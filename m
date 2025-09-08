Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F0E231C9F
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325306; cv=none; b=Hz55TlhkeHr3Liwr4qDOrzLI4fK+Qf+d9qPKc6iSATd6PshlJU4ytEiFZgifhAPTWo7NkddHD8t4Czn9U94VTQj8Mu1JKNyxBzk+izfYrwnIpq56Gm5m7uJt5FrJ7keBf6dzO2uqM6fRLPap2MTaEMxnZcg7wZ3Ie6ixtFazUEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325306; c=relaxed/simple;
	bh=q/SHz0otxHI4uZS4nrzhHC28tJ0Q1/atCL/dCqcPiiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVuRlqUO105J2PVaqsz6SYXKLhW7I7UtyBFWT6uukEz/YA6L6kzOuBMx3wEEtPEz2V1dbyJ3pYR9yUAjSIttkXqHnkDm9BzPrWiUaBTxQUqJMAk3p7P7Ayxn7TTXvs/hryk89ttrpT8iqv+ZhcU9mk8eZEL52/E/E6TNatrUAcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o9wXvnPI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nv9kvOdl; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o9wXvnPI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nv9kvOdl"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 48EB87A005D;
	Mon,  8 Sep 2025 05:55:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 08 Sep 2025 05:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757325303; x=1757411703; bh=Ix3dSwVo76
	cNc04XPZOzKldiZYvaGhIfomK4hZPui7A=; b=o9wXvnPI1R4eMRG/F5VBtJa4NB
	PqpEoF42puFzHhZe1jvRQpGUcD5LsrCQWdiFzHbz2LZqA3owXC4A2csECfcV4CzF
	O/j3lKkKH5FnNI4yMq/QLo087LJelh0X+bxfPidYXY0k4veUsFdQ4AZaKyqDib+5
	KYPRc+d1d7ALhpugUDYB0C2cf1fnmISEwvwM0GVtROJdDX3bR55UfNL401AdkItU
	ezVHqoYGoeggZleCSj4Aa/JJKM0U1Co+6dDv+OCoLs8NJFj1d8GnQF9qqzejcmXV
	exlwvomSkli8IhYk/gmgmUFAbLlr66cuKz0XDHrZeILuV0dH+ih/nEBMVvng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757325303; x=1757411703; bh=Ix3dSwVo76cNc04XPZOzKldiZYvaGhIfomK
	4hZPui7A=; b=Nv9kvOdl7cKhbM9Q3LnmcmcqT9PIywVQOqJp5xRZA8tWrLKzghX
	oTGrVyBAw5pHmqoD1CQSTewNULfHoZJnqN6rVJwMJIuBrCM3rnvElo6q0wWjAbjv
	TgbcnUufIiy/aSgVnoIHkQ6hJtkdBAGB5EXXaa2/4geDW4z7CCo6TZbnpoHp4Fei
	gEcdbLXOv/KEmHZ1loi3ZMRbgq7uRPu4IUuRzLlpAu2iPUitS1SP9ur9VvTtzc5O
	tA0x/hOXgEXquGCj+AOK3XjYG26dm7WKXzp5sTuP6r+vzFEAgp2vCooxpofxPbCd
	JN/+i3/OV9KDANyCLJU4w5Oj8ZQUbVT+Pbw==
X-ME-Sender: <xms:9qe-aFLBkaHNWE_WXqs4jBP1ymum-3uPNWkBGO79TrmcL-9q8YbPig>
    <xme:9qe-aM00_YWOA8IzAbV64j1byIfCh5JXVP7phh8GmOrlHxXHTYShzdyrBMRwhvQ-q
    qOJ_Q9VJyloopnccw>
X-ME-Received: <xmr:9qe-aKKqsC2j3e8CCdPYvxrT_N-C3Pr_rPj1JEURmkTYJFuN99FkJS9mnkFaimzTJnRYbOstzc6dTFd22aSR9m5OUpVtp3tn8PFVrKWhHX8GTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhn
    sehgmhigrdguvgdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:9qe-aPgK_FJUDdPu3RIqWI6Ei7eHKlGDSPR3NipqWn0Ti1WUlZQ8PQ>
    <xmx:9qe-aCDzzcy_R4jOUf8iMiv2EZWWxtixYFnB0bVJopn0kPcdUR9-Ww>
    <xmx:9qe-aJ6tX7ECKz277n3S1K5GtVAPDZyv-sylfsxHUileKiiNtOpoKQ>
    <xmx:9qe-aPHw0k_bnrYHhpzudaWLlKkIsZu__Ce-iLIx6DmfrPjtpqKyfg>
    <xmx:96e-aK8slMpm7NPg4c7EcuP_4qL9_J10qqNQktmuepRna3qAFVuKHsSQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 05:55:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3f20b346 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 09:54:59 +0000 (UTC)
Date: Mon, 8 Sep 2025 11:54:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Elijah Newren <newren@gmail.com>, Toon Claes <toon@iotcl.com>,
	John Cai <johncai86@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] replay: add --update-refs option
Message-ID: <aL6n8KEHSDii5Wd1@pks.im>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250908043620.57848-2-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908043620.57848-2-siddharthasthana31@gmail.com>

On Mon, Sep 08, 2025 at 10:06:19AM +0530, Siddharth Asthana wrote:
> diff --git a/builtin/replay.c b/builtin/replay.c
> index 6172c8aacc..a33c9887cf 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -284,6 +284,37 @@ static struct commit *pick_regular_commit(struct repository *repo,
>  	return create_commit(repo, result->tree, pickme, replayed_base);
>  }
>  
> +static int update_ref_direct(struct repository *repo, const char *refname,
> +			     const struct object_id *new_oid,
> +			     const struct object_id *old_oid)
> +{
> +	const char *msg = "replay";
> +	return refs_update_ref(get_main_ref_store(repo), msg, refname,
> +			       new_oid, old_oid, 0, UPDATE_REFS_MSG_ON_ERR);
> +}

Is there a strong reason why a user would want to update refs one by
one? If not, let's not add new code to our base that does so. This is
known to be inperformant for the reftable backend, but also for the
files backend in some cases. If we really want to support the case where
only a subset of references gets committed we should be using batched
updates with the `REF_TRANSACTION_ALLOW_FAILURE` flag.

> @@ -319,6 +355,12 @@ int cmd_replay(int argc,
>  			   N_("replay onto given commit")),
>  		OPT_BOOL(0, "contained", &contained,
>  			 N_("advance all branches contained in revision-range")),
> +		OPT_BOOL(0, "update", &update_directly,
> +			 N_("update branches directly instead of outputting update commands")),
> +		OPT_BOOL(0, "update-refs", &update_refs_flag,
> +			 N_("update branches using ref transactions")),
> +		OPT_BOOL(0, "batch", &batch_mode,
> +			 N_("allow partial ref updates in batch mode")),
>  		OPT_END()
>  	};
>  

So I think we should reduce this to only accept two flags:
`--update-refs` and a flag that accepts a subset of refs failing.o

We might also want to make this something like `--update-refs[=<mode>]`,
where `<mode>` could be "allow-failures".

> @@ -333,6 +375,14 @@ int cmd_replay(int argc,
>  	if (advance_name_opt && contained)
>  		die(_("options '%s' and '%s' cannot be used together"),
>  		    "--advance", "--contained");
> +
> +	if (update_directly && update_refs_flag)
> +		die(_("options '%s' and '%s' cannot be used together"),
> +		    "--update", "--update-refs");
> +
> +	if (batch_mode && !update_refs_flag)
> +		die(_("option '%s' can only be used with '%s'"),
> +		    "--batch", "--update-refs");
>  	advance_name = xstrdup_or_null(advance_name_opt);
>  
>  	repo_init_revisions(repo, &revs, prefix);

We have the `die_for_incompatible_opt*()` helpers for this.

> @@ -389,6 +439,18 @@ int cmd_replay(int argc,
>  	determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_name,
>  			      &onto, &update_refs);
>  
> +	/* Initialize ref transaction if using --update-refs */

Nit: the comment doesn't really add much context, so I'd just drop it.
It's generally discouraged to add a comment that re-states what the code
already says. Instead, comments should point out things that are easy to
miss or not obvious at all.

> @@ -445,10 +525,43 @@ int cmd_replay(int argc,
>  
>  	/* In --advance mode, advance the target ref */
>  	if (result.clean == 1 && advance_name) {
> -		printf("update %s %s %s\n",
> -		       advance_name,
> -		       oid_to_hex(&last_commit->object.oid),
> -		       oid_to_hex(&onto->object.oid));
> +		if (update_directly) {
> +			if (update_ref_direct(repo, advance_name,
> +					     &last_commit->object.oid,
> +					     &onto->object.oid) < 0) {
> +				ret = -1;
> +				goto cleanup;
> +			}
> +		} else if (transaction) {
> +			if (add_ref_to_transaction(transaction, advance_name,
> +						   &last_commit->object.oid,
> +						   &onto->object.oid,
> +						   &transaction_err) < 0) {
> +				ret = error(_("failed to add ref update to transaction: %s"), transaction_err.buf);
> +				goto cleanup;
> +			}
> +		} else {
> +			printf("update %s %s %s\n",
> +			       advance_name,
> +			       oid_to_hex(&last_commit->object.oid),
> +			       oid_to_hex(&onto->object.oid));
> +		}
> +	}
> +
> +	/* Commit the ref transaction if we have one */

Likewise here.

> +	if (transaction && result.clean == 1) {
> +		if (ref_transaction_commit(transaction, &transaction_err)) {
> +			if (batch_mode) {
> +				/* Print failed updates in batch mode */
> +				warning(_("some ref updates failed: %s"), transaction_err.buf);
> +				ref_transaction_for_each_rejected_update(transaction,
> +										 print_rejected_update, NULL);
> +			} else {
> +				/* In atomic mode, all updates failed */
> +				ret = error(_("failed to update refs: %s"), transaction_err.buf);
> +				goto cleanup;
> +			}
> +		}
>  	}
>  
>  	merge_finalize(&merge_opt, &result);

Patrick
