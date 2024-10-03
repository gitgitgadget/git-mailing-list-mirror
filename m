Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F2213B280
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970670; cv=none; b=oezIS8/UqLerlqnmIBTdcCJOflTN1SyZ8/oxRjxW9hh6+qpDueaW9cvCpRyIT6vmKGpIccLOugvW1HKcONKNUBbE82364MlNIwQ0mppvqkgSp3ZiRJd6F3qIl5DSPNBqQErHlW2loDyTh7adJ4C98wJENGUoZsSZLVemj+2HapA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970670; c=relaxed/simple;
	bh=1WTOuPmURi6TM3AYvDlhWLp9afU9xMEaquo3wvTAZgM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YjxQWitcWST8jaNj8XkepiHMpe01WY/L++JDwTy3Q2vnTlUWsf7DOb178ciDSoB2Pa86ePA6X+4NiNq1Bew6xNdesvI005T/5V3V/SvjErWp+mG/qrnU6oKG3f97CO0qE5q2xLM8DIHxhE1MRWA7XWBhf9UFgvoI6yFyVgd0hpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=txCuYqgJ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="txCuYqgJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727970661; x=1728575461; i=l.s.r@web.de;
	bh=TJQpsTtIClyfuAFSbe7ZHu0bwuDFkrkZUMZkj5ArKmc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=txCuYqgJZWjx2jDGrAyJqceQPb+5Wclh2BoQEi/YDSKvGdSD0ZQ/TS1QgI2bevWL
	 oyINeo9xj0mRU9iJHCQxxUlMYHtQprDTwtsFMTUg/Ld1dyVEHI4TdG+2A0qM5SiQ1
	 vHCoaq3MEEPB0ZS7RE69Zh47etK+N4fqkXmbQLQ6k4legYJUS7PVw2cTc0CjO0DDB
	 Zak2k1j4B130QrVoFPAekN6vbezvZpwtSFeB1SUGmb53B0Z3AJyAORVkNIlVbApgM
	 QIdZG03WklKESdyeEqmJ9647ipi9qhOBElhTGT7KIkCVK1LVCqgeI3DVQWx/LGx9+
	 mMZjAX1z33gn4DgRRA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.148]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8T7K-1sryGD2qYK-008IjG; Thu, 03
 Oct 2024 17:51:01 +0200
Message-ID: <faed1d0e-86a8-4dcd-a27f-19dcd9f89f37@web.de>
Date: Thu, 3 Oct 2024 17:51:01 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] archive: fix misleading error message
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e2AMEfr1/NhIYXOJQfUXzB5gQgS7HF5BCqBonTQed/Wo5JSIDI5
 aPwCaxHLpQUCKELbTW6m/fp0hJI22qXw40QGfE8BbhWgxFUhtcT9RBB0H3wrBbLSp2rj9DG
 RiueJE2zY9eCykDkNiT3QUZXbF/GkSt1kxrtQE0ARALwWjIEJ2qznNRz2fxfQtw57+/Yact
 +EdMJxlSNMKfQSFCVPbaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZQvWkcn/6c0=;eUaqWtbvgKmOUvc6Na8/nmySaIK
 jrIend/acjmoRLCRUA3lUQa1MjEbtIvm7+XA1vbHyHart9LSaDm6F4IQ97VUjqEcGqdtWDLtG
 qLyOnpRA2heKMg33XFvobUMKJuowW8dVDbjCAkX2SgEbzcsYlpTrIixpFkK47k1shTaeE5Uq4
 GqkzE1N4zXQvoKgrhmnYrYdQWaZdtcOJlnEQsVBS9YpnTwxxwlD3QckUn4gitoEa4rdfRC1TJ
 Af74smcu08j6Mw4Pc+rR1rRRRdrM9a3wGaWLhXMkR64uhh+L8SOqlgoNGGrJpwQoWqEmnTZZP
 E5qp65NEGCID3cyoqCGSb3+I0ZeTNK+Him7btgx9Hqruh4abctz8+pFekp53l/f2y7APFwDgE
 3HXd62Xm8waY8CMHGfoSmtswtglIvbMiLiewhkq4GXiiNZUTb53IsKgnLqnL4YiICkTMmGOkO
 mwij8bgFSgzTuen208kouDQtrnVohqsRRIMTxKvW/fsOApg4RJMmHGka/Fyo+XBRa5e581n7N
 5b34eE6gGwFyen/zdXBgRcL0SPVOF/YZnVzpm1uMyXbJh+tzYewDVJXM3VIdcVF/U9ak9tuGH
 cKOxtyy8a0eeFaGF66np3tZzGdeNCoiSFCgBjQHpNfzRnviVdcp11gw5Guf5Z0ytvRDGW81rr
 MYkRATvTOTpg+O3eQKAmRVw+B56N4t8Gk90Zt0pr60M9xbYoWMHDlI26PQe8LRKmAgN5ZRGQI
 S6W2beygeMoAhy2sDknynxzT5jr1mN0rjcsKsMqI6pFo6GHRqtOJJ+NB4QLBzmoUPEHe2IE46
 mTXMT0CLg99Ydw/nTn+H4vuQ==

The error message added by 296743a7ca (archive: load index before
pathspec checks, 2024-09-21) is misleading: unpack_trees() is not
touching the working tree at all here, but just loading a tree into
the index.  Correct it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Silly me, I stole the wrong message. :-/

 archive.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/archive.c b/archive.c
index 58f86bf75c..a7a92ff839 100644
=2D-- a/archive.c
+++ b/archive.c
@@ -536,7 +536,8 @@ static void parse_treeish_arg(const char **argv,
 		opts.fn =3D oneway_merge;
 		init_tree_desc(&t, &tree->object.oid, tree->buffer, tree->size);
 		if (unpack_trees(1, &t, &opts))
-			die(_("unable to checkout working tree"));
+			die(_("failed to unpack tree object %s"),
+			    oid_to_hex(&tree->object.oid));

 		git_attr_set_direction(GIT_ATTR_INDEX);
 	}
=2D-
2.46.2
