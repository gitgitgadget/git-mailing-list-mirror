Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55F241F428
	for <e@80x24.org>; Sat, 28 Apr 2018 22:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeD1WoZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 18:44:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:50193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeD1WoY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 18:44:24 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Ld0fQ-1eUO8W3SHg-00iBn7; Sun, 29 Apr 2018 00:44:16 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v7 01/12] argv_array: offer to split a string by whitespace
Date:   Sun, 29 Apr 2018 00:44:07 +0200
Message-Id: <178058d887281fc87e5008367bbee5677a619320.1524955439.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
MIME-Version: 1.0
In-Reply-To: <cover.1524955439.git.johannes.schindelin@gmx.de>
References: <cover.1524865158.git.johannes.schindelin@gmx.de> <cover.1524955439.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:b38UGDhJft0MZotQLq//zwx5mZEW2eZoF2h72y42a+AFr+/qnz3
 dPuxxPoAloz0mxjYPS75CdnQ/e3d/+lFV7+RCDhGM3dsWtBMpa7hXbW9NJigcrXtuGUjHAy
 h3+9y4QUP2W111qzkmXP4130KwCz2lrNPVNU4gtseNUw8uv8tFpXF7mnhR7SHR07O3eQNhd
 1+7d6i3nvVB1BlxTuCAZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X8YpmCG9Aeg=:zn69Vzrqr/bl2pMFZ4lcbm
 6VC0qwagiPkMO3xEpDUEV9BmuSWDRS3sc7pKt4eQlHqBNVM5z1CQgPf1E8vCrr63FR3P3owjP
 AE/7A7OnuPgGJt0f3yuJ4JbgsOEQZFGcdRk8QuINnC83+td6vz2dQMoF/cTuCWFDWfGTEN9Gb
 4mls14LCfVs0F8SFhnQLnlW3XUn+VT5HygMz/2qgbONPBk1KVowQydqKOK3IUsfzrFTBebA+b
 nriLv3t2JZmXVQhd0lDj+atCsmvdg8injaNl0Wan1D6Ubi5GaU1aLBEqBMtp0eucNwi6wZNFL
 ZRqtdiO0fgzYmRK6pVXg+K7OxkGQHXij0ENjD+VxnpaLMhnN88p1K+cNzBzmLbUOeOXatABTz
 SQ+SU+goUEPwAq+1ZBOKcdJq9mPSfwaCLXA2on/Jg7iizl+W55V7BLn0eyFl2JfLp4HdM/rwK
 i4AUrsPYU0nTGFNMl6yqfjVoKSs1zbhSRbLV+pyAQPrKsxWJ6jtX3teki6zyAghKhz03ko2c5
 N7LR9+tNiZ9CcjugRvlZptv2uTpPqkKYXWvfBGsmAGpWkL4cFTeBXbaymFVofDrwF4keXQM/N
 eqxh1ykrAnxotxr0sIhFTX53bO+GjK30iUTAF5M6vsZBcoG3d928lfu8/OCm/KIq+L/X1q90q
 t3MGKj3vMzSWBgyujkGO2SqeLEXP65P/z5wejDaoCJC5QML5qpwRh2WvT+mVasl2nPP0a0NFj
 kNyC5rH+mP3D+c/SmqC45zHLxdnKWCEIQ9xvhqS4CuPPTdHsNnNtxEnOVTT9QZAP40o2KMkIo
 zKKEibE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a simple function that will interpret a string as a whitespace
delimited list of values, and add those values into the array.

Note: this function does not (yet) offer to split by arbitrary delimiters,
or keep empty values in case of runs of whitespace, or de-quote Unix shell
style. All fo this functionality can be added later, when and if needed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 argv-array.c | 20 ++++++++++++++++++++
 argv-array.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/argv-array.c b/argv-array.c
index 5d370fa3366..cb5bcd2c064 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -64,6 +64,26 @@ void argv_array_pop(struct argv_array *array)
 	array->argc--;
 }
 
+void argv_array_split(struct argv_array *array, const char *to_split)
+{
+	while (isspace(*to_split))
+		to_split++;
+	for (;;) {
+		const char *p = to_split;
+
+		if (!*p)
+			break;
+
+		while (*p && !isspace(*p))
+			p++;
+		argv_array_push_nodup(array, xstrndup(to_split, p - to_split));
+
+		while (isspace(*p))
+			p++;
+		to_split = p;
+	}
+}
+
 void argv_array_clear(struct argv_array *array)
 {
 	if (array->argv != empty_argv) {
diff --git a/argv-array.h b/argv-array.h
index 29056e49a12..750c30d2f2c 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -19,6 +19,8 @@ LAST_ARG_MUST_BE_NULL
 void argv_array_pushl(struct argv_array *, ...);
 void argv_array_pushv(struct argv_array *, const char **);
 void argv_array_pop(struct argv_array *);
+/* Splits by whitespace; does not handle quoted arguments! */
+void argv_array_split(struct argv_array *, const char *);
 void argv_array_clear(struct argv_array *);
 const char **argv_array_detach(struct argv_array *);
 
-- 
2.17.0.windows.1.36.gdf4ca5fb72a


