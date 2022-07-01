Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EFEC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 09:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbiGAJ0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 05:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbiGAJ0L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 05:26:11 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276835FF2
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 02:25:51 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z41so2213383ede.1
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 02:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RQJAYyV8xDyZL95im4qq+4egwvBM+iZZj56ozpfuAiM=;
        b=V5Rs/UqR9eUDrDgZ30hT2cECaqB05msPBuZT9+lIZFfNtjRfIMt7tnX532cFh2Zke9
         TEFHWYaHEPNSwDsgKWPJ9VNp9Z+/ZHalyrYtykNUPX8MFVUCCNTahmh91jOO66EbwjEu
         ZBNa8MlK+K0xh/eAPslxShHgnmRqTbR1HVG8eyLA+zG4OebR/xRLmyM8NjSeWB1Rs9iV
         ViEmiRYZx69iopPBRibXV0aLRl9ZmPHgMmTHAI0nAB8UhZLZ3BxkSQoBlSYWLCEWbZO7
         6BBmyn+MtthzGZ10gXg7li7AEyZqjFFdTBfY0AODA/VCB6FnFyXKiOpXTlYglM1ym6fk
         7mcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RQJAYyV8xDyZL95im4qq+4egwvBM+iZZj56ozpfuAiM=;
        b=1IAn6wE1VTOrG8X7I+s7tiRsfYHnP0/3PBKcUwkdcuc3iWDWx2VBHGL2ThNX4wLkA/
         jfMszrdw7kQ7zC+4uKcMXF4ezRhWd3WbTrPbfVExVLBrwcMvJMjle6iQ45E2aeDyj/l8
         5QeurXYSof/6pHq3AozI3T8ZR1VX0+6accYhBbeF2fZ+hZe/W8MSlAr6WWcGPsOT+n9M
         eRDLy+ZBYVgfCJ309d+exWZhYYfH4/LCPFWA+OXrccBUGYVmMktsfiLgw8Yq90Uh5OKu
         Oz2/HF5qlyaVTtTYT9DP03xUjlhxRZ9JVLoYPFd3t4ASQs5DsnGIdFRpG3tHezLw171U
         vO+w==
X-Gm-Message-State: AJIora9AafKwKUSxP+v+7HAJAGbbz6+MYtuI0xZQYJ491bC/3pj5JXse
        D6lphsKVMDBUO9IpxPfqc5w=
X-Google-Smtp-Source: AGRyM1vxMyrg5PHuwwUDZTNCl5VSZsK/o68+cN2m8Bv/LWFpFptCX6Mj+YiiHy8FM+hi8g9heg5LfQ==
X-Received: by 2002:a05:6402:f1f:b0:437:6c2d:677a with SMTP id i31-20020a0564020f1f00b004376c2d677amr17861364eda.269.1656667549737;
        Fri, 01 Jul 2022 02:25:49 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id pj10-20020a170906d78a00b006fa84a0af2asm10238609ejb.16.2022.07.01.02.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 02:25:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o7CuJ-0039AU-N9;
        Fri, 01 Jul 2022 11:25:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/9] test-tool path-utils: fix a memory leak
Date:   Fri, 01 Jul 2022 11:24:56 +0200
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
 <patch-2.9-06b2dcf4f12-20220630T180129Z-avarab@gmail.com>
 <CAPig+cT5jETAi5extz2tHwSzp4a=b7qqaK0S=mcjQr1m_1jAQQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAPig+cT5jETAi5extz2tHwSzp4a=b7qqaK0S=mcjQr1m_1jAQQ@mail.gmail.com>
Message-ID: <220701.86k08xb2w4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 01 2022, Eric Sunshine wrote:

> On Thu, Jun 30, 2022 at 7:51 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Fix a memory leak in "test-tool path-utils", as a result we can mark
>> the corresponding test as passing with SANITIZE=3Dleak using
>> "TEST_PASSES_SANITIZE_LEAK=3Dtrue".
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>> diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
>> @@ -294,11 +294,13 @@ static int protect_ntfs_hfs_benchmark(int argc, co=
nst char **argv)
>>  int cmd__path_utils(int argc, const char **argv)
>>  {
>>         if (argc =3D=3D 3 && !strcmp(argv[1], "normalize_path_copy")) {
>> -               char *buf =3D xmallocz(strlen(argv[2]));
>> +               char *to_free =3D NULL;
>> +               char *buf =3D to_free =3D xmallocz(strlen(argv[2]));
>
> Is there a non-obvious reason that `to_free` is initialized to NULL
> before being immediately overwritten with the result of xmallocz()?
>
> Also, pure nit, but it may be a bit more idiomatic (though I could be
> wrong) written as:
>
>     char *buf, *to_free;
>     buf =3D to_free =3D xmallocz(...);

Thanks, I'll change it to be like that. I wouldn't put "=3D NULL" there
normally, that part snuck in from some earlier version, and escaped my
own pre-review.
