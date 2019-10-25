Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E27521F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 17:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505955AbfJYRle (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 13:41:34 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:40371 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505952AbfJYRld (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 13:41:33 -0400
Received: by mail-pg1-f201.google.com with SMTP id e5so2308931pgm.7
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 10:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tRUYvuK9V+U06xmeykdrn2BsdId6x4OQC70nIvHAOFA=;
        b=mJG8Y9EhEZW9qG+2OVX/7EhghENhBBdj3fQbagyxlCmYnDqJQ8ZPceKOsioZ/uAm5b
         qVNQ06Jk7sTaMN2X+4BI950GadAHb4FJTwdj8FpZW8dlrLKnEnXZrsIKWgIYoPZwPfRk
         i6oYHha3HX88kuyygSU3URdgBzfJptYBuqNUo23i4Zm9gB5Q47jeDbNxM8WrPTI6RhfX
         OtXwW4h3uBGul5j7H8WI07MZCx7MR30taiuLaxkf54JAOPNDgrk5Oo4GPAy2ySpd5DRN
         iEMRulKiVqirDtkTPqt81bGNPE0GqDzlElZsRUiprn5UL7ab3h+PWXXcrT6qP/NPrv1G
         bbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tRUYvuK9V+U06xmeykdrn2BsdId6x4OQC70nIvHAOFA=;
        b=pszAb28PRucezYAm25P1+JQJuPB0MS5QTARHU99/6U9VzJ1wZ7qrZzk36pvS6sIPPm
         Ku6e9WkHPby9sxX8j/PrREt+123xc7+5DEEOVVtv69PfeO6EVrgTbRtp3dtdS6dTwXpV
         aI5eWgL154/WTcYdWWNCooA0HQSNDPlc1Jf/w9TppjkPQNu4hCjhJ+lVwRoO1Kbmv3EG
         FtbHwZE5Mh8fX7FKQnxQr5T+pQW1wVwJS6RDbXYIvP/bEsOi6rhljR9qm21wvT2Spfvs
         XCJ8QOLS0ykJ67Rkcyg6ODHnuWk95T6CZ3yDGQze7J7SOkNH3oDAyxDDqtFVAKwVOsYe
         aC8w==
X-Gm-Message-State: APjAAAUiZKoEy4iQ1DwqY6b3XAHMyGuHZClCPTYiX1O0Dp6PIC/O9Y94
        o8XPR656dMlmDBMHD+KzANO6teBAyd5bluWV8sFb
X-Google-Smtp-Source: APXvYqyyc49nEo5DvNlETC8DWHBX5dDzgisEuYrVhACxZRsyt+10LsZDyBQkgv/t7PmvuJqsRRm9Gf/gx0t0Sddr1dg4
X-Received: by 2002:a65:4bcd:: with SMTP id p13mr5914352pgr.80.1572025292653;
 Fri, 25 Oct 2019 10:41:32 -0700 (PDT)
Date:   Fri, 25 Oct 2019 10:41:29 -0700
In-Reply-To: <xmqqv9sdeeif.fsf@gitster-ct.c.googlers.com>
Message-Id: <20191025174129.194010-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqv9sdeeif.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: Re: [PATCH v3] fetch: delay fetch_if_missing=0 until after config
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Instead, we can control whether a region of code lazy-fetches...
> 
> The approach "from here to there, we can set global to forbid
> lazy-fetch" may prolong the life support of the quick-and-dirty
> mechanism, but it has to assume you can say "from here to there"; it
> would mean that we cannot go multi-threaded until we get off of it.

By "from here to there", I meant, for example, creating a struct
repository in cmd_fetch() that has fetch_if_missing=0, then passing that
repository to fetch_pack() (once fetch_pack() and all functions it calls
support a repository object). In that way, from here (start of
fetch_pack()) to there (end of fetch_pack()) there will be no lazy
fetching. As a bonus, if we ever want to support fetching in
repositories other than the_repository (e.g. submodules), this change
will allow us to support that too. I don't think this is
quick-and-dirty, and I don't see how this prevents multithreading.
