Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0D1C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 08:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347936AbiFUIbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 04:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiFUIbk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 04:31:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AECE13D5D
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 01:31:40 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso13003228pjg.1
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 01:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5G9iJp+tgBuyE+X+6ULFAXAiMEfAvHHhRGUzafj7Hes=;
        b=nPvjbTx4byneWgjKm9yWID4uIv/aSvVVHv+aepQuhpHJVZ7Of0VngXvTAapbIP73wQ
         hwujUmJtcRXIJhPLWJcnaFPiTAI27KzAA1I5sH7ZD2rYyNl1qVTDyhUfHo9U3IOkFkGj
         L6YnGCb6S0l0iux5ttDHGao3wonGYiIifUtIxIMZMyF3awP/5V0d2lZMLq1z8IpovR9A
         QiefEf990skL/7+GtVGL+3zZjpw1Cyc6GuqTumZML4fyPjbjPOiHQtVoiQIRZssrLZWL
         4+PjnEmxjMEFMNAngM20olo5bCxsv7t6YrySZhif14t8+tl5w7uZJWwPL7uUloFQ/WHW
         dAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5G9iJp+tgBuyE+X+6ULFAXAiMEfAvHHhRGUzafj7Hes=;
        b=wE+BLIAZi5crMjHY0Ge0X62fFnZVE/vscWB4fN7VqnQGCx5NVxuGywNx3mApIcGlP6
         N81TdCZ0aj2TBNkm7QFTTdCX9IWMrUmyZMLF28eIneHoGOtQ/hChsJVvPJEdqOT6qKXL
         7CyM0p9EOGEsH1VFGxq+3/4clOVp/SebtbJZ5h69nbu6+mBSj6T4Po5K6bYazONYcxm2
         667FyTjW4wknEtzbL60C+L6ki0dwBBa1y20/AobhfvH0udyMk6SOgHXztznYfLtUXUob
         398bq/izjk4sr2h+C3uTvcGE5af7CYC8S5coYPivziKmA27nFoaAAIGvtD11be9925MV
         eVDQ==
X-Gm-Message-State: AJIora+5OtiqAH+vh5HYTYNoNiq/uxSTnbqZ0UameOm8QgY5InkVM34O
        57FpLzvuwSg7e1XIvr+wnTLqHBliW7M=
X-Google-Smtp-Source: AGRyM1tKsYLh+UJQ2U0ysuS8X8qVQ2MWOjvlQYJvZGYuGilphHs/PIq5AYW+S46/hYe5/WigH09PHw==
X-Received: by 2002:a17:90b:4382:b0:1ea:f4b6:1e29 with SMTP id in2-20020a17090b438200b001eaf4b61e29mr29242207pjb.159.1655800299609;
        Tue, 21 Jun 2022 01:31:39 -0700 (PDT)
Received: from localhost.localdomain ([2409:4060:e8c:d9c4:a028:bb47:21:6f27])
        by smtp.gmail.com with ESMTPSA id j2-20020a62c502000000b0050dc762819bsm10563262pfg.117.2022.06.21.01.31.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jun 2022 01:31:39 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/6] Documentation/technical: describe bitmap lookup table extension
Date:   Tue, 21 Jun 2022 14:01:14 +0530
Message-Id: <20220621083114.21429-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <YrCpv3XEoB6lOlY4@nand.local>
References: <YrCpv3XEoB6lOlY4@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> wrote:

> Abhradeep -- do you have any thoughts about what this might be used for?
> I'll try to remember it myself, but I imagine that we could just as
> easily remove this altogether and avoid the confusion.

Honestly, I never understood the logic behind adding this flag option.
I thought you have a reason to do that. Even I was thinking of curving
it to 1 byte. I will remove it then.

Thanks :)
