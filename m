From: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCHv4 3/6] Git.pm: refactor command_close_bidi_pipe to use _cmd_close
Date: Tue, 12 Feb 2013 22:12:09 +0100
Organization: http://mina86.com/
Message-ID: <xa1tk3qd9qza.fsf@mina86.com>
References: <cover.1360677646.git.mina86@mina86.com> <fc760829f74f31d23f94b61a9e087eda2a66956e.1360677646.git.mina86@mina86.com> <7va9r9gy5y.fsf@alter.siamese.dyndns.org> <20130212204807.GB25330@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 22:12:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5N9i-0005tV-02
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 22:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759696Ab3BLVMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 16:12:20 -0500
Received: from mail-ea0-f181.google.com ([209.85.215.181]:53129 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759431Ab3BLVMR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 16:12:17 -0500
Received: by mail-ea0-f181.google.com with SMTP id i13so226954eaa.12
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 13:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type;
        bh=ERK0NuGM8tG3VG962TT71Xo8ExymioI3zQr5jAM4b9c=;
        b=eUPOsxVyI0lHETHN35IsB1O0a3iW0bpWB53IXsVIn2GkIwPU2bEIsQmyCoDaO5Fnax
         Xg8UQM/sW+Rb6oerIW5zk7yIefwh0bFtqFHA3npqfR0FAyEPZPYzIQEnA7YniZKIB+VL
         2RRadrqcrEyRTo/MzGz/N8n27qmVw7xz4KtlgWfmZxdhOBLoJokbFCUJWJ1lou4GeTpc
         Y+s06yzwod7tj61N8svbNoPoy7HxaIoPlHvdMHwbRLM+rlMipap1Hl/imjbn+8JXKwRn
         Jln+jzLGwouCrGLYC3ELu8cV5KIHzIPsJ+g9IpKfKJYhDq8N2bAlJPPjiP1r2YpKlNfT
         1aCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type:x-gm-message-state;
        bh=ERK0NuGM8tG3VG962TT71Xo8ExymioI3zQr5jAM4b9c=;
        b=K0s5gm9v8jePM9lmiNEmjt4dMv/WSvR9SKpQeBRn5Sun1otUi2n6PNxCMzR4Ac2aMt
         tvN1kwhnb8TaZvBsMpDAGWfAVYb8fQulI/Xbx7i3JfHVVpj/n7wB6GNNeaeMRfTg1MVa
         jEaldpm3V7Ap29Oxrtht7JViCbhTXdjpx1FCp7A5mNssq89XTo0r3mefG49mBjQ4Ahuw
         NFodqBJ3oXHCnvIzZDvnulrn/y/mR2k6eDLaSzqQrGzCyhCBUIrsAcRIl1kANjjCbfbx
         hmFds/+9RycPhdjkLgm8bxO8WIhWHMzSPHKw7wUVRzusVXsy6D4AHCRyxwjKZKvelzer
         H1vg==
X-Received: by 10.14.205.137 with SMTP id j9mr13697285eeo.15.1360703536509;
        Tue, 12 Feb 2013 13:12:16 -0800 (PST)
Received: from mpn-glaptop ([2620:0:105f:5:6552:be17:7596:e60d])
        by mx.google.com with ESMTPS id l8sm35834811een.10.2013.02.12.13.12.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 13:12:15 -0800 (PST)
In-Reply-To: <20130212204807.GB25330@sigill.intra.peff.net>
User-Agent: Notmuch/ (http://notmuchmail.org) Emacs/24.3.50.5 (x86_64-unknown-linux-gnu)
X-Face: PbkBB1w#)bOqd`iCe"Ds{e+!C7`pkC9a|f)Qo^BMQvy\q5x3?vDQJeN(DS?|-^$uMti[3D*#^_Ts"pU$jBQLq~Ud6iNwAw_r_o_4]|JO?]}P_}Nc&"p#D(ZgUb4uCNPe7~a[DbPG0T~!&c.y$Ur,=N4RT>]dNpd;KFrfMCylc}gc??'U2j,!8%xdD
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEWbfGlUPDDHgE57V0jUupKjgIObY0PLrom9mH4dFRK4gmjPs41MxjOgAAACQElEQVQ4jW3TMWvbQBQHcBk1xE6WyALX1069oZBMlq+ouUwpEQQ6uRjttkWP4CmBgGM0BQLBdPFZYPsyFUo6uEtKDQ7oy/U96XR2Ux8ehH/89Z6enqxBcS7Lg81jmSuujrfCZcLI/TYYvbGj+jbgFpHJ/bqQAUISj8iLyu4LuFHJTosxsucO4jSDNE0Hq3hwK/ceQ5sx97b8LcUDsILfk+ovHkOIsMbBfg43VuQ5Ln9YAGCkUdKJoXR9EclFBhixy3EGVz1K6eEkhxCAkeMMnqoAhAKwhoUJkDrCqvbecaYINlFKSRS1i12VKH1XpUd4qxL876EkMcDvHj3s5RBajHHMlA5iK32e0C7VgG0RlzFPvoYHZLRmAC0BmNcBruhkE0KsMsbEc62ZwUJDxWUdMsMhVqovoT96i/DnX/ASvz/6hbCabELLk/6FF/8PNpPCGqcZTGFcBhhAaZZDbQPaAB3+KrWWy2XgbYDNIinkdWAFcCpraDE/knwe5DBqGmgzESl1p2E4MWAz0VUPgYYzmfWb9yS4vCvgsxJriNTHoIBz5YteBvg+VGISQWUqhMiByPIPpygeDBE6elD973xWwKkEiHZAHKjhuPsFnBuArrzxtakRcISv+XMIPl4aGBUJm8Emk7qBYU8IlgNEIpiJhk/No24jHwkKTFHDWfPniR
 4iw5vJaw2nzSjfq2zffcE/GDjRC2dn0J0XwPAbDL84TvaFCJEU4Oml9pRyEUhR3Cl2t01AoEjRbs0sYugp14/4X5n4pU4EHHnMAAAAAElFTkSuQmCC
X-PGP: 50751FF4
X-PGP-FP: AC1F 5F5C D418 88F8 CC84 5858 2060 4012 5075 1FF4
X-Gm-Message-State: ALoCoQmo9rcr8tiJGxA36a/zA9a8PTLVyfrsO3ZE8aLeDj0cEP6f7sp0TxbluNC222786pGzPqfOwmDJQSnMWSxW+jBozQoEXGyT7E/AXehvzh5OKorWFAKig/5zIicAOWmYx1NmcntFACXOhM4EGXumjcW4Rjh3hl7FbiZ8iMhykGJfZIKtZOahJEN0lQ0M/dAx6GN9jsau6qyYsDMtF1DJeD7g6mCVGw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216200>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>> Michal Nazarewicz <mpn@google.com> writes:
>> > The body of the loop in command_close_bidi_pipe function is identical =
to
>> > what _cmd_close function does so instead of duplicating, refactor chan=
ge
>> > _cmd_close so that it accepts list of file handlers to be closed, which

> On Tue, Feb 12, 2013 at 10:55:05AM -0800, Junio C Hamano wrote:
>> s/file handlers/file handles/, I think.

On Tue, Feb 12 2013, Jeff King wrote:
> And s/refactor change/refactor/.
>
> Other than that, I think the series looks OK. I have one style micro-nit
> on patch 4 which I'll reply in-line. But it is either "fix while
> applying" or "ignore", I don't think it will be worth a re-roll.

All fixed.

Junio, do you want me to resend or would you be fine with just pulling:

	git://github.com/mina86/git.git master

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

iQIcBAEBAgAGBQJRGrApAAoJECBgQBJQdR/0VIwP/1o2tqJBBiNwqv1fo36C6buS
3yOl4vhj7MzvB4mWcu4h5ZmJDXYSzu4v4TKCULIy49gHrAS+8aYvg0zINEDxhXU0
SzROym5tKmB4VrxWO4NFT2YLLedGCdrLVuiCuzeM5AaUA/RDoZYxo7HxbRR7QNfD
UW/gMcM27/9yzZRWBMBePzEJhB/HeJVfiFbIuZtCwrjPFm9L9rn4XqaXNdET8RuE
xB6oFR9UieCw0Rq+p2ED9NGlBjI0mEiYhH8Cn6v+Plsp3Gdg+Iylll8h7NoVtiFk
kEFT6fw44u5OpCkHcJXozPBCwDkODvZcESJKkkrpGGOvILsMztGIwCKhX06eAIhF
2zQiNVLNXKHXJnQDYBvouVChLJF34p33cM7KeBzwEdSIgDJxcahGBZ/s1pdnaINv
qjeDXAfWu2Ft4ay9vlsioKCSy3zfV8W/rx1A6P1PHCZC+8A2u/xL4VpDLSUv4wnu
vviTT3bVvQa0g2Afj5lBuJ3GQwvXXa7sLHcGFbh6bPmJUpq6REyczhRfweHdrj64
PwogUYSQfYZqu6E2rNSq1iBlPv/PFiQwOVvbVUO5SVjMOHSlzbNmDuRHQPUIT2rp
kNk29k+ArmG6rl1kbQNrq02ITQghgzcV373Q93pDBIH9iTuharemxAapzbrXzI/R
SzKAw+p2SaAnAsP3am/q
=0+Yz
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
