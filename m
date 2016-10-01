Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 460EE20986
	for <e@80x24.org>; Sat,  1 Oct 2016 23:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbcJAXHd (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Oct 2016 19:07:33 -0400
Received: from avasout03.plus.net ([84.93.230.244]:38422 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbcJAXHd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2016 19:07:33 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout03 with smtp
        id qP7T1t0070zhorE01P7UGo; Sun, 02 Oct 2016 00:07:29 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=YLLd8lOx c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=fHJeHCpVL1lYGcKT8XoA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] tmp-objdir: mark some file local symbols static
Message-ID: <f5560f8b-75be-faa0-ce1c-5e2716ee82a5@ramsayjones.plus.com>
Date:   Sun, 2 Oct 2016 00:07:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jeff,

If you need to re-roll your 'jk/quarantine-received-objects' branch,
could you please squash this into the relevant patches.

[I also note that tmp_objdir_destroy(), declared to be part of the
public interface, is not currently called from outside tmp_objdir.c.
Despite being unlikely, it is at least plausible that this function
may be useful in future. ;-) ]

Thanks!

ATB,
Ramsay Jones

 builtin/receive-pack.c | 2 +-
 tmp-objdir.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 25afa3f..4194088 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -87,7 +87,7 @@ static enum {
 } use_keepalive;
 static int keepalive_in_sec = 5;
 
-struct tmp_objdir *tmp_objdir;
+static struct tmp_objdir *tmp_objdir;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 2181a42..3a58404 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -17,7 +17,7 @@ struct tmp_objdir {
  * more than one, and we can expand later if so.  You can have many such
  * tmp_objdirs simultaneously in many processes, of course.
  */
-struct tmp_objdir *the_tmp_objdir;
+static struct tmp_objdir *the_tmp_objdir;
 
 static void tmp_objdir_free(struct tmp_objdir *t)
 {
-- 
2.10.0
