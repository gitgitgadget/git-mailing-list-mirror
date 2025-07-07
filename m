Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3096186A
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751927074; cv=none; b=LUybAHh4ahgWpYOFKh1anQj9a3lt41EJgbYREJbCo4l0R2zddokzTDz5FCfFvxHepgcxgfM1WTQbDYAN6ytAyKevg0Msy0kJwpnQ8EuwRbUv5pT6r/lrnXB4ojG05lUIXWpJNsc90WnbAUR8+xOSHLkc+4BYGpXJfaSMoGtqQ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751927074; c=relaxed/simple;
	bh=SKLMj320irgC9gALcx7ibsBoX+Ooz94mfYfIBSJuU7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MP1skIcinQzawsI9LPRJu6fUzlzsTKIVTbBq9MOK8KL+QiwkcIp7e72L8LakDOOJiM9iiO6SguntjG95ap2hXeYXiZjvDCEpRm/UoeKn5sKBDLYinskCOc8uYI6dB8Stp6vjrfVjbF6z0h886QgOC5JRnyyOFxDCfYC+/eDRQvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R3TX73dT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N96U9XCI; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R3TX73dT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N96U9XCI"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2DF14EC0BAE;
	Mon,  7 Jul 2025 18:24:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 07 Jul 2025 18:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751927071; x=1752013471; bh=8iLkRCbwuJ
	Z9fG9KuVo+lpdMbr1tsrXOu5n8yvu1A5U=; b=R3TX73dTLgA3QpIxf7Dd9zrLsX
	U8SUSt0bIZuctik69hVM2H8f/ynVbBeYr35u/9QJrJ67pzxJrFS0Z2HM6ebD+cDu
	ix4ehO5SL2+DOJxcXAnENR8kRqV62clY99G+tPTAsnL/YmkB+Zfy9FlMnfaXJxeM
	7UBLXGn9fdarjAvvOxfGVWRGu2bAxWF2numV4QP1n/tBpVk13l/evzzqdDKMYpDQ
	ZmDUskCdMbpSttyezWtu+TJ8+twMfBWPbKIS8cgb5crdrgt1NEMPNXuI2i9Rui9F
	trIVSL6VDJaVgGeUTIbRxSOpKymiOAJmWvAp/ObIzgM/Kj5otGjO7zlI8CxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751927071; x=1752013471; bh=8iLkRCbwuJZ9fG9KuVo+lpdMbr1tsrXOu5n
	8yvu1A5U=; b=N96U9XCIAR5Q/XWLIsZaaP8NdwAIlLIB45wM97NNjTJO5v+LKx2
	OMdglZTKgfgElJtaIr/1dJlbrFU/v7/gFHRXnBtFn6OHsn3OCmi/Q3081xSqtoQM
	y2EpOlfaLmwHAJP4XlvyIqdwTbL6Tg4EuLtC1bMxr6orNvSVU/HyN2kycuwUNDuR
	YVbb75pWnzthjXycwl0H6MHA54ECGcpydlwQC20kQGZPQvXgJSYRkDXtLyAMwWeo
	hR6snGTvZHTKcFD7fjcUHbsAS6XX+B13A9hj+bt0e2czaGAWkGIGjv8sO+4+4urM
	EU82tiGdmi4yKVffO36bbYoezauiVKRj+CA==
X-ME-Sender: <xms:H0lsaH_UC_k8Ky0-lwis-u7XtqpBt3mn6rZuJEpPIkjL5_ozjpVtmg>
    <xme:H0lsaG-cheaeG_pBXTT_iPxCcoIn1yk5Rv7HukvhddaJk1dkVdUjXyq0OcuoWxPrl
    jERPxb5LQvQhEzvug>
X-ME-Received: <xmr:H0lsaOfYjZJc81Y3cw5JXmwmCFKaMXnlRLJtesN1js8QrAoTQnWBcRMDJh0FH_of5MBI_5-YbST3NJSisxFtZMV4z8ERhQqI2jGq3KE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvdellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevgfdvjeejkeelheelgfevtedukeetfeekffevvdekhedttdfhhfevteejheev
    jeenucffohhmrghinhepthgrghdrtgifnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhruges
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:H0lsaPFfmogvnwQYkizv7JB8VSAqW2HWq-PcQNLaE195rHiQv4v9BA>
    <xmx:H0lsaMfgqlYTsfbzEUr9uNtJ---UbmntZ5V2WDJJGnaL7--ZRcrAZg>
    <xmx:H0lsaJGI-6NfLGj_gk9TROq-dNIXKvifcDU2z0EJvy_Q77vdK-nC8g>
    <xmx:H0lsaFUsptXgOljjc4ZvDr9xHVldVR-3Wz3oaq8Zz97TgdSoWkaRyw>
    <xmx:H0lsaLlR4VvdH5IJ9s74Nc0cT0Ls-Y34x5PafOZ_sYmhw-Wvrqqy3Auc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 18:24:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: M Hickford <mirth.hickford@gmail.com>
Subject: Re: Suggestion: error "tag ... already exists" should distinguish
 between tagging different or same commit:
In-Reply-To: <xmqqzfefodje.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	10 Jun 2025 07:51:33 -0700")
References: <CAGJzqsnvTnp3k8Ab2exaBAw5pszQRz00UcucnK=ECtY5vhG+1A@mail.gmail.com>
	<xmqqcybcrc2u.fsf@gitster.g>
	<CAGJzqskj803dUcEuV+P-yuWdT0tiaidb7h3YxQSCgYHWgBfaWA@mail.gmail.com>
	<xmqqzfefodje.fsf@gitster.g>
Date: Mon, 07 Jul 2025 15:24:29 -0700
Message-ID: <xmqqfrf73ahu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Or simply something like this.  I am not convinced (yet) that this
> is a good idea; I merely is showing that the implementation would
> look like this.
>
> ----- >8 -----
> Subject: tag: allow idempotent "git tag" without "--force"
>
> When "git tag T O" is told to create a tag pointing at an object O
> without the "--force" option, it refuses with "tag T already exists",
> even when T points at O (which makes it a no-op).
>
> Let's allow this "idempotent" case by special casing.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/tag.c  |  2 +-
>  t/t7004-tag.sh | 12 +++++++++---
>  2 files changed, 10 insertions(+), 4 deletions(-)

As I see nobody biting, I am inclined to say that this is not such a
brilliant idea.  Let's chuck it.

>
> diff --git c/builtin/tag.c w/builtin/tag.c
> index 4742b27d16..5380a46494 100644
> --- c/builtin/tag.c
> +++ w/builtin/tag.c
> @@ -660,7 +660,7 @@ int cmd_tag(int argc,
>  
>  	if (refs_read_ref(get_main_ref_store(the_repository), ref.buf, &prev))
>  		oidclr(&prev, the_repository->hash_algo);
> -	else if (!force)
> +	else if (!force && (create_tag_object || !oideq(&object, &prev)))
>  		die(_("tag '%s' already exists"), tag);
>  
>  	opt.message_given = msg.given || msgfile;
> diff --git c/t/t7004-tag.sh w/t/t7004-tag.sh
> index 10835631ca..9a253a44a8 100755
> --- c/t/t7004-tag.sh
> +++ w/t/t7004-tag.sh
> @@ -126,7 +126,7 @@ test_expect_success 'annotated tag with --create-reflog has correct message' '
>  '
>  
>  test_expect_success '--create-reflog does not create reflog on failure' '
> -	test_must_fail git tag --create-reflog mytag &&
> +	test_must_fail git tag --create-reflog mytag no-such-object &&
>  	test_must_fail git reflog exists refs/tags/mytag
>  '
>  
> @@ -183,8 +183,14 @@ test_expect_success 'listing tags using a non-matching pattern should output not
>  
>  # special cases for creating tags:
>  
> -test_expect_success 'trying to create a tag with the name of one existing should fail' '
> -	test_must_fail git tag mytag
> +test_expect_success 'recreating a tag without --force' '
> +	# light-weight tag pointing at the same thing
> +	# now succeeds
> +	git tag mytag HEAD &&
> +	# light-weight tag pointing at a different thing
> +	test_must_fail git tag mytag HEAD: &&
> +	# creating annotated tag, pointing at the same object.
> +	test_must_fail git tag -a -m anno mytag $taggedobject
>  '
>  
>  test_expect_success 'trying to create a tag with a non-valid name should fail' '
