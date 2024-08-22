Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147D2282EA
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316517; cv=none; b=iYtbXMqtvlvGnbT456ePWAqWXIDLa5tP44AcFGbibFKtap0qbi09vYEdcRzPXn1J9ja3hami3d0W29qA/tDA/uqpCNWVHOzDVMPGeH99V3FK0VCSmaX2p81bS554kCYBaTSd/rqKJ/XO+HtqeliS16GdclBHtu43E7EeKVqoobA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316517; c=relaxed/simple;
	bh=k7l6N540iL74DrU6ga+/8HfkLqn37hCzDztAksZWHQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+dEt0gcVMSpG1vNVSYgxJOKYQaPENXJl9jrpVkB1mels0k7h5CYqLgbSKqkC8tPeQzQM66ZEREx6KeTt4XEex4PtQjmAxHLpOdJH6jitUwM0u6muSN7c627z2H80vPcMzqO0LImEF0kcgP+6NcCmNygpds78el+wqJbf7iNLYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WWP/uhU4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eugkD18L; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WWP/uhU4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eugkD18L"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1AA1B1151A93;
	Thu, 22 Aug 2024 04:48:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 22 Aug 2024 04:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724316515; x=1724402915; bh=8C6HYySz7v
	6EZ2a9DcWjSoFYsKQ1OSmpKyH2C/KmP+0=; b=WWP/uhU4c4JC+B7t3DyU8W74RD
	9VljPs5jCtU6ZBW5Q2Ao1B/+NbPrXgjpmjO7Ey766Eapb+kpjnhwVtKBLyhxej8x
	cET3h5RFLfL03l7WK1bB2cDy6MOuHs+pLtBt3/A7/+ynu/pXxyFzGvocSE5UbWp7
	rNtktb1kRcZ0AxSpZQsxErXxgCIzdhWplOVRFpuz3DkGc+0ip5+WhAYaCXtjbit1
	wtoIAuk1EaGiEca+6QyRoGXLNffro+EPTY09KaxCq2eWyxq/Xp94Xai/tblf++aM
	3cyycwKsVaRXj0EQX2UoPXH3ln71zzZdj1a3udf+MCk7isc+NmpfR9vnnojA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724316515; x=1724402915; bh=8C6HYySz7v6EZ2a9DcWjSoFYsKQ1
	OSmpKyH2C/KmP+0=; b=eugkD18LmAmjs5xLhAJ5Eo6ZsrTByzMm/8G0/hR+mgVv
	M9NL0cNb8X0zC4u916bPyGOBMxYeBhAc1kntKtY5UsLlAKFfRl1Fs3L1RriWjp7H
	A4haG1r8ET5iP99jTb4N8xET1bp2/9FKxl+15k2faOE7xyIf9CJNRtq8/x9TNsSF
	6WInjkyTHpVL/1rNDjCFqWnPGHLrAMlTFOXQJDgWXqsCeaZE7B5Cz/TEjwnSYm1h
	hCUX0Nl8hGugv/mdqFqYE2mHx0x/hwgtqj10MknBDHpx8miIek8RERKEp3oVC3DN
	ccBpZZ9/eqYlmCC2a3SzxDJqSwjkz2QtN6oyTCDN/A==
X-ME-Sender: <xms:YvvGZgmI_-aFEioH3g_6--TsEZBvAm6T3_tpg4LSUMmiXUXBGTUwKQ>
    <xme:YvvGZv0dR22-YfVvDRAPzORkVmILMtwDMcQ4cgw93R335A7YqhqgupHo0Rq4lTKyy
    lPi6XuLx49qzr6ZxQ>
X-ME-Received: <xmr:YvvGZupq1W5M0zfst_U-AF1IdIv_GsKwkPdACbng4aT-U-633HfAMiXVchJXIe56y-NWqjVcEBY1VEKg_y1HV9LjGHsC_pTruHZPrusbq3wSuuI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Y_vGZsktiK8dBOaYw-EZh9MrVemTb80WHXbbwUQF0APo5XLboG-E3A>
    <xmx:Y_vGZu3YrdVWERQI6CCu2WoP3zhHy2vX8phWqUh4gwK5JVT2EqzqPQ>
    <xmx:Y_vGZjvnTC1m96tWmGsZssGgPyx8FZyns14AyDiXl7TzBVNrNMsKhw>
    <xmx:Y_vGZqUHfyiNzq1GaweGReM-U-dIXed-HcGk0H-U_3Dv-0eDDvot5w>
    <xmx:Y_vGZhQG6ggCZs6oPYPxLx5TZH1DAaunPnVFLVp45HT-FrP8FQUdJc5Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 04:48:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id df799be8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 08:47:58 +0000 (UTC)
Date: Thu, 22 Aug 2024 10:48:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 2/4] ref: add regular ref content check for files
 backend
Message-ID: <Zsb7XgX4Lt_4LX_P@tanuki>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
 <ZsIM2DRDbJsvNjAM@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsIM2DRDbJsvNjAM@ArchLinux>

On Sun, Aug 18, 2024 at 11:01:44PM +0800, shejialuo wrote:
> +static int files_fsck_refs_content(struct ref_store *ref_store,
> +				   struct fsck_options *o,
> +				   const char *refs_check_dir,
> +				   struct dir_iterator *iter)
> +{
> +	struct fsck_ref_report report = FSCK_REF_REPORT_DEFAULT;
> +	struct strbuf ref_content = STRBUF_INIT;
> +	struct strbuf referent = STRBUF_INIT;
> +	struct strbuf refname = STRBUF_INIT;
> +	const char *trailing = NULL;
> +	unsigned int type = 0;
> +	int failure_errno = 0;
> +	struct object_id oid;
> +	int ret = 0;
> +
> +	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
> +	report.path = refname.buf;
> +
> +	if (S_ISREG(iter->st.st_mode)) {

We can avoid having to indent the remainder of this function if we `goto
cleanup` here.

Patrick
