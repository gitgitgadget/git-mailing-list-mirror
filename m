Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12235C7EE23
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 23:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjBZXSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 18:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZXSa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 18:18:30 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FE79744
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 15:18:28 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id ee7so18972530edb.2
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 15:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zLdVf+WxX5w/38iUUqKkiBnn3sxQrF0RoDPr7WVmIz0=;
        b=Ut3pklFt5C+ux+3TSIOkXekkAqQzioYrvwPjsyNv5mf4UEqCg1a8OE6hJnGacdTG/M
         6+sFOWIRRVuSyAsVni4HXU3CeASADszcOkkibd+AwykpyIEd2dXGnj9tM72j3WIVmyA5
         E8Js1UE9juvgNIlDBosgvT92i9RkZENsKVedJP1GSykREVJAsHeSTP3P6uC7AuMu2XNl
         YR6iKCKYCktzbCcfoHHzHPIEtbRgApxC+8Z9uv18asggnWfXn2or6FiYPLdyWZKqpBtj
         xOt0hfmT3OFaf83SwUsgm2SsfF7+Dsxsqj3h/4du9zbb8T64fzHsHP+PolTYD2HNxMjO
         jlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLdVf+WxX5w/38iUUqKkiBnn3sxQrF0RoDPr7WVmIz0=;
        b=O1ao/eJHS798ubanP1wqjZTXSP8ArD+TbaQw+g6fJSBLeIBtRFBUlpabSlcYL+5sw2
         ahBH9KSmOu0LGiCj2HMYaXrU/l/6S2pMD6nCj0aOdIkS9AbYhSh87bmHqT4laefLEKyq
         FUdp4wvH1nfHadYKkqo2T78w9SBRRb1+KAJ0BAnwxYFZS9bluFiWHRRajrUvLvSDOwC3
         cKuoQ5g4OnU7VBTRHmhh28SvvQj8dQZtHS6OScwJlOc2y8zdTTY/PchaTurnLRCsa6PM
         qPMcJmAqeGo0IoOS4glCg3FvQPaUD2miubIlRWSl2Yw2mkil+O7ch70unrvpoILB8Jhm
         ZXqw==
X-Gm-Message-State: AO0yUKUFFlcugBCQ84FlJaQjDykKPzbcQN1lAlJvNyKnzodLmvnvirq9
        9TeCPRCTdS1MdKqgwE0EoGOdKRYBiXx82pBpDXiWaJSQYZ20zshw
X-Google-Smtp-Source: AK7set9UWhm7o8hb0he8iIItB9PC50bWtUBmkXDa+A0nYY+l79QIlCZqvmaOS2F44F7cgng7IGfAuhHZZVqpDAajxNE=
X-Received: by 2002:a50:a6d7:0:b0:49d:9a8c:f857 with SMTP id
 f23-20020a50a6d7000000b0049d9a8cf857mr10654639edc.1.1677453506773; Sun, 26
 Feb 2023 15:18:26 -0800 (PST)
MIME-Version: 1.0
References: <20230226083347.80519-1-gvivan6@gmail.com> <CACmM78QTptLOvNHs9oE2NNareSNDb+ydGFKr0VHuboCBWSZbSw@mail.gmail.com>
In-Reply-To: <CACmM78QTptLOvNHs9oE2NNareSNDb+ydGFKr0VHuboCBWSZbSw@mail.gmail.com>
From:   Vivan Garg <v.garg.work@gmail.com>
Date:   Sun, 26 Feb 2023 16:18:15 -0700
Message-ID: <CADupsJNfiW5ep-kfoGNqK8p-ppUG6POnPa1Q3sJBFDQcQ9OdHg@mail.gmail.com>
Subject: Re: [RFC][PATCH] GSoC 2023 proposal: more sparse index integration
To:     Ashutosh Pandey <ashutosh.pandeyhlr007@gmail.com>
Cc:     Vivan Garg <gvivan6@gmail.com>, git@vger.kernel.org,
        vdye@github.com, christian.couder@gmail.com, hariom18599@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> you should include a link here to Junio's what's cooking in git where
> your contribution is mentioned.

That's something I've already considered. I didn't do it yet because the
status might change by the time I submit my proposal, so I just put
a placeholder there for now. Thanks though!
