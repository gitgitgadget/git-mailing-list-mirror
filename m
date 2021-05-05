Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB880C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 09:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E7A1613BA
	for <git@archiver.kernel.org>; Wed,  5 May 2021 09:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhEEJFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 05:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhEEJFy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 05:05:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E45C061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 02:04:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a4so1680843ejk.1
        for <git@vger.kernel.org>; Wed, 05 May 2021 02:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0DWtQ5qWmlNmKbtSmTuvftdXnhMpmptJILcQzyfGX8Y=;
        b=hHJg/DSYVkd+bddOh3Ytin2cyPR6kPm5phKtcVGATYPZo2zCTHNweW0lcDtmabo89h
         DfJijlpLQTny29zZjqzaYFT2UJGT6zWoregrMRM0eVHkZ3cvGVWfdIQBcpevIz9vmqxO
         qe+hrrk6rh5BGp8eSb8OE/WiJCkyZ0wzkdtrEHcyGaGv5Ujq0F6MmQVwElIok6wGsYdi
         VcRFTJym7vMWb1fjp5ju9pZBVQ/Fu29qTZ83Tm5FqzP2GJ4gmz4dlbaBBWFMyORE+veH
         r3VH9dnDPIe9itxBhVhmto9fhflt3f0htgEktkQ55YrOntVaniPqxGvkjQp9kHk8Jtz8
         WzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0DWtQ5qWmlNmKbtSmTuvftdXnhMpmptJILcQzyfGX8Y=;
        b=gp6OvDR+CfNuG5JtFrcFlebk9wuRMEIav/mZt0Prwi2ornKSfJom6FieFvquYU4Qmq
         2rLZsqNU6tbChEkAVFDD9g7SrvZ9tYSt1PsskzVgkyv69vf0VIvoFhHAqxa00840f/VA
         FJuoMaE4kqcLiF4O4Rr1m7NgZQZijx84hcfnl+zung8iyBSdCyW7zW0xvoINrAbFnokA
         K4ZM0XKreJnUd5MlHUFm0xaoU3K8Tvf546oUYG9FP4R6i+sPG4OS+WT/8DMco5MiV/fB
         51a4qMdzQAX7+qEuvYjCl6Z2E59Vkm1N0pgtvox3rGCjqaEdnDHbvQFzYl65o0PzfPd5
         JCKw==
X-Gm-Message-State: AOAM533xpVy01pagcK1U1oEFnbVtWVtmARAWwkXiuPmsYeDXJfaN8jbz
        VO1y9eATNuXpeycuB91Hd7TJKTHehSP5xMSf0uI=
X-Google-Smtp-Source: ABdhPJywulR5QgnNS8/6rPKdhPCnhoIKVsYqU3hrYWd+Bx1R4ZA8TeM63AVasRVtk/uya8qfR1p7b/dg4p8SSpTOSwQ=
X-Received: by 2002:a17:906:d7a2:: with SMTP id pk2mr26612620ejb.551.1620205496914;
 Wed, 05 May 2021 02:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210411095538.34129-1-mirucam@gmail.com> <20210411095538.34129-4-mirucam@gmail.com>
 <xmqqy2doftrj.fsf@gitster.g>
In-Reply-To: <xmqqy2doftrj.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 5 May 2021 11:04:45 +0200
Message-ID: <CAP8UFD3X24F3qgefHpi00PM-KUk+vcqxwy2Dbngbyj7ciavCVQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] bisect--helper: reimplement `bisect_run` shell
 function in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Miriam Rubio <mirucam@gmail.com>, git <git@vger.kernel.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 11, 2021 at 10:31 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Miriam Rubio <mirucam@gmail.com> writes:

> > +             temporary_stdout_fd = open(git_path_bisect_run(), O_CREAT | O_WRONLY | O_TRUNC, 0666);
> > +             saved_stdout = dup(1);
> > +             dup2(temporary_stdout_fd, 1);
> > +
> > +             res = bisect_state(terms, args.v, args.nr);
> > +
> > +             dup2(saved_stdout, 1);
> > +             close(saved_stdout);
> > +             close(temporary_stdout_fd);
>
> In v2, we just let bisect_state() to write to our standard output,
> which was the reason why the loss of "cat" in the "write to
> BISECT_RUN file and cat it to show to the user" in the scripted
> version in v2 was OK.  Now, we are writing out, just like the
> scripted version did, to BISECT_RUN, the user does not see its
> contents.
>
> Does the distinction matter?  Christian, what's your call on this?

Sorry for the late answer. I think the content of the BISECT_RUN file
should indeed be shown.

bisect_state() calls bisect_auto_next() which calls bisect_next()
which calls bisect_next_all(), and bisect_next_all() uses printf() to
show things like "XXX is the first bad commit" which should be shown
when using `git bisect run`.

Also when adding an "exit 1 &&" before "git bisect reset" at the end
of the `"git bisect run" simple case` test, with 'next' I get:

-----------------
$ ./t6030-bisect-porcelain.sh -i -v
...
expecting success of 6030.21 '"git bisect run" simple case':
       write_script test_script.sh <<-\EOF &&
       ! grep Another hello >/dev/null
       EOF
       git bisect start &&
       git bisect good $HASH1 &&
       git bisect bad $HASH4 &&
       git bisect run ./test_script.sh >my_bisect_log.txt &&
       grep "$HASH3 is the first bad commit" my_bisect_log.txt &&
       exit 1 &&
       git bisect reset

Bisecting: 0 revisions left to test after this (roughly 1 step)
[3de952f2416b6084f557ec417709eac740c6818c] Add <3: Another new day for
git> into <hello>.
3de952f2416b6084f557ec417709eac740c6818c is the first bad commit
FATAL: Unexpected exit with code 1
-----------------

and:

-----------------
$ cat trash\ directory.t6030-bisect-porcelain/.git/BISECT_RUN
3de952f2416b6084f557ec417709eac740c6818c is the first bad commit
commit 3de952f2416b6084f557ec417709eac740c6818c
Author: A U Thor <author@example.com>
Date:   Thu Apr 7 15:15:13 2005 -0700

   Add <3: Another new day for git> into <hello>.

hello | 1 +
1 file changed, 1 insertion(+)
-----------------

while with 'seen' I get:

-----------------
$ ./t6030-bisect-porcelain.sh -i -v
...
expecting success of 6030.21 '"git bisect run" simple case':
       write_script test_script.sh <<-\EOF &&
       ! grep Another hello >/dev/null
       EOF
       git bisect start &&
       git bisect good $HASH1 &&
       git bisect bad $HASH4 &&
       git bisect run ./test_script.sh >my_bisect_log.txt &&
       grep "$HASH3 is the first bad commit" my_bisect_log.txt &&
       exit 1 &&
       git bisect reset

Bisecting: 0 revisions left to test after this (roughly 1 step)
[3de952f2416b6084f557ec417709eac740c6818c] Add <3: Another new day for
git> into <hello>.
error: bisect run failed:'git bisect--helper --bisect-state good'
exited with error code -10
running  './test_script.sh'running
'./test_script.sh'3de952f2416b6084f557ec417709eac740c6818c is the
first bad commit
FATAL: Unexpected exit with code 1
-----------------

and:

-----------------
$ cat trash\ directory.t6030-bisect-porcelain/.git/BISECT_RUN
-----------------

So it looks like there might be another issue with what's in 'seen'.

> If it does not matter, then the code and tests are good as-is, but
> if it does, the fact that you posted this round without noticing any
> broken tests means that we have a gap in the test coverage.  Can we
> have a new test about this (i.e. at the end of each round in "bisect
> run", the output from bisect_state() is shown to the user)?

Definitely it seems that taking a look at the tests is a good idea.
For example, comparing the verbose (with -v) output of t6030 before
and after each patch (and before and after this patch series) might
help find issues.
