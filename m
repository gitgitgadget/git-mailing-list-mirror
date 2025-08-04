Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED961FDE31
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319073; cv=none; b=A+LctVSQPKqJXArcMyraVszYSljsqsOJubRgRiAPBKwMSVk1HWKGMqBa53J9ORkAYYhoVHrQPrz9b+vH3ZpxiTATCK8Jjx1qcEWp1QeyrlKwVuIGOjaw9Nx/NWM99MYl24JvX0AhPXqm9d4Ym9PRKHTUxq25jbUff66DtS/b4FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319073; c=relaxed/simple;
	bh=PtiMlSff8tBiFSHKOW8cnYgMnVq5/7qM3m1IECyVX14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVmq5+5bEX1fg678Mvezvka7fqqblRNjyh4AG0QU4qzwKjmGU1h2SKk9x1TPZhVoGNwp7/dBLubepj/T3XjQio1TcK8i1cGfzCwMxIgxfFzTt1t+b5PGc4wkCdQH2+U0c+f1K5J0VLlygAvi5400jyh35wFHclHmcAttZgKKIto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eQS1GRyO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nLqHAB7F; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eQS1GRyO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nLqHAB7F"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 172971D00009;
	Mon,  4 Aug 2025 10:51:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 04 Aug 2025 10:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754319069; x=1754405469; bh=uChKRShlAs
	gBMVuHaY6uvFaYQOABdwf3CmgWPvbi9Xk=; b=eQS1GRyOlMQ5R1n3qRHUOTu+M6
	qYu2/WI5zyD80D0VwP6jbN8Wo4ev/7p8fTX4zVkdX2a2V2Fc3JMHlRWbHHSrb5O3
	UaJfWK6Dh/yr7ATcpwwNBUiHhi2Oo99gJRNdSv1un3nI5BcKWuHib00mM5CuL/c1
	RkxJV/uLY26m2hqsVnxKnmWA6UEq1+nx0IzI2NzoTh3Z0hdfrPcR4EETh20EwaPo
	GK1Bq9ds/xSyNx+ReB8Nl5xBkmKKwIxIq26zT/gvIOqNFijkWWyVj+BKoI5PlgR5
	Tmnt240c2r9Dxpifufq9vqfQtFYH9ZyAXLa+fUcAEyAHrkdVhMiTJHDLLNuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754319069; x=1754405469; bh=uChKRShlAsgBMVuHaY6uvFaYQOABdwf3Cmg
	WPvbi9Xk=; b=nLqHAB7FFIffOp0vOOXEwgtnlFI9y9cNgUKw9eBzDGaiY7CSgAP
	JmyV1fWNB9Ma7Cv4Jzx1/QKjVz4OGSyh5/Pe0lwM7CgFDQBwn8sD0+yaLYX0Y4wt
	t+/3iiM1RjMloEdT06dczcaqXeldRiY6WzEmXFiaSpX28mS7eUBvgULD7tlN+g3W
	DAiXh/Glk5iADKnQv8sjpWjJHm7CM7EZrocSP5AYMosWzsJ0MIcNCnAuL0tbWWhr
	poNzctShqg8Lk6peeleKWs2AKtwR9Lz9ULrA6rBhTD7o/jHJfoevFhpdiXJwf4FY
	tv1wBc3T4MG3jACj4Fz6UM4FNCqVXrfG3Xg==
X-ME-Sender: <xms:3ciQaC-7jS8_cSjiYsjIOdcjGhFStRNqQQzD2VCsQ6VqekLgkmCT_Q>
    <xme:3ciQaF_1Vhv60lobgfUA21-CnhPUgUdFWRr9E7kzzu-QwmUrjhhXPJhyxa4tB17TY
    DGkSOD7S8N_IjNz2w>
X-ME-Received: <xmr:3ciQaBdX2EJFMqXfh1rMHM-qXqVN2OfsAjkVnnr6YlsH40zpgFFG-LEUitTpUhWLRzBMxjsX2Yq2brKP_Jjuuu9jRbRKIJ4fM5IWXFOHZMk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddvheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:3ciQaGE68XlSa59wXXJTF4ZeQU8XhOWSuF0A-9OSnmjjfXHvhumhyw>
    <xmx:3ciQaHeCJqCsh4Wd9DAqEzO-h836utYWh3PrPoMTPh0bUCGyD0WMvQ>
    <xmx:3ciQaIGAI6-vzDEtL40RDSdeRKomiVivpN2AIW9YIYnL2thlWkfipg>
    <xmx:3ciQaIVdrC91TSavDV8RzTMw_wRnA8p1O8emYAHec700jKKiGW-Rdw>
    <xmx:3ciQaIB8sZj1Kq4QCaEWES5juusWYmjJtRlzy_TMGCvBDOpjUdWziBej>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 10:51:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e2b7674a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 14:51:06 +0000 (UTC)
Date: Mon, 4 Aug 2025 16:51:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Aug 2025, #01; Sun, 3)
Message-ID: <aJDI16RBR9QKdtW9@pks.im>
References: <xmqqms8fbilv.fsf@gitster.g>
 <aJCBlnHp-db4Nd5w@pks.im>
 <xmqqqzxr88jg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzxr88jg.fsf@gitster.g>

On Mon, Aug 04, 2025 at 07:29:23AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Mon, Aug 04, 2025 at 01:23:40AM -0700, Junio C Hamano wrote:
> >> * ps/remote-rename-fix (2025-07-31) 7 commits
> >>  - builtin/remote: only iterate through refs that are to be renamed
> >>  - builtin/remote: rework how remote refs get renamed
> >>  - builtin/remote: determine whether refs need renaming early on
> >>  - builtin/remote: fix sign comparison warnings
> >>  - refs: simplify logic when migrating reflog entries
> >>  - refs: pass refname when invoking reflog entry callback
> >>  - Merge branch 'ps/reflog-migrate-fixes' into ps/remote-rename-fix
> >>  (this branch uses ps/reflog-migrate-fixes.)
> >> 
> >>  "git remote rename origin upstream" failed to move origin/HEAD to
> >>  upstream/HEAD when origin/HEAD is unborn and performed other
> >>  renames extremely inefficiently, which has been corrected.
> >> 
> >>  Will merge to 'next'?
> >>  source: <20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
> >
> > I've sent one more version of this patch series for a couple of final
> > finishing touches. If Peff is happy with that version I'm happy to see
> > it merged.
> 
> Hmph, you have?
> 
> >
> >> * ps/reflog-migrate-fixes (2025-07-29) 9 commits
> >>  - refs: fix invalid old object IDs when migrating reflogs
> >>  - refs: stop unsetting REF_HAVE_OLD for log-only updates
> >>  - refs/files: detect race when generating reflog entry for HEAD
> >>  - refs: fix identity for migrated reflogs
> >>  - ident: fix type of string length parameter
> >>  - builtin/reflog: implement subcommand to write new entries
> >>  - refs: export `ref_transaction_update_reflog()`
> >>  - builtin/reflog: improve grouping of subcommands
> >>  - Documentation/git-reflog: convert to use synopsis type
> >>  (this branch is used by ps/remote-rename-fix.)
> >> 
> >>  "git refs migrate" to migrate the reflog entries from a refs
> >>  backend to another had a handful of bugs squashed.
> >> 
> >>  Will merge to 'next'?
> >>  source: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
> >
> > I'm happy with this version, so if the above goes in I think this one
> > here can also be merged.
> 
> You have an update for this one.  Perhaps your comments are swapped
> between these two topics?

Oh, indeed. Sorry for the confusion.

Patrick
