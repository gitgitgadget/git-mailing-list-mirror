Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A01EB1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 06:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbeKZRDv (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 12:03:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52531 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKZRDv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 12:03:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B5FF10E6DB;
        Mon, 26 Nov 2018 01:10:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2+uOoRxHUGMU
        zeBymYLiLcetJY4=; b=NDBHGI3QZ3o5qyAxs02NMfqFu4O5YXTZ6XVQuh6rsBMo
        Ep/dlnhV3lHuRy2EtDaetj80dt7vVjOYL6ZZrZ82hhNYXxmQkvAIDpphl9Rg24z2
        mBTh9U/SVCRcadizYHaqsXg4twdpW3xMoc3T0D/FOE2Clfbj8FPXScBFjTyu2nM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tk5h/4
        4g4f5BIUFyDpWMXTx4fxjOx1Irle8eYvnfHYSMKIjQgYmjmC8R0Y9LbMNvIE2MxF
        3vNFrVeOUgmsJjhuxCuVBKK5opqnB7XbVzIbNi7oHMQUqdHq6oagsDwYJtgLwJEp
        WbRYezTEyZanjYjUez2/W/nyk/uOObE8zhxa4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4479710E6DA;
        Mon, 26 Nov 2018 01:10:47 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B77F610E6D9;
        Mon, 26 Nov 2018 01:10:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase: mark the C reimplementation as an experimental opt-in feature
 (was Re: [ANNOUNCE] Git v2.20.0-rc1)
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com>
        <87y39w1wc2.fsf@evledraar.gmail.com>
        <877eh219ih.fsf@evledraar.gmail.com>
        <xmqq36rq2cp0.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 26 Nov 2018 15:10:45 +0900
In-Reply-To: <xmqq36rq2cp0.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 25 Nov 2018 10:00:43 +0900")
Message-ID: <xmqq36roz7ve.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 03BC61FC-F142-11E8-B208-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>>  * "git rebase" and "git rebase -i" have been reimplemented in C.
>>
>> Here's another regression in the C version (and rc1),...
>> I wasn't trying to stress test rebase. I was just wanting to rebase a
>> history I was about to force-push after cleaning it up, hardly an
>> obscure use-case. So [repeat last transmission in
>> https://public-inbox.org/git/87y39w1wc2.fsf@evledraar.gmail.com/ ]
>
> which, to those who are reading from sidelines:
>
>     Given that we're still finding regressions bugs in the rebase-in-C
>     version should we be considering reverting 5541bd5b8f ("rebase: def=
ault
>     to using the builtin rebase", 2018-08-08)?
>
>     I love the feature, but fear that the current list of known regress=
ions
>     serve as a canary for a larger list which we'd discover if we held =
off
>     for another major release (and would re-enable rebase.useBuiltin=3D=
true in
>     master right after 2.20 is out the door).
>
> I am fine with the proposed flip, but I'll have to see the extent of
> damage this late in the game so that I won't miss anything.  In
> addition to the one-liner below, we'd need to update the quoted
> release notes entry, and possibly adjust some tests (even though the
> "reimplementation" ought to be bug-to-bug compatible, it may not be).

So, in a more concrete form, what you want to see is something like
this in -rc2 and later?

-- >8 --
Subject: [PATCH] rebase: mark the C reimplementation as an experimental o=
pt-in feature

It turns out to be a bit too early to unleash the reimplementation
to the general public.  Let's rewrite some documentation and make it
an opt-in feature.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/rebase.txt | 16 ++++++----------
 builtin/rebase.c                |  2 +-
 t/README                        |  4 ++--
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebas=
e.txt
index f079bf6b7e..af12623151 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -1,16 +1,12 @@
 rebase.useBuiltin::
-	Set to `false` to use the legacy shellscript implementation of
-	linkgit:git-rebase[1]. Is `true` by default, which means use
-	the built-in rewrite of it in C.
+	Set to `true` to use the experimental reimplementation of
+	linkgit:git-rebase[1] in C.  Defaults to `false`.
 +
 The C rewrite is first included with Git version 2.20. This option
-serves an an escape hatch to re-enable the legacy version in case any
-bugs are found in the rewrite. This option and the shellscript version
-of linkgit:git-rebase[1] will be removed in some future release.
-+
-If you find some reason to set this option to `false` other than
-one-off testing you should report the behavior difference as a bug in
-git.
+allows early adopters to opt into the experimental version to find
+bugs in the rewritten version. This option and the shellscript version
+of linkgit:git-rebase[1] will be removed in some future release once
+the reimplementation becomes more stable.
=20
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5b3e5baec8..19ad97b177 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -59,7 +59,7 @@ static int use_builtin_rebase(void)
 	cp.git_cmd =3D 1;
 	if (capture_command(&cp, &out, 6)) {
 		strbuf_release(&out);
-		return 1;
+		return 0;
 	}
=20
 	strbuf_trim(&out);
diff --git a/t/README b/t/README
index 28711cc508..7e925e5fea 100644
--- a/t/README
+++ b/t/README
@@ -345,8 +345,8 @@ for the index version specified.  Can be set to any v=
alid version
 GIT_TEST_PRELOAD_INDEX=3D<boolean> exercises the preload-index code path
 by overriding the minimum number of cache entries required per thread.
=20
-GIT_TEST_REBASE_USE_BUILTIN=3D<boolean>, when false, disables the
-builtin version of git-rebase. See 'rebase.useBuiltin' in
+GIT_TEST_REBASE_USE_BUILTIN=3D<boolean>, when true, forces the use of
+builtin version of git-rebase in the test. See 'rebase.useBuiltin' in
 git-config(1).
=20
 GIT_TEST_INDEX_THREADS=3D<n> enables exercising the multi-threaded loadi=
ng
--=20
2.20.0-rc1




