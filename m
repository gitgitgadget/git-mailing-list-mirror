Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D6D70816
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737730017; cv=none; b=FLba7AvUWCEBmDKggk+JazbYFw9VK2D87/frqODOARH/ymSDBMyLAZjE6Kok8U5qtMp3k4nFM7H7B3Pl2eAdPlDzECzTfwJVsavRHtWqDTviGg4oj6Gr3ZzunaTMfz5O1DXQThurMZS5CO/DQTDUO+LHoWnMGYkVc5mWo1V6OfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737730017; c=relaxed/simple;
	bh=d9Eau0PZo9JqNw2s31BUz1IE6cMM56sc4Za99c6a1+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcjeG9bBtqWvDAvjBWfcyozAywSJP140yzkVV6zd0ZUx0SApc0QZ6Dgay3kXmH1uKH3ubRkig26h7Ry/fVk59hZGqcUbVHm/VRd61QWD5LrBZTIGciywHBo6VKxquj97kKD2w4arTHlVKDILXDgbZWFCVGy6XTMI42by2c0enYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B4iCBeFT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PE5DNTDu; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B4iCBeFT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PE5DNTDu"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5901C1140142;
	Fri, 24 Jan 2025 09:46:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 24 Jan 2025 09:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737730013; x=1737816413; bh=u6DqZq7DO3
	3GbuNbhVK2BcPpmrOLHy8cf5RbsRAA82w=; b=B4iCBeFTC2ogrxYoGXvw3dyJ4J
	ojWYIyZnbbFXkM43rgwqGr/laybgtXmuLapRtqnUVhO8ru5CGN58z9Vd2RJ4xvHa
	WrBxa2FIkdj3TCgbvrnDAcXUidhg6vPjfnGF8dRctwIMrGnK6LXYIhRtdqHd2HEZ
	js1h2jLv2my2NOD2zGtK5eV9rZg3x8c5YYcRuNnQMaCNhdHx9zxdglhbyuNN9Gmi
	Db5KDMQencaaZK4U1EtdRVS5DvpoNxGVSDzmOblmWEBfiTN9kggeYWYOkp7AvAEx
	b6zTYc41ksy55/REk2Jiww9b2r8RWMWq4pnVv+zeGvLMN8MN/1uXCJkd+jAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737730013; x=1737816413; bh=u6DqZq7DO33GbuNbhVK2BcPpmrOLHy8cf5R
	bsRAA82w=; b=PE5DNTDuuE3g8HCLQSLbz+HfUhdApqMxUzm+uGnmhKlTaDxnIfg
	M76SAby9XAu5JuJHiVnKRAR/tqBzb9kUDdb3dPq1RvH51JkaFfTGeJ+H7XakpiNh
	OxCzIpCVhL4cRjqOtjT2dFIrr8pG32RLK1uqPXYRt7/OPGk0h8dMPmUSPiKva0NA
	UNaNx9Y2eYsX/Z6XFeLqWcPuvHDurYuCkb4UWBea3oOL1ljq9c/mLBLkMRSBuIl4
	Z9o/JuxNqsWJJq+q3V26Y49TiA0WxG/wDy/llRsmToM0a4gMqhnCCmlXaRweFlTQ
	kcKMvhQ84O7RlBXuublY7eE25di7UB91cZA==
X-ME-Sender: <xms:3KeTZ91hXgnhzowUheUHKVsraYaUA8SIiPe7BStle1X86Ob3OcS0MA>
    <xme:3KeTZ0FVzu5zbw_7wdQ1RVqivztLpFvDOPjBpk2UCzVrNos3XzU-JeH98_w1G0b6c
    IxdM328dJfgLRNCPQ>
X-ME-Received: <xmr:3KeTZ94Kv_uCJyYInuMC3-Y5G63m2H38BxdAGoniqL4Gc9Zi4F3B9dTVTyuAn554U07rpiMA566TfzQwIDwEubrslntiXp8NfbpITTcgsnMtIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedggeejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
    pdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvg
    htpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3KeTZ62ApqHJ1JmEwPaSyY2XfzWGKIEkpRj6Hmd3XnmVjVq9fpMhvQ>
    <xmx:3KeTZwH8P02Fu2Doqc8y5mk7435aqh_vPms6YsAV3BmupPb_gi8LpA>
    <xmx:3KeTZ7_OeRDFSQaYCMVpcFjCiRzuVdMafslIIx_NS4dKTv1Gk32A_g>
    <xmx:3KeTZ9kyTiBEqNuBqhkFe1WZqdM1qwJ5JLpSJBlpsNfqKZvcFaHYiA>
    <xmx:3aeTZ1Oi2jDwOuut0PMZzpsyY-LOHL__ZkjN0WERRG8iR-AvxGBFf3Tv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 09:46:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c7239566 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 Jan 2025 14:46:48 +0000 (UTC)
Date: Fri, 24 Jan 2025 15:46:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de, git@vger.kernel.org,
	sandals@crustytoothpaste.net
Subject: Re: [PATCH v3] refs: fix uninitialized memory access of `max_index`
Message-ID: <Z5On1waE-2uwIjS2@pks.im>
References: <xmqq5xm5s80e.fsf@gitster.g>
 <20250124140203.886324-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124140203.886324-1-karthik.188@gmail.com>

On Fri, Jan 24, 2025 at 03:02:03PM +0100, Karthik Nayak wrote:
> When migrating reflogs between reference backends, maintaining the
> original order of the reflog entries is crucial. To achieve this, an
> `index` field is stored within the `ref_update` struct.
> 
> In the reftable backend, before writing any references, the writer must
> be configured with the minimum and maximum update index values. The
> `max_update_index` is derived from the maximum `ref_update.index` value
> in a transaction . The commit bc67b4ab5f (reftable: write correct
> max_update_index to header, 2025-01-15) addressed this by propagating the
> `max_update_index` value from the transaction to
> `write_transaction_table_arg` and, ultimately, to
> `reftable_writer_set_limits()`, which sets the min and max index for the
> reftable writer.
> 
> However, that commit introduced an issue:
> 
>   - In `reftable_transaction_data`, which contains an array of
>   `write_transaction_table_arg`, only the first element was assigned the
>   `max_index` value.
> 
> As a result, any elements beyond the first in the array contained
> uninitialized `max_index`. The writer contains multiple elements of
> `write_transaction_table_arg` to correspond to different worktrees being
> written. This uninitialized value was later used to set the
> `max_update_index` for the writer, potentially causing overflow or
> undefined behavior.

It reads a bit funny as a bulleted list with a single item, only. A
suggestion for the above:

    However, we only set the update index for the first
    `write_transaction_table_arg`, even though there can be multiple
    such arguments. This is the case when we write to multiple stacks in
    a single transaction, e.g. when updating references in two different
    worktrees at once. And, if so, we wouldn't have initialized the
    update index for any but the first such argument. This uninitialized
    value was later used to set the `max_update_index` for the writer,
    potentially causing undefined behaviour.

Other than that this is nicely described, and the fix looks reasonable,
too.

Patrick
