Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF5AC433E0
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A536207A5
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbhAACmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbhAACmS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:42:18 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF52C061573
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:41:38 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id d8so19324097otq.6
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=ULl+l9Y0FtPV7kioDpLupyCedO28AHAVjAFG+95jOhY=;
        b=k8C1yzLCSDFpjdNXPSA+tizV6syaeFqIFcaKqZBIV7ljxUcgDPhzZvYytqdHVdw3gO
         hWjU+NXFL2gDecgz2TCjMXhKkzZdmTtWm5mDU6ArxGP/mbQ6cX2F07nHDFEhZFptclCk
         l49ZWn0ojapu8QPp91HLovqF2zi8fvqzvvKAxm79rq7ap0KrGaLQBM3N2iqP8M501KP0
         9yj3dpxgiZQop/ATjujlg2WItfRT72WWGEE2TYB+GFpVz++k1F6pXN1VShHlSb9X4YKR
         D/QFUQ1+ktbxybwasLQseQjcClJ35PEZJXDoQlxLG+4Srsz9iDUtxbftu+YuB3dUM2g3
         Lkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=ULl+l9Y0FtPV7kioDpLupyCedO28AHAVjAFG+95jOhY=;
        b=tAyw+vW2TFGYdjFnSzhSmKCxvjcgeD3TeBTrTeruPp+rTfze9mC4jQHpHbX+UX2g52
         B2lg6gPsaoYBjGlhdAJh/+KnUSOEss6NA5XoQiKPMZUR4HrXIsc3Mocj77IcdmQpdRfo
         dM9wRLy+lxVjbQnesyWVe26SQxq0Cv1f1PWXhlHnIPqOQ6hnuCFVazwLYT5+bv0lR50q
         emwKv8qPP3QaP/pOI5Jt1NMGdyHHFhmGaS7kKuEpQScURhhLHCG+cGmaubVH//ZmCqO5
         VE/kc14QkjdTL0LbLv2dsUbtgmgCUAhhGg7UIYFuGKtEy2wHI9Y2G+4cJ1B7d9wD6gM2
         u87g==
X-Gm-Message-State: AOAM531kVgf00BKd5dbYoiwWhHuaSE0NUR/5PULmVAievNoNAGA0q5UM
        nZB7Mne0+y1dTEs4C+V7fsHEAGYyNH3chQ==
X-Google-Smtp-Source: ABdhPJzY0+9ISeal6nKu2tCV+hO2RCu+TOJjhJpxCbY3ddU2u6JZcBHTqaT3LA3wZnGw+q5QeqVNCg==
X-Received: by 2002:a9d:208a:: with SMTP id x10mr42890191ota.260.1609468897336;
        Thu, 31 Dec 2020 18:41:37 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s77sm12076947oos.27.2020.12.31.18.41.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:41:36 -0800 (PST)
Date:   Thu, 31 Dec 2020 20:41:35 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Message-ID: <5fee8bdf8256e_c31ca208fb@natae.notmuch>
Subject: [ANN] git-completion 1.3 released
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Git-completion is a friendly fork of the official Git completion and
prompt scripts for Zsh and Bash.

The main goal is to provide a more up-to-date completion for Zsh (I'm
the developer), which is basically just a wrapper around the Bash
completion.

Compared to Git upstream, you get many benefits for Zsh, but there's
also benefits for Bash users too.

If you use the official Zsh completion, the main benefit is that it's
blazingly fast. Simply doing "git log <tab>" on the Linux kernel (with
3k+ refs) takes several seconds on the official Zsh completion (about
3 seconds on my machine), with git-complete it's *instantaneous*.

There's other benefits too. Since the Bash completion is actively
maintained by Git developers, everything works as they intend too.

For example "git send-email <tab>" correctly completes branches, as
opposed to files in the Zsh official completion. Also, complex aliases
such as '!f () { }; f' are correctly identified and completed
out-of-the-box.

It's a sister project of the Oh My Zsh gitfast plugin [1], which I maintain too.

Since the last version, the baseline has been updated to git 2.30 (which
includes some of the patches of git-completion 1.2), but there's a bunch
of other improvements and fixes.

The main improvement over 1.2 is that now all the completions are
correctly quoted (according to zsh developers using compadd -Q is rarely
correct).

In total there are 47 patches [2] on top of git's master (plus tests and
workarounds).

For installation instructions, and more information, check the wiki
[3], but basically.

 * make install
 * fpath=(~/.local/share/git-completion/zsh $fpath)

And for Arch Linux users I've created an AUR package: [4].

Enjoy and Happy New Year!

[1] https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gitfast
[2] https://lore.kernel.org/git/20210101021622.798041-1-felipe.contreras@gmail.com/
[3] https://github.com/felipec/git-completion/wiki/Zsh
[4] https://aur.archlinux.org/packages/git-completion/

-- 
Felipe Contreras
