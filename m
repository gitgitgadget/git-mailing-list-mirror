Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993453E075C
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765815; cv=none; b=OAi6Dcr230WpFQuUNlq0S3usyLsfh3VuV884sfV6h/5+N/NjHrLGxMFrOuo5fm7qjenzV9/v8QRSGLCkpf4WOvii/TGm3GyHORXo/wIf4NSG6/fhVLjAFSU0heX2rWT7AyMEZyhnUNK2eycYk5zaK6FQZvWybrB3ZPHeo/e8tHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765815; c=relaxed/simple;
	bh=AESkAY8wuTPqVL3lczRcxm9uODuhb2p8EaSzj+QsY28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQXT2dHYUKMBp8cr2aBEkzV2qvhukN9K9z2FaWWQUXY92sV/fBoZfweLUMe38k60cqGD5HFLsM+SPC8UVj/AiW1imL2sHyC2EFDH0PPB5+oMR62KsUKfQIfUSKGdwqeYH8cc5p2YlVuOLQhe/k7i2Ij9gI5gOWsnOu5m2gnflhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ynTK3US7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bd0Ym+kK; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ynTK3US7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bd0Ym+kK"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id A10F6EC0256;
	Mon,  7 Sep 2026 03:23:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 07 Sep 2026 03:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788765812; x=1788852212; bh=6XODQiwUMW
	+USZ04FW5S34STcjvbEsjM/RvLjz+K0/E=; b=ynTK3US77xWzkS2+LfRBjn8/Cj
	UWLyWTFf7ma2GTe4Tm+q9ew6fmjOVD8Q7iG5g7s4MBqMfcmhmCDzaeyI2mniK9Cr
	AS54JWUzAZbRLdTzM+sGeue56qrDFuXeXdwPxCmv4nQZdGLpfEYMo2zKi+Xx2fvs
	pm9GasCIL2b4HF1EnLH/vrlhZk+X09hoD+TMn6dCkxjoOYbxuDTdYpfYXc2WWxjx
	kMkPjWmEMCCgvbUiq7fTt0+YXFhNVMb6K/yqXkIRcu0kYDjAXCyTSxI5VuyhLbdc
	j3DLegsHgFy22OBZoIX1AXP2xyYj0L21gicjPMoacSMtXPZ09erIeQwgvSNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788765812; x=1788852212; bh=6XODQiwUMW+USZ04FW5S34STcjvbEsjM/Rv
	Ljz+K0/E=; b=Bd0Ym+kKmg8a5o+lqwpxdoz76OxbKDJ+FXzsJbOYPuslP5u0AlS
	GDq545h76W6UtXEemk5XCz/enQuys+H9FyqsfJ75VxaltkzBzIhXjw6jmVSvqjQo
	wRMQC25KvrTRNuhoToaqVsWjPclaG/h0KhTuk/nH62AYQfxY9Cd26y/jFtN3DbDh
	d2wGKLWiLL4UzZeydBS3XY1jZQ8ife1Bj6ndJKU2zPRdT8BOnbLQpEAsEdzDg1+4
	zcgZ3WzkusLcXR4JaeNJT+XfdrrohsMUSQ5q+onw5c5yxrmzg1vkmIXsIaYRX7Uw
	70y5Ufv3rsG1A0CwOW0SnG1nKteLR4hT4GA==
X-ME-Sender: <xms:dGaeahsKqFVtumW6CqktVHo26dW1e0o48S78SqWDTrf4p7Up_ebQJA>
    <xme:dGaeahdQs48FIo1FBffU1qf28LuEx5vb-WFwatxezxY9vNaIxjZP8gjVvhXL_p_mK
    _fuyu5jkQefbbbh2gEHOCiO8hTJqzQRWraC_9AlYFAT7636IEEOVw>
X-ME-Received: <xmr:dGaeapzRa37aDimTutWnRWie6lOoVUAqMVPmvrfp15vW2hKk6bd6RQ>
X-ME-Proxy-Cause: dmFkZTEwHtJvykOmKUDEDY+5LL6zSA+tSWEL4neDjojXqSiP8eZ9gnnapy1uam+jsG7D63
    eME639ZiWRdi/0Jgr3ohjdssSBBMXg8KaIwH6+zKV6NpihJ9jh0S8lIXND5yLSTgVrBeWF
    u6R0nazELzVgxnXkno+kGWJxicdG38T2fC8ENnSL4PBGsG9RZDuRlzRmCuqM1r1H2hAumU
    RQfcCW+25rdUCwK4++wpJU9DjfhlbCan77nsgN1Q9RVgl1oDlkwrZPafyXLNgJrqWHDwbz
    4RXcsu4WGY8o7RbZpQitbI0hVy8DTBVCT3pt8bqIO41wWPJ/lykWGDKbmMs8huuTQr0Ng9
    80StbNBiGvVOwMYb4QpdDEIOAagY1sDUyAW+L1zXPa7nBmyv0X6vXBKwHWE/TRJ6ei53l6
    HJNdLZumacNMJ8LprCFsp1sGfCUuElvdaDtabTwChWSD1kq2J8UlKGbAI/QmMMTNYHdrAi
    bnP8JnRqO+aOdYvbwuet0TEkum4Ns95WRqDzrxucJGpVzJEdxOCZmNLPLpZ+Y2X6L40ALj
    mcxi/rS3JwxNF4EudwgoYV2GZgDmm9cmRdg7A8rdiSIUU1yTApqFw8D/U1YlPPlPoc5WYu
    OKNEyDneIj/dUWjOOtwfiyNjHENVgmECuT23iA9Jiwio/Fr3JAM4FAbazULQ
X-ME-Proxy: <xmx:dGaeanF1Kg-z0I8imNxPXrbGDNcKNpPL5hd4l1obZUo-Z2IkCOhMyg>
    <xmx:dGaeaty8BIo32cxiP-rkCluH5Ctxr6gqGkRFfgCXZOgYxGgFmTwzIg>
    <xmx:dGaeaotfGDcaMcMmM7CqyRoZ30x7iUatv3xAJTSscCn-jqoP_vZRng>
    <xmx:dGaeaq2jRoEGKbci_wR4Xq-wJQlj0EITer08mkngwyC1wGw5Ac7pSA>
    <xmx:dGaeapwwBglQLO05jOjqOYuvZHQWNYQskhzKXr9E3g3iFpqIS5JHe0pO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 03:23:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3c5a8bf4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 07:23:29 +0000 (UTC)
Date: Mon, 7 Sep 2026 09:23:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/8] builtin/clone: defer setup of the object database
Message-ID: <ap5mafyJrnXCTw_L@pks.im>
References: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
 <20260831-pks-odb-write-alternates-at-creation-time-v2-1-aecd2382ba1c@pks.im>
 <ap2URrS4i-nHV5cB@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap2URrS4i-nHV5cB@denethor>

On Sun, Sep 06, 2026 at 11:42:48AM -0500, Justin Tobler wrote:
> On 26/08/31 12:02PM, Patrick Steinhardt wrote:
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 5b25cca510..0a67492ebd 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -1184,11 +1184,14 @@ int cmd_clone(int argc,
> >  	 * database. We do not yet know about the object format of the
> >  	 * repository, and reference backends may persist that information into
> >  	 * their on-disk data structures.
> > +	 *
> > +	 * Furthermore, we skip initializing the object database so that we can
> > +	 * first resolve potential alternates before creating it.
> >  	 */
> >  	init_db(the_repository, git_dir, real_git_dir, work_tree, option_template,
> >  		GIT_HASH_UNKNOWN, ref_storage_format, NULL,
> >  		do_not_override_repo_unix_permissions,
> > -		INIT_DB_QUIET | INIT_DB_SKIP_REFDB);
> > +		INIT_DB_QUIET | INIT_DB_SKIP_REFDB | INIT_DB_SKIP_ODB);
> 
> Ok, now we skip the initializing the ODB during init_db in favor of
> delaying it to after we have the required config info. This makes sense
> to me, but IMO the `init_db()` interface has grown quite awkward with
> these "skip" flags. It appears that there are only two callers of
> `init_db()` which makes me wonder if it would be simpler to just require
> them to explicitly set up the ref DB and ODB.

We can, but there are some nuances here that make this a bit more
complicated. Most importantly, we'd start printing the message that the
repository was (re)initialized _before_ we create the actual object and
reference databases.

But thinking about this a bit more we can solve this, and we can even
get rid of the flags completely here:

  - git-clone(1) always passes the QUIET flag, so we really only want to
    print the message for git-init(1) anyway. So we can lift the logic
    out of `init_db()` and then drop the flag.

  - Same for `EXIST_OK`, we never allow preexisting repositories when
    performing a clone.

The name `init_db()` would become very misleading in that case though,
so we should probably rename it to e.g. `create_repository()`. But
overall the change makes sense, as it moves the command-specific logic
to the commands themselves instead of making use of flags to control it.
I like it.

> > @@ -1311,9 +1314,6 @@ int cmd_clone(int argc,
> >  		strbuf_reset(&key);
> >  	}
> >  
> > -	if (option_required_reference.nr || option_optional_reference.nr)
> > -		setup_reference();
> > -
> >  	remote = remote_get_early(remote_name);
> >  
> >  	if (!option_rev)
> > @@ -1342,6 +1342,10 @@ int cmd_clone(int argc,
> >  	if (option_local > 0 && !is_local)
> >  		warning(_("--local is ignored"));
> >  
> > +	create_object_database(the_repository);
> 
> We now explicitly create the object database here.
> 
> > +	if (option_required_reference.nr || option_optional_reference.nr)
> > +		setup_reference();
> 
> Any reason the reference setup is also further deferred here?

You might think that this has something to do with refs ("refs/*"), but
that's not the case. This setup here sets up alternates, and we can only
set those up after we have created the object database. I'll note this
in the commit message as it's quite non-obvious.

Thanks!

Patrick
