Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1B8C88CB2
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 17:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbjFLR5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 13:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFLR5A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 13:57:00 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BE719D
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 10:56:59 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b01d3bb571so24686705ad.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 10:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686592619; x=1689184619;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TnG4HoXZ/23JBn7CSpaze6hD54ymf0bR3qxZJRAPyR0=;
        b=n4SV0fLlk3R/0zp/C0Wp2NZpBBnQZFXE9G4Zw4mL01n25MlxuKIYnIDLjBNQrQVkMe
         7o49pokzl9ou/Qz10//Qta62cAkhEz7cO2AqkR18ZGNiv9/3FlG7ANRjVSpee8f812HU
         8pdaIEyIRDRLcLL63xattch5+aRu5emyxsjxZqLpPe2KNYdrEDvg7xWvPt+viQITgRUm
         Q84atHzV54Fi4CY7mDTxk+AULmUkiQGxjkR7CPE4mIBICOgfqEhsPeRUdAkV/8wL2AlA
         5uPA/qgKnO2yGKIG4mWU+yP/IiN5ctvNaIyMcL9tEwEvRpjQI46Lx/Wi0ZURbJJfcHzH
         umsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592619; x=1689184619;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TnG4HoXZ/23JBn7CSpaze6hD54ymf0bR3qxZJRAPyR0=;
        b=TGlbm5BMwQS20/5+EktAXmEsGFFItSFkpT256YNB1Yn3dS5R2AEWYxDwMnFPxSWnoc
         PYSW+yuZsymDzF21oD8F4sQdckB1fRofOpxSuQq/G25ZQfrksiSdPsgfLcHx+/g2fttL
         7HelnX4o7xWvm9xiokYN/FnrPlEvMSIxjRbXA1VAg5ZYTg3n+05xLjQqFgwNPaZeICFJ
         fhoJfAxpbHX8tc9iBfnm8VctYt4aCbJXRnuXpj03qJ1icn48trmcrdlCyMyVFwsGqeye
         IJdGc+kQu/AZx2C9zOrqa69ZCVsr3WXiExcn0Q0YcF4gxzWJdb3XGTArl5fVWmLCsEzz
         gyZQ==
X-Gm-Message-State: AC+VfDx6jwhl2PrU1oMJPobNc0uReVPBHvQY8GW/1GhEdjWxaR6YpYjU
        JrBbCUgASGHxY6S+C00/hHc=
X-Google-Smtp-Source: ACHHUZ4UG7FFB974WYuhBlPx3AXiqWcZQRc97GNu35S2/FErB8W1uXPC0op84X8pGFEt+W5kuoxz+g==
X-Received: by 2002:a17:902:f684:b0:1ac:8be5:8787 with SMTP id l4-20020a170902f68400b001ac8be58787mr7996568plg.21.1686592618703;
        Mon, 12 Jun 2023 10:56:58 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902cf4600b001b24857d1f2sm8528415plg.188.2023.06.12.10.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:56:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2023, #02; Tue, 6)
References: <xmqq5y814aw8.fsf@gitster.g>
        <5cd3a92c-0f7c-5bf5-7706-753ad00441d2@gmail.com>
Date:   Mon, 12 Jun 2023 10:56:58 -0700
In-Reply-To: <5cd3a92c-0f7c-5bf5-7706-753ad00441d2@gmail.com> (Philippe
        Blain's message of "Sun, 11 Jun 2023 11:15:00 -0400")
Message-ID: <xmqq4jncbm39.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Elijah reviewed the new version in [1], to which you responded in [2].
> So from what I understand we are just waiting for 'next' to be rebuilt,
> not for additional reviews, right?

Correct.  Thanks.
