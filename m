From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Re: Revert a single commit in a single file
Date: Fri, 25 Feb 2011 09:48:12 -0300
Message-ID: <AANLkTimqszvGjVeJHKLPWicDugeOuqbgO1+wy5BO-AE0@mail.gmail.com>
References: <AANLkTikpdGfAAUMu_7DfA-GRUv7gKn5Yc9RnJwo2iKoM@mail.gmail.com>
 <AANLkTimLRc4LybUvmD2ZCKfQqEP+vr+2aBnb4n3B+Mb2@mail.gmail.com> <4D67A293.2050306@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 25 13:48:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psx66-0008HY-7K
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 13:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754387Ab1BYMse convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 07:48:34 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42143 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665Ab1BYMsd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 07:48:33 -0500
Received: by iwn34 with SMTP id 34so1054873iwn.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 04:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=tuccc4JNQEhzBhBKZOMPfCHpKbjZDSbPiGzCDkTWgOY=;
        b=OYTD/UAnxJCp5JmT/dejFwKsZHL0d0vqauywgd5ZDPryDioaLs5ogEpBrZdOK2s1jC
         zNHiA+/KHt2lepvFtb3tlzBu66vxxDwKlMpfD88+rq7xF+/V/4bVaOwHYmhr+gAHhkjn
         8FsUoxmh4Vcyc3Je6cioEdQmGw2+Rg4MqKUN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=W/W1vQuL4y0DzpZeS/FSnKisIhyVtt0X2sJdw3/Jb9K0yX6aE/GDMbL0x6h/s+Z06D
         MV2NoUDoChyj9XpYcV45DX2oNrz0Z4cSbpH8SSu/7kW5qKRc22FUZttQbz5SOywvFEdY
         bw/73mSqSjGmGAu1zkwKdkYSr809KIVB3QI44=
Received: by 10.42.197.138 with SMTP id ek10mr705897icb.58.1298638112072; Fri,
 25 Feb 2011 04:48:32 -0800 (PST)
Received: by 10.42.53.194 with HTTP; Fri, 25 Feb 2011 04:48:12 -0800 (PST)
In-Reply-To: <4D67A293.2050306@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167903>

The most sensible way to do this seems to be:

 git checkout HEAD~2 file.c

And your index will show file.c modified, as it will have it's content
reverted 2 commits.

The behavior of 'revert' is to revert commits, not files, so it's not
expected to work if you say 'git revert <commit> <path>'

Cheers,
Dario

On Fri, Feb 25, 2011 at 9:37 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> =C6var Arnfj=F6r=F0 Bjarmason venit, vidit, dixit 25.02.2011 12:17:
>> On Fri, Feb 25, 2011 at 11:34, Thomas Ferris Nicolaisen
>> <tfnico@gmail.com> wrote:
>>> I tried asking the same question on the "newbie" list some time ago=
:
>>>
>>> http://groups.google.com/group/git-users/browse_thread/thread/d562b=
4eeac016711
>>>
>>> Basically, when I go
>>>> git revert <commit> <path>
>>>
>>> .. my expectation was that a new commit would be made reverting the
>>> changes from the old commit, but only for specified path/file.
>>>
>>> Maybe it's a bit of a corner-case, but still would be nice to have
>>> once in a while. What do you think?
>>
>> It would. What you can do in the meantime is:
>>
>> =A0 =A0 git revert <commit>
>
> =C6var meant to write "git revert --no-commit <commit>" here. (Or the=
re
> wouldn't be anything to reset and add.)
>
>> =A0 =A0 git reset
>> =A0 =A0 git add <path>
>> =A0 =A0 git commit ...
>> =A0 =A0 git reset --hard # making sure you didn't have uncommited ch=
anges earlier
>
> If you want to revert changes to all files but a few, you can do it t=
he
> other way round (revert, checkout HEAD^ -- <path>, commit --amend).
>
> Cheers,
> Michael
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
