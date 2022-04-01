Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F647C433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 17:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349985AbiDAR13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 13:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349931AbiDAR12 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 13:27:28 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5811DEA96
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 10:25:38 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c62so3735020edf.5
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 10:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=BDsf9DFcLIOnBPnk5UPKGVOam2cvZi6CRUE1haIOwqo=;
        b=fBJvg9W68zHUTvDQhnjY3zK9sH8z1+/8tTviWxTW/TGx8KNHXInMggNiKto05eHWiz
         mstfwfK8sYMBSCfq9Ir18EbUCkW5MaDGibxh1/gA/0zq8CpoeQ28eELu8Ik9/FE5YRbp
         BRm6AVYn7k1L67jv3DZs47Glx97eCWOnApYlHBrjZcI7ZeXRfsq5QZuLLvxYC9P9UAM2
         cj3uQY2+Ac2vcul/5Rw5a8ors9sE7OypNDqewhhh+WhEsbxKNrdbDky4M4mNPS6Ho+rt
         flkBBD21sDAjFL1mBryEXuh/q5GW7355JClP12KmpUnilSJZUpovpEpcHMfMgNAo7/BU
         7nmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=BDsf9DFcLIOnBPnk5UPKGVOam2cvZi6CRUE1haIOwqo=;
        b=pMFt9+ynCaWlUY9d6LrL5/1nW4rucbc+ZKHDZYRqmMQMz2RFPtVEFR+F2Z4p0n6i16
         m2xRQGG6agLW15pqUs8gWliZqhApOlpyUgehmemj+R1hkxQfyocaeLEJxvaeUsr9p5pv
         elzP7LyK+tsbTDDtbmE0ph9TCqXCA8AcnHFc0rE7MOzaVeMu3htWoq4YsoSqAMBbelOa
         bPCk/9OwxRL3W6a0jKu/MlYpPVcx7T0uxccHA1S7X5Hhd2RYgLoP9I2GIr6kgio9XnfX
         ijo9PQcY4EoRq04+0cHEn8gm83VoTSC73+geVXakX+h3qov4fl0ojnVpND2MhKsEmCwn
         P7BQ==
X-Gm-Message-State: AOAM530bXfv3l5mdvYTO1evaC2l7omguBdPSgmyOslZF1U+mZulY0QwE
        uk1NvhyILm7PQgfEgXpqthCIqY0oWLY=
X-Google-Smtp-Source: ABdhPJwiqrwsewUq0nelYtnTxSCLLk8b/tdjgaB0kwih9cq3jO3vHc4WdOep0lwmPXfeIh+qBQlzyQ==
X-Received: by 2002:a05:6402:354b:b0:419:4af8:c5c9 with SMTP id f11-20020a056402354b00b004194af8c5c9mr22351949edd.91.1648833936565;
        Fri, 01 Apr 2022 10:25:36 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id jv19-20020a170907769300b006e095c047d6sm1227707ejc.109.2022.04.01.10.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 10:25:35 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1naL1j-001GV8-F5;
        Fri, 01 Apr 2022 19:25:35 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 06/27] revision.[ch]: provide and start using a
 release_revisions()
Date:   Fri, 01 Apr 2022 19:25:07 +0200
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
 <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <patch-v4-06.27-b9beaba16bf-20220331T005325Z-avarab@gmail.com>
 <fb26835b-c2fe-be3c-a7c4-6ea8b5748969@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <fb26835b-c2fe-be3c-a7c4-6ea8b5748969@gmail.com>
Message-ID: <220401.864k3cogvk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 01 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 31/03/2022 02:11, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> The users of the revision.[ch] API's "struct rev_info" are a major
>> source of memory leaks in the test suite under SANITIZE=3Dleak, which in
>> turn adds a lot of noise when trying to mark up tests with
>> "TEST_PASSES_SANITIZE_LEAK=3Dtrue".
>> The users of that API are largely one-shot, e.g. "git log", so
>> arguably freeing the memory is a waste of time, but in many cases
>> they've actually been trying to free the memory, and just doing that
>> in a buggy manner.
>
> I've not looked that closely at these changes but builtin/log.c is not
> modified so I'm a bit confused by the mention of "git log" above.

Along with git-rev-list it's the main user-facing interface to
revision.c. I'll clarify that in a re-roll.
