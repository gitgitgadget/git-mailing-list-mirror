Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA8136341
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990695; cv=none; b=QLOcH1AXuPIVIOfxneLacCXgA33sf0fysLQdk57nSdcN+iUzDHPOMmBw4onbrC8zsyg1apvZqDQ/CWvK0hsy/jSg5a7YkbDXPnhPrTJAQ2FWRIirpNmrx13864QZLVfwEnCMxUozadHc0+IppCASvTP+Ru0OSb5vLqJ7BU1OJEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990695; c=relaxed/simple;
	bh=37kjzEy68ky2qzNpLCWGo4nZLJf3bdHt5p30+eEp5Zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLf3SMKaEVeDNA7WkSmY3BBQh4B36JvTvHi3bczx9AAR1vFApDa4Nuhjxn7p8vsXdBeoh5mwoaCIbketx3N9qzTBk5RMxXalMN4Ku9a4RVf51gIjXlQOzPachiRoMA6fJ4SdTs8r4DC9bJG9ghprm7tYIlxlBM/B2pMyXtFyMOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXnqiRta; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXnqiRta"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso8808219a12.1
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737990692; x=1738595492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WMQ5daqeCG/MMl9BWOxhi6cI0sEjZt1JVOZAECUhhE=;
        b=GXnqiRtaOCef2fCsNNepIpCxqvyuCNQQge7aBWwp3vm3/81qAOEyrD/WpSJ9im2x40
         VB2I0AiH8OdBYTibEV/HlusKEuGx2lR1CmEebu4gPFvQiWLMft/yeEfCLWtzBk2JdqMU
         E10g1/yvetRbrV7fzYqf5a/Yzw6FnUUGukvACNt5CDUoIQr5oIeOAeijjRz0eqRACGzQ
         qdWopOHwlQ/6tyyCOxR9uzdGw5k59z/8r8mXpcyLlLS43jwN+zDmSFSjGUHnlk9V2gsd
         FBhfrDWNrAjWVqdXxUbVkmU9hSkCaNmw7Jqlwip6aHYN9C8OBledS+PwD3cAKIRe8h4m
         gnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737990692; x=1738595492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WMQ5daqeCG/MMl9BWOxhi6cI0sEjZt1JVOZAECUhhE=;
        b=mqMKg5Q1bEvd3IMhgmYhRnMMdxMd2sITF2zFyDWGz1l9sNo9b09Fq3HdPNH+y71exs
         cctt0C9sEtOnZquvtFEj2aZCwSIg1biNBb9FfYHHtyYXwksc+U2J+QtQITLh36y4YtwS
         iy/k0izD1VcvIMBFPsT89GKbVQcnyjYOA00o/DvC6Buv626o4tEYgOKp8CK/cP4pJy5i
         smVAislEP+/erZeu2pjPlq/VEQ1ZOeG6un3C8PmhsbkdLDx6o5tWwiQAGLELLhTuJESi
         /XW2yzutEzjrBgolz4wU5Fn1WxAV6Ztr507U97MPMozVoad+keTGu8wz4j/fbEFi5xcs
         biVQ==
X-Gm-Message-State: AOJu0Yz8hlUzv2YhTnofPYC2WLIdK71y9FOtWxQ1jnvNog6Eg6fPKoeu
	HcwXbr2oFuKen62qz26P0byw/9SflM3iDAvQrRC9XMYeI/EUO/KNGEoIIwLB0yi9i753FR9ZS5d
	sStLTmbc2WfMtizht/n3KEQyuEpI=
X-Gm-Gg: ASbGncu3FUT/dxAZUk95BfjVfzQF4TDFmA3wVgxbiGNE4+64pGDkdGvG2q7x5WR3Sp9
	/OujRNO2+bxAo8mbxHPMD0hgoVSvrNO11qAz8AeZdawqP3NKfgq78KBL+NTWX1EMY
X-Google-Smtp-Source: AGHT+IEEryZ+nTzsBCcW2zK8bSU21UpZbvEFLmmE6UkFc8pfcbXReQxVLiPo34GBxssdMFXyO9kLzhVKhPTwOzwz4+8=
X-Received: by 2002:a05:6402:524e:b0:5d3:d8e7:d6d2 with SMTP id
 4fb4d7f45d1cf-5dc17fed201mr12351372a12.1.1737990691479; Mon, 27 Jan 2025
 07:11:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910163000.1985723-1-christian.couder@gmail.com>
 <20241206124248.160494-1-christian.couder@gmail.com> <20241206124248.160494-6-christian.couder@gmail.com>
 <xmqqjzc7lq60.fsf@gitster.g>
In-Reply-To: <xmqqjzc7lq60.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 27 Jan 2025 16:11:18 +0100
X-Gm-Features: AWEUYZmojhle0qFWOXg0-2MOyGU7v3oWMb9oSSqsF-j8nPTsPrDYbgSsairKcYU
Message-ID: <CAP8UFD2Pehtk2=GkjrXga0bqsrUFauYKkPYPWgdRHsoaDvQQDA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] doc: add technical design doc for large object promisors
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 12:43=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > +We will call a "Large Object Promisor", or "LOP" in short, a promisor
> > +remote which is used to store only large blobs and which is separate
> > +from the main remote that should store the other Git objects and the
> > +rest of the repos.
> > +
> > +By extension, we will also call "Large Object Promisor", or LOP, the
> > +effort described in this document to add a set of features to make it
> > +easier to handle large blobs/files in Git by using LOPs.
> > +
> > +This effort would especially improve things on the server side, and
> > +especially for large blobs that are already compressed in a binary
> > +format.
>
> The implementation on the server side can be hidden and be improved
> as long as we have a reasonable wire protocol.  As it stands, even
> with the promisor-remote referral extension, the data coming from
> LOP still is expected to be a pack stream, which I am not sure is a
> good match.

I agree it might not be a good match.

> Is the expectation (yes, I know the document later says
> it won't go into storage layer, but still, in order to get the
> details of the protocol extension right, we MUST have some idea on
> the characteristics the storage layer has so that the protocol would
> work well with the storage implementation with such characteristics)
> that we give up on deltifying these LOP objects (which might be a
> sensible assumption, if they are incompressible large binary gunk),

Yes, there is a section (II.2) called "LOPs can use object storage" about t=
his.

In the next version I have tried to clarified this early in the doc by
saying the following in the non-goal section:

"Our opinion is that the simplest solution for now is for LOPs to use
object storage through a remote helper (see section II.2 below for
more details) to store their objects. So we consider that this is the
default implementation. If there are improvements on top of this,
that's great, but our opinion is that such improvements are not
necessary for LOPs to already be useful. Such improvements are likely
a different technical topic, and can be taken care of separately
anyway."

> we store each object in LOP as base representation inside a pack
> stream (i.e. the in-pack "undeltified representation" defined in
> Documentation/gitformat-pack.txt), so that to send these LOP objects
> is just the matter of preparing the pack header (PACK + version +
> numobjects) and then concatenating these objects while computing the
> running checksum to place in the trailer of the pack stream? Could
> it still be too expensive for the server side, having to compute the
> running sum, and we might want to update the object transfer part of
> the pack stream definition somehow to reduce the load on the server
> side?

I agree that this might be an interesting thing to look at, but I
think it's not necessary to work on this now. It's more important for
now that the storage for large blobs on LOPs is cheap.

As clients may not all migrate soon to a version of Git that supports
LOPs well, it's likely that LOPs will be used for repos that are
mostly inactive first (at least that's our plan at GitLab), so there
would not be much traffic. This would give us time to look at
optimizing data transfer.

> > +- We will not discuss those client side improvements here, as they
> > +  would require changes in different parts of Git than this effort.
> > ++
> > +So we don't pretend to fully replace Git LFS with only this effort,
> > +but we nevertheless believe that it can significantly improve the
> > +current situation on the server side, and that other separate
> > +efforts could also improve the situation on the client side.
>
> We still need to come up with a minimally working client side
> components, if our goal were to only improve the server side, in
> order to demonstrate the benefit of the effort.

How would clients work worse with large files compared to the current
situation, when the benefit of the current effort (the
"promisor-remote" capability) makes it easier for them, but doesn't
force them, to use promisor remotes?

If clients can use promisor remotes more, especially when cloning,
they can benefit from having fewer large files locally when they don't
need them. So they should just work better. And again they are not
forced to use promisor remotes, if they still prefer not to use them,
they still can perform a regular clone, and they will not work
differently than they do now.

> > +In other words, the goal of this document is not to talk about all the
> > +possible ways to optimize how Git could handle large blobs, but to
> > +describe how a LOP based solution could work well and alleviate a
> > +number of current issues in the context of Git clients and servers
> > +sharing Git objects.
>
> But if you do not discuss even a single way, and handwave "we'll
> have this magical object storage that would solve all the problems
> for us", then we cannot really tell if the problem is solved by us,
> or by handwaved away by assuming the magical object storage.
> We'd need at least one working example.

It's not magical object storage. Amazon S3, GCP Bucket and MinIO
(which is open source), for example, already exist and are used a lot
in the industry. Some Git remote helpers to access them can even be
found online under open source licenses, like for example:

  - https://github.com/awslabs/git-remote-s3
  - https://gitlab.com/eric.p.ju/git-remote-gs

Writing a remote helper to use some object storage as a promisor
remote is also not very difficult. Yeah, perhaps optimizing them would
be worth the effort, but they are, or would likely be, at least for
now, separate projects, and nothing prevents people interested in
optimizing them from contributing to these projects.

I have added some details about these object storage technologies and
remote helpers to access them in the next version of the doc.

> > +6) A protocol negotiation should happen when a client clones
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +When a client clones from a main repo, there should be a protocol
> > +negotiation so that the server can advertise one or more LOPs and so
> > +that the client and the server can discuss if the client could
> > +directly use a LOP the server is advertising. If the client and the
> > +server can agree on that, then the client would be able to get the
> > +large blobs directly from the LOP and the server would not need to
> > +fetch those blobs from the LOP to be able to serve the client.
> > +
> > +Note
> > +++++
> > +
> > +For fetches instead of clones, see the "What about fetches?" FAQ entry
> > +below.
> > +
> > +Rationale
> > ++++++++++
> > +
> > +Security, configurability and efficiency of setting things up.
>
> It is unclear how it improves security and configurability if we
> limit the protocol exchange only at the clone time (implying that
> later either side cannot change it).  It will lead to security
> issues if we assume that it is impossible for one side to "lie" to
> the other side what they earlier agreed on (unless we somehow make
> it actually impossible to lie to the other side, of course).

It's not limited to clone time. There are tests in the patch series
that test that the protocol is used and works when fetching.

The "What about fetches?" FAQ entry also says:

"In a regular fetch, the client will contact the main remote and a
protocol negotiation will happen between them."

Or are you talking about lazy fetches? There it is mentioned that a
token could be used to secure this. Other parts of the doc mention
using such a token by the way.

I have changed the note about fetches to be like this:

"For fetches instead of clones, a protocol negotiation might not always
happen, see the "What about fetches?" FAQ entry below for details."

> > +7) A client can offload to a LOP
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +When a client is using a LOP that is also a LOP of its main remote,
> > +the client should be able to offload some large blobs it has fetched,
> > +but might not need anymore, to the LOP.
>
> For a client that _creates_ a large object, the situation would be
> the same, right?  After it creates several versions of the opening
> segment of, say, a movie, the latest version may be still wanted,
> but the creating client may want to offload earlier versions.

Yeah, but it's not clear if the versions of the opening segment should
be sent directly to the LOP without the main remote checking them in
some ways (hooks might be configured only on the main remote) and/or
checking that they are connected to the repo. I guess it depends on
the context if it would be OK or not.

I have added the following note:

"It might depend on the context if it should be OK or not for clients
to offload large blobs they have created, instead of fetched, directly
to the LOP without the main remote checking them in some ways
(possibly using hooks or other tools)."
