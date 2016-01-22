From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Issue when changing staged files in a pre-commit hook
Date: Fri, 22 Jan 2016 15:58:47 +0700
Message-ID: <20160122085847.GA31700@lanh>
References: <CAPYEnzGfnRbajDQAwBTNE5XSaB0WbHKbf1heRV0bUgbq5w_A5g@mail.gmail.com>
 <CACsJy8DhiYiie7+Cw3PkPJpSX7CGp-r2Mu98mLp4OMhhGdsXgQ@mail.gmail.com>
 <xmqq1t9dbe9y.fsf@gitster.mtv.corp.google.com>
 <CACsJy8DxQnGV5JZnHuvA1Zbpf2BuGdmMF+YNiq51HNK+8vW56Q@mail.gmail.com>
 <xmqqwpr56ste.fsf@gitster.mtv.corp.google.com>
 <CACsJy8Aj+_Qra312EWRsjmebd67EFQt4RP4LWFUyXUB-QCnKvQ@mail.gmail.com>
 <xmqqk2n56n49.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Niek van der Kooy <niekvanderkooy@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 09:59:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMXYZ-00054R-6s
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 09:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbcAVI64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 03:58:56 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35992 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbcAVI6t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 03:58:49 -0500
Received: by mail-pf0-f172.google.com with SMTP id n128so38749948pfn.3
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 00:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kbGha7AeGK71CL57VHeIdyWYLcnN9LrMDjFhMeTJLUg=;
        b=gD04DM28lb376OdPH+liYHP4FAbGs3Hz6HfopLHi0+yqNhDdjUvb99xNhpT8w1hWIx
         glIwao0AqjOrbLDSMs52xPzTWot2WgGmcEzjRnZW03G+XeWvyJ9AAICLmTLZvdqCPJh0
         vn1MenptP/ZVQT4gVnZgmtH5XZbJ853SiEWli0pl3y29dueQPia+/EGxyHrzL7XvVzaK
         GCC00AkCp5qO2U7H+6JiYv7xvK3kSLBpK1wfS+vyIW5m2igtOD6FR6isscRhTh/aFUrD
         c6iFgnOd9wvIP3OQ6SxFbqyShO7z/jhg16VOZSh+stl5fxkRLYdsDM9+NPvE69mo1jrh
         s/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=kbGha7AeGK71CL57VHeIdyWYLcnN9LrMDjFhMeTJLUg=;
        b=VB0yMog4Au11/eYbEk5ZWn1EvADt0iodFJeOdnwL36kITozpQNuUPeJLh2M39/alQY
         UqzJ+YZpI8Gyg5fZbwAZG+f6+o/jik05JRaXgBhxhJFOIVgdODZj9HJTaLpw122lJdjk
         jbjXO1j8zVkZwgZTWzSBGHyCjfUwgMSUkVC+E6yNvQgluya3AR7y4a5o/6hAbKKvbmhN
         47jUFylKZHboTtrt+RyZpQ3D632THRoCxenHPmQTSy8e0Hjzc9OVM38Tnx4Ajercz/kn
         hwdC+nf2q/X7yCIMH6h/+O8AQVbpume0zbYf6KpqSffv5WEbKESfOg3aWuzt3keJMDEn
         Xu/A==
X-Gm-Message-State: AG10YOQYR9QdXYS/gU4h+JkJ5XseDCVHlDpDznIbiqZX340KmHNFvHW1m01u0LB7fdO3jg==
X-Received: by 10.98.13.7 with SMTP id v7mr2735790pfi.150.1453453128755;
        Fri, 22 Jan 2016 00:58:48 -0800 (PST)
Received: from lanh ([115.72.43.83])
        by smtp.gmail.com with ESMTPSA id h66sm7979556pfj.52.2016.01.22.00.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2016 00:58:47 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Jan 2016 15:58:47 +0700
Content-Disposition: inline
In-Reply-To: <xmqqk2n56n49.fsf@gitster.mtv.corp.google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284553>

On Tue, Jan 19, 2016 at 05:44:22PM -0800, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > On Wed, Jan 20, 2016 at 6:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> >> The only sensible thing we can do at that point in the code after
> >> re-reading the index is to make sure that hasn't been changed by the
> >> pre-commit hook and complain loudly to die if we find it modified, I
> >> think.
> >
> > OK. Two more points
> >
> >  - do we catch index changes for partial commit case only? Because
> > when $GIT_DIR/index is used, we do not have this problem.
> 
> I do not think you are correct.  As-is commit with un-added changes
> in the working tree would have the same problem.  .....

OK you convinced me that catching pre-commit modifying the index is
the best option so far. We can do something like this. You'll have to
put in the commit message though, you explain it much better than me.
No document update is necessary because the user will be informed why
git-commit fails.

-- 8< --
diff --git a/builtin/commit.c b/builtin/commit.c
index d054f84..f9f4957 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -656,6 +656,7 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 }
 
 static int prepare_to_commit(const char *index_file, const char *prefix,
+			     const unsigned char *tree_sha1,
 			     struct commit *current_head,
 			     struct wt_status *s,
 			     struct strbuf *author_ident)
@@ -928,9 +929,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 
 	/*
-	 * Re-read the index as pre-commit hook could have updated it,
-	 * and write it out as a tree.  We must do this before we invoke
-	 * the editor and after we invoke run_status above.
+	 * Re-read the index and check if pre-commit hook has updated it,
+	 * We must do this before we invoke the editor and after we
+	 * invoke run_status above.
 	 */
 	discard_cache();
 	read_cache_from(index_file);
@@ -938,6 +939,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		error(_("Error building trees"));
 		return 0;
 	}
+	if (hashcmp(active_cache_tree->sha1, tree_sha1)) {
+		error(_("pre-commit hook has changed commit content"));
+		return 0;
+	}
 
 	if (run_commit_hook(use_editor, index_file, "prepare-commit-msg",
 			    git_path(commit_editmsg), hook_arg1, hook_arg2, NULL))
@@ -1636,6 +1641,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	struct commit_extra_header *extra = NULL;
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
+	unsigned char tree_sha1[GIT_SHA1_RAWSZ];
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
@@ -1657,10 +1663,16 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (dry_run)
 		return dry_run_commit(argc, argv, prefix, current_head, &s);
 	index_file = prepare_index(argc, argv, prefix, current_head, 0);
+	if (update_main_cache_tree(0)) {
+		error(_("Error building trees"));
+		rollback_index_files();
+		return 1;
+	}
+	hashcpy(tree_sha1, active_cache_tree->sha1);
 
 	/* Set up everything for writing the commit object.  This includes
 	   running hooks, writing the trees, and interacting with the user.  */
-	if (!prepare_to_commit(index_file, prefix,
+	if (!prepare_to_commit(index_file, prefix, tree_sha1,
 			       current_head, &s, &author_ident)) {
 		rollback_index_files();
 		return 1;
@@ -1749,7 +1761,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		append_merge_tag_headers(parents, &tail);
 	}
 
-	if (commit_tree_extended(sb.buf, sb.len, active_cache_tree->sha1,
+	if (commit_tree_extended(sb.buf, sb.len, tree_sha1,
 			 parents, sha1, author_ident.buf, sign_commit, extra)) {
 		rollback_index_files();
 		die(_("failed to write commit object"));
diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index 984889b..e6b5979 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-hook.sh
@@ -136,4 +136,12 @@ test_expect_success 'check the author in hook' '
 	git show -s
 '
 
+test_expect_success 'catch pre-commit hooks that modify index' '
+	echo modified >>file &&
+	write_script "$HOOK" <<-\EOF &&
+	git rm -f file
+	EOF
+	test_must_fail git commit -m m file
+'
+
 test_done
-- 8< --
