Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF01C433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE5B120724
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHPuLQoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389339AbgF3PQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389334AbgF3PQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 11:16:25 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CDBC061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:16:25 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 22so19190689wmg.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JJbe+QrBO14NsmfZqfQ91/DM3X7GnUFWvZC77pmO7bI=;
        b=mHPuLQoqvQg2dWsGJfp1ZCXymBoT6EBeLrlPkQtQqXFOsR6xpj0OZrqFN1ZxTTgKg1
         DuK58/GTp0KDeNiwc9Od8D9mNuiwWrDFPYH+h7vWi66932TgRw8VkBizRmHwwm371CWU
         Rqc4IQK8+vs5yGKOsTu8+teQRxJyGV26nceFuGaOvtJeoM//K9XND/VQpJstiiBMYmQr
         9GFa2OztjV661AddzPpcOLtpRSfKAmScZXgWwkh1t8tePbr0D+ISB0SZsxpgoXeqpvV/
         DjQcTK0qP9XsADqgQChsj+8J2Nx1eJSVCYK5bIR71jTErGSlCi57WLB4o4lZNacBHnQz
         cpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JJbe+QrBO14NsmfZqfQ91/DM3X7GnUFWvZC77pmO7bI=;
        b=W85F1OvEo7ZT7gpJSZQxQackvadSXpTIt7HbVyGMD7X4+ldHA8jSjCurNeis1bWgZ8
         8swgza5Ief3CupDXMXtLjursOW9Im9YvTIav8RoCA3lAK0/EriN9/3Aml3uy3Knrp5mF
         wGUYY0HXZR3EzSojW2WBnbjU47oiL9NkdwSGD1X5CiSzxyv3sbkQzRCouR/8A/5jwFvS
         qdwpgzUg/q0VMSdhU6k58hsunsZVWeCggcYMLFa7ddtEgv1skQNh91U/sdGxcuZENjUL
         nhedt5LBNwI+HbthwVjae5cla3eTrWWun4010ne23EI4twpl5no8bhRSHF2rodW+/MGZ
         YA/Q==
X-Gm-Message-State: AOAM530MMtEcr7yonluRZk5wZeiEj+efg63glEsrpaR2HCYdCmUaGGHf
        dFUMKnblIALbDT8Y8kzJdmg5DVQu
X-Google-Smtp-Source: ABdhPJxptBDlw42Zjp+y2yWhzydG5lezulPVEzKJqSeAr4MgBqBE++t51URe+ABoHQ/q/W3Proii+w==
X-Received: by 2002:a05:600c:2154:: with SMTP id v20mr23859553wml.185.1593530183734;
        Tue, 30 Jun 2020 08:16:23 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-323-12.w86-199.abo.wanadoo.fr. [86.199.210.12])
        by smtp.googlemail.com with ESMTPSA id 63sm4263911wra.86.2020.06.30.08.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:16:23 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 0/6] stash: drop usage of a second index
Date:   Tue, 30 Jun 2020 17:15:52 +0200
Message-Id: <20200630151558.20975-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200505104849.13602-1-alban.gruin@gmail.com>
References: <20200505104849.13602-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old scripted `git stash' used to create a second index to save
modified and untracked files, and restore untracked files, without
affecting the main index.  This behaviour was carried on when it was
rewritten in C, and here, most operations performed on the second index
are done by forked commands (ie. `read-tree' instead of reset_tree(),
etc.).

The goal of this series is to modernise (a bit) builtin/stash.c.

Originally, this series was also meant to fix a bug reported by Son
Luong Ngoc [0], but as emphasized by Gábor [1], the issue is not limited
to `git stash', so this series is not a good fix for this particular
issue.

This series is based on a08a83db2b (The sixth batch, 2020-06-29).

The tip of this series is tagged as "stash-remove-second-index-v2" at
https://github.com/agrn/git.

[0] https://lore.kernel.org/git/EED2CFF1-5BEF-429D-AB99-AD148A867614@gmail.com/
[1] https://lore.kernel.org/git/20200615152715.GD2898@szeder.dev/

Changes since v1:

 - Lots of rewording, following comments from Christian Couder and Son
   Luong Ngoc.

 - Removed a useless function call.

Alban Gruin (6):
  stash: mark `i_tree' in reset_tree() const
  stash: remove the second index in stash_working_tree()
  stash: remove the second index in stash_patch()
  stash: remove the second index in save_untracked_files()
  stash: remove the second index in restore_untracked()
  stash: remove `stash_index_path'

 builtin/stash.c | 156 +++++++++++++++---------------------------------
 1 file changed, 48 insertions(+), 108 deletions(-)

Range-diff against v1:
1:  6101e8ce64 ! 1:  598f03e76e stash: mark `i_tree' in reset_tree() const
    @@ -2,9 +2,9 @@
     
         stash: mark `i_tree' in reset_tree() const
     
    -    As reset_tree() does not change the value pointed by `i_tree', and that
    -    it will be provided with `the_hash_algo->empty_tree' which is a
    -    constant, it is changed to be a pointer to a constant.
    +    In reset_tree(), the value pointed by `i_tree' is not modified.  In a
    +    latter commit, it will be provided with `the_hash_algo->empty_tree',
    +    which is a constant.  Hence, this changes `i_tree' to be a constant.
     
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
     
2:  26dceead41 ! 2:  7265cfe65c stash: remove the second index in stash_working_tree()
    @@ -3,26 +3,19 @@
         stash: remove the second index in stash_working_tree()
     
         This removes the second index used in stash_working_tree() to simplify
    -    the code.  It also help to avoid issues with the split-index: when
    -    stash_working_tree() is called, the index is at `i_tree', and this tree
    -    is extracted in a second index for use in a subcommand.  This is not a
    -    problem in the non-split-index case, but in the split-index case, if the
    -    shared index file has expired and is removed by a subcommand, the main
    -    index contains a reference to a file that no longer exists.
    +    the code.
     
         The calls to set_alternative_index_output() are dropped to extract
         `i_tree' to the main index, and `GIT_INDEX_FILE' is no longer set before
         starting `update-index'.  When it exits, the index has changed, and must
         be discarded.
     
    -    The call to reset_tree() becomes useless: the only caller of
    -    stash_working_tree() is do_create_stash(), which creates `i_tree' from
    -    its index, calls save_untracked_files() if requested (but as it also
    -    works on a second index, it is unaffected), then calls
    -    stash_working_tree().  But when save_untracked_files() will be modified
    -    to stop using another index, it won't reset the tree, because
    -    stash_patch() wants to work on a different tree (`b_tree') than
    -    stash_working_tree().
    +    With this commit, reset_tree() does not need to be called at the
    +    beginning of stash_working_tree(), because it is only called by
    +    do_create_stash(), which sets the index at `i_tree', and
    +    save_untracked_files() does not change the main index.  But it will
    +    become useful again in a later commit, when save_untracked_file() will
    +    be rewritten to use the "main" index, so I did not remove it.
     
         At the end of the function, the tree is reset to `i_tree'.
     
3:  1ae236daf4 = 3:  b5587c0d56 stash: remove the second index in stash_patch()
4:  8c901ddf9d ! 4:  5fbcddf899 stash: remove the second index in save_untracked_files()
    @@ -8,7 +8,7 @@
         containing only untracked files, so the tree is reset to the empty tree
         at the beginning (hence the need for reset_tree() to accept constant
         trees).  The environment of `update-index' is no longer updated, and the
    -    index is discarded after this command exited.
    +    index is discarded after this command exits.
     
         As the only caller of this function is do_create_stash(), and the next
         user of the index is either save_untracked_files() or stash_patch(),
5:  413be5b5f9 ! 5:  0338986339 stash: remove the second index in restore_untracked()
    @@ -42,7 +42,7 @@
      		return -1;
     -	}
      
    - 	child_process_init(&cp);
    +-	child_process_init(&cp);
      	cp.git_cmd = 1;
      	argv_array_pushl(&cp.args, "checkout-index", "--all", NULL);
     -	argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
6:  b2c08c189e = 6:  4f151f4600 stash: remove `stash_index_path'
-- 
2.20.1

