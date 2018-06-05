Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6D1B1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 21:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbeFEVk5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 17:40:57 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40891 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeFEVkz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 17:40:55 -0400
Received: by mail-pf0-f194.google.com with SMTP id z24-v6so2011799pfe.7
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 14:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kgLUHXy6IkQy46NSx/OZTHHdnpv7RttMXMznxgMv7Os=;
        b=hZ9Zx0e6IKJrApn1/NdOqSF/06OVvaRAsFudsgnWQVcv26xJe94tCpCBhc6SOtVOAk
         ofZmyFryusQMuiOxUpgxm3t6PndTXabLlAHsSK6DfdPtfHoJKFz3mabvWzb+VeY6lh7h
         q+2fan6M26s5lELLjJCp5wIZLrSgaoghYbDaUrEW5u32O8qSsd61knWB9E9NEm701kVK
         g6YkEdJIq6GLhnE+dGwgRMbjALO+mH3IGeAZSEh9G37RiYvVSEcOCSaMVomX9G85pzgj
         H9o6QXIpBaS9jQh21UJOwmK2p5cXh2xjHi7NCBfnCIHec3V3saraMgpFyMZDIJfXdgyP
         FN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kgLUHXy6IkQy46NSx/OZTHHdnpv7RttMXMznxgMv7Os=;
        b=YS1XTKkKUBDBNoBuFyRl4hyN1AeOjAZCFZA11DlKACwqU2H1aQKO7kXCwL3Eky7FIL
         GOLxSUjJmnDFAy3WOE7WGzHkGsm+fMOwGk+WvLke28rURnVd2hrM7WuNAOhelP5vfxqS
         Q/L39UnExwCgwe8wN3DqkVAWCtFeP1PckDl979I0GGYi9IxEew90PGDS4YiCTce4h5Oy
         18VA03QhXyF5Y1opTH34xBlfEoDQ9xOIM4l8uJvq3z7PkuZbtxFKJ3Nv4ftLgy8oKxXN
         p80tNVJ8znpZ3RvciSqdr3E98BMrLF9Jx58yW9436gJZepVTef73sD1ZoNCubKUCI4Yt
         WGrg==
X-Gm-Message-State: APt69E090NTzQ7oXg/6j/28oNaMp54vsUC8ue+As3IbpZtWslBeU3WKN
        VIIOzZjxh/42iOKnTTvbokWVPCTphD8=
X-Google-Smtp-Source: ADUXVKL51svtTiYg4MtAM3P3W1dtb89CnHtXMq1rRVc/XiLcmG45YpPz1MEzEyqdHPYyf9aYJwWndw==
X-Received: by 2002:a63:24c4:: with SMTP id k187-v6mr268754pgk.434.1528234854452;
        Tue, 05 Jun 2018 14:40:54 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id 76-v6sm27451138pfr.172.2018.06.05.14.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 14:40:53 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, bmwill@google.com
Subject: [PATCH v2 2/2] fetch: send "refs/tags/" prefix upon CLI refspecs
Date:   Tue,  5 Jun 2018 14:40:36 -0700
Message-Id: <c6910161aab1f383b5721bdc91969baad8c10a66.1528234587.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1528234587.git.jonathantanmy@google.com>
References: <cover.1528233146.git.jonathantanmy@google.com> <cover.1528234587.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When performing tag following, in addition to using the server's
"include-tag" capability to send tag objects (and emulating it if the
server does not support that capability), "git fetch" relies upon the
presence of refs/tags/* entries in the initial ref advertisement to
locally create refs pointing to the aforementioned tag objects. When
using protocol v2, refs/tags/* entries in the initial ref advertisement
may be suppressed by a ref-prefix argument, leading to the tag object
being downloaded, but the ref not being created.

Commit dcc73cf7ff ("fetch: generate ref-prefixes when using a configured
refspec", 2018-05-18) ensured that "refs/tags/" is always sent as a ref
prefix when "git fetch" is invoked with no refspecs, but not when "git
fetch" is invoked with refspecs. Extend that functionality to make it
work in both situations.

This also necessitates a change another test which tested ref
advertisement filtering using tag refs - since tag refs are sent by
default now, the test has been switched to using branch refs instead.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c        |  2 +-
 t/t5702-protocol-v2.sh | 24 +++++++++++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ea5b9669a..1f447f1e8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -359,7 +359,7 @@ static struct ref *get_ref_map(struct transport *transport,
 		refspec_ref_prefixes(&transport->remote->fetch, &ref_prefixes);
 
 	if (ref_prefixes.argc &&
-	    (tags == TAGS_SET || (tags == TAGS_DEFAULT && !rs->nr))) {
+	    (tags == TAGS_SET || tags == TAGS_DEFAULT)) {
 		argv_array_push(&ref_prefixes, "refs/tags/");
 	}
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 261e82b0f..b31b6d8d3 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -204,6 +204,7 @@ test_expect_success 'ref advertisment is filtered during fetch using protocol v2
 	test_when_finished "rm -f log" &&
 
 	test_commit -C file_parent three &&
+	git -C file_parent branch unwanted-branch three &&
 
 	GIT_TRACE_PACKET="$(pwd)/log" git -C file_child -c protocol.version=2 \
 		fetch origin master &&
@@ -212,9 +213,8 @@ test_expect_success 'ref advertisment is filtered during fetch using protocol v2
 	git -C file_parent log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
-	! grep "refs/tags/one" log &&
-	! grep "refs/tags/two" log &&
-	! grep "refs/tags/three" log
+	grep "refs/heads/master" log &&
+	! grep "refs/heads/unwanted-branch" log
 '
 
 test_expect_success 'server-options are sent when fetching' '
@@ -406,6 +406,24 @@ test_expect_success 'fetch supports various ways of have lines' '
 		$(git -C server rev-parse completely-unrelated)
 '
 
+test_expect_success 'fetch supports include-tag and tag following' '
+	rm -rf server client trace &&
+	git init server &&
+
+	test_commit -C server to_fetch &&
+	git -C server tag -a annotated_tag -m message &&
+
+	git init client &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
+		fetch "$(pwd)/server" to_fetch:to_fetch &&
+
+	grep "fetch> ref-prefix to_fetch" trace &&
+	grep "fetch> ref-prefix refs/tags/" trace &&
+	grep "fetch> include-tag" trace &&
+
+	git -C client cat-file -e $(git -C client rev-parse annotated_tag)
+'
+
 # Test protocol v2 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
-- 
2.17.0.768.g1526ddbba1.dirty

