Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3BBC6379F
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 07:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjASHYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 02:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjASHX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 02:23:58 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC428618B8
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 23:23:47 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id jm10so1487188plb.13
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 23:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ad/IKfv7FjYl4PDudB6T0RH72O4CtPQNIfwepctJRgE=;
        b=OK/42hRhoO838yW02jhbO8pCyRuI8o9CWCGlUvQp5va1AiVwhLO5IjT009b7ZgTYyW
         ELY9GctKcvXe6RsroiWaF0CarXdZWfOWNjiKVYhC6n4SUW1VnkYbdWbt/nSlec8GNpWv
         jZM5x0gkISe8zzn3Mn7oEn9QAoYmg+VvAYX36ExPDpdW00njjFkC/lkTDDZsi5fepmz7
         WcAEov9uhEd/bnV2cBlcPk8AhsSgTSRbWNDKEcrQT8DzDK2W8TVqOKM+sg80+fWcai4p
         GZocANgdOevtyuisxX3lmuLfjgGzm88vPY4TWXvsuMahz32tiLYGaOT5eNEwROYz9FGR
         kn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ad/IKfv7FjYl4PDudB6T0RH72O4CtPQNIfwepctJRgE=;
        b=g8G2ovBb8FdKBsMgX9GZIyqDMADF7q1PqW7qHAR6uYO5bo99rkOWrz9BS3Z5xpwmZL
         K5j7LDhOP33Rxoy67/wNKn7aV0T/LbE31pY4ergSgFmdEh4JuTFsclWCPHTFqRQgbOc/
         ZXtwF9UKM9gz7K2eGNbVHEpvu2YLiPNAkN+zmljdlDg8Lo4kRkDzldDXM8XY5yJgr8z5
         NMtO6hdfAdMplgeAk3ZT3+EdAGeNeklLEWQKnaLOPHRdNpF3dbG1QVrZX/wLUgYULMU1
         OPpvmFdE248OaRwzzaW2uqXK21lrhgBkdWbfFz/U94proFeAuMJI4vkgTbhH3/cnVSly
         JEFg==
X-Gm-Message-State: AFqh2kqw5G8a8BD+/LJSHWqmmEGCnWVGc7rZBuB7e4HRfKo9kEvps/mq
        Id1oCwHDj1GVWijhLlp3Tvo=
X-Google-Smtp-Source: AMrXdXtmbS4cjkxKLgI0xdotQSnpgpFXwPk35xg+AodSpG9MPBDo3ictiLvRSYsQCT5bIt8gL6BoaA==
X-Received: by 2002:a17:902:ec82:b0:193:3215:960a with SMTP id x2-20020a170902ec8200b001933215960amr14513507plg.33.1674113027071;
        Wed, 18 Jan 2023 23:23:47 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b001930b7e2c04sm21272684pli.287.2023.01.18.23.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 23:23:46 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Jinwook Jeong <vustthat@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re* [PATCH v3] checkout/switch: disallow checking out same branch
 in multiple worktrees
References: <20230118061527.76218-1-carenas@gmail.com>
        <20230119055325.1013-1-carenas@gmail.com>
Date:   Wed, 18 Jan 2023 23:23:46 -0800
In-Reply-To: <20230119055325.1013-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 18 Jan 2023 21:53:24 -0800")
Message-ID: <xmqqa62f2dj1.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:

> Changes since v2
> * A leak free implementation

> * More details in commit as suggested by Junio

I meant to say we may need more details in the documentation, but
after reading the existing documentation, we say that

 - "-B <name>" is equivalent to run "branch -f <name>", which is
   sufficient to hint that it will fail to recreate and check out an
   existing branch that is checked out elsewhere, because "branch
   -f" would fail in such a situation.

and that

 - "--ignore-other-worktrees" defeats the safety that makes "git
   checkout refuses when the wanted ref is already checked out".

so the existing documentation of "git checkout" may already be OK.

As long as it is well known that "git branch -f" still fails in the
situation, that is.  After re-reading "git branch --help" twice,
however, I am not sure if it is so clear, though.

How about adding something like this, as an independent
documentation improvement?

----- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] branch: document `-f` and linked worktree behaviour

"git branch -f name start" forces to recreate the named branch, but
the forcing does not defeat the "do not touch a branch that is
checked out elsewhere" safety valve.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-branch.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git c/Documentation/git-branch.txt w/Documentation/git-branch.txt
index aa2f78c4c2..b12e7940d3 100644
--- c/Documentation/git-branch.txt
+++ w/Documentation/git-branch.txt
@@ -123,6 +123,10 @@ OPTIONS
 	points to a valid commit. In combination with
 	`-m` (or `--move`), allow renaming the branch even if the new
 	branch name already exists, the same applies for `-c` (or `--copy`).
++
+Note that 'git branch -f <branchname> [<start-point>]' refuses to change
+an existing branch `<branchname>` that is checked out in another worktree
+linked to the same repository.
 
 -m::
 --move::
