Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36761185939
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731483388; cv=none; b=q3+dnc8VV8MuKGN9ihz4MyjqSsF9Qo+Dfxte4hEgSGndxtiJzf5zmvah2LlDjt7QW/TYHOuzz0svDlXWKOSjyAWSc7W+CqO8x1yCQrhqeisLPmsAfyT64PIgROhacDwUdI5Qv2vVt6K3OZ/fkIj8Uc99+ADzOuBrEVf/H+kmBGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731483388; c=relaxed/simple;
	bh=7YKu4oQk1BhbJvPgBroj0wPvIUFccPe4ZTgWlTMN4G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bP0cjMAQFkNYK215Xwp21XuHF0sasP04SxjEG2GvQCiMd1WYM3ZH1SAyVYsEE5ImAy4U5ILygXDuOLBpLkdhVCg28cb4dlU36hgWPwXrbUETTCehfDg8gDMtqBiNUsp67mJ2VgrTArpb0/9D412Ahe9KHhixpwdhHBwQGyeDMtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SO65c1Bd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MAmsbmXQ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SO65c1Bd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MAmsbmXQ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5358E11401B7;
	Wed, 13 Nov 2024 02:36:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 13 Nov 2024 02:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731483386; x=1731569786; bh=94CPBaTTVQ
	4+DToSv0bDuDsbAASJSp/jlvNqxEg7OhE=; b=SO65c1BdHuLdZcvZ/PU5oRY7/n
	myaAZWILr51AwVpnwgGMpxB2e8j6O6TDzsgSudTVY7TyyN7SzRyHmorNb4yrhhpP
	pUoj48F/1suViu2T8FvBMLzG/zVUXZYohl1x13AdO2ZjbUy+rxUHRcIlzmS2bgJa
	iNiaFk+nRjop8ihM4hVg0cfUssoI17EpbRVvYTJpcVtuWQwu8TvWRax6uMYaNuHh
	j7XYZprpQUsUnep4GIeUM08sGTeVaXR/g7F57WKPd6aD9K8RB2vRgOV7radmXF1m
	xi4SK8632q81eHyozhSsbVG7hCxmimCOXqLkpKtjevBfXRQ9cTbQ6H+zOfZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731483386; x=1731569786; bh=94CPBaTTVQ4+DToSv0bDuDsbAASJSp/jlvN
	qxEg7OhE=; b=MAmsbmXQ7kai92XwF+bTukU/aaf6qVAL1w+1QnXC21d1NIXY5FO
	fdgEJ3tA3Ye+QRstLpwBz2L6aMxUpi9tVlOSTRHw2IrdOFkHVYKzmGwAxn47KEh2
	I4G4wOIz/NIkbxqkz4dwhX3Z6ub5crGWMzBrwozoKsWJQUb6yxgxz5O7nHVEn+9v
	7qSS6K2qGdInsuGBk6/4oLK+a9rs9xi5mFPDwhF7IqlAT27lu6OtEwMDtvguWRJ0
	g2TW9rJbPTTEHkPo/L8ZskDgFjsv/1ljqr0Du6jzqIA5mPrEhNIVYXkSK0sb4YNH
	rfYPf9sMrBfxpFxjOOSZ8T1E8dBLBfyaztg==
X-ME-Sender: <xms:-lY0Z2M6NtxcoXSbIQEYCLEs_adyA7X1VEfxIEOMDUAzgc0APsd6mQ>
    <xme:-lY0Z0_qxXAIe_KV2To5Ubbrjux3rhJuv9_Jlq29regJwYUBfOrwTtoFtZEveQYiL
    -0kfdYO4yFORWYU6Q>
X-ME-Received: <xmr:-lY0Z9QV_E4IHdPE-SQewiXJHtu_G89bOSWvNfDy5wG6ea-y8wPCIYXKtsSWxsoxJG2EeDAcy05-v123qkpwYKJ1MwyyBZuudMCN-kFqflXK8eI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudelgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:-lY0Z2svRVmcqA1GQcSvykxjh3ge_zF4rZjFHwFxUc1PVTuhSe1-KA>
    <xmx:-lY0Z-cW9-db-OK2exVnwoO5qSbNhqyjmNsaxf9PIpOpI_Zd6J2aKQ>
    <xmx:-lY0Z63morIF4nMyDB78RmT5YJ0w4nU96KsFmKCq0HZyHKJpH-tRKA>
    <xmx:-lY0Zy83tYp2MYOJ6xiQj2Jm9Lvvm4uGv7uHXPZE43ZQKUN5IhZQoQ>
    <xmx:-lY0Z97cXu64msn1B5u9DvEyl2rr1cH3_WP2_2NynoViqUahr_Lz2A0n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 02:36:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 943d1cf4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 Nov 2024 07:35:47 +0000 (UTC)
Date: Wed, 13 Nov 2024 08:36:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 9/9] ref: add symlink ref content check for files
 backend
Message-ID: <ZzRW8M39-hw1E9-h@pks.im>
References: <ZzCiCGxL4Adnd_eq@ArchLinux>
 <ZzCis8E49O10O1zr@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzCis8E49O10O1zr@ArchLinux>

On Sun, Nov 10, 2024 at 08:10:27PM +0800, shejialuo wrote:
> @@ -3572,8 +3579,30 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
>  
>  	report.path = target_name;
>  
> -	if (S_ISLNK(iter->st.st_mode))
> +	if (S_ISLNK(iter->st.st_mode)) {
> +		const char* relative_referent_path = NULL;

Nit: the asterisk should stick with the variable name.

> +		ret = fsck_report_ref(o, &report,
> +				      FSCK_MSG_SYMLINK_REF,
> +				      "use deprecated symbolic link for symref");
> +
> +		strbuf_add_absolute_path(&abs_gitdir, ref_store->gitdir);
> +		strbuf_normalize_path(&abs_gitdir);
> +		if (!is_dir_sep(abs_gitdir.buf[abs_gitdir.len - 1]))
> +			strbuf_addch(&abs_gitdir, '/');
> +
> +		strbuf_add_real_path(&ref_content, iter->path.buf);
> +		skip_prefix(ref_content.buf, abs_gitdir.buf,
> +			    &relative_referent_path);
> +
> +		if (relative_referent_path)
> +			strbuf_addstr(&referent, relative_referent_path);
> +		else
> +			strbuf_addbuf(&referent, &ref_content);
> +
> +		ret |= files_fsck_symref_target(o, &report, &referent, 1);
>  		goto cleanup;
> +	}

I wonder whether this logic works as expected with per-worktree symbolic
refs which are a symlink. On the other hand I wonder whether those work
as expected in the first place. Probably not. *shrug*

In any case, it would be nice to have a test for this.

Patrick
