Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF332C433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 01:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240705AbiEKBsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 21:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236703AbiEKBrr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 21:47:47 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EF52228A
        for <git@vger.kernel.org>; Tue, 10 May 2022 18:47:46 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l38-20020a05600c1d2600b00395b809dfbaso110444wms.2
        for <git@vger.kernel.org>; Tue, 10 May 2022 18:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oC9Wo4de6FMpWWlSzFLzca9U6ibPw5mGjGc5kHvqGS4=;
        b=PIMOIZOkiImtgSfO5MdrLbToiNeKRY1pO6jibGmfQS4+ebLAq3sEgi5dwf5MPc3JhI
         bfPH7YF60tfPnvPDUgxFWEUEBK322ja4wvTUa4G1i0tYmORKizq/yZoTfGqVXmDpfDjy
         6yP37mN3favhDhxGTJnX8Iu0ekohsF1TCmMhrKUWqH/ouiJkMLUP1vgV2nr/BdrkOv3k
         UaFLgVwJeZVTsq4YRNM8E1PwJALnRvgIR9sKnopsikc5BUfmM0bqJWEWlrB5azIHE5Fz
         u6PKf0UUsKLYAZ1LDGqvaBmvNmLTX0E0N9lwKCebj1W+KlCClk+ngVISW2/Kt5K/Basu
         J/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oC9Wo4de6FMpWWlSzFLzca9U6ibPw5mGjGc5kHvqGS4=;
        b=Goz6aQv9zAOtQn4sm/JcYQnVDs3G1axEsFsr1/mr0rf3VpR0Yv3kv9TPl2FOX9xWbx
         fVTGEuCwwJBfEd5yH2oB28WWK9FaWTTphM5M0zvlJ2qpy2ZBHF8rDTtWsQyrBVJbSI5h
         Wz03A9OrKTur4ylh5FO9e+DUi0yzJsE5PBi3blr6E/VbWeRzCLC1hNbrn0MFrlwmzftj
         ZletRJ+1ECJX4ibOZ36485RA+IV8rgEvPKOkVySZuM5ZGyJ0GNrbq/W8j0tgcbyjFfLU
         +hM0WKh6gav9ZtF32J1IU4uhaOM0dttnrGsUVDj+G9wDBET/Ns1my2/B9ysfefYHPKnJ
         tb7g==
X-Gm-Message-State: AOAM532RXtBAREWqGJapwC9VX044A/yfCzlBfWrgHXOtiYySK30fUgta
        zCBFg0kbMKR/YY+kPHP9UUBj76vr0/c=
X-Google-Smtp-Source: ABdhPJy53LidrSHbfCMMknKYCcnvuMIujZR0+AubxjdGKTfqkoxRZfZvk33L2yaxbeJBiZfriTfddw==
X-Received: by 2002:a1c:770b:0:b0:394:3fae:ab79 with SMTP id t11-20020a1c770b000000b003943faeab79mr2390105wmi.200.1652233664850;
        Tue, 10 May 2022 18:47:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15-20020a1ced0f000000b003942a244ecbsm697367wmh.16.2022.05.10.18.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 18:47:43 -0700 (PDT)
Message-Id: <f6034b0964b1e8cccd25f47aa01d51753672df31.1652233654.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
        <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 May 2022 01:47:33 +0000
Subject: [PATCH v2 4/5] MyFirstContribution: reference "The cover letter" in
 GitGitGadget section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The "Sending Patches via GitGitGadget" section mentions that the PR
title and description will be used as the cover letter, but does not
explain what is a cover letter or what should be included in it.

Refer readers to the new "The cover letter" section added in a previous
commit.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/MyFirstContribution.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 078b96d674a..728dc437854 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -893,8 +893,12 @@ https://github.com/gitgitgadget/git and open a PR either with the "New pull
 request" button or the convenient "Compare & pull request" button that may
 appear with the name of your newly pushed branch.
 
-Review the PR's title and description, as it's used by GitGitGadget as the cover
-letter for your change. When you're happy, submit your pull request.
+Review the PR's title and description, as they're used by GitGitGadget
+respectively as the subject and body of the cover letter for your change. Refer
+to <<cover-letter,"The cover letter">> above for advice on how to title your
+submission and what content to include in the description.
+
+When you're happy, submit your pull request.
 
 [[run-ci-ggg]]
 === Running CI and Getting Ready to Send
-- 
gitgitgadget

