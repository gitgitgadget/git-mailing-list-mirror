Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5D3ECAAD4
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 06:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiH2Gg1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 02:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiH2Gg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 02:36:26 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79A32CDC7
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 23:36:24 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so7609926pji.1
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 23:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc;
        bh=8+Txb7RMxNYcVveFKiWaRS+abml7znua/jVHtLOPAFE=;
        b=DBKI7seP0lf7H2B5K6IH8slXm8LrKyfq+Vx+XC3JVAnnot8mgfL+L2cYUdr6GITQpG
         wAxR3B9JLvz8bafK4HD3PUSnn8C2pgaUxPOFDNQrQfzBNdwKp36zZrjoim5+BjomqZlF
         wLIgH6O/d2TnEdsYH6ojcjgkfUcdz6iGknPIHzljJsOm1l5xjlQ127RB/bDgXpcwn7TD
         rzDTksIdEc5av/Mwdk18t8sOnz3UsY7F4RXg4DGOBRYFISML/CMP5LTtdOwJSCfupoNR
         RmFBvqvzkOvkg1z38UJBK6L6W5MbPLpJvPnvYkLGdn5HD64kQ9Edwcwt85oKUzAmNuv0
         6Uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc;
        bh=8+Txb7RMxNYcVveFKiWaRS+abml7znua/jVHtLOPAFE=;
        b=xZ+Vur/yUdc59WrRIDy5PbGRiKby5iuG7UZOGez91wV6LbH/Javld76uRVK2SwcP0S
         OYjllljT9LLKuD0pUFqRphff6PsZUPLS9GMCFyq0tK9qAw5S3kW2wMH+LGRRQBok5Gge
         dIsGi64Y0XqXUY3t9qqu6Zwj8cld98UtNyDYcnKYgYNMVaHcqEP9RVujEBmAdgNJgdIz
         EIXaENVpr9a8NJh1CGuwp8WgyF2/aXCdEk0a2OJFtE+pYC0ZC4y1RodVSYq62kuJ3U+U
         gKSzmT+hX/2bXXNypAsbRJk+WzJhobS22KD78Bmx8yn1RaRlM7/+76StCpKOxy8Tedr3
         +bog==
X-Gm-Message-State: ACgBeo3s0AiqJLRzk/y/dvn7bGs5smY/15nTYLO4SEu7QbF9oS/VLse6
        evLnN/yuWHPn3FlhJiHXiehCARsGY+4=
X-Google-Smtp-Source: AA6agR6KRV6bI+6Ix4zAUlN1/+6Kos0YKeb9eRxJxFHYnrBIMdW91va+ryRiJKZ3h6BW7XYGmdJdIQ==
X-Received: by 2002:a17:90b:4b47:b0:1f7:2e06:5752 with SMTP id mi7-20020a17090b4b4700b001f72e065752mr16873377pjb.187.1661754984144;
        Sun, 28 Aug 2022 23:36:24 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id s6-20020a170902a50600b0016dbe37cebdsm6552350plq.246.2022.08.28.23.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 23:36:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Caglar Akyuz <caglar.akyuz@sparsetechnology.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Ambiguous 'HEAD' issue.
References: <AM0PR08MB4323160241D4341FB1B99CC2FD749@AM0PR08MB4323.eurprd08.prod.outlook.com>
Date:   Sun, 28 Aug 2022 23:36:23 -0700
Message-ID: <xmqqsflfr1y0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Caglar Akyuz <caglar.akyuz@sparsetechnology.com> writes:

> * find . -name HEAD | grep -v modules -> only .git/logs/HEAD and .git/HEAD

plus "grep HEAD .git/packed-refs"

> * git branch -a | grep HEAD -> nothing

plus "git for-each-ref | grep HEAD"

