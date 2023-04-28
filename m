Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6A2C77B61
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 18:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346361AbjD1S3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 14:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjD1S3d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 14:29:33 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D4FFB
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 11:29:32 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b7588005fso310896b3a.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 11:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682706571; x=1685298571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhLmCRF2/o3Yhx3IBvtJWnBH2mHxTKX83/ClrYadW2Q=;
        b=IKU6gVrowihGyCGahkjAukljQadJ3OtHUHxrnfdTFBYakDlH467cwZ7+k4c5+JwVYh
         Sg/+UA2MGOnoKtPEJYcgFQgaiXqjTIpaY1fHTnanzUnxvSp7QOVDHUSJfvh3hflTPMqX
         FTpdebNpcuBu0DTCuwdJYfpEq4Rb8vE9IpuSPZaF2KjGaYf3TXM9OWcncxK75Ai+YISD
         tl0qPxr9Ua1HF07uD9/Nee00MXoovVkKRSWhynPXMg1kcobFIVs9Zdf7CjXeFpnEadmg
         sot8Muacc5jRyDvg/vSlhTEfle1v8LRmWIdwdH5U4zIIRrWtNdCEDUK+iGXH3zhjrAbs
         FtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682706571; x=1685298571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhLmCRF2/o3Yhx3IBvtJWnBH2mHxTKX83/ClrYadW2Q=;
        b=MxRvfx1DfTlzMQOk4MqNESU8mfi2dvZ+01pLkoWB4fKac223Qr+8oXvg84XoEvOrqz
         hwN5HropQPD9ml0M0r19ZfSU+V0+c1IcKnuz70Eo8oKRWXK4fFUWe+/3b7ce7z8uha3k
         xfPlfTUuv6YLbH2SuQ4OawtQH3hsLDPEVkj/QeThlDallqmjx7KWNBTIsbKWgZEEwF47
         VO1Fg4vvLkbm8YKWBNCPRA42rr1q5wR+EWUaRAkihOnwssj3o6IzWeBqV7aPs9nU5xKl
         8+rEocdvYUIjNh31HCgwTQ9KzugCHiIsZllDuGCo04+QC95bxut860VnzMfPnVVndcg1
         OP4g==
X-Gm-Message-State: AC+VfDxUjW7/6Dpem1iE+poeeysuTIwHx3F0dqdewtIHPwrjxtR/Ae1v
        o0m4w+mA4PIAVyIc8mW/ZsE=
X-Google-Smtp-Source: ACHHUZ5wjGg4LkABAL64jU90nXEGVRpbHwrrapnxA2fB1k2JuSVTuALl2pD1Db8WMZTdL8Pzu1wnhw==
X-Received: by 2002:a05:6a00:9a2:b0:641:f54:eaed with SMTP id u34-20020a056a0009a200b006410f54eaedmr10274755pfg.21.1682706571613;
        Fri, 28 Apr 2023 11:29:31 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.147.33])
        by smtp.gmail.com with ESMTPSA id t40-20020a056a0013a800b0063d29df1589sm15560474pfg.136.2023.04.28.11.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 11:29:31 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     nsengiyumvawilberforce@gmail.com
Cc:     git@vger.kernel.org, chriscool@tuxfamily.org,
        hariom18599@gmail.com, jaydeepjd.8914@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v5 1/1] ref-filter: add new "signature" atom
Date:   Fri, 28 Apr 2023 23:59:25 +0530
Message-Id: <20230428182925.14975-1-five231003@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230311210607.64927-2-nsengiyumvawilberforce@gmail.com>
References: <20230311210607.64927-2-nsengiyumvawilberforce@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com> writes:

> +test_expect_success GPG 'test bare signature atom' '

I think this test is failing on CI because, as Junio said, there
are different versions of gpg coming into play here. In particular,
this test is failing on (according to the logs) linux32 (daald/ubuntu32:xenial).
The version of GPG that xenial can use is at a maximum v1.4.20 (this is
evident here https://packages.ubuntu.com/xenial/allpackages). But
according the code in lib-gpg.sh, we should be able to handle any GPG
version, except for v1.0.6.

Looking at the logs that Junio posted, I think that the cuplrit is

> +	grep -v "checking the trustdb" out_orig >out &&
> +	head -3 out >expected &&
> +	tail -1 out >>expected &&

but I'm not really sure. So I would really be grateful if you could
explain this hack to me, the one you mentioned in the cover-letter.

Thanks
