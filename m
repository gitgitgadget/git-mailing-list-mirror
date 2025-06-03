Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DC4539A
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748972409; cv=none; b=R1p7enMNWnkKza5ZCjek2YvEEaQzHxJdhPL8wRuDkPwocN/2vtROsCVjhvGvHhUX2RSrTTw7Fopltks8KMx0MmxNoBqCCZt2oUVLQCh93A0cdPAH0vCCa1SqNE5/PPCGhTMxmqTgVuWjO8m9lyJvRkubtBqxosPeLKXhKCt6kWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748972409; c=relaxed/simple;
	bh=q5Bpruq8uZRLTEewhNGla4CLXeU0KNUQTjbj+V1sv4E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CLDB6rFF3+A/+VmMODLr0CPEzoKMfHEAD/qjU6KhSXG2d2UVtuHTUwCvSFtYun+aQTsxsWZ2eSEMWAZAy42zxq2xcRgHoIHyfvwu7W4AvXkrGBTcbOhE3Lac0BuPsGKOupe44f2Ho4Sm4ofy/DCxW8bly7dKsi9YughDpbg5lYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RVwwtSK5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nV7nvdWF; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RVwwtSK5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nV7nvdWF"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2C6352540137;
	Tue,  3 Jun 2025 13:40:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 03 Jun 2025 13:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748972405; x=1749058805; bh=maIzkwRdkT
	15SiML88MtWzoz4MPXw9Tpb74ZRFdOCOM=; b=RVwwtSK5tJZa/9x77f1yeMMFIL
	t85q18h7Bj/lBlvf2d8FxZJNH8HPTnBW1RoFHK5erJuQz4pv+nAQmSBZXSPC0oKW
	tRP6Tm4CZHSoH7rWWxt6e8Th8zhy/hBCk9gNxnwyqwURhpZ7sytqxCW4FiTY961/
	YV6tL7s2ZHVfFXdyqDfS9l7rN1cukNamQQjIKUSI2YX9y6304nu4oZP93AnyTp7r
	f/27nMiL+4eWWJOjht3csUv+1xz05Pj+QQmunBWcbevsTCL3oK7eUHeXNmAIcheo
	Y9eaR3ILvamzbybvuiiK3NMw5hTc9MFSi1pIdlnri6IIxqyBddTxfMCrPsfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748972405; x=1749058805; bh=maIzkwRdkT15SiML88MtWzoz4MPXw9Tpb74
	ZRFdOCOM=; b=nV7nvdWFmFCj342binVfdfkaGIfP/eSMXomN/5Sy+bl1yxmSP1m
	6vW5js7WL3nvyif6ydUx+7GGUTD6xz7eiu6GlPyx0VJO+9rB3ZY0Np/Vu8yKZOnP
	duwffSZWEDfZxxpMmXbH0sfrHI6hDfLycuBrkeurELgblcXhoIn0Tfi78u8W2CYz
	cQRNTXdZuFint0QsmWdKrchKaWMZBxZHOdr91ip1Dn9ORi5weM1cRZaVmR3+4rRi
	xpjoyUhBfM5i3QB1z8mnmGk0HwlZOtuNwh8g2gwyOfqJK8+AdSW2H58aoBb8mOhu
	JylIwa+1MGnjjxckKHsj5TKBYkytXdgNLzA==
X-ME-Sender: <xms:czM_aMS0shzZLTjiwdkqrhkLJaTug0PP_HwxHk6tN8P_iMxrCQ8rhQ>
    <xme:czM_aJwrJauMe7fzyU_bt98nYrXsfhtInC9VybrHTGVz41G6nT7Mq74C4DnNnUeUl
    KkNgQHlz2NWokxzzQ>
X-ME-Received: <xmr:czM_aJ0RMremxEs79e6d3SVKxo6i8IcD7x592dpsSnuxeQ34Yf06Fod3TUc2SwpEy8yKPQjFz-eaWgwfJzVITa4aJrPfStHlvvDc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopeehtddvtddvgeeffedttdehieesshhmrghilhdrnhhjuhdrvggu
    uhdrtghnpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:czM_aAD6w6MaoIbTlbUUgxWPuhWFVGWyHpVclFi3O50Pd6XZ9dmaXQ>
    <xmx:czM_aFg2UYFq3D_kbStcQMEJCtxCJF0OZaFLa2PvMXp4fp-ytYnMhw>
    <xmx:czM_aMrPbfAooflLkBexPo9JynKq6Wh7ADdH5eaE3HEFt0uIvpg5ew>
    <xmx:czM_aIiGRjRA9K8_g0Pp4LUE7-a3BwFjb7ETcanY3yh5LdVLEaWvbw>
    <xmx:dTM_aIra_YvbGobhOZeFsDUvX4Zj5F1-g7zmnKEStEHouzHWfXBuLx1S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 13:40:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Lidong
 Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v4 2/2] BUG(): remove leading underscore of the format
 string
In-Reply-To: <9d69c19273be31135eade258b49582bcc6df27c7.1748916074.git.gitgitgadget@gmail.com>
	(Lidong Yan via GitGitGadget's message of "Tue, 03 Jun 2025 02:01:14
	+0000")
References: <pull.1964.v3.git.git.1748569955.gitgitgadget@gmail.com>
	<pull.1964.v4.git.git.1748916074.gitgitgadget@gmail.com>
	<9d69c19273be31135eade258b49582bcc6df27c7.1748916074.git.gitgitgadget@gmail.com>
Date: Tue, 03 Jun 2025 10:40:00 -0700
Message-ID: <xmqqcybklo5r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>
> BUG() is not end-user facing but programmer facing, and we do not
> use _("...") in them. Replace all `BUG(_("..."))` with `BUG("...")`
>
> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
> ---
>  builtin/mktag.c     | 2 +-
>  builtin/worktree.c  | 2 +-
>  pack-bitmap-write.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

This is unrelated to the sequencer code clarification change, so
I'll queue [1/2] and [2/2] as separate topics.

Thanks.

> diff --git a/builtin/mktag.c b/builtin/mktag.c
> index 7ac11c46d53f..1b1dc0263e18 100644
> --- a/builtin/mktag.c
> +++ b/builtin/mktag.c
> @@ -41,7 +41,7 @@ static int mktag_fsck_error_func(struct fsck_options *o UNUSED,
>  		fprintf_ln(stderr, _("error: tag input does not pass fsck: %s"), message);
>  		return 1;
>  	default:
> -		BUG(_("%d (FSCK_IGNORE?) should never trigger this callback"),
> +		BUG("%d (FSCK_IGNORE?) should never trigger this callback",
>  		    msg_type);
>  	}
>  }
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 88a36ea9f867..2dceeeed8bd0 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -621,7 +621,7 @@ static void print_preparing_worktree_line(int detach,
>  		else {
>  			struct commit *commit = lookup_commit_reference_by_name(branch);
>  			if (!commit)
> -				BUG(_("unreachable: invalid reference: %s"), branch);
> +				BUG("unreachable: invalid reference: %s", branch);
>  			fprintf_ln(stderr, _("Preparing worktree (detached HEAD %s)"),
>  				  repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV));
>  		}
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index 7f400ee01213..56960e6ad760 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -1087,7 +1087,7 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
>  					 oid_access);
>  
>  		if (commit_pos < 0)
> -			BUG(_("trying to write commit not in index"));
> +			BUG("trying to write commit not in index");
>  		stored->commit_pos = commit_pos + base_objects;
>  	}
