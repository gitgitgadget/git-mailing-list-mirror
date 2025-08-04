Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565FD23ABBD
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300829; cv=none; b=HxAwasRvWGf/KDYve3yBGxAS29Ti/fhWtMDfnhMtFWhlkZQDoI1PmSEUQ5fQaJTBfqHTIjDS2YYwM8xEtXNJK5sKJ/UAdE832fep52/xEfzlEkif6w4SrBOKphyS6XG5LpMWlXbKpNEm0PWDQBtti7PvNBtaTjECMuKRL1uARSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300829; c=relaxed/simple;
	bh=KQTW2HoSZUNQ9ZElH427FbH872cvtWdTxun/LQqNmd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDFE3iMtYpa8o5j7H8+uPiDZ1fhcrjBXW0pZp8aED0CTrMCatbhcgoH1bqTLwh23jl/GMypBDs1dwljx1YfxG0S13+F8F8aO6LIksbz7cQszoyPWxu6zMlbmIRoWRnxnSJbHi0IA/3/4To5A4KRFfDiLsSU9ZTjGy/FOSX0t9DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lH+U7cKm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iILNqudk; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lH+U7cKm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iILNqudk"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id AE5D31D000F6;
	Mon,  4 Aug 2025 05:47:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 04 Aug 2025 05:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754300827; x=1754387227; bh=yg8mtAfft4
	KHr/B6/jgIXxRRoZH7DFnRvZIOWoz7cwA=; b=lH+U7cKmGYe1+pQxgKFgM3Qdon
	mQk8s8/TV3ljHhrjrBmqaYmGIImSRMVBguWnlXeWqyO4H4WAz4bd3pLe2qAw6NsR
	BuxcUOsHW5ORyGN3JpNcRHf8wy5KYmFs09p3G/S2g+Zd/2OjDKYJ/4YrYDfVcZBj
	p1xRbs3FLDtsUKwoeVXOLgbcF9TQJDDiKn/4Qo1ehu3sULNvOLe7A7KYuDPBRSoH
	4h9F5bVPMfDy718C8xW60B6P/5C+EUjQ9tgYHilrmT50ImPZpKqLg7dOesd+qmAg
	ILQ6TyCDboa1dBHGsMZbikh2kuy+g3yWser/vo2yutO5g2hUROITm/zyK3Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754300827; x=1754387227; bh=yg8mtAfft4KHr/B6/jgIXxRRoZH7DFnRvZI
	OWoz7cwA=; b=iILNqudkLuLq5t3U27kXlQ9+JM0AcA4D/33+TayPSaajh5nK1+j
	kcZJmsag2um6oArt+9v18iSHwGTfD7BvOT2JBME1jsrM+tOZV1sQZFtWBSKzLkRy
	zQ4cYQj/dcTQwqbx0ITwpLhYuMycC2XsPwINKZ94DABiraQNsnfGI10TLtNd/Mte
	C6k3bYWbB0jYhoQmyNzWPFozDKzuYUhVgrhVOhh/49V2XMD5rydm/eh+gwuwIvau
	ROD0Sg4F3Of9X0JVaLlj+wH1t2qUn/1/1oL2AAhLsSMVjeL27a1Ulf08NT+hNAXC
	fFuIeA8fzaJIgmgJtbRUiyBV8b6gO3zyA4w==
X-ME-Sender: <xms:m4GQaM1vWynW2ZqDeFcsIKucswc1Vk86iNAvq9qKx4qj8EG_7WV2iA>
    <xme:m4GQaKXQ2s19w4e693eZDcZPcQZwodzmykaT4f8O55mt9RtMNQ9CvMh-C6j3C9GZj
    TyGsAyXlV2NDYjXmQ>
X-ME-Received: <xmr:m4GQaOWXhZRyCjSVspH8sY3H9JoYWMmls5a54DQIdqtRrEu0TxLP64EFLwXF_aHR6JznTVdT60bDjINy8CRfu85l0Kip2QQVCaPM94_HkvM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeduffevfffhvdeiuedvkeffkeekhfejhefhvd
    ejudejteelgffgudeihfektdfhtdenucffohhmrghinhepmhgvrhhgvggurdhpshenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:m4GQaBfm1kokTmJ-C-HeBRL1L9waoKWReHJqSn55RFj5PWoYIdoNWg>
    <xmx:m4GQaPUi_gkxlavHLP8YL6KsZEqgAu56HhhPXX_TmblRdGuqNbybbQ>
    <xmx:m4GQaCcKTLIWY3h-oDpOrqy-kCj0ErtSeSXMOSF5H4uq4m4iHmr7WQ>
    <xmx:m4GQaDMdosyddDNi4ZlsVtATmmF-EzlBXrjJY11wvMDFLev7cKLdnQ>
    <xmx:m4GQaIa1RA16Oz3ZOLJuT7JMLrCXddn1kb8ZzVZo53yMfDul1AlMt61Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:47:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 40e8af0a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 09:47:05 +0000 (UTC)
Date: Mon, 4 Aug 2025 11:47:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Aug 2025, #01; Sun, 3)
Message-ID: <aJCBlnHp-db4Nd5w@pks.im>
References: <xmqqms8fbilv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqms8fbilv.fsf@gitster.g>

On Mon, Aug 04, 2025 at 01:23:40AM -0700, Junio C Hamano wrote:
> * ps/remote-rename-fix (2025-07-31) 7 commits
>  - builtin/remote: only iterate through refs that are to be renamed
>  - builtin/remote: rework how remote refs get renamed
>  - builtin/remote: determine whether refs need renaming early on
>  - builtin/remote: fix sign comparison warnings
>  - refs: simplify logic when migrating reflog entries
>  - refs: pass refname when invoking reflog entry callback
>  - Merge branch 'ps/reflog-migrate-fixes' into ps/remote-rename-fix
>  (this branch uses ps/reflog-migrate-fixes.)
> 
>  "git remote rename origin upstream" failed to move origin/HEAD to
>  upstream/HEAD when origin/HEAD is unborn and performed other
>  renames extremely inefficiently, which has been corrected.
> 
>  Will merge to 'next'?
>  source: <20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>

I've sent one more version of this patch series for a couple of final
finishing touches. If Peff is happy with that version I'm happy to see
it merged.

> * ps/reflog-migrate-fixes (2025-07-29) 9 commits
>  - refs: fix invalid old object IDs when migrating reflogs
>  - refs: stop unsetting REF_HAVE_OLD for log-only updates
>  - refs/files: detect race when generating reflog entry for HEAD
>  - refs: fix identity for migrated reflogs
>  - ident: fix type of string length parameter
>  - builtin/reflog: implement subcommand to write new entries
>  - refs: export `ref_transaction_update_reflog()`
>  - builtin/reflog: improve grouping of subcommands
>  - Documentation/git-reflog: convert to use synopsis type
>  (this branch is used by ps/remote-rename-fix.)
> 
>  "git refs migrate" to migrate the reflog entries from a refs
>  backend to another had a handful of bugs squashed.
> 
>  Will merge to 'next'?
>  source: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>

I'm happy with this version, so if the above goes in I think this one
here can also be merged.

Thanks!

Patrick
