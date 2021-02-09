Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADA7C433E6
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23AC64E3C
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhBIWzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 17:55:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64361 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbhBIWRD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:17:03 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 17BD010CF77;
        Tue,  9 Feb 2021 17:15:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vANlR/sWq7LklcE9R15iAY9D96g=; b=aBaGCK
        cbDrD4t7w6mGymgNN3sETQZct+5a+bm9wWHgsodPd7u1kZ1V3OxQ+iF9XBQRhruq
        bYPuGCsKxxBgzkvTFZ07dyRzVhk0TCuMUX+xkvVh42TDPZmf64oxL0F2h8p8yfop
        AHu4SLl7GDnhBDJ1Ec96JmcRcldwcYocfCLec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Lul7b2uQoRg/i9qC3vvF3NvJR1kDO7tA
        QanB+Vu0UnxNzzStB/mK7h8WOOOiSqVFAxXM4SnDwpNUVN6BrqlUXH/sxbFulpCo
        L5BdONcKGzbvr3Kbbgu8gknQP2dgPnlPTXFhJ0fdZBl1JEBmp/FcS4LLGnW6Q/wa
        hKAkggcQp0w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0EFD110CF76;
        Tue,  9 Feb 2021 17:15:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5216610CF75;
        Tue,  9 Feb 2021 17:15:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     peff@peff.net, git@vger.kernel.org, stolee@gmail.com,
        jeffhost@microsoft.com
Subject: Re: [PATCH v2] usage: trace2 BUG() invocations
References: <YCJ6D1wGgmo1a+KT@coredump.intra.peff.net>
        <20210209193459.3100734-1-jonathantanmy@google.com>
Date:   Tue, 09 Feb 2021 14:15:47 -0800
In-Reply-To: <20210209193459.3100734-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 9 Feb 2021 11:34:59 -0800")
Message-ID: <xmqqa6sczy3w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D50F21A-6B24-11EB-9B0D-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> > +# Verb 007bug
>> > +#
>> > +# Check that BUG writes to trace2
>> > +
>> > +test_expect_success 'normal stream, exit code 1' '
>> 
>> Is this description accurate? It doesn't really seem like "exit code 1".
>> Maybe "99", though BUG is probably more accurate.
>
> Ah...you're right. Maybe 'BUG messages are written to trace2' is better.
> If Junio doesn't do it locally (or if there are other issues that need
> fixing), I'll send out v3.


Unless I forget to merge it, this is what I queued.

---- >8 -------- >8 -------- >8 -------- >8 ----
From 0a9dde4a04c1228025d292f44113cb8f9cebbfba Mon Sep 17 00:00:00 2001
From: Jonathan Tan <jonathantanmy@google.com>
Date: Fri, 5 Feb 2021 12:09:08 -0800
Subject: [PATCH] usage: trace2 BUG() invocations

die() messages are traced in trace2, but BUG() messages are not. Anyone
tracking die() messages would have even more reason to track BUG().
Therefore, write to trace2 when BUG() is invoked.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/helper/test-trace2.c   |  9 +++++++++
 t/t0210-trace2-normal.sh | 19 +++++++++++++++++++
 usage.c                  | 11 +++++++++++
 3 files changed, 39 insertions(+)

diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index 823f33ceff..f93633f895 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -198,6 +198,14 @@ static int ut_006data(int argc, const char **argv)
 	return 0;
 }
 
+static int ut_007bug(int argc, const char **argv)
+{
+	/*
+	 * Exercise BUG() to ensure that the message is printed to trace2.
+	 */
+	BUG("the bug message");
+}
+
 /*
  * Usage:
  *     test-tool trace2 <ut_name_1> <ut_usage_1>
@@ -214,6 +222,7 @@ static struct unit_test ut_table[] = {
 	{ ut_004child,    "004child",  "[<child_command_line>]" },
 	{ ut_005exec,     "005exec",   "<git_command_args>" },
 	{ ut_006data,     "006data",   "[<category> <key> <value>]+" },
+	{ ut_007bug,      "007bug",    "" },
 };
 /* clang-format on */
 
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index ce7574edb1..0cf3a63b75 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -147,6 +147,25 @@ test_expect_success 'normal stream, error event' '
 	test_cmp expect actual
 '
 
+# Verb 007bug
+#
+# Check that BUG writes to trace2
+
+test_expect_success 'BUG messages are written to trace2' '
+	test_when_finished "rm trace.normal actual expect" &&
+	test_must_fail env GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 007bug &&
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	cat >expect <<-EOF &&
+		version $V
+		start _EXE_ trace2 007bug
+		cmd_name trace2 (trace2)
+		error the bug message
+		exit elapsed:_TIME_ code:99
+		atexit elapsed:_TIME_ code:99
+	EOF
+	test_cmp expect actual
+'
+
 sane_unset GIT_TRACE2_BRIEF
 
 # Now test without environment variables and get all Trace2 settings
diff --git a/usage.c b/usage.c
index 1868a24f7a..1b206de36d 100644
--- a/usage.c
+++ b/usage.c
@@ -266,6 +266,10 @@ int BUG_exit_code;
 static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_list params)
 {
 	char prefix[256];
+	va_list params_copy;
+	static int in_bug;
+
+	va_copy(params_copy, params);
 
 	/* truncation via snprintf is OK here */
 	if (file)
@@ -274,6 +278,13 @@ static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
 		snprintf(prefix, sizeof(prefix), "BUG: ");
 
 	vreportf(prefix, fmt, params);
+
+	if (in_bug)
+		abort();
+	in_bug = 1;
+
+	trace2_cmd_error_va(fmt, params_copy);
+
 	if (BUG_exit_code)
 		exit(BUG_exit_code);
 	abort();
-- 
2.30.0-663-g458e05790b

