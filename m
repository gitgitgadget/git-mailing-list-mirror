Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F032066F7
	for <git@vger.kernel.org>; Sun, 26 Oct 2025 00:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761439620; cv=none; b=lqv7Neu2rNv3yJq600vUSNr5cg6cHXfk0/Ovsmhm3/SDLl6m3VDq4o0Aj/btL4FRXnXAay5UrOtg+C09/pQfUAe61GNM84ZazpU8LP0jtAM7yNwWG+Wg9xU213+07gPeVm0RQY2/2AK4FtFnb74Dm/YCAkou9JtNZiXBuTmATv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761439620; c=relaxed/simple;
	bh=yJ5Psj2E+7NO7T/UAZY0mtwql24J+uZ2xH3avRzLkOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=usfnXYiQRXRi8wpCvaokdrcZ98z4me2b+xtB4pgnVRthm6Z2HkW2qgkqVlM/RV1uV/ibNyx/lDD9p0/eoulr12DBRvLb9sPu1fPcr/DPhwoAmqnV70FitD7mXf2iuyVjCqHkFJp5HNh1kBqr4E71qK19gQEVuOQX53vHl4ZJCdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RmQd22iN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=riGok/VD; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RmQd22iN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="riGok/VD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DCE24EC0109;
	Sat, 25 Oct 2025 20:46:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 25 Oct 2025 20:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1761439616;
	 x=1761526016; bh=nTUSxz3x5LZb2TbJJlY3xNmQo9mQpqQ6ajqd5ZYyONk=; b=
	RmQd22iN0UBBdAxc4nq2huI0rFy9MaJ+Ji5SF9ZF/7xZ1aQvWB/m+r+l+0iilX1e
	NTewKTnI8CvnJrhNgDtV+YFPsUY9f0afyqYtxuHUvyT/nhRWG1IUB8gywgIA6wgb
	7G/diaF8EpvSikL5VFJkZcKoAc1hF0nF4bq4hngwCPTn95vum7F8t6b4lYQyiphR
	6ZSV1B9lD6i/4NCRRe6F8CvoWsC6ew/kQ7ds8WMHnz1yMNtAMfjLA6rMBQzyU8GM
	YHHMQNjYpTNVH42e7ac/96ihKepZQSA1vZiIgutqCiljSOpdwNrC367OTPdclv6J
	MkffU4YUZR2aFxcoYEeXaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761439616; x=
	1761526016; bh=nTUSxz3x5LZb2TbJJlY3xNmQo9mQpqQ6ajqd5ZYyONk=; b=r
	iGok/VD9UE6K0s/wcuML9e83swCJcjboqZrjU4jgVUQUyUr3/e68o3VG8D1IursK
	SAnv8e60ZsLaPUCanUAtMBl1tfBwnBQj0E/qfsaCiP+sp4V+LjiaO23XTeG+y85Q
	9v0t8yV6T+dywMzncDv9K8n+zZnBuA25rQx4o95DJaDuUsNyJuEqz/faKvqrNto9
	lzHvIvAfZzVSNbZqUpw2eshDTzxWVT4uibueuuLuWvWhcnjPhddt5lwBjEXi3FlO
	pEnWea96vgPCDuhxcZO96gJvRcnJurhr0K0TW/Axz1dNQ/M5mU/8VlJWjxXYK7+0
	pcGp5vFnbDpJbPnpvaAsw==
X-ME-Sender: <xms:gG_9aABLwcOnDU-2x-kaD2HhwVlHxVUaxcb_5b-hpO_TM_hF7hH-WA>
    <xme:gG_9aJ_mgNhS1lrMUjKShVIHLPW_fKr_brQCFNYemaokpAn5A9McZV8bvmxSejS4K
    g_VPIEq48keErVf2XtLfLxXfWnMPxgE2L27VZPayd-9kmKG2k52lw>
X-ME-Received: <xmr:gG_9aA8UJ6_6t46E_i3jECK6xsHnBi6MxYmBvgmpS_sIf8SkmguZhuexSKB8zNE3DjQMQyMqlRjfpt8RrLnq6ukHRwKDR6IhDalc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheefieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdr
    rhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gG_9aAeIRxieXU4OITSOIefTSe1eUsy0Wn63c49MdjVIYbGCw-cQ5Q>
    <xmx:gG_9aJGwgH2oiuvnq1DJy6y2rR8KZSjbelz9y6sBLWa--ZDCbMJMtQ>
    <xmx:gG_9aOf0qpzNVeMHC-ci2HsiUAwTNjHMhtu1lLxAQnk32sKm3jr_ww>
    <xmx:gG_9aDHamNHzqyGrruChCrc9gwDTH3fumPSsx1xRRKeu0H-cT6kPoQ>
    <xmx:gG_9aMmd6BlvkQ2uP3pyYYO_5H1tBdT1qC-dSBEhF9rMjsW52mrRiEiC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Oct 2025 20:46:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] add-patch: quit on EOF
In-Reply-To: <13529bee-1e02-4c20-9461-6569312bfe4f@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 25 Oct 2025 07:48:28 +0200")
References: <0985f775-fb01-4de0-99a8-4775b602829a@web.de>
	<13529bee-1e02-4c20-9461-6569312bfe4f@web.de>
Date: Sat, 25 Oct 2025 17:46:55 -0700
Message-ID: <xmqqfrb6mqv4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 851ca6dd91..071b78c355 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -1431,4 +1431,15 @@ test_expect_success 'invalid option s is rejected' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'EOF quits' '
> +	echo a >file &&
> +	echo a >file2 &&
> +	git add file file2 &&
> +	echo X >file &&
> +	echo X >file2 &&
> +	git add -p </dev/null >out &&
> +	grep file out &&
> +	! grep file2 out
> +'
> +
>  test_done

Let's do this squashed in.

 t/t3701-add-interactive.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/t/t3701-add-interactive.sh w/t/t3701-add-interactive.sh
index 071b78c355..4285314f35 100755
--- c/t/t3701-add-interactive.sh
+++ w/t/t3701-add-interactive.sh
@@ -1438,8 +1438,8 @@ test_expect_success 'EOF quits' '
 	echo X >file &&
 	echo X >file2 &&
 	git add -p </dev/null >out &&
-	grep file out &&
-	! grep file2 out
+	test_grep file out &&
+	test_grep ! file2 out
 '
 
 test_done
