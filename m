Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94508C4332F
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 23:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiKTXYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 18:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTXYY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 18:24:24 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FDD24972
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 15:24:23 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id q9so9814151pfg.5
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 15:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYDmiobqKR4D8p2DPMBfTkze3MLDbQ3gjJA65eJMPwc=;
        b=dy6vZmPglrVsJWyDmfij+uQUjm2aReksj45tilebBZZMerNQcrN+9FwB0u1ViRV6ye
         U7oIpw6evy5ts0fZHu9hsx1LTI0XBFdW96xjWltBUKeUzYLaAYn2AIW+r4k/nhgp6rlO
         KawERvvHDlOgQmD/gs9WaV8AO6fLf5dOA4QcE8lNNNUYSJDY4xnJTMhPTn+om6yRMp2d
         oqJHlOY6CD98Pt/F+m4Zbdike1p5fM/pLujosmWcd7s6eQ+n7XfJkCDIjaluEivk/4Qd
         Si1WejCUcUhPe+cZX6k/J3s7aCnvAsT8AIhvPS2bK9yH2A0guM8LZeBLUXDH1Qrogo83
         Im6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hYDmiobqKR4D8p2DPMBfTkze3MLDbQ3gjJA65eJMPwc=;
        b=LLKLQnh5MlVEUsLtdMPlUP/6RLogcbwbBEpG+MlyR1NWKWoqI7e5KCJRuZ30WbY6+m
         VNKsMWAxE1s/cENjSSrQsSFewj/XOFR40Cf3ITlOjapKmAcsEu9TZwot4E6o2dsE7Xxf
         zqUfhNbXuK4q3y6//Xg3QZsYHucat/x6KIXnAoEiwAS0BpxHx+Pi0QNb/Ygjun2Z8fA6
         noGsSTmmdHcViRYOu47wyTe3VrTgbnPsWdUvOt3qtS1JYxr0VSZ7f8zi3Rt9hBEt6iWQ
         otG1gL3basGPVlh2l2CRX4agudZcp0rKbR8QrKXVKFEk57Nbw3jhUqKIb3Gr5N3jF7oc
         plKw==
X-Gm-Message-State: ANoB5pn5UrBgEo0+uEOva9AEECwJzyNbU6KosyvYlhmyksVJEqCQCTLC
        2PyL+7hPLUhQx+JQfjzgoH4=
X-Google-Smtp-Source: AA0mqf6R3PBhpWMDh548RJmW1VzmQWwq6BYVvFRIBKGevOeObWyeZfOncmUFGg0UNoNlTk9JzeMyZA==
X-Received: by 2002:a62:2702:0:b0:572:8766:598b with SMTP id n2-20020a622702000000b005728766598bmr17698526pfn.21.1668986662988;
        Sun, 20 Nov 2022 15:24:22 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090301d100b0018855a22ccfsm8190157plh.91.2022.11.20.15.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 15:24:22 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #04; Fri, 18)
References: <Y3g95OYdwzq2OP3z@nand.local>
Date:   Mon, 21 Nov 2022 08:24:21 +0900
In-Reply-To: <Y3g95OYdwzq2OP3z@nand.local> (Taylor Blau's message of "Fri, 18
        Nov 2022 21:22:28 -0500")
Message-ID: <xmqq7czp1a6y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> * ab/various-leak-fixes (2022-11-08) 18 commits
>   (merged to 'next' on 2022-11-18 at 8828bb7161)
>  ...
>  (this branch is used by ab/merge-index-prep.)

> * pw/rebase-no-reflog-action (2022-11-09) 2 commits
>   (merged to 'next' on 2022-11-14 at 790dadc8d3)
>  ...
>  (this branch is used by ab/merge-index-prep.)

The other topic referred to is not described anywhere, and not part
of 'seen'.  Intended?

Thanks.
