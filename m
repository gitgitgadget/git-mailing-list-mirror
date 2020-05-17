Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FF9C433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 19:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09072065F
	for <git@archiver.kernel.org>; Sun, 17 May 2020 19:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ3a7Uot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgEQTrX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 15:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQTrW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 15:47:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1E3C061A0C
        for <git@vger.kernel.org>; Sun, 17 May 2020 12:47:22 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f134so7229551wmf.1
        for <git@vger.kernel.org>; Sun, 17 May 2020 12:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VS2Uh9/TsuTJ/RsDwwJPSMRRepO7w/oCZBvY5aBPGQQ=;
        b=lQ3a7Uot0XMLgdCIqM4+b8USwO1ZniT7qyLw6rZv1pC18g+z7Gb0ZeFm0Iqn4OW/EB
         zJsVTOEWisWhWs2XU5+GvjFytcrC6nLS6Gt8Fow/NrUpAxGyD8uRRdNDVT8bW967Oq7O
         WKN6Rh6sOgEeTv+It+iR/KvKwG4rXH344XrqzYDllv8EBVcOvndqiErf2pZtFscayGXb
         FvW5WWRZ5eHEWyn0SyiYqycAFJ6NRYOGruoxdNYdnhNBmjib0FkUx0cdeNbYD+G2TbjJ
         iaFVt0D0kfJDE0aYv109Izqig9ilxGVLXPj003aGkmnMRVf7YitSyanMqu0mxyUjx59N
         5g0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VS2Uh9/TsuTJ/RsDwwJPSMRRepO7w/oCZBvY5aBPGQQ=;
        b=D3ynO9A88VqMjQ7ASD2cApQmkffo+KdcxyMvRq8MvCZCYjh0gMTEStFNLWBRN6TrMh
         4Km0FVaWwZo33KOF9gHCDfY+NdeAMjW35y3QgoshhzjXec/4KrOscJ+K8MPnkL7+dmjh
         77XWLDYPSvhw7DkCPjT/355A8dVLZQK9FbZ14k91X/mejUQQoT2+v5dt5dceFgqc5JKE
         lgTA1+x8vib8GPH9WNCZQhXwcuehYbTZICsTzin0V04I68pRUroq9rw6XrQZwKslcU3a
         b61/+wPamBtvyfJc+xPgEFB2B82K2DKOLJh0qy8pSf6w5bqDYth32oxOuj+M/SFyB0Dd
         BBQw==
X-Gm-Message-State: AOAM530LgW1PGTs86DYtDvBoJZ6ScxTIL/WHN7W/xXwunXgG1GL/d4Ri
        wFQzWiVSdSoYWLiKfwe/kEkVFsAugWE=
X-Google-Smtp-Source: ABdhPJwohVPc3PMshYF8IY7WsGos/xQ9H24zZNIBDahIyy77j2m9nSfxaAfAbrmY0WNah8yQaoIEcA==
X-Received: by 2002:a7b:ce01:: with SMTP id m1mr3832959wmc.116.1589744840615;
        Sun, 17 May 2020 12:47:20 -0700 (PDT)
Received: from [192.168.1.21] (xdsl-31-164-191-108.adslplus.ch. [31.164.191.108])
        by smtp.gmail.com with ESMTPSA id t6sm13792067wma.4.2020.05.17.12.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2020 12:47:19 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] submodule--helper.c: add only-active to foreach
To:     Junio C Hamano <gitster@pobox.com>,
        "Guillaume G. via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
 <pull.631.v2.git.1589697023.gitgitgadget@gmail.com>
 <xmqq8shq7edu.fsf@gitster.c.googlers.com>
From:   Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
Message-ID: <b9240d11-5ae9-301c-43b1-191532489ee4@gmail.com>
Date:   Sun, 17 May 2020 21:47:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq8shq7edu.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 17.05.2020 à 17:46, Junio C Hamano a écrit :
> "Guillaume G. via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Subject: Re: [PATCH v2 0/3] submodule--helper.c: add only-active to foreach
> 
> Are we still adding 'only-active'?
> 
> Does updating the cover letter needs a better support from our
> tools, I wonder...
> 

Hi Junio,

Probably no, it's me. I wasn't sure for traceability changing subject 
name was allowed. I assume for next time it is.

new subject would be: submodule--helper.c: add filters to foreach
