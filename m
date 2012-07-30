From: Christoph Miebach <christoph.miebach@web.de>
Subject: Re: bug (?) in send email
Date: Mon, 30 Jul 2012 12:38:00 +0200
Message-ID: <50166408.8000008@web.de>
References: <50145A90.1090904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 12:43:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvnRW-0000jV-MW
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 12:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246Ab2G3KnL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 06:43:11 -0400
Received: from mout.web.de ([212.227.17.11]:57664 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753030Ab2G3KnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 06:43:09 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jul 2012 06:43:09 EDT
Received: from [192.168.168.63] ([89.0.136.194]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MaajJ-1TFoHa1y9p-00JvyJ for <git@vger.kernel.org>;
 Mon, 30 Jul 2012 12:38:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <50145A90.1090904@web.de>
X-Provags-ID: V02:K0:TgkmT7Hc3MV4JQzT9QKDQ+dkngp9kZ7PMv0v9Zlqz+J
 6edd+wHketwj8OejkDQrdOf641PQlPKBWlFX1AvIfr92s3BoOi
 QSnkoHUsJPnwNyvNHMdGeBEcgJ1r33J1Gyo1z/+PpsFzf5l5rv
 k3BX6LN9m7ZkEeDkzcIkSgTR4TuEzGPz0A1+moGAqazV6GYLlp
 0g74156600O9eUwlHy21CW+WXqzlKcJM3Dzhjv0g5I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202534>

Hello!

Removing this line
s/_/ /g;
here
https://github.com/git/git/blob/master/git-send-email.perl#L867

Solves this problem for me. But I really don't have any clue, what kind=
=20
of side effects this modification on "sub unquote_rfc2047" might have.

Regards

Christoph

On 28.07.2012 23:33, Christoph Miebach wrote:
> Hello!
>
> send-email (tested versions 1.7.9.2 and 1.7.10.4) breaks email addres=
ses.
>
> Steps to reproduce:
>
>
> Modify file.
>
> git commit --author=3D"Micha=C5=82 Tz <name_1911@some.com>" modified.=
file -m
> "Test"
>
> git format-patch -o patches origin
>
> Now, the patch seems to have the address right, see [1]
>
> git send-email  --to MYOWN.ADDRESS@mail.com --suppress-cc=3Dauthor
> patches/0001-Test.patch
>
> But checking my inbox now shows an email starting with:
> From: Micha=C5=82 Tz <name 1911@some.com>
>
> So the address is splitted at the underscore.
>
> Furthermore, if I don't use --suppress-cc=3Dauthor, the CC field show=
s the
> right address.
>
> Regards
>
> Christoph
>
> [1]
> less patches/0001-Test.patch
> From: =3D?UTF-8?q?Micha=3DC5=3D82=3D20Tz?=3D <name_1911@some.com>
>
> git show
> Author: Micha=C5=82 Tz <name_1911@some.com>
