Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA70C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 01:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjDAB7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 21:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjDAB6r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 21:58:47 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC4923687
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 18:57:23 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-17ebba88c60so25053051fac.3
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 18:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680314194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/4+76mjhHZ5qCdTbcm6kc+lv3qYrTf7AeFpkCppnnY0=;
        b=UfIePnXzO3J9RlnKPW7Z8tBAEi6ZoXV5EQkcH7F/eP1yw17Jn0BSp5MDQTDk9E+Ha+
         G+Vgh96ZImstgmRnw3d97CepKgRN0ibVuZyoC9/Ne24VbhFiiSyXR6XjpuszI+nr/7db
         lwSO5xseRIxnk0wi5tqCbOpbDvxnBZOX9ki8TEp2oZu4SEWsnMi9EFqcc3GqNpX+TIMd
         kAMfw4cyjcf0Uxs2F/HKUfq9NfjNKe1R4Q7FAUn0Fvs39b4tARfDEV9BN74KE+472Bbh
         GzKFvFuTk05N/sLVC2eQO/4embYvL46AJfOP3BiUGXNsc88mNsB+RNw01eRZcJU1omEt
         5hzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680314194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4+76mjhHZ5qCdTbcm6kc+lv3qYrTf7AeFpkCppnnY0=;
        b=yo3LNw29Zpb2O5yOhIsq/RG8xrZ8WJna8AXUo+33XnrJxWOOjWKSg0Fc54PoCC4s6i
         N4DIGbfum+agRYaaaO9JI+NkwR6nEpPqrGmV0qmiHTS9GpOTGk9df+8MpUq/TL4OIQE6
         gbGhI+F4+2G8dyy3EJrMUY7Rv8RTrjFZ24Z77oCn3LnlnUWtbRqVbThRAaJ0ai/fN/T5
         RIYFynym+khw3gO6EGj88/rIorlCqJ0QoQnMnCiiWP+LM8JbpJQ1U/be/RLz8QTxzGtP
         xM8VCg0zAar4vqJDU/NJtBeUFUOdUO5hmngSlE+EkLELJV8sgfx7DqWi534GZDHx7jpj
         1uFg==
X-Gm-Message-State: AAQBX9ckA7dIm/RvG/Y32bdJv/I9tg+Z2M3Q1i07hu2hPHcesyMbaEoj
        QX4SGRVZga4OwPKKIfpkj6+9s09BHzI=
X-Google-Smtp-Source: AKy350bC6S3556Fq4wWBQD0n+GIEe2SHbJNw0WamxbsSq2XC/klFtA6ifLT9YtZFEAz49bJicgbsIA==
X-Received: by 2002:a05:6870:2214:b0:17f:5b32:c493 with SMTP id i20-20020a056870221400b0017f5b32c493mr10382620oaf.59.1680314194733;
        Fri, 31 Mar 2023 18:56:34 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id j19-20020a9d7f13000000b006a13dd5c8a2sm1821681otq.5.2023.03.31.18.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 18:56:33 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] test: add support for zsh and zsh completion
Date:   Fri, 31 Mar 2023 19:56:30 -0600
Message-Id: <20230401015632.103581-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have been running these zsh completion tests for many years in my
git-completion fork, and they have been sent before to the mailing list [1],
only to be ignored.

But by adding zsh support in the test library it's possible to run them in a
more straightforward way (directly in the test script, and not in a separate
zsh fork for every assert).

By running these tests it's easy to see the many issues the upstream zsh
completion code has (13 failures), all of which are fixed in git-completion.

[1] https://lore.kernel.org/git/20220830093138.1581538-3-felipe.contreras@gmail.com/

Felipe Contreras (2):
  test: fix build for zsh
  test: completion: add zsh tests

 t/t9904-completion-zsh.sh | 1143 +++++++++++++++++++++++++++++++++++++
 t/t9904/.gitignore        |    1 +
 t/t9904/.zshrc            |   51 ++
 t/t9904/_git              |    1 +
 t/test-lib.sh             |    5 +
 5 files changed, 1201 insertions(+)
 create mode 100755 t/t9904-completion-zsh.sh
 create mode 100644 t/t9904/.gitignore
 create mode 100644 t/t9904/.zshrc
 create mode 120000 t/t9904/_git

-- 
2.40.0

