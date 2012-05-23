From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Wed, 23 May 2012 22:50:05 +0200
Message-ID: <CAMP44s3uW75O_jt2F7POxTAhX+qPyRSjOX9-DuEkg7a7WtnLsA@mail.gmail.com>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
	<1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
	<4FBC0019.6030702@in.waw.pl>
	<7v4nr72bim.fsf@alter.siamese.dyndns.org>
	<CAMP44s0aKi+8WHPXYLQ+iSMkj9iV88JGTabrpBRNBWb7upAMiQ@mail.gmail.com>
	<CAOnadRF8XyZKi+d=y1fFy2Xvs-3ETVyCbJBj83mK3Q8yuK7oQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	=?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>,
	Dan McGee <dan@archlinux.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Wed May 23 22:50:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXIVa-0006d7-M8
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 22:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759640Ab2EWUuI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 16:50:08 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36804 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389Ab2EWUuG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 May 2012 16:50:06 -0400
Received: by lbbgm6 with SMTP id gm6so5391850lbb.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 13:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=tXFJWxabjUB0D/zQ/MQVoS9gPxXGzhU6nV5iO1g5yaU=;
        b=IomznjLlPrA7xGx/PZnCgts2g4r5V3wdT+wxRFMIQeEc6PaHDg+uaFt2x8DIFLvwy9
         RJPvA4OJ16TtsmtjEnMGnMYH+EdYumJbPF/6hz7SR17NTMPVkfJwbVl3vwY3LLVkR1CY
         2EuVzmnlK/6UabzriCEKomCVkaFUe1UC2woSOBLY9FG97HBBe9yFA5btarpW+gHol7PB
         TaoHPr6g1+V+2ogtPOwS91tqzBr9yx7C6cZvyhLsT6+CXuQxGbQeFkwMLaVbf/25aVKw
         huda0m6gvKfqb8eHFdqBfaENFP6bOKnoEzyqUiqe16iBKORve+YartXtNp50hLwihCpr
         gwGg==
Received: by 10.112.36.130 with SMTP id q2mr4848740lbj.44.1337806205271; Wed,
 23 May 2012 13:50:05 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Wed, 23 May 2012 13:50:05 -0700 (PDT)
In-Reply-To: <CAOnadRF8XyZKi+d=y1fFy2Xvs-3ETVyCbJBj83mK3Q8yuK7oQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198322>

On Wed, May 23, 2012 at 7:03 PM, Ted Pavlic <ted@tedpavlic.com> wrote:
>>> I am not sure if that is worth it. =C2=A0These two share/duplicate =
some shell
>>> functions and we may end up refactoring them (a way to do so may be=
 to
>>> dot-source git-prompt from git-completion and drop duplicated defin=
itions
>>> from the latter), for example.
>>
>> And how do you propose to update the install documentation?
>>
>> 1) Copy the file (e.g. ~/.git-completion.sh)
>> 2) Copy the other file (.e.g ~/.git-prompt.sh)
>> 3) Edit the original file (~/.git-completion.sh), modify the 'source=
'
>> command to use the other file (~/.git-prompt.sh)
>
> The third step doesn't seem necessary if .git-completion sources
> git-prompt when it's available (and otherwise ignores it gracefully).
> Then anyone who cares about the prompt just makes sure that git-promp=
t
> is available.

And then anything that uses __gitdir() would fail.

And how would you figure if it's available, and where it is available?
What if git-completion.bash is distributed on
/usr/share/bash-completion/completions/git? Where would you put
git-prompt.sh so it can be found *and* you would not require
modifications? And what if I want to put the latest version on
~/.git-completion.sh (as the script actually suggests).

There's no way git-prompt.sh can be sourced without modifications to
the script, unless you expect it would always be named
'.git-prompt.sh' and would be on the same directory, which many
distributions would frown upon.

--=20
=46elipe Contreras
