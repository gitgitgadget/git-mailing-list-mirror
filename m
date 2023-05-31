Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D332C77B73
	for <git@archiver.kernel.org>; Wed, 31 May 2023 15:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjEaPwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 May 2023 11:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjEaPwx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2023 11:52:53 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9C09D
        for <git@vger.kernel.org>; Wed, 31 May 2023 08:52:52 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-96f6fee8123so484702766b.0
        for <git@vger.kernel.org>; Wed, 31 May 2023 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685548371; x=1688140371;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ges2qjw7CnAV3Hz1lWHozYalREYb39D1YINxKbaHLZ8=;
        b=l5GetwgSO7+QdPjwVuefzrH/+tfQA7I8RwaXl0K0Zv2+E7F1lY/oBFSbcwepFdKCE/
         H4KRejaKJ7DqxCGNXPYrWCgD5i2tLueRqHVqjGFoGWqjW4XizZwN+f4VTBx6zfaRnSJN
         eMTeZA5YVfbrzvU4NA9dD+IzX9z1s3ndyCgmAKhI+lJOl9InlAZYgOO1YtI7FFO/yjiy
         /G5CCxLJtNcL7JFVi3bHtZvTCDnScDFZqMYD/2uP5CSNdOCLW3LLel/kbRiVlx7TLT7+
         oOmbstdMijyO+RiQxumLRUUgbzh3FtQ9Yhv6/axQYbdaov2rIXy2eMfGAZn/aLk1ooFT
         QuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685548371; x=1688140371;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ges2qjw7CnAV3Hz1lWHozYalREYb39D1YINxKbaHLZ8=;
        b=C6PZN/nV9/N0O7EnUtO3GyaZbi26Szn4uaA67CLZZI5QTnlhVqYEAyfRESFQg/bYQo
         6lQqWVxUD0jfDXauQXpvB9gSxIjqb+qNNuqWKZbDPUMde73T9Uz3WOdPVeyTK7PA5+nf
         yZz0c4hdX2sHRXIuW6UrY/rFx+TrLPFIfaKC4gwocmXDQOg8cvL5z9tdC34PoAG9GNuN
         kj67a05coPj49GG4fRROeDqbjW/YBzpN3iMkYCx43TveSLP/5ibVsPJXTRcyqb5j0phK
         8WtjlKDGzB8Z1SKSJs0XTrfLphf7Kqt0q25gFJrh0gQtqOT3TSntcpEh1YuhGyCmmISO
         /jLw==
X-Gm-Message-State: AC+VfDxP5XibSyHuUhTiBIIyYVpjsSk7TJjNF3GxuoN4Ih1Ev+sCSm5W
        4DeHyVIocz5gpEFI16sbY7N8Mx23wl7lSAKPeTkWFlOnNIWjGa7cFnyocVorJpTyqT2zWbCJPrO
        6gASMG+MDKXCEn511Z4dz2Ng2LmkWEsLFa8O29jodVkyOxKngMBogMcUg0rCpEejWkwmZ
X-Google-Smtp-Source: ACHHUZ7MRRs+arIIdn51LBZhj6mkHCNxMt4FasGRRZf8qUCq33k/1tam3c1pK9yonKjs7p7lFj9SurxDSI258ycT
X-Received: from siddhu.muc.corp.google.com ([2a00:79e0:9c:0:bbc9:7869:40c9:d55b])
 (user=siddhartth job=sendgmr) by 2002:a50:d55d:0:b0:504:81d3:48f with SMTP id
 f29-20020a50d55d000000b0050481d3048fmr1890679edj.2.1685548370757; Wed, 31 May
 2023 08:52:50 -0700 (PDT)
Date:   Wed, 31 May 2023 17:51:41 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.GIT
Message-ID: <20230531155142.3359886-1-siddhartth@google.com>
Subject: [RFC PATCH 0/1] Unit tests for khash.h
From:   Siddharth Singh <siddhartth@google.com>
To:     git@vger.kernel.org
Cc:     Siddharth Singh <siddhartth@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This RFC patch adds unit tests for khash.h. It uses the C TAP harness to il=
lustrate the test cases [1]. This is not intended to be a complete implemen=
tation. The purpose of this patch to get your thoughts on the unit test con=
tent, not the test framework itself.

The tests cover a wide range of functionality, including the creation and d=
estruction of hash tables, the insertion and deletion of elements and the q=
uerying of hash tables. I would appreciate feedback from reviewers on what =
other tests would be useful for khash.h and if these tests provide enough v=
alue.

[1] https://lore.kernel.org/git/20230427175007.902278-1-calvinwan@google.co=
m/T/#me379c06257ebe2847d71b604c031328c7edc3843


Siddharth Singh (1):
  khash_test.c: add unit tests

 Makefile       |   1 +
 t/khash_test.c | 173 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)
 create mode 100644 t/khash_test.c

--=20
2.40.1.606.ga4b1b128d6-goog

