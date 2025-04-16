Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194FC1C54B2
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 00:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765110; cv=none; b=j5oRDExwJzP840RvW8vG/tzMlhBpuRuD99QW4aG9dwzl34Pln+FFDvkr2VPnj/BEnAX8Wpk7c7xDUtzXAU/QkqQF9bj6dwlurzp4Rj7PYI1zqOTJQFddPPpnxw7wzNXlAlc9pDJA8H3Z26ZjaI39szw6pWNd5b/iOTRSG8WrHNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765110; c=relaxed/simple;
	bh=d/qIYGf78Gr5P6E9Mb+e7sIxsywTc0Coes3aZIHTGc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ptp3VHTIoC1Dh2hI+7JHY7nrBl63FNIgEiIQo3EQaFVFrIeq+yKhUm9krnkgE4LJsj5dH0GYRgdy3EkI0XkA28XJU3o0W5CscaY7fwJ4M+gog6R+CRUscNGEfuCtZ8964yG8vicFvz6cJGc46bpvV31aN1VFyvzSkEPQJs7KOHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WC8S2zOU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kLuXN8MX; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WC8S2zOU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kLuXN8MX"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id F320B13801DA;
	Tue, 15 Apr 2025 20:58:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 15 Apr 2025 20:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744765105; x=1744851505; bh=/9bBXUPOcX
	/5iCICnHhbNYuoRqEb801jpWvVL91A5go=; b=WC8S2zOU3zPYWWi/LtjbZ8Ejeh
	gsPf5xQfWs+7Hwp4uNghiFZI5vCPNZW64J/tw2J0F479p8Ablyr0YebuYvXU2T0k
	LZyqmmHMW2xO4PgSwcrCC1j2fR+v2bDX51LG1pM+S963gSth5RFjCpCk/WcxqHIY
	LgY/LV3Pf1pJPpxaE2QQl8925j7uMNCVDWqZhs9Op7slspUYpm67Yh/DGCaxYvCc
	5ENuJf8Y9hG0d6Ih4TLX9RmRkwXog6ykCHRC31alxULgTtGNuOd+q2Ja2m4kzqmQ
	y2Rc4Fk5Tm6SDHZ8gT/vuz+vkQ7cjmjkwPUq9fOUSTdjTFDJOXuNT40Vhhkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744765105; x=1744851505; bh=/9bBXUPOcX/5iCICnHhbNYuoRqEb801jpWv
	VL91A5go=; b=kLuXN8MXWXf84bm4hWOuCXYTiwT7/tuO4mPU/+eWUW2+uODX5ur
	eiRwS5rvRZuWOmQLXYRXyhXTL9rb0gmdF5L53mnqw8R3pPnGS4TxQ3dUWe2Gh/Cu
	2HPE9GJaa+u+6EQNQiTO+pPsTEtHufQpd6SCJD0UsRIs01MuKGQm35rQH37W1YrF
	4MgupQHa9l8AOA+n/MYt5DeMy+E7YDEKDxSRpwEAhUwLEo4vgO+ONtwAX6urUDJZ
	GTGH/D2iLQdObw1kDgADJMcBP5LRlYgBb4tuAYCo8B1GQ8ET4sJuubQK6wCZnVgu
	KlThfcQUndqVTucFAd6FZZr9SVnX7fHvETQ==
X-ME-Sender: <xms:sQD_ZwNquwbCQNwArzyG3Tiryse69SfT4HWqhx_hCsd8_X0Yjf9zhQ>
    <xme:sQD_Z2_xxNve-x_RsJbj6JoSM50TXxJeuoXRewwi6Uv4bWMpf_6bWdojDdkJxNA8U
    r5oH0ESXQoIOGDcxg>
X-ME-Received: <xmr:sQD_Z3TeeE_vqpJd9F1R98dGRwYpypH5X98lzVccaJqtmDDIwRuv17w4GBA_DTqtfCUkt9FGUU2QgdFVHH_CSy-1dZBYNIFmZBrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdehtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:sQD_Z4tbJl4AlIvtGYgXCGNlGRrIhqr_UuEQTP_NPsVLSwYQWxuCmQ>
    <xmx:sQD_Z4eg-7Z205ISJwEz2BINW1S7jaAjNgrNoDgWnHb214qIx0wqig>
    <xmx:sQD_Z80_t4ogGoMwbmndmBict0DmD8KS1SfIQ8HgerMtYAPgNhIKBg>
    <xmx:sQD_Z8_p8bx_Qnevy4uROsVMyBXs3w8yZNYbsKQK0nrT4m1ope1hxQ>
    <xmx:sQD_Z_DyMghp3tGmEaOWiQ_OMgsiklqZS0FkI8mvVYFV2XsII6bVNvQK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 20:58:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 2/9] pack-objects: limit scope in
 'add_object_entry_from_pack()'
In-Reply-To: <986bef29b5f33d32fd366aa9370d439175a9b605.1744757204.git.me@ttaylorr.com>
	(Taylor Blau's message of "Tue, 15 Apr 2025 18:46:51 -0400")
References: <cover.1744413969.git.me@ttaylorr.com>
	<cover.1744757204.git.me@ttaylorr.com>
	<986bef29b5f33d32fd366aa9370d439175a9b605.1744757204.git.me@ttaylorr.com>
Date: Tue, 15 Apr 2025 17:58:23 -0700
Message-ID: <xmqqtt6okjm8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> In add_object_entry_from_pack() we declare 'revs' (given to us through
> the miscellaneous context argument) earlier in the "if (p)" conditional
> than is necessary.  Move it down as far as it can go to reduce its
> scope.

That makes sense, but ...

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/pack-objects.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 20dd870bbf..4ab695a3aa 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3490,14 +3490,14 @@ static int add_object_entry_from_pack(const struct object_id *oid,
>  		return 0;
>  
>  	if (p) {
> -		struct rev_info *revs = _data;
>  		struct object_info oi = OBJECT_INFO_INIT;
> -
>  		oi.typep = &type;
> +

Isn't this change about spacing around oi's decl and the first
statement in the block strictly worsening the code?  At least it is
an unrelated change.

>  		if (packed_object_info(the_repository, p, ofs, &oi) < 0) {
>  			die(_("could not get type of object %s in pack %s"),
>  			    oid_to_hex(oid), p->pack_name);
>  		} else if (type == OBJ_COMMIT) {
> +			struct rev_info *revs = _data;
>  			/*
>  			 * commits in included packs are used as starting points for the
>  			 * subsequent revision walk
