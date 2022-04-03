Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3020DC433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 14:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349397AbiDCOSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 10:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbiDCOSr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 10:18:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E12425E90
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 07:16:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b24so8130028edu.10
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 07:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=OyjYn7+2QNmLwf+Gj+sq1ZC8VPt0LMAYodSPaFaMmzo=;
        b=OPqLwu6oICxrJv1w8hO+EM4ns2ZPWo7bWIji+iuK72H3qkb1mEVDdGGs/dPVHmhHqF
         0gRmwVZ3A0wS1pEQ6fRNbLfQot68dZNtK3Np9v4xFrdQ4E8eEoNCMo2bU4NwNN1f4LUx
         YAyBJR8BXcaXw+hphAf2l4fSdXDXsmEds1BECcmXKTyomcaLb43VheksY2cr6FFNmBCg
         yz+OndjE+NVAkYRlP/pToxWIcR73OEkP5pSdD8VMLwUqv8+KRu4Q4Y/a4JGgkuJwNC05
         hlMcHPRLL6F933r49giFrvh2PCy0+QHL9YcO113+HpXTIn1M+fu/vX+vhgAVpdjV9w6Q
         PgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=OyjYn7+2QNmLwf+Gj+sq1ZC8VPt0LMAYodSPaFaMmzo=;
        b=yafQVNRv0TilK1eXF42/R7sM95CpY/v6TPznq0B3usJWwtmHtlYGKe+scbqBWKU7lF
         AalIuapsk2hozFyR6NctMrJOTGo16vO0FdTl6HMk87UoFMQITsQEbRyJ26hAP4cig/06
         8EkR5KGrwOin6AyNUgtoD4V5cD7rU3B2GUdj8k2pKhQsgzh8i1uQg3sVeLX2VPyPPGxV
         PXXbc9cUem5YYNXDfx1CcdJQgvdeA6UfYOGP3qdXU/4pkL4VAxe3NacdexKNEyiwPlYo
         qOC4Hgq06eQf0RTr4ZJY3aEoIaG7uUe6YKeohOfyhoD071zvdqlO39RHeq+8hheW57KF
         AdDw==
X-Gm-Message-State: AOAM53384apxzosWUKdPsadzHf0nbqyzk6em8szXKLOalDJflJLCTnCu
        AMFQrD7uolt8RrFG3O8PhMDqEejsCf0=
X-Google-Smtp-Source: ABdhPJxCfSQKRvs1neIYr3QLQ41sgELOJWjfkqRrAkJ6Y49p9VLIsC553s9z5KKd96LMh6A/24MdtQ==
X-Received: by 2002:a05:6402:18:b0:410:86cd:9dce with SMTP id d24-20020a056402001800b0041086cd9dcemr28900721edu.70.1648995410484;
        Sun, 03 Apr 2022 07:16:50 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g20-20020aa7c594000000b004194b07bbfasm3872857edq.10.2022.04.03.07.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 07:16:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nb128-002EIM-WE;
        Sun, 03 Apr 2022 16:16:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 13/27] revisions API users: use release_revisions()
 in builtin/log.c
Date:   Sun, 03 Apr 2022 16:07:44 +0200
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
 <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <patch-v4-13.27-02ca92660af-20220331T005325Z-avarab@gmail.com>
 <14c17fa9-e9ff-ac5f-dbda-4a566ed09fd3@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <14c17fa9-e9ff-ac5f-dbda-4a566ed09fd3@gmail.com>
Message-ID: <220403.865ynqmeun.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 02 2022, Phillip Wood wrote:

[A comment on v4, but also applies to v5 I think]

> On 31/03/2022 02:11, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> In preparation for having the "log" family of functions make wider use
>> of release_revisions() let's have them call it just before
>> exiting. This changes the "log", "whatchanged", "show",
>> "format-patch", etc. commands, all of which live in this file.
>> The release_revisions() API still only frees the "pending" member,
>> but
>> will learn to release more members of "struct rev_info" in subsequent
>> commits.
>> In the case of "format-patch" revert the addition of UNLEAK() in
>> dee839a2633 (format-patch: mark rev_info with UNLEAK, 2021-12-16),
>> which will cause several tests that previously passed under
>> "TEST_PASSES_SANITIZE_LEAK=3Dtrue" to start failing.
>> In subsequent commits we'll now be able to use those tests to check
>> whether that part of the API is really leaking memory, and will fix
>> all of those memory leaks. Removing the UNLEAK() allows us to make
>> incremental progress in that direction. See [1] for further details
>> about this approach.
>
> This breaks "git bisect" but only when running the test suite to
> detect leaks so I guess that's not too bad. An alternative would be to
> manually remove the UNLEAK() when you're testing rather than
> committing the change.

It doesn't, for this series each individual commit passes with

    make test
    GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue make test SANITIZE=3Dleak=20

And also in a stricter mode that I have locally (not in git yet):

    make test
    GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck make test SANITIZE=3Dleak=20

Which ensures not only that the tests we marked as leak free pass, but
that no other tests we *haven't* marked pass unexpectedly (requires prep
changes before this series to mark the still-not-marked-but-should-be
tests).

I think that should address/help explain things re your questions about
some of the UNLEAK() back-and-forth.

I.e. there's a few changes that are in this series just so it can pass
in that "GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck" mode, but it would still
pass in "GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue", i.e. because we'd make
some new test pass unexpectedly.

But I think maintaining the 1=3D1 correspondance really helps to follow
along with this, i.e. tests are tweaked as they become leak-free, and we
(or well, mostly I) can be confident that I marked all the relevant
newlry passing ones, and that there are no regressions in-between.


>>   /*
>>    * This gives a rough estimate for how many commits we
>>    * will print out in the list.
>> @@ -558,7 +564,7 @@ int cmd_whatchanged(int argc, const char **argv, con=
st char *prefix)
>>   	cmd_log_init(argc, argv, prefix, &rev, &opt);
>>   	if (!rev.diffopt.output_format)
>>   		rev.diffopt.output_format =3D DIFF_FORMAT_RAW;
>> -	return cmd_log_walk(&rev);
>> +	return cmd_log_deinit(cmd_log_walk(&rev), &rev);
>
> This is a rather unusual pattern, at first I wondered if there were
> going to be more added to the body of cmd_log_deinit() in later
> commits but there isn't so why not just call release_revisions() here
> to be consistent with the other release_revisions() call that are
> added in other patches?

It's just a way to save every single call to this callsite a change on
top like this:
=09
	diff --git a/builtin/log.c b/builtin/log.c
	index 5dad70aa47e..ece03536bed 100644
	--- a/builtin/log.c
	+++ b/builtin/log.c
	@@ -684,8 +684,11 @@ int cmd_show(int argc, const char **argv, const char =
*prefix)
	 	opt.tweak =3D show_setup_revisions_tweak;
	 	cmd_log_init(argc, argv, prefix, &rev, &opt);
=09=20
	-	if (!rev.no_walk)
	-		return cmd_log_deinit(cmd_log_walk(&rev), &rev);
	+	if (!rev.no_walk) {
	+		ret =3D cmd_log_walk(&rev);
	+		release_revisions(&rev);
	+		return ret;
	+	}
=09=20
	 	count =3D rev.pending.nr;
	 	objects =3D rev.pending.objects;

Which, given that there's 6 of them nicely cuts down on the resulting
verbosity.
