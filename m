Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6751C3F34
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640065; cv=none; b=LjHDepwbakOnCuDlrcnrsLA20CtKNpRGjWOrhYSeHKJyVha5ScXLC6o6rQEhrgQVunrACiiztjP2SjVgM639Luf7YSvzgcZei1MVKiQ8frMWjAT3OnFU0zn7mOql8dzQXvvfBtvDxlLcpalBfoSUQUavX34A3HEpAQWZeV96pvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640065; c=relaxed/simple;
	bh=QYEla9ThpgkrWg4hNmeV9TZmgVvEU3Ai4KCxq0oAHlA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cgDsRQv+lLThTQh6Vj/tS13b1fqIQJwlVW13WVX+zHi/Qj/dvwq75wlsyUuUn0gxRMngRT3p7Cw/hCJU128rGmxHLTBx/W7mUc8NYOazVa2fCo54ReekTodXk8LQOvmH5L6qoFbEyiKfJDz4IP3j24J1b6zS5SXaKWkXnvRYW+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VoNLr05Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yVKlH61D; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VoNLr05Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yVKlH61D"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 5406911401C2;
	Mon, 10 Mar 2025 16:54:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 10 Mar 2025 16:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741640062; x=1741726462; bh=QdDFFA9QC6
	BhmbhCg9oPZ67QOVNfLS890nsBF8opA8I=; b=VoNLr05ZW4Qkd+jiYUxm1VQQei
	xZlL/0G4cimI1Lg+Uw5StjnWjZ7b29jdOta1c9K9IBYGKSptLDsDrjV2IakEMEQ3
	eVqEQfk+q5trA+fGJy1XHLPRgGcKA0CX4TOgZ3VPbSSvLH8USbbzifqyBruZJ75Y
	mjt4jqFJ7Cj2OQASlTL38KRLtzxnyWBi2Rc/o4BITr46T+7a2Lt0tGmSDZ6tJdXr
	hd5wfKnES4Q9eaXT5JjRQefFopUP8vKLbnCDs9eP9Hp39OoP6h+BlM6uQ4d+nYgm
	YyJr2mF8NQMaOgyAa6Lo/LbS90hFtzo2KKaiv1Ovb4zJ17Usuc9RSwXFE47g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741640062; x=1741726462; bh=QdDFFA9QC6BhmbhCg9oPZ67QOVNfLS890ns
	BF8opA8I=; b=yVKlH61DYR+lwF5XRnRxqsc5mD08YQ91iUsjHOeUmZD5Fk5VpWH
	Wu9pq80Au+TGj0odWwTrWV9XVIdFOj13ihbySJQvNSe48PSv5OgKHYNshNQFO+4E
	kZqjsvcAXrB4c8KSYHNwIz1sQigpbtNMoPo9er5pGzsYityhIqTQ3PRQulxUYHoq
	7zOvyxTm8RX2erQX7+5TBWOmuxc/nYFVp72rmW0f7tAE0jzIBRpTdVOKQ7xIsmZO
	fnjuIYKkmI03fpXBLICK6aogIK5fwT53DHmeE0dPIp9Nhaq30HCekhQOu06bRoSi
	lfXEtdDaVsbSZubRtae9izMO6jV2PVEooEQ==
X-ME-Sender: <xms:fVHPZx5ra4tSs4arU5aIiNplK4ACgG0tX2qyCDvaCpRDX8PUQV7fzQ>
    <xme:fVHPZ-6rl-o6U1tzehcU8OVhSDbWbCBVHKawUtckmKeEAJ8phST2QOMUaNwlYPtcW
    2Ufo_qLm2yupRN23Q>
X-ME-Received: <xmr:fVHPZ4dg1AEEsjoENCgKBw6sAwG2uHiWrZHwiSK99Y4QORdlnCIEHz3wu9fA6RiavjA3git9P1DByLbo7gCjvmM3025Qa0HOX3Db>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:flHPZ6LPfem_MOSpcII8T2TQGRnbOv7nhxb3HFCtoOvPHdojpN2KYA>
    <xmx:flHPZ1K4uJQ4kG-iYcSo9I_5rJsyg46H96i0TIUIyJsw1b7RLDnyUQ>
    <xmx:flHPZzzDvtDovdHgzqP-X2ILCiYN-DOcUGHHAn_rSJTu6zhKIVzueQ>
    <xmx:flHPZxKajrpoQbp0BcP9Am4YCzdGAtkAyS275DDx0b1NKPysNyL_aQ>
    <xmx:flHPZzjPz74q4Us52brXY04pnrSn9P2kv_hYCHn0axxqlkbAVgGlDP7o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 16:54:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  christian.couder@gmail.com
Subject: Re: [PATCH 2/4] rev-list: refactor early option parsing
In-Reply-To: <20250310192829.661692-3-jltobler@gmail.com> (Justin Tobler's
	message of "Mon, 10 Mar 2025 14:28:27 -0500")
References: <20250310192829.661692-1-jltobler@gmail.com>
	<20250310192829.661692-3-jltobler@gmail.com>
Date: Mon, 10 Mar 2025 13:54:20 -0700
Message-ID: <xmqqr03461z7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> @@ -639,19 +640,15 @@ int cmd_rev_list(int argc,
>  		if (!strcmp(arg, "--exclude-promisor-objects")) {
>  			fetch_if_missing = 0;
>  			revs.exclude_promisor_objects = 1;
> -			break;
> -		}
> -	}
> -	for (i = 1; i < argc; i++) {
> -		const char *arg = argv[i];
> -		if (skip_prefix(arg, "--missing=", &arg)) {
> -			if (revs.exclude_promisor_objects)
> -				die(_("options '%s' and '%s' cannot be used together"), "--exclude-promisor-objects", "--missing");
> -			if (parse_missing_action_value(arg))
> -				break;
> +		} else if (skip_prefix(arg, "--missing=", &arg)) {
> +			parse_missing_action_value(arg);
>  		}
>  	}

There is a huge NEEDSWORK comment that essentially says that the
above two loops that this patch combines into one is fundamentally
broken.  I suspect that the remaining two patches in this series
would punt and not improve them, but offhand I am not sure if this
change is making it harder to fix them properly easier or harder.
