Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E3741F454
	for <e@80x24.org>; Mon,  4 Nov 2019 20:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfKDUDx (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 15:03:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46740 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbfKDUDx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 15:03:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id l4so2870625plt.13
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 12:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bchuMdPI/Illdsr3uWvZlOJbFZ3BWOd/5u7DUzZg1F8=;
        b=d1dIorDmLEU+AuAHIiriZ/1AhzpXNZARSLMJAqFp8ndaMM+ZAPqj3GDTnoC146mjmi
         +z+2sy9Tny0HyG1S34bw5kf1v3YWROcyWeOi6yyXD5k7MzMM2bSU6ixFVwVZ9vPxh0uV
         iCxcab3v8fOGi7zizE+cFnpsDc7REgDM9T/WnJuPR1UrG8tyCOLIWHN829msC6uOIYLq
         sr17cXooyxBROMpAK45KARghGtR82yaXqu8qu6vPkM8dv2AtX/DLU40P4/BLvWTWI3d9
         42vMGBIis/Jg8nBWw5tieRpJAXPex5yWdqBZ4D+OImfBWrfuF10Bx3Oc9kpyNof2SfSS
         F0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bchuMdPI/Illdsr3uWvZlOJbFZ3BWOd/5u7DUzZg1F8=;
        b=f+Ng4Yi5bxBFDApOHG8QI/EFISkqJUlZMMsOhogJRK0OPlIl97+oQKHF6uIGDpX0Mb
         qxskko+yhlvwQu+FR+H7QV7+rL9tIYuC8q3qJ1iNiu7RyxWhLSBpBQnx5lzdGzpezPDY
         u9+maO92XpDsS0hKNH+0lnaY11EF05vR2AU/AhM72pRQc1cfis6eFoV28E4sEglmCQ2c
         KBmWgNjUju3maJeSlTyWMsPV2OhvX5lJZUgCMhupwbMjX3JCA8xW4LTO5CFGeoxlXXTS
         21GHBNyP7WB5H7XKU+WHq2hWJkEfyialTnpUz7atyLWrJQU5nvgCEmFeUeW1DC+VswDu
         eVoA==
X-Gm-Message-State: APjAAAXaOKFCmvhkqxUVvaEjb2pSdHV6uQx7015bEsXTd89cCh1bviDV
        1S0Cs3VI8AyT2oc99+HAPfgnzmQd
X-Google-Smtp-Source: APXvYqwq5vjIaI3A19K8U0hAOhz1AlTS507UhB2JTA6ezfq6bBuaF3VUKZFQCunb4d3oYNVoPnN1HQ==
X-Received: by 2002:a17:902:ac98:: with SMTP id h24mr4152775plr.227.1572897832529;
        Mon, 04 Nov 2019 12:03:52 -0800 (PST)
Received: from generichostname ([204.14.236.210])
        by smtp.gmail.com with ESMTPSA id u7sm5101924pjx.19.2019.11.04.12.03.51
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 12:03:52 -0800 (PST)
Date:   Mon, 4 Nov 2019 15:03:50 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/8] revision: make get_revision_mark() return const pointer
Message-ID: <743a91029960eb134420bd315eb0d5076a40427f.1572897736.git.liu.denton@gmail.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572897736.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get_revision_mark() used to return a `char *`, even though all of the
strings it was returning were string literals. Make get_revision_mark()
return a `const char *` so that callers won't be tempted to modify the
returned string.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 revision.c | 4 ++--
 revision.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 0e39b2b8a5..2151b119b7 100644
--- a/revision.c
+++ b/revision.c
@@ -3944,7 +3944,7 @@ struct commit *get_revision(struct rev_info *revs)
 	return c;
 }
 
-char *get_revision_mark(const struct rev_info *revs, const struct commit *commit)
+const char *get_revision_mark(const struct rev_info *revs, const struct commit *commit)
 {
 	if (commit->object.flags & BOUNDARY)
 		return "-";
@@ -3966,7 +3966,7 @@ char *get_revision_mark(const struct rev_info *revs, const struct commit *commit
 
 void put_revision_mark(const struct rev_info *revs, const struct commit *commit)
 {
-	char *mark = get_revision_mark(revs, commit);
+	const char *mark = get_revision_mark(revs, commit);
 	if (!strlen(mark))
 		return;
 	fputs(mark, stdout);
diff --git a/revision.h b/revision.h
index 4134dc6029..addd69410b 100644
--- a/revision.h
+++ b/revision.h
@@ -322,8 +322,8 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 void reset_revision_walk(void);
 int prepare_revision_walk(struct rev_info *revs);
 struct commit *get_revision(struct rev_info *revs);
-char *get_revision_mark(const struct rev_info *revs,
-			const struct commit *commit);
+const char *get_revision_mark(const struct rev_info *revs,
+			      const struct commit *commit);
 void put_revision_mark(const struct rev_info *revs,
 		       const struct commit *commit);
 
-- 
2.24.0.rc2.262.g2d07a97ef5

