From: Edward Marshall <marshallx7a@gmail.com>
Subject: Re: Windows git bash - child processes see system PATH environment
 variable instead of user...
Date: Fri, 19 Feb 2016 11:15:18 +0000
Message-ID: <CAN2vHUHhqVn8uXaUTdeU5mKuRLQ1084wJu27k4nMJgywOjdOdA@mail.gmail.com>
References: <CAN2vHUFYqKDDEJpGtxJ9aD+8abe-krnHBy7cm1tMm0+bh5ykBQ@mail.gmail.com>
	<alpine.DEB.1.00.1602191154190.20796@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 19 12:15:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWj1x-0006Ud-DM
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 12:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1427620AbcBSLPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 06:15:21 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38053 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425751AbcBSLPU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 06:15:20 -0500
Received: by mail-wm0-f42.google.com with SMTP id a4so65877248wme.1
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 03:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Md5fkYX/jK4ysKG1KQFP6PZhNEz/lSq9AIRfmirDbCw=;
        b=qUR+Re/IKqAKBVVyK1ykZsPTbg5UojcY9oexSoscIYbn3oN30GL9bnO2nwQ15tyHz/
         NUEyJ2w204899osqDHyaIetkLUEswzj55yDSokCrEfJL0grJ6nnBi7kXpIySWJzEJQ/n
         Ou4Ox9vIJY7e0NvwwzYaXn91pGXOQc9UVXgZllgDdcqXyxZol9lnCOxmut/whhmBHU5E
         FoMrybbIDAFS36DtLPqpaKp/SqiE+R0PmX92btYhwSWx0RLYsUB6YEZIH+uHgC+HGNEL
         jlKI4x8jEZ8aXY8UEB1ONjawF20oT0J61Vy8avLrU6xT1qdp9m+UNTxipohiwg9nheh5
         GZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Md5fkYX/jK4ysKG1KQFP6PZhNEz/lSq9AIRfmirDbCw=;
        b=VCYJACWtFPm69cHSkgOHSUat0ELPsS8JCdg9uATxr8RmfKKnULcCSo2FGopA6Wmwhi
         Xlk1DN0w8ZqhXATPFGLDMEH76wNF5w4abd2SZ6tdMGkQ2CQW5eNTR/WOITsD1NXWxfUG
         59tSanekMBauYyhDLLd7aNZGGsg1hd1ZkKpXZ/Jm2RI1oh/w6ycsr6mmLUyiZQIBBmW0
         htMdzWCnNsm0ZYVdA23C3PUwR1bbbpEEEsJa0UktiDs0WP9nkaNFpZdXWxaIaMCtXvjZ
         8IR4RIvQO8Jsbo5MIzm0ZUTBBqlRkaFYcvdR8iAykbAtqetGCPHwTXB+6gG99d5LI2lb
         PTbg==
X-Gm-Message-State: AG10YOTPWLNd3WtCNaOebvLBOIHrrnIMwYqM34GxePGJclSu9XrkPwWy+ya3csRLjceJsZcQQ4sK7e6d9i2lAg==
X-Received: by 10.194.90.137 with SMTP id bw9mr12474273wjb.120.1455880518198;
 Fri, 19 Feb 2016 03:15:18 -0800 (PST)
Received: by 10.194.102.193 with HTTP; Fri, 19 Feb 2016 03:15:18 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1602191154190.20796@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286683>

Hey, thanks for getting back to me. I subseuqently found the
git-for-windows issues tracker on github so have posted an updated
version of this there - not sure where is the best place for issues.

I have also found that the cause was having
%VPROJECT%..\bin
inside my user PATH
but no VPROJECT environment variable.
Removing the path or adding the missing env var fixes the problem.
This suggests that something is failing to concatenate user PATH to
system PATH when it can't expand the non-existent environment
variable.

fwiw, I don't have a .profile file either.

Hopefully you can replicate the problem with the above info, but
please let me know if you still want me to run anything or if there is
anything else I can do to help.

Kind regards,

Edward Marshall


On 19 February 2016 at 11:08, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Edward,
>
> On Wed, 17 Feb 2016, Edward Marshall wrote:
>
>> Edward@Edward-PC MINGW64 /f/Work
>> $ echo $PATH
>> ...(USER PATH)...
>
> I presume this is Git for Windows 2.7.1(2), installed via the default
> installer?
>
> And I also assume that you run this in Git Bash?
>
> Can you test whether this also happens in the PortableGit from
> https://github.com/git-for-windows/git/releases/latest? (These are
> self-extracting .7z archives, just install them somewhere else than your
> current installation, it won't touch your Start Menu or desktop icons.)
>
> The Git Bash is available in the portable installation as git-bash.exe in
> the top-leve directory.
>
>> Edward@Edward-PC MINGW64 /f/Work
>> $ cmd
>> Microsoft Windows [Version 6.1.7601]
>> Copyright (c) 2009 Microsoft Corporation. All rights reserved.
>>
>> F:\Work>echo %PATH%
>> echo %PATH%
>> ...(SYSTEM PATH)...
>>
>> The same is true of any child process (e.g. node.js) - they all see
>> SYSTEM PATH now instead of USER PATH.
>
> Are you sure that it is "instead of"? AFAICT both Git CMD and Git Bash
> should have the full PATH, i.e. both system and user PATH concatenated.
>
>> Running bash -l from a cmd window, has the problem.
>
> Now, this is interesting. Maybe something funky does happen in some
> strange place in the Bash profile.
>
> If you can reproduce this with the portable Git, it would be good to
> insert the line "set -x" at the top of %PORTABLEGIT%\etc\profile
> (that is the correct file name IIRC, it could also be bash.bash_profile,
> but I think the latter is included by the former). Then start bash -l
> again, and see whether you can find the place where it sets the PATH.
>
> To be certain, I would also recommend outputting the PATH with which Bash
> starts, either by inserting a line "echo $PATH" at the top of the profile
> file, or by starting bash without -l option.
>
>> I have no .bashrc or .bash_profile files on either system (no idea
>> what these are for but a colleague was trying to help diagnose the
>> problem - they ultimately came up empty).
>
> Could be a .profile, too, maybe.
>
>> Unfortunately I don't know what version of git I had before, and older
>> versions aren't offered for download so I can't trial and error.
>
> Older versions are still available (we did not remove any) from
> https://github.com/git-for-windows/git/releases (and if you look for the
> 1.x series that was using a completely different Bash/MSYS:
> https://github.com/msysgit/msysgit/releases).
>
> Ciao,
> Johannes
