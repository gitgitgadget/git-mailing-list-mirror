Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBD9377575
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593438; cv=none; b=iUdQ6zUQOfpeeK5X6bIPgBDTcrb/IApGnwHj5Tfb/SKmiEWsqvjZozCURqkfPidwfQuZOimV2E5tb5tilqvR09cCxA3tKr01N001txFsca/I3CQfQei25F3ZVUtSRclu+Kk1c1Kfer+fFf3UUJ/7OTlN17zW0H/MeyUd9rJ3eWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593438; c=relaxed/simple;
	bh=KYqsNFidwcBxm2e0cnEwKl0AS5mplKU98uDnPDsmRXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itf74hUWuZe9+bE9XZHuvq8QiMM1Q9II4j+1YRZl2crKvXoVUEp7P4yYye1/DlFH8/nzaPoKcw7XYB9eWmtfxzoPmjo6/ChuKPK5N6AewGv2STyKD6ag9vqORnDAuzrTov9TRU+iDycF3gx4SeseFLGf41IOJP3HaV7kxwmNdmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UTcweHc0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gEj3+ayU; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UTcweHc0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gEj3+ayU"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C75F5EC03E1;
	Mon, 24 Aug 2026 13:43:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 24 Aug 2026 13:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787593422; x=1787679822; bh=UTnnW2nOzL
	4TVnlvDTkVuvQh0YW3YupbIZvgTyyh/3E=; b=UTcweHc0SiwHQfgXdVqG+JUxAP
	TEPaZIsuSuKjUysc/3sJvEpcpWcrrOw/sG4zZyoFXMxCKGyjJ+7ybM8gZ6Qr94jo
	B807sh87ceYsCyZFo3njXbPWlsVB6TCXXYvpoFd+nfd+DsIYgLbwBVLbLz6uNr7m
	xJqeRpP/2GBzxJDUJAOCWNERqTkWD106DYg+9TVq027c+f4MFhlvX9B1Tf7/zfMK
	PjDX4uJtCApe9URPMUtc77lSZnf+e1B0wJfSVe6rj2HAqPNRGiTHO18Nn6hw5e/N
	DX/hfdSSLpaPGqfz9dgbA3635LG/95kt+JjQIqglsYy0dQvp8YeOvGyuVHgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787593422; x=1787679822; bh=UTnnW2nOzL4TVnlvDTkVuvQh0YW3YupbIZv
	gTyyh/3E=; b=gEj3+ayUbI/KkqkJrGD22ylhBYmfluoV4i4VAbyI/GEEDvJcmXX
	/Izs7JmJCxi88ium+POiN7BJ7daPpamQehAwe7e7BwuzVBkxMpeJ0No3FQ4a3kBT
	9zjJj4uDsquYCGwxCTQUXDjnpbkFYG/bBnqgOYQcYpSiGHZLhQnOvcGiZqERYu8n
	d0Jt05Ph643INrB54rUC3ovABX8en6C9+26dju+ueTH1q1J95j7lM27uRyKsNwaf
	bJ+1D7z+BFNP4Lh6rG7Asp2eN+bQYkkcyT/sbcAUz+XfA+xwmYKh/m1KIBM9TDkx
	F5a4MVYbBn6lQ6Hib0ntxAuRo8okPKKo97g==
X-ME-Sender: <xms:zoKMaoez50txLUxVOd0kLAY9-JhD_RvuiEFVBIN8QtSosXA5bd1S0w>
    <xme:zoKMagNa-udW9-EE9il0ED4zcwEXgkMk4rJSAiOdnIFtlCJCKu3b48LF1fX_HvqIF
    hFfTLeNgWEHahEHA1IX5DPjIJIPLqctO-P5Gv-0LKO_1bN6D9u-lw>
X-ME-Received: <xmr:zoKManL7g3vqzlw_9e6HU_3qBVvUQVybYvUSfXN6ZBSVoRWhK2HBfkw2omNCB8Qh5-dlgAqmjlB6-NmfbwbnhV_pK-tFv0wj6l3ffsrQbA>
X-ME-Proxy-Cause: dmFkZTGoBQ4wyMi1x7Y9XST4GY3OCqOXveEAOhKzdOeVcUlyMMQuAXRR56VQFFemXl/180
    o3q9C1tLVgvQt5hyZ3bmFUcfS6lz98PZBpbzqIBGiNuKBduUHiLcKF9b526KIj/J1DKqix
    58ajXgBTmXlpBlmPWdZgjmyhJxu6RIaqo+rxL/5QeF6AvfL9hK8zzeK9isyY7gAVIG3TOr
    hb1B3uoWBez96SyZdhrE6xgv0KllttAZ/Gq8oB7+bjiCILEOH04jsU5X/MdQQpqSRBBDjZ
    CYgb/Ymu975FKMDTdKp17HkUeg3aLU00q17sgbJIaBCb3XnebxEWb2VkZQjQjMYMc9n8tC
    ka+Gt2VeQk0bVGgm/2Sd352tUOz5pShvDDSPf9oYtJtUP7UVhxxR8Z8qsLgFptmDkPolg2
    GepaCvUdxU+mYxksKHsCrqJvKyP+PL4mdj1/C8zebDIvqg3fKgVfAL0KRCk1q2JMhW38io
    b+paI5/ha9n/NOGgOX7O1Dpnh+Qk30QLLhrk1ghA2DfOXoeh47kc7wCz2pXYs80k09HSnL
    1jHYABb+0Z7K8rQk3dP93HOhMWjD1TTra3qSB29G/ot5XHvTix8FzFL3yt4EM6+aacYrF4
    6dC023WdHIMXL5eFVhnHeevsYbK77BtrQNNfpSq8mSXfNrzy8bgiXlIj8jNQ
X-ME-Proxy: <xmx:zoKMapHEDPyk27IHoMPRa0N7UWoGBtcokty4z8v6XTXTrvKTXse_Hg>
    <xmx:zoKManR1fKeKr2KOqjkSGKPd-ELdlMct4YKs1nokI58rsPO8n0Yv8g>
    <xmx:zoKMatElDJ5nl9EcuyrV7NfvsHQqc-QorKrwPZN2vUV6L76ygZFxPA>
    <xmx:zoKMar-SZivL39pmpkhb1mjq-glNvzg8Z_j9REFdF3xWdvyTUDkgwg>
    <xmx:zoKMaj0RGLoCrL21NmqzQckljrYnx81bmUsrVbyqfVjck1VBasoclN7k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 13:43:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 135922d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Aug 2026 17:43:40 +0000 (UTC)
Date: Mon, 24 Aug 2026 19:43:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2026, #10)
Message-ID: <aoyCyYDWEbgdnA48@pks.im>
References: <xmqqbjaru0yx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjaru0yx.fsf@gitster.g>

On Mon, Aug 24, 2026 at 06:01:10AM -0700, Junio C Hamano wrote:
> * ps/odb-geometric-repack-loose-threshold (2026-08-11) 1 commit
>  - odb/files: be less aggressive with geometric repacking
> 
>  The threshold for geometric repacking to trigger based on loose
>  object count has been adjusted to match that of 'git gc --auto',
>  preventing over-aggressive repacking during concurrent writes.
> 
>  Will merge to 'next'?
>  cf. <aoTcxJSmKWNhnjZ9@denethor>
>  cf. <CABPp-BHgyVTHB_OGmCL4JprFFe6_MapOQNSjUOhJxu-+oWbErg@mail.gmail.com>
>  source: <20260811-pks-geometric-maintenance-reduce-frequency-v1-1-7a54c42355ac@pks.im>

Yeah, this series can be merged.

> * fr/pack-objects-trace-pack-bytes (2026-08-19) 1 commit
>  - pack-objects: trace pack bytes written
> 
>  The pack-objects command has been updated to record the total bytes
>  written to pack files in trace2 output, allowing performance
>  analysis of different compression settings by comparing the
>  resulting pack sizes.
> 
>  Needs review.
>  cf. <aobFLJuiuM1EuNpv@pks.im>
>  cf. <20260820082102.GA2973952@coredump.intra.peff.net>
>  source: <c6a8cdac36d2202055d637ebcc97e484122cdcd4.1787158152.git.friel@openai.com>

I mentioned in my review that we might want to use a different hash
algorithm, but I think the ultimately patch is fine as-is. And both Peff
and you also acked it.

> * ps/odb-pluggable-pack-generation (2026-08-20) 6 commits
>  - bundle: generate packfiles via the object database
>  - bundle: get (mostly) rid of `the_repository`
>  - builtin/bundle: refactor option handling for progress meter
>  - send-pack: generate packfiles via the object database
>  - upload-pack: generate packfiles via the object database
>  - odb: introduce interface to generate packfiles
> 
>  The mechanism to generate a packfile corresponding to the result of
>  a fetch/push has been made pluggable through a set of object
>  database callback functions, removing hardcoded references to
>  'pack-objects' and enabling alternative ODBs to serve packfiles
>  themselves.
> 
>  Will merge to 'next'?
>  cf. <CABPp-BHAeb5Q6kWw8e0fz9+avKyJL0_k7cUzRhesHScJjB3Xfw@mail.gmail.com>
>  cf. <CAOLa=ZQMjb1SzYTVVuMF0ajmre_5_q=L6bmSQwYY233f-RiVXA@mail.gmail.com>
>  source: <20260821-b4-pks-odb-generate-pack-v4-0-074e8bd641f8@pks.im>

Yeah, I think this series should be ready.

> * jt/receive-pack-pluggable-writes (2026-08-20) 9 commits
>  - odb/transaction: add transaction interface to write packfiles
>  - odb: return temporary ODB source when set
>  - builtin/receive-pack: explicitly pass packfile fd
>  - builtin/receive-pack: report unpack errors via strbuf
>  - builtin/receive-pack: lift global state out of unpack()
>  - builtin/receive-pack: read unpack limit config lazily
>  - builtin/receive-pack: pass shallow file explicitly
>  - odb/transaction: add transaction finalize interface
>  - builtin/receive-pack: properly clean up keep files
> 
>  The 'git receive-pack' command has been updated to use a new ODB
>  transaction interface for writing incoming packfiles, making it more
>  backend-agnostic.
> 
>  Will merge to 'next'?
>  cf. <aohD54ZQEyybw008@pks.im>
>  cf. <xmqqo6evqzsu.fsf@gitster.g>
>  source: <20260820234940.894624-1-jltobler@gmail.com>

I'm happy with the state of this series.

> * ps/odb-eagerly-load-alternates (2026-08-17) 6 commits
>  - odb: drop `alternates_db` field
>  - odb: drop `loaded_alternates` field
>  - odb: eagerly initialize alternates
>  - odb: decouple source path comparisons from `the_repository`
>  - setup: create ref and object databases after config is written
>  - Merge branch 'ps/odb-make-creation-pluggable' into ps/odb-eagerly-load-alternates
> 
>  The object database layer has been simplified by eagerly loading
>  alternate object directories upon initialization, instead of
>  deferring it to the first object lookup.  This eliminates the need
>  for scattered lazy-loading calls throughout the codebase and paves
>  the way for integrating alternates with the pluggable backends.
> 
>  Will merge to 'next'?
>  cf. <CAOLa=ZReodSXjEbQkFoxcofMLq6mUOjXANRg7bZ2uEKKQn=DXw@mail.gmail.com>
>  cf. <xmqqik53qz5j.fsf@gitster.g>
>  source: <20260817-pks-odb-eagerly-prepare-alternates-v3-0-1115a7e02467@pks.im>

Yup, I think the discussion around "core.ignoreCase" has wound down by
now and we seem to all be on the same page there. I don't think any
further changes should be necessary as a result of it.

> * vm/complete-history (2026-08-13) 4 commits
>  - completion: complete 'git history split' pathspecs
>  - completion: complete 'git history --update-refs' values
>  - completion: complete 'git history --empty' values
>  - completion: add 'git history' subcommands
> 
>  The command line completion (in contrib/) has been taught to handle
>  the experimental 'git history' command.
> 
>  Will merge to 'next'?
>  cf. <aoWP3TYq5rNjUx7S@pks.im>
>  cf. <xmqqse49uanx.fsf@gitster.g>
>  source: <20260813-history_autocompletion-v3-0-69eed1cea93a@kernel.org>

I'm happy with this version.

> * dk/use-nsec-runtime (2026-08-20) 3 commits
>  - core: convert build-time USE_NSEC into runtime core.useNanosec
>  - environment: align repo_config_values_init with struct declaration
>  - meson: expose knob for xmlto relative links in manuals
> 
>  The build-time knob 'USE_NSEC' for nanosecond stat precision has been
>  converted to a runtime configuration 'core.useNanosec', allowing
>  distributions to bundle one binary that adapts to filesystem
>  capabilities dynamically.
> 
>  Needs review.
>  cf. <xmqqa4qgsn20.fsf@gitster.g>
>  cf. <aoaP7oIrR_Bpvx34@pks.im>
>  source: <cover.1787231825.git.ben.knoble@gmail.com>

I haven't gotten around to it yet, but will try to review it tomorrow.

Thanks!

Patrick
