Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF012C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 10:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiAMKoz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 05:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiAMKoy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 05:44:54 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A7DC06173F
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 02:44:53 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id m4so21333770edb.10
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 02:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=m3bHEWkO2YuEket/X3e8GE9Ei5zsm4rbw1Jl1qVxI9g=;
        b=HOelW6wmEbVHvh+TUuCnk4RueWWTn/wWV4cRoZRKtzygu1tlFzs4LssuREHziMGb4C
         F1yfXH0+TtRM/3cDQFayqUsPNlZNBCyc5UVcDRbDcEn4LkfkXLHJ8Kyr2XO0N1BEp8/j
         qDcriwfuZWhPtFtyAF8uPiP2WYeebsqt5lglzmbfbcwdnnvGW1k7BvWYEAMA8dA/ntuM
         cQ624RbAgR/oL1cmJAJKSakfF7IWDtdk40E4gN0Eq/ZnCrJiO7PiNRag2UKchoAOFxgF
         aHq9DQXR0A0RJ/q/C3WXAXoneKg88u/S3vTD0eUJwIk3w84VWHB9A18jgGd0vVb2F6Kt
         PLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=m3bHEWkO2YuEket/X3e8GE9Ei5zsm4rbw1Jl1qVxI9g=;
        b=JDryzOh35xcFB5JrjjdP/Qatd7FtK/Lbd2rd5gs2Yjp7q8QNmdqozYi7465LRhxvwR
         KH9OvTkTzDvgpe7jE3Fh5IFhPL3A01oAuRKJz3N5X9Oem4HkLk8mYkGYJD+rLaD2dO0z
         a+b8wUuOAmukya+IiEgyGw/B9darkpqQpdl0ssRVvbk5UxKMXxhQA3Wgqoyuc2PfXRqV
         lKTN4cTZn6CBxVy3Rdzhd3k4WdcAAU72ao939zP10R/S+8e7rqVG0KzyooddycS2wEtX
         P5jrd9xpFdd9rU1iWQA2WGM9kguR3lEuap5rkAjePTiy3DwcbMB16O7+tdk4zVTV9uLO
         T0xg==
X-Gm-Message-State: AOAM533c+e7DZHl6y6tSoHz9OpKada5GG1maSwPnkcBIwvgWS6+QPLAN
        ECW4e73zD9uw8ywXTp548+xoYSvrsZfXZA==
X-Google-Smtp-Source: ABdhPJwOLxxFWchHrIgECrd+tjHpeJy6igg55u3pFRd2duQPLjn+FJL3JCJGXsSvSyrPFmyyH0RlUQ==
X-Received: by 2002:a05:6402:41a:: with SMTP id q26mr3603412edv.387.1642070692336;
        Thu, 13 Jan 2022 02:44:52 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qw28sm724362ejc.154.2022.01.13.02.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 02:44:52 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7xb9-000rxW-D4;
        Thu, 13 Jan 2022 11:44:51 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 2/3] reftable: remove unreachable "return" statements
Date:   Thu, 13 Jan 2022 11:29:35 +0100
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
 <patch-2.3-7a6a69314b5-20220111T163908Z-avarab@gmail.com>
 <Yd3XpLaZ3qc25PzQ@nand.local>
 <220112.865yqpxge2.gmgdl@evledraar.gmail.com>
 <Yd8pzOh1HLvDWSPg@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <Yd8pzOh1HLvDWSPg@nand.local>
Message-ID: <220113.86y23jvrrw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 12 2022, Taylor Blau wrote:

> On Wed, Jan 12, 2022 at 01:47:40PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> >> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
>> >> ---
>> >>  reftable/refname.c | 1 -
>> >>  reftable/writer.c  | 1 -
>> >>  2 files changed, 2 deletions(-)
>> >>
>> >> diff --git a/reftable/refname.c b/reftable/refname.c
>> >> index 95734969324..136001bc2c7 100644
>> >> --- a/reftable/refname.c
>> >> +++ b/reftable/refname.c
>> >> @@ -132,7 +132,6 @@ static int validate_refname(const char *name)
>> >>  			return REFTABLE_REFNAME_ERROR;
>> >>  		name =3D next + 1;
>> >>  	}
>> >> -	return 0;
>> >>  }
>> >
>> > In this case the loop inside of validate_refname() should always
>> > terminate the function within the loop body. But removing this return
>> > statement here relies on the compiler to determine that fact.
>> >
>> > I could well imagine on the other end of the spectrum there exists a
>> > compiler which _doesn't_ make this inference pass, and would complain
>> > about the opposite thing as you're reporting from SunCC (i.e., that th=
is
>> > function which returns something other than void does not have a return
>> > statement outside of the loop).
>> >
>> > So in that sense, I disagree with the guidance of SunCC's warning. In
>> > other words: by quelching this warning under one compiler, are we
>> > introducing a new warning under a different/less advanced compiler?
>>
>> I'd think that any compiler who'd warn about this sort of thing at all
>> would be able to spot constructs like this one, which are basically:
>>
>>     while (1) {
>>     	...
>>         if (x)
>>         	return;
>> 	...
>>     }
>>     return; /* unreachable */
>>
>> Where the elided code contains no "break", "goto" or other mechanism for
>> exiting the for-loop.
>>
>> I.e. GCC and Clang don't bother to note the unreachable code, but I
>> don't think the reverse will be true, that a compiler will say that a
>> "return" is missing there. Having a function be just a loop body that
>> returns an some point is a common pattern.
>
> Right, but I'm more concerned about a less advanced compiler that would
> complain about the absence of a `return` statement as the last
> instruction in a non-void function.
>
> This is probably all academic, anyway, since less advanced compilers
> probably have other issues compiling Git as it stands today, but
> fundamentally I think that SunCC's warnings here are at the very least
> inconsiderate of less advanced compilers.
>
> To me, the safest thing to do would be to leave the code as-is and drop
> this patch.

I really don't see that, sorry. We have an actual example of a compliler
that does emit a warning new in this rc on this code, but AFAICT your
concern is purely hypothetical.

Such a hypothetical compiler would already be emitting a firehose of
false-positive warnings in our or any non-trivial C codebase,
e.g. builtin/bisect--helper.c:bisect_run(), show-branch.c:version_cmp()
and fsck.c:count_leading_dotdots() would all warn (and I just picked
three examples from a quick grep, there's a lot more of them).

So I don't think we need to be concerned about such a hypothetical
compiler. I think anyone doing such flow analysis tries to do it well
enough to not make the warning entirely useless.

Aside: SunCC does get it wrong in some cases, but it's more obscure
code, mainly from jumping into a for-loop via "goto", and not
propagating understanding the implications of NORETURN in some cases (or
maybe we're just using the GCC-specific one in that case).
