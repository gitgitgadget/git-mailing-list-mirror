Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E782045C0B
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 20:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756846679; cv=none; b=YA21AS+qcjJkq0FVlrlr8oghRP0nB62ynRC8JRTHibhYsQtHSOfWu28H5Hd/cqkiCb43JZ1A4H1yZQpRcR++T/TBfgWwK2vaH9Vgfu6o4ZBAyHZrmUYCApdLyz3D2d7T50v3aTCqnCWmvtqGm7lUti9HbF0eqC1TLl0LOAIiVfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756846679; c=relaxed/simple;
	bh=MP7penrRIPU72/xGXIN3Kx2TA/Sk5awzj2zra8fa8j4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pb3a4b04EfL0qOfRT1XebhJZ38sCZN2r2SXoe9GMDCqNDTbhJx1kfL7r+deaqJUXEwSaXOxMBAdm65bB2Rbi/KBI3I4E7lEpNv20FX/lcG8negMvcvgnOqHEW4P9vNLtHQos/kqGPbOEudbrg/JpV7q4YxvYCBYkzIKVqqMmpEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NYi9fqUh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZiIyRh31; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NYi9fqUh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZiIyRh31"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id F2364EC04CD;
	Tue,  2 Sep 2025 16:57:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 02 Sep 2025 16:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756846676; x=1756933076; bh=bsmrgwLnsh
	51q8w3jcZcYGGR2uVCc+2vyQVM4UgACGo=; b=NYi9fqUhdIrDg1NekNWpPlqDLP
	qXe6GCgC1NB+sptlz3w8qsPry9FCSW36iikrSCrT31k4PbvPD34J0XQl6t/xl752
	3h479Sj4tc35HLm8wn7sR4o7jCQr0aE3pN/6aAx2S0JKoY27xx7tWSV0rHgh9DdZ
	yd6QRLbAsXGPQ6B0qsJm6NmnRt1zO/ANNXqvIr10snA7NERcWUdoLKekScFgPLAW
	eXUvCLDFTdki/x3/rlfoEjAE4ypaC5vo+8tqn9YuIwKqe3nulvuBr0xBFDK5KTqr
	kv7Hn5Ymm1x8ZUD3t2KFu3odXr/RqgByB03sh0IiNy9Nd76L1fGW5KZw58dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756846676; x=1756933076; bh=bsmrgwLnsh51q8w3jcZcYGGR2uVCc+2vyQV
	M4UgACGo=; b=ZiIyRh3158TRxWgp0x2vDz47R3iylq2zTXNLE0fCsQB4osSc8P6
	cRZk/PT6mLKCDG7uvPDzwlOxzOuXn4s+6rkfYxcNOoANwEC+BgnzCPkvmlwkth/k
	qTtXiePEEZw8NZmo+Fhyhy56Ui3gvxIKt/uCBLDlxTI9kV3BHrzhSnoMzsI3lUFX
	h86wfEjmJzaj1Bo2GI0My2XAk0evfwM7pLuS889MrPXXcOeL6KZa4hpVtdmYa5DR
	XTpkiTVAiFsClDuphTkWcJ4zqpyErWfWHZ49/NiuFuZaxjebG7pEd9M9R+KYa8ld
	ec34WqCBDID393UCGw9azGuSIPFhQWpaZKg==
X-ME-Sender: <xms:VFq3aBPd-ooVGjCvXaJdZC2H1Xziz8QpQ3UM4Txmra2jK4nO2-jCmQ>
    <xme:VFq3aOhA3UQuBk6CF76SGclDgc5MXy00kUZWlDZMIRugoyJozMAiB_3DE-yjbgtF_
    FHFsqeyvAmNAOtF5Q>
X-ME-Received: <xmr:VFq3aM0ghfm1tMp7GS3NcXunaywEiaTDeMqWR8HxSRW9th2FsTUN9FLhOhJ6B2C5hU15GktBhXIOwYfh3MHSMfX2fRYv4GVtMR5IIVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VFq3aAhbZIkERkxGiogJBCkb2hxEyIP-LA7Tc7WPNpzAiAyeXEGEnA>
    <xmx:VFq3aEdAetOMU0yki0XdPjJj59T_oCR3s95ce6T_S2OYYEE69N504Q>
    <xmx:VFq3aLk7LDxewK7mlowg5kcYXytIroN97YLwSIn1Ksy41M4WlNLd0w>
    <xmx:VFq3aFuKNvSHiOYYGtIgd6ywi01Ks7_A8OLiLf6xWkPml-A3sxysdQ>
    <xmx:VFq3aNGsbs8ZtOwFu8cG69Ywdg3EP2WPsOV8TZIIRDl0akjF2caSNqmz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 16:57:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] t0450: add allowlist for builtins with missing
 .adoc
In-Reply-To: <xmqq8qj3rqgn.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	28 Aug 2025 16:12:08 -0700")
References: <20250804073002.1586332-1-toon@iotcl.com>
	<20250808095943.3312265-3-toon@iotcl.com> <xmqq7bzdfoxe.fsf@gitster.g>
	<aJs5D2jPh8Uom96p@pks.im> <xmqq8qj3rqgn.fsf@gitster.g>
Date: Tue, 02 Sep 2025 13:57:54 -0700
Message-ID: <xmqq5xe0incd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>>> > To ensure no new builtins are added without documentation, add an
>>> > allowlist: t0450/adoc-missing...
>>> > ...
>>> >  t/t0450-txt-doc-vs-help.sh | 8 +++++++-
>>> >  1 file changed, 7 insertions(+), 1 deletion(-)
>>> 
>>> Forgot to add something?
>>
>> Indeed. Toon is currently out of office, so I had a look at what it
>> takes. The below patch is what I ended up with -- note that I also had
>> to reverse the `grep` condition to set the prereq in the else branch.
>>
>> Let me know whether you're fine with just squashing these changes in or
>> whether I shall send another version.
>
> I've marked this topic in the What's cooking report to be expecting
> a reroll after 2.51 final gets tagged, which has now done.  If the
> fixup! sitting at the tip of the topic is good to Toon's eyes, then
> I can squash it in and mark the topic for 'next' without waiting for
> a reroll.  If not, please do send in a hopefully small and final
> update.
>
> Thanks.

Toon, did you have a chance to take a look at Patrick's update?  Can
we move forward by squashing it into your [2/2]?

Thanks.


>
> From: Patrick Steinhardt <ps@pks.im>
> Date: Tue, 12 Aug 2025 14:52:31 +0200
> Subject: [PATCH] fixup! t0450: add allowlist for builtins with missing .adoc
>
> ---
>  t/t0450-txt-doc-vs-help.sh | 17 ++++++++++-------
>  t/t0450/adoc-missing       |  9 +++++++++
>  2 files changed, 19 insertions(+), 7 deletions(-)
>  create mode 100644 t/t0450/adoc-missing
>
> diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
> index 980130be78..e12e18f97f 100755
> --- a/t/t0450-txt-doc-vs-help.sh
> +++ b/t/t0450-txt-doc-vs-help.sh
> @@ -112,16 +112,19 @@ do
>  	adoc="$(builtin_to_adoc "$builtin")" &&
>  	preq="$(echo BUILTIN_ADOC_$builtin | tr '[:lower:]-' '[:upper:]_')" &&
>  
> -	# if and only if *.adoc is missing, builtin shall be listed in t0450/adoc-missing
> -	result=success
> +	# If and only if *.adoc is missing, builtin shall be listed in t0450/adoc-missing.
>  	if grep -q "^$builtin$" "$TEST_DIRECTORY"/t0450/adoc-missing
>  	then
> +		test_expect_success "$builtin appropriately marked as not having .adoc" '
> +			! test -f "$adoc"
> +		'
> +	else
>  		test_set_prereq "$preq"
> -		result=failure
> -	fi &&
> -	test_expect_$result "$builtin appropriately marked as having missing .adoc" '
> -		test -f "$adoc"
> -	'
> +
> +		test_expect_success "$builtin appropriately marked as having .adoc" '
> +			test -f "$adoc"
> +		'
> +	fi
>  
>  	# *.adoc output assertions
>  	test_expect_success "$preq" "$builtin *.adoc SYNOPSIS has dashed labels" '
> diff --git a/t/t0450/adoc-missing b/t/t0450/adoc-missing
> new file mode 100644
> index 0000000000..1ec9f8dcf3
> --- /dev/null
> +++ b/t/t0450/adoc-missing
> @@ -0,0 +1,9 @@
> +checkout--worker
> +merge-ours
> +merge-recursive
> +merge-recursive-ours
> +merge-recursive-theirs
> +merge-subtree
> +pickaxe
> +submodule--helper
> +upload-archive--writer
