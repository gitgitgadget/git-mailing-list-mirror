Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B122AC54EE9
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 17:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbiIMRMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 13:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiIMRLx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 13:11:53 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA14A9C29
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 09:00:32 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id c11so8970831qtw.8
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 09:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=bz+qyJqqIpnRN1V+IiS1nIcA0xmIBSdHFpPtw0Scud0=;
        b=DSOJM3De2TLE0rNaPyr3fNXi/YqzTpuYZVNV0O0n+pNhKSgs98nUy6zvG+NbA9bIQw
         hscGCFDPAQuDoiXRj9SQ43yPUNrZhGhONtO5v523X5yXMtikhKWCGN2Qt9afgaBm7dxb
         rL613QxhiPEYQWcNtl+f2nl4IPtefqTrqAMA9gNyb5yygRJgMM4KkUuJd9Rez6hYmjxk
         U7dBbSuLhjDpV3V9ErdpPYeEnMEG6MENXx1bXWHyJ6tRx5QNld+fKLo/JF9DorOjpiHz
         x+2KBCkz1x6T8MskPG673RdsR2WgjwLa9L1le8A629gJww6VrVVh6Np1k60wi6eavJos
         ZeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=bz+qyJqqIpnRN1V+IiS1nIcA0xmIBSdHFpPtw0Scud0=;
        b=RfCCwhXWpuBMag8AnvIJoJaJ0OaTCVo979fzMYq/rr+kmyTwIzMrbR/XTpBzkTFZI6
         2wA4ftMFXUFbSmYG8DCdx/21YXbbedhuPk4xx8gIHmxRxHWlg1HgSbCgqG2XBODasMcb
         2P7vmC+N0sJxCJTSfe1iXrXndo+anOB+7KaLRskA2x64tUm0VBgUB6cSVzfzHQ08NxeC
         QzSzsDB4DjXY6hV1uwOrOM2Kl2iz5Xi3DVBg5U39c8QNdvqBJaSMEUpJgbRBZLiBOuEE
         YKZhbnkPSA3Re6X7mHxrP/yE7JyO9TBC4rSZE9qslx1EenM2NJnl5L9fX6kZbElvu0G+
         cO2A==
X-Gm-Message-State: ACgBeo3GqM510QwGmcM+d0mB+qG+TlCC6I0RbFv64lbFQnYwu1B6cvqD
        RINu+zuBIoaQhMKY9piHI+8hdHdlj2Q=
X-Google-Smtp-Source: AA6agR5zslZ2oURZvWeu8msf5G1J3VJ2ETF0JQHU8PRuVB+Zxf29y8ii4HicCx5eVqX/uppgQGeizw==
X-Received: by 2002:ac8:5856:0:b0:342:f8bf:3582 with SMTP id h22-20020ac85856000000b00342f8bf3582mr28267440qth.573.1663084818898;
        Tue, 13 Sep 2022 09:00:18 -0700 (PDT)
Received: from gmgdl ([50.225.1.251])
        by smtp.gmail.com with ESMTPSA id z24-20020ac84558000000b0035ba4e53500sm8604340qtn.56.2022.09.13.09.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 09:00:18 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oY8Kf-000I9T-1X;
        Tue, 13 Sep 2022 18:00:17 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Arthur Chan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Arthur Chan <arthur.chan@adalogics.com>
Subject: Re: [PATCH] fuzz: add basic fuzz testing for git command
Date:   Tue, 13 Sep 2022 17:57:25 +0200
References: <pull.1351.git.1663078962231.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1351.git.1663078962231.gitgitgadget@gmail.com>
Message-ID: <220913.864jxb6z8u.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 13 2022, Arthur Chan via GitGitGadget wrote:

> From: Arthur Chan <arthur.chan@adalogics.com>
> [...]

Just a quick comment. The coding style of this project is to:

> +void randomize_git_files(char *dir, char *name_set[], int files_count, char *data, int size) {

...try to wrap at 79 columns.

> +   int data_size = size / files_count;

...and to use \t for indentation, not spaces.

> +   for(int i=0; i<files_count; i++) {

...and e.g. to use "for (", not "for(", spaces around "<" etc. We also
tend to pre-declare "int" instead of putting it in "for" etc.

> +void generate_random_file(char *data, int size) {

Can we really not use the APIs we have already for this (maybe not due
to the fuzz testing aspect of this...)

> +   ret += system("git add TEMP-*-TEMP");
> +   ret += system("git commit -m\"New Commit\"");

(I have not looked deeply). We usually write *.sh tests in t/*.sh, can
this really not be driven by that sort of infrastructure?
