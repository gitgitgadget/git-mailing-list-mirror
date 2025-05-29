Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601061386DA
	for <git@vger.kernel.org>; Thu, 29 May 2025 20:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748551670; cv=none; b=ECXjTZ1X9NszImTJfjuQPQfFvxW196Rqrj0weDdKy7lCRZ1Eay9eUxuq+OgIhnOjIPJ6QaGnmsXJFz00lt547goxBntdwm6p4a6bNTvbEAiAFTtx6FUjbpRf2ZMX+LZ6qUAgY13W7ODJsC4aDvBCnkf+QXWpXVEjh6jmIknpDqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748551670; c=relaxed/simple;
	bh=4fd5hNcf75BpAbJ9xnJaP6EmEa+c0u9Bac6O/3Lr7Wo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BywBlAPTFHhardaAwu4k+YH5dJcR0Jn4iG0OkWgzAfwDE0Mr1Nyw3ylws5PVkEVyHHauoR2RtIhgEuF12LI0Jrh3VFP0XZ6KW1B60+CmYULopkklAvCqnGisFTrczDT0Lb24br03YnxAnguvAIIFly+jqszNC+sxlI+pQYodvDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WT8uQdnn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HMg6zU/U; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WT8uQdnn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HMg6zU/U"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 600E3138035E;
	Thu, 29 May 2025 16:47:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 29 May 2025 16:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748551666; x=1748638066; bh=patpUOH1PT
	tt4e6l525ybmCL16Hd7UJW0Czt+k2JlgQ=; b=WT8uQdnnbMQtQJuRAzNj4VroF8
	1qQoTbmICbFD93yI2H8YKnUhhEvyn5K5V8Qgffcd6JJUhC2xHcjDiiDwBEjagERU
	vOBe2qWSsaEoVA0JuDQI1R5fyeFYrf0ldALMWihbtYtDRYOoR3Q2usKiUEcouL/d
	wODRBb9ajauwZgdQZPZl5SY/xZlg7siTcjGx6JhS1WNa1/vqaayHSnXh1+evkbaF
	JKDoYQjrhoYDFkiQ+sI0V+Zwkil77qM6/6YMZVBQwIevTMMkyYb4WMmghTDNmMuQ
	XD9Nyuf/FZX7uIJpQW0BQ2qfBKgOxxbK0vAWDZNv9abFBPiavoQkN6MOrDBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748551666; x=1748638066; bh=patpUOH1PTtt4e6l525ybmCL16Hd7UJW0Cz
	t+k2JlgQ=; b=HMg6zU/UizD+EXITd93rFkD+aI6O6udkkh5YtZCh2F7RPWV4r46
	vhtMTRL7Ra2kJuaNS+f6MSA9ShazoMEJQBclm5XdDlPQ91JoJGzk3Y7MiBL0qRtZ
	ug+qYLacpRx+9uJ05dUQkv0kKKAnfzNBA1B0jKz1AgG5rbPZNuTChgOdIMEdorXG
	nu1Y8ETrP1PeI9fY/YYlnkDlpookGxK/nh84wm4M3ugqCe/Pb1G+5vS0SZCjmjz5
	sokizCT7vkRLmvgeuLhsZnRbH3/9rDNlIZD14A2VVszPJl9qmGh2syfC3Gz1C+7Z
	UiiImMgDSKf6uRmDMYKVUiQwPnONTY/Y5lg==
X-ME-Sender: <xms:8sc4aNrAzlXtl6zRpTgAO7FGEopLvou38RguiLhhII8QzDl5Ca5Xrg>
    <xme:8sc4aPoUOmcFru3XiZSWRuTybEdFOLS1l_93gPR_1h133pjpnZ-BqnQmhVgScjSNm
    2aAtpVYkzjpeFuB6A>
X-ME-Received: <xmr:8sc4aKPiazw7lOdLwPf7t7ifOe7ibqgDYvs0525tuEcqF8g5yjdRtdGqZqsSNBDZcoMIyY7aq8MbOzJuPOTwRq3y-wz6S42G_maRoJI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvjeduvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:8sc4aI5dtTQFxUoitDLq3QNpFAuCKuiCfZKFe7rIhsSA6GFkEfLpHw>
    <xmx:8sc4aM4tcgJQYsophx_Syy9JfuncGZW4wCK4Y2Tenle-3x8iwfjpeA>
    <xmx:8sc4aAgxk_6v75461UCYLAOaWAX_UykQOnjQ6qHavNiJCD8soJRK8g>
    <xmx:8sc4aO6htji3_P9CZkTIAYgCMf9QBkQJio-ejy7x3gdap3SX_kZeqg>
    <xmx:8sc4aNYHxalypMeZIPU13_zra9oDx7NPw43A4wh3jX3rim5hKl4LllTf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 16:47:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v2 1/4] midx: access pack names through
 `nth_midxed_pack_name()`
In-Reply-To: <d3508d3cfbddb512dbca4c2177731fffb5827084.1748473122.git.me@ttaylorr.com>
	(Taylor Blau's message of "Wed, 28 May 2025 18:59:00 -0400")
References: <cover.1748198489.git.me@ttaylorr.com>
	<cover.1748473122.git.me@ttaylorr.com>
	<d3508d3cfbddb512dbca4c2177731fffb5827084.1748473122.git.me@ttaylorr.com>
Date: Thu, 29 May 2025 13:47:44 -0700
Message-ID: <xmqqr007jg9b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Accessing a MIDX's 'pack_names' array is somewhat error-prone when
> dealing with incremental MIDX chains, where the (global) pack_int_id for
> some pack may differ from the containing layer's index for that pack.
>
> Introduce `nth_midxed_pack_name()` in an effort to reduce a common
> source of errors by discouraging external callers from accessing a
> layer's `pack_names` array directly.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  midx.c                    | 7 +++++++
>  midx.h                    | 2 ++
>  pack-bitmap.c             | 4 ++--
>  t/helper/test-read-midx.c | 7 ++++---
>  4 files changed, 15 insertions(+), 5 deletions(-)

Hmph, I am not sure if an accessor really makes it harder to make
mistakes, but I'd expect it to be mechanical rewrite from a[n] to
fn(a, n)?

> +const char *nth_midxed_pack_name(struct multi_pack_index *m,
> +				 uint32_t pack_int_id)
> +{
> +	uint32_t local_pack_int_id = midx_for_pack(&m, pack_int_id);
> +	return m->pack_names[local_pack_int_id];
> +}

OK, midx_for_pack() takes a pack_int_id, finds the midx that
contains the pack (by updating the 'm' via its pointer arg), and
turns pack_int_id into local offset into m->pack_names[] array,
and returns that string.

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index b9f1d86604..8ddc150778 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -490,7 +490,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>  	for (i = 0; i < bitmap_git->midx->num_packs + bitmap_git->midx->num_packs_in_base; i++) {
>  		if (prepare_midx_pack(bitmap_repo(bitmap_git), bitmap_git->midx, i)) {
>  			warning(_("could not open pack %s"),
> -				bitmap_git->midx->pack_names[i]);
> +				nth_midxed_pack_name(bitmap_git->midx, i));

This loop runs from 0 to (num_packs + num_packs_in_base).  I
understand if it runs from num_packs_in_base to (num_packs +
num_packs_in_base), iterating only on this layer, but probably this
just tries to open everything (i.e. in addition to num_packs we
have, we know num_packs_in_base packs are there in our base layer(s),
so we iterate from 0 to that number).

The updated code converts the global 'i', which runs from 0 to
"everything under us" num_packs + num_packs_in_base, to
corresponding layer midx plus offset in it, so it looks good, but
then, is the original reference to bitmap_git->midx->pack_names[i]
even correct?  If we have a base, i can run larger than
bitmap_git->midx->num_packs, which is the size of the array
bitmap_git->midx->pack_names[].

Or, unlike how the proposed log message portrayed this change as
(i.e. code clean up), does this patch fix real bugs that manifest
only when midx files are chained?

> @@ -2469,7 +2469,7 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
>  			struct bitmapped_pack pack;
>  			if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {
>  				warning(_("unable to load pack: '%s', disabling pack-reuse"),
> -					bitmap_git->midx->pack_names[i]);
> +					nth_midxed_pack_name(bitmap_git->midx, i));
>  				free(packs);
>  				return;
>  			}

Similar to the above, this is also in a loop that runs from 0 to
num_packs+num_packs_in_base.  Is the array access to find the name
for the error message in the original even correct when midx are
chained?

> diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
> index ac81390899..fbed0f6919 100644
> --- a/t/helper/test-read-midx.c
> +++ b/t/helper/test-read-midx.c
> @@ -53,8 +53,9 @@ static int read_midx_file(const char *object_dir, const char *checksum,
>  	printf("\nnum_objects: %d\n", m->num_objects);
>  
>  	printf("packs:\n");
> -	for (i = 0; i < m->num_packs; i++)
> -		printf("%s\n", m->pack_names[i]);
> +	for (i = m->num_packs_in_base; i < m->num_packs + m->num_packs_in_base;
> +	     i++)
> +		printf("%s\n", nth_midxed_pack_name(m, i));

OK.  This used to iterate from 0 to num_packs using the local
offset.  Now it iterates from num_packs_in_base to num_packs_in_base+num_packs,
meaning we iterate over packs in the given midx.  No change in
behaviour, as accesses to m->pack_names[i] using the local offset in
the original was correct, and the updated code iterates using the
global offset.  This is not a bugfix but is a code cleanup.

> @@ -108,7 +109,7 @@ static int read_midx_preferred_pack(const char *object_dir)
>  		return 1;
>  	}
>  
> -	printf("%s\n", midx->pack_names[preferred_pack]);
> +	printf("%s\n", nth_midxed_pack_name(midx, preferred_pack));

Again, is the original buggy when midx are chained?

>  	close_midx(midx);
>  	return 0;
>  }
