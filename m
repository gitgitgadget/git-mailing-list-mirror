Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B871D86DC
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765615350; cv=none; b=ZqdATMjrQAxsfEyxmErKcLYyRKc+/W549Wr82Fa9es981cXoRVSZyaUy98HhshtGpTSxAEBW2m3RrMdt9syMzZMS8u8IWqjKo2LnH0colexXsTyQaCJs3EMjlzGbgU+b/2+LcMxm0o/bIN6JhTJBTEqMfC28O7Qfw/04hSYjVEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765615350; c=relaxed/simple;
	bh=+cQr79V+DUqSbBO2x/BnDuyGPDh1sV89/1pSp2LvKm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y7QXyFeN2wE8fLSuCRH8RXaYiqUafmOc6qNWJeBmUnBqyPb00LvWPYgQ1Eo6jaa/iMwGhuQeVnARsbKQzb3qzndQf2er/9EqleiQ/SzQzr5LVDiiNM2YLi4+JsWqcnWmA7AeD73JGZNnAx3QHH18eaqy5AfwcyiqpluWMk1TeMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VdcF09A0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ffhPR8dc; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VdcF09A0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ffhPR8dc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 907A6EC055C;
	Sat, 13 Dec 2025 03:42:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 13 Dec 2025 03:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765615346;
	 x=1765701746; bh=1nphTaSG7uxZCxamPsPt2h26xyYYNCuqtSaDnzxuRfg=; b=
	VdcF09A0DFV3VVn18qrTPQReLmdasDLXMhQrkkoX43pqSLq2Gat5z/l+YTndE80H
	JX5jaAf89rhFmuOqruN7QB1q+QXkDxQ+cIlhFtdMKqdCiHkveIucOX36whDeWlZY
	JntX1o9bvjhs0IiFZJRZHwKa/f1i0a5iwUuhGB29+k2r95H1qAIqEEoMS26PmLwQ
	6pxq7T9/wHivQjPitFpHPhBf87iIXFWMs2MSGgpiTWGKj7+/xsqWqqgDL+PzQtFG
	zeQXpj9v1+YEloAQRT2TWpi3jyo5iUuc4WrAAaAJhtTWFGm01tLy1IGzieOA2AjZ
	SvC6e0PiOg2f2Rt0xTRw1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765615346; x=
	1765701746; bh=1nphTaSG7uxZCxamPsPt2h26xyYYNCuqtSaDnzxuRfg=; b=f
	fhPR8dcOcCBp4vzZIfkht2HWBVDa8uqiYFCAOKvBX2Ci5UPhSUzUyHJrHTASVHSs
	gSnffyaxEk7HWOAxq9RtkMO1UR4LbKUNK8/gI4AaNw+HZTh4QOtHthDNAjht9O4c
	Oyr7Mw3sdHEo95h/TFQVsYhVUpsxUiOq/zs1PjrME8lVujXZ8BVk8tUTtSNtGioW
	hX16iFghnQ2qMHrzFl+2Y5qFoQfNyKvot4Yt37q7hNuFAKeodjT399GS2au8otl7
	XK+JL5kbHdwanXWj+G5H5ZHPvtlgowTWlJJWLtmjlvbRd4qwYgf8kTY8Hh5qgGpB
	aomAjlRke2BLmPi24ZHYw==
X-ME-Sender: <xms:8iY9aXOjcBgph0IkOw7D_Ba_r9E31MiRKbZuYxdJq7Sma2NGpWc0iw>
    <xme:8iY9aZbhpLStD7TD1sD1n1mp7rw-DiJDc6HZPXBWZjnFdW4i17c5Fp80V4IA8ZGJt
    EYMAdYLvIXw5lHNAz0sSGGDAyYNIpPKVDAsMz9LEvh8tnPrDY5r_A0>
X-ME-Received: <xmr:8iY9aTrZpktyln5BKI0FViZz8Ue4-rshIyXvAH6iH2G4BJ4BmG7sMKhKNRdBTt_iEG4XkHH3gUx5KszwQ190VDB_cKMkM8HLzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeetleefgeeuhefgteeugfeitdefgf
    fgudekleejgfeivdfgkeeiffdufeelueeitdenucffohhmrghinhepghhithhhuhgsrdgt
    ohhmpdhtgedtudegqdhfohhrmhgrthdqphgrthgthhdrshhhnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidr
    tghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8iY9aVYdd5OA2ugjH02iT6Ux_ES0yStAFzUE9VPGQ021V-iAG90taw>
    <xmx:8iY9aTQ9vNdRKRxHSKQINxncnJdsaKPXwgKg6_fj9rnTfERPO98rfg>
    <xmx:8iY9aU5IpIgLhZm_7E9aWQTXf4k37DrScIqMgu6yJJrZav9XFoz-dw>
    <xmx:8iY9aQzno4DMiRpWBwaS_J1VO6tpZ4GejKqdT3WzznQMk0s75Xp0ew>
    <xmx:8iY9aZCGzef0g-jfNtENMHLTO0xR2VR-qksKFulgo2DMB8rYskFBIZhF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Dec 2025 03:42:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] t4014: support Git version strings with spaces
In-Reply-To: <eb0e6533-44ef-4b85-b1aa-f43f6d4174a4@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 13 Dec 2025 09:03:00 +0100")
References: <eb0e6533-44ef-4b85-b1aa-f43f6d4174a4@web.de>
Date: Sat, 13 Dec 2025 17:42:24 +0900
Message-ID: <xmqqsedeai33.fsf@gitster.g>
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

> git --version reports its version with the prefix "git version ".
> Remove precisely this string instead of everything up to and including
> the first space to avoid butchering version strings that contain spaces.

"everything up to and including the last (rightmost) space"?

> This helps Apple's release of Git, which reports its version like this:
> "git version 2.50.1 (Apple Git-155)".

Sounds sensible.

> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Not an Apple patch.  They use sed(1) instead, which inadvertently hides
> the return code of git:
>
> https://github.com/apple-oss-distributions/Git/blob/6b2f9bfe72d6d4b5c9bcc1c2d0236c026d321cba/src/git/t/t4014-format-patch.sh#L982
>
>  t/t4014-format-patch.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 2782b1fc18..21d6d0cd9e 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -980,7 +980,7 @@ test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
>  
>  test_expect_success 'get git version' '
>  	git_version=$(git --version) &&
> -	git_version=${git_version##* }
> +	git_version=${git_version#git version }
>  '
>  
>  signature() {
