Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1EFC433F5
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 09:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F65B610A0
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 09:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbhKMJMs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 04:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhKMJMr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 04:12:47 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AFBC061766
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 01:09:55 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id e3so11194511edu.4
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 01:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=mHffK+wSdOGKSjDGM1dBFN6Oj7zJXXe0jQyYBTlIxdc=;
        b=RvCE7aMm/jbtCNPtbFOMLbq237un5omMHBqhGvBpUH3mBL+U9hDwj3UuTjbCQCa+bH
         bkovJEBQfbRgIe1RVqAISUp5phbnM/OvjanU4AexMY2JNPb3+ds/J7ulEAr/1H97r5eN
         oaYPH8ZeqUCCNVjVrD369Ol0TKqFvdiugSMcSfwdKI3RYL+cm97O/G/RuR+eA7kJa6V0
         SuDz9a7CEnKIz0hcFycLCVId+Ub8YV2csVlq4fR689FcLynr4/xdABZq+ZPFB234h9S9
         Jz7sKYz6kNS1bHRzYhrn1JDwlN6p9CgneA47u/E7pODO3QHJS7+yC11SmygEIMOHO+PM
         4wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=mHffK+wSdOGKSjDGM1dBFN6Oj7zJXXe0jQyYBTlIxdc=;
        b=q+AThXAyOrjQ9iT833kyf6/6/QB4OKSPxqq8GGBjvZPnfwYIEi/FP7gxUs7zsjFDAe
         bUIQjHjoVTgV0Sy+1ptJtpZvWWXZB0GF18ADyDxWAuHguKCXTcNMIuJUjgdeGYeXFY46
         KssiG75/WgBBavmQiapcCFR9txsacvj2N2D5ByptaX9vBvySZM9PykvgK2HcuZxrmEPU
         z8lgHiaKem4RYhhixrA2U5n7l9wv3kTgBAxnDaIHKa0gPo/UbLF60bRqFavrDRQCNJ0+
         nb0B3kBRFRma9cqhvAG1sUDP7koA2BHPyUBfrh1SDvoXQsstZycaQy1sulF7CrcM4Zb5
         JOWw==
X-Gm-Message-State: AOAM532P17gJJNWdUFeDHLuouRWGIUqNJ9SPecxrFRhUzXIQecWmCCKY
        n0/LfAIZXtcdiRLg+qr+TFE=
X-Google-Smtp-Source: ABdhPJy0E1FKzY6ifsedTLK6dZEfZKXN2yC4YsGh0So+HGvkkqkMaeaHLizJ1duEk2jY7uStaMmtQQ==
X-Received: by 2002:a50:e08a:: with SMTP id f10mr31070072edl.319.1636794593263;
        Sat, 13 Nov 2021 01:09:53 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hr11sm3397057ejc.108.2021.11.13.01.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 01:09:52 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mlp2l-000Zx8-Sr;
        Sat, 13 Nov 2021 10:09:51 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/2] object-file: fix SEGV on free() regression in
 v2.34.0-rc2
Date:   Sat, 13 Nov 2021 10:00:37 +0100
References: <20211111030532.75910-1-hanxin.hx@alibaba-inc.com>
        <cover-0.2-00000000000-20211111T051800Z-avarab@gmail.com>
        <patch-1.2-811242178e4-20211111T051800Z-avarab@gmail.com>
        <xmqqtugilel1.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqtugilel1.fsf@gitster.g>
Message-ID: <211113.86y25sto9s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 11 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Fix a regression introduced in my 96e41f58fe1 (fsck: report invalid
>> object type-path combinations, 2021-10-01). When fsck-ing blobs larger
>> than core.bigFileThreshold we'd free() a pointer to uninitialized
>> memory.
>
> s/d we'd/d, we'd/; no need to resend.
>
>> This issue would have been caught by SANITIZE=3Daddress, but since it
>> involves core.bigFileThreshold none of the existing tests in our test
>> suite covered it.
>
> s/d none/d, none/; likewise.
>
>> Running them with the "big_file_threshold" in "environment.c" changed
>> to say "6" would have shown this failure, but let's add a dedicated
>> test for this scenario based on Han Xin's report[1].
>
> Yeah, it is a good and focused test.=20=20
>
> By the way, I do not think changing big_file_threshold _blindly_ to
> smaller values, instead of in a focused test like this, is a good
> idea in general.  Some tests check if a file with a normal size that
> is smaller than the threshold correctly is treated as a binary file,
> and lowering threshold for them without understanding what they are
> meant to test would trigger a "bug" that is not a bug at all, for
> example.
>
>> It would be a good follow-up change to add a GIT_TEST_* mode to run
>> all the tests with a low core.bigFileThreshold threshold.
>
> So, no, please don't do that.

Yes it's probably not worth it, and I've got enough dragons to slay as
it is.

I took the commentary you added in 12426e114b2 (diff: do not short-cut
CHECK_SIZE_ONLY check in diff_populate_filespec(), 2017-03-01) as a
suggestion that we might be conflating too many things in
core.bigFileThreshold, but maybe that's just projecting.

I think that setting is probably too much of a kitchen sink grab bag of
stuff for its own good. Any such GIT_TEST_* mode would I think need to
introduce another setting to not have it imply "these files are binary".

Which may be a good idea in general, and it might not. I.e. are there
users who mainly don't want to consider these for packing, but do want
to have "git diff" work on them?

Anyway, even if that were split up we'd still have the remaining tests
that are assuming that something ends up loose or in a pack.

Fixing those is probably a good idea either way, so poking at this might
be a useful canary for someone. I haven't looked in any detail, but a
part of them are probably checking things manually on .git/objects and
could move to "git rev-parse" or whatever.

The other half likely really do care about whether something ends up
loose or not, and would probably benefit from testing "both sides".

None of that's anything I'll pursue now, just idle thoughts from having
looked at these failures a bit, in case anyone's interested.
