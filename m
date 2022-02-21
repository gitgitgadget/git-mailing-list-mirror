Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ADEC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 19:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiBUTBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:01:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiBUS7s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 13:59:48 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78707BC28
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:59:24 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s24so24903666edr.5
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=jBr38zjcIkHGN5/eoR+vAI3D9L3FzIrHe5UiQH1o3bA=;
        b=J5ySeQidWMRxibIhuG4uxpTd80FkdLkFcDcpdOiUPC4l1csmzSqilnCYTrv+uQmBm9
         hX8PCNzrJM/CqeyWUrH1vzQbsdLWtzl9SMp9nv9LkwyvLREETLOmwx/ENls+m4SLHzUh
         zoNIGk6jnBT5NA/gGZ5O5ElGwpIvleOEx/GUKjH2oeOF9/mSpdk1AChP+j6T3R0U77Y4
         0QLgjae1FWwl5S77CM5Ge73r0LXm1vKgRQRxUl/x9glnj3Ye047lIETGSqG/ymEDPmHt
         EWhEKWqfi1H3fkp0yiGGvY658R1MAAgLgRRE0zxR0FDT0BrgUPPm7ivh9C/9Ij3j2UIL
         PkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jBr38zjcIkHGN5/eoR+vAI3D9L3FzIrHe5UiQH1o3bA=;
        b=cjc2fo31exuekedqUgWaNC7uWIibUTBK7Bj8rseUy6YtWBkOrBm6a41sh/G3Cw+B80
         TVsZygAQrHwlxlKzoSW5Av9KhruJ+B77jBJ9+7XY34oyYG0N5aoGbYM8nGIumYATiq3m
         cjkX0IA1WdnDYYBugOX0XYgN+WBRUQomrFCJSIuJarvxMyzdDeaurSaIs8V5Kb9k1/C6
         DQuR/eB2wlb3CsqiiaIVEGJkLPIvdrngIOqkL7kjxUgHovtUN56zP1xkfDtJ58OPRXz/
         9E/XSYADIsebeTrk34RM/SNR4U+tx7LWfmPZisG80+FxvgibKfQsBOF7BoLiAHONEEBr
         J0+g==
X-Gm-Message-State: AOAM532xXqg3gTCWoeKm1bE+GGagNkdUIB4U9xQzb0wVnEzZDkY3xi/+
        zYwWj879srfbG0xi9JiQrGI=
X-Google-Smtp-Source: ABdhPJztiD/WaMcfLKZNJ7OLxoW1/lprrrLRolRIkbna4ffw2mDCwKL/xz8is/NEK9N9E5NpCKy6tg==
X-Received: by 2002:a05:6402:34c1:b0:412:d12c:e713 with SMTP id w1-20020a05640234c100b00412d12ce713mr15920462edc.312.1645469962997;
        Mon, 21 Feb 2022 10:59:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 5sm9206734edx.32.2022.02.21.10.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 10:59:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMDu5-005l4v-9e;
        Mon, 21 Feb 2022 19:59:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] test-lib: make $GIT_BUILD_DIR an absolute path
Date:   Mon, 21 Feb 2022 19:55:50 +0100
References: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
 <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
 <patch-v3-3.4-b03ae29fc92-20220221T155656Z-avarab@gmail.com>
 <YhPL+wSxtI0KIz07@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YhPL+wSxtI0KIz07@nand.local>
Message-ID: <220221.868ru4avw6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 21 2022, Taylor Blau wrote:

> On Mon, Feb 21, 2022 at 04:58:34PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 77c3fabd041..ff13321bfd3 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -41,7 +41,7 @@ then
>>  	# elsewhere
>>  	TEST_OUTPUT_DIRECTORY=3D$TEST_DIRECTORY
>>  fi
>> -GIT_BUILD_DIR=3D"$TEST_DIRECTORY"/..
>> +GIT_BUILD_DIR=3D"${TEST_DIRECTORY%/t}"
>
> Sorry to notice this so late, but this hunk caught my eye. What happens
> if `TEST_DIRECTORY` is provided by the user (and doesn't end in "/t")?

I think that the preceding 2/4 should cover your concern here, i.e. I
think that's not possible.

> Before this change, we would have set GIT_BUILD_DIR to the parent of
> whatever TEST_DIRECTORY is, whether or not it ended in "/t". We'll still
> do the same thing with this patch if TEST_DIRECTORY ends in "/t". But if
> it doesn't, then we'll set GIT_BUILD_DIR to be the same as
> TEST_DIRECTORY, which is a behavior change.

Indeed, but I believe (again see 2/4) that can't happen.

> If you just want GIT_BUILD_DIR to be absolute in order to for LSan to
> understand how to correctly strip it out of filenames, could we replace
> this with:
>
>     GIT_BUILD_DIR=3D"$(cd "$TEST_DIRECTORY/.." && pwd)"
>
> or (an admittedly less clear)
>
>     GIT_BUILD_DIR=3D"$(dirname "$TEST_DIRECTORY")"

Yes. I almost changed it to the former in this re-roll, but as noted in
<220219.86y227fvz1.gmgdl@evledraar.gmail.com> thought it was better to
have it clear that this really wasn't a generic mechanism, we really do
need/want the actual "t" directory here.

