From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: [BUG] attribute "eol" with "crlf"
Date: Fri, 16 Dec 2011 23:05:27 +0100
Message-ID: <CAN0XMOL674Hw_LctTC+8NNqA84Of6dMjdKT0SU+DWMG7EYShYQ@mail.gmail.com>
References: <CAN0XMO+OOdTJ+aNMSc2G3RVc7Wfypr4+7dU3US9GVAmMiSJ7cg@mail.gmail.com>
	<vpqr504wf70.fsf@bauges.imag.fr>
	<7vmxasgqlm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 23:05:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbfuJ-0006OF-V2
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 23:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866Ab1LPWFa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Dec 2011 17:05:30 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63203 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964826Ab1LPWF1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2011 17:05:27 -0500
Received: by ghbz12 with SMTP id z12so2689496ghb.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 14:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=zOwKkREm6ZaELaZhfnyKxFwnlgbKN7TpTmoFRTJ0PoU=;
        b=sWCmLLYYNA9HJKNAAOgSjPvxm1I/wePq8y7W2c3B5QmVxkwWb6EpHeC71YgeJ+wHiH
         mZ6pyMTzU5iRY6XUDJGSnmcQnLQXc+0jqPjUsTHo8FMN6ruDO91/danZ/9/R1c2i01bP
         F6DYKf35xRzpAw35Akr+Mcl+9mLdO9O9s92c8=
Received: by 10.101.146.33 with SMTP id y33mr2520898ann.41.1324073127208; Fri,
 16 Dec 2011 14:05:27 -0800 (PST)
Received: by 10.147.22.19 with HTTP; Fri, 16 Dec 2011 14:05:27 -0800 (PST)
In-Reply-To: <7vmxasgqlm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187324>

So i have to commit ".gitattributes" and everything is fine for me afte=
r!?

> The sequence adds "test\r\n" file without .gitattributes to have the
> repository record that exact byte sequence for the file. But then lat=
er
> goes around and says "This file wants to express the end of line with=
 CRLF
> on the filesystem, so please replace LF in the repository representat=
ion
> to CRLF when checking out, and replace CRLF in the working tree to LF=
 when
> checking in".
>
> So it is not surprising that "\r\n" coming from the repository is rep=
laced
> to "\r\r\n" when checked out. As far as the repository data is concer=
ned,
> that line has a funny byte with value "\r" at the end, immediately be=
fore
> the line terminator "\n".
>
> What you said is _technically_ correct in that sense.
>
> However, I think the CRLF filter used to have a hack to strip "\r" if=
 the
> repository data records "\r" at the end of line. This was intended to=
 help
> people who checked in such a broken text file (if it is a text file, =
then
> raw ascii CR does not have a place in it in the repository representa=
tion)
> and it was a useful hack to help people recover from such mistakes to
> start the project from DOS-only world (with CRLF in the repository da=
ta)
> and migrate to cross platform world (with LF in the repository data, =
CRLF
> in the DOS working tree). =C2=A0I suspect that the streaming filter c=
onversion
> may not have the same hack in it.
