Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DA3C05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 21:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjBHVW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 16:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBHVWY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 16:22:24 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1704937565
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 13:22:24 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b5so421316plz.5
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 13:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaFLLxph9xOodqATi4GZgbnbphTOlULAiIhPWTQaOss=;
        b=a3DQjDOSVZi5cW59uACb2aSzsdNZ6Ecuwbv3sHOiQrjTbAEh2iDMphtO+4KEqdk8qe
         1R39Kq6ppiTPCtiKP4pPH2Q0dQk3qAKElV4vFLMPN6o8NZpb3A/YxohnprR/KeiMh3ot
         knOCC58WIG/nvP9eyHFtGMK945EiCJrROjHMadO8zHHer60lrGlo8MfNdlYdIMigj4ka
         JJdNr9I5o1u/qitE0zBPmfj5igb8N4mYea398Lq6X/P9JxbJKnlDcdgH4dIy1qwNdkWv
         78cJAwKwPgHX8R0nCoKVdBnCJ1mVQjj7qLmOuD313SZ2BLEy482prB2Y6x+tgn9NPJpg
         tXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaFLLxph9xOodqATi4GZgbnbphTOlULAiIhPWTQaOss=;
        b=BLJOtFkQv/8hkQwlnflVri9QMtd8KkcI3l0JWD7Pe6SpG7KH6hcCTcSp+OcnzkFMCF
         Tjo10D0kBXurk3xebIfg/9JJiDnVgk6z/yuW6esgL5CqZpy2131CDZqMFT5VlsZur8E8
         kPtdpaFyJnaGeg+CfgdBck6bLipRNhDG93jO8oEYJav+lBafkNiAs+72XRj3ypT2zUH7
         WcKtATN2CAw2ftHV/mZbtBGXPe+6rdOFELqkcLh5Mn97YRbBkkqf4JcDnJZVgt3XOWv1
         o6sDMyqvlzq7Jutz83Idp2dBvMpkEk+0/RTdZORY+tTJuaSi+tKsuPWT4qmvk9haH8Ep
         bJ+w==
X-Gm-Message-State: AO0yUKVQZpLn9RypkiY4jHPoTxFvNfVI2GC8+iGTm3PjG6ywK7/PBta0
        CkYB/ld+C1RQQGoCqKjIp18=
X-Google-Smtp-Source: AK7set8hIVqkj4ffFUxs86CYFqgSViM04cmqJUDCfwiWmI+GUYZFpRm2DVuHBZrEVHGxIjGw8FBJmw==
X-Received: by 2002:a17:902:db09:b0:196:1462:3276 with SMTP id m9-20020a170902db0900b0019614623276mr8934190plx.46.1675891343480;
        Wed, 08 Feb 2023 13:22:23 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id p22-20020a170902a41600b00198e6257921sm10580793plq.269.2023.02.08.13.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 13:22:23 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 5/5] hook: support a --to-stdin=<path> option
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
        <cover-v2-0.5-00000000000-20230208T191924Z-avarab@gmail.com>
        <patch-v2-5.5-b4e02f41194-20230208T191924Z-avarab@gmail.com>
Date:   Wed, 08 Feb 2023 13:22:22 -0800
In-Reply-To: <patch-v2-5.5-b4e02f41194-20230208T191924Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 8 Feb
 2023 20:21:15
        +0100")
Message-ID: <xmqqpmajq2cx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> From: Emily Shaffer <emilyshaffer@google.com>
>
> Expose the "path_to_stdin" API added in the preceding commit in the
> "git hook run" command.
>
> For now we won't be using this command interface outside of the tests,
> but exposing this functionality makes it easier to test the hook
> API. The plan is to use this to extend the "sendemail-validate"
> hook[1][2].

OK.

What does it take to tackle the obvious leftover bits of [4/5]?  Use
tempfile API to allocate a temporary file, slurp the input and close
it, and then use the "path_to_stdin" feature to spawn the hook?
