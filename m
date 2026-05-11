Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231353A4F4A
	for <git@vger.kernel.org>; Mon, 11 May 2026 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485575; cv=none; b=mClhNZRtoH6JrS76jN7oF8sNGoqt7rJhT9BU22JZ0tvpUWg+snbYCzneW11hjeF14pG3JIFd0S5NSU3e+CK/vXtsXVJp+A2H7lsNUxyUhLH+YqdylcxWeyFKGvrldzQkNTJwyB7lsc63EB/fB8U9lOqoko6LS/zf0k6KpTfGtxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485575; c=relaxed/simple;
	bh=m401DNdKu3plJKVknLjLD7Q7Wn6Crh+QiZ/b0vSlyRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BgGZoXl4sV2nfeHLdA6jUVn+In+TKtZ66PtJ4epWNizoP74oFc9LokdXvi9r2xkbnM5yp8GwhfSJ4oI7K/D4MvmQgi/wCOJa8eAZngBj5PzR9vG6ZW/UasE3VZ+ljpo0eXzmbgKjmL2B08zbzeeFhIMvuGYwZyAPTTRU5rjPsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=OhrQL7yK; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="OhrQL7yK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778485559; x=1779090359; i=l.s.r@web.de;
	bh=4RXuNh08gB3t2ARbkzkoXad5a0SbQPrGzN2He0d8vSk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OhrQL7yKFcwVbP9ut9WTs0JlJpkC+fzcjBvSnme3oaJnflyNZYt8hJWejOVcLQZ8
	 AKjYZjKcJRL+wy66aHL3K8e+bpxb3oDMlQP1GORB2oR7dlMYnXFWe8U3zAF2vMS0M
	 2HTIQzGl/r5H1xtUT5P/8Yw7tOQ3MuQYHisXGfHe1CUnO5je5zZc8WyVyoS7WhyfV
	 6F+nIu6c0h6/yDgAvHNzzZv4Eu/fh32oLblBroBC6gCOdmd2mE1XCuiJForg6ukI1
	 mBCIkiXjSfvevuB2T5I0Q08BYpGBmr6SYI6Z94K4ZvE+b6IlC1eQbOBg0qdGCJ2IM
	 +nV3Mjd2/+JlTz/Qiw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MN6BN-1weq5j3YzF-00Z8vz; Mon, 11
 May 2026 09:45:58 +0200
Message-ID: <ac1aac76-17bc-469b-8dc1-d3a384f5c6af@web.de>
Date: Mon, 11 May 2026 09:45:58 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] shallow: fix relative deepen on non-shallow
 repositories
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Samo_Poga=C4=8Dnik?=
 <samo_pogacnik@t-2.net>
Cc: git@vger.kernel.org, owen@owenstephens.co.uk
References: <e8257951-4ea7-40ba-8043-f4f2a080b70b@web.de>
 <20260506215647.3011769-1-samo_pogacnik@t-2.net> <xmqqzf26x0vi.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqzf26x0vi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BE0KskrwiAfjir2IX0m1/+n3PCrYwDrcjIFAXybRUZ0niP4+e+b
 ey680NJnIHUMi2aErrnbkymZk0+c8gyny6P+Tp+rPwPtezhG2jJS3lQfRhrtJNy9rRTPfkg
 xYgPgujXX0BmPrYcCXN4Y7ZZJqSC9KvfGGGa9q0YquxQD4kJR69yyd9wSZOgWHpfbHSi9G0
 VWKeYisJv9+jWha6ucrIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VHXOcqNCwoA=;DnZOcY+rdAEOsxS2yDG35bg/lx4
 c9NSSjUs8I6oc+JZr9ufkmWKt0Y68Ad30d45joyZLn+oTkArbKICWE6u581LY4LJbfjVOJcdX
 wIZ74FCAWg4Qq75P853olY27Qbvn7pBMI1Bbo0DEs9k+ex/dGJL7gVDdVEZCEQAmfaVpsMjzf
 /HGdJEDi47nbmRR4LQae5mwH95iPlnKpmi1T7k0ksO/gZVa9D0hICaWNwzGV9r+wpotbQ/oWX
 xsMqJP9M8rcCm/zL/METse2SiBuHvZt5yDny4t1UmwD+N3OkTkU3616QfPX7mWztjeQdBtlDu
 C43JFlfLVOjS7Qjx/2GgxUWkssIP0wox1OFGWnlwvRns4X9rdquLbk3Mse+xfA0FQrFofz7zY
 KndjEAj7MxcX3ElAWNWxbR+xGFw+SjipTWgw9ScvMHBEA1KYKjUgkzYeYjM5dZmslSC7SoEJD
 J/MeKnyn+Sb0CxkHxd2fwNwN6JYHYAGn+8rx5oNNEJXEDUBuaWJ7mbeyuNeiPvOsctvWfJNEL
 NkjlIA0L2IwjTTyOjHv4WYeMTnpQbDDZN+l1Yza1dIjw57v/cIn+0lrfRWc/ysi5WprPonl/P
 kCkhH+RgQ5cLYhJ1CRFdfpK6tmpkHvzxuVMLktFnaRB67Z8w+N3aDFzjxJJGxey4ag6RQuW06
 uROoU6ASaXWSfEhQ83icLD9vlDR6bAhh1RHn+EvXaQpseBZjkMLliiFlU+CfNRGpyc5qkzAHM
 2CHqAxhhB33iLX176PlfMFsORtUUGUdog8E/Y0OgOzf70HdEuUycR6Vypza0BMHpzxB2aKeos
 PYKSFuchKUydAjCzzBKgsmkvPwREVWGRGgywtULoxIlQEmGPpI+OiT3FsiKOMAqm84lTFUfDh
 488uOGLJU09ctPDGBA5aVWrzO6rb8ppuvAAEu8tmPH3xvmSWzgGkpg56BUY9E/wfCCK7VHyDx
 jaXY4GWiPLMVLRFrMff7+qrfwbluFTuGH1SZa5Ev/SHFH2M+0R/9B/F8vmhmgXNcA5CwCJoMq
 fXjFplKy80iE0Km+XdDdj0gEEe/MCJ46uyLPlMNLBX1kqFx0FmyVo/O/XiLsTVy6h7Ry5Vcjc
 GcD1RJDPaiUfpYiOiWfnwiFiTQ4ZG+260MAWkAj+7lTJ2Wkb+7HUiybEjxmBSZM5FQfPGRGTF
 UW84VO96I/165Drkv6+ym133DTh0QHhrXOsHuOGhm8qqTRvHBNcFG67sDF+8RZUfnIScO90IA
 gu0aPkf5XV5XMbL+Uak1K/eOUle6qFckj02mGmhAJEh7OoixJ9iQ1ZxgYITDOA++EbAcZGY5C
 lMxZbfCYhWeKB5Mf3dmOPfda9UfhaaqJ+h1lhuuWjS036GeBqeB1lLAI+G6j34LgXHcB7uoEq
 ZcU4X0C8M/JIo57lCrCyDhWPtnvF8IbmOLLj4Q++RfdsM6RGQfGx3EamQ/cBc6XsFcAgC4iuZ
 nelkRa2DJ3hVT1DibIyCB6JomKqirh8cBZQBq/nas/pB3tv+W/lW8Ms3FI7LJKDW2dxaTazif
 P5F0F1fW8alxbQXAXDdM/vtgcg2vU4ZVIJASzSDkxVMwk24EXvvwx/qsNSgtBqTumL2FuKtT1
 sHsOt+yfZlpls03ZAGmmhQGA7W1YXIa1yFFofptdwatItbPQFXoes8bfGP50UBt+gWshAmCxz
 HW17HFAdKULD++LxcFYjo0NiLkmpNo8FZD9qb7cGs1880uueJITd1XijVnd8tGJAnOvlakoyV
 MCTheHxy3CBHBr/u6kPUem21+C4zsBVrlPcuPwzake73cP+8qr4hbdTkUdugHXPO1nbNcnygK
 rND7XIB02UeN+yL9p3mEhP+MdwDteFirvpv9SODtEXEdWsCuwgBeiW+Nq4ssVL6fx/NNZasvd
 nMJY95297OoMLXj4CjOYypG9oU5tbaS1Y7soTgniJDIMvM5fm+Rc1+OakakPbsZwoDFPtGrQx
 /wtszzM2E3+UbToMej0K8/KhPr3F7Ove1xr3JZuqSNPgqRfGJ3CyzShigmNrS3GIPVo1I7PqX
 E+EpfSAKstzSSVHBrbVJ1gJ6oQpaLb1TZATXdRWslb/N+7vg93pyaNJoLCHeQl7W4g0n6SKPD
 t2/PuG0cU+tSZwR4iQzpnnKNonxwkWpJHImm+TNbUJW52gItFP1dh87kbCofRIsjRKzGW1Y4Z
 lDUcDv/15wTFM4/W9GnTp5T9eQg7+V/ZexSIVu0A5b55NCBl/H9Y0Lw1y8Mzno16bauRa2eYR
 ECu4vmQJLCeXrFVqKZ2XbvfjVFQxYxI4Mh+1wiZkJsLQ2wrLxGADV1nusSZiI+BB+eHk6Zz+2
 CV9au2724107JM8LgwRDFqHWoWcZm2C9iDt8YfDKoHwdybMLEDBA/7Td5doTL2tRoQ3lneOyW
 LVjgsig41IHvyq9VjHWRNR5+eNX+CoMr4aEeEILhVor71HvZNcazB6yeIOwGpYP6bXrDbZZHg
 dAFeaFL1YKNaYMnd4bpWKMiarnXvflGaubzft15IQmHv0XaXxzVB5zjdKkDlCBvHRdAbxW3Bc
 v3BQ18HdX+yM7bUjBLaDsHkYEyAXTT7fcBI0CKMVV1lhNB7qWeWu63eM5DVL/NqNoqVCcNnxT
 Gc5fIXNm6YplVyDCsVjjEcyUkM/MkFq0kCaVgYlo9AMf4khV6J1ltYchnTRyP9q8PY1wcrGSU
 W2Moe8NfEHTP5vKnflQ4aZSsD4JSSEANrhinCEr+D24xettIvHtWMT6W++KVpbUDeWcLCJucA
 LC8eB/5x4E+TeSq3A4fjqGatk4+Zid+/Hzhxog/rnYbfv4/NLxiN5+Gjd28S+PRl8qrHRW1YB
 p7T4rgYxlcY9hgI5X1RIAE3s4PczTIQkpS6DRlpnYme/zGOgge7TEowFs97+ZDUQj/Aiw+036
 2cUHzKzBGWU8LgAXYqWEiybi1XWnEirtBsxc3WQDjH4kYdQTMo8+n8KZ2DxJxYcx6RhgxMF44
 pTxs6ikHLcdQiHAwS9AhvdFiPI7FPhMZgEIurEZADt2qfbhpTHLXRKFwhL9QcbgRr+QNVTQWv
 P6cuywCVco3w5APBVlCxXx+oYgUCH+Lpq22wyycMSmrv4xiKsha57qKC29FqR4/A9Z3emU9px
 xFfVSPcf+jSk4wiTafNT3clbCVm7bLpmZgMeZpQx/IpajP8RwHDPln7L9S8ndaXX3al/FPO10
 TyWw+IfmRnoJIjLSItVIJHixugJmKJoLWyeeN52J6q8xx37QMhBVOwLlcRZVcdQK5wnzfKFw1
 L+k7hw8xzlbaoLymRp+YC4XuvP+CeLmibDJuHwTFoBtncP8rUDwTbCm6eyb4YoYLarACWmC+g
 QL9s4/W9mmLL7VWaI8btq6L6RWa+JaHcCkh11nrO+aobaL/QODTo6b+eZM7+mMdG6vV9zQ6ai
 N4PXeyBSLv9GdaaA/qPTaslieQQmj30s1P4le7EP2dH7zZRldKo6Kqd/rXKV66xG8z0OtXvjn
 qYRgrLD5k3U3saJ3JCWG6QpuAX+rhGqDOykrBYpHDZEgqu/R29LzvvAdvbDbfbE7owFI0w9bz
 5gOLjmhBBLR9iP520Pz6L5FO/fePnJxnDTB2m9duJi7p8+1C1fje917zZMSMs+KwyF+DoUOoH
 0ujE7lC+vjppaRQr+R/KpLwrTJ4M9aF8ALIYfm9KSjHKRQfd2xIXST0MBiDn87Mj2zbq8JqBA
 gZnjPcnIzZC/Z+4ENrsmytiRNPSYFA/682gOGsmkeNrP7zxPiGKNi2iXpT+Nct6XVWc3ldM0r
 ofG44dpjqzeQPGIgNZSO7Mbskvtl6nyWryUViZzGxTiehT6GCy4B5/q/en7lyetpqbCWNZZKY
 wDb0aX+tuxtgH2pWV0Hl9AY1P0k8zUhaxagv3uAJy53fyLITyT00roSdfYt2ibcCTp+mUEhCe
 xv08rkRA+1Q34k0DknAYwWhkrHoOln4beqE9SVMdtbxv4EI/EXgOkKsob7e9f8qPJG4GsjnY9
 L/iqn0InbdUdJBSmzQGoDgYUU8Jt84Xrej2zU3dWiXoCmcWzSx8hkugdQ9GNOu6CWRf26ppoA
 xnfkHEmtiI+2/X+Y4oby5dtODb7h7Q3wRyJRFtRL9TQw+a6oSa1MpdSmJF4qHZCZm6p6h9shO
 O9PKQ5J91TnCdaPf4wpC7bEOfRhMgbE/6eTBwMOfYwsvF12KErGgQSm9Nn7x9xohtN68vooUq
 46xOkCVvFTnW1ii/C0nhE1+POzc0PwkeQ3NIxONKjLIFXHRs8RlbhCqGoDYhK4/sapdNVLKis
 lDxFfAnPy4nlQu833wvtdR7swSXB7StRG3NShOBM4r/qluNeQ5q9ynld+9OUcxQhXxHqml4t+
 O752tnB2ooj6uNgtucwyHFf3XcmMlgZhcwBH11Tm0EZmN78OTuTVL9OvMQJC8rBsdpe8hDaQA
 be/3M7FeYLGCHsyStjQ3+yQbpBeT5mNTnSIloT6JYTYmrqVMuq1Zv3xQbuXTpoghmVEdAesJC
 N/9b4556sqxS0xZhDlqoWwQAu5IH3wy3cJQvXQUo1WzO14mF8seywHbmNBDFSIy1kjgkEccjQ
 XuCoJ+//VYEsw4vjM19z82tW6Y6NfP4zDkJJblU6gQuusTdkmBd03PYe6aqm3zo/aj4Qd3gA4
 rNgfUO5N6/BuBu8C63PiS95qz7E2tcu6qiixBFjc8iE+UT7EdWWzNKCfXulGlO4KLDFWcb5bb
 hCp+igrDMrqf3QuWLPrLoEgBSby/iU9mpjouCAvho8GtQNGD0S8fLfWvKBhbWXOs77LnAxBGC
 ZiuZ5ZDo12dIKhFj8Ddeze7ZVMD69eIBvZvjTuLJl8HtGOGoc+aWYXUhkLeUU9cO6kb+jkV7E
 IxqswSus68tN0l8nIASkPI73KN4MuhTQkdivlU4bP0xIPFLm5HR3FZEGdSqkyE1j/J5rUvUGC
 tty0fQbubdoVcFrLvY8/MCGNggbFNL+FudwOA1dy1/dt6Xxj54HykUgoCkNrotcAX76c5bduS
 K6dutTlizJKEqoXTF+TDJeVIgZV0gdpLq6DQq54Gfh/8x7UCEsa3lDwZElAzPwRlYcvolEnZb
 W0xehGYP73N3dWl3ut5Ohn5p/Li1dgzO0YSs0dXOgkKDHy547mlyQs9xS/EERh55+65ApnbIx
 juZZi0/yVkYfPQnvvQySqsmIwzA4HhT061fIz5o4L+vBU27TfGSkaGII3PNH/J7qBMsXmxPO0
 /TCQSX8ebi1BYrVvKF+rPcSZ4bN8a/A7cj83u5LtH1ntabDXcqY3vtKWWMNFGrP8b7fRZPnHS
 NQoZN2KptRd6H0twNOl5w9r2lzaBLg+ucnHBioDAz+ZLml37tuqXwjPdE3+LY2NF6+M9lKAaJ
 Rr5c+2zTAfSjXS5uwb7GU3J8kCQnUaDzTNM92NB5BGZuOnkRSiJ8bkbGlhC+z1nGIPy2DLXl/
 B7o6URBW3QNauHL2cwcHORyeX3AFLoGkXH//FGcNyt7tA=

On 5/11/26 2:09 AM, Junio C Hamano wrote:
>=20
> We obviously should not truncate when asked to "deepen" (i.e., the
> user asked to get more history, not reset the number of commits we
> have to a specific depth), and making the operation in this
> situation a no-op may be a good first step, but should we just do so
> silently, instead of giving a warning/diagnosis?
Perhaps, but no warning has been given for deepening a non-shallow repo
since the introduction of this option by cccf74e2da (fetch, upload-pack:
=2D-deepen=3DN extends shallow boundary by N commits, 2016-06-12).

The best place for such a warning would be close to the user, in fetch,
no?  And in its own patch.

Ren=C3=A9

