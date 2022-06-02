Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD4AC43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 12:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbiFBMOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 08:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbiFBMOk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 08:14:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE8E1DC843
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 05:14:34 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id rs12so9542576ejb.13
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 05:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=UOGjZjYONU95nTkqhbvKS56Cq60933fwgG7eUJn6+1o=;
        b=cjowokyYAjzqL77WoDFlZFRua1uMo1eMFfbLP0J2r//Oy1DalqYThwc81QSaIlJkZo
         D9/wKsnmGU0g9SFCyyYYPCjzmFX6IKSd3pYdUTIo7nZ6uXnqlltxCZckTyQLn/CMyq/g
         Tgplp3dp4e8PaUupeYw7Rvb54EgO8HT7WB9+rlTTFhKD2QMe3hKpoiKt/mZZd+xXcT8t
         wCYsY7HSJd8CnnIr4u803jLadz6erP6nQHh0yjQ0Td19MpDigS7td0mp+UBs407LkWk3
         Wb0tKWoZNo3lEHiEWhE6CtEKC84NnKV9zHod9GFLSj6qDFKui53+UtWdslfrIK2jhDQr
         lGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=UOGjZjYONU95nTkqhbvKS56Cq60933fwgG7eUJn6+1o=;
        b=OGnMjWSoz/UA6WWKfrCDqpJZ5RxFGbCFKBYtco273IkNvAnlX/z9T2O2LoJl3yCtIo
         ZtW8sytoYiO8XdKRLTuWK9EgB+KiA5kQOzou/7Zc1CoEWRJgRCtWExRmqyTZBCIBTX+r
         84gQh4I7I3S0gp/K9jK0AUkP0Ia4vocnp6SYkMD2zuhaijW4Q/PuWfd10cDdzmA/8h/3
         D+ppyUHYIfTf+SfHy2KzxVwsFlbIdD/j+3hDOSuiPKLYVXuVuwgu9AwQ8kdxjaitG+3C
         k/bQUAmBnUiKI5P2Q3AmWkppYXKGxWvNKTJn7Q3ZW4E1Nab41Q73mT//nuFfC1HRnqQ+
         lR6A==
X-Gm-Message-State: AOAM532Iav4sDAIthviQ4Wahm6cwL2zfN8WVDXeQ18ucvvw7atRCc2Oy
        V2ftYhyOL3HYHj/t65djB0Cj/3D0uYn8NA==
X-Google-Smtp-Source: ABdhPJzCrKldSFOFfPkBdr83wB6wYV8o3izbtmPu5HYzfbQR235miSB+YJ+oP+8FcDXKTHL/JPCZrA==
X-Received: by 2002:a17:907:9494:b0:6fa:78f3:eb9b with SMTP id dm20-20020a170907949400b006fa78f3eb9bmr3905863ejc.704.1654172073162;
        Thu, 02 Jun 2022 05:14:33 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id d22-20020a50fb16000000b0042617ba6389sm2377989edq.19.2022.06.02.05.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 05:14:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nwjih-001RWi-Bg;
        Thu, 02 Jun 2022 14:14:31 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/env-array (was: What's cooking in git.git (Jun 2022, #01; Wed, 1))
Date:   Thu, 02 Jun 2022 14:13:31 +0200
References: <xmqqee07q3xc.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqee07q3xc.fsf@gitster.g>
Message-ID: <220602.86a6avz2hk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 01 2022, Junio C Hamano wrote:

> * ab/env-array (2022-05-20) 4 commits
>  - run-command API users: use "env" not "env_array" in comments & names
>  - cocci: remove env_array -> env migration
>  - run-command API: rename "env_array" to "env"
>  - cocci: add a rename of "struct child_process"'s "env_array" to "env"
>
>  Rename .env_array member to .env in the child_process structure.
>
>  Expecting a (hopefully final) reroll, before merging it to 'next'.
>  cf. <xmqqilq0jhk2.fsf@gitster.g>
>  source: <cover-v2-0.4-00000000000-20220520T072122Z-avarab@gmail.com>

I think it should be ready with the v3 I sent today:
https://lore.kernel.org/git/cover-v3-0.2-00000000000-20220602T090745Z-avarab@gmail.com/
