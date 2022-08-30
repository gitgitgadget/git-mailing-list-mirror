Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE579ECAAD1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 13:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiH3N2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 09:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiH3N1m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 09:27:42 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E77AA2621
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 06:27:29 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-11f34610d4aso5840167fac.9
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 06:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=4HCuYwN9DknyS4pc1SEtJKYgS0Y8CFLIgT33DuLYlX0=;
        b=BaZQnnIA0c/+omddDYolNIRDeVH95p9WEjCmI7p8YExXY+gxvAWqaEYsoJhmCJvXUe
         iO+RFZuqtH/yQnHq6SZJ0skIUKOidT6g6QlxTz/P5uAubQiU6UC6T4qWYjD+s47sjcR4
         28IyoCubf15qkDlJP2p7a7DSI9PeJTJXCfGP+HCN4XoYiagMRhb18UtrQpXsSfLdNn8T
         mLXb/w/KCBgb3CsCUETCka7fuSKaajgE4UiJPX6jegzKhlr9LNkOfJP0uWn191GPtySa
         kcIVMyrjLFMnz8G1V8SPDCIAvTYssk5yBX68h5gfh4mynOmKCBg1hlIIgzM+KXqyqkRw
         Po5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=4HCuYwN9DknyS4pc1SEtJKYgS0Y8CFLIgT33DuLYlX0=;
        b=u+ufhJvDHVB5jCpmyQRUfW0jwC6jyrB4+8/nPhvtvmDwJrCx9lV4kTI8CVM9273BrO
         CvZMgnOPA/hW/R0ONSNkYDk7eTQAG6FpgYnrcCQ5Nzc98B0m68mblgvb2mJR92qaoU2M
         hZyANW3nnqFJgFwX5b4ZH3JbR5hu8Bh6eTLqlT5/jYa2Z2t/mhRGiXdgVwfVqVT1fPKf
         4d859gt3C57d1ol4myXCOLzM5+vc7OV+Jrp5Db0iwLtI6MV481OebuEuRP07PRRe4eGE
         tL3ch6TOIUAlXqhbRi8oXXN4+USvuDv3V/xlmYNP8Zlpk0k8zW5VUoUQIjzlVYQmWa2J
         fQMA==
X-Gm-Message-State: ACgBeo0w8/nxqhc4O6G81UwsVkfeHnfQuCuNdWM/b86/P4mA26/kEWig
        wW/vO3QMpNwfifDBlkxea2Yb
X-Google-Smtp-Source: AA6agR5rrIJjW2VsIfoy/eTJhJm5la1gmRmAMUYTUnLKijuy3I9kRWIaetgwiMwy9H6kAFMQNBkEOg==
X-Received: by 2002:a54:4696:0:b0:342:fd3c:77a8 with SMTP id k22-20020a544696000000b00342fd3c77a8mr9493434oic.297.1661866047821;
        Tue, 30 Aug 2022 06:27:27 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q5-20020a4a88c5000000b0043540f7701esm6646302ooh.31.2022.08.30.06.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 06:27:27 -0700 (PDT)
Message-ID: <e851e646-1daa-a77c-5d27-fd7c4445c2ce@github.com>
Date:   Tue, 30 Aug 2022 09:27:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] gc: use temporary file for editing crontab
Content-Language: en-US
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Renato Botelho <garga@FreeBSD.org>
References: <20220823010120.25388-1-sandals@crustytoothpaste.net>
 <20220828214143.754759-1-sandals@crustytoothpaste.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220828214143.754759-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/28/2022 5:41 PM, brian m. carlson wrote:
> While cron is specified by POSIX, there are a wide variety of
> implementations in use.  On FreeBSD, the cron implementation requires a
> file name argument: if the user wants to edit standard input, they must
> specify "-".  However, this notation is not specified by POSIX, allowing
> the possibility that making such a change may break other, less common
> implementations.
> 
> Since POSIX tells us that cron must accept a file name argument, let's
> solve this problem by specifying a temporary file instead.  This will
> ensure that we work with the vast majority of implementations.
> 
> Note that because delete_tempfile closes the file for us, we should not
> call fclose here on the handle, since doing so will introduce a double
> free.
> 
> Reported-by: Renato Botelho <garga@FreeBSD.org>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> Changes from v1:
> 
> * Use `goto out;` in additional places.
> * Fix broken test.
> * Use `delete_tempfile`.
> * Improve commit message to mention `fclose` rationale.

Thanks for this update. It resolves all of my concerns from v1.

Thanks,
-Stolee
