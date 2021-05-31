Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9D5C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 20:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5703B611CA
	for <git@archiver.kernel.org>; Mon, 31 May 2021 20:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhEaUpm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 16:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhEaUpk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 16:45:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B380BC061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 13:43:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gb17so18293587ejc.8
        for <git@vger.kernel.org>; Mon, 31 May 2021 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=BVneFUKc+0imrewzZi5zB8r3NFHf8Xr6PW5daNUgjl4=;
        b=XR0J1sTS8cqQIPq/EwP6ysZZO9i9lcIlxQwVLJcYU19vigT3TVDfG5/mD8tjIKXT1g
         9ukDiS6klPMRpPzhmBXkPAP1eZj0yjdX/7DTmnY+lkjiClWgfBgBARVP2HFmpAKJbi2G
         vyVCRXa+w0bo6tXKwnOKq4EQEKsFqYs3qSCaVPxMbF+nD2ip81IZbMDfAwA96dzTzMH5
         LQGu3p1EcFLV3lUp27YRPvob0j4bhXVX774HDLeMznqDrBRN/WhJAfxi7oqJCOlghWGF
         pzBu87RlAspYhLqb9M4ImoEhsMrbfHQLbDFf41MvLGRQBbdzR9gpK8DYgTnwfRx3O5Xz
         95MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=BVneFUKc+0imrewzZi5zB8r3NFHf8Xr6PW5daNUgjl4=;
        b=IxztVoHjuPbtKEC44W/bV+7Tk/ZdM9+oOmAzdI9V8Nx6sn13cW0ESk4Ile3WFfRTH3
         fn5KntYGf2g4qk0qSG8JTfcVJIl6xrEr9gn4QWBWmaRUMM0szZh4cgvdUxrwsZ1N0OVi
         tvSUukkc2q0fCAr7+/tmSZwAgYb3PDJT2wlpLjXO+TltUaJpmNKwH+ykakvzkPe0D+XP
         daEXoxIKkfNRhJtBMEwf3Lwk8L0B3s8J73a8VhBE/XrtEeg93gCQMZQHdwnnVVi8vS27
         t5KAc01HmV+H5T58eJ9e7/1lwvL5XRb0LGjuVIAvKDgj9YwjxkLkT8fbc+SivyLwE5q9
         pzhA==
X-Gm-Message-State: AOAM531/QCfzRGe2pC0I3Npj/5kCSOQ/OzKCJyUQ+A9D3eeDWRc6e4gs
        vjX3J5RV88CXHnuW446wMy0=
X-Google-Smtp-Source: ABdhPJx9nA3kibCvJhn+Sz2u/vatNvqY3t++sWKMWZQFQvm5WAT7adpvhN1F4HChyTiiViKrG1nFSw==
X-Received: by 2002:a17:907:990f:: with SMTP id ka15mr24721471ejc.132.1622493836132;
        Mon, 31 May 2021 13:43:56 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gn26sm6021936ejc.6.2021.05.31.13.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 13:43:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] t2080: fix cp invocation to copy symlinks instead of
 following them
Date:   Mon, 31 May 2021 22:41:12 +0200
References: <871r9n2dlu.fsf@evledraar.gmail.com>
 <20210531160903.42347-1-matheus.bernardino@usp.br>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210531160903.42347-1-matheus.bernardino@usp.br>
Message-ID: <87v96y1vn9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 31 2021, Matheus Tavares wrote:

> On Mon, May 31, 2021 at 11:16 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
>>
>> There's still a failure[1] in t2082-parallel-checkout-attributes.sh
>> though, which is new in 2.32.0-rc*. The difference is in an unexpected
>> BOM:
>>
>>    avar@gcc119:[/scratch/avar/git/t]perl -nle 'print unpack "H*"' trash\=
 directory.t2082-parallel-checkout-attributes/encoding/A.internal
>>    efbbbf74657874
>>    avar@gcc119:[/scratch/avar/git/t]perl -nle 'print unpack "H*"' trash\=
 directory.t2082-parallel-checkout-attributes/encoding/utf8-text=20
>>    74657874
>>
>> I.e. the A.internal starts with 0xefbbbf. The 2nd test of t0028*.sh also
>> fails similarly[2], so perhaps it's some old/iconv/whatever issue not
>> per-se related to any change of yours.
>
> I ran t2080 on the same machine (gcc119) to try debugging it but I could
> not reproduce the test failure [1]. t0028 also passed here. Could it be
> that we are building git differently? I did `gmake CC=3Dgcc NO_CURL=3DYes=
Please`.

t2080 is fine, it's t2082 that's broken. But yes, we are using different
parameters. This works for me:

    gmake CC=3Dgcc -j3 CFLAGS=3D"-g -O2" NO_CURL=3DUnfortunatelyNot

This doesn't:

    gmake CC=3Dxlc -j3 CFLAGS=3D"-g -O2 -qmaxmem=3D524288" NO_CURL=3DUnfort=
unatelyNot

The reason I test on AIX / Solaris is to get from under the GNU-isms of
various libraries & away from the gcc/clang mono(bio?)culture.

I.e. you're testing with GNU iconv, but IBM also has its own
implementation:
https://www.ibm.com/docs/en/aix/7.1?topic=3Dprogramming-understanding-libic=
onv
of that POSIX interface:
https://pubs.opengroup.org/onlinepubs/9699919799/functions/iconv.html

Perhaps we've had some GNU-ism slip in somewhere...
