Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C11620323
	for <e@80x24.org>; Sun, 19 Mar 2017 21:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbdCSVdb (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 17:33:31 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34382 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbdCSVdb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 17:33:31 -0400
Received: by mail-wr0-f193.google.com with SMTP id u48so15849027wrc.1
        for <git@vger.kernel.org>; Sun, 19 Mar 2017 14:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gal-ro.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=/8uBRhbXlcQH+MetvYSvx3Ge657Y3/7FQDwK5TpSDu8=;
        b=cx6nV0+PpE3S+cRXqsyL/ek6LkzzWYK2V8YgwcQyM3DMtWzzpakCovIWWmAkO0HT9a
         aBofS8YlCXkKOskG9NCnIykj6ZzJOy3CSbJ6ko97VRPrpFu+2+bQAPbWT0nm1Qg6LTq6
         j3bw/lhR/1FqiUv2C3hkPs2a8ogSnpqj7gZaLYR+Ypbsk91rkGYNazVx2NRhhDS12Vmj
         o9rZKL9KqBjO1ptFHmkiKwqvaNobAMBemr1xSgItmiQ1tV0WgV+HrmKNWWYwR/ZOClim
         T1yEUVUA8NHj4gBYyqxLRwwwI5kaKn32mcKelU2Tdlx1c3SdhiP2cKMhBHs4eRBXYp/D
         od9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=/8uBRhbXlcQH+MetvYSvx3Ge657Y3/7FQDwK5TpSDu8=;
        b=AmOR1h9oYWuZ93sYkP1Zhk9zIdNPaMUg8yULqWP2qoMjg/cPVazOm0Sdn8sgik6iY9
         Ndf+w2Zex/CpslUoQF5WjPOLvnyo/M6QNxiXNnTwsxdNYPxegjISHIZnIMlUbfzlDyh3
         zG+5M1Djz3ZGVkpjL6q6oqDAui/dP/80YT6SFh6M+B8ijG/DofQNs6OIrvtA3BUPP952
         R3SRT56atf+HnM2/NfGLwW5brzrIw4Lx9BZpvq/c3HX2kUmm6yeNde5g93fwW46LLLWR
         KR1ZxWcpI2FkKvxs+O2dg7sF7JtcAaHHYXfRYk/s1WaZ7Mz4O7zu9HVzpKAUkdnpr9SX
         No2g==
X-Gm-Message-State: AFeK/H2OFqVphkGB2HPqOBkeWbieMNsfqAT9evHzAP/Jnfjb7PM1Xt3PyAh7mBqeDZPrh2uIrPt0mm3BEBwMcg==
X-Received: by 10.223.135.47 with SMTP id a44mr24420383wra.197.1489959207562;
 Sun, 19 Mar 2017 14:33:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.107.213 with HTTP; Sun, 19 Mar 2017 14:33:27 -0700 (PDT)
X-Originating-IP: [89.12.26.214]
From:   Alex Hoffman <spec@gal.ro>
Date:   Sun, 19 Mar 2017 22:33:27 +0100
X-Google-Sender-Auth: iFYVsiiCrmaAziv5G6ZjNYQ-r8o
Message-ID: <CAMX8fZU-HeKzd8VYh8R=U8f8V-px+4V==M3CJSS677K0ErwPtA@mail.gmail.com>
Subject: [PATCH] Correct compile errors when DEBUG_BISECT=1 after supporting
 other hash algorithms
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 bisect.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index 30808cadf..6feed8533 100644
--- a/bisect.c
+++ b/bisect.c
@@ -131,7 +131,7 @@ static void show_list(const char *debug, int
counted, int nr,
                unsigned flags = commit->object.flags;
                enum object_type type;
                unsigned long size;
-               char *buf = read_sha1_file(commit->object.sha1, &type, &size);
+               char *buf = read_sha1_file(commit->object.oid.hash,
&type, &size);
                const char *subject_start;
                int subject_len;

@@ -143,10 +143,10 @@ static void show_list(const char *debug, int
counted, int nr,
                        fprintf(stderr, "%3d", weight(p));
                else
                        fprintf(stderr, "---");
-               fprintf(stderr, " %.*s", 8, sha1_to_hex(commit->object.sha1));
+               fprintf(stderr, " %.*s", 8,
sha1_to_hex(commit->object.oid.hash));
                for (pp = commit->parents; pp; pp = pp->next)
                        fprintf(stderr, " %.*s", 8,
-                               sha1_to_hex(pp->item->object.sha1));
+                               sha1_to_hex(pp->item->object.oid.hash));

                subject_len = find_commit_subject(buf, &subject_start);
                if (subject_len)
-- 
2.12.0.399.g9d77b0405.dirty
