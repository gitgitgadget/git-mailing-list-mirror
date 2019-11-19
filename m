Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93C7D1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 00:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfKSAVX (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 19:21:23 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40086 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSAVX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 19:21:23 -0500
Received: by mail-pf1-f193.google.com with SMTP id r4so11195117pfl.7
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 16:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TsB4aE736AeJq+doBWJ90BkdoQivqsnlIXws11wrieQ=;
        b=pmSM4ubgZX1ZQG3lEIydIyrglRZJeMpX0pZkcPrQ30jPvjDRRgZ9EGeCw/GWNgs1aV
         oQj6ycAOmoyhohsvipb3GJC8zoVw8BXxRSKkADJY5Fow6h1q6vkp60qvGxpQcmS0etMd
         nUygvlCT43cv/Bv9FC4fnmx2++1zmqoguLzXoBo/vu321qPQfn5CIvm+vAQs8O99e2HQ
         81hhBGGHS4Ki8Ry5XbpYFhe554FPu3Vj1vFkAqNDnxrtcDFju8wQbTX/CENWjm5CIj64
         uF73HmWm/4pGrPTuV4+Npw4ajDiuibqttu2W0UeRmeoV6jvRP1hk/P407KwvF8NVdI+8
         sRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TsB4aE736AeJq+doBWJ90BkdoQivqsnlIXws11wrieQ=;
        b=o5+oFr7NIAEUwIG2WHQey/l73oK6481OXG6F6S2OilMQWZVhBwB1Lo6jHiYGUx0MX9
         pMGrey4/ZWkXisQQRnDNkiNYeb6225uHUEEu55osZTXFaYhvJWn0mBbxiwcfmrtoSKk2
         hFSDBcSfuYolSfJluT8CdX+C56UWyuvOtUQYn014ipL1v7yjqb47Uwtg3DfD/83H/KJI
         Rk70Ex/fCdDLrb2VUdkerA8bVoRpA974xcYE+30vj84XlDg/8VariSco2hMq0SDbkGBD
         NOsihuQjuiYPZvNbqsV+evSosruaQ0CLgkGt/20cbrtrEk90MG9/z6B96n+5CxhYGpCa
         N4uA==
X-Gm-Message-State: APjAAAWrtsUOx+yoDTORs8R+Gxz4XiQIx5LqcVkRBfbAF8E+bPYq93Sj
        ClsSNf0lE2LURsIGeG0H58/3Enf7
X-Google-Smtp-Source: APXvYqzVScagR6RL3LcBLqHiClGbI7ro5otu8/3wCi4cBDWt6ctYASRsj9GZp10WB7nhNmaUANXPzw==
X-Received: by 2002:a63:5966:: with SMTP id j38mr2237069pgm.304.1574122882183;
        Mon, 18 Nov 2019 16:21:22 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id j7sm20098820pgl.38.2019.11.18.16.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 16:21:21 -0800 (PST)
Date:   Mon, 18 Nov 2019 16:21:19 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v4 05/11] revision: make get_revision_mark() return const
 pointer
Message-ID: <bfb216954bebea92aa5363a07bfad0f70fed102b.1574122784.git.liu.denton@gmail.com>
References: <cover.1573764280.git.liu.denton@gmail.com>
 <cover.1574122784.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574122784.git.liu.denton@gmail.com>
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
2.24.0.420.g9ac4901264

