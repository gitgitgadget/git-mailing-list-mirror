Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41420C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 23:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C8220740
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 23:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa+TID+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgCSXre (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 19:47:34 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52783 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCSXre (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 19:47:34 -0400
Received: by mail-pj1-f66.google.com with SMTP id ng8so1699119pjb.2
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 16:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IhvwaPNCF8PqXO8VXVqavfdlzYuD5DrBLWVJpYaQUJE=;
        b=aa+TID+O0Bbdg6OzGNOgb+zPEFoRG8+7lwI7RIMt3vyYwlgL70jSYYjjoX8L9cIYI7
         IDWImJBaNqLC3uEIbLqFOopEg7ioPS9ogDNPbKBdH0aod0K0FHlCpXuLP46jYDgUe4bL
         0f8iqSH5LDT+oBXd/AufjTvgqzyhFL5XU/hBP2HaftjoCsfd7hize9ljiWnyN+4UXiGO
         MF4fy3Air6aFNP4bu6gbVPdjrazKPsEDcod1VieVZXtzfwxKs/WZaSxB4MBfx6eOZjgT
         0WrRI42gIXbcMSoV+bPvAdwHr1XKSM96oEeuAHXzK2W6U3qAOjsweFdHim0vbbtj/e39
         2XDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IhvwaPNCF8PqXO8VXVqavfdlzYuD5DrBLWVJpYaQUJE=;
        b=En9Ekp5zAiJcH42Hwz0Q1IlFnN7nZ89HIhWGcLMZ4QLSYrCCyLGVtkbUU/vh6TUq4w
         5voVt9Nvat2zo8eqkxaTwnslrxm/8qA3rJo2hH8Q/YVlfn2Eg3rSVoKmKWaBQxfMU1hl
         SwBfLzgSM8dH+BW1zLEylqha8N0pV62SdVEsM9HmRVSsq+wv07O4LI7TK24uiLbRvQuN
         A89x5CdvcoxbqdIM1yE7vpkmpAv/smFgTCK+uJd6A2+QGDsIbCZoYQut/DfPjm7sbnDL
         +dD1H/+XKHGufHIM9SM6Hsu8qqLrPD8zCwDFIXgOZibSLnOC5rMxEMYe/rK2SJQNrTNo
         6Kkw==
X-Gm-Message-State: ANhLgQ1umj7srMeyJPqfpOVpxqyK5LEb6OEgHv+sPVDyDLolOnv8ZszL
        5T+ykUfkOI6IMdjWxwqFx0wvp7RNdpY=
X-Google-Smtp-Source: ADFU+vtY8GGyL+583pQL7eiAUoNtVvryMa25DO6aijfbyTklskTfGTTz1IwnWiioTmEi/ccMAhOh+w==
X-Received: by 2002:a17:90a:fe08:: with SMTP id ck8mr6539973pjb.56.1584661652793;
        Thu, 19 Mar 2020 16:47:32 -0700 (PDT)
Received: from localhost.localdomain ([36.77.94.225])
        by smtp.gmail.com with ESMTPSA id i126sm3347187pfc.105.2020.03.19.16.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 16:47:32 -0700 (PDT)
From:   Adrian Wijaya <adrianwijaya100@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Adrian Wijaya <adrianwijaya100@gmail.com>
Subject: [GSOC][PATCH 1/2] t1300: replace "test -f" into "test_path_is_file"
Date:   Fri, 20 Mar 2020 06:47:22 +0700
Message-Id: <20200319234723.6504-1-adrianwijaya100@gmail.com>
X-Mailer: git-send-email 2.26.0.rc1.11.g30e9940356
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,

In this year, I intend to apply in git for GSoC 2020. This is actually my 
first contribution to the git community. I am a sophomore Computer Science 
student at University of Indonesia.

In this patch, I have replaced 'test -f' into 'test_path_is_file' function 
(can be found in test-lib-functions).

Suggestions and advice are very welcome. 

Regards,
Adrian Wijaya
