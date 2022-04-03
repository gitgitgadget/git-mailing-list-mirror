Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF92C433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 14:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352073AbiDCOFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 10:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241200AbiDCOFa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 10:05:30 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF7A277
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 07:03:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id u9so3025151edd.11
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Et533A6XGS8cweAlPbuU7eHzQdwisWDCaaWOg48571s=;
        b=gcqG+GEQcA0Web6LK16BLHwm9XVPCmuEu4guYjqUUjy4Do7n7a7N1L2lr2zdMbAgpz
         4ORgg1NG0Y+Znt9GMR9rR8kaViqN8ZvfFeP04m30RBBgyPi2nuQbW2RAjcDOYT/3dYRm
         8vOaMdX8P7NTUiXbNTYl9+AIMcOzVDpq9908xRqSC/AD8sBQItUXKprC8gqTBaWhL234
         o3CiCSOZ2sq4BeEfyS6VoPBMR8GsKoJOXti5oDnZu1BcmBNyxMvy5HgfTbrDZ4ERTpTY
         OL5teUjb4QYH7640+s+OvT/M31vChH6GEbcI+yhzBDYu+UC+GWrLKT/Skr27+uaZ80AX
         XsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Et533A6XGS8cweAlPbuU7eHzQdwisWDCaaWOg48571s=;
        b=rClBZOt+/X8RzbCtT+qU3II5PLlHrIxVizcHkZijdVZPOBXg1X4QAMQnr1bV+fnGdk
         /tszzJPiWMiKzhvws7tSmdUZ5i9icr8EkLJk3zVohOxjsNfiyPEajsC/1dxd1sz34N+P
         xTdOP7dwwdD9wN1wZTjKckjXa6tr3CAQoj0jlVYvAUo1mlWkLJ29W4r1+3lB+kUK/6al
         hGCUyVoxXJM4Xfs4/c43qF/aKDe5KBcj2g7paIn/cVxFc5OMxh77SE4HDZhIiAbZG3wx
         a38psJk9P0skWKKMr/4w6om74ZZeptt18ZzAoWBwHZ9LfrKKV6Q8eRU6h2ObXP7OPa0V
         BROg==
X-Gm-Message-State: AOAM533h8BpR3hytKusuPhuQHoA8kTV1JxnvOxSHShUrIaiKoRf34/E9
        QXURmBdFWTHoqw2ATyDgHMJe3V5vfmo=
X-Google-Smtp-Source: ABdhPJyh+w+iVHTnVTuEpLO4j3W+GJEhR5/ZYLemURSqakEAjeaxXkZsYxLMw5W5LeXkPH1hIHLomA==
X-Received: by 2002:a05:6402:4407:b0:419:3859:697e with SMTP id y7-20020a056402440700b004193859697emr28993717eda.400.1648994613217;
        Sun, 03 Apr 2022 07:03:33 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ky5-20020a170907778500b006d1b2dd8d4csm3291058ejc.99.2022.04.03.07.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 07:03:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nb0pI-002DsY-1l;
        Sun, 03 Apr 2022 16:03:32 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v5 18/27] revisions API: have release_revisions()
 release "cmdline"
Date:   Sun, 03 Apr 2022 16:01:39 +0200
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
 <patch-v5-18.27-7987c748ba4-20220402T102002Z-avarab@gmail.com>
 <02da5550-3137-b579-93c5-bf245a8cbc2a@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <02da5550-3137-b579-93c5-bf245a8cbc2a@gmail.com>
Message-ID: <220403.86ee2emfgs.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 03 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 02/04/2022 11:49, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>   +static void release_revisions_cmdline(struct rev_cmdline_info
>> *cmdline)
>> +{
>> +	unsigned int i;
>> +
>> +	if (!cmdline)
>> +		return;
>
> I don't think we need this guard, the only instances of struct
> rev_cmdline_info exist within struct rev_info, as far as I can see it
> is never created on its own.

Yes, it won't ever be NULL. I'll fix that (missed it with the other NULL
check cargo-culting).

>> +	for (i =3D 0; i < cmdline->nr; i++)
>> +		free((char *)cmdline->rev[i].name);
>> +	free(cmdline->rev);
>
> This could just be in release_revisions()

Ditto <220403.86ilrqmflb.gmgdl@evledraar.gmail.com>. I.e. I'd prefer to
keep these for readability
