Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78371426EB7
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 23:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531090; cv=none; b=ZLDoILUhbdghvslqr6neKOuI2k6bSy/BEHACUoyVUSFbdUitP/c4kGRt9mFxz/BAS+9AohAVFow019GYoKitWU/W+4hZBnapuM4ooa4XGyXzRx+/GSZvjM6OTRnWaIS7P+JgD7ebMz5/0owpqXespC/qDD+L0o2M2jGx4xMfsSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531090; c=relaxed/simple;
	bh=qR8q5I1qNoYhWEQb9+u9MpeWGX2vaz+TdP4bxuyhALk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lEk+mi7dG+YihWBruvNMjuHfs68sda4Z8QK5sTnb9FdF7xckTp5s/N1grwUc4VGq3+HVvv4cAjoSG4TMvUDb2h3B0nVmmNYj60fT93ezmRXN3iXJk0MsWyo7brpjn9MacgZ6hM9/IUy11uH234mUyT6lvhB4rXj+d2iV20bd+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=klL6nPW8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BU7O8cgo; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="klL6nPW8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BU7O8cgo"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AEAFF14000B8;
	Wed,  3 Jun 2026 19:58:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 03 Jun 2026 19:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780531088; x=1780617488; bh=aAPJexXTJQ
	BhWcgTbcP4qBeSRppBHEM4RsRY8du+odw=; b=klL6nPW81pSC4f6xilXyTWf9pK
	zCofRBv8/K1v9IPHwzW64p6w7p4HBWbpvwctZX5OJH0Apj2Q+U8iGtxwCNh9LKlT
	FVrPb4Oy/ZUjnwODhUmz2Ni+a7e6tdXjI8IpRxGY8WSNI4rD6dOh1+D+ZMKs7aY8
	w9oKz5iEzLueNpUa9OftLIs7sM6/EzMzK3Tjbz3T7ZuNOzd0sUta6YHZu+xbkBv5
	F/tGo3kG3q1zW70uRsJcwBF8LsmhrBTa5Oxjn4Yawa9/8Omz+Mj/X9HWlN/wEVvX
	se2YR+7GRtZzHd+LCK1yA75SrlOBQ2c8gm005vWlJq5CJi8s9anma4vv1FnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780531088; x=1780617488; bh=aAPJexXTJQBhWcgTbcP4qBeSRppBHEM4RsR
	Y8du+odw=; b=BU7O8cgoozOnHPfN011bNIVsM6B+SlEFlRAAJiQvRxvg8jhwmdL
	xRBurh2rcPpH/MbxeFKHO/azwDff2sh1vaOjZxd/6KYBGhPXPx6kE3aqiBZvmUGd
	teDr9UCqezJV4iqcfXe/nh5uA7oSEnVUY2VwinNcTuIInSFwqvy6S7mUYJxeXTim
	BqQC7/hAtdr3HJgIFWLk5TMRIrVcTuornC0YaIARemSFrJBBTRukHK2St0CS+4Gc
	ysIFtU6wwMW9R0XpZ2t9cQAp4UJwMWSD7oOHebrDNyomY3sygGKl+HWyKikQL8Jn
	UGgddzxp2T9RAZtsjTBZ3yPgIiIRS7um00w==
X-ME-Sender: <xms:kL8gaqyGb3oPgI0VkufyN3orcCrKjYxNWHmy22FDLtXcZHtK8CEgVw>
    <xme:kL8gatSfOQbypvVYQ6OGbKFH5M0Rv2nJaJlKpB4e3Wq1XaZBFNXMkzPtV9qTbaUwI
    ZavjlsyT1HI8JKM9-TkWqseYHD04sREXIeaNd35Ol5C3D1pvK9s9w>
X-ME-Received: <xmr:kL8gahWTewlMz8iPwzAqY8VUmJy0CHO43XFM3Wd4vA2aODEzusDHq5GY0eqILHZBMXp5TYKpBtezllli0WH4oNNVexmEorPvXaOE>
X-ME-Proxy-Cause: dmFkZTG3XbMQ/dMoymAjwTlWpb22rBj80ve5h1ZgNocJNjL9vTLH5Ufn5uOlHPhH46Fa++
    8UCTHVl4KBX7+e0YkzITc5zP9bmAz7O1FJdRa1lAeFO6NVa/uhQiC0al9SxLD6lDtYFBD3
    w9rlzUMPxUmXJYJkBZrxn5cKuQCvWhmSWPePSAz2uJl7hKzqVinInodgBgp9do0aDVcQGg
    AtwezUifclvLRWqrKjW5+CLMsN1qMFYZgex7Ohtl3QFOC5rHaftHe8/A69Fv6v8OOGnlN7
    OT6ijLHzXw6EXnxcQqCwDrsace8a0+QRpr+D25dhq96S5JX38DOabH2y5JalzjNtL/H1jO
    VqTVbiaMSXGGyG4bN/Umy8rsg2c6vQkatsTvYJ4FjN3Sn/iEj0sxLfdZkKVdL6pPVXPyJC
    6pjpwre9JkBLnGYdNcLIAkvjVZUtJrC4R5GgcwAncgpVrQT/qldZlljYXVwiN+fivwL2x4
    9bkJUeeZAND8QY9KUPRD9y7M6EKUw+3kn2jB5lTaGj3HyXYKkty5tEC9pCMzaWrJTHLIEe
    A1t+EoJdL+wcJMhJJ3AZpzPIqjctbVEkrcBUQ4J41LbZM6ETkAkExOMjNQT30ijhLZQyVz
    GPQpP9T4DumkyyjtDxrhlyjd8V0oH0yXyXI4QE7VKC3fHBtbjQwN5M0hqOdQ
X-ME-Proxy: <xmx:kL8gavaLPrZYKfCCzSWkvdwGNnl0Ir7oqSb2IYx1avyx3kKkBffstw>
    <xmx:kL8gan3RadKnHjPHBW9cQButIwWA8fKOzNT9PjlRZk5YNp0fudB2dw>
    <xmx:kL8gahjOFn2ywy2-f82-Uq9ZkLFO5E3C514FBvbjkrUqvCVu5ZeWPg>
    <xmx:kL8garZj6hVfBuelwW6lWvR1pOps_li_ZxSMt6IKoW_YZ7A297SgoQ>
    <xmx:kL8gakAJAsKkbxzBM-F_JE_Cv1SzD5a_82TN9IsO7xLi42MLFPnqlo9H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 19:58:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Pablo Sabater <pabloosabaterr@gmail.com>
Subject: Re: [PATCH v2 9/9] builtin/history: implement "drop" subcommand
In-Reply-To: <20260603-b4-pks-history-drop-v2-9-742cb5b5176d@pks.im> (Patrick
	Steinhardt's message of "Wed, 03 Jun 2026 18:14:08 +0200")
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
	<20260603-b4-pks-history-drop-v2-9-742cb5b5176d@pks.im>
Date: Thu, 04 Jun 2026 08:58:07 +0900
Message-ID: <xmqqmrxbqir4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +static int update_worktree(struct repository *repo,
> +			   const struct commit *old_head,
> +			   const struct commit *new_head,
> +			   bool dry_run)
> +{
> +	struct reset_head_opts opts = {
> +		.oid_from = &old_head->object.oid,
> +		.oid = &new_head->object.oid,
> +		.flags = RESET_HEAD_SKIP_REF_UPDATES,
> +	};
> +	if (dry_run)
> +		opts.flags |= RESET_HEAD_DRY_RUN;
> +	return reset_head(repo, &opts);
> +}
> + ...
> +	/*
> +	 * If HEAD will move as a result of the rewrite then we'll have to
> +	 * merge in the changes into the worktree and index. This merge can of
> +	 * course conflict, which will cause the whole operation to abort.
> +	 *
> +	 * If we had already updated the refs at that point then we'd have an
> +	 * inconsistent repository state. So we first perform a dry-run merge
> +	 * here before updating refs.
> +	 */
> +	if (!dry_run && !is_bare_repository()) {
> +		ret = find_head_tree_change(repo, &result, &old_head,
> +					    &new_head, &head_moves);
> +		if (ret < 0)
> +			goto out;
> +
> +		if (head_moves && update_worktree(repo, old_head, new_head, true) < 0) {
> +			ret = error(_("dropping this commit would "
> +				      "overwrite local changes; aborting"));
> +			goto out;
> +		}
> +	}

This block is skipped under --dry-run, but update_worktree is
equipped to (and indeed run unconditionally here) run in the dry-run
mode.  Does it mean that "git history drop --dry-run" that user runs
to see which refs may be updated will not get warned about possible
worktree conflicts that would prevent the real run from happening?
Unless there is a compelling reason not to, I think --dry-run should
be a close simulation of what would happen without it.

Thanks.
