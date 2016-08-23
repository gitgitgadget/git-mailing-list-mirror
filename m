Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D508A1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753282AbcHWQOB (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:14:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:62796 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751799AbcHWQOA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:14:00 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M7Xi3-1bG0Ng0qGd-00xGVS; Tue, 23 Aug 2016 18:07:23
 +0200
Date:   Tue, 23 Aug 2016 18:07:22 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/15] sequencer: lib'ify create_seq_dir()
In-Reply-To: <cover.1471968378.git.johannes.schindelin@gmx.de>
Message-ID: <80062be27256704617280fdb479176e0d2afb4d4.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:oPQZv9gY4ztgt4ZiWQo9JeOrObtGtBEXqQG3mX68yB+ljv0IPBK
 jKZxfhyC+Sl/imDDvVHGcAtkRgCR4FVcl4NoLM6XOr/vNnC3whhosBct7n51qFdjcmIYxxo
 v8Y0mEm93IkrPa4ud2Rh9NXEtCNPw7PbUQvu12EayBM71ZkG/Peo3jUudZCE/ADNd1T765B
 avrUVw5XYI2mPwrRSBu8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oZiw6c/7rMY=:fsDO8egsqDrFWiQikdqSVv
 Qi9cp49RJpgB5f3b8GHuIg6HooAZxVcBlHD1SCHqvc0nT0WOVdi3meHOin86R+kYo451FlZef
 KAYDrDivgdRNN3EpAARwP+Jr/gAKAPxwZ9ILLcIHWyuQLbJh/NkhnEkGnbzshtiEaRHDR8msf
 btldLDRs5JxvORsUXlsu59l+XwkCmMh3XB8F1UgT1Xxw+UW9oaTdCUQh7TB5fil/ZU2KgK6VW
 Oe42DnGICkDqrLAtV4Bre6aq1T5kij3JcrQ/99s7+Tdara29NEWvkeCd5KjfHZfsC1V6eLJuA
 frjsidxnobuJoZXs6wq8uiwSUgHrczpj+aviasO3hm50BZmHe6PqRiIdSWyz2NoS9KWbqB5+1
 x3PMS4UZB4opT+iSN9JqFVbAHUUoaMDPMwKCWTkS5MeFlczKUK5ODtHdfIAU91QP/HThLJVuA
 bH2WxBarfQgANzq39qVkOSqiu7GKk8UBEUpzBpVymwvWDATo9in9l9maU5dtutP+1gujnzPEl
 4QbMaFbz8qwq7tm4kMnKiUqvQy6ctHVm35qBEhJfzI+i6wmBBJOX/f5Bb73bjad5+N8ubiggK
 idhCw8pwv+K7WXF+EBGpuELs97bPEwurztcbEAasQz8qAYNmMxaa0C4Nhma/3gZxrTeWU/iTP
 YFIB1A0iZLV60AQjKK/Q8DmBZYxENNBlmF3gFn2eMvmmLe6EiQ2mhGZHuDSnE/pNdkmF6Jp8f
 l2T6ptRmJ0A7DsUW9eE7PoH3BFK9kquixjvT1wqAdVO/gm0MsxheqvuTW474kFgMzmsVpanXn
 puoxVz0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To be truly useful, the sequencer should never die() but always return
an error.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1bcea84..1706ef4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -839,8 +839,8 @@ static int create_seq_dir(void)
 		return -1;
 	}
 	else if (mkdir(git_path_seq_dir(), 0777) < 0)
-		die_errno(_("Could not create sequencer directory %s"),
-			  git_path_seq_dir());
+		return error(_("Could not create sequencer directory %s (%s)"),
+			  git_path_seq_dir(), strerror(errno));
 	return 0;
 }
 
-- 
2.10.0.rc1.99.gcd66998


