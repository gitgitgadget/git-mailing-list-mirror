Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15D91A27A
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="GKFG7Yw8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1702992962; x=1703597762; i=l.s.r@web.de;
	bh=cPIgI4epBkS2an0Wp3o8KHnvUic5iNAalWdKuTI4H0c=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=GKFG7Yw80iW+kwKfp/aN+yWcFtUaCrZL6bn6m5YSB3blkhr4pKyX/ThKfjURSSlZ
	 /mmbSsv3i++QxII2k8D5om1uz90zqwjhBKQtBwlkOrRAsNk/ZZdQ9j2vDkk0s2TPF
	 RUY1pp6nrE/Ofr1+Uw2ihlm9qufCeaN6OxMMqEIDs/Kmuwimc3Jp35Elq03JYFhZr
	 hnj2CAbor7jvPW0tDtJFpAmfit6qA7SY8VmAQR4rNWzqHpzGe3DRrdrQSAGzhjO64
	 ND3qUCWSRMQHA78cl6C/ROYzWGkEioDzmCY9MiH90StJH13ItEA13d2G+h+q3XERE
	 5dDQTXWBSq31Vg0hnQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpCqh-1qx1yf2kjn-00qNm2; Tue, 19
 Dec 2023 14:36:02 +0100
Message-ID: <aa9e4e07-03d8-4f4e-a63c-f393e1b56c92@web.de>
Date: Tue, 19 Dec 2023 14:36:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git-compat-util: convert skip_{prefix,suffix}{,_mem} to
 bool
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org, AtariDreams via GitGitGadget
 <gitgitgadget@gmail.com>, Seija Kijin <doremylover123@gmail.com>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
 <20231212200920.GC1127366@coredump.intra.peff.net>
 <8bea38fe-38a3-412a-b189-541a6596d623@web.de>
 <20231213080143.GA1684525@coredump.intra.peff.net>
 <4d0b2a5f-305b-4350-b164-44923cb250d8@web.de>
 <20231214220503.GA3320432@coredump.intra.peff.net>
 <99b3a727-36fd-4fa5-a6be-60ae6fc5911e@gmail.com>
 <2d30dc36-6091-4b47-846f-92d3f4a8b135@web.de>
 <b7a56625-46d5-4d77-b4bf-5595a6fb2aef@gmail.com> <xmqqa5q7e00q.fsf@gitster.g>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqa5q7e00q.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bV81ibq8BJULR+l0+BeTVLcWFjPo51scKhJGHT92EvocpPObDtH
 UWk4UPZ90MeRr39MdEnESp7yO5pJgDmgaBJfvdKwzslCKpujs/VAezGcq+fBtdayxcg4gJ5
 zVxUUAavEbQk8euqYsLiSQBidAjh1NjaMt8C38vHjUiWhfV2m/mUAcgPJcozHcCgbnbSCUo
 H2favPleP9HI1kwBFPpGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VAEVbyzsihA=;qnBZhQbWc0tHaDLzxpQzBV+9Fok
 qQzd4NnwbuVUH7BQpgbIQZWC/nTSGIIcejk+v36CM1XwcJ8C9MMQ0PibOToKCuddN3Ja7YXNl
 dmFbUwG1DQlTg/ioC/kIaLh2wDj7jXvmvPd98gHVx8HeopW0Rd+pBpBNZBnO6y0dnR3QpIwNg
 Twe/jlJwV4jooxwDsQeUFNwMNV/hktZYFi6SwFCntGtbuP2lcpHWlNsVqduLLfo28+59H9rHl
 3iM3EFbnvaEu82y/+heGeJ4JBVYnkUbOInhjx9Q4e2JHFx5ad70fBnyagaa/zfU8u+Wg+EJ2L
 NJNfcTKrRkrLRj53tk34IEFSWxZZ1NeNd/4GWzFneXmAwi0Rm6w4sWC2L1V0gxb1aHravwkM8
 Tqhvc5d9xWX/nMvcFgALkvjP5QvPFAI+Rvh1ndUud011HNVTWqvJ0gFXMx9BXyPsM6oLkixdU
 sNfQcgI5HS0HyKf29XwgEXO1oVbnlgkbv9K0yo/bDMa/+xc2iE9wFVCwV0t+g0rH1bQSCgiio
 gB8wasSxNMU/jPZ1amNYmd8hhPacne/3OoDdcYSnu+S4cc7K/GH7k3b6S3dp6q45/cU8dKNc1
 SXKcz7fIf+8a2RbCW8qnShhG3Dcu/hVppcbWX64wp2Mlhfd+zBUfxG0P0dYtw2kn2t8rus626
 waAiFSp/nSjihTxs22s/OnEdfycK+CeWXyswa9P5QYZ0aT4a+ZcRxb4p+SgztdrtXZk0okOYr
 4L0wRDVYb2RsNK/+DiqVrW3CNGbu3a8wdHUce7f7EH1uhH6qfXu2eD+MApJ8tny2f5jKwfVSB
 2910z5EbQ9+Dx3qCJLxoAStO3Obab3iTaLDgVgWi5Ql4YQIB4r9Mg3SuD+S5NUmnwQQaF2zI0
 VElAgRT6SCvOQh3g1tZdcwFFuG5srRXkMYcfatmxw42ce9HnmeBONM20nXMhh6NYNmdpTRMD0
 1GgHeQ==

Am 18.12.23 um 21:19 schrieb Junio C Hamano:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> Thanks for the comprehensive commit message, I agree that we'd be
>> better off avoiding adding a fallback. The patch looks good, I did
>> wonder if we really need to covert all of these functions for a
>> test-balloon but the patch is still pretty small overall.
>
> I do have to wonder, though, if we want to be a bit more careful
> than just blindly trusting the platform (i.e. <stdbool.h> might
> exist and __STDC_VERSION__ may say C99, but under the hood their
> implementation may be buggy and coerce the result of an assignment
> of 2 to be different from assigning true).

We could add a compile-time check like below.  I can't decide if this
would be prudent or paranoid.  It's cheap, though, so perhaps just add
this tripwire for non-conforming compilers without making a judgement?

Ren=C3=A9



diff --git a/git-compat-util.h b/git-compat-util.h
index 603c97e3b3..8212feaa37 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -705,7 +705,7 @@ static inline bool skip_prefix(const char *str, const =
char *prefix,
 {
 	do {
 		if (!*prefix) {
-			*out =3D str;
+			*out =3D str + BUILD_ASSERT_OR_ZERO((bool)1 =3D=3D (bool)2);
 			return true;
 		}
 	} while (*str++ =3D=3D *prefix++);
