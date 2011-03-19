From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] repack: find -> /usr/bin/find, as for cygwin
Date: Sat, 19 Mar 2011 23:15:30 +0700
Message-ID: <AANLkTinncw6GSLf3QvxjqKoaqesH9SWxrn5TENnHDj4Y@mail.gmail.com>
References: <AANLkTimHof_MNSGbU2KGX=7Q3MQpjkzXK+xyGGVjbngR@mail.gmail.com>
 <AANLkTimPbz2s=Maafhqg-7wOk_TT4fFSh7AQ-3rWY0A3@mail.gmail.com>
 <4D84D0C0.7080808@lsrfire.ath.cx> <20110319160754.GA5871@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?cnllbnVzIOKXhw==?= <ryenus@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Mar 19 17:16:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0yoz-0003zk-6R
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 17:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416Ab1CSQQB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 12:16:01 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39367 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473Ab1CSQQA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 12:16:00 -0400
Received: by gyf1 with SMTP id 1so1926410gyf.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=r57LOqGVQSPia4pcGG0G3rlUXBlHnuQ3/5to06xwOdg=;
        b=Z34+5uhb/xkVBUnH32nLtyUneZ0cpLSMgtqevGYawH1iJnCaqb/3ylQLlLa7H4VXi4
         tz/+sUua2PE8hbYQOZt+uwQ4zuz1n17r700gRn4EN8yqJ7CPwHmRx5uYb80nhxCMI74f
         OcETMihxk/zETt5PiB9VPG9tbeYVwBRlnto94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=JHr4ZJsu6k8k91i3bHtc2sLVDyxA6aClo/NOPd5UtNTo/CgS5EAT1Wh8EPwP4e3StR
         ucmo2IS4yXLoAG2008aP3ZBtIXzivwChDXb/q2h19o6g2DQhC0vNrCu96whXF2DDx+Fw
         lF+Uj6pUQeOGVXwXwKLr3a/cgcI2zox/VEQqE=
Received: by 10.151.95.16 with SMTP id x16mr2451741ybl.46.1300551360203; Sat,
 19 Mar 2011 09:16:00 -0700 (PDT)
Received: by 10.150.220.14 with HTTP; Sat, 19 Mar 2011 09:15:30 -0700 (PDT)
In-Reply-To: <20110319160754.GA5871@do>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169445>

On Sat, Mar 19, 2011 at 11:07 PM, Nguyen Thai Ngoc Duy
<pclouds@gmail.com> wrote:
> I looked at test-lib.sh but forgot git-sh-setup.sh, which does
> aliasing for find in MINGW build. With your patch, the last use of
> find is gone. So we might as well do this
>
> - =C2=A0 =C2=A0 =C2=A0 find () {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /usr/bin/find "$@"
> - =C2=A0 =C2=A0 =C2=A0 }

On second thought, no. We probably need to do an unconditional alias

find() {
    die "find is not supported"
}

to make sure no one will ever use it again.
--=20
Duy
