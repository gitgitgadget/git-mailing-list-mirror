Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661B6C433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 05:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356367AbiEBFya (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 01:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243435AbiEBFy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 01:54:29 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2578164DA
        for <git@vger.kernel.org>; Sun,  1 May 2022 22:51:02 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x18so531935plg.6
        for <git@vger.kernel.org>; Sun, 01 May 2022 22:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OevKj4ncsiPeBpWApB88cve/znqpz3xIKl9PmCqguyA=;
        b=fDbSdcRo/zq5eKPUp7/kW8+R2SY/P5xdMy5M4JSsHjcnitSAr2f81ipWVW2v4TR3Jy
         qCL9TfKBG0Xn1SE22fxiQkaBDBU+m/mzF0oqvdRk/1gSZMsD7rHJjCpCLFH6MkvKn5fH
         tdkYcuAITS0v8A2rD87/6V4QnPWD983skjtLhglu85Bp3X11MJv3s+oNnSNRbAVaUWV7
         EEujtClXVz9l0JeiBKgxoIfmZywslvVg/f10SErzPJ1K2q0Vv70+/DN9L/L54RPDurXv
         SuOGwUhLwobGcO4YWTr5kbO28n2Geh9/obyU7o0wUTc3QupyCAzMVYC3aNH7L+FvSmN9
         61BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OevKj4ncsiPeBpWApB88cve/znqpz3xIKl9PmCqguyA=;
        b=cA/+ztdht4fW0DfcDk/6fDjNFl3K1/0ROz8NoWHj74QMSSWyO5c7KA8TDTeyfnT52O
         kVY+/w5212CIaJJhJWk6keaIl9mdWjMxQPY3rXSs5tmlxa4rPUczz2e0/47+vUmEKDKp
         ZPe7I20+nomUdT2twZkENUs8ygE/pV+o+KawHArny/OVqMtorEQyVHdY/ByLouxq1f2s
         jjEoP+OBrGr8eaXUuq42FZiSo5fsLo5KxlqsmSiWlyqR7WbWl0wW0X9zt5XFAo41KvDm
         7rSP30bW8yZ8nQQWpcUIuLM+saewX3umoQkVgGtCna7RyoRYlgFmZd+f8Hy0e4d7VqVm
         qH/w==
X-Gm-Message-State: AOAM531UJTZdLDVpWZU0DnHbrOsNLxNnBYdoyStfj5ux6r5kz5uL3DXB
        cFwVVPbbbpVr2H5s5zfBcLI=
X-Google-Smtp-Source: ABdhPJwl7NVAFh4DwO7hiB7UGBz4Y4FAJoGC9M+GOhgOtexpldB+cUXSCSRAsx3PlHXgKVLYR7hp2A==
X-Received: by 2002:a17:902:e883:b0:15e:86ea:846e with SMTP id w3-20020a170902e88300b0015e86ea846emr10575662plg.131.1651470661374;
        Sun, 01 May 2022 22:51:01 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-14.three.co.id. [180.214.232.14])
        by smtp.gmail.com with ESMTPSA id 20-20020aa79254000000b0050dc762818dsm3770075pfp.103.2022.05.01.22.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 22:51:00 -0700 (PDT)
Message-ID: <48cd2ce4-feac-b028-daad-2df6aa71e363@gmail.com>
Date:   Mon, 2 May 2022 12:50:57 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] bisect--helper: warn if we are assuming an unlikely
 pathspec
Content-Language: en-US
To:     Chris Down <chris@chrisdown.name>, git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <Ym59GmfWpCSV9Bqr@chrisdown.name>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <Ym59GmfWpCSV9Bqr@chrisdown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/1/22 19:29, Chris Down wrote:
> In order to avoid this, emit a warning when we are assuming an argument
> is a pathspec, but no such path exists in the checkout and this doesn't
> look like a pathspec according to looks_like_pathspec:
> 
>     $ git bisect start d93ff48803f0 v6.3
>     warning: assuming 'v6.3' is a path
>     $
> 

For completeness, we can say 'If this is incorrect, abort the current
bisection with "git bisect reset" and rerun with correct commit-ish.'.

-- 
An old man doll... just what I always wanted! - Clara
