Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67CDC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 23:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243664AbiBWXzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 18:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbiBWXz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 18:55:29 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C5249272
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:55:00 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id d10so708915eje.10
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=oEH+IhdzWJxcweUx7XY2Jbfi/Kp/tKmybwciZsLemJA=;
        b=f3k0iyMx5XpkIg3BtlNaNxC9z7L0HWUJmqOZhnME3Y8H/mxEkM9B6DV4lsZ9wd05EM
         0z78UPdouFDQ+fV07LUpB/U9VmajJQf1qd07FCFT0+lHPeUSly9PGmif14YOgmer3iGv
         aFYtde8b5sPw0ynP9GsdyOLSseTwHHJADNtGxLtKedV4xvvfPZgIK8ZaxT0TQcRjVKTX
         SyWWP6ikwJLZ8IOgOryGAmiAZw7t4csXz1/xKgUlzkD6YdMLf35/Qd/5DmXtU6IBZ+gr
         kW/tt1zSfdlCt/sdBAZazk/NVvOyU0R3WLp8kyEQ2Bwsd4JwhcEzVbz8yZUgRTv+hiL4
         qM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=oEH+IhdzWJxcweUx7XY2Jbfi/Kp/tKmybwciZsLemJA=;
        b=3FhmIi0dcU9lPUsQVgdTCvXJeTZvyiAgynY45QWeBCrJ1Vt1r92aPMfMQl6BIxrm+8
         lhpIHwFsGsvODP3KB8w/4fdatbhohfdvlIttfm82PweVc+QsA1tQ5tINJTePxpfvnj4N
         /AIig9oWceS8wF2cyBmrrUQwTrEFdTGrEKvoSpxDl8WkNBGgVH51fNc5kMrzC40zTb8r
         2DjTcBNNwEYFhfViUCH/nxiGB1p+84tCtv/6RYWCyMRyLYvwwV7GcMyk1I+St8v2mZCx
         FUceFAAbkGvt7GO5acSw0Aw9YWp8mAZZB3wlJcVeau3ErNTvtL33Gd7ujUR/xxYDUN7B
         o/cg==
X-Gm-Message-State: AOAM531irTALwRObvOTYOOn9nVJG1nd7hu7104bPJYZYCAo0m+jg8hdc
        Drt1sgKHK1pHrjCSnRlvi00=
X-Google-Smtp-Source: ABdhPJw72xL8fYiThiA0736ReYIOYHLDtWnxgNIZQ4lJYew83ph6XY8+VHiAXW4bD5tkP58krjhI5g==
X-Received: by 2002:a17:906:f9d9:b0:6d0:9f1c:d676 with SMTP id lj25-20020a170906f9d900b006d09f1cd676mr104324ejb.584.1645660498770;
        Wed, 23 Feb 2022 15:54:58 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d21sm473916eja.15.2022.02.23.15.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 15:54:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nN1TF-0007I4-AH;
        Thu, 24 Feb 2022 00:54:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai <johncai86@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 1/3] stash: add test to ensure reflog --rewrite
 --updatref behavior
Date:   Thu, 24 Feb 2022 00:27:51 +0100
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
 <6e136b62ca4588cc58f2cb59b635eeaf14e6e20d.1645554652.git.gitgitgadget@gmail.com>
 <220223.864k4q6jpr.gmgdl@evledraar.gmail.com> <xmqqbkyxqjrq.fsf@gitster.g>
 <272D2409-1CAE-4203-96F7-9B104F7E5D4D@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <272D2409-1CAE-4203-96F7-9B104F7E5D4D@gmail.com>
Message-ID: <220224.868ru1b0ku.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, John Cai wrote:

> Hi Junio,
>
> On 23 Feb 2022, at 17:51, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>>> +test_expect_success 'drop stash reflog updates refs/stash' '
>>>> +	git reset --hard &&
>>>> +	git rev-parse refs/stash >expect &&
>>>> +	echo 9 >file &&
>>>> +	git stash &&
>>>> +	git stash drop stash@{0} &&
>>>> +	git rev-parse refs/stash >actual &&
>>>> +	test_cmp expect actual
>>>> +'
>>>
>>> This one will be portable to the reftable backend.
>>>
>>>> +test_expect_success 'drop stash reflog updates refs/stash with rewrit=
e' '
>>>
>>> But as I noted in <220222.86fsob88h7.gmgdl@evledraar.gmail.com> (but it
>>> was easy to miss) this test will need to depend on REFFILES. So just
>>> changing this line to:
>>>
>>>     test_expect_success REFFILES 'drop stash[...]'
>>>
>>>> +	git reset --hard &&
>>>> +	echo 9 >file &&
>>>> +	git stash &&
>>>> +	oid=3D"$(git rev-parse stash@{0})" &&
>>>> +	git stash drop stash@{1} &&
>>>> +	cut -d" " -f1-2 .git/logs/refs/stash >actual &&
>>>> +	cat >expect <<-EOF &&
>>>> +	$(test_oid zero) $oid
>>>> +	EOF
>>>> +	test_cmp expect actual
>>>> +'
>>
>> Why should this be tested with "cut" in the first place, though?
>>
>> If we start from
>>
>>     stash@{0} =3D A
>>     stash@{1} =3D B
>>     stash@{2} =3D C
>>
>> and after saying "drop stash@{1}", what we need to check is that
>>
>>     stash@{0} =3D A
>>     stash@{1} =3D C
>
> Yes, this is true but that doesn't seem to test the --rewrite functionali=
ty.
> I could be missing something, but it seems that the reflog --rewrite opti=
on
> will write the LHS old oid value in the .git/logs/refs/stash file. When
> --rewrite isn't used, the reflog delete still does the right thing to the
> RHS entry.
>
> I couldn't find any way to check this LFS value other than reaching into =
the
> actual file. If there is a way that would be preferable.

Thanks for that summary that's accurate as far as I know. I think that's
how this all works, and I don't know of another way to extract this
information than this reaching behind the curtain.

Which, I think is a lot clearer if we amend the test like this. Note
that this doesn't really add anything for catching a regression goes,
but I think helps guide the human reader through this step-by-step. So
perhaps it would be good to fix the test up to have it (or maybe not):

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index ec9cc5646d6..bc58e99e3e6 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -198,12 +198,25 @@ test_expect_success 'drop stash reflog updates refs/s=
tash' '
 test_expect_success 'drop stash reflog updates refs/stash with rewrite' '
 	git reset --hard &&
 	echo 9 >file &&
+
+	# Our two stashes
+	old_oid=3D"$(git rev-parse stash@{0})" &&
 	git stash &&
-	oid=3D"$(git rev-parse stash@{0})" &&
+	new_oid=3D"$(git rev-parse stash@{0})" &&
+
+	# Our stash <old oid>/<new oid> before "drop"
+	cat >expect <<-EOF &&
+	$(test_oid zero) $old_oid
+	$old_oid $new_oid
+	EOF
+	cut -d" " -f1-2 .git/logs/refs/stash >actual &&
+	test_cmp expect actual &&
+
+	# Our stash <old oid>/<new oid> after "drop"
 	git stash drop stash@{1} &&
 	cut -d" " -f1-2 .git/logs/refs/stash >actual &&
 	cat >expect <<-EOF &&
-	$(test_oid zero) $oid
+	$(test_oid zero) $new_oid
 	EOF
 	test_cmp expect actual
 '

If this series is amended to drop the "EXPIRE_REFLOGS_REWRITE" flag then
this will fail on that last test_cmp like:
=20=20=20=20
    + diff -u expect actual
    --- expect      2022-02-23 23:37:40.438221222 +0000
    +++ actual      2022-02-23 23:37:40.434221258 +0000
    @@ -1 +1 @@
    -0000000000000000000000000000000000000000 236c59f58e239e74e90b6832a98fa=
4b7f4b33647
    +5c6ad4ca28e71ae3a007e6c77043d04bc42fa9ee 236c59f58e239e74e90b6832a98fa=
4b7f4b33647

I.e. our <old oid> is now referring to the now-deleted stash entry we
just deleted, since we didn't rewrite it.

And as we can see with some manual inspection the state before we
dropped stash@{1} was:

    0000000000000000000000000000000000000000 5c6ad4ca28e71ae3a007e6c77043d0=
4bc42fa9ee
    5c6ad4ca28e71ae3a007e6c77043d04bc42fa9ee 236c59f58e239e74e90b6832a98fa4=
b7f4b33647

My usual method of checking my assumption about this not being otherwise
inspectable would be something like:
=20=20=20=20=20=20=20=20
    diff --git a/refs/files-backend.c b/refs/files-backend.c
    index f59589d6cce..590c13e7a2b 100644
    --- a/refs/files-backend.c
    +++ b/refs/files-backend.c
    @@ -3133,7 +3133,7 @@ static int files_reflog_expire(struct ref_store *=
ref_store,
            const struct object_id *oid;
=20=20=20=20=20
            memset(&cb, 0, sizeof(cb));
    -       cb.rewrite =3D !!(expire_flags & EXPIRE_REFLOGS_REWRITE);
    +       cb.rewrite =3D 0;
            cb.dry_run =3D !!(expire_flags & EXPIRE_REFLOGS_DRY_RUN);
            cb.policy_cb =3D policy_cb_data;
            cb.should_prune_fn =3D should_prune_fn;

I.e. let's intentionally break the flag, and see what else fails (it's
set in a few places, but this is the only place where it's checked).

That should normally find the other things that are testing this, maybe
there's a better way.

But, no such luck :) The only thing that'll fail is this new test being
added here.

So just like my 5ac15ad2509 (reflog tests: add --updateref tests,
2021-10-16) this is covering a true blindspot in the "git reflog"
functionality.

The only tests that used --rewrite were a test added in c41a87dd80c
(refs: make rev-parse --quiet actually quiet, 2014-09-18), which will
pass if --rewrite is omitted.

And the ones I added in 5ac15ad2509, which I added not to test --rewrite
per-se, but to test that the --updateref part of it behaved as expected
in combination with whatever effect it was having.
