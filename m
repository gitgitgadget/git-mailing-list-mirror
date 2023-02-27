Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1FBC64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 16:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjB0Q5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 11:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjB0Q5A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 11:57:00 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5F023C46
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 08:56:53 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so6247159pjg.4
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 08:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wK3pOLPvRp3uDEd+Zlx0ZsXvlkaOtGan8UDdVsAsHpg=;
        b=Gk+VAwZpuU+toQ7K1cdmVntC2dwL0znG/NGX6Cr8AUSN+CPQHAXBvfL8hB0JylH0hc
         r7D+pRcfI1jYUeYknHwdiWg0/WB3/V4I9DNZUo/GPL7SwWk4Zz0i+u+PpFqEBJWa5mm0
         TI5VNkiXYiFY7Vp+yQdwRWLaQPN5rOPmQZozdRsJambfQQrIrZ574KAvLtduZ8siKayG
         FwZplJFsK1PPjYNZVpaJQcENBz6+bNwreYUdFoRK8FWAAG2jqkREx9p5u9cidFwnVyqo
         nkKZcMTndPYwmFf04+KfWWhDt5vIc+w8Gm32aw7omJ89DX28BIp658D6eJmoTLJh6ddY
         forQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wK3pOLPvRp3uDEd+Zlx0ZsXvlkaOtGan8UDdVsAsHpg=;
        b=ryWyimPDKmz11a+wgP3/YI5wRsj83Pr6tC99+kmNkqWOTqlJibjWkkhaxWoatJxa9h
         1yFewcgoytLEoih2Zm9G/+ShuMBrnoMptqeHyJkt/GKgFSvrYek/wKVSwSovSLFaSEcM
         LaAngkW/+IDVJnVaczKDKxVygFnNo/H9EJ1XaG0BQfxS9Ley1eoiM+Gep+1ZSC+gYjHy
         EJo/sqjjBotFsY6+ZWqdjX0aVx7Iwhkk6cKmNzsHVlaiVNqKIo6yY3jpkSzawcTsX4pd
         0rVQPTBYlv+VZEQvhJRNfr4Rn77Hi7GvKp/d5qabVK1O9oCykvlu9rjUrKluSUvc1nx3
         wxIA==
X-Gm-Message-State: AO0yUKUIhUeMYAMlwI2K23zfsib2JQRzhfPAQSeUPbhciYzbL2OkZeLn
        cM14UrfsYAx6YhsTtRV/9xYJqWeAufc=
X-Google-Smtp-Source: AK7set80woB4EWyhUgjMHIKxHhWuNTBbZ0vfrQVNwsF6qE+oIdpwNYUlLp6KNcBJpZ9ORhX/ks+T/A==
X-Received: by 2002:a05:6a20:8e06:b0:bc:8b91:69a3 with SMTP id y6-20020a056a208e0600b000bc8b9169a3mr21364225pzj.46.1677517012553;
        Mon, 27 Feb 2023 08:56:52 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.144.45])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7918f000000b005d3730383a7sm4433800pfa.220.2023.02.27.08.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:56:52 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     five231003@gmail.com
Subject: Re: [PATCH] index-pack: remove fetch_if_missing=0
Date:   Mon, 27 Feb 2023 22:26:45 +0530
Message-Id: <20230227165646.6777-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230225052439.27096-1-five231003@gmail.com>
References: <20230225052439.27096-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Waiting for review.

Thanks
