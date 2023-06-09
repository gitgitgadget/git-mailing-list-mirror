Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDDDC7EE29
	for <git@archiver.kernel.org>; Fri,  9 Jun 2023 00:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjFIAIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jun 2023 20:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjFIAId (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2023 20:08:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DC71706
        for <git@vger.kernel.org>; Thu,  8 Jun 2023 17:08:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565ef5a707dso15856307b3.3
        for <git@vger.kernel.org>; Thu, 08 Jun 2023 17:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686269311; x=1688861311;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vZTj10KVmj+ho3ah/PjGr8swdjkUjStfgzmuiqxO2t4=;
        b=3RFhO8xUtP92IqqbvYyHHHaamT48+cxuLJsXJcnJhC7V83cc+1p0e4Yw+N8I/P8ZWi
         oi8+nqICEt6851JyEZzeCwRi52bqAk3W9+ngNOSPDfvmmbSYKN/JAPuDaS5lNNdxbS+d
         D16uDPeDp+BG1YEB3/pvQu42bbmtV4Ldsdt3xmNh8pYEOPJ36LLvTiJAlzK7sUWRrGkq
         xCX+M3oB4p5z5HjIBz2msbS5mZcukl4p5PD6EfmM5Ue1iV3ah2VUekTjohU5bXOh2EzF
         e4ArF2IDP5CSVjUqsnbqckHmYGBmG2A95AstdJDy63xifIcTK+2ClEgLfl2toeLbmZp9
         +1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686269311; x=1688861311;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZTj10KVmj+ho3ah/PjGr8swdjkUjStfgzmuiqxO2t4=;
        b=SxLMXqn6zBdjaL4f3EEcgx4BsRMhvJyhpXXL1julLtnDNl4vZSJuyUq2Jlj4H9luZ7
         08bCfey0nKN6Vh0B86xvkf4dIHbTmHyZRU8H5KBhRe2bfWhjQcaDBicSCed/09kXfhAh
         vDgFMltVm5pAN6U7Vjl2KfJWh/nvyZTMqiEvYPIFIrrvPRbZlFZB4eawPHLg4PFGny8S
         oj/hAtKUbbWgrfUd/w+93cCAgLtCvSCY/i/f1D+mpsdG3jAtigT4v44XL9oTz8/uFrcP
         b0kkSx1Zg19JiPSyVzfjuXluQ7pRME2kPkaYLPmz9RCVzK6jJrx8+rUIbA9guHg7RdOJ
         PCIw==
X-Gm-Message-State: AC+VfDwORoSOZVRMt+qE/HsLzUI+WaKromu9G41JfFYQTzjx4HndImMW
        ZD3zG5gfZplIjolbOGjE6eOGtLz/E/+80FX9zmfg
X-Google-Smtp-Source: ACHHUZ4WwzUd7smtsLyEx+DWYyyYpAQjOy/699H7jpZvcs86d7WEVhqGRyPtbLSGzkod5cSlw3ErcX2ladEMl6zFtnX2
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:bde7:a867:45f9:3528])
 (user=jonathantanmy job=sendgmr) by 2002:a81:cf02:0:b0:555:cd45:bc3a with
 SMTP id u2-20020a81cf02000000b00555cd45bc3amr698008ywi.9.1686269311414; Thu,
 08 Jun 2023 17:08:31 -0700 (PDT)
Date:   Thu,  8 Jun 2023 17:08:28 -0700
In-Reply-To: <3ff7acfc-0fd2-88a8-3e31-2c6405a03f59@ramsayjones.plus.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230609000828.1762551-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 0/4] Changed path filter hash fix and version bump
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> >      +CENT=$(printf "\xc2\xa2")
> 
> I think the only change you need to make here (because /usr/bin/sh
> on Ubuntu is usually 'dash' not 'bash') is to use octal rather than
> hexadecimal. ie: CENT=$(printf "\302\242")
> 
> HTH
> 
> ATB,
> Ramsay Jones

Thanks! Yes, it works. I've checked that it passes CI [1] and will wait
for other reviews before sending out a new version to the list.

[1] https://github.com/jonathantanmy/git/actions/runs/5216513514
