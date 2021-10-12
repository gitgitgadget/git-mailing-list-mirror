Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9D0C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 10:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4561360724
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 10:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbhJLKGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 06:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbhJLKGU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 06:06:20 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87EBC061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 03:04:18 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id p13so79635208edw.0
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 03:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:user-agent:message-id:mime-version
         :content-transfer-encoding;
        bh=R73b48gdKXTWCM4K2Vr76O17YawaMpRb/IC6osxK9co=;
        b=TdKrbCD6rXsp0Cb/zB8M1aHGZLx8oZ1ghZ+j+ELEvtdRtFoB90q6FHLVS5AoVB3FNY
         X8RN2I/LTp+bqqvrWjyYuBhqb6+oNmceMzXF+19xi41jV97jpGzl9NTczR55UM4uBc0M
         jHVYhEsOpRLfAydRJBex8YpOSexS530D1yBCUEh65oo/QWSsi79ZxKQbnP8N5iuOFnEM
         V2uLEfB0tfoeBp1awKwREFgV4nPeJ9jGHgOTxP9YemFBq93hEXZMi/CravLvFFwNCbB+
         qJSJEKddZmHqogN9O9d7lbe5riozfttc/PH9HnPdluX0ms2eJfJOu/zztScs8TclB1Dv
         uSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:user-agent:message-id
         :mime-version:content-transfer-encoding;
        bh=R73b48gdKXTWCM4K2Vr76O17YawaMpRb/IC6osxK9co=;
        b=azGY9buvEWoyau001T597u0V4vLhB6gyNQX5ep9yb7LiK9aWmF4ke9g8baieNb9H40
         gZCBd/Os09uZfiw81m7s46N4jUnTSNj7e5M9uEiPeHMAizfopecajZRLE+WUTpLguOaG
         L1loKudjZKzg4lWfwNaLZK8Rr5GBFgkoB2AA2/lbM4SXLqrDasawlLEl8w5EJxo96Xus
         Pk7ZFlKNekCEA41v82jt/JSKlBuMKV/z55mYjO3fgvl2iPscwTDeO12fF5d7MV2GdEO0
         uauwdHbE7RnJqIabDtkf1e7ct2h02OcHW+e2Grzpv+TTDJuIETwHUmwhGwqL5B2yC3Lg
         Dgcg==
X-Gm-Message-State: AOAM530qmGPTOiC1w1hnKb78vg+BHGmPihH+R1aY+dvhXsenT8CSTYc4
        tV8Biu+YdzPgagiZ9QSsj7U=
X-Google-Smtp-Source: ABdhPJyVejsY8l2WV4xLl2R1+0iz4fGhHo+tk9bxN8HiMM1yMMKHoDLqaDAZXv2fU0uGj0r0/qXERg==
X-Received: by 2002:a05:6402:1d04:: with SMTP id dg4mr49652152edb.183.1634033057266;
        Tue, 12 Oct 2021 03:04:17 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c11sm5712216edk.68.2021.10.12.03.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 03:04:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, David Turner <novalis@novalis.org>,
        Elijah Newren <newren@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: test-lib.sh musings: test_expect_failure considered harmful
Date:   Tue, 12 Oct 2021 11:23:40 +0200
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
Message-ID: <87tuhmk19c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 11 2021, Junio C Hamano wrote:

[Removed "In-reply-to: <xmqq5yu3b80j.fsf@gitster.g>" with the Subject
change]

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>  test_expect_success POSIXPERM,SANITY 'commit should notice unwritable r=
epository' '
>>  	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
>>  	chmod a-w .git/objects .git/objects/?? &&
>> -	test_must_fail git commit -m second
>> +
>> +	cat >expect <<-\EOF &&
>> +	error: insufficient permission for adding an object to repository data=
base .git/objects
>> +	error: insufficient permission for adding an object to repository data=
base .git/objects
>> +	error: Error building trees
>> +	EOF
>
> This is odd.  Shouldn't the test expect one message from write-tree
> and be marked as expecting a failure until the bug gets fixed?

Presumably with test_expect_failure.

I'll change it, in this case we'd end up with a test_expect_success at
the end, so it doesn't matter much & I don't care.

But FWIW $subject, or at least s/harmful/running with scissors/g :)

[CC'd some recent-ish users of test_expect_failure, and I'm no innocent
in that department :)]

In the Perl world (Test::More et al) the "#TODO" keyword we map
test_expect_failure to (and yeah, I know the latter pre-dates the
former...) doesn't generally lead to subtle breakages and mismatched
expectations, i.e. you do:

    TODO: {
        local $TODO =3D "not implemented yet";
        is($a, $b, "this is why this in particular fails");
    }

So you generally mark the *specific* thing that fails, as separate from
your test setup itself.

But our test-lib.sh API for it is the equivalent of marking an entire
logical test block and its setup as a TODO.

So the diff below "passes". But did we intend for the test_cmp to fail,
for the thing to segfault or hit a BUG?

Any of those conditions being hit will have the TODO test pass. So will
all of it succeeding.

=3D=3D=3D snip =3D=3D=3D
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index df544bb321f..15724e6a358 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -601,4 +601,13 @@ test_expect_success 'branch -m with the initial branch=
' '
 	test again =3D $(git -C rename-initial symbolic-ref --short HEAD)
 '
=20
+test_expect_failure 'do stuff' '
+	git config alias.fake-SEGV "!f() { echo Fake SEGV; exit 139; }; f" &&
+	git config alias.fake-BUG "!f() { echo Fake BUG; exit 99; }; f" &&
+
+	git fake-BUG >expect &&
+	git fake-SEGV >actual &&
+	test_cmp expect actual
+'
+
 test_done

=3D=3D=3D snip =3D=3D=3D

(Although for the "suceeding" case we'll print out a summary from
"prove", but unless you're carefully eyeballing that...).

So I think "test_expect_failure" should be avoided, the only useful way
of holding it which works in combination with other test-lib.sh features
that I've come up with is:

	test_expect_success 'setup flaky failure' '
		[multi-line test code that passes here] &&
		>setup-todo
	'

	if test -e setup-todo
	then
		test_expect_failure 'flaky failure due to XYZ' '
			test_cmp todo.expect todo.actual
		'
	fi

I.e.:

 * Don't say that the failure of your passing test setup is OK too.
 * In doing that don't break --run=3DN, so that "test -e setup-todo" test
   (or equivalent) is needed, in case the "setup" is skipped.
 * Have *just* the "test_cmp" (or other specific failure test) in the
   "test_expect_failure"

But it's only useful if you can't make that a "! test_cmp" (or rather, a
more specific positive & passing "test_cmp".

I.e. it's flaky, or the output/end state is otherwise unknown (but we
expect it to be once bugs are fixed).

We have ~150 uses of test_expect_failure in the test suite, I'm pretty
sure that <20 of them at most are "correct" under the above
criteria. E.g. this is ok-ish:
=20=20=20=20
    t7815-grep-binary.sh-# This test actually passes on platforms where reg=
exec() supports the
    t7815-grep-binary.sh-# flag REG_STARTEND.
    t7815-grep-binary.sh-test_expect_success 'git grep ile a' '
    t7815-grep-binary.sh-   git grep ile a
    t7815-grep-binary.sh-'

Although in that case we should make it a test_expect_success if we can
get a "REG_STARTEND" build flag exported to the test suite. Skimming the
grep hits *maybe* some of the ones in "t9602-cvsimport-branches-tags.sh"
(I haven't looked carefully).

But most of them I Consider Harmful, i.e. they're a bunch of setup code
that could be hiding an unexpected bug/segfault. Running into that with
some past WIP work (a thing I considered to "just fail a test_cmp"
started segfaulting) is why I try to avoid it.
