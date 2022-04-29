Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39316C433F5
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 16:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378967AbiD2QUV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 12:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378557AbiD2QUU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 12:20:20 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFD5D372D
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 09:17:01 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id z126so6288640qkb.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 09:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=S4FFHpPbnTK+pJRugwFDhrPrwb3vFMIiRCLnel9uMiM=;
        b=XxtBgey5hSSgYN+enCa5BlBZuupIV3tA8tQUtFyLAwNisj2eRUnc8jmU9hqYW/Wwq1
         D9dZAofUVzOtILDfykL0BEIeVWKTrVoHtPhYE0p0KBezqXy/GQB1FKd9T9laHkNm4Ctd
         75ekjuDOpGSNkYFupOnMoUxPgvfE4i8uqN0VHszn/+SVUNf7FnMl5+4hCt14Kn3V6hz6
         ZjTGa1rZViXBDuiArNhrEC5Op9XtMgBE58Bsq0vb3/QezMnwCGNTvDisuE91ciB2deSG
         NJVsfOiVTkyA6ML5/RoTjErfhQjprN6fAysqvJ8Usieub25E5gX/lOX2ZejzhlKKEmPS
         t5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=S4FFHpPbnTK+pJRugwFDhrPrwb3vFMIiRCLnel9uMiM=;
        b=6vIg476K3ypBULTt+S6W7xLJrEEu98spd8lHA5j/njs+rpnLfssZW10s67jrxwJPGk
         5EkNAMTo92cPaL0WXI4Y0pXOP3yaiT3XzsTzPft8CgS9QMnHVqpu6wN8IUmJ1T6ASiZ1
         Tf7LR3N+PrKv60ZTun4euEM+fd57IX4BZ3/vmQotu27fstD5GxUj9j0ykz0uxXPh7rJW
         yN4jSwx141+6jTxWtisX2fkrR31pKCB5Tf0SDUDUASsag6OGiU014LtLk5kT8WVr/JND
         q9FqICnRewqXIrfjUjgSXto3hmvsWin40DauDcQdNj2E7tS6XvQltc1oV4i4cgsgeg1X
         iMcA==
X-Gm-Message-State: AOAM530hyWhi8QIde4UaGTS/S652PROiEq8JIsngRKtTh6nQiF0fv3pV
        jgV4LpIDmoe0LeUvNHyuX2/H
X-Google-Smtp-Source: ABdhPJyJbziuT1SPPWPdXR1mJDlQyDVORq5pZPb/uyoEiUZddzhvwJzQWSq1Afbk+wUBaRBuKhAORQ==
X-Received: by 2002:a05:620a:280e:b0:680:d1b9:6b0 with SMTP id f14-20020a05620a280e00b00680d1b906b0mr23601999qkp.391.1651249020347;
        Fri, 29 Apr 2022 09:17:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:20e7:8cbb:83bb:177d? ([2600:1700:e72:80a0:20e7:8cbb:83bb:177d])
        by smtp.gmail.com with ESMTPSA id v19-20020a05620a123300b0069f70d51c35sm1639715qkj.5.2022.04.29.09.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 09:16:59 -0700 (PDT)
Message-ID: <484187d6-5bbd-c238-a922-95411e80322e@github.com>
Date:   Fri, 29 Apr 2022 12:16:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH] git-compat-util: avoid failing dir ownership checks
 if running priviledged
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     philipoakley@iee.email, me@ttaylorr.com,
        Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20220426183105.99779-1-carenas@gmail.com>
 <9658dea7-d421-b238-113d-c7b83eca4569@github.com>
In-Reply-To: <9658dea7-d421-b238-113d-c7b83eca4569@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/26/2022 3:48 PM, Derrick Stolee wrote:
> On 4/26/2022 2:31 PM, Carlo Marcelo Arenas Belón wrote:

>> +		const char *real_uid = getenv("SUDO_UID");
>> +		if (real_uid && *real_uid)
>> +			euid = atoi(real_uid);
>> +		else {
>> +			real_uid = getenv("DOAS_UID");
>> +			if (real_uid && *real_uid)
>> +				euid = atoi(real_uid);
>> +		}
> 
> I imagine that something else could be added here to help Windows
> users who have elevated to administrator privileges. It will use a
> completely different mechanism, though, if needed at all. We can
> delay that for now.

Just chiming in to say that the way we do this check on Windows,
there is no difference between a user and the same user with
elevated privileges (the "Security Identifier (SID)" is the same
in both cases).

Thanks,
-Stolee
