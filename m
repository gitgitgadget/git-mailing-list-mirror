Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99463C46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 13:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbjAJNPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjAJNP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 08:15:27 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89006736D7
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 05:15:26 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j16-20020a05600c1c1000b003d9ef8c274bso5516208wms.0
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 05:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHxC13MyFotC5MxLeE4I4+HCHPqO4Q1rk2RPC0DEs7o=;
        b=bGrkQbD8R1IAQ+9lDO93PoCE6CuLZk1ZYTEIvHnBpQD52oJvJd+C0v3VgWtIClHBi/
         6n8hUAMb8OZbE5Myije0glFUDb2bl+ZZ1Q308XyDtYfrBRTPnsbdRhGb6lMORUn8RTzE
         936BtrEzZ485hWmY1B+WdJiLYx6TXGUlo3zTCuwCuzaXkl/OSqvtpPqgg0is7DgBio/V
         DlAWx34U/ijr0IjjdWaLX2whJGgrrBDwR60wpbI0SR8rwa/KYIJqG0ha90I+qFY/r5jZ
         qK6PxEtc6zC1qyjEPbtpuzc8+OfBCwv57CEGQcEmyPFd0ICHQsatOJ3qh7+sA8lwVn/a
         sRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHxC13MyFotC5MxLeE4I4+HCHPqO4Q1rk2RPC0DEs7o=;
        b=Z5uP05mC89YytdKhtZ8IM0oPtgorZ5wr7DMcVjcFFn5uSoQhXtm1Ku4JzC7ZdjfDc3
         GbfoHu1mF1GPpE3CNxhFNQCB/2QqVwHdK6sLrWny4qFdNcFr3U+sJRVapnVm59FPQ9Ex
         4+aQpOahaq5mE3ojnUe08OpJWn1BYtTEblsdiCzhgVQyOCyoAj/1MPMvO7BVGaEHTg+3
         pIpw7yo7BLwCTEhLtuMG+cBaXJh3AsSTcfVhSo8B6bLkZqBVqrXzycgqQcTbnW1Cuv3W
         nyMt9rgqybt88z9MJssd4Cz4rrRruoJgo17Y/F/PwQkPX2yM6K8GVyehiaUFuKXHdQFk
         Izfg==
X-Gm-Message-State: AFqh2kpjzTp9YD+YMZkuu+ZLpjLrjcdEkUh9neulc3Kxge0QHKwMSf2T
        bgsRbNlTY7dKgGXoiJzoLEdOmDnCdlc=
X-Google-Smtp-Source: AMrXdXsYaQ54wU25PeTu+UX2+G2D9AU64RE32MzwNRT+likb0bbafjY+kmJ+boUaYKDuEWogl85V4w==
X-Received: by 2002:a05:600c:2155:b0:3cf:b067:4142 with SMTP id v21-20020a05600c215500b003cfb0674142mr48569497wml.4.1673356524907;
        Tue, 10 Jan 2023 05:15:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8-20020a1c7708000000b003d9f00c8f07sm6870460wmi.21.2023.01.10.05.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 05:15:24 -0800 (PST)
Message-Id: <f25c71fd4c31b5c08974b275b3ab23b6c8048fce.1673356522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1456.v2.git.1673356521.gitgitgadget@gmail.com>
References: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
        <pull.1456.v2.git.1673356521.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Jan 2023 13:15:18 +0000
Subject: [PATCH v2 2/5] git-reset.txt: mention 'ORIG_HEAD' in the Description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Erik Cervin Edin <erik@cervined.in>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The fact that 'git reset' writes 'ORIG_HEAD' before changing HEAD is
mentioned in an example, but is missing from the 'Description' section.

Mention it in the discussion of the "'git reset' [<mode>] [<commit>]"
form of the command.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-reset.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 01cb4c9b9c5..79ad5643eed 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -49,7 +49,8 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 'git reset' [<mode>] [<commit>]::
 	This form resets the current branch head to `<commit>` and
 	possibly updates the index (resetting it to the tree of `<commit>`) and
-	the working tree depending on `<mode>`. If `<mode>` is omitted,
+	the working tree depending on `<mode>`. Before the operation, `ORIG_HEAD`
+	is set to the tip of the current branch. If `<mode>` is omitted,
 	defaults to `--mixed`. The `<mode>` must be one of the following:
 +
 --
-- 
gitgitgadget

