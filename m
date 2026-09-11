Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FA736194D
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114433; cv=none; b=bcFybVP1UlSnlfXj9DeGlOXz9nF8GgQyK+0GGwigMzcrsgJjoiNqX2NGnDLLHHt5iHrHwnElTnA1mNzN0AeysMY+aAHmYiIjfWoDzswIYDSdKin/cBIZBfF6N8d9ApvvIl5ElYc6LcuCTP/W1OstefouTKIfb7jjLC6pjbX1guE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114433; c=relaxed/simple;
	bh=hyLxNoSA+Wx/JI5NkXMHLVZwLYWJM7fsiQ1y/qxFz40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ebf2E7frVB6XfEgXyVkkTjAaRJbUY2nfcnsuGG/u7C8xWt2NgWdXtTwcjBhojZ+KxuGeeC9+Eit9tZj8KuHs7cZepds6+Rls3MYt/Y9lxnR/Y9nKQmqnRBFTkCgsH28UBAFe6MwQMBi6AYrQKaWnvxg8Ke+GGR5rVbFW6WIGddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EBJmiR+O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jexQv21s; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EBJmiR+O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jexQv21s"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 516377A00DC;
	Fri, 11 Sep 2026 04:13:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 11 Sep 2026 04:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789114431; x=1789200831; bh=nMyuMD+Xse
	TQtZTcJntbUaIteVAl4x0wxMLlAPP6J/w=; b=EBJmiR+O9/ERfYuzYy/Q730qEa
	1lG9k1s8z7ohIAO67mzkNvAaHqNSiN4xKc/ziMAhNlJrn0pGn1+u9XDtXxiNJR6N
	//IUbqTLy7OtjnwWGWZHpHdpsTl+lha0c/bvqkQlVJlroiR+NZdql1++qeSlQ+PS
	g7fgFXz085SSituX+upVkpQKlLROYMLrenIl0ud7alzfT+Er98snPWQXYl8lwU1B
	1aCx9vyNzAmgSXv8uA6pzY8yvBALYh8kW/xkjSZimVUMvGvRyNsLaTm04J1aX8nv
	yCyykOE7x2lQDkMofY60C849Izslux4l19CdYvii5xipCeWN7beDYsrr0fbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789114431; x=1789200831; bh=nMyuMD+XseTQtZTcJntbUaIteVAl4x0wxML
	lAPP6J/w=; b=jexQv21sn5bZ8SNsgtLROqPgMndpmI0c+/4SSbY71IOujONtUVp
	SM7D+Qhzet09Fsr0nlMT3eyaAu3TqXWL+wSa3y99gcxb4efi9O4x+2F3RoXNtXRM
	TtVHJnAXlGok5RSNbizltVG+FX+f62sCpgnTCnyTD8vlLw/2CaICzY2IjuFOOqqH
	6Ic1U+1q08ARL6DecJ/KrYzqAjng6wwmEE/2KbDLp9Oy2yREs3tJWG4DUOSUb2TH
	JsV/AtyP8hkxr6IDxLelqtn7V4QI63ixjCGcfCBn8UDnhZnrCxpT9D++0kszxK/o
	f1wy4Y89aRRA9ikVRBOeptrC8qIeh60435A==
X-ME-Sender: <xms:P7ijaoL9anQAhIr3UE7JyazCHzNefgVoNg7Wx5oG6qxGib4UOXOr1g>
    <xme:P7ijauJbvPlHa8ImBmYwMAZ4n0e4a2v9iSx_4DYknN8gPEQBRgZt3iKLnJje5VTyV
    cWxEfnuiyoaiC7TPdcLd6C3AuLIlkqK-miiDezcf7AK5YVmx_Xvsos>
X-ME-Received: <xmr:P7ijamUhYXS39-qTOsjBquRGJsoR8w9Q1l95pveBORa1fJD_1_4dmcR7WxOjpjn2VXr_bA>
X-ME-Proxy-Cause: dmFkZTGZwq9ERDEPGlKozn9Ci+qdzEayXWRQ5KW4dJDD17qJjku68Ay0C1P6JozDaXKK1n
    EvRi3ssowEIbRxUnT7YdOb/wbVn+Hr9NpIvbLnIMkq6rzWuQiEDpi7cuXBrpjJdTJEVvwN
    evv1IRNK3TL1GDNy1BhWnqXG754Pv3CTETVb1MZ+M6D5nX3cwA4bd9LViu+lJRpu4D3R+A
    Dt5NW2UgpYxvNhoBCaUVh1FTK5EI9aJfO0ayC2TkiXmZOBCCODkv+uav6jJhdYH1QclsdU
    53KQXK3N2vhQU1Qc+wYQIedKQrw9ZonwMID4K3nZfPbnn7MCWKX2gCQQgap8bSfZqiQvLz
    5cgWwHmBgp+/u/lJuYV7IBIhWKeJ8ABw6hG+M/d9MT1AZjPlnXpo62e+E5icAOqHFfVXjZ
    bDwqGuxLH7nQr5a9YLLVPI1Z8759l7gGWMSEhdZQ0U/CV9LSfd1L/j6x00PQx3FpPqRBTS
    M69pJFhkfgRq6Zqg5+o7aW6wwSEwe5mQEUS4x/9zYtJGbMEU9IF4joxI1rbNjFPZBsuJZs
    q/b6NAizSGBZ/Ax+Kt9arpNgHEG8pxtl/jNxGFO2u9KpUeg4t8Nx/wIq7oPNLY3HZxYYnN
    Zjg5bksgxZv7S1v17FdT3cry99NFFpHrfcbnOv2TVNv7AnmC4Epl0deUOtzQ
X-ME-Proxy: <xmx:P7ijagg_UliCOO-CI_U8vhdDRnXNzTTHc_HUrNZD__XjFb8s19H3qQ>
    <xmx:P7ijah-EzHQTFpjfWT2XFp1Ol5mnBr6y3W5bTArvPEhCX_G7Has5dw>
    <xmx:P7ijaqAG9MVNgGPE-m7BeeWUd8OcPam91VKqQDrBW3uGtvxk2rXgMA>
    <xmx:P7ijauJE7z3J5zvZaRmT35qyCKos2XlU1DOmnEjvOuatp1C0KLoPJg>
    <xmx:P7ijap6AZrpcIVUXOrLcdUnq9hFhaAm-p9UDd-RvXWVOjtI2lr04gTS2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 04:13:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 110ce4b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 08:13:49 +0000 (UTC)
Date: Fri, 11 Sep 2026 10:13:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ariel Keselman <skariel@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] refs/files: avoid packed-refs lock for root ref
 deletion
Message-ID: <aqO4OukzSa4SWcGG@pks.im>
References: <aqJr0ZB8qpthTEGT@pks.im>
 <20260910145528.309340-1-skariel@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910145528.309340-1-skariel@gmail.com>

On Thu, Sep 10, 2026 at 07:55:28AM -0700, Ariel Keselman wrote:
> Deleting a root ref queues a packed-ref transaction in the files
> backend, even though root refs cannot be packed. For example, holding
> .git/packed-refs.lock makes "git update-ref --no-deref -d AUTO_MERGE"
> fail, whether or not AUTO_MERGE exists.
> 
> This also affects post-commit cleanup, which deletes AUTO_MERGE after
> updating HEAD. In a linked worktree with read-only shared metadata,
> commit succeeds but cleanup reports a packed-refs.lock error. Deleting
> CHERRY_PICK_HEAD and REVERT_HEAD is affected as well.
> 
> Skip the packed transaction for root-ref deletions. Keep loose-ref
> locking and packed-ref deletion for other refs unchanged.
> 
> Test deleting a root ref with packed-refs.lock held, and check that a
> transaction deleting both a root ref and a packed branch still fails
> without changing either ref.

Nit: this last paragraph doesn't really add any value, as it's trivially
visible from the patch that we add tests.

> Signed-off-by: Ariel Keselman <skariel@gmail.com>
> ---
> Thanks for the review, Patrick.
> 
> Changes since v1:
> - Keep the packed-ref deletion comment focused on its original purpose.
> - Use one existing root ref and include a packed-refs file in the test.
> - Drop the timeout overrides and redundant individual-ref cases.
> - Add a transaction deleting a root ref and a packed branch together;
>   check that a held packed-ref lock causes failure and preserves both refs.
> 
> AI assistance was used to generate the patch, tests, and commit message,
> including this revision.
> 
> The root-ref deletion regression fails without the fix. With the fix,
> 123 test scripts / 4078 tests pass, along with 249 unit tests and t0600
> with SHA-256 (one platform skip in t0600).

Huh? I hope that _all_ tests pass with this, not only 4078, and I would
assume that you verified that this is the case at least on your machine.

> diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
> index 74bfa2e9ba..65ca19e84b 100755
> --- a/t/t0600-reffiles-backend.sh
> +++ b/t/t0600-reffiles-backend.sh
> @@ -519,4 +519,47 @@ test_expect_success 'symref transaction supports false symlink config' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'deleting a root ref does not lock packed-refs' '
> +	test_when_finished "rm -rf root-ref" &&
> +	git init root-ref &&
> +	(
> +		cd root-ref &&
> +		test_commit initial &&
> +		git pack-refs --all &&
> +		cp .git/packed-refs expect &&
> +		git update-ref AUTO_MERGE HEAD &&

For added benefit we could even execute git-pack-refs(1) after having
created AUTO_MERGE and then execute `test_path_is_file` for it just to
prove that it really doesn't get packed. But other than that the tests
look good to me.

> +		: >.git/packed-refs.lock &&
> +		git update-ref --no-deref -d AUTO_MERGE &&
> +		test_path_is_missing .git/AUTO_MERGE &&
> +		test_path_is_file .git/packed-refs.lock &&
> +		test_cmp expect .git/packed-refs
> +	)
> +'
> +
> +test_expect_success 'deleting root and packed refs in one transaction requires packed-refs lock' '
> +	test_when_finished "rm -rf root-ref" &&
> +	git init root-ref &&
> +	(
> +		cd root-ref &&
> +		test_commit initial &&
> +		git update-ref refs/heads/packed-branch HEAD &&
> +		git pack-refs --all &&
> +		test_path_is_missing .git/refs/heads/packed-branch &&
> +		git update-ref AUTO_MERGE HEAD &&
> +		git rev-parse AUTO_MERGE refs/heads/packed-branch >expect &&

We could strengthen this a bit by listing the state of all refs:

    git refs list --include-root-refs >expect

> +		cat >stdin <<-EOF &&
> +		start
> +		delete AUTO_MERGE
> +		delete refs/heads/packed-branch
> +		prepare
> +		commit

We can drop start/prepare/commit here, those are optional. We can also
drop the extra file and just write the data into git-update-ref(1)
directly via the heredoc.

> +		EOF
> +		: >.git/packed-refs.lock &&
> +		test_must_fail git update-ref --no-deref --stdin <stdin 2>err &&
> +		test_grep "Unable to create .*packed-refs.lock" err &&
> +		git rev-parse AUTO_MERGE refs/heads/packed-branch >actual &&
> +		test_cmp expect actual
> +	)
> +'

Thanks!

Patrick
