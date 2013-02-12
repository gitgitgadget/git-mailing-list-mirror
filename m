From: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCHv4 4/6] Git.pm: allow pipes to be closed prior to calling command_close_bidi_pipe
Date: Tue, 12 Feb 2013 23:50:27 +0100
Organization: http://mina86.com/
Message-ID: <xa1tehgl9mfg.fsf@mina86.com>
References: <cover.1360677646.git.mina86@mina86.com> <3bb6b7736eb4b0a958469be13d8c646faec1208a.1360677646.git.mina86@mina86.com> <20130212205141.GC25330@sigill.intra.peff.net> <7va9r9fd4e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 12 23:51:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Ogp-0006E8-9e
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 23:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423Ab3BLWug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 17:50:36 -0500
Received: from mail-ee0-f42.google.com ([74.125.83.42]:36240 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab3BLWuf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 17:50:35 -0500
Received: by mail-ee0-f42.google.com with SMTP id b47so322780eek.1
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 14:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type;
        bh=lC54Pe4PNxyVtDgnvRLYZq/O8bKcvsOFiEre6uCBx1A=;
        b=bfEk2jJVDHFH/jjR2qvvJcBAnP4eur1PFQhGnVDJaLJo661GuvAd0kx8XGdY+anyKV
         I2rzxevVdHJIy0UMnfi3xrT6s1UNDUWQzsw+7xvfhqq46Sz8IlJ11x8rgLXqu60vhmLa
         9X/gHpUqkDP1YI6E4uw/JUc45uXI+3SS2sD2LwFJIJNCgB8XwnX7WxIYLy6pmY7Mdhzo
         hduKYnWGfhyJqbdjdbZNrpmIR/wwzqda7idKVpCEFSTIq7G8Yxx4NFkfh7Rr6NbaYXR2
         U8B4yWY7M7S80gG9n6cY+uDM13iZxXWIrNXhGtJSEhsL/5jdpRpxu2BCo28gMCCOkpJH
         XWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type:x-gm-message-state;
        bh=lC54Pe4PNxyVtDgnvRLYZq/O8bKcvsOFiEre6uCBx1A=;
        b=mWQmttlKaZDGCwDnvsHrOf6xAEi5gpXG1jXkfvuSwrFbNPSwIozZgLATlPcxvhE98g
         8GpUPFiX9FrjGp3TNtDu0FIP7icVVkdUlFyCH8Ewz031a5ki/Wa2krg+CaVIlpC4u0SJ
         DYKeDK9tq9WR7RDI3dUUFb+EkAidAO3onixUdIKultoZ1Y2nZBW0lsCwuEsPFoKLWKam
         xL0cInhBfVTTwXgzJsVgWL8RtmwXTCTtQc9QuQs7ZMU6YO+V3aLu9NeGoJVIst/uohoH
         Pfx+pVtM/kgM71HMoUiX910hI4qlDOisCcI6G8wetgVbRXHJ125bfDG6v5XJuT8sV40J
         k6hA==
X-Received: by 10.14.223.137 with SMTP id v9mr68691203eep.22.1360709434080;
        Tue, 12 Feb 2013 14:50:34 -0800 (PST)
Received: from mpn-glaptop ([2620:0:105f:5:6552:be17:7596:e60d])
        by mx.google.com with ESMTPS id q42sm60943420eem.14.2013.02.12.14.50.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 14:50:33 -0800 (PST)
In-Reply-To: <7va9r9fd4e.fsf@alter.siamese.dyndns.org>
User-Agent: Notmuch/ (http://notmuchmail.org) Emacs/24.3.50.5 (x86_64-unknown-linux-gnu)
X-Face: PbkBB1w#)bOqd`iCe"Ds{e+!C7`pkC9a|f)Qo^BMQvy\q5x3?vDQJeN(DS?|-^$uMti[3D*#^_Ts"pU$jBQLq~Ud6iNwAw_r_o_4]|JO?]}P_}Nc&"p#D(ZgUb4uCNPe7~a[DbPG0T~!&c.y$Ur,=N4RT>]dNpd;KFrfMCylc}gc??'U2j,!8%xdD
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEWbfGlUPDDHgE57V0jUupKjgIObY0PLrom9mH4dFRK4gmjPs41MxjOgAAACQElEQVQ4jW3TMWvbQBQHcBk1xE6WyALX1069oZBMlq+ouUwpEQQ6uRjttkWP4CmBgGM0BQLBdPFZYPsyFUo6uEtKDQ7oy/U96XR2Ux8ehH/89Z6enqxBcS7Lg81jmSuujrfCZcLI/TYYvbGj+jbgFpHJ/bqQAUISj8iLyu4LuFHJTosxsucO4jSDNE0Hq3hwK/ceQ5sx97b8LcUDsILfk+ovHkOIsMbBfg43VuQ5Ln9YAGCkUdKJoXR9EclFBhixy3EGVz1K6eEkhxCAkeMMnqoAhAKwhoUJkDrCqvbecaYINlFKSRS1i12VKH1XpUd4qxL876EkMcDvHj3s5RBajHHMlA5iK32e0C7VgG0RlzFPvoYHZLRmAC0BmNcBruhkE0KsMsbEc62ZwUJDxWUdMsMhVqovoT96i/DnX/ASvz/6hbCabELLk/6FF/8PNpPCGqcZTGFcBhhAaZZDbQPaAB3+KrWWy2XgbYDNIinkdWAFcCpraDE/knwe5DBqGmgzESl1p2E4MWAz0VUPgYYzmfWb9yS4vCvgsxJriNTHoIBz5YteBvg+VGISQWUqhMiByPIPpygeDBE6elD973xWwKkEiHZAHKjhuPsFnBuArrzxtakRcISv+XMIPl4aGBUJm8Emk7qBYU8IlgNEIpiJhk/No24jHwkKTFHDWfPniR
 4iw5vJaw2nzSjfq2zffcE/GDjRC2dn0J0XwPAbDL84TvaFCJEU4Oml9pRyEUhR3Cl2t01AoEjRbs0sYugp14/4X5n4pU4EHHnMAAAAAElFTkSuQmCC
X-PGP: 50751FF4
X-PGP-FP: AC1F 5F5C D418 88F8 CC84 5858 2060 4012 5075 1FF4
X-Gm-Message-State: ALoCoQkoc6kYUrcWh+OGJQE/zVjuFt0KN+Vhyx47Ot15V2+f3ZkMnyRZSTcnH2+f5SE1gx2U4ZqabFRMMUaK8dKfU5XRV4DokkTMREwt0adVYYHh8LlQWK1VnLyqguEJjvxgXwtUU4LdnvWvjYU3wXc2NFVpkq3DR8Ln1Ej/bEbiKdmwdbFeBIw0yAQ4MYVeUekiv5zSwW4E6LBkEExPPcI6AuqeumaxLw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216213>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12 2013, Junio C Hamano wrote:
> I would actually vote for the most explicit:
>
> 	_cmd_close($ctx, (grep { defined } ($in, $out)));

To me that looks weird at best, but I don't have strong opinions on that
matter.

--=20
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz   =
 (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
--=-=-=
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--==-=-=
Content-Type: text/plain


--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJRGsczAAoJECBgQBJQdR/0Wn4P+wYI1i5kBrI0U/mocgY1ypd/
UcN9uIQ3Z8z5LyqiCvse2Ll1kJWqi53S8dE2FMtQy0WucaTcP39Jk1vVg/eVupTn
fdN3Ab2ykRDwK1CavHPxYTqMcMrwQQqKQ3NSwLoVpDz+Yf8pM95Va7zd4WiFCwx1
IU5XVmDO0AV/BvP6VKAsH9S/0W62oQv44kRCO39Fhwon1Oh3EFDyoP1eec9GzRZH
63jE7wgSf+mmZgH5+cGKG+fSP0jrLxCLqNYYrmJTV0CiP7lrjXCaR9DJKpNWnfQU
wUxui37AyEOApSMiYZOEOYROpqniJRlPaisrLhrGChtbfJrsTJNtSAyzR/LKWRCu
t348zCrP5goNFJWuOOlzcC1QdXJYnOoxoRoSCghlS5FbsXhvjXfL2TlIwLuUoRKP
VjHfZjG1c+dmgei+JEW74hsVtHrJ7tHKO8TIl45UaOytajqxLhLQXcGGihHvgQAi
7m+7+J24H10iSrpnpL7LbNfYWGmgNyPc0soCgV3cYY5IZG6oCJ/SgY8MoSGIZnwN
5N4TmmajddXSp5E4Pyjjxfjblnuc+Rxz89xKrpmvJYMdET4OeO5o8KPG3LxZXell
pPBWJUgrpErnvC7/x5MVbBgsF3sgAdtWYcmDO8fGoPHBGs63pIGsrxwm+wWeCi2l
UklQSmF8e28M02nEQX6b
=jqjF
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
