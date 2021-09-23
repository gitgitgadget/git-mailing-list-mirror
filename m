Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CB6C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 20:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8331D6124B
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 20:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243048AbhIWUOZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 16:14:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38360 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242982AbhIWUOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 16:14:25 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 1BBE91F8C8;
        Thu, 23 Sep 2021 20:12:53 +0000 (UTC)
Date:   Thu, 23 Sep 2021 20:12:52 +0000
From:   Eric Wong <e@80x24.org>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] doc/technical: update note about core.multiPackIndex
Message-ID: <20210923201252.GA25980@dcvr>
References: <20210922221342.6867-1-e@80x24.org>
 <9ebb4c34-8cdd-3120-ff9a-0e47099c3cf6@gmail.com>
 <YUy9HzRgHU2zvI4P@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUy9HzRgHU2zvI4P@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> wrote:
> On Thu, Sep 23, 2021 at 09:47:03AM -0400, Derrick Stolee wrote:
> > On 9/22/2021 6:13 PM, Eric Wong wrote:
> > > Multi-pack-index files are used by default since
> > > commit 18e449f86b74bab35b150549c8342d252fe7ae00, so the
> > > outdated note was misleading.
> >
> > You are correct that the note is misleading, but it is still correct.
> >
> > A user can _disable_ reading MIDX files by setting core.multiPackIndex
> > to false. If this was in the user-facing docs, not the technical docs,
> > then I might push back on trying to make that distinction.
> 
> It may present a fuller picture to instead say:
> 
>   The core.multiPackIndex config setting must be on (which is the default)
>   to consume MIDX files. Setting it to `false` prevents Git from reading a
>   MIDX file, even if one exists.

Ah, thanks, I'll just use your text.

---------8<----------
Subject: [PATCH] doc/technical: update note about core.multiPackIndex

MIDX files are used by default since commit d0fa539bc569
(doc/technical: remove outdated MIDX default note, 2021-09-22)

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Eric Wong <e@80x24.org>
---
 Documentation/technical/multi-pack-index.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
index 1a73c3ee203e..86f40f24909a 100644
--- a/Documentation/technical/multi-pack-index.txt
+++ b/Documentation/technical/multi-pack-index.txt
@@ -36,7 +36,9 @@ Design Details
   directory of an alternate. It refers only to packfiles in that
   same directory.
 
-- The core.multiPackIndex config setting must be on to consume MIDX files.
+- The core.multiPackIndex config setting must be on (which is the
+  default) to consume MIDX files.  Setting it to `false` prevents
+  Git from reading a MIDX file, even if one exists.
 
 - The file format includes parameters for the object ID hash
   function, so a future change of hash algorithm does not require
