Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3723C1FF7BC
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336100; cv=none; b=iP8zBprLN66do98zi5m7PgAjb0dBdBUzAkflrsTIWeqoLwa+WGaiEHvFCyuwx+aziNQ0anhsU0J6gzc+WpRX4RrSskmPEH38aHfWkNHnnMTF2h7f57LUm5xbKPKod3yFAp/Cwb8qe55oDdCbvTfkDdjvZlhAUUA0BURQS6OaiSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336100; c=relaxed/simple;
	bh=AWjohRKX8hcampTwbe3jXyRKvShDgP90IxEJyw3MU2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTR3Io+bGyC6jLBbn/MRBSU2rS0Y4iADLcSeF4NCsRqH85gp4lYjzvnwjMnDBne/OuMYIjwON87Cj5dZGvNOOl1e5fBPV13bW0m8gumDEgNlYKgdpbzs8pbzy0bZd1mUzrgrQ+GnHOG8/cxmwzUHAzZHYGidktCFnDfXUJmtenk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lA+fZvWk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YDlZBmk8; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lA+fZvWk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YDlZBmk8"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id DD81711400E3;
	Mon, 16 Dec 2024 03:01:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 16 Dec 2024 03:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734336096; x=1734422496; bh=lX+Q59Om1G
	tiC2EXrUR02yPjnI9A5M7fCe6XJHs5Cho=; b=lA+fZvWkgW3uGI68tzOicdmZVW
	95wBOFvXBIKpiIpxj62EFx1rYKCT2a2S5I3NCo793Nwax1v2pT4UZlVzAwJ0gW9u
	+QgIlvkS4hRD1KbrIRqRvxN+4RXyCtMyU4QCiXETfWQZl3+FvKAVfzjNFs9Bsq53
	gi6ynCNmfKMdmk4a00fbWNBcrQYIBYGIgvhbU9QeQMzWVaJvlXJvrM8hUYjZkpF2
	Sdo5OZrMVX3/dD2oHNPl29wuF2BR5Gn/nGRrY38oQi+19tOfmMt2EKra5BSN6zEq
	ttycjI2LJEP+fJLvvLPNY3Hp9qzMe+XcKzIeSCYDFdC4AfNmsMnLye5nrwYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734336096; x=1734422496; bh=lX+Q59Om1GtiC2EXrUR02yPjnI9A5M7fCe6
	XJHs5Cho=; b=YDlZBmk8tgonX99efG6PYbfOOZCRqoYstAtmFj8x20B+4joQq6W
	PMzYAZsoiGzMWepjCjuAegktyNan6Zix8blArT6fa2HBy5cbmEUH7FUYGDP78RiB
	CguCP1RnTCF3J4NbByPG8zRuaPmVw6cfLhEf27cpX6PMxAxtYfnNYkHhAXEL2WJn
	/veP4ibNhVSkAZDCZtJb4UWKmbjvfApxi5AL0tMy+85xTdC9XDgDujPCYlmeLCp6
	Fs8lxcT9deP4FxpgmVvaVqST/qiXrZzRc8gZCDjfAuzxye61YVjtVfU9Evhe8CKf
	j1NdXBJCtK/7RQuh2qx2Ni5NWV138ymfXyA==
X-ME-Sender: <xms:YN5fZz8dfNzqznLf7nNFutr-wvGlgH0TTDQ-C3K_rVO1UvCI08n8xA>
    <xme:YN5fZ_spKUODs8fBhBDCMqKOfY0UeajnQClsHdk8GawRU8fRaGMCESghblS3-btl1
    04pl6B7ATBYIDGMLw>
X-ME-Received: <xmr:YN5fZxC6Aun7eaZkneEoJo9r6487ZO5Yt1RBx_hfbkX_BfiG53v9Dm6Z7R7iF_hwrhNXiwhWnfX7hsRn1kqKi7hjnhRn2OR4_LiJV1ONw1mAiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledvgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepudegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhtohhlvggvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtg
    hpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghp
    thhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:YN5fZ_cE91RtFtz-gnzuCm8oiIyoOyp7EHqYJyJSw2hcnQqHtXfl-Q>
    <xmx:YN5fZ4PLmh3-L2k0JZtfRxW0wfupU8IUjgCFkE-CHBeRQGmPXQZGCg>
    <xmx:YN5fZxn1amVkQgawY6Not1IEMcuK55cCKDaN_56rgaA_kjEpoZjh6A>
    <xmx:YN5fZytjaFqamE0HdnxnFeXdw1IWHXs-LkY-B2fd5ylJPar4zT-X_g>
    <xmx:YN5fZ_n_q9hMHAmaYAUbTmOHZnGE5nfxpwn4Q1H1Q5DttQ28mIUuFdzc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 03:01:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6890a9cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Dec 2024 07:59:49 +0000 (UTC)
Date: Mon, 16 Dec 2024 09:01:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, me@ttaylorr.com, johncai86@gmail.com,
	newren@gmail.com, christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com, jonathantanmy@google.com,
	karthik.188@gmail.com, Derrick Stolee <stolee@gmail.com>,
	Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/5] backfill: add --batch-size=<n> option
Message-ID: <Z1_eTHk6IEJ0BEEg@pks.im>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
 <3cfd23073a036ea426569769b3e31290076257a6.1733515638.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cfd23073a036ea426569769b3e31290076257a6.1733515638.git.gitgitgadget@gmail.com>

On Fri, Dec 06, 2024 at 08:07:16PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> Users may want to specify a minimum batch size for their needs. This is only
> a minimum: the path-walk API provides a list of OIDs that correspond to the
> same path, and thus it is optimal to allow delta compression across those
> objects in a single server request.

Okay, here you explicitly say that this is a minimum batch size, so this
is by design and with a proper reason. Good.

> We could consider limiting the request to have a maximum batch size in the
> future. For now, we let the path-walk API batches determine the
> boundaries.

Should we maybe rename `--batch-size` to `--min-batch-size` so that it
does not become awkward if we ever want to have a maximum batch size, as
well? Also helps to set expectations with the user.

[snip]
> Based on these experiments, a batch size of 50,000 was chosen as the
> default value.

Thanks for all the data, this is really helpful!

> diff --git a/Documentation/git-backfill.txt b/Documentation/git-backfill.txt
> index 0e10f066fef..9b0bae04e9d 100644
> --- a/Documentation/git-backfill.txt
> +++ b/Documentation/git-backfill.txt
> @@ -38,6 +38,14 @@ delta compression in the packfile sent by the server.
>  By default, `git backfill` downloads all blobs reachable from the `HEAD`
>  commit. This set can be restricted or expanded using various options.
>  
> +OPTIONS
> +-------
> +
> +--batch-size=<n>::
> +	Specify a minimum size for a batch of missing objects to request
> +	from the server. This size may be exceeded by the last set of
> +	blobs seen at a given path. Default batch size is 16,000.

This is stale: s/16,000/50,000/

> diff --git a/builtin/backfill.c b/builtin/backfill.c
> index e5f2000d5e0..127333daef8 100644
> --- a/builtin/backfill.c
> +++ b/builtin/backfill.c
> @@ -112,6 +112,8 @@ int cmd_backfill(int argc, const char **argv, const char *prefix,
> struct reposit
>                 .batch_size = 50000,
>         };
>         struct option options[] = {
> +               OPT_INTEGER(0, "batch-size", &ctx.batch_size,
> +                           N_("Minimun number of objects to request at a time")),

s/Minimun/Minimum

Patrick
