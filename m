Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411EEC433F5
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 11:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2040E6109E
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 11:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhJBL2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 07:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbhJBL2b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 07:28:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D02C061570
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 04:26:45 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ba1so44403485edb.4
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 04:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FiGohdxZz9xBxJfmdm6Jlr1rVbmI+nGGyrc+S7HUFxk=;
        b=KITdbyT8Nty5nZ03zNzCGEAd7lpT8DPVfpgNMwpI+OQHwyhSyMj7faOsWwxOobjJhi
         k7qZnq84WmN3invNS/nMKEa9ofREjO9WM92W7Pq4x+AXKU81pyVXJ76HlkOMUtjkeoKh
         ln2CcaobbP/Kyxg1DtiRGuZ1c2lVvDsfBysuwWIimvtO4rxQrGECCeND6fLrqP1P0dzP
         7QEssjMMRY/W24vxH8EdE5+9CokTd0T5saLRZP8Mlyt7+gpHH5W85FZUF2p8OsWZcpIY
         5AJbqLhE8ljPh9XtuThXsgNEwEIUw3J1NaI4xzXlWZ8jaY66mGZh/Cu/Lm93JOyea33i
         8b6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FiGohdxZz9xBxJfmdm6Jlr1rVbmI+nGGyrc+S7HUFxk=;
        b=BrlSfsOxYGlaoXNfN6VENlLpvVoPd48ZuX3l0gA7I+PDnqHKOE+4UrSrxm/3O1vl8J
         hnFBdu/iE+8IwnTJGBahPvoYC8N9kvn4mXJt/LFvJ+s8OIRPnEo1iqcygC5xEhjQk1gV
         pFWZPBm9dqtWMzIt6h9qCKvbcCVXrF3xlheuh8ReUsjlKDRD86cPDSZuU4qhmQ9ROvDf
         Or840jgC1nwSa3WTP4eSIHXkBh7j9r4EG/ysrGYjgjf5Hoacvy+u8Fh0AWKnsOEcRrVI
         sFj0Ifgsr7ssbgDkCd+Um2ZyRScNx52vbfGY9eJC5b6+cFz+1iyJ3rs0ejqGg+2aT39C
         UERQ==
X-Gm-Message-State: AOAM5323xqC0FRlaQ+fUtyOLbuRNNI1xgT51w/wPLFlcvB05CifqJNuN
        kw8VdEZOnpHos6rGfn+cXwI=
X-Google-Smtp-Source: ABdhPJzre9OqYW6hHj/QYuKCqt1KFn/kzJKRTGrQCujOSfzSVsgVpOPMXveuj9PthUetIABGcdtb8Q==
X-Received: by 2002:a17:906:704e:: with SMTP id r14mr3568898ejj.293.1633174003846;
        Sat, 02 Oct 2021 04:26:43 -0700 (PDT)
Received: from gmail.com (77.119.208.5.wireless.dyn.drei.com. [77.119.208.5])
        by smtp.gmail.com with ESMTPSA id h8sm4275881ejj.22.2021.10.02.04.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 04:26:43 -0700 (PDT)
Date:   Sat, 2 Oct 2021 13:26:40 +0200
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] perf: fix test_export with SHELL=zsh
Message-ID: <20211002112640.hrn2ojndhoa2dd4c@gmail.com>
References: <8b70d04f-0ad1-6e68-f5a2-2d8ec3bb98ea@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b70d04f-0ad1-6e68-f5a2-2d8ec3bb98ea@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 02, 2021 at 11:40:02AM +0200, René Scharfe wrote:
> Pass the value through an unquoted command substitution to force
> word-splitting even in zsh.

This seems like the wrong direction.  There are probably other places where
we rely on such POSIX features.  Also it doesn't fix the case where users
use other non-POSIX shells, say

	SHELL=/bin/fish t/perf/run p0000-perf-lib-sanity.sh

We already have solutions in place - our top-level Makefile has

	# Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
	...
	ifndef SHELL_PATH
		SHELL_PATH = /bin/sh
	endif
	...
	SHELL = $(SHELL_PATH)

Meanwhile t/Makefile uses

	SHELL_PATH ?= $(SHELL)
	TEST_SHELL_PATH ?= $(SHELL_PATH)

A related fix is to make those two consistent.  I would prefer the version
in the top-level Makefile, because t/Makefile gives the false illusion that
$SHELL is honored:

	SHELL=garbage make -C t t4211-line-log.sh # succeeds because make sets SHELL=/bin/sh
	make SHELL=garbage -C t t4211-line-log.sh # fails

---

Anyway, for this issue we should just have t/perf/perf-lib.sh follow our
convention of using ${SHELL_PATH:-/bin/sh} instead of $SHELL.

Looks like t/interop/Makefile has the same problem.

I'll prepare the patches later unless someone beats me to it :)
