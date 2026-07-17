Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF4737E5F6
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 06:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784268016; cv=none; b=I7QqmuIzhjgkLQMdUX04f1X11LpTDf2U53nUa4t/f6HKG4GawgokedD0qZlteYBExEal+hES9eiTICLyWUrWBTk4Gtrx8JBeFqntjvAcr+TsbO9u6oT3AMlpFDHyqp6QJgC5M2WxNzF4mzc/sx75U0jw35yaiLpUArsWJU12cyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784268016; c=relaxed/simple;
	bh=0aoCE7hxNuH8f6pndNzGNH7E+8s4yDYCvcDMBjl/bsE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fwjss9zbAVwXV2MYrau1lqqud/ZRSJ1AyD8ei5SQTaY6xtyRC8UoSq5xGJEHiq4HpaQkfhzGnIhPBjX1l1go2BV+8Q6npq28orB4KWBnQoY3HXaecMJWQprpRkr/RfmbHqndVs2htnciwLz9g5U/4yV7xFfiCXlE7CAo+j0JY5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vUC62shg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g3MXfTIZ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vUC62shg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g3MXfTIZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D593C1D00105;
	Fri, 17 Jul 2026 02:00:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 17 Jul 2026 02:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784268012; x=1784354412; bh=7QOQPq4ID1
	t6I/NNe2iPunTraxk8pO++nglq2kPrc2M=; b=vUC62shgBW2saNvKLry6c+FoZr
	M4jiRhnYd8LkVmTHceZMlBRJdxRe4OoHIv5/FgjWeX7+v1Gl6TFgujceor8WTkgU
	De6xfu6/B6P/qI/mgg9ArXSWO61e0caoVTIoGi+sTIuZSgxeSo0w5TV99AHRZx7P
	cr1THoDcwk1TWNwc2Fy4RUWCmu6YvXYzFghxoyFXo2o5D5GcY7GbTtz5ZfIhD9dM
	dEJFqGFNCPMb2u8rL9tfjIuSCgq5f07oogpDTElCzgYzpMicu7+m+/oSiKyXf8XY
	zPox3mrDOW81x22VIcEcqvPeKLnq8OJSvwXGI+JCawsv6Hvzt0Elwt656F3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784268012; x=1784354412; bh=7QOQPq4ID1t6I/NNe2iPunTraxk8pO++ngl
	q2kPrc2M=; b=g3MXfTIZPdnJO4osPqhTWzYtR7ZxlB1P9++YQitKoMQym6C6Tv6
	VCmyK8vDx6lYjb8aa4Mkg/xAcLO6ZdEFWt+EMu3mAtSr5HA4iWpvQqBqT248eIbp
	EQPhpEq50yMe8L60Bnxyi1ww+RtziHj1Q3CFCeFkBU3Ws22KbbGhZeevecDkZhk3
	BIhxajrNFbOb5dvcuCB+TMv9Q6mj2tZ5nzwvqdjSnTJxa/G5hKIuYGqgStejwgIz
	z1XwOVJqdMU9GGg9nJklXhcIFQGP6RdiWiWULbUxAJIRn9S07LpxIzkkENGOAEVt
	Y89oT5Ngcxc4FY4cpTI8AMhEqbTpBb+Dc6A==
X-ME-Sender: <xms:7MRZalk3_t_ngz5eX_fmUlH8MrO7rbtPHIoSzJVIIGFcDscKde0zew>
    <xme:7MRZaoR-1ao5FRQ-CzqPemEoKjaJlCa1sHGVTBwdghwVSZsqa16IfKD2Pa_GETI5U
    YFTgb7ZFEv_3J4Z5sTWeYR-Nrdz7Zl6C8AeKCZjRIVkEPedHIGosCI>
X-ME-Received: <xmr:7MRZapB-v9pB1flfOfPQtMfvgxUV6onCJp0Cyga4M3wlr_3BHHFzhX71y229p_DVTYWB77yaoOdkRCpRrHShg64gSYFhd5nvQ8nFiWE>
X-ME-Proxy-Cause: dmFkZTGSGbCnRcRjdiAMN6ee8+ubuM+KG8vYkS6RSO76HVzxbuumoa3fjsY2XdudLb4EH5
    nrzJuY6RUM3YzpuXDabXHoPm1AqpkokL3UbvUtIXUET+PhCkDNN17jos3lGQEnM1D3INcs
    CsK01Brye2Y+UQrImV5tLQkR4hgj8QzziqXl+Io2MJMQ6SB5B4fCU1ivR66OvJAn0ITqP5
    +9twFiyMEVdbQpyEwxx932KapVeVgArhr0tnzHryhrWBKw+OSZu7ayrsPoH4VwZ4QLG8MK
    pM4BWLH5BdGGhsfpxh3NoKnajRRcU01ltmhkF4H5wUEyub5GBvmtvyLr5lQBkGtTHaFNmv
    TBDi9Mr4ZX07BS4OQwsVwrretnMQ32OJt1XKWuHp0EcOJ7iGmrVuBkAeriPqUKQIlq1cpC
    tB9ri6Zp7dUzulnadn6XJlhmm4VodrN01AjVWSbD+j9hPAFtHxk+/rU+YasvZYPzjF+AjD
    cIaJw1CmmCYYckFtwv66I+J643OeLTMa0pjJPT75lZEb4hm0hAb49dIFkIyHAoqdllyiiD
    pZOZOwbn2oBGF6AhvcRmdO17VPFQALWlsPjBeijMse7zg4ItYl6sysI/LACGuvwWO8Q+RB
    cuxkdF9JTDf8sd2g6oNGeERKFcEckHQdly9qbK30NuW8Ppu4FCZ0gTfw5AGQ
X-ME-Proxy: <xmx:7MRZavTGyKSpmtju9ehnnmtTbr1w1jG3HrHjfsQfxJb3FOX7rFfEBg>
    <xmx:7MRZanppjffPRYNsycOwnmCW3loQEiCmZDQBssJt3c-YCRZGIM-UOA>
    <xmx:7MRZahwGA4dbxt25Ys6hABqRKIxFv2eFJm4AbuIFbYKb-wJlPVO9kw>
    <xmx:7MRZasLLaYseuA3sYqMam3UqYFRUaNRM8fqMvonEID9RTvL_TnuL6A>
    <xmx:7MRZahrHvU2uc4H-vLb4iCeOE-Mi35Ha7K7rKuOEvukR3CreitIuTXtW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 02:00:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v6] show-branch: convert per-branch flags to commit-slab
In-Reply-To: <20260715184241.56635-1-gatlavishweshwarreddy26@gmail.com> (Gatla
	Vishweshwar Reddy's message of "Thu, 16 Jul 2026 00:12:41 +0530")
References: <xmqqy0fcnpee.fsf@gitster.g>
	<20260715184241.56635-1-gatlavishweshwarreddy26@gmail.com>
Date: Thu, 16 Jul 2026 23:00:09 -0700
Message-ID: <xmqqfr1i6tqu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com> writes:

> show-branch uses commit->object.flags to store per-branch
> reachability bits, one bit per branch starting at REV_SHIFT.
> The flags word has only a fixed number of available bits, limiting
> the number of branches that can be shown simultaneously to MAX_REVS.
>
> Convert the per-branch bits to a dedicated commit-slab using uint64_t
> as the element type, initialized with a stride via
> init_commit_rev_flags_with_stride(). Keep the UNINTERESTING bit in
> object.flags where it belongs, as it is used for revision walking and
> does not need to be in the per-branch slab. With UNINTERESTING removed
> from the slab, REV_SHIFT becomes 0 and all 64 bits of uint64_t are
> available for branch tracking, lifting MAX_REVS from 27 to 64 branches.

Thanks.  This version looks much cleaner.  I appreciate your
addressing the correctness issues around UNINTERESTING
propagation that we spotted in the previous round.

I do have a slight worry about a potential performance regression,
though.  We might run the risk of slowing down the traversal in
how we skip parents.

> @@ -226,39 +285,43 @@ static void join_revs(struct prio_queue *queue,
> ...

In the original code, we avoided parsing and re-queueing the parent 'p'
if we knew it already had all the flags we were trying to propagate.

> -			int this_flag = p->object.flags;
> -			parents = parents->next;
> -			if ((this_flag & flags) == flags)
> -				continue;
> -			repo_parse_commit(the_repository, p);
> ...
> +		{
> +			int commit_is_merge_base = has_all_rev_flags(commit, num_rev);
> +			parents = commit->parents;
> +
> +			while (parents) {
> +				struct commit *p = parents->item;
> +				parents = parents->next;
> +				if (has_all_rev_flags(p, num_rev) &&
> +				    (!commit_is_merge_base || (p->object.flags & UNINTERESTING)))
> +					continue;

With the new slab-based approach, we skip only when 'p' already has
all possible revision flags, num_rev.  If 'p' already carries all
the flags that the current 'commit' has (even if it lacks some of
the other num_rev flags), the traversal could be pruned early, but
the proposed change fails to do so.

Consequently, we proceed to propagate the flags (which amounts to a
no-op on the slab anyway) and, worse, re-queue 'p' for further
processing.  In a densely tangled history with many merges, this
would lead to significant redundant work and queue thrashing.  We
instead should check whether the flags of 'commit' are a subset of
those of 'p'.  Since the flags_stride is known, introducing a
helper, perhaps has_subset_rev_flags(commit, p), to perform this
check should be a straightforward exercise.

Also, looking at the bigger picture ...

> -#define REV_SHIFT	 2
> -#define MAX_REVS	(FLAG_BITS - REV_SHIFT) /* should not exceed bits_per_int - REV_SHIFT */
> -
> +#define REV_SHIFT	 0
> +#define MAX_REVS	(sizeof(uint64_t) * 8)

While lifting the limit from 27 to 64 is a welcome improvement, I
wonder why we stop there and still tolerate a hardcoded MAX_REVS
limit.

The introduction of flags_stride and init_commit_rev_flags_with_stride
already lays the groundwork for supporting an arbitrary number of
flags.  The only remaining blockages that keep MAX_REVS alive are:

 - The static ref_name[] array; and

 - The stack-allocated arrays rev[] and reflog_msg[] in the
   cmd_show_branch() function.

If we

 - dynamically grow the ref_name[] array (perhaps using the
   ALLOC_GROW macro),

 - dynamically allocate rev[] and reflog_msg[] in cmd_show_branch()
   once options are parsed (and thus ref_name_cnt and the reflog
   flag are known), and

 - calculate flags_stride at runtime as (ref_name_cnt + 63) / 64,

then we can get rid of MAX_REVS and the associated boundary checks
entirely.  Since the proposed patch already does 90% of the work
needed to support an arbitrary stride, it feels like a missed
opportunity not to take that final step.

Thoughts?
