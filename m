Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9914EB64DA
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 20:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjGHUg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jul 2023 16:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGHUg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2023 16:36:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9B8E4C
        for <git@vger.kernel.org>; Sat,  8 Jul 2023 13:36:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-313e742a787so2488768f8f.1
        for <git@vger.kernel.org>; Sat, 08 Jul 2023 13:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688848616; x=1691440616;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oo/o4V95FsAz/ewDJ96zduBYarymR6YuKq+hrbNmkD4=;
        b=K6AtzquLAtiv+DEay/hEVZDHWKhTts75qdZUZ/HG/owhG7S66nbch21ds9GmGWlzH8
         sEtvlKuO5cAJ1TeEeo0GB1eAJb1flduZECU2i1Vbco8g6TPLM6iOPJx+n6tYuDCdxAv7
         pk6/TOuPTMKtwVS6NCk2b/rbEoJQXFFsyGoc8z8S++XaxBRLEuAop1Z/6GPUe5Q+/M3F
         s9bEnBeLNvw3jU2quoUXxz9gEFzMGMMBWYffirsP/1kC+VQfWGwPVxJth4mwQ23jFQgi
         tSSJ5vTDAkzPsmMfhxYG5Kds4p/0Xny1hs+DPYn1p0z5D+F65nUslGZvfUP4LL/TC331
         UTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688848616; x=1691440616;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oo/o4V95FsAz/ewDJ96zduBYarymR6YuKq+hrbNmkD4=;
        b=OecSp18ahO4cGVNciOrRjJVHfG728kvDTuZVTPnxvF+4TZCpZn3bUi0LTZ4OPRLZf7
         ljpJ2MBh6ycudldPKKZpujr5KQ3CRFj+USTVQcaUmDYFzL1Y2MkRQbDTZXHAWzUXgjTf
         ZDRfYEyN5OtVI9uOlL8qiU1BFeT/4mLND0HyNrNZWOj8Su0nMbJJTS4XjgelU/Y61IF3
         6g31lnqwwdogREEZBBBTOQtbY03QMBGFMO2tcVp8OKH96SlKFgeSwsJ/pzK0yI9+PGhc
         7aNHTc9+L4g1adkMupW9wQnnaRFnZXpQw1kSRfLLgyZxqdNzq91FwIuk0rpagBXnh5qU
         QqZA==
X-Gm-Message-State: ABy/qLYJhxT2vB1WvqWz9ygIrHLXS0CnhpmQi2f674nOtFWx5Hx4acqn
        i9CKxyw2CE645oAzAX5TfQDGcmU1ymA=
X-Google-Smtp-Source: APBJJlFr1Lw/hqlbr8B1eGqKTEywpR7vJkstG7Exse1/chFBCDSm4ERu5L01kntG+YmRIEjclMii2g==
X-Received: by 2002:adf:fe8d:0:b0:314:1228:c4c1 with SMTP id l13-20020adffe8d000000b003141228c4c1mr3865023wrr.23.1688848615543;
        Sat, 08 Jul 2023 13:36:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6-20020adfd846000000b00314315071bbsm7674472wrl.38.2023.07.08.13.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 13:36:55 -0700 (PDT)
Message-Id: <pull.1538.v3.git.1688848614262.gitgitgadget@gmail.com>
In-Reply-To: <pull.1538.v2.git.1687332624780.gitgitgadget@gmail.com>
References: <pull.1538.v2.git.1687332624780.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 Jul 2023 20:36:54 +0000
Subject: [PATCH v3] doc: gitcredentials: link to helper list
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, msuchanek@suse.de, sandals@crustytoothpaste.net,
        lessleydennington@gmail.com, me@ttaylorr.com,
        mjcheetham@github.com, M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

Link to community list of credential helpers. This is useful information
for users.

Describe how OAuth credential helpers work. OAuth is a user-friendly
alternative to personal access tokens and SSH keys. Reduced setup cost
makes it easier for users to contribute to projects across multiple
forges.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    gitcredentials: link to list of helpers
    
    Add link to list of helpers

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1538%2Fhickford%2Fhelpers-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1538/hickford/helpers-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1538

Range-diff vs v2:

 1:  26818290468 ! 1:  a6265156eed doc: gitcredentials: link to helper list
     @@ Documentation/gitcredentials.txt: $ git help credential-foo
       
      +=== Available helpers
      +
     -+The community maintains a comprehensive
     -+https://git-scm.com/doc/credential-helpers[list of Git credential helpers]
     -+available.
     ++The community maintains a comprehensive list of Git credential helpers at
     ++https://git-scm.com/doc/credential-helpers.
      +
      +=== OAuth
      +


 Documentation/gitcredentials.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 65d652dc40e..71dd19731af 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -104,6 +104,17 @@ $ git help credential-foo
 $ git config --global credential.helper foo
 -------------------------------------------
 
+=== Available helpers
+
+The community maintains a comprehensive list of Git credential helpers at
+https://git-scm.com/doc/credential-helpers.
+
+=== OAuth
+
+An alternative to inputting passwords or personal access tokens is to use an
+OAuth credential helper. Initial authentication opens a browser window to the
+host. Subsequent authentication happens in the background. Many popular Git
+hosts support OAuth.
 
 CREDENTIAL CONTEXTS
 -------------------

base-commit: 061c58647eb4b3f0e2c898333577d4b2af115b1d
-- 
gitgitgadget
