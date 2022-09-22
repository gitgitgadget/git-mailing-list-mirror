Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37082C54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 14:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiIVOOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiIVOOe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 10:14:34 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40972B4
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 07:14:28 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id q83so7795339iod.7
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=VdxMx7j2p0qMEQtf2DlrmcfwGvmqY8H629T9Ya5KArU=;
        b=GQEz3tYPJ/nkmhmEJm400lrREgxoXH+A9by3C0osGiHfIiZLSn9Z9vl/srkY/+Ol4N
         uAp5buRLlXPL6Ef3/Fqb9IkjouefKwo4dXuyBUMMZTdf0I7yMGroe41C4G/T37np2+Cz
         B0IHjXbEu5TL30Y+OwfyaJtf1Mb0PPOM79mEmRL9ZM/g/PpnlFSYLYyBZWKVkQfWSRG+
         kQrJgCZ/fTX9OYHS5AG1sjV5uYauVS8Rri2BzXl1m+0/+j2Z37ShRIWL5w5zTIWj7SzM
         cJT9u9ulj89t+suclK1ikY6rHJ1fCnBcqedxzSYwEDO5r26lcpeXvrKrwyIQgT2AuJeV
         74Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VdxMx7j2p0qMEQtf2DlrmcfwGvmqY8H629T9Ya5KArU=;
        b=InECKeEQWgJfki9VAr+b865ry3a8gHAj3SsBVSJOTlssjxo5fPly1sTZSSsKtIQN/+
         4rSczsTSb2uVvkdCPY8vwWebqHvSVaf/TnQHX/Q/5Vv3duwSzHx5Ekoyw6ouhSIF7SfW
         hYEpvH/pnv8dLG1to329BYHAbroWYFPueRZXkkVQf9JdU7bcgKDirCiNxvw6+BBhLS3Q
         kb2vQ2goTD4lPq08vbkhxPCnFvtiw/knE3WtzFZjJ/6XkEds7HaC9X3vG5viSiFOdANL
         xe5avTu0TrggrDT+ltMyq5eioNusFlLMZWt3uh6JTLvihrhqnBHHyGa+k1SxMghgMNS5
         Agzg==
X-Gm-Message-State: ACrzQf02lgvgw8/0ViU5TxvWEoTBNv0wAXHtlHiiK8DHELdyjn1HrGVx
        chchEa4Kp8TJPOsAaYXKiPYe
X-Google-Smtp-Source: AMsMyM79IFiO5I1ltWAIgC5ASuXEZfkl03QF8vNZOa6aiDLFTtRv/87tZ2AGiy6WJZg8W7Y4Bb2xKA==
X-Received: by 2002:a05:6638:25c5:b0:35a:69fd:946e with SMTP id u5-20020a05663825c500b0035a69fd946emr2123423jat.174.1663856068149;
        Thu, 22 Sep 2022 07:14:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e4c7:912a:7017:ed79? ([2600:1700:e72:80a0:e4c7:912a:7017:ed79])
        by smtp.gmail.com with ESMTPSA id y11-20020a056602178b00b00688b30a7812sm2312712iox.42.2022.09.22.07.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 07:14:27 -0700 (PDT)
Message-ID: <63a1c3d4-eff3-af10-4263-058c88e74594@github.com>
Date:   Thu, 22 Sep 2022 10:14:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 0/7] midx: ignore cruft pack with `repack`, `expire`
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, gregory.szorc@gmail.com
References: <cover.1663638929.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover.1663638929.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2022 9:55 PM, Taylor Blau wrote:
> This series fixes a pair of bugs that were originally pointed out by
> Gregory Szorc in [1].
> 
> Namely, that both `git multi-pack-index repack` and `git
> multi-pack-index expire` can cause us to "absorb" the cruft pack,
> distributing its objects into a new pack, and removing its metadata.
> 
> This is worth avoiding, since even though it doesn't result in object
> corruption, this bug removes semi-important metadata contained in the
> .mtimes file, which controls how fast objects leave the repository
> during a pruning GC.
> 
> This series teaches both sub-commands to avoid any cruft pack(s),
> preserving their metadata.

I gave these patches a careful review. They all look correct and
are closing possible gaps in this mixed mode of repacking with
different strategies.

I do think the 'expire' situation is very rare, but it's best to
be safe here.

Overall, the end result is that users could set up their background
maintenance as follows:

 1. maintenance.incremental-repack.schedule=daily to do an
    incremental repack every night.

 2. maintenance.gc.schedule=weekly to do a GC once a week.

 3. With gc.cruftPacks=true and a gc.pruneExpire value, the cruft
    packs will be written on that weekly job, only expiring old
    enough objects.

Before this series, that weekly GC creating cruft packs ran the
(very likely) risk of those cruft packs being rewritten with the
rest of the new object data, losing the .mtimes data.

(While the proposed schedule above is now possible, I don't
recommend it as a default. Not only will it delete objects
automatically, but the GC task is very expensive for very large
repositories and the incremental-repack task was explicitly
created to avoid that huge cost in those cases.)

Thanks for this update!
-Stolee
