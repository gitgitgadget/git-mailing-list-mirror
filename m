Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5B43D34AC
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851359; cv=none; b=QdTDk3u00ZOGYSxl4/KkLodwE/Wm3nzn+antX6JrNJ8twTbrVp0apLlhNKFFXz/Pm3ZqO7s3UgjMhIgN40lnuX/zb0s8cpIVBxYb/4CYX09d/QVwKcZV/LN0f8SH7Hjq7oumyMVeGxd6jiJpTZxYiSerR3JuI1Dq32/miCAsG0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851359; c=relaxed/simple;
	bh=IxDUIIJIikVLPWEFryUsKJ3aDhT1dGC0hNebKMGNcyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMbrFpAcdCVdn10Q/yMHQ3ZGg80Y7SdLX/bgz8N2hV4DzEajv70X/LciooqUcgG5NBePwkVTVdAt4Q68Dh0SowHthes6sLVfKZLWUpaTpTOatQlY3HsTkd/syEkMC4UUBWqpB7PahmJljNNxwp2BpPDFD5OZIjZ60fFSk53oJQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZrLFhUo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZrLFhUo"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so207645e9.2
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 09:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773851350; x=1774456150; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i/3edT/TKkr6xyoqNlQ1FMLUNoPDTJt9oncOXKp4/uE=;
        b=WZrLFhUoyoH0m6CMa37ZqmkchZ7G+KugHA4NMUKO0w6f4JHfke5QrUE1xqueRFtinu
         7FTepo7TJ+m6ZH5n56BYcQLL9myIjhz6JwLUeNIOdKRYG9wt4fyQhSy4COBTssIQF0Bb
         MxOThjx31Fzn3hnF7IjRlsV9qXq9wkex1K3ge3+SVW/SxMIb2CA30NOzMEz+U4ELhaSa
         iy6JB9lCPCW22gEFGCtt4nQrcFEpb3yw8kJvT1SNjqdyYDORc4tRfuwf1naXhAjI33Mo
         4OeaBA+IxEaOMSPoZtJnkzbwzLtjFZ4qo6Q+BA2TLbieTSc1BICfDFIzgrypppnwUcMp
         0tPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773851350; x=1774456150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/3edT/TKkr6xyoqNlQ1FMLUNoPDTJt9oncOXKp4/uE=;
        b=IJSxYGQx/eQNXIH1RZ1YafHcsNDWQ29kaGlIShT6DGv6fSPGuZcRlyyobaiK3SX3PW
         GyXRGhPOqeM0bkQhDnfi/GGXWhHt0H1/izUj7mSQHZmtDihW1WMNIq/osm1S6BPLO/t4
         7nJAUvcQd4zdLs11q8CvZSfbbp1itBsuOiozcMVKQObNTTY6ofMW4tpSLE6xsNrYIin2
         ZGdxjiRv4CIZo/e9WpsUxIClhaM4DWyNYaAFQOWR3730rLQ09q+eq8NQhof2G/u8nvLy
         TudLIIRkYCoYBOaq7PyZtCO3/p1I1aLwiP9OjxChKy14onEdzSCBbwPQ5zTpKYmykQgy
         ra6w==
X-Gm-Message-State: AOJu0Yx/+0uHWTPXenNl1+RfClHp2GJ4ExkOZ8IKD7drmmowiV9jP+gi
	qHhg7qmuYiOEbiisWf+b7NsVJm6xGmr10YuGmFS/Z0jao1uRiRbLtIy4sFKDGHCnSuulsw==
X-Gm-Gg: ATEYQzzss92JqETTz6vIyP3x/Ojn/hnMLtuLA1bgE4PVOE/bq6+v5SVXsAY8hk/6W00
	QCEP+8CkbeMnjxBGX4Z8kN2dvLrAlbSFk2HZvHg1RjmSA/5SGYd+xXW6ylvspRMi6p/ew1s48bh
	yS2hj2yjo9foF+4sj1Up+aJy+CqnMpIjpq9yFsWRZb3X8Cq/r7krn7UzCMLi9r4l4aBIZJWaJaD
	k73mUVOLGOphA5bOMuSWlP82BffhTRYFJ/j7CKCxoPkE4c1LbbwCR/wAdAyIbKGPVoZtmEKb/Lp
	FaMrmSnYDHTTslikTkR94K0j7+Y/T5S7FwQ9ZCziq53V1+ycik/oq2yao+oynEj4a1JSDxuis0J
	zjLzsVyMd2sSJ7eIz2iwyOR5R2lx8i1uQHDXW6HU8/iepqSg7A+C7SnOhWDzOkeB+cPeGnRtAtB
	fEcfFtjqMVWY3M809FYEryzrNByKKTH3RDlFfCrNybGwd9HMJ9InK5yc+JPL9RheIaXjW5qbyEO
	zzBaPdi
X-Received: by 2002:a05:600c:871a:b0:480:1c85:88bf with SMTP id 5b1f17b1804b1-486f4451195mr68126985e9.27.1773851349095;
        Wed, 18 Mar 2026 09:29:09 -0700 (PDT)
Received: from lorenzo-VM (host-79-19-37-238.retail.telecomitalia.it. [79.19.37.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51892244sm9772495f8f.22.2026.03.18.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:29:08 -0700 (PDT)
Date: Wed, 18 Mar 2026 17:29:06 +0100
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC Proposal] Implement promisor remote fetch ordering
Message-ID: <abrS0q_Oc3kn_T3Y@lorenzo-VM>
References: <abBh__zmlWXY-yjI@lorenzo-VM>
 <CAP8UFD1=Ow6NNFKK6y5csmneVaS0J+e5z9pGjFmaVoJ2g1OPFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1=Ow6NNFKK6y5csmneVaS0J+e5z9pGjFmaVoJ2g1OPFg@mail.gmail.com>

On Sat, Mar 14, 2026 at 06:30:57PM +0100, Christian Couder wrote:
> On Tue, Mar 10, 2026 at 7:25 PM Lorenzo Pegorari
> <lorenzo.pegorari2002@gmail.com> wrote:
> >
> > The following is my proposal for the GSoC'26 for the project "Implement
> > promisor remote fetch ordering".
> 
> Thank you for your interest in Git and this project.

Thank you for reading and giving me feedback on my proposal!

> > As soon as the the contributor application period begins, I will submit
> > the proposal in PDF format to the official GSoC website.
> 
> Good idea.

I will send v2 and upload it pretty soon.

> For the patches that are merged to master, it could help if you could
> give the object ID of the merge commit that merged your commits into
> master, or alternatively the object ID of all your commits.

Ack.

> >  * [GSoC PATCH v3] doc: improve gitprotocol-pack
> >    * Link: https://lore.kernel.org/git/cover.1772502209.git.lorenzo.pegorari2002@gmail.com
> >    * Description: Improved the `gitprotocol-pack` documentation.
> >    * Status: Will merge to `master`.
> 
> Yeah, this has been merged to master after your email.

Ack.

> > Partial clones avoid this issue during `clone` and `fetch` operations by
> > passing all the objects to download through a `--filter=<filter-spec>`
> > specified by the user, which will limit the number of blobs and trees
> > that actually get downloaded. The `<filter-spec>`, can, for example, be:
> >  * `blob:none`, which will filter out all blobs.
> >  * `tree:0`, which will filter out all trees.
> >  * `blob:limit=5k`, which will filter out all blobs whose size is greater
> >    than $5$kB.
> 
> Why are there '$' signs above?

Ops. I wrote the proposal on Markdown with LaTeX support. Text between
"$" is considered LaTeX. Forgot to delete it when sending the email. My
fault.

> > The filtered out objects will be lazily downloaded when the user runs a
> > command that requires those missing data.
> >
> > This mechanism works with the following steps:
> >  * When the client wants to fetch some objects from the server using a
> >    filter, the client, after sending a list of capabilities it wants to
> >    be in effect, sends the `filter: <filter-spec>` capability, followed
> >    by a request for the objects that the client wants to retrieve. The
> >    following is an example of a request (extracted using
> >    `GIT_TRACE_PACKET=1`) made by a client to a server to fetch 1 object
> >    using the `<filter-spec>=blob:none`:
> >
> >    ```
> >    [...]
> >    pkt-line.c:85           packet:        fetch< 0000  # "flush-pkt"
> >    pkt-line.c:85           packet:        fetch> command=fetch  # Execute fetch
> >    pkt-line.c:85           packet:        fetch> agent=git/2.43.0
> >    pkt-line.c:85           packet:        fetch> object-format=sha1
> >    pkt-line.c:85           packet:        fetch> 0001  # "delim-pkt"
> >    pkt-line.c:85           packet:        fetch> thin-pack  # Capability
> >    pkt-line.c:85           packet:        fetch> no-progress  # Capability
> >    pkt-line.c:85           packet:        fetch> ofs-delta  # Capability
> >    pkt-line.c:85           packet:        fetch> filter blob:none  # Filter capability
> >    # OID of the object the client wants to retrieve
> >    pkt-line.c:85           packet:        fetch> want 394ca7a7b5e75a57e736040480f685c8b71844eb
> >    pkt-line.c:85           packet:        fetch> done  # End fetch
> >    pkt-line.c:85           packet:        fetch> 0000  # "flush-pkt"
> >    [...]
> >    ```
> 
> I think when lazy fetching like this, the filter is always blob:none.
> It's not really used anyway because the objects that the client wants
> are specified explicitly.

Oh, I didn't know that. Makes sense.

> The filter is important when initially cloning or fetching from the
> server to specify which objects are initially excluded, even if some
> of these  objects will be lazy fetched soon. For example the checkout
> part of a clone might need objects that were initially excluded, so it
> might lazy fetch some.

Ooh ok, with this comment I actually fully understand now. Looking back
at the `GIT_TRACE_PACKET` output, I actually understand almost all of
it. So the partial clone fetches (usually) the `HEAD`, excluding the
filtered out objects, while the lazy fetching directly asks for the
missing objects when they are needed, so the filter is not used. Got it!

> >  * The server will apply the requested `<filter-spec>` as it creates the
> >    "promisor packfile" of the requested objects.
> 
> This is important during an initial clone or fetch, not when lazy fetching.

Got it. I will revisit all the instances where I made some confusion
between lazy fetching and initial cloning/fetching. Thank you so much
for your explaination Christian!

> > A packfile is a binary
> >    file that is used to compress many "loose objects", and it does so by
> >    containing the most recent versions of the stored objects and deltas
> >    of the previous versions of those objects. A promisor packfile is a
> >    filtered packfile, where the unwanted objects are not present. The
> >    promisor packfile is sent to the client.
> 
> 
> > I created a minimal example setup, mostly based on the test
> > `t/t5710-promisor-remote-capability` added by `4602676` ("Add
> > 'promisor-remote' capability to protocol v2", 2025-02-18), to experiment
> > with multiple promisor remotes, in order to not simply rely on the
> > documentation, but to actually get hands-on experience. The example setup
> > creates a `server`, a 'lopm' ("Large Object Promisor medium") for blobs
> > larger than 5kB, a `lopl` ("Large Object Promisor large") for blobs
> > larger than 50kB, and a `client` that interfaces with all of these
> > remotes. It is created in the following way:
> 
> [...]
> 
> > Now, with this setup, by slightly tweaking the configurations of each
> > repository, it is possible to deeply test how multiple promisor remotes
> > are handled in various situations, and actually see what is described in
> > the documentation.
> 
> Yeah, it's quite complex to set up.

Yep. The complexity of the tests are the reason behind my decision to
deeply describe them in the proposal.

> > ## Testing Promisor Remotes Advertisement
> >
> > An important thing to test is the promisor remotes advertisement feature.
> > This feature is dependent on 2 main configuration options: the
> > server-side option `promisor.advertise`, which enables the server to
> > advertise the promisor remotes it is using to the client, and the
> > client-side option `promisor.acceptFromServer`, which describes how the
> > client should handle the promisor remotes advertised:
> >
> >  * If `promisor.advertise=false`, when the `client` wants to fetch an
> >    object that the `server` does not have,
> 
> I don't think it depends on the client fetching an object the server
> does not have. It depends on the client using a filter because the
> promisor-remote capability only makes sense in the case of partial
> clones (or fetches).

Ok yeah, I should have explained this better. Of course this depends on
the client using a filter. Thanks for the feedback.

> > the `server` will not
> >    advertise the `promisor-remote` capability, and so it has no other
> >    choice than to first fetch the object from `lopl` and/or `lopm`, and
> >    then give it to the `client`. This can be checked by doing `git -C
> >    server rev-list --objects --all --missing=print`, and seeing that the
> >    previously missing large blobs are now present inside the `server`, or
> >    by directly looking into the `GIT_TRACE_PACKET` output, and seeing
> >    that there is no reference to the `promisor-remote` capability.
> >
> >  * If `promisor.advertise=true`, when the `client` wants to fetch an
> >    object that the `server` does not have,
> 
> Same as above, it doesn't depend on the client fetching an object the
> server does not have. It depends on the client using a filter because
> the promisor-remote capability only makes sense in the case of partial
> clones (or fetches).

Ack. Same as above.

> > the `server` will advertise
> >    its promisor remotes, as seen by the `GIT_TRACE_PACKET` output, which
> >    will contain:
> >
> >    ```
> >    [...]
> >    packet: upload-pack> promisor-remote= \
> >        name=lopl,url=file://$(pwd)/lopl; \  # Adv lopl
> >        name=lopm,url=file://$(pwd)/lopm  # Adv lopm
> >    [...]
> >    ```
> 
> [...]
> 
> > Recently, with the patch series "Implement `promisor.storeFields` and
> > `--filter=auto`" [5], the new client-side configuration variable
> > `promisor.storeFields` was added. It contains a list of field names
> > `partialCloneFilter` and/or `token`), and the values of these fields,
> > when transmitted by the server, will be stored in the local configuration
> > on the client.
> >
> > ## Testing Multiple Promisor Remotes Fetch Order
> 
> Yeah, I think this is the most relevant for the project.

Agreed.

> > Finally, the last mechanism that is fundamental to understand is the
> > fetch order when multiple promisor remotes are defined:
> >
> >  * When multiple remotes are configured, they are tried one after the
> >    other in the order in which they appear in the configuration, until
> >    all objects are fetched.
> 
> Right, but there is the exception of a remote configured with
> `extensions.partialClone` that will be tried last. You mention it
> later though.

Yep, will mention it also here.

> > This can be easily seen from the output of
> >    `GIT_TRACE`, which initially tries to fetch the objects from `lopl`,
> >    and then from `lopm`:
> >
> >    ```
> >    [...]
> >    trace: built-in: git fetch lopl [...] --filter=blob:none [...]
> >    [...]
> >    trace: built-in: git fetch lopm [...] --filter=blob:none [...]
> >    [...]
> >    ```
> >
> >    While, if we make it so that we first define `lopm` in the `client`
> >    configuration, then initially `lopm` will be used to fetch the
> >    objects, and `lopl` will not be used at all (because `lopm` contains
> >    all required objects:
> >
> >    ```
> >    [...]
> >    trace: built-in: git fetch lopm [...] --filter=blob:none [...]
> >    [...]
> >    ```
> 
> Yeah, when all the needed objects have been lazy fetched, there is no
> point in further fetching from any remote.

Yeah, and so `lopl` is not tried at all.

> >  * If the configuration option `extensions.partialClone` is present, the
> >    promisor remote that it specifies will always be the last one tried
> >    when fetching objects.
> >
> > ------------------------------
> >
> > # "Implement promisor remote fetch ordering"
> >
> > ## Project Goal
> >
> > This project aims to improve Git by implementing a fetch ordering
> > mechanism for multiple promisor remotes, that can be:
> >
> >  * Configured locally by the client.
> >  * Advertised by servers through the `promisor-remote` protocol.
> >
> > ## Approach
> >
> > The bulk of the project will be the creation of a system that allows to
> > define the order with which the promisor remotes will be tried when
> > fetching an object.
> >
> > The first goal will be the creation of a `remote.<name>.promisorPriority`
> 
> Yeah, or just `remote.<name>.priority`. The name is to be discussed.

Ack.

> > configuration option, which will hold a number between 1 and 'UCHAR_MAX',
> 
> UCHAR_MAX could be system dependent. It might be better to have
> configurations work in the same way on all machines though. So perhaps
> a fixed range like 1 to 100 would be better. Or are there other ranges
> of values used for similar things in Git or other well known software
> that could be reused?

Mmh true. A fixed range might be better, I agree.

> > and which defines the priority of that promisor remote in the fetch
> > order. This means that the order in which the promisor are tried will be
> > the following:
> >
> >  * All promisor remotes that have a valid `remote.<name>.promisorPriority`,
> >    starting from the one with higher priority (the lower `promisorPriority`
> >    value). If 2 or more promisor remotes have the same priority, they will be
> >    tried following the order in which they appear in the configuration file.
> >
> >  * All promisor remotes that don't have or have an invalid
> >    `remote.<name>.promisorPriority` configuration option. If 2 or more
> >    promisor remotes don't define any priority, or have an invalid priority,
> >    they will be tried following the order in which they appear in the
> >    configuration file.
> >
> >  * The promisor remote defined inside the `extensions.partialClone`, no
> >    matter their priority (which will be ignored if present). This is
> >    necessary for backward compatibility.
> 
> Yeah, I think something like what you describe makes sense.

Nice! :-)

> > Having already taken a look at the code, I have a general idea of th
> 
> s/of th/of the/

Ack.

> > major steps to take to actually introduce the
> > `remote.<name>.promisorPriority` configuration option:
> 
> [...]
> 
> > # Possible Issues
> >
> > From my understanding, the project as it is proposed will handle all
> > possible cases, except for one. Let's imagine the following situation:
> >
> >  * `server1` and `server2` both use the promisor remotes `lop1` and `lop2`.
> >  * `client` has both `server1` and `server2` as remotes.
> >
> > In this situation, the `client` has no way to specifically say that when
> > fetching from `server1`, it wants to first try `lop1` and then `lop2`, while
> > when fetching from `server2`, it wants to first try `lop2` and then `lop1`.
> 
> Right, but lazy fetching does not only happen as part of a clone or
> fetch from a server. It happens when for some reason (like a git show
> or a git blame for example) the user needs some objects it doesn't
> have locally, and when that happens, this is not related to a single
> server.
> 
> So global priorities are likely the most useful ones to have.
> 
> > One way to solve this very specific (and maybe unusual) issue is to
> > introduce a way to associate a `promisorPriority` to a specific remote.
> 
> Yeah, but I don't think it would be used a lot. We can perhaps think
> of some cases where it could be useful, but in practice it is likely
> that if there is an optimal order for one server, it will be optimal
> for all other servers too.

I agree. I should have pointed out clearly that, to me, this unusual
situation doesn't seem worth the effort.

> [...]
> 
> Thanks!

Thank you Christian!
