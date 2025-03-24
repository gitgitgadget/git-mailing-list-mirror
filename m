Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20C25C6FE
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821701; cv=none; b=X0XQrDhf8sI2/qm83sfxSYGgOUrs3h460RoNFRVZIFRKn1zAhNz4wM16dtJUatnFiLANCri2B7dNrFDlltkPwfiBWWJKlcyeQGshcNbNttKqQfldrKxzWCfXCo7KwWl6EwaSdbqnXtkv5SBXU9ZJP2xJazBN1GAFwABxE/MZoR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821701; c=relaxed/simple;
	bh=wNJTIoO7PKH8GaQbv48ZQPA7mr4I3+buoRmgN4WJPm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTwrpfMBHv7zkY8Yu5RiE/IY+FypRA8wqu51xIrvlRcwWth30yGOvf01d70o3N8WNv5XH5ci4kehe/cW2bX+ycsZddLnDrq0hh+vbwnN44+m1m+P2FtnPOMMaMJGm/3t4uxdY43NIMITsdw3mL3K2ArrJPQQSmMnUPCnWSP4nsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AGgNWCou; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v19CH7EP; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AGgNWCou";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v19CH7EP"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 553782540187;
	Mon, 24 Mar 2025 09:08:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 24 Mar 2025 09:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1742821698; x=1742908098; bh=YG7r0N7UZ5
	Fd/Z/Xd+c5V/pHUHBSuwC8cF8m0pBmqbo=; b=AGgNWCouDGQDpC4HP7DMZll8xZ
	MBxszDFeXlklwDCRMq3aFPMKUhHsixtdjz6UjxDyhVyjax0ud/+yQbEcfw87Bsu9
	7niO9gmnHAT67EoEB/zDNFiya2HTDh19dhTUkVY8k2UI4aM6qI1fSsXRDg9T/itv
	SH0T32Dvbu7wIILxHtgybl9Ls2P7xIRW8ytgX2jr+ke07ParXEMyg6qRK1v19QCc
	N7CQRzGC75j6Np5ScTghMlKA6eni/TOvdBHtvbCr3nWKtcfgaw5WATumpm6w3h8u
	FSgFrvnal3dVqlw1cvL+QO0/QPzAqyJ2idekoiMj5M5fpzTLuHE3Pnh8hQ3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742821698; x=1742908098; bh=YG7r0N7UZ5Fd/Z/Xd+c5V/pHUHBSuwC8cF8
	m0pBmqbo=; b=v19CH7EPrgg3a+sWXAaLGuNsCOimknbWDGmgUh0iGk4ivXPzWLc
	jToPq5PvpPjb98EjXCnJ4oZfaGSNyBmzkQk/8MMIXE8PIX7f9c9jZSogDBrWeYUN
	mV1CCDuA5CVwr9vtsQjp94hSEqLmI4pxikvJzPJoR+I+g30jDHvpLQPRJWM+mlXE
	AVQwKe012R6reJQcpA8slX5xTTu7ejEYZxnLdEaoblBfOL6Weq/pE/43Ss+ZnDZF
	B0mz+gWeg0XkFjrS6AVh/ZUSPKd3vOVLCDTrUvkkXpmg6Zz/h5M1T+dGNxYTrrKz
	1Vnx/LqnfVR4awiPIwAnVr9nFId0X82JTrg==
X-ME-Sender: <xms:QlnhZ83TugLnevR8ecTldwTFE4IiyBeuiNOQwNVHISwsE-6jpWX30w>
    <xme:QlnhZ3F4yFIjylE5Ui-BQLP0uhKoXUjRrnmPcuwT9eD8USD0sPATGxxcjtqK_54vM
    FaVCgtHjjpsKcmO6w>
X-ME-Received: <xmr:QlnhZ04mHVkKkTyT1sp5qm9_DYrW0sRv1UnE7AZaYpHLJ-Pf091ImbSiu_FgE7V7fOpzaV--0XnnIadrUyCSxmWrPZqVLitWymy_ulGqtIpwyis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QlnhZ13Pnlqu-XZfJyofWldAUt4lN8SmNYHSdQys1F5HkaCyjsagaQ>
    <xmx:QlnhZ_Gc60-3av5LwALw8W1x5Hp6MNDmJxI6wGcfF5WGhxVi1uzTNw>
    <xmx:QlnhZ-_0ZOO4RPWYGyM37B543Ni38Pgjcwy3li7DjbC7CaK8eI95ZA>
    <xmx:QlnhZ0mV_AaElY3ZkZoPsqX_ezfenI3PNR3B_4ov9Jxm75-LmWHmxQ>
    <xmx:QlnhZzgkxgaTpnOIR9jie0pM3VdaAuDXIupM3A3WSMX2ZIhjS-0DZasq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 09:08:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7a9024f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Mar 2025 13:08:14 +0000 (UTC)
Date: Mon, 24 Mar 2025 14:08:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v4 7/8] refs: support rejection in batch updates during
 F/D checks
Message-ID: <Z-FZObjvIN-qzvlj@pks.im>
References: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
 <20250320-245-partially-atomic-ref-updates-v4-7-3dcc1b311dc9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320-245-partially-atomic-ref-updates-v4-7-3dcc1b311dc9@gmail.com>

On Thu, Mar 20, 2025 at 12:44:02PM +0100, Karthik Nayak wrote:
> diff --git a/refs.c b/refs.c
> index b34ec198f5..f719046f47 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2540,6 +2540,7 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
>  					  const struct string_list *refnames,
>  					  const struct string_list *extras,
>  					  const struct string_list *skip,
> +					  struct ref_transaction *transaction,
>  					  unsigned int initial_transaction,
>  					  struct strbuf *err)
>  {
> @@ -2599,12 +2601,26 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
>  			if (!initial_transaction &&
>  			    !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
>  					       &type, &ignore_errno)) {
> +				if (transaction && ref_transaction_maybe_set_rejected(
> +					    transaction, *update_idx,
> +					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
> +					strset_remove(&dirnames, dirname.buf);
> +					continue;
> +				}
> +

Okay. We have to remove the dirname from `dirnames` again so that the
next reference that creates a reference in the same directory would also
be marked as conflicting. It does have the consequence that we now have
to read the dirname N times again, where N is the number of refs that
are created below that directory.

We could probably improve this by using another map that contains the
conflicting names, right?

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index be758ffff5..1d50d4013c 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -864,7 +868,9 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>  		 * make sure there is no existing packed ref that conflicts
>  		 * with refname. This check is deferred so that we can batch it.
>  		 */
> -		string_list_append(refnames_to_check, refname);
> +		item = string_list_append(refnames_to_check, refname);
> +		item->util = xmalloc(sizeof(update_idx));
> +		memcpy(item->util, &update_idx, sizeof(update_idx));
>  	}
>  
>  	ret = 0;

Hm, so we have to allocate the `util` field now to store the update
index, which is a bit unfortunate because all of this is part of the hot
loop. We cannot store a direct pointer though because the array of
updates may be reallocated, which would invalidate any pointers pointing
into the array.

I was wondering whether we could abuse an `uintptr_t` and use it to
store the update index as a pointer. It does feel somewhat dirty though.

Patrick
