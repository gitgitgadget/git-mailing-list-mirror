Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D61BF1F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933760AbcHaI4o (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:56:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:52817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933889AbcHaI4l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:56:41 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MH5Sw-1brgUR3Bbe-00Dmth; Wed, 31 Aug 2016 10:56:29
 +0200
Date:   Wed, 31 Aug 2016 10:56:29 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 29/34] sequencer (rebase -i): show only failed `git commit`'s
 output
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <2b8220c24c1c9094783f7626f5f40dc2db8855c1.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:O09a9t48StolUOvfCCVJjA2YhdpR1OE/jwbmgwDEh2FL+/aT3K7
 W0EAEQaWdcHLYXHCMXx5yjs+XWR5uzDWL+2JRd3vWBlHQdOMAxEN3mb7/Ok8oobSAueESjB
 8yBiYYXmFsKQMQMbQmF+sRUqSCoaAKr3VV3dv3etBn1KLxL0y0E7vAKc3NX9fm9q83mw91c
 3COt7yOWhlNjdo6VVY/oQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZbG5nOPOj8Q=:dFRkr5mlpZsNRIuT6gwdEd
 fIq0bpzeV0wluDZhW8tb12mYM1WnK7rCOCJV1wA3e2oDQqcmD9VRm6wpeSm3TcXxaisAVlX5f
 Y+QUTEk3LE40OWuJCH3yz07PBP/fvQAx+uRPBzPFrQBBpvEE7vzUIPkkSPddkT71KVAP4n11p
 d12Rhi3diy4UZ0CTcRk8ZXpXMIjEodXLgEyuDPfiBF/Fa/M1vFZj1A0tHJWkOGgcSH5ls0M7L
 Q5NFmEXs5TjXw6323wRcezKcrMP2cfNhXcnBLR6xE4n54PrYBRlPhtl46uRufbCC1VG0MkFGW
 o3Y6zbIcR0tbsNmweNv87naM/nsG6RawBQzvw3sjlgGBxkgRXi/xgPzZhwYgccRQPcUmPJsEf
 /X+GNgrsuxwDrLPnp1AByCpDkcBngHIaauYuer4Th+CYzB1AY7RHuxohHRuwVqY8qy5NvGDPF
 Z8otbNHuqnAUSXs2EtvZpNBJH4ARC5TyFogTlVxKaECGHcASbzrbXrtFHE7F4ZANQgZDfqeL3
 nfaYeCwgYICBjXFx1fTkzhDYLjZj9/LdvsHlR3dVzM493N4kcG9nukso2czbhEyCTRMuDIp2X
 zpjJys4i9lfB8Ma69KnwYCVkVjuoRjrkiTgPvm6a2tdJl6NRsZBcWGqzijrpo8GcIvp3p4zML
 N2zqFNf013XR72XwEu3yAeDYUsTOfE3QXOGElVzRnRN2OJBfn3P/j4uR06mwYNpnV10LuR37h
 vw0OhzHTfr3tijByGHf4S7lcPwMyOUiFEt05PDidi3UIgE/rK2A6vVmRP2HPrtiZ0txv4ad6z
 Sn9EKhF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the behavior of the shell script version of the interactive
rebase, by using the `output` function defined in `git-rebase.sh`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 4c902e5..22568d2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -640,10 +640,15 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
 {
 	char **env = NULL;
 	struct argv_array array;
-	int rc;
+	int opt = RUN_GIT_CMD, rc;
 	const char *value;
 
 	if (is_rebase_i(opts)) {
+		if (!edit) {
+			opt |= RUN_COMMAND_STDOUT_TO_STDERR;
+			opt |= RUN_HIDE_STDERR_ON_SUCCESS;
+		}
+
 		env = read_author_script();
 		if (!env) {
 			const char *gpg_opt = gpg_sign_opt_quoted(opts);
@@ -688,7 +693,7 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
 	if (opts->allow_empty_message)
 		argv_array_push(&array, "--allow-empty-message");
 
-	rc = run_command_v_opt_cd_env(array.argv, RUN_GIT_CMD, NULL,
+	rc = run_command_v_opt_cd_env(array.argv, opt, NULL,
 			(const char *const *)env);
 	argv_array_clear(&array);
 	free(env);
-- 
2.10.0.rc2.102.g5c102ec


