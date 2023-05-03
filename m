Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E63C7EE21
	for <git@archiver.kernel.org>; Wed,  3 May 2023 00:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjECAJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 20:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjECAJi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 20:09:38 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4708273F
        for <git@vger.kernel.org>; Tue,  2 May 2023 17:09:36 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-61b72fd8cc0so1708476d6.3
        for <git@vger.kernel.org>; Tue, 02 May 2023 17:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683072576; x=1685664576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sX+6YSSJhFTYkJ3wcHo7tMPV4C2czg46hSJ8Jji8bWs=;
        b=ragYFoypUYjjhVxrO8DqfSVB60NxVao4UI1gn9qGmSxc2FAeOH5IMoVC8EKBRhxITC
         o2Zhvm66QgMksTyGfUhHnY7ZOIsCgvdykx7eslLJs5eToo13CLjb5yzqpLovr8dX643K
         PyusCf3q/zAmTdUaiQ0ThZ0L/y7f4NJy9Xht/WUCXUYOvOvvOXTxv5SdtzsUVKqNGU2K
         QfsHUoVK8YTO7NrMUNXNl2j6PM1nxBqC5IJ7OGDDr4SgiCa5B9ughAr3C+BAkzBXhNcG
         YnBku/EkL8hDyxBC0X51lPoNxnDe818ahBTHMYO04hJobpDSlV3lXWKAlRwRbClp5gDP
         meUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683072576; x=1685664576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sX+6YSSJhFTYkJ3wcHo7tMPV4C2czg46hSJ8Jji8bWs=;
        b=ciYKO4CTSFT4/DGqQ33jO/DV4v8XCVwlh4eKQTyoBWH9z9D+PqrFOGAvFFFYh1qTJw
         wAzNblb3WjWREXNBBTxZcoIzPYCASfOF9LaIbNR3zaKgZe7qzscqEPrDJh7UsGUJ16NF
         MvauPJoDAFEJ57fKWAtJ885HB/QC7lsmnGDNo+uv4OLNMNFqIGTCkzon5JU0wCj2FC1h
         21THJeg7bnwBtDo8Q6knLNym+hX3pM9vn2FTBWyhmGZfBFrrieAoFFSRdnQO8ELHHRXf
         2r6URq6GQjVWbG2yggT1mjTG8f4Q7rL8q/74C+Xz8tl4kn9Jdo9Yq6P47RxldoDln1Bh
         yN/Q==
X-Gm-Message-State: AC+VfDw3d4fjbKMcgd7UnKI+4A6CsV90xSDCTKegw9dHHWjpaHbdmL6+
        r515Fp9bQThTZLhOP0m4SEw=
X-Google-Smtp-Source: ACHHUZ7u9vomKb9NSNiQaMtlmqqXpmWoysRnMTR/Dv1mmAKA2hRldrXgeRduNstslqPNl1MYtH8c+w==
X-Received: by 2002:a05:6214:c63:b0:5e6:8e03:994e with SMTP id t3-20020a0562140c6300b005e68e03994emr6889010qvj.38.1683072575710;
        Tue, 02 May 2023 17:09:35 -0700 (PDT)
Received: from sohom-te15.lan (2603-6081-2401-85c7-0000-0000-0000-1112.res6.spectrum.com. [2603:6081:2401:85c7::1112])
        by smtp.gmail.com with ESMTPSA id 13-20020a370b0d000000b0074ad1698959sm10134840qkl.40.2023.05.02.17.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 17:09:34 -0700 (PDT)
From:   Sohom <sohomdatta1@gmail.com>
X-Google-Original-From: Sohom <sohomdatta1+git@gmail.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sohom.datta@learner.manipal.edu
Subject: Re: [PATCH] docs: clarify git rm --cached function in gitignore note
Date:   Tue,  2 May 2023 20:09:32 -0400
Message-Id: <20230503000932.153612-1-sohomdatta1+git@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <pull.862.git.git.1601888338644.gitgitgadget@gmail.com>
References: <pull.862.git.git.1601888338644.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey maintainers,

Friendly ping regarding this patch (I assume it slipped through the cracks).

It would be great if the change could be made to the git documentation, since
it still is a common misconception amongst students that merely adding a file
to .gitignore will lead to the file being automagically ignored by git when that
is in fact not the case.

P.S: sohomdatta1+git@gmail.com and sohom.datta@learner.manipal.edu are both me,
that email was used by me previously when I was affiliated to my university.

Regards,
Sohom Datta.
