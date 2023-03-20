Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659AEC6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 17:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjCTR2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 13:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjCTR2F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 13:28:05 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC4912F39
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 10:23:44 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id y35so5889640pgl.4
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 10:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679333021;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=175PJP5c1GGE5rUkfdH2evFMkRMmTH2Q564mPTLPO3g=;
        b=OjzW9frshGB2hQPZK/7GP5M7mfeKKhjYMMtZkBhmtP/zFgIQtoS1rmOArwpjH1i1ud
         l8fq/RrmIM/vWQOmG5G9a8h2qcX99oagCKFVK7tBqpFW6CcMdlxBPUl70CnvYh4rrytG
         7+jHkGJaOTY8J66ka8PEYjjsTgklFw/JQAcO4s1EqES3z4LbKZVCT3sAvwajIfQc8BcL
         4w/zpwLgaec7GVD70EFXURjM8h2QEsWCXCdcxzJ3LhYoAH4VAEtRcEqXjAIdH7TvHRp3
         Whj82aJvPvzUIar1qEhl3wsD5TTydoMZZMf9NoWI+HS4d6WIXIi0LzkPDdqDy9Dex+jI
         p7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679333022;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=175PJP5c1GGE5rUkfdH2evFMkRMmTH2Q564mPTLPO3g=;
        b=iH0bswVVwfx31kBZzugzjuEjTY2zvvCshs1Xu3/3vudNC2qtd+gz4RzryBNH0Biy05
         PkrocoZGdhw2HABNC6aEykcpVTRR1xx4quJlotbBRZlk1XhTauzeArZD25VyLY5TBy9m
         w/W/zazqZED18YIDkbU3FxtF2VX/B5lj24POAp75Age35SatHWZZDaE3B0JvyayoHJG2
         p9oj7ePAi0CTRvdkMK2UaI2nY8dpDlMbixkswJhMQ4urgQnzbX0Buv+LAspTqsPltAvI
         xlANRGL+ApMkLHC9zlXkmsOEVjjWsCwm8nl7nXajxgqhcR4TcV6o5kMfzerQdHpEqtHF
         0Ksg==
X-Gm-Message-State: AO0yUKWfF+/zSebtgjg8Bkj0yPgbiTagtM/IN7CUGIVdVepf8B+vA+ZI
        GkTJLzIzzF/Uq17JikA1O/FWdrHVHro=
X-Google-Smtp-Source: AK7set+MOFnnYnlAFa0YRB/4azZ/H7fhXmMgMUHb/bu6nbre3eznnajbctqE8RjuOBViU+LDyoskXQ==
X-Received: by 2002:a62:6101:0:b0:625:4f81:bb30 with SMTP id v1-20020a626101000000b006254f81bb30mr12929036pfb.21.1679333021664;
        Mon, 20 Mar 2023 10:23:41 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id v7-20020aa78087000000b006254794d5b2sm6761803pff.94.2023.03.20.10.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:23:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Stanislav Malishevskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Stanislav Malishevskiy <stanislav.malishevskiy@gmail.com>,
        Stanislav Malishevskiy <s.malishevskiy@auriga.com>
Subject: Re: [PATCH v2] http: add support for different sslcert and sslkey
 types.
References: <pull.1474.git.git.1679233875803.gitgitgadget@gmail.com>
        <pull.1474.v2.git.git.1679327330032.gitgitgadget@gmail.com>
Date:   Mon, 20 Mar 2023 10:23:41 -0700
In-Reply-To: <pull.1474.v2.git.git.1679327330032.gitgitgadget@gmail.com>
        (Stanislav Malishevskiy via GitGitGadget's message of "Mon, 20 Mar
        2023 15:48:49 +0000")
Message-ID: <xmqqlejrmj4y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Stanislav Malishevskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Stanislav Malishevskiy <s.malishevskiy@auriga.com>
>
> Basically git work with default curl ssl type - PEM. But for support
> eTokens like SafeNet tokens via pksc11 need setup 'ENG' as sslcert type
> and as sslkey type. So there added additional options for http to make
> that possible.
>
> Signed-off-by: Stanislav Malishevskiy <stanislav.malishevskiy@gmail.com>
> ---

>  http.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Thanks.

Is this something that can be protected from future breakage with a
few new tests somewhere in t/t5559 (which may also involve touching
t/lib-httpd.sh as well)?
