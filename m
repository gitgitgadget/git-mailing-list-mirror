Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC0BC433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 11:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiKULjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 06:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiKULir (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 06:38:47 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969AE1C917
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 03:37:07 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id m22so27764127eji.10
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 03:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kmwS5CBIFfJCSEl7WpIUAfHpqIpB0Ap1NWCLpMMULY8=;
        b=KmyqCHY3YmrO7YZZ+cRt+y0FDx2aFbS1lcieoJquRgh4yl9ig8so5qbHcHAMbx/je0
         CHSIyIc7z9FeL5B8Atv2ZJyNHySocMcLjjuv7LiS+WzitF+Jgh1swbO7ozJKW4nLR1bH
         tnqYg0xEL1x2xd0qG0gJzhRP7ZJnxpiS8oIFSsoiTC2BJfM0Zoo/76oZAiLdGnicpTcb
         4lVQBVWdBprdQsjPXDtDGFaQOwmk7P3NgVuUuuYafilogf0taazsqxJgfncYsm3jv0fU
         dCJ+UyhJR9D+h0ANu3buYTP/4cURoXXM50yiNJsioXE+CIwqIkDDUYKdrjapYTnyF6+w
         BH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmwS5CBIFfJCSEl7WpIUAfHpqIpB0Ap1NWCLpMMULY8=;
        b=N9GiseVoOFOy6hg5dTojH7NFJTKt8EZwx/fwFiIwYf+swnNjpIeISDi+puWgMVQtUQ
         dXGaUXxP17YNGPMkobXF5spJL8Xp4SC/8YLah/IydQ+2/5MyqelE6TLZ5nFzfFy40jbi
         mUqdcMqes1hXR6350sf4zUCpABohv6pMBT0QXt6cLGEWR5uYZlJ2fo7LGiUHQVNV6kHU
         x8MZeIGAWLb1pCJhDQvbAjY1mmKXMnJNiqJuWIE0hcDdw6mKYZZnJE6b211ky6o59M7n
         LsaacOm9vuEwYoTXqd50hCP3BxglzJRHSWoy9Bkrr31cz2fKOSfWgAlsJe4g48udutMY
         mxww==
X-Gm-Message-State: ANoB5pnP4FBk228wRGfxQ2hpInntcKYmoZO8+WRazbMqBy7kH623QUFE
        Rp9zrt4iY4jS+kpKZUfaQYU16MziXs0=
X-Google-Smtp-Source: AA0mqf4uB/CrxPQAZh8aJGyftWsbCiuwTnUHiNgy3K90V343Yw05g7koHveLBaBgHkPhNvM1uHMxmQ==
X-Received: by 2002:a17:907:104d:b0:79e:3312:9a0f with SMTP id oy13-20020a170907104d00b0079e33129a0fmr14150406ejb.576.1669030626064;
        Mon, 21 Nov 2022 03:37:06 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id f24-20020a17090631d800b0078db18d7972sm4896179ejf.117.2022.11.21.03.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 03:37:05 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ox56m-0004np-1s;
        Mon, 21 Nov 2022 12:37:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Siddharth Asthana <siddharthasthana31@gmail.com>,
        git@vger.kernel.org, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, me@ttaylorr.com
Subject: Re: [PATCH v5 1/2] cat-file: add mailmap support to -s option
Date:   Mon, 21 Nov 2022 12:27:45 +0100
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221120074852.121346-1-siddharthasthana31@gmail.com>
 <20221120074852.121346-2-siddharthasthana31@gmail.com>
 <xmqqy1s4wyvf.fsf@gitster.g>
 <CAP8UFD1CB90eoWpQmGJbfxK7uHX0-u4BuSE-v=mD1yuW+nnAxA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAP8UFD1CB90eoWpQmGJbfxK7uHX0-u4BuSE-v=mD1yuW+nnAxA@mail.gmail.com>
Message-ID: <221121.867czoczdr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 21 2022, Christian Couder wrote:

> On Mon, Nov 21, 2022 at 8:27 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>>
>> > +test_expect_success 'git cat-file -s returns correct size with --use-mailmap' '
>> > +     test_when_finished "rm .mailmap" &&
>> > +     cat >.mailmap <<-\EOF &&
>> > +     C O Mitter <committer@example.com> Orig <orig@example.com>
>> > +     EOF
>> > +     git cat-file commit HEAD | wc -c >expect &&
>> > +     git cat-file --use-mailmap commit HEAD | wc -c >>expect &&
>> > +     git cat-file -s HEAD >actual &&
>> > +     git cat-file --use-mailmap -s HEAD >>actual &&
>>
>> Doesn't this break under macOS where wc output tends to be padded
>> with SP on the right?  We used to often see test breakage when a
>> carelessly written test like
>>
>>         test "$(wc -l <outout)" = 2
>>
>> which expects the output file to have exactly two files (the
>> solution in this sample case is to lose the double quotes around the
>> command substitution).
>
> I guess that's the reason why `wc -c | sed -e 's/^ *//'` is used in
> the strlen() function in t1006-cat-file.sh. There are a number of
> places in the tests where wc -c or wc -l are used without piping the
> result into sed -e 's/^ *//' though. So it's not easy to understand
> why it's sometimes needed.

It's because in "t1006-cat-file.sh" we're assigning the "wc -c" to a
variable, because it's used to "test_cmp" the number of bytes in some
free-form text.

It would be nicer to split "test_line_count" into some utility function
that knew how to parse out "wc -l", "wc -c" etc. for a given input file,
and return that as a string.

In that case the "sed" isn't needed, and we're just (ab)using it to do
things we can do with whitespace managent + shell built-ins. E.g. this
works too (the "echo; echo; echo" showing that we're stripping out
whitespace "wc -c" might emit:
	
	diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
	index 23b8942edba..9ae4b534421 100755
	--- a/t/t1006-cat-file.sh
	+++ b/t/t1006-cat-file.sh
	@@ -106,7 +106,7 @@ echo_without_newline_nul () {
	 }
	 
	 strlen () {
	-    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
	+    printf "%s" $(printf "%s" "$1" | (echo ; echo ; echo ; wc -c))
	 }
	 
	 maybe_remove_timestamp () {
