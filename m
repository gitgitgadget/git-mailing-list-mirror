Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7211C1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 12:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfBUMUb (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 07:20:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39112 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbfBUMUa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 07:20:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id i20so3303071pfo.6
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 04:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NxxuM3gH2B8DL0XiE+SvYBBTOJOyPXL9Gw9BvSf17BQ=;
        b=Idxf4cN6LM3RQnxvMoOoilzr8RjNDm2dV+c3jxo5gWVz40t8Y+IhAhJHF8XZhBOMcD
         aZwKI1T82AnmyFWW+EkP9IwJ1kbxPYqLHKJewpv+maCBVz0D6YghGknyG+QlAah+coZX
         ZXILpFL8NV04r/NgOYaFX1wahmUmkvHDF+OaYfKDgb+l0Kefquh4jF97S8ADX3FXxInT
         lCpdRh3HpbMZuFzBXUHNF7ASgYUbMGUe9e77XNBd5CrQEDZ/WocjgqwklhyH2iBgzmRI
         bSPomhwht4HMQBOGDOtPLVpok1OfsvgLrhFWQU+EXSkXJhbn+iZNtRjWVpaWbpFtUwtk
         ilJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NxxuM3gH2B8DL0XiE+SvYBBTOJOyPXL9Gw9BvSf17BQ=;
        b=nZOXJkwPeUkOoi1Jy92Ag4bvmtf0SLlysrYAAGcNcusl9+ZLjyGcT/tCku3kA9QXtd
         P0uqh88ZukEqAB/z2ngphOFKjOaCz1m6VJX51fhrzErbV81i79NB+L3TlI7NihCUFBOg
         z8XG9Jb8kxyJheiPBsNBUPlh0bg3tCVKIb030fnWYZhYlrJdjAkBevyyLZjLpGQmwAxx
         Sow6WJPZBDePAMsw1ytn5FsgGQq0OMTkNr8qQWz31/jJkZT/QKQKEli8UpYwMOpj9HX/
         KVJXNOAWOwvqbn+RsmTuQoyWoB5zZIFIE9t8htptVifMVfuSg3ICZ6LRZIIOqOAjUnVK
         8dYw==
X-Gm-Message-State: AHQUAuanYc4KycqQveHqJnOMUieBC1JNK/obvY3lquC+AfF7QcRS1PDk
        MUfW+LL9ZuRWBvrrBBVjkkZXyyjd
X-Google-Smtp-Source: AHgI3Ib+c46y3f+H54rW2rAjJUJqFIrgGLwClWOmgxjZ9Avqx4N4rbmG2pifN3UuIbxfN7TtY3GPeQ==
X-Received: by 2002:a63:515d:: with SMTP id r29mr33443823pgl.350.1550751629555;
        Thu, 21 Feb 2019 04:20:29 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id l12sm25748565pgn.83.2019.02.21.04.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 04:20:28 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 19:20:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, hi-angel@yandex.ru, sunshine@sunshineco.com
Subject: [PATCH v2 0/1] worktree add: sanitize worktree names
Date:   Thu, 21 Feb 2019 19:19:42 +0700
Message-Id: <20190221121943.19778-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190221110026.23135-1-pclouds@gmail.com>
References: <20190221110026.23135-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 fixes bad ".lock" handling in v1. I keep the "name->len == 0" part
though because I found another valid case that could end up there.

Nguyễn Thái Ngọc Duy (1):
  worktree add: sanitize worktree names

 builtin/worktree.c      | 51 ++++++++++++++++++++++++++++++++++++++++-
 t/t2025-worktree-add.sh |  7 ++++++
 2 files changed, 57 insertions(+), 1 deletion(-)

Range-diff dựa trên v1:
1:  42a3144874 ! 1:  d1b6e1c55b worktree add: sanitize worktree names
    @@ -13,7 +13,7 @@
         be able to specify the worktree name by themselves if they're not
         happy with this dumb character substitution.
     
    -    Reported-by: hi-angel@yandex.ru
    +    Reported-by: Konstantin Kharlamov <hi-angel@yandex.ru>
         Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
     
      diff --git a/builtin/worktree.c b/builtin/worktree.c
    @@ -30,16 +30,14 @@
     + */
     +static void sanitize_worktree_name(struct strbuf *name)
     +{
    ++	char *orig_name = xstrdup(name->buf);
     +	int i;
     +
    -+	/* no ending with .lock */
    -+	if (ends_with(name->buf, ".lock"))
    -+		strbuf_remove(name, name->len - strlen(".lock"),
    -+			      strlen(".lock"));
    -+
     +	/*
     +	 * All special chars replaced with dashes. See
     +	 * check_refname_component() for reference.
    ++	 * Note that .lock is also turned to -lock, removing its
    ++	 * special status.
     +	 */
     +	for (i = 0; i < name->len; i++) {
     +		if (strchr(":?[]\\~ \t@{}*/.", name->buf[i]))
    @@ -55,12 +53,18 @@
     +			strbuf_remove(name, i, 1);
     +	}
     +
    -+	/* last resort, should never ever happen in practice */
    ++	/*
    ++	 * a worktree name of only special chars would be reduced to
    ++	 * an empty string
    ++	 */
     +	if (name->len == 0)
     +		strbuf_addstr(name, "worktree");
     +
     +	if (check_refname_format(name->buf, REFNAME_ALLOW_ONELEVEL))
    -+		BUG("worktree name '%s' is not a valid refname", name->buf);
    ++		BUG("worktree name '%s' (from '%s') is not a valid refname",
    ++		    name->buf, orig_name);
    ++
    ++	free(orig_name);
     +}
     +
      static int add_worktree(const char *path, const char *refname,
    @@ -103,8 +107,10 @@
      '
      
     +test_expect_success 'sanitize generated worktree name' '
    -+	git worktree add --detach ".  weird*..?.lock" &&
    -+	test -d .git/worktrees/weird
    ++	git worktree add --detach ".  weird*..?.lock.lock" &&
    ++	test -d .git/worktrees/weird-lock-lock &&
    ++	git worktree add --detach .... &&
    ++	test -d .git/worktrees/worktree
     +'
     +
      test_done
-- 
2.21.0.rc1.337.gdf7f8d0522

