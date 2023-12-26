Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379AC4C63C
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="aadVCvr9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703578666; x=1704183466; i=l.s.r@web.de;
	bh=brx0R4ST4fMOA3hPFa4tNE4YiRYrJoxGGpsPT1RPuFY=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=aadVCvr95a6TZg/zn9ape/n7ZfNjqmSITJhlUNyWgPgwubIioF6rAAHM1mAKTlW3
	 hHXIQRYgyd3g5ikVfTubWWk0IrwdIEn3A9WeabR7ttKeCOhO+4nzj4EOEtamJHFNr
	 UQ9FJIsEEtitlempEoia4JLsE/8S+G7jBPp63fM0MYuQP1kUZKVtGuo704UoCe3rG
	 AAGkAym3ZrhCP9bvJOWyZh9DKxz+eGQ+BRLwxCoWNvrPWKcLf8IGTb7EWmQGdYuIz
	 YZPxi2mxwVKaMQvSrqfjrQC2d4iT5p9zpZ8N5pfFpL3nLSf/By8BVIK8VQ4Anz1NF
	 OHQ7p/bc3jyp+RYb/w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MAtsj-1rOwVf0HrF-00BCWP for
 <git@vger.kernel.org>; Tue, 26 Dec 2023 09:17:46 +0100
Message-ID: <50c1f410-ca37-4c1c-a28b-3e9fad49f2b4@web.de>
Date: Tue, 26 Dec 2023 09:17:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] fast-import: use mem_pool_calloc()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rXqMcHoDbdpUuX8MJWSIdRShM7lVuTZfewN3J/hzwyOtOsu/mcj
 SPyShznsiFMx2q0C7D98QBMXfuAm2XgNbXUn6kgxhzTwmvS9NMYHOWlT+nC42IfNGycABT0
 Eg6+uq86i7LKIK8bnA/97zCpcLWfjnuPelYkM8/7SZEqmHABELIvZYswubqmxf6aMlvo+Fd
 nP1Lczw3mNNSIuL5l4nAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1o89c+dzZrI=;UaVJpJN+KDNaYFUn+jypYtm5xzM
 RJVir/itWmKHRFa/FTFoc8N5FkJBnN4UjBmy2Wj35R75AFBHaH9VqJFYZJl3eFvAEoxfiSbGZ
 BrBbx6zSva65aodHH4JYDyPR2D+V50gRL0YfKim//BooYhDL8/WoGfAg3MiVBUox9rKSXXany
 Nbti69lrOMFQNH2045Bj0m8UOlYpTi9SxP+gGowSjB3TCA8LjIuY3bs2O9b7FRgiFGKGwMa/l
 SiJxwy03PQhytmvK6FfQY0oKs/OYJdrhnlwBYE62EfqwbNmBlpmuIRbHOAThsBRU2WEh5XE2v
 u+7G3BWlU2/53sP2eifjulWK0mck7CTtpZNO8jCOCpBWNGHLhsrVNZPrkw7AprsiaZu6iTTTZ
 WpcGAc2eAIZIjczDj/jeY5UN2z3K9bmQOEzZb2y2c4MKfuSuHPPkJgBY9f2bbWxSHK4pvoPrZ
 6ohBwI3yHxNk/aQLtIbdb1UKTSptoavScjPpdroVLLrTmUNMKxSj0yc91RDA6XwjbUTsyzIvW
 Cc6MbCAzdzkoyALEJAEw7UFcoEJKAzwkC8eR0wS/BaUMPxg1NolfVFYZ258scb5MFln2/tpjC
 TPj3fLGu9QIxNsLRQNFvwoq8tda3qP4x+LdV4S+ovce4KFaTBf+OdiaC2vx2vWlIv/ErE+vDH
 uXkA+UlVQ6muIOfP2kisVZ6tOq6Nou+tN1uk0gVg9Nx3cNA7d3QAwTPcPiQOp1+M9TmDU1cPg
 tldrAX5gerKi83fhm+PVoVGkLQPtms80S1Vhshzg964c60rWhXACdvGZrW9AAfP1RseOzECv3
 imtzIL+fz4FcqLvXX1wmoGqA26WNSFwBPn/FNlYbKYrlsXyz4lNM/OB8jfikL1+jSPkx3TCHP
 PGg+D2khey2jRI76j5VxHATxX0GsWPiYRBaUFOYPJTRndTOv8AwkzrnuBuzPrUBnJjCHrFQHb
 OnUxiQ==

Use mem_pool_calloc() to get a zeroed buffer instead of zeroing it
ourselves.  This makes the code clearer and less repetitive.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/fast-import.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 444f41cf8c..92eda20683 100644
=2D-- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2809,8 +2809,7 @@ static void parse_new_tag(const char *arg)
 	enum object_type type;
 	const char *v;

-	t =3D mem_pool_alloc(&fi_mem_pool, sizeof(struct tag));
-	memset(t, 0, sizeof(struct tag));
+	t =3D mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct tag));
 	t->name =3D mem_pool_strdup(&fi_mem_pool, arg);
 	if (last_tag)
 		last_tag->next_tag =3D t;
=2D-
2.43.0
