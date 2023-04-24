Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296C5C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 18:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjDXSwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 14:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjDXSwk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 14:52:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4759762
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 11:52:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b92309d84c1so22784096276.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 11:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682362316; x=1684954316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pxvvpX/1igWMXqh2kdq37ZEsNlU2jM8AJPQkmf4jHrk=;
        b=wyoyirWisPS6qb057N30OA75XE79ouB243aNnj/LObh23qGwv67RmgG4BvZVdNYmIY
         K2VQ1VmppNKXUzD/hHR0XlRSr9yuDVlHgPlEzmm70Zd4dycxLy3tGXT2dpOxmfLvOk/6
         6MZNXdAWi8VS3LsI7fqx7yjtEH9Xa3mvvgT4DHoOwhZqTguhFCKWeLHzlqGO1tJtm1zh
         ehxXFuOqoodwP+pVp9t07EEEx9l52QlCQwvmw6Ry9gKJAZp2rxrzwzqw33sQa0C64V+3
         u0JaM/ThEaLydtQNleIRjsGSeXgXTsWrXn1WWkIpb94LwQFZ1NW4yYpNEOQzxF6B0OOB
         lPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682362316; x=1684954316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxvvpX/1igWMXqh2kdq37ZEsNlU2jM8AJPQkmf4jHrk=;
        b=SCHZD9nsRXoWmMRf14SwWL818WhGqBtLicvk2jsKip+0Px5JatsExkdGSZYSVnCjU5
         an9R83CFuZAR0sLJbSVMShYFKxYyONEyD3grxNKaRYXYFH3CpRxITTiAbn5AeE/D5u6G
         ath4lGQ05xt0P8Igxs04uuD2GjGQROkdapzZxRbIrgWgGKvaCs9keMuSMbkQiD0qzqVR
         UWl6VVXHV7cHYtLtebvp4RgloRU8kaUc0EJC7BzoSmzzw+gwOGrQgSMHGNDxg/EBQfo7
         qnoQodzWK4Oc7vO+HvTzyMR7JBjTCGxl/g+h0hpZvEpNKIWPMKBrC9j9DamNrrQOpn02
         ZE1g==
X-Gm-Message-State: AAQBX9cYY6+uKUlFpPidpyhBsGaj/kOWV/2HwQN+vG7aGWevMnC1xFAg
        h7cPRKfHLL/qus64qvoIC7dHOVgrKkl7jw==
X-Google-Smtp-Source: AKy350ZCUQei3Ne7KvumwwTg4hbQdp4MamG2U0J4EpZGnlUgern2wCBKvXfLQcwOhSq3pZx7EV3BKqdA/bqmlg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:690c:9d:b0:555:a687:e151 with SMTP id
 be29-20020a05690c009d00b00555a687e151mr8219089ywb.3.1682362316709; Mon, 24
 Apr 2023 11:51:56 -0700 (PDT)
Date:   Mon, 24 Apr 2023 11:51:54 -0700
In-Reply-To: <d95f97f5e90da40b285aa8fd678efcff0ae11033.1682194651.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com> <d95f97f5e90da40b285aa8fd678efcff0ae11033.1682194651.git.gitgitgadget@gmail.com>
Message-ID: <kl6ly1mh865x.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 13/22] hash-ll.h: split out of hash.h to remove
 dependency on repository.h
From:   Glen Choo <chooglen@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>                                 Move the parts of hash.h that do not
> depend upon repository.h into a new file hash-ll.h (the "low level"
> parts of hash.h), and adjust other files to use this new header where
> the convenience inline functions aren't needed.

Suggestion: To maintain this property, it might be helpful to capture
the rules of hash-ll.h vs hash.h in a top-level comment.

> diff --git a/hash-ll.h b/hash-ll.h
> new file mode 100644
> index 00000000000..80509251370
> --- /dev/null
> +++ b/hash-ll.h
> +const struct object_id *null_oid(void);
> [...]
> +const char *empty_tree_oid_hex(void);
> +const char *empty_blob_oid_hex(void);

hash-ll.h doesn't depend on repository.h, but these functions' bodies
use the_hash_algo. Does it matter?

Moving the functions to hash.h requires changing 8 files to #include
"hash.h", all of which seem to be because they were getting hash-ll.h
indirectly via object-name.h.
