Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8BD01F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbeLTTo4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:44:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41530 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731483AbeLTToy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:44:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so2968715wrs.8
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cpXkvhinpIIllAECgcgzKJXzSqbPUUO33RniiCIjngg=;
        b=ESkt2snjmRwvB7Sf5lLd4WOaZgDZ7qbnlWn8kNRMgJ4bmXRM6Qu3UymMIigsRod3ha
         rzEtqe+ZLjRIUmSoWm5IM+heZhEcne0nP7tmZXDB4WUp0zARC7n3ouSWCX/Kyx94faxR
         fjXhmzZrhwm4q0fY2qqgmsZQ0t/+a+DS8z3JIi/o6UHTO/tT0NMuFjZLNIa1+Tvb+uwO
         fu6ugpwNrHNu+B6CMCp1s7k8VwLbAYCywu//LmskaUkSpwHOh9Flu5OcmSXWpKAKccpE
         TAFeEGi7T2k+u9gm78edfw3V22Q8T57K9Fv9z8HNeFDB16fYY2QVIXKPZAdGSLxbtsy0
         husg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cpXkvhinpIIllAECgcgzKJXzSqbPUUO33RniiCIjngg=;
        b=tB3XBjeyUtpJLPfkPYzYYXtfj+nxpbBEsWwWDbwK9fSX1rjauR9nVDMMSu8ksif6NN
         Qz3MYZ9PQYbWD5vrD+MqhjW+F3zThstYDKSa5k1c4ygEMtFJvJEwDQS5pb8rOPJpbt6d
         +bcW8dqldncXgccwqXChJPoAHfQ4C4KeQMWv0aeSHQt+TgWKrwnZBeZ794jKSg/Ht063
         NWrBInmqrKBU93C1u78tSkYj2SwGoSWAW6ErP3pUlH668Bi4azzYzkUJvuGrY3DKtjvI
         DakPc47DxoBND5irIebYMfUjuTChgqCd6PHXzcqh8PuE6AsT03HLB4dbLqixYVoYaEuX
         zRpQ==
X-Gm-Message-State: AA+aEWYzBC2Ow7b2Krsv/aDwX61QS3WItpgTSMfH6+IBCDc3jEUczISs
        MwGADif5rU4ohnr3LLJlWIJNTQldmJ8=
X-Google-Smtp-Source: AFSGD/UcnGAUTqLa6LvRAs7GxP7g2wJxgG+YNlj+3zEQf/ATHyBC5dIp+irQQX5JD8PjMEf6UWh63w==
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr22931184wrq.5.1545335092276;
        Thu, 20 Dec 2018 11:44:52 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:44:51 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 04/26] ident: add the ability to provide a "fallback identity"
Date:   Thu, 20 Dec 2018 21:44:20 +0200
Message-Id: <57a654887e652251ae966ec31b4604dc8222f9c6.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 3bc2111fc2e9 (stash: tolerate missing user identity, 2018-11-18),
`git stash` learned to provide a fallback identity for the case that no
proper name/email was given (and `git stash` does not really care about
a correct identity anyway, but it does want to create a commit object).

In preparation for the same functionality in the upcoming built-in
version of `git stash`, let's offer the same functionality as an API
function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h |  1 +
 ident.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/cache.h b/cache.h
index 28ccc97e10..dd2154bcd3 100644
--- a/cache.h
+++ b/cache.h
@@ -1493,6 +1493,7 @@ extern const char *git_sequence_editor(void);
 extern const char *git_pager(int stdout_is_tty);
 extern int is_terminal_dumb(void);
 extern int git_ident_config(const char *, const char *, void *);
+void prepare_fallback_ident(const char *name, const char *email);
 extern void reset_ident_date(void);
 
 struct ident_split {
diff --git a/ident.c b/ident.c
index 33bcf40644..bce20e8652 100644
--- a/ident.c
+++ b/ident.c
@@ -505,6 +505,26 @@ int git_ident_config(const char *var, const char *value, void *data)
 	return 0;
 }
 
+static void set_env_if(const char *key, const char *value, int *given, int bit)
+{
+	if ((*given & bit) || getenv(key))
+		return; /* nothing to do */
+	setenv(key, value, 0);
+	*given |= bit;
+}
+
+void prepare_fallback_ident(const char *name, const char *email)
+{
+	set_env_if("GIT_AUTHOR_NAME", name,
+		   &author_ident_explicitly_given, IDENT_NAME_GIVEN);
+	set_env_if("GIT_AUTHOR_EMAIL", email,
+		   &author_ident_explicitly_given, IDENT_MAIL_GIVEN);
+	set_env_if("GIT_COMMITTER_NAME", name,
+		   &committer_ident_explicitly_given, IDENT_NAME_GIVEN);
+	set_env_if("GIT_COMMITTER_EMAIL", email,
+		   &committer_ident_explicitly_given, IDENT_MAIL_GIVEN);
+}
+
 static int buf_cmp(const char *a_begin, const char *a_end,
 		   const char *b_begin, const char *b_end)
 {
-- 
2.20.1.441.g764a526393

