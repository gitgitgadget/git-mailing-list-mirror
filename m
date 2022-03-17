Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F5EC433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 17:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiCQR2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 13:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiCQR2x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 13:28:53 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A16114FC8
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 10:27:36 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n31-20020a05600c3b9f00b003898fc06f1eso5342830wms.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 10:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IQf1GTIawgIv0tA7JZX7HoKK96q+6B1QT9KUuYViw3U=;
        b=LMi9aWdjIWkFqHVkOVe6CiSRDMdE2ts1piwSHv8b0/21/RBpLNyzBU7U9ND1zBphXG
         fddQRmY4aD7TSmCRTKNwOZUAkVn69eHmEnemFYY20GSoi2+W8phb0LcJi3KG5mfEmn+U
         ki0940IXQDcGh1OZibtz1/W1cR78b/zEW1aOoSAazhNMszUjSEKHPWkhQDRQARjPpmAc
         SdSAqjQjutlkdXTS9v5mHCpM/SugKYW9GRytk8gV07K9BgW5tIK5PLhKY9/HeVkAxPeL
         5UjqkVf5eGXZ12PC6PkSqa3rCsiGNaARpN2JEGNJrvA52jJrinL7lZC7JF9SoEXFyvq4
         hgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IQf1GTIawgIv0tA7JZX7HoKK96q+6B1QT9KUuYViw3U=;
        b=Xr6Q91FtewlOeF7GnS+jLfDDSR933iOYXPMlQaScwLlKYLu/bqdcDkasfyuRIUGvil
         oFymudvRjt+GAxjVCA4zjv3rIFQK6MGJ3vhCnIsLHfkcY3Tv2os3f+cvwMYobw47rEt8
         IPftVHI7oKjhI8PHlEb2MwgMbESS3pgq7nbnyi+2gNyjG94tKsE/f9Z+iptEWBHTo2Bc
         bFMBz0A4Rgxa4gwuhGr1nibWVZ8qp1HXMsAgL6cXuON/i20l/Hz7dxe8to2UX0iOTrwJ
         t+5HGebQ6Ui10Kge61uErSfzOZKWw2Q85oFoJ9r+V4t6FzsXmLMe8zOdosmLdzeUvpjv
         U9bw==
X-Gm-Message-State: AOAM530g6askmuqXSsm12+wt9JiPH16Jw1w9uabSsEBg0VRVRRY9e56h
        cRqoWkf/kLdsVO0FDBoHKyEzShiiCUZINw==
X-Google-Smtp-Source: ABdhPJxTdN4jMqeDrYkOHa81RTp2ULHrEZ3JQfsc27gcaoqkEfeVupaTBe+FLC/qz42cYsMzajM/xA==
X-Received: by 2002:a1c:1941:0:b0:38b:4af1:49f8 with SMTP id 62-20020a1c1941000000b0038b4af149f8mr12570171wmz.156.1647538053901;
        Thu, 17 Mar 2022 10:27:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b001e669ebd528sm4690693wrw.91.2022.03.17.10.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:27:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] refs: designated init & missing debug in ps/fetch-mirror-optim
Date:   Thu, 17 Mar 2022 18:27:14 +0100
Message-Id: <cover-0.5-00000000000-20220317T171618Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I recently submitted a topic[1] to convert various things to
designated initializers Junio (presumably) ejected the refs changes
due to conflicts with ps/fetch-mirror-optim. The rest of the series
was down already in 20d34c07ea4 (Merge branch
'ab/c99-designated-initializers', 2022-03-06)

Now that that series has landed 1-3/5 are those previous patches
re-submitted (with a minor change for the new "read_symbolic_ref").

The 4/5 is then a deletion of packed-backend.c stub functions that I
think are not worth carrying anymore, and which has the fringe benefit
of squashing a noisy warning under SunCC.

5/5 is then a minor fix-up for ps/fetch-mirror-optim: It didn't define
a debug wrapper for refs_read_symbolic_ref(). Now that we do we don't
need an implementation that'll ever fall back on
refs_read_raw_ref(). It's now a stand-alone API function without a
fallback (which in effect it was before, sans debug backend).

Aside: It seems that the GIT_TRACE_REFS facility has been broken since
it was added, i.e. running the test site with e.g.:

    GIT_TRACE_REFS=/tmp/log.txt make test

Will fail, and not due to a test being confused about the logs. I
think something in how the iterators are wrapped is confusing it, but
that's a long-standing issue in any case...

1. https://lore.kernel.org/git/cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com

Ævar Arnfjörð Bjarmason (5):
  refs: use designated initializers for "struct ref_storage_be"
  refs: use designated initializers for "struct ref_iterator_vtable"
  misc *.c: use designated initializers for struct assignments
  packed-backend: remove stub BUG(...) functions
  refs debug: add a wrapper for "read_symbolic_ref"

 attr.c                |   2 +-
 notes-merge.c         |   1 +
 object-file.c         |   9 +--
 refs.c                |  13 +----
 refs/debug.c          |  82 ++++++++++++++++++---------
 refs/files-backend.c  |  64 ++++++++++-----------
 refs/iterator.c       |  18 +++---
 refs/packed-backend.c | 128 ++++++++++--------------------------------
 refs/ref-cache.c      |   6 +-
 9 files changed, 135 insertions(+), 188 deletions(-)

-- 
2.35.1.1384.g7d2906948a1

