Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B24527FD75
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544888; cv=none; b=oR5oe/qLJsxjOZLmfp06J3FypmDEuKFnegIh28sMhMN+FpG3lvzmbVFpPC0nnVt5/XMO7ZtUrz4S9Yz1Ejm1DcsLrGQdQZN8rqgZQYWvk9T7ZO8Gi/1csnVW6pDyokZnJqkrHARe1rLq2+jXqKNAbosTqcM2BVd3B4ChAxmjMHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544888; c=relaxed/simple;
	bh=S3aYZGQJvgL2xGCCgLryDHkt5IA5Z8yA8dLjTzpT5Ms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NIGih+bCAfoa8CLinT17IIolZBTPK5Gf1pPpmD7GPDRRr7ibf4g69fMhZ2SF3AI55gsHHkdDPDb81+FmhwFW72rgpQF+8MOTvkzRCTwfq3/4XyfTO+tqpSSfjBNCztmJtZmJNnAiUZytymWovtS9FJ+QBMT5zKG8vK+7pyHX39s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jvOuih0K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5HNbnnkg; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jvOuih0K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5HNbnnkg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id DB4901D0020E;
	Thu, 26 Mar 2026 13:08:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 26 Mar 2026 13:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774544885; x=1774631285; bh=XgewJ5fwZy
	40GR3Jg615ikMjBxr9R9xS09vWlnQYcac=; b=jvOuih0K+OsWJmPaL614Qqz98N
	h+BVHr7H4rfE805pm1m5iKH0bmU9XgD2pFGICFTKo2bEJFzg8xUd8jEZZoLNRwHC
	3Pv/yxDG5L/+wNC/etjBH/Xk9fz6d20fJJhPgElJoNC8dxP7jHJESrDL4Ft/DD8O
	jpmwfTZQ82CgpgpmObOH60oPPrqTDfS559IgsZ/Uy9hjmwX2xTLu2sJ5IESnUGve
	fpnS9stImnKjB9716YdSp6ZinGzJhzVBPGWHd1MbEiX/SHKJoK1ljzuw1PEkCR/y
	rVGWo2qyJJfaDMaqrwm8SroE/aEiFSO8aBbR5ZzkWv0QTPdptPJdY2i927cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774544885; x=1774631285; bh=XgewJ5fwZy40GR3Jg615ikMjBxr9R9xS09v
	WlnQYcac=; b=5HNbnnkg5ol79NGeZFO46BgoJWwEhxEZfFxpSTd9cYna31X4kHL
	/puArVFjDijJNGvvicT2BYvDrVXQyQcj72nhltUxBx6qbsQB4frrmfWJ5aBiIrc1
	zAa2uf9cbYfBEhuMhEvIaABp27OonQkBaNLtPx1rLoPfegjoVaQxPLdatP+jfcmY
	4pz/WWTppoOkTjxbxKrVi1qyT1w+EYf4buM1LbUI8d49YvxGwm8jfWvCurdd1HB1
	UGxpVwfzxcBcmy8cYabKH3MtveqyQOL7ZyPKReSnMe34Ru1kYdA3iSWS/iagZKjR
	/QXJTa+xlwHk2mbhi8qtJr/YRaYazeYSHKw==
X-ME-Sender: <xms:9WfFaYcdmCKfnWWpw_p3HqkXjNhnUXxmCM8rgARdUYoLdDwzTvM0HQ>
    <xme:9WfFaRrUkWF78I9Qij3eO1IivbT3TOXahlVtO31rGiEhFw48IHWjNH2WClNFmTTYs
    kc7p7WZc3zVvcxRxa8Cl1V4OcUeAXu46W5fOgv3NLlHCVxZTpro0g>
X-ME-Received: <xmr:9WfFaW6zHNg0BKFihBWank5cT7SbkDStavMSaoQyY8GBUa1fvtOiXYCyUdgSi-vFz1t20OwrcvseIsjF3IEZnWoisGZbvSGXfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehg
    rhhusghigidrvghupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9WfFaXq9n4MuoEn_v7d-LUOlZwH8TwKksY609JEbTLXcuR9g0vbErA>
    <xmx:9WfFaYjEGHJzNvkw0ym-ItxmeqXz-zvlGO0PjivImOADt-mgek5XGQ>
    <xmx:9WfFaRJfD_17yGcnt0XI0Y6-m8M9RvWpIb05fxPSqtO4CppghM2xkg>
    <xmx:9WfFaYCwYD0ardnYsc7G_d95ONEavVksBY_klWxw8_y3OHkd6hVC3w>
    <xmx:9WfFaabynFuctFk3ePqrOA4qekCMQj0CMlV3_9C0Y7Y8Xo_miOKQzmOP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 13:08:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@grubix.eu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] do not discard const: the ugly truth
In-Reply-To: <fe9c86af4825a81b2618ae8ffc8be12300058af2.1774537954.git.git@grubix.eu>
	(Michael J. Gruber's message of "Thu, 26 Mar 2026 16:22:52 +0100")
References: <cover.1774537954.git.git@grubix.eu>
	<fe9c86af4825a81b2618ae8ffc8be12300058af2.1774537954.git.git@grubix.eu>
Date: Thu, 26 Mar 2026 10:07:59 -0700
Message-ID: <xmqqfr5mr028.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael J Gruber <git@grubix.eu> writes:

> ISOC23 reveals that we mutate argv strings in place. Confess to this
> with explicit casts.
> ---
>  builtin/rev-parse.c | 8 ++++----
>  revision.c          | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)

Forgot to sign-off?

> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 01a62800e8..f429793b6f 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -265,7 +265,7 @@ static int show_file(const char *arg, int output_prefix)
>  	return 0;
>  }
>  
> -static int try_difference(const char *arg)
> +static int try_difference(char *arg)
>  {
>  	char *dotdot;
>  	struct object_id start_oid;
> @@ -325,7 +325,7 @@ static int try_difference(const char *arg)
>  	return 0;
>  }

This one is unfortunate in that in the end the incoming arg is
temporarily truncated by substituting the first "." in the ".."
found in the string with "\0", and then restored to the original
value before returning to the caller, so unless the caller is
handing a piece of memory in a read-only segment, nobody should
hurt or even notice.

> -static int try_parent_shorthands(const char *arg)
> +static int try_parent_shorthands(char *arg)
>  {
>  	char *dotdot;
>  	struct object_id oid;
> @@ -1145,9 +1145,9 @@ int cmd_rev_parse(int argc,
>  		}
>  
>  		/* Not a flag argument */
> -		if (try_difference(arg))
> +		if (try_difference((char *) arg))
>  			continue;
> -		if (try_parent_shorthands(arg))
> +		if (try_parent_shorthands((char *) arg))
>  			continue;
>  		name = arg;
>  		type = NORMAL;

The same, with "^" in magic sequences "^!", "^@", and "^-".

> diff --git a/revision.c b/revision.c
> index 31808e3df0..a28b14a2ea 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2132,7 +2132,7 @@ static int handle_dotdot(const char *arg,
>  			 int cant_be_filename)
>  {
>  	struct object_context a_oc = {0}, b_oc = {0};
> -	char *dotdot = strstr(arg, "..");
> +	char *dotdot = (char *) strstr(arg, "..");
>  	int ret;
>  
>  	if (!dotdot)

The patch takes a different strategy to deal with this one, even
though the pattern should be exactly the same as try_difference() we
saw earlier.  Shouldn't we take the same "internally we know we muck
with the string temporarily, but externally we pretend that we take
a const pointer because we revert our temporary modification"
approach in builtin/rev-parse.c too?

One thing that _could_ break if we did so is when the callers do
pass a string in read-only segment to these functions, trusting the
function signature that takes a const pointer promises them that it
is safe.  And to prepare for it, the approach you took in
builtin/rev-parse.c to be honest about it to the callers is safer.

So in that sense, perhaps this function should be updated to take a
non-const pointer to arg instead of sprinkling casts in the body?

> @@ -2176,7 +2176,7 @@ static int handle_revision_arg_1(const char *arg_, struct rev_info *revs, int fl
>  		goto out;
>  	}
>  
> -	mark = strstr(arg, "^@");
> +	mark = (char *) strstr(arg, "^@");
>  	if (mark && !mark[2]) {
>  		*mark = 0;
>  		if (add_parents_only(revs, arg, flags, 0)) {
> @@ -2185,13 +2185,13 @@ static int handle_revision_arg_1(const char *arg_, struct rev_info *revs, int fl
>  		}
>  		*mark = '^';
>  	}
> -	mark = strstr(arg, "^!");
> +	mark = (char *) strstr(arg, "^!");
>  	if (mark && !mark[2]) {
>  		*mark = 0;
>  		if (!add_parents_only(revs, arg, flags ^ (UNINTERESTING | BOTTOM), 0))
>  			*mark = '^';
>  	}
> -	mark = strstr(arg, "^-");
> +	mark = (char *) strstr(arg, "^-");
>  	if (mark) {
>  		int exclude_parent = 1;

Ditto.


