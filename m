Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E3633F8C2
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742949; cv=none; b=usr1ZyPLDEnW5WmFnEP3q4DtLLV/jLi+MDYKhYNw1q+EQOwD2axSXDWY9PA7JL753oE2B2zpGQPuxVnFc3kwyG+X54IcH1bbnvhpHJl6nMVZZI9uR5WEzQrqzpXL0EBwWrtGpPjiGHZ8n06mcbvYm3Z06gWL3j/gSbRnKmbAyFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742949; c=relaxed/simple;
	bh=534TAw7XN6fb10QavecAGeCWvooIA0AHkq1+hzb5hC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kXj5Y0VqombmP0ncsYi+QbSZOoYBUbHP1V0KG3U++jWlj7QaBubrO4VjB6PC+iHJBimneWRyfK8QIvN8ZBu2CrT6EzhIn2IB3heSS1I8GxIj62gDVIxh+/n/nDOgOjjMcY18mzpGYRFRmXSGo/Jqb781z36op08hwqhmluOOjBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VZKaTHj5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e4mm6sOU; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VZKaTHj5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e4mm6sOU"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6B160140020B;
	Thu,  5 Mar 2026 15:35:46 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 05 Mar 2026 15:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772742946; x=1772829346; bh=KqzZ0NJWF5
	L54dBOidFLzUpz77YROJdmWAfDVjicDwM=; b=VZKaTHj59ROzdBxtUUx0Xp0m0t
	YTUwq/4O2uXU8UZgDS3ONTUlU6ISIugBGJvr7704OYrhGchQS0jXvI1cJfL1UYex
	hHbKGK9VInFdzoSUP/10Mi5I2EZjMM9ygwGm0EfxODfIlVOi6baOQvSKLI3w8T83
	vt5WpmTC5svlrEXJ29dl7qWE1id3dvVedewlwjOv5FwzMy655OHSv7keHzzobOut
	Vs7k0k+f60HHsB3D+OrrNqp3Id7UQ0Q1WfHLwU6ZRx9POGxDV5YDTA3HOc/ZCjjV
	0wMpJKfHIYdTni+II2HZI1cCxRk0qFry5JxIbm29YOUwc80bI3zQ9R3qIX+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772742946; x=1772829346; bh=KqzZ0NJWF5L54dBOidFLzUpz77YROJdmWAf
	DVjicDwM=; b=e4mm6sOUyhVNP5IIqNKmg40yfCj2zPVc96epn0BUN7oW33G5D4U
	/A5FSV6ZAd3sJ+RO2kmX15y/wkqYgngp81CgF9ujIBSEyy/VfusodJ+dUYf84uvq
	HeBRbDgLMEVEdKPMsIsDBu+elWBvi1DvHvjuk0xGRBz1f0ZLgVAIIwLc5QEYWPie
	DyBnienduueq147H2rszXb19MSuvW7FiJafY3l+0Z4pnpy+7GIaR9LPQ4e326psE
	qysq/pInT8Ouyh3GY9ehqYnj7diUcZ9VgQB7geKSX0t4uYyGSXxt7tvn/Gprd+nx
	JBL7GFn8sURRgskzimhFO6uWtrmt9ycL52w==
X-ME-Sender: <xms:IumpaRBC_eUn5-UteO6ouoZLb6kFxmGjuBwhUocw0oODkw-neHpG5w>
    <xme:IumpaWhBHqDUTV_QKTF4oxBqMjul8soMQRdy6WA-YcOgA6nIxUHba6sg5yuaIehsG
    MKTzOrZSs_-qbVYJ3--a3dEbH2nUF2gACAGGiIpG_-YYxHFSsaYnw>
X-ME-Received: <xmr:IumpaRlXb0XukSflrKXv5kHnD2FJREOA0daVWw11padorAzRIbBYzGUH7mNP0zOfP4LZ1BNAUJtXyLylq-OXJ4xJ-f94T6QcQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IumpaaqZ1GoyoM3bCdSJsGpeJRJKACE_vwHFPcXcWKZya-P-hQjL-A>
    <xmx:IumpaSFfjUAL2nb2LvC7vovSCDM31esp-lK0b7DbWu3BcKsVed0bdw>
    <xmx:Iumpaex0qx4wf7RaWKTxWUIsVXIAfmdWSKzEoE_QgerzWYZdW24lLA>
    <xmx:IumpafrjhxOMg9JE6xu7QCTs8tSA5KufY_9NHhLfW6aPdJQdAJM6CQ>
    <xmx:IumpafS_WkMT6OecoCfTioMxglb2nw1ZJ0uPmVGIRd2t4TH0Va6RVJ8F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 15:35:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH] Documentation: extend guidance for submitting patches
In-Reply-To: <20260305193836.973122-1-jltobler@gmail.com> (Justin Tobler's
	message of "Thu, 5 Mar 2026 13:38:36 -0600")
References: <20260305193836.973122-1-jltobler@gmail.com>
Date: Thu, 05 Mar 2026 12:35:44 -0800
Message-ID: <xmqqikba2evz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Before submitting patches on the mailing list, it is often a good idea
> to check for previous related discussions or if similar work is already
> in progress. This enables better coordination amongst contributors and
> could avoid duplicating work.
>
> Additionally, it is often recommended to give reviewers some time to
> reply to a patch series before sending new versions. This helps collect
> broader feedback and reduces unnecessary churn from rapid rerolls.
>
> Document this guidance in "Documentation/SubmittingPatches" accordingly.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  Documentation/SubmittingPatches | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

What's written in these two new paragraphs are all agreeable, but is
the first addition in the right place with correct mark-up?

This whole section is a sequence of bullet points that shows "a
typical life cycle of a patch series".  The first bullet point
starts with "You come up with an itch." and the second one is "You
send the patches", whose end part is what we see in the pre-context
of the patch, ending with "help you find out who they are."

If the new paragraph is meant as yet another paragraph to elaborate
on that second bullet point, wouldn't we need that "a line with only
a single '+' on it" before it, instead of a blank line, and the last
line of the first new paragraph should not be such a "single '+'"
line but a plain vanilla blank line?

> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index e270ccbe85..5acd692ad7 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -38,10 +38,23 @@ they have no obligation to help you (i.e. you ask them for help,
>  you don't demand).  +git log -p {litdd} _$area_you_are_modifying_+ would
>  help you find out who they are.
>  
> +It is also a good idea to check whether your topic has been discussed
> +previously on the mailing list, or whether similar work is already in
> +progress.  Prior discussions may contain useful context, design
> +considerations, or earlier attempts at solving the same problem. Being
> +aware of such discussions can help you avoid duplicating work and may
> +allow you to coordinate with other contributors working in the same
> +area.
> +
>  . You get comments and suggestions for improvements.  You may even get
>    them in an "on top of your change" patch form.  You are expected to
>    respond to them with "Reply-All" on the mailing list, while taking
>    them into account while preparing an updated set of patches.
> ++
> +It is often beneficial to allow some time for reviewers to provide
> +feedback before sending a new version, rather than sending an updated
> +series immediately after receiving a review. This helps collect broader
> +input and avoids unnecessary churn from many rapid iterations.
>  
>  . Polish, refine, and re-send your patches to the list and to the people
>    who spent their time to improve your patch.  Go back to step (2).
>
> base-commit: 628a66ccf68d141d57d06e100c3514a54b31d6b7
