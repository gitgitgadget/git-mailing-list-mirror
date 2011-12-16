From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: [BUG] attribute "eol" with "crlf"
Date: Fri, 16 Dec 2011 23:36:07 +0100
Message-ID: <CAN0XMOKts7UR6eSYWA9-xj-YCpprvhbqwfdbq4U6Hfrn0nUONQ@mail.gmail.com>
References: <CAN0XMO+OOdTJ+aNMSc2G3RVc7Wfypr4+7dU3US9GVAmMiSJ7cg@mail.gmail.com>
	<vpqr504wf70.fsf@bauges.imag.fr>
	<7vmxasgqlm.fsf@alter.siamese.dyndns.org>
	<CAN0XMOL674Hw_LctTC+8NNqA84Of6dMjdKT0SU+DWMG7EYShYQ@mail.gmail.com>
	<7vehw4go0v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 23:36:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbgNx-0001hE-NA
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 23:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946Ab1LPWgK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Dec 2011 17:36:10 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60074 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932694Ab1LPWgI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2011 17:36:08 -0500
Received: by yhr47 with SMTP id 47so3247807yhr.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 14:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=SyI4GpkKFrh3YPMn0x8m+HWVeyFGjX79SDDUwjt6X6I=;
        b=kWzi85KPOummHXaQs1EivEUpMbkSA0uHmDj2TPe+pNo6mY9orAO8HS4nt/KfhPfcZw
         7ZuA0n4pQkHQgMKN5igDeRmWS96jQTBHDMGiNJWK3Nw8EAlWtiSPewTcn5flo0iO6qnK
         zheTG7nv8iS8AX98Rc2Azq39B/7VaRdPDHxCQ=
Received: by 10.236.123.108 with SMTP id u72mr14970452yhh.45.1324074967344;
 Fri, 16 Dec 2011 14:36:07 -0800 (PST)
Received: by 10.147.22.19 with HTTP; Fri, 16 Dec 2011 14:36:07 -0800 (PST)
In-Reply-To: <7vehw4go0v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187328>

Basicly I want to force the line endings of the files on my
project. :/

2011/12/16 Junio C Hamano <gitster@pobox.com>:
> Ralf Thielow <ralf.thielow@googlemail.com> writes:
>
>> So i have to commit ".gitattributes" and everything is fine for me a=
fter!?
>
> No. =C2=A0Sorry if I was unclear, but I do not see which part was unc=
lear in
> what I wrote, so...
>
>>> The sequence adds "test\r\n" file without .gitattributes to have th=
e
>>> repository record that exact byte sequence for the file. But then l=
ater
>>> goes around and says "This file wants to express the end of line wi=
th CRLF
>>> on the filesystem, so please replace LF in the repository represent=
ation
>>> to CRLF when checking out, and replace CRLF in the working tree to =
LF when
>>> checking in".
>>>
>>> So it is not surprising that "\r\n" coming from the repository is r=
eplaced
>>> to "\r\r\n" when checked out. As far as the repository data is conc=
erned,
>>> that line has a funny byte with value "\r" at the end, immediately =
before
>>> the line terminator "\n".
>>>
>>> What you said is _technically_ correct in that sense.
>>>
>>> However, I think the CRLF filter used to have a hack to strip "\r" =
if the
>>> repository data records "\r" at the end of line. This was intended =
to help
>>> people who checked in such a broken text file (if it is a text file=
, then
>>> raw ascii CR does not have a place in it in the repository represen=
tation)
>>> and it was a useful hack to help people recover from such mistakes =
to
>>> start the project from DOS-only world (with CRLF in the repository =
data)
>>> and migrate to cross platform world (with LF in the repository data=
, CRLF
>>> in the DOS working tree). =C2=A0I suspect that the streaming filter=
 conversion
>>> may not have the same hack in it.
