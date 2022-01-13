Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3ABC433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 16:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbiAMQZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 11:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbiAMQZr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 11:25:47 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD19CC061574
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 08:25:46 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m4so24966362edb.10
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 08:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=PIiaB1/M26J5Sf6bRZJxlQzuPNYpTvZI2pcaibeB/bw=;
        b=J4katlT3IpYkATL3J6Rln65XB2TSF7D+UCVCu38AlyG+a0hshCvr1W7osQDg7L6JFu
         XhUekkjpiT4ysA5M7tZ6uK07MeviJtLBODifynnYrS6Uw6QOVfWV7CZ5AL5g2/m+0coV
         bS9VUYwCxeJbUUJk0qNzfbWXmNsBO8Y/zilJvdPIQlZ0+sTuBVh0jw8r+H3Eyhyf9f7P
         lR/XBmEz79z4pUnp4LuU+QHV2rFUT+4BYqPqjBHR47khkxNaX9WUI3v2LvwWPpEvS19/
         9RTmbCI4HeQGTHwVvsY4h4RH/GX0er74Tpy6bHtO4I+9Ai8qWLpkQmOyjLgBlv6j+A9Z
         Pbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=PIiaB1/M26J5Sf6bRZJxlQzuPNYpTvZI2pcaibeB/bw=;
        b=kgltZFRmWQfNPQksUIn+duIREUtDKbEKOxr0BYeK762VsnQ9ficDeXIiAV/cVT8vHw
         6IOIMRMa7mqHl5lGnuPtXIY6qrWtivjDsYEnOQpOi2gYWIi4fUDNvWuRAJOufhVuwHWb
         JI8B2IeXgOdGBE5TBUacLfaS3gEN3yPSbGvBqhM60UzlCUHk0O0DkKetcJD/CGwIYHa4
         RNImgnaF/hK9Hcns7QeHtzhrNyiPLqmGPFPcDz8OZ8C+0IDZ5+Ls6tL5VDPObzGSATNq
         LbZv4VC7wJfI0bMSUyKKraVesiJ4MnC5Zp2ZsJJiQaw0m0hhos8aPJ8VW35ibAQBO0SB
         /ENw==
X-Gm-Message-State: AOAM530qFcBqLbvikeqdKvDKCp3q7SIxRha35j+pY2SmcLw1Ok33Yw9o
        dee2dA/trvAeB4c+xOxz1SI=
X-Google-Smtp-Source: ABdhPJwaK2QYD3+c85j8qKsPRABkScqi+Z6OK7ogeq5AQQVNJG1jmD/8GKUVBK3VYV515I+P8F/wqw==
X-Received: by 2002:a17:907:7da5:: with SMTP id oz37mr4319317ejc.586.1642091145342;
        Thu, 13 Jan 2022 08:25:45 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l9sm1030914ejh.66.2022.01.13.08.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 08:25:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n82v2-0010Y1-Ab;
        Thu, 13 Jan 2022 17:25:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH] reftable tests: use C syntax compatible with old xlc
Date:   Thu, 13 Jan 2022 17:22:47 +0100
References: <0b86f6c2327b88886ad8667d28e0fa8382791499.1633638316.git.gitgitgadget@gmail.com>
 <patch-1.1-7425b64c0a0-20220113T113821Z-avarab@gmail.com>
 <CAFQ2z_M2ZH-8RNS_zxShkdaXdO4x4Vr8EwrFo6atd0qzyy36oA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAFQ2z_M2ZH-8RNS_zxShkdaXdO4x4Vr8EwrFo6atd0qzyy36oA@mail.gmail.com>
Message-ID: <220113.86v8yntxfb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 13 2022, Han-Wen Nienhuys wrote:

> On Thu, Jan 13, 2022 at 12:38 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Change code added in 1ae2b8cda84 (reftable: add merged table view,
>> 2021-10-07) to be compatible with older versions of AIX's IBM xlc
>> compiler. Version V12.1 of it (on gcc111.fsffrance.org) will hard
>> error with:
>>
>>     "reftable/merged_test.c", line 211.19: 1506-196 (S) Initialization b=
etween types "char*" and "struct reftable_ref_record" is not allowed.
>>     "reftable/merged_test.c", line 212.19: 1506-196 (S) Initialization b=
etween types "unsigned long long" and "struct reftable_ref_record" is not a=
llowed.
>>     "reftable/merged_test.c", line 213.19: 1506-196 (S) Initialization b=
etween types "enum {...}" and "struct reftable_ref_record" is not allowed.
>>     "reftable/merged_test.c", line 214.19: 1506-196 (S) Initialization b=
etween types "unsigned char*" and "struct reftable_ref_record" is not allow=
ed.
>>     "reftable/merged_test.c", line 349.19: 1506-196 (S) Initialization b=
etween types "char*" and "struct reftable_log_record" is not allowed.
>>     "reftable/merged_test.c", line 350.19: 1506-196 (S) Initialization b=
etween types "unsigned long long" and "struct reftable_log_record" is not a=
llowed.
>>     "reftable/merged_test.c", line 351.19: 1506-196 (S) Initialization b=
etween types "enum {...}" and "struct reftable_log_record" is not allowed.
>
> Weird. What C standard does xlc implement?

I don't know. Your guess (and searching through IBM's website) is as
good as mine.

AFAICT it mostly implements the C99 semantics, but doesn't grok the
interpolation of structs-within-structs

>> Perhaps there's a better way to do this, but just duplicating the
>> earlier struct values declared earlier in these functions works, and
>> is probably the least bad solution.
>
> I'd rather not duplicate anything. Can't you do
>
>   struct foobar *want =3D { &r[0], &r[2] .. }

Maybe I'm just not understanding what you mean, but this:

        struct reftable_ref_record *want =3D {
                &r2[0],
                &r1[1],
                &r3[0],
                &r3[1],
        };

Gives us the predictable compiler error on gcc/clang, nevermind
xlc. Turn that into:

        struct reftable_ref_record want[] =3D {
                &r2[0],
                &r1[1],
                &r3[0],
                &r3[1],
        };

And you can get gcc/clang to emulate what that xlc version (mis)parses
that as. I.e. it takes it as a reference to the nth element in that
struct.
