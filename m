Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD38C07E9D
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 22:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIXWxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 18:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiIXWxW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 18:53:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630034507F
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 15:53:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id cc5so5032563wrb.6
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 15:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:from:to:cc:subject:date;
        bh=bl1tYnRSIjxRIq2YS+H19QyoVVyoTSMhnItcJcr3N74=;
        b=k1hhJm0iXrtueUO0jqnd8TTw6iM/UgBJmK5P+ZMmNdK7hLeUvMurXj41Nayb2k7aup
         Rt3fDe1JBcG6Cj8y2/j9noODrFJ/X4W0xkfdad+FlLPSp40erL+Y7b70crXg2W1I0S2E
         DPfhh1RE8y+hHfFuDmCwWc6UzwE2JYoia15INQav7FYLV8e0/1gXbASYIUP1NRJVJiuj
         iqCRkkt03EvOHXMpbVLEPI3z204suyPxL17cskrWY+o9iLJWQXBukNOisRQ/5cfB1fw4
         dxEW7pR9YbO8KL+E2TS8JxqwiiFkK60viK3CoLbQC82sgK/IfpAaIb1DhRuUzJ+Jh1Q6
         W16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bl1tYnRSIjxRIq2YS+H19QyoVVyoTSMhnItcJcr3N74=;
        b=UablSNzG3cgm/XIMrVsYCeBSrufE6vEOl4hWOTzj+iBaWfN6QXzuWyUFDWcI/qaAWG
         giRsk21oKETQ4WhYScZV0NxPEff5xjPfSYNzDVELLI2G+cyBk46wV99zUA+QiCD1dtmu
         LOr9NVTglMAxCKWiF+6tJjccBvXaBnKzyao14obvn4AleoNFROHoFK9CXH5BLEHzG0d3
         MJnyRDjPzBCaPBiYTo2bXJYXqJcuH78Yp/iocMagbZjBdx4YYT5yNxv1IAK0TG4a1gAI
         +5Eum7uZ6nyKKRhZfZTh+cRnj7r4Fay4J01HZssdOcYUCf0suaAlKHsYx7KarDgsDi1o
         7U8Q==
X-Gm-Message-State: ACrzQf0ZA/LamdLLTGfv6I/vTv8G9C+rMKyzWOpx1Y0gBfnxeqvjivHk
        Se+qXE0qf4hScqatNeSPz+kH5FKNmis=
X-Google-Smtp-Source: AMsMyM6SpaO2cFdWBd5EX7P1sWCn0f6wem1Gt9CT+g8jMvEgmDFBWm204awIXXeFJiVg8pTfr+3r3w==
X-Received: by 2002:a5d:44cf:0:b0:228:dc26:eb3c with SMTP id z15-20020a5d44cf000000b00228dc26eb3cmr9131547wrr.389.1664059999850;
        Sat, 24 Sep 2022 15:53:19 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c4d0700b003b4e009deb2sm7123098wmp.41.2022.09.24.15.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 15:53:19 -0700 (PDT)
To:     git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH] ref-filter.c: fix a leak in get_head_description
Message-ID: <6ff29e96-7f8d-c354-dced-b1b363e54467@gmail.com>
Date:   Sun, 25 Sep 2022 00:53:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 2708ce62d2 (branch: sort detached HEAD based on a flag, 2021-01-07) a
call to wt_status_state_free_buffers, responsible of freeing the
resources that could be allocated in the local struct wt_status_state
state, was eliminated.

The call to wt_status_state_free_buffers was introduced in 962dd7ebc3
(wt-status: introduce wt_status_state_free_buffers(), 2020-09-27).  This
commit brings back that call in get_head_description.

Signed-off-by: Rubén Justo <rjusto@gmail.com>

---
 ref-filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index fd1cb14b0f..914908fac5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1722,6 +1722,8 @@ char *get_head_description(void)
 	} else
 		strbuf_addstr(&desc, _("(no branch)"));
 
+	wt_status_state_free_buffers(&state);
+
 	return strbuf_detach(&desc, NULL);
 }
 
-- 
2.36.1
