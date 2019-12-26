Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD9BC2D0DA
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 17:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3C2206CB
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 17:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1H7+XsP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfLZRnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 12:43:41 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39888 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfLZRnk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 12:43:40 -0500
Received: by mail-ed1-f66.google.com with SMTP id t17so23235492eds.6
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 09:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EymN584Bi9uDOyoL88+AKCmCtrzV5rPmokQIcI1Ewa4=;
        b=D1H7+XsP2PwvcX1/E0lHANpXrgeJLPorVhbXCkdl13wEYEouoXPm8/U+i0cVA1SFUZ
         ewAXW6YqzpsEGgkifkR/1l0sgwm2oSPKnqUKtUN+/Y/9/cH9UJCPoDASL1XMFY9HfNbX
         Kd3+5Iqb8G3k8xwXX+hf9fm1EUg9bjArGJJhzcM+KhZ8S6Bp9hEd5XC5lT0OqGJ6mb3v
         vaIxii+yZ/wrjHEPxhGbaNuHon21Aqq/X1krYfSSb3KaGTSknAfGHtTSRz+X+xWzmlmB
         mxlAV3WeS5weQDZeIZnTXidPtSnJgD2qOLkGDsLE0z707zpL5wnKVfVrfjwnxb30Vvad
         sx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EymN584Bi9uDOyoL88+AKCmCtrzV5rPmokQIcI1Ewa4=;
        b=I7mUVZthJAGT0a7bCNrTsMCbyYvi0UKJuHZp7H5aJl1xPzxZnx3+cYjglLgX0qwmbu
         qArvwcND0Y7mLBvoVVxwg1sUZWog4ZyZ6ma3Fz16vfRRwrJkMFiEAfoXq3NhLL/hK1E1
         c6qdQfSnKSsCLhSdtB49XLvX3zcLL51jXfAMTQADcJoDQQo4E1zvc6Xza3orPLxAeUQX
         AzQWQqb7tYYaOTRCHqQrQLWtnxxa8Iso328R+aocZQfWxk11N7Gi+uoo4dGNkMGAxJ5q
         tki2c6rQboo10UKRDUnxLZi3z7csvMhfnCnwUJ6OFiGdvCIZkitYMW3E4GG6XEEFOs3e
         /EiA==
X-Gm-Message-State: APjAAAUwHT680Ik8Mz3GDHVM+TVIDsxw+DFcwIbx7PGWSpz1MNdy4SYn
        +WTgAl70ntaYe92SJbedfXkt+d+C
X-Google-Smtp-Source: APXvYqwkpj2LxhWB798Wv5mn23D+Di9nxfAt8nTGY6dkCVdhrbeJZAEWjtnd50Ml9UYV0S8HZNedhw==
X-Received: by 2002:a50:f38e:: with SMTP id g14mr50278337edm.168.1577382218219;
        Thu, 26 Dec 2019 09:43:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y19sm3756687ejw.65.2019.12.26.09.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Dec 2019 09:43:37 -0800 (PST)
Message-Id: <pull.494.v2.git.1577382217.gitgitgadget@gmail.com>
In-Reply-To: <pull.494.git.1576559263.gitgitgadget@gmail.com>
References: <pull.494.git.1576559263.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Dec 2019 17:43:35 +0000
Subject: [PATCH v2 0/2] Improve line log documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two patches add more information to the documentation for line history
(git log -L) : 

 * Mention explicitly that only the --patch and --no-patch diff formats are
   supported 
 * Mention that parameters <start>, <end> and <funcname> must exist in the
   starting revision

Regarding point 2 : I stumbled upon this while reading the history of
'filter_refs' in fetch-pack.c. I did

    git log -s -L :filter_refs:fetch-pack.c

which shows a list of commits starting with 745f7a8cac (fetch-pack: move
core code to libgit.a, 2012-10-26). So then I did

    git log  -s -L :filter_refs:fetch-pack.c -L :filter_refs:builtin/fetch-pack.c

which fails with

    fatal: -L parameter 'filter_refs' starting at line 1: no match

Changes since v1:

 * Shorten the commit titles
 * Use long options names for --patch and --no-patch
 * Remove inexact mention of --function-context
 * Reword the clarification regarding <start>, <end> and <funcname> so that
   it doesn't apply only to regex parameters
 * Also add this clarification to Documentation/gitk.txt since it applies
   there as well

Philippe Blain (2):
  doc: log, gitk: document accepted line-log diff formats
  doc: log, gitk: line-log arguments must exist in starting revision

 Documentation/git-log.txt | 8 ++++++--
 Documentation/gitk.txt    | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)


base-commit: ad05a3d8e5a6a06443836b5e40434262d992889a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-494%2Fphil-blain%2Fline-log-doc-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-494/phil-blain/line-log-doc-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/494

Range-diff vs v1:

 1:  0ed04a8629 ! 1:  e68ef0ced3 Documentation/git-log: document accepted line-log diff formats
     @@ -1,18 +1,16 @@
      Author: Philippe Blain <levraiphilippeblain@gmail.com>
      
     -    Documentation/git-log: document accepted line-log diff formats
     +    doc: log, gitk: document accepted line-log diff formats
      
          Currently the line-log functionality (git log -L) only supports
     -    displaying patch output (`-p`, its default behavior) and suppressing it
     -    (`-s`). A check was added in the code to that effect in 5314efaea (line-log:
     -    detect unsupported formats, 2019-03-10) but the documentation was not
     +    displaying patch output (`-p | --patch`, its default behavior) and suppressing it
     +    (`-s | --no-patch`). A check was added in the code to that effect in 5314efaea
     +    (line-log: detect unsupported formats, 2019-03-10) but the documentation was not
          updated.
      
          Explicitly mention that `-L` implies `-p`, that patch output can be
          suppressed using `-s`, and that all other diff formats are not allowed.
      
     -    Additionnally, mention that the ':<funcname>' form implies `--function-context`.
     -
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
       diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
     @@ -24,8 +22,7 @@
       	give zero or one positive revision arguments.
      -	You can specify this option more than once.
      +	You can specify this option more than once. Implies `--patch`.
     -+	If ``:<funcname>'' is given, implies `--function-context`.
     -+	Patch output can be suppressed using `-s`, but other diff formats
     ++	Patch output can be suppressed using `--no-patch`, but other diff formats
      +	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
      +	`--name-only`, `--name-status`, `--check`) are not currently implemented.
       +
     @@ -41,8 +38,7 @@
       	give zero or one positive revision arguments.
      -	You can specify this option more than once.
      +	You can specify this option more than once. Implies `--patch`.
     -+	If ``:<funcname>'' is given, implies `--function-context`.
     -+	Patch output can be suppressed using `-s`, but other diff formats
     ++	Patch output can be suppressed using `--no-patch`, but other diff formats
      +	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
      +	`--name-only`, `--name-status`, `--check`) are not currently implemented.
       +
 2:  4ea4eeae0c ! 2:  c7d489794c Documentation/git-log: mention that line-log regex must match in starting revision
     @@ -1,10 +1,10 @@
      Author: Philippe Blain <levraiphilippeblain@gmail.com>
      
     -    Documentation/git-log: mention that line-log regex must match in starting revision
     +    doc: log, gitk: line-log arguments must exist in starting revision
      
     -    When giving a regex as parameter <start> or <end> in
     -    `git log -L <start>,<end>:<file>`, or a function name in
     -    `git log -L :<funcname>:<file>`, the given regex must match in the starting
     +    The line number, regex or offset parameters <start> and <end> in
     +    `git log -L <start>,<end>:<file>`, or the function name regex in
     +    `git log -L :<funcname>:<file>` must exist in the starting
          revision, or else the command exits with a fatal error.
      
          This is not obvious in the documentation, so add a note to that
     @@ -20,8 +20,22 @@
       	not give any pathspec limiters.  This is currently limited to
       	a walk starting from a single revision, i.e., you may only
      -	give zero or one positive revision arguments.
     -+	give zero or one positive revision arguments, and any given regex for
     -+	<start> or <end> (or <funcname>) must match in the starting revision.
     ++	give zero or one positive revision arguments, and
     ++	<start> and <end> (or <funcname>) must exist in the starting revision.
       	You can specify this option more than once. Implies `--patch`.
     - 	If ``:<funcname>'' is given, implies `--function-context`.
     - 	Patch output can be suppressed using `-s`, but other diff formats
     + 	Patch output can be suppressed using `--no-patch`, but other diff formats
     + 	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
     +
     + diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
     + --- a/Documentation/gitk.txt
     + +++ b/Documentation/gitk.txt
     +@@
     + 	(or the function name regex <funcname>) within the <file>.  You may
     + 	not give any pathspec limiters.  This is currently limited to
     + 	a walk starting from a single revision, i.e., you may only
     +-	give zero or one positive revision arguments.
     ++	give zero or one positive revision arguments, and
     ++	<start> and <end> (or <funcname>) must exist in the starting revision.
     + 	You can specify this option more than once. Implies `--patch`.
     + 	Patch output can be suppressed using `--no-patch`, but other diff formats
     + 	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,

-- 
gitgitgadget
