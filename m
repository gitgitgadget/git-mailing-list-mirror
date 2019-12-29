Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377A8C2D0CE
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 19:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A50820748
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 19:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsSO5fcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfL2TcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 14:32:17 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:36170 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfL2TcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 14:32:16 -0500
Received: by mail-ed1-f49.google.com with SMTP id j17so30781024edp.3
        for <git@vger.kernel.org>; Sun, 29 Dec 2019 11:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=fqWXxP3mtA+/I3LZAkzV5U14TPbzZZnJua/q1EQZFb0=;
        b=fsSO5fcLVRoUcSnw/rCj05qkRXou4KT+KUv2YpALSITwa1fXzcntAsT67f3UDs1gxa
         5H9hN93YE8xWU5DktsBXo4IeyxxHXCI/CjqoP/RpLnX3G7YLrT/SqEEb2XiyICcjQFdk
         F7XLpwZEEa2M6bwQbuBbiGuAstMGZgOeAKhShHPnxZJEhOtsHmU03+jlDEJsoqUmXars
         LFohCW7bW94dNEp86k8CBB5G4/KL7OlA9OP+o55z4sr6HlwsqulPpNMUCNv+9di9Pgqb
         1DjiXkCp4eJP1l51mS82ex/D8I6zB0beXzWmjlAenVMZzSehGEnqyuUnRLrsv/6HoadQ
         6ReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=fqWXxP3mtA+/I3LZAkzV5U14TPbzZZnJua/q1EQZFb0=;
        b=eNEdnC1UyE5O1B2Hc68V9gYiA3zUeH4cI19ZnGiEZg4EHLoF2mCWsKNKapqutP6P/L
         imD0hMyHidzQ/5EEYuMS4K6Xx7IKDEK6F8lJY++GMVIs84loMwAQD6XHULRnryoAtmHE
         6xGhnBT+MZ2uuMJFnC4582SMhSaH38EjCegYey10hrA2xjmiSGgBmkqQFgQBVGA3of24
         mH0Fs6xXd9GREFEFTijPK2Yisd3odHTdgL1S5yfDMulBSWSrN2djrsxcxQINZ5OpQy6J
         RDBB8zI9x0c+VzXC5S3U4IhpZHFwtpUDfEbQUnwj2oyI4+k17KzLI8tSEWGHJmQVFgu2
         57Fw==
X-Gm-Message-State: APjAAAXtvr6JtXoLY8M+7k7e2TuFsrfCYqdiN4M5vOURWUsdnS/0c5z2
        WdGZcuI9FZDLrVHOKiOUazdFoNmq
X-Google-Smtp-Source: APXvYqxslf6OhWV+iiftak+C2aYEFjqxAlT9ykxsiMDb+oreKDD2pZifdFglp2CsdaHZhi7K57adRA==
X-Received: by 2002:a17:906:f286:: with SMTP id gu6mr65526092ejb.146.1577647931738;
        Sun, 29 Dec 2019 11:32:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dn12sm5125224edb.89.2019.12.29.11.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Dec 2019 11:32:11 -0800 (PST)
Message-Id: <pull.499.v2.git.1577647930.gitgitgadget@gmail.com>
In-Reply-To: <pull.499.git.1577386915.gitgitgadget@gmail.com>
References: <pull.499.git.1577386915.gitgitgadget@gmail.com>
From:   "Zoli =?UTF-8?Q?Szab=C3=B3?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 29 Dec 2019 19:32:09 +0000
Subject: [PATCH v2 0/1] git-gui: allow opening currently selected file
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
  git-gui: allow opening currently selected file

 git-gui.sh | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)


base-commit: 23cbe427c44645a3ab0449919e55bade5eb264bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-499%2Fzoliszabo%2Fgit-gui%2Fopen-current-file-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-499/zoliszabo/git-gui/open-current-file-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/499

Range-diff vs v1:

 1:  fce80f1b95 ! 1:  a6fde256f8 git-gui: add possibility to open currently selected file
     @@ -1,6 +1,6 @@
      Author: Zoli Szabó <zoli.szabo@gmail.com>
      
     -    git-gui: add possibility to open currently selected file
     +    git-gui: allow opening currently selected file
      
          ...in the default associated app (e.g. in a text editor / IDE).
      
     @@ -9,11 +9,10 @@
          the file can be searched for in your preferred file manager or directly
          in the text editor, but having the option to directly open the current
          file from Git GUI would be just faster. This change enables just that by:
     -     - Diff header path context menu -> Open;
     -     - or double-clicking the diff header path.
     +     - clicking the diff header path (which is now highlighted as a hyperlink)
     +     - or diff header path context menu -> Open;
      
     -    One "downside" of the approach is that executable files will be run
     -    and not opened for editing.
     +    Note: executable files will be run and not opened for editing.
      
          Signed-off-by: Zoli Szabó <zoli.szabo@gmail.com>
      
     @@ -26,11 +25,12 @@
       
      -proc do_explore {} {
      -	global _gitworktree
     +-	set explorer {}
      +# Get the system-specific explorer app/command.
      +proc get_explorer {} {
     - 	set explorer {}
       	if {[is_Cygwin] || [is_Windows]} {
       		set explorer "explorer.exe"
     + 	} elseif {[is_MacOSX]} {
      @@
       		# freedesktop.org-conforming system is our best shot
       		set explorer "xdg-open"
     @@ -44,9 +44,7 @@
       	eval exec $explorer [list [file nativename $_gitworktree]] &
       }
       
     -+# Trigger opening a file (relative to the working tree) by the default
     -+# associated app of the OS (e.g. a text editor or IDE).
     -+# FIXME: What about executables (will be run, not opened for editing)?
     ++# Open file relative to the working tree by the default associated app.
      +proc do_file_open {file} {
      +	global _gitworktree
      +	set explorer [get_explorer]
     @@ -57,18 +55,30 @@
       set is_quitting 0
       set ret_code    1
       
     +@@
     + 	-justify left
     + tlabel .vpane.lower.diff.header.path \
     + 	-background gold \
     +-	-foreground black \
     ++	-foreground blue \
     + 	-anchor w \
     +-	-justify left
     ++	-justify left \
     ++	-font [eval font create [font configure font_ui] -underline 1] \
     ++	-cursor hand2
     + pack .vpane.lower.diff.header.status -side left
     + pack .vpane.lower.diff.header.file -side left
     + pack .vpane.lower.diff.header.path -fill x
      @@
       			-type STRING \
       			-- $current_diff_path
       	}
      +$ctxm add command \
      +	-label [mc Open] \
     -+	-command {
     -+		do_file_open $current_diff_path
     -+	}
     ++	-command {do_file_open $current_diff_path}
       lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
       bind_button3 .vpane.lower.diff.header.path "tk_popup $ctxm %X %Y"
     -+bind .vpane.lower.diff.header.path <Double-1> {do_file_open $current_diff_path}
     ++bind .vpane.lower.diff.header.path <Button-1> {do_file_open $current_diff_path}
       
       # -- Diff Body
       #

-- 
gitgitgadget
