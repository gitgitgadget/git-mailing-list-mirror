Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7515332ED3
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764496; cv=none; b=CiSnfwtHUn7v/93x7mdv7p6AYQ8IOOI6Qm7CR0EeUMlYyEFxGmaDReYoLLDKR5MJH/LdRtneKKE65zKE4jcwONyifAWvhznImReSclTEDPQtqRui9jayvq6f4Psy8FcLZhLtFyhoKPoTATRuU5X0ne00q7GI6geCd+r3p9KgusY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764496; c=relaxed/simple;
	bh=Vwhrwg/O9Q2TXA70Dh984+uXc2VwTn8ZcEnNEAcEsDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbnc9e8qbPxn14CqElyOGgvmZjivPeq/hWcVLLh4LoMEzXZLb7ZdYxE2Oh9VpF8QdplfvmpvYlpuiqeKaQw5VfHRRBQWtQUuSpxsWU/eiHmxg1iWzZAPJuzO1ic2uoxuPeIMCLfMEoNhZPeqtoJguS6LUeIZBNpiJmvc3qwsHNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xphCb+ER; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CGra4aX4; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xphCb+ER";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CGra4aX4"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 3568EEC0092;
	Tue, 21 Apr 2026 05:41:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 21 Apr 2026 05:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776764494; x=1776850894; bh=GZ1v19bcZD
	QIaWqy6Zu0M+pC3m7MoNOcJVSOyk2bA5Y=; b=xphCb+ERMflmsRtwTfSLWpoj1x
	ZCVU/9VPie0YYOP+CAzQfusP3XNnjMvvdTdNk7QP6ZOrSEh2t6wF41I1Vc8pN5Y8
	LPnsce5IqBzrsxbF3yZdZaFSN8k/v1sQ67zAgW+nhv6ZZbxS/KNg3qvplSXk7NSp
	OY+gP41i7cG6HvSKdcDF1j+4v/8zxPEg2HIrxuV8HDLtjzVzIKERTr399ZpDqf1F
	DG70xNvjpQrDlGflXztGze1de63Y4hxak3tTftWjkY9/E3MDLNKhTY9pslz/3gr7
	tJZ47zUnB6oJzA35b20FHhlR+kP+X5xG6CoNhbNPvc6r/+S8kGqzBDJ3PdDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776764494; x=1776850894; bh=GZ1v19bcZDQIaWqy6Zu0M+pC3m7MoNOcJVS
	Oyk2bA5Y=; b=CGra4aX49oVsxW1g4TfqTY5FOj3Wp/R7p6DLaS/CCBwFqKv8zVE
	aYKz4S7UCPc32mKby5hcsV0qBI6ZQCymAesxDxLCaNeXP1Bj6AiWChJS6hUl0iwe
	I/XVHZ1QeOma9gZxdMqFLcxa9mvFrYE5AbFfSw7cV681nhpZkqHqjMq1xDEDy8qC
	yNG6IHtJGPrP/drIsUFLOM6w7v2zqlVv9yVvvaUG3BcHnH/2cirsvxm4r4eZOOVp
	6wqzfVWQExy/XmMrFMchHDplSsPXgUtxQwtGD9W5vUSqNpxmnXGgY8+hO1XgMpdq
	0I2Cx0e1qoKr/8CPm7B4W/VO68lKvW5jRHA==
X-ME-Sender: <xms:TkbnaX39MH6oxC9ekraAnrD_DJr93YGJ4YxGpJcLfwVDccsM-jlzwg>
    <xme:TkbnadH8BDf1BpUQ2F0N7Xj62iZ1hlF0pP_seYSkwxMAS684iOwlgCNDABEZpxhR3
    ck8injEQI7zvXxQWIKaEU99M4CFZ9ATFU_ZsZQMtxPUMYnS7JBt>
X-ME-Received: <xmr:Tkbnac542aQ96Bx5s6LFvB6_CK5Zw_1Sbjzs9jRWEJ1zmeC8jgVhELYnylzsQpaHQHeDYiKCbDsNtDhRHwz1c8Ha4wTVJL_MgZCDoYDL5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiuddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:TkbnabuRKW4J-orbFX0OQm3WfwMj6VIWPwoop1VU8ZLqY6XXcIP4hw>
    <xmx:TkbnaV5ERnAq3ARwMalgquJtYGNAkUPHZtVwh9_uE8MGNBvywXavvQ>
    <xmx:TkbnaeXdlcjDkffcDDrO028awjP4NTf79FraE06Va42tXVjbTh-nsQ>
    <xmx:Tkbnaf9LMrrmt5jGZrf_9nRsTPLXYI26JwQmX8imS3XOynbyxzx8WQ>
    <xmx:TkbnaYZsMCu72__2mUtgfJFk6S40fygodvsXQT9ikldWD8aXuvj2V9uD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 05:41:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c79bda38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Apr 2026 09:41:32 +0000 (UTC)
Date: Tue, 21 Apr 2026 11:41:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/18] setup: drop uses of `the_repository`
Message-ID: <aedFNjsLDsFj_InR@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
 <xmqqy0ihpnf6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0ihpnf6.fsf@gitster.g>

On Mon, Apr 20, 2026 at 10:11:09AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Message-Id: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
> 
> There seem to be some tool errors that made this marked as v1 (hence
> no References/In-Reply-To).

Yeah, I noticed this, too. As mentioned in the mail to Elijah, I think
this happens when I'm overeager and already switch branches while b4 is
still busy sending out mails. In that case, it doesn't update the series
to vN+1 :/

> >   -  9/18: setup: stop using `the_repository` in `setup_work_tree()`
> 
> > diff --git a/setup.c b/setup.c
> > index dca32addae..80dd94b261 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -26,7 +26,6 @@
> >  #include "trace2.h"
> >  #include "worktree.h"
> >  
> > -static int work_tree_config_is_bogus;
> 
> Once we start "setting up" more than one instance of "struct
> repository", "the worktree configuration given to us is bogus" bit
> cannot be a singleton global that applies across repositories.
> 
> Hopefully nobody sets core.bare and core.worktree in configuration
> files other than the repository local one.  Otherwise a lot of
> interesting would break ;-)
> 
> I am not quite sure the reasoning behind removing "initialized"
> global without any replacement was properly explained, with "should
> ultimately be idempotent".  This can give us a huge performance
> regression, if the callers have been relying on setup_work_tree() to
> be _cheap_ when they call it "just in case" no other potential
> callsites have called it, even though all of them know that the
> current code works only with the_repository (in other words, they
> call because the switched into the_repository---they do not know for
> sure if other call sites have called it).
> 
> Or does the current code never call setup_work_tree() twice, because
> everybody knows that we never work with anything other than
> the_repository?

`setup_work_tree()` is typically executed via "git.c" in case
NEED_WORK_TREE is set. Some other top-level commands end up executing it
manually in case the bit is not set.

Other than that it's called in a couple more sites:

  - "builtin/check-attr.c", "builtin/clone.c", "builtin/describe.c",
    "builtin/diff-index.c", "builtin/diff.c", "builtin/difftool.c",
    "builtin/grep.c", "builtin/ls-files.c", "builtin/read-tree.c",
    "builtin/reset.c", "builtin/rm.c", "builtin/submodule--helper.c", :
    Not marked with NEED_WORK_TREE, executed exactly once.

  - "builtin/sparse-checkout.c": we have multiple callsites here for the
    subcommands, but also call it via `update_working_directory()`. We
    execute it a fixed number of times only though, but I doubt that the
    performance overhead of this matters in practice. That being said,
    all sites leading up to this have already called `setup_work_tree()`
    beforehand, so it would be trivial to fix.

  - "builtin/update-index.c": it may be executed multiple times via
    command line options, e.g. in case you execute `git update-index
    --refresh --refresh`. Again, I doubt this matters.

  - "blame.c": executed exactly once via `setup_scoreboard()`, which in
    turn is executed once only via "builtin/blame.c", which is not
    marked with NEED_WORK_TREE. So this is fine.

  - "wt-status.c": executed once when printing a verbose status. This
    will result in a second invocation for git-status(1) and
    git-commit(1), but again it's bounded.

  - "t/helper/test-subprocess.c": executed exactly once, but doesn't
    matter much anyway.

So overall I think it's fine as in most cases we really only execute it
once, and in the remaining cases we only execute it a limited amount of
times (twice or thrice). In addition to that, getenv(3p) and setenv(3p)
shouldn't be inherently expensive, and the chnotify callbacks we
register are all rather cheap, too.

We _could_ prepare git-sparse-checkout(1) and git-update-index(1) to
handle this, but I'm not sure this is really needed. All the other
callsites are fine, as far as I can see.

Thanks!

Patrick
