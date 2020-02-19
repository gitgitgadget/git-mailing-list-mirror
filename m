Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5653C34022
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 08:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF0F2051A
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 08:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDoJpVBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgBSI5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:57:22 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:40607 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgBSI5W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 03:57:22 -0500
Received: by mail-wr1-f43.google.com with SMTP id t3so27185833wru.7
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 00:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=HZR5Q+Qc7Hv9RMTJN8XFr2Lm3BK8EWXld14oaje4fRI=;
        b=mDoJpVBHI7dQjapEvDSjPI5sR3/XLbFk5+lVL+CY/tznaIqZioSN/X00EM5pWNsN0S
         gqKmLta78GJKZsOMDnzs4aKF/58hAymIp+k/Sqa6tlkMXDEYGpW/X6LtZqka673+TlO0
         isGjoTJNG36Z4YMTbtAnpbZooKgKhvbicLV2mOCkoJfDiTIdqIQreGwrL4lfi3mDsCl3
         nPjI9p4IFedKuneWf3ScuQWYFYL2KzXaO7ATE5p419kpEVXYn9U6VZxFRfYCRTWgMECm
         ehzlyAN2pppti3C2m5BSt4XYBc13XjRsaoXB5+XZXXWbSKPqpj+3aBiQAms1Xll0zEY7
         HHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HZR5Q+Qc7Hv9RMTJN8XFr2Lm3BK8EWXld14oaje4fRI=;
        b=X8kuBoBME6I5L6PzuE5FLe8uwqjXbyuFbSLdGr8/NmQpGKdJL36VEikzhgT0NIwW2C
         kMwfLLHth+AzPDLsAi/6azG9onNqUfkylgmGnJuItAu2uLphFuM4RjW5a64ZX7uJw3Tg
         YaMaFtP327C9tjbza67hOW0+oJJFbqtat8D/qKTTw60AXDdtJPsxL+8y9K6GUqBBEWzL
         4S26/ThiWKlXyx1qu8erHQ8DPeJqfyLv3M6wo85zCB0oePHuk0UyRCerV+dh8Rsz8hXd
         D8AU6RvYxre2G4KM6EVTmnvkgEQtRRvFJvWxPPKqrI6HcrhkYaX2xVlOzEr14wSY93+5
         tABQ==
X-Gm-Message-State: APjAAAVut2j4aBDhKd+mNHauFedkNEungqlsAF3taiQFF6CgEzt2iRy/
        jN90ew+dRB6tP1E10eHKHWqrMhi46nQ=
X-Google-Smtp-Source: APXvYqwFYUr7Z4ViBw8c0OHKAf0ApqMXnbX5HT1waX2GKIDrMR2NLqpkZ5Spr54bkWSmYaH/Mn9fmg==
X-Received: by 2002:adf:a453:: with SMTP id e19mr33109105wra.48.1582102640402;
        Wed, 19 Feb 2020 00:57:20 -0800 (PST)
Received: from [192.168.1.146] ([170.253.59.124])
        by smtp.gmail.com with ESMTPSA id h10sm2079953wml.18.2020.02.19.00.57.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 00:57:19 -0800 (PST)
Subject: Committing with one single option
From:   Alberto Salvia Novella <es20490446e@gmail.com>
To:     git@vger.kernel.org
References: <e773b01e-8fcf-8b8f-50d7-4b0f922895f7@gmail.com>
Message-ID: <547b53e1-f3e1-5f12-5ffc-f35b95e25867@gmail.com>
Date:   Wed, 19 Feb 2020 09:57:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e773b01e-8fcf-8b8f-50d7-4b0f922895f7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Doing:
git add --all; git commit -m ${summary}; git push

is so common that it would likely benefit from being composed into a 
single option, something like:
git set ${summary}
