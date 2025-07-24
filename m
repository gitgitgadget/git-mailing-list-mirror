Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C506725BF15
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342975; cv=none; b=OzaKS8dr+2fUNCXiRMrP6gt3wykLVEcHazxoIJoFnkVJSGLAJNekoWMsxAUQYvsiHp8ufbZb0azxzGgu2Lh2KbzRC6sVTAtndhQU70sKpdRHoGysg5RFJNzRKSSV1ImuRBsUNaaDIesvjBCdVXKz8f+JB/V8LR1MongHbwDAwtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342975; c=relaxed/simple;
	bh=CRCqgVKkBxrqVQs6mQvp3d8Kx819eDmHjzb0rdhEPdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lyi3cMAIYOdnGwAS+V6RpG15iR/VmgNQSYhTgGTM3j2KNKK2VJnvYgDhd3mUqqnqSIj6xrBx+WLsP8HfSkpVr8AOInu1Ddtq1nwdQXvABLCgbgsZZTsqQQYIBevthiLPPDOqE1Cw2WeIzu4QoSUgy3xDnKVUAffv38Q62YEKVCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KY4COXkP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ha+XTkX7; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KY4COXkP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ha+XTkX7"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0062F7A0195;
	Thu, 24 Jul 2025 03:42:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 24 Jul 2025 03:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753342972; x=1753429372; bh=c1UE8u1m+O
	jgFLWL+/9C3FSAHujf2FEPmzobmXZlm5s=; b=KY4COXkPpaTuTSb20/kXAKrrrT
	4dUswIx6NpkM+kwq5XGcs8Kxu1Mw8dipYlJCmkmKE+lcmZv3ihQZYichI2jqpjnF
	iVT3AbXeMRl+PrvMb+Id18AIyKJyo1BHw0rJWlopANvZraF+27xTZMNERDdexpfp
	Hs34XgxZd+oylipQUO4WbIHLgRHnGQHo4SZkJRltkKj0rIaQQ5X4amojsOdZbmRE
	lnpzHKx2s0bE+bn2LErGrIdnyqdvSkUmfpPeUCSkkj46NUqDpl1+fsAkiHe6lIKK
	QEth+Zt2OSYZM0fmCPhpXLI9Rp3W04U1e2abhfsTLgSeARNsLEwQQNLoZqiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753342972; x=1753429372; bh=c1UE8u1m+OjgFLWL+/9C3FSAHujf2FEPmzo
	bmXZlm5s=; b=Ha+XTkX7Qp3z4bCNB36EyjZoRCi2W+f8tgHXSMrtzZ9Tm+Wcd7z
	OjDO8/dN4MpkbYZ+z6mgmUz1UE0Q0O3rwAJ/kbVLoFCX9OTPZdXiKLTa5EnUfkai
	2pXtdsHvQMjD/cY7E/LMT9ZlLBYSZnAShpB/J9WhC71cGToqeYYJsoIYusQMVl2J
	GnCsD4IuC2rdclEFBXbZgM/MeRdQgqotYSxS4E+Ly7brDL7Vqr8Bj9u7GIhmNzua
	tt230wSXzus7wT1YhEhFDfCeObP1fljMfTfyzUGpCDNBOA6TVhFWwKTNV9ZAxZWy
	y+LqBxijKA7AS8f1HjdfpZ/AJxUoRRmCriA==
X-ME-Sender: <xms:_OOBaFN6YTowb6IqceFTGZTND3f2CbLFZEHuDI9vPD2wecNFS31TTw>
    <xme:_OOBaLOvaWKEQY2Sh_Kyg435y2biFaOin5oMJ2Myr-qz968WfjyMf4Sfn_-DW4ZCF
    u6L8Wzpma1WSKETjg>
X-ME-Received: <xmr:_OOBaNskqfa7h9RwHFlPQz4MPHXf3AJzBLvDAJxQvSKe8UpKodoLAR_YJKAuIrXRohzsjJzuxJ4nXAeVVe2IIHCZCFXNCuI8zG7vYOLUxmo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdektddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:_OOBaNXuZkuF8JWOx0Zn9GMa1Q9_m1VZyGYXCihgf3V4fjP016IqOQ>
    <xmx:_OOBaNuPVIKbmUVkgOdguPmkAWU8Ce4-vO_AOAwNYEq8BfXta0I4TA>
    <xmx:_OOBaBUM92z-c8T_Y95fzLFuOSiPMFxVCQS5xVcYbXheK626QVcC6Q>
    <xmx:_OOBaInDlRYSXkKui5rdnJO3DNH9-cpCPZ80cdx9_T-PMzBFWEuaBA>
    <xmx:_OOBaBJtUWWjrr9SfLta92WBIn59xMK27CNhvSDcs46tBpM72Y8T4tF1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 03:42:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a32fb7c2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Jul 2025 07:42:51 +0000 (UTC)
Date: Thu, 24 Jul 2025 09:42:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 7/8] refs: stop unsetting REF_HAVE_OLD for log-only
 updates
Message-ID: <aIHj-KBiD7hjOCNF@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
 <20250722-pks-reflog-append-v1-7-183e5949de16@pks.im>
 <j52ugdtik25i6dqgqafchvy5an3o7qbdfeavtqg6bcr2ouxvyv@qwtqzf7xk4hi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j52ugdtik25i6dqgqafchvy5an3o7qbdfeavtqg6bcr2ouxvyv@qwtqzf7xk4hi>

On Wed, Jul 23, 2025 at 03:31:01PM -0500, Justin Tobler wrote:
> On 25/07/22 01:20PM, Patrick Steinhardt wrote:
> > The `REF_HAVE_OLD` flag indicates whether a given ref update has its old
> > object ID set. If so, the value of that field is used to verify whteher
> 
> s/whteher/whether/
> 
> > the current state of the reference matches this expected state. It is
> > thus an important part of mitigating races with a concurrent process
> > that updates the same set of references.
> > 
> > When writing reflogs though we explicitly unset that flag. This is a
> > sensible thing to do: the old state of reflog entry updates may not
> > necessarily match the current on-disk state of its accompanying ref, but
> > it's only intended to signal what old object ID we want to write into
> > the new reflog entry. For example when migrating refs we end up writing
> > many reflog entries for a single reference, and most likely those reflog
> > entries will have many different old object IDs.
> > 
> > But unsetting this flag also removes a useful signal, namely that the
> > caller _did_ provide an old object ID for a given reflog entry. This
> > signal is useful to determine whether we have to resolve the refname
> > manually to figure out the current state, or whether we should just go
> > with what the caller has provided.
> > 
> > This actually causes real issues when migrating reflogs, as we don't
> > know to actually use the caller-provided old object ID when writing
> > those entries. Instead, reflog entries simply end up with the all-zero
> > object ID.
> 
> Ok, if I'm understanding this correctly, the `REF_HAVE_OLD` flag is also
> required to actually record a provided old OID in the reflog entry. If it
> is not set, a NUL OID is recorded instead.

This fix is not sufficient to record the old object ID, so the commit
message is indeed misleading as it comes from a previous iteration of
this patch seires.

I want to have this signal so that in the next commit we can assert that
if the new `REF_LOG_USE_PROVIDED_OIDS` is set, that the caller also sets
both `REF_HAVE_OLD` and `REF_HAVE_NEW`. So this commit here isn't really
required anymore, but I think it's the right thing to do anyway, and the
additional safety check isn't too bad to have in my opinion.

I'll rewrite the commit message a bit.

> > Stop unsetting the flag so that we can use it as this described signal,
> > which we'll do in a subsequent commit. Skip checking the old object ID
> > for log-only updates so that we don't expect it to match the current
> > on-disk state.
> 
> Just to clarify, when migrating reflogs, are these operations always
> marked with `REF_LOG_ONLY`? The comment for that flag states:
> 
>   Used as a flag in ref_update::flags when we want to log a ref
>   update but not actually perform it.  This is used when a symbolic ref
>   update is split up.                                           
> 
> I might be misunderstanding this though.

The comment is out of date indeed. When queueing reflog updates we use
`ref_transaction_update_reflog()`, which sets the following flags:

  - REF_HAVE_OLD and REF_HAVE_NEW to indicate the object IDs.

  - REF_LOG_ONLY to skip writing the reference itself.

  - REF_FORCE_CREATE_REFLOG to disable heuristics whether or not the
    reflog entry should be written in the first place.

  - REF_NO_DEREF to not write the reflog for the target of a potential
    symref, but for the symref itself.

  - REF_LOG_USE_PROVIDED_OIDS to actually use the provided object IDs
    and not try to resolve state.

It's an awful lot of flags, and I tried to work on a solution where we
don't have to introduce the new flag. But the logic here is so intricate
that it always caused unintended side effects.

Thanks for your review!

Patrick
