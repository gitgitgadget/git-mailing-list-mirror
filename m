Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F5D81F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 08:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfJGInk (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 04:43:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44352 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfJGInk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 04:43:40 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 97B8C1F4BD;
        Mon,  7 Oct 2019 08:43:39 +0000 (UTC)
Date:   Mon, 7 Oct 2019 08:43:39 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 21/20] convert: drop invalid comment for subprocess_entry
Message-ID: <20191007084339.GA7808@dcvr>
References: <20191006233043.3516-1-e@80x24.org>
 <20191006233043.3516-21-e@80x24.org>
 <xmqqeezp490w.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeezp490w.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> > Comments stating that "struct hashmap_entry" must be the first
> > member in a struct are no longer valid.
> 
> After this patch, there is one "/* must be the first member! */"
> comment left in convert.c, which is both misleading and unfortunate;
> a structure 'subprocess_entry' wants to be the first field of any
> enclosing structure, where 'subprocess_entry' has a hashmap_entry as
> its first field.

Oops, I was only grepping for hashmap_entry :x
Thanks for the sharp eyes :>

Also, the first member requirement for the oidmap stuff could be
lifted sometime in the future...

----8<-----
Subject: [PATCH] convert: drop invalid comment for subprocess_entry

"struct hashmap_entry" inside "struct subprocess_entry"
no longer needs to be the first member of any struct,
so the old comment is no longer true.

Signed-off-by: Eric Wong <e@80x24.org>
Reported-by: Junio C Hamano <gitster@pobox.com>
---
 convert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index 94ff837649..93c1e1eae9 100644
--- a/convert.c
+++ b/convert.c
@@ -753,7 +753,7 @@ static int apply_single_file_filter(const char *path, const char *src, size_t le
 #define CAP_DELAY    (1u<<2)
 
 struct cmd2process {
-	struct subprocess_entry subprocess; /* must be the first member! */
+	struct subprocess_entry subprocess;
 	unsigned int supported_capabilities;
 };
 
