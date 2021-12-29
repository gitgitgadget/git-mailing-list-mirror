Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E29C433EF
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 13:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbhL2NfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 08:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhL2NfL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 08:35:11 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93BCC061574
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 05:35:10 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id h7so3523442lfu.4
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 05:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j46j6qIIuBSGr7tpCkt7FSYN5D74t935dd2Yhm58tn4=;
        b=UdjjvwdleEXvPX5ymP6EZouTLhcgey9bI4hMaRGtHFK8pirKHt+K8lNdZ/78Lygd+7
         ODoqwaeRo3oKD9a2hSk5lEHmExKLWpQHiVXxeqHklNl5gz3Wtnd9iIg2DnAjqFyYWiIl
         EqNMezqHKJx2ZpHABf2+hcStKzt5ilmsN5pbWdvKLVCxPhxdKv30Ts+Ldd9uTOMgypXm
         cyADIaxeGrt6qHVf4llMgOMv3eAsl8hkVgdjMYhOEyG32npZWQRB010+jonyc6iQQipB
         yO5kM+KKrLYyxpAe4WEZLFG4bzFhFSUz/evRD+XoXOosxuJngZmLM9KDCOHsX1FA12Qy
         A40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j46j6qIIuBSGr7tpCkt7FSYN5D74t935dd2Yhm58tn4=;
        b=ClP9xGetP1a6YT5s0nLc0yNdfERTscZ0B9h62S+c20Ui7MhWUaCH3Q5nT+xgklRMMQ
         7pxtQWDHHmuVasEbHNxBsuy3E82YtKmSJIKoAz2HOs5s/ZmI30PmaPC3yRxGy/ZoEgOm
         /OpiSaN1j+5pLBrDu030/fZ/AVHusJy9vkaIFIcO+pBXPpN6Ib0PU6U6LzdQU1+1ZC2G
         /6zPzU5kejUdwbFW3JZ2TCq7qehpzpQRa62TdpX5dehtK7XsdAvi6+B4VKOWcNuGRHiO
         nHn0pJGOayosClEcctndIRip2eCiXdj8JWT3rTi0AsVrp8dSRfb4Uigbt0UmxQKvGMnk
         FAOg==
X-Gm-Message-State: AOAM5319EaM+JaN/RGETdraBPR4B3zHtPgcH8VYUCEqrmzjq3fw/ko0O
        TlN3ffol/Wg3p4jqRGjjrOKjJLTntAg=
X-Google-Smtp-Source: ABdhPJz/zyxqwaqWGdlA8GvRpgBCh7ReV6A9LL7uHClcJTWnK53GX4DIt9OEpniL2mAaRoy90TBGlA==
X-Received: by 2002:a19:6f4c:: with SMTP id n12mr24678350lfk.582.1640784908921;
        Wed, 29 Dec 2021 05:35:08 -0800 (PST)
Received: from ?IPV6:2a02:2168:8729:6c00:311c:f36:5cf5:528e? ([2a02:2168:8729:6c00:311c:f36:5cf5:528e])
        by smtp.gmail.com with ESMTPSA id w10sm2205230lfu.173.2021.12.29.05.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 05:35:08 -0800 (PST)
Message-ID: <fffeed2f-c956-d34f-ea5f-73f52e2d2be4@gmail.com>
Date:   Wed, 29 Dec 2021 16:35:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: request: allow passing -X <strategy-option> to git checkout
 <path> to auto-solve merge conflicts
Content-Language: en-US
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     git@vger.kernel.org
References: <3e1548ab-5e20-9555-bd10-d6cbf2ffbce4@gmail.com>
 <CA+JQ7M-By65FVPnMFnwE8zx3T4O7DV3_5Kf2P6eZhP4Zcemorg@mail.gmail.com>
 <a8f3246f-2b50-e713-16c3-1d23b80a42a1@gmail.com>
 <CA+JQ7M9Ht5vSfDDEuYyK7pBPBvgjzi7L6jEYX8dkP4PMFK-M2Q@mail.gmail.com>
 <CA+JQ7M-gornjkB78Dgx-bHW7Ps=C2936vDNUakQ-VG8KAyZ=YA@mail.gmail.com>
From:   Andrey Butirsky <butirsky@gmail.com>
In-Reply-To: <CA+JQ7M-gornjkB78Dgx-bHW7Ps=C2936vDNUakQ-VG8KAyZ=YA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is exactly what I tried to avoid, since Git already seem has all 
the needed under the hood to prevent such disaster..

On 29.12.2021 15:13, Erik Cervin Edin wrote:
> On a tangent, you can set up your own merge tools.
>
> So in git config you can add something like:
>
> [mergetool "both"]
> cmd = "sed -i -e '/^<<<<<<<$/d' -e '/^=======$/d' -e '/^>>>>>>>$/d' -- $MERGED"
>
> and call it with git mergetool --tool=both
