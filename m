Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02762C6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 16:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjDGQGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 12:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240702AbjDGQFv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 12:05:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A5CBBBD
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 09:05:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id kx12so1455522plb.12
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 09:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680883545; x=1683475545;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uav5cPnaHW0Lg7ksQoCe9sfwD5dvF0sbx2gTCPT/WE=;
        b=iOBzhc9l4pDLPOXFQBNGRQZdz0ej7VXo2Zev+PejAgLhpePGkEJ0NrSreNYeLNGu4Z
         ulWRGzr+haDaa0EZLfl7WAr/wI03/jVawyeob/Fb/VXVwX6vBJr11urQ4R4Of6gnhRdX
         kprMI72tOTn9lpB57UpPOg7uFj1lpTR+YFqFRnG7epBbuDIfPdSC2sQ2nWqwSlhvZZfo
         b/7Uva9wDl3LB9sV0Qo7VcX4VBDcgqwUdXgii49uH0h1ElZJVjXZQ6ZSp9Fyp8UsqhIO
         xV2lYJb4S+HiJe7KP6tNVUphH4yxxxoAOcM5B0lsf6JVypK5HB5crxBUIXX4wSNryxGM
         UfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680883545; x=1683475545;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1uav5cPnaHW0Lg7ksQoCe9sfwD5dvF0sbx2gTCPT/WE=;
        b=ix3KVDhRKQDDeG14h+HzXut5Nql0s8qJoLrO52YAptadkDEfmnaGUCeRbb7zmSOkZI
         yD4ZfEbPcNUYJB+1f8uycE5zXXvTIhdB0uB+jbRCSe2/GziOVfkzl4Y8LxoHGQb+lqyV
         vjxhgcF/19H3CGgQWLKZe26K7s1hWij1/h8h66Pf4pw9FZpwLHiaE753c/H0EZTlJfrP
         oySV1XQDsugQMHk+sSyYF0jEtEcCBqk/Klk9D1VibiS3dWdkTcDUzgRm92XqL7tbZAYU
         sxu+gKcszww1994LXR/XAgNGnsQ7oWFroe8RWtsOd72aic/wM3mSb2C9MnYr3E5B0TO1
         2Isg==
X-Gm-Message-State: AAQBX9e9/JDsTWNYx7s6We9D45eLL9z6SFXkfXthU1LhLEL6B4PeN0YQ
        etyZRFxMlWTMS1/EjAlFNto=
X-Google-Smtp-Source: AKy350Yjf3kgkExwNwhGXGF3sKB0E4WR9bRBjS0EMCpRvibtrOE9SCDNaZw8o6u3cwx1pdRT3SmUSg==
X-Received: by 2002:a17:90b:314a:b0:240:973d:b436 with SMTP id ip10-20020a17090b314a00b00240973db436mr2726806pjb.49.1680883544794;
        Fri, 07 Apr 2023 09:05:44 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id nn12-20020a17090b38cc00b00231224439c1sm4880849pjb.27.2023.04.07.09.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:05:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] coccinelle: add and apply branch_get() rules
References: <4cb4b69c-bd14-dfbd-6d06-59a7cd7e8c94@gmail.com>
        <xmqqjzynlm9i.fsf@gitster.g>
Date:   Fri, 07 Apr 2023 09:05:43 -0700
In-Reply-To: <xmqqjzynlm9i.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        07 Apr 2023 08:55:53 -0700")
Message-ID: <xmqqa5zjllt4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> To be fair, I do not think we would not see if "branch_get(NULL)
> must be the only way to ask for the current branch" is a good goal,
> until we at least try a little.  Maybe during such a conversion that

Argh.  My double negatives are horrible.  What I meant is that we
may not know until we try, at least a little bit.

Sorry for being a bad writer.

