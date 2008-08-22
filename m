From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] Support "core.excludesfile = ~/.gitignore"
Date: Fri, 22 Aug 2008 19:56:22 +0200
Message-ID: <36ca99e90808221056i6d79b122occ4ae1e21da6a221@mail.gmail.com>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu>
	 <loom.20080822T165656-932@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric Raible" <raible@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 19:57:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWatB-0001g3-2j
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 19:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbYHVR42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 13:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbYHVR42
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 13:56:28 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:2635 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbYHVR41 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 13:56:27 -0400
Received: by wx-out-0506.google.com with SMTP id h29so603023wxd.4
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 10:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8otoTCno1pqRJySqQmWP8ieOU0Ee2F/jWTWrNjmWy+w=;
        b=OaWSoqSvOCHyxlR1AQA8b24RJoGfcZyX+MJajvLqBCWZwh2r6LRRBByiRaJgiM/WLZ
         SeCv8UlPwWMS3FGqN7VXFkXVMXyzs/1luTaD0W36wkjusHxpc+1jqn9PsrM/ndo2e522
         ZQwgTtii+/iqCfqd4zF78pbDzoy9CR+yEhnCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=uK9p6yvRKn3t13QSWjIDo4WDxBjfS5JXlPdfX2bmKVxOq2TvYCMBRAzXIwJWGZng2r
         QWamuqWOk0Qq9Y/cEIET9AZWGSq6qpEKkctImqRqk2Yn4oEmK/H9xq+GJ5x2l6AabpU9
         +yh3YZw0eq6o78T3VUR+I+1Wvfv1BvSuJwGKI=
Received: by 10.70.48.7 with SMTP id v7mr1654497wxv.61.1219427783048;
        Fri, 22 Aug 2008 10:56:23 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Fri, 22 Aug 2008 10:56:22 -0700 (PDT)
In-Reply-To: <loom.20080822T165656-932@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93336>

On Fri, Aug 22, 2008 at 18:58, Eric Raible <raible@gmail.com> wrote:
> Karl Chen <quarl <at> cs.berkeley.edu> writes:
>
>> +static char const *git_config_subst_userdir(char const *value) {
>> +     if (value[0] == '~' && value[1] == '/') {
>
> Might you want to check that strlen(value) is at least 2?
No.

    swtich (strlen(value)) {
    case 0:
        /* value[0] == '\0' => value[0] != '~'
           value[1] will never be dereferenced, because of lazy && */
    case 1:
       /* value[0] != '\0'
          if (value[0] == '~')
              value[1] == '\0' => value[1] != '/' */
    default:
       /* ... */
    }

So no invalid memory dereferences.

Regards
Bert
>
> - Eric
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
