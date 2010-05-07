From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 22:11:46 +0200
Message-ID: <3FDD45D5-102F-4D78-B459-630C0791BE9B@gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> <cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, torvalds@linux-foundation.org,
	prohaska@zib.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 07 22:12:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATtv-00009r-Eb
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 22:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199Ab0EGULv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 16:11:51 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:51650 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758157Ab0EGULu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 16:11:50 -0400
Received: by ewy20 with SMTP id 20so391058ewy.1
        for <git@vger.kernel.org>; Fri, 07 May 2010 13:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=JPABk3290YrDCVsuSFE+jrLQtS3n8IOLYOLP2K1y6gI=;
        b=OhfY7IUS5ITved7Ig3n8xaz1yFCybzxG7N0CTbtpSo6Y5+YaJlUbl0efChNyu92CTY
         +0Pyfkfx0LQh0Ee5ww9zwp3meOcYm8iZXWLgf549nlEJ8Mux+Mqry6wXuYikjxHbm613
         PYliuITEEQGGYgKXEQzO3XYDdlnGAfDDYJIX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=Xn4ShZrKk+KJEOK7XwyBgoZBLWRes9D9Irozkk2zPJToCch0ZjbWHzkt0PJdG4Oa61
         6Wvy42Cheqxp/yibiA0zYuuCi+S0xY2vd0cOE5jBMd+PFiz9WYuliYjCccs2+PI9YQ8r
         piDmDwdQIX9BbmH+f3No3CjnRo59MjFhK83mw=
Received: by 10.213.73.65 with SMTP id p1mr274642ebj.65.1273263109279;
        Fri, 07 May 2010 13:11:49 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 13sm1298017ewy.5.2010.05.07.13.11.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 13:11:49 -0700 (PDT)
In-Reply-To: <7v4oijhdsi.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146581>

On 7. mai 2010, at 18.33, Junio C Hamano wrote:

> Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:
> 
>> - An attribute called "auto-eol" is set in the repository to turn on
>>  normalization of line endings.  Since attributes are content, the
>>  setting is copied when the repository is cloned and can be changed in
>>  an existing repository (with a few caveats).  Setting this attribute
>>  is equivalent to setting "core.autocrlf" to "input" or "true".
> 
> In what way is this attribute different from existing "crlf" attribute?

Avery and Linus have covered this quite well, but I think I can use "crlf" instead of inventing a new attribute.  New patch series to come.

> It feels as if this series is fixing shortcomings of the combination of
> core.autocrlf configuration and crlf attribute while trying very hard to
> keep their shortcomings when the user doesn't say so.  What is the
> downside of making the existing "core.autocrlf" + "crlf" combination do
> what your patch wanted to do without retaining this "keep the existing
> shortcomings for backward compatibility"?

I think keeping the existing shortcomings is partly necessary because I don't want to break any existing repositories by changing the meaning of "core.autocrlf=input" and "core.autocrlf=true".

I also like "core.eolStyle" because I want a config setting that explicitly says "crlf" or "lf" rather than forcing the user to remember what "true" and "input" mean.  The new series will keep core.eolStyle.

I would like to have a boolean "core.autocrlf" that uses "core.eolStyle" instead of implying anything about line endings in the working directory, but I'm not sure if that is possible without breaking anybody's setup.

>> 1. Setting core.autocrlf in your global or system configuration is a
>> pain
> 
> This is a wrong thing to do to begin with, and not worth discussing.  You
> know and your readers know that line ending convention in the repository
> data (i.e. blobs) is under project control while line ending convention in
> the working tree is end user preference.

I think it's worth mentioning because git doesn't currently enforce line ending normalization on a per-project basis, which is what I'm trying to rectify.  Also, the default setting in msysgit is "core.autocrlf=true", but I guess you disagree with that default :)

>> 2. Setting core.autocrlf in an individual repository would be okay
>> except that naive users will do it after they have already cloned:
>> unless core.autocrlf is set globally, the clone will have the wrong line
>> endings, and the user needs to know how to refresh it manually (rm -rf *
>> && git checkout -f).
> 
> This may be a worthy goal.  But if a "auto-eol" attribute "fixes" this,
> perhaps "crlf" attribute can be taught to fix it the same way, no?

Yes.  And it shall!
-- 
Eyvind
