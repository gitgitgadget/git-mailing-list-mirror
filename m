Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A033C4332F
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 08:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiK2ISs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 03:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiK2ISr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 03:18:47 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B61A326D2
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 00:18:46 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id j12so12678695plj.5
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 00:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/cUUwW9CiNypNGK1mUYdIil9WtiZh+BWwwxajzW6g0I=;
        b=j3dgZI8lNmzMZHQhRjqjT2GED3G4RK9CVZ4HTidB6H6/wt9r1JT8WN+wtRdAyACS0Q
         cWP926jU/l6Ustu8/Z9rdCKeL62zuFCWW8hsNQrc/LKueop/LxFT+tSUrJBWG3/3UxIi
         SAdDgl045lqdBVgBdyU6hiaP9gpOC43O3oHAcPiYGurBtxApmekSjA+LrE5t9pcV+pzP
         IeDvdLNmWrge95W8qojq6lI1IaaRUg8OyxEAQ7779mog0IBEWwF1GVRI4d4R4I3HBJvL
         vMAcBmMwfqfLm8zItTQ55UwArJabxMsF0+kmeAD7dyN921plZq/lPuHz/jNbdvSi44vc
         rzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cUUwW9CiNypNGK1mUYdIil9WtiZh+BWwwxajzW6g0I=;
        b=cD1OuG6/qwAUBEhGHLVbTWzylsOotj94prwA1BNg8dAOKWuFhSdPTpi4MOlQLbPUsP
         dSfiPb+RfNGhTCxlyzd8QGzP4Bqk4jOahnrHyFS7mRCj9+BJ4WNxSWIl79Y0kQQQcK8w
         WtBKBEwiQSkbB/XkN5h/lNKjx3POaDRZd8Sd8veXQwgV4ZPvwronn8xHVVO5Gy+dKsir
         DH+O5HIQkFsteUZ+Q6Uu8YDQ9K41LCCv5X7l5mhPQ5nXB+1q3B30mxn/entzsblaPGD2
         JhZUamxDzhZoLn3jOlyiWYjpcUuawSHqvJ7FjTfU7XIY/DtbuPTDUcCa7CMXBH6TePFD
         SLWQ==
X-Gm-Message-State: ANoB5pli4wJhvNwIaaHBZS3iuHBecHfn3R98fjYgMqi4/kb2afq6tX8M
        XIhRMeMfYGXW7cez9LoYOekgUPd5cCc=
X-Google-Smtp-Source: AA0mqf7BHknUHvxBhZK5gWVtuSMiJaoBbs5zYUFGs9IVpgFozceai06Br2Fu7dFoMXH+BJoueUWW0A==
X-Received: by 2002:a17:902:e20b:b0:189:6f76:9b57 with SMTP id u11-20020a170902e20b00b001896f769b57mr18416855plb.64.1669709925936;
        Tue, 29 Nov 2022 00:18:45 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-73.three.co.id. [180.214.233.73])
        by smtp.gmail.com with ESMTPSA id p22-20020a170902a41600b001869b988d93sm10131072plq.187.2022.11.29.00.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 00:18:45 -0800 (PST)
Message-ID: <455e9d7e-7394-bad8-c8f2-3ddf3958f1a2@gmail.com>
Date:   Tue, 29 Nov 2022 15:18:37 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [bug] git diff --word-diff gives wrong result for utf-8 chinese
To:     Ping Yin <pkufranky@gmail.com>,
        mailinggit list <git@vger.kernel.org>
References: <CACSwcnQfTOYHxSJQqc+viiqkCqt=WZieuCw70PqOdvo88XdeOQ@mail.gmail.com>
 <CACSwcnT9Pz3snq4Jp6K5qxHFiE_zo41bKVUjJ_LJ39WN7h=gbQ@mail.gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CACSwcnT9Pz3snq4Jp6K5qxHFiE_zo41bKVUjJ_LJ39WN7h=gbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/29/22 10:49, Ping Yin wrote:
> sorry, typo, s/--color-words/--word-diff/g
> 

Hi, welcome to Git mailing list!

Please remind yourself:

  * Do not send HTML mails, send plain-text ones instead. Many mailing
    lists (including vger.kernel.org that powers Git ML) reject HTML
    emails for these are likely spam. Make sure your email isn't mangled
    (tabs and spaces as-is, no line wrapping).

  * Do not top-post, reply inline with appropriate context instead. I
    have to cut the reply context as a result.

  * When you submit a patch and people reply with their reviews, engage
    with them (either sending revised patch addressing the reviews or
    reply with justification). They will ignore you if you ignore them.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

