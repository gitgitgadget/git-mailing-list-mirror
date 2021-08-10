Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B7BC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 17:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F273D60FC4
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 17:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhHJRVE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 13:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhHJRVE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 13:21:04 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19473C0613C1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 10:20:42 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id z12-20020ac8710c0000b0290291f4eb83d3so1838845qto.10
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 10:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CWB0aaevBa9ohIVgOLD2r+Y0M0llZaMV+v/YY58GAtY=;
        b=XXjndh+E1LcGGevDiWJEGdYEu+M8FJoUPTqrBd9cLCLZC13fL08vXLzTyCLw/yk5t3
         yvy/Ub+j17GU9gqymAmTp7EYDOZfGNWYIIXPHXJJ52Fygg3t1ugmK1MPzmTQIRY8om10
         bfNIxxgyowESY/mHVaqiJVpqnIpO8FhUCC8PtTVRK1cWvGcQZZE7ghEN2x4mu+0HA3NM
         CYNvI+yPkqm3X2fKsslGB2Q1onsybBnuB5C3GL3aSjGgoIAw4Xe5wlyPdjL/oj/alLOs
         9RLxwRbJse7G1oJVChWex6lhwc1DxLJodL5AKOtyxuma0jd1StGj+T1ZDcnD355LgRHz
         a6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CWB0aaevBa9ohIVgOLD2r+Y0M0llZaMV+v/YY58GAtY=;
        b=PmrVe78+dHVRkBb46Yl2Ts+8cmXBKGCB/hH7GakDO/dMXhLeydGMDM3jNmlXrAPj1l
         JXkSOdMRxioM70F4KdMomg6K9lqA+0Fe1bbn5MoLJatk3NElvTjUMuAKq4XWocN31REx
         SIzODFbulPbCFWXOwfoBKXwwQBEBf7zmRxx9d9DB7l74urrOWIvNQ57hO71gTsAD8YO1
         7pcW0yumHq3X4chFuxhcy6mX1sOy4Co9MpcfBdUR4YAO1oCeYrWSLe1Jk+w2SlDmZNkK
         zobExM//AAFndHx3r6MkdYBmhP5VlrJ2ZaX7wuUBYLTJdrMTd2dkFO5PmsCt5zAth9IQ
         oRIg==
X-Gm-Message-State: AOAM533bpFqSSvU30NvvVVV/2f+X1FFeOx8F3wx5xWxfVnohU2I0G+pN
        U8CEmg9oDh7YJDWknDLGufYjI2sb19fOBL3gMF3c+c4S1wygduTYAjiQhN3w6KZw9MxnxvTy9wF
        FRzxz5PHClKPg+tY3NRBDsXVqlKduCuV2J1KMYYLw9sp/MQiF/xKq+4ssosEpgqA=
X-Google-Smtp-Source: ABdhPJztqcWRfdbwXpFakpG19T4iIvjya+FsRZiluFYlRK2A2dBZvldQWBr6+q0rOlA5XKmdSytDzYPd0KIzPw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:3091:ffe3:3b2e:858e])
 (user=steadmon job=sendgmr) by 2002:a05:6214:285:: with SMTP id
 l5mr11490919qvv.24.1628616041230; Tue, 10 Aug 2021 10:20:41 -0700 (PDT)
Date:   Tue, 10 Aug 2021 10:20:39 -0700
In-Reply-To: <f79ab95af6da3da710da2112cfcae4a042b7f7fb.1628020616.git.steadmon@google.com>
Message-Id: <48180cecc7a8013ec19ed8fc19842d81b356ebd7.1628615309.git.steadmon@google.com>
Mime-Version: 1.0
References: <f79ab95af6da3da710da2112cfcae4a042b7f7fb.1628020616.git.steadmon@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v3] connect, protocol: log negotiated protocol version
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is useful for performance monitoring and debugging purposes to know
the wire protocol used for remote operations. This may differ from the
version set in local configuration due to differences in version and/or
configuration between the server and the client. Therefore, log the
negotiated wire protocol version via trace2, for both clients and
servers.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---

Changes in V3:
* remove unnecessary `test` calls in the new t5705 test cases
* remove the wire protocol version formatting function
* log the wire protocol version enum value directly, as in V0 of this
  series
* avoid logging the protocol version if negotiation fails (i.e., if we
  end up with "protocol_unknown_version")

Changes in V2:
* adds a format_protocol_version() helper function
* adds tests
* bug fix: actually log on the server side, rather than twice on the
  client
* moves the trace statement closer to the actual version negotiation
  code

 connect.c                             |  2 ++
 protocol.c                            |  2 ++
 t/t5705-session-id-in-capabilities.sh | 11 +++++++++++
 3 files changed, 15 insertions(+)

diff --git a/connect.c b/connect.c
index 70b13389ba..aff13a270e 100644
--- a/connect.c
+++ b/connect.c
@@ -164,6 +164,8 @@ enum protocol_version discover_version(struct packet_reader *reader)
 		BUG("unknown protocol version");
 	}
 
+	trace2_data_intmax("transfer", NULL, "negotiated-version", version);
+
 	return version;
 }
 
diff --git a/protocol.c b/protocol.c
index 052d7edbb9..c53f7df5be 100644
--- a/protocol.c
+++ b/protocol.c
@@ -73,6 +73,8 @@ enum protocol_version determine_protocol_version_server(void)
 		string_list_clear(&list, 0);
 	}
 
+	trace2_data_intmax("transfer", NULL, "negotiated-version", version);
+
 	return version;
 }
 
diff --git a/t/t5705-session-id-in-capabilities.sh b/t/t5705-session-id-in-capabilities.sh
index f1d189d5bc..eb8c79aafd 100755
--- a/t/t5705-session-id-in-capabilities.sh
+++ b/t/t5705-session-id-in-capabilities.sh
@@ -73,6 +73,17 @@ do
 		grep \"key\":\"server-sid\" tr2-client-events &&
 		grep \"key\":\"client-sid\" tr2-server-events
 	'
+
+	test_expect_success "client & server log negotiated version (v${PROTO})" '
+		test_when_finished "rm -rf local tr2-client-events tr2-server-events" &&
+		cp -r "$LOCAL_PRISTINE" local &&
+		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
+		git -c protocol.version=$PROTO -C local fetch \
+			--upload-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-upload-pack" \
+			origin &&
+		grep \"key\":\"negotiated-version\",\"value\":\"$PROTO\" tr2-client-events &&
+		grep \"key\":\"negotiated-version\",\"value\":\"$PROTO\" tr2-server-events
+	'
 done
 
 test_done
-- 
2.32.0.605.g8dce9f2422-goog

