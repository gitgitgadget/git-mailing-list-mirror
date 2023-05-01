Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88ECC77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 22:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjEAWEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 18:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjEAWEu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 18:04:50 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDFF1FEB
        for <git@vger.kernel.org>; Mon,  1 May 2023 15:04:48 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b70ca0a84so3582290b3a.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 15:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682978687; x=1685570687;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWUxNG+fyxsUeHqjuOV624xvdoQg7QaO8IN5O9wgWuM=;
        b=lFRLyVx8MRKoKCEevJ83LMLHy5IqODE5iaCspWEGES98T0WZzJ7YOti7EibyDAAgLI
         GnieMF79NT6jnf8bOoRr0lBNJZzMjhLxWtOTP0+wh6yGmRaHVviTaJT1VXmCj9XizR7m
         6bhI+6ZSZZxsSUbjmOxloEQS3NvP4pp3pO0dadkx7NjxHQSp3AG1GRlFRpdxEbdICC31
         hipuS1o7AY4wA3TNwuXubSjagC2Q19mifpck0trsEWg6b+ilcJxT2Ks1tg36KjVkFOWK
         q76fyX9RwlpHCI0a85CXg1qd+SRiGZKZ87if2kzKikmzow5CBRdT8meH36AcBbGqBbx1
         q9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682978687; x=1685570687;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jWUxNG+fyxsUeHqjuOV624xvdoQg7QaO8IN5O9wgWuM=;
        b=KgyjjQ5MOV4Tdx3cpSniR/yjn6Ql+/J6b7FwbAeZmm6W3V8K0xoc8QvYbRWsM98b6H
         qF0uKDbWqYDYXpXHqf8aisb9H+Un9lhqaKqo6FZ2AkGclrU/ju71PASx7k46KEw5quuN
         9rrtulde0O4lp09snaP+czplIQv1Ibt/yPeh9mJ09FvGsUXizt/R/uehlKUoudL5B/VL
         rX8j0oUuc9qJeyGmzP3FvzDd7vXeMzkwnYPl1OJ22FayOkF7VlQoE0zJ6rYo7PmShsjP
         oTHREvYCN3rgfWe59iesIrLmhgY9N52SCzqod/zbXcvIOXmfxqoNLZ7BugUZiKbGxuxr
         zUHQ==
X-Gm-Message-State: AC+VfDxcCuYRAyrSU4PxEtdLIr0y1giYpW1eAXwiSBcd7zYJTUc/c8EP
        Ni3Hec+7Pmhp/fOHmDfXnBo=
X-Google-Smtp-Source: ACHHUZ57W6S+b49hYSAg3Ep0179kVsUMdteBYMmy19fBWvw2fOuD4bw41eePOHJ/5JFcSqvSR8l9SQ==
X-Received: by 2002:a05:6a00:2d84:b0:63b:e4:554 with SMTP id fb4-20020a056a002d8400b0063b00e40554mr24157813pfb.4.1682978687522;
        Mon, 01 May 2023 15:04:47 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id n47-20020a056a000d6f00b0063f18ae1d84sm18615311pfv.202.2023.05.01.15.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:04:47 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com
Subject: Re: [PATCH v8 0/2] diff-files: integrate with sparse index
References: <20230322161820.3609-1-cheskaqiqi@gmail.com>
        <20230423010721.1402736-1-cheskaqiqi@gmail.com>
Date:   Mon, 01 May 2023 15:04:46 -0700
In-Reply-To: <20230423010721.1402736-1-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Sat, 22 Apr 2023 21:07:19 -0400")
Message-ID: <xmqqttwv3dz5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> Changes since v7:
>
> * Refactor the ensure_expanded and ensure_not_expanded functions by 
> introducing a helper function, ensure_index_state.
>
> * Delete the test 'diff-files pathspec expands index when necessary'.
>
> * Delete 'the pathspec_needs_expanded_index' function.
>
> * Add double quotes to "deep/*"
>
> * Change "**a" to "*a"
>
> * Updata commit message.

This round did not see any reactions; is everybody happy to see us
declare victory and merge it down to 'next'?

Thanks.
