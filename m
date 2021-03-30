Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24225C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 19:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2B43619AB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 19:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhC3TRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 15:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbhC3TRg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 15:17:36 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3F2C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 12:17:35 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g25so8988276wmh.0
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 12:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U3L2ezx1fYr2NhWL+kNZBdG3v2/ERKisVmuyZjB9f98=;
        b=ayezURsUhCCSuaLtRmDXZs8ycE6JzXauezJJNZrhIRRU4Jby5khKrS8Wo0/DtqP5R7
         hLhDYEZw8wfxhUnie/5106Avf90eF4iMhKTQndQeodqIBObxo4hHqo0Hx5uFb4ry/LzH
         PcuiendwuGLDH+IrliTDBn9nQ+TTNhDBgIfLYtShQxoQw1yporFeB4CwzGzKJrvmMr1W
         DF9WfOklpJQf77L/TaT1NUMN9b8RcGPE42stp4Qa9WpPlXYQn7ETyJSVRRsk8CkntxMK
         kxOObIF3k8V3gEW+Cxz5C+Xx2RdTPm3IecRn6catFx/cXCrZCgOGDfHQcbKhzTGfYuxX
         rksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U3L2ezx1fYr2NhWL+kNZBdG3v2/ERKisVmuyZjB9f98=;
        b=TpRURf30Tv6CO4j8X8WvcQgosZLlX4yu5vdeLw2+bXm1jhtjYQPwaoSqqJn/cjbfch
         TI8wE7bcIw6HKNLSQytdItoNFGHFM/oNAXvgF0ZYz1oJKcRo+RmGnYjogEsX3P4gqDyu
         iTbalTKDFjC99Zkdwe+KV1JRbOAS5u8M7Tn32+piEdcPhZKQhu8bzSTAk38JF8Kp1rSG
         GYUyquaEvF4PwyuOCgUVLe8RNN9NPTdoWNT2x+YZTyDoqIjqnPRHYvNeCVBs2elugv8B
         Qw0mlGh/eMARB6FVwxMHuo7AZGedP3pDjGrT+SYIxac/I5YVrXvUGP+bW0UvjhTV8mTn
         CS7w==
X-Gm-Message-State: AOAM532xRZ134mFteCxzalFhiwUpEzgr0lYcRgJAD7+eaf2tbY+doucD
        ETwA3LSYNy7UB86RvI6DxommQV3/V1sRD1OZ4zc=
X-Google-Smtp-Source: ABdhPJymqhiHaPCb5cTNzb3pPa/oY/RFow48qowbQy4MDouFrSrxhxA4xJ7J2nG65i3v8tDAiHGnMA==
X-Received: by 2002:a7b:c931:: with SMTP id h17mr5572293wml.4.1617131854033;
        Tue, 30 Mar 2021 12:17:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:85f:2a0a:9300:1d6d:c581:cf0b:2ca7])
        by smtp.googlemail.com with ESMTPSA id m2sm7957521wmp.1.2021.03.30.12.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 12:17:33 -0700 (PDT)
From:   Stavros Ntentos <stdedos@gmail.com>
X-Google-Original-From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
To:     git@vger.kernel.org
Cc:     stdedos+git@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v2] pathspec: advice: long and short forms are incompatible
Date:   Tue, 30 Mar 2021 22:17:30 +0300
Message-Id: <20210330191730.24561-1-133706+stdedos@users.noreply.github.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210330190517.21138-1-133706+stdedos@users.noreply.github.com>
References: <20210330190517.21138-1-133706+stdedos@users.noreply.github.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >  - 7 is way too long for warning against something like ":!(glob)",
> >    no?
>
> GRRRRR C :-p
> (I'll push the changes on the next iteration; including the `like glob`
> removed, and whatever comes from our discussion.)

Actually ... C does not have a problem with it:

	root@94ae60990b85:/usr/src/git/t# ../git log -- ':!(glob)'
	hint: ':!(glob)...': cannot mix shortform magic with longform [e.g. like :(glob)].
	hint: If '(glob)...' is a valid path, explicitly terminate magic parsing with ':'; or
	hint: Disable this message with "git config advice.mixedShortLongMagicPathspec false"
	commit 14b8580dde326a0bbf9abacac7e09dbe4c38c25e (HEAD -> fix/mixed-short-long-magic)

True, it does not look nice; theoretically, any number (even 1!) could be
too much to contain ellipsis after that text.
Given the size of the change, I would want to say that it is acceptable to
leave this as-is.

Unless you'd like me to write a generic

	truncate_at_chars(char *text, int width, char *ellipsis_char_or_default)

function.
