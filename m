Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681FA1F5619
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037078; cv=none; b=MdmzdlqDRogojnclxphwC36lWbXHy4G/Mqsf+4UngCNm5FbutACgAm7Lx6iLqvKAD7LFv9kPLUqcqYn7nEMrYSsyJ5ucyF7vTvCU0EANaW5Qq3G4XN4LEDDDqZbfGq8X8MQ9Jh4oBo0uS6eYk3nkfInlYnnYP97p19iyKxBv23U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037078; c=relaxed/simple;
	bh=oDa6XZcK6t60tHgu+T6i5vzY6hwswpDnGNbb9WKcJCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmAgjHyN5Ig1u4x5J2e5mwTi3py/wIdfesYI/vBnkoGUNeJlrZx5SX4F3DBATtrUDfTQ7QpZCeduEJheTQ3FCPH5SxmXkPCQ3sZ2D6xAo6OXPmkwPXDgrJgy7N39VXx6wimjVtiGpaQru8Eh9dYc0WRpEWHK27qk7w5AltW7B6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BsGXk0MZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J8tiGnJq; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BsGXk0MZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J8tiGnJq"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 80C82EC166F;
	Fri,  1 Aug 2025 04:31:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 01 Aug 2025 04:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754037075; x=1754123475; bh=a7haIfGcTA
	dze78hJMHOUXbNTWbFRr+VHygGs7C0OXg=; b=BsGXk0MZI8uGm3OBGBRx8I6AVc
	zlJujR391pHKyhwZSQ7SaCM642JMmf827vl3bmYMy95XFsb5noCFt1M0qqf0eFKq
	seWe2TU3+osMxHZIiJ0UYJ68hZgIytJ2Lho0TxYpzt4g5WFe8pls+2bT65uLjiul
	qsAr8KAwmZZc2zpoPX6W8iQOlgoKSKXFYR+GXZi5QPUWG4Lf87rnPO0Ic+hr2Y72
	FZnkjUJNw6rlD82vhCwQiDLEwiUMp5O7AkTR6c3tKKgRUEMlBNM14YQH+0oL36jY
	n+szotX6Yxw9iu270FAFBvlaT1lPj0NCj6Fbr58rweNGWfCBzOO578E4ao2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754037075; x=1754123475; bh=a7haIfGcTAdze78hJMHOUXbNTWbFRr+VHyg
	Gs7C0OXg=; b=J8tiGnJqDkfXBBeKRXIbnICBqBdcobbKA/FhBaGmJtiZXgYZJMt
	PcWwQqeiMu+aTMYjCXChzl1PuOjdJpq8tDv16vJKDTSuSCbXqQXKvyUSyCVxofso
	t9t2dZs5Bi1EUn7DSwsPqw41vDiD8MDxxwM21P/eVgs6EwE6vEjoQ4DxgZM8uXCB
	ybL7YXO1PkON7fm099Mj3z95PU+Tg9nyuQtwQzi58lDm+zI67wdd/hzDFh/WL970
	lzx2iaZ81e9Sf6TDqM8H2OXr/fkXQR56rs52mB9TUxJtHSdm9dyAZKBZwOClKu9d
	8WOvSO9vcOgQ4ikfV+dpX8DuPYHYOTm27bg==
X-ME-Sender: <xms:U3uMaNC-Yds7AVQKWUet0MSd7h8sZ7pa8TJOk9R8HvIf5uHlFi0K5Q>
    <xme:U3uMaOwmS7ZNkrymBQBsELskfhLgzDyFUO7MT2eYkdTFSpEeY1nm4wjg-jKjCBdzO
    t2MIP2EbsM8hMnTQQ>
X-ME-Received: <xmr:U3uMaCAeUpUtXPid1FExzErVkUv8NB_zonIyq6B9iprowkCfl-gKweEV0-lNn2qYYCV2fRbBpoHbaP3DGskRrlcGh0zbSL6GZ28R9_u_Sjq9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfi
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:U3uMaDYP6UqXeYId18JOk323FX3kDcbmkl0r0vxEj4uyu1MWN5Fe3g>
    <xmx:U3uMaCh_Py2Elx29dU7DoHEXlJ7yhg_iO955o4f6qkmSJRM1TVTakA>
    <xmx:U3uMaN4d-qYqXLKn-jDbhwc-om2KyPIUPyKsws1IFaBVkc2-i2tXwQ>
    <xmx:U3uMaB7sKj8yA9fzBBtYDs3o57vjcUpCwj43925R5oqXtoiHgwlyiQ>
    <xmx:U3uMaNvvjY7hZhcdhCHYKYvbzppjTJicPgPtZ3E5h5Rp1O3APlO9FqrA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 04:31:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8d197280 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 1 Aug 2025 08:31:14 +0000 (UTC)
Date: Fri, 1 Aug 2025 10:31:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 6/6] merge-ort: fix directory rename on top of source of
 other rename/delete
Message-ID: <aIx7TxhXHhRI3vEt@pks.im>
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
 <0813d42d91fe9e27f713de3c7d2377c28311ae57.1753197791.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0813d42d91fe9e27f713de3c7d2377c28311ae57.1753197791.git.gitgitgadget@gmail.com>

On Tue, Jul 22, 2025 at 03:23:11PM +0000, Elijah Newren via GitGitGadget wrote:

What a massive commit message. It almost felt like a blog post rather
than a commit message, but I certainly don't mind the additional
context.

> From: Elijah Newren <newren@gmail.com>
> 
> At GitHub, we've got a real-world repository that has been triggering
> failures of the form:
> 
>     git: merge-ort.c:3007: process_renames: Assertion `newinfo && !newinfo->merged.clean' failed.
> 
> which comes from the line:
> 
>     VERIFY_CI(newinfo);
> 
> Unfortunately, this one has been quite complex to unravel, and is a
> bit complex to explain.  So, I'm going to carefully try to explain each
> relevant piece needed to understand the fix, then carefully build up
> from a simple testcase to some of the relevant testcases.
> 
> == New special case we need to consider ==
> 
> Rename pairs in the diffcore machinery connect the source path of a
> rename with the destination path of a rename.  Since we have rename
> pairs to consider on both sides of history since the merge base,
> merging has to consider a few special cases of possible overlap:
> 
>   A) two rename pairs having the same target path
>   B) two rename pairs having the same source path
>   C) the source path of one rename pair being the target path of a
>      different rename pair

So basically file A get's moved somewhere else and then replaced by a
different file B?

> Some of these came up often enough that we gave them names:
>   A) a rename/rename(2to1) conflict (looks similar to an add/add conflict)
>   B) a rename/rename(1to2) conflict, which represents the same path being
>      renamed differently on the two sides of history
>   C) not yet named
> 
> merge-ort is well-prepared to handle cases (A) and (B), as was
> merge-recursive (which was merge-ort's predecessor).  Case (C) was
> briefly considered during the years of merge-recursive maintenance,
> but the full extent of support it got was a few FIXME/TODO comments
> littered around the code highlighting some of the places that would
> probably need to be fixed to support it.  When I wrote merge-ort I
> ignored case (C) entirely, since I believed that case (C) was only
> possible if we were to support break detection during merges.  Not
> only had break detection never been supported by any merge algorithm,
> I thought break detection wasn't worth the effort to support in a
> merge algorithm.  However, it turns out that case (C) can be triggered
> without break detection, if there's enough moving pieces.
> 
> Before I dive into how to trigger case (C) with directory renames plus
> other renames, it might be helpful to use a simpler example with break
> detection first.  And before we get to that it may help to explain
> some more basics of handling renames in the merge algorithm.  So, let
> me first backup and provide a quick refresher on on each of

s/on on/on/

[snip]
> == Directory rename detection ==
> 
> If one side of history renames directory D/ -> E/, and the other side of
> history adds new files to E/, then directory rename detection notices

Did you mean to say "D/" here?

[snip]
> == Testcases 8+ ==
> 
> Another bonus bug, found via understanding our final solution (and the
> failure of our first attempted solution)!

s/solution/solutions/ as there are multiple attempted solutions that
were discarded?

> diff --git a/merge-ort.c b/merge-ort.c
> index feb06720c7e1..f1ecccee940b 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -2313,14 +2313,20 @@ static char *apply_dir_rename(struct strmap_entry *rename_info,
>  	return strbuf_detach(&new_path, NULL);
>  }
>  
> -static int path_in_way(struct strmap *paths, const char *path, unsigned side_mask)
> +static int path_in_way(struct strmap *paths,
> +		       const char *path,
> +		       unsigned side_mask,
> +		       struct diff_filepair *p)
>  {
>  	struct merged_info *mi = strmap_get(paths, path);
>  	struct conflict_info *ci;
>  	if (!mi)
>  		return 0;
>  	INITIALIZE_CI(ci, mi);
> -	return mi->clean || (side_mask & (ci->filemask | ci->dirmask));
> +	return mi->clean || (side_mask & (ci->filemask | ci->dirmask))
> +	  // See testcases 12n, 12p, 12q for more details on this next condition

This should use `/* */`-style comments.

> +			 || ((ci->filemask & 0x01) &&
> +			     strcmp(p->one->path, path));

So if we have a stage 1 index entry and the path is the same due to a
transitive rename we can say that the path is not in the way?

Patrick
