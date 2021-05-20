Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B97C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 10:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 713D561059
	for <git@archiver.kernel.org>; Thu, 20 May 2021 10:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbhETKvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 06:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238541AbhETKti (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 06:49:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C74EC061D7B
        for <git@vger.kernel.org>; Thu, 20 May 2021 02:51:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z19-20020a7bc7d30000b029017521c1fb75so5036817wmk.0
        for <git@vger.kernel.org>; Thu, 20 May 2021 02:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=user-agent:from:to:subject:message-id:date:mime-version;
        bh=P9+mqB/HrgOIY+pqht8poyeBXOunUM7CZE5XSj/8Dog=;
        b=baNIS88NG9E+BEasXZNcZlzNaj0YQb1YCbsNjPk0AJ/R5fblfzgxj8T5upWDkbm6ir
         WoNUrrKfEzeiC9L0FMgDj0HNGkbzVcWF12RtKFbiIj/ESp8cG91xbKq+4liI95UGxjkC
         +QMBQv9B6EREiIpcoEebPk0xd1P1MYrWHvdMruLR0/HgrlBhBfQha3DEssLGcN7Vo4A2
         0tbiSNBAGafJPbxLkrYTue6vSavqSF0C7fg0rBZXK9olurWd+CcPJTZp6W1bEQN5py6C
         sjLOvFq+2hHvKaRY8qYloJtTMATcyM+J5yO2HTqA2TxnOm/JP7yz48/5lGcam6fKXLxK
         xeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:from:to:subject:message-id:date
         :mime-version;
        bh=P9+mqB/HrgOIY+pqht8poyeBXOunUM7CZE5XSj/8Dog=;
        b=dsSmCN6rYt46H3CHoXlikMM0iDwWILoXMRmmYGdygtV4M8KMsAPPUgzH+5LO2mH8la
         /4/bZdmEglGJ8u8WhkOP2RVMwByhnyGS8WcfkIgP1Tk+R2IMOzDXGydsW9vFk+3uyzae
         8u/XZtKRCalFe8hz1S86FoABYAu8AFW+IuAOlK6lYAd7OKYjWE4jxNSh8IPzg6As5Blt
         9jTMRetHyMLaKdXACSo6+KnBeoAh6v4e6MApDwUUxBDR5Ff/O4HVw/VGZ3f35Dg1QpRJ
         tivdBccWMx/71dcTq2XumV6YxhFaVkCRAzU40EI94ORNOnLNwPKMqkB4oAXJcMOKLbdM
         7krA==
X-Gm-Message-State: AOAM533yRvqFyKH8mKKLLGpTGd9CmRmbt2tmttvpAcSnFsC/Ry/SNHNL
        aaRFLD181zUdD2goIDPcQW6WlF9h0i0=
X-Google-Smtp-Source: ABdhPJyihK++Cp9aSGn9Hhd72xMg8K3Hxmrr+qeGPcUe9ZgmnGJk9qUuwC76U/2VuMreS1ba+ojfGQ==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr3177078wmi.117.1621504288854;
        Thu, 20 May 2021 02:51:28 -0700 (PDT)
Received: from arch ([2a01:5ec0:2001:5c56:224:1dff:feda:be78])
        by smtp.gmail.com with ESMTPSA id s5sm2518772wrw.95.2021.05.20.02.51.27
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 02:51:28 -0700 (PDT)
User-agent: mu4e 1.4.15; emacs 27.2
From:   Siavash <siavash.askari.nasr@gmail.com>
To:     git@vger.kernel.org
Subject: [Bug] git-credential-netrc.perl is not built and is not available
 in `exec-path`
Message-ID: <87k0nt3f8i.fsf@gmail.com>
Date:   Thu, 20 May 2021 14:21:25 +0430
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


which is located in `contrib/credential/netrc`.

If I'm not mistaken, it's because it sets the `SCRIPT_PERL` environment variable here:
https://github.com/git/git/blob/88dd4282d949cdafff516650c1be8aaf4d67983f/contrib/credential/netrc/Makefile#L13

But the Git Makefile un-sets environment variables here:
https://github.com/git/git/blob/88dd4282d949cdafff516650c1be8aaf4d67983f/Makefile#L587

Also credential helpers in `contrib/credential` are not present in the
output of `git help -a`, is that a bug?

I'm using Git v2.31.1.
