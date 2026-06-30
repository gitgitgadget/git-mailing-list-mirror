Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85AB175A73
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815191; cv=none; b=kYshR54ufPL86SjzHN/WkaJoWg39a8+c1uS0q/Ujd5ZeNUl5KN79IqxaW1CFGJjPwbKddmfv91/KgQQlRaN2sbOLn9Bfd9+NL2D7lFakFBpGVppTv5aO+8wNFFFTX31BM2+Bwl88Trzvmnggp8EwMhLsOcZVIAXk7nSLdb6hkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815191; c=relaxed/simple;
	bh=lhcng0xweMceWHC8ZSkypxC1VOfmTaMnqKNtokpPu/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJI01gzKz8vnRd5AkNJB3Mt7Ctqkzk5iQQYy1UGoH0TsatcV1Jz3QeGvY8pieyXiHbC1SKtmNlEdLbnzb4Eh2fzMaa2EOu+rCKtORqpKl/28OgfDHXmNtpiWDmcUZEuWcRnORy32UzHNqSHnQdlz57RDV8YNvjTv9Tn5eaZfCPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FPdeFwIt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KPbfvgAI; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FPdeFwIt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KPbfvgAI"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 264F91D0008E;
	Tue, 30 Jun 2026 06:26:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 30 Jun 2026 06:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782815188; x=1782901588; bh=2gx+VXcDFO
	5LGjn134ZoJ7bOYWED3Gyn92okeE2eqTE=; b=FPdeFwItS9Zk4T4Vm4lhDSgUDw
	hXI8dCXKMDKRcOSPA8zkKdkdPjpqKsBeLB+ZYzOz7MK8N2fxIGTU9AhAvRyYxvNr
	xYbGoYZfg/a/ffd3Tt10au4HThnAWRDTt6PTdjhn7sw+jiB9ElABvcZt/FT3SbQO
	4rSYdZUUz6uLRPWGfnZFPYWUEQtY/8Nm1gQfriPDMdbRPSJhsx5A8s9IJjbZN/GJ
	8SxUvqcrZa2EemfvUhbFy28TvUKpGWXsq6kDPZfAd1rCLU5zsiA7yxBt089evZJp
	HB+Wbk0X2Zp3iSecThx0RpT5AOcYd9DnZby/wcmNzRCTO8DimPlcW3KUhIcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782815188; x=1782901588; bh=2gx+VXcDFO5LGjn134ZoJ7bOYWED3Gyn92o
	keE2eqTE=; b=KPbfvgAIXFvoQpegf9kXEHTHTCUEztEh8iPSOnXfWdSUiT5qMnF
	XgfsvybQ1NSUt+wWRPvuL5WtA2WZDQpmcL+o+AoC+cHF9TQFOc+3MsXZsqYgRMo+
	sqAdfRk5GGo3qHpC2YWYFiX5/0soivZ2Djywb7rrEBLZEm5OU0ggf2KuyzfHQUGG
	IgrvFmKZOsil4s/RT5PYd1XP+N/Hc2e27/+ZDblOmNK2AZKi7JK8gqW10LpCY4nR
	9c6r2Nd8Eq8b5B77uYeIU6tbqL+GK9USlA7NZ5ZJuTH0Jq4BoQV8e3DkXDf2JtVA
	vu6aq0gtfLOSoLBUxebOQPLxccASQPlUogA==
X-ME-Sender: <xms:1JlDatXUYFAUKSSMUZ00VisOSMmGfwMpycLUIFCa8QSXovyPQWwE8Q>
    <xme:1JlDalD0n9STKjKleeOXvUWwgoCFpAQHyZufrCdniat0cOi29Esjo_4rv679PPHli
    Cvx1l9Dmg8mXRun_8BVVBquEv2Yccp9LuGEZ0iYgz75czpYntw8qA>
X-ME-Received: <xmr:1JlDamzu2AuvZR4zSTXj2qXwWuZBfSgCbweAbs9ToiMGFGSAdDSsycDPuqVhRcLsQWtwTKaoWG_I2kFT8YZKHSjBHb-B5gQ1CGYufZNglNqdCw>
X-ME-Proxy-Cause: dmFkZTFb1/oEHj3z4rMwyrIlAndJJw5S5NAcAbqg56x5a3SYdu2RaBxO6AUcbcOXMVML57
    hx216z0qrNkIJa7bcsViXsFY1VsoHt6QQ+rMzTZ1k0n1EkbKSvM5H2y9bmcXFseZUNAFjo
    6y2QDNcVYsvSCQrfjb3R+GMt12fRDNuKY8CDTR89xuwsVPEZjE/oywOc68/dxvuSKqGWg5
    ZfFjcMOUAQQmMMGtjnEDPlGTjbNuCBdTrFQnIsaseOEWmy02p2X2GztfWr16YI/Rxme5QT
    48V2l4I8wTMCov4HSyMAbs5WYnjqwxtkUTEI6f6S9wy5GNi9HrUXTOwa3IHu+yGBKIL/eZ
    ZQnJx5KFx5DC3K7yGCiJdsa3tEnhHp5sYVd07Evgdjbtnh+tRi/u6xgCRnysvC3QvCHwEy
    4Yi09bRuvLN6OTHcpzGLARKVe+FwDc5fSIU5l8K0GvlplKuJ7oz1sdB6bnXt/4lJyg+snA
    xpsO+Wluhe+viK06FNECYeCpo6fmwt4gdHn/8VevQH1EjrwzP2rKR52tZW01rRN/9Z+qN2
    kRxVuukvLy2qie0k/JlJP49cqYWjwrqoPnxPBYx2TxWKjNwwzZGKPeYUe+7hehTUniGOYh
    O2+wl5ToRB9Jac1I69Juqc33YAA062WBq/syO0NYb0kTsD9XYh2zwRFMefhQ
X-ME-Proxy: <xmx:1JlDaqAP7U3D1P4M0DIhXxHC2YditKh5HMcM-EgYDUub1X-1vns37g>
    <xmx:1JlDarbi2rvIywks8nLfvZCNtw-Pzm8CW8GeiJnYmV7gyIbl3z7yyA>
    <xmx:1JlDaqiMO4JsGFOpDprws0JCrhvwvwWT1nbtbRBh3L8UxuFmfVxkjw>
    <xmx:1JlDal7dbLwcHgBn3kYC7eNkYrxgGzPFoTpxE606BWeNsZDBP7Uw1A>
    <xmx:1JlDamvcgaTjuZrntlZkTEmWMI3nFR0YLNLYs_QdJQUOqW9X4nGpt5nO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 06:26:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1bfa7a3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jun 2026 10:26:25 +0000 (UTC)
Date: Tue, 30 Jun 2026 12:26:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: fix leak of rev_info in prepare_bases()
Message-ID: <akOZy-BygZS8fqPM@pks.im>
References: <20260630063944.GA3733670@coredump.intra.peff.net>
 <20260630064301.GB3733961@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630064301.GB3733961@coredump.intra.peff.net>

On Tue, Jun 30, 2026 at 02:43:01AM -0400, Jeff King wrote:
> In prepare_bases() we do a custom revision walk, separate from the main
> format-patch walk. After we finish, we fail to call release_revisions(),
> possibly leaking its contents.
> 
> We failed to notice it so far because the revision machinery doesn't
> always allocate. But at least one case can trigger the leak: if a commit
> graph is present, then the topo-walk allocates revs.topo_walk_info and
> some associated data structures. You can see it in the test suite by
> running:
> 
>   make SANITIZE=leak
>   cd t
>   GIT_TEST_COMMIT_GRAPH=1 ./t4014-format-patch.sh
> 
> which yields many entries like:
> 
>   ==git==3687620==ERROR: LeakSanitizer: detected memory leaks
>   Direct leak of 200 byte(s) in 1 object(s) allocated from:
>       #0 0x7f4ccba185cb in malloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:74
>       #1 0x55cd452cdd0b in do_xmalloc wrapper.c:55
>       #2 0x55cd452cdd9d in xmalloc wrapper.c:76
>       #3 0x55cd45255473 in init_topo_walk revision.c:3845
>       #4 0x55cd45255bef in prepare_revision_walk revision.c:4017
>       #5 0x55cd44ffec40 in prepare_bases builtin/log.c:1872
>       #6 0x55cd450010ec in cmd_format_patch builtin/log.c:2439

Interesting. Makes me wonder whether we should modify linux-TEST-vars to
also run with the leak checker enabled. Ideally we'd of course just do
this for all jobs, but the overhead is probably way too high... yes,
doing a simple benchmark shows a ~3x hit.

So this is definitely nothing we want to do for all jobs. But for the
linux-TEST-vars job it might make sense, as it exercises a bunch of
non-default code paths.

> The un-released rev_info has been there since the code was added in
> fa2ab86d18 (format-patch: add '--base' option to record base tree info,
> 2016-04-26), but back then we didn't even have a way to release rev_info
> resources! The actual leak probably started around f0d9cc4196
> (revision.c: begin refactoring --topo-order logic, 2018-11-01), but it's
> hard to bisect because there were so many other unrelated leaks back
> then.
> 
> So I'm not sure exactly when the leak started beyond "long ago", but it
> is easy-ish to find now (since we've plugged all those other leaks) and
> the solution is clear.
> 
> I didn't add a new test since we can demonstrate it with the existing
> ones, but it does require tweaking a test variable. We might consider
> ways to get more automatic leak-checking coverage there, but I think it
> should be done outside of this fix.

Yeah, agreed.

One thing worth noting: there are still six test suites that are failing
with this patch: t0095, t3451, t3452, t3453, t4013 and t4211. The t345x
failures are because of the missing call to `repo_unuse_commit_buffer()`
in git-history(1), which we already noted elsewhere.

All of the remaining leaks in t0095, t4013 and t4211 seem to be related
to bloom filters.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/log.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/builtin/log.c b/builtin/log.c
> index d027ce1e0b..350b35c556 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1888,6 +1888,7 @@ static void prepare_bases(struct base_tree_info *bases,
>  		bases->nr_patch_id++;
>  	}
>  	clear_commit_base(&commit_base);
> +	release_revisions(&revs);
>  }

The fix looks sensible to me. We always initialize `revs` before we take
this exit path here, and there is no other early return that we'd have
to adjust.

Thanks!

Patrick
