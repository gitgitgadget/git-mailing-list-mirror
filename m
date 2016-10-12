Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FCDF207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 16:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755529AbcJLQlN (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 12:41:13 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36335 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755427AbcJLQlL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 12:41:11 -0400
Received: by mail-lf0-f65.google.com with SMTP id b75so7875684lfg.3
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 09:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0//+wO2nwqRr9MxBe35VfFaO6lQEL3T3Ga9QbRkZsss=;
        b=G4j9nCCgjlGwyRITy/95svj30WpwCWhcBzmgdzr09DcEqP6AOpAnLbW8cVDmOuTChg
         2tr5fJGPDHMTSuoOy4WeQp88pHQkz1tbCQSRwadeRT3LYvn7V5bhXCWkzuzgqAQG69a6
         Fm5VsdU+o+c+xFIR4sNwaswXRNNcvJVXegBgOJs9Owjjaijr8QMG+8wf/RThyUDvfxJp
         p6AsgEYuUlv0bY1rQNRuApGdE/ddklIMn/+XA94iU60aZ5hZRn3B2xGvhjxk6iLNHalW
         DiEjsnwzN8nILV+rDXzbkHR/LdCoOp/K7o3V0c0J7vzY0yMLtiFNhXBosnmMB/tb87F3
         hA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0//+wO2nwqRr9MxBe35VfFaO6lQEL3T3Ga9QbRkZsss=;
        b=ZgAqNd5CxsN1rfKmAjKBx2QtbyBC2QL1/1ALgqntHO26vYXPScyD1vG9oSpDkCnYzt
         RiAywkLucdmCkBwS06W5rVJPZX4+pgpOczKJVSC3NEdjdV8M4GxwyEiAGlEbBaTLBm+U
         SBBdEbMfTBzf5iq6DuflWsfcPn1Op2fSb9tkHFNVzaq2mQ9uv3cOTNkOrU4/inVKFlA6
         5OIkmufIA61Pf5gWtZNOI6r2uFk9AXUCX0DBfAC9C9AOuCSzHxkbmVDsj+Vznyjdu8oQ
         tWrL7//ltTFefT6ItRsxq5Lp7mOWfkbRaWnWHBKhX+QN/QngOOIqYR7GUyEXX0HsocKg
         gAtg==
X-Gm-Message-State: AA6/9RnPOFMyNRtGGQ/AbQULsHre45GadauNGkBIgSOON3l1Qyjn0mIO+Ycz4bZSRlNOxQ==
X-Received: by 10.194.63.145 with SMTP id g17mr2789979wjs.166.1476290469659;
        Wed, 12 Oct 2016 09:41:09 -0700 (PDT)
Received: from hurricane ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id h10sm14127965wje.48.2016.10.12.09.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Oct 2016 09:41:09 -0700 (PDT)
Date:   Wed, 12 Oct 2016 18:41:07 +0200
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, mtutty@gforgegroup.com, rappazzo@gmail.com
Subject: [PATCH] worktree: allow the main brach of a bare repository to be
 checked out
Message-ID: <20161012164104.zcxpcwqrp5h65qmc@hurricane>
References: <CACsJy8CmgmGLEi0xQUY9Eo-4FkA4eDNk9WJ2LtEDVFQBjbFdCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8CmgmGLEi0xQUY9Eo-4FkA4eDNk9WJ2LtEDVFQBjbFdCA@mail.gmail.com>
User-Agent: Mutt/1.6.2-neo (2016-08-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In bare repositories, get_worktrees() still returns the main repository,
so git worktree list can show it. ignore it in find_shared_symref so we
can still check out the main branch.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 t/t2025-worktree-add.sh | 8 ++++++++
 worktree.c              | 2 ++
 2 files changed, 10 insertions(+)

On Sun, 2016-10-09 at 17:52 +0700, Duy Nguyen wrote:
> On Sun, Oct 9, 2016 at 2:51 PM, Dennis Kaarsemaker > <dennis@kaarsemaker.net> wrote:
> > On Sat, 2016-10-08 at 19:30 -0500, Michael Tutty wrote:
> > > 
> > > The only exception seems to be merging to master. When I do git
> > > worktree add /tmp/path/to/worktree master I get an error:
> > > 
> > > [fatal: 'master' is already checked out at '/path/to/bare/repo']
> > > 
> > 
> > The worktree code treats the base repo as a worktree, even if it's
> > bare. For the purpose of being able to do a checkout of the main branch
> > of a bare repo, this patch should do:
> > 
> --snip--
> 
> You're fast :) I'm still studying  8d9fdd7 (worktree.c: check whether
> branch is rebased in another worktree - 2016-04-22). But yeah that
> should fix it.

OK, so here it is as a proper patch.

D.

diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 4bcc335..2996c38 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -138,6 +138,14 @@ test_expect_success 'checkout from a bare repo without "add"' '
 	)
 '
 
++test_expect_success '"add" default branch of a bare repo' '
+	(
+		git clone --bare . bare2 &&
+		cd bare2 &&
+		git worktree add ../there3 master
+	)
+'
+
 test_expect_success 'checkout with grafts' '
 	test_when_finished rm .git/info/grafts &&
 	test_commit abc &&
diff --git a/worktree.c b/worktree.c
index 5acfe4c..35e95b7 100644
--- a/worktree.c
+++ b/worktree.c
@@ -345,6 +345,8 @@ const struct worktree *find_shared_symref(const char *symref,
 
 	for (i = 0; worktrees[i]; i++) {
 		struct worktree *wt = worktrees[i];
+		if(wt->is_bare)
+			continue;
 
 		if (wt->is_detached && !strcmp(symref, "HEAD")) {
 			if (is_worktree_being_rebased(wt, target)) {
-- 
2.10.1-356-g947a599


-- 
Dennis Kaarsemaker <dennis@kaarsemaker.net>
http://twitter.com/seveas
