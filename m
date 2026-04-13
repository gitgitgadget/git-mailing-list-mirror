Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A27395254
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776116014; cv=none; b=YG1OIWOlfXgvY1L3V5Biktw8ROH13XrLjaP/mADo0eSSNFId8uzxBmoVIDskj1uE/pbgXzNCfnS9fydEWuXGGWf7fGNI3SLEojVaLP64rDj3jwF5APRtNfqBlBNGIeVKkDt9QVQQG8oLcH85eMfAISdRW0vxw+9egs28zWwNvv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776116014; c=relaxed/simple;
	bh=juRsstX0yuCYaxFVAFdQPQyj7ryQyMI6un+NRE5O+pw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i94Mm+6z2y9HsKK8/DJ+yLhiwr9ktm3HnJMYKPinvwxRrVBhCgf+htK1Zq4k087n9yta3QJAzRA4gJEMalkBKEuSq7O5kELCAhRCwpThhM4SLdEOXqzRoolvN8A/JnAEbmBBYHJyqMUBtKIpcOEX1uGLaBkXvtoo84zYmMRNPiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kYLllXF9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DZbMREzl; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kYLllXF9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DZbMREzl"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 811FD14002B4;
	Mon, 13 Apr 2026 17:33:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 13 Apr 2026 17:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776116011; x=1776202411; bh=I+SgK64hHa
	mPWqjHjtd+1AohyJTnvuuxRN75VD5+QLI=; b=kYLllXF9TdQwWYVJmb8GdFV3AF
	lTtbX+eJTwmvHYJ5ZQ26VDqU/M1sAN8yqtELkFmwueDT2FsJBU68I3m0Xy6Vkimk
	1eu7rv9JIwxp0aAeQbTTWnlNzktcv9wMG0U+3BFtcLoXivIFmvYPG6vc//5oZD2w
	FhjUm5P0jo3FZGbAWgc7K6KvBxTDCX6YifmpURLAqO+/bDBN1pgkmXxEhkaL/OQO
	CAXuQ7c51XlC89NRptcs+riJfA3AIY23Bb4fpNntWYWUyg4Jdw1ebF9cut7fY8jC
	dnBzaaE8c3o7v4bt5oGbCELJz/ikdvSjAZCBlMgb6vTci/3v1i6ULmvCruZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776116011; x=1776202411; bh=I+SgK64hHamPWqjHjtd+1AohyJTnvuuxRN7
	5VD5+QLI=; b=DZbMREzl6xU9885tXG9gDK7QmEyoNW4xxfOrwPz/sGjZIuTw+BR
	0OD26rxIcx3fN/2rHU01wHfIRrFWREwd85MP9UDFW6EwMUAAxczARQvbpBBG+Y9O
	yPFKRi/7RHtlrV8oG1HT3iy7v9sLp9fmZzHo9JBojhV9G3rOA/65V1SKT91SfmUq
	Fway5TFtlp98jwBnZleU85MDOAPuIFEdLc6AmfMZ5IHrQ316hzY3JfVevLQ1lePk
	IvxaLGZNaJY91dX9pKJnafNdUoIg3xDpAS2aNKS7/ZN4kgqPWGJ+ssjLdZ03oSL5
	RFTyej8Is7tIFx9ZfRp1C0yFezidDTOlO5Q==
X-ME-Sender: <xms:K2HdaR4RbWVnSB24SPc2uEiCpoVDap2feYGwBrzlxid3GWyH4y9rTQ>
    <xme:K2HdaSJG9yzOY8hXPef5bpDQrqZMEohxpd0yS9_wK1vp0Tv3EfxpIxRe4wn1ROLKj
    N50SV_U7GNYueM53x5MHSIniID8uMjKHYlTA14hrihUpRZmU5vuAQ>
X-ME-Received: <xmr:K2HdaR7sbVoLrngpFonm71P9l-zjX15BARHfMM7WDSbbx0icmkv3lekN0xWhZ2kAY6jTpR8g2tPaXEn1meR7M1Hf8n5l88T0Hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefleefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:K2HdaVz4-Vy644Lk-YLWHplQ90WlDfvvxmKCaxmvnZ94x487vYbbig>
    <xmx:K2HdaVbo8vJcXZu24XtsDLEZDjacstExX7mF4ygFcmcSo1hn06REpw>
    <xmx:K2HdaXQ6Rd9vsMzWaifLfm0_QqZEhYaEgihrxV7a7eidylis8IMmMA>
    <xmx:K2HdafzbHCGHPcjkniBCuP6BOHJmWFxvHBlDntIkB3QgRMDG9HJVbg>
    <xmx:K2HdaRvKc7pZ-URwqzNPL389ara2iyrnUJQ9YBMxK7t2yndfIXodmW-l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 17:33:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/12] t: detect errors outside of test cases
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
	(Patrick Steinhardt's message of "Mon, 13 Apr 2026 11:49:21 +0200")
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
Date: Mon, 13 Apr 2026 14:33:29 -0700
Message-ID: <xmqqy0iqfsuu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> this is a follow-up to the recent discussion we had around `set -e` to
> make our tests more robust and basically supersedes Junio's [1].
>
> I've tested the patches with both Bash and Dash, and all tests are
> passing on my machine with both of them. CI seems to be happy, as
> well. But I would expect that this change probably has some fallout,
> even though I hope that it's generally going to be small and contained.
>
> This series is based on 8c9303b1ff (Merge branch
> 'jc/no-writev-does-not-work', 2026-04-10).

This unfortunately breaks svn related tests big time for me, as I
deliberately do not install Perl modules that are needed for git-svn.


    $ cd t && sh t9152-svn-empty-dirs-after-gc.sh -i -v
    Initialized empty Git repository in /home/gitster/git/t/trash directory.t9152-svn-empty-dirs-after-gc/.git/
    Can't locate SVN/Core.pm in @INC (you may need to install the SVN::Core module) (@INC entries checked: /etc/perl /usr/local/lib/x86_64-linux-gnu/perl/5.40.1 /usr/local/share/perl/5.40.1 /usr/lib/x86_64-linux-gnu/perl5/5.40 /usr/share/perl5 /usr/lib/x86_64-linux-gnu/perl-base /usr/lib/x86_64-linux-gnu/perl/5.40 /usr/share/perl/5.40 /usr/local/lib/site_perl) at -e line 2.
    BEGIN failed--compilation aborted at -e line 2.
    FATAL: Unexpected exit with code 2


    $ cd t && ls -d trash\ directory.t*
    trash directory.t9100-git-svn-basic
    trash directory.t9101-git-svn-props
    trash directory.t9102-git-svn-deep-rmdir
    trash directory.t9103-git-svn-tracked-directory-removed
    trash directory.t9104-git-svn-follow-parent
    trash directory.t9105-git-svn-commit-diff
    trash directory.t9106-git-svn-commit-diff-clobber
    trash directory.t9107-git-svn-migrate
    trash directory.t9108-git-svn-glob
    trash directory.t9109-git-svn-multi-glob
    trash directory.t9110-git-svn-use-svm-props
    trash directory.t9111-git-svn-use-svnsync-props
    trash directory.t9112-git-svn-md5less-file
    trash directory.t9113-git-svn-dcommit-new-file
    trash directory.t9114-git-svn-dcommit-merge
    trash directory.t9115-git-svn-dcommit-funky-renames
    trash directory.t9116-git-svn-log
    trash directory.t9117-git-svn-init-clone
    trash directory.t9118-git-svn-funky-branch-names
    trash directory.t9119-git-svn-info
    trash directory.t9120-git-svn-clone-with-percent-escapes
    trash directory.t9121-git-svn-fetch-renamed-dir
    trash directory.t9122-git-svn-author
    trash directory.t9123-git-svn-rebuild-with-rewriteroot
    trash directory.t9124-git-svn-dcommit-auto-props
    trash directory.t9125-git-svn-multi-glob-branch-names
    trash directory.t9126-git-svn-follow-deleted-readded-directory
    trash directory.t9127-git-svn-partial-rebuild
    trash directory.t9128-git-svn-cmd-branch
    trash directory.t9129-git-svn-i18n-commitencoding
    trash directory.t9130-git-svn-authors-file
    trash directory.t9131-git-svn-empty-symlink
    trash directory.t9132-git-svn-broken-symlink
    trash directory.t9133-git-svn-nested-git-repo
    trash directory.t9134-git-svn-ignore-paths
    trash directory.t9135-git-svn-moved-branch-empty-file
    trash directory.t9136-git-svn-recreated-branch-empty-file
    trash directory.t9137-git-svn-dcommit-clobber-series
    trash directory.t9138-git-svn-authors-prog
    trash directory.t9139-git-svn-non-utf8-commitencoding
    trash directory.t9140-git-svn-reset
    trash directory.t9141-git-svn-multiple-branches
    trash directory.t9142-git-svn-shallow-clone
    trash directory.t9143-git-svn-gc
    trash directory.t9144-git-svn-old-rev_map
    trash directory.t9145-git-svn-master-branch
    trash directory.t9146-git-svn-empty-dirs
    trash directory.t9147-git-svn-include-paths
    trash directory.t9148-git-svn-propset
    trash directory.t9150-svk-mergetickets
    trash directory.t9151-svn-mergeinfo
    trash directory.t9152-svn-empty-dirs-after-gc
    trash directory.t9153-git-svn-rewrite-uuid
    trash directory.t9154-git-svn-fancy-glob
    trash directory.t9155-git-svn-fetch-deleted-tag
    trash directory.t9156-git-svn-fetch-deleted-tag-2
    trash directory.t9157-git-svn-fetch-merge
    trash directory.t9158-git-svn-mergeinfo
    trash directory.t9159-git-svn-no-parent-mergeinfo
    trash directory.t9160-git-svn-preserve-empty-dirs
    trash directory.t9161-git-svn-mergeinfo-push
    trash directory.t9162-git-svn-dcommit-interactive
    trash directory.t9163-git-svn-reset-clears-caches
    trash directory.t9164-git-svn-dcommit-concurrent
    trash directory.t9165-git-svn-fetch-merge-branch-of-branch
    trash directory.t9166-git-svn-fetch-merge-branch-of-branch2
    trash directory.t9167-git-svn-cmd-branch-subproject
    trash directory.t9168-git-svn-partially-globbed-names
    trash directory.t9169-git-svn-dcommit-crlf
