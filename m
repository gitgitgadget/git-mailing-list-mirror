Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A700DC432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 00:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691752070E
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 00:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awXxiMJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKWArT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 19:47:19 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:33322 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKWArT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 19:47:19 -0500
Received: by mail-wm1-f48.google.com with SMTP id t26so7490894wmi.0
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 16:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Jvz5Ufz69IdxnuLKB7xS6Puu3M55x3H94JJP6XzrLk=;
        b=awXxiMJWdo4wFlL5/UrExj5u4h8ezFZkO6ECop24RXhMzQvuVZieXfK+SBYJjIsAu+
         sLfABroGuHAC8VH05JvGLn/yAeWjOraX0eN2tlWnsWqfErqCC5mvTfoqWgf47Vui38le
         bIqlUFm4KfS/RTX3UsnmSNr+SWM71tuS7t3DaAgv4j/JSz6OgmDNcAd/kmNEzJQZeEx7
         W5qMooLlCXbt13HXbnQIt4dSbyt7q0n8HT5py8crGe49N4r+sUdM7mQUUSeceZKqr6tU
         V+vJWFYx2cbVPZnfwysE8Cwu2byPCzTp8PIK9J6fISrcn3XY1j28/MaivpoRm6Vo2C+u
         3WXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Jvz5Ufz69IdxnuLKB7xS6Puu3M55x3H94JJP6XzrLk=;
        b=j5iAQ2oquoEz0W6T9YeBvDjZyCEHge58Pm/3m7FM4p6ZMnayEMVevpfPdry0htnTxA
         deD7YXb0IH9XeVCknXKm991g10Og+L06KFTwz8tscw5GY1PmdHoa8wlo8rwDhYnfdP1q
         J4eLlJwShvm+fw3weMmyd6Sw+g4oG1agEpPAdvzeiujd6vVMJLw6ZgA78cCEFBWaC75d
         BWGxiKjaRh4GLnWFfQV5AFVvYsV7vENBQ1dzspxTVcz1wdaOcL6WFo7Rj9vRBUAEwuvb
         ELsOGxkAirH5l6NPncy9CQlZrOKWcrev1Bm9+jnNYMKKl3dxHmL935kkTJ/l8RLUSygA
         uldg==
X-Gm-Message-State: APjAAAWQ1R4TmV8y74juuRvPCUF5by4hPI6PviYjmQlplgUd5xN1q4cj
        7OTES73LgDdVfqcAtExtTpA=
X-Google-Smtp-Source: APXvYqzWN3gfsciXxwoDkzL18IRSCFK4LAVtFuxZ2782WcBDSsCi8x8f3laK1777ISQR/GVExbAGNQ==
X-Received: by 2002:a1c:ab0a:: with SMTP id u10mr19817971wme.0.1574470037620;
        Fri, 22 Nov 2019 16:47:17 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-110-106.w86-199.abo.wanadoo.fr. [86.199.33.106])
        by smtp.gmail.com with ESMTPSA id q25sm41742wra.3.2019.11.22.16.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2019 16:47:17 -0800 (PST)
Subject: Re: ag/sequencer-todo-updates , was Re: What's cooking in git.git
 (Nov 2019, #03; Tue, 19)
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, phillip.wood123@gmail.com
References: <3e616116-2f6f-acff-91b3-4aefc7e62653@gmail.com>
 <20191119204146.168001-1-jonathantanmy@google.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <54cf0a3d-9b05-b24f-7bb1-983c8d3354df@gmail.com>
Date:   Sat, 23 Nov 2019 01:47:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20191119204146.168001-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

Le 19/11/2019 à 21:41, Jonathan Tan a écrit :
> - Commit 3's todo_list_write_total_nr() could just take an int instead
>   of the full "struct todo_list *".
> 

I’m not really sure about this.  This way, it can only write a specific
integer from a specific data structure, and cannot easily be misused to
write something else.

Cheers,
Alban

