Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E34C4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 07:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiKYHVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 02:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKYHVI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 02:21:08 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B4DDF85
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 23:21:05 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id y4so3261426plb.2
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 23:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POzvCcgZJQauODcIh0cFLFgNWu9tJBfvYTv7IJSIa8Y=;
        b=P/QlZh5OFNeQh+jfCee0GrkpzpZqmOrmdqkkJoLVWgZiOCFKeFeANMHRyogkEHAJJ0
         xuzxIzpy2glAUPrixnyDZl0T3FdZd1yFIDrdpe4FzpLdxjZnZiaUyf272CeD2azhrPRC
         j7whFgtWWeYAFB/7j34wBFbP8Ezqr7WuN/eGN3FMUx7kQEbzTI6TQGRmWdR3SSC4ixGC
         BCi7a5jJ2USFSpAU24Zoif/kxT0koqR7nsu58zdqpA3SJpDVc2ehK5Vhplct7LFRMwEJ
         HUtGUc+hcdKWgDLJsYtFoCJqJWU7jLXNzkUMps8zy+Ji47B7GDBCUnmFS1xuQvu7h5gI
         3hTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POzvCcgZJQauODcIh0cFLFgNWu9tJBfvYTv7IJSIa8Y=;
        b=zA3UxUNtF4OIR1vN+UkCqpTc5pePfXqbqRX5LtrHOozNtJ6JeZz4urwyIXasklty07
         Q/mPGCEsM3Fkv2SS1kbx8qSOo6lylKJWvsEb2nu26bievOsFufTQKsFsO6o+11dgDrVa
         SOOeBVpI1gvTnQx5bzrIPy0sXe2ChHIISPtc6ThSkVdzPmjKgWVlEnV21W0CAX1NGTVF
         JeMXGextsBooWVJ3gCP5qB5YMe676hHGLXnMjDpYu4iMaaxY2Mw0mi3HMJs2/9YrxpSW
         UATyf9pg2gqER8pQDJsMPEi+4JaRf14GC784ZB8xPpP8FvO8dADY1OYn9SuWJX6uatwE
         RBxw==
X-Gm-Message-State: ANoB5pl+zD7YdwJgaT2KyqWaWfnunPvXnwTMPP/zwyfrCUCqt+fL/K0o
        NAEP9jU/5csFD2UBHuH3vFY=
X-Google-Smtp-Source: AA0mqf43YIosFhEgwajNofa41xUFRbmI8zxL4/nJ+LZsHtDJzp0/pW/gizj9d0UTHuzweWgjoD25/Q==
X-Received: by 2002:a17:90a:1bc2:b0:218:8bdb:de3f with SMTP id r2-20020a17090a1bc200b002188bdbde3fmr32073213pjr.225.1669360865328;
        Thu, 24 Nov 2022 23:21:05 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u6-20020a170903124600b00186fd3951f7sm2580396plh.211.2022.11.24.23.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 23:21:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 1/3] github-actions: run gcc-8 on ubuntu-20.04 image
References: <20221123150233.13039-1-worldhello.net@gmail.com>
        <20221124090545.4790-2-worldhello.net@gmail.com>
        <221124.86mt8gpqra.gmgdl@evledraar.gmail.com>
Date:   Fri, 25 Nov 2022 16:21:04 +0900
Message-ID: <xmqqpmdbcxen.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Because while I think a non-pinned "latest" sucks because it forces us
> to scramble with updates like this, having a "pinned" image go away
> entirely (because nobody noticed we should update it sooner-than-later)
> would suck more.

Yeah, that matches my preference, assuming that we do not have a
pre-warning to help us avoid scrambling either way.

If we have such a pre-warning, I would say it may be nicer to pin a
version, even if the only upside is that we can say we test with
"this exact version".
