Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C94161313
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 21:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728509830; cv=none; b=Bvpv7VFMjOPWmrQkHvqhg+PjLzS55KwMf2WyXZjkyt1EQLJGBvqpY+q+jxl4JGV4vkx2IbsTjWNjC5qUGzetqk/CdBSKmwuZcoRwx/MJ5Helvt/RYbSRcdYNAh3NmJWl2WVxSsmmbwf6TVjkX8+aD5WL+T+7HbM4KbLMAQP25r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728509830; c=relaxed/simple;
	bh=Do4BMrYX5hGQFWgED+T54j02w2PMgY5PSWtsS4wj43k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sitwm99lftBLpmrYU4wASMDAKiCDfcTz7Am31APZz4P1KIUliUwE7WVNOg5V0B3xXJUuATNnA/LyoaF4d4B7f0OQoynV8kSA5jhqkFeum0jx6pwwji4hy7acFAl27DLGNZSI151DNQLQJYw1TVdC8z4/YH/AxG23AQFlLgvQruU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uKV+UwmA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VO3QoUcG; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uKV+UwmA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VO3QoUcG"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8622F138044B;
	Wed,  9 Oct 2024 17:37:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 09 Oct 2024 17:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728509827; x=1728596227; bh=uhdhp0MHrR
	dbKq+G7j6DY9auXKZlYvdRCzbvl7OQW4Y=; b=uKV+UwmAsbZwQtqygMRuNl37kl
	lKGsLwJqQ7TAiKzGy0ExIk1ZqG4DaDX8z5/Y5nj0TZUXs7cNCwa8d2YVq1rlzLUc
	ibRtcmxZEowyRisGBLVjNBJV41YF7Edn6TNkFcDJtjr0KvCdCshpwQUcxed8CsAn
	mhVM/HQ6uQpF1/QH2+9Mhhlg9VvVHAbZv5s/3Dk2uf17Mh0yPYm3c5EzwUbVvtSB
	KmY3CcLSbElj44IUPCz5q4gpvRjUlsiXrMfKBjFT1EuUQqE0iBRpWNMVssPv88vz
	Mbf/6VwLifm4jBu6vhaafyAz2GFF06sNNB5Hlw/qFgP1RxZ+ZHvIukN5tgQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728509827; x=1728596227; bh=uhdhp0MHrRdbKq+G7j6DY9auXKZl
	YvdRCzbvl7OQW4Y=; b=VO3QoUcG02szQmuer8IXAD+6sQ8XXJqJiSw4p1TW9wUj
	gNjY0BmlLf7cue5hbsGK5rMYmX6mSg5kmBxaZFJ/QuWIKL2O1Dm/ijc+VZWVdjRk
	5xP+c+GJf4m1nL9eDJN2M1M8GejjVMfyQ1V49jr1gzevgWH1zk4oZPNOwSSBvZ0B
	BP8UXtqSp1o0+f6V/4+Av+KLI7JouLBDDLmIDrtOnjbPQOkFp2+HKHL/FeVIgwu3
	rJFWBzjFpgSMguRk7JRU6U+oPDcAEu2OAt3aTGyOXEvrnFTWJYJMdiAai9nEKPlX
	Q6+LATQ4W8vV5PSx4pCuvhOx2N9BD71qKYapJ2MoUg==
X-ME-Sender: <xms:gvcGZ91Hqs8PRbZG3I5Eb60meJZaV_nF3V3J2ycLIeE991dOOZSoLA>
    <xme:gvcGZ0FDw5UcdOIfKDVMOv1gxMP_etkMhAYVeRkVkkYLA08i9kct2m78zhgkjzUDC
    T07X48Sx6iXjtO0jg>
X-ME-Received: <xmr:gvcGZ95g3IdVAGTZDbGB6QavxWHybpdDVKIJULcibOqOk7XIPQ2_aNCTZvqs24Stuiq4exOmN0I4NIzB_7yZ3YVJYILRkuBEIMV1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhr
    ohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueff
    teeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthho
    peejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvghrughinh
    grnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehlrdhsrdhr
    seifvggsrdguvgdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:g_cGZ60eaO10Jp8FUfTMMHfTnuxDmULf_FwOyVTDYMt-yhbJAgt5ew>
    <xmx:g_cGZwFCpCqbzuj9eFnWTl5QYnom6qRDsdFL_R5ZJN78lSgZKTG3qg>
    <xmx:g_cGZ7-cD_OiAmoZZnuuGgfUC9yQ5RvvSvTpEYUCbGiSrZTyaJHfdw>
    <xmx:g_cGZ9noKhn4TEL_01i0wVLiADOhTahaY9ereErhsVIVjjvTNr_JGQ>
    <xmx:g_cGZ70f-Fhz-6eDqESXnhSSwnhNBx5Z00jDHhfg369UmqCQXG1Gq9pU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 17:37:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk, 	Taylor Blau
 <me@ttaylorr.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Johannes
 Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 5/6] refs_update_symref: add create_only option
In-Reply-To: <20241009135747.3563204-5-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Wed, 9 Oct 2024 15:57:27 +0200")
References: <xmqq1q0xhu13.fsf@gitster.g>
	<20241009135747.3563204-1-bence@ferdinandy.com>
	<20241009135747.3563204-5-bence@ferdinandy.com>
Date: Wed, 09 Oct 2024 14:37:05 -0700
Message-ID: <xmqqiku1ot4u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 6c87690b58..3c9bc39800 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -559,7 +559,7 @@ static int replace_each_worktree_head_symref(struct worktree **worktrees,
>  			continue;
>  
>  		refs = get_worktree_ref_store(worktrees[i]);
> -		if (refs_update_symref(refs, "HEAD", newref, logmsg, NULL))
> +		if (refs_update_symref(refs, "HEAD", newref, logmsg, NULL, false))
>  			ret = error(_("HEAD of working tree %s is not updated"),
>  				    worktrees[i]->path);
>  	}

Didn't somebody tell you not to use "bool" in previous rounds of
reviews?

We are still smoking out platforms that have trouble with the type
by using it only in a tightly controlled weather balloon we raised
in 8277dbe9 (git-compat-util: convert skip_{prefix,suffix}{,_mem} to
bool, 2023-12-16), if I recall correctly.

Assuming either (1) I forgot that we are OK with bool everywhere, or
(2) the patch will be updated to use plain 0 for false and
everything else for true, let's keep reading.  I as a reader expect
that some *.h file will tell us what the new parameter means.

> diff --git a/refs.c b/refs.c
> index 91cacee6f9..3d2c07dd67 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2115,19 +2115,32 @@ int peel_iterated_oid(struct repository *r, const struct object_id *base, struct
>  
>  int refs_update_symref(struct ref_store *refs, const char *ref,
>  		       const char *target, const char *logmsg,
> -		       struct strbuf *before_target)
> +		       struct strbuf *before_target, bool create_only)
>  {
>  	struct ref_transaction *transaction;
>  	struct strbuf err = STRBUF_INIT;
> -	int ret = 0;
> +	int ret = 0, create_ret = 0;

Isn't it sufficient for create_ret to be in the scope deep in
the nested if/else where it is used?

>  	transaction = ref_store_transaction_begin(refs, &err);
> +	if (create_only) {
> +		if (!transaction ||
> +		    ref_transaction_create(transaction, ref, NULL, target,
> +					   REF_NO_DEREF, logmsg, &err)) {
> +			ret = error("%s", err.buf);
> +		}
> +		else {
> +		    create_ret = ref_transaction_commit(transaction, &err);
> +		    if (create_ret && create_ret != TRANSACTION_CREATE_EXISTS)
> +			ret = error("%s", err.buf);
> +		}
> +	}
> +	else
> +		if (!transaction ||
> +		    ref_transaction_update(transaction, ref, NULL, NULL,
> +					   target, NULL, REF_NO_DEREF,
> +					   logmsg, &err) ||
> +		    ref_transaction_commit(transaction, &err)) {
> +			ret = error("%s", err.buf);
>  	}

Style: in if/else if/... cascade, opening and closing {braces} sit
on the same line as these keywords, i.e.

	if (create_only) {
		if (...) {
			ret = error(...);
		} else {
			...
		}
	} else if (!transaction ||
			...) {
	}

But more importantly, I think it is much cleaner to handle failure
from transaction_begin outside the if/else cascade.  i.e.

	transaction = ref_store_transaction_begin(refs, &err);
	if (!transaction) {
        error_return:
		ret = error("%s", err.buf);
        	goto cleanup;
	}

        if (create_only) {
        	int create_ret;
		if (ref_transaction_create(...))
			goto error_return;
		create_ret = ref_transaction_commit(...);
                if (create_ret && create_ret != TRANSACTION_CREATE_EXISTS)
			goto error_return;
	} else {
		if (ref_transaction_update(...) ||
		    ref_transaction_commit(...))
			goto error_return;
	}

cleanup:
	strbuf_release(&err);

	if (transaction) {
		if (before_target && ...)
			strbuf_addstr(before_target, ...);
		ref_transaction_free(transaction);
	}
	return ret;

I didn't spot any caller that passes "true" to signal that it wants
the create_only behaviour in this step.

Which is OK---let's keep reading to find such a caller in the next
step.


