Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A21C6FA99
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 17:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCLRQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 13:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCLRQV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 13:16:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C231D2CFDE
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 10:16:19 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x11so10545163pln.12
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 10:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678641379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMeatP+vrR/FmedXermhTp1WQyb/F35qlrbV3RIc+y4=;
        b=JITyeAMRwOsxipxpiud3RRIBXtZw8R0X62fDReyYJT0ixppWCNZ9489/ZnNXZHLdOh
         8/moqMjW0Oz/2Ywirj+bprE7z80//5/k4gco02DBPg+r6xPjczHQqlxLecbMg6FE7qZE
         6TC2+Kgw6MTw7hrbsQ5cO+ekONGG/b8PneCnpujwjmzbySdwH8B20IFXWGyQWrGrFBlf
         u2LkhxFqd/MHKDdKAs7i1iW0MhMKbZ9vbrhDpnci3lB4iFguq9pVTT6Vsi3hb7SKW1r5
         +UXzr1zoUMCGVZx/kK41YBN4eCiMtPJVwlaKVm1Qiws4bIAs9N1ZvJwSlomPxJmaeoYc
         pMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678641379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMeatP+vrR/FmedXermhTp1WQyb/F35qlrbV3RIc+y4=;
        b=i2PqPl5KjmngnobiEz041iWKBA0HYBK1TBauUCmBtUHNNcoPkYrRoBx9GB8b/u6vQJ
         VB/GwjGzt9gxkVd9ob+dBAfs4o+6Tqwl2UvkwbnPj+IzfNrd3HQjk861yOlSJXYyCu2Y
         3IwnqFsHPYA3X80Cm4hRDri7J7wZP2C/n8kKxMAaeV9impMGaGFKG6hEtnCMphB88BRY
         iFSqmlXiXsfblDYDm4mMeSQ58oh5+K9lPq4upbWB29uRsby7NJiSYKAaAERTS7LxOISF
         WLXIeKciWT6Sdns8ZM331LY3gO0dlNn9GcxJrrQ4cN2XZKTRgYD+aG21hxVbr1vewwKm
         Qzzw==
X-Gm-Message-State: AO0yUKXhaDPSTRzq7zevfQiIe5GR0uKDFoOTkZsieJ9OQyUO9SlHyKg6
        wRpPubGhmUmhQ2xSWB5cqtg=
X-Google-Smtp-Source: AK7set+hSsn7G5yka1xBFnmLO5xEr3uxoxY/hGb5CS4xBEnpzCWItXeNkddGHlSVWAdmS02y/GWZMw==
X-Received: by 2002:a17:902:f693:b0:19d:5fd:11fb with SMTP id l19-20020a170902f69300b0019d05fd11fbmr38202400plg.23.1678641379068;
        Sun, 12 Mar 2023 10:16:19 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.148.22])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902a9c800b0019f29cfcae7sm2504563plr.195.2023.03.12.10.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:16:18 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH v2] index-pack: remove fetch_if_missing=0
Date:   Sun, 12 Mar 2023 22:46:13 +0530
Message-Id: <20230312171613.6968-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <xmqqttys4746.fsf@gitster.g>
References: <xmqqttys4746.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 11 Mar 2023 at 03:11, Junio C Hamano <gitster@pobox.com> wrote:
>
> I admit I haven't thought about it any longer than anybody who
> touched this topic, but should "fetch_if_missing=0" really be
> treated as "it was a dirty hack in the past, now we do not need it,
> as all callers into the object layer avoids lazy fetching when they
> do not have to, so let's remove it"?  It looks to me more and more
> that the old world-view to disable lazy fetching by default and have
> individual calls to the object layer opt into fetching as needed may
> give us a better resulting code, or is it just me?

I think having a single function to check for object existence, which is
compatible with partial clones is better, because the end goal is to
completely integrate the concept of partial clones with git's codebase
and not have code that worries "Oh, there maybe bugs here because
what if the user has a partial clone", everytime the code does an object
existence check (that is, a call to has_object_file() or any of its
related functions) and just have fetch_if_missing set to 1 or 0, according
to the particular command.

It is also true that has_object() is not that "single function", because
in cases where we are missing an object in partial clone and want it,
has_object() has no way of fetching it. With or without flags (it only
supports one flag which, when set, rechecks packed storage), it does not
lazy-fetch in a partial clone. But there are cases where we need such
objects, such as the commands that come into "family (b)" [1].

So, why not use oid_object_info_extended() directly, instead of wrapping
it with some other function, whenever we are checking for an object's
existence. We can skip lazy-fetches whenever we want with
OBJECT_INFO_SKIP_FETCH_OBJECT and can also prefetch with
OBJECT_INFO_FOR_PREFETCH [2].

[1] https://lore.kernel.org/git/20230311025906.4170554-1-jonathantanmy@google.com/

[2] pack-index itself is one example of where this is done.

    When we don't have REF_DELTA bases, we bulk prefetch them

	    if (has_promisor_remote()) {
                     /*
                      * Prefetch the delta bases.
                      */
                     struct oid_array to_fetch = OID_ARRAY_INIT;
		     for (i = 0; i < nr_ref_deltas; i++) {
                             struct ref_delta_entry *d = sorted_by_pos[i];
                             if (!oid_object_info_extended(the_repository, &d->oid,
                                                           NULL,
                                                           OBJECT_INFO_FOR_PREFETCH))
                                     continue;
                             oid_array_append(&to_fetch, &d->oid);
                     }
                     promisor_remote_get_direct(the_repository,
                                                to_fetch.oid, to_fetch.nr);
                     oid_array_clear(&to_fetch);
             }

    Instead of going object-by-object, which is basically like an
    infinite loop in large repos and partial clones are widely used
    in large repos.
