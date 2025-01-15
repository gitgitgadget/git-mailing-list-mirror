Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89D923F299
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736940986; cv=none; b=CdyMK4Kc9r86e3hUR+bG25y1Y2Hl28GpFVY/FgFjQItl2MmSlClRv2Td+ymCKoYBqq9uXPJ0L7Yw/vMGqKUrRHc200cdr0jJz40Mq6PlKcbv/kbMKsbzFm/odK0M4vQiCNKJBGB2vwN7V4l533mwYkhiImVuiAujF9RMKx+eXtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736940986; c=relaxed/simple;
	bh=gcu62O2/chFQrZciysQBlCPS2ZRMpD5hSaBE2LzrSnQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=FWPk4iyVxlkoZ0qN5By66cIcZPyDxf8amwLf3zIF7dlMqhhWWjXl7GLqpTIvMgzq7eotV6+esqgygLAfad+65NqV8SqyPwFVEIlVyfKhrDWY2oGu1y5FaTcRouRBWGqU53wYb1N5yEm+Qzg+yl9TnVmMbdGIZorQoALSo8SBRNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu; spf=pass smtp.mailfrom=cepl.eu; dkim=pass (2048-bit key) header.d=cepl.eu header.i=@cepl.eu header.b=Tf7MpQXs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F/1KHA36; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cepl.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cepl.eu header.i=@cepl.eu header.b="Tf7MpQXs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F/1KHA36"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 283561D40AD9;
	Wed, 15 Jan 2025 06:36:20 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Wed, 15 Jan 2025 06:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cepl.eu; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736940979; x=1736944579; bh=RYOoY6R9nj
	g/uEn5Rp0abzZw4ZIg1TzXITgt185Njek=; b=Tf7MpQXsreJdrdVIqDkmURzUNf
	9TB+FulkCvFVmTcAJ3RxjgJHLOLOwO+kmLgoWpmcX7ELqJfECIiqeoayaQGm/sFd
	xd4+gq2XsJ3W5NZKUWGEjgYKePvcXFP4zDFq+LqX06tFwHdqrD1np1luG5wDQCn8
	PVG80FYEq4I4SFmuL9oBOIdhi3jX3atWS7EX+YhVtL86/K/eWrX/uD+DW63JN08G
	EyA6pokMWRJBwYakTlurDk6FauI0y/MUt2zjRxQBbiPghJZfn8gGIwBFliK/b6hw
	LYc4uw5kJiTh9gVDtZFYczPN2bW0Ym/aTKjNyFKwTJxgHTbHftbs0sIHR9wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736940979; x=1736944579; bh=RYOoY6R9njg/uEn5Rp0abzZw4ZIg1TzXITg
	t185Njek=; b=F/1KHA36v4Pe4Dr5WnGp4mGuBeIn4CvBCQ79vz+6Z+I229jFbu7
	GI+h2wNirJbWxbUmrUwb/juhXFUxQL9RAitJyxlOrUp3lnr6DY9D/7vYwpZVD218
	EhNakj9q9IM9nNvwPR6+KZahsQ91zmhuKf3MZ/hyeksfhcl/m/NQXVd3lM9fHMD2
	1gXqGWA2lsOaW8oGI0JCnJbZja58/MRtOdUhmtllYs4Ei2uq3h/+dm6StCOZ/EZE
	fzrgbzvCJK3FKOf5k+OzkV8/xeM9CznUGcjnvYmA/WtZwRCbZRhpsSyHX2QKCPUH
	Gdrf8zfeYQJgY8vU99Ns5faVHjAizA/fsow==
X-ME-Sender: <xms:r52HZwvJhdMwD-N1Kwc5UIFZYTFHaQVCHzfqpCBYqXeuE9RIjUdi0w>
    <xme:r52HZ9eXsGrbv7GEur8EvQmOduIcChEPud1it7ZuBGCYNp9v0PBsgwAWK08R5jxEh
    ov91mVFqNF31pFsYLE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggtgffkffhvffuofhfjgesghdtreerredtjeen
    ucfhrhhomhepofgrthmvjhcuvegvphhluceomhgtvghplhestggvphhlrdgvuheqnecugg
    ftrfgrthhtvghrnhepveefjeefffefiedtkeduteelgfeutdeuieeiffejgeehlefgtdff
    ieejvdegheelnecuffhomhgrihhnpegtvghplhhovhhirdgtiienucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmtggvphhlsegtvghplhdrvghu
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjoh
    hnrghsrdhkohhnrhgrugesuhhnihdqmhhuvghnshhtvghrrdguvgdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:r52HZ7woMHmtEddOG40ZlG-sF9NpFzhVeQcJugKyQpUipcLm_NRZLg>
    <xmx:r52HZzOsTbjYbR0dO5HAdwtddVTbIdiMPU5Lwma1QLy9NxWI7s0kUg>
    <xmx:r52HZw_oD3ejlR0So-cc6q0W8c70fQ8TpMXhjwXIn7VtXC8VWvyIgQ>
    <xmx:r52HZ7Xk_WxobTGs_65qlX6p6ycH_cNY15ZkCtkrCJzAXOFltueUkA>
    <xmx:sJ2HZzIqBMzzsnLs2EOyN0X2_rCpPjvUU1xzp8LwBR8d4FBglaYUdlgb>
Feedback-ID: i8c5e488c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AE79DB00069; Wed, 15 Jan 2025 06:36:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=a03b1792e19a5ec5fab2caa6cbcebe7b2c314e163f701a4dbe238c7c0c7e;
 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 15 Jan 2025 12:36:15 +0100
Message-Id: <D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu>
From: =?utf-8?q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
To: "Jonas Konrad" <jonas.konrad@uni-muenster.de>, <git@vger.kernel.org>
Subject: Re: Git branch outputs usage message on stderr
X-Mailer: aerc 0.19.0
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
In-Reply-To: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>

--a03b1792e19a5ec5fab2caa6cbcebe7b2c314e163f701a4dbe238c7c0c7e
Content-Type: multipart/mixed;
 boundary=6489418a3274f718ab91b580c82d81b7456a3dd20e357af7a411cb37f175

--6489418a3274f718ab91b580c82d81b7456a3dd20e357af7a411cb37f175
Content-Type: multipart/alternative;
 boundary=2fa5971f91a8e9b07570c806b85ba6fb68e9170ee16403b4b1cc98c16b72

--2fa5971f91a8e9b07570c806b85ba6fb68e9170ee16403b4b1cc98c16b72
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

On Wed Jan 15, 2025 at 12:22 PM CET, Jonas Konrad wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> I opened a terminal on Arch Linux with a bash shell and called `git=20
> branch -h` to get a usage overview of git's `branch` command. I then=20
> tried processing the output with `grep` by `git branch -h | grep list`=20
> which gave the whole (unfiltered) output, i.e., the displayed message=20
> was not processed by `grep`.

And that is exactly the correct behaviour. In the world of UNIX,
where pipes are normal, utilities should send to the stdout
only substantial material, which could be processed down the
pipeline. Error messages, help, and similar diagnostics, should
go to stderr. Also, you know about `|&`, right?

Best,

Mat=C4=9Bj

--=20
http://matej.ceplovi.cz/blog/, @mcepl@en.osm.town
GPG Finger: 3C76 A027 CA45 AD70 98B5  BC1D 7920 5802 880B C9D8
=20
Thou shalt not lie. Thou shalt not deceive one another.
  -- Leviticus 19:11


--2fa5971f91a8e9b07570c806b85ba6fb68e9170ee16403b4b1cc98c16b72--

--6489418a3274f718ab91b580c82d81b7456a3dd20e357af7a411cb37f175
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=E09FEF25D96484AC.asc
Content-Type: application/pgp-keys; charset=UTF-8

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUdpQkQyZzVUMFJCQUNaZG5H
LzlUNEpTMm1seHNIZUZiZXgxS1d3ZUtQdVlUcG5idThGZTdyTllNV1ovQUtjCjlWbStSdW9WRXJt
NEhHc2IwcEw1WlBubmNBK204MFc4RXpRbTJyczhQRDJtSE5zVWhET0duayswZm0rMjVXU1UKNllM
emQ4bHR0eFBpYTc1QTVPcUJFQW1KbHlKVVNtb1dLakFLL3ExVGo1SFczKy83WHFXWVlDSnpBd0Nn
alIyRAppcnc4UVA4R0NvVVVYeGVOcElPVHF6TUQvajY2VlRsbityeFlUMTJVNGp4TGxzT3M1WTBM
VlFmVWJwREZFWXk5Cm1rV1g4aU5UVVpzeCttNnVoeWxhbW0zRWtOL2RXMGIyc1E0RDNvY1pla3Jp
TFBEUi9YMFAxWFBVZGN5MjhhNm8KV1pvVkFLTjI2WCtQd3hTcTNKQ2lRRUpnUEplS3hpTGlFeGgz
bERpdE55QVMwV1VEL3hRT3FyeUVGYjlrc0d4TApSOVVDQS85V1VRTXdnUXZFVWh1VkI3cVNuUkVv
MytrczM0S2x0cDcxdVVqdU1qTGszeWtTcHR5bjhvVitYWmd4CnJ4UEFEK1dPSm41MXlGeGJvK09Q
TmRINndHMlphWEZqNDdyWDZHUTlXNndJN0swUWhkeVFUcHM4S05sc0p1RFEKcHo3WE1FOThvYjhT
c3pzdmtQUG0vZ1gwb1dkT0lxSGlwSG5NbEw2ODRqUkhDV0hWanJRZFRXRjBaV29nUTJWdwpiQ0E4
YldGMFpXcEFZMlZ3Ykc5MmFTNWplajZJWUFRVEVRSUFJQUllQVFJWGdBSVpBUVVDUlNvV0FnWUxD
UWdICkF3SUVGUUlJQXdRV0FnTUJBQW9KRU9DZjd5WFpaSVNzcjVzQW9JQXFzTmNzMVNsOWpybXF2
N3ZKekw0UUc2OFYKQUo5KzMwTm1CQ2xRd3BtcW5BMjZuQ2E0K1dTNWFiUWJUV0YwWldvZ1EyVndi
Q0E4WTJWd2JDNXRRRzVsZFM1bApaSFUraUdBRUV4RUNBQ0FDR3dNQ0hnRUNGNEFGQWtVcUZna0dD
d2tJQndNQ0JCVUNDQU1FRmdJREFRQUtDUkRnCm4rOGwyV1NFckFVTEFKb0M4eXJwdE9nb29KT3pM
em1MeERjMW16ZUdEQUNkRkJ3Wmx2RmNqMVQyZG1DUk5kbjUKY0VyUnlCZTBHMDFoZE1TYmFpQkRa
WEJzSUR4dFkyVndiRUJqWlhCc0xtVjFQb2hpQkJNUkFnQWlCUUpRaXhwdwpBaHNEQmdzSkNBY0RB
Z1lWQ0FJSkNnc0VGZ0lEQVFJZUFRSVhnQUFLQ1JEZ24rOGwyV1NFckJNWUFKOWVRRXBpCmJMNlZt
N3NVT2h1cHhEL1VzSGlXbFFDZEhZaStVTnB6QzFtS1l0RFNXYTFvY2ZPMVE3NjBIRTFoZEdWcUlF
TmwKY0d3Z1BHTmxjR3h0UUhObGVtNWhiUzVqZWo2SVlBUVRFUUlBSUFJYkF3SWVBUUlYZ0FVQ1JT
b1dDUVlMQ1FnSApBd0lFRlFJSUF3UVdBZ01CQUFvSkVPQ2Y3eVhaWklTc1AxNEFuaTZVODdoU1VY
RFUrM1pUYURSWEl3YXNUdHRsCkFKMFFXaGpTbWFKVGRra3BmcW1SQjliUmk5cEFRYlFmVFdGMHhK
dHFJRU5sY0d3Z1BHTmxjR3hBYzNWeVptSmwKYzNRdWJtVjBQb2hnQkJNUkFnQWdBaHNEQWg0QkFo
ZUFCUUpGS2hZSkJnc0pDQWNEQWdRVkFnZ0RCQllDQXdFQQpDZ2tRNEovdkpkbGtoS3dCQndDYkJP
b1RZNTJoWWVLbkt1VS91UmpPVHNVTWczSUFualRUclhZSEQ0OXh5THM4ClQvVnBzdWs2WlAvaHRD
Rk5ZWFJsYWlCRFpYQnNJRHh0WVhSbGFpNWpaWEJzUUdkdFlXbHNMbU52YlQ2SVlBUVQKRVFJQUlB
SWJBd0llQVFJWGdBVUNSU29XQ1FZTENRZ0hBd0lFRlFJSUF3UVdBZ01CQUFvSkVPQ2Y3eVhaWklT
cwpraTBBbjBHdzFNalpKQVR0VnExMVN1MG1qZDNyRFFDaEFKMGVlUEUwYW1Td1lWR1NwU05iMjY0
K1hqVW90clFzClRXRjBaV29nUTJWd2JDQW9VbVZrU0dGMElFTjZaV05vS1NBOGJXTmxjR3hBY21W
a2FHRjBMbU52YlQ2SVlBUVQKRVFJQUlBVUNSU3ljaXdJYkF3WUxDUWdIQXdJRUZRSUlBd1FXQWdN
QkFoNEJBaGVBQUFvSkVPQ2Y3eVhaWklTcwpieVFBbmlxdzFQWDI0QmxiQkQyMnpOcVl3emZJUERo
d0FKNG0vM3l0dUp6c2Z4ckVhYzF0U29FYjIrSDl2clE1ClRXRjBaV29nUTJWd2JDQThZMlZ3YkMx
YVR6UkdNRXR1YlVORVNHc3hkVTFLVTBKclVXMVJRSEIxWW14cFl5NW4KYldGdVpTNXZjbWMraUdB
RUV4RUNBQ0FDR3dNQ0hnRUNGNEFGQWtVcUZna0dDd2tJQndNQ0JCVUNDQU1FRmdJRApBUUFLQ1JE
Z24rOGwyV1NFckFuOUFKOWJPME5VcUxuTURUQ2NjaHRWeks2eUVPTGtDZ0NmWHdrdHkxdUVBelFJ
CjVrdDlHZWM4eVFweERsaTBHazFoZEdWcUlFTmxjR3dnUEcxalpYQnNRSE4xYzJVdVpHVStpR01F
RXhFQ0FDTUYKQWxyNjVDc0NHd01IQ3drSUJ3TUNBUVlWQ0FJSkNnc0VGZ0lEQVFJZUFRSVhnQUFL
Q1JEZ24rOGwyV1NFckhqTwpBSjQ3eUY5U1RYL0VzNHFzSlBqVzk2MUhlOUgzYmdDZEVzak9ndDdj
ekU4N0d5MEQxS1hXV05UZFR0VzBHMDFoCmRHVnFJRU5sY0d3Z1BHMWpaWEJzUUhOMWMyVXVZMjl0
UG9oakJCTVJBZ0FqQlFKYSt1US9BaHNEQndzSkNBY0QKQWdFR0ZRZ0NDUW9MQkJZQ0F3RUNIZ0VD
RjRBQUNna1E0Si92SmRsa2hLd3NRUUNkR21HWFc3M082UTNUQjBWMAp4UDl5THdNakR0RUFuaktX
RFc4UEtPOTBueDhJa1BvZHhyMW5DdkpidEJwTllYUmxhaUJEWlhCc0lEeHRZMlZ3CmJFQnpkWE5s
TG1ONlBvaGpCQk1SQWdBakJRSmErdVJQQWhzREJ3c0pDQWNEQWdFR0ZRZ0NDUW9MQkJZQ0F3RUMK
SGdFQ0Y0QUFDZ2tRNEovdkpkbGtoS3lLdFFDZEhEcG9sSGcvMXFEYXcvNENReVV6QWZOdkhrMEFu
aUVZTDZCRgpyZHlvbmhnUWYvWlh6WGpuS3pTZXVRRU5CRDJnNVVFUUJBQ2Z4b3oybm16R0p6NnVl
S0hrVGVYY1Fadks0V3pLClROL3VKSmhFbVN1UW1PS3ltYklrR0w2dkJRYitXNEt4dkxsMmxBYk5s
ZklnTEdETENzMVlBd2ZTcEo0dlM0bXQKbGlQZ0EyT3RaNWoxV1NPcXB4ZWRRUEdWYmE1Z1ZvN0hO
U09NVXRaS1R6N1ZzQ3ZSOTR2MDVjb21oTzFHb2s3NQpaeEh0WXlWSHVrNVY4d0FEQlFQL2Z0K1c0
RjB0Y2N3c2x6ejhPL2M5L01qOEtaRFltZk15TmI3aWVsVDJXZVEzCmlGRjlBeE1UNk92T3hBUWJE
SnZ1cmZLZVlseWRjWExzNmN5NGxLY2UxaEZhSjRpK01PRkxWVjFablpERENoUlAKcFE2S3JSQ0hM
YittTFkrU1lEMzdPN3Awc3BRQSs5Z3NFRS90bW4rNXNXN0xFOGhxU09vUFZkZjdZNXlVRGo2SQpS
Z1FZRVFJQUJnVUNQYURsUVFBS0NSRGduKzhsMldTRXJFVVNBSjQyVDFsLzJURnlrYlVMQnFxQXRu
YkM2a1IwCnd3Q2RFblJsQ0dsdm5PNzhSMEZnS1hsdDNSeXpHdUU9Cj1zeG9XCi0tLS0tRU5EIFBH
UCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0K
--6489418a3274f718ab91b580c82d81b7456a3dd20e357af7a411cb37f175--

--a03b1792e19a5ec5fab2caa6cbcebe7b2c314e163f701a4dbe238c7c0c7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iGwEABECACwWIQSJ70vGKIq/QxurJcPgn+8l2WSErAUCZ4edrw4cbWNlcGxAY2Vw
bC5ldQAKCRDgn+8l2WSErOpOAJ45mGfk/zOiU3p0AmLQSiIiBqgIuACghOZwAwjv
BgK3nGY9ZrHc8YaiKCE=
=DfE9
-----END PGP SIGNATURE-----

--a03b1792e19a5ec5fab2caa6cbcebe7b2c314e163f701a4dbe238c7c0c7e--
