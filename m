Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F69EB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 13:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjGKNwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 09:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGKNwd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 09:52:33 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C4E94
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 06:52:31 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-635decc135eso31771106d6.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 06:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689083550; x=1691675550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HLCkt1myFgRpSSSv23nzdSPJiFt1nFMfQcyrg43Hwik=;
        b=a/kCVpF10yx2Oqdg3FjuLGQMxPkIc71WY8Zn1tzzeMnS2Klqj+dEKKqWJWbV63CNZO
         BrTssRZGQM5d7lv13Za3nCiwBJ27xNuM63cK8Jk8VANpVx+0PDjGKXCRUNN6IovaSnK7
         /GdnxAmD7f/46o9XAKNLI8/mopHxM6q6CtaiVTUUL9DuETeRFOjJsVE+icV8K3tbzMqd
         c2NycJi+2LhoIIFjor9Acvx1NaS7wZKhZ8wLpnAxFR5SgSiEV4WIuLzQugDV/X+kO2OU
         azA7ToGZsCKA1mfVJ/sedw4j5qEcQMyK+cA9Wx1bN8dw1Ok6vfXF6ckSCPpfu4aWS59B
         EnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689083550; x=1691675550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLCkt1myFgRpSSSv23nzdSPJiFt1nFMfQcyrg43Hwik=;
        b=jeEoh9zWGJ/DlDwas/OhdAwNELmPagajQAXCqbFQPZZTzHGMjKO2rtGwoW5kaBbPjo
         9J9v7N3UeWUcV+iu4blSGbSSlWaROTzb13VtI9b0Jf5NugZvRzS0Zhz9XBk4adLVvGMP
         xga5eqcsNGyXI1ewmQzFVgiw9sBwcnFnVe+Mb0RBWERhFsd6ZVVe4ZnkTLMZP7fq47VK
         lHN/l2g7nT8gV9D+Bkk2UpSCTcUJBKuEw7Bvms1otUGBri6YFIuS71ccOerc/aTjRaMd
         l9U2MQyuOyYFuZWit8KhIg5pwY83iUIIJdqRozPuaz21VMjJ+JVkwinF220PhvvdgRet
         THgw==
X-Gm-Message-State: ABy/qLZtB4UZ6ogSm0W4tdDWMGMNlRdPGSGNevtQ9oSl+K9p9o4Gzf/g
        f4iddZRvbO4pSlvy1zLktZeGoM6qVVgeGw==
X-Google-Smtp-Source: APBJJlFOOsoMuKztchcaEhIRvXwJkBJqAsxxwNEHTI3swBlbSWZ3+O8ITqa0pM8N+lk7TsFOoWjNig==
X-Received: by 2002:a05:6214:ca5:b0:637:9da3:9193 with SMTP id s5-20020a0562140ca500b006379da39193mr19899435qvs.4.1689083550422;
        Tue, 11 Jul 2023 06:52:30 -0700 (PDT)
Received: from localhost.localdomain ([69.158.190.118])
        by smtp.googlemail.com with ESMTPSA id i16-20020a0cf390000000b0063640486254sm1067814qvk.116.2023.07.11.06.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 06:52:29 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com
Subject: [GSoC] Blog:More Sparse Index Integrations
Date:   Tue, 11 Jul 2023 09:52:14 -0400
Message-Id: <20230711135214.17445-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Week 5-8 post is here

	Week 5-6: https://cheskaqiqi.github.io/2023/06/25/Week5-6/

  Week 7-8: https://cheskaqiqi.github.io/2023/07/05/Week7-8/

Thanks
Shuqi

