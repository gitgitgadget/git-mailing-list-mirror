Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDA0274B59
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764099576; cv=none; b=DuS4Mld2/RlpMSoXYeQDdm6isZxow2CssJIqpBP6ZM/J8UfBkj4ehGzVzufQdRBjeLsz5vjmQ6Tz3JIcjsFCSgmMkBedp42AEmBuzX9oq1pCev4KRU8xEWyNyHAZd1dFfw04AtWcYbEP+bQTagjjAXOLiZPcixmZse8YFUxZBig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764099576; c=relaxed/simple;
	bh=Jnj72ewEfDCB7xsVg8q+ju65QF0pZ6V4fhkWRv1Wn/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=roZ7tTTEFnddlkS6fWbylz3HqRQo0GKxp4yJVhG94574WOQ1RzeEWRXuv9Yh/vDeQPaU21DHuErqcSTANu9FSrH8lddFkqEquYwJArAyd5wB8DxTCvpxRErBlsNhapdE4dFR5hAykOW3/OobffHeHsOktY7C3FUNh/rtfEW+B8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J+vgECvG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cFBVDMxt; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J+vgECvG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cFBVDMxt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 573691400217;
	Tue, 25 Nov 2025 14:39:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 25 Nov 2025 14:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764099572; x=1764185972; bh=U7SYxFaUYA
	566nLs26JhiR00PcsnVLX9lmJ66TMH3eg=; b=J+vgECvGmjX6BnvWnL3tSq6GYC
	A3zRPko0COsvLZFbTcdhDHk20yARVimQEuKXU3mITGKRlg9PaLfCO41tpHIqV7/e
	LJA9Y/6Vsb3xOuvBe7V2NJEJcj1w8Azuw/9EcNZP7zoYxIF6VefnPQUzdXlEKYjO
	GMnTlEP3usfSpKvAO65hBUqJ4/iFcLPKh3WMN/AdUNqnapwovjaq3g+aKcpj1NJl
	TH6VSdudgi066uaTiWOYNWTOp+92mjYP2bcGe9ED2mm55ZhXqiJjGSgDlgKa6cI+
	1kQSP0i/GkallYEEpniDLQvzuoNqT8Y2/76ZR11k9GkxACirZFJsfPr+UIWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764099572; x=1764185972; bh=U7SYxFaUYA566nLs26JhiR00PcsnVLX9lmJ
	66TMH3eg=; b=cFBVDMxteUlF3ajAzR9J8hRq/ynuef0B/tMzoqdj7xylDwJHDbb
	9mF0gBt2c02TSDqTV3dosRR/P/mZl97G+qLYdwlPQi4bHmRSjZw5f1cqj/e97fXB
	5/LsS3gwoHWZVroXvc48r6GSR1xnfhBZkMSOVQPYLu6tgkLFDhLy/meP+0uYWZgs
	SknDlykWq92HPA92H4/XR0Ay6SLmip0GETLQ2qFUFffKhIZphi1hbLWR1eljyvXp
	yfEABXw4pVAFUT+c9nn6KIy66GonDb0VR7fuEiVRTIDz/WYS8MciODG1sBlMrB6h
	OuAia7u8LHv0e3IvEqVTdYedw2IVArFJduw==
X-ME-Sender: <xms:8wUmaUvwl9t-GyG0VpH6UQf-YqbDQDmsA9X6-OO5mYjEfw_b7GB6hA>
    <xme:8wUmab3G7RdqdceoRnM7PS2b7qYS7TgL7LGao2qF5kbIv9M-aX3kLqDhlp-fxNUuJ
    bYAOz1NIRn0fbzOvmCzJclMJM2xQSn50ekYHlFc_-ODGcV07yIf6g>
X-ME-Received: <xmr:8wUmaV4MzpniwElUi8f5lis1aQ642JsxoOShCIGOBm9h_zakLJ1d0McujMbv_oI4CWu_LSyTVRTN3PdXYDQ_Cmx_4ixt7qL2sCA_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedvfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephefhkeefkeeiveelveekveekkeelgedvvdelgfeuhffhgffgieffjedviedv
    gfegnecuffhomhgrihhnpehsvghquhgvnhgtvghrrdgtfienucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghouggvsehkhhgruhhg
    shgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:8wUmaSXc5qGAIFZ8uay_LTYJZKvSwfx5p-Rg-g3BHG1E9plNC3Jhkw>
    <xmx:8wUmadj-W_W073UgBrZEl54hdrNslZsJSehY3slsMQJPHIB7MpYQ7A>
    <xmx:8wUmaScF7JFoJXnESbjFLDvfHv6P2H7GAq-XPZrR5IxmXo_D2FVLsw>
    <xmx:8wUmac2r9iAFRfTvJ1FXPVVoUWwOGHemVretUoCy34dMv7QiSTDt0w>
    <xmx:9AUmadIxgoD1nDQt_Q2Z69Bend67ka2SSKW4XD1TObcpXEPSXpfseJ65>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 14:39:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  newren@gmail.com,  phillip.wood123@gmail.com,
  phillip.wood@dunelm.org.uk,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH 1/1] replay: add --revert option to reverse commit changes
In-Reply-To: <xmqqo6oprjti.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	25 Nov 2025 11:30:49 -0800")
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
	<20251125170056.34489-2-siddharthasthana31@gmail.com>
	<xmqqwm3drk6m.fsf@gitster.g> <xmqqo6oprjti.fsf@gitster.g>
Date: Tue, 25 Nov 2025 11:39:30 -0800
Message-ID: <xmqqjyzdrjf1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> Dedup with do_pick_commit() where this was taken from.  Possibly in
>> a separte patch before the main one.
>
> Forgot to attach this at the end.  What I meant was that something
> along this line may be a good starting point.
>
>  sequencer.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git c/sequencer.c w/sequencer.c
> index e6d82c8368..29909952d4 100644
> --- c/sequencer.c
> +++ w/sequencer.c
> @@ -2365,20 +2365,8 @@ static int do_pick_commit(struct repository *r,
>  		if (opts->commit_use_reference) {
>  			strbuf_commented_addf(&ctx->message, comment_line_str,
>  				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
> -		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
> -			   /*
> -			    * We don't touch pre-existing repeated reverts, because
> -			    * theoretically these can be nested arbitrarily deeply,
> -			    * thus requiring excessive complexity to deal with.
> -			    */
> -			   !starts_with(orig_subject, "Revert \"")) {
> -			strbuf_addstr(&ctx->message, "Reapply \"");
> -			strbuf_addstr(&ctx->message, orig_subject);
> -			strbuf_addstr(&ctx->message, "\n");
>  		} else {
> -			strbuf_addstr(&ctx->message, "Revert \"");
> -			strbuf_addstr(&ctx->message, msg.subject);
> -			strbuf_addstr(&ctx->message, "\"\n");
> +			sequencer_format_revert_header(&ctx->message, msg.subject);
>  		}
>  		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
>  		refer_to_commit(opts, &ctx->message, commit);

By the way, I probably would not be queuing this version today, as
this has obvious conflict with a large code movement made by
Patrick's "history" series, which itself is expecting a reroll.

Perhaps collect review comments on this iteration a bit more and
wait for that other topic to be rerolled, and if it turns out to be
solid enough, base a v2 of this patch on top of it?

Thanks.
