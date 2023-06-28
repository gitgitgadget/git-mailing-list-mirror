Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A49C001B3
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 10:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjF1KGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 06:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbjF1KC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 06:02:26 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8892947
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 02:54:27 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-668704a5b5bso5112357b3a.0
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 02:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687946067; x=1690538067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKwGGUhxGPvsEpgfNVZgpUDK06V9bjYDdKt/hkMRtHY=;
        b=qNdmtnD7swku0KfESDbKMyTDa6Os6l3bVPl06p9Il540jzN1qtw29dhbVFhFgJDsAf
         Ru2ITK8mvfIHjsyfilvLildYS93VKALmnjlayEoju9AZzYxXf0uObF++i4FfxiLHENI2
         UtRuWs4CKvGfdc7/2FKFY3fybVACgC9yUWLGhmdpg8XxRBvoHrZn+WiDEVjh1Ts5gLny
         VsRQtYRqjkOVNBpZRmm3Z1hMCOeokEqXuZamqGEIRn6zbHwVTjkIqTb8RK28MDJ3kU3S
         /8p/IqqdctuQf0UrAHtuFUwuPTJr/p+uhYFn/VSopVnMW55EewJlA6CfoE3kcXsCjpb1
         SeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687946067; x=1690538067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKwGGUhxGPvsEpgfNVZgpUDK06V9bjYDdKt/hkMRtHY=;
        b=irZ8PUAhhU7lYQLiC1Dai+Am+oYhVnGYz7f0vyE0qDp9k42x6lrAghuaPej2kpQHgI
         VsgRWpjuWwxU5axKhFffaHB2t1BdLSRAp+kkhWZPD0fRtpaTQOkTl3CQVDlHseE25yc5
         AXBWd9tn6XvRH8ULD4lIk1dsQS+kC8pmXREXgHLVtMyw8OHHLx4OiytPrbLxTy0FuL7H
         ZTGzPXRM0g59U829YqKf6XJLYdKDT/K6nwl4YLDwdfcweJ+VJh91h7OfFuH3/zJYVZ3Q
         M4MNAnJYRUndIONa/JnTvDe4oZ9dwz5a4SSO+Nc7C4QbrRG0HJ+aNIUe+3otH1QBIaW7
         dKHA==
X-Gm-Message-State: AC+VfDytXif2GfUZEWAtKpFIQHbOXZrxUvwHfH+FBQ3GQEM6adfPY5AM
        rGkO2MsqFe/RtiKD4O4IJQuUUnnQ0UDluQ==
X-Google-Smtp-Source: ACHHUZ7iiT5rlDIhwUpFM6vf8ThvgSNn76tt3MGg0m9X5ytbGggdad2PqmR5DO36wk9T3DvtCArMag==
X-Received: by 2002:a05:6a00:2351:b0:668:6445:8931 with SMTP id j17-20020a056a00235100b0066864458931mr42538567pfj.29.1687946067232;
        Wed, 28 Jun 2023 02:54:27 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.59])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78803000000b00678afd4824asm4427040pfo.175.2023.06.28.02.54.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jun 2023 02:54:26 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2023, #07; Tue, 27)
Date:   Wed, 28 Jun 2023 17:54:21 +0800
Message-ID: <20230628095421.7249-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.41.0.194.g94486b67
In-Reply-To: <xmqqcz1gftdn.fsf@gitster.g>
References: <xmqqcz1gftdn.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * tl/notes-separator (2023-06-21) 7 commits
>  - notes: introduce "--no-separator" option
>  - notes.c: introduce "--[no-]stripspace" option
>  - notes.c: append separator instead of insert by pos
>  - notes.c: introduce '--separator=<paragraph-break>' option
>  - t3321: add test cases about the notes stripspace behavior
>  - notes.c: use designated initializers for clarity
>  - notes.c: cleanup 'strbuf_grow' call in 'append_edit'
> 
>  'git notes append' was taught '--separator' to specify string to insert
>  between paragraphs.
>  source: <cover.1685174011.git.dyroneteng@gmail.com>

There are no pending issues I think ;-)

Please let me know if there are some obstables to merge.

Thanks.
