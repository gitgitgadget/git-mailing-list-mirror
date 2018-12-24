Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D963920A1E
	for <e@80x24.org>; Mon, 24 Dec 2018 08:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeLXIsO (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 03:48:14 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41326 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbeLXIsO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Dec 2018 03:48:14 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so5362872pgq.8
        for <git@vger.kernel.org>; Mon, 24 Dec 2018 00:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XhC1SAWGvS243nhf21eDQu7vxRqmiTk0D1KP5SxjkmU=;
        b=E0KPzFx6CSWbe0l9PZbG2qIxc4MSl430MwTVOcs6E3lPFulD18AH1d8h8BtPP1WHz2
         Cji0gGQvB7ijRVrjHoqwlwq1CMb1/pUavIyZzi9w0tnfR+qqFLZeVw3Uqbvm61n5fH2s
         Zm4nscWfsccvS3aam3cKPDLdfg5HRAsUgXles41+DEGEFR5/e07zTYy/LLG8z1NX/zMf
         K5cmIDU6QtWXy7K74f52AXrjvER6PDRIBJhMb7N6nO1ra7FtZnoYnIoUfW1jPvFzN3DA
         0UcZtxLdbnDW3vHH8YRvqgk14e2fG2TZ31r5ua73BqJ3yWBnzfIkDvduPgSUuNLOrXie
         7DIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XhC1SAWGvS243nhf21eDQu7vxRqmiTk0D1KP5SxjkmU=;
        b=fHqplnTmVDQFCQb9UR+SgskOn3vvLifZRYcWlLRisrUzGxFSHmJuOUDWK7aqH9rXQ4
         Yp4Z0Vbqh4QqnG9k7h81Xw1Uq4nu9k0vVvauNHA3YZZ+K08SjBJeM/gpm964Sr/6Wugp
         o1BgYFp2b81dhE7lSmmfVuaLOlWUGoiApasudTL8C+EqWEZ0MOAEPPgboaPXtlYyMbAv
         u+YHidyDGNP9ZeNu0Knw4C49GN2c/d5gxBIDqyDV49JX6RdT+1xoUiej04O7en3yeJyF
         ETAzgPSUXMCS1UHRp2kF2KTynrnT+nW9C5fMawppQkDhHuG5OVIIrCxzvSOslv1FMcy+
         iRRg==
X-Gm-Message-State: AJcUukcKXT65RZseQ/X+lCocMVzAN9C9Qy/zWSnIi1bS4uuSx7PfoZ7f
        ecTYVlTT9aZ1nm4L03DtIX+03uzy
X-Google-Smtp-Source: ALg8bN4b6S6iCm99ejluVI4RIGdTAIbWw9BExPwaNFvcsKAb1OwUlKDJHS0hw6BDh/VnyYUTtnWiWQ==
X-Received: by 2002:a63:e615:: with SMTP id g21mr11844900pgh.290.1545641292989;
        Mon, 24 Dec 2018 00:48:12 -0800 (PST)
Received: from localhost.localdomain (cpe-23-241-199-231.socal.res.rr.com. [23.241.199.231])
        by smtp.gmail.com with ESMTPSA id m67sm57292021pfb.25.2018.12.24.00.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 00:48:12 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v4 3/3] branch: Add an extra verbose output displaying worktree path for refs checked out in a linked worktree
Date:   Mon, 24 Dec 2018 00:47:56 -0800
Message-Id: <20181224084756.49952-4-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20181224084756.49952-1-nbelakovski@gmail.com>
References: <20181220145931.GB27361@sigill.intra.peff.net>
 <20181224084756.49952-1-nbelakovski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

---
 builtin/branch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2a24153b78..56589a3684 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -366,6 +366,10 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 		strbuf_addstr(&local, branch_get_color(BRANCH_COLOR_RESET));
 		strbuf_addf(&local, " %s ", obname.buf);
 
+		if (filter->verbose > 2)
+			strbuf_addf(&local, "%s%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)%%(worktreepath) %%(end)%%(end)%s",
+				    branch_get_color(BRANCH_COLOR_WORKTREE), branch_get_color(BRANCH_COLOR_RESET));
+
 		if (filter->verbose > 1)
 			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
 				    "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
-- 
2.14.2

