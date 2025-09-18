Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6329A221F29
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223250; cv=none; b=awZQbKMNpH3YRLgWTYWIO3WFIWZ0SneuaDJThs98HQoCvG5JPqoAoTblCatlcC+qLhDW3HRdzXzBLhE3rfz5x3gsbSf36AjR9f2OsLhjuD1ld/RbtmaxMGTLuZGJUJbUswXSGbSQvNGWA4r0RZ1bdsSJKqSa2d/fmAmjXB8CCC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223250; c=relaxed/simple;
	bh=WuEn0sWD8wWJ4PUlg/tozGH0PqdJt4klUprMgA6bOUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOqtc5MgYNdcqlNA8PKv0P54dK9ppCvqRE3lKN7/vtlA9vNWSd4NwEfW+DTz/BLXZdIv2P8nJ+AAsFT4sSB8M0CwnewPwm4ontC4pPAPRW50QE+/zm6fRcLMsOJbyoZseDeVc2Z5+bwwMfaFXfRpic2y2uE1hRF6tYwKAz4EQUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IXH7Zz16; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IXH7Zz16"
Received: (qmail 121951 invoked by uid 109); 18 Sep 2025 19:20:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WuEn0sWD8wWJ4PUlg/tozGH0PqdJt4klUprMgA6bOUY=; b=IXH7Zz16KL+QiqJNHeC4VNjwCnvRE2a42LFHrpcvDmCj8sRGeVRz6htzEVMEZ1E6D0PBt3bLaUDcC8gAcOw0UjqJCfEZ5W4D2yoG1SrPQiDa7zdDLNSey3RE0hbb/iwKwjpkKohgIDvU8Uv/yyLNOItm/sSGW2A8VEpw8qwpX3rNa/H2RFf8neDLBM6iCy8G9mWV2UCWiakkN5GohKnrpmpBjPPwyidFFfT6VvA6RSn+HecTx7EFPHzBp602Qy4NA7GTx4tUdcZocxhHHzqMJ9oSVwli5EbPmWOm1eH7FQqp49To8D/3dInru0AsfdBu5tb6CCGQsFWeOc9KNl/H+g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Sep 2025 19:20:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 195205 invoked by uid 111); 18 Sep 2025 19:20:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Sep 2025 15:20:46 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 18 Sep 2025 15:20:45 -0400
From: Jeff King <peff@peff.net>
To: Kevin Puetz <PuetzKevinA@johndeere.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Bug] git fetch --dry-run --filter makes changes to .git/config
Message-ID: <20250918192045.GA1187769@coredump.intra.peff.net>
References: <CY8PR05MB100119985C7C25A72E530556DB517A@CY8PR05MB10011.namprd05.prod.outlook.com>
 <aMsmbU_Cg0L6kOlm@fruit.crustytoothpaste.net>
 <DS0PR05MB100132C058A3D9D5AA735D905B517A@DS0PR05MB10013.namprd05.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DS0PR05MB100132C058A3D9D5AA735D905B517A@DS0PR05MB10013.namprd05.prod.outlook.com>

On Wed, Sep 17, 2025 at 11:23:21PM +0000, Kevin Puetz wrote:

> On 2025-09-17 at 14:44:00, Kevin Puetz wrote:
> 
> > >     the .git/config file was modified, adding
> > >
> > >     [remote "origin"]
> > >         promisor = true
> > >         partialclonefilter = tree:0
> 
> > I will note that if this command actually downloads any data, this is
> > required.  That's because your repository is incomplete: you want to
> > download exactly one commit and without marking the promisor remote, you
> > will lack the ability to acquire trees or blobs and your repository will
> > then be corrupt.
> 
> I agree - had I actually stored the fetch, this would be correct behavior.
> It was surprising/wrong *only* because --dry-run threw away the resulting objects

Unfortunately it does not throw them away. They're still in your object
database! The dry-run mode of git-fetch is not very dry. It just skips
the final ref update.

It would probably be better if it established a separate tmp-objdir area
(like we do for pushes before we commit to storing them), fetched the
objects into that, and then threw away the result. That technique did
not exist back when "fetch --dry-run" was added, but it probably
wouldn't be too hard to do now.

> I certainly agree that the `fetch --refetch` conan 2.0 is currently doing is a very inefficient
> way to check if a remote has a certain commit or not - which is why I was
> experimenting with blobless/treeless to minimize the useless transfer.
> 
> Today I also found `git fetch $REMOTE --negotiate-only --negotiation-tip=$COMMIT`.
> That supposedly (and seemingly in practice) replies with the list of ancestors,
> we have in common, i.e. it will print the same $COMMIT if the server has it,
> or some list of ancestor(s) we share if it does not. That seems like a much more
> sensible command to check whether the remote has a commit,
> so I'd also appreciate any feedback if I'm there's something wrong with using it this way.
> 
> I did find one odd quirk. When the remote and the requested commit are unrelated
> e.g. I'm taking to the wrong remote, or have done `git checkout --orphan`), I get
> 
> $ git fetch https://github.com/git/git --negotiate-only --negotiation-tip=$COMMIT
> fatal: expected 'acknowledgments', received 'packfile'
> 
> This still works for conan's purpose (exiting with an error means it didn't print a matching commit hash),
> but I expected something more like the "fatal: remote error: upload-pack: not our ref: ..."
> error that you get from git fetch {remote} --refetch $COMMIT. Of course, unexpectly sending a packfile
> could be a problem with github's server implementation, rather than the git client.

I had never used --negotiate-only before, and did a simple test which
ended up with the exact same problem. I agree it's probably a bug, but
it's present in git.git itself (my fetch was to a local test repo).

I'm not sure if the bug is in the server or client, though. If I
understand correctly, the server does not know anything about this
"negotiate-only" mode, but is just responding to the client. The client
is supposed to say "done" to tell the server that it is not sending any
more "have" negotiation, at which point the server sends the packfile.
But in this case the packfile comes anyway. Running with GIT_TRACE_PACKET
in the environment shows the client making an extra request with no
"have" lines at all, which the server then takes as an indication it can
send the packfile.

So I think there is at least one client bug, which is making that extra
request. There might _also_ be a server bug, because it is sending the
packfile without a "done" line, even though it was told the client wants
the wait-for-done option (and the client does not even send a "want"
line at all, so what does it think it is sending?).

I can't comment beyond that on the wisdom of using --negotiate-only.

One other option is to use the "object-info" protocol extension which I
think would do exactly what you want. But the server has to enable it
explicitly.  And I'm not sure where client support is (I think there
were patches for a "remote-object-info" directive in git-cat-file a few
months ago, but it looks like it is in limbo now?). So probably a
non-starter.

My other instinct would be to try to fetch the single object, which is
what you're trying to do with the --dry-run invocation. I wondered if we
might find some wisdom in how partial clones do one-off fetches to
lazy-load objects we are missing. It looks like they do (this is from
promisor-remote.c's fetch_objects() function):

  git -c fetch.negotiationAlgorithm=noop fetch --no-tags \
    --no-write-fetch-head --recurse-submodules=no --filter=blob:none

which is not so far off of what you're doing (and actually I wonder if
it even does the right thing when doing a fill-in fetch of a non-blob;
shouldn't we be using the same filter that we originally cloned with?
And possibly --depth=1?).

But I don't think it helps your problem. It still writes the promisor
config (which, in a real partial clone, would already exist anyway).

We could sneak around the odb issue by setting up our own tmp-objdir,
like:

  mkdir tmp-objdir
  GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/.git/objects \
  GIT_OBJECT_DIRECTORY=$PWD/tmp-objdir \
  git fetch --dry-run ...

but that would still modify the config. So I think you'd really have to
set up your own fake little repo, like:

  mkdir fake-repo
  (
	cd fake-repo
	# this alternate might even be optional; do we even care about
	# seeing our own objects here, since we are just trying to grab
	# the one from the server? I guess if we have the object in
	# question it prevents the server from sending it to us.
	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/../.git/objects \
	git fetch --dry-run ...
  )
  rm -rf fake-repo

I dunno. That is pretty ugly, but I couldn't come up with anything
better.

-Peff
