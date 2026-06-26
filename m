Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87031C695
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 21:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509953; cv=none; b=ZOD0GkyPW1+J4JYr4OWHi+G7WghtpTe3e2o+AiCibaqaVEd7SOdYQMW4YHzMHCvcd6/ZFPdy0GjdkC2ohVwE7vlsN+R7eLDmLWTfycWtLg8rtDUBgJEZJQkj35swYf4PmqAC1ZsgpBoljdYBsZ7vbE/5NcjNP29AEQIo4o/Ij5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509953; c=relaxed/simple;
	bh=CE5BAB1ku6sEh0RXyxL6MuO6mn/L91JpHszMXZ6+dZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VUvQeSgTiRwhRPKUuH3W4DtdsUFO5znuGLdU/aiUylpcI8rsp/04QPxr+usg04y+A7ge6cq+RFBAyJLh1i2sSRc0VoEiAq8fHyIa2upOPZviT4JCMKn95yNjOq7cVm0UQHN70/vQWEM3cGIpH3GFEMg68oU35JBx4GR5P+AbcM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W56W4VlO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KimPiWJd; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W56W4VlO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KimPiWJd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1BD001D000E3;
	Fri, 26 Jun 2026 17:39:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 26 Jun 2026 17:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782509951; x=1782596351; bh=VEpWr19nfd
	HISJH6r0k5Yo6wAyLCalsAVbuAiVYCMs8=; b=W56W4VlO1n3D9Nzi7qdv1cbFCQ
	l6bmMLT2e1MUPzuwurm22C+MJaDCFVAGIqj31AiFMh4WFxoeZtYwVy40Na41wjma
	EWfK2XctBaPe6/jdkJDLhqeqzwt02pR7qesqqw8/9sp8jSEcjk4kLqJmmoiF7qsF
	Anz7oNp2M4dRIhfN+UfY+f/FzUFByYH7hsvqgy8oO04cLvjDwa8ATTmT1qxV0wJM
	/1FBkuvav/Tf0uFV95VguWrY9l5vXhhJMrAFV5f+nOy/Jd0v2f6OBHP4lxVqi1lq
	NGbaAMFmEpvm18aB9bfHrP96HymwXP1eDwrDeo4823w4Z0Pvsj/HwRc2tlNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782509951; x=1782596351; bh=VEpWr19nfdHISJH6r0k5Yo6wAyLCalsAVbu
	AiVYCMs8=; b=KimPiWJd8yFvE5VzOpEoI/6VHfvLzZ5ouCAZJE7cuM7oOXYvlx1
	TBjXfWqnw1G1kYVFOFSOBVlQonWEcxtCXpvaNtdna92ib8RdVlykAb9H6ITXuBgy
	BGoyuznknLLM0VxnHeazgl8T3r0MMwmNfktffInYVH3BnEkViU8ee7UPDUe6JXki
	+wOd1pYXXTE8DhJJc5ODd9l2fF2EMyKirgMhFCHWDeY7LweN69LWrQ/A+f1caehQ
	MaedHz1U2LRZMR7mxKWny2PGbg1QAx0Sq/H3EAFF1QKg50yf9HOOAnsIJ96VixLx
	S+/u4vwSiZ4+OEuWrfAm2BvzwMhoiy/hMtQ==
X-ME-Sender: <xms:f_E-arDzDI94zmW0Ui6JOeFFCwnha499rZaqosva8t5rILYFVguzcg>
    <xme:f_E-alMjJcnbLBCkgN0YIZmaKMlaTkQwhnQtLd03tnPgWmMgIjKRahQjCrdkwjIlj
    rq05DfyJR-NvaR7jv5zLIgL9NOvD0ksArLim8tS77NiGBkC3Iii>
X-ME-Received: <xmr:f_E-agb309VcQVO_9i81_yh678AkS6iFr8u1PxpajmhNpad9T0nWpEDgMNuv0WNWQHaO9h1IxlHIhLoCvCYRRSOVWtVYkDnF8UdaBHM>
X-ME-Proxy-Cause: dmFkZTFvozzlgXjyZyPCUKzsRbIZ09lc5ujEunCGn1dSc5hNf00CCCEgQSxzTDVo9GQnth
    ftT4oIhjXkd1nwMNHw19ZHPB+F07HEm7b3UgsLajJ7Z2DEGx0gyrmE3cctn6HmF/QRR0s3
    Wr0JZya6czTzYUq/njpMOkgIcMbycYXEbjYsVdmZ0hJHtME6McHfJdz69WnkrRMYJUyeSd
    NIzvk53sihB1hA0dJbGvoF/P6jhpI+gYlBoxXqVYJXoT+6dZ9gdSyivH+CCK4EYwOY77Sn
    hzCtr/Pq8OFCMxkvpq9T3+hgZWXrPUWhDjgPv7QMntDpTomeGD9+s0LIbDThWXqnUpxbBy
    4z02zDpoMzFr/7CJr9vC5xk2M7LLRFMZBIYjJVhVHhALWQCRY3tMzKRcQdO9zCC9wk2C+U
    Apjhrx9cphSfpdtMqDPP37lGfF6c/Je3TF/CLSPuOUTDSfD3aT79Uk7BWj2BIUoU3vQ1qR
    pi8kXAn7rX0vCs8Bsr50WjyNnv2x13KG6qENfecoMhaEAXO81flATgFE/FeqxitrO5cNK8
    3vGCbt59X6w8q8KKu8c8oss1SiMj4YORzv4M1Q6uadjSu0x3bp7/NA52KtzJzAHVavnMgV
    LXf0sTgRM2VzR9nb4KUu0aZDY2FstKFi7IK7BMf4GJbJS7uYKjPdWaPqmorg
X-ME-Proxy: <xmx:f_E-aksBpUwfUB6jqE_SB8HMJEEMDo-tihvnN0uixT_4OL1cD3hSQg>
    <xmx:f_E-aiO-BIPc90NjJCBRsEJJ3sOksaxDlrzlSNrzif0IWQvvLiADfA>
    <xmx:f_E-ar6FTD3NnK2q7lJPcO6hGPnMyPjRa1nU6yQodQRt9OwNGFSN1A>
    <xmx:f_E-aoQc7vZYqbSL8IDD2-gxnm7MJviJ24L3zOcmhNTAeSRAtqEROw>
    <xmx:f_E-agc-JfNSFxHFfsOrpEH79C5MntbxmlSOj-xgwGXrlZs5knVZwk4A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 17:39:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH 08/10] pack-objects: introduce
 '--stdin-packs=follow-reachable'
In-Reply-To: <e3d2e46443d0b32ce29215563dde04ebcf850679.1782500507.git.me@ttaylorr.com>
	(Taylor Blau's message of "Fri, 26 Jun 2026 15:02:37 -0400")
References: <cover.1782500507.git.me@ttaylorr.com>
	<e3d2e46443d0b32ce29215563dde04ebcf850679.1782500507.git.me@ttaylorr.com>
Date: Fri, 26 Jun 2026 14:39:10 -0700
Message-ID: <xmqqpl1d56dd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> +/*
> + * Flag bit set on commits that belong to an included pack during
> + * '--stdin-packs=follow-reachable'. Used by the pre-walk to
> + * identify which reachable commits should be tips for the main
> + * object traversal.
> + */
> +#define IN_INCLUDED_PACK (1u<<11)
> +
> +static int mark_included_pack_tip(const struct object_id *oid,
> +				  struct packed_git *p,
> +				  uint32_t pos,
> +				  void *data)
> +{
> +	struct rev_info *main_revs = data;
> +	off_t ofs = nth_packed_object_offset(p, pos);
> +	enum object_type type;
> +	struct object_info oi = OBJECT_INFO_INIT;
> +	struct object *obj;
> +
> +	oi.typep = &type;
> +	if (packed_object_info(p, ofs, &oi) < 0)
> +		return 0;
> +	if (type != OBJ_COMMIT && type != OBJ_TAG)
> +		return 0;

We do not care about non commits, non tags.

> +	obj = parse_object(the_repository, oid);
> +	if (!obj)
> +		return 0;
> +
> +	obj->flags |= IN_INCLUDED_PACK;
> +
> +	if (type == OBJ_TAG && main_revs)
> +		add_pending_object(main_revs, obj, "");

Any tag object is added to the pending list of the second phase
traversal here.  Doesn't this retain unreachable tags and
(unreachable) objects that are only reachable from these unreachable
tags found in the packfile?  Don't we want to limit this code to add
only tags that actually are reachable from refs, or something?

> +	return 0;
> +}

The other function ...

> +static int mark_loose_object_tip(const struct object_id *oid,
> +				 struct object_info *oi UNUSED,
> +				 void *data)

... is structured in a very similar way, and gives the same
puzzlement to me.
