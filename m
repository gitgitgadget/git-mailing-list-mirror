Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D8F21CC53
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594994; cv=none; b=JbBmazdgDQijnyXpJSj3klrIUdApepGlDyVdhuV/9LzImojZiD0Vkq7yksvlzwqdV0Jhvam2AvxhfBKoVQrgLnl7PxARJzd9d7AyTM/mNizy0M8gDDwBq1A4hclBI0nQy87YI9QoiU6WOnpWc+JYgIyQEZmFmCyEn56eNdl0Yiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594994; c=relaxed/simple;
	bh=QpwzfVT2+uhTtQ/0rIH5hZGn8wjGZ8P9zsGv46A1YjI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aUpq9JRmSOiJRufS4aP9AOyxds4uJcl29NkA8NquyTDq8cYEeuLyuCw3CZpCBBdTzuHAs6sFyscJj+YpWNWj6ti0UM9gQyojQLE9Taffm5MJVrbc0Tn9EHwcygfqgtkaXDiiaDMF/0P4sgYrubANERFtgkk7WCmgouQR8V/Vdaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lfP0LTjx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MM5ooX5B; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lfP0LTjx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MM5ooX5B"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6AD5F1140127;
	Wed, 26 Feb 2025 13:36:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 26 Feb 2025 13:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740594991; x=1740681391; bh=sOSqd2eOJU
	PmyQ8JiupDfu3Qhq8gJTqMyQFY6+k/ipM=; b=lfP0LTjxvSwIeU/Tzd03z9p2kQ
	ykFjgdWBZXBqoxK06twUOCEJ+UZmm+LqRmRvzSHgelGfVFajXIfLeY9CsurqUu/e
	ciF9v5hT+Zt2QeKWl+OM/rcmCMZSMNQ5lyw+z0owTxYTpx/evn0CEWU6Hchj2yCl
	Rhr5bGK1KEcCQ94IMlcE5ps0giuL51rxAuZulyBMhSKNk4wi9pBUmuBdPvtPuOVq
	uV2KfoRaZvFjZc4I3rgxsEFy6zh3ybdRjeX0JjRWiK3RYrwUUzuXOsWFjFvatu37
	3NRr6X6UQLjQkMzjcUWXmHvK26zgmeI6HlnTjXEaz8qhgcDs6VNkpfHtC/Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740594991; x=1740681391; bh=sOSqd2eOJUPmyQ8JiupDfu3Qhq8gJTqMyQF
	Y6+k/ipM=; b=MM5ooX5BJJEUgEvQYVlB0CA9W9u0rl1k0d1rskLzkF8SEo9PAKH
	s4SHEGHHaBNizdDyqlrw4WadXf8FoS9GzMtFbbdKp8DNSRTMr4avxjQBEQ9wb7/s
	Z+Ch0O2RxeF4Dl0P4b1z3JPrW6zQS1la9HzbU1msm1sQP1fYxmKLZbngdwvUFkDP
	6auq0LeqY5K1nt8wreuhxh2lEnOxeHHtObm/1maIZNozMgYGibdy7BsJEMI5cj3N
	Qf51t0KwlzxtW/MnE6UgF+qBXn4HxJF25m+w6mflLwx61CW3/PJEAbit1ULqGZ+x
	9LlU0gLF2y1SVxEHpjIOK0VvWGrJdq5FA/w==
X-ME-Sender: <xms:L1-_Z-GOUgsIsErHHadVSLpDQajhGAKPcJjtktVjEYZpcz7nXNxtqA>
    <xme:L1-_Z_UX5xuma6A2VCD8A0lYo4tgP0TMOQni5cVD8gGt0RHO9VsHY_R4g4E-7a6XQ
    KdNf_MuoRKgw04SCQ>
X-ME-Received: <xmr:L1-_Z4KpJwTwcRdJesIKeSFPKOYhuZBbsNSl5xerSkvLjtpudvcD5y32upBxOUu3V6to8obIaOwBLM0pQLFdaMyBP_YoWWMzcIwj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluh
    hosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmhhgrghhgvghrsegrlhhumhdr
    mhhithdrvgguuhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:L1-_Z4Fk6atQc3X9GGkx-UK6afznALJiGtycrVDJE5HJEu3-4sT7dA>
    <xmx:L1-_Z0V126NLzUzO1sRptui7oJOF7XMZGhw34ML9g0iJyfHN__BsDQ>
    <xmx:L1-_Z7OIT2LxLxCDNa7KWZ4TYu4gJG7uH3YlXIV2CZe7ZsiTdvMBjw>
    <xmx:L1-_Z72XTwKaS_D0ZWArQePqsEkxffO4L1aeFSeNFaTfT4PbPkVQzg>
    <xmx:L1-_Z2JudU5NWslIbCI61HI2ZjBrAqHPnmM3-23QAMn8K5FBXk_IGttS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 13:36:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 3/9] packed-backend: check whether the "packed-refs"
 is regular file
In-Reply-To: <Z78cAU69IUSDgpuD@ArchLinux> (shejialuo@gmail.com's message of
	"Wed, 26 Feb 2025 21:49:53 +0800")
References: <Z78bmBSrDR20GY6g@ArchLinux> <Z78cAU69IUSDgpuD@ArchLinux>
Date: Wed, 26 Feb 2025 10:36:29 -0800
Message-ID: <xmqq5xkwd042.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> +static int packed_fsck(struct ref_store *ref_store,
> +		       struct fsck_options *o,
>  		       struct worktree *wt)
>  {
> +	struct packed_ref_store *refs = packed_downcast(ref_store,
> +							REF_STORE_READ, "fsck");
> +	struct stat st;
> +	int ret = 0;
> +	int fd;
>  
>  	if (!is_main_worktree(wt))
>  		return 0;

I do not think it is worth a reroll only to improve this one, but
for future reference, initializing "fd = -1" and jumping to cleanup
here instead of "return 0" would future-proof the code better.  This
is especially so, given that in a few patches later, we would add a
strbuf that is initialized before this "we do not do anything
outside the primary worktree" short-cut, and many "goto cleanup"s we
see in this patch below would jump to cleanup to strbuf_release() on
that initialized but unused strbuf.  Jumping there with negative fd
to cleanup that already avoids close(fd) for negative fd would be
like jumping there with initialized but unused strbuf.  Having a
single exit point ("cleanup:" label) would help future evolution of
the code, by making it easier to add more resource-acquriing code to
this function in the future.

> -	return 0;
> +	if (o->verbose)
> +		fprintf_ln(stderr, "Checking packed-refs file %s", refs->path);
> +
> +	fd = open_nofollow(refs->path, O_RDONLY);
> +	if (fd < 0) {
> +		/*
> +		 * If the packed-refs file doesn't exist, there's nothing
> +		 * to check.
> +		 */
> +		if (errno == ENOENT)
> +			goto cleanup;
> +
> +		if (errno == ELOOP) {
> +			struct fsck_ref_report report = { 0 };
> +			report.path = "packed-refs";
> +			ret = fsck_report_ref(o, &report,
> +					      FSCK_MSG_BAD_REF_FILETYPE,
> +					      "not a regular file but a symlink");
> +			goto cleanup;
> +		}
> +
> +		ret = error_errno(_("unable to open '%s'"), refs->path);
> +		goto cleanup;
> +	} else if (fstat(fd, &st) < 0) {
> +		ret = error_errno(_("unable to stat '%s'"), refs->path);
> +		goto cleanup;
> +	} else if (!S_ISREG(st.st_mode)) {
> +		struct fsck_ref_report report = { 0 };
> +		report.path = "packed-refs";
> +		ret = fsck_report_ref(o, &report,
> +				      FSCK_MSG_BAD_REF_FILETYPE,
> +				      "not a regular file");
> +		goto cleanup;
> +	}
> +
> +cleanup:
> +	if (fd >= 0)
> +		close(fd);
> +	return ret;
>  }
