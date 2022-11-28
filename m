Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553F9C43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 11:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiK1Lar (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 06:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiK1Lan (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 06:30:43 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AEC115A
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 03:30:41 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id vp12so23691743ejc.8
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 03:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VYMXwL5wbKC+A2gOkFr2dQcuR4z2fJAHslijiIoHZDc=;
        b=mgkHHMsMPmuch+61+CwhPP2lZ16eba8NolUOvFbkAlNrLB1NpeKM3+HZiyJDniFhVJ
         8g9Uur060mN2LAI8WyP9Ioaa7jwynj1rqxYtaR27aINUg1ueKLQs7GWlUifl8sNP7e3I
         F29C2Z1KVMuZOjMvae7PI2pytr92YtYN4ukiYOqUvN+miUZr9Xb6BUS6t8rLHidS7a/5
         Cj7Igqx79OUppIrXujMpyn9S30K+ujZj8/jyx8lvFmDJxh6rtrsZ3TDcCLhLHS1HBmeY
         iO/tPO1Nve4GY86TgLxylM8DxNGLuwxBB3MjuebVn/bPrRMSDnZvge1jZSe9w6OpcRjq
         sxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VYMXwL5wbKC+A2gOkFr2dQcuR4z2fJAHslijiIoHZDc=;
        b=RrE71xuRf50p1KhOfSGCXvIc95Sr609TDkQRUIlHTvzs1gq2q9n7XHcUwM/gkKMwsS
         Fg3aGtBNpx/Krv/b7uOrpnTwBAcR/eTP+4iubfZHQxz3MmF1IuOnShoVKG3ib43GjS5w
         KgosjNfEcA7hlg+lZaUUzHhMtvmqc+yuS1ZrEhSU63pwJXNZ7pvFjiRdBXfQwxqcHYqk
         9AjD7pid3xX40eFNA1m2uLY+OY66Dzbaf4Hs7GupUjy91g4LBS5/kVmrhlLuCd/nIVko
         EBGYQ8uihqbS86n+9FF+/taB1Nmr3WqFkx+A+YTgjq1mtQfCjHCDpkfNPbeB1KbCCgb9
         KfBw==
X-Gm-Message-State: ANoB5plAUfkiMWbSyyaqkGQGFR9LmnmXpsaZc+ZrebHpl8LqKqLMyzA9
        Txm2O8NkoVITOMHgamGK/2Y=
X-Google-Smtp-Source: AA0mqf7XWaNMIn4b1lYX+HL00awtW3csE7grGar4B3dqMUfBXILmCoza1hAPDxH/J/oNEUe2fIOlOQ==
X-Received: by 2002:a17:906:1e55:b0:7ad:a0cb:f79e with SMTP id i21-20020a1709061e5500b007ada0cbf79emr25675658ejj.458.1669635039747;
        Mon, 28 Nov 2022 03:30:39 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id i18-20020a170906851200b007c07c23c267sm511743ejx.224.2022.11.28.03.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 03:30:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ozcLO-00106n-2e;
        Mon, 28 Nov 2022 12:30:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] Revert "pack-objects: lazily set up "struct
 rev_info", don't leak"
Date:   Mon, 28 Nov 2022 12:12:23 +0100
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
 <f5779e19-813c-cda9-2f84-9fe58f745e89@web.de> <xmqqv8mz5ras.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqv8mz5ras.fsf@gitster.g>
Message-ID: <221128.868rjvmi3l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 28 2022, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> This reverts commit 5cb28270a1ff94a0a23e67b479bbbec3bc993518.
>>
>> 5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't leak,
>> 2022-03-28) avoided leaking rev_info allocations in many cases by
>> calling repo_init_revisions() only when the .filter member was actually
>> needed, but then still leaking it.  That was fixed later by 2108fe4a19
>> (revisions API users: add straightforward release_revisions(),
>> 2022-04-13), making the reverted commit unnecessary.
>
> Hmph, with this merged, 'seen' breaks linux-leaks job in a strange
> way.
>
> https://github.com/git/git/actions/runs/3563546608/jobs/5986458300#step:5=
:3917
>
> Does anybody want to help looking into it?

It's because the tip of that branch introduces a new leak, but it's only
revealed in our test suite by a "git" invocation that we don't check the
exit code of. So testing with "GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue" (which
is there to check exactly those edge cases) catches it.

Ren=C3=A9, testing locally with e.g.:

	GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck \
	GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue \
	make test

Should catch it, but note that we might still have new leaks in tests
that are already failing due to other leaks. So diff-ing the resulting
t/test-results/*.leak/* would be a good sanity check to see if there's
any other leak we've missed.

As to the bug itself: This exact edge case is why I went for the
lazy-setup part of 5cb28270a1f (pack-objects: lazily set up "struct
rev_info", don't leak, 2022-03-28), and indeed the example mentioned in
its commit message now leaks again, but not on master:

	echo e83c5163316f89bfbde7d9ab23ca2e25604af290 | ./git pack-objects initial

Now, maybe I'm missing something, but it the tip of that branch points
out a legitimate bug in my 5cb28270a1f.

But I don't see why the fix for it needs to be a full revert of
5cb28270a1f. If I replace all the C code changes in that commit with
this the test it flipped also passes:
=09
	diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
	index 573d0b20b76..0de53c5a2df 100644
	--- a/builtin/pack-objects.c
	+++ b/builtin/pack-objects.c
	@@ -4158,8 +4158,10 @@ static struct list_objects_filter_options *po_filte=
r_revs_init(void *value)
	 {
	 	struct po_filter_data *data =3D value;
=09=20
	-	repo_init_revisions(the_repository, &data->revs, NULL);
	-	data->have_revs =3D 1;
	+	if (!data->have_revs) {
	+		repo_init_revisions(the_repository, &data->revs, NULL);
	+		data->have_revs =3D 1;
	+	}
=09=20
	 	return &data->revs.filter;
	 }

I.e. the commit is correct that we shouldn't be clobbering the
"rev_info" when we see --filter again, but then let's just stop doing
that.

Well, I know why, it's because Ren=C3=A9 initially started poking at this to
rid the codebase of the reliance of C99's J.5.7. I think our two
opinions on that are quite clear, so I won't repeat that here (I don't
per-se mind, I just think it's a nothingburger).

But in any case, if we're going to also refactor this code to get rd of
the J.5.7 reliance I'd think we could agree that it really belongs in
its own change. That change could then be a pure refactoring change, and
wouldn't need to also explain how it's fixing a bug while-at-it.
