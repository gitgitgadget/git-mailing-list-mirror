Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8666B20259
	for <e@80x24.org>; Tue,  6 Dec 2016 12:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752798AbcLFMy3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 07:54:29 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36550 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752298AbcLFMy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 07:54:27 -0500
Received: by mail-pg0-f66.google.com with SMTP id x23so19826332pgx.3
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 04:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZAiFH6DyF/qbdxNpjSpLzyEFwkk4IYKPws5gdkLm1CI=;
        b=dWcHgCm8Fkw5I7kQxeP7LZ1bGicxsr8YCCK33/6CWcj2RM8VCh9Yx2V2d5c+eKtYIY
         t90SJNiTA8EXKymZlXfuWoDli2LRHQp3J4P+czRCVp8yR4jZZrEPD4kOpBwI9hX+Dmsn
         2JSlTlDuCKENKwQHEdAgtHKfTrpXOjltpYxrbR/hCUNc9L2/ElQmLGT4zGY9UoL5Rz2R
         svPT6E0TB//nKu747elFdA0u/tXWVtZ8FqdC9dkLlyeK18KUyu/yjhGWml6wi9k+D+oK
         2nIw1LPSLKzwTi1BmgwVOH7VJTo/Af7oFsobziGFFHbgxOG24sj9IibTRna/l5U3D1yy
         yLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZAiFH6DyF/qbdxNpjSpLzyEFwkk4IYKPws5gdkLm1CI=;
        b=YijHRKpG1fbsiAn1PVNEyNv7QnM94IDOXNz/tQoQOkqjIliX2XxYjWFLP0Kf4WJjBE
         Q55MG+K3s+ZfUutxESE/jr4OFosNSxY9BLYEh0RXbAPdDDvkSCC8CTMuXS6TGiCAn3f4
         geCFy4rJa4OC1qel7aJ5G1/aObxN6B4jJe/bLaifP0wL9kP6q78JmZsawY5t8nD3U2G3
         shLoUBsW2JCx+QKYlXHdx/vDMqHi4pjG2CgAm8Lv23wXJjE2OMfqRHGb/WFzK8YiErxG
         2JWRgYOPkfxCl1twrdmXjrUU3omlhE7PpeeMAq2tS72Vwpt06n8oinLXPcH4ndkXD0qW
         wI3g==
X-Gm-Message-State: AKaTC00ksGXSCEexT5dZZRt9ubd6fNbf0w8ulgBBshUJzM701Y4hS5ID6aHzwCFULBOcPg==
X-Received: by 10.98.82.65 with SMTP id g62mr62725108pfb.119.1481028863090;
        Tue, 06 Dec 2016 04:54:23 -0800 (PST)
Received: from ash ([115.73.166.29])
        by smtp.gmail.com with ESMTPSA id x4sm35021044pgc.14.2016.12.06.04.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2016 04:54:22 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 06 Dec 2016 19:54:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     rv@rasmusvillemoes.dk, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 6/6] shallow.c: remove useless code
Date:   Tue,  6 Dec 2016 19:53:39 +0700
Message-Id: <20161206125339.16803-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161206125339.16803-1-pclouds@gmail.com>
References: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
 <20161206125339.16803-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some context before we talk about the removed code.

This paint_down() is part of step 6 of 58babff (shallow.c: the 8 steps
to select new commits for .git/shallow - 2013-12-05). When we fetch from
a shallow repository, we need to know if one of the new/updated refs
needs new "shallow commits" in .git/shallow (because we don't have
enough history of those refs) and which one.

The question at step 6 is, what (new) shallow commits are required in
other to maintain reachability throughout the repository _without_
cutting our history short? To answer, we mark all commits reachable from
existing refs with UNINTERESTING ("rev-list --not --all"), mark shallow
commits with BOTTOM, then for each new/updated refs, walk through the
commit graph until we either hit UNINTERESTING or BOTTOM, marking the
ref on the commit as we walk.

After all the walking is done, we check the new shallow commits. If we
have not seen any new ref marked on a new shallow commit, we know all
new/updated refs are reachable using just our history and .git/shallow.
The shallow commit in question is not needed and can be thrown away.

So, the code.

The loop here (to walk through commits) is basically

1.  get one commit from the queue
2.  ignore if it's SEEN or UNINTERESTING
3.  mark it
4.  go through all the parents and..
5a. mark it if it's never marked before
5b. put it back in the queue

What we do in this patch is drop step 5a because it is not
necessary. The commit being marked at 5a is put back on the queue, and
will be marked at step 3 at the next iteration. The only case it will
not be marked is when the commit is already marked UNINTERESTING (5a
does not check this), which will be ignored at step 2.

But we don't care about refs marking on UNINTERESTING. We care about the
marking on _shallow commits_ that are not reachable from our current
history (and having UNINTERESTING on it means it's reachable). So it's
ok for an UNINTERESTING not to be ref-marked.

Reported-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 shallow.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/shallow.c b/shallow.c
index beb967e..11f7dde 100644
--- a/shallow.c
+++ b/shallow.c
@@ -512,12 +512,8 @@ static void paint_down(struct paint_info *info, const unsigned char *sha1,
 			    oid_to_hex(&c->object.oid));
 
 		for (p = c->parents; p; p = p->next) {
-			uint32_t **p_refs = ref_bitmap_at(&info->ref_bitmap,
-							  p->item);
 			if (p->item->object.flags & SEEN)
 				continue;
-			if (*p_refs == NULL || *p_refs == *refs)
-				*p_refs = *refs;
 			commit_list_insert(p->item, &head);
 		}
 	}
-- 
2.8.2.524.g6ff3d78

