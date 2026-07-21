Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CC238910F
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659905; cv=none; b=LDEaLmvwz43r7HaG4j5aXnA+tpxnSyVXgP9GoPwmJxGD5hJ2cocgAjQYQftsSekYSqrDQhAgqaEgpAA723hhIWjmjPHFOZU+Ksb6L6OEDGDoBvpUm8MfhTLyN4Fhc0eXIlj1c/dK4PWkrI82xGf6qTq3prcih6It9GHlhwL6/Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659905; c=relaxed/simple;
	bh=p177GuLV7yj62MU8OdUuRlW6J5dxNjlSZQZj+hQCnJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R3nB3Y9y5Tyme4QZfUZqDfIw9xWqjDw4w+5vJJctYcp1p96nrcVWiG3fZILHXMuq3wctw0VybBwmcMFzuW5wKmBZfnGBgFTl9SK7Kzmn06OqTDk5yHyvw/0TLyGPnVRNdpl2jIot2geoPRPSElLuvW3ZEENNBtMAPHrk7q6CmIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NuXDWbmL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g0WV8m4m; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NuXDWbmL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g0WV8m4m"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 356B57A00FF;
	Tue, 21 Jul 2026 14:51:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 21 Jul 2026 14:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784659899; x=1784746299; bh=nLZxpm06pj
	D7A0twe5myBN2dQEGRbE8fMm/lqKslle8=; b=NuXDWbmLyuY/HFZDsIqDsXvv7t
	BEm3wNtnLYv6qHVx/dfsrwQgvAcEQzx4ZMRkK7vdUXKHBgvkTVGe7pazCwzxjawI
	Q78mg3rSGuCjHkKf6+qll9YNArc70iReJLAxADt5oGp8JLRzPAuNdvalGXEi31Qb
	73fLT2OQwKt8ZHB+AzmC3B+emuH5JMYQ7dgC/UD/Hw/Vgo2eSYQkoQfwkDwvcnYH
	QlVQSdMp6wsgw5F/Nu38vGj6TwQRDYPME1oO3Imt5f269nI4503eO9aQZB3QIhRy
	Ybt6VEWzxi9t4zAC86rbwkgaZnufCIIhpR0JDABKHIcbLVqx2fSR2ymsEa0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784659899; x=1784746299; bh=nLZxpm06pjD7A0twe5myBN2dQEGRbE8fMm/
	lqKslle8=; b=g0WV8m4mwMF/H2pfeE2Ss00pjVG5WCEKHOPIdqk3Ct5uWcdwVy5
	9KJWXLWCUSxp6/vRDRHHCUPjkGQsYmWTAGF78uvo7iWT7R4CzB5nZUZdhekmodjI
	MtaUC1HuIIEksP+K5CWNNj0brENqfLov05RCfxOh/u7AH029U3cS3oms1iVFFfde
	/HKTIEG8F9FntkWauF2pQfuBX6Sf9LxxuFeLLow8BHSEAAEN/Vacmv27P1oOlt14
	X1/AQiUFQk6+0wb6U9IYy0e8Jm9+o5Z0Yyf0nd0woBVp1vLBTa65Z+NZYsoe8oYF
	msUvbS2SYQRpRjmVjXk4q+0dApUB1wYBYwg==
X-ME-Sender: <xms:ur9faqaPSBPokbdGCKTZdVFwPA0mxxP5ZF0sG__skltaFFyIVEA2zA>
    <xme:ur9fak1FznkLDfwK19qPBww1BHlYm2TvvODBUfareHG1EIJpak3MvpZ5sFt-od_HP
    ArEU9lHr5oQUhEJUX6OkdzZRv7rlVFMlLMW-M5Li_7yJwmJLp0F1uY>
X-ME-Received: <xmr:ur9faiW4kAzkzlEsilG9H9EmI8dAL50DaZ2wfTkyK_syjHKskbutKEl4VA52kQXdSHKG4oSoVC8GkOxUeydXc_mvm6E6v7MAhg>
X-ME-Proxy-Cause: dmFkZTFX/rpDMPLc+E4o+dpTS0fcJnrnUPfNfOhOQf+ztbI1coFads+/eLssAFdbrJtfKZ
    nmC1Bz3GuK/vfGTjPN/Bz0ErgPU0NpUAaWZas5EtCN7ZXwR4PLviX/4LU7WvuEXiV/ZvRj
    LwmeOrXPwvGts3DvYY6tqyIL5fhixA6E6mk/fOSmm+tf1RvZ6EO3EKE7M8rs5mdKPjkEJV
    bp7DjmqITeL2VyEusuYcZkH0n2nmZEq6ehlTAlyEHAMx183qNnB6oNlGcXB9A6/KZhtlxF
    tStn/wcaOfidZRqs2PHAo1XXfoS1Ws3tp7P+oKUdaxxC7BRAtzsYh1skbZBlhf03RVFVEm
    I20LD2NycXpovINh015CUHuwPRFEtXL7RSXrePGol0UI1swx40cUzf2Li1Jra53BPAP2m0
    86ajds4TvA0VCqryHmdh9l6CC9nF0yAYs8IGqroh7OBSdVl4ExXUXVXZJInihKTXo/Fb8q
    m+6wwobvBLnWh3caHpODvjWK2HyDSqDTKm4qdCK6AauSkT8DVCy1MDORh/B+buvRVwlDQY
    NEVCHkUNZwOYUWMFUugGtXHQnRoLQXokzxW1cnD+vpvZtTFNC9UklLaZmOGMLzeRZpOdf1
    eY8wrdvuCDMNEHlqI/sPxMXkCBpkiT0eBV07tXIrrZQiGaCgnsNIIcOfxwXw
X-ME-Proxy: <xmx:ur9famUp9h9Vvn4VsNrajeU27L0mCVj3G0L37HUHijl9T7bCdJsL-g>
    <xmx:ur9fapfZfe5s1nRl6cG9wxURfoVNV4LPK5VCp5kjKO_RsI0MFwzoAQ>
    <xmx:ur9fanXQ2DCKphey8as0EUXN_P10P8kyxlUbE5URqnSi6DQtEURnSg>
    <xmx:ur9faqfpSKcZeiOIL4-higbdgOZx07PcpGUQiK8VJeLZuUX9pSI4IA>
    <xmx:u79fas2xHTMdx1JkD1Z0vM1xBoDiI2haslTPHAodZUz3XJSMwVE5mvRD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 14:51:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v9] show-branch: convert per-branch flags to commit-slab
In-Reply-To: <20260717224435.74504-1-gatlavishweshwarreddy26@gmail.com> (Gatla
	Vishweshwar Reddy's message of "Sat, 18 Jul 2026 04:14:35 +0530")
References: <xmqqcxwl33kr.fsf@gitster.g>
	<20260717224435.74504-1-gatlavishweshwarreddy26@gmail.com>
Date: Tue, 21 Jul 2026 11:51:37 -0700
Message-ID: <xmqqzezkw4zq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com> writes:

> I took time to read through the code carefully before sending this.

Hmph.  I hate to say this, but I am finding it difficult to trust
your "carefully" at this point.

    $ make
    $ ./git show-branch master next
    Floating point exception (core dumped).

While I have not spent the time to exhaustively find all bugs in
this code [*], it is disturbing that the simplest use of the command
immediately crashes.  The reason for this crash is trivial.

>  static struct commit_name_slab name_slab;
>  
> +define_commit_slab(commit_rev_flags, uint64_t);
> +static struct commit_rev_flags rev_flags_slab;
> +static int flags_stride; /* number of uint64_t words per commit */
> +
>  static struct commit_name *commit_to_name(struct commit *commit)
>  {
>  	return *commit_name_slab_at(&name_slab, commit);
>  }

The code still uses name_slab to associate names with commits, and
commit_to_name() is called by functions like name_commits(), which
is used in cmd_show_branch().  Yet, the patch does this:

> @@ -713,8 +773,6 @@ int cmd_show_branch(int ac,
>  	const char **args_copy = NULL;
>  	int ret;
>  
> -	init_commit_name_slab(&name_slab);
> -

The code simply discards the initialization for that slab, leaving
name_slab BSS-initialized.  Consequently, all members in the struct
are initialized to 0, including the '.slab_size' member.

This init_commit_name_slab() call is not moved elsewhere; it simply
disappeared without an explanation.

When commit_to_name() tries to look up a commit in the slab, it
first attempts to determine which slab should contain the data for
the commit, using this code from <commit-slab-impl.h>:

scope elemtype *slabname## _at_peek(struct slabname *s,			\
						  const struct commit *c, \
						  int add_if_missing)   \
{									\
	unsigned int nth_slab, nth_slot;				\
									\
	nth_slab = c->index / s->slab_size;				\
	nth_slot = c->index % s->slab_size;				\
									\
And we all know what would happen when you divide by zero.



[Footnote]

 * ... and I will not.
 
