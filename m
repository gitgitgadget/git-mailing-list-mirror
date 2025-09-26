Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBE734BA4D
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758908277; cv=none; b=IkdUJCOTCPNH2XN+R7OBo+qbaKqooeUiSRdqugdBLLF1HQGBXkejZcSHa8wDHeMR72jh8vEifis9fgJilCfi4ipSVW9/mKJo9RP1FQqQQLBhdJc9dnc1HwViFhhq3EpcGaK83uypG870os1ZtxkAMnQbjLPF7r89RigSW8QnOQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758908277; c=relaxed/simple;
	bh=uU/eIYnQcr0CM26JlbBo1ywTHZwsO+tAKohWmi7SMAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=snvLZxV388jh8LTVjAzwAZk6QZkcmRbNWULTpUSdaZMnR9UFQD8XyCIr/t3mobgsUwUwmIKN07AsN2yLbvCBetZQHTptrBV0LqqrFwl/GjkQJb8EqQhEo1V9+lYLEs/4Bq2oBW1olW+74CcNCpD2MYTAqmw0U4YGmYsX44ttW2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IlGLJFdd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eIXVAgfx; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IlGLJFdd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eIXVAgfx"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1489E7A00B7;
	Fri, 26 Sep 2025 13:37:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 26 Sep 2025 13:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758908273; x=1758994673; bh=1DwTJ6SZYD
	ZpQuKf3Uz+4YXDY0QBydJgsT7rSt3ygiQ=; b=IlGLJFddtdKrllpA4bWZbE80CM
	GWFbDksZ7Vc89zFmVL0Q7sFHfA5guBZJsegJjqhLaH/W0pQy6HKF33TA7kFaOfpC
	+a0GxQRxO9Jid0ia+JzPUg20WYGfZkN4BdaVKjhz6qQqaoNTFbPdHPHCUD3YVdqd
	DStb6p4jTZYseDkL4w8T1cyW+hbMULt77g/xnwFUy82aPCq/SLk8cG7EPDmv7kyx
	MECQaO4G+tc4iL2EnpESXhMLwk1Jpwvp7/rEzs0M5VbTUxekNeMYjr1Ynx34okXl
	O26m9sXZpFYHBNX9Otkw/CGY/yYiB0UFadEp6jB+l8gAWaS6zfah1rvWxGLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1758908273; x=1758994673; bh=1DwTJ6SZYDZpQuKf3Uz+4YXDY0QBydJgsT7
	rSt3ygiQ=; b=eIXVAgfxmgBai2OjCOP3MFEGiaea0moHLNq9MOruljh7AU3WAX0
	qzNPa9lKV5o2SfQYLbt1m4zfLa3pUi7BONoPIeDJtox5sO2R7DBOr5FsXiLZdKNb
	ed+IaerTPCa25lwfQeyPYqQezZ9N31/cGe5o8aZijOBtuqAS05YiUVkOS8uchSaR
	H7OyhFTErIREIGiKESq92aTN7MQLqtClMun+tZ9rRxyc6Be5TripAgj3e4/bC/IR
	/X7E/LtNz7Ks/rC/0ZFjZZS7ZvwuQE2GAIChN879F3MT+IvyR7rS+4PZubyci0+e
	6DYyqul6kN3A1X+Vi5GzgoNR79+nP8FsZ3w==
X-ME-Sender: <xms:cc_WaGbHEqySW6bkTuiWaJbvpM4lWyap96JJLWDSKEsvGKMWdciTRg>
    <xme:cc_WaCv6GU3rlr0qPWwk9CGRgEjBeyS8oQ-fhYHXzYR6G5QxbuUfo5agnxM-s1EBD
    Xn0VFtbdUAU1Tlr7rOa1T9zhQGYVuLPIcnXrATe4dqkMA0qEpROAqc>
X-ME-Received: <xmr:cc_WaIP163qGgUEYUGgZAgtDOyzNGdndQIGX-HBYuehhoQu9slvHt1vSKQNC79nm3hibnOOAhg_g14OF3MM2PRLw796-Vh24Wj_s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeileelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:cc_WaJ5Z_9LAx0jcxTndOsShhyuLSH3tc6kQdC40ug8AL0tJ4pBpJA>
    <xmx:cc_WaOSS7fDIKzDSbycHurzvlQ7WdCSkSIwqtD98nhKpvIAmKLA7PQ>
    <xmx:cc_WaGBnHihOPtHEFL63AY2JRb03bzIYTeGJJvASwn7USG1P-ipQTA>
    <xmx:cc_WaOEflt0GG8NtYecgkGfA_2fjyuDwH-s99YCWmtXWM-VBcUzadQ>
    <xmx:cc_WaFhVILpCyp_UcUnPQRIXziAWf10ZnA1itHrTOl2soBt6IMj6nxzs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 13:37:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 1/2] add -p: mark split hunks as undecided
In-Reply-To: <58689c52-d692-4a5f-8d55-478325bbd39e@gmail.com> (Phillip Wood's
	message of "Fri, 26 Sep 2025 11:12:22 +0100")
References: <pull.1863.v2.git.1757950144.gitgitgadget@gmail.com>
	<pull.1863.v3.git.1758813038.gitgitgadget@gmail.com>
	<4935dde39933744ecd957d84d3b71287fc274074.1758813038.git.gitgitgadget@gmail.com>
	<xmqq348agzpk.fsf@gitster.g>
	<58689c52-d692-4a5f-8d55-478325bbd39e@gmail.com>
Date: Fri, 26 Sep 2025 10:37:51 -0700
Message-ID: <xmqqseg9azdc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Junio
>
> On 25/09/2025 19:21, Junio C Hamano wrote:
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> ... In the case
>>> where the user only wants to change the selection of the first of
>>> the split hunks they will now have to do more work re-selecting the
>>> remaining split hunks.
>> In general, that is not just "first", as you can jump ahead, or just
>> keep typing "J" which is not all that hard, until you find the hunk
>> you are looking for, at which point you flip its status.
>
> Fair enough, I think that only applies to a single split hunk
> though. One you select or deselect it you can't walk though the
> remaining split hunks J anymore because you'll have been dumped at the
> next undecided hunk after entering 'y' or 'n'

If you have a single hunk for a file, you cannot split after you
selected that single hunk in the first place, and the change we are
discussing would not help the situation.

If you have two hunks, you select one (now the other one is shown),
you can "K" back to the selected one, "s"plit it, and then say 'y/n'
to deal with the first of the split hunks, which would take you to
that "originally second" hunk.  You can "K" back again to the last
of the minihunk.

I think the room for improvement of the UI we are seeing is mostly
outside the theme of this change under discussion, but enumerating
them may help somebody pick them up as #leftoverbits in the future.

 * There is no way to rework with a file once you decided sel/desel
   on all its hunks.  Even when you have multiple modified files,
   you cannot switch from the current file to another file whose
   hunks have already been decided.

   Perhaps introduce "Y" and "N", that allows a choice like "y" and
   "n", but does not auto-advance?  I think the current code takes
   "N" and performs "n", so this would be a backward incompatible
   change that needs to be designed better.  Perhaps when no hunks
   are in undecided state, show a prompt "What now?" that allows you
   to still navigate with "J" and "K", or go to next file?

 * There is no way to see what state a hunk that is on the screen is
   in.  If you remember that you came with "j" or "k" or deciding on
   all hunks in another file and you are automatically taken to this
   file, then the hunk is undecided, but if you came here with "J"
   or "K", you cannot tell if you decided to select it or deselect it.

   Perhaps tweak the "(3/5) Stage this hunk [choices]?" prompt and
   give this information?

The change under discussion somewhot helps the first one but only
when you have at least one undecided hunk in the file.

The latter problem is greatly alleviated with the change under
discussion on this thread.

>> So I like the updated behaviour very much, but I am reluctant to
>> pretend as if we are siding one camps of folks who think that
>> splitting a selected hunk is done with an intention to deselect most
>> of the minihunks most of the time, playing favors.  I think that
>> is a wrong way to frame the problem this patch solved.
>> In any case, I no longer have problems with the updated behaviour
>> with these two patches.  Thanks for working on them.
>> Will queue.
>
> Thanks, do you want a different commit message or are you happy to
> take them as-is?

Hmph, what would an improved commit log message would say?  Reword
the second UI problem above and explain how this change improves the
situation?

Thanks.


