Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7CC311583
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764595178; cv=none; b=J2Vw8hHUWVb8NA4HAxbiM7a3+7Hi0rS4UZmgJdrUlzlNWtCWwVS8QKrFZ5F3fcgBl1qRZXsxp0IHlrAAZELT6CjKyRUucTbYRXuXPnWStTUni0A1fQYh6404p/6XVZglesxbbauHYeq0N1r+CpEqwFz81t1yM8yrqfnNRn5raaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764595178; c=relaxed/simple;
	bh=3/iDtx68rmRueYFh1mDoiFc8cw2tDQorQxCj2hDNwyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZcSYtCkJchgLM2a2wj60NWYTiuRkM5YOYZkbqo+dzt6qbZ1ErAYaUWQxeKQo106sNE4+Tt3rZyLoY0m7Aht38gLY8T4L3W7HDnzJ1cFBxMuhoXptrWAkep7KHAoMMzNITQoHqTo9PaxJtsLh7prUxFvrhbdGJPKrL4RY255DyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KiVpbqr7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yG0/EWGD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KiVpbqr7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yG0/EWGD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 00745EC0557;
	Mon,  1 Dec 2025 08:19:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 01 Dec 2025 08:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764595174; x=1764681574; bh=JJRxrroM3B
	X60UWCNTopxivyj7/hfPjpoZ/zH7CwG2E=; b=KiVpbqr7Tj+8Kp8M9lF5NAwuqK
	Lbng4EWzgzKSWP70aIFINs1CznFtgrz3OGFgYoNZE0wGVuPr/iy751tOW58j9HCB
	h3OZGqwMvvKVLK8k8PiVHLaFJLS8etdUPv3aRR+SOrw0pZ6ckB+Ze1qHsM4cS500
	oTu1cYcQVAP3E3r6I/U3UfyBxbF3uWpnRn+Mg8nB0p3mk70Bq7aQRiD7j+yY9hTC
	m+rDaXTVGianNcrpL/N+hUsbYhkubiaaRus9dVyUW+Aifw6D8UvmR3CajoDqx0R+
	yhQWvecy/6bV6vRH+r3RN0VUhTu8Yz3A43EXbdceyX30ed9Epfqf+KTJYhsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764595174; x=1764681574; bh=JJRxrroM3BX60UWCNTopxivyj7/hfPjpoZ/
	zH7CwG2E=; b=yG0/EWGDejFQ5I1SA9plNMmyaSSNlaarIaMJaPWBuuCLCgB0MRw
	85Dulf95/CmsKyMDZZ58AjBJnqNENpZ1lgDx/pHjEKQeM46C2uhKY7BxniH+YIdR
	RVb6djZrpURx4XMoCnK2WgVE+1IUbYBq5gg6ZM2Jg7KEP21xowyOcvLyfPo7qF1S
	MJf2Ta/IHgV1IbkoUOk8NTtmfrFujZ2iTXWiPWaW9jichUXQTvUPpwK7C0yI53XQ
	u52eQOBFwF4CdQZqM8BRVP9XOlWkxlm/fpYMhfHFwN/9XnhEN1KGOuTURu2p48Ep
	PN/oWl/rwsvrAVggNVcpKElMFvDTig7pb4g==
X-ME-Sender: <xms:5pUtaWdwCLaBpjxPr40VN3_NpIWcHk_joRMQ4vm6sCETZ4J89O1vmg>
    <xme:5pUtaTduBjzOZhQgqVaGtDwYy__VEDI9alqDUJGyMe1ZbZOFsviS3-YXr1zSCNsut
    Pmai-ghxqNt0fdBy6Xoc4Ih91kadWDfpi4lunQm9wfiqw03ymyVEg>
X-ME-Received: <xmr:5pUtaQ_bQIsebzZQSVCfBvXDChYk-bCFn3fcv_jan-BRMxQvtXPCYwjaJvHHagR1vx4u9FattjvltHUCUPbrnwKSUltbD4Y96z0zH9PX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epgfeuffdtieejgeeutdetvdduhfeigffgfffhhfdtvdejteefuedtgfeihfetffehnecu
    ffhomhgrihhnpedtgigsshgrtddrohhnvgenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5pUtafk6ou34KJepvcFijstVrO7HsVsWlHML_UmZ1Ioyj8xiaLeF-A>
    <xmx:5pUtaS9TLEVSgFn5bfIypZHQAioIdceK-KIY3MDxCJfvLwbvDVNoGA>
    <xmx:5pUtadmuwiVXi1qUqe2yzyUV2vG2j96RpQAO2JJCMHrw7I9EzOCgsA>
    <xmx:5pUtaf0oNr7ob2WvKC8-bYxqalukoGk-7e0jtk-M3NcGq2lo1ia4eg>
    <xmx:5pUtaYEtJ80U7lzV-zRelyFXxlrA0-TBsQZ6jFm3P7kqzUn7FaTBfzUZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 08:19:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3ca88fe5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 13:19:32 +0000 (UTC)
Date: Mon, 1 Dec 2025 14:19:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] refs: allow setting the reference directory
Message-ID: <aS2V4TKeS4V_oxAb@pks.im>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <xmqq34651ie5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34651ie5.fsf@gitster.g>

On Sat, Nov 22, 2025 at 08:29:22PM -0800, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
> 
> > While Git allows users to select different reference backends, unlike
> > with objects, there is no flexibility in selecting the reference
> > directory. Currently, the reference format is obtained from the config
> > of the repository and the reference directory is set to the $GIT_DIR.
> 
> I actually am not sure if I like the proposed environment variable.
> 
> The proposal is based on an assumption that any reference backend
> should be able to move their backing store anywhere, and they should
> be able to express the location of their backing store as a single
> string <path>.  For a new backend, "where is your backing store" may
> not even be a question that does not make much sense (as "somewhere
> in the cloud that you do not even have to know" is certainly
> possible), and even for a new backend design that does allow such a
> question to have a meaningful answer, this "you have to be able to
> use a random place specified by this environment variable as your
> backing storage" is an additional requirement that its implementors
> may not need to satisfy in order to please their user base.
> 
> For reftable and files backends, these assumptions may be true, but
> then it is not too cumbersome if these stay to be backend specific,
> as there are only two backends.

I think it's a reasonable assumption to make that the path _can_ be
represented as a single string. For now, we don't really require any
configuration for the backend in the first place. So all you need to do
is to say:

    [extension]
    refStorage = reftable

This implicitly identifies the location of the backend, too, as we
derive it from the commondir/gitdir. As you say that's sufficient for
the "files" and "reftable" backends, but it may be insufficient for
other backends.

Suppose that we for example have a Postgres database to store data. It's
clearly not sufficient to specify "extension.refStorage=postgres", as
that wouldn't give you enough information to also know how to connect to
the database.

It's a problem I have been thinking about quite a lot in the context of
pluggable object databases, as well. Ultimately, the solution I arrived
at is to extend the extension format itself. For pluggable ODBs this
would look like this:

    [extension]
    objectStorage = postgres://127.0.0.1:5432?database=myrepo

This is similar to a normal URI with a schema: everything before the
"://" identifies the format that is to be used, and everything after is
then passed as-is to the backend itself. I think this should give us
enough flexibility for any future formats and it is easy enough to
configure. The added benefit is that this can also work in contexts like
the GIT_OBJECT_DIRECTORY and GIT_ALTERNATE_OBJECT_DIRECTORIES
environment variables, even though their naming is off now.

For the reference storage I think we should be moving into a similar
direction. Sure, for the current formats that we know its sufficient to
only specify their directory. But I think we should treat the directory
as an opaque string and then let the reference backend handle it, same
as with the proposed format for object databases:

    # A schema-only variable will be treated as if we specified the
    # common directory.
    [extension]
    refStorage = reftable

    # It's also possible to explicitly specify a different location for
    # the backend.
    [extension]
    refStorage = reftable:///foo/bar

    # And same as above, we can also specify non-locations.
    [extension]
    refStorage = postgres://127.0.0.1:5432?database=myrepo

As said, the important thing here is that the reference backends get the
string after the schema as opaque blobs that they can self-interpret.

> So I dunno.  In addition, if this is designed to help migration
> (which is the impression I am getting from the cover letter
> description), don't you need a way to specify more than one (i.e.,
> source to migrate from and destination to migrate to)?  With a
> single GIT_REF_URI, it would not be obvious what it refers to,
> whether it is an additional place to write to, to read from, or
> something completely unrelated.  For example ...

I think we cannot easily retrofit handling of multiple refdbs into Git
at this point in time anymore. The way to drive this would be that we
have two processes:

  - One `git refs list` process in the repository that uses the old
    format.

  - One `git update-ref --stdin` process in the repository that uses the
    new format specified via GIT_REF_URI.

This allows us to do an online migration of data into a separate ref
store.

> > This patch series adds a new ENV variable 'GIT_REF_URI' which takes the
> > reference backend and path in a URI form:
> >
> >     <reference_backend>://<path>
> >
> > For e.g. 'reftable:///foo' or 'files://$GIT_DIR/ref_migration.0xBsa0'.
> >
> > One use case for this is migration between different backends. On the
> > server side, migrating from the files backend to the newly introduced
> > reftable backend can be achieved by running 'git refs migrate'. However,
> > for large repositories with millions of references, this migration can
> > take from seconds to minutes.
> >
> > We could make the migration non-blocking by running the migration in the
> > background and capturing and replaying updates to both backends. This
> > would require Git to support writing references to different reference
> > backends and paths.
> 
> ... I am reading that the above is saying that the system will write
> to whatever reference backend specified in the extension.refStorage,
> plus also where GIT_REF_URI points at, but if that is the way how
> the mechanism works, the variable should be named more specific to
> what it does, no?  It is not just a random "REF URI"; it is an
> additional ref backend that the updates are dumped to.  Maybe there
> would be a different use case where you may want to read from two
> reference backends, and you'd need to specify the secondary one with
> an environment variable, but if the system behaves one specific way
> for GIT_REF_URI (say, all updates are also copied to this additional
> ref backend at the specified ref backing store), a different
> environment variable name needs to be chosen to serve such a
> different use case, no?

Truth be told, I'm not realy a huge fan of the name, either. But as
said, I don't think we can easily "overlay" multiple refdbs, as it would
lead to various different questions due to our hierarchical layout of
references.

That being said, I personally would prefer `GIT_REFERENCE_BACKEND` as
variable name that accepts exactly the same kind of strings as the
`extension.refStorage` values I have proposed above.

Thanks!

Patrick
