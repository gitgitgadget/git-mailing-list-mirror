Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EEE01F404
	for <e@80x24.org>; Sun, 11 Feb 2018 00:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752956AbeBKAKP (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 19:10:15 -0500
Received: from mout.gmx.net ([212.227.15.19]:39661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752932AbeBKAKO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 19:10:14 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0MUI8w-1eJowZ4362-00Qz7M; Sun, 11 Feb 2018 01:10:06 +0100
Date:   Sun, 11 Feb 2018 01:10:04 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 01/12] sequencer: avoid using errno clobbered by
 rollback_lock_file()
In-Reply-To: <cover.1518307771.git.johannes.schindelin@gmx.de>
Message-ID: <67bb2eead7bb499b27436fb6a120cbfbb2de1262.1518307771.git.johannes.schindelin@gmx.de>
References: <cover.1517266437.git.johannes.schindelin@gmx.de> <cover.1518307771.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TRxWQQND++7InjYEpkYezVq9HWYbFDR2TsABH8ctzUrNi5R9lUr
 u3bf2XG0TJizrV9uTKjlHYknNoftPNl9/y+fjO/1uRkU/oz03M3/e9Ee5TwESKlMdR/NpTk
 5gQjMebd9sVm+52FgHwI24hsvgdFOcQ2MUicwAWH84AnpGmzac98lTfnlKeQ9kacq1oUtUT
 Zqy7pk2LmN+mtSKunRbsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TY+GeVkcXNI=:94wfAuWssiAmJrjwR44Swf
 kWmKIOFZ8J8EmM1F96GOv+f6INXvHZy/OSgmw7PGxkp0yWs5AL8exetTHDvsE8SyNUI6xgCCX
 ygpYl6O7dcVnOl3F6MY+aL+fOWtb9YR6iq/7kVoqax+mAS+/fYvcW77CZqySsOOJwhvxdnJhZ
 x5yGOGqW8ZHiCymuBSV0g7PdAv2jj+L5j+p19ucxkd92yfJGTlXmYT22GDlOUSv39ugwKMFIW
 XNwsltIC0UDIbIe9oGXcRiGU2stcY3FNQKAZfl83u3/QITSFf24LZZp+5Tvbekyw+W0pfBOkK
 EWDt8ca93r450Ixqpb5L/M4WEYP5QVB93LT4cXLeLh5LvB9pzI3N4P69TQDFScBRR+VE5O66U
 8AbXxUG1i6aOGiqMBPry3sG76pDnOVjsG4j4VOv2BMAPvNGn9pGBlDXV9Hu67xUAixbLJVMzQ
 NRwspsvq6HChJZzQryvqOFleI4wi1ecjeLvnO+oxPcLJJQAYd1yTBnzKjauiQRJTbAXrowUKy
 cBFxT/Wo8qqbsqkHnxXgE3Fs+Ll5DZK2EqyoDtU1+SHNWOoxnVdkSKOmMnxnPQFzzyPkCJYtu
 4rd0ORojXDwAU7FD8YvBoTUN3v+AyA5TEsnN/S5ZzHj+v3yhQtSTuJdpkN5g8tHrm6W77UROY
 uiCLFccvXGCpa+hqPu7fytbZVIsSdieckWR0JhbIdDbcu4k36kpzB+wT2vi3uJjThdj/mtbMq
 dILQVfMK+Gg9S5e+qH8gPh4E3JJLR3OJA3LnKl7nuJjWNby4cUxLavqpilzC9ueawBIwDzMEU
 qNsQaIB3ynsU7278lLXi5qSpFunvmKjykdRALtBQNbVAIQgP9s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As pointed out in a review of the `--recreate-merges` patch series,
`rollback_lock_file()` clobbers errno. Therefore, we have to report the
error message that uses errno before calling said function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 4d3f60594cb..114db3b2775 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -296,12 +296,14 @@ static int write_message(const void *buf, size_t len, const char *filename,
 	if (msg_fd < 0)
 		return error_errno(_("could not lock '%s'"), filename);
 	if (write_in_full(msg_fd, buf, len) < 0) {
+		error_errno(_("could not write to '%s'"), filename);
 		rollback_lock_file(&msg_file);
-		return error_errno(_("could not write to '%s'"), filename);
+		return -1;
 	}
 	if (append_eol && write(msg_fd, "\n", 1) < 0) {
+		error_errno(_("could not write eol to '%s'"), filename);
 		rollback_lock_file(&msg_file);
-		return error_errno(_("could not write eol to '%s'"), filename);
+		return -1;
 	}
 	if (commit_lock_file(&msg_file) < 0) {
 		rollback_lock_file(&msg_file);
@@ -1584,16 +1586,17 @@ static int save_head(const char *head)
 
 	fd = hold_lock_file_for_update(&head_lock, git_path_head_file(), 0);
 	if (fd < 0) {
+		error_errno(_("could not lock HEAD"));
 		rollback_lock_file(&head_lock);
-		return error_errno(_("could not lock HEAD"));
+		return -1;
 	}
 	strbuf_addf(&buf, "%s\n", head);
 	written = write_in_full(fd, buf.buf, buf.len);
 	strbuf_release(&buf);
 	if (written < 0) {
+		error_errno(_("could not write to '%s'"), git_path_head_file());
 		rollback_lock_file(&head_lock);
-		return error_errno(_("could not write to '%s'"),
-				   git_path_head_file());
+		return -1;
 	}
 	if (commit_lock_file(&head_lock) < 0) {
 		rollback_lock_file(&head_lock);
-- 
2.16.1.windows.1


