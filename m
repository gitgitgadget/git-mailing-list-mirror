Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A176C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 14:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiADOtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 09:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiADOtj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 09:49:39 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1763CC061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 06:49:39 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id s1so76686161wra.6
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 06:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YJvA5vjU4d99Kw3SEeDC/tiJn7TEc7RhXDrUOgjD30g=;
        b=jB+R5UV3n0vNZyBemynmlz6tJwR/LmkvTsl8KpfbQhCgwi7wAbNxK9aHjEb5R3JN9v
         nF1u1MMBEEtGpKmeQ/Lr/xOyJ+jaT3ShyliClxRoWjd0wtQTmWNOFWTYbywCb81MKF1S
         j7ZpokeZ7hxigTRsVIitHUIeFiE+z8CgGcXjpK4ZEV9tcCMMHsjJedOLOow6P++GnTOD
         vhOox2PNSE+3TJR9BXdSlQhWzjBjd2cxMHT8Rce+QdcomOLxTN+rrcRvQSRK6ZzV7vxG
         9YYiPgDlkxlW88YOBS+IyGLxSZcF8b5deOk702h/dfs2YJIF8knHNR133qkT3xY2l1Q9
         WtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YJvA5vjU4d99Kw3SEeDC/tiJn7TEc7RhXDrUOgjD30g=;
        b=40AUWFNHPrBr2XnyU0eihPN76ToxQcw59eabhXB9VyQJsW1sEEOakbMZwch8vr+i/3
         vAoam+8E/0Gj3sf+HflDqbPKUmQZRNCCxE2NgqF+rgUkXHhdPmU6VHB/w7FRJwsBeJdL
         cP7+/jnYKviC7AgafbVi/DDD8jerp/0hf20qOQtJdBW6m+Tzcr7pobd0MFartJmlBp8k
         CFUp7JJo6/c5TXUeylOZlidayytZbdiP2kUNE+8UHb80mA/6GU5DohNM+04HjX/DBMMe
         4uhsYDs/39gRf/QHod2U1x9A6RVmYRg+dETxIyMsZVsRCzJx3AQl3S7XRfIynVz6yuT0
         wRhQ==
X-Gm-Message-State: AOAM531V+xr0fApC1rDm0d0eO3oEIKZc+i9Qb+/yuKacNgNmMa8+4PbO
        /osMnHqT+tv1qJhf/K32JkhR/ohm06Q=
X-Google-Smtp-Source: ABdhPJwLrOVo/svTWJAt6LDGQbbDmr3yWANuLqOlZ+/WMVtUDTlKSvaMtGYzwRMV7Cg9JcXEvGnjSg==
X-Received: by 2002:adf:9c85:: with SMTP id d5mr42247986wre.374.1641307777490;
        Tue, 04 Jan 2022 06:49:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8sm42165832wrd.10.2022.01.04.06.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 06:49:37 -0800 (PST)
Message-Id: <pull.1171.v4.git.git.1641307776.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v3.git.git.1641221261.gitgitgadget@gmail.com>
References: <pull.1171.v3.git.git.1641221261.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Jan 2022 14:49:34 +0000
Subject: [PATCH v4 0/2] name-rev: deprecate --stdin in favor of --annotate-stdin
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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1171%2Fjohn-cai%2Fjc%2Fdeprecate-name-rev-stdin-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1171/john-cai/jc/deprecate-name-rev-stdin-v4
Pull-Request: https://github.com/git/git/pull/1171

Range-diff vs v3:

 1:  55ec2a5fa3e ! 1:  4e9200922a4 name-rev: deprecate --stdin in favor of --annotate-text
     @@ Metadata
      Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
     -    name-rev: deprecate --stdin in favor of --annotate-text
     +    name-rev: deprecate --stdin in favor of --annotate-stdin
      
     -    Introduce a --annotate-text that is functionally equivalent of --stdin.
     +    Introduce a --annotate-stdin that is functionally equivalent of --stdin.
          --stdin does not behave as --stdin in other subcommands, such as
          pack-objects whereby it takes one argument per line. Since --stdin can
     -    be a confusing and misleading name, rename it to --annotate-text.
     +    be a confusing and misleading name, rename it to --annotate-stdin.
      
          This change adds a warning to --stdin warning that it will be removed in
          the future.
     @@ Commit message
      
       ## Documentation/git-name-rev.txt ##
      @@ Documentation/git-name-rev.txt: OPTIONS
     + --all::
       	List all commits reachable from all refs
       
     - --stdin::
     -+	This option is deprecated in favor of 'git name-rev --annotate-stdin'.
     -+	They are functionally equivalent.
     -+
     +---stdin::
      +--annotate-stdin::
       	Transform stdin by substituting all the 40-character SHA-1
       	hexes (say $hex) with "$hex ($rev_name)".  When used with
     @@ Documentation/git-name-rev.txt: OPTIONS
      -	altogether.  Intended for the scripter's use.
      +	altogether.
      +
     -+	For example:
     -++
     ++For example:
     ++
      +----------
      +$ cat sample.txt
      +
     @@ Documentation/git-name-rev.txt: OPTIONS
      +$ git name-rev --annotate-stdin <sample.txt
      +
      +An abbreviated revision 2ae0a9cb82 will not be substituted.
     -+The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907
     -+(master),
     ++The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907 (master),
      +while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
      +
      +$ git name-rev --name-only --annotate-stdin <sample.txt
      +
      +An abbreviated revision 2ae0a9cb82 will not be substituted.
     -+The full name is master,
     ++The full name after substitution is master,
      +while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
      +----------
     ++
     ++--stdin::
     ++	This option is deprecated in favor of 'git name-rev --annotate-stdin'.
     ++	They are functionally equivalent.
       
       --name-only::
       	Instead of printing both the SHA-1 and the name, print only
 2:  e4bd09ccf75 ! 2:  18f77ab9dde name-rev.c: use strbuf_getline instead of limited size buffer
     @@ builtin/name-rev.c: int cmd_name_rev(int argc, const char **argv, const char *pr
      -			if (!p)
      -				break;
      -			name_rev_line(p, &data);
     -+		while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
     ++		while (strbuf_getline(&sb, stdin) != EOF) {
     ++			strbuf_addch(&sb, '\n');
      +			name_rev_line(sb.buf, &data);
       		}
      +		strbuf_release(&sb);

-- 
gitgitgadget
