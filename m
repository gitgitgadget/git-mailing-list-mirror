Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E2AE95A8E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 10:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345860AbjJIKAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 06:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345708AbjJIKAB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 06:00:01 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE79D97
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 02:59:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9ba1eb73c27so152677966b.3
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 02:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696845598; x=1697450398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZeaBVUxIdLGKHNqLa27vRqndPXpCGaPsYdDVYTWWyk=;
        b=ir6cQlXhztagb9+pwK2lhdloPvPOmjAmXUiaDvWmurGzZ0e9BJkbh5ydPTpMiRrL2S
         8dsK8aq3bhaWdRPRryeds9/ejuTGk9v5ei6xYxpe96hg9Oqu1dcOXfFByELAOvVvhXGY
         oyJkaiJFcd6NnrBEdcsej7bbXSI47rHI2reFby5Jg1BGjvMBE/Ca8dZl3OPijEHi0RQ+
         fNObBsTqWnuJvcJrN7zU5cXyEZmgeX9q+8XfnOuvJh6lJA6cHauZiV/OeVC4DHjNPjAD
         AULRvOz9OTom0tMq0NgcRXqkDXcR99XVPcBGIz+ILKqwd+l+mLdgWpdurNhA8LxaX4yH
         oD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696845598; x=1697450398;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZeaBVUxIdLGKHNqLa27vRqndPXpCGaPsYdDVYTWWyk=;
        b=O44Gtld0cjKbGWsHfhHR8LZcW+F0VqKoW4DD5Jmm6fnT4e7sKimGNHtld2310rOqHQ
         Qu7uckaY6tRw/EVMe6zLDQKeQOlb5KBc7FgQVyoxR/oV6s3jW4zy91uD+oqOZ1wEZEXE
         38m/Ks6BUOsOifyl0wtZ7RACQpaAwkiHaqMmbWu34Zlo9Q546XceGZEm5RHn1XiUou1D
         0xHcQKp+V+7x0S/rS2dSK99FNxCxb6O4lvIeIwQpoTDckR5+BpzTSe5VO66fc1JLCBaj
         T3NCxJibMOTDQB+p7/yBWiBQVHHCbpRgzi3weQtpi/+q1sSO77hYlY2KhVR7ZXCBhqN+
         d/Nw==
X-Gm-Message-State: AOJu0YyE72QzWVGPuFLcqnzDCv4n5xNYw3txRsel+u2+nuHakwiL4oHT
        FP9FxXeMrQRbxRb5TVYwrJJ95G+EcZY=
X-Google-Smtp-Source: AGHT+IHCPc1l6EA0nl0ur0swQv6zUzXHhoGKfpUE/tg1Ny1tVx2Wi650ZpVhgedIRPz/iOzMLpWdEQ==
X-Received: by 2002:a17:906:151:b0:9a1:cfd5:1f3a with SMTP id 17-20020a170906015100b009a1cfd51f3amr13025325ejh.13.1696845598027;
        Mon, 09 Oct 2023 02:59:58 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709064ed000b0099bd0b5a2bcsm6587411ejv.101.2023.10.09.02.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 02:59:57 -0700 (PDT)
Message-ID: <02cf1135-d330-4f0b-aa43-4a555f34adfc@gmail.com>
Date:   Mon, 9 Oct 2023 10:59:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Oct 2023, #03; Fri, 6)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqh6n24zf1.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, Izzy <winglovet@gmail.com>
In-Reply-To: <xmqqh6n24zf1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/10/2023 09:20, Junio C Hamano wrote:
> * ty/merge-tree-strategy-options (2023-09-25) 1 commit
>    (merged to 'next' on 2023-09-29 at aa65b54416)
>   + merge-tree: add -X strategy option
> 
>   "git merge-tree" learned to take strategy backend specific options
>   via the "-X" option, like "git merge" does.
> 
>   Will merge to 'master'.
>   source: <pull.1565.v6.git.1695522222723.gitgitgadget@gmail.com>

We may want to hold off on this as there is a wierd copy-by-value of 
struct merge-options cf <a482d047-dd40-436d-8daa-0c74780af11f@gmail.com>

Best Wishes

Phillip
