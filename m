Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C394D206F21
	for <git@vger.kernel.org>; Sat, 25 Jan 2025 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737793961; cv=none; b=IrBNvUmQyvbDE3OBdBctgRHlf0Os20WE/jhBJU/0iglR0ZkDcdyZMeX8kc0l52y9BkQBQAFC/GxVzL0JtbQ/HJqas0/OZy+CjQllD/x+Uf7zqphRbPxp9g5ZM2hOBDvA085NzJQguQwxxETEnvXevhJ7qgwwrQR+tqQBQRlj9bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737793961; c=relaxed/simple;
	bh=6ESkYqnFlJ7LGvUt3eKpGeobGa1zjC1Nj/HNosjCU/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hduUKlUcHS6FcXCvrwzuQm0NoHT+CLX8TPu7eCh1Ibs5wLC+GNLxZyUl+9HxvN7S4L+KUhsZMRdkFp8xAZ3B2e+VFMkCFpxrpG1kCsWjC4im9JGYqVmN05Ym5KfYCdhHeWFou6qompL1mfcMQ2nqbMnHFv2gEwKVFzcntgp5WOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g4QhwGjE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eosU8n6c; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g4QhwGjE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eosU8n6c"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id AF7E01380937;
	Sat, 25 Jan 2025 03:32:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sat, 25 Jan 2025 03:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737793957; x=1737880357; bh=kjBnK/BvQa
	YBBNGvP2qL6+XWpFLfTFeW4iOdqXnl69M=; b=g4QhwGjEirXk8w9pulkiutu5kX
	a72svmHxHTzO6hdQ1V94jrHA6f+x+NQCIIhS8Q3LBE74kkPF2AlgREq2ygOK4NsL
	2KAz0I2q/2UsZgNG2xHz7h8ozelhWn5ZO8DUeXyqI88EXyapU75fi/8yfdJIkqWW
	dDyenJb29NSKwHTEIl/UO5lya1VIFJwp7yO/4rlNhT/3XIWlgAxPhVH2KCU2tO4c
	5YDKdOm6+BUYDVdOtQ7lLA96mNHKi+B70e9zP2+PnySE7tsmawxlwQd16nGo6T8u
	5NHbYxrnutlHyL15QTAIfeI61qWhqM+A6E8T7b2VnQ/5/Bzt+/Bp1ofr8Vgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737793957; x=1737880357; bh=kjBnK/BvQaYBBNGvP2qL6+XWpFLfTFeW4iO
	dqXnl69M=; b=eosU8n6cC6vHdRppyWDw7jbdc7+6hgllu41cl304FdIKDJFvlNw
	39Z4nBvW7YMV1z5c/zEIszBZezeaykdWr2GRjTzwNN/axO4ebbUuIe0FBSiiQFqj
	tj43dkUkIE4dvEUAXVqzrR7w/tLAUan5ZihwVsVIfFqu8RmhG30AuD5713IXZCIN
	VDgYSx1yCkMp1P9QLNEr/LwojeVzLiDM1ftsMqIFLO2uPTSPP/I6HXyVvHBtpYGz
	eNr8GSmO8DHuI49lHkyEqJAAfzPjmHlnaPSCmzqjK/kWtYPQ2gh1Sek62kRfTfG9
	nJ7wx4/1rHlLa7YYL0OEVjzBwnTixEgbkaQ==
X-ME-Sender: <xms:paGUZ8fG2wmPVMECo9tnnebvZ4IUQLKBiExTKh8mQgQ3GE1m1tCXWg>
    <xme:paGUZ-OIlMBS0hSYO_xC9OpxZ2qlPIQYvV4lnCrVnIsWa-dsg6CHs1mji02cCqjDA
    ODvBJ8G3g0IMxnydg>
X-ME-Received: <xmr:paGUZ9iS3nSQdJhN8zyD5T1xJ155IjKBrni0LR-qwq4liIlIDpK-TAlKBCJMim-Zpmf6eM_3VmiGrDHMgijmeqwmbJ3EN7vRX6wzVznbbK_D84AN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgieelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeiiohhtthgvlhgsrghrthesthdqohhnlhhinhgvrd
    guvgdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjheitheskhgusghgrdhorhhg
X-ME-Proxy: <xmx:paGUZx8Ctq4O94CQeZaHYKaRxmYY4kB8V1KH07aRuPlJas0m_nsrAw>
    <xmx:paGUZ4uFPvxlHW2-oPhdKdMt5HvnviPgoeCxAb7dv_w-PH4Ob3I4_g>
    <xmx:paGUZ4FapLk6ZWTnAV8OEZL6icaslgn-_IuDkSXC-o9qco_3GrC0mQ>
    <xmx:paGUZ3MA1HOjCijWVhO5Ho4tU76Kb2WdUuNobZnQeNItiDYdZb9CcQ>
    <xmx:paGUZ6IKLG3SclQpiIdAqWBwklJ7JLostrlRxW0ZwxyGL4CI1Aenumv4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jan 2025 03:32:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7534f8e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 25 Jan 2025 08:32:33 +0000 (UTC)
Date: Sat, 25 Jan 2025 09:32:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, Christian Reich <Zottelbart@t-online.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] reftable: ignore file-in-use errors when unlink(3p)
 fails on Windows
Message-ID: <Z5ShoLCWREAsWZVh@pks.im>
References: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>
 <6acb9e8a-7014-4605-b8af-59c4584e9fe6@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6acb9e8a-7014-4605-b8af-59c4584e9fe6@kdbg.org>

On Sat, Jan 25, 2025 at 09:19:57AM +0100, Johannes Sixt wrote:
> Am 25.01.25 um 06:41 schrieb Patrick Steinhardt:
> > While this logic might be sensible in many callsites throughout Git, it
> > is less when used in the reftable library. We only use unlink(3) there
> > to delete tables which aren't referenced anymore, and the code is very
> > aware of the limitations on Windows. As such, all calls to unlink(3p)
> > don't perform any error checking at all and are fine with the call
> > failing.
> > 
> > Instead, the library provides the `reftable_stack_clean()` function,
> > which Git knows to execute in git-pack-refs(1) after compacting a stack.
> > The effect of this function is that all stale tables will eventually get
> > deleted once they aren't kept open anymore.
> > 
> > So while we're fine with unlink(3p) failing, the Windows-emulation of
> > that function will still perform several sleeps and ultimately end up
> > asking the user:
> 
> Why don't the changes that your commits ending at 391bceae4350
> ("compat/mingw: support POSIX semantics for atomic renames", 2024-10-27)
> help in this case, too?

The user report was explicitly about compatibility with JGit, which
still had these files open. We don't have control over third-party
clients and how exactly they open files, so it is expected that we may
still see failures with the deletion of in-use files.

> Since the reftable layer is aware of the problem, why don't we just fix
> it there and instead sweep it under the rug in the compat layer?

I didn't really have a good idea for _how_ to do that. We automatically
pull in the compat version of `unlink()` via "git-compat-util.h", and we
cannot easily change that. So the reftable library is basically unable
to handle it there, because the assumed POSIX-behavior of `unlink()` is
different. I also don't want to reimplement the "compat/" layer for
Windows, because it brings us a couple of features for free, like
wide-character handling and handling the deletion of read-only files.

Another alternative would be to provide `reftable_unlink()` in the
reftable system layer, implement it via `mingw_unlink()` with that
second argument I'm introducing and then convert all callsites of unlink
to use that function instead. But that felt unnecessarily complex to me.

I'd be happy to hear about alternative ideas that didn't came to my
mind.

Patrick
