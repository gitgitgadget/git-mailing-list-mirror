Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3A4242D9D
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783531477; cv=none; b=FJ4mTYyA98V+fZr7hVOAUtSe0rAc7TjlFM/jnBvMzgPNCxHOqZQ1BI6RAYjJouc0WwIUE7+qG3E4uSTVQqYiGsFpTWLWuYmDSdXD6Z/sjj4Hsw+j1ZqWYESdwgnaGHjLh9Ii3IEKSCrX3qrkauMjteeEajZj6530MKO0iQWHw4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783531477; c=relaxed/simple;
	bh=tqQ4+0wqmt53bRnuyai10nk7g7wZMUx+OrvNRTgMwIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cW1ghXrj00/OI3DrXts/Mtz41JHZ+w9UuNkNOIrdsZopLOzu98CHuHlcbN4NCpHklpUPnFfQkX9vYBYXfOCU6oihyWSMGbtis1PTJgceZ9jls100N9HBgXcHWnf0nylT1Tli6dhUUU06G6mB9PEOiXRruxLD1l4EFKsBJcL5KSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X7HzdT/E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kcF20EN2; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X7HzdT/E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kcF20EN2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 10195EC00C4;
	Wed,  8 Jul 2026 13:24:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 08 Jul 2026 13:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783531475; x=1783617875; bh=6SyfLoaMRH
	xMnarHbluqE2zF1hg1nxRjA+8hJwy7DLQ=; b=X7HzdT/E30+zC4xgkGd4BVaJEF
	Ls3hXkSfvVuuOnmy6ahY/IBgr1MHgopuyJeDFTrqr857fOYveXKLic6EYmcrRprc
	LJ7ACVPcsTeEiz+EojNUbQdmVyV+P4PjGxo+XRWAqfvZ/zJuPGoCaSkuR+8tihrD
	LAGLeTtIiZbrT/Qa9pdsIBSxrZUWSrF4bikdH+s4us0u/SRA4dtgOymZTvOuYXan
	yvluGseUQ258zBa+4i+oPcN4eBZWXs4y6HVTidaAnjB59mP4jQt1nqpmGlBA+PD8
	nfvUWU+mj0EIBt1jApNbiCaXOYtNunurx4fT4y45YnHQj3WjbO4zmIIYx7LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783531475; x=1783617875; bh=6SyfLoaMRHxMnarHbluqE2zF1hg1nxRjA+8
	hJwy7DLQ=; b=kcF20EN2UtgOwaxqhEJIJKwfFRMgSMr0jVUk6S0Capwj2DFekUL
	oxG/nhb++wMwYbaLr2gdELp0mf4rTD5beglZuWxcyujwnHwMcj9nwGjgWuIZC0sq
	8jPYvpa67RlNawJ7IEC34VNK5IyD6ygGExkn+AUxOen/wiEhq9jIg9NVbv/LqRey
	SzWTPbZF8uIoP+/fhcwM7u79UnrGib0/brirKcdPngx796QVCMsveGj2rEhWKpRW
	cpxo35jmskWQ2foNOO8sWWRQIqk2vs23ETyk/1XIX/6XVoCz5/6mjho6Gxq/NPNQ
	TaIgTYgWcRaSg0N3f2S29cga90KoSjoJ0+A==
X-ME-Sender: <xms:0odOap58orHn2SGvnEt_h6rLa2wSC0theZ32NG_zpMAcVHb7CoG3jg>
    <xme:0odOatzp-Z5aTirco-ehnX5W2nrFGTeirBFSadOdbBTr9jzpK17YS6cZ3aFDI83hf
    ltm2qBQ5P9RwHhi6L-Tdn97offcfhfkpWHV0eBeNn_EWnYWQw7NdQ>
X-ME-Received: <xmr:0odOaozNZjrS4MHlnvoeqqGT5SdtfkU4ZJ9sTqqW_iZdwv9gG7cu-AyjtIEOi1kz0oFVHZbXJhtRqDiJEsrdMgJK0DZ-q91YDLjmes8>
X-ME-Proxy-Cause: dmFkZTEJhrtuuCeIjrmOOPKRaKsUo4o+5rPmkRCi1Z8dyTIq6FOlbp5deXN4TzJfDYFBJb
    TxfB/OhQLrOXeGR31fSMX1QOdQ7NdKUePNnqgRLWSkX9mAc5g9NfJX6NCneHRu3MqqS+07
    pmsI6hwpwqQsjcuUOtf40SuoLwooYkZfxj3YnIFMzKPjVw3tCYRdlBZo5/Qkoyez01HU4u
    quPBAZawqd2Ods1lfA4U1ZM/ifb8Lth2n3dlwDdyOAUrez6jmrupHVqWVPiMt2vf8fYrSv
    qnjPKptXQ2novgqVRrEsHxa9AJs4CYMcsBFe2xX42BaYo51HeqgStg0o5Y7MeHdCvtWKnx
    n84RaZ+ZSz2xSPCF5QmOTIfQG0B0ZqEJ36BgEwH7rnpIjlIIjLQ3JDPfA6Lq1A2v4na+fg
    4jbRl/VCMvpmXA1+w92mlujWmDjuZ5slcnI7l02CvUHCD8Qa0JfTLmiTZ2lTRxQ0eyu8KL
    nH5/EtLo6F/397SuGkDtUIDoQsg7M5X3GZJ3ibSqU2NKuA6SCDaxLsgk3ZnYPnk7Qvz0wM
    grryXwfiYu2N9fuSRSw2kk1MeXYNiQWW8v4G7QgAkg2InUBeZ1/LuvTHR/sJaVBwiNWMrD
    SfRtBXkftz7+FuTQ+JDbfKB4+Hgqp0PHvIi3s/uyq5TBS854WH/+H9KhJBGg
X-ME-Proxy: <xmx:0odOatx2IqUGk6YwgjIF0pxgVSFdrFHeHNqSbw476Qi3dv44b3oKNA>
    <xmx:0odOaqYAXNYGlUZgt5yKLZdmhfWBrCc5KOsAz5dWvCtqzb-OZz6vYw>
    <xmx:0odOamXExX64ytzwdhrVumknRKBd0D-LbNymuAY57jmk_qjtytOl_g>
    <xmx:0odOagil_KHenQT8IoLRXlTwIe8TwfCeK5A2bQNdXQTT1s_pHNpRBA>
    <xmx:04dOapyKgrgWlwfBPHhlkrI_q29taCvnI473Y609NaR-GblurC3YbZOO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 13:24:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Kristofer
 Karlsson <krka@spotify.com>
Subject: Re: [PATCH 2/2] commit-reach: guard !FIND_ALL early exit with
 generation ordering check
In-Reply-To: <ba3f2bb6e8463eb2f101ebf5c7d8d83d353731a2.1782739162.git.gitgitgadget@gmail.com>
	(Kristofer Karlsson via GitGitGadget's message of "Mon, 29 Jun 2026
	13:19:21 +0000")
References: <pull.2162.git.1782739162.gitgitgadget@gmail.com>
	<ba3f2bb6e8463eb2f101ebf5c7d8d83d353731a2.1782739162.git.gitgitgadget@gmail.com>
Date: Wed, 08 Jul 2026 10:24:33 -0700
Message-ID: <xmqqjyr5v1gu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Kristofer Karlsson <krka@spotify.com>
>
> When paint_down_to_common() falls back to commit-date ordering (for
> v1 commit graphs without corrected commit dates), the !FIND_ALL early
> exit incorrectly fires.  The exit assumes the queue is generation-
> ordered, so the first RESULT commit found must be the shallowest.
> With date ordering this is not guaranteed: a closer merge base with
> a lower committer date (clock skew) may still be in the queue behind
> deeper commits.

Excellent description of a good observation.

> Add a gen_ordered flag that is cleared when the date fallback fires,
> and require it for the early exit.

The solution is simple and straight-forward.

The flag is initialized to true but we drop it when generation order
is not in effect, and the early exit requires the flag to be still
true.

> Update the test from the previous commit to test_expect_success.
>
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---

Let's mark it for 'next'.  Thanks.

>  commit-reach.c        | 10 +++++++---
>  t/t6600-test-reach.sh |  2 +-
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/commit-reach.c b/commit-reach.c
> index 5df471a313..708798a39b 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -108,11 +108,14 @@ static int paint_down_to_common(struct repository *r,
>  		{ compare_commits_by_gen_then_commit_date }
>  	};
>  	int i;
> +	int gen_ordered = 1;
>  	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
>  	struct commit_list **tail = result;
>  
> -	if (!min_generation && !corrected_commit_dates_enabled(r))
> +	if (!min_generation && !corrected_commit_dates_enabled(r)) {
>  		queue.pq.compare = compare_commits_by_commit_date;
> +		gen_ordered = 0;
> +	}
>  
>  	one->object.flags |= PARENT1;
>  	if (!n) {
> @@ -147,11 +150,12 @@ static int paint_down_to_common(struct repository *r,
>  				commit->object.flags |= RESULT;
>  				tail = commit_list_append(commit, tail);
>  				/*
> -				 * The queue is generation-ordered; no
> -				 * remaining common ancestor can be a
> +				 * When the queue is generation-ordered,
> +				 * no remaining common ancestor can be a
>  				 * descendant of this one.
>  				 */
>  				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
> +				    gen_ordered &&
>  				    generation < GENERATION_NUMBER_INFINITY)
>  					break;
>  			}
> diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
> index 1090104220..0ff41381ff 100755
> --- a/t/t6600-test-reach.sh
> +++ b/t/t6600-test-reach.sh
> @@ -1003,7 +1003,7 @@ test_expect_success 'merge-base without --all is one of --all results' '
>  	grep -F -f single all
>  '
>  
> -test_expect_failure 'merge-base without --all, clock skew, v1 commit-graph' '
> +test_expect_success 'merge-base without --all, clock skew, v1 commit-graph' '
>  	git rev-parse skew-M2 >expect &&
>  	merge_base_all_modes skew-P1 skew-P2
>  '
