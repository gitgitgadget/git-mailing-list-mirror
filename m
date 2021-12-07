Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C40C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 19:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240992AbhLGT4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 14:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240840AbhLGT4f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 14:56:35 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B9CC061746
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 11:53:03 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w1so313877edc.6
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 11:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=pO4/Ytw3ijU6wx16owrfLwWKjg6Dc7r3b+0As70r3UQ=;
        b=htUIMf8S5ADeWAAszjn8K3rxK8P/7afriEd1OrVqAi0p2/DcEsCK9VsIi8o6A9+beJ
         Xd57/qSKP96R21UrUH7S4tIzH7xXrUEzkWXMELJAkisu1XPdi1dtN3E91xmGORDF+hJm
         dhWSlaE9xsSaGfK018MS08pWLRjuB8HEq1OD+ICf0oG5QFM92KZB/Vz59gBMhVRiHk1J
         ZcBFRZL4zD0bQfkUsJh8h8IkVvEIccQWOgFJ+YTBV94sqYK3QUI/QlDZbw2eDIHhCArN
         E3DqVSaEUDTCKkSpBkcmDMtiQIzKQc1pdWs9KDebhqy71G6zco8wHDhpSjP+j6j+0P9i
         7d4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=pO4/Ytw3ijU6wx16owrfLwWKjg6Dc7r3b+0As70r3UQ=;
        b=PMTNtOY4klYCnJrmeR+nTLgvUt2MYjnB1QbijTo4PUSx9xUhcwEha/KA4PD7qPdx/H
         DeFan4RqAAPjnpRPymqxSj7jfboud+/q4MngOrq+j0d2zUVxVFCHjIE+js2XXF0/stjH
         wDgGIC28YngPW6WkettMe88kQv4EabGyapL2Tl5CBcxE0eLp22tAI7qqcEWMT/p7B8l8
         GRJGXqPLItWYF/t3GANMP1baO129O56ArABxePv1Fck1BE3ZPctTpYQ9q+BIPDc+Xtuj
         j6MGmCJ4ggsHrDTEXS7nKdQBEUAQ2G03zQQrRO0mlEjRz9RDZ24EfAdil4CSYNmpdYgu
         sqoA==
X-Gm-Message-State: AOAM53252G/szhKYIZBo96k6LzQLUOXi1YXXQBM2uEJPHHBRgcjnAW7R
        Bcb4W+HBqYktoaRnelNRKFCeBgwudhVvjw==
X-Google-Smtp-Source: ABdhPJzGYGeIZWqbvB8i5CqziF9eY5xXTBordQS8HOspIe7DrK2Y5cbXViG4H6ZOX1wIDokgWirSUg==
X-Received: by 2002:a05:6402:520e:: with SMTP id s14mr11962331edd.213.1638906782233;
        Tue, 07 Dec 2021 11:53:02 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sg17sm284649ejc.72.2021.12.07.11.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 11:53:01 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mugWL-001I2f-68;
        Tue, 07 Dec 2021 20:53:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Clemens Fruhwirth <clemens@endorphin.org>
Subject: cf/fetch-set-upstream-while-detached (was: What's cooking in
 git.git (Dec 2021, #01; Fri, 3))
Date:   Tue, 07 Dec 2021 20:37:47 +0100
References: <xmqqh7bpqhf0.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqh7bpqhf0.fsf@gitster.g>
Message-ID: <211207.86pmq8mbtu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 03 2021, Junio C Hamano wrote:

> * cf/fetch-set-upstream-while-detached (2021-07-06) 1 commit
>  - fetch: fix segfault on --set-upstream while on a detached HEAD
>
>  "git fetch --set-upstream" while on detached HEAD segfaulted
>  instead of noticing that such an operation did not make sense.
>
>  Expecting a reroll.
>  A low hanging fruit to make this usable is an addition of a few tests;
>  any takers?
>  cf. <CAPig+cTRXTGe-MNTy=2gk1eX8G+0fa303nrLnEtX1uHUC2usmg@mail.gmail.com>
>  cf. <xmqqsg0ri5mq.fsf@gitster.g>
>  source: <20210706162238.575988-1-clemens@endorphin.org>

Yes, you can pick my [1] which solves the same issue, but has tests
(which I came up with independently, didn't notice the earlier fix due
to a broken In-Reply-To chain with that fix).

To refresh your memory (I had to refresh mine) you had the comment that
we shouldn't fix the segfault without also making that exit with
non-zero instead of warning().

I don't disagree, but if you read t/t5553-set-upstream.sh you'll see
that's how we do it now.

So i'd think that any proposed behavior change there should come
independent of a narrow segfault fix, let's fix that, and then change
how "fetch --set-upstream-to" works in general.

In any case, per your comment above there's no mention of the
s/warning/die/g, just that it needs tests. If that's all that's needed
you can just pick up [1].

You can even pick that [1] and combine it with
cf/fetch-set-upstream-while-detached and it'll pass the tests the former
adds if they're fixed up[2] to grep for the difference in the warning
text.

I think the warning I added is a bit better, but I really don't care. As
long as we finally fix this segfault we can tweak that wording, or
whether we use warning() or die() etc. as a folllow-up.

1. https://lore.kernel.org/git/patch-v4-1.1-0caa9a89a86-20210831T135212Z-avarab@gmail.com/
2.

diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
index 48050162c27..631bd5a9366 100755
--- a/t/t5553-set-upstream.sh
+++ b/t/t5553-set-upstream.sh
@@ -95,7 +95,7 @@ test_expect_success 'fetch --set-upstream with a detached HEAD' '
 	git checkout HEAD^0 &&
 	test_when_finished "git checkout -" &&
 	cat >expect <<-\EOF &&
-	warning: could not set upstream of HEAD to '"'"'main'"'"' from '"'"'upstream'"'"' when it does not point to any branch.
+	warning: not on a branch to use --set-upstream with
 	EOF
 	git fetch --set-upstream upstream main 2>actual.raw &&
 	grep ^warning: actual.raw >actual &&
@@ -193,7 +193,7 @@ test_expect_success 'pull --set-upstream with a detached HEAD' '
 	git checkout HEAD^0 &&
 	test_when_finished "git checkout -" &&
 	cat >expect <<-\EOF &&
-	warning: could not set upstream of HEAD to '"'"'main'"'"' from '"'"'upstream'"'"' when it does not point to any branch.
+	warning: not on a branch to use --set-upstream with
 	EOF
 	git pull --no-rebase --set-upstream upstream main 2>actual.raw &&
 	grep ^warning: actual.raw >actual &&
