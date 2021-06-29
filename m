Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E925FC11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 18:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C150B61DE3
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 18:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbhF2SiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 14:38:25 -0400
Received: from mout.web.de ([217.72.192.78]:44375 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235154AbhF2SiX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 14:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1624991748;
        bh=JoKQB1eCbDSjRWjTSAEVjOPCS4KT3y90AyyRxTMrpa0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=pxqDj/m6/ZygQUCKNulKzZRE9iG6hw44X70+wrmOtB4iYMvk/qggw2OA2VPrpJxt0
         Ad01LziGxZ72ooMOs7ZxM+HsceX0p5FSn4Q6IUzvx80lQKXJ6UTqs2/Pq9XNxOaai0
         Z+/9wXIfSiHI3+fmGT04y/jG9hNgFniI3fFghgCM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1Mdf8F-1lOxtt0A5Z-00Zf0I; Tue, 29 Jun 2021 20:35:48 +0200
Subject: Re: [PATCH] grep: report missing left operand of --and
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Matthew Hughes <matthewhughes934@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <20210628121748.f3yrc72v4mynknl3@debianXPS.lan>
 <98171911-ba39-27f1-d068-4d381bcd4804@web.de>
 <87im1wft42.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7c462dc5-f250-0bc3-5e85-cf394fd8fbb9@web.de>
Date:   Tue, 29 Jun 2021 20:35:47 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87im1wft42.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zzUmB7buGMY3iGbjfwPO0CtxcPgHsWpl8TYflyWY1BizMOQPJj+
 tjsu2FNgpcr+c540A4yXRjDqF8ADkZz+epx6vs5eb+0TjCXHIXMANw8N7EuTcH7K+iIo/Br
 YwYjJWWBmwzbnOYLDR1mD8l++duDglREELzkqgOrDSOqqM60DQ0aOcgkFbME17lpJBxaDj4
 Sq4yT7zBdXkdTdeVD0xwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8YtIzdUK2kc=:dLNJIUiq77i3z9pgXKESb1
 9DwDnHWYNZOhAKCsQyaDiShoAVMMqYyI4bDXfTSXT2Ocmpg7PtGJUbitD7FC1/sHu5J6CUfWv
 NB1v3tmMlOdNPBruzC8jWcGI2mLFp8tgl7Pha2G7aQK2mzyMobXNSLKVKtgYMKyA713zJZpTV
 eFNGGO1PgRRwu2o62C0BPvwYI3np9LgmTDw7qyQdJtNoopGLyuFB40ku9m1QdkalSt0VkC2/h
 pJ6CerdbZDRcdKAx5ja1qhAF8aHQeteSsk1IVrxRL8EPW2JHkS9r1tXPu7KDVE5Iv0oJeCFNd
 QNGXcOFyRjYTk+Om+cTXWhJ3dgYsFyVPcdrta8JsQbzvfiuZ9+MuvEeP35V8AC07ggpeTYM3b
 fezfcHcFoXk3K6X3WJ3H5h84xy2TF5HNI5+SOxvmThTXDiZgudcQ1UblRLBU5soONH0QCeOSj
 OtekTcbtxo2AfBhIgSG6+t+sFyH1Q7DLt98RY+i8NA981HfWcYVZhjVpSBJw4C/FZHMX0v7XX
 tpi4g5i28c6/2H8I9Ld/1DgIlO27Umo9GIQwQAuaKO6e/ktk37tGSGb11XTTwzWbkerk0XA+T
 DuRtoWAEK3z7yEEBEGkIzCgHBliXZ1QcVAtSD+PKTtgxTuDRMSvahsvJFrUX1dJWfZExwX/nG
 tZdJiQb3VLBtCQxBjftOXBP3rVAFHlG2LOcJ9ApWA/VRRYHYZf8y/QP7O7Ag0M3HECHZWDW62
 rDkL6mmjl7GLdCFdEnaQT6P0EdXYzfWniD9ErtMr0YKd4ujxm+QoFnwBK9Izea2uv5o17Pvde
 4QZdvJDxPfIZigPJPQKovg/0C+BPXS2Y+9mfoUzXieAulxNoL1BmIXVNPYNCS1++6KZTz0SdG
 JZJAvF2wT1H5XCyDWgdxoJqe9cF5VMCx6w0qOxcoWgzTLDXAu9GlIYdUa/BlcySBKbuMDHw6H
 j/oyajvbuFjhSCXzMJ49hxcSaApzxlHjvMK0dqrSNUclZV3OB7E5W9FxGFZnsHj93UcmRuc6+
 cnK+lgPqpVQNaKGqozcVwqttFnjJLCwITPCGBwoSzAedZkY6PEbILgomW3YfnG6h0TNgYzTi8
 nqP7VfshhdgGm53KBLg3BLxjNL+r7dPG8Vc
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.06.21 um 19:52 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Mon, Jun 28 2021, Ren=C3=A9 Scharfe wrote:
>
>> Git grep allows combining two patterns with --and.  It checks and
>> reports if the second pattern is missing when compiling the expression.
>> A missing first pattern, however, is only reported later at match time.
>> Thus no error is returned if no matching is done, e.g. because no file
>> matches the also given pathspec.
>>
>> When that happens we get an expression tree with an GREP_NODE_AND node
>> and a NULL pointer to the missing left child.  free_pattern_expr()
>> tries to dereference it during the cleanup at the end, which result in
>> a segmentation fault.
>>
>> Fix this by verifying the presence of the left operand at expression
>> compilation time.
>>
>> Reported-by: Matthew Hughes <matthewhughes934@gmail.com>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>> Whether the check in match_expr_eval() can now be turned into a BUG is
>> left as an exercise for the reader. ;-)
>>
>>  grep.c          |  2 ++
>>  t/t7810-grep.sh | 10 ++++++++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/grep.c b/grep.c
>> index 8f91af1cb0..7d0ea4e956 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -655,6 +655,8 @@ static struct grep_expr *compile_pattern_and(struct=
 grep_pat **list)
>>  	struct grep_expr *x, *y, *z;
>>
>>  	x =3D compile_pattern_not(list);
>> +	if (!x)
>> +		die("Not a valid grep expression");
>>  	p =3D *list;
>>  	if (p && p->token =3D=3D GREP_AND) {
>>  		if (!p->next)
>> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
>> index 5830733f3d..c581239674 100755
>> --- a/t/t7810-grep.sh
>> +++ b/t/t7810-grep.sh
>> @@ -11,6 +11,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>>
>>  . ./test-lib.sh
>>
>> +test_invalid_grep_expression() {
>> +	params=3D"$@" &&
>> +	test_expect_success "invalid expression: grep $params" '
>> +		test_must_fail git grep $params -- nonexisting
>> +	'
>> +}
>> +
>>  cat >hello.c <<EOF
>>  #include <assert.h>
>>  #include <stdio.h>
>> @@ -89,6 +96,9 @@ test_expect_success 'grep should not segfault with a =
bad input' '
>>  	test_must_fail git grep "("
>>  '
>>
>> +test_invalid_grep_expression -e A --and
>> +test_invalid_grep_expression --and -e A
>> +
>>  for H in HEAD ''
>>  do
>>  	case "$H" in
>
> This seems like an incomplete fix, for the exact same thing with --or we
> silently return 1, as we would if we exited early in free_pattern_expr
> on !x, which aside from the segfault I think we should probably make a
> habit in our own free()-like functions.
>
> Whatever we're doing about the --and segfault it seems like we should do
> the same under --or, no?

No, --or is a special case and needs special handling.  Currently it's
ignored.  If we want to berate the user for using it without expressions
left and right then we need to start actively handling it.

> Your first test also passes before your fix, it's only the latter that
> segfaults. The first one emits:
>
>     fatal: --and not followed by pattern expression
>
> So having that in a leading patch to indicate no behavior was changed
> would be better.

True, the first test is just nice to have.  I can remove it to reduce
confusion.

> Instead of the "Not a valid grep expression" error let's instead say
> something like:
>
>     fatal: --[and|or] must follow a pattern expression

Good point.

> The error (which I know you just copied from elsewhere) is misleading,
> it's not the pattern that's not valid (as to me it implies), but our own
> --and/--or option usage.

That's what's meant with extended pattern, I think.

> And the "excercise for the reader" is a bit flippant, do we actually hit
> that condition now? If not and we're sure we won't now seems like the
> time to add a BUG() there, and to change the "Not a valid grep
> expression" to "internal error in --and/--or parsing" or something.

I don't know.

Ren=C3=A9
