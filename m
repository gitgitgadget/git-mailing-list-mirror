Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D113C433EF
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 08:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiFXI2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 04:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiFXI2M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 04:28:12 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6FFB92
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 01:27:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 128so1918784pfv.12
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 01:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NDGIO2E+UDb8oeCJIHVwXLaUmgW+HVCLLhVYbneXxpQ=;
        b=f6cUeUyEZhv5uD2zerH9uaJqDr+zYZzYx7sMz5dzwbEVSyEksimexg4bvQs5JPWL3S
         JsNPWRAlmlQYNt7lMdVc8lkfNBEhpTQoyyvTw5bseJCG34CQGhJh59h6cwYaNqlK8KeP
         ITcIj2vg6CzuuexDLh2vGx0yFkscXdqAN2aT9AKPybzJariWAKVm/QjWZZJEbg7O0AKk
         V1SnlQDmq1FUb17S0AiO7g+8ooVVXan9dAGHpCDZoIaoQktX4o5muK9/fzRwYOdtpAMP
         dEmn0V2EBfofngOrdrJMxFSU1A/WZCr4k52QFTwgnN+diJn+CeXxlM/wcrMFWpzKpAP+
         /dFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NDGIO2E+UDb8oeCJIHVwXLaUmgW+HVCLLhVYbneXxpQ=;
        b=EE3S5ibm2X/tYvL0WrE4of5iYSBWGWukghfz2sMv8xpxlIxoxgSbSSKPs/4QcjQA9c
         JfBsOEY9qD83HESSM+8wDEO8o3n+qGSoymGsZKz3qNC+7GS46T4+2g8sEqidfuPPJLR6
         ZTc7wT/MmFqZHv8Q8+ZMg7k1wxBX1S/c06MrF5qZ5yBi0QrSpV6uDFPsmNJX9qy+kiFx
         dIAtDBPUKWF7CuwyWz/SVzPXZoU9mQz3bUpXbXPikvc4e5eBs/VOqYCaeIB4OUZ25an3
         34R3GOzE0w8XfAdhZuh1IDtaRdac7QqtB2+zqo0CC4VGYULe/1eVvaIgextx8kz3vKNZ
         LHWQ==
X-Gm-Message-State: AJIora+vq6s4H+eZCJjMApIH0FGfc/Mi99dazv6RyoBfqePotcfzrNqk
        PmJbvAJttIRXIxlaoMQr49o=
X-Google-Smtp-Source: AGRyM1uBIHwJi/gRaTnzv6lf2ZZ6NXXr0MFMol/S4mN9Wh/JJ3itJAs4KnkHL0f1MZRcmNzl6NsO3w==
X-Received: by 2002:a05:6a00:140a:b0:4e0:54d5:d01 with SMTP id l10-20020a056a00140a00b004e054d50d01mr44657004pfu.20.1656059275524;
        Fri, 24 Jun 2022 01:27:55 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.45])
        by smtp.gmail.com with ESMTPSA id ik8-20020a170902ab0800b00163ac8673edsm1210122plb.35.2022.06.24.01.27.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jun 2022 01:27:55 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@jeffhostetler.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 5/5] bitmap: add trace2 outputs during open "bitmap" 
Date:   Fri, 24 Jun 2022 16:27:50 +0800
Message-Id: <20220624082750.90840-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.1464.ga089800b9d
In-Reply-To: <a4dda985-a319-2c24-2957-5116831142b8@jeffhostetler.com>
References: <a4dda985-a319-2c24-2957-5116831142b8@jeffhostetler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nn Thu, 23 Jun 2022 11:14:27 -0400, Jeff Hostetler wrote:

> I had intended it to only print the final "effective" value
> that the command would actually use.  I don't remember if I
> ever experimented with config values that are set at multiple
> levels, but testing it now shows that you're right it does
> print a "def_param" message for each level.
> 
> I would suggest we fix it to only print the final value
> since we really just want to know whether the command will
> or will not use a feature.  The inheritance is somewhat
> irrelevant.
> 
> But the change to do that may be quite a mess, so printing
> the scope name as you have here is fine.  And may help with
> support when debugging users having confusing problems, so
> I'm fine with it.

Yes, as I replied both way is OK for me, but sorry for only
replied the append-scope way. I will post a new patch v5
and include the related changes to fix this. 

Thanks.
