Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E401913AF2
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795276; cv=none; b=edThYZmXcHgRWEi7YWPA2hIRUS+J7fNET+axqfVUjMKKRienwRImFN9v1ifTMYNnfhZl6lcOtxVI0osvAyeTIUdkv4Q9ggFmLxZaKw//JbhblzQMmHyNwK3rkY6Tft8++p1Nd86MdCmzRsivzolR1AHPqPV0XVALV9TUw2FwgpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795276; c=relaxed/simple;
	bh=+B97HF+rpKDeKhtA+lKEreaLltjNy8GZz8Cs/mzmh54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cf+mIj8dPsnd6rcQC3W5dmu6aaSjM9ng/hPCw/hMmIQqKhOdZYo4KThKVK5xnBdPmvpz7zFg2Fr8ajji/Os/oJD7c6DsjusEsK6LbPF7gfQalUFr0Q3HkeszHUJQPCAuO8OpsM8Z94dXDbGN76/3TJ4Tekb1KBc9DDXybNmxPTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=saeR6u1d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RpEUfmAi; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="saeR6u1d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RpEUfmAi"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D986D1140093;
	Wed, 16 Apr 2025 05:21:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 16 Apr 2025 05:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744795272; x=1744881672; bh=VU7pCJ3rX0
	0xJjutv/M4U0+ubwVciZkIMPH1Pdyph4k=; b=saeR6u1dPi+Qjak4khScyZYVDV
	vnkxT+gOnhMS2+FfrXZCJL5u5P50++lJl4jKiyBknEHxMYKn9n/JJvH7bngnsZuW
	8RylDVW7w1hMjnIY0Id48zRdjKBbVjuXtYDMNIPY5PpNeVN92SI1QlnKe8SpZ3n3
	xP96ahMQGYrjeXkVI+MLmfjiuPDlLQmOqHHnUEoiD67SMjPZ+rrpj0+AkCsf4AHW
	kYnkOP/xziaNDVWuu7YUENQlLiTmksFc7SbNcVRQTxNt8pEOSE7Kk8bGWjtmxQXe
	++owzfTM5PhbC42htmW2pCpQ+Zi+n0jM49rXonf/EZkHXQ60O6XyN1D0ivuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744795272; x=1744881672; bh=VU7pCJ3rX00xJjutv/M4U0+ubwVciZkIMPH
	1Pdyph4k=; b=RpEUfmAiVFTxYJneR+FQWsYaOIjlkYwryIzrd2sMix4XTDapN34
	k9bJeqihRp1QhjzOIuia66d3iigXpCHbds2Mo58G277sCXg+WCfEGPw3Hi0V37y2
	++4ueKng036F0rjBUhFyXBqbcfJeLqUtPrhuBdNlDt6vuB02t4K8EgmFJ8oPitko
	I9dk2kcPziPvP2wGWMKe63PgnI3GmmolvCiJbMe+mbkpqfQdq2eJe5RycLYM89aV
	4f5TFUKyk8vDsgKO9ymKt4GXSQXlqyoYfot1PW7OC4dObSjSHI4394oSjdNDj9wc
	OgjbdSRGShN7WpgM9rWL8m9XJFewunPZQFQ==
X-ME-Sender: <xms:iHb_Z2rdtxKZuFTvS-UscssMQu4dgl39ZO6m7WeteR_eX8ezRdrq6w>
    <xme:iHb_Z0qe5Hr70iyC9NTMI93Bch4Rzjs0sdZo19iowWujae-A0jMyfuVVDN0kyQXiZ
    vGgRLvxhKllSZZFbg>
X-ME-Received: <xmr:iHb_Z7M5Jsll7rqx0IyWVKllqVGUWx6pRQK5FRDvjCAVebNM0dBiVOptSOBq4JmklZkKAvPrKG8i5TTzUQ5Pp6767snX5MfLK4fi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdehleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iHb_Z17PBK0Nh38S1tUkHtt2tHraBkBDHZS_GFowh_lRTrfjng8hsQ>
    <xmx:iHb_Z16DRui5GWpQMF6qrAg_FPPfCH1Jjnt55ExzFa-SqROqZxOBjw>
    <xmx:iHb_Z1j_ml-stkLZyyVxXgMaVtM-NmF4N3zxTpRe9KglysAyEG6dAQ>
    <xmx:iHb_Z_5ZJR4Us4Ya4RooN1wkyNUFmsxTVo_5RKhwx4Yk3iBEl4EBGg>
    <xmx:iHb_Z8N8y5NX9cbqOxxcf00mUjK0XlLu10w1p5nSdRghzQCvFH4XNPjd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 05:21:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 5/9] pack-objects: perform name-hash traversal for
 unpacked objects
In-Reply-To: <240e90b68d18b3231826d2a68e4e251c893e645a.1744757204.git.me@ttaylorr.com>
	(Taylor Blau's message of "Tue, 15 Apr 2025 18:47:01 -0400")
References: <cover.1744413969.git.me@ttaylorr.com>
	<cover.1744757204.git.me@ttaylorr.com>
	<240e90b68d18b3231826d2a68e4e251c893e645a.1744757204.git.me@ttaylorr.com>
Date: Wed, 16 Apr 2025 02:21:10 -0700
Message-ID: <xmqqecxsjwc9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> With '--unpacked', pack-objects adds loose objects (which don't appear
> in any of the excluded packs from '--stdin-packs') to the output pack
> without considering them as reachability tips for the name-hash
> traversal.
>
> This was an oversight in the original implementation of '--stdin-packs',
> since the code which enumerates and adds loose objects to the output
> pack (`add_unreachable_loose_objects()`) did not have access to the
> 'rev_info' struct found in `read_packs_list_from_stdin()`.
>
> Excluding unpacked objects from that traversal doesn't affect the
> correctness of the resulting pack, but it does make it harder to
> discover good deltas for loose objects.
>
> Now that the 'rev_info' struct is declared outside of
> `read_packs_list_from_stdin()`, we can pass it to
> `add_objects_in_unpacked_packs()` and add any loose objects as tips to
> the above-mentioned traversal, in theory producing slightly tighter
> packs as a result.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---


Clever.  And the necessary changes are surprisingly small.  I like
it.


>  builtin/pack-objects.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index d60cb042c9..eb2a4099cc 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3644,7 +3644,7 @@ static void read_packs_list_from_stdin(struct rev_info *revs)
>  	string_list_clear(&exclude_packs, 0);
>  }
>  
> -static void add_unreachable_loose_objects(void);
> +static void add_unreachable_loose_objects(struct rev_info *revs);
>  
>  static void read_stdin_packs(int rev_list_unpacked)
>  {
> @@ -3671,7 +3671,7 @@ static void read_stdin_packs(int rev_list_unpacked)
>  	ignore_packed_keep_in_core = 1;
>  	read_packs_list_from_stdin(&revs);
>  	if (rev_list_unpacked)
> -		add_unreachable_loose_objects();
> +		add_unreachable_loose_objects(&revs);
>  
>  	if (prepare_revision_walk(&revs))
>  		die(_("revision walk setup failed"));
> @@ -3790,7 +3790,7 @@ static void enumerate_cruft_objects(void)
>  						_("Enumerating cruft objects"), 0);
>  
>  	add_objects_in_unpacked_packs();
> -	add_unreachable_loose_objects();
> +	add_unreachable_loose_objects(NULL);
>  
>  	stop_progress(&progress_state);
>  }
> @@ -4068,8 +4068,9 @@ static void add_objects_in_unpacked_packs(void)
>  }
>  
>  static int add_loose_object(const struct object_id *oid, const char *path,
> -			    void *data UNUSED)
> +			    void *data)
>  {
> +	struct rev_info *revs = data;
>  	enum object_type type = oid_object_info(the_repository, oid, NULL);
>  
>  	if (type < 0) {
> @@ -4090,6 +4091,10 @@ static int add_loose_object(const struct object_id *oid, const char *path,
>  	} else {
>  		add_object_entry(oid, type, "", 0);
>  	}
> +
> +	if (revs && type == OBJ_COMMIT)
> +		add_pending_oid(revs, NULL, oid, 0);
> +
>  	return 0;
>  }
>  
> @@ -4098,11 +4103,10 @@ static int add_loose_object(const struct object_id *oid, const char *path,
>   * add_object_entry will weed out duplicates, so we just add every
>   * loose object we find.
>   */
> -static void add_unreachable_loose_objects(void)
> +static void add_unreachable_loose_objects(struct rev_info *revs)
>  {
>  	for_each_loose_file_in_objdir(repo_get_object_directory(the_repository),
> -				      add_loose_object,
> -				      NULL, NULL, NULL);
> +				      add_loose_object, NULL, NULL, revs);
>  }
>  
>  static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
> @@ -4358,7 +4362,7 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
>  	if (keep_unreachable)
>  		add_objects_in_unpacked_packs();
>  	if (pack_loose_unreachable)
> -		add_unreachable_loose_objects();
> +		add_unreachable_loose_objects(NULL);
>  	if (unpack_unreachable)
>  		loosen_unused_packed_objects();
