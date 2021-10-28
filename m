Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC78C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5611A608FB
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhJ1U72 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhJ1U72 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 16:59:28 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF0BC061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:57:00 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id ay10so2095336qkb.12
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1L8ZWAQ0/DSXqAoSfn4banppSef3gou6TWSGodV7qeY=;
        b=j6PI3k6LqRJykVxKVAan+ez6mC6jrZxQjng/liiB7z5TKSNyo20ryIFk8DgNyuD9/u
         i06yTgCq2fi0OKHAZfZzi7jojL6GqdCb/ldcC94mrANzcJMiGvyLaOSBp3kyNn0F9yKi
         a0GEjG2xiMwfIB373M0PDOhTImuB62nF72PeOH8Mllu6s9B2ZTBqEyocR7JY1Mknc/Pi
         Q/sGWZtfllQXSVOBLlTmRGWYb14XF08PumcRDOva0sKf/cHm7P8CuZEAZYSh+XfXFyPv
         3c99Uh0LW/QAf5gV8tNZqkkQq3QWhRzalx9VskRqGuFw+sMvnuqWELCh5yDuPVRWuLNz
         MKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1L8ZWAQ0/DSXqAoSfn4banppSef3gou6TWSGodV7qeY=;
        b=fsmOEwMDALI/zCF4p0wbGwKJzWetnOZ012icC5N5buYPAIPXosN47Tpo8yXZgylS9m
         BtyhixnfCc1NHHkyqxxmeV/S+nhhrZaGUEZwgmBQFNg43NncfYzKRLai+j/nfxhSZlaC
         bUpX2aVG5N1Zn/mohDaJSQUDycHVxfcPuKURAuyErVD4BY5vt9p6P4QET8BQfNyoeT7y
         y2z36ToJAz/dYU36dFFXRUJxGL9UYciihXqJ/mxRWl5nQqSjbremesD0MB48M6q6U8KT
         D2zMaEUAv9HIt7mLs4LAaQEWkLCnUJihfxXCuZ1/+A85eDNOriLpdmuqRE3noNnlGf2I
         iv/A==
X-Gm-Message-State: AOAM531ika6oNZ99hGRu3itN/6YXOMVKBb0fOYAgJ5wFx6rNePJw3b0u
        mzgfB3JvQOzMYkEblfQN48Vf5ijD6aM=
X-Google-Smtp-Source: ABdhPJx+JbGaAZyMGXXhhg3Vn1xAFSIQWp3AwTwYBgdhALPNLkvYhEuPFp0d8jx7bsylhTyjfT1JYA==
X-Received: by 2002:a05:620a:d85:: with SMTP id q5mr5579673qkl.64.1635454619712;
        Thu, 28 Oct 2021 13:56:59 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id az12sm2626136qkb.28.2021.10.28.13.56.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Oct 2021 13:56:59 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, vtbassmatt@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 0/3] Allow clean/smudge filters to handle huge files in the LLP64 data model
Date:   Thu, 28 Oct 2021 13:56:46 -0700
Message-Id: <20211028205649.84036-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.1155.gbdb71ac078
In-Reply-To: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following series is a fixup to avoid breaking in 32-bit systems; first
patch should be added as a prerequisite with the 2 following able to
apply to the corresponding patch in the original series.

Carlo Marcelo Arenas Belón (3):
  test-lib: add prerequisite for 64-bit platforms
  fixup! t1051: introduce a smudge filter test for extremely large files
  fixup! clean/smudge: allow clean filters to process extremely large
    files

 t/t1051-large-conversion.sh | 4 ++--
 t/test-lib.sh               | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.33.0.1155.gbdb71ac078

