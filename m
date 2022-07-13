Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D764C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 20:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbiGMUEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 16:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbiGMUEd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 16:04:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B43310574
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 13:04:33 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id b11so21730432eju.10
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 13:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=SEWfEQhMCSJH52+6l0fzF4yvFxMSHkALUKnVyJK2Ch4=;
        b=BagHPPPw01yAv80yk2HVUD0cCbBoelCXJTSZFCUjhG50K3xPq3mw+Blo5H7U3E0aUF
         B3yZKnoy9sS2Kc0BfJ/aC7DCCEJPu6nDGmULBvQq6ngONUwho8WBML/Wp4zOt069ypGi
         BiW1NmZCnqonUXPCjWMSJ0pa5V5b9CGdbxFY+kzC0F94yBdv6t0gT0+UoLtlFEAYqiwA
         2sKvatTXqK4vzaLf9YdqpbROr9PfITTg9ODTE96TTx+AIiI+1TJMi5mgFEbpISmwENo5
         kkW6KAJZdLdcrqESLwv0Q0AhDkStqPk3MW+4uI1b1nYcuVK0BWC/NFeJiyVUwUjpJS+I
         fYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=SEWfEQhMCSJH52+6l0fzF4yvFxMSHkALUKnVyJK2Ch4=;
        b=08LuvuKlWoSbhttCGkkDuOCWkUCzDBnZfpvMgKmZhUrb4ZX1W4rU2q/R9xbAkSvWgG
         EwzopDONlh4hcPg4hxe4g1ksPl7TWRoYOfzMrgbb3o+9WJguXx9ue6ghQz1beNFwXNb+
         tFe/pYQC6yoYGrfGGwYG51pXbQbas39F23dftTcU4VC2kiyLb5IuYk3XCC4soAh4h1wy
         KVVBKiwpat30V3Wi0/p0IVx1lrwfKRYHnOUwbDzv1Ww3rVhiWaRIwW8bv92fdwAEe8G/
         R0ukXWTxg8ZVNvVRbq8uaZDyjqXWlyCfjne1msbKN3vNLCZfBSNvUAjbGX0zQU2qK2Mn
         dSYw==
X-Gm-Message-State: AJIora8BtEqHnE42BJU49OXbyPYYH0aF+xDg3dkt3XtnfFs0gzYe2FiL
        yOJpteJ6OGFrcjyC1+24Vc/wGqzhfRlBkQ==
X-Google-Smtp-Source: AGRyM1v2xLRpyNrWo5TZPpkQDAdgR6+DsFRTpXrwogEJpKvspJgti1H4uUpUPSpaWNvyw9MZKHlRNQ==
X-Received: by 2002:a17:907:3e08:b0:72b:5af1:5f31 with SMTP id hp8-20020a1709073e0800b0072b5af15f31mr5381111ejc.277.1657742671605;
        Wed, 13 Jul 2022 13:04:31 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j21-20020a170906255500b006feb479fcb4sm5345773ejb.44.2022.07.13.13.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 13:04:30 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oBib0-001w3l-29;
        Wed, 13 Jul 2022 22:04:30 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/3] Use "allowlist" and "denylist" tree-wide
Date:   Wed, 13 Jul 2022 22:02:45 +0200
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
Message-ID: <220713.86sfn43hkh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 13 2022, Derrick Stolee via GitGitGadget wrote:

>  sha1dc/sha1.c                   | 12 ++++++------

Aside from anything else I've commented on: Please drop this part of the
change. If you'd like to change this take it up with upstream:
https://github.com/cr-marcstevens/sha1collisiondetection/

As a "git log" on "sha1dc sha1collisiondetection" will show we try to
keep a 1=1 mapping to upstream with this code, this would both diverge
us from upstream, and diverge sha1dc from our own submodule copy in
sha1collisiondetection/".
