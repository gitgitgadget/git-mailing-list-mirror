Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C47C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 18:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346777AbiEZSul (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 14:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348793AbiEZSuM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 14:50:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD845623E
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:50:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id wh22so4683476ejb.7
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=hhwfcD1dvEzwP8t+6Gv6X/a3EFZXax23GKFnJXUfnyc=;
        b=kfq0kHPmhygxr/oVNWS+CauYFFi0wwMC1z7zS7RwBRe9dKcxqQxcetzwb6xlmKpjrU
         zaYSUNuGprYOHIptx4tGvEEg3KYL6G0Xjrh6g2sFr0KqOdHNy0d+q0uglVWseIuhIHmX
         65F1KMN6tnrdwEiB8IhZY7xj1vzli4qaWLVqYevyNGHNqPUTQNAAqxJPN1kOX0td1B8Z
         jNFyisv4VZj4x72V/IFT1AM+Qd7teuJRgVqgtQ+aHOnBvhXr84xJ50YHbP7k5lGS3Eae
         ggpG6TZagiLY2vTSPrTrwSDXQKxwCTsY9ZOSmfsW9pXME9JDNDEMy6Ym8ys4XWH+nsTx
         1+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=hhwfcD1dvEzwP8t+6Gv6X/a3EFZXax23GKFnJXUfnyc=;
        b=J9JiDJE8KKxK7CjkxGKSDpnfxVf6tel/OAdVVlzBFTXdHmFhvw3pc2E5H/8mVPt56H
         jNXtA8xPdazcRh1n14TT0n0SUQOeDolWPeRmzCv4RtTqY4R//yh2Pqy8KQzbnMN4Ja02
         pDCQq/mNcs8E82Vgwf/4IwB6ah23xzJjMtvZVfgvVKlSCus3mj5oA/SSdv1OaqECDTOk
         aoJe6DlGps0fCKTaORWf8sZUXjTYRkc40Me0uVbl6c4dPCwX1Tr05mljAHcCcg64eHJc
         XJc94nRnPkvxlp8iNryQE8vmprgW9vEtV/I/YYN5chqyWSG6SKTMHYkQhbq12iF9SMbn
         L20Q==
X-Gm-Message-State: AOAM531ou93YP60EOMszmExmtV2YdrDjY/JupWC33noJghd3SOAozjT6
        ZtRfTUaYOTKK0SKtcQvT61f4do2bYYyiQg==
X-Google-Smtp-Source: ABdhPJyr7bW30StbUlx/cY4IVEQCQSyxl8vfvY8McI0iufXAPNwFmdby0Mh+lL1I7jE/L4Ejb15xUA==
X-Received: by 2002:a17:907:2d8b:b0:6fe:aa75:6609 with SMTP id gt11-20020a1709072d8b00b006feaa756609mr29215299ejc.468.1653591010170;
        Thu, 26 May 2022 11:50:10 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id y26-20020a50ce1a000000b0042ab02e3485sm1092265edi.44.2022.05.26.11.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:50:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuIYj-000Fg4-Ba;
        Thu, 26 May 2022 20:50:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: sg/build-gitweb (was: What's cooking in git.git (May 2022, #07;
 Wed, 25))
Date:   Thu, 26 May 2022 20:49:12 +0200
References: <xmqqzgj41ya2.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqzgj41ya2.fsf@gitster.g>
Message-ID: <220526.86zgj43z8e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Junio C Hamano wrote:

> * sg/build-gitweb (2022-05-25) 1 commit
>  - Makefile: build 'gitweb' in the default target
>
>  "make all" should but didn't build "gitweb".
>
>  Will merge to 'next'.
>  source: <20220525205651.825669-1-szeder.dev@gmail.com>

Did you see the discussion about what that costs us in terms of noop
"make" performance? See
https://lore.kernel.org/git/220526.86k0a96sv2.gmgdl@evledraar.gmail.com/
& https://lore.kernel.org/git/Yo8y3AHWa3PChLwd@coredump.intra.peff.net/
