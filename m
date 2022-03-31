Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BACCC433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352404AbiCaBsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352379AbiCaBsE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:48:04 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1817D483AE
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:46:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h23so31611397wrb.8
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FWPm1hZl3ZbDhuZ3mmAEZqAjvgyays71Cz6AoTt8gvE=;
        b=A1TmPqbwX47i9TlaEtxkmzISOjYHsX8ggRpWWn3VsUJq80MweXu7FndkSsvd32KHfq
         22+0imRRVE4y0z4sYsJSBbcj7krNO64kzc2OsGKQmafYaMHk35p3GHdCfmnr9f99GIhm
         h/PsCOGlHKiJLcNUolHp+yNxB++3c6EA8j/ouHkCfGkGQ1j2LOQIYaTPc1aTOnokiIJ2
         7RX2lnmE0pszVo9TgApm0LTmckzlXbR9eeA7FpKh+WX+Nh8jHNCC8fOAHIbi7fam9/gZ
         AndZ4WHE9tAwZCgGsQgeJ6D/45C+dFQRdqSUoH/untOLwm5vZB2zyXoAZzT1lJ9bKGSy
         C+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FWPm1hZl3ZbDhuZ3mmAEZqAjvgyays71Cz6AoTt8gvE=;
        b=IeAeSH7aUrzznV8pS6za646lbSySuGiEywWSLGiMwWLEneFGQUYHOy2ZJDl3mEZ5Cu
         EfF3pYl3phX4j7vQ892vfbG1MI4EIglDB9dJbXIUqkbpEuC85HD5uy0PO6HfdDYGSigZ
         jVadEDCyAdYr2b5gdZMAvHr0terwd65EzntbwpjB/JzAmEZYw38v7e5/VcG38qRJ7+dI
         QG3Gjd1nV0U4W/EB1txVz97YwIyS0K+NOr3kvlaVUHni3JHy4vIcayZjc4pd+ZVPQCmo
         m6jiy1bQ5y+pa3QvCvF+rKog5Lyg/nK2I7OttrVVeRPWr2IwbdwEEFD2gbYF7CQTaF4y
         oCWA==
X-Gm-Message-State: AOAM533MAU4+FOwOOnfvbyvrqWynlyUsYCkjLHqB4gYjV/x9pG9B/hOC
        BXBDPJpUWL/zkl3lUs6ZzXfBe3P7Yeohcw==
X-Google-Smtp-Source: ABdhPJz7qoeZhmsIlumX08gFuPHSnK4mF8iet1IccQKwbMTj0tuQVUAUH2PS2JCjwkZbsHZFueBG/w==
X-Received: by 2002:a05:6000:239:b0:204:101:8fdd with SMTP id l25-20020a056000023900b0020401018fddmr2058729wrz.267.1648691170340;
        Wed, 30 Mar 2022 18:46:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020a05600018af00b002057c72d45fsm23603272wri.77.2022.03.30.18.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:46:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/6] various: remove dead code
Date:   Thu, 31 Mar 2022 03:45:49 +0200
Message-Id: <cover-v4-0.6-00000000000-20220331T014349Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1561.ge8eddc63765
In-Reply-To: <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
References: <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This v4 drops the last patch of the v3. I'll address git-sh-i18n.sh in
some future topic, the rest of these should all be uncontroversial.

Ævar Arnfjörð Bjarmason (6):
  run-command.h: remove always unused "clean_on_exit_handler_cbdata"
  configure.ac: remove USE_PIC comment
  xdiff/xmacros.h: remove unused XDL_PTRFREE
  pack-bitmap-write: remove unused bitmap_reset() function
  object-store.h: remove unused has_sha1_file*()
  alloc.[ch]: remove alloc_report() function

 alloc.c                                       | 21 -------------------
 alloc.h                                       |  1 -
 configure.ac                                  |  3 ---
 .../coccinelle/the_repository.pending.cocci   | 15 -------------
 ewah/bitmap.c                                 |  5 -----
 ewah/ewok.h                                   |  1 -
 object-store.h                                |  4 ----
 run-command.h                                 |  1 -
 xdiff/xmacros.h                               |  1 -
 9 files changed, 52 deletions(-)

Range-diff against v3:
1:  bac78566135 = 1:  fc55b203474 run-command.h: remove always unused "clean_on_exit_handler_cbdata"
2:  93dc689e1aa = 2:  f6125e9f62a configure.ac: remove USE_PIC comment
3:  05adde5b9e4 = 3:  cf54976bbc4 xdiff/xmacros.h: remove unused XDL_PTRFREE
4:  6bd89f3cf42 = 4:  a9b71c281c2 pack-bitmap-write: remove unused bitmap_reset() function
5:  cf7969f8f67 = 5:  69d32330716 object-store.h: remove unused has_sha1_file*()
6:  b60a4c24a28 = 6:  f477389c275 alloc.[ch]: remove alloc_report() function
7:  7a82b1fd005 < -:  ----------- git-sh-setup: don't mark trees not used in-tree for i18n
-- 
2.35.1.1561.ge8eddc63765

