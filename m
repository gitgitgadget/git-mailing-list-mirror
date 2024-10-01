Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF811BCA19
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727809842; cv=none; b=dzUIvaYEoLAHz8GAwgskIsgtxxxFIgtuk6gV6MMsQKWZfjTKhsAWbIQkHMt5VxPnDHXk3yZ4ld/w98109M1b9yGCuTbNkAs9qmZiBXWJYjgYnT/g3cuYoBR1ggofnmV0q2JbWxssN1q51ye60ZppcE2id4cMArgW1YbGYtx1qqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727809842; c=relaxed/simple;
	bh=eQnhxEqufbGgwnzCS4vy1jRUUKyOp4FFq5ziZVrvjc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PYmJ73djc8pPn9oaXPgORCOrxgpmgqqvLtsFsNvnHuX3jk/QHMX7LK8xYEtARS6sPyoCldQf6+UMLH44G+gMPJzDaUB2tOwR0SGXyU5gOxIrjlzrNcOH6ioEtZYl3kgLxGBC9bWTAirkvgqGxF5qU8gBh4a+f2r/Tq0JAtx4plE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bo2H7K3e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lT2cN2bl; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bo2H7K3e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lT2cN2bl"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C7F591140D6C;
	Tue,  1 Oct 2024 15:10:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 01 Oct 2024 15:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727809838; x=1727896238; bh=21YU4mVJL0
	wvOdLY7syuNRvxgA8VbTNy25G+/fe8Puc=; b=bo2H7K3e4nXgbucFn67dydrNIL
	pUAzKLi2Awcj+eO9LXwFKq7eMNl9Lh8R+RmWee1np7EIP9Pkcpa+6Pp8qdZzhP2t
	xxFoah/ZpJtBrg1cXREaPGhjn5Iq04KyAbbheGpfZuv8ESYc2GrerBEC37reY7Fx
	FAzvsXxK9PB1jRKG8l3+rqbBFVGjpqptwY74t6cjxCaG4zPspA/ZagBeGehMGOZk
	cKoNGoGF491zDAYzboT39XWauRhEbd6TVB0b71ev3PmnZHWcIbDZaT8qLeBslrpJ
	7ywdDKX8AfC8KO85P4XbVM5rE9o4DN1kQdk2lNIkMZpDZRAl91UbJilPij5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727809838; x=1727896238; bh=21YU4mVJL0wvOdLY7syuNRvxgA8V
	bTNy25G+/fe8Puc=; b=lT2cN2blcjAyKwYFTZvhYhdLXB1jKWSY+1bs4VDH5U5y
	7BUuwfhinaIS8P0v2z4K1LjCqyC1376P4dyC2PBw1jGI9MqN3VKgrAZH0iiTxeOT
	NfFVrbUUMhiXX+3zg1P8+j8sNo56joCnp8iq5gtAj7NVIdBm634ue+uDrrVTzSwd
	l7znDbYJaiyWkI/ZSg8xCOENkjFZ5/zLN19ULhWK4Al2SLS/hF2RwyrMVuRMpRo8
	Ub2NMAKV+6VQXteeQ1KDg5f3cWdvW8Xzxc0zNEcSzHY22G8nUaY7uiyODIWM/X+M
	2SAffv1UYbK84X9lTYRd5RLa0g3YGyQIENH3FXgrXw==
X-ME-Sender: <xms:LUn8Zn3mfJB7kiwegTiGXJ7im0QYjYFfG8ZqV_WvlEf79ldeF2jExA>
    <xme:LUn8ZmGNdOVXCEnlrelADaQ3fSPSFYMsXxfRH14kqebYmzKn5iXYjS_i03ndpfVTn
    TbpbRp2WpbfJ6Wqtw>
X-ME-Received: <xmr:LUn8Zn6wcdTogO7VtHmo4F2Pv3_ADNky2zLx_y6HjjH-MB_jJFe3YvkMv51YgPkKpcv6TVmXAgdJbpjlTXbpDGhQSI_GNZg0rTGA3ho>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvg
    hrughinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrgh
    druhhkpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehl
    rdhsrdhrseifvggsrdguvgdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvg
    hlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LUn8Zs3FBNaMdtLbqYaIBMWnA5x5EIXobQ83UWnN7Bc_clLbhpR9Ag>
    <xmx:LUn8ZqEq_sT1N0f3E8j4M7Waa0uSWM0SblygvXxBJRPOqI9cJG0sbw>
    <xmx:LUn8Zt9o16VmdNXnMi-0K-yhVpGtuCV116aJyJD3W5f7743RW4bXug>
    <xmx:LUn8ZnmSIadPpmLDfdjVJ_A2eE6uMCTPWKzA5RJER-0MNGvuGxTgpQ>
    <xmx:Lkn8Zt0xEI5k7wF86YGh2hSpYjOlEyGoDPhMtWuXrpkdxwW-Tt8wX4fU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 15:10:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk,  Taylor Blau
 <me@ttaylorr.com>, 	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Johannes
 Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 1/5] refs_update_symref: atomically record
 overwritten ref
In-Reply-To: <20240930222025.2349008-2-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Tue, 1 Oct 2024 00:19:51 +0200")
References: <D4JIG4VS5WVN.2F0PNU5514UEL@ferdinandy.com>
	<20240930222025.2349008-1-bence@ferdinandy.com>
	<20240930222025.2349008-2-bence@ferdinandy.com>
Date: Tue, 01 Oct 2024 12:10:36 -0700
Message-ID: <xmqq7carwser.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> diff --git a/refs.c b/refs.c
> index 5f729ed412..301db0dcdc 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2114,7 +2114,8 @@ int peel_iterated_oid(struct repository *r, const struct object_id *base, struct
>  }
>  
>  int refs_update_symref(struct ref_store *refs, const char *ref,
> -		       const char *target, const char *logmsg)
> +		       const char *target, const char *logmsg,
> +		       struct strbuf *before_target)
>  {
>  	struct ref_transaction *transaction;
>  	struct strbuf err = STRBUF_INIT;
> @@ -2130,6 +2131,10 @@ int refs_update_symref(struct ref_store *refs, const char *ref,

Let's extend the precontext of this hunk a bit.  The function begins
like this:

	transaction = ref_store_transaction_begin(refs, &err);
	if (!transaction ||
	    ref_transaction_update(transaction, ref, NULL, NULL,
				   target, NULL, REF_NO_DEREF,
				   logmsg, &err) ||
	    ref_transaction_commit(transaction, &err)) {
		ret = error("%s", err.buf);
>  	}
>  	strbuf_release(&err);

We begin a transaction, update ref to point to target in the
transaction, and commit the transaction.  An error at any stage of
this three-step process will bypass the rest and we give an error
message.

> +
> +	if (before_target && transaction->updates[0]->before_target)
> +		strbuf_addstr(before_target, transaction->updates[0]->before_target);

What if ref_store_transaction_begin() failed?

If we want to say "we append the before_target recorded in the
transaction to the caller-supplied strbuf only when we manage to do
the update, and we leave before_target intact otherwise" We'd at
least need

	if (transaction && before_target &&
            transaction->updates[0]->before_target)

wouldn't it?  Like the code that frees it (below), this new call
should be prepared to see !transaction.

>  	if (transaction)
>  		ref_transaction_free(transaction);

> @@ -2948,4 +2953,3 @@ int ref_update_expects_existing_old_ref(struct ref_update *update)
>  	return (update->flags & REF_HAVE_OLD) &&
>  		(!is_null_oid(&update->old_oid) || update->old_target);
>  }
> -

Good (even though it is unrelated to the topic of this series).

> diff --git a/refs.h b/refs.h
> index 108dfc93b3..f38616db84 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -571,7 +571,8 @@ int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
>  		    const char *newref, const char *logmsg);
>  
>  int refs_update_symref(struct ref_store *refs, const char *refname,
> -		       const char *target, const char *logmsg);
> +		       const char *target, const char *logmsg,
> +		       struct strbuf *before_target);
>  
>  enum action_on_err {
>  	UPDATE_REFS_MSG_ON_ERR,
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 0824c0b8a9..8415f2d020 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2577,6 +2577,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>  	}
>  
>  	update->backend_data = lock;
> +	update->before_target = xstrdup_or_null(referent.buf);

OK, so this comes from the backends, as they are the only thing that
knows what the current value is (the caller can only indirectly infer
if it has old_target, in which case the backend checks if the attempt
is stale).

Do we need a corresponding change for the other, reftable, backend?

> diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> index 65346dee55..a911302bea 100644
> --- a/t/helper/test-ref-store.c
> +++ b/t/helper/test-ref-store.c
> @@ -120,7 +120,7 @@ static int cmd_create_symref(struct ref_store *refs, const char **argv)
>  	const char *target = notnull(*argv++, "target");
>  	const char *logmsg = *argv++;
>  
> -	return refs_update_symref(refs, refname, target, logmsg);
> +	return refs_update_symref(refs, refname, target, logmsg, NULL);
>  }
>  
>  static struct flag_definition transaction_flags[] = {
