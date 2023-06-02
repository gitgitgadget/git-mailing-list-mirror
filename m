Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96F2C7EE2A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 02:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjFBCb0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 22:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjFBCbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 22:31:25 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A963B194
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 19:31:23 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53482b44007so962517a12.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 19:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685673083; x=1688265083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4A+84/SxPcNeAfquDx3w8qZXhfX1JlrEBXNgjfIw1U=;
        b=O3C8Le1M8agafz9dZoqpN/pZ0cg2OcAeQcHnnajNHHPixJjtERS7zKdHxFjfNmj2cI
         TKPZ4IwEHWYSV8XFJuFa+/YRVt6x7darrW8Y17p9Z27CrfnS236usOaOLC2cKM13956S
         /7sE11686sW2JiFNplzAxZNYu+aM1rbiaU5kCH3UZKdlGT9zzN9cxr14pENmUgNw/mLS
         kAOxh+A5mQp3lJuB8hF3ovrFmqhnpZZ3gTNBXGAdMfaY/QasXFK9HIABblTK7A2up418
         R94N4/EzfI3/6TfCbieM3DLoshhwKMtKnjQgx+R9xkZW6jCL7hkifmGvpVF44qq53EEJ
         zvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685673083; x=1688265083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4A+84/SxPcNeAfquDx3w8qZXhfX1JlrEBXNgjfIw1U=;
        b=id8r7i7aoDE1aOBj5kpYo1+YM+551HT3V4TPPtEv20S80tAJJPphnh+gZso3XOEZmp
         qX2kKxTTZw4Ta3nAhc+3eWis02G8YiCAAuibU+JLHK7ef8Arfpo4QCcocSAMeULrNvsT
         GgZPOmNV5wXG4NPrDhnKMLK6UmbBV+o8RCSG+psk+Z4hsk4bJmubaUQqEqPseki1kRgE
         zwV51Ct1RW+ZJ+QZmaLvTvzPGxajPwYC9QL5uFTCd1TgK7g1cm0esnYBhNtBD2d8QFi+
         ZMCo9AqMINbDrkUQalmfuOHzetRDodqhPs6E8K6/OvSdhi7uWXS2kxbqP8xwcnHHvOXQ
         cNmg==
X-Gm-Message-State: AC+VfDy/RZWrMiKJUTW5YVuZYqoh6pRuamgqHK41szvA4VBjtkyVNk1Q
        9BvRWoHKQT5VWTYumMbbUzNYRWuiVoVRLw==
X-Google-Smtp-Source: ACHHUZ4gtOtB4Q+5cSoaom7u5qKFIT2XErR0NVPsqYHpEI6Y76Ax6ccUWRGCWn6w+7y7y/z+zJTqpQ==
X-Received: by 2002:a05:6a20:6a27:b0:110:32ba:33c3 with SMTP id p39-20020a056a206a2700b0011032ba33c3mr9812942pzk.57.1685673082628;
        Thu, 01 Jun 2023 19:31:22 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.144.109])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b001b0395c4002sm71251plg.210.2023.06.01.19.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 19:31:22 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH v2 0/2] Add new "signature" atom 
Date:   Fri,  2 Jun 2023 07:41:53 +0530
Message-ID: <20230602023105.17979-1-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230529192209.17747-1-five231003@gmail.com>
References: <20230529192209.17747-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks for the review.

Changes since v1:

    PATCH 1/2 -
	Changed the condition so that prereq GPG2 will only fail
	if we have GPG v0.* or v1.* instead of failing when we
	don't have v2.* (this will have an effect if in the future
	GPG v3.*, v4.* were introduced).

    PATCH 2/2 -
	Renamed the setup tests to be more clear about their purpose.

    Common to both the patches is the change where we introduce a
    newline to a file. Use "echo >" instead of "echo "" >".

I have also rebased this to be on top of v2.41.0, the previous version
was on top of v2.41.0-rc0.

Range-diff against v1:

1:  5c97d11b79 ! 1:  87465ef1a8 t/lib-gpg: introduce new prereq GPG2
    @@ t/lib-gpg.sh: test_lazy_prereq GPG '
     +  test $? != 127 || exit 1
     +
     +  case "$gpg_version" in
    -+  !"gpg (GnuPG) 2."*)
    ++  "gpg (GnuPG) 0."* | "gpg (GnuPG) 1.*")
     +          say "This test requires a GPG version >= v2.0.0"
     +          exit 1
     +          ;;
    @@ t/t7510-signed-commit.sh: test_expect_success GPG 'amending
already signed commi
      
     +test_expect_success GPG2 'bare signature' '
     +  git verify-commit fifth-signed 2>expect &&
    -+  echo "" >>expect &&
    ++  echo >>expect &&
     +  git log -1 --format="%GG" fifth-signed >actual &&
     +  test_cmp expect actual
     +'
2:  e89f14283d ! 2:  690869aa47 ref-filter: add new "signature" atom
    @@ t/t6300-for-each-ref.sh: test_expect_success 'git for-each-ref
with non-existing
     +GRADE_FORMAT="%(signature:grade)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
     +TRUSTLEVEL_FORMAT="%(signature:trustlevel)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
     +
    -+test_expect_success GPG 'setup: signature gpg' '
    ++test_expect_success GPG 'setup for signature atom using gpg' '
     +  git checkout -b signed &&
     +
     +  test_when_finished "test_unconfig commit.gpgSign" &&
    @@ t/t6300-for-each-ref.sh: test_expect_success 'git for-each-ref
with non-existing
     +  git tag seventh-unsigned
     +'
     +
    -+test_expect_success GPGSSH 'setup: signature ssh' '
    ++test_expect_success GPGSSH 'setup for signature atom using ssh' '
    ++  test_when_finished "test_unconfig gpg.format user.signingkey" &&
    ++
     +  test_config gpg.format ssh &&
     +  test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
     +  echo "8" >file &&
    @@ t/t6300-for-each-ref.sh: test_expect_success 'git for-each-ref
with non-existing
     +  grep -Ev "checking the trustdb|PGP trust model" out.raw >out &&
     +  head -3 out >expect &&
     +  tail -1 out >>expect &&
    -+  echo "" >>expect &&
    ++  echo  >>expect &&
     +  git for-each-ref refs/tags/first-signed \
     +          --format="%(signature)" >actual &&
     +  test_cmp expect actual

Kousik Sanagavarapu (2):
  t/lib-gpg: introduce new prereq GPG2
  ref-filter: add new "signature" atom

 Documentation/git-for-each-ref.txt |  27 ++++
 ref-filter.c                       | 111 ++++++++++++++++-
 t/lib-gpg.sh                       |  21 ++++
 t/t6300-for-each-ref.sh            | 191 +++++++++++++++++++++++++++++
 t/t7510-signed-commit.sh           |   7 ++
 5 files changed, 355 insertions(+), 2 deletions(-)

-- 
2.41.0

