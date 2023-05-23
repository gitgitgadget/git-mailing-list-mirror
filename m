Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE8CC77B75
	for <git@archiver.kernel.org>; Tue, 23 May 2023 13:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbjEWNJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 09:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbjEWNJN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 09:09:13 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEF2FF
        for <git@vger.kernel.org>; Tue, 23 May 2023 06:09:12 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f3b5881734so4346802e87.0
        for <git@vger.kernel.org>; Tue, 23 May 2023 06:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684847290; x=1687439290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6sfnY9nYMVeCzBV6FRUjn1RLoa/QlG1BLcnLMnzzSg=;
        b=HOCIp92GE27x3FXZznqpMigN+FGSzrpkmHDQtRmT+75BJ/SnP9fpCT5H/bXPn4wd8T
         w+x1BExfDCfBKlvwfQxNRK8MiLRflZM5h11PEI0guXCXk/N7IBRGKKPYCY/C9AK5Z4xT
         L+qpGg3f3wpE2mFWtTIGQvjsiuYB385Sf2YleU9QC0IYpuwtGg3MYuh1iomgEVtjof1A
         SmYcKbLlP44sQwaZo0fvwFFGVGvzEM9TyoKjVff4fz7HieE5IsPDyEwM9L/yUrBHWX2u
         FHOH9ZNlWAL0cyjJSifYoOXB9Tes+IrRqxjoC6/7uJDet2I4DzcfepJFjkX3Tsevx+7Q
         9YXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684847290; x=1687439290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6sfnY9nYMVeCzBV6FRUjn1RLoa/QlG1BLcnLMnzzSg=;
        b=XoVQkCW1AtAihqMKfBxN67cGRdVKJMJNtLf7+Dyo5FgU3BBtDB+/1fwg/UXsMUnafs
         rpKERZBUKeXUrn40NzoX3b1y/idWzn1vUuDiqe7g4461FUBbKdg1fv5CRhi5hLDB6sXc
         bW3u/NrBeIRDV5ULf4CCKi1WDOsAcV5kKU0zmN/T8zdzo5uuI+97lbKdoJ4ucUv1kUVt
         I1Wk2nPdlSff9BeJEi+h+eaaarw8Q7DJhhbX+aErEQlgWSBsbg1yK0YDs4JF+BTA665Y
         lKtdOUuuwVsquFkGx5Po0tlAPME3Kccm1X+dhPYFvo1Dan4JBCw5EXhwsjSy0Rw25EZe
         LjkQ==
X-Gm-Message-State: AC+VfDxQytRqPiPuYvAUJSqSgvn+V9Eo2AgtAajFzzUOnWzlAhz0/oil
        key5LSsgoWQVX9dboFjqNZGh6ieDO4M=
X-Google-Smtp-Source: ACHHUZ7Y5gvV5kG/lE7qNlwscCkmAoFukwCUyxP2Mq636V4TR0hyqQBHkOfFv3v/P4PNUpAA28yrnw==
X-Received: by 2002:ac2:5106:0:b0:4ec:7b87:931a with SMTP id q6-20020ac25106000000b004ec7b87931amr4712715lfb.13.1684847289999;
        Tue, 23 May 2023 06:08:09 -0700 (PDT)
Received: from localhost.localdomain ([2001:4641:9d1:0:9c74:f016:4c88:53bb])
        by smtp.gmail.com with ESMTPSA id u27-20020ac24c3b000000b004f4c3feb9fbsm126848lfq.61.2023.05.23.06.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 06:08:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.41.0-rc1
Date:   Tue, 23 May 2023 15:08:08 +0200
Message-Id: <20230523130808.17591-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <xmqqedncqkzf.fsf@gitster.g>
References: <xmqqedncqkzf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 19 May 2023 at 10:39, Junio C Hamano <gitster@pobox.com> wrote:

> * "git branch --format=..." and "git format-patch --format=..."
>   learns "--omit-empty" to hide refs that whose formatting result
>   becomes an empty string from the output.

Typo here. branch, tag and for-each-ref learn this, not format-patch :-)

Øsse
