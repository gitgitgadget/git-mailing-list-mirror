Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BAAC433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 18:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D216141B
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 18:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346314AbhI2SpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 14:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244341AbhI2SpX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 14:45:23 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EBAC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 11:43:42 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g184so3650973pgc.6
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 11:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+nS/0LJj6EQCLFX0hMi1HGRZRYNq1KsRyYvnHaz/jJw=;
        b=X0BJlbEt9/0sOdxN0yJOpWi4C7vLN0RAkyBFqMSwrrYzqivKDwPMhyT+itPKrb020u
         3fODrVWACehgWwXEZ6tVD37IIwPBTqMqdQIpMYMD7CHVQhvG5hL5I75iKVdbnwwAE0+F
         9KuD8x81F3goxMjg5pOvuonmJFIs60eTUC8xhRwyrrYiNJ/sbjeJAJGWljVphpiN6w7X
         /9rvA9ZAt2Yy82HM4781e3J40fda+6fJKwsb5bXo6P2nEfj5gUHfkezRQSVO9aGrBL61
         BKG0FumQodMXyu1HPyjqRz4As9PjgRU5QRtgHLyCxtLRCPhYRK8HKkPuPecL1wI+oIhO
         x5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+nS/0LJj6EQCLFX0hMi1HGRZRYNq1KsRyYvnHaz/jJw=;
        b=vNIBwfyvQq7bHthzuxX9bivP1np7xkBR8c21oFYakdEmP8rm3MeHvTN+pWHNzv2wBC
         Z0M8/rxRVN8sLuLOjLFolZXxN0mEcbckpRVNX1M6ZI6qDhmvVdZ/p1gBpS+jKDnaA1CC
         D92j0tm0Yjp/ccWpwbgcxMNLEgoD+fnMwKQSic+k5EHhFbFZx9Pv8Bre4Wb3BAjZo4SA
         9Dl9kre5IPPRX2p9oHHR2bHv1j6vxIr3xKKhJQWNXOJePSveQ56MKbYxowJLoQfkRdBs
         0neNgvkHF5LmbaVSADcHvOYxpyUrDo1zKpK3BaMRg/RYqWdG3EJnE8+hw2zpyikkkvqz
         LCKw==
X-Gm-Message-State: AOAM532cijo+QR2vbPFykcOVGWfgJusJcE62dnmIYNPqBT1M17qKgv7n
        spSItOLzb5hETftimIj0VnpCwKJ5zhfRpb1b
X-Google-Smtp-Source: ABdhPJxwrATEJ3n57hZ4o1XrGZsjz1dVQ7BKBXQwa8I4/k+dgN83hkUOmBKjKSgHFfZMWaBeDFPY6g==
X-Received: by 2002:a63:374c:: with SMTP id g12mr1254139pgn.35.1632941021917;
        Wed, 29 Sep 2021 11:43:41 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-227-232.customer.broadstripe.net. [24.56.227.232])
        by smtp.gmail.com with ESMTPSA id d5sm2579763pjg.53.2021.09.29.11.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:43:41 -0700 (PDT)
Date:   Wed, 29 Sep 2021 11:43:39 -0700
From:   Neeraj Singh <nksingh85@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
Message-ID: <20210929184339.GA19712@neerajsi-x1.localdomain>
References: <xmqq8rzhmsi7.fsf@gitster.g>
 <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
 <YVOn3hDsb5pnxR53@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVOn3hDsb5pnxR53@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 07:40:14PM -0400, Jeff King wrote:
> On Mon, Sep 27, 2021 at 11:46:40PM -0700, Elijah Newren wrote:
> 
> > > * en/remerge-diff (2021-08-31) 7 commits
> > >  - doc/diff-options: explain the new --remerge-diff option
> > >  - show, log: provide a --remerge-diff capability
> > >  - tmp-objdir: new API for creating and removing primary object dirs
> > >  - merge-ort: capture and print ll-merge warnings in our preferred fashion
> > >  - ll-merge: add API for capturing warnings in a strbuf instead of stderr
> > >  - merge-ort: add ability to record conflict messages in a file
> > >  - merge-ort: mark a few more conflict messages as omittable
> > >
> > >  A new presentation for two-parent merge "--remerge-diff" can be
> > >  used to show the difference between mechanical (and possibly
> > >  conflicted) merge results and the recorded resolution.
> > >
> > >  Will merge to 'next'?
> > 
> > It has been a month that it's been cooking with no issues brought up,
> > and it's been in production for nearly a year...
> > 
> > But just this morning I pinged peff and jrnieder if they might have
> > time to respectively look at the tmp-objdir stuff (patch 5, plus its
> > integration into log-tree.c in patch 7) and the ll-merge.[ch] changes
> > (patch 3).  I don't know if either will have time to do it, but
> > perhaps wait half a week or so to see if they'll mention they have
> > time?  Otherwise, yeah, it's probably time to merge this down.
> 
> Sorry to take so long. I think this is a very exciting topic, and I
> appreciate being called into to look at tmp-objdir stuff, because it can
> be quite subtle.
> 
> I just left a rather long-ish mail in the thread, but the gist of it is
> that I'm worried that there's some possibility of corruption there if
> the diff code writes objects. I didn't do a proof-of-concept there, but
> I worked one up just now. Try this:
> 
>   # make a repo
>   git init repo
>   cd repo
>   echo base >file
>   git add file
>   git commit -m base
> 
>   # two diverging branches
>   echo main >file
>   git commit -am main
>   git checkout -b side HEAD^
>   echo side >file
>   git commit -am side
> 
>   # we get a conflict, and we resolve
>   git merge main
>   echo resolved >file
>   git commit -am merged
> 
>   # now imagine we had a file with a diff driver. I stuffed it
>   # in here after the fact, but it could have been here all along,
>   # or come as part of the merge, etc.
>   echo whatever >unrelated
>   echo "unrelated diff=foo" >.gitattributes
>   git add .
>   git commit --amend --no-edit
> 
>   # set up the diff driver not just to do a textconv, but to cache the
>   # result. This will require writing out new objects for the cache
>   # as part of the diff operation.
>   git config diff.foo.textconv "$PWD/upcase"
>   git config diff.foo.cachetextconv true
>   cat >upcase <<\EOF &&
>   #!/bin/sh
>   tr a-z A-Z <$1
>   EOF
>   chmod +x upcase
> 
>   # now show the diff
>   git log -1 --remerge-diff
> 
>   # and make sure the repo is still OK
>   git fsck
> 
> The remerge diff will correctly show the textconv'd content (because
> it's not in either parent, and hence an evil merge):
> 
>   diff --git a/unrelated b/unrelated
>   new file mode 100644
>   index 0000000..982793c
>   --- /dev/null
>   +++ b/unrelated
>   @@ -0,0 +1 @@
>   +WHATEVER
> 
> but then fsck shows that our cache is corrupted:
> 
>   Checking object directories: 100% (256/256), done.
>   error: refs/notes/textconv/foo: invalid sha1 pointer 1e9b3ecffca73411001043fe914a7ec0e7291043
>   error: refs/notes/textconv/foo: invalid reflog entry 1e9b3ecffca73411001043fe914a7ec0e7291043
>   dangling tree 569b6e414203d2f50bdaafc1585eae11e28afc37
> 
> Now I'll admit the textconv-cache is a pretty seldom-used feature. And
> that there _probably_ aren't a lot of other ways that the diff code
> would try to write objects or references. But I think it speaks to the
> kind of subtle interactions we should worry about (and certainly
> corrupting the repository is a pretty bad outcome, though at least in
> this case it's "just" a cache and we could blow away that ref manually).
> 
> -Peff

It seems to me that one problem is that the new "primary" objdir code doesn't
disable ref updates since the GIT_QUARANTINE_ENVIRONMENT setting isn't set.
If we fix that we should be forbidding ref updates.

I've included a path that fixes my test case. This is on top of:
https://lore.kernel.org/git/CANQDOddqwVtWfC4eEP3fJB4sUiszGX8bLqoEVLcMf=v+jzx19g@mail.gmail.com/

From 38be7f6d31da8df3f205b35d25dd0a505aa75a8a Mon Sep 17 00:00:00 2001
From: Neeraj Singh <neerajsi@microsoft.com>
Date: Wed, 29 Sep 2021 11:24:05 -0700
Subject: [PATCH] tmp-objdir: disable ref updates when replacing the primary
 odb

When creating a subprocess with a temporary ODB, we set the
GIT_QUARANTINE_ENVIRONMENT env var to tell child Git processes not
to update refs, since the tmp-objdir may go away.

Introduce a similar mechanism for in-process temporary ODBs when
we call tmp_objdir_replace_primary_odb.

Peff's test case was invoking ref updates via the cachetextconv
setting. That particular code silently does nothing when a ref
update is forbidden

Reported-by: Jeff King <peff@peff.net>

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 object-file.c |  7 +++++++
 refs.c        | 22 +++++++++++++++++++++-
 refs.h        |  5 +++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 990381abee..e3e5cec3c8 100644
--- a/object-file.c
+++ b/object-file.c
@@ -770,6 +770,12 @@ struct object_directory *set_temporary_primary_odb(const char *dir, int will_des
 	new_odb->will_destroy = will_destroy;
 	new_odb->next = the_repository->objects->odb;
 	the_repository->objects->odb = new_odb;
+
+	/*
+	 * Disable ref updates while a temporary odb is active, since
+	 * the objects in the database may roll back.
+	 */
+	refs_disable_updates();
 	return new_odb->next;
 }
 
@@ -786,6 +792,7 @@ void restore_primary_odb(struct object_directory *restore_odb, const char *old_p
 
 	the_repository->objects->odb = restore_odb;
 	free_object_directory(cur_odb);
+	refs_enable_updates();
 }
 
 /*
diff --git a/refs.c b/refs.c
index 8b9f7c3a80..98026b7341 100644
--- a/refs.c
+++ b/refs.c
@@ -19,6 +19,8 @@
 #include "repository.h"
 #include "sigchain.h"
 
+static int ref_update_disabled_count;
+
 /*
  * List of all available backends
  */
@@ -1045,6 +1047,24 @@ void ref_transaction_free(struct ref_transaction *transaction)
 	free(transaction);
 }
 
+void refs_disable_updates(void)
+{
+	++ref_update_disabled_count;
+}
+
+void refs_enable_updates(void)
+{
+	if (!ref_update_disabled_count)
+		BUG("ref updates are not disabled");
+
+	--ref_update_disabled_count;
+}
+
+int ref_updates_are_enabled(void)
+{
+	return !ref_update_disabled_count;
+}
+
 struct ref_update *ref_transaction_add_update(
 		struct ref_transaction *transaction,
 		const char *refname, unsigned int flags,
@@ -2126,7 +2146,7 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 		break;
 	}
 
-	if (getenv(GIT_QUARANTINE_ENVIRONMENT)) {
+	if (getenv(GIT_QUARANTINE_ENVIRONMENT) || !ref_updates_are_enabled()) {
 		strbuf_addstr(err,
 			      _("ref updates forbidden inside quarantine environment"));
 		return -1;
diff --git a/refs.h b/refs.h
index 48970dfc7e..acd7e275c5 100644
--- a/refs.h
+++ b/refs.h
@@ -840,6 +840,11 @@ int ref_storage_backend_exists(const char *name);
 
 struct ref_store *get_main_ref_store(struct repository *r);
 
+/* Helpers to mark updates to the refs as forbidden */
+void refs_disable_updates(void);
+void refs_enable_updates(void);
+int ref_updates_are_enabled(void);
+
 /**
  * Submodules
  * ----------
-- 
2.25.1

