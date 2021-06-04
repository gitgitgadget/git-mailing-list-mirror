Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5A5C4743C
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 17:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5470613F9
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 17:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhFDRqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 13:46:15 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:34326 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhFDRqO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 13:46:14 -0400
Received: by mail-wr1-f52.google.com with SMTP id q5so10129382wrm.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 10:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=PTtrYtfKHDmJ4MnBJgXX7O0sNUpSC6343I74usA5BTA=;
        b=qFRGSkOGRz101wJCbb3AEOGV/FSAA7DKDZiZyYec0aJ0oAj+XCui/e4RcvpcV5EdT7
         QpsjXearp27WR9YfQCE7QnTr8l7YXn+3TAlQmcC8OxE53ozhNJSF4RURatHjzGi2vNoP
         ZSvy3B0oYty3JoCuU/9uR+JWmvQvHsEHV7uZP1+ulSk9UzTloNNRQ018/Rmb8I9WYcTA
         uZK02LUuv1HUgZZvctC8Nxzgsxct9VMzRxLtvziWVV/7sQDfVDHB6AzEoQiTdPCEoEvQ
         mNhr4DDU6ARy/nmtT+JVEXsaKTnFLDn2OxJEVEB5GoidJUlEVMw8hBlFYbT2UW4H5RTN
         j/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PTtrYtfKHDmJ4MnBJgXX7O0sNUpSC6343I74usA5BTA=;
        b=AT+NGJqfm/LXr6kMeIlfFiAn+BILejF6AWERZ/M8Kngv78CiidXcZLIeaWcQBaOcxQ
         Wl4DC9a7VpvmXjnG8xADjIRnKuJ5gplWGdzPM+55qbMh8/KaVFup0c3zDknK9PLgczzd
         LMiCApIObQymysDjbFDnbtR7j8gnejX5hUzjPD/Z/O4557Xxl9zvIlUXPpI3fSukBjWE
         AZ0j0kYo68H2HOIvKy6lmWEWs68+6JMsGukfS3sBxV2MnpbezMrgvjGuZusz/Fl/FUxE
         7o/22/eZAJFnDIp/asBvEK0DG49u7KNf5TqiMVNdAcXAeyBXKgwQCz6LjOZZXSz/eZxo
         RNrg==
X-Gm-Message-State: AOAM5318PuDhUW34Svd7kK/BNKlg3PLvAM8c5ZQCrFpP5Qk8McirW8At
        WbZ9Cpf/Yb5556pV6BsM4zb0ZcJWUKE=
X-Google-Smtp-Source: ABdhPJwCFGRcM0V8b3mKTfW3a1N3a0M7vZ9o9AI4016/aqAFUgZ/w6Wy6PzfHh0AVOzxNgdcgF2xZA==
X-Received: by 2002:adf:ee85:: with SMTP id b5mr5034138wro.95.1622828607123;
        Fri, 04 Jun 2021 10:43:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16sm8012437wru.56.2021.06.04.10.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 10:43:26 -0700 (PDT)
Message-Id: <pull.970.git.1622828605.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Jun 2021 17:43:22 +0000
Subject: [PATCH 0/3] Make CMake work out of the box
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This pull request comes from our discussion here[1], and I think these
patches provide a good compromise around the concerns discussed there

1:
https://lore.kernel.org/git/CAOjrSZusMSvs7AS-ZDsV8aQUgsF2ZA754vSDjgFKMRgi_oZAWw@mail.gmail.com/

CCing the people involved in the original discussion.

Matthew Rogers (3):
  cmake: add knob to disable vcpkg
  cmake: create compile_commands.json by default
  cmake: add warning for ignored MSGFMT_EXE

 contrib/buildsystems/CMakeLists.txt | 38 ++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 9 deletions(-)


base-commit: c09b6306c6ca275ed9d0348a8c8014b2ff723cfb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-970%2FROGERSM94%2Ffix-cmake-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-970/ROGERSM94/fix-cmake-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/970
-- 
gitgitgadget
