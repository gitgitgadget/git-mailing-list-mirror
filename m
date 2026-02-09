Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031523385A5
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770628479; cv=none; b=jgcB00Clz8X0D6D1NZlhxmW1XXnfscb2RKm/TGuqfBQ+ajrO3oek9fzk4diGPcZI7xLxACQQBI28xWZ4i6ga9q9sytDZ33qoNc22k1oErX7vuCKH/1VLuLOlmuikGIYP0geygEypRbwRwibBhLDTAqrHIDb3/0xB0WmO3sIJkIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770628479; c=relaxed/simple;
	bh=CbTPKrBYn65suZfVRE79Ig/7ZfYvEGPXHjF0wuaZUfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAjubNgNsqQzgIXEZZC1YjDZP14OELiNIghjK6QKnseNuA+nGCmaCT1SiGXXxqlEvP+ajI9bgwxJFibyIle1P6efvyN6/C5dfDdoJ3nWrkV6AvshS8wCx+FTz+9XvsWvvTtZ8p5Jp/F+ouXVxP41B61E9lA/wq4ELwBqb1fP248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WEIS7fow; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=etNejl5N; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WEIS7fow";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="etNejl5N"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4F28A1D0016A;
	Mon,  9 Feb 2026 04:14:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 09 Feb 2026 04:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770628478; x=1770714878; bh=2rjX8okKrf
	yHrJooRHMJ8oLdg7+aXFetThjfbdm8vfo=; b=WEIS7fowc/T+rb5lt6ebCb4/Yk
	aKHLa30ZN5eUftWVYJsbQdVwJIDC/F8q6fJCzhXSnMAYUxXX8gRyVn5zE+Oellmr
	HIzRdtBZM8Bnj1hOgQOuPWLHVAZPx4MiQcrKdgXSRfb4Tdqs+FhRRkmgYzuhDS6s
	xReLYwAxPWpkOZVkdhfpfPlYr4nXqu32zlZ2Zt7LAm1B7evPbYv5kjeNNBTGK0Y2
	kdZkXaQo3hS+7QpltGklmbYbFs2d/4WgfnqyZl10WTBjA7L/3y7ESCCxofU24i6Y
	7rybbsS+d9qfoIzl5x+B5lF+TJVvY+I0UKTv4sz5QGPbPx+yn8M2XWeAwYbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770628478; x=1770714878; bh=2rjX8okKrfyHrJooRHMJ8oLdg7+aXFetThj
	fbdm8vfo=; b=etNejl5NWoleO++HEvOPxmRkcr/b8EQ7GqlqxDugFTcyJ5J7kaZ
	+WoL7nWsy6/i38QSFy38AW7xGppQoXyNxC/5Cq57Vth6nFNWRzMqZBqa5KQ5TrAs
	JJRhHs1AzR5/QT/Rd5m8ne7sirfXmCczbMF2vg5UbuCs0YKn/TBmN7EaylsY7WtX
	ARUjsbR6AFF8EKLIY58hlWqHM7f4mkkkL0LQ7049QQGAOzTGB83al9TjIaCfjiqe
	FZEJEGot7u6ZO7CLU0vcv4Ay0E0/BZU9VI8KVXidrFKRK7G9VlRSSGQ9L5jItua5
	ATUmdRkjsHVUG1l0RC4I1aclgPvwzRsn53Q==
X-ME-Sender: <xms:fqWJaXxa0DccWTDEhHuWCWjoNXGIVs3KU8E8SPnuQGg_vSs1eit6hQ>
    <xme:fqWJaVSO5b8BQNIO3kiRIuVAlKL8iaVKOXgpMB9uVpN80-224kL6EW5dfl4oR5ngN
    zaAhQa3py2miychIAtoScU0MWG2Zucot4X3XMevUKkGUwOOoRi-GQ>
X-ME-Received: <xmr:fqWJae8HVjQewiAYrf-0TIWXEwxLc5gikrEtreauuc3JVi5xw2wI7tjCdZ9J6Lng80i4IHRnhNpbftDubfVlcYiwhkz0nG2WLSoWDQgXpHs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleeigedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedugffgvdevvefhgfeihfeugeetkeejveegje
    euffefffetvddvveduffdvledtteenucffohhmrghinhepughofihnrdhpshenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fqWJacpj8E0xn8DdFOJnIoin9cNmYJRG71KqIAb8RgHOHDtDOiTU9g>
    <xmx:fqWJabl2AD0xHWsN9gfDgDvdwO6PZsD_a5mrXTHF9ZDlfP5edCCD5w>
    <xmx:fqWJaTKuAOLOfY9JYdstaYJZrO7s2kbJKoJK5qMpcpw0CbZvMPRlVQ>
    <xmx:fqWJaQzKd6R7wBiB1ty6c8mv_kQ7mfKuf4FPkc5RKiUX2SV0vBy86Q>
    <xmx:fqWJabJWMKoMu6v13DKJu_UAwWhqDDhMDdJkRInd9U2-hlBXGQfSnGEV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 04:14:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ea6e4a3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Feb 2026 09:14:35 +0000 (UTC)
Date: Mon, 9 Feb 2026 10:14:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2026, #03)
Message-ID: <aYmleK3kGqzLXyJe@pks.im>
References: <xmqq7bsob0wo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7bsob0wo.fsf@gitster.g>

On Sat, Feb 07, 2026 at 03:15:51PM -0800, Junio C Hamano wrote:
> * yt/merge-file-outside-a-repository (2026-02-05) 1 commit
>  - merge-file: honor merge.conflictStyle outside of a repository
> 
>  "git merge-file" can be run outside a repository, but it ignored
>  all configuration, even the per-user ones.  The command now uses
>  available configuration files to find its customization.
> 
>  Will merge to 'next'?
>  source: <D514F3BA-36DD-4DAD-BF73-609730390A27@ytausch.de>

This patch looks good to me.

> * ps/meson-gitk-git-gui (2026-02-04) 1 commit
>  - meson: wire up gitk and git-gui
> 
>  Plumb gitk/git-gui build and install procedure in meson based
>  builds.
> 
>  Expecting a reroll.
>  source: <20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im>

Probably makes more sense to say that this is waiting on a pull request
of gitk, as the patch series itself doesn't need to change.

> * jc/checkout-switch-restore (2026-01-29) 2 commits
>  - checkout: tell "parse_remote_branch" which command is calling it
>  - checkout: pass program-readable token to unified "main"
> 
>  "git switch <name>", in an attempt to create a local branch <name>
>  after a remote tracking branch of the same name gave an advise
>  message to disambiguate using "git checkout", which has been
>  updated to use "git switch".
> 
>  Comments?
>  source: <20260129190616.645471-1-gitster@pobox.com>

I think this is a good change, and I'm happy with the current layout. I
had the tiniest nit on the first patch, but really don't think the
series needs a reroll because of it.

> * ps/for-each-ref-in-fixes (2026-02-05) 4 commits
>  - bisect: simplify string_list memory handling
>  - bisect: fix misuse of `refs_for_each_ref_in()`
>  - pack-bitmap: fix bug with exact ref match in "pack.preferBitmapTips"
>  - pack-bitmap: deduplicate logic to iterate over preferred bitmap tips
> 
>  A handful of places used refs_for_each_ref_in() API incorrectly,
>  which has been corrected.
> 
>  Will merge to 'next'?
>  source: <20260206-b4-pks-fix-for-each-ref-in-misuse-v3-0-1e050c3d6a50@pks.im>

I expect it's ready, but I'd like to wait for Taylor to have a final
look before we merge it down.

> * ps/object-info-bits-cleanup (2026-01-26) 3 commits
>  - odb: drop gaps in object info flag values
>  - builtin/fsck: fix flags passed to `odb_has_object()`
>  - builtin/backfill: fix flags passed to `odb_has_object()`
> 
>  A couple of bugs in use of flag bits around odb API has been
>  corrected, and the flag bits reordered.
> 
>  Comments?
>  source: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>

I'm pulling in some reviewers to move the series forward.

Patrick
