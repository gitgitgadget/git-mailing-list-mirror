Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03B0B20401
	for <e@80x24.org>; Sat, 24 Jun 2017 12:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbdFXMMU (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 08:12:20 -0400
Received: from mout.web.de ([217.72.192.78]:56434 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751281AbdFXMMT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 08:12:19 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LopiJ-1dzzLG2as7-00gqZ8; Sat, 24
 Jun 2017 14:12:09 +0200
Subject: Re: [PATCH] sha1_name: cache readdir(3) results in
 find_short_object_filename()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
 <xmqqwp8f4mb2.fsf@gitster.mtv.corp.google.com>
 <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
 <20170615055654.efvsouhr3leszz3i@sigill.intra.peff.net>
 <ec36f9fa-5f3e-b511-3985-3d0301b4847f@web.de>
 <20170615132532.nivmj22dctowxssm@sigill.intra.peff.net>
 <b728352d-7fa5-2adb-af00-5f232b85b2bf@web.de>
 <20170618115017.wyroncb3jka6lrdt@sigill.intra.peff.net>
 <xmqqd1a0vb2t.fsf@gitster.mtv.corp.google.com>
 <d06fb033-294e-f364-3dde-394624e83cd6@web.de>
 <20170622231041.2zdjypviwmndjnsb@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2cd8a407-f9a2-687a-3c78-6b502da2ad94@web.de>
Date:   Sat, 24 Jun 2017 14:12:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170622231041.2zdjypviwmndjnsb@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:6WtGhzUNkKvDdKRX/OgM5L0wiWXzBOX7RIki7xRMOuUzBEeDQqT
 oWf24gPlq055hNB0OGs4fWPgvaHqpvwqbKq1tBvB/Zjx8pu2SFUn9kibQ7hHFVJb2mmys2V
 EsrwI7JNz28aeMxoJ/vvLMkSBXa8bVPx/Pi/aOJxtPNtcgZO2iE8sL07G4liOj79jExJzY4
 cxZK3KTplgUucgqYz7sjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mvj/IGLHWCY=:H1jbwB6XUaa01Vtmcz3IzD
 8X9y7GE3WGDKUnqa+Bzvww8yPF3GtqBFMuS5UVXbwgKGNRtlgrxbVjzOJqEQuQS+on05TRbtM
 dKDu5GQpnRbBQ77Kyqq9OOAJNb7Aad7wo+6vGLv7p23vPndR25oKqEt+YDxdmmU2qukBL//MM
 G4am9akWbFmOuxrssOqa7WQaCp5RQwsTVqhTFG/Ag7vaZsa0lG9tlQzq5POr4Zl3KtR9NGEna
 5V/5oe2k0WPeCG986MWvX37vMGJ1uEgMQRQYjLIvepkK1xwI+jcsBW3T3aJI28TpWjSrMIRSe
 1PRXSsqThtBdXfK8+AF6BJhxJgCrfqIET3p25B++qLo0xfPKk7xUq9VhH1EzJpD3db8anrCAm
 YKbQYk++u41UHI5BOALHsSy0c0gYe7QJNhwcFYDW8/RU+JWNK2EX2q9EaCOuWHzWvgJUoo7Xs
 xq6EZzNAMtlELweKSZfsKRKCVzh+KcExu5GoxtkWfm86kDQCrhTaIWnnGYD70SxG8dS1XwLCx
 kJ44N5FWaF3aq7thhw3JMCtP34jw/cjIlL+oUCoqkLfrAlMfNUb6aVHo1FdCSAuknK36CNtPI
 QXOntqNLR13wXxsNYpXhBI5nHM3FyNc1rxzSA1pR+GS9HI9eyV9nz3G2yZ4Ez8tDXrpLnSyHF
 svOh2+zfVcPi3aIbJmy/US/1Z5udw7plrXkBMWGPWn91zKPHkmW1F+wT1MoRhNw1yWjpj3ze6
 EkWnCVTelD6ZxkQ+f3Gxa7ODM3qeCgjKcNJxhrW6RKheHlmqShIwlihYccWwNv3bKtP8zoCQo
 FRDsbFL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.06.2017 um 01:10 schrieb Jeff King:
> On Thu, Jun 22, 2017 at 08:19:48PM +0200, René Scharfe wrote:
> 
>> Read each loose object subdirectory at most once when looking for unique
>> abbreviated hashes.  This speeds up commands like "git log --pretty=%h"
>> considerably, which previously caused one readdir(3) call for each
>> candidate, even for subdirectories that were visited before.
> 
> Is it worth adding a perf test that's heavy on abbreviations?

Sure.  Here's a simple one.  It currently reports for me:

Test                        origin/master     origin/next              origin/pu
---------------------------------------------------------------------------------------------
4205.1: log with %H         0.44(0.41+0.02)   0.43(0.42+0.01) -2.3%    0.43(0.43+0.00) -2.3%
4205.2: log with %h         1.03(0.60+0.42)   1.04(0.64+0.39) +1.0%    0.57(0.55+0.01) -44.7%
4205.3: log with %T         0.43(0.42+0.00)   0.43(0.42+0.01) +0.0%    0.43(0.40+0.02) +0.0%
4205.4: log with %t         1.05(0.64+0.38)   1.05(0.61+0.42) +0.0%    0.59(0.58+0.00) -43.8%
4205.5: log with %P         0.45(0.42+0.02)   0.43(0.42+0.00) -4.4%    0.43(0.42+0.01) -4.4%
4205.6: log with %p         1.21(0.63+0.57)   1.17(0.68+0.47) -3.3%    0.59(0.58+0.00) -51.2%
4205.7: log with %h-%h-%h   1.05(0.64+0.39)   2.00(0.83+1.15) +90.5%   0.69(0.66+0.02) -34.3%

origin/next has fe9e2aefd4 (pretty: recalculate duplicate short hashes),
while origin/pu has cc817ca3ef (sha1_name: cache readdir(3) results in
find_short_object_filename()).

-- >8 --
Subject: [PATCH] p4205: add perf test script for pretty log formats

Add simple performance tests for expanded log format placeholders.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/perf/p4205-log-pretty-formats.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100755 t/perf/p4205-log-pretty-formats.sh

diff --git a/t/perf/p4205-log-pretty-formats.sh b/t/perf/p4205-log-pretty-formats.sh
new file mode 100755
index 0000000000..7c26f4f337
--- /dev/null
+++ b/t/perf/p4205-log-pretty-formats.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+
+test_description='Tests the performance of various pretty format placeholders'
+
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+for format in %H %h %T %t %P %p %h-%h-%h
+do
+	test_perf "log with $format" "
+		git log --format=\"$format\" >/dev/null
+	"
+done
+
+test_done
-- 
2.13.1

