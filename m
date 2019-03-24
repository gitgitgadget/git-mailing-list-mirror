Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8337420248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfCXIW4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:22:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42144 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbfCXIW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:22:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so4344204pgh.9
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aiSmXcPWwuUlZwOaeK3ivjrxGNj+j1bDAtipP1bbsHM=;
        b=MMjAKCohFdfn5xZhz3Rjy5G+SQ3Ij0ejCPFN3o1T6XWk3ftL4vHCU0p1Ar2JptbCVh
         ec77quzqwMgpUS1JJr2OzN0eKszfzasNPDejWtmnYaE9y31qjnqochFNQgkxzuK6ykZT
         6rbaycUbNiD98FhkI4HFte1NwEgQms2N514E9RSr1bEauvyHS89uJ6PWg/ieF/BD8eHT
         /sIBlL2weMTfpLVmyq01nQ0nR+waRQ83i2/0jlmsqv3qcs539si5Ui1Xh2UAuU+l5QJj
         JrORx4JSI5cnNAu6wOgBigLkWVUo6+9a6Bwohv5Vz1Qg1Tw4dzZ0kxWjwazpmFUE09hl
         ho5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aiSmXcPWwuUlZwOaeK3ivjrxGNj+j1bDAtipP1bbsHM=;
        b=itqX0cwxy9tPUMigg4ANbpvXXT+0wcAHSHL/M6jp3K+vKY1x5vai9RzdhROlRT73ko
         kqNqPTt/aF3UhLhQlhEjzvUyUveJ8KqJ9AnGqRAfakPzj9A9JSmIOrOoEi/XJ0GqM0un
         zNzavHTKOYysDSIKbqH+R/aGHVWNDKZt+5jUgXVjmcGvOtu/1eKY/NxLxELsolPO5rUB
         XiuXu9gQqARIGorKzKTjNj9RYNALULJxepb6cPV/iqkMwoka+Av3T3uB3peqMnFXBTUb
         bSr96pr0UrGLKJZ0BjZeoHQRA3vEgR5+mRU2GxhhR1nX/uW9WwzP/9XcpCVGA+usZsTM
         kNUA==
X-Gm-Message-State: APjAAAU6SO8oeKhthYj3Kzwpmfy8D9jnZoys8Tt0hjECRkdcNDsu2XU9
        Ox93tDt3DBi+NfR+hESsAz0=
X-Google-Smtp-Source: APXvYqwxOFqu6FUVxXqqy0qD3DiZsiuKSxA/Gx4i4T+pl8ILMrZHUvvUOV6cbe1kAILL1sJXKvOs/A==
X-Received: by 2002:a17:902:6b48:: with SMTP id g8mr18701431plt.21.1553415775574;
        Sun, 24 Mar 2019 01:22:55 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id s79sm25236562pfa.61.2019.03.24.01.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:22:54 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 15:22:50 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 20/20] am: avoid diff_opt_parse()
Date:   Sun, 24 Mar 2019 15:20:14 +0700
Message-Id: <20190324082014.2041-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190324082014.2041-1-pclouds@gmail.com>
References: <20190320114703.18659-1-pclouds@gmail.com>
 <20190324082014.2041-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

diff_opt_parse() is a heavy hammer to just set diff filter. But it's
the only way because of the diff_status_letters[] mapping. Add a new
API to set diff filter and use it in git-am. diff_opt_parse()'s only
remaining call site in revision.c will be gone soon and having it here
just because of git-am does not make sense.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/am.c | 4 ++--
 diff.c       | 6 ++++++
 diff.h       | 2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 95370313b6..0cbf285459 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1515,11 +1515,11 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		 * review them with extra care to spot mismerges.
 		 */
 		struct rev_info rev_info;
-		const char *diff_filter_str = "--diff-filter=AM";
 
 		repo_init_revisions(the_repository, &rev_info, NULL);
 		rev_info.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
-		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1, rev_info.prefix);
+		rev_info.diffopt.filter |= diff_filter_bit('A');
+		rev_info.diffopt.filter |= diff_filter_bit('M');
 		add_pending_oid(&rev_info, "HEAD", &our_tree, 0);
 		diff_setup_done(&rev_info.diffopt);
 		run_diff_index(&rev_info, 1);
diff --git a/diff.c b/diff.c
index 8b770cd396..11f26285c3 100644
--- a/diff.c
+++ b/diff.c
@@ -4692,6 +4692,12 @@ static unsigned filter_bit_tst(char status, const struct diff_options *opt)
 	return opt->filter & filter_bit[(int) status];
 }
 
+unsigned diff_filter_bit(char status)
+{
+	prepare_filter_bits();
+	return filter_bit[(int) status];
+}
+
 static int diff_opt_diff_filter(const struct option *option,
 				const char *optarg, int unset)
 {
diff --git a/diff.h b/diff.h
index 03c6afda22..f88482705c 100644
--- a/diff.h
+++ b/diff.h
@@ -233,6 +233,8 @@ struct diff_options {
 	struct option *parseopts;
 };
 
+unsigned diff_filter_bit(char status);
+
 void diff_emit_submodule_del(struct diff_options *o, const char *line);
 void diff_emit_submodule_add(struct diff_options *o, const char *line);
 void diff_emit_submodule_untracked(struct diff_options *o, const char *path);
-- 
2.21.0.548.gd3c7d92dc2

