Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B29C43217
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 18:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiK0S0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Nov 2022 13:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiK0S0J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 13:26:09 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7121E62C3
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 10:26:07 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j16so14224380lfe.12
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 10:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H78+++70eyQQCpqgQ1lLWATgjjcdpKW5LIvZ2N8DUOU=;
        b=TLX+SgiWg5zsNsQSC8i1K1PHanyafC78WsYWob6szALut96ZmpYyPqHp9SKVpOku1L
         f6M3qrtg5mIlC2ShKpcGPkRjyWHA/6qXu+JWwy9SG0dcBMaZIMVyQSrAVnWCV75sT2Gx
         Uiskvnipz+yZm6kXrPmqWAvRtkcar9ANCLyCY0E0obD/chrDpM5mKFNri16oiCxnbOEZ
         NYMOhcyJMkCHceQFRsW7ezm0bmnpNSz7ZKl077FeIVdQuoMpHu8GapxheXVDHHDvAm6/
         Twv2Y6qE5u2eBhva3e9SaLM8cXzl34kZKtoiPGznMxQ+PMiz09nTteDvojdhVANIjWRN
         hjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H78+++70eyQQCpqgQ1lLWATgjjcdpKW5LIvZ2N8DUOU=;
        b=TNeyvJWpFKSJcUUtxtgHTlGW5AVdg8y3+pdSEZ9YNgGAANmH8UI0OiQk5L56ayXabL
         GZ98s23pq/xUXhy36HxcwghWlXF/fbTgVMW/G71+S45FyTgAX5W+Aak+McKX2Y8psa84
         8zBud+w3eKSvWqlKfk2aHE3WNsPXiJrU1NloZtr/D0y8osBX2puevh9qsAixJ/vFMPV7
         yIFgHLy1JX7EMJtaJSyWYYg+qC5lW7qSIMZVAoajF0o8d1c4QU4wEG6LqkZWjRwPCo1C
         i8AgyrHG1J6Ty3e3On+pNqeCG3fIiSjs32nKvZUOIjNtMtUfK0pROicSUSpM6aSnWU5R
         +TMA==
X-Gm-Message-State: ANoB5pnNBWmRwHwpciJ5z+R/qYGSrQkBrBLpuThEj4o+D7ZK3Ewo86qb
        3jJmTeN5n6jLfmVKcqfmZLqjT82Hb+GjnNrqdzTCCg==
X-Google-Smtp-Source: AA0mqf427r+5uYUBGc9e8iihg5MclwisfT18c2QqHnRewLbCF/YbP6L6+V3sWklDpF3Y6IB/m6AAgg==
X-Received: by 2002:a19:690e:0:b0:4b4:6c29:9580 with SMTP id e14-20020a19690e000000b004b46c299580mr17607728lfc.299.1669573565243;
        Sun, 27 Nov 2022 10:26:05 -0800 (PST)
Received: from [192.168.1.7] ([95.165.148.251])
        by smtp.gmail.com with ESMTPSA id r2-20020ac25c02000000b004b4e373df2bsm1387043lfp.202.2022.11.27.10.26.04
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 10:26:04 -0800 (PST)
Message-ID: <16587f28-bd73-39ba-04da-bd0e2240f48c@gmail.com>
Date:   Sun, 27 Nov 2022 21:25:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To:     git@vger.kernel.org
Content-Language: ru
From:   Kirill Frolov <frolovkirill7@gmail.com>
Subject: git ls-remote windows issue.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When i run  "git ls-remote `origin` HEAD" on windows machine i get 
"fatal: ''origin'' does not appear to be a git repository"

When i run the same command on same repository on linux machine i get 
"b7efcb7055a6d45f53c05270a2420aaedaba4d02        HEAD"


