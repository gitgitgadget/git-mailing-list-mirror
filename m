Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90AFA1FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 22:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbdLHWRE (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 17:17:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53430 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752350AbdLHWRD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 17:17:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABA7AAE2C0;
        Fri,  8 Dec 2017 17:17:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=S
        f0g2OZWLo6RaGOSzW/RT99xJCs=; b=COv3NMeTNvaZSELun5GKwNC1uXfwIOwKQ
        AfMjldMPFp2Vlm5/1RscnVB1ZN7u/ni952XEXvg8aF98bznhmxp6NFKU0gwX9Cte
        LznBv+fGSoE2hEpbaTtbWjFd+NU3mr+oJgqh7GkfV8iE6a/p4UHlpEFoIcdDiNN9
        bQ/RidWvyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=VNt
        dlPU+TVsJXnxXZpywUX4woa+1bYGlD6cMrhu4PPMKgKk1xzF/9qRD2oTkfsLT/f5
        Q04lx3T5CNTzbjbSpIkYUIRXEp/I6hX0Ybmlhv9W+j4B7NzJ/0A6bU395GptHdIk
        iuwsyYwB8ve8R6QO/7OVR/OsUnN5zx7fdUv8O3qw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0C4FAE2BF;
        Fri,  8 Dec 2017 17:17:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 27A5CAE2BD;
        Fri,  8 Dec 2017 17:17:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] t6120: fix under gettext-poison
Date:   Fri, 08 Dec 2017 14:17:00 -0800
Message-ID: <xmqqa7ys7tlv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83F47956-DC65-11E7-ABCD-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll queue this on top so that 'pu' would have one fewer breakage at
Travis.

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 4668f0058e..3e3fb462a0 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -341,7 +341,7 @@ test_expect_success 'describe directly tagged blob' '
 test_expect_success 'describe tag object' '
 	git tag test-blob-1 -a -m msg unique-file:file &&
 	test_must_fail git describe test-blob-1 2>actual &&
-	grep "fatal: test-blob-1 is neither a commit nor blob" actual
+	test_i18ngrep "fatal: test-blob-1 is neither a commit nor blob" actual
 '
 
 test_expect_failure ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
-- 
2.15.1-501-gdae66d7f65

