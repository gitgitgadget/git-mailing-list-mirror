From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: [Bug] git show crashes with deepened shallow clone
Date: Wed, 25 Sep 2013 17:27:59 +0200
Message-ID: <524300FF.5000801@atlas-elektronik.com>
References: <5242F78C.5060607@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 25 17:28:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOr0b-0004kV-Jd
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 17:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730Ab3IYP2E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Sep 2013 11:28:04 -0400
Received: from mail96.atlas.de ([194.156.172.86]:25357 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755423Ab3IYP2D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 11:28:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 8EF48101D2;
	Wed, 25 Sep 2013 17:28:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T9dUY5ibGfXp; Wed, 25 Sep 2013 17:28:00 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Wed, 25 Sep 2013 17:27:59 +0200 (CEST)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 8C0382716A;
	Wed, 25 Sep 2013 17:27:59 +0200 (CEST)
Received: from [10.200.54.97] (10.200.54.97) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server (TLS) id 8.3.279.1; Wed, 25 Sep
 2013 17:27:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <5242F78C.5060607@atlas-elektronik.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235355>

Am 25.09.2013 16:47, schrieb Stefan N=C3=A4we:
> Just a quick report since I don't have time to bisect now (will do la=
ter
> if no other gitster is faster...)

I'd marry 'git bisect' if I wasn't already... ;-)

This is what it gives me if I use my script (slightly modified to also =
run make)
with 'git bisect run':

6035d6aad8ca11954c0d7821f6f3e7c047039c8f is the first bad commit
commit 6035d6aad8ca11954c0d7821f6f3e7c047039c8f
Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date:   Sun May 26 08:16:15 2013 +0700

    fetch-pack: prepare updated shallow file before fetching the pack

    index-pack --strict looks up and follows parent commits. If shallow
    information is not ready by the time index-pack is run, index-pack =
may
    be led to non-existent objects. Make fetch-pack save shallow file t=
o
    disk before invoking index-pack.

    git learns new global option --shallow-file to pass on the alternat=
e
    shallow file path. Undocumented (and not even support --shallow-fil=
e=3D
    syntax) because it's unlikely to be used again elsewhere.

    Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:100644 100644 67bd5091be0b34bfea075cd60281d22cf5b34768 6e9c7cd9d5da7d2=
4d4810b36039681f184325932 M      commit.h
:100644 100644 f156dd4fac30cda4e09c508b7091cdb8d96917e2 6b5467c6dec9645=
f53d83cdad2467a158db622c0 M      fetch-pack.c
:100644 100644 1ada169d5cff3051effee33c6f9ba5b9be15b2e6 88eef5a7cc6d36f=
6e17f4855945116dd6f1b0681 M      git.c
:100644 100644 6be915f38f1fe8dbe0a22c4cd8ae2569331f483f cbe2526d8c2b264=
3957eea2729a16269a7a74fab M      shallow.c
:040000 040000 5333beeb4db3fc37c37e5a4d03816c4750ce6b28 3b0fb999b865515=
5cba24e2d09ebff29058d29d7 M      t
bisect run success


Stefan
--=20
----------------------------------------------------------------
/dev/random says: Answers: $1 * Correct answers: $5 * Dumb looks: Free!=
 *
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6=
e696b2e636f6d'.decode('hex')"
