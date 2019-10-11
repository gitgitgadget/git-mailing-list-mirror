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
	by dcvr.yhbt.net (Postfix) with ESMTP id A93D51F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 22:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfJKWI0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 18:08:26 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:49514 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbfJKWI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 18:08:26 -0400
Received: by mail-pg1-f202.google.com with SMTP id l6so7889659pgq.16
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 15:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XTyagDPFsil+mL9bh2FPs+o9QI3DaStQfQBXiYgpsEg=;
        b=Cn6HPkwhQ04MOYGmkEKj1O3awdHifDpyXicSdw8IbgqIQ7RDlYrGlgndb7KG3rPfHu
         XP4fXayIQrYfagZN/jB/BVluUf2dqF2xFRV0plD+ew8C8p9TG0QChceq8vm6/o0MKxr9
         P9zBgXLt94PLJ5DPESNgidIEWmJ4MR6/J/mtt5xcZHcukoa/gRpiSQbJQmmUxWfr8/mq
         Z4arys/yam6VOMrURdsZbbuMeANU/GaYWtPxePdlnzF3eE0O9iD4iISHXEpOrdBIuV+F
         MwdSxjlmIpUZdm6+9OlheFdmgvE1WS6iOwl4fZ3bCXTUAAoL6VzziPB1aySCQG7G97te
         BQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XTyagDPFsil+mL9bh2FPs+o9QI3DaStQfQBXiYgpsEg=;
        b=ShrEtD0BwkGGbl0M4Br/XvKoSTyW+bnn3st6FGv8up8VCSet1D1tYQc/sJnYd4+Xoo
         KYoHCW12iA4cOptpo6xRrMNq7p3qAZCtH5WDqi3psW+c+vxNxpoa726kZmTAyNPW6Pg9
         kVUDyP+XtbmlHfA2iSR3AVBOuTmoWZukELPei+xUVHB7Rkby0Gp7U/upIpjOhIRavNf5
         2gNVDQnek4jNklZUiJIASmWapX94oUWiEpjqM8Ky4EKcMbx9Cbab7gMAbHSt0Oxz8rHD
         ARxejrWy6YjRQegDe6L7C2gpKBGcPrwmWruQfc7ePSsUYackDdDwdYVjTwNMN3L4cW3j
         T3sQ==
X-Gm-Message-State: APjAAAUpsbyvcFBgDTDg9tcBfWdg7RypCEIrcfuGhUIze5ee1z9dUctQ
        LGX4RCPMmqdxUI1zaFp8D2diPPPsFMgqdZ1l8mDi
X-Google-Smtp-Source: APXvYqw/0dl44RLX6OuuYvYAw9bt2jxA/nDBLyn/aLWUkyzWj1uHHBZRchz3/IX8o0c4T6j50dnuHhaUvDfZzGgA5YNo
X-Received: by 2002:a65:5b02:: with SMTP id y2mr19712445pgq.365.1570831705728;
 Fri, 11 Oct 2019 15:08:25 -0700 (PDT)
Date:   Fri, 11 Oct 2019 15:08:22 -0700
In-Reply-To: <20191011161504.GB19741@sigill.intra.peff.net>
Message-Id: <20191011220822.154063-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191011161504.GB19741@sigill.intra.peff.net>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: Re: [PATCH v2] send-pack: never fetch when checking exclusions
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     stolee@gmail.com, jonathantanmy@google.com, git@vger.kernel.org,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> As a general rule (and why I'm raising this issue in reply to Jonathan's
> patch), I think most or all sites that want OBJECT_INFO_QUICK will want
> SKIP_FETCH_OBJECT as well, and vice versa. The reasoning is generally
> the same:
> 
>   - it's OK to racily have a false negative (we'll still be correct, but
>     possibly a little less optimal)
> 
>   - it's expected and normal to be missing the object, so spending time
>     double-checking the pack store wastes measurable time in real-world
>     cases

I took a look on "next" and it's true for these reasons in most cases
but not all.

QUICK implies SKIP_FETCH_OBJECT:

  fetch-pack.c: Run with fetch_if_missing=0 (from builtin/fetch.c,
  builtin/fetch-pack.c, or through a lazy fetch) so OK.
  
  builtin/index-pack.c: Run with fetch_if_missing=0, so OK.
  
  builtin/fetch.c: Run with fetch_if_missing=0, so OK.
  
  object-store.h, sha1-file.c: Definition and implementation of this
  flag.

Everything is OK here. Now, SKIP_FETCH_OBJECT implies QUICK:

  cache-tree.c: I added this recently in f981ec18cf ("cache-tree: do not
  lazy-fetch tentative tree", 2019-09-09). No problem with a false
  negative, since we know how to reconstruct the tree. OK.
  
  object-store.h, sha1-file.c: Definition and implementation of this
  flag.
  
  send-pack.c: This patch (which is already in "next"). If we have a
  false negative, we might accidentally send more than we need. But that
  is not too bad.
  
  promisor-remote.c: This is the slightly tricky one. We use this
  information to determine if we got our lazily-fetched object from the
  most recent lazy fetch, or if we should continue attempting to fetch the
  given object from other promisor remotes; so this information is
  important. However, adding QUICK doesn't lose us anything because the
  lack of QUICK only helps us when there is another process packing
  loose objects: if we got our object, our object will be in a pack
  (because of the way the fetch is implemented - in particular, we need
  a pack because we need the ".promisor" file).

So everything is OK except for promisor-remote.c, but even that is OK
for another reason.

Having said that, perhaps we should consider promisor-remote.c as
low-level code and expect it to know that objects are fetched into a
packfile (as opposed to loose objects), so it can safely use QUICK
(which is documented as checking packed after packed and loose). If no
one disagrees, I can make such a patch after jt/push-avoid-lazy-fetch is
merged to master (as is the plan, according to What's Cooking [1]).

[1] https://public-inbox.org/git/xmqq8sprhgzc.fsf@gitster-ct.c.googlers.com/
