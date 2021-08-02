Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E78C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 13:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 767BA61029
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 13:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbhHBNKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 09:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbhHBNKr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 09:10:47 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30EAC0613D5
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 06:10:37 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id o5so30842856ejy.2
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 06:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=qduNbZBr1FVQ8CTWWdRzbvvwUK4rSQBt5uRSenwe0zI=;
        b=XnUOcYzmloppnxrqZ4TYaCBqB7TiAdfnaGGM1lBzGzJU0mQpNuA0UwmsNoWEecSi+S
         XoLzL0shehyj3oI6Gygt4vseZMJqHleRoViAWZeAcJJ2yeMeAf7ts4fJsacAHwnLLFkN
         X6xlX0TVAgf3VvONqbF1Yg0okvhSo4KJLaJWoY2w46k7WYOlAPvdfTrU2WnIVCVM702v
         ENQjNl4bqqhO52Ye0+j30j7BsaMb0DWK8REA420s7tPOBy9BQsjv1C+aDIwXCc3MMD4Q
         Ebc64RORSZgDXZ+MndOlXt1ah25n+oH3OKJev3iqgGfYbNdcVop2Ldpesjzie+qgKexf
         EI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=qduNbZBr1FVQ8CTWWdRzbvvwUK4rSQBt5uRSenwe0zI=;
        b=E8gblD8b0tM4ZzkJNRCfgoXqU3+Iorf+ysRkt9ux7X2R+SyGecNCQuS4gfGKakKc1G
         Hqemnor2343bNjxDk61Ow/vpNf2P8rPD5e4wD5s1u5FrTP+7+eK+NiEyzvc4zf4Mpnxe
         BJaxnEZ4dp8EJgdcaBF5UCIuoH9ID8CQUgx0FXftJBSJeJCBKV34bJN0m+QNrdQfSwJY
         bj6jeQCCJTXOZ5Sfzgs4O/6/fZP/CmmTL/ZPf0c5oFOHMsDtJWEoM0EHcKU7LaKhmtGE
         BLXGcHH6jVItN8RjKoX36QC/2n9SNln/4snOv0e0FvASgnfswRuh0gaft+AjvbIQDbnW
         EbWw==
X-Gm-Message-State: AOAM530WzOGMLyNhIk9uv+tn56nVNhyhg4GoemsqZiVMH7vLPsmyk6QD
        gGs62R0P4LzoKzrNncut3UmWYSvYZ18=
X-Google-Smtp-Source: ABdhPJwMZ5O3gOqE4bbESwmFAah4eJfQClkUGfLiNORDccnU++FK32XGNUleyaFQmh3mH/pvucHTUg==
X-Received: by 2002:a17:906:b750:: with SMTP id fx16mr15339643ejb.108.1627909836024;
        Mon, 02 Aug 2021 06:10:36 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id nd14sm4421363ejc.113.2021.08.02.06.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 06:10:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ben Boeckel <mathstuf@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/1] config: support a default remote tracking setup
 upon branch creation
Date:   Mon, 02 Aug 2021 15:02:41 +0200
References: <20210728135041.501850-1-mathstuf@gmail.com>
 <20210729020125.746206-1-mathstuf@gmail.com>
 <20210729020125.746206-2-mathstuf@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210729020125.746206-2-mathstuf@gmail.com>
Message-ID: <87sfzsngad.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 28 2021, Ben Boeckel wrote:

> The `branch.autoSetupMerge` works well today for setting up tracking a
> local branch, but there is no easy mechanism to automatically set up a
> remote tracking situation for workflows which use a single set of
> branches for integration without specifying `--track` to every branch
> creation command or branching directly from the remote ref. This patch
> adds the following configuration values:
>
>   - `branch.defaultRemote`: initializes `branch.<name>.remote` if not
>     otherwise given;
>   - `branch.defaultMerge`: initializes `branch.<name>.merge` if not
>     otherwise given.

Not a new issue per-se, but what if you've got a branch called
defaultRemote? It seems to me that any new branch.<name>.* config closes
the door for a <name> we squat on.

Given that we have checkout.defaultRemote and this also affects
switch/checkout it seems better to continue in the checkout.* namespace
even if it wasn't for that, but given the config squatting issue
especially so....

For what it's worth I usually use the checkout.defaultRemote option
(which I added) and:

    git checkout master &&
    git branch -m master <topic-name>

See 8d7b558baeb (checkout & worktree: introduce checkout.defaultRemote,
2018-06-05). It seems to me from that patch diff that you could modify
some docs / tests for this, no? E.g. how it interacts with git-worktree.

I like this direction, but just have a concern that this is a place
where we need to consider all the UX in the area overall, and that any
options/config don't overtly interact in a bad way.
