Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4560620248
	for <e@80x24.org>; Thu,  4 Apr 2019 07:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfDDHem (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 03:34:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42415 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfDDHel (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 03:34:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so786703pgh.9
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 00:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yDkbo+Wbq27nVW/BCxqnBQ5mYgTu+UDp4nAbecyja7A=;
        b=eX9+jgHL12jyvkmtKBraY5Q452JQp53uRp5nmUMOsvcI7kbGJ/XgFtVRjoPdw2Mxgs
         bn45pvCwDj2I+/1S6rBr3uXup8Fw2CkXlU2ZSLyDxAY7hUelC8QS+bcMIniAUzC8TpSx
         Q9S7GapoZvth+dKSp9aUIsVdGowguXKihbfNgCx73OYInwoIH2W+1k7o328+r/vmJ98L
         AiPf/D5jW2Ih3GtwtDZ046X2MOiAJ/cQdkLPdTO3M+06GcMVWsmCiFXr7CWf4s48gFhz
         PxKVfm/mIFHC+Up2Nu9cuYd+TTNoWdrZl/Rw28rUWkiUOsc2Fd3Z0oFp5HKwH+VSs/kh
         peZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yDkbo+Wbq27nVW/BCxqnBQ5mYgTu+UDp4nAbecyja7A=;
        b=E+VMVLC6HUiW7ShHaFwlFTxKTUZvlKR3ietZAkw+KkwwK2l0oZLX8MIq5umig4T1YU
         8FtWaUCzXMOEC4VMhpvPHf4k0Y04bKMVi4dFxLiR51GxuKic44lB8WEpAhXWBnY3W6qo
         j1vEdOmkj6lesgdQmbEdPQBF6jC6ab5FUi6SIdcBE/K93D09WebkSK9fUe1X8O03RLMy
         7GIsWNIQL7bC8YAAu5Fr0PgbNosIJv+GbyuUi6OzgiG3J3nvxfHyBetSHTbkIMieNC9Q
         GvL+64XJSandLOzwE1IIgjqNKa6r1mpieoD7BjlHQiN3P0dFLxKr0p91lfmOS5Q6vWB8
         3S2w==
X-Gm-Message-State: APjAAAUDK/TpXHYP2n1ix/qb7JSvUdic485ZP7460MuxrkW8nStPBv+y
        B8EJN8nPxQr6pnhej7QJUexNFNRt
X-Google-Smtp-Source: APXvYqwyO6RCFLn8sBaUkt1Qu2n6ny9UwLqZ1b4TCXo+qfns39CCjk+Zn95tb5CdQoShCpgAGpMhzQ==
X-Received: by 2002:a63:7e10:: with SMTP id z16mr4382484pgc.40.1554363281138;
        Thu, 04 Apr 2019 00:34:41 -0700 (PDT)
Received: from localhost.localdomain (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id b26sm41802310pgn.4.2019.04.04.00.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 00:34:40 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: [PATCH 1/2] mergetools: add support for smerge (Sublime Merge)
Date:   Thu,  4 Apr 2019 00:34:38 -0700
Message-Id: <20190404073439.9558-1-davvid@gmail.com>
X-Mailer: git-send-email 2.21.0.198.gfad8868f4e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach difftool and mergetool about the Sublime Merge "smerge" command.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool--lib.sh |  1 +
 mergetools/smerge     | 12 ++++++++++++
 2 files changed, 13 insertions(+)
 create mode 100644 mergetools/smerge

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 83bf52494c..aaa4eed0bc 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -279,6 +279,7 @@ list_merge_tool_candidates () {
 		fi
 		tools="$tools gvimdiff diffuse diffmerge ecmerge"
 		tools="$tools p4merge araxis bc codecompare"
+		tools="$tools smerge"
 	fi
 	case "${VISUAL:-$EDITOR}" in
 	*vim*)
diff --git a/mergetools/smerge b/mergetools/smerge
new file mode 100644
index 0000000000..9c2e6f6fd7
--- /dev/null
+++ b/mergetools/smerge
@@ -0,0 +1,12 @@
+diff_cmd () {
+	"$merge_tool_path" mergetool "$LOCAL" "$REMOTE" -o "$MERGED"
+}
+
+merge_cmd () {
+	if $base_present
+	then
+		"$merge_tool_path" mergetool "$BASE" "$LOCAL" "$REMOTE" -o "$MERGED"
+	else
+		"$merge_tool_path" mergetool "$LOCAL" "$REMOTE" -o "$MERGED"
+	fi
+}
-- 
2.21.0.198.gfad8868f4e

