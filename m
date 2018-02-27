Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 632E71F404
	for <e@80x24.org>; Tue, 27 Feb 2018 21:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbeB0V1d (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:27:33 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54456 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbeB0V1c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 16:27:32 -0500
Received: by mail-wm0-f67.google.com with SMTP id z81so1227542wmb.4
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 13:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=T4b3pjMcMYIyluRT9cmNFsfYOK81/tLRsRmSV6PBXCs=;
        b=F3Dtlwoix4eIMLKpn1XmpMJrvO6RW+EJ+vQlVeZb5Bh2c5IGnexvSxlU+/SCaDPQWD
         uSe7PEhKYHkUyWp/Wjb79HWQQXgJn7W+oQvPLPzzYHllaYVQj0Yd/sUGd8WiubVPy8Hd
         38H+r3tgoxvksntWRje2Z6MqYa8OBa9Dcifdj9ohS1SfTCvgUq1mmqts5SGZnTXI+5p1
         B8VCMCwYYbmOe9Sw3ogDOrWRMlK8MB1wnImIsVgwd1ervRjWPA6xqALR2iO2u2J6zyPz
         mYQ30JDt+nMS+77/n8PdvOIdeVhigGoT9zYb3SIJ7m8Ydrs4rH/fD5YSpfLHysyh/m3v
         MD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=T4b3pjMcMYIyluRT9cmNFsfYOK81/tLRsRmSV6PBXCs=;
        b=lYKlXCU7696SUC00qCrVYU/+CptcGLT40VmgUIwgqr6xaru8gZvI8mwQBNuBYcDm/T
         2Xe2YACuOmFGUlArK82kMRiYrE2aGGKS0yL7y7Gp6CRDN1Vi2+V3Dp8iyf+IuMTQ1W78
         s8JqwCy2sOWUyoSLDRSAuOb2TMJ9pK0fIqKYlEiJ1C4QzKz4Q2xK3MiZtWLVBfuVhqf9
         V9epQdDRhTotBanhKaPwdBb2V77PcX+cIorT5xARbtFBRVsm9RKzw5G4QwCrpk0LPdVN
         r9ywh5oZkBRwRsHdbr/NpK88IGMv9DqYkmGFs3PNcByLhseCVJc2a52l8kP36D1adtZm
         cckA==
X-Gm-Message-State: APf1xPBHpp2AafEX2FeEse1Q4BBFs2A3dG/9NadLVtCox4u0h65dn65A
        GXZ4WyxXDlPusS5baV0S/5Oo6NWZ
X-Google-Smtp-Source: AH8x2240p4iwY62LJbofFxQzFINUGZ9/DVuwgGn/pUBaatxmD+DFuv2eJFtQ8k1uqXlhXK+O0sCJ4Q==
X-Received: by 10.28.220.66 with SMTP id t63mr11862076wmg.100.1519766850575;
        Tue, 27 Feb 2018 13:27:30 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d5sm571004wma.18.2018.02.27.13.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 13:27:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH] test_must_be_empty: make sure the file exists, not just empty
References: <20180223233951.11154-1-szeder.dev@gmail.com>
        <20180223233951.11154-5-szeder.dev@gmail.com>
        <xmqqtvu2p2kx.fsf@gitster-ct.c.googlers.com>
        <xmqqpo4qp290.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 27 Feb 2018 13:27:29 -0800
In-Reply-To: <xmqqpo4qp290.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 27 Feb 2018 13:10:51 -0800")
Message-ID: <xmqqh8q2p1ha.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The helper function test_must_be_empty is meant to make sure the
given file is empty, but its implementation is:

	if test -s "$1"
	then
		... not empty, we detected a failure ...
	fi

Surely, the file having non-zero size is a sign that the condition
"the file must be empty" is violated, but it misses the case where
the file does not even exist.  It is an accident waiting to happen
with a buggy test like this:

	git frotz 2>error-message &&
	test_must_be_empty errro-message

that won't get caught until you deliberately break 'git frotz' and
notice why the test does not fail.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib-functions.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 37eb34044a..6cfbee60e4 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -772,7 +772,11 @@ verbose () {
 # otherwise.
 
 test_must_be_empty () {
-	if test -s "$1"
+	if ! test -f "$1"
+	then
+		echo "'$1' is missing"
+		return 1
+	elif test -s "$1"
 	then
 		echo "'$1' is not empty, it contains:"
 		cat "$1"
-- 
2.16.2-325-g2fc74f41c5

