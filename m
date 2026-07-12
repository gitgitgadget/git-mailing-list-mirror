Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3F532C8B
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783871226; cv=none; b=Hkb3DPRMuEafobeIIAQmLEDgHSaQfAHwpM8G6pboamQYQZyYQBlrnjqZnJmbAvJtcYzinHu1NAeYNyGZO9mCavpIYYzWD7MJpfCodZPW8v8GnehTEMawzwOHQlvTaVmDT1FHOummUGo28hsVIdIjSXapb9mecMoq0xA0qiNpD+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783871226; c=relaxed/simple;
	bh=/VNM76b0LiXIX3r2GvjmOcyJxHZsmtpT2HKqJW3sY8w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SEFtUWkQSeTOdaWzHEGGUadqnwxZezvvh0jM6XDPovqVbc5p4/Nsdm6PbLwGbb3d8jFNfdF+cNFWYbwF8jJp4t1rgjRbbhq86wen84ZVaYujDs0OgpovYiymfKnMfP5mpO0Trk7jKqrSV6V8fqbahrYrKIEvhUJNH0VOYuH6sbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Psi/RLPt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cLKXE/a2; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Psi/RLPt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cLKXE/a2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3C22D1400050;
	Sun, 12 Jul 2026 11:47:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 12 Jul 2026 11:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783871224; x=1783957624; bh=eUdr0Isv9N
	hKtnXeigBGPCNSJ28iF1rYBz1y+owKfRk=; b=Psi/RLPtcb74puwdmtHBLPszeT
	2NmWStSqzgjmSE4Jna636/qJRwgSIFMzM2Xt6H/ov4eCHv3omk5Z/X89UpZpOamg
	kLPc7lYtTD/CNCEvuwHGFyV08etqYO4Iiu4nGuiRANsCw1VZTb4GydfQBED+3TiK
	FvvlMhhEZJaSSPAf/LhMh9O8Z/CiHM9cnaV1PbyDuil81E9Mczeo9I2xyB/oeGgt
	ZwsIH3zja2+1ntzVU0IkCZggYXisqHc/BwRJgRDAtz73/y6xxZ/muEk5gktdY9dY
	iHF95zPmB4J91KmJmX+UI+QZNi4a5dPEhVv68Pr+ZHHxqcRYZFpsvO9YpOJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783871224; x=1783957624; bh=eUdr0Isv9NhKtnXeigBGPCNSJ28iF1rYBz1
	y+owKfRk=; b=cLKXE/a29PZvFKbMfBa73OWsm80UT+0UicqDZk+mMf1VfFr4GF1
	xJedaYoZ9yl5PPhPgX+u2lhqir0+wUk92kPjXtKE7lUcnQAW5dW4CjrfuM2a2ljK
	Bz7l3NcwNJFaBn0/kBCiyd8heDH0riH+lGHWK06f9gfSWU4h+HRc9QBRfGCjfF93
	eodmSNXaBFYwE1mCTQh8GVdbk8/C4+PuwOXxtY5R6tqLo0u1JZuvwhYyAcfUhvdJ
	V74qS5/DSuUc+GCRl+atpmF9N4UBnaoRB9/QP398y8095CguBXUBaVNS9LaN9Xfq
	5iki2UVkDmI+X2IFTme+UlG/5S6IksHSvWQ==
X-ME-Sender: <xms:-LZTajJBx5aaPn7bySLbOJlOSyfnAN4qkForDS0MEka0tVG_VLA8AA>
    <xme:-LZTapuONeCuw8VWmQv7arGgZLHSDW0GrLkBNAd4bKz9askD3N80i2PuKB8Wqgq_A
    qNFIRpT8t6MjxV1Nk_lndOYxymU3m-5LZLWDtFovI-pgRJbKWk96CY>
X-ME-Received: <xmr:-LZTavXO7vwCrvT3g433G413Hx318RII9NroEnI6SLtdV5WgZIM5fBl1FeHRDkjhfyXvExHYehx4XuxlZtXnbIdrFSJpVqUV9CyM720>
X-ME-Proxy-Cause: dmFkZTE9kgmIAxx+hHA+sVxlNd3XvdUalUh892dZeb/2fOsr1GS72EVrji+qTdAiop7ib4
    aKAYf8uGItfzQMrJLfVXM6zonshHsFG8dxECiSpjqsCXgyP7ndH1h7FBAHvCvNLxYjsrYE
    YQQ1VEOKklTAmXTHKvQODaryunj7zJvRerPt6VzCewi91jMD84x9V5VH5ymmYTWGCqbUmT
    qaCeqlFqshDbaxwcIUeAxrW6oLOlvPOvyeakQIRQbD6lV8GnWcUtHs3gaPZE6639Wsj5eB
    WyYYnklzcQy6AA1cGR0qRhoQivR8rQyzUHZ3oiwFkkihbdqHJiDdA2BZXIJxTj55gFo4nm
    iXVRIKqIUFbFw77M8nc3RDmNWsXLeVsE1/yETKt2deVkdUb6l19HBU/JsKA0x/vl07ABDU
    xo5rF9sC0O2mWGeD2cuf5TalggafFrli/4xFvF0EG3NltlnkeXvQtf6usY6udo9w8p0IiV
    qoDqI5axyQAMegyN6MzYO8H+mOK7YZBVHQsqb5f1NHOmfQ027oegMCsBUQARalpq0dkHmU
    vPXEYpat4stdLUoJ2o/r26HjWJzFQSWtGWV6IGuj+Qxcb3tf/tC9mfD4J7QUCUYmDuYutE
    o/ulFjwD9udJ7inamxxi+XQODw5dba0N0FNhG8/nS/dsKLsXQG9+Vyt05Cxg
X-ME-Proxy: <xmx:-LZTasjxBo0HVZEztVWOuJdiHS-jmhir807ktn8wW__dK3jSeiTtlw>
    <xmx:-LZTavrRDh_Ey9M1tSO8dV2zrnTvRt73scYOp1_mKCrJDafhI1EwvQ>
    <xmx:-LZTaqG5D_rB4wa6umgARADbAGUf0-ijKOcDBswLReApspTw3rxuSQ>
    <xmx:-LZTas6r6yAfrr2rHyxDM7swbcz6Ql6696K5hiNOvd23TZ4ugPXuGw>
    <xmx:-LZTagR9B3YfcJYa1_9PIxUh2y0WG1jeG0nJQv3yjoONtqAAXfGqDrQt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 11:47:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  pabloosabaterr@gmail.com,  cirnovskyv@gmail.com,
  szeder.dev@gmail.com,  Christian Couder <christian.couder@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH v10 5/9] environment: move askpass_program into
 repo_config_values
In-Reply-To: <20260712111734.1073514-6-cat@malon.dev> (Tian Yuchen's message
	of "Sun, 12 Jul 2026 19:17:29 +0800")
References: <20260709161145.13349-1-cat@malon.dev>
	<20260712111734.1073514-1-cat@malon.dev>
	<20260712111734.1073514-6-cat@malon.dev>
Date: Sun, 12 Jul 2026 08:47:02 -0700
Message-ID: <xmqqfr1o43d5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

>  environment.c | 6 ++++--
>  environment.h | 1 +
>  prompt.c      | 3 ++-
>  3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/environment.c b/environment.c
> index 975c9cb9eb..1a26c9c6d6 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -464,8 +464,8 @@ int git_default_core_config(const char *var, const char *value,
>  	}
>  
>  	if (!strcmp(var, "core.askpass")) {
> -		FREE_AND_NULL(askpass_program);
> -		return git_config_string(&askpass_program, var, value);
> +		FREE_AND_NULL(cfg->askpass_program);
> +		return git_config_string(&cfg->askpass_program, var, value);
>  	}
> @@ -726,6 +726,7 @@ void repo_config_values_init(struct repo_config_values *cfg)
>  	cfg->excludes_file = NULL;
>  	cfg->editor_program = NULL;
>  	cfg->pager_program = NULL;
> +	cfg->askpass_program = NULL;
>  	cfg->apply_sparse_checkout = 0;
>  	cfg->branch_track = BRANCH_TRACK_REMOTE;
>  	cfg->trust_ctime = 1;
> @@ -744,4 +745,5 @@ void repo_config_values_clear(struct repo_config_values *cfg)
>  	FREE_AND_NULL(cfg->excludes_file);
>  	FREE_AND_NULL(cfg->editor_program);
>  	FREE_AND_NULL(cfg->pager_program);
> +	FREE_AND_NULL(cfg->askpass_program);
>  }

The 'askpass_program' global variable has been removed.  Instead, 
the member in repo_config_values is correctly initialized to NULL 
and properly cleaned up when finished.

> diff --git a/environment.h b/environment.h
> index 39b6691b47..a2e9def89d 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -93,6 +93,7 @@ struct repo_config_values {
>  	char *excludes_file;
>  	char *editor_program;
>  	char *pager_program;
> +	char *askpass_program;
>  	int apply_sparse_checkout;
>  	int trust_ctime;
>  	int check_stat;

Wait, wasn't there an extern declaration for that global variable in 
a header file somewhere?  There must also be an actual definition 
for it.  Both should be removed to ensure no one accesses a stale 
variable; doing so allows the compiler to help you spot any 
leftover users.

Thanks.
