Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163C2C433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 16:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD7061A13
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 16:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhCZQQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 12:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhCZQQb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 12:16:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DA5C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 09:16:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e18so6185716wrt.6
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/9E5V9yXdfNpYw5c2AZwJGlC08Q8PGHYiej1BFSgLE=;
        b=AtLl223hkg5bgsxguR1BkGqFym0kUr16KEbfv1ggDRA9zU+DuncWBQ35hr7H3qvs+k
         RpC3wv8d0psmBRP9hsC6XOV3hU1+9KbgutDQlJTqsFxWHG8uVWBNmcHjhaaLhLD/bXwe
         WE9zmshoqtyP/zV0HLqX+6c8N6nmX9S5biq679C+1YR5xwgfb3a5E/XN0LnA8uDzzd+5
         h/hzjs2XVz2OoZhImgomHooUKaYs2P1gHbBVoovtxlBxU2qjpoEOFXKYoS3uakIwm8PX
         MKTcIW8j/bSAgFycZ1Mikl3lQ54TxKbMziHkfwObpvrCXbSR/UqOre5sDPO9QzqGtxvv
         c4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/9E5V9yXdfNpYw5c2AZwJGlC08Q8PGHYiej1BFSgLE=;
        b=Cp8U9Z6ORVwaVAVh+MVStVFE6ykNKaA3Bt7BrDqVVQnH/2C3/+ReVu/GcV8ujr4rTn
         dlTeSi2XRSmVDQektVMThelZRj+64mmjfb14cZBGmAa2gl1UQIDC794QsF8250wx6vqc
         p4kl4bJ1KT01JNUTROajM4QkxW3Ta4XoLKsxBAMsQjCYJgaYcAhWV+Yw2qW2/ZblX6d3
         lOcFPtv02f/zpVwcl4gnz4uWr2nGtbUfopdY3WWoPUUIhvDf/p0vMp4DPFCk/ylkaZAv
         53kdiJunCUDQJOeMs+pdPpOXsCVWySPEOsEuIr/n15cidewe7nCLOtUqf2f3O3wUVd00
         kEsw==
X-Gm-Message-State: AOAM530dQRSWF+BvHoHAOe2DqJHsVOs6JLU7mWty3hwmZUDKr0BU9ZeK
        L4mV1bPZ53LcIV6ys6bWZNg=
X-Google-Smtp-Source: ABdhPJy7rOYPBw2snUndnl4VcSW3jgUoYQJ+dYxi5nztTVwkxzDodyW9ZLZD1RNgdnWGLNxUQIfXGg==
X-Received: by 2002:a05:6000:1149:: with SMTP id d9mr15192206wrx.347.1616775389630;
        Fri, 26 Mar 2021 09:16:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:85f:2a0a:9300:501f:ca6d:3b18:1e72])
        by smtp.googlemail.com with ESMTPSA id f2sm12648011wmp.20.2021.03.26.09.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 09:16:28 -0700 (PDT)
From:   Stavros Ntentos <stdedos@gmail.com>
X-Google-Original-From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
To:     peff@peff.net
Cc:     bagasdotme@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        stdedos+git@gmail.com
Subject: Re: [RFC PATCH v1 1/2] pathspec: warn: long and short forms are incompatible
Date:   Fri, 26 Mar 2021 18:16:26 +0200
Message-Id: <20210326161626.28648-1-133706+stdedos@users.noreply.github.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <YF1w/xKbozpQn7Vf@coredump.intra.peff.net>
References: <YF1w/xKbozpQn7Vf@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> We avoid using variable-length arrays in our codebase. ...

Hear hear, however, I wanted to avoid the "small mess"
that allocate/free would cause (one or more of ++sloc, labels, if-nesting); ...

> But two, they are limited in size and the failure mode is not graceful. ...
... however, my main issue is that - I don't know what's a sane allocation size.

> ... The "4096" is scary here ...
While scary, it is "a safe" upper high.
The first time the string ends up in pathspec.c for processing it's here:
	entry = argv[i];
which comes from here
	parse_pathspec(pathspec, magic_mask, flags, prefix, parsed_file.v);

and I don't know what's the maximum size of `parsed_file.v[0]`

> Is this "%4096[^)]" actually valid? I don't think scanf understands
> regular expressions.

I was suprised too - but it's not regex.

see: https://www.cplusplus.com/reference/cstdio/scanf/#parameters - 4th/3rd row from the end

%s is greedy and there would be no other way to limit `sscanf` to not include `)` on its first variable.

> ... though I'm not sure I understand what that is looking for ...

I think it will help you see what I am trying to achieve if you read at the warning message / testcase
https://lore.kernel.org/git/20210326024005.26962-2-stdedos+git@gmail.com/#iZ30t:t6132-pathspec-exclude.sh

And, to clean up the testcase:
	git log --oneline --format=%s -- ':!(glob)**/file'

I guess it should be now obvious what am I targetting:

If someone naively mixes short and long pathspec magics (`!`, and `(glob)`),
short form takes precedence and ignores long magic / assumes long magic as part of path.

(If it's not obvious, all the more reason to include such warning)
