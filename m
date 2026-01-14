Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24872E2679
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410538; cv=none; b=iBI00Fv/NzJiI2wxerhAhf4feZ8R9guZy2Kk0+J2J44f+wDdK3G0VL6v9XiDzrQ5W+D4RgHfOVIctOKaqivfA+5ZRgDAz1biuTT1QeGVxWI99cbOPgzNKwuuTIxPCrUsm5ZNpkX7Hoh30CzBKAEsuqCz4taXEs2cu8SUiCLdj3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410538; c=relaxed/simple;
	bh=yTShnf/UaCy81cYoziufQ0WhmxhGDp2HmmT1heEr2z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8tt4DYcXN0LmLwHpPWcx1NNogMRk/TGFjW+pEqxR2sPnKF74H6lAcjCUmaeASddqiSGn9SQi0JcMu/Ga0sorkcyv4e8Ka1/bjtpob4JTY7Qphh80k3M9Fik2xv9vSW3S8v0pe2Pz+RWq8zhMZt/syizwUDJXyB8fLFeJiPPXKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PHiMBQP9; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PHiMBQP9"
Received: (qmail 40451 invoked by uid 109); 14 Jan 2026 17:08:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=yTShnf/UaCy81cYoziufQ0WhmxhGDp2HmmT1heEr2z4=; b=PHiMBQP9kfqZuJtaL7XPucLfjHdgzgaJbcAy2950V/tHm8ZyH6sDzvwC86JsNsv0gOtdAb3VeL8j/uS7/9RijBV6YFUkHGJGIvSDy2JJMRn+ci2X/hgXxXwplikzcgyGqmmudrV6pUn+tT5S9odKlwIOR9fwxx0kyx0XR4fyE8rAp7elfCkazlbeDqZivOYl9Yeb4pqr/nB0fZ5pF6vsf8Ij+xXmtk2+BInctFA4AAUxtwXnV8AZi2dffR1eX4GFl/Yugv3xmUaa1yKMJUwFsvxMUj2vGpJN3GQXemXm7mZGqoKwQTWORcTuA1/PpI8MNh0Hoi4EgJi+muZG7OwgQw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 17:08:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 66917 invoked by uid 111); 14 Jan 2026 17:08:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jan 2026 12:08:51 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Jan 2026 12:08:49 -0500
From: Jeff King <peff@peff.net>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Emily Shaffer <emilyshaffer@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Chris Darroch <chrisd@apache.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] hook: allow hooks to disable stdout_to_stderr
Message-ID: <20260114170849.GB885771@coredump.intra.peff.net>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
 <20260113234528.1749921-1-adrian.ratiu@collabora.com>
 <20260114031257.GA858646@coredump.intra.peff.net>
 <878qe0zimo.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878qe0zimo.fsf@gentoo.mail-host-address-is-not-set>

On Wed, Jan 14, 2026 at 10:46:39AM +0200, Adrian Ratiu wrote:

> > So we are hitting the poll timeout for each ref we consider, and it
> > takes forever to actually write the whole input stream. Which seems like
> > a bug in using feed_pipe without ungroup. Either:
> >
> >   1. We should write everything to the child as quickly as possible,
> >      assuming that we do not have to worry about reading back from it to
> >      avoid deadlock.
> >
> >   2. We should add the child's input pipes to our poll() call so that we
> >      can tell it is ready for more input (without hitting the timeout).
> >
> > Setting ungroup=1 saves us from this because it means that we'll skip
> > the poll() call entirely in pp_handle_child_IO(). So we end up
> > effectively doing (1), which is OK because ungroup means we are not
> > reading stdout or stderr from the child at all.
> >
> > But it feels like this is papering over a bug, or at least providing a
> > dangerous interface. AFAICT you _must_ set ungroup if you are going to
> > use the feed_pipe callback. And it does not really have anything to do
> > with the stdout_to_stderr flag at all.
> >
> > It looks like feed_pipe feature is new-ish in your series. Maybe it
> > should just be a BUG() to use it without ungroup?
> 
> This is all very useful and it proves there are 2 separate bugs here,
> requiring two separate fixes for both Chris and Kristoffer.
> 
> The logic in v1 (without ungroup) is enough to fix Chris' issue with
> stdin and for Kristoffer I will do a smarter fix which implements your
> (1) suggestion: batch more than a single stdin fd write in each poll
> call so we achieve comparable throughtput (no added poll latency).
> 
> We already do this for the receive hook in feed_receive_hook_cb(). In
> this case we just need the callback to process more than just 1 ref at a
> time.

I looked at what feed_receive_hook_cb() is doing and...it's kind of
horrifying. It arbitrarily sends 500 lines, and then yields to the
caller to pump stderr (assuming ungroup=0). So:

  1. It is assuming that 500 lines of input won't fill up the pipe
     buffer and block. Even if we compute the size of 500 lines we're
     sending, we don't know if the caller has cleared anything from the
     pipe in the last call. There might be zero bytes available!

  2. After 500 lines we'll go back to the caller, which will then
     poll(). But if there's nothing to read on stderr, it will wait for
     the 100ms timeout. So if you have, say, 501 lines to send, then
     there will be a pointless 100ms pause in the middle.

So here's an example hook setup that will deadlock due to (1):

-- >8 --
#!/bin/sh

# make two repos: one to push from, and one to push into
rm -rf repo
git init repo
cd repo
git init --bare dst.git

# And here's our pre-receive hook that will cause problems.
cat >dst.git/hooks/pre-receive <<\EOF
#!/bin/sh

# Imagine we write a lot of output to stderr. For example, progress
# reporting for some kind of setup procedure (but it could be anything).
# The key thing is that it is enough to fill up the pipe buffer going
# back to git.
for i in $(seq 10000); do printf "\rprocessing $i..."; done
echo done

# and now we are ready to read the input from the caller. A real hook
# would do something useful with the input, but we'll just read it
# and discard.
cat >/dev/null
EOF
chmod +x dst.git/hooks/pre-receive

# And now do a big push. 1000 ref updates seems to be enough to fill up
# the pipe buffer (each one is 2 oids plus the ref name plus whitespace,
# which is 100+ bytes each).
git commit --allow-empty -m foo
seq --format='create refs/heads/branch-%g HEAD' 1000 |
git update-ref --stdin
git push -q --all dst.git
-- >8 --

This will deadlock when run using the ar/run-command-hook topic. What
happens is this:

  1. Git writes out the first 500 lines to the hook. This partially
     fills the pipe buffer going to the hook.

  2. The hook writes to stderr, filling up the pipe buffer back to Git
     and blocking.

  3. Git does its poll() and sees that there is data to read on stderr.
     It reads some of it (8k, I think, due to strbuf_read_once).

  4. The hook sees more room in the pipe, so it writes another 8k. But
     it blocks again, still not having read any of its stdin.

  5. Git, having done one round of poll(), goes back to trying to write
     to the hook's stdin, and tries for another 500 lines. But since the
     hook did not read anything from stdin, this fills up the pipe
     buffer.

  6. Now we are deadlocked. Git is blocked trying to write to the hook's
     stdin, but the hook is blocked trying to write to stderr.

To solve this we must either:

  a. Make sure ungroup=1 is set, which means that Git does not read back
     stderr. In which case the 500-line batching is pointless. We can
     just write everything! But I assume you do not want to do this, as I'd
     guess the point of the series is that we want to buffer the stderr
     of each hook so that multiple hooks can be run in parallel without
     stomping on each other's output.

  b. Do a real poll() loop that checks both for incoming data on stderr
     from the hook, but also for the ability to write to the hook's
     stdin. Look at how pipe_command() and pump_io() do this, for
     example. You'd want something like that, but extended across
     multiple sub-processes running at once.

-Peff

PS If the goal of the series is to buffer stderr, that has another side
   effect: hooks can no longer produce real-time progress updates. Maybe
   losing that ability is a good tradeoff to keep the stderr output from
   multiple hooks from stomping on each other. But for a single hook,
   should we retain the existing behavior?
