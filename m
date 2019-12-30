Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88488C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 15:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BD9206DB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 15:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXtr9092"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfL3P5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 10:57:03 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38370 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfL3P5D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 10:57:03 -0500
Received: by mail-ed1-f67.google.com with SMTP id i16so32956325edr.5
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 07:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=mos5RHVYAZaA1DWdCUQ4+JkM6GsAkN6MV3Nljd/CWFQ=;
        b=nXtr9092KoX6vWZcbvi4Ffxw+49No9ivxsmSYTQxukuogf+XPBBBKl2iRGcqqFXKmd
         d2oZvSR6GopoPygWl10YxsJutCXsC4bSNsS3nMh7m8/ZavOFWwbYB1gAXaPfOhjZPxSs
         eCTOSkJrRhCZSG7qXQE8Y+1NYP06PFRunnt34OhnAoACUS4fQm2ojdVox06vPsE0jgCL
         wbtVDurNO3iYLEZIcu/pv2AXmfKAJvstv6oW1L9xhVYxlGpexAioYCp8qGoEacmQed+b
         c33hi3gNy1iiplDuwv4HUgwwSQq+x1VZFmUlfFhAE5ZFgB+zMlESNo8ozbowq4HS7VBb
         +2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=mos5RHVYAZaA1DWdCUQ4+JkM6GsAkN6MV3Nljd/CWFQ=;
        b=ZkvqJxOY/T5+eOPX4wUp0ZCflj0EfDAIv1IosSi3DkGJTNeK/YHqdz3w3TnX5G0CMZ
         TkCSg1IsLGj/seYLCfT7pKYqVjwCG/HWW4kOGjdC/CQxp/U7h/pWIiNsNrwSMaLnXZPj
         DnXuQxVQdBTUb/fUobUKxKr9H5sLGKqERg85UNkarc24NrZ2Z6pH3qFbYhK1W/WrASXH
         LJCw8o87M7qQ2ymcLQ1RAGI4VdmAKOjD1RwbWMqaHA4Ld99LilKLIDszlOxOLgYeFW6U
         k594v8KkzIbrRSM4q/IgNJyARZBjdny5XRN8XXr6FLOiekqDX10lC2dAA63Z2a9J6xLd
         rfxg==
X-Gm-Message-State: APjAAAVP9R2Nysg5pxWt9f7p4clZVAxvBj1WRD08ytZgFTfRo8rNwgAa
        pLBNXKLKdvC90UVoSuuNL5PzYpwn
X-Google-Smtp-Source: APXvYqzhjzkYSZKkgACw84URZ7gbAdqbKKgYKn8XGIhQUxKylQbWFrTTd5UlUZdcfIGwptTBS8vKtw==
X-Received: by 2002:a17:906:a48:: with SMTP id x8mr72370466ejf.188.1577721421174;
        Mon, 30 Dec 2019 07:57:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bs4sm5364577edb.16.2019.12.30.07.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 07:57:00 -0800 (PST)
Message-Id: <pull.499.v3.git.1577721419.gitgitgadget@gmail.com>
In-Reply-To: <pull.499.v2.git.1577647930.gitgitgadget@gmail.com>
References: <pull.499.v2.git.1577647930.gitgitgadget@gmail.com>
From:   "Zoli =?UTF-8?Q?Szab=C3=B3?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 30 Dec 2019 15:56:58 +0000
Subject: [PATCH v3 0/1] git-gui: allow opening currently selected file
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

...in the default associated app (e.g. in a text editor / IDE).

Many times there's the need to quickly open a source file (the one you're
looking at in Git GUI) in the predefined text editor / IDE. Of course, the
file can be searched for in your preferred file manager or directly in the
text editor, but having the option to directly open the current file from
Git GUI would be just faster. This change enables just that by:

 * clicking the diff header path (which is now highlighted as a hyperlink)
 * or diff header path context menu -> Open;

Note: executable files will be run and not opened for editing.

Signed-off-by: Zoli Szabó zoli.szabo@gmail.com [zoli.szabo@gmail.com]

Zoli Szabó (1):
  git-gui: allow opening currently selected file in default app

 git-gui.sh | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)


base-commit: 23cbe427c44645a3ab0449919e55bade5eb264bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-499%2Fzoliszabo%2Fgit-gui%2Fopen-current-file-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-499/zoliszabo/git-gui/open-current-file-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/499

Range-diff vs v2:

 1:  a6fde256f8 ! 1:  1b2363be72 git-gui: allow opening currently selected file
     @@ -1,8 +1,6 @@
      Author: Zoli Szabó <zoli.szabo@gmail.com>
      
     -    git-gui: allow opening currently selected file
     -
     -    ...in the default associated app (e.g. in a text editor / IDE).
     +    git-gui: allow opening currently selected file in default app
      
          Many times there's the need to quickly open a source file (the one you're
          looking at in Git GUI) in the predefined text editor / IDE. Of course,

-- 
gitgitgadget
