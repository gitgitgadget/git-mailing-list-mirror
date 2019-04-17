Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D40BE20248
	for <e@80x24.org>; Wed, 17 Apr 2019 08:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbfDQIR7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 04:17:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36072 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQIR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 04:17:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so2403020wml.1
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 01:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=C8Ea5VzNr37mXGsqz1NkXxeLYQWHNMMQL2gt1ME677k=;
        b=m1mrzEjd/ChTAz6oTMZY/NReCv3R9czzcVBxMlqtWb95PSlxUc3MscHpJecrd3iXwR
         RPrVa/QClz4COtPO2k/gHhGvNWzdKb9ZG0xbZQtyQpjUv7ctyoE0KMnDnBfs7UBjHnO8
         CrlJV3v0PFPCOklM4hyn0un+QylFPWvFQHXuIStXjwGJ0dyVwH7aB5wdbXOaRV8tFaE3
         rz382mmLfYuujoKIdjyCeVExRDcgGctY5Fs4qJfQcSlF6tVVlLZZMrKvYe4mg0l1TbxI
         VfI8jFu+diQisSTfvqQwu4XfREVNXOneGZG+3n5uQdh4FsXUur8LtlkBfPt1qbo38IWk
         lIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=C8Ea5VzNr37mXGsqz1NkXxeLYQWHNMMQL2gt1ME677k=;
        b=p8Q/9temO5cep5DV8Lc7bHXDE4m48tr18wrFKuL6+VCSjqCMvFDFjgkeICIVEaTH6b
         lBgEnKfyCSjWzR1mI5wyTQG/0z9xGN8PaOFLjchg/pYcEN1vNywk9trxNBMHR4JGXYM6
         2dQllFwP5UQQUOmdyo/ul/ofb94MsZ+XgknhC9wpMv1uQxbWj9pyuqXpLRuStCl/4VyJ
         V96egxhkZSuDuAZ/ZXSe5VzhMezel2g9+8bOJ9eLcOi+TjYjai7gy7avdYNRLlf8TTVx
         iJ/VKeBlC5CmOorggWr3cdT6qyxTvfeNJIljMPmyaPUBCQfoupt0aldUEFJn/qiWgIIA
         p/bA==
X-Gm-Message-State: APjAAAUUHk7RG0o8Aji2XS9i86BiXv5BGWRsOVnByhJu3T5KZJ+Szyla
        qrUXepsEnB1k2Kws/nxwl7E=
X-Google-Smtp-Source: APXvYqzyfuS/VC/Ji2UoFLbCoIVsuxKFl5baS0Q9tzBw/cb74uRMiGdhgSEQSkkS5twpSFqT77bzyA==
X-Received: by 2002:a7b:ca49:: with SMTP id m9mr29196285wml.61.1555489076819;
        Wed, 17 Apr 2019 01:17:56 -0700 (PDT)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id t81sm3264306wmb.5.2019.04.17.01.17.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Apr 2019 01:17:55 -0700 (PDT)
Date:   Wed, 17 Apr 2019 10:17:54 +0200
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/1] Fix %(push:track) in ref-filter
Message-ID: <20190417081754.bd27mjxjx7qdxhty@doriath>
References: <20190415210416.7525-1-damien.olivier.robert+git@gmail.com>
 <20190415210416.7525-2-damien.olivier.robert+git@gmail.com>
 <20190415220108.GD28128@sigill.intra.peff.net>
 <20190416123944.vtoremaitywtmkhj@mithrim>
 <20190416214842.GA21429@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416214842.GA21429@sigill.intra.peff.net>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Wed, 17 Apr 2019 10:02:14 +0200
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Jeff King, Tue 16 Apr 2019 at 17:48:43 (-0400) :
> The name "compare_info" is a bit vague. Perhaps "stat_branch_pair" or
> something would be more descriptive.

Done.
 
>  ref-filter: use correct branch for %(push:track)

Done.

> s/refer/&s/
> s/change/&s/

Grmf, thanks.

> Is it worth changing "upstream_name" since it sometimes is now not
> %(upstream)?

Changed to tracking_name.

> Leftover stray whitespace?

Oups.
 
> For any one of those nits I'd probably say it was not worth a re-roll
> (and the maintainer could adjust them when he picks up the patch).  But
> there are just enough that it's probably worth making his life easier
> with a v3.
> You can put my Reviewed-by on it, too. :)

Here it is:

---- >8 ----
From: Damien Robert <damien.olivier.robert+git@gmail.com>
Date: Tue, 16 Apr 2019 14:16:46 +0200
Subject: [PATCHv3 1/1] ref-filter: use correct branch for %(push:track)

In ref-filter.c, when processing the atom %(push:track), the
ahead/behind values are computed using `stat_tracking_info` which refers
to the upstream branch.

Fix that by introducing a new flag `for_push` in `stat_tracking_info`
in remote.c, which does the same thing but for the push branch.
Update the few callers of `stat_tracking_info` to handle this flag. This
ensure that whenever we use this function in the future, we are careful
to specify is this should apply to the upstream or the push branch.

This bug was not detected in t/t6300-for-each-ref.sh because in the test
for push:track, both the upstream and the push branches were behind by 1
from the local branch. Change the test so that the upstream branch is
behind by 1 while the push branch is ahead by 1. This allows us to test
that %(push:track) refers to the correct branch.

This changes the expected value of some following tests (by introducing
new references), so update them too.

Reviewed-by: Jeff King <peff@peff.net>
Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 ref-filter.c            |  6 ++--
 remote.c                | 68 ++++++++++++++++++++++++++++-------------
 remote.h                |  3 +-
 t/t6300-for-each-ref.sh | 13 ++++++--
 wt-status.c             |  4 +--
 5 files changed, 66 insertions(+), 28 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3aca105307..31af81fb28 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1392,7 +1392,8 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		*s = show_ref(&atom->u.remote_ref.refname, refname);
 	else if (atom->u.remote_ref.option == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours, &num_theirs,
-				       NULL, AHEAD_BEHIND_FULL) < 0) {
+				       NULL, atom->u.remote_ref.push,
+				       AHEAD_BEHIND_FULL) < 0) {
 			*s = xstrdup(msgs.gone);
 		} else if (!num_ours && !num_theirs)
 			*s = xstrdup("");
@@ -1410,7 +1411,8 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		}
 	} else if (atom->u.remote_ref.option == RR_TRACKSHORT) {
 		if (stat_tracking_info(branch, &num_ours, &num_theirs,
-				       NULL, AHEAD_BEHIND_FULL) < 0) {
+				       NULL, atom->u.remote_ref.push,
+				       AHEAD_BEHIND_FULL) < 0) {
 			*s = xstrdup("");
 			return;
 		}
diff --git a/remote.c b/remote.c
index 9cc3b07d21..0761d1ab21 100644
--- a/remote.c
+++ b/remote.c
@@ -1880,37 +1880,27 @@ int resolve_remote_symref(struct ref *ref, struct ref *list)
 }
 
 /*
- * Lookup the upstream branch for the given branch and if present, optionally
- * compute the commit ahead/behind values for the pair.
+ * Compute the commit ahead/behind values for the pair branch_name, base.
  *
  * If abf is AHEAD_BEHIND_FULL, compute the full ahead/behind and return the
  * counts in *num_ours and *num_theirs.  If abf is AHEAD_BEHIND_QUICK, skip
  * the (potentially expensive) a/b computation (*num_ours and *num_theirs are
  * set to zero).
  *
- * The name of the upstream branch (or NULL if no upstream is defined) is
- * returned via *upstream_name, if it is not itself NULL.
- *
- * Returns -1 if num_ours and num_theirs could not be filled in (e.g., no
- * upstream defined, or ref does not exist).  Returns 0 if the commits are
- * identical.  Returns 1 if commits are different.
+ * Returns -1 if num_ours and num_theirs could not be filled in (e.g., ref
+ * does not exist).  Returns 0 if the commits are identical.  Returns 1 if
+ * commits are different.
  */
-int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
-		       const char **upstream_name, enum ahead_behind_flags abf)
+
+static int stat_branch_pair(const char *branch_name, const char *base,
+			     int *num_ours, int *num_theirs,
+			     enum ahead_behind_flags abf)
 {
 	struct object_id oid;
 	struct commit *ours, *theirs;
 	struct rev_info revs;
-	const char *base;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
-	/* Cannot stat unless we are marked to build on top of somebody else. */
-	base = branch_get_upstream(branch, NULL);
-	if (upstream_name)
-		*upstream_name = base;
-	if (!base)
-		return -1;
-
 	/* Cannot stat if what we used to build on no longer exists */
 	if (read_ref(base, &oid))
 		return -1;
@@ -1918,7 +1908,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	if (!theirs)
 		return -1;
 
-	if (read_ref(branch->refname, &oid))
+	if (read_ref(branch_name, &oid))
 		return -1;
 	ours = lookup_commit_reference(the_repository, &oid);
 	if (!ours)
@@ -1932,7 +1922,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	if (abf == AHEAD_BEHIND_QUICK)
 		return 1;
 	if (abf != AHEAD_BEHIND_FULL)
-		BUG("stat_tracking_info: invalid abf '%d'", abf);
+		BUG("stat_branch_pair: invalid abf '%d'", abf);
 
 	/* Run "rev-list --left-right ours...theirs" internally... */
 	argv_array_push(&argv, ""); /* ignored */
@@ -1966,6 +1956,42 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return 1;
 }
 
+/*
+ * Lookup the tracking branch for the given branch and if present, optionally
+ * compute the commit ahead/behind values for the pair.
+ *
+ * If for_push is true, the tracking branch refers to the push branch,
+ * otherwise it refers to the upstream branch.
+ *
+ * The name of the tracking branch (or NULL if it is not defined) is
+ * returned via *tracking_name, if it is not itself NULL.
+ *
+ * If abf is AHEAD_BEHIND_FULL, compute the full ahead/behind and return the
+ * counts in *num_ours and *num_theirs.  If abf is AHEAD_BEHIND_QUICK, skip
+ * the (potentially expensive) a/b computation (*num_ours and *num_theirs are
+ * set to zero).
+ *
+ * Returns -1 if num_ours and num_theirs could not be filled in (e.g., no
+ * upstream defined, or ref does not exist).  Returns 0 if the commits are
+ * identical.  Returns 1 if commits are different.
+ */
+int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
+		       const char **tracking_name, int for_push,
+		       enum ahead_behind_flags abf)
+{
+	const char *base;
+
+	/* Cannot stat unless we are marked to build on top of somebody else. */
+	base = for_push ? branch_get_push(branch, NULL) :
+		branch_get_upstream(branch, NULL);
+	if (tracking_name)
+		*tracking_name = base;
+	if (!base)
+		return -1;
+
+	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
+}
+
 /*
  * Return true when there is anything to report, otherwise false.
  */
@@ -1977,7 +2003,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	char *base;
 	int upstream_is_gone = 0;
 
-	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, abf);
+	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
 	if (sti < 0) {
 		if (!full_base)
 			return 0;
diff --git a/remote.h b/remote.h
index da53ad570b..0138b3fb98 100644
--- a/remote.h
+++ b/remote.h
@@ -253,7 +253,8 @@ enum ahead_behind_flags {
 
 /* Reporting of tracking info */
 int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
-		       const char **upstream_name, enum ahead_behind_flags abf);
+		       const char **upstream_name, int for_push,
+		       enum ahead_behind_flags abf);
 int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			 enum ahead_behind_flags abf);
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 0ffd630713..d9235217fc 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -392,8 +392,15 @@ test_atom head upstream:track '[ahead 1]'
 test_atom head upstream:trackshort '>'
 test_atom head upstream:track,nobracket 'ahead 1'
 test_atom head upstream:nobracket,track 'ahead 1'
-test_atom head push:track '[ahead 1]'
-test_atom head push:trackshort '>'
+
+test_expect_success 'setup for push:track[short]' '
+	test_commit third &&
+	git update-ref refs/remotes/myfork/master master &&
+	git reset master~1
+'
+
+test_atom head push:track '[behind 1]'
+test_atom head push:trackshort '<'
 
 test_expect_success 'Check that :track[short] cannot be used with other atoms' '
 	test_must_fail git for-each-ref --format="%(refname:track)" 2>/dev/null &&
@@ -420,8 +427,10 @@ test_expect_success 'Check for invalid refname format' '
 test_expect_success 'set up color tests' '
 	cat >expected.color <<-EOF &&
 	$(git rev-parse --short refs/heads/master) <GREEN>master<RESET>
+	$(git rev-parse --short refs/remotes/myfork/master) <GREEN>myfork/master<RESET>
 	$(git rev-parse --short refs/remotes/origin/master) <GREEN>origin/master<RESET>
 	$(git rev-parse --short refs/tags/testtag) <GREEN>testtag<RESET>
+	$(git rev-parse --short refs/tags/third) <GREEN>third<RESET>
 	$(git rev-parse --short refs/tags/two) <GREEN>two<RESET>
 	EOF
 	sed "s/<[^>]*>//g" <expected.color >expected.bare &&
diff --git a/wt-status.c b/wt-status.c
index 445a36204a..5a7ec2cf99 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1851,7 +1851,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
 
 	sti = stat_tracking_info(branch, &num_ours, &num_theirs, &base,
-				 s->ahead_behind_flags);
+				 0, s->ahead_behind_flags);
 	if (sti < 0) {
 		if (!base)
 			goto conclude;
@@ -1990,7 +1990,7 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 		branch = branch_get(branch_name);
 		base = NULL;
 		ab_info = stat_tracking_info(branch, &nr_ahead, &nr_behind,
-					     &base, s->ahead_behind_flags);
+					     &base, 0, s->ahead_behind_flags);
 		if (base) {
 			base = shorten_unambiguous_ref(base, 0);
 			fprintf(s->fp, "# branch.upstream %s%c", base, eol);
-- 
Patched on top of v2.21.0-313-ge35b8cb8e2 (git version 2.21.0)

