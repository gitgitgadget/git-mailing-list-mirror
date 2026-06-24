Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E55625B0AF
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782300424; cv=none; b=r3njfjViCHU6sjxPjJ9GcplklbnjOVJDiEcAFu6IeUH5aNX/KMbdmpyK29mpyaC1tFmBxDcmP8yPq4x6IehLA4Rr3NqMgifAFEWZnlIP8sxMjr8/FCq36bDcTLA/+/jnQUCOtyArxI0V7WfUy6HM3FZphLM5XIxIrB6Gcdn9bQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782300424; c=relaxed/simple;
	bh=/xOn32dhtjG2Jwq3OOGmeyiyafZ3loPnEyOlKJsVlxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMJ0sbp+XN9BDFZp41gs/L7k9yEmwpaKoZqaTVwfFBQtNS2SsRT5YqU/v/RhX7Y3kBgTUsxM9sVPfCqEkZa+zPQ4bBplM+k7guYSxs6c/8vskMGn9XeLQhp8Vp32BtUlgi0sG84MpuKWUmMM7xjTlqngoCWLNOrsfUvnENUscI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cotOPE5N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M79phZ0b; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cotOPE5N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M79phZ0b"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B74C27A005F;
	Wed, 24 Jun 2026 07:27:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 24 Jun 2026 07:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782300422; x=1782386822; bh=kTs2xRCyee
	uQDeae8hhWUYw51+XGpsXrPn4nvZUNWVo=; b=cotOPE5NyXxIwtR4TdmxVJDjMV
	1pvMF58myGNB3XBExT8hWhrHK6C8VeXxA110vdNr/BLIbYBmj7FMkHvCVfpWAwHq
	PY+BIWeIT7aEgaoUmdSFr0GgSd67jhesbVZl24kokW7JYJ05+/14qcIilWD4vami
	WzmsrYU8r5bELXC5KDSfsA+QtuTLB7iGAR+SSgHvggf8Nz5bEmxcn1RsNCTCdndU
	Iy5QkJTjtbUwK+KwsBlWX6+kkfG08Sva39ReyJUx6vproqsxlbxtlNsRBdBicdyH
	fBw9cm9Rr2Fid+jXHaqcSxiolroazKu71GEaVQb0ibp62WDQbn6lgBcRfV1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782300422; x=1782386822; bh=kTs2xRCyeeuQDeae8hhWUYw51+XGpsXrPn4
	nvZUNWVo=; b=M79phZ0bA2gXg4FJjpIXUEO2f5ZvEy2WOhW2yN6eIpEVPSxEeaQ
	t2dH/l59wNGJCxbi4q9VCG64L7EZ3idGGJziQurwevhsoMt2Doc2q5RJSppqJGNS
	UnGVQIH9Zx4TvxSV1eXB9RYPiDa9x2KXmedeIVRbPgzCkMCUqvKnpGBiEmy2nkcA
	OReXVaD8OTCJmv0uDEgt623DblOppXmNGcsGbIyRdnT3aKVVOcS7qGBxabpKNOV9
	pBpDBmJF46iGwwJJHC8cchHaw6wWwKta3/UAyOxciGtf6VEQnt7PdkO+a8G5Eb1L
	W7hO/VcIdgH++Ll1kLmVlPa9+92aZINgy+g==
X-ME-Sender: <xms:Br87akUYHWjhnAd6L_migpTGctpLR-B0-gT0TXvQbUTS3S90kWalPg>
    <xme:Br87aunyYIYLXnWKL1o1S7mU_0iIRsFsXp2qOzLO1jekVs0pgqCnHNLYNI2SLLxZT
    AcZjMPTOPkqjPUgcqsvab_dNhaUl6dWr7-cbRz2I17U2ZRuN2vanA>
X-ME-Received: <xmr:Br87amC5mYKlICK1ZGUfT-5P01TSwPTV3uv9IOg2_153pfxYHQboRebO5_LEYyb8xllMsiJhF95flMDQI_XZCZUa5nBTzfb3Aq13UeQ8>
X-ME-Proxy-Cause: dmFkZTE8nadoKE78MhcMgd+5yQWfYE0kD+bQfooTkEol/2jwh+xQsSE2EvTICLpAxVc6wf
    Mde+nLtwhCDFgylcTHk/OMcTocidOWfSjCfl1ep4tPfzxsNejPrls4ML+APBsOAX3uzheb
    JA5MEHFKwGvkD+b/6WuDd3yQyXQ427/ILRxgyd3XU1A7aAwGy/3gEHwr1+FN5NtTpHsvce
    YqPsamkWBANJ/ROUZROvLaY01t1XVO7syFfaNDCALE6hrnBXo62XNAv4kgX+djkM/VYmwI
    BDkK38geuCKVXOnLz1wAfv1L1r+mzoInrQDXRoyahUbur2UGZZXpoWwgZQ+JkM10xqHIsK
    s81p3AWpEOQH9tblAZ+uT2CrjPcWcSWLTGTxWQH9wkXiQ0UooIgCS1lBk063PqUA5qBB07
    qcqTABYtNNN5BAl1WLJhYXfHc9c/m2qApoF4IlNnmoFmFJjzAPE/wq0qyvE85c2XYkIcMs
    Wh2TeQsr0UItO95K5/RotfssHbfiK1ublPRSz0iaH1ceU5wHyWngTAKcCOrCUH534D3b3w
    inF3nnq1mJkKBrkJU+zuMLMVFND6LgxTPlV+wIibvR5g/SMWM5DKiJc+6wrONgaKQ12HSk
    d92CXBEEz6bpWDidMz2PeizHNWRLl09/qFGIez/MFp1dKEQ/nCj6LOah0HpA
X-ME-Proxy: <xmx:Br87aud2WgT_Wk-IJVhujgiyiJSqsm7KVHLZqSm2OpLlN-XW-6oncw>
    <xmx:Br87ahKoEvqhwEQ9RwtXwtoOuW_Hp3FCH4LZXCZwmeGjWaTh7v5Sdw>
    <xmx:Br87ahenIWeIirhvBBxvLXNVi_fjKWfagzWBbTsmhSFmnJNgq_gKtg>
    <xmx:Br87ao2BO_zKk_-p2z1GL1AS9As8n3yxHg40enNCD4uJUFSg-w7ZNA>
    <xmx:Br87apFPBZrynZ8fJehRnCsM1BxvAiYPLacwqktJSQQ34ulYHxz83EuU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 07:27:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6444bffa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 11:27:01 +0000 (UTC)
Date: Wed, 24 Jun 2026 13:26:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] builtin/receive-pack: stage incoming objects via ODB
 transactions
Message-ID: <aju_AmlKVi5UZaiQ@pks.im>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260624041920.2601961-7-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624041920.2601961-7-jltobler@gmail.com>

On Tue, Jun 23, 2026 at 11:19:20PM -0500, Justin Tobler wrote:
> Objects received by git-receive-pack(1) are quarantined in a temporary
> "incoming" directory and migrated into the object database prior to the
> reference updates. The quarantine is currently managed through
> `tmp_objdir` directly. In a pluggable ODB future, how exactly an object
> gets written to a transaction may vary for a given ODB source. Refactor
> git-receive-pack(1) to use the ODB transaction interfaces to manage the
> object staging area in a more agnostic manner accordingly.
> 
> Note that the temporary directory created for git-receive-pack(1) is
> eagerly created and uses a different prefix name. This behavior is

A different prefix name compared to what?

> special cased in the "files" backend by having `odb_transaction_begin()`
> callers that require this behavior provide an `ODB_TRANSACTION_RECEIVE`
> flag.

Okay. I guess this is to retain existing behaviour where the temporary
directory is created lazily everywhere else. Makes me wonder whether we
should eventually change this to just unconditionally create the
directory in all cases so that we can drop this new flag.

It might've also made sense to split this commit up into two: one to
introduce the flag parameter, and then one to do the changes to
git-receive-pack(1).

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 19eb6a1b61..ee8e03e2ab 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -112,8 +112,6 @@ static enum {
>  } use_keepalive;
>  static int keepalive_in_sec = 5;
>  
> -static struct tmp_objdir *tmp_objdir;
> -
>  static struct proc_receive_ref {
>  	unsigned int want_add:1,
>  		     want_delete:1,

I assume the goal is that we convert all other users of the tmp-objdir
subsystem to also use transactions eventually, so that this becomes an
implementation detail fo the files transaction?

> @@ -2106,14 +2104,13 @@ static void execute_commands(struct command *commands,
>  	 * Now we'll start writing out refs, which means the objects need
>  	 * to be in their final positions so that other processes can see them.
>  	 */
> -	if (tmp_objdir_migrate(tmp_objdir) < 0) {
> +	if (odb_transaction_commit(the_repository->objects->transaction)) {
>  		for (cmd = commands; cmd; cmd = cmd->next) {
>  			if (!cmd->error_string)
>  				cmd->error_string = "unable to migrate objects to permanent storage";
>  		}
>  		return;
>  	}
> -	tmp_objdir = NULL;

We don't need to unset the transaction because that's what
`odb_transaction_commit()` already does for us, I assume?

> @@ -2326,7 +2323,8 @@ static void push_header_arg(struct strvec *args, struct pack_header *hdr)
>  		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
>  }
>  
> -static const char *unpack(int err_fd, struct shallow_info *si)
> +static const char *unpack(int err_fd, struct shallow_info *si,
> +			  struct odb_transaction *transaction)
>  {
>  	struct pack_header hdr;
>  	const char *hdr_err;

It feels a bit weird that we sometimes pass the transaction as
parameter, whereas othertimes we access it via `the_repository`.

> @@ -2351,20 +2349,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
>  		strvec_push(&child.args, alt_shallow_file);
>  	}
>  
> -	tmp_objdir = tmp_objdir_create(the_repository, "incoming");
> -	if (!tmp_objdir) {
> -		if (err_fd > 0)
> -			close(err_fd);
> -		return "unable to create temporary object directory";
> -	}
> -	strvec_pushv(&child.env, tmp_objdir_env(tmp_objdir));
> -
> -	/*
> -	 * Normally we just pass the tmp_objdir environment to the child
> -	 * processes that do the heavy lifting, but we may need to see these
> -	 * objects ourselves to set up shallow information.
> -	 */
> -	tmp_objdir_add_as_alternate(tmp_objdir);
> +	strvec_pushv(&child.env, odb_transaction_env(transaction));

Interesting, this here seems like a change in behaviour. Previously we
added the transactions as an alternate, but now we only propagate it via
the environment. I didn't see this mentioned in the commit message.

> @@ -2707,7 +2694,10 @@ int cmd_receive_pack(int argc,
>  		if (!si.nr_ours && !si.nr_theirs)
>  			shallow_update = 0;
>  		if (!delete_only(commands)) {
> -			unpack_status = unpack_with_sideband(&si);
> +			if (odb_transaction_begin(the_repository->objects, &transaction, ODB_TRANSACTION_RECEIVE))
> +				unpack_status = "unable to start ODB transaction";

s/ODB/object/

This may be visible to the user, and "ODB" may mean nothing to them.

> diff --git a/object-file.c b/object-file.c
> index 14064d188a..e7958753ec 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1702,7 +1703,8 @@ static const char **odb_transaction_files_env(struct odb_transaction *base)
>  }
>  
>  int odb_transaction_files_begin(struct odb_source *source,
> -				struct odb_transaction **out)
> +				struct odb_transaction **out,
> +				enum odb_transaction_flags flags)
>  {
>  	struct odb_transaction_files *transaction;
>  	struct object_database *odb = source->odb;
> @@ -1717,6 +1719,20 @@ int odb_transaction_files_begin(struct odb_source *source,
>  	transaction->base.commit = odb_transaction_files_commit;
>  	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
>  	transaction->base.env = odb_transaction_files_env;
> +
> +	transaction->prefix = "bulk-fsync";
> +	if (flags & ODB_TRANSACTION_RECEIVE) {
> +		/*
> +		 * ODB transactions for git-receive-pack(1) eagerly create a
> +		 * temporary directory and use a different prefix.
> +		 */
> +		transaction->prefix = "incoming";
> +		if (odb_transaction_files_prepare(&transaction->base)) {
> +			free(transaction);
> +			return -1;
> +		}
> +	}
> +

Okay, makes sense. I really wonder whether we need to insist this much
on the exact name used by this, but better be safe than sorry for now I
guess.

And as mentioned before, I also wonder whether it really makes sense to
have the lazy creation of the tmp-objdir. Maybe add a NEEDSWORK item
here that mentions we want to investigate whether this is even needed at
all?

> diff --git a/odb/transaction.h b/odb/transaction.h
> index 536458297b..78392ff13d 100644
> --- a/odb/transaction.h
> +++ b/odb/transaction.h
> @@ -44,6 +43,10 @@ struct odb_transaction {
>  	const char **(*env)(struct odb_transaction *transaction);
>  };
>  
> +enum odb_transaction_flags {
> +	ODB_TRANSACTION_RECEIVE = (1 << 0),
> +};

It's not clear at all what this flag does based on its name, so we
should have documentation for it.

Patrick
