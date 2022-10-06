Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69E0C433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 13:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJFNFP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 09:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJFNFO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 09:05:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092288E0C0
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 06:05:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o5so997227wms.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QEqh/mrE2H/0nENMSNHQyvDnsJZXAPo6kdSW6d0mym0=;
        b=SW5wHBMWIFrkMPolxUFluP8uBgFfdrHONDuLrx+75XMk6ECVTKmd7Tt6HXVLkQ/iVn
         q7E2ziiPCU9rlhlZwq26ucNoIFZlYYurzoeWpJE2JnSFTjj0/nIdEkugcCXOvSTIy5SE
         d1/VzFbT3PaAYzCksN/6fHTg0PF8/LjvXGNyOl8cVUoBpYLSALACoeSep+pgV7ivWtcG
         B89aguZebsZBtVjN7oRDsMxkKXRfYvD5hpa7qYpfjvdwHo87aPtQ4VZQsE2JDlr3py8L
         uDdAs3SSOX8X6ngazEIQZVesoi1fPh4perk06Sk6hCUwr52IstEoOUXb7yhjQvtUeKDX
         04JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEqh/mrE2H/0nENMSNHQyvDnsJZXAPo6kdSW6d0mym0=;
        b=BF9jAHJtCa0B0WHP5BzrbjyCYI4Ov6Pxa7aj74Hx2NCljqbQCgKjxX0ZS7zr/krTA/
         KGeYQnKFC2gHAvRMMyTagSNZHLcZralQnglzO/DgXkXEV9nF3bJwh4pIXUeIuNpNXZY2
         9h1KFe3x0693NIlPeOI5LJmNHLidv8o9steZMvi76olXTXYvC5yQ+bkKGhVBtb+iHK1R
         m5la09bfkjbjUOp8qsnpN6mcaBbw0bvEtt9e9adQmOlYrzjg5yqLUq5DjG3cUGDF/Tgo
         faWC2ZHqwauucYWmC/hQ2Ebk7JQBJNgYEV8dSJlzZyDh99TetAkbGFIgo97Ex+dR7N73
         EmCA==
X-Gm-Message-State: ACrzQf2Coy4QTHmNxunZarHg77FeZCpcQgJxeGIAAa18fnapPsXyEKjY
        Xq5STBahl7LQhPQvBia7dfo=
X-Google-Smtp-Source: AMsMyM5nUm5VvojP3bK2TLLyB8YYqR+5rAz6P0tu3yn1kX7/paU4VsO64zrxHhSlcIlgcMVIycv4Xg==
X-Received: by 2002:a05:600c:310b:b0:3b4:c618:180d with SMTP id g11-20020a05600c310b00b003b4c618180dmr3142754wmo.25.1665061511483;
        Thu, 06 Oct 2022 06:05:11 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id n25-20020a05600c3b9900b003a5ffec0b91sm5387263wms.30.2022.10.06.06.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 06:05:10 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <ce32d5c7-c62c-b27f-23fa-566cba65c383@dunelm.org.uk>
Date:   Thu, 6 Oct 2022 14:05:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] ssh signing: return an error when signature cannot be
 read
Content-Language: en-US
To:     Fabian Stelzer <fs@gigacodes.de>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1371.git.1664789075343.gitgitgadget@gmail.com>
 <pull.1371.v2.git.1664877694430.gitgitgadget@gmail.com>
 <20221006082817.4uxywfxjokfyml6y@fs>
In-Reply-To: <20221006082817.4uxywfxjokfyml6y@fs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Fabian

On 06/10/2022 09:28, Fabian Stelzer wrote:
> On 04.10.2022 10:01, Phillip Wood via GitGitGadget wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>    This patch is based on maint. In the longer term the code could be
>>    simplified by using pipes rather than tempfiles as we do for gpg.
>>    ssh-keygen has supported reading the data to be signed from stdin and
>>    writing the signature to stdout since it introduced signing.
> 
> The ssh-keygen call is already using stdin for the content to sign or 
> verify. The signature and the signing key need to be files passed as 
> parameters to ssh-keygen. I'm not aware of any other option of providing 
> them to it.

We use stdin for the content when verifying but not when signing

	strvec_pushl(&signer.args, use_format->program,
		     "-Y", "sign",
		     "-n", "git",
		     "-f", ssh_signing_key_file,
		     buffer_file->filename.buf,
		     NULL);

	sigchain_push(SIGPIPE, SIG_IGN);
	ret = pipe_command(&signer, NULL, 0, NULL, 0, &signer_stderr, 0);
	sigchain_pop(SIGPIPE);

Note that when verifying with -Y check-novalidate there is a missing 
call to sigchain_push(SIGPIPE, SIG_IGN) as we are passing data over 
stdin so need to ignore SIGPIPE.

Best Wishes

Phillip


> Cheers,
> Fabian
> 
