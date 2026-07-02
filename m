Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE89309F1C
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 05:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782969692; cv=none; b=nP6MJT2/ScDnyDVRFnhb7/o/rnJSsAFw7rNJnxXqtE3qbVszvnTmbcym663/g780AOAf9yVAmDb34X0d04pQ8YMkrvVRBIPwIXvm02CPvW7rW68GKqyjXZX5mst/ubEN753DfyyYOP28JByy3dOIzKLeNo+6LJz2yCwz/HrM5ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782969692; c=relaxed/simple;
	bh=JWJduhoojarGgHoQcy4J4w+gm/pcH0hSYuDAsY49L1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OswiL9MBxRvwUwYDgkJPPTVfHbOtTF3Vw1C3GJVf3BHm5J4ZfVhX/XgRd53yS9rl5zlVMHmnc3PtQzXEtG4CzgcU/K7PESbNLgLDjGwmHX5l9wGwsFdyHRbSdksUAwdwyVt8UOdJdHVTTwh1bbTMaRGV+2MtUOlFuJkFASHw7To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q/ipLx9J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IOqfL6RD; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q/ipLx9J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IOqfL6RD"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 20FA51D00058;
	Thu,  2 Jul 2026 01:21:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 02 Jul 2026 01:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782969688; x=1783056088; bh=5Ne1r1QXGc
	0Hy8McIhm/sOCa7HXWi+anldjI+XDQ0+4=; b=q/ipLx9Jq2vcO7+lCvoDtEhXp5
	CeL1JjMk0/SV+XuA2qeNSgXMakGEbhGp7m2zRQI81zGm8lvHI6Hb9Gk8QZrFfjwQ
	xlg1A5WaFXnixhvJJecZGOIszYkxOm1O2y7hGAQXS6vfIoRiG48JiKG7BsfEkQgT
	fNEjbukcZOwcRjbpTVzG2Vbw/OJNGujyntdpimSvmg4E15k/SvZf//M+5a5mHC7s
	3HOS7mX9KfQR7hZaVstDCGtUX9ZBzJ73V+TXbKN/0aCYvqsoTrsbEZ381E5zjtSc
	C/Z2lsOEaX2haxHGH+lHm5OmTS6JQCT6yzW1MUx8avNbr/GXgJSwLuNZNnvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782969688; x=1783056088; bh=5Ne1r1QXGc0Hy8McIhm/sOCa7HXWi+anldj
	I+XDQ0+4=; b=IOqfL6RDu1C2DYEq5AJjEuFOzCCpxEUfJXZnURHOHBbHP/YM+1Z
	eboDPJ9RPEb7DScUKXY1fRFf6PM52X0uU8DE/lzqA/+ZmE9WsleidYTs+SNCmiAO
	DqLhnb7LsXUiREl5mHOLdvvyuE+IxYWOL2w3dNCegovHBGO5wJ5t9bAneKtXpLsp
	t/itkX77cFpAs0NTkk6HMXMtzCoFOsWdqUB6YhI41jTxJG1cqqN0Qm4WhLzFj4Ak
	8yGAR5quyqamB4o1gERgWXt86ecLaASJYD4ULk+uoZOtedfYKvELgB0j9JfgP9iG
	8XPFCpbS9+k6LlDHeljpOzn63cfu6Hcu6Hg==
X-ME-Sender: <xms:WPVFaulv82xmB455yBbfndzkGgKE4tsGfmsGIpC43jfm9lwcYxymrQ>
    <xme:WPVFav0Z58eHq7WcOsDLRAMDG4ZJCjvtzri4268n5A_obNEb8TMfT3tu4Waps2b_D
    iI_9tY-EKVYXSXqhXd6O8MIMfRdGGOPydD82bhaTTrgZbJnxZNQrw>
X-ME-Received: <xmr:WPVFajTtOUJDe5WcHdh7t-1ZMOWLLZiWJyNEbJ7Fbl2SJA5bpoPhd9gv51YontxQpgXJZR30Sh2t9mbpMPTJ9edIe2_ihxrchP_GEBVQPCvZgg>
X-ME-Proxy-Cause: dmFkZTEHnk/NEr78DvS2pnUNiDliKZgnC3MYHOobb/6X/5+X73VuxzFjEm9xwvhB097Fpn
    J20/b1PQXYtZ0l3TXW7L9golwYJI1+eL0bPjwfkGIynxQHzEc43ns8dL9nVm7ctnwX2lxl
    KouSJNbWBT5d8q5GhZYnTFWsExCBYMQWcIjuHvXUMhJTY0zvkmKexSjV/tyZqLRw+ZGTX9
    hdyLkCFeY/uoo2tl7eqSch83aqFAAfEx2zvsXW+8ol5hCRtNgLQi5W1Pf2ujSh8aTF2CWH
    taSO0Putu1FWfCQ8QH9Wn0iNC00XzpAfZZf/lDNpMtziW/ab9+RMC/qI1oN1szpsiBObJM
    WhsAPXKwySHIjY9RQKUnRicBn3kRlcjKRBf82FtvmNlAv4a5nJDe6maxDfvjtXwcjJEnVt
    J1m78H3njfyzAv/V6vf4MqaXRySdDddnM9fiyAtPIncJ6bYAvD9bzetQ185hs79sFJgM3W
    YBskFOXyfOSPYVmnB5VmBmcBoqObYtGqi90mqcm0/E9vT+yZj6vk+Y7S982ONI3PsVBTWg
    5y4V9kU+T5cp5H6QA7JQnxraAkNGkVeQe1m8MmDJGVDkgvWJHVwBhN7zaeXMkR1Vhm5YP8
    F0fMKVGdQDfC4z/tr+7n26effUtr+r9mhL+8L8sFLcp8InXL1bahIbUjvStQ
X-ME-Proxy: <xmx:WPVFagy1buK2eMWBG4zKzJLtORruzAAHIvTMWVlvIxwORhxYnjU-Wg>
    <xmx:WPVFarAun7GtC0P5aq9kam1N4XnPfTEmmrZPjLCf69xh6HY5Di21sg>
    <xmx:WPVFakHhrIEBI5yeSaDQFzwCm0Ty68w8abIvGSxUQgtA0WtPYaujiA>
    <xmx:WPVFaqMjBhZ0xoiWflgDyC3GgujRqHcPNPV6Hh7pn7AmH6T0zYx5mw>
    <xmx:WPVFamoGbwK4P5vtmCBg8XpMEFG4f7wBSW1huMDiUI1A3tF5GAXvjN6j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 01:21:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9f27f812 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 05:21:23 +0000 (UTC)
Date: Thu, 2 Jul 2026 07:21:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v2 2/2] Move libgit.a sources into separate "lib/"
 directory
Message-ID: <akX1TMoRr87Id8Ss@pks.im>
References: <20260622-pks-libgit-in-subdir-v2-0-cb946c51ee7b@pks.im>
 <20260622-pks-libgit-in-subdir-v2-2-cb946c51ee7b@pks.im>
 <aj9wcFEb6oCRnfn2@szeder.dev>
 <akS51xJSP4tkP_pS@pks.im>
 <cbbb08fc-fd4d-45ef-927b-05ac44602ff1@gmail.com>
 <xmqq1pdmrcp6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pdmrcp6.fsf@gitster.g>

On Wed, Jul 01, 2026 at 07:45:09AM -0700, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > As I said last time this came up, I don't really buy the discoverability 
> > argument because there are just as many files to trawl through to find 
> > what you're looking through and now there is an extra directory to 
> > check. I think the solution to that is to recommend folks use "git grep" 
> > or ctags etc. not moving code to a new directory.
> 
> Hear, hear.  Also it would be great if we can trick some talented
> technical writer into writing the "map" of the source so that by
> reading this one or two pager, any new person with reasonable
> competence will know how things are partitioned into pieces and how
> these pieces fit together.  I wonder how good LLMs are these days?
> ;-)

This isn't about discoverability of the library files though, I
specifically want to improve discoverability of all the other files that
we have in our root directory. So yes, I fully agree that this change
does not help to make that one file that is part of our library easier
to find.

> > I do however think putting all the library code in a subdirectory makes 
> > it easier to say things like "please try to avoid new uses of 
> > 'the_repository' and prefer 'error()' over 'die()' in library code" 
> > because all the library code is in the same directory. I think that is a 
> > much stronger selling point.
> 
> Yes.  "library code (things outside the subdirectories) should not
> use X" would work just fine, though.

That rule doesn't quite work:

  - We have several C files that are not library files and that are in
    the top-level directory. For example "scalar.c" or "shell.c".

  - We have several C files that are part of the library and that are in
    a subdirectory. For example "compat/", "refs/", "odb/".

So having this properly cleaned up would help to have clear indicators
what component a given file belongs to.

> > Another cost is remembering things have moved - the other day I spent 
> > too long wondering why "git show origin/seen:wt-status.c" wasn't working 
> > until I ran "git log origin/seen" and realized it had move to 
> > lib/wt-status.c.
> 
> Yes, this has bit me multiple dozen times, as the tip of 'seen' is
> contaminated with this rename, already.  It is a huge pain.

Yeah, this one I don't have any arguments against besides a very
hand-wavy "it'll get better over time" :)

Thanks!

Patrick
