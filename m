Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AF95C613
	for <git@vger.kernel.org>; Mon,  4 May 2026 00:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777855792; cv=none; b=Ba9P+S23wkOiBWFaiuZiBO19Zf82RG9HR8aq3lqQ53Yv2NCZxKeRkuKLuiPQK3vIfCR5VOASqblhYAeoYPq9JLhuhjhY4FlejVTTLmbcG1cRCcAnxkrZtL14Qv5Dzu3kisbecYRfKWeoFMDXr+zs8dZbL9KhtZidg76Gr6fF9z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777855792; c=relaxed/simple;
	bh=GyoZl42MXuj9iIPGKNL92S2QswWkwICZuD+jTPAMXH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kQmIrEC17/e1ZwXvYkodmMf2TrAGez5hHWLAVi4NPdqitvikCXjVajHIpGuMMdAsiyNytSPcSC7plGuw/MeO19Y7JWk85sSsEMwflzJW2sPLISmN5OCOukP+GbjyvaymOMkWjGnPotk3qMWVSqEHaxmlcX+gXSnEbLf0zwkKCHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wA+TogO8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OiwnJU4j; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wA+TogO8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OiwnJU4j"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 24CB87A00AC;
	Sun,  3 May 2026 20:49:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 03 May 2026 20:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777855789; x=1777942189; bh=M2qAP8mLXN
	hjvCJpvkyTMplUII/MA2jbEIL+klGCYbw=; b=wA+TogO82DRBX/vjF7Jo68Xtj9
	2lg2DmE2NaE4RSQRFOhdERqWjeojrhEGmLjKGIB1iZ7feZrdACj1BgW7eVJ2hNGO
	emxxPmiZSkFMZPV6a1n2mDmzv/mbaJ57crE8v/M8+EKK9DlFiwWdmJE182AXP/qq
	JoilGO4MNAEYFRiEFuEFxXrYE1lu/esutnNDNFRAaJU4it3UE4m6aIjH3TKX7RbG
	f7L7tgtRMSyo+Dqy0HzYxakO+AFDXZahA4hA/wNYEPKn+i1sYqtXObQMG2iXzDNv
	ajR8Unz4lkKT2PSQPZKmEmj1JsAbD9twHGzmiPlKk2O8Bt50dmTRcR3Ptxug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777855789; x=1777942189; bh=M2qAP8mLXNhjvCJpvkyTMplUII/MA2jbEIL
	+klGCYbw=; b=OiwnJU4jG/oZWliOLp/qhgY+JAPyodsRAsg5PCMzvN/1OaYkPlo
	GFw5X5s4WhNKYPcUDAwOBWpaw7hB5AoOlnuYhDHnh1OwrXYVVToHKhYqR/DdBtrc
	lCHHaUlF75LWfjI1ms+FN4SmhZl7qBkCIuKwxZ47TUIH5ZCSti56cvxJLdedJIgJ
	ZImV3Og0h3qvaCdWQoJoC9VxM9EjeqKqpjVUGASCquUgAP22GP9GCa0ngScRJnVc
	HaNZ2ztB0uuN+IiiDpGmva0jEotbjn3tr6QaWfdY2BRpOaJBayA/G3jMqqObdecR
	6C3XtLNlVcEnbEA3aQgTSwxz605CYSoj48A==
X-ME-Sender: <xms:LO33aYKsabSh5EZ-5Dd9IPi1YzOQIKdnlm_CDQwHH9dAdOQHXpaonA>
    <xme:LO33aei9PdiOfH_udUe3OOhszZMnhoaIu-6aSxvlEsw-OanTr0mRu0ldFfLktvJOW
    TNZSbCoblYIuG_FdHq5LuZFX43Soq_BOLeEYbr6NsUpMYm7Jy8>
X-ME-Received: <xmr:LO33aU9tuEnl-NTsT3CEzhKa4iBxkJoId3L8Ru3sPoj4YD5J9elh0os-7l5DEcw3bE0966CMFMI9IqwSwDuypMCZ-rGvBzWL8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeljeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehj
    ohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhs
    sggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:LO33aTMk_cFdoO6g4sBnnrCpj73iL3X0MD7p7Dr2cB4QgQWMTVsMXQ>
    <xmx:LO33aYBGPDm082BaJcSaXUqCpEnAzXTiHKXTPXMQ9NbfzxDQeIge1Q>
    <xmx:LO33aXNQq5HO45otuY7IHcxEcec0ZbD-XbCt3bXyfWlg01QIm4hn2w>
    <xmx:LO33afd1Kk7cfOO3YJDCZW8exxjOv2cl7KmSuNRkgy8aEL9-R8F3iw>
    <xmx:Le33aRLhrz17fdQ7AOq2mrSLJdxvbUTrpLoaYbbMc-5szoVYiWArxrMF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 May 2026 20:49:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  johannes.schindelin@gmx.de,  johncai86@gmail.com,  karthik.188@gmail.com,
  kristofferhaugsbakk@fastmail.com,  me@ttaylorr.com,  newren@gmail.com,
  peff@peff.net,  ps@pks.im,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/7] pack-objects: pass --objects with --path-walk
In-Reply-To: <29d2797440412bfec85be7b6a6439350b9ebf5e8.1777731354.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Sat, 02 May 2026
	14:15:48 +0000")
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
	<29d2797440412bfec85be7b6a6439350b9ebf5e8.1777731354.git.gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 09:49:47 +0900
Message-ID: <xmqqo6iwq9qs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> When 'git pack-objects' has the --path-walk option enabled, it uses a
> different set of revision walk parameters than normal. For once,

"once" -> "one" (or "instance")?

> --objects was previously assumed by the path-walk API and was not needed
> to be added. We also needed --boundary to allow discovering
> UNINTERESTING objects to use as delta bases.
>
> We will be updating the path-walk API soon to work with some filter
> options. However, the revision machinery will trigger a fatal error:
>
>   fatal: object filtering requires --objects
>
> The fix is easy: add the --objects option as an argument. This has no
> effect on the path-walk API but does simplify the revision option
> parsing for the objects filter.
>
> We can remove the comment about "removing" the options because they were
> never removed and instead not added. We still need to disable using
> bitmaps.

In the old code, there was a valid reason why bitmaps were not used
(i.e., "--objects" not enabled), but that no longer holds (i.e., now
we add "--objects" ourselves).  Do we need to give an updated
rationale to keep bitmap disabled?

> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  builtin/pack-objects.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index dd2480a73d..4338962904 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -5190,10 +5190,7 @@ int cmd_pack_objects(int argc,
>  	}
>  	if (path_walk) {
>  		strvec_push(&rp, "--boundary");
> -		 /*
> -		  * We must disable the bitmaps because we are removing
> -		  * the --objects / --objects-edge[-aggressive] options.
> -		  */
> +		strvec_push(&rp, "--objects");
>  		use_bitmap_index = 0;
>  	} else if (thin) {
>  		use_internal_rev_list = 1;
