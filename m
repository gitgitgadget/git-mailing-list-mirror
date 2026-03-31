Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47AD274FE9
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 06:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774936954; cv=none; b=qYHZsdNLeQI9tsYaID4pwuXJXgz0DAwMciaDhExF3KEXrNpUwXZJwxGP95Htdb8+rGH6mpPv5q3/je1IhT1+xWHxOrtgW/7kF2gZR9dAUEFBn/O9k9cMhar6GITBh+HvdRdkBN/wb/3McqWZP/cdLoWTLmNLl99Tt1h3mkgU8fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774936954; c=relaxed/simple;
	bh=UoP4c0yBiGJLTQye8Aj8kRo6XDw3jpdgdR37ObSBD1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLhLqrtM5kE3T5HHVEtyJf6O+QudzP0/xLB66FapaVxczwajZMZRpMrrN30imzuAuFsyPrkLZKHQfaECk5ZDTxJkTX2syeRsycIsVigoQwjgvAvFO2kbOqJPsvxI3qhl7L2qe2iUt4ixbqPXJfmlMi9zQ4VgWdg4DTH1LKKYlgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kQOp0pge; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZJlR1dt6; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kQOp0pge";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZJlR1dt6"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A13714001EA;
	Tue, 31 Mar 2026 02:02:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 31 Mar 2026 02:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774936952; x=1775023352; bh=MEOUYFJFb5
	Eu6CETWAxi41F2KY2flN/DuqTu++wt5jw=; b=kQOp0pgeacPW4XnAtNp5BAKnYN
	YtbIbVZV2+aY7QMaowujAOcq6ltcRP+iRAX7xLKldLVaOLhIAEOTNjFUdckBFPwC
	5uIOd+RsXGipfY7jHgH7O0Ud8xmyy+2TI/eL13TGGx0OwIgxraG0iRIpT5LJiLwc
	Z77DxByoskiBUTp9lUKmO54XqB608/lJZwJDGyxjahq03MJCZBVvETimzva3YbGO
	5+byW5fYYbBOJGLEF+jWCl9uKfPk36RZxF7xTyPxM2/2Q/WjFuy/iLqj3zB287qK
	fUdzrWvTs6lMapfFn6+P91VfIhydwTFmqhUpw9o0czf9AHF5jcXXD51TGTJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774936952; x=1775023352; bh=MEOUYFJFb5Eu6CETWAxi41F2KY2flN/DuqT
	u++wt5jw=; b=ZJlR1dt6iUDbQmW5wahQlnZQGaBQU1XIndVZQUuXQttxL3mYb/d
	yxriXjLM/d8Ne200/CZFZekgnFCdS0AwnGBDXMHTZB6ebNki6Q4himu5CaEvOTlu
	S2Zf8MlDTYObCBov/9M4XH1b6IG/FrE6bPcm3m/kB6tyj9LfDCI9Q1qDI/GwJ+vD
	iwEdkyxOH9gbZ/f8/peNuYhjpLTeXHuG4guXyAanXc65YGB2sxB24eL4JZBSMNG3
	ft+805PPu+Tl+WCn7YKUuLD72Y9lTwy7ddzB9uN/Jwm11abF7jLgRlXCPf/xItFM
	3c2/zqZ3XmDvNtQMD+6X1mOClYGV2mD8Law==
X-ME-Sender: <xms:d2PLaXMJEV-79udVNAt9AjWZ-UGjeKFoXx5w-VBmELVs2b0_m1cpdg>
    <xme:d2PLaeg-jrBj0_VCM1ASPS8Zi9SG5vefWY2ih3OuSXQCl24qcb_EYrBRSmDglbHsw
    TRhCzzhqlg5nVWGdFGF9muyalkP44eZOTJbH4yBYlesLoFNTL3cdQ>
X-ME-Received: <xmr:d2PLaatxm5rrta0PJvRVw_uN0Fdi3Zz4tRtyzjol99YpWo-kj_lwHfZoEUq_GmhIeITskPm2pVvCM_-cJBZFOO60z1g062MNMYk_Xq50HLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgeduuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheprggsrhgr
    hhgrmhgruggvkhhunhhlvgehtdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:d2PLaSgJaMBgHjcRxgbQN4A4-xqnsvrWyWB7m7lVYlGHgMCaqJrjFg>
    <xmx:eGPLaQaug-Hkrda4gEeFV1S9RaA0igSyWmz8CRl_OvQOUlu_uIWCjg>
    <xmx:eGPLaRb09M2QZxve1qwcatp8NcZLcIbOk95jhzoLfKnsvN8MDQNZvA>
    <xmx:eGPLaVwaoHAqYs3SppayIjmEjpAZmVzXOEmMUvHC5z1n3hZTGbXYZg>
    <xmx:eGPLaQ3Zx7vYSjccwOFFepspxYfjCMBmGtrRZykHUUbVy0YpvlwYP4TG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 02:02:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ac055476 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Mar 2026 06:02:28 +0000 (UTC)
Date: Tue, 31 Mar 2026 08:02:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] repack-promisor: add fake paths to oids when repacking
 promisor objects
Message-ID: <actjaxIkDEXHJbyi@pks.im>
References: <acasFS_UXC8NybtE@Adekunles-MacBook-Air.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acasFS_UXC8NybtE@Adekunles-MacBook-Air.local>

On Fri, Mar 27, 2026 at 05:12:43PM +0100, Abraham Samuel Adekunle wrote:
> This change addresses the NEEDSWORK comment added by commit
> 5d19e81 (repack: repack promisor objects if -a or -A is set).
> 
> When 'git-repack' repacks promisor objects, only the raw oids
> are sent to 'git-pack-objects'.
> This gives 'git-pack-objects' no information about the original
> pack order of those objects in the packfile so it must
> rely on its default strategy of sorting the objects by type and
> then by size over again. This can produce suboptimal packfiles
> because the objects that were previously stored in the same
> packfile can become separated.
> 
> Provide a hint to 'git-pack-objects' when sorting, by using the
> packfile basename, and the offset of the object in the existing
> packfile as fake paths when writing the oids to 'git-pack-objects'.
> 
> This will ensure they can be grouped by the type and existing pack
> order which will make them end up close together in the sort, improving
> delta compression.

I think the general idea may be sound, but ideally we would have some
benchmarks that demonstrate it actually is. Like, can you come up with
scenarios where it will indeed improve the packfile size and show the
advantage of this change? Are there scenarios that are likely to have a
disadvantage because of this new ordering? Which of these scenarios do
we expect to be more likely?

Before answering these questions we basically just claim it's going to
be an improvement without actually verifying.

> diff --git a/repack-promisor.c b/repack-promisor.c
> index 90318ce150..3f3034fb79 100644
> --- a/repack-promisor.c
> +++ b/repack-promisor.c
> @@ -12,25 +12,51 @@ struct write_oid_context {
>  	const struct git_hash_algo *algop;
>  };
>  
> +/**
> + * Build fake path for the objects to give pack-objects
> + * an ordering hint.
> + * For the packed objects: pack-basename/offset-padded
> + */
> +

Nit: this empty line can be removed.

> +static void build_ordering_hint(struct object_info *oi, struct strbuf *hint)
> +{
> +	struct packed_git *pack;
> +	unsigned long offset;
> +
> +	if (oi->whence == OI_PACKED) {
> +		pack = oi->u.packed.pack;
> +		offset = oi->u.packed.offset;
> +		strbuf_addf(hint, "%s/%05lu", pack_basename(pack), (unsigned long)offset);
> +	} else
> +		strbuf_addstr(hint, "loose");

Nit: our coding guidelines say that once an if statement requires curly
braces in one branch, all branches should have them.

I also have to wonder whether it's going to be a benefit to also specify
a hint for loose objects, or whether we should rather not write any hint
at all for them.

> +}
> +
>  /*
>   * Write oid to the given struct child_process's stdin, starting it first if
>   * necessary.
>   */
>  static int write_oid(const struct object_id *oid,
> -		     struct object_info *oi UNUSED,
> +		     struct object_info *oi,
>  		     void *data)
>  {
>  	struct write_oid_context *ctx = data;
>  	struct child_process *cmd = ctx->cmd;
> +	struct strbuf hint = STRBUF_INIT;
>  
>  	if (cmd->in == -1) {
>  		if (start_command(cmd))
>  			die(_("could not start pack-objects to repack promisor objects"));
>  	}
>  
> +	build_ordering_hint(oi, &hint);
> +
>  	if (write_in_full(cmd->in, oid_to_hex(oid), ctx->algop->hexsz) < 0 ||
> +	    write_in_full(cmd->in, " ", 1) < 0 ||
> +	    write_in_full(cmd->in, hint.buf, hint.len) < 0 ||
>  	    write_in_full(cmd->in, "\n", 1) < 0)
>  		die(_("failed to feed promisor objects to pack-objects"));

This now translate into at least four write(3p) syscalls per object. Can
we maybe reuse a buffer so that we can reduce the number of syscalls?

Thanks!

Patrick
