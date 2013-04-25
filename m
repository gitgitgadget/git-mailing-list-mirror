From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/9] remote-hg: remove extra check
Date: Thu, 25 Apr 2013 14:22:02 -0500
Message-ID: <CAMP44s3oNZiNTotaWqf3=FtDh+Jzc3i2-Ox5=E8pKLYqWY=X-A@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-3-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mrMkLBRSKk3GwjYvh+tCtXU=efeuaZC4nKGTZosVyHrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 21:22:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVRkB-00083T-3d
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 21:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758272Ab3DYTWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 15:22:05 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:39140 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756519Ab3DYTWE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 15:22:04 -0400
Received: by mail-la0-f52.google.com with SMTP id fd20so2941915lab.11
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 12:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=7ZhD2J3hD5kpV5LdGAO6WFaxbspk1wZpd5qvCKmTRzU=;
        b=tuwDWICmn/yriSYhPN5CDwAJp/r7An7kOezlMDKal/RKW2oz8A+wYH9LOvEY9C/VjF
         y2mBHC3KOhwdHobXSCjrtC2Yx5yNWr6O8Z0gBvXkWqb5jtgL+c/Az/vEtXfytlxX9aDu
         ZiGl+j1YqRgjaszTlaK6UMjOf4pTnvE7VzD5Api+nYXqYQRkvgbJccIFB+6sa7b/QOkT
         khOk5fihtDOlr4/eDgJ5TrBBSwE5Qb/y0Jwj52WnAf3HqyYVivAEGMmC34XcM6Cf1c1Q
         dAcPHfKUpL2DR313bWc+SIp9kThjh1m2m9yi5QAURU6vmsUnDQKqDUoreTQ/v2usa3Gt
         vHaA==
X-Received: by 10.112.146.133 with SMTP id tc5mr20374031lbb.88.1366917722364;
 Thu, 25 Apr 2013 12:22:02 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 25 Apr 2013 12:22:02 -0700 (PDT)
In-Reply-To: <CALkWK0mrMkLBRSKk3GwjYvh+tCtXU=efeuaZC4nKGTZosVyHrQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222417>

On Thu, Apr 25, 2013 at 1:23 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
>> index 5481331..0b7c81f 100755
>> --- a/contrib/remote-helpers/git-remote-hg
>> +++ b/contrib/remote-helpers/git-remote-hg
>> @@ -332,10 +332,6 @@ def export_ref(repo, name, kind, head):
>>      ename = '%s/%s' % (kind, name)
>>      tip = marks.get_tip(ename)
>>
>> -    # mercurial takes too much time checking this
>> -    if tip and tip == head.rev():
>> -        # nothing to do
>> -        return
>>      revs = xrange(tip, head.rev() + 1)
>
> I'm surprised these four lines were even there in a previous revision.
>  Again, you changed the meaning: if xrange() returns an empty range,
> you must return, by extension.

I'm not going to go back in history, but we were not always using
xrange, but the mercurial API helper, which was dead slow, and in the
end did basically an xrange().

-- 
Felipe Contreras
