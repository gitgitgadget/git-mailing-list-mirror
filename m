Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 399AF20248
	for <e@80x24.org>; Thu,  7 Mar 2019 12:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfCGM3Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 07:29:25 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42867 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCGM3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 07:29:25 -0500
Received: by mail-pg1-f196.google.com with SMTP id b2so11130676pgl.9
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 04:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qIdplIH7gHUg0ZlXaCagdfaDvlZVzBk9WF4AmZVp+xY=;
        b=IHtL4vb4EFhNCwBS6GmmDNPyyvXqelnGEk3ICUMURDwcDqyb/BEFJuAX1EY20lUmX+
         7pcsuiy7NPwmqVNWlNko3cc7iJCS8zxiaHSe3Ay4v1FTLPi3zX6a+LMpJkXQUy2BT20u
         QeeumRvVzVIniJQfiyR03l5rz2ZRyw4qSKoZP/U9Tuie63Crj+oVHgNGC1Wf6+rFR/By
         9FzyFL3G2iwFY75t3MezAITqaXe2ZaEjZMuZg0UC9qkFCXLR5yp6sIpH6BOYSfmGkT6x
         BxJgaChhwBwMRU7xnDspJT6FB0q1x4Cb7Ciuy+fYxH1MBXItpHuoUP6KhwtssXxfRqw+
         Rtbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qIdplIH7gHUg0ZlXaCagdfaDvlZVzBk9WF4AmZVp+xY=;
        b=hCAo6v+oJ3RRRtKLs0c8z/Y5zFYT9xXvVP5mXqLxycivrWRnYuth+JfCTVBUV6f+Mv
         lIcu6hsR/JySvhwCpMBejyVeN+Wtd6YLlTXb+Yt71MpFMwECBhBT08B6cq5lYG9/BzFg
         atWrjp38kAIBcpojh7Aj5pgKquvYmnMCbgzBKSf6an4K79bmx2bK9ZaTZHS0RtadQn04
         e2n9E3SstuMBRpPi/fHAyvok1B17tnFzKhz1nYx8+BF2Ua05nJSl89wdy8X2UfuusK/j
         IIItlqQ4TyC1LTnQaIxbX1egBJ8zttS17+hLoM8RBl0658dSZGdR5Gf15M6sBsdp565r
         xPGw==
X-Gm-Message-State: APjAAAU11Y2V4F0c9+WXgIjZFgQ6W41lz7PlNXFZrLnx7yaH0FOq9ijk
        1M4lIbEA5UI0jbpafzbPHrQ=
X-Google-Smtp-Source: APXvYqzSNpK+D/dfwr1VGeNEifKDdnqV7W9h3W3EeCPgt+x1DYiuKZyiX/I9vIeqNW3DD5QS/coZXA==
X-Received: by 2002:a17:902:b097:: with SMTP id p23mr12534313plr.36.1551961765022;
        Thu, 07 Mar 2019 04:29:25 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id p11sm16160104pfi.10.2019.03.07.04.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 04:29:24 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Mar 2019 19:29:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     phillip.wood123@gmail.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, phillip.wood@dunelm.org.uk,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/3] Fix refs/rewritten not show up in for-each-ref
Date:   Thu,  7 Mar 2019 19:29:14 +0700
Message-Id: <20190307122917.12811-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <ec707cbb-96e8-f26f-3d69-b69d29b31737@gmail.com>
References: <ec707cbb-96e8-f26f-3d69-b69d29b31737@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apparently there is one corner case where refs/rewritten/* may not show
up in for-each-ref in multiple worktree setup. This is because the
per-worktree classification has to be done in three places (my bad!)
and Johannes only updated one.

This should fix it (and it also fixes refs/worktree/ not showing up
under the same condition because I'm an idiot who does not know how to
test).

Nguyễn Thái Ngọc Duy (3):
  files-backend.c: factor out per-worktree code in loose_fill_ref_dir()
  files-backend.c: reduce duplication in
    add_per_worktree_entries_to_dir()
  Make sure refs/rewritten/ is per-worktree

 path.c                   |  3 +++
 refs/files-backend.c     | 50 ++++++++++++++++++++++------------------
 t/t1415-worktree-refs.sh | 35 ++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 22 deletions(-)

-- 
2.21.0.rc1.337.gdf7f8d0522

