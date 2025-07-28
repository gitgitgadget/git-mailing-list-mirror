Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC9D275875
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718870; cv=none; b=VvFMFs9jqwkENolbRBNEI3tc4GLkQpznrIPMeiGaRsjoPmkSGFXbp/6FdGeToG+rXkHifDbxIPY2zY+lK26K0HpY55idwJ8VUw8FWDjfJOK9K2oen7MMpHuKULjjxQUt2+uRgiSk66AfyqmvsyqeJ+mTJK7Y4bSOBUtGEjqoaJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718870; c=relaxed/simple;
	bh=Elx0Gcap15j4iwpXDm6dQamkf3jplzewVGQx2xkKsiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PmQXj168zKJ+lIoIUUDALVYksWEcE8bO3HsdGnpxj4MoLFGPOtZEyS2mPM+cJ0hiCK0jVhQAJdME7oD3db07hxLXJqzSHZdBE3T6vujw8n/uxuKoyFH9M9/P0L7dyHqKDGDBYZ+qdjklFwQlw9WVBJpaygUmbwkxtAIpeq2E0YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g82a5eEs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZOSJ8onS; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g82a5eEs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZOSJ8onS"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 018021400034;
	Mon, 28 Jul 2025 12:07:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 28 Jul 2025 12:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753718866; x=1753805266; bh=6eJZlOvBw6
	CWg9DQa2EdI22tFLdQOSE8xkP9l7ipDfU=; b=g82a5eEs7Uhhhl95UfgAwKOy+T
	WWVWXnxVbFWwfwJeaTb5r1U+OkZCPOzQRG2igQVZqCrjyDBSzaEE1K22iGb3lB7X
	jPQ49WtLK4ZPZyv/ZEAmZCZ1fFIzzhCaE0Yb5Ewd7ZKOiKiyArNWnCe+bRtIJBZ4
	IBZR6RkWtaU0s6gflll5EsWvC0/CUXnb/XjyC+YT5Da7Yv0T0/FEDVcw9UrBDTiU
	A4Pi5Xek5r3JjhB3mmheh+paUxz4INXCHmrEheFgnuF4bJ86SkPwn1I6IqGaTFGL
	uNB/BEMuG1dUMCpjGlgGfOh6/tZPB1zXkU2Spo1iWc294VnwCf6dHL5hsp1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753718866; x=1753805266; bh=6eJZlOvBw6CWg9DQa2EdI22tFLdQOSE8xkP
	9l7ipDfU=; b=ZOSJ8onSETC5TryGNH/LJ1/MJZfCO0Wbo18ONK+O38rtUx97Bl5
	bISeAqFuRPB00mvPMda9YabtcIZ57BqwBCllUlwbCFaVXEVggWYt1d1a4D5GqkzL
	7s64FTjTQWD4DMZFYa3cn2PndWFXo2TE9RSOnn21WXu7KDTOcdO1CMjE2xcdW2AC
	P742eeMaD7VbER0TwxNAVSgCSo+85vXVZIKkeMO06lZcn31OjQcFecNYwTmxj0rW
	qX1tHsHw+GEO//EvyoHVb7g17YNxh5qKBGajD0r/g3BneEiekdLHI756TyzUe3oI
	oj93WLGMopj95RLpPr3hXZJIAngc9/xgLFA==
X-ME-Sender: <xms:UqCHaCtLYTzMpXqCv3BZxvA4nwYu77R_xTUOQlXW-ZPk8l-7tGchJw>
    <xme:UqCHaC82rFcbLKeKppMSUQ1RPw1jtmtiTJP1r10Mj-b2CBVvim75TxnQjx_uzL5J_
    A8SorQL3Rm8Nt97nA>
X-ME-Received: <xmr:UqCHaEN29keLfrFY7SJl8_9NchZoR1Vzlwl5i4x7HkBo33Mg9Ho-wNdT8yUlvwlbewGYFwdavqHvFabrd6qWMKpzvZeULDDEvGOmLlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepjhhhtggrrhhltdekudegsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:UqCHaIFJCmck97TvLvP0GeDjAOOIRXd49LEPpP4TIms_YXYTvUTY5g>
    <xmx:UqCHaKSLU8JSaB3cWYkZxbt1XAPfZyr7C7l9L4vUVMo1n9xzUcOinw>
    <xmx:UqCHaNsUcRZ5WACTk2PckbjcB3CXYLnQphp47_LcqUs-AE5ckx_Xig>
    <xmx:UqCHaKLkN0IDJA82JFR1NoX3Bfl04wrmcsF4j13KkbBoVIS_AYyqSA>
    <xmx:UqCHaNKncAVmAz-Q9XT_3ZZeIOwNq8b1j0XJv228JQFTtJsSL4QV3onP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 12:07:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Han Jiang
 <jhcarl0814@gmail.com>
Subject: Re: [PATCH 1/4] refs: pass refname when invoking reflog entry callback
In-Reply-To: <20250728-pks-remote-rename-improvements-v1-1-f654f2b5c5ae@pks.im>
	(Patrick Steinhardt's message of "Mon, 28 Jul 2025 15:08:45 +0200")
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
	<20250728-pks-remote-rename-improvements-v1-1-f654f2b5c5ae@pks.im>
Date: Mon, 28 Jul 2025 09:07:44 -0700
Message-ID: <xmqqv7ncwb73.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> -static int fsck_handle_reflog_ent(struct object_id *ooid, struct object_id *noid,
> +static int fsck_handle_reflog_ent(const char *refname,
> +				  struct object_id *ooid, struct object_id *noid,
>  				  const char *email UNUSED,
>  				  timestamp_t timestamp, int tz UNUSED,
> -				  const char *message UNUSED, void *cb_data)
> +				  const char *message UNUSED, void *cb_data UNUSED)
>  {
> -	const char *refname = cb_data;
> -
>  	if (verbose)
>  		fprintf_ln(stderr, _("Checking reflog %s->%s"),
>  			   oid_to_hex(ooid), oid_to_hex(noid));
> @@ -525,7 +524,7 @@ static int fsck_handle_reflog(const char *logname, void *cb_data)
>  	strbuf_worktree_ref(cb_data, &refname, logname);
>  	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
>  				 refname.buf, fsck_handle_reflog_ent,
> -				 refname.buf);
> +				 NULL);
>  	strbuf_release(&refname);
>  	return 0;
>  }

Nice.  There are a few callsites that passed refname as (a part of)
cb_data, like this one ...

> diff --git a/refs.c b/refs.c
> index 4bd80287054..fd9a5f36b20 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1022,7 +1022,6 @@ int is_branch(const char *refname)
>  }
>  
>  struct read_ref_at_cb {
> -	const char *refname;
>  	timestamp_t at_time;
>  	int cnt;
>  	int reccnt;
> @@ -1052,7 +1051,8 @@ static void set_read_ref_cutoffs(struct read_ref_at_cb *cb,
>  		*cb->cutoff_cnt = cb->reccnt;
>  }
>  
> -static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
> +static int read_ref_at_ent(const char *refname,
> +			   struct object_id *ooid, struct object_id *noid,
>  			   const char *email UNUSED,
>  			   timestamp_t timestamp, int tz,
>  			   const char *message, void *cb_data)
> @@ -1072,13 +1072,13 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
>  			oidcpy(cb->oid, noid);
>  			if (!oideq(&cb->ooid, noid))
>  				warning(_("log for ref %s has gap after %s"),
> -					cb->refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
> +					refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
>  		}

... that makes quite sense.

