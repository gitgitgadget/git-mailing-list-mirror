Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 930DD207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754276AbdDZUUR (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:20:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:59635 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754263AbdDZUUP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:20:15 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDyFr-1dKJaF1M7z-00HKh3; Wed, 26
 Apr 2017 22:20:12 +0200
Date:   Wed, 26 Apr 2017 22:19:56 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/26] status: close file descriptor after reading
 git-rebase-todo
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <f5a4cd0c7c3b59e6b4b062b8f8a6b4aa1420a88d.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6uHsMXtFUiZiLs0aA/sxbHAnnsHzXo4kyD6eV9j47WqXrNJcgKZ
 kicGRtOsM9nnf4D3tZot8I5x0wUs1g8clXoxryg0C6QFl96QVzSlo5c3Uf3OTtIfiIz3pD7
 8nMQVSZtoF2TsNCRgJ3Ya0GORGhJvtH3CHs2094zkN5KU/yiw3R7xEZik6gAabX3mAJ4r5i
 vgvy26ikW5DGrFknjqXdQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3yBFFO1iW50=:4h+j5oOhlXuouq2Vc1kisf
 XDA2RalgBzAr2WFFirmJZduwjr26+J1b3nUxtzQ5/MZK0BsrKR7FpWzD8boCotIQpAj+16SYm
 n4Olj286bN9nnPPxenSmaYTTMQ6kudV4ZJnbpwLqNZ1Y4PPqiaQOhokyy9HZd0VvZz2WboFj9
 3XTSHrUwmBgZAvtotkKuMWrtGOf8OiC2dg6YO3+Y6H3JcwyG+dSNNHlruytsFQDFOXn8E/eOf
 ix35C7Iah80EmXbIvSASTOktMrIotLCP8ofCIJ6YgY7hbp9UrWqKX2RmGPOjIFCiR0gQJt5qp
 Hc5EC8yyeWbZuxGFQZhjUtW4zVMfhdMUeHPhICu3pc4eFmUWauEUM++rTDlxoZshxQINZWiuz
 g5OGwgrEVM8e5lXLJySvwSyvfw0OTALx9vTx6aIVbY4nK3nclGHCjC1dy20iT2XDbT09yNEgk
 Bg0TqhlbbUxAFZzESM2UsMGFwOLdDddvQ8+N6QOy29vSNnZsRNNCL7cUO3SawI5hStspQow5G
 j+vBlSfc3vLNAA+zb1VDCiydAYtUguwl0+fiBLavesDXh8ak7h0g8mOZvHyG9GnmZ0XFSXJDg
 KHX9ZgoN1aKOhvbf99ULGHQLIWN8IIijTDKvWkCdj70SAWx9Hury0QEazXXaZxRV0bdp0GSBM
 KPV05LSMH/gdwib7oAqNh4iOVkv6dNK23qgQWFAAwHNLhR1R6i3DCRv8QONYM7BRILaxACxCL
 yiXz2arhcEGnb3ApdiRmjpjH+DRl3qTNT25TNVbLAxBR2sdUwEUSNMz4sMbpfeYajFjyq20zv
 CNe4ePD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wt-status.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/wt-status.c b/wt-status.c
index 03754849626..0a6e16dbe0f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1168,6 +1168,7 @@ static int read_rebase_todolist(const char *fname, struct string_list *lines)
 		abbrev_sha1_in_line(&line);
 		string_list_append(lines, line.buf);
 	}
+	fclose(f);
 	return 0;
 }
 
-- 
2.12.2.windows.2.800.gede8f145e06


