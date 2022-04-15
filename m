Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0071C433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 05:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245028AbiDOFby (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 01:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiDOFbx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 01:31:53 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741F52C3
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 22:29:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id md4so6867248pjb.4
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 22:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2KjXz9SLSnIjmz99lkDG5Bjux7h2r74HyUX/kDItHZo=;
        b=DR3Dicu5FAViZim5grtgkMQz/VIRkZbggygvOaCwDL35qz3vAVQiOICoU1DGVkqxgD
         91MltlD23fTOPHrEnHXZLlirJG91lz+enFYPiRYqcZ8ycIB7tK5egw/cXPyQYXhpamkq
         AGx4dVKbRbgdlnSMi6hRSaie1BbcTWv2cZ623FOTF09sgV5jvh/5/ATHmsKTrIlUcziT
         Wr+P6Y9iCmw+RpPc+gaHS1eE389oh3RURlsVpO3u4ntiRaJ6wGH/9F8RqrzMqL7udCuT
         S18rY7yiTU0ENoTPyai1Pxdn9jdCdPORz3Npv3KKePWvXE+JtzQlIkICdJHrGOmBYN7k
         ZNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2KjXz9SLSnIjmz99lkDG5Bjux7h2r74HyUX/kDItHZo=;
        b=RrADeyyv8KyY82+VX+tlqZemgu1wittzxEND4GuvH05z88r5rT86C1HFQw4FP+mIIv
         V+iFAwUQQ2VGkmSaGi47R/p/Z+9HZuiGRhtebSw5Tu5vZs25+2y9oyg+DJEYdyG+xa+M
         qkE4s4DZEJGiYiL2eId9VRcBwUxRJbPLZzilo2s7hoP0whBgzv7hKmmmLH4cjSet3bY9
         qA9AnmEo3A0An7eb2WYUcBNUEHNn+GUI5Rc078wzruOpbOBGOCT9eefMo20HRlIT69B+
         ugcJ4EV4ngTpGUE7nFLb6IguBSLlWFFk2O3YpV1u0hfay+R5g7FArfTFcZCZvJmC0+iA
         8acg==
X-Gm-Message-State: AOAM531+qB2udc963wPvBVFrz4vffEJStUXxyGRHwqXMNUfmaoVvS/qJ
        WdXgAmSjxXVikR0b535eNs4=
X-Google-Smtp-Source: ABdhPJz+tJZ3pbQBo+vc8rnekTDAY04+IE14t+YnbCz+khTi14JS9YAIsvVGcA+l6wUqpoQJQud5ug==
X-Received: by 2002:a17:90b:4cc5:b0:1cb:ba0f:9623 with SMTP id nd5-20020a17090b4cc500b001cbba0f9623mr2306891pjb.85.1650000561793;
        Thu, 14 Apr 2022 22:29:21 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.156])
        by smtp.gmail.com with ESMTPSA id kb13-20020a17090ae7cd00b001c7de069bacsm7711428pjb.42.2022.04.14.22.29.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 14 Apr 2022 22:29:21 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][RFC][PROPOSAL] Reachability bitmap improvements
Date:   Fri, 15 Apr 2022 10:58:56 +0530
Message-Id: <20220415052856.49433-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <fc0015ac-9ad4-d3b4-39ee-0bf4f9c99fa0@iee.email>
References: <fc0015ac-9ad4-d3b4-39ee-0bf4f9c99fa0@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> wrote:

> It's also worth looking at the Git Rev News articles and light reading links
>      https://git.github.io/rev_news/ and
>      https://git.github.io/rev_news/archive/

Thanks Philip! will surely look into it.

Thanks :)
