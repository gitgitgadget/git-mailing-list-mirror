Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED82FC001B0
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 21:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjHGVAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 17:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjHGVAC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 17:00:02 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE3D1BE2
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 13:59:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31765792c7cso4311286f8f.0
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 13:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691441949; x=1692046749;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cawdj61DJT27s7IL9rFqkhzVQ3qimXABnaoW1KX0Sss=;
        b=YIPb+sXlk9wYiyCQozqG+ccpGiXXGd0uAHkGXoJahlS9ceuiMTOTdSSnaCfOZxtY5W
         D5Wtt4kzbqQSHyva6CBNZafqjuCS6Anj2l/RgfBt4+yvDOjdKvVX3Hm6f5+Z8ShfuPBg
         tHVljcbcZJE0U+4G7YNxI8GVuyXOGHYGz2MuZwTOopttKMPk2BXF0ujJ06xa4nZ61dZE
         Q8EjIKXxYHtacQuxcXa0bc4FCap14NR/+PGNkKqvKlj27NS8CnB/NWpCmk1s/J31Lh8Z
         Gli5N4Uo0oyGUq5wzLjGRHmT+ylSmsB4Qstqsn/GK72BmP1u7YmPeEumPr7AuFVhWEhn
         GL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691441949; x=1692046749;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cawdj61DJT27s7IL9rFqkhzVQ3qimXABnaoW1KX0Sss=;
        b=Mot/4SOhPOYyMJTBtNttR4ojUMW+zdIm9g9MwXmdIlNCNzBkhyF6QFxmRt0wAyU5lj
         3Aq9whzAg+fEGc8J/aA4bDqPdcJHzdvpBrmcwXfMKHhTVDkkb3HQxngq0KWikeJqV4O5
         vaSxiTLkDiHW7W6ap89t7/QiuUzNqY7NITaBqiAYoDDmoCy/fQPNP/2WgJ8hEFbz70Qb
         TyuD8nnjIKJafFN2gVLTxtjuwMHFwECfNIj/HbetLEfTql5D4lpsH55EJ6ialc/FHD4O
         3vlfwoI2/Y5kcNB6G+2RrVEkTtVt4RYk+GAw+R67Tytme9I1gpuKbAfOpI23EmvQuZFW
         niVw==
X-Gm-Message-State: AOJu0YwVkVoyRpTSWsVl16uq+XE1O3jQem6Gycm7c6wMZynUGVkRO/Uz
        hPnyYSq6S7Jdt37reAWA+pzw2wRxTXE=
X-Google-Smtp-Source: AGHT+IHsxveSSd+sBDlY6RGgAaDtfxRFXyFAByEGpdkBTz9QvNcy33/MQN7OQXMtOBAhpRyFLqvtsA==
X-Received: by 2002:adf:d4ce:0:b0:315:8f4f:81b8 with SMTP id w14-20020adfd4ce000000b003158f4f81b8mr7156294wrk.50.1691441949003;
        Mon, 07 Aug 2023 13:59:09 -0700 (PDT)
Received: from [192.168.2.52] (225.red-88-14-55.dynamicip.rima-tde.net. [88.14.55.225])
        by smtp.gmail.com with ESMTPSA id h12-20020adff4cc000000b00314367cf43asm11426888wrp.106.2023.08.07.13.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 13:59:08 -0700 (PDT)
Subject: Re: What's cooking in git.git (Aug 2023, #01; Wed, 2)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqfs518gdh.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <870d6901-e1ea-98fb-96fc-fd568bd35f16@gmail.com>
Date:   Mon, 7 Aug 2023 22:59:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqfs518gdh.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/8/23 20:10, Junio C Hamano wrote:

> * rj/status-bisect-while-rebase (2023-08-01) 1 commit
>  - status: fix branch shown when not only bisecting
> 
>  "git status" is taught to show both the branch being bisected and
>  being rebased when both are in effect at the same time.

Maybe this suggest that something has been added, but only fixed.

Perhaps we can say something like:

   "git status" was not showing accurate information when bisect and
   other operation are in effect at the same time.

> 
>  Needs review.
>  source: <48745298-f12b-8efb-4e48-90d2c22a8349@gmail.com>

Thanks.
