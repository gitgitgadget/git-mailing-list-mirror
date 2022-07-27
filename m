Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EAEC3F6B0
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 23:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiG0XN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 19:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiG0XNy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 19:13:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE774D4C5
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:13:52 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so1692780wme.0
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=nnwUuz/jM4EM0NrDNxFRIEvdzFM+Qfdq5gD/PCOeC18=;
        b=dHVzDPMl9SP2pCyVVSFjRlrkPkG2tvTYcn2tkn0bXZ+FiSnURR9qZ02v5nr+S/v2VM
         6WnNg+kl5IZMUrDanJgfzxoR0rW9vj8MYPYqVp6iZpXM2eyIm6QC9CIqUhA0wxPqzDTH
         fZAahl+l61fqwgtzNjAR1NYlZ5A0v5NUxEZ/yarAP5P43aDz2prvgjeQhe6ezgi11CJB
         RwzyN4eMUpQWjVISMS1RkmAYF8qne801BsH+5X8dten2obZ+PLIrChRshEVw1QRj4fAV
         /FOHNQ/3qA/pS9tfLPCP4c5m+I2CsrxhTM8J/xLcHYgIHzVFqxi52j6D27Nowmjwyy/k
         TUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nnwUuz/jM4EM0NrDNxFRIEvdzFM+Qfdq5gD/PCOeC18=;
        b=XIBr/k0BthG+UhMFGoV64WkDU4g9ku4vwFBmekvEIzAINpZfsuJ0v7gW3lsf6tUYZv
         bcz0cODFEYi0ihvbfHndLD2t6tTHUh9Fmf4L2xCqvr7pAvZaqLLsOoYbP0gA7EdaQj4l
         VCSJKPaaaF1XIyBgFkkGdtC3HGTgNUD6C0CkjNiiImA2pyGXwzabWs1qhd1vi5K0XkNU
         Qhyoek0XdZTI6NtRkYV98BDtsxYws2MBiJ/FFp/go+Ok3YvQQ2z6vbxt/bwII09Kl0rT
         U5N3FgQl+l23cJApl6O2JQynHREmgzpxb3d5tSbkgqC6pTCM0bDNAeHBdcepd6ZNTuZk
         Z6YQ==
X-Gm-Message-State: AJIora97chOFhZT8rt4pTFdb06ebvy+bXJa161zwyBnqWbuGaeYOt/IW
        aoBleMSuSwoK0xcsrUq5ZUDg3gvetQkE9A==
X-Google-Smtp-Source: AGRyM1sSUYWyTyEm2wAUTo2bnJtjE2PCP6QB38ScwK/MQb8PlgPLeLKE3U5B3AGbN2Wa0+gMI983jA==
X-Received: by 2002:a05:600c:1d06:b0:3a3:19ee:6963 with SMTP id l6-20020a05600c1d0600b003a319ee6963mr4740685wms.89.1658963630614;
        Wed, 27 Jul 2022 16:13:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z3-20020adfec83000000b0021dd08ad8d7sm1692806wrn.46.2022.07.27.16.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 16:13:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/15] test-lib: don't set GIT_EXIT_OK before calling test_atexit_handler
Date:   Thu, 28 Jul 2022 01:13:30 +0200
Message-Id: <patch-v3-02.15-242f3c9ed20-20220727T230800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1127.g4ecf1c08f67
In-Reply-To: <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
References: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the control flow in test_done so that we'll set GIT_EXIT_OK=t
after we call test_atexit_handler(). This seems to have been a mistake
in 900721e15c4 (test-lib: introduce 'test_atexit', 2019-03-13). It
doesn't make sense to allow our "atexit" handling to call "exit"
without us emitting the errors we'll emit without GIT_EXIT_OK=t being
set.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3f11ce35112..c8c84ef9b14 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1169,12 +1169,12 @@ test_atexit_handler () {
 }
 
 test_done () {
-	GIT_EXIT_OK=t
-
 	# Run the atexit commands _before_ the trash directory is
 	# removed, so the commands can access pidfiles and socket files.
 	test_atexit_handler
 
+	GIT_EXIT_OK=t
+
 	finalize_test_output
 
 	if test -z "$HARNESS_ACTIVE"
-- 
2.37.1.1127.g4ecf1c08f67

