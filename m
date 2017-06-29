Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C16C1F623
	for <e@80x24.org>; Thu, 29 Jun 2017 22:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbdF2WWk (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 18:22:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36729 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbdF2WWh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 18:22:37 -0400
Received: by mail-wm0-f65.google.com with SMTP id y5so4971030wmh.3
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 15:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EAfyyNv/8/AQaBoX29hvkRSOwIkanEcuVJN7EXmXKrE=;
        b=X8dk6SY9CCaeSMC09nJM7yGYY7MwbXyiM86c7BA+oUAynz6meoJWHGXdbQq1kL0Hhq
         /b4Dc/MAv9gJs3So6dMoLaYV/CUIzS/sSbmQ7fQM8FFw3FztRmGdygv1D42ZztKn6zs+
         IIgGxXqwCoorMYeNh0R+II//KNOXAqB2qEIgQ/Qu1sMTRaGm1pRbed7k2SmN80FzvxYZ
         z5xu/R63qt0aYrnToyL4Me0kef6OI0E9Rxaaw7LS8O93Evk5JwlCYVjGGkij+jAFUwZo
         +6aHN3VedHAYkYc4z5MF+AlGhXoBF26zmIou4/HjcFzkU/jWdyIywB6FGj1Ur7947Sti
         Sp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EAfyyNv/8/AQaBoX29hvkRSOwIkanEcuVJN7EXmXKrE=;
        b=L6q9VgIUUydyQ1107x9WQmadMM4F6fKD68I2aEvvWbl5abL7R4a4ey3E8oIgQPy84l
         KVdXTKpYxvM78GMHaMQPZKdJDS3zYramDlP2X5tbcIzMx1rxh/fQJg/yf2IC0NM8w7fT
         VlpFNgfef7Vvohc/TKzJHgV8lRLwX86ig9JjVc1w8sMMvDgC8w0nkmdfN8sFPukWBUS+
         OS4zWk35ZCMMYKkiexFdjPBI7XrcEVYSuC7IDb4Av6dGyyWlWK6EuGusqOFW7uovYkVx
         7kQbZFrnmpsrQ0DMWFFJ0J4KPButgRzyh5EJrZ+ANR9f1UtSzT7ugxfM0ucXt3ef7ry+
         vivg==
X-Gm-Message-State: AKS2vOzEb0AVy8aKyBfk6tck7deWdl9eU39spCa1uV66TCI2eMAtdxd4
        btZ8fLVfV396wiKg+AQ=
X-Received: by 10.80.165.104 with SMTP id z37mr3123110edb.60.1498774956114;
        Thu, 29 Jun 2017 15:22:36 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c36sm1181183edb.31.2017.06.29.15.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jun 2017 15:22:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        J Smith <dark.panda@gmail.com>,
        Joe Ratterman <jratt0@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/6] grep: adjust a redundant grep pattern type assignment
Date:   Thu, 29 Jun 2017 22:22:18 +0000
Message-Id: <20170629222222.4694-3-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170629222222.4694-1-avarab@gmail.com>
References: <20170629222222.4694-1-avarab@gmail.com>
In-Reply-To: <20170628215809.23060-1-avarab@gmail.com>
References: <20170628215809.23060-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust a now-redundant assignment to extended_regexp_option to make it
zero if grep.extendedRegexp is not set. This is always called right
after init_grep_defaults() which memsets the entire structure to 0, so
there's no need to set it again to zero.

However the reason for the if/else pattern is a holdover from[1] where
this was adjusted from a bitfield assignment to a boolean. Rather than
getting rid of the assignment to 0 in all cases, let's just use the
value returned by git_config_bool(), which is more idiomatic and in
sync with the rest of the boolean handling in this function.

This is a logical follow-up to my commit to remove redundant regflags
assignments[2]. This logic was originally introduced in [3], but as
explained in the former commit it's working around a pattern in our
code that no longer exists, and is now confusing as it leads the
reader to think that this needs to be flipped back & forth.

1. 84befcd0a4 ("grep: add a grep.patternType configuration setting",
   2012-08-03)
2. e0b9f8ae09 ("grep: remove redundant regflags assignments",
   2017-05-25)
3. b22520a37c ("grep: allow -E and -n to be turned on by default via
   configuration", 2011-03-30)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index 29439886e7..817270d081 100644
--- a/grep.c
+++ b/grep.c
@@ -78,10 +78,7 @@ int grep_config(const char *var, const char *value, void *cb)
 		return -1;
 
 	if (!strcmp(var, "grep.extendedregexp")) {
-		if (git_config_bool(var, value))
-			opt->extended_regexp_option = 1;
-		else
-			opt->extended_regexp_option = 0;
+		opt->extended_regexp_option = git_config_bool(var, value);
 		return 0;
 	}
 
-- 
2.13.1.611.g7e3b11ae1

