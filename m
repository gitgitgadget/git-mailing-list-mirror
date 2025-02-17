Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF5D2F5B
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 12:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739796442; cv=none; b=ns/Cskrq/T77XExY+JYdPfNb1TzE7CfpO4W5WNQAyAxcsKiTO2lFgJyQOPpfnceSvnhkrZcZvKR8wwEBdsQkpaPhTZmA5sAfLV0eCZugFkqoAQwNxGUj+xohoHUoyqyxupSray9HObSPblOYazy05VColyLKcNtgj3T7Zp0hlgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739796442; c=relaxed/simple;
	bh=Mavh9zrg8Cff1lmaBoAQabGVT3l0Nv+y4NrBMehMqPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fS/cdeLGAC6lOol5j/HBuUWJ/vanr+OpXQodGxMoDTYxRsZaGMJXFaS7vbaDTW9/QClUyIWEIHD6bBLdnkqnjMRKRahqhybf+2dcWuOWMRKAD3VKIhPtQMIo0/k7rHSdau1KgQLy6S9xyWe5vDb78IVCIXaVlcMCj8laGZZSTA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=efjeQcsS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VzmRePyt; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="efjeQcsS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VzmRePyt"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5A0B1254019A;
	Mon, 17 Feb 2025 07:47:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 17 Feb 2025 07:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739796438; x=1739882838; bh=T7pb6cpCwE
	cfB3/pnZAuGV23NTbi6/BKbkhR7y+aMfw=; b=efjeQcsSriKwW4ut3/STOOFqz7
	y1qlw9XnXW4pQemCbae/m/9+6ocXdTtha8namucREtlgScZ6pBeYgMnWwxukZ8Aa
	aAFxv0CtgLx+99zS5hv1CTVGVmvKJ0i1vENr+MBAS8FfcQjQ/IlIt8bUL8O8oZVy
	PotoYev+yBma4452oRfwXiWOsRbUFzyORrl412QexbQNsjCesEjZBlkRZb3NEZNK
	SE2ZCYTNpQxnJitlurOEcJdiD+A3mQ587NQeJpaLVu1ztXOwEun8JVj4qw9M9+aw
	DDpHnC19olmtlA+B2Ttk2/B7L5fKfZ946eYRqTnBzzIeARp9zEEUtia8FdRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739796438; x=1739882838; bh=T7pb6cpCwEcfB3/pnZAuGV23NTbi6/BKbkh
	R7y+aMfw=; b=VzmRePytytoxAeZhqkLhvSD1DDPkkfppBU/8IZT6RNIi+AjIwTU
	QkQ9Kzbj08bd5E8KX+1aVUR22dwUPOn52pjaA2uDHTSicgUlvLPyPfUy8IawCf7t
	GX0V7ZNmhI1g9+h3XpdGu4OnhQQvf13zh9j5c/VKkm+wyiEgFZDLW6lH0PU2GeSA
	QXkyum3zqhMK/cCmzSAXc926FP998bVTie9kOYISAsyBkRGesnWwcsw/rjim528R
	to90DJk3hqm9ivoKsxkOnPue5W7o6hKzfAFvEc4xqEGsDSGVg/kUY3tKB/7nnAmH
	HJlTzhNq/oJkYeQEAP8+eLht9A6cAuQ15PQ==
X-ME-Sender: <xms:1S-zZ_Bm1EalG03r346kuWtyMcusTU5lolufNUZMjln30wbKlUHx7w>
    <xme:1S-zZ1iQIUq9TUdUQXa47UAlEhwp9sW29T6n_qgluVFmnJYSdNlINTA8sUYNv6yT8
    uVefaJsFL6LFE0Gfw>
X-ME-Received: <xmr:1S-zZ6ndeRBJMC2ial_8Fc-ZURyJoXoezkk0yG-MNZZ_5mfT9lXzjz2THTOTkfDEwCO_Pi8zmyzvqH3Rm8cNIaqVDZdU8YT4mfLTTFhxpDJykK0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpefhiefgvdffvddtuefhlefgleehgfefveeuteffudfg
    heetgfevlefhueeuveeuvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjh
    eitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghthhhomhhsohhnse
    gvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:1S-zZxyjuKsaTTxIA6BSrh3ON56cJjQadFzE7pKWY25r96VpN4KRCw>
    <xmx:1S-zZ0RfPOLWCXxkIn-xpSoYQ3xNdItFcMzevZGkW_5ePlyoYYuJiA>
    <xmx:1S-zZ0ZE4txnXSU-rL1zqsA6kvcY1siqDUomyBt8H0ROllnFvkwCwQ>
    <xmx:1S-zZ1SH02x7XBte0FB0MKRSMkFH3kyQI4mGpN3fwW-zSODyAuvZuQ>
    <xmx:1i-zZzFo6fQfjBxKAEyfVHDlaqGzRonfqpmjCZhWe9nkePUaothX75PP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 07:47:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 46513955 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 12:47:13 +0000 (UTC)
Date: Mon, 17 Feb 2025 13:47:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Sixt <j6t@kdbg.org>,
	Edward Thomson <ethomson@edwardthomson.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 15/18] compat/mingw: split out POSIX-related bits
Message-ID: <Z7MvzH3AVe4_waUH@pks.im>
References: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
 <20250207-pks-reftable-drop-git-compat-util-v5-15-ba2adc79110f@pks.im>
 <c48e8fa2-cca4-4abc-95d2-234fa5c69b8d@kdbg.org>
 <e202a870-921b-8f38-58af-3d44e94c447d@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e202a870-921b-8f38-58af-3d44e94c447d@gmx.de>

On Thu, Feb 13, 2025 at 07:22:57PM +0100, Johannes Schindelin wrote:
> Hi Hannes,
> 
> thank you for looping me in.
> 
> On Sun, 9 Feb 2025, Johannes Sixt wrote:
> 
> > Am 07.02.25 um 12:52 schrieb Patrick Steinhardt:
> > > Split out the POSIX-related bits from "compat/mingw.h". This is in
> > > preparation for splitting up "git-compat-utils.h" into a header that
> > > provides POSIX-compatibility and a header that provides common wrappers
> > > used by the Git project.
> > >
> > > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > > ---
> > >  compat/{mingw.c => mingw/compat-util.c} |  28 ++--
> > >  compat/mingw/compat-util.h              | 220 ++++++++++++++++++++++++++++++++
> > >  compat/{mingw.h => mingw/posix.h}       | 216 +------------------------------
> > >  compat/msvc.c                           |   6 -
> > >  compat/msvc/compat-util.c               |   6 +
> > >  compat/msvc/compat-util.h               |   7 +
> > >  compat/{msvc.h => msvc/posix.h}         |   8 +-
> > >  config.mak.uname                        |   6 +-
> > >  contrib/buildsystems/CMakeLists.txt     |   2 +-
> > >  git-compat-util.h                       |   4 +-
> > >  meson.build                             |   8 +-
> > >  11 files changed, 266 insertions(+), 245 deletions(-)
> >
> > I can agree with this rearrangement of compat/mingw.c. But the
> > Git-for-Windows repository has much higher stakes with all the
> > additional changes. I put Dscho on Cc.
> 
> This indeed causes massive friction. See for example
> https://github.com/git-for-windows/git/actions/workflows/main.yml?query=branch%3Ashears%2Fseen,
> which should ideally be updated with green builds as frequently as `seen`
> is updated. It's dark red, and there are tons of gaps (which means that I
> was not able to finish adapting to these changes).
> 
> Another problem introduced by this series is that now the same filename is
> used in multiple directories, which makes it unnecessarily hard e.g. when
> setting breakpoints in `gdb`, or when trying to follow `#include`s.
> 
> Granted, the problem already exists, e.g. with range-diff.c vs
> builtin/range-diff.c, but I would hope that Git's source code would be
> changed away from duplicate filenames instead of adding more.

The question is what ways we have to improve. Filenames being the same
can be avoided, e.g. by naming the split-out files e.g. "mingw-posix.h"
instead of "mingw/posix.h". But what alternatives do we have when it
comes to splitting out the logic in the first place to reduce the
conflicts on your side?

A couple of alternatives I see:

  - Use `ifdef`s to conditionally only make POSIX bits available. I
    think this would be quite awkward.

  - Just ignore the issue on Windows altogether and expose non-POSIX
    bits there. I don't think this is great either, as it means that
    Windows becomes even more of an outlier than it already is.

Do you have any other ideas?

I can send a version that avoids moving stuff around and really only
splits out relevant functions into "compat/{mingw,msvc}-posix.h". But
I'm unsure whether that's enough of a help to you.

Patrick
