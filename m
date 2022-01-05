Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64665C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 04:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbiAEEUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 23:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiAEEUm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 23:20:42 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE152C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 20:20:41 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id v123so273249wme.2
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 20:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ItlgSiNRT9pt1qx+ki579buxJHtAoR7ipQ3AjAgdRp8=;
        b=DytEAcsVg8td7f24j8m7ky7SMdUM4EqvH8KMbT87Nq/rmPeGy6fyAQrA9fZubjjzYo
         EKMv/hbxzTIJOEnqbRAX2EX8QQoBJWkax+C2GynK7mI3l7wsr6GC6451RAb4VAoc170G
         Jp+1H1BgnKdhSgHfTcs5EUiQI8bZ9+ToGYFZ2kdzoKAtyq7hh39E7UxMczXeBGAd83vm
         a6CDuFBIXzDVbGPoIORQX6JfVSrK63Rrecf/BkCoJ78EQtDnEtYewc42M9VyrQti2KLQ
         5stw7bWG76bjebhsbHrrS0BO4+VMkvwmvtHoDzp4zr+aizRXjfIfF01NRGA6q6L8pCE0
         p0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ItlgSiNRT9pt1qx+ki579buxJHtAoR7ipQ3AjAgdRp8=;
        b=M9NiFF+gpcZSZtIZG7N0C1LlgIortyCf0paHLUaYq2Apzss0Atz7MUbW5gHAhYlmFI
         J2qSbfxV+kM3OhW+VO/SDQxdkHP0i80L+/1hucjsTncTVdaKB2QwTujKJeIJD2m3gHHt
         F9Y0W3s/eyGain+rCdHEYN0c0+uRrAe0Z+HvovuB/pfotqx4ZmsEmNnVOjUfAIo1ZlX5
         6gnPZ1/fTheg0E4+H0H1Ot7od2zYqu/7OwjYEdmYulipXKTTjrLTEYI5TyvGDtBIZTxL
         GB2WxsU39Qs/tERLksappQ79MOkoiZO8/rH9WKoHymREaAZ06JZLbhH7is7V4sShIw7b
         Ne4g==
X-Gm-Message-State: AOAM532qrxLCpf8abw6Qv3lc2Jrt8a/GqrgqBLTF+s4C5g21BA/VJQ1P
        jinTPm1KRni/cdqA4V3McjFxjASr7ow=
X-Google-Smtp-Source: ABdhPJw94krKLbdj4Ek9izGlQT/6hROOw48/VPeNtymD3rUPkyiT4/g6Bm7uAJDPByVY6q44t1ekWQ==
X-Received: by 2002:a05:600c:3514:: with SMTP id h20mr1163564wmq.62.1641356440372;
        Tue, 04 Jan 2022 20:20:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a2sm44961888wri.17.2022.01.04.20.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 20:20:40 -0800 (PST)
Message-Id: <pull.1171.v5.git.git.1641356439.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v4.git.git.1641307776.gitgitgadget@gmail.com>
References: <pull.1171.v4.git.git.1641307776.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 04:20:37 +0000
Subject: [PATCH v5 0/2] name-rev: deprecate --stdin in favor of --annotate-stdin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a --annotate-stdin that is functionally equivalent of --stdin.
--stdin does not behave as --stdin in other subcommands, such as
pack-objects whereby it takes one argument per line. Since --stdin can be a
confusing and misleading name, the goal is to rename it to --annotate-stdin.

This is the first step in a process of eventually fully deprecating --stdin.
This change also adds a warning to --stdin warning that it will be removed
in the future.

See https://lore.kernel.org/git/xmqqsfuh1pxz.fsf@gitster.g/ for discussion.

changes since v4:

 * fixed documentation example indentation

changes since v3:

 * use strbuf_getline instead of strbuf_getwholeline (based on Junio's
   feedback)
 * fixed commit message s/annotate-text/annotate-stdin (based on Junio's
   feedback)
 * since strbuf_getline does not keep the trailing terminator, add back '\n'
   with strbuf_addchr
 * reordered documentation blocks based on (Philip Oakley's feedback)
 * fixed doc typos in example block

John Cai (2):
  name-rev: deprecate --stdin in favor of --annotate-stdin
  name-rev.c: use strbuf_getline instead of limited size buffer

 Documentation/git-name-rev.txt       | 30 ++++++++++++++++++++++++++--
 builtin/name-rev.c                   | 28 ++++++++++++++++----------
 t/t3412-rebase-root.sh               |  2 +-
 t/t4202-log.sh                       |  2 +-
 t/t6007-rev-list-cherry-pick-file.sh | 26 ++++++++++++------------
 t/t6012-rev-list-simplify.sh         |  2 +-
 t/t6111-rev-list-treesame.sh         |  3 ++-
 t/t6120-describe.sh                  |  9 +++++++--
 8 files changed, 71 insertions(+), 31 deletions(-)


base-commit: c8b2ade48c204690119936ada89cd938c476c5c2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1171%2Fjohn-cai%2Fjc%2Fdeprecate-name-rev-stdin-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1171/john-cai/jc/deprecate-name-rev-stdin-v5
Pull-Request: https://github.com/git/git/pull/1171

Range-diff vs v4:

 1:  4e9200922a4 ! 1:  7c5fb10d87c name-rev: deprecate --stdin in favor of --annotate-stdin
     @@ Documentation/git-name-rev.txt: OPTIONS
       	--name-only, substitute with "$rev_name", omitting $hex
      -	altogether.  Intended for the scripter's use.
      +	altogether.
     -+
     +++
      +For example:
     +++
     ++--
     ++	$ cat sample.txt
      +
     -+----------
     -+$ cat sample.txt
     -+
     -+An abbreviated revision 2ae0a9cb82 will not be substituted.
     -+The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907,
     -+while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
     ++	An abbreviated revision 2ae0a9cb82 will not be substituted.
     ++	The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907,
     ++	while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
      +
     -+$ git name-rev --annotate-stdin <sample.txt
     ++	$ git name-rev --annotate-stdin <sample.txt
      +
     -+An abbreviated revision 2ae0a9cb82 will not be substituted.
     -+The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907 (master),
     -+while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
     ++	An abbreviated revision 2ae0a9cb82 will not be substituted.
     ++	The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907 (master),
     ++	while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
      +
     -+$ git name-rev --name-only --annotate-stdin <sample.txt
     ++	$ git name-rev --name-only --annotate-stdin <sample.txt
      +
     -+An abbreviated revision 2ae0a9cb82 will not be substituted.
     -+The full name after substitution is master,
     -+while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
     -+----------
     ++	An abbreviated revision 2ae0a9cb82 will not be substituted.
     ++	The full name after substitution is master,
     ++	while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
     ++--
      +
      +--stdin::
      +	This option is deprecated in favor of 'git name-rev --annotate-stdin'.
 2:  18f77ab9dde = 2:  2acd70f36e7 name-rev.c: use strbuf_getline instead of limited size buffer

-- 
gitgitgadget
