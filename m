From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 3/3] push: add separate 'downstream' branch
Date: Thu, 16 May 2013 05:22:52 -0500
Message-ID: <CAMP44s1eB+bvg7vnG5S3SBACHTrkpCqJNX-Q2tzEVdvzFWvkcA@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
	<1368675828-27418-4-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0nTS6Vh7GfnrLWAK5VeevQyGN5N7xT43c+uqBQ5oM5tww@mail.gmail.com>
	<CAMP44s3fPsGW_9aBbcsu8cJAagz8JEWV2HM=XRH3Rw4=SXdL7Q@mail.gmail.com>
	<CALkWK0nOywB5BtHnKZQ_+wsJNp82zk7-YJw_S15quqH+iU=jWg@mail.gmail.com>
	<CAMP44s2vsD2uwFoL5_79m05gtqyKLN9wHX8Yrhtn0kT4LVULxQ@mail.gmail.com>
	<CALkWK0m+_AbCd305dU5p5bxwuPPCBKJH7a3e6rHgxxnySMz0pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 12:23:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcvKv-0007n9-VW
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 12:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625Ab3EPKW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 06:22:58 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:32925 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab3EPKW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 06:22:57 -0400
Received: by mail-lb0-f178.google.com with SMTP id w10so1445069lbi.37
        for <git@vger.kernel.org>; Thu, 16 May 2013 03:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ZSfhMZ+MGH2lifXIi1pvfHe8mN2ouvzBkVI2OAM5hWA=;
        b=N8Z2GXVQad5lxGqufvw/HWekICBSqh+1+feDDGv/FQW9ekrdlI8cEbnLuQ/Sx8Tc5D
         s71R04q4JQIPINUWE871DoMR9dravwOL1LlN3NoMcJoSjFdardFt6K1xYhsj5yNY/fyU
         /cKPgJ4+8hvb7NwQDKYzFX8Iv8GXTvOPt1jWAw+aRpw53g377Gqb7b/ac7SyTR55RLnU
         T7oOBgOypfBnUgdn09XfLzZXzHF4GRjY6ly5lU1xsq2L5rkrc1xX4HrWqIt/Fj58MyJ0
         N2Q+aElipPJFsnfh/a/iYaNccdcTCvNePVrjEs0oVNyJiAnMp80194khoweObYNaiWQp
         APxA==
X-Received: by 10.112.166.101 with SMTP id zf5mr19363193lbb.59.1368699772703;
 Thu, 16 May 2013 03:22:52 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 03:22:52 -0700 (PDT)
In-Reply-To: <CALkWK0m+_AbCd305dU5p5bxwuPPCBKJH7a3e6rHgxxnySMz0pQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224549>

On Thu, May 16, 2013 at 5:06 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>>> [remote "origin"]
>>>     push = refs/heads/master:refs/heads/fc/master
>>>
>>> [remote "."]
>>>     push = refs/heads/fc/old-remote/hg:refs/heads/fc/remote/hg
>
> Major thinko.  It should be:
>
> [remote "github"]
>     push = refs/heads/master:refs/heads/fc/master
>     push = refs/heads/fc/old-remote/hg:refs/heads/fc/remote/hg

Would I be able to do:

% git branch --set-upstream-to origin/master --set-downstream-to
github/fc/master

?

Would I see these branches when I do 'git branch -vv'?
Would I be able to do 'git push next@{downstream}'?

>>> Advantage being you can do:
>>>
>>> [remote "origin"]
>>>     push = refs/heads/*:refs/for/*
>>>
>>> While you can't with branch.<name>.push.
>>
>> But I can do 'git push origin "refs/head/*:refs/heads/for/*"', not
>> that I've ever had the need to do something like that, so I don't
>> care.
>
> Isn't the entire point of this exercise getting git to dwim without
> being explicit?
>
> I don't care about it personally either, which is why I haven't
> written a patch yet.  However, there are users of Gerrit who would
> appreciate this feature: in the remote.pushdefault thread, some people
> requested this feature.

That is orthogonal to 'branch.A.push' the same way 'remote.B.fetch' is
orthogonal to 'branch.A.merge'.

-- 
Felipe Contreras
