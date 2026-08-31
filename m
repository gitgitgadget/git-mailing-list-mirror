Received: from mta0.migadu.com (out-108.mta0.migadu.com [91.218.175.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEC553CA61
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189850; cv=none; b=NmQNiZ+wNAqrb23zqgwAjVFbgj7MGho1N6WTYYnFVcuw6HGsFAEx5914pMLSEsCxZMmD1vwmeQGHO3K1n+dLZyH3rC6gpwS0ZeIxAXbN7oV4lqO9sFOUTrjDxwK4uU7whRfyJMNAYdicNfKMmhQrHg8y5JEAeQkgjKqgwIggTZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189850; c=relaxed/simple;
	bh=c7EezXJRlioZuI2ttelh4Q7WvTv6zmVHlgo780YRebw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BHDOKd4ayCi/DafvB7DYDzfIouH2sgRY3uweczhHC2HHoTsBYnUv98I4fugR9+pPTCFfwuH3h2rVD34lcwvelC85vWcZiCnmP3Fv60xxeSlfHz3RG5Exn2EzVBA0dDwsSoQs/gc9y8yFiXeeBKX6BC9Rlp8pxFxa9PqYLBJdOpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=2dWRlCbJ; arc=none smtp.client-ip=91.218.175.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="2dWRlCbJ"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=c7EezXJRlioZuI2ttelh4Q7WvTv6zmVHlgo780YRebw=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788189844; v=1; x=1788794644;
 b=2dWRlCbJJo+C1yeZLKVCys2OG/8if7SQbHuRy1W79rFFJdkldUZCaJAObSKnGkm9O7sFZkW3
 rFsKJswbDEZj6Wp4qQMKO3IvFCOM0zOquDYe3B71blMtSaLE40OV9z6nuhadluE+pMX2cbX5agt
 vpcjAjDrcLNccvTAqz8CQWEM=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 2244aba515e45bda;
	Mon, 31 Aug 2026 15:24:04 +0000
X-Mizu-Trace-ID: 2244aba515e45bda
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2026, #12)
In-Reply-To: <xmqqy0dp24q1.fsf@gitster.g>
References: <xmqqy0dp24q1.fsf@gitster.g>
Date: Mon, 31 Aug 2026 17:23:58 +0200
Message-ID: <87wlt6wbxt.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> * tc/replay-linearize (2026-07-28) 3 commits
>  - replay: offer an option to linearize the commit topology
>  - replay: resolve the replay base outside pick_regular_commit()
>  - replay: add helper to put entry into replayed_commits
>
>  The 'git replay' command has been taught the '--linearize' option to
>  drop merge commits and linearize the replayed history, mimicking 'git
>  rebase --no-rebase-merges'.
>
>  Waiting for response for too long, stalled.
>  cf. <anYLeQj4Sx2vZqvy@denethor>
>  cf. <CABPp-BEFGku8msiJCcXburV+tcersr6uqEumKaPh-TguA1LjSg@mail.gmail.com>
>  source: <20260728-toon-git-replay-drop-merges-v8-0-ced11dffe749@iotcl.com>

Sorry it took me some longer because I was on leave. I've sent out v9
just now.

> * tc/last-modified-bloom (2026-08-07) 6 commits
>  - last-modified: keep per-path Bloom filters for wildcard pathspecs
>  - last-modified: check pathspec against Bloom filter first
>  - revision: add Bloom check that includes parent directories
>  - bloom: add helper to check if any key in a vector is present
>  - revision: expose check for paths maybe changed in Bloom filter
>  - revision: move bloom keyvec precondition into function
>
>  The 'git last-modified' command has been optimized by using Bloom
>  filters.  It now reuses revision walk filtering logic from 'git log'
>  to pre-filter commits, and maintains per-path Bloom filters even when
>  wildcard pathspecs are used.
>
>  Waiting for response.
>  cf. <xmqqtsp4a6c2.fsf@gitster.g>
>  source: <20260807-toon-speed-up-last-modified-v2-0-7d87bbdeaf9b@iotcl.com>

Rerolled v3.

-- 
Laters,
Toon
