Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6EDCCA473
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbiF0Si0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbiF0Sge (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:36:34 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE0B15705
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:32:03 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id q11so13951990oih.10
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zUNLw2ArfNVuCZ4Dj3jJPvEOcyTReSMQ5FxTyzEOjAk=;
        b=HAIZz/G8lhoOP8fpKnNf3plvcn3YwkMt17hmCaCpi6i6cwJKnmQgsCyzJzXc829knL
         wJi4nxAk5tCO9NKEhgJcJZlWuXMyDIl5OGydQYcaTQAnIYHipoJoab0jfGcXcoWWz1oX
         D21+6msag64qwi9LjX8XD7Mzf1wAi6qU3dWqutghtl3fbsH3yA3Qb/QW8fFZ9uQoaVJ2
         dd7p3119rvXqGgP4tYugOxgVYlWcu0K/hx7GMx5TkUR4ySyIgl3nmZuZjywLPDDF1GN8
         RjCwMgwlExbu1KGzkSBVs9CIF/P5U4KMCRU7RZUTOhhCr3PYQdaihT5UXy8ij81Qtv7J
         /V8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zUNLw2ArfNVuCZ4Dj3jJPvEOcyTReSMQ5FxTyzEOjAk=;
        b=om7QadUcJmyUD5PDiwa2BPSgXJSwZF3EhhGZOiPtPo7SLv7MD9rZDL6WtDbi993l9P
         S6YtonyWyADi9ayx/Sg57993+rHuMXaaITq6fWAKNrXuwxF0vtgGqwX++9IUu1LUGA0G
         UyGfqE/0RCl15vCL5ijlzd25GyiKIjsJjs2eLc9UTncBW2NAQyBNMfiekdIq12j54UIP
         FmroDKhD12KKRvM4056T4Aom0Fdw0DBDQCfokEBYM2ReMI0cbuSur+1CWZp2nzkxctut
         RPCnPnfXlJSTDf9r58xNL/x2DAOxNcjDD36QOqUkwkVHiYoydFVffcSIxtvidrp6+XaK
         ocfA==
X-Gm-Message-State: AJIora/A0aKL1gWhEjfBfkVUhm1zkbl0twFyVd6ObrT5p8inyUf9GlJ9
        /X+3lNu24LYpn1Av2fsxgLgQ
X-Google-Smtp-Source: AGRyM1to5NNIgr4BDUH5lFBSDWvUfzZKw0fi6CNpphni52qwn0+Dzx/KCi/m4x1BGl7OC61fdJ/Bfg==
X-Received: by 2002:a05:6808:152a:b0:335:4be5:612f with SMTP id u42-20020a056808152a00b003354be5612fmr9134250oiw.254.1656354722683;
        Mon, 27 Jun 2022 11:32:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:714a:b337:6fac:e704? ([2600:1700:e72:80a0:714a:b337:6fac:e704])
        by smtp.gmail.com with ESMTPSA id s4-20020a056870ea8400b000f1bc45ba21sm8006957oap.14.2022.06.27.11.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 11:32:01 -0700 (PDT)
Message-ID: <22428078-5e08-5788-1092-02b0381b6c6d@github.com>
Date:   Mon, 27 Jun 2022 14:32:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 4/6] pack-bitmap: prepare to read lookup table
Content-Language: en-US
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <cebad3da-5779-5908-15d5-63d4c590c20b@github.com>
 <20220627180618.16291-1-chakrabortyabhradeep79@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220627180618.16291-1-chakrabortyabhradeep79@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/27/2022 2:06 PM, Abhradeep Chakraborty wrote:
> Derrick Stolee <derrickstolee@github.com> wrote:
>> nit: This alignment should use four spaces at the end so the second phrase
>> matches the start of the previous phrase. Like this:
>>
>> 		if (flags & BITMAP_OPT_LOOKUP_TABLE &&
>> 		    git_env_bool("GIT_TEST_READ_COMMIT_TABLE", 1)) {
>>
>> Perhaps it looked right in your editor because it renders tabs as 4 spaces
>> instead of 8 spaces.
> 
> I don't know why but my editor sometimes do some weird things for alignments.
> I generally use VS Code. But for alignment related problems, sometimes I have
> to use vi editor.

I also use VS Code, and I noticed a few spacing issues recently, especially
in .txt files.

I submitted a patch [1] to improve the contrib/vscode/init.sh script, which
adds some helpful config settings to your Git workspace. Please take a look
and see how it works for you.

Thanks,
-Stolee

[1] https://lore.kernel.org/git/pull.1271.git.1656354587496.gitgitgadget@gmail.com
