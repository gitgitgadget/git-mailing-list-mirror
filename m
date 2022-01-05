Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E371C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 17:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242286AbiAERaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242235AbiAER3t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 12:29:49 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6C0C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 09:29:48 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id j21so164800527edt.9
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 09:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IUfw+Ix9kOOTDpokzRdeq9QhzlJl+xmNgjsb7pe9NoY=;
        b=NjFH2+yngW5BN9M/XiFZGdBelzc/pkuHQmkqXuayL/3IBRBl7hAMeHQ1Q2aJvm7qJC
         qEjTKiHsHuDoyJpIp81nUV6JuBjgw9QYBw4IeF4l0LGkkFwxAyn0J+JhTKo61iT9s+4w
         6EAQXhJXWvKQAOMurih3vrkL/IagV4NeWmBdAFY1vhZEHzNG0rn5JBDNvE5VjPrMGxpl
         As/b4q+9pbaeKiSCgHkHptDH/ufFlFwQN43MlDRaiTCqB1m2rSTqKUx13mqz20QVujDu
         THYN8FtbfuA2z1s/LbCd+RacNa+NM4BdfBuvSIhD9N+YpQNM1ffe1xFOS+ibzE4iGPZm
         gmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUfw+Ix9kOOTDpokzRdeq9QhzlJl+xmNgjsb7pe9NoY=;
        b=XL051IxWqKSlsY1Er7dtAQbfyut9q1dciwSmsFP4jwm9iH+7iqbiVRKV8T/tS3FzpS
         DPy6JcEeDygIjD+yiL2eJjZ4Hq4iNJIjql64dEIRmWTXsyiZyqwT6XaONAjYMqFkvw9/
         jVBAS1BMtCOiyHgZb5tTd6FHKXQGjPp8aS8DfYXRmU9d63nQ1y+YzK3H673/boGm0sCG
         3KGFcHzySRPmIiVQNc30VFlSb2rqlNDtQhm3XcUEAMq0BpXwMSEi5HHjcu+yqdUo8B/C
         0PU7vES5Oix2pHHnfGXFEAAqGm+pYNWjFaFPYKRuvE7xcIT+zh2ZkFr21Y3HkAhpxCg8
         KBzw==
X-Gm-Message-State: AOAM530+V2kjw8/1ZdtZ5vOeJTYDDUMTJxyWLcwpMUqIRvroLDm+Mb6a
        Ar8RbfaUrzN00jEgrGfKwjOwxqqziABE0hTC1xs=
X-Google-Smtp-Source: ABdhPJxXARRnqzxMwxkih7QySnb/nunwJvw+d+9bBBbV2fN4WWqy2sG6y8EdsO6i7P1OU9v/MfgS+0+++vK6wWpTVGs=
X-Received: by 2002:a50:da48:: with SMTP id a8mr52494552edk.146.1641403786694;
 Wed, 05 Jan 2022 09:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20220105163324.73369-1-chriscool@tuxfamily.org> <20220105163324.73369-3-chriscool@tuxfamily.org>
In-Reply-To: <20220105163324.73369-3-chriscool@tuxfamily.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 5 Jan 2022 09:29:35 -0800
Message-ID: <CABPp-BFGh=aNbtz7PDfH+JK13Hazb+EggLy8XDWqu0wAP=hmuw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] merge-ort: add t/t4310-merge-tree-ort.sh
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 5, 2022 at 8:33 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> This adds a few tests for the new merge-tree-ort command. They have
> been copy-pasted from t4300-merge-tree.sh, and then the expected
> output has been adjusted.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t4310-merge-tree-ort.sh | 162 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 162 insertions(+)
>  create mode 100755 t/t4310-merge-tree-ort.sh
>
> diff --git a/t/t4310-merge-tree-ort.sh b/t/t4310-merge-tree-ort.sh
> new file mode 100755
> index 0000000000..9a54508e82
> --- /dev/null
> +++ b/t/t4310-merge-tree-ort.sh
> @@ -0,0 +1,162 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2010 Will Palmer
> +# Copyright (c) 2021 Christian Couder
> +#
> +
> +test_description='git merge-tree-ort'
> +
> +TEST_PASSES_SANITIZE_LEAK=true
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +       test_commit "initial" "initial-file" "initial"
> +'
> +
> +test_expect_success 'file add A, !B' '
> +       git reset --hard initial &&
> +       test_commit "add-a-not-b" "ONE" "AAA" &&
> +       git merge-tree-ort initial initial add-a-not-b >actual &&
> +       cat >expected <<EXPECTED &&
> +result tree: ee38e20a5c0e1698539ac99d55616079a04fce26

So the tests only work on sha1?  My tests in
https://lore.kernel.org/git/pull.1114.git.git.1640927044.gitgitgadget@gmail.com/
are sha256 compatible.

> +clean: 1
> +diff with branch1:
> +:000000 100644 0000000 43d5a8e A       ONE
> +
> +diff --git a/ONE b/ONE
> +new file mode 100644
> +index 0000000..43d5a8e
> +--- /dev/null
> ++++ b/ONE
> +@@ -0,0 +1 @@
> ++AAA

Oh, this isn't just a --raw diff, but both a raw and full diff?  I
missed that reading over the previous patch.  This seems potentially
*extremely* expensive for big repos; dramatically more so than the
merge portion of the operation.  (Any files modified on just one side
can be trivially merged without looking at the contents.  In fact,
directories only modified on one side can usually be trivially merged
without looking at the contents.  But merges are going to modify lots
of files relative to either of the two sides and especially relative
to the merge base, and doing a full diff is going to have to crack
open every one of those files -- multiple times since you do it
against the base as well -- to show this output).  I don't think this
is what you want.

> +diff with branch2:
> +diff with base:
> +:000000 100644 0000000 43d5a8e A       ONE
> +
> +diff --git a/ONE b/ONE
> +new file mode 100644
> +index 0000000..43d5a8e
> +--- /dev/null
> ++++ b/ONE
> +@@ -0,0 +1 @@
> ++AAA
> +EXPECTED
> +
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'file add !A, B' '
> +       git reset --hard initial &&
> +       test_commit "add-not-a-b" "ONE" "AAA" &&
> +       git merge-tree-ort initial add-not-a-b initial >actual &&
> +       cat >expected <<EXPECTED &&
> +result tree: ee38e20a5c0e1698539ac99d55616079a04fce26
> +clean: 1
> +diff with branch1:
> +diff with branch2:
> +:000000 100644 0000000 43d5a8e A       ONE
> +
> +diff --git a/ONE b/ONE
> +new file mode 100644
> +index 0000000..43d5a8e
> +--- /dev/null
> ++++ b/ONE
> +@@ -0,0 +1 @@
> ++AAA
> +diff with base:
> +:000000 100644 0000000 43d5a8e A       ONE
> +
> +diff --git a/ONE b/ONE
> +new file mode 100644
> +index 0000000..43d5a8e
> +--- /dev/null
> ++++ b/ONE
> +@@ -0,0 +1 @@
> ++AAA
> +EXPECTED
> +
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'file add A, B (same)' '
> +       git reset --hard initial &&
> +       test_commit "add-a-b-same-A" "ONE" "AAA" &&
> +       git reset --hard initial &&
> +       test_commit "add-a-b-same-B" "ONE" "AAA" &&
> +       git merge-tree-ort initial add-a-b-same-A add-a-b-same-B >actual &&
> +       cat >expected <<EXPECTED &&
> +result tree: ee38e20a5c0e1698539ac99d55616079a04fce26
> +clean: 1
> +diff with branch1:
> +diff with branch2:
> +diff with base:
> +:000000 100644 0000000 43d5a8e A       ONE
> +
> +diff --git a/ONE b/ONE
> +new file mode 100644
> +index 0000000..43d5a8e
> +--- /dev/null
> ++++ b/ONE
> +@@ -0,0 +1 @@
> ++AAA
> +EXPECTED
> +
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'file add A, B (different)' '
> +       git reset --hard initial &&
> +       test_commit "add-a-b-diff-A" "ONE" "AAA" &&
> +       git reset --hard initial &&
> +       test_commit "add-a-b-diff-B" "ONE" "BBB" &&
> +       git merge-tree-ort initial add-a-b-diff-A add-a-b-diff-B >actual &&
> +       cat >expected <<EXPECTED &&
> +result tree: 3aa938e8cc8be73c81cbaf629ea55a16e7c39319
> +clean: 0
> +diff with branch1:
> +:100644 100644 43d5a8e 1e462bc M       ONE
> +
> +diff --git a/ONE b/ONE
> +index 43d5a8e..1e462bc 100644
> +--- a/ONE
> ++++ b/ONE
> +@@ -1 +1,5 @@
> ++<<<<<<< add-a-b-diff-A
> + AAA
> ++=======
> ++BBB
> ++>>>>>>> add-a-b-diff-B
> +diff with branch2:
> +:100644 100644 ba62923 1e462bc M       ONE
> +
> +diff --git a/ONE b/ONE
> +index ba62923..1e462bc 100644
> +--- a/ONE
> ++++ b/ONE
> +@@ -1 +1,5 @@
> ++<<<<<<< add-a-b-diff-A
> ++AAA
> ++=======
> + BBB
> ++>>>>>>> add-a-b-diff-B
> +diff with base:
> +:000000 100644 0000000 1e462bc A       ONE
> +
> +diff --git a/ONE b/ONE
> +new file mode 100644
> +index 0000000..1e462bc
> +--- /dev/null
> ++++ b/ONE
> +@@ -0,0 +1,5 @@
> ++<<<<<<< add-a-b-diff-A
> ++AAA
> ++=======
> ++BBB
> ++>>>>>>> add-a-b-diff-B
> +EXPECTED
> +
> +       test_cmp expected actual
> +'
> +
> +test_done
> --

I've focused a bit on the things that I didn't care as much for, but
the usage of the merge-ort API was solid and there are pieces here
that look quite simliar to what I'd expect...and in fact, to what I
also implemented.  Perhaps there are multiple things I also overlooked
in my implementation of this idea; would be great to get your comments
on that, over at [1].

And, as a heads up, as noted at [2], I'm also working on the
server-side cherry-pick/rebase.


[1] https://lore.kernel.org/git/pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/CABPp-BHpK8hPsiuHoYsf5D_rjcGLSW-_faL3ODoh56pG_2Luwg@mail.gmail.com/
