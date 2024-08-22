Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E7713A3FD
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310736; cv=none; b=IKKECs0hhJse40FUQoxHmAeG09ZBfYLIA0oSemuGKxEgAJDPvId8KyN69IVVnil2EuxZdB4KDhWbTDsvcgsGof43E87ps0lE6nDNSFK88GyfNOBshBpGG/ZGyMMaCc0A3XQNKQpfOgpwvANK1jAUVGTLsnUzTXzph0YQ4Kw7Ymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310736; c=relaxed/simple;
	bh=3JQgKsRCwrOhGes/Tgiq8gziStEftEooNaxpkdQFj6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gK94s6XS2tS30wL/SlDZmQuoBUb8FzEEQ9NFJNyhhRYn+bMEe+DD+Oy3KgVpxcQXxBucHkSd7du/aiqHX6z5ZR79aPS8EGIMyfdTe2y50yzurFGclbQ8OC9IdvqjcD0ETOI8pO6UaKWsH1E7LHcoLEh8JulRJu+ZLGkwFl0jHfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GBBaKrSi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bCzGuHDo; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GBBaKrSi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bCzGuHDo"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 902B0138FFAD;
	Thu, 22 Aug 2024 03:12:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 22 Aug 2024 03:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724310733; x=1724397133; bh=mmgOJag3/g
	6AlicTgFdK4A3O4J+1AO8HDart6k6EOJQ=; b=GBBaKrSi2ruukn0j5rsw/YXfq3
	UGlevQeH5xfqNa0C9GJJIlH8hyTwLz6AEd/OBEeDOKGUg/UH8qygxmC9ZW5/aNVA
	7nCtBFUXn/nxxEzU1s2nxsL6mmUomkvyc+Zggqkav8eVRHs5v5xNRGW8JK/Jphxm
	3bddpYZmgrbjNGYgB87/E5mF/t5TgOJWgJnTvtp6dHo83UeTveT5NH6btH0EyGDr
	3DCpbufLlmXduKQ2F5NFERbM31ZEAoNufMWFZro0Q3K47TiVQ9xQSRUdCconqxwI
	e5JiBeKdYvc63hTOQRw1/Ytu4liJUSoIO9D3iYpSsOD50WkJ3HWjt7iyUbBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724310733; x=1724397133; bh=mmgOJag3/g6AlicTgFdK4A3O4J+1
	AO8HDart6k6EOJQ=; b=bCzGuHDoiB9+cg4w5+wrhgAH2hln1D4c+0dJn9f9Kgm9
	WEos2esGPpBirlnt3hyPOB6bbDIV87G0uF8vqiydMW9BjMW5FuMLc6DqrfDbdSr9
	pEaanjPjb6B5FLMkzNwbUnIXLVRZlFGFnGX32LsEPo0B0TWz2xFFjakS0tWVYATd
	QYwoV52HAVd3oIZgnSkJ+qnc2iB7XB27ecfCgfcKzzIC6jPPIfCUMN6Ho6ewdssH
	aIDOWuwpfOwConQejpH08u+GHWwdn7IMUoBkUECOmJbGGqcb2nnP0/Gx10fSIy9d
	Djc/YyrIMngox8MPL6dOpHpgJxCD8LHZVjw5+Rymig==
X-ME-Sender: <xms:zeTGZkWmYIOllLtgneDRIJvYTH8vK2PPDT6XSa5DydqeEKf5oQF5yw>
    <xme:zeTGZonlGis4-7ONm-qRs2pS7mNg9hPJjGnK2d6U5yOOgY9i6un6Fc4lhTRYPNp7C
    YGy9JLGEBcWlb4MBw>
X-ME-Received: <xmr:zeTGZoYpWeREcVwImNhBBWWvu2uti5CMjb_hTAljiC_K9DF0aoSfXFZ7H1MJj2HBQrxSDUk0-hTueEKqspM914NlSnuQxtGKGoMuxAREDeskjbc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehtohho
    nhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:zeTGZjV-sBV2BkK7W686uFYdoLoXAcn7Xkzfw7PqLPPB3nEgATWt2A>
    <xmx:zeTGZukeqViLxYzSLfI8Dd6QZZBNAEq3SJOoCRDbLP5hhsQnyHCQRw>
    <xmx:zeTGZocber9jwfZmrP3PSH2D0Q_jIToP_Zdz9uEmgamqrM2vQdfQug>
    <xmx:zeTGZgGUyiD8MCJKyBUslEB6DG5qJledrifQWrljy0yMuN9-AieOEg>
    <xmx:zeTGZgjLAT8ZtrqsbS_gEBwET-y4TpnLu5P58eDIPhY8Fk78sQ3NPyCx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 03:12:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a42df14e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 07:11:36 +0000 (UTC)
Date: Thu, 22 Aug 2024 09:12:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon claes <toon@iotcl.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 3/3] fetch: use bundle URIs when having creationToken
 heuristic
Message-ID: <ZsbkyaLFnsz1Xik9@tanuki>
References: <20240722080705.2614195-1-toon@iotcl.com>
 <20240724144957.3033840-1-toon@iotcl.com>
 <20240724144957.3033840-4-toon@iotcl.com>
 <ZqObobw8FsDMkllm@tanuki>
 <87a5hv9gw0.fsf@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5hv9gw0.fsf@gitlab.com>

On Fri, Aug 02, 2024 at 03:46:39PM +0200, Toon claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > I think Junio essentially asked this already, but I'm still missing the
> > bigger picture here. When the "creationToken" heuristic is applied, the
> > effect of your change is that we'll always favor bundle URIs now over
> > performing proper fetches, right?
> 
> Yes, sort of. Bundle URIs are a step before "proper" fetches. A "proper"
> fetch might still happen after downloading bundles.
> (I would rather call them "negotiated fetches" or something, but let's
> just stick with "proper" fetch for now)
> 
> > Now suppose that the server creates new bundled whenever somebody pushes
> > a new change to the default branch. We do not really have information
> > how this bundle is structured. It _could_ be an incremental bundle, and
> > in that case it might be sensible to fetch that bundle. But it could
> > also be that the server generates a full bundle including all objects
> > transitively reachable from that default branch. Now if we started to
> > rely on the "creationToken" heuristic, we would basically end up
> > re-downloading the complete repository, which is a strict regression.
> >
> > Now that scenario is of course hypothetical. But the problem is that the
> > strategy for how bundle URIs are generated are determined by the hosting
> > provider. So ultimately, I expect that the reality will lie somewhere in
> > between and be different depending on which hosting solution you use.
> 
> That is true. The mechanism of bundle URIs is mostly outside the control
> of Git itself. It's up to the Git hosting provider how they use it. This
> gives them a lot of flexibility, like where to store bundles, how
> incremental bundles are used, and how often bundles are regenerated. But
> this also comes with a huge responsibility, due to the scenario you
> describe above.
> 
> At GitLab we want to do an initial roll-out of bundle URIs with just one
> bundle advertised to the client. This bundle is generated every week,
> and only contains the whole history of default branch (up to the newest
> commit). But, we'll advertise this bundle with creationToken "1",
> always. This will cause the client to fetch any bundle for the
> repository only once. Even when the bundle is updated by the server, the
> client will not fetch it because the creationToken did not change.

Okay. Are details like this documented anywhere in the Git project?
Because when we start to build on the preexisting heuristics I think
that we should give server operators a guide for how things come
together and what the client's expectations can and should be.

> > All of this to me means that the "creationToken" heuristic is not really
> > a good signal, unless I'm missing something about the way it works. Is
> > there any additional signal provided by the server except for the time
> > when the bundle was created?
> 
> The Git hosting provider can use the "creationToken" however they want,
> at the moment it's up to them to decide on a good strategy.
> 
> For example, assume you decide to create bundle URIs only for the
> default branch, then you can choose to use the committer date of the
> topmost commit of that branch as the creationToken.
> 
> Imagine you have the following example commit history (committer date of
> some commits are indicated with a caret below those commits):
> 
> 
>   A --- B --- C --- D --- E --- F --- G
>               ^           ^           ^
>       2024-08-02     2024-08-04     2024-08-09
> 
> Today (on 2024-08-02, at this point commits D to G don't exist yet) the
> Git host decides to create a bundle:
> 
> - git bundle create first.bundle main
> 
> The server will advertise this bundle with the creationToken being the
> Unix timestamp of the topmost commit in the bundle:
> 
> - first.bundle  = 2024-08-02  or in Unix 1722549600
> 
> When the client clones/fetches, it will download this bundle and store
> creationToken 1722549600 (= 2024-08-02) in the repo config as
> `fetch.bundleCreationToken`.
> 
> A few days later (on 2024-08-04, now D & E are added) the client fetches
> again, and there are no new bundles, so a "proper" fetch happens.
> 
> A week after the first bundle (on 2024-08-09, D to G were added since)
> the Git host decides to create a new (incremental) bundle:
> 
> - git bundle create second.bundle C..main
> 
> The server then advertises the following bundles:
> 
> - first.bundle  = 2024-08-02  or in Unix 1722549600
> - second.bundle = 2024-08-09             1723154400
> 
> Now when the client fetches again, it sees a new bundle "second.bundle",
> and will download it. This bundle contains the history from C..G. And
> you might have noticed, the client already has C..E, while it only needs
> E..G. This is a slight inefficiency, it's a pitfall of bundle URI I
> don't think we can avoid. By design bundle URIs are used to pre-generate
> files for clients to use, so they are never built-to-order. It's almost
> impossible to avoid clients to download bundles that have objects they
> already have.
> 
> Well, maybe it is possible. But then the question arises, if the current
> main branch is at G, do you want the client to download a bundle which
> has a little bit too much objects, or do you want to have the client do
> a "proper" fetch and skip any bundle?
> 
> But all the above assumes there's only one branch in the bundle. With
> more branches another strategy might be required.

Okay. What I'm still missing though is the ability for a client do
discern whether bundles are incremental or full.

In the schema you describe, my assumption is that the server operator
will eventually regenerate the first bundle to become a full bundle.
Which means that if there was any activity in the repository, then the
Unix timestamp of that regenerated bundle will likely be bigger than
what the client has stored on disk. Consequently, without information
that this is in fact a full bundle, the client would end up fetching it.
This is a potentially big waste of time and resources.

> > If so, is that information sufficient to determine whether it makes
> > sense for a client to fetch a bundle instead of performing a "proper"
> > fetch? If not, what is the additional info that we would need to make
> > this schema work properly?
> 
> I think my example above indicates the "creationToken" _can_ be
> sufficient information for the client to determine if downloading a
> bundle makes sense, but it depends on a well-though-out strategy of the
> Git host. So one the hand it gives the host the flexibility of using a
> strategy, on the other hand it puts a lot of responsibility on them.

It does put a big burden on the hoster to get it right, that much is
true. But I think the bigger problem is that the hoster _cannot_ get it
right, because they have no ability to distribute enough information to
the client.

For a schema like this to work I think we need to advertise at least two
things for each bundle: a unique bundle token, and the token of the base
bundle that a bundle may refer to. This would allow us to advertise
dependencies between bundles to a client rather easily: a full bundle
does not have a base, whereas incremental bundles would point to the
previous bundle.

A theoretical flow would thus go like this:

  1. The server announces the full bundle A.bundle. The client downloads
     it and stores the unique token Tok(A) in its config.

  2. Subsequent fetches notice that Tok(A) announced by the server and
     stored in the config remain the same.

  3. The server creates incremental bundles B.bundle and C.bundle.
     B.bundle builds on top of A, C builds on top of B. The server
     announces all three of those bundles. The client determines that it
     only has A, so to get to C it needs to fetch both B and C. It then
     stores Tok(C) in its config.

One scenario not yet covered is when the server regenerates the full
bundle to get A' = A + B + C + D. Ideally, the server would temporarily
announce a new bundle D = C + D while also announcing that A' and the
result from D are equivalent. Like this, the client knows that it does
not have to refetch A', but already has its contents and can thus update
its config to point to Tok(A').

But even a schema that is more involved like this one is rather
suboptimal. Eventually, the equivalence of Tok(A') and D will not be
advertised by the server anymore. So the client will not be able to
learn about which incremental bundles to fetch anymore, and would be
forced to re-download everything.

> > So unless I'm missing something, I feel like we need to think bigger and
> > design a heuristic that gives us the information needed. Without such a
> > heuristic, default-enabling may or may not do the right thing, and we
> > have no way to really argue whether it will do as we now depend on
> > server operators to do the right thing.
> 
> I think we're absolutely not ready to default-enabling the bundle URI
> feature in Git. Here at GitLab we're trying pilot bundle URI to figure
> out how it should/can work. Roll-out to CI runners is our first target
> and because we have the flexibility to toggle use of bundle URI on the
> client side, we can test things safely, without affecting any other
> user.
> 
> Talking about heuristics, any heuristic will be a _hack_ if you ask me.
> If you think about it, the bundles them self should be the single source
> of truth. In fact, a bundle is a packfile with a header prepended that
> contains refs and their OID in git-show-ref(1) format, and includes
> which prerequisite OIDs it has.

Yes, that is true indeed.

> So another approach I think of is to have the client partially download
> bundles (so it pauses the download once they have received the complete
> header) and make them parse the header to determine if they continue the
> download. But this approach feels quite complicated to me.

It certainly is more complicated. But it's also the only mechanism that
gives you all the information you need, I guess.

> Luckily, with the bundle.heuristic config we can always introduce new
> values if we discover there is a flaw in the "creationToken" heuristic.

Well, I'd claim we have already shown that it's flawed. I think before
we enable incremental bundle fetches by default, even if it's only with
the "creationToken" set, we need to show and document a way for server
operators to make use of this feature. In other words, we need to
document how they have to generate bundles in a way that does not cause
clients to re-download everything whenever a new bundle is announced.

Patrick
