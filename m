Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADF0C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 20:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66652074B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 20:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1r/kvJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgFJU5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJU5c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 16:57:32 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1999C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 13:57:30 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id p9so3015170qtn.5
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 13:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l9fphW+aX/x4iowDIpXptpuMG5vTJ74qGiP0in+a8yc=;
        b=U1r/kvJW++qCFCVooaL5+LhhMbr5tANiRvJgPer97Jx+Euq+LvdTz3FI+4XIZbxTSG
         0EtafhNYk+cv/o6oKk/Dxvb3Ios+vCgV3WrulP8qZ4hjoXqxxqFbjDXzykSMHIW02TkZ
         ecGGccbe866YtbMvi4mEdxCVVSJQXF9MbeWnHF/cQArLfhmD1HO8fP1cVgaw1/eK9Y1c
         zRwx0ixQFcqXASd1s+StsGfhAE+v72QkXbGN/abw6aSbb/gjqQZfuMhNSIcC7xiR7XWf
         YnnFNZ+QITtlA4lpK1CosZrbJBHnHVCyt+ya9iEWc2H2k6OL8Kv7Zf2wxVjPhi1tQLl5
         l1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l9fphW+aX/x4iowDIpXptpuMG5vTJ74qGiP0in+a8yc=;
        b=AtMnyEksDVHW84gATQeXqGUEt6+wHRZRi3NvCbMD4LlPte3l+bV/P9xYzWkNdz4y5I
         2c6fUBKexQPgk5Yyjbr0+QKjQxQawbAEiBnNDq/Df5rGoXEaQgV+haMi+liJBXmoC+fx
         DJ6nyrARmUL+AImg2fsuIJ2kxrxIPxSKZwDwGmiaORN7Wzc9ZcIywKQhmMTzEdNffIOt
         eiUJNcubRpqOIy/uP48kcMiJs2eMTQpk2GjSwmIByufOHAcS+O8swsSPsTJDYFaUKEqT
         TpjdLmga/bcHufwbhVfFBp0VhtXEPJkSt6YhK47kSBVXGXHk6yx0+3fXPfLM6GjG+v9j
         shYg==
X-Gm-Message-State: AOAM530SNEvR1IK6ZYa/9Ac/il4OhrLHuhDhYTonLmrTCwcZFDAECMs8
        nk/mBeEuD2/RjDcdoif+iWHKXIO42avqJEqE0KG9XVnO+EJfYovFIakHDiECFKDUYNplnqoQMDd
        BpXdy59bN7AXfgM1bHP3hU67vMPoqgUQO6GPYkEjWij9Jd2BxWvBo8ebQdwxhu11Ogo/ah6ciiB
        Qp
X-Google-Smtp-Source: ABdhPJxWv27WW+LqWRgCsbKJqqQeTU++lMRqAUwPvUvsS/VUfqPHrHvHfsfLsJ9ZGB3VPJUdBxtT5Q3gKoO+97Be4+/b
X-Received: by 2002:ad4:52e2:: with SMTP id p2mr5036762qvu.100.1591822649902;
 Wed, 10 Jun 2020 13:57:29 -0700 (PDT)
Date:   Wed, 10 Jun 2020 13:57:15 -0700
In-Reply-To: <cover.1591821067.git.jonathantanmy@google.com>
Message-Id: <d3b27394cad951a9f1412a04572439513d7e9f4d.1591821067.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1590789428.git.jonathantanmy@google.com> <cover.1591821067.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v2 1/9] http: use --stdin when indexing dumb HTTP pack
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When Git fetches a pack using dumb HTTP, (among other things) it invokes
index-pack on a ".pack.temp" packfile, specifying the filename as an
argument.

A future commit will require the aforementioned invocation of index-pack
to also generate a "keep" file. To use this, we either have to use
index-pack's naming convention (because --keep requires the pack's
filename to end with ".pack") or to pass the pack through stdin. Of the
two, it is simpler to pass the pack through stdin.

Thus, teach http to pass --stdin to index-pack. As a bonus, the code is
now simpler.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 http.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/http.c b/http.c
index 62aa995245..39cbd56702 100644
--- a/http.c
+++ b/http.c
@@ -2270,9 +2270,9 @@ int finish_http_pack_request(struct http_pack_request *preq)
 {
 	struct packed_git **lst;
 	struct packed_git *p = preq->target;
-	char *tmp_idx;
-	size_t len;
 	struct child_process ip = CHILD_PROCESS_INIT;
+	int tmpfile_fd;
+	int ret = 0;
 
 	close_pack_index(p);
 
@@ -2284,35 +2284,24 @@ int finish_http_pack_request(struct http_pack_request *preq)
 		lst = &((*lst)->next);
 	*lst = (*lst)->next;
 
-	if (!strip_suffix(preq->tmpfile.buf, ".pack.temp", &len))
-		BUG("pack tmpfile does not end in .pack.temp?");
-	tmp_idx = xstrfmt("%.*s.idx.temp", (int)len, preq->tmpfile.buf);
+	tmpfile_fd = xopen(preq->tmpfile.buf, O_RDONLY);
 
 	argv_array_push(&ip.args, "index-pack");
-	argv_array_pushl(&ip.args, "-o", tmp_idx, NULL);
-	argv_array_push(&ip.args, preq->tmpfile.buf);
+	argv_array_push(&ip.args, "--stdin");
 	ip.git_cmd = 1;
-	ip.no_stdin = 1;
+	ip.in = tmpfile_fd;
 	ip.no_stdout = 1;
 
 	if (run_command(&ip)) {
-		unlink(preq->tmpfile.buf);
-		unlink(tmp_idx);
-		free(tmp_idx);
-		return -1;
-	}
-
-	unlink(sha1_pack_index_name(p->hash));
-
-	if (finalize_object_file(preq->tmpfile.buf, sha1_pack_name(p->hash))
-	 || finalize_object_file(tmp_idx, sha1_pack_index_name(p->hash))) {
-		free(tmp_idx);
-		return -1;
+		ret = -1;
+		goto cleanup;
 	}
 
 	install_packed_git(the_repository, p);
-	free(tmp_idx);
-	return 0;
+cleanup:
+	close(tmpfile_fd);
+	unlink(preq->tmpfile.buf);
+	return ret;
 }
 
 struct http_pack_request *new_http_pack_request(
-- 
2.27.0.278.ge193c7cf3a9-goog

