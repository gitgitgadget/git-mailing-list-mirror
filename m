Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876DFC77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 19:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjEHTu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 15:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjEHTu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 15:50:29 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC060869A
        for <git@vger.kernel.org>; Mon,  8 May 2023 12:49:24 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-24e3a0aa408so4493885a91.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 12:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683575308; x=1686167308;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fxh9TGTxsmFxUml6aFAt7Q9dlKIpIGfdSx9eLy5deLc=;
        b=HW0D3pMsq2L+PZmsenc8AWe/023NMajmKmB4XSi4GrG2bnF6vhcSTP55ostnF2fACV
         auPAb5m1N576mKbxKQjEMatb4kgE9mm5jTrpgwD5SUogG+lQVHc3F19BxRCPn7Cx6Ci8
         97PLS7FCkwCsvLcO9V8mnPRqRLEohdSmjCUvqAjPMNDFvtizF+OI35AuVSL6FJjf/oG4
         lo3axHCkR9Yvd+VqPc92rBGJETKREYg+gbDi1rEZEhCUly8qWzLa3K+KcCpR1atJvcC+
         hklMNUJiqYmcKVTEeiI5zPUwomvJyyFKOvSOUCJpOHgLDYnhmDFgMU3yI9iSk+spsGPu
         lSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683575308; x=1686167308;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fxh9TGTxsmFxUml6aFAt7Q9dlKIpIGfdSx9eLy5deLc=;
        b=RhD3UOQHC8TOpU6hAy7N7OonhUbZSg966CFTsTnKSlcXa7bj+7ZgqUS3+OHlVCHKPQ
         iU3BtIN6zxlqHW6slieSUnkq3E+45BhhjDMxDWLQrI9lxtBi4TCIt8hCtq96e9+K3DtE
         jhGbjkfP0kwbfA/sR+sAPtUhxPb8ntnBKtBeKGZIro8fH4t330AAXR3hbLaskS4kOPl8
         4Vjnn8HM9U/P4G3E+/MqM7NOCcJs8/IQP6+98QZMpK/SDkUNDcGTuvDb/smVMB/LvAvi
         QygtoDHyZII+AHpC1oaMptS52VxbFZilpQUP2k5w7Xc4mlL/KwhkLN1DC4ZWHUHXdngM
         ugZw==
X-Gm-Message-State: AC+VfDwRO5wSMcpgGrawfnhDSpbspQUS0w7CQ5E4h4a05IulzPGAAMxD
        Xn9rDgkOhACLVTcHoo8+FLE=
X-Google-Smtp-Source: ACHHUZ77TsSjnmF44XabiHQTR1H2f18Z0aSKwWvziN8YOxr2Bv4CHp2sD2IW5O7WBuTpzWBFKmz8iQ==
X-Received: by 2002:a17:90a:6545:b0:249:64d2:4122 with SMTP id f5-20020a17090a654500b0024964d24122mr11993561pjs.21.1683575307845;
        Mon, 08 May 2023 12:48:27 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001a980a23802sm7629604pld.111.2023.05.08.12.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 12:48:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH 09/11] doc: trailer.<token>.command: emphasize deprecation
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <1ac58b0b07c21fe4494f5fbe5d4b0f9bc1a49ac0.1683566870.git.gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 12:48:27 -0700
In-Reply-To: <1ac58b0b07c21fe4494f5fbe5d4b0f9bc1a49ac0.1683566870.git.gitgitgadget@gmail.com>
        (Linus Arver via GitGitGadget's message of "Mon, 08 May 2023 17:27:48
        +0000")
Message-ID: <xmqqsfc6mwok.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> This puts the deprecation notice up front, instead of leaving it to the
> next paragraph.

Shouldn't the opening text of the next paragraph be tweaked in the
same commit to avoid duplication?

> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  Documentation/git-interpret-trailers.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 5ca758e363f..c9b82ceba34 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -234,7 +234,7 @@ trailer.<token>.ifmissing::
>  	that option for trailers with the specified <token>.
>  
>  trailer.<token>.command::
> -	This option behaves in the
> +	Deprecated in favor of 'trailer.<token>.cmd'. This option behaves in the
>  	same way as 'trailer.<token>.cmd', except that it doesn't pass anything as
>  	argument to the specified command. Instead the first occurrence of substring
>  	$ARG is replaced by the <value> from the trailer. See the
