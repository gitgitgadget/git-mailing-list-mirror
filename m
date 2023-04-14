Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049A4C77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 14:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjDNOKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 10:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDNOKq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 10:10:46 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96502D59
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 07:10:17 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54f21cdfadbso295475147b3.7
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681481368; x=1684073368;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsTeqrdbwjH1xCbY2jo4i5niLsOL7jh8UYGruTUBgxs=;
        b=Uj7zGPzk95CTcwORFUjQtWyX8I2YGO7vLjsvHsUVsopa7bX16sjktBhzWUyiMR17u+
         LSxPoQ0Eg79Lzos8XRM577B8b6oatvx4a/MRtJ8bHnMe/EmVg4RKMaOPpQ6oBudPchkw
         cYOgZfa7tGpmbHCsoI2PCN/EVCVwn1Ia5w8PpxzZ2ySTEDGifTtORb4En94rJ4Sh7uPn
         jI+/3MI8n3iknBMxmKKhG883TzIOZkJEq5Co89YZXbQzudSo9ax/boM+Emb97MsmksLN
         bmuPgJGRt3OK7/5zPCdbtpA+75mPN1VHnIDsgew44a415HO6junPfBcvXOfwoL3cKi7X
         qcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681481368; x=1684073368;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BsTeqrdbwjH1xCbY2jo4i5niLsOL7jh8UYGruTUBgxs=;
        b=ivCW5n1IpjtmC1wWcOT3/Vags3UjCM97ovtu5y7jS2FpGrKG1/yWlY9rPqa/KsTTNC
         FaYnYm2Nc2ez7FDjRaAM66ZGRYV/n9A6w/SWUxr4YDei+qXJtX0RHpSiYEq97NPp8Wxh
         u5PtUPLDllaKfrJy0yNB1Lw5sOCPKp+KcmnWrEqb9T7nui5aAHeVMMyOjAnjcCwtKOt6
         i8aLtBnuRV1XSFe6uH5Hhn0iu4Wi9sVSuP2Gef4hSxdXttO5EVtH4jVLQJPhtcZ1/qDe
         O3fSEYQp7K8jsi53GXOVp6CdA5WopvtFIZc5VN5YjSfq6jdBfaBUrbqyQQmEGRiYJFSF
         L3Ow==
X-Gm-Message-State: AAQBX9crMGZLTI/VDpNCnUruRgaWb5hLHjzmmBEo64y+d8hj1C9MMYTP
        2j5i8d/UvyH52zr7NNZDBs9dTQZK2IVfAx6Pkg==
X-Google-Smtp-Source: AKy350aY+qac9DNz+YBxEaHL1rv4sDgtdCG+yKR9lIr5UnNFKeb5LB3PVPtseMzJEtZ+CVq+LZd57g==
X-Received: by 2002:a81:4802:0:b0:54f:881e:75bb with SMTP id v2-20020a814802000000b0054f881e75bbmr5274987ywa.45.1681481368147;
        Fri, 14 Apr 2023 07:09:28 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id bw8-20020a05690c078800b0054f69033623sm1184927ywb.61.2023.04.14.07.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 07:09:27 -0700 (PDT)
Message-ID: <8daf2603-2818-9c9d-7a06-6af2872a045a@github.com>
Date:   Fri, 14 Apr 2023 10:09:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 11/14] replay: use standard revision ranges
Content-Language: en-US
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230407072415.1360068-12-christian.couder@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230407072415.1360068-12-christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/7/2023 3:24 AM, Christian Couder wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Instead of the fixed "<oldbase> <branch>" arguments, the replay
> command now accepts "<revision-range>..." arguments in a similar
> way as many other Git commands. This makes its interface more
> standard and more flexible.

Unfortunately, while doing this, you have broken the --onto
logic:

 $ git replay --onto HEAD~2 HEAD~1 HEAD
 fatal: replaying down to root commit is not supported yet!

The rev-walk you are supplying by this line...

> +	argc = setup_revisions(argc, argv, &revs, NULL);

is taking the remaining arguments and using them as tips to
walk. We need to be able to recognize that --onto A B C means
that A is the new base and our walk is B..C.

I'm not sure if there might be a way to use a callback for
the --onto option and pull out the next three options into
'new-base', 'old-base', 'tip' values or something.

Overall, I don't think being flexible in the CLI is of high
value for this command. Let's be as prescriptive as possible.

Something like:

	'git replay [options] <base> <tip>'
	This mode means to rebase <tip> onto <base>,
	detecting the range of commits to rewrite.

	'git replay [options] <new-base> <old-base> <tip>'
	This mode means to rebase the range <old-base>..<tip>
	onto <new-base>.

We don't even need "--onto" for these positional arguments.

Thanks,
-Stolee
