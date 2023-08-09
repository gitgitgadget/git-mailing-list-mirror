Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125CBC001B0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 13:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjHINGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 09:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjHINGD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 09:06:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A6A2103
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 06:06:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe12baec61so57144985e9.2
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 06:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691586360; x=1692191160;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oY+qCkEA5Kae9iEaYaAY9OpgoCyVbazzK4tMDJY+Mac=;
        b=Wb4v6vU/9EaqMt5BDFlUtf9ninCCP0Wh8rBXfO6XI8ConnMZatfx1OLLdryfq3gX7w
         DMWouBjAwAXsncdigXI2MQwQO0L/Wn5p7Aoo7vFDVUxhH3yjMjW7rda4W8jXKAEnVx6N
         78CiyNnfR4WoaznafalWqcQfdNls0NpjLMNrAMOPqhexbDVrre2wqYP8QMC1DlWSAWtk
         kvaqmzQCMaqfhG8+wPL2x9hV7e3bbH1lBH4ku8A3l6fjlPiHj2WJg6U6ejDBUCx6EZUJ
         6inHqAJ0v+Q4dEQtSgHCtq9hgBedHiz0K55ZKGNGWEA+xfsB6AEOOzVbQwetgrMTF4bA
         kQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691586360; x=1692191160;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oY+qCkEA5Kae9iEaYaAY9OpgoCyVbazzK4tMDJY+Mac=;
        b=Z441MFz12VmQdelldJx0p+GThd+No9FC2Hhy77SuLGn9BDT0G04yZmF6mfM1/Z2u6l
         1LZr8fKPvnJViyd1bJ8QfvK6FnRseaEguoIAZkJer487//4UZIaQ2D1NHf/D4349axgB
         qpW3Tf5w+PVPQhclVkH2lM356zKH+NCYIdr1rUFgHT5YI+U42Bb/w9g1Cr1tKJMTbuH0
         ozTzLIlYz8SmPmLjgJwpVP06s4/wknDhXxfSpsk+by3SyUmPhp+WET5z7YR4oXnc6v8B
         Mbk/Ey5ZA9gTFAX8SgCif7G4OSMcWhBCsauM0LM1yOhzqCfVOgFYDjoQ63KJ1UJOM3L2
         Go9w==
X-Gm-Message-State: AOJu0YzoRFI0E82DBGQ97jxbt4sVfJiU0nuus9nanY565rYpb5ZPZV8l
        NLSnB93RXjU2l4vp4EXbs6I=
X-Google-Smtp-Source: AGHT+IHE1Vq+iUGy3dQeBH4KPyFzkp5rRQ2vxIHSyqR5i/raQMJaqIyFB0ufm+tgfPqnmDPpbv2i/w==
X-Received: by 2002:adf:fa01:0:b0:30f:c5b1:23ef with SMTP id m1-20020adffa01000000b0030fc5b123efmr1767234wrr.41.1691586360201;
        Wed, 09 Aug 2023 06:06:00 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id s18-20020adfeb12000000b0031779a6b451sm16763213wrn.83.2023.08.09.06.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 06:05:59 -0700 (PDT)
Message-ID: <9a073127-cecb-12d8-c49e-6eceaffcf16b@gmail.com>
Date:   Wed, 9 Aug 2023 14:05:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] t/lib-rebase: (mostly) cosmetic improvements to
 set_fake_editor()
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
References: <a803e1ad-1025-164a-f7ca-cc1a41e4f12b@gmail.com>
 <20230807170935.2336663-1-oswald.buddenhagen@gmx.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230807170935.2336663-1-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/08/2023 18:09, Oswald Buddenhagen wrote:
> An update to the documentation, and two minor functional changes that don't
> actually change anything given current use cases, and are therefore basically
> documentation updates as well.

Thanks for re-rolling. I've left a couple of comments on the third 
patch, I don't have anything to add to Junio's comments on the first two.

Best Wishes

Phillip

> Oswald Buddenhagen (3):
>    t/lib-rebase: set_fake_editor(): fix recognition of reset's short
>      command
>    t/lib-rebase: set_fake_editor(): handle FAKE_LINES more consistently
>    t/lib-rebase: improve documentation of set_fake_editor()
> 
>   t/lib-rebase.sh | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
> 

