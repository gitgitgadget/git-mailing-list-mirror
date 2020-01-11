Return-Path: <SRS0=hslh=3A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094A4C33CA7
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 22:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF0A2082E
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 22:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eefA+oHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731586AbgAKWfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jan 2020 17:35:02 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:47263 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731579AbgAKWfC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jan 2020 17:35:02 -0500
Received: by mail-pf1-f201.google.com with SMTP id e62so3923589pfh.14
        for <git@vger.kernel.org>; Sat, 11 Jan 2020 14:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+KlhRrUcvm7dwLz6RebZqOI/BJqufC5hsikEm1sZQ3Q=;
        b=eefA+oHKapPvpaRHDh+OCAY/CpD+3IygQ4axxqkpPHvLAjCaH8ww0WOoNHiADn6xz5
         XfzBpTZLIhqBpfmW6mdrbr+CINBClam9Ytr2rF/33+wnh6keDJxug6Ms7P37thwGKBRJ
         EwQjQpRDyk4ypD4g4aGg49tKUMNaAwsgwPA50SovryCEbIz8rb7+Yl8vq+9UTwABlIqt
         l0S8lGJBkLC8EF8dAIabUtD9Y2OzoMBIm8Jb4g4zIJv3QHcTV95bdzghM+TUAkYRs9nR
         CNI+6jFWVpGoOTDa4hAFbRvzsATFPmwA8cHnyXOqaMQGjdi/cYQ4aBppCP7NwpLmruei
         tQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+KlhRrUcvm7dwLz6RebZqOI/BJqufC5hsikEm1sZQ3Q=;
        b=m6aGCCXlrk2aAYd7nouGGXT8CNYK+vJj+7Pc6ZrR21rcADdBs9C4qelw6rQ1dSJdgs
         m7Q8VxwBQGQSRnyepnGov354JmSw5sAJhdBVAislGht8xLFwH69UtAEGMxCX8c9GOgfl
         B+tt5jtiVa6pPGaxXSMWTm/Wo9FonVEriJM+Ghk9pBEy7ZihXZtupr1w4WR1kcpUSmh/
         0U7vS1HrXMT98MYzq7nlzcmKvK80hVTl4xcS/pz1+RLTIcCKQ5967An3P0ZxV0B3Nsa+
         qdfexWpQOuOLOdJ784bsKxgy41q7XDm/+syOkF893JtKdirSKspQJ8Zx5ZhzrNCLJR/T
         xkpQ==
X-Gm-Message-State: APjAAAWujxEXlvtBGh51KBD6Wk1noa4QrZ1vIr0OkxRytJvBjdMnc/uV
        QJ+3Cl8dmV7RgOQPoT0SQPG8KfKyFNcSA5qp8BDhz/yx+cBkUlKLxzXT7XCAAKCMB1xr8+xxxmL
        XsTza5cdkpLFa1riTqbMrs9blMY+LSHJ61hnowRczbTdxZaWURS+y8YZyOZ+T+un5g6so5p6ufz
        EN
X-Google-Smtp-Source: APXvYqx19DWTSmfngh63v15MzDusyYBDafSYEwKSxu8JMgiS+b6kyD8wf3cZmji3+MaQdoaRW0qVeECIO6+F40u9MdTl
X-Received: by 2002:a65:52ca:: with SMTP id z10mr13550392pgp.47.1578782101471;
 Sat, 11 Jan 2020 14:35:01 -0800 (PST)
Date:   Sat, 11 Jan 2020 14:34:54 -0800
In-Reply-To: <20191228003430.241283-1-jonathantanmy@google.com>
Message-Id: <cover.1578781770.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191228003430.241283-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v3 0/2] Un-regress rev-list --exclude-promisor-objects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I took another look at this and tried to simplify things. The main
points were:

 - there is a real bug
 - it can be fixed by relying on get_reference() more
    - but there was some discussion about what get_reference() does, so
      I added some documentation first

Hopefully those main points were adequately conveyed in the new commit
messages, and I didn't oversimplify things.

There was some discussion about whether get_reference() should treat
corrupt objects as missing. After some thought, I think the best
argument for doing so is that this has been its behavior for some time,
and have wrote that in the first commit.

Jonathan Tan (2):
  revision: document get_reference()
  revision: un-regress --exclude-promisor-objects

 revision.c               | 12 +++++++++++-
 t/t0410-partial-clone.sh | 12 +++---------
 2 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.25.0.rc1.283.g88dfdc4193-goog

