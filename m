Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C326C433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 23:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359605AbiELXnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 19:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359607AbiELXnr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 19:43:47 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2914E28AB8E
        for <git@vger.kernel.org>; Thu, 12 May 2022 16:43:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so3856314wme.3
        for <git@vger.kernel.org>; Thu, 12 May 2022 16:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s6mAAFAjova36jeVuNp1f4ouBVDKYHmolLXPxF09+Eg=;
        b=KHSbg9nSSSdE/uFkBbMVzydw7nqbkMehJwO7HVYRD5UEeLLtUgaOMExm9edxLC+oV4
         fjB2qc2UVFVHTJcUXOIZIjKABtIP7dyf/ErbbXcaK6B0B3JiXlnHWI3eoSbG/xxYdOvB
         Rr3c9YmzqePggkbdz/N3EuIa5CcPn4x0P6zTv0JaTDDtx0uMyU3yH+8moEp77KNkUk4p
         +lg6IaV+iIGblyRTP1Y9BLZL8fMeNajLIP+suriXEEYZOUcf+f+qiS2J4LYQS6at38Tf
         XD1k5iV1YbJ6Y2ZcfLDgAXG2/atpsnbAyHZAjoZ3iVvUbVxgVKBIKT1KGBRoPQDJlaB5
         fYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s6mAAFAjova36jeVuNp1f4ouBVDKYHmolLXPxF09+Eg=;
        b=xv8Zg6Od3ZzUgXgbBgNCczvLw6G1KFS3qMojSL1oMudwCnjE6hGjnRTPjTY+Qu1Chv
         FDKl5lqxPN6XMWVO3bOCQkbyQ+o4+ggyYnpFD4zg/VHnyMpupIfXnlvJH9RVbXvxLdgq
         twNvjQ1slA/XvQRLQ6Tf018Qag2e2Zy7Drj/powbIVHQSOfgNvs5sJWMch7esSzFRHew
         KXECBhuUBVY/O2s17hxafpsF1YqVV78IjlDI9JW07KLzKO1C0V8mU9yqiD3jWHCSoYiV
         yDVw6U1E3DseaD54wm63mg6cl8PhLyYAtjFLfmR9crk5gabzLrnWyIU9wi5LX2wJUSY2
         W3ig==
X-Gm-Message-State: AOAM530VLlzrxPFjmlBIVeN1Xsx8g5f9uRiimdgLAM2301nErvYZJda+
        iM3CrtkMdQYIOVU+v8VpkeYYYwMLxxw=
X-Google-Smtp-Source: ABdhPJzYVhEXMdUyCWb8PsRYDyZ1Tx+F8hoGo31gSNoLobCK1Mj8aw/Qo5SRm87kbgktsQN+hRu8fA==
X-Received: by 2002:a05:600c:1d18:b0:394:6469:abec with SMTP id l24-20020a05600c1d1800b003946469abecmr1914000wms.89.1652399024226;
        Thu, 12 May 2022 16:43:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j32-20020a05600c1c2000b00394832af31csm4236051wms.0.2022.05.12.16.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 16:43:43 -0700 (PDT)
Message-Id: <76bcb6612e40aa3d5244658f9ff90f453222836a.1652399017.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v3.git.1652399017.gitgitgadget@gmail.com>
References: <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
        <pull.1226.v3.git.1652399017.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 May 2022 23:43:37 +0000
Subject: [PATCH v3 5/5] MyFirstContribution: drop PR description for GGG
 single-patch contributions
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

By default, GitHub prefills the PR description using the commit message
for single-commit PRs. This results in a duplicate commit message below
the three-dash line if the contributor does not empty out the PR
description before submitting, which adds noise for reviewers.

Add a note to that effect in MyFirstContribution.txt.

This partly addresses:
https://github.com/gitgitgadget/gitgitgadget/issues/340

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/MyFirstContribution.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 9eb2dfec959..1da15d9ad44 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -904,6 +904,16 @@ respectively as the subject and body of the cover letter for your change. Refer
 to <<cover-letter,"The cover letter">> above for advice on how to title your
 submission and what content to include in the description.
 
+NOTE: For single-patch contributions, your commit message should already be
+meaningful and explain at a high level the purpose (what is happening and why)
+of your patch, so you usually do not need any additional context. In that case,
+remove the PR description that GitHub automatically generates from your commit
+message (your PR description should be empty). If you do need to supply even
+more context, you can do so in that space and it will be appended to the email
+that GitGitGadget will send, between the three-dash line and the diffstat
+(see <<single-patch,Bonus Chapter: One-Patch Changes>> for how this looks once
+submitted).
+
 When you're happy, submit your pull request.
 
 [[run-ci-ggg]]
-- 
gitgitgadget
