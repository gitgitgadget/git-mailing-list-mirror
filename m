Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAF421FF30
	for <e@80x24.org>; Mon, 22 May 2017 04:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751007AbdEVEsQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 00:48:16 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34339 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdEVEsP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 00:48:15 -0400
Received: by mail-pf0-f169.google.com with SMTP id 9so70054744pfj.1
        for <git@vger.kernel.org>; Sun, 21 May 2017 21:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=k6ZHGrqu8c4q7dCdEsjR/0BCeKGQYg229I8eyOvHBVg=;
        b=HFc+8okBO/S9HXHgEqlS2b6eNVt42qTaVFRF/NBauDeTlrYKWrU5PxHJul0bjoUWbf
         zIC8XqaQ5hxdAK0q6eWuuSazDRWUFhVFj5oweOt4Z5uRFm9Ew3ApjqekYg9LLBLXx2My
         E9SD0pJWkhNxTTpuVTZLAmhus8QwQuHScH4dgwQ8hPrM6QpZpl+udz3Vsoy1gIncagFH
         0+BCl8nUCzGh1mVoi/BE6ANpwZzD96kpJzomHxLauWIidZ/XdmZpvhNjM8k0jsyJbBcY
         1RZf41K/UWYe609qUzltlsNVJC1IQhjD8cHVKLtANMGM2xJqefC51AoldgOtJVIb225e
         vGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=k6ZHGrqu8c4q7dCdEsjR/0BCeKGQYg229I8eyOvHBVg=;
        b=KuUw7ilFF1O/AduzUo8Nipt5AOZltpFwdkbjIs9xQF06HYMOm748fYYjiPHRHbLIMP
         shNChZzTnlKapxDwG46OcaR8KfGymS6onZ2jhmB/xavNKXqnB5S+4uzKCUT51B/rlBtH
         KskM4pdfTNM9KaWOA7YzQcKF6NCp2AYBP8OeEMWfcthNmAePb5jow+G6uY6H4NvyS94C
         WN0XYg8MG4vHbA4OoI8CKMbl/0X7w+Uu+9hzE0ZDz4FdIXubJiK1zsdVtwzl4LbFtOoM
         AzFJtNt+S26drcSF/pc4IATOZpvvlrrtikBYau9DCOTQRX8Lm1uHdXAjGiUiDKBUrYa/
         ctfw==
X-Gm-Message-State: AODbwcD1f05Pbtw8LlNBD8U0+KO2Nfn7075ldL+SsddzRW1Me/6bv6jG
        gJqqHg8U4SeB5w==
X-Received: by 10.98.57.80 with SMTP id g77mr23728597pfa.111.1495428494363;
        Sun, 21 May 2017 21:48:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4439:f55c:c49b:d0dc])
        by smtp.gmail.com with ESMTPSA id q24sm29080862pfj.3.2017.05.21.21.48.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 21 May 2017 21:48:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 6/6] clean: teach clean -d to skip dirs containing ignored files
References: <20170518082154.28643-1-sxlijin@gmail.com>
        <20170516073423.25762-1-sxlijin@gmail.com>
        <20170518082154.28643-7-sxlijin@gmail.com>
Date:   Mon, 22 May 2017 13:48:12 +0900
In-Reply-To: <20170518082154.28643-7-sxlijin@gmail.com> (Samuel Lijin's
        message of "Thu, 18 May 2017 04:21:54 -0400")
Message-ID: <xmqqtw4do5tf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> +	for (j = i = 0; i < dir.nr;) {
> +		for (;
> +		     j < dir.ignored_nr &&
> +		       0 <= cmp_dir_entry(&dir.entries[i], &dir.ignored[j]);
> +		     j++);
> +
> +		if ((j < dir.ignored_nr) &&
> +				check_dir_entry_contains(dir.entries[i], dir.ignored[j])) {
> +			/* skip any dir.entries which contains a dir.ignored */
> +			free(dir.entries[i]);
> +			dir.entries[i++] = NULL;
> +		} else {
> +			/* prune the contents of a dir.entries which will be removed */
> +			struct dir_entry *ent = dir.entries[i++];
> +			for (;
> +			     i < dir.nr &&
> +			       check_dir_entry_contains(ent, dir.entries[i]);
> +			     i++) {
> +				free(dir.entries[i]);
> +				dir.entries[i] = NULL;
> +			}
> +		}
> +	}

The second loop in the else clause is a bit tricky, and the comment
"which will be removed" is not all that helpful to explain why the
loop is there.

But I think the code is correct.  Here is how I understood it.

    While looking at dir.entries[i], the code noticed that nothing
    in that directory is ignored.  But entries in dir.entries[] that
    come later may be contained in dir.entries[i] and we just want
    to show the top-level untracked one (e.g. "a/" and "a/b/" were
    in entries[], there is nothing in "a/", so naturally there is
    nothing in "a/b/", but we do not want to bother showing
    both---showing "a/" alone saying "the entire a/ is untracked" is
    what we want).

We may want to have a test to ensure "a/b/" is indeed omitted in
such a situation from the output, though.

By the way, instead of putting NULL, it may be easier to follow if
you used two pointers, src and dst, into dir.entries[], just like
you did in your latest version of [PATCH 4/6].  That way, you do not
have to change anything in the later loop that walks over elements
in the dir.entries[] array.  It would also help the logic easier to
follow if the above loop were its own helper function.

Putting them all together, here is what I came up with that can be
squashed into your patch.  I am undecided myself if this is easier
to follow than your version, but it seems to pass your test ;-)

Thanks.

 builtin/clean.c | 70 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index dd3308a447..c8712e7ac8 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -851,9 +851,49 @@ static void interactive_main_loop(void)
 	}
 }
 
+static void simplify_untracked(struct dir_struct *dir)
+{
+	int src, dst, ign;
+
+	for (src = dst = ign = 0; src < dir->nr; src++) {
+		/*
+		 * Skip entries in ignored[] that cannot be inside
+		 * entries[src]
+		 */
+		while (ign < dir->ignored_nr &&
+		       0 <= cmp_dir_entry(&dir->entries[src], &dir->ignored[ign]))
+			ign++;
+
+		if (dir->ignored_nr <= ign ||
+		    !check_dir_entry_contains(dir->entries[src], dir->ignored[ign])) {
+			/*
+			 * entries[src] does not contain an ignored
+			 * path -- we need to keep it.  But we do not
+			 * want to show entries[] that are contained
+			 * in entries[src].
+			 */
+			struct dir_entry *ent = dir->entries[src++];
+			dir->entries[dst++] = ent;
+			while (src < dir->nr &&
+			       check_dir_entry_contains(ent, dir->entries[src])) {
+				free(dir->entries[src++]);
+			}
+			/* compensate for the outer loop's loop control */
+			src--;
+		} else {
+			/*
+			 * entries[src] contains an ignored path --
+			 * drop it.
+			 */
+			free(dir->entries[src]);
+		}
+	}
+	dir->nr = dst;
+}
+
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
-	int i, j, res;
+	int i, res;
 	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
 	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
 	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
@@ -928,30 +968,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		       prefix, argv);
 
 	fill_directory(&dir, &pathspec);
-
-	for (j = i = 0; i < dir.nr;) {
-		for (;
-		     j < dir.ignored_nr &&
-		       0 <= cmp_dir_entry(&dir.entries[i], &dir.ignored[j]);
-		     j++);
-
-		if ((j < dir.ignored_nr) &&
-				check_dir_entry_contains(dir.entries[i], dir.ignored[j])) {
-			/* skip any dir.entries which contains a dir.ignored */
-			free(dir.entries[i]);
-			dir.entries[i++] = NULL;
-		} else {
-			/* prune the contents of a dir.entries which will be removed */
-			struct dir_entry *ent = dir.entries[i++];
-			for (;
-			     i < dir.nr &&
-			       check_dir_entry_contains(ent, dir.entries[i]);
-			     i++) {
-				free(dir.entries[i]);
-				dir.entries[i] = NULL;
-			}
-		}
-	}
+	simplify_untracked(&dir);
 
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
@@ -959,9 +976,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		struct stat st;
 		const char *rel;
 
-		if (!ent)
-			continue;
-
 		if (!cache_name_is_other(ent->name, ent->len))
 			continue;
 
