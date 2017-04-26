Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAC8B207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967217AbdDZUUD (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:20:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:50862 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967214AbdDZUUB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:20:01 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lbujs-1dmkJg3NtE-00jFkf; Wed, 26
 Apr 2017 22:19:52 +0200
Date:   Wed, 26 Apr 2017 22:19:53 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/26] difftool: close file descriptors after reading
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <c634ea5dad0ce1c1f424f54a12a5614e6fa4a847.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:85snzmnzIJEhnPb0XqYKbd8BiXFP1zb1e7Qm7xiE6G08MSlpVUY
 XXJyK/R+caWT09Hfnd7d1D8bp1H121gV0oQem1T9hTqev2oXsecyShTIi3yIqkznqMBvPQM
 MbTNNIpJDqDjo67PlhsdQT4azbl3ZG9OwsdSgLbjhrVclq0mOMBf6yxRrjuR4MiOVyY8cZF
 Ve64qm1YrutTwNduQeHCQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N04GJOso/lk=:gIwn6m1hDgZqCtEa6msBCP
 0NvXyFO/oLOlD+Ei2WgkCFLDHplLQB3GUtimkVLApYn7xdbtLZUyincApTuQuQ7vX/bphwLkB
 HRW/PNJo1qPBlkX9mD3wlPKg4THXntn2naF/o+FX41jE67ZD5CwCpl75rcxWwGG6lxcy+nMpe
 gE86sqVe9z4lM1lv6miiKsq9a0/VwByed76gvOuVJL7hm8cxyJPvI1MolAMCmLJmmR9hRo5J4
 D9Edv0LsHEXP3cwj7Dgtw8h1c5N3R9X5hkenvK4M+A8ctMGxTAkmMIMZ31BS+e8Vm5107uYYu
 rniC3bu9NiUAgV4BBW+Gw3x3twJUrzmN2QTsgWMU31Z6P5xlIZ4a0SDALV0Jro4G0Xo78P81u
 HWhq+iu0DCfHHrEUveopLf5qW+dkprWqTOPia9y5rTWLVZvIYhXV1ztC425iAWlH17AcdRp+b
 Qi2RrEI4Ed5kT/HrRyM4wPKNUAVbwUXnCOpZHXBBdyQMj2KaBlswxCgCsmMDHsQzxAfC9fPEa
 gk8YkuH8LKdBeWhwPOQKADUOrlX0U1WCdHp0NvgCnYazzJLl4vRypbD16AQcTeAqkP8JFGPZ9
 bS8S/38MY1IETqmNy/l46W0PTnLBDegXjeQq0hhb5N3OOXksQ0MJNzmzfAbQCP/JI3Gx9v3OS
 6qyXDrsntGCJPWyUxrWV0CqnB/thEOmsjuQLE6l61KCkRGRMFskqC+xsI0f1Vi5KNMqxdDz22
 DecRCAoA0AeNxJohJmirAnIa9qM0eWy3zsHP+r1DqSQXxGCKmrBBwQ302QYl6RwgR2y2kYFGb
 AOj7KJV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Spotted by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/difftool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 1354d0e4625..a4f1d117ef6 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -226,6 +226,7 @@ static void changed_files(struct hashmap *result, const char *index_path,
 		hashmap_entry_init(entry, strhash(buf.buf));
 		hashmap_add(result, entry);
 	}
+	fclose(fp);
 	if (finish_command(&diff_files))
 		die("diff-files did not exit properly");
 	strbuf_release(&index_env);
@@ -497,6 +498,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		}
 	}
 
+	fclose(fp);
 	if (finish_command(&child)) {
 		ret = error("error occurred running diff --raw");
 		goto finish;
-- 
2.12.2.windows.2.800.gede8f145e06


