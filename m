Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AEF429CD9
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786724970; cv=none; b=fuzJekic2asD+MeSgt9yhrJneTZ31ZwHlA4egHrZ+LLKmsPuR+8/E2J1lxnZOHm+R1wSIZ5YdgqFwUr+hVKcOEn9/o6Gw/ZQHcUgs0CCw8CedZc9A8nzAwHVcxSCft/36su6hi54+h4Et03PqFtSuwTFmWirCJrXXVTr/yiSz64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786724970; c=relaxed/simple;
	bh=wJmwvfhNud1LKoYGHWqA/BJ+SA33/CFLgtagzol1hfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UebkmvgTqhNNBpzBxL346YjO/nCtsfwD7gIK+AT8r6OoPiG3Zf7XhP+pV5Qtr1NTqkbBeQPMTwqHTtRJX+dg/KI8500cgx/n5MFBkAfhDARigWKva491cvrS1HkNoQHmZXzStKQ7lFVZL/1ACosmZhYe/tZ8s/B555fw0jdtTmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xikN5Dnz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QT4+1xUD; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xikN5Dnz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QT4+1xUD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E39A2EC01E4;
	Fri, 14 Aug 2026 12:29:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 14 Aug 2026 12:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786724966; x=1786811366; bh=2RpuTxMB05
	mWm2u/kuzH9uOjMhgcrIZXB2+KLvYEET8=; b=xikN5DnzGAQ9TXEI5ypPzzFWMv
	2O+gLQ8iQ7H0/ifJQZBYxvW2dJLzOF4Nn+SRYH4fnHSBP8lgKXBhhhovrPzfsJpW
	N7+SycRuqV9HqIgHG24qzIAS+2p9bvj7O5QYwaUEToAbRfHsSLpYaqWZ9Po2BCe9
	h/KS06i0DVx/FivlKF5IaPJgr969tY1+ioNImo08iDjTJWBbpVqTRMrjNp2vhnx4
	pjFKBbJizRhOGYL2I7hk/cNo92f3sUh0ro57Qj5zcVW5kRpeKCbrb5zkqbaG9Rfe
	J9ouVzWRNQCIk0j8wJZaUSWQyfEwoaPysSuaAq+0qUUT3GfbdFM9oAGPcCKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786724966; x=1786811366; bh=2RpuTxMB05mWm2u/kuzH9uOjMhgcrIZXB2+
	KLvYEET8=; b=QT4+1xUD3nWPaSuGStPPhS0QNwZ03oZWKNLIHB0ehWZztGIZkv1
	RUcV/9S6UpV6BDzTtH0I3Xy1sLcvAVJPz9JggoNNvhQuZU7trUhHeWydIXSf5R6a
	TNTTix1w+pDky/H+2wM8qr8TnlzsSrjGtvm+9VZYPnp4lSwHdG5WrZNuks9uNSk1
	iiM2blw9fn1x3KFs1Dzjad4N2wp9kaZm/xUGeTo/B/XsPV08FskzqTx2bxQjH6Kq
	FAl9r/Y4H/DH6s/ty+phXGwU3uUkUyjWQ59HCTCqzdJP2qNwJUvl4qF2lLkm22cf
	DF95sD4GG94XIpiLMsDgdUZakbCf9UvFmFw==
X-ME-Sender: <xms:ZkJ_arjAx8qw1vRUbLdjUgAakZNS3IWxj6y6AnLm6ZJNprVKUocSbg>
    <xme:ZkJ_avAeAWtL_RQ7s7ezkFxZA88l6gFDSmePbhc2fXusYwJC4_5NP7noD_ulizusX
    J_MTzx8CntgI8AzUSfbJPUGPiN3l38KKyFZIXm8Q6RfNJ1Weo8RZw>
X-ME-Received: <xmr:ZkJ_agHab6Ttdso0bcwbGj6DwsjNuSHexEZxF8FBmKsmTZKa1dLIsh5BesnS3t3pdfwWB7KP5FvSeTkUKmObm7fYYWnbpAnanQ>
X-ME-Proxy-Cause: dmFkZTFCRxiE6M/ze6TfGIERu6XYCnZGxzhoosIm3c/WVjaCLLTQhf55NkyvQxYbxH4UIZ
    GvfEJqwcfrnc0WQtqEwOBRoLmMf6xuW26LGZDysOT4gPCB9VIg4jJQjWulNTsDB3VAP6RQ
    tqBBtTZpwECa8hyRcBDMmzqJGgqTSbZdqDeZZBxnEEWGl8a18xbjfaVPAP9BLHp0CwROOS
    CnuM9ywVZLr2E8534Xgvhe4/Awa8m6eTqCmEqa9TcgROE3Y6sF+BNJcOcxTiNxgzVhAnkx
    nx3LnocJ+mr0b3/x2ksKzaRCko/6oUR1wsfZvrvx+XGEvDqrwOPtwNJCp4spX2s/5+4qcy
    ekelwtEldHPR2+Id7NvIzXGzZZzmILgp7EWB9as/nek2lOrMhe5BKZF6hCijHpRHu/jQjC
    oTfj50hMeA9YYPD+T0aIYlnzdlSW8AGkwlCWSUTF7JQfOmdbyC/EY8CHBsxBTe9DRPgNbl
    7CPjbi4ikeiG7QoAbTXUdoxjafaYce/71A9qhW1BZ2TnkqZpfAa9+zNCuoWvsYuLiDOj6/
    s+m4qYvWOOj7NfPod6kPwga0EjISPFMdP3Uw7CzoD7L7W/ZGmiT/K2bHn5wmFivnE0Ktmy
    Hh1aiw1xlpr5rBECQ3Rpr6nEXzCB1anZ0n74BzaU68uBgdnLhSi9Hmsu9y8g
X-ME-Proxy: <xmx:ZkJ_anLGiDHygogoIOf3rtCQ_hANiMS_9FzJiY7jPZpD-vNEDoaA8g>
    <xmx:ZkJ_akkg4HPKDr66qlACX_gKT-BvLTGiIM9qF7FsF3f-tlNitULBpg>
    <xmx:ZkJ_avSiUROLseh5O-GdfEkBy3AdjttXDzdLnsBtTT4CAirtNiQP9Q>
    <xmx:ZkJ_amKtBOt59xeUr4M83BdPdEMRFIcvLzniWeJcf4b9psBr1ijTWA>
    <xmx:ZkJ_ankrBntM2b3YaPr3HZvhv_R5c2Fhhu-cy8beMbF9LR_Q87JoJAiH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 12:29:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Peter Morris" <mrpmorris@gmail.com>,  git@vger.kernel.org
Subject: Re: [RFC] git worktree: use filesystem cloning where supported
In-Reply-To: <7d0e9933-1a5f-4755-8bc5-fa4fea42f61c@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 14 Aug 2026 12:54:02 +0200")
References: <CAOqWQbKn88m=OBDF7W8bBPjeOxtRsvNmhsqNy9AryMKrOKtLUA@mail.gmail.com>
	<7d0e9933-1a5f-4755-8bc5-fa4fea42f61c@app.fastmail.com>
Date: Fri, 14 Aug 2026 09:29:24 -0700
Message-ID: <xmqq4igwpswr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Fri, Aug 14, 2026, at 12:40, Peter Morris wrote:
>> I'd like to suggest a change to how git worktree creates files.
>>
>> # Problem
>>[snip]
>
> https://lore.kernel.org/git/pull.2317.git.git.1780685368.gitgitgadget@gmail.com/

In that thread, Brian makes a good point that you cannot "copy"
dirty working tree files from an existing worktree, and also that
you cannot have the same branch checked out in multiple worktrees at
the same time, to avoid making other worktrees out of sync when a
commit is made in one of the worktrees to advance the branch tip.

But these issues only mean that you cannot call it done by just
creating an identical CoW clone of the whole directory.  As long as
you are willing to accept that, instead of CoW-copying all existing
working tree files, you may have to give the new worktree its own
copy of the path by writing unique contents yourself, the above two
are surmountable.

However, when creating a new worktree, what happens is we check out
the working tree files for the new worktree from the index.  The
code paths doing the work to materialize these files on the
filesystem do not have any visibility into what _other_ worktrees,
including the original, have checked out in their working tree.

If anybody wants to work on this, first you'd need to stop thinking
about "there are many unchanged files already checked out in this
worktree so why not CoW copy them?"  Instead, you'd need to think at
the level of the checkout_entry() helper function and devise a way
to teach it not to do its thing, and instead do your CoW thing.

Roughly speaking, checkout_entry() takes an index entry that
records filetype (regular, executable, or symlink) and blob object
name, and the path to store the blob contents in.  It takes the
contents of the blob from the object database and writes them out
to the working tree.  Your enhancement to the system may go like
this:

 - First, iterate over the linked (non-bare) worktrees, examine the
   index of each of them, and make a mapping from each blob object
   to files in the working trees that have clean checkouts (there
   may be more than one such file that has a clean checkout of the
   same blob object).  Make sure you do not include any files with
   local modifications.

 - Hook into checkout_entry() to look at the mapping you created
   above.  When you notice that checkout_entry() is trying to check
   out a blob object known to your mapping, instead of letting it
   write the blob contents out by calling write_entry(), intercept
   the request and do your favorite CoW thing.  Make sure that you
   do not lose the race where somebody else may have updated the
   working tree file you CoW from since you made the above mapping
   while excluding locally modified files.

The TOCTOU issue may turn out to be nasty.  The cleanest way I can
think of to solve it is to hash the resulting file after making the
CoW copy to verify that what you CoW'ed was a good copy against your
index.  I personally am not interested in making such a change to
the system myself, mostly because of this.

If you hook into checkout_entry(), it will be used not only by
"git worktree add".  Anything that goes through checkout_entry(),
which is practically everything in Git that updates files in the
working tree with what is in the object database, will learn to
CoW-borrow from an existing checkout elsewhere in sibling worktrees.

HTH.
