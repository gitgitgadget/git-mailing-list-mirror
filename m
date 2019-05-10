Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11F4A1F45F
	for <e@80x24.org>; Fri, 10 May 2019 15:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfEJPdH (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 11:33:07 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:41356 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfEJPdH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 11:33:07 -0400
Received: by mail-ed1-f49.google.com with SMTP id m4so5660738edd.8
        for <git@vger.kernel.org>; Fri, 10 May 2019 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=9kaClN+hVqe9UAnfjOnIME8mBppgwHKdeyB/dtAiWWo=;
        b=LWsyWrDX7fDNvWYm1LZUJctnN2vk1UuRpS0Myc++k4bes5cF1hsNSIUnsxTMySAyg2
         lQsfL99TXyobhLabDaBYlv5whIcsND2z9DMB645/eSP0LScahZ6sPXKE9xK+Dgz4hiT2
         ZHZGC6aM3btMZ+XnLg+/+/LM4NTMo2DBpEuw8NdRnrenyVqOuN9phSiHS3DWMGkZ1Cz5
         HWLzvSeyL3LFPN+MEEKwKssWpZb3yvIST4/DXvNxdfDWdFQWq7WTvfB2VLtz0ZZV2fWJ
         paa8v2MgHhZvsrsy2lJiV3awdRZWdUh2Eek2nm1fMUcDukPM/iu+uWb7lJBoaFTpxWFK
         7SCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9kaClN+hVqe9UAnfjOnIME8mBppgwHKdeyB/dtAiWWo=;
        b=iXeJZIKB88QViq6ZLdfe1mV3NWK9K8adIetNIJSVjTnJGEReTel4Pcw8AOxon1rX20
         k0aoXwamgiCDx9PZwMy6oeKDWm1cF07A2tGbQWUIfffVXhyX2cxrfvvrXso94MnNsk0w
         NwNvA8pFI7/346vdlXowoIhAOSqHFJwo4LDQPbp1sGmbM+G1Q85wndVBCNUcCLL3Cv5G
         lyuS76sjGHJBxW5ivIloe8DNAw0GwYckA+VOT5hfvzAOO6l6UGYtKO8iYgksUpy94h+S
         4xS9wAFx8iUJWwmvJvccO+z8DJdrJCT8KTfuIFQpeof+6LC+el7tT2FFWmG6gHiaXDze
         J5TA==
X-Gm-Message-State: APjAAAW6B86VXAQ8W4N6IE2aFpT8tgPqSRdSNkmwiYM6KzhedM9LuEw+
        w9e4kSClHHOmNV41KcPeYrRjioX/
X-Google-Smtp-Source: APXvYqwskkA62Yfa3JnP4OVvUYvZWMhLNpVHAnDG0Pt8J+8QXvWMep1BuRHYPKevjrxrr0NVvSUMIQ==
X-Received: by 2002:a50:bf0c:: with SMTP id f12mr11898065edk.181.1557502384987;
        Fri, 10 May 2019 08:33:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4sm1475025edf.89.2019.05.10.08.33.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 08:33:04 -0700 (PDT)
Date:   Fri, 10 May 2019 08:33:04 -0700 (PDT)
X-Google-Original-Date: Fri, 10 May 2019 15:33:02 GMT
Message-Id: <pull.183.git.gitgitgadget@gmail.com>
From:   "Mike Mueller via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] p4: fix "Not a valid object name HEAD0" when unshelving
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git p4 unshelve was failing with "fatal: Not a valid object name HEAD0" and
"Command failed: git cat-file commit HEAD^0" on certain systems e.g. git
version 2.21.0.windows.1 + python 2.7.16

It seems that certain python pOpen implementations drop the ^ character when
invoked using a string instead of an array as first argument, which is what
is done by extractLogMessageFromGitCommit.

Solution is to use the array format of passing the command to fOpen, which
is preferred (see https://docs.python.org/2/library/subprocess.html) and is
used in other parts of this code anyway.

Mike Mueller (1):
  p4 unshelve: fix "Not a valid object name HEAD0"

 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: aeb582a98374c094361cba1bd756dc6307432c42
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-183%2Fmdymike%2Fmaint-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-183/mdymike/maint-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/183
-- 
gitgitgadget
