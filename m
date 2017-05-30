Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4858320D0A
	for <e@80x24.org>; Tue, 30 May 2017 00:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750908AbdE3Abu (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 20:31:50 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35202 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbdE3Abt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 20:31:49 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so14065559pfd.2
        for <git@vger.kernel.org>; Mon, 29 May 2017 17:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5v6USLFUS4P/1iMj77VdZlqp9MqxiiPmL7n4PjLlWfo=;
        b=syIz/rNnZGA7vF5DXj+fz4vjsw8D1QFX3MVxcGGEHJEnYRPKNk5zw2tSRfCrdN/Hp4
         4i2uM8pxwhWRyrdNkyqlnXUf2Dy/Rte1De6g4BHtj+IIJw2eWM1beHlACmuRNvaHbc1k
         K4+JJicy31WfpaS45IDGeZiAFE9sEFYrLdj6rmr8QV08FOANzF8dDBrFIWIJ/KP8nW/S
         7I48nQMWn8iH7Frvp6SmSpllSqBnKtxXer7ETZK/rpArhzUOXVaUumfuQzWIx4WIgaIT
         qdggRap43jzj5FwcJ7eGtWBHJXMDeuHhEttt+CyicQuDg5aIbhu2ZM/PhePXI8o6M0MM
         pseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5v6USLFUS4P/1iMj77VdZlqp9MqxiiPmL7n4PjLlWfo=;
        b=gFO/Ukh0VZaUcTeK53VdfcX/EdfcvVb8TnUJyZS1XGPFZnkHslwyomP5vedBk9Yd/+
         Vmhe6EMGy0YLcefUk9axd17M/YWG70BboodP2mheo8umGmHqIw+aTiuA0rerfgj1ZwMF
         y209Y0d0fHrxI5T1mSbJ3CBdI2GT2S+YAHmpgb/IzMEAog1NIJTtrqKVc5dWxkrgCd6q
         79nYQ1eqlwJBKsGiszrs1t5yjbg8JTG+g8OAdCWqlsr31/n287xLIBnPmPRerwQFdmkK
         sj191dPydHRytiFzGqEJMUyjGNhO1do38M+mXL+9MRMBh2miZWG1YiznebcMFQ4JXW7p
         +d1Q==
X-Gm-Message-State: AODbwcCHFgWW1YpzzqC4LjeF3Tj+oiSnlZuJq6OgHcB50IS/xwnBuxP5
        ZUfP1dmdGTI020C7/Jw=
X-Received: by 10.99.123.81 with SMTP id k17mr22009815pgn.125.1496104308765;
        Mon, 29 May 2017 17:31:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id x73sm19708599pfa.71.2017.05.29.17.31.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 17:31:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] compat-util: is_missing_file_error()
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
        <20170526033510.1793-1-gitster@pobox.com>
        <20170526033510.1793-13-gitster@pobox.com>
Date:   Tue, 30 May 2017 09:31:47 +0900
In-Reply-To: <20170526033510.1793-13-gitster@pobox.com> (Junio C. Hamano's
        message of "Fri, 26 May 2017 12:35:09 +0900")
Message-ID: <xmqqefv7famk.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our code often opens a path to an optional file, to work on its
contents when we can successfully open it.  We can ignore a failure
to open if such an optional file does not exist, but we do want to
report a failure in opening for other reasons (e.g. we got an I/O
error, or the file is there, but we lack the permission to open).

The exact errors we need to ignore are ENOENT (obviously) and
ENOTDIR (less obvious).  Instead of repeating comparison of errno
with these two constants, introduce a helper function to do so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Now this is independent of nd/fopen-errors topic.  We could tweak
   nd/fopen-errors topic to use this later, after both of these two
   topics have graduated.

 git-compat-util.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 8a4a3f85e7..8a3c680626 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1115,6 +1115,21 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
 #define getc_unlocked(fh) getc(fh)
 #endif
 
+/*
+ * Our code often opens a path to an optional file, to work on its
+ * contents when we can successfully open it.  We can ignore a failure
+ * to open if such an optional file does not exist, but we do want to
+ * report a failure in opening for other reasons (e.g. we got an I/O
+ * error, or the file is there, but we lack the permission to open).
+ *
+ * Call this function after seeing an error from open() or fopen() to
+ * see if the errno indicates a missing file that we can safely ignore.
+ */
+static inline int is_missing_file_error(int errno_)
+{
+	return (errno_ == ENOENT || errno_ == ENOTDIR);
+}
+
 extern int cmd_main(int, const char **);
 
 #endif
-- 
2.13.0-496-ga689fffbe2

