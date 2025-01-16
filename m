Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF411547E2
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 19:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737054312; cv=none; b=ZUf9aCYkoj67sG0UyZ9QsQR10yL0kn5WpUCiCBc0aqzGI5z/wXygdaRmEb+2RzYwb19ebBH2ZdnWsNLY9mmNBVCr/1gm8Z3mpCwJinVJ07IiSMHl1womFiN651Wrq2+0o5p6uhMvl6eqJdu10vyqifLGHz0oaHKeAgGy9AfX7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737054312; c=relaxed/simple;
	bh=RvIVM1WiOkOYyB3crb7nXv9OMJW2SXT/2aYDx2BKx+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G7MDlJsMDWjk+lCT/L9PB/DuyHZHd3Gz5NbAYpvhD1PuAxmTm6bNiunzNRFUpGFz9yW8SyJFLb24SlTSU02Ws/lWZejABpqy6uoh2kpxTeJ55xULAUVf29orKqXPPUVNqhjWPmu2PrgCXD7ghHhlPcPMsroO7IgiDhgYJipym0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PNCqS2KB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JX4f9RjC; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PNCqS2KB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JX4f9RjC"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 14F5211400A9;
	Thu, 16 Jan 2025 14:05:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 16 Jan 2025 14:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737054309; x=1737140709; bh=0JYzKmB7yJ
	TApbsqq8SIHs5MQkFAcR1btWnIoQwj5Uc=; b=PNCqS2KB0gNqPRwBhbyU7m0dh5
	rkLO7uZkQV6w7yKL483vvfUvgkCJ/vxcwRM1T6Coje4pWJN4RTa2mW0oYL+FnVnZ
	M4ACjSOwIzfqbuzqUWCqGBgkR9IbMxDhX/H+4BQNXY5YU9uTtQ/hZ4IBNAPV4Jk7
	SKUGGAnjNESsJmsFdznUGkUslqng6vzEgOTMzQxeWjFkSiLEMX4+BO00O0gmN5p1
	kKGMyk7Z0sVgcNNFM18zvy2fLP/jchMEafnDS6ezKgTI0rhVqeJPJe7V5nVSDj7w
	M3qAxxeAR+kyozS66c979/AakCZRnfHZPSduLzb+OD53qvSCACS1N2HgHygg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737054309; x=1737140709; bh=0JYzKmB7yJTApbsqq8SIHs5MQkFAcR1btWn
	IoQwj5Uc=; b=JX4f9RjCuN9Q7FHyo//Qw7U6kM9ha8J3xuSv1DUzSMMuwMIN78N
	Jvw/m5npdOLeEc2UW3aTKhKaHCToVHHts/SEatShIYAjczdmm+SmLm3CS49Pbn3A
	ZnKNj+aNpN0rLh5ec8eSzdJ0n4K8+LkaThxgcrQv6Ee8tVVHrVqPr4Xm9tPzeq0n
	JMyMxUw6R7HsVxTUWI3pUvv4yMzW2eMQJXRoJuKkNNUJ9KX3PPmPMiFuvOgE62yo
	Ex4b1vOTD38qI/VtfmNRlbSocpGnbyF7zQmbfuga8sJl2aPELLxHs9G2FKb8VuOz
	QHMCvLhC03ExYIxOBvWgzz90CYhF5P7yn9A==
X-ME-Sender: <xms:ZFiJZxhYGJQENoAIGilUdk-5NibHLvXPcFvvDN2fFRhToIhnCgk1-A>
    <xme:ZFiJZ2AumTtiDzJG4_ppcuua74HKZOUigWNcymBmVptYqNA1viZY8SBJjhEh0duAU
    Q6HnfiO6mWR4tu8XQ>
X-ME-Received: <xmr:ZFiJZxFXw_c0BmlxqtFQ5QShBR-Vw-rjXdUFae1Ak-gYK0RsFbu2BDjBg224pwesqFwawmuGyUbokLumqOQ1mE-WiEdADZaaLajf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvnhhulhhlod
    hkrghrthhhihhkrddukeekrdhgmhgrihhlrdgtohhmsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZFiJZ2TE9EQFbA2EJRW9HbbpWpw-d_Cn_fKlHdZWvlwvfbr_ltKpSQ>
    <xmx:ZFiJZ-w6HUXrtpH3RZGwwX0MElmozbXyXLQthEQfQ8R7Gfj7YelkvQ>
    <xmx:ZFiJZ8662Cqthg45-oHs6BHjxy3O96arsKNDH9Th_vRdMPy1iplvAg>
    <xmx:ZFiJZzwvokKfIDC0DkR4SVDJYWWrHV_VaRxpus7aaOFVnYIEniUwAg>
    <xmx:ZViJZ4vp274t1F2Zoc0c_c7CQlcujt-9192lKLMZynthFx75pyFch5wz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 14:05:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak via B4 Relay <devnull+karthik.188.gmail.com@kernel.org>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/5] pack-write: pass repository to `index_pack_lockfile()`
In-Reply-To: <20250116-kn-the-repo-cleanup-v1-2-a2f4c8e1c4c3@gmail.com>
	(Karthik Nayak via's message of "Thu, 16 Jan 2025 12:35:14 +0100")
References: <20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com>
	<20250116-kn-the-repo-cleanup-v1-2-a2f4c8e1c4c3@gmail.com>
Date: Thu, 16 Jan 2025 11:05:07 -0800
Message-ID: <xmqqo706r34s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak via B4 Relay
<devnull+karthik.188.gmail.com@kernel.org> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> The `index_pack_lockfile()` function uses the global `the_repository`
> variable to access the repository. To avoid global variable usage, pass
> the repository from the layers above.
>
> Altough the layers above could have access to the hash function

I do not think the choice of the hash algorithm has much to do with
this change, though ;-)

> internally, simply pass in `the_hash_algo`. This avoids any
> compatibility issues and bubbles up global variable usage to upper
> layers which can be eventually resolved.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/receive-pack.c | 2 +-
>  fetch-pack.c           | 4 +++-
>  pack-write.c           | 6 +++---
>  pack.h                 | 2 +-
>  4 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 56347a79633505efe8dc05acf1583b4c9995eefe..b83abe5d220cefd3707b701409dc5e6b67566599 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2304,7 +2304,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
>  		if (status)
>  			return "index-pack fork failed";
>  
> -		lockfile = index_pack_lockfile(child.out, NULL);
> +		lockfile = index_pack_lockfile(the_repository, child.out, NULL);
>  		if (lockfile) {
>  			pack_lockfile = register_tempfile(lockfile);
>  			free(lockfile);
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 3a227721ed0935d1f9c40584c57f54043354c032..824f56ecbca11cd9e4da6a3e4c450c6b2e7078ab 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1036,7 +1036,9 @@ static int get_pack(struct fetch_pack_args *args,
>  		die(_("fetch-pack: unable to fork off %s"), cmd_name);
>  	if (do_keep && (pack_lockfiles || fsck_objects)) {
>  		int is_well_formed;
> -		char *pack_lockfile = index_pack_lockfile(cmd.out, &is_well_formed);
> +		char *pack_lockfile = index_pack_lockfile(the_repository,
> +							  cmd.out,
> +							  &is_well_formed);
>  
>  		if (!is_well_formed)
>  			die(_("fetch-pack: invalid index-pack output"));
> diff --git a/pack-write.c b/pack-write.c
> index fc887850dfb9789132b8642733c6472944dbe32d..0cd75d2e55419362a61cf981fc11117ea7a1d88a 100644
> --- a/pack-write.c
> +++ b/pack-write.c
> @@ -460,10 +460,10 @@ void fixup_pack_header_footer(const struct git_hash_algo *hash_algo,
>  	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
>  }
>  
> -char *index_pack_lockfile(int ip_out, int *is_well_formed)
> +char *index_pack_lockfile(struct repository *r, int ip_out, int *is_well_formed)
>  {
>  	char packname[GIT_MAX_HEXSZ + 6];
> -	const int len = the_hash_algo->hexsz + 6;
> +	const int len = r->hash_algo->hexsz + 6;
>  
>  	/*
>  	 * The first thing we expect from index-pack's output
> @@ -480,7 +480,7 @@ char *index_pack_lockfile(int ip_out, int *is_well_formed)
>  		packname[len-1] = 0;
>  		if (skip_prefix(packname, "keep\t", &name))
>  			return xstrfmt("%s/pack/pack-%s.keep",
> -				       repo_get_object_directory(the_repository), name);
> +				       repo_get_object_directory(r), name);
>  		return NULL;
>  	}
>  	if (is_well_formed)
> diff --git a/pack.h b/pack.h
> index 6d9d477adc83e83d9e9175ccf699c100b4c147c6..46d85e5bec787c90af69700fd4b328b1ebf1d606 100644
> --- a/pack.h
> +++ b/pack.h
> @@ -94,7 +94,7 @@ off_t write_pack_header(struct hashfile *f, uint32_t);
>  void fixup_pack_header_footer(const struct git_hash_algo *, int,
>  			      unsigned char *, const char *, uint32_t,
>  			      unsigned char *, off_t);
> -char *index_pack_lockfile(int fd, int *is_well_formed);
> +char *index_pack_lockfile(struct repository *r, int fd, int *is_well_formed);
>  
>  struct ref;
