Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C3F28641E
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776671040; cv=none; b=luIexXSFCT5sdKkMdIgx0J1Do+SIEoEOdqRO+DaCAUeqQ9Xp4h1REc/KQmyQNLdBWSQBmjYVP59lbg60ocQQKbVRkh2SiMkGfGVqVnUWRRpYVE91MHXieyTR51Iq9l/it+xCmvrQ8JOtDfIEuSO9YEztclmPIDm42ffmOPaKaDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776671040; c=relaxed/simple;
	bh=0Q0/mrhdKiMsPVviqzZF3bRnm3tQcVSNrD2kt38cmJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRpD6teSF9ZeAKuUc5EE4paZ6W+BfqYXS71mNz+QZG7V4IUDvh5Ini8RqspOKsLWf9ZKY1T51lO17GmeIXcCtohCIBUCcA9/uQb/aNtNXDYjVU8uonSFjtpM/KRelU/0Q7OdcDQzRfE8VVhu8r6ftQK9H3wuyoYGB0CyuSpuXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kRsKGf8d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oz6niNSZ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kRsKGf8d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oz6niNSZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 94D9614000A1;
	Mon, 20 Apr 2026 03:43:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 20 Apr 2026 03:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776671038; x=1776757438; bh=rZicVC8IB/
	EngpyRlrLFaz39f5LpNt/OtvfHe9SM++o=; b=kRsKGf8di+sVuqwmmYuFybOEuL
	xxE9XtBwqU2zKRVBPpFwENKi+2Vmvy+y7xSiiFiumLZsQ8B+0J3O6G1OV3v9uO2S
	k+/yA47xeqJb2beAohYCELsiLfujJWu42s/PeEDSswJVVmXOTlqd2ewW7cT8dgWa
	GIU5fMBKlMwgldnOdGbAJkwZFNuWGDbWbiqDpde4G6ix7N2Zed6bM+qZlqT7qfpT
	utrzrwue+FkWkwTE+tLRFs69s0aGAzFZKIz4tU0uuK9kvdSGlIAUDVFzicdDkP7r
	72VH02uzigdNGo6rvc9diQkJaR8gAzIJ9De6C9575WgewY+q4fHu9oNarXPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776671038; x=1776757438; bh=rZicVC8IB/EngpyRlrLFaz39f5LpNt/Otvf
	He9SM++o=; b=oz6niNSZq8/TvdRmugAbq2meWCi0590TjJfANIQ1C43swqpJezg
	SBB7kp3qDuOwnaWO5AzrD6aXaXTfdnEuI2GXtjds37g/LK0M6SiECYWC4cG2ZGmZ
	vuI+GPLtyyiYspOzr5we5l15fFsafNhbD8BlR6IwR00uA9j7Wf1UarNhu5h+2npQ
	pujKtZCByvaWSOy2EHW5fPoQJyCnQ8d0ruIwXxiMWFge13B1WXymqXhBmpPLMJ5Z
	eyRLdshcpJ/Z4Uh55VAAsOz7RhAaFJQHXa7C+TLmBiBmuWMdqpwXtU2O3KZBqPq7
	0w1GL+Myle3jBVraPp/I3z+Gvkfn1V8vk+A==
X-ME-Sender: <xms:PdnlaRY-cbmZseswwj6UBlFPlKCp95O6x7Xx84g_vVtdsQBpZWny5w>
    <xme:PdnlacF0uPppEfUqTTD2JVeVGy8CMMXLg85PSyYQxJSCAzJNGBgiymR1_sc91Jt63
    VRQsTFBhJZsalfEpDuW0VPy-MXSwJvAeQ6GyZ1WAgKVvP0eCnOU8Q>
X-ME-Received: <xmr:Pdnladx2HsLL0w1GfQMVwIbuhqWMxal9phNmWKSbh3ZA_voY1SNOKMLYD5PCkFE4-arzVQOtefro8Wg5m__ucQ8yF9ZqQQBQE7sPNNPYD14x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjuhhsthhinhesphgrrhhithihrdhiohdprhgtphhtthhopegthhhrihhstghoohhlse
    htuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:PdnlaWmzf0TgczUd08AojEkl-TS_9wYxuwNPKbQ6K5AzxrirDqle-Q>
    <xmx:PdnlaemI0b4Lp_fKXjpQx1_9uORP5A-VQWdXxfUj3iwe7YU4_ANFrQ>
    <xmx:PdnlaQzANFQUn0FplfK5flqmwvJWDs-x8tiEEaP8_F_s2lZPN3V3Pg>
    <xmx:PdnlaboDGcB1F81B2WP06Gmg6iErFXY-VR5HDS551aOOI04Gvfglkw>
    <xmx:PtnlaRJVlk6uqJQWRWvu97dqXfOmWSVAtPrzjyHcwr5kylVhWn_wIVlW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 03:43:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2ff78a93 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 07:43:55 +0000 (UTC)
Date: Mon, 20 Apr 2026 09:43:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, toon@iotcl.com,
	karthik.188@gmail.com, justin@parity.io
Subject: Re: [PATCH v1 1/1] rev-list: add --missing=print-only mode
Message-ID: <aeXZOAtILSr638LG@pks.im>
References: <20260419084840.33986-1-siddharthasthana31@gmail.com>
 <20260419084840.33986-2-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419084840.33986-2-siddharthasthana31@gmail.com>

On Sun, Apr 19, 2026 at 02:18:40PM +0530, Siddharth Asthana wrote:
> When working with partial clones, it's common to want just the list of
> missing objects. The current --missing=print mode does this but mixes
> present and missing objects together, with missing ones prefixed by '?'.
> Getting only the missing OIDs requires an extra pipe:
> 
>   git rev-list --objects --all --missing=print | perl -ne 'print if s/^[?]//'
> 
> Add --missing=print-only which outputs only the missing object OIDs, one
> per line, without any prefix. This makes the above one-liner unnecessary
> and the output directly usable by downstream tools.

Naming is a bit tough, as "print-only" sounds as if we're only printing
them without doing anything else, but it doesn't quite convey the
relation to non-missing objects. I don't really have a better suggestion
though -- "print-exclusively" may convey the meaning a tiny bit better,
but still suffers kind of the same issue.

> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 8f63003709..ba7e3e3919 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -104,14 +104,22 @@ static void missing_objects_map_entry_free(void *e)
>  
>  static struct oidmap missing_objects;
>  enum missing_action {
> -	MA_ERROR = 0,    /* fail if any missing objects are encountered */
> -	MA_ALLOW_ANY,    /* silently allow ALL missing objects */
> -	MA_PRINT,        /* print ALL missing objects in special section */
> -	MA_PRINT_INFO,   /* same as MA_PRINT but also prints missing object info */
> +	MA_ERROR = 0, /* fail if any missing objects are encountered */
> +	MA_ALLOW_ANY, /* silently allow ALL missing objects */
> +	MA_PRINT, /* print ALL missing objects in special section */
> +	MA_PRINT_INFO, /* same as MA_PRINT but also prints missing object info */
> +	MA_PRINT_ONLY, /* print ONLY missing objects, without the "?" prefix */

Makes me wonder whether we'll eventually also want to have
`MA_PRINT_INFO_ONLY`.

>  	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
>  };
>  static enum missing_action arg_missing_action;
>  
> +static inline int missing_action_prints(void)

How about naming this `should_print_missing_object()` instead? That
gives the reader a bit more context.

> @@ -1011,7 +1036,7 @@ int cmd_rev_list(int argc,
>  
>  	stop_progress(&progress);
>  
> -	if (revs.count) {
> +	if (revs.count && arg_missing_action != MA_PRINT_ONLY) {
>  		if (revs.left_right && revs.cherry_mark)
>  			printf("%d\t%d\t%d\n", revs.count_left, revs.count_right, revs.count_same);
>  		else if (revs.left_right)

Not a fault of your patch, but I really feel like git-rev-list(1) is
becoming more and more tangled. The fact that we have to add this check
to so many different sites doesn't inspire confidence that we have
indeed catched all of them that need this check.

It would be great if this was reworked a bit to become more obvious, but
that's probably outside the scope of this patch series.

> diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
> index 08e92dd002..105560ad21 100755
> --- a/t/t6022-rev-list-missing.sh
> +++ b/t/t6022-rev-list-missing.sh
> @@ -198,6 +198,32 @@ do
>  	'
>  done
>  
> +for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
> +do
> +	test_expect_success "rev-list --missing=print-only with missing $obj" '
> +		oid="$(git rev-parse $obj)" &&
> +		path=".git/objects/$(test_oid_to_path $oid)" &&
> +
> +		# Capture present OIDs before hiding anything.
> +		git rev-list --objects --no-object-names HEAD ^$obj >present.raw &&
> +
> +		mv "$path" "$path.hidden" &&
> +		test_when_finished "mv $path.hidden $path" &&
> +
> +		git rev-list --missing=print-only --objects --no-object-names \
> +			HEAD >actual &&
> +
> +		# Only the missing OID should appear, without the "?" prefix.
> +		grep "^$oid$" actual &&
> +
> +		# Present objects must NOT appear in the output.
> +		while read present_oid
> +		do
> +			! grep "^$present_oid$" actual || return 1
> +		done <present.raw

How many present object IDs do we have? I'm a bit worried that we now
execute grep(1) hundreds of times. Can we maybe do some tricks with
comm(1) instead?

Thanks!

Patrick
