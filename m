Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A26C2035F
	for <e@80x24.org>; Fri, 11 Nov 2016 16:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934226AbcKKQ3v (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 11:29:51 -0500
Received: from mout.gmx.net ([212.227.17.22]:52168 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933380AbcKKQ3u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 11:29:50 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOOJl-1c8FNM45bh-005oan; Fri, 11
 Nov 2016 17:29:38 +0100
Date:   Fri, 11 Nov 2016 17:29:33 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH] mingw: hot-fix t5615
Message-ID: <f4336a7fa3df8c0b426c3d01ada8d7d8f38e588a.1478881741.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uBtpzlSyMrvN0czgIGuYTWz7Wtv8AwGM1MuP2zumRLvxx0UH3hy
 FzlPqC79bkJ/t8Cuke0YJqJV56Pv4G5sAe7UOXMnHEoof/+NZEaKEo8VOlAaekJE3jcFvA4
 8W9dPm9VUDP7YIIRfr9f+0n1JVtrIUjmbmjhBhd8KO3ljOgdhJ0kdqARed+rPGpefzDjTjB
 RsF6Wi6MOpaK8InaR5QdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xTvYHMo/mUs=:6t9tCc1khSfUlRHhEhXPpQ
 +XUtKQopaeG2ukjj9QaCNEc6QzmPD6hR3OBXd6bzPIZkT4w9nsoaBa1r10mRNHB2UBRD5yVSZ
 EjHblM+/qNiuf1BlQ+v73TRjPGWndazSdGoUX8PcdsfJ+MQXy+WcqZSIXkbOJOxvjQguTqNCk
 r39kSfhp0QRuVIUFW/zlmkLqwSqyuhU6pf91rb9qdoBGGXR4a8JsoTutJ22AelXN3WmBSKKXE
 BwPbSMDBKAr4h80bUj6xPTcXy6jTuqBUEu4RdaiHPe4GzdbcODjAXLE8RWaBX6+mqneEDm5Vg
 WBs+EX8olpnCpQE9NjiqpsyGzH1dhTWmPCZfz7u1hXBgr5A5aWgpYaScyU64ykYWMlEv0puHa
 MlhP3FUOLTJmxQzhKA5DlkMPu6nrTao2kUugiB6pjXJzUUjkxKs7pbFZxwx0GwdBr4/Ey2Cu2
 c/zDDyffe1FRwp0A+F33aGnpmHBLiNmD4sv939DkhqrWpmLIs5F3QKNVqNS8VwzwsUxaRy1Qg
 zO2ZfAEiVTNQsr43ztcVOibWDhy5rYq+MzGf614iegMmfw++ShatwVViPNIO44PigtT7KkGZR
 FPGClMXu3nRV5g4bDPYA9l+9aGk5WPTedAVWpH+4eDJAqom5pcwe5JNAYTfyhjsOsr6avJVTc
 87oYANbzlQoUu9shcGui8yX+z4WpDBrDJ+kipE4rAPGQetqSstejrnPAXabdZA2jbV0HTUg5F
 O2iUXAmAD4ebNBOA6Pxl/tTizHuQcHZTv4uysxGqnVzM7+jQ+0IDZ8Y25haug/28TEfPyL+3d
 GVWMLQt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That test made the incorrect assumption that the path separator character
is always a colon. On Windows, it is a semicolon instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/t5615-path-separator-v1
Fetch-It-Via: git fetch https://github.com/dscho/git t5615-path-separator-v1

	This is required, but not sufficient, to fix `master` on Windows.

 t/t5615-alternate-env.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t5615-alternate-env.sh b/t/t5615-alternate-env.sh
index 22d9d81..3aeffb6 100755
--- a/t/t5615-alternate-env.sh
+++ b/t/t5615-alternate-env.sh
@@ -37,8 +37,10 @@ test_expect_success 'access alternate via absolute path' '
 	EOF
 '
 
+sep=:
+test_have_prereq !MINGW || sep=\;
 test_expect_success 'access multiple alternates' '
-	check_obj "$(pwd)/one.git/objects:$(pwd)/two.git/objects" <<-EOF
+	check_obj "$(pwd)/one.git/objects$sep$(pwd)/two.git/objects" <<-EOF
 	$one blob
 	$two blob
 	EOF

base-commit: 0538b84027a8aba7e8b805e3ec8fceb3990023e5
-- 
2.10.1.583.g721a9e0
