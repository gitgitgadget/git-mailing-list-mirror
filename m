Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4DEC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 16:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15471206D8
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 16:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7QG6Xli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbgGaQwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733019AbgGaQwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 12:52:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4459DC061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 09:52:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so28577334wrs.11
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wx7iH1scd1t+/nUg3FKgjKk3yAFoQFGR68rJPp6XRMU=;
        b=J7QG6XliEDO9oHBtUuKn7AQD/B3O3/SGzU8qAw6G9zE/m9lvFcqdk2eKRMbaqCzvHR
         XD0OwRBfHg6h/5zwuVt3Lz0ypiny5a/5LHWONxbZP2M21LpC0++XLrck1SXb8bFabM/P
         i0dKryqeG32hnDkprHNlrmZqXvVSB9PsDoTpX1hTiMISHv19UWXstzAs09Tv6F6szFsA
         Ygf96Xah7SC0Nr5ioA/dmICl8t2kEQCgTmyc+JitLnkCc0QsIIUABR1goUnhqrQ7VsoC
         khHBHNi6ix1Wxj29H19RgRJRst+0MuD9WPeqfYv7rhPFTX2xk4b7zV1fxWWWMITthkOz
         RqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wx7iH1scd1t+/nUg3FKgjKk3yAFoQFGR68rJPp6XRMU=;
        b=iP/9W2a8e3rKMpFS6+g28E/uScxIKYBGjSRkxzjZZ4xAZgC0CT1k1pWBvDE161EwuS
         vv3ZHXrtTHa+Is5X1rotrqzPxToICB1k/6SKuKvMoQQanV8CzI8EYlCFjJPZoUHlm3bm
         P+6gmiAwpeLXeAMNuIto+jd1uR0mORJ63N86cLU2hqWnTiveZLMHtM5Y1HRH5HBXFzPB
         uom1zMRu8gK2zmpg3Aew+hpdWPZH8wgmZWD7t921ZwA7NxooSVJXVPBGucbKYzHfSk6b
         xCv7sEfIcd4cQszAvJW3Vveac/j6hHI+WI8HV9w4dsmpVOlY4uAXbg2V19NcakmVpzkn
         /syA==
X-Gm-Message-State: AOAM533kO40xc8GhCwXyhU9Tl2/XNmUYPGmrno7Xm9zdXv6Gt+rXg09h
        eL2Cbj/zj9yoDp4bGFIsAvL0Rykc
X-Google-Smtp-Source: ABdhPJx/8uWAfV3d93f3GcvLlzHk5X1+pjwqbnwJRMmt94IPYM5WcdffEi67NjNZ1cNgP9npaACgwg==
X-Received: by 2002:adf:94e5:: with SMTP id 92mr4173897wrr.316.1596214327724;
        Fri, 31 Jul 2020 09:52:07 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-421-163.w2-6.abo.wanadoo.fr. [2.6.84.163])
        by smtp.googlemail.com with ESMTPSA id t14sm15169134wrg.38.2020.07.31.09.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:52:07 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 0/6] stash: drop usage of a second index
Date:   Fri, 31 Jul 2020 18:51:34 +0200
Message-Id: <20200731165140.29197-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630151558.20975-1-alban.gruin@gmail.com>
References: <20200630151558.20975-1-alban.gruin@gmail.com>
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

This series is based on a08a83db2b (The sixth batch, 2020-06-29), and it
applies cleanly on top of the current master (e8ab941b67 (The second
batch -- mostly minor typofixes, 2020-07-30)).

The tip of this series is tagged as "stash-remove-second-index-v3" at
https://github.com/agrn/git.

[0] https://lore.kernel.org/git/EED2CFF1-5BEF-429D-AB99-AD148A867614@gmail.com/
[1] https://lore.kernel.org/git/20200615152715.GD2898@szeder.dev/

Changes since v2:

 - Typofix in the fifth patch, noticed by Christian Couder.

Alban Gruin (6):
  stash: mark `i_tree' in reset_tree() const
  stash: remove the second index in stash_working_tree()
  stash: remove the second index in stash_patch()
  stash: remove the second index in save_untracked_files()
  stash: remove the second index in restore_untracked()
  stash: remove `stash_index_path'

 builtin/stash.c | 156 +++++++++++++++---------------------------------
 1 file changed, 48 insertions(+), 108 deletions(-)

Range-diff against v2:
1:  598f03e76e = 1:  598f03e76e stash: mark `i_tree' in reset_tree() const
2:  7265cfe65c = 2:  7265cfe65c stash: remove the second index in stash_working_tree()
3:  b5587c0d56 = 3:  b5587c0d56 stash: remove the second index in stash_patch()
4:  5fbcddf899 = 4:  5fbcddf899 stash: remove the second index in save_untracked_files()
5:  0338986339 ! 5:  a12a923014 stash: remove the second index in restore_untracked()
    @@ -6,7 +6,7 @@
     
         The call to `read-tree' is replaced by reset_tree() with the appropriate
         parameters (no update, no reset).  The environment of `checkout-index'
    -    is no longer modified, and the cache is discarded when it exists.
    +    is no longer modified, and the cache is discarded when it exits.
     
         In do_apply_stash(), the changes are a bit more involved: to avoid
         conflicts with the merged index, restore_untracked() is moved after
6:  4f151f4600 = 6:  dd25e71f35 stash: remove `stash_index_path'
-- 
2.20.1

