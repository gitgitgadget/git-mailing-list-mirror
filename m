Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75440C4741F
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 15:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A25F20759
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 15:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGnbQ93N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbgKEPXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 10:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbgKEPXf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 10:23:35 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC7AC0613CF
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 07:23:34 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id w4so1599539pgg.13
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 07:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=opaSRc8VaDzY7pASrwzSAOKyIEhO4XED3qgyemTpFt0=;
        b=cGnbQ93Ns3al4GR3sOsKwLJHDDpLF0DssH0OMiKL7xiSQWGdmuJ78xC/J2iR7p+8k2
         bYkP0gy0y71+tA2rzEDeHIYlMxjoLuPI6E8X+4q12Izi2zsU3VD/iRcfboQiFpkLAS10
         qrStPmApGpccmsCDDSktcZXx1CDJHTJ7V/iv7dzm/bMgZj/X8dg2bQmkjXxOqlp6Sj1p
         pVUnz4b3bnEFrmCjRO0lHVrPMxs1lXytoyWr5n4AEAHpgTcikOF/90IKPWe+kUK5JYu7
         usjo2Dk1PmWvxD/vhRhLZNZ6bG2cCPJ7aRMBKDqUSRgkiRwMWlE1xMYs/Ve1gc94+Yg3
         jKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=opaSRc8VaDzY7pASrwzSAOKyIEhO4XED3qgyemTpFt0=;
        b=nbgfZJvUnauSR++HAN7b9+XlWtueCg+e1ZTtQmHPanM/ewCA3c9l6ihCJcAzLXQBkB
         6XLRm7/rvcdgGyajLRnpQ1PxglzmdyQMoXI8xgBS6bHtKkAq61EAUTsXv9b+MPwQFzhx
         VSWZcRxVlf46mMZ4xE/+knLWnU1hUFemKKgGSoSxOalreegLZsEqVddvt7X7zgy8Dx5z
         i+YgNEEf7jLNlTb4uDHy9LOuJC3h0tr32RDrEIZFCoQHE5cOySetQdBCa3P9goSX8oIm
         4fBiAVS7gdWR9UPG2zPYm387Q6sGZsPS6dkEyYKnjOl3aFc6eLGzoAA2g/2xoPc5bvq0
         JgiA==
X-Gm-Message-State: AOAM5330ei2XcmCK/zwenVquMPunomgRgRSxg0i/v/qaCbLmRMxzr8JB
        kia4Y6SN4tVVUmm4WRcJ6Bs=
X-Google-Smtp-Source: ABdhPJwVQYEL2bbKjwiCj9+A+YfgD4szcUmCEvBCkYH0Dm88xVtMUWT35JbRsJLtW9OIUjgRH0snZA==
X-Received: by 2002:a63:7744:: with SMTP id s65mr2839524pgc.396.1604589814204;
        Thu, 05 Nov 2020 07:23:34 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id s11sm2821592pjm.4.2020.11.05.07.23.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 07:23:33 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [RFC PATCH] t5411: fix broken pipe write error on proc-receive
Date:   Thu,  5 Nov 2020 10:23:29 -0500
Message-Id: <20201105152329.12736-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <CANYiYbFcXN_ARmZ70GQkrQ=uFaf7YPObYcopEOFseON6TQzNpQ@mail.gmail.com>
References: <CANYiYbFcXN_ARmZ70GQkrQ=uFaf7YPObYcopEOFseON6TQzNpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Johannes found a flaky hang in t5411 in the osx-clang job of the CI/PR
builds, and ran into this issue using `--stress` option with the
following errror messages:

    fatal: unable to write flush packet: Broken pipe
    send-pack: unexpected disconnect while reading sideband packet
    fatal: the remote end hung up unexpectedly

In this test case, the "proc-receive" hook sends an error message and
dies earlier. While "receive-pack" on the other side of the pipe
should forward the error message of the "proc-receive" hook to the
client side, but there is no such error message in output. It seems
that the expected error message is overridden by the broken pipe error
message. The broken pipe error is because "receive-pack" sends other
commands to the "proc-receive" hook, but the hook dies earlier.

To fix this issue, these changes are made:

1. In "receive-pack", close the input stream for the "proc-receive" hook
   before reading result from "proc-receive".

2. The test helper for "proc-receive" consumes the input stream before
   it die earlier.

Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/receive-pack.c            | 4 +++-
 t/helper/test-proc-receive.c      | 8 +++++---
 t/t5411/test-0013-bad-protocol.sh | 3 +--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index bb9909c52e..6bd402897c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1172,6 +1172,7 @@ static int run_proc_receive_hook(struct command *commands,
 	if (version != 1) {
 		strbuf_addf(&errmsg, "proc-receive version '%d' is not supported",
 			    version);
+		close(proc.in);
 		code = -1;
 		goto cleanup;
 	}
@@ -1196,11 +1197,12 @@ static int run_proc_receive_hook(struct command *commands,
 		packet_flush(proc.in);
 	}
 
+	close(proc.in);
+
 	/* Read result from proc-receive */
 	code = read_proc_receive_report(&reader, commands, &errmsg);
 
 cleanup:
-	close(proc.in);
 	close(proc.out);
 	if (use_sideband)
 		finish_async(&muxer);
diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
index 42164d9898..132c74db52 100644
--- a/t/helper/test-proc-receive.c
+++ b/t/helper/test-proc-receive.c
@@ -79,9 +79,11 @@ static void proc_receive_read_commands(struct packet_reader *reader,
 		    *p++ != ' ' ||
 		    parse_oid_hex(p, &new_oid, &p) ||
 		    *p++ != ' ' ||
-		    die_readline)
+		    die_readline) {
+			while (packet_reader_read(reader) != PACKET_READ_EOF);
 			die("protocol error: expected 'old new ref', got '%s'",
-			    reader->line);
+				die_readline? "<call with --die-readline>": reader->line);
+		}
 		refname = p;
 		FLEX_ALLOC_STR(cmd, ref_name, refname);
 		oidcpy(&cmd->old_oid, &old_oid);
@@ -136,7 +138,7 @@ int cmd__proc_receive(int argc, const char **argv)
 		usage_msg_opt("Too many arguments.", proc_receive_usage, options);
 	packet_reader_init(&reader, 0, NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
-			   PACKET_READ_DIE_ON_ERR_PACKET);
+			   PACKET_READ_GENTLE_ON_EOF);
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 	proc_receive_verison(&reader);
diff --git a/t/t5411/test-0013-bad-protocol.sh b/t/t5411/test-0013-bad-protocol.sh
index c5fe4cb37b..ee75515430 100644
--- a/t/t5411/test-0013-bad-protocol.sh
+++ b/t/t5411/test-0013-bad-protocol.sh
@@ -91,8 +91,7 @@ test_expect_success "proc-receive: bad protocol (hook --die-readline, $PROTOCOL)
 		HEAD:refs/for/master/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-
-	grep "remote: fatal: protocol error: expected \"old new ref\", got \"<ZERO-OID> <COMMIT-A> refs/for/master/topic\"" actual &&
+	grep "remote: fatal: protocol error: expected \"old new ref\", got \"<call with --die-readline>\"" actual &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
-- 
2.29.0.dirty

