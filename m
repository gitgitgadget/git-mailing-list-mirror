Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AFCD20286
	for <e@80x24.org>; Thu,  7 Sep 2017 13:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755372AbdIGNvk (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 09:51:40 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36347 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754393AbdIGNvj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 09:51:39 -0400
Received: by mail-lf0-f48.google.com with SMTP id m199so24672698lfe.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 06:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=fI8QBfxvYkOm5m7i4x5bOAE/DX15bsB0FBXihQnw6cw=;
        b=I9qy2O/H5Hm79lQ4IPRd1uK8S8gJ+uwniidAp8w4b88t2XkATkF4o0Qdw8bWb3PLzW
         Uenisj4rak6eeI+hqQv+fcvTUAb8OYu7VrZsdip5haClwkBDDJY7gI/zfMlp9VuC4pa5
         ETxsqI42NNAG4eqIj23gYNPi9Vic7A+1mi2FBo1gYYoeRGHp24JXgtocpdMjLWN8qq20
         6ikcNEaAvHim5kMUBNvKROZHiHZ3BUUNoJsKkENggZZEYb2LKgH1011f2YJWv2boqHhg
         IHnND3gzicFU3qSdERTaOq6/gw8PZGF8r/FxI2WoCIUk0FcmX1yVDJrFN2g1OXWtSYdv
         Mt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=fI8QBfxvYkOm5m7i4x5bOAE/DX15bsB0FBXihQnw6cw=;
        b=oZA3Fm4JaQ2L+xF9mrK59KyvtDis4L2VFzSh0gRhINdTG5vNZDSh2qGEcZsivGarUf
         sfavZ66MvB1rWTIYmo4X3prZ97qWqWDZoTGuVM+BDo2hqo7GUP5yig/etHji6H5dt6k+
         TgzJnnSv59OPyJP/JFxuCfuInCLNrN9MukA9OPnO0pVzuMYsc+2T0jqqcq1FyE8AhNRi
         9fha0qise9lEYRu13qJHLUhqprPFllYWuksTojDM1uNRpRrB2dDsB1npeaXoVQVt0Vu0
         ADI+m7PmWhEi/hkNGOjj8WPOAfo9zIskloIyJj2B4tugh31WU4hFWls9BD4XjgrJr29v
         zyqQ==
X-Gm-Message-State: AHPjjUib7lcJa2C7yrizYgwijYDXxHOa3hKC1xTohC/CEPnwbAxY3Vm+
        WxZgmbP4+7vy5FXW1Kg=
X-Google-Smtp-Source: ADKCNb5qXmZrH35wCclTz839X6uk8dUHgRn6CQx6COvVvRTbT2JtNsJzD9ja99LRoOHb9kg3PuAP0A==
X-Received: by 10.46.69.67 with SMTP id s64mr1231207lja.149.1504792297773;
        Thu, 07 Sep 2017 06:51:37 -0700 (PDT)
Received: from [10.2.14.166] ([95.67.107.166])
        by smtp.gmail.com with ESMTPSA id h83sm202345lfi.16.2017.09.07.06.51.36
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Sep 2017 06:51:37 -0700 (PDT)
To:     git@vger.kernel.org
From:   Aleksandr Makarov <aleksandr.o.makarov@gmail.com>
Subject: [PATCH] match_name_as_path: Pass WM_CASEFOLD to wildmatch
Message-ID: <79c946a2-532e-1c9b-7bf2-1f1ccbff721e@gmail.com>
Date:   Thu, 7 Sep 2017 16:51:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
  ref-filter.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index bc591f4..3746628 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1663,7 +1663,7 @@ static int match_name_as_path(const struct ref_filter *filter, const char *refna
  		     refname[plen] == '/' ||
  		     p[plen-1] == '/'))
  			return 1;
-		if (!wildmatch(p, refname, WM_PATHNAME))
+		if (!wildmatch(p, refname, flags))
  			return 1;
  	}
  	return 0;
-- 
2.7.4

