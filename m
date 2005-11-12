From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: Re: Remove unneeded packs
Date: Sat, 12 Nov 2005 23:02:47 +0100
Message-ID: <43766687.2000007@etek.chalmers.se>
References: <1131800663.29461.11.camel@blade>  <4375EA80.7070405@op5.se> <1131802238.29461.18.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marcel Holtmann <marcel@holtmann.org>
X-From: git-owner@vger.kernel.org Sat Nov 12 23:03:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb3S8-00083Q-4x
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 23:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVKLWCZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 12 Nov 2005 17:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbVKLWCZ
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 17:02:25 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:30939 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S964821AbVKLWCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 17:02:25 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn1.fre.skanova.net (7.2.060.1)
        id 4368D4B9002C6403; Sat, 12 Nov 2005 23:02:22 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <1131802238.29461.18.camel@blade>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11711>

Marcel Holtmann wrote:
> you are right. It is exactly what I was looking for. I just saw it so=
me
> minutes ago, when I pulled the latest git tree. However to make an ol=
d
> GCC 2.95 happy, the attached patch is needed.
>=20
> I am not sure if it is fully working. It deletes a lot of old packs, =
but
> in case of the linux-2.6 tree it leaves on additional behind.
>=20
> .git/objects/pack/pack-4d7682fb8230fef33eb518fa8e53885ec675795e.idx
> .git/objects/pack/pack-4d7682fb8230fef33eb518fa8e53885ec675795e.pack
> .git/objects/pack/pack-b3c6fbdfa36a326815de6358885c7a570a986b1b.pack
> .git/objects/pack/pack-b3c6fbdfa36a326815de6358885c7a570a986b1b.idx
>=20
> The 4d76... is the current pack, but the b3c6... is an old one that i=
s
> not needed anymore.
>=20
> Regards
>=20
> Marcel

This is most likley because the pack b3c6... contains unreachable objec=
ts.
git-pack-redundant only makes sure that all objects present in packfile=
s
still are present in packfiles after the redundant packs have been remo=
ved.

Thus, unreachable objects will also be considered as required.

Note that I haven't checked if this is the cause in this particular cas=
e,
but I have the same packfiles (I use the HTTP transport too).

I'm thinking of the possibility passing a list of objects to be ignored
on stdin to git-pack-redundant. This would hopefully solve this problem=
=2E

/Lukas Sandstr=C3=B6m
