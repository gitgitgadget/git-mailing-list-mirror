Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4411DC6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 22:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjC2WRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 18:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjC2WRo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 18:17:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387D459F1
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 15:17:30 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso17686143pjb.2
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 15:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680128249;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JsZhQedkt6ePUnryVimUJywsBe59T2P1YdgzkY5Gdtg=;
        b=n5qIlNxp/PaTOz0TVJGneQNVFGf3Z5tIMKMI/rnCaN9yfUXecqz/rpjr71vyCs+2Cy
         TQMhRwa5gg9MDlO7tuew+oVPN316Fl26Hu1GKPdM5kswXmzc6h6KHCk36EM8kMI9vN5r
         ftSISzfvPaNXwMGXXRSFC0JahEU77mIhqauh357640dpmSFoFE2fBx9V5lUH/RkGqFCD
         6G01WEwoBtcf8EJWQ9dQN2aamo8AdKZwTkhvY+NF7yhPeG8nJoHsqpFAr1OQi4hNRbwm
         HISGEvsGT+pfKG6OZWpaM8uAV05I0G9KijZjc4eGdkIzgkQQsFJYfUmRKgzDz4GzubOI
         jB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680128249;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JsZhQedkt6ePUnryVimUJywsBe59T2P1YdgzkY5Gdtg=;
        b=YQK8x357r8c40xRDABvX5kYWPOi4UfCmv7e+9+o95UzO97TEodM+hSXNL2IAY0iMYM
         UneDUuXGEW81GgwyE383G/juIHM5yCn0mNOPSfIUqU7XhkCfo0n6XKNM97iphamN7wWo
         SaolXO2jgZZRFRB2FcT1kS+wchqXyLkatG+mA241Di23xWO60nDS6/COiSq9cFhqcnL9
         r96yZ2TSqej0ifk5zgnTgCbRR8Z8rgUrn+bng/Kk5NhtZfL/9fq9j+YTx9nI6bm4ITVG
         DUpF8Gf/0iVS4FNSYZEOLchCC8jjlPFh3PXbOnamEWIXBZeMrushOmAM+w9vTi2cA3uf
         Ulqw==
X-Gm-Message-State: AAQBX9cgHHxLdCNAkBGETdw6uHSdqlC2OL8xnV8ftopwMtLLhm5t7TQb
        Q04PKdiuFCuiGAxSt7J+d68=
X-Google-Smtp-Source: AKy350YAiGDCkBWSYwgYuVFK/HHZTDt1M/r/eQJtMQLx1nf49W2qA9+jkca7thq5J07/eGaLOZNTnw==
X-Received: by 2002:a17:902:db12:b0:1a2:88c5:d337 with SMTP id m18-20020a170902db1200b001a288c5d337mr384816plx.22.1680128249677;
        Wed, 29 Mar 2023 15:17:29 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902fe8b00b001a21a593008sm10582232plm.306.2023.03.29.15.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 15:17:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v7 2/4] notes.c: cleanup for "designated init"
References: <cover.1680012650.git.dyroneteng@gmail.com>
        <9dc123c8f7a1cc2e7a146fb336939d6076369e2e.1680012650.git.dyroneteng@gmail.com>
Date:   Wed, 29 Mar 2023 15:17:29 -0700
Message-ID: <xmqqpm8r6w3q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> From: Teng Long <dyroneteng@gmail.com>
>
> The "struct note_data d = { 0, 0, NULL, STRBUF_INIT };" style could be
> replaced with designated init format.

I think our codebase calls it "designated initializer".

    notes.c: use designated initializers for clarity
    
    The "struct note_data d = { 0, 0, NULL, STRBUF_INIT };" style could be
    replaced with designated initializer for clarity.
    
    Signed-off-by: Teng Long <dyroneteng@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
