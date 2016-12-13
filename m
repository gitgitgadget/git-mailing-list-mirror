Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5769D206A4
	for <e@80x24.org>; Tue, 13 Dec 2016 15:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934202AbcLMPce (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:32:34 -0500
Received: from mout.gmx.net ([212.227.15.19]:60470 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932984AbcLMPcb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:32:31 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVdfD-1c7qD21Ckp-00Z2NR; Tue, 13
 Dec 2016 16:32:15 +0100
Date:   Tue, 13 Dec 2016 16:32:00 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 28/34] run_command_opt(): optionally hide stderr when the
 command succeeds
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <1e82aeabb906a35175362418b2b4957fae50c3b0.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:26mEF4rKPpk/nmmG5fcFdH6bQADxoZQZeuo3hzPAFBWoZahYiug
 kR0oxJWIiMZ/ACI+8iZ2PKO84+yipktmaxH0N1SCSByNt7bzchpogMiwTx24FSmELHZ1Cb2
 xaOautk6SA8Y1hIYGuiAuirrlaiHRt3INpz9Hkuwgn0txftZd5XrY5ukPUA+gGDxl/M0upG
 qbaJbX4WS0jTiXIk81UNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OxfRLO6fiGg=:8ohAr58iXXpy2rLlZfYq3Q
 J+sPOjr23Eqio/2+3fhKQmO5pn8hXE8DTzAj/P8zvjwc28Mp4tZ/MY2pEhvU5LJZQ6bHczVQm
 IEgHmVUR4WGvExkicBeVFtrS4g/nuMvndq6+sNQElTg+QNgypicshbbSD2zPBxQu6tHPPUcCV
 ATPTzOcmDCGPKJgKj6Ly+/GRxPRpgEpAGgANLUHOElJDZbskF9Fiy994XmzQgjIuWx7eeUIkP
 2P13+19bh4pdKDdYcCGRFpqXDD8tFGjktgxPvsi8ArI+fUEIycJvwZEeXeNR2w6Yr+V5qmkpl
 SHG4F2mkT0+/o+XJr9UnaYYl0exQdxKLUDMfHC/cZSipPCiJyNlSgefImmzp2DgugJ7MSy6V4
 SWC9hCoDm32S4h1EuFgDFBoWSOKPUTSmCzpLaoabTAbtWEy7jX4cm0MV7N4wHrtJV7JLkXJPs
 AM2kthtlxWVmxdhy6uU+3KOW7JwYKwDbXfRzoQNMkG9W7mfpD+UQ3nn72hF+AlTHmIXIT54c9
 1hGA9AzZ48NvVAfAlTTe6+Mnh20VxPF8k06jvwpVmAnbeEdM+RgcEOXi71arUDOyz1KGVkAHN
 EwywLhwZQFM1DFtjJPuH1LJhD+TqH7Z4r2BwhhDgPNs/Zzm5+mp/hjq7bqlmb3A/GinROZ7ic
 xffIyhc+6fx9q0Jun4TO2xtMGZl+MUQr/yLUYSpCAMwhH0iFKM8Frlf99Sr40iouBk2Z1PatA
 VMfstvmaTJGT/eVuoxPHq2SQDF1VUNvNaGDPpCuWL17paYSL/c1EENtrcDrnDPXy7oRzuYe21
 s34l5Kl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will be needed to hide the output of `git commit` when the
sequencer handles an interactive rebase's script.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 run-command.c | 23 +++++++++++++++++++++++
 run-command.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/run-command.c b/run-command.c
index ca905a9e80..5bb957afdd 100644
--- a/run-command.c
+++ b/run-command.c
@@ -589,6 +589,29 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 	cmd.clean_on_exit = opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
 	cmd.dir = dir;
 	cmd.env = env;
+
+	if (opt & RUN_HIDE_STDERR_ON_SUCCESS) {
+		struct strbuf buf = STRBUF_INIT;
+		int res;
+
+		cmd.err = -1;
+		if (start_command(&cmd) < 0)
+			return -1;
+
+		if (strbuf_read(&buf, cmd.err, 0) < 0) {
+			close(cmd.err);
+			finish_command(&cmd); /* throw away exit code */
+			return -1;
+		}
+
+		close(cmd.err);
+		res = finish_command(&cmd);
+		if (res)
+			fputs(buf.buf, stderr);
+		strbuf_release(&buf);
+		return res;
+	}
+
 	return run_command(&cmd);
 }
 
diff --git a/run-command.h b/run-command.h
index dd1c78c28d..65a21ddd4e 100644
--- a/run-command.h
+++ b/run-command.h
@@ -72,6 +72,7 @@ extern int run_hook_ve(const char *const *env, const char *name, va_list args);
 #define RUN_SILENT_EXEC_FAILURE 8
 #define RUN_USING_SHELL 16
 #define RUN_CLEAN_ON_EXIT 32
+#define RUN_HIDE_STDERR_ON_SUCCESS 64
 int run_command_v_opt(const char **argv, int opt);
 
 /*
-- 
2.11.0.rc3.windows.1


