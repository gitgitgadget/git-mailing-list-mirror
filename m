Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011F0C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 21:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJDVN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 17:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJDVN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 17:13:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DCE6C769
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 14:13:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3576c47f204so103478057b3.2
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZNrHNLwcYwLSB8zSpMm5vf/qXi32O9SrnSy+iISizo=;
        b=ZI8Q1yWbUjBvp8mSzFHQl2Cry7vba6liuYeapo9S9tBdYSVw0rjiZNYvg+hbqnOAO3
         JYRaUPAZpFXAVdoBy64kHocD3t6hwFJMlD/iMQGQ9tnyyAmk7IN+TNNp/i9Cj4QUYvRE
         tAGaveG7xxZYYnAqLzS71SD5RKBCC34y45aalQNs2f1R93pF1MtLMtppETwADGHuEsPv
         uRs9EU2/wn1S5GkolDVBwJZ0SQjA3oSA9s/0QVB2DY1j/HES0dOVDFxRQiZon7BZo16i
         IjpfmdiAr1xIClOmhAVoz6zWS8NlUkZv8G0/8Tb9AJrAIMTxxLWvn2nDBQ4ZkQnttsFo
         CAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZNrHNLwcYwLSB8zSpMm5vf/qXi32O9SrnSy+iISizo=;
        b=Yp0UYGF0k+0d74H5F6779uP0blenACbASrtr2wQCXYpWuPE7vmnra0v8gdMwa4Cqre
         zl3ecDPXOV6wsCDn1g6TinEGMT7dmg3BJB3k8nKA/gxR35c7AK1ZnNYwaUN9R9afOEm5
         FfGiRTK9kBg8fESOeaJ9LSMUpXXrw1MWP09tA8j8Xi4w+KVEMJWskuZEj1OgMVjNwYI9
         PiZsN7tMYZNxJQtErWJ28CQMv2GH0/dTaepARzpiFkEcSu7NFu/vmKQo5Of6wB+gNyVP
         zRryod4P9n/e5QdGZnhW5WQ2WKi/QyUG+yxcBoXBzK8u7caXlujHPVeC7UsWdgDY88fk
         hiSQ==
X-Gm-Message-State: ACrzQf2PdzV0Cz0GwOZxpAhVA2VnO2C2moN7UUkofMLi4P9PaK/hTk4F
        siAy3xrIIbaJRjMhYS9ZPOH6EZFbTtB8SwZm7AAm6+jfkG+pYTaX2JoCDCPS0S8RiU95+Ui6l7j
        1bw1othAwIoiYr792ROgZMWygzRK71ol8eIfiFqq3TgWt2dScNmYkuvmDnIdylAYTwOwIp3cxQR
        YS
X-Google-Smtp-Source: AMsMyM4D1/WVnroTkpZgCwfchHCYX1PkvqII50DoasvCY6k0NvuAgfAqYvXG3hfyD0iJQIzRlQa5XSYXOlmVpNT4PVw+
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a5b:104:0:b0:6b0:429:3fe9 with SMTP
 id 4-20020a5b0104000000b006b004293fe9mr27169214ybx.543.1664918033950; Tue, 04
 Oct 2022 14:13:53 -0700 (PDT)
Date:   Tue,  4 Oct 2022 14:13:41 -0700
In-Reply-To: <cover.1664917853.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1664316642.git.jonathantanmy@google.com> <cover.1664917853.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <9bbf130c2c3d589d15811d9f83d88ec97643c1f6.1664917853.git.jonathantanmy@google.com>
Subject: [PATCH v2 2/2] promisor-remote: die upon failing fetch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a partial clone, an attempt to read a missing object results in an
attempt to fetch that single object. In order to avoid multiple
sequential fetches, which would occur when multiple objects are missing
(which is the typical case), some commands have been taught to prefetch
in a batch: such a command would, in a partial clone, notice that
several objects that it will eventually need are missing, and call
promisor_remote_get_direct() with all such objects at once.

When this batch prefetch fails, these commands fall back to the
sequential fetches. But at $DAYJOB we have noticed that this results in
a bad user experience: a command would take unexpectedly long to finish
(and possibly use up a lot of bandwidth) if the batch prefetch would
fail for some intermittent reason, but all subsequent fetches would
work. It would be a better user experience for such a command would
just fail.

Therefore, make it a fatal error if the prefetch fails and at least one
object being fetched is known to be a promisor object. (The latter
criterion is to make sure that we are not misleading the user that such
an object would be present from the promisor remote. For example, a
missing object may be a result of repository corruption and not because
it is expectedly missing due to the repository being a partial clone.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object-file.c            |  4 ----
 promisor-remote.c        | 11 ++++++++++-
 t/t0410-partial-clone.sh | 14 ++++++++++++++
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/object-file.c b/object-file.c
index 6c8e3b1660..a5e0160d28 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1599,10 +1599,6 @@ static int do_oid_object_info_extended(struct repository *r,
 		if (fetch_if_missing && repo_has_promisor_remote(r) &&
 		    !already_retried &&
 		    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
-			/*
-			 * TODO Investigate checking promisor_remote_get_direct()
-			 * TODO return value and stopping on error here.
-			 */
 			promisor_remote_get_direct(r, real, 1);
 			already_retried = 1;
 			continue;
diff --git a/promisor-remote.c b/promisor-remote.c
index 8b4d650b4c..faa7612941 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -4,6 +4,7 @@
 #include "config.h"
 #include "transport.h"
 #include "strvec.h"
+#include "packfile.h"
 
 struct promisor_remote_config {
 	struct promisor_remote *promisors;
@@ -238,6 +239,7 @@ void promisor_remote_get_direct(struct repository *repo,
 	struct object_id *remaining_oids = (struct object_id *)oids;
 	int remaining_nr = oid_nr;
 	int to_free = 0;
+	int i;
 
 	if (oid_nr == 0)
 		return;
@@ -255,9 +257,16 @@ void promisor_remote_get_direct(struct repository *repo,
 				continue;
 			}
 		}
-		break;
+		goto all_fetched;
+	}
+
+	for (i = 0; i < remaining_nr; i++) {
+		if (is_promisor_object(&remaining_oids[i]))
+			die(_("could not fetch %s from promisor remote"),
+			    oid_to_hex(&remaining_oids[i]));
 	}
 
+all_fetched:
 	if (to_free)
 		free(remaining_oids);
 }
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 1e864cf317..5b7bee888d 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -215,6 +215,20 @@ test_expect_success 'fetching of missing objects' '
 	grep "$HASH" out
 '
 
+test_expect_success 'fetching of a promised object that promisor remote no longer has' '
+	rm -f err &&
+	test_create_repo unreliable-server &&
+	git -C unreliable-server config uploadpack.allowanysha1inwant 1 &&
+	git -C unreliable-server config uploadpack.allowfilter 1 &&
+	test_commit -C unreliable-server foo &&
+
+	git clone --filter=blob:none --no-checkout "file://$(pwd)/unreliable-server" unreliable-client &&
+
+	rm -rf unreliable-server/.git/objects/* &&
+	test_must_fail git -C unreliable-client checkout HEAD 2>err &&
+	grep "could not fetch.*from promisor remote" err
+'
+
 test_expect_success 'fetching of missing objects works with ref-in-want enabled' '
 	# ref-in-want requires protocol version 2
 	git -C server config protocol.version 2 &&
-- 
2.38.0.rc1.362.ged0d419d3c-goog

