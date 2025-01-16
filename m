Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A5C1DE4C8
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737033874; cv=none; b=LWEmIGygpfHZ9ymLpxAMykMNgywJW1BE4mpUpp8oK33XnmVZNNJiZRO5KmvlfscTiBfxN0gLgpgvUlprTIgJE6kX/HBZstg9gehv27DfOg0X2W3AV4BjgcVRhFw/2nsLxcwD3u6RNwp+a1oAOCnm+N0mBIkUuQQog0r3YzdPkGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737033874; c=relaxed/simple;
	bh=tOBlvklpkowfDbooA+5pPdljieIwFw9kftPkUJ+gO7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNHGfCQm0MP8Dv3yrogtlktCAanjGMBk+zEvcYjYeAPltw7XS8fNrZjHXRvCgQPQq57WqUYro18BLijphjW56JZAs/U5Y2mqAScBKCLU4pyicwqDeHwxudyx96mHAo+9riZeroFWszL1o742yTH+6teRWzzzmIsD4fiLuBlHfBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qdl2bygm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aRcqrPn2; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qdl2bygm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aRcqrPn2"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C506025401CE;
	Thu, 16 Jan 2025 08:24:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 16 Jan 2025 08:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737033871; x=1737120271; bh=HsLuYfbVF8
	L1zGK5LHfRg14WWZVJxqJ73pBdppWQYPk=; b=qdl2bygm6up/Uk25S7X39ZgYJG
	mR6p4i0eeprXnoX9fIx0GX63DRUWP/y8o5+gQob8PqIGkyz6uP8ItaEfPMNI8I07
	e1osuApILaTaPrBNxuTsdRUOkUsVQ6L8KQ2zHnhOBmSeWS1zDjL/Z9/Qq+J53p9G
	kFJXfZNTNQACshvDEwg0oNiVSDaDNFWFpNLqyuc511rjEXeZIxuopnR8LdGulcPq
	quzCmp7v+8et0IHD6y/RR3y8h1eb+e0pofvcmOhJXgIwH0hiIS1i8ERcCgr8BNH5
	zY08bKGPwH517AADXYg/kfTvUg6+KcqyPzE6/+d8atYC5IlD5WMcXBq1pCRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737033871; x=1737120271; bh=HsLuYfbVF8L1zGK5LHfRg14WWZVJxqJ73pB
	dppWQYPk=; b=aRcqrPn21Gkz2hB/pIwC705NKQwyBrnKOJKjCkgWEQmiKeqYIuF
	WusOLLTvUtzTCono6QsqAlWXe7eYpmSelDZMNvo3nqSLuVY/m/ywyYO1oMCVuTZ6
	wqUamKtbABkbjIriwzwcQR4dlOS+tB2ABVAKgHSoyXmNbSYH2V2manfpA0B1ga5R
	Su31AvL5/JKxKgQVkcoddnn2lZsiEB7LW1Unc2M3AaUfdubWZ239+EYiEAiGhf2q
	KdXO8qxUO13WL9o9vV9ha/gSzCPoC15bI7yozv/KjWsUvss86lRPKTKgG0W+FBPo
	UV6lrXgqAjJtjkVeNrqKabN7Z0lsdpyyrDQ==
X-ME-Sender: <xms:jwiJZ906IZxXQkPHCZNo8zYLqhdA3O0_THljZTlM-bxi2KBsVWqFJw>
    <xme:jwiJZ0G6uoadioA9p9gykMeDdwr49R0W4Ph_zBaqeP7llxatvjQIdfE_U1QTJViVg
    veszImKqrXlQZM2ew>
X-ME-Received: <xmr:jwiJZ94LJCqI8qjmM1_tGQ2uJEgF0F9zQ9QF5PLZtOutkpEaS3IHKp2WN0Yz6LSfr7AgVKM--1nZfCY-TqMfe1suV3omZ0wcjTZU9QTlHHWpC0qc3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jwiJZ63tjQ2eFrCTu3gBpLXgijSxiFTK0DviTZco4aGxP9uuJjCIbQ>
    <xmx:jwiJZwFlt6YSh1RlnzQvDnbBIoKcFncFrREmJRALScMmGBadxk8WeQ>
    <xmx:jwiJZ7-DpzzakaqEtGVG7cZFGLKcvO1lFMRcXfvVEieUyC4HLvARQg>
    <xmx:jwiJZ9lDYtwAJqpsqSQU1B3QnHwjn4BLZcjlW6DRInEuih6LkE2Kzw>
    <xmx:jwiJZ1SxT1qS2M7hZ4VA_HfG8ahVR60o-SmBWXXJX8vkI-6LznJG_0EA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 08:24:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aea4412a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 13:24:29 +0000 (UTC)
Date: Thu, 16 Jan 2025 14:24:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] pack-write: pass hash_algo to `write_idx_file()`
Message-ID: <Z4kIg8ihbgPPb3C_@pks.im>
References: <20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com>
 <20250116-kn-the-repo-cleanup-v1-3-a2f4c8e1c4c3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116-kn-the-repo-cleanup-v1-3-a2f4c8e1c4c3@gmail.com>

On Thu, Jan 16, 2025 at 12:35:15PM +0100, Karthik Nayak via B4 Relay wrote:
> @@ -546,7 +547,8 @@ void rename_tmp_packfile_idx(struct strbuf *name_buffer,
>  	rename_tmp_packfile(name_buffer, *idx_tmp_name, "idx");
>  }
>  
> -void stage_tmp_packfiles(struct strbuf *name_buffer,
> +void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
> +			 struct strbuf *name_buffer,
>  			 const char *pack_tmp_name,
>  			 struct pack_idx_entry **written_list,
>  			 uint32_t nr_written,

This change was somewhat unexpected to me as it wasn't mentioned, so it
makes you wonder why it's different than `wried_idx_file()`.

Patrick
