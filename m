Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5009A2FAC0B
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330275; cv=none; b=ICNYfAJlR0mAxpsB8J5qMoYnS4ddolS6SahIMq0ZxXLy0NF/y/F3PpZ6tBdgrReWhcbNG9IXcFYBwepLLw4eU3M6QNG/hQTQrtasM+hUETI2vzQhbrqxMr3jC/gSEZ/7Zx9IPhVnSNTYuE5YkY8H4A7F6zegYzOvlEUTuCYPjM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330275; c=relaxed/simple;
	bh=Ivie+bpyLR8lcV+wTDWFzdAIXXC2HIQhn7U2AwsMFUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5MbW5wyKdJV3LV2zpFSjg8Co9oeg1axyIWRwdOkcpZunKn/o243NDVNIhJhinbPyA2Wkku4o4wGWeXq1ImlPefw43R3A3e39CXXZGJrQUGxb7/Ea5XuYYdIXSYBoXI7WQ+9e/rqwpD5dHd7TJfUS1cUec4av/n53UabOpZUUD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l2+BptpB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QDj8G0MZ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l2+BptpB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QDj8G0MZ"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 3668D1D000DD;
	Mon,  8 Sep 2025 07:17:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 08 Sep 2025 07:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757330271; x=1757416671; bh=xbuQi+wh9c
	asrZ0OzobS+e4k5yoQ2nSas0owtX5xcbw=; b=l2+BptpBz0WDnGGfvJAM2ALfbQ
	8NI9Ue6UUFuYsrP2IhDgXsboy2IY1g1wgXvwWlOcixijMFqDulsAaQk0GolzszTb
	sYFnsP6K7AgCBgXH0W6ziyRnd1zmACAsNCHsvGbJMaxdetPJj8r3BgTay3Engtk/
	qPJfxTmfoPN640ct62S73jCXdy/D5aNhlktX8cU9rPyPtI+9bg6JtNHpMZGgTKsr
	TX3lGMNLvLc+mUel7TxVrAbTySiVyJ1dn8sKzoKCF5r4Gr8vhBazrwhMC7JQyRXW
	rurL94t1J+Gkw1Y40t+510uMceFrzdSeknTj0ESHQYfOnLH2fQCpY5L+gWag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757330271; x=1757416671; bh=xbuQi+wh9casrZ0OzobS+e4k5yoQ2nSas0o
	wtX5xcbw=; b=QDj8G0MZtbckgZEcNl9s/xy1lt4IXc0p6hZTR7UzBNvDQy/Xdpd
	7bnrtXRsXI2YuqS3qUEZMuUQo0EWQgex2WnKchO2Yfib7fSDrhL0kIqR+HWXbrcT
	15MoqPykBfxesdmvxEgGvgoW+TiyImdOisKzHW6J6f/gbW9ZVKl801bafhzoZBQA
	fHOon5nFDfbQbx0vqJPwaEDMU0ftZfEtNq+6BCLyY35uXK5aKpa4tXdpgnsBZk4J
	29i/vzxnXOhcnxb4jx63GLxCo5epUaGT53uQwsCjOmIidN8riB7GFTazMUyN7mRH
	Mvg3v7JAdUNR+IZYUE9d7p5A818vfSv8jvQ==
X-ME-Sender: <xms:Xru-aNbUzo0OY5yONzqmCWiPoaJXcAPS0Lasc_Vd0fc9uHNf7OSvgQ>
    <xme:Xru-aHrrDjJ-BV_DGxWVJRZGhQIB4xw3kdIMinv0pkNO4rHqUd7RjwCQTlK8bl0tH
    TnlVfE4BweeQZUZ3A>
X-ME-Received: <xmr:Xru-aJZiLIGbCeL6BtDwK0ikmF4ctfQ_a4uY5Mlk35TW1ga8Wv_R9Q36CxTOHSZ20MVofxlEc5NpyGu68vZRD5drSeSfi6tCy7QNBCHIHr1RFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Xru-aHQ5IkEV5sM4cB1BhlFbHMzdpoOt6TTaPMkuuDZf29YuvWgh1w>
    <xmx:Xru-aI4vshThBxis4y_OG5Lnk5yV4_i02ZfpVa2WaYy6qJFIlvTQ1A>
    <xmx:Xru-aEzdUk87PPF5nM5seiMDC9vJSib7E0NsvXp4xJpCnhpo0p_edg>
    <xmx:Xru-aPRBWYbxRPHRb6iHl0QVVzYxk0oak7TWkhuR6Nsq-VHGkIaZ_g>
    <xmx:X7u-aIS8lAbOsncAeO9w_nye0INQ3IrN91F9m3waS7hexauIKkHGM5bb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 07:17:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc799514 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 11:17:48 +0000 (UTC)
Date: Mon, 8 Sep 2025 13:17:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/6] odb: track commit graphs via object source
Message-ID: <aL67U0-tw7O-y6_X@pks.im>
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
 <xmqq5xdx7qx4.fsf@gitster.g>
 <cf7aeda1-297a-4805-b0ae-e379ce11bbcf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf7aeda1-297a-4805-b0ae-e379ce11bbcf@gmail.com>

On Fri, Sep 05, 2025 at 02:29:50PM -0400, Derrick Stolee wrote:
> On 9/4/2025 7:12 PM, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> >> commit graphs are currently stored on the object database level. This
> >> doesn't really make much sense conceptually, given that commit graphs
> >> are specific to one object source. Furthermore, with the upcoming
> >> pluggable object database effort, an object source's backend may not
> >> evene have a commit graph in the first place but store that information
> >> in a different format altogether.
> >>
> >> This patch series prepares for that by moving the commit graph from
> >> `struct object_database` into `struct odb_source`.
> > 
> > Hmph, I am finding the above hard to agree with at the conceptual
> > level.  In some future, we may use multiple object stores in a
> > single repository.  Perhaps we would be storing older parts of
> > history in semi-online storage while newer parts are stored in
> > readily available storage.  But the side data structure that allows
> > us to quickly learn who are parents of one commit is without having
> > to go to the object store in order to parse the actualy commit
> > object can be stored for the entire history if we wanted to, or more
> > recent part of the history but not limited to the "readily available
> > storage" part.  IOW, where the boundary between the older and the
> > newer parts of the history lies and which commits the commit graph
> > covers should be pretty much independent.
> > 
> > So moving from object_database (i.e. the whole world) to individual
> > odb_source (i.e. where one particular subset of the history is
> > stored) feels like totally backwards to me.  Surely, a commit graph
> > file may be defined over a set of packfiles and remaining loose
> > object files, but it is not like an instance of the commit-graph
> > file is tied to packfiles in the sense that it uses the index into
> > some packfile instead of the actual object names to refer to
> > commits, or anything like that (this is quite different from other
> > files that are very specific to a single object store, like midx
> > that is tied to the packfiles it describes).
> 
> This is an interesting aspect to things, where the commit-graph file
> is a "structured cache" of certain commit information. It happens to
> be located within the object stores (either local or in an alternate)
> but is conceptually different in a few ways.
> 
> The biggest difference is that you can only open one commit-graph
> (or chain of commit-graphs). Having multiple files across different
> object stores will not accumulate additional context. Instead, we
> have a "first one wins" approach.
> 
> This does seem to be something that you are attempting to change
> by including the ability to load a commit-graph for each odb (and
> closing them in sequence as we close a repo).
> 
> So in this sense, the commit-graph lives at the repository level,
> not an object store level. When doing I/O to write or read a graph,
> we use a specific object store at a time.
> 
> The other direction to consider is what context we have when we
> interact with a commit-graph. We generally are parsing commits from
> a repository or loading Bloom filter data during file history walks.
> Each of these do not have a predictable nature of which object store
> will "own" the commit we are inspecting, so it wouldn't make sense
> to restrict things like odb_parse_commit() over repo_parse_commit().
> 
> With these thoughts in mind, I have these big-picture thoughts:
> 
> 1. Patches 1-5 are great. Nice cleanups.
> 
> 2. Some of Patch 6 is great, including having the I/O methods use
>    an odb_source to help focus the specific location of the files
>    being read or written. However, the movement of the struct into
>    the odb_source makes less sense and should still exist at the
>    object_database level.

I (probably unsurprisingly :)) don't quite agree with this.

Let's take a step back: why does the commit-graph exist in the first
place? It basically provides a caching mechanism to efficiently return
information that is otherwise more expensive to obtain:

  - It contains a cached representation of the graph so that we don't
    have to parse each commit from the object database.

  - It encodes generation numbers.

  - It contains bloom filters.

All of which makes sense with the current design of our object storage
format, because obtaining this information can be quite expensive. But
let's consider a different world where we for example store objects in a
proper database:

  - This database may have an efficient way to compute generation
    numbers on the fly, either when reading an object or when writing it
    to disk. We cannot currently store that information in the packfile
    right now, so it needs to be stored out-of-band. But with a database
    there is no reason why we couldn't immediately compute and store the
    generation number on each insert.

  - This database may have an efficient way to store bloom filters next
    to a specific commit directly, without requiring a separate file.

  - This database may be distributed. So why should every client now
    have to recompute a commit graph if we can instead store the data in
    the database and thus have it accessible to all clients thereof?

  - It may be _less_ efficient to use the commit graph to access data
    compared to what that database can provide.

So I would claim that the commit graph is specifically tied to the
actual storage format of objects, and it's not at all obvious that it
would need to exist if we had a different storage format.

The goal of this patch series is thus explicitly _not_ to allow loading
one commit graph per object source. In fact, the refactorings I did
ensure that we still only ever load a single commit graph.

Instead, the goal is to allow each object source to decide for itself
how this additional information is to be stored and retrieved. This
_may_ be a commit graph if that makes sense for a particular storage
format. But it may just as well _not_ be a commit graph, as other
storage formats may have way better solutions for making the commit
graph information accessible.

Patrick
