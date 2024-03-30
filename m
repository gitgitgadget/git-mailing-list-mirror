Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AEF2030B
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711808297; cv=none; b=ljHvEmnAiItULBfuVd7muclRLAN4/i9FAqBeIRJIsGTEAde7Wcfq7FAfEbdRPaQNtFwGKrqTmZGg3iPbc7/NqaVjrEv6peo7igN6ZIh3RCda67P96viBfNXSwM8dNjmudVc66mqiy7jhr5Q4xmX9uoK2ffjZqUN3B2VYgbek8bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711808297; c=relaxed/simple;
	bh=4mG018XS/VRwdM4O3tRchYQoDFJkjQOiSMWWHsBZlwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWQKeT+aFx8IKK+PGWY3GZlUx3UKPJXCy9cOOX+7dvz0KtrUBl4Vr9R20y1+rLJTw4JQ7KrA/GAzDq6xRnOQ86nLaTCcHWYSjFte9+MrXM2nWzmJ+DxJTtoVtMS10hCrNv4bUXEUWrdEk4gw3+Lh9Sum5OxbT+VDz5nQ6qKoYQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+lt/FnR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+lt/FnR"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6b729669bso2380090b3a.3
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711808295; x=1712413095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BfgfHXAjwVbT5aoqU1JVl0QLJgh7485W6gjrZkoi6do=;
        b=B+lt/FnRmRyrsbYQFZjGpBpMisNgha8fibls269GsT8oc/w7b3X10ma73Y59yyD1NG
         HGOn3Z4jUd6avto3GTJHUnVdPBohrqHj3/7SqQnlG6vGhsr/F2g01+VQtcgq/I8g8yoc
         QMrWV0jwc87k7Z9xMMdVJLjzaWeuSn1YAIXLgpZaRM4LXLOI99FAWvmtj2F0eQxVXhqb
         +uffE6kd5aE19I93kNUsY295mS2OkOSA/qvI7apbmcXfIaBAJPo2Y1y2jj/MOu/UVcGk
         ob1a7hewF4Nv40mU8kbr9WtKfA0IOraP1+F3WUYx3NYJUEDpkdRMNkTHKdS5E/dPkX9k
         UtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711808295; x=1712413095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfgfHXAjwVbT5aoqU1JVl0QLJgh7485W6gjrZkoi6do=;
        b=Gq80vi4qy3C36xbKXflcK2P0apMhdCzjA7p20zC6jaZzXWUWGJ3L0/2xE4Gue9c7VW
         ScseNQlP3mfSv2gqljzGdutKkO4et9nXSugZ2WFp4QhnOAr5bzPFcHN3DZpmhjUWzLuC
         wyiZz/zv3nfzbaPX5DFG72nKTFzf2SlfB1Uqwkd0VwtySAGEUidaOfeX8H4wPP/5WR7Q
         iUjSElkQ20uLgdzvO+ZO9b0fa08N64w5+GrRHYfVJkmYmDy38XHmxQfrZZhlSC2LPbgV
         EEJRB2mYboLOa0tIPUJaY5iCG4ieTHcSgkNK6JmKQLSlIOjBRZzRatWoxF2yNPDBuinR
         Zmcw==
X-Gm-Message-State: AOJu0YyHz8XsylA3noXwN/I77fbZeDIR2WmaVgsIWLSP0Lv9G2+u5SOr
	mqFlsD5RXofuTzquInqUQBy3EBtjSKrh/IGPVt6DPfvS05tnq5V9
X-Google-Smtp-Source: AGHT+IEt7QanpqzaJR/BFkUZj85LFgtsoEx6OQ64TWumm6/vvWT6fYc7tm2aD9djwD9/ZVBgizxgtw==
X-Received: by 2002:aa7:888f:0:b0:6ea:afd1:9023 with SMTP id z15-20020aa7888f000000b006eaafd19023mr5965088pfe.0.1711808294903;
        Sat, 30 Mar 2024 07:18:14 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id z185-20020a6265c2000000b006ea80883ce3sm4808906pfb.133.2024.03.30.07.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 07:18:14 -0700 (PDT)
Date: Sat, 30 Mar 2024 19:48:11 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] builtin/add: error out when passing untracked
 path with -u
Message-ID: <b3j7l2ncstdiaxojtollxddmxvkbbeciou25yptguttr5qugmx@y3bzqbdxkyaw>
References: <20240318155219.494206-2-shyamthakkar001@gmail.com>
 <20240329205649.1483032-5-shyamthakkar001@gmail.com>
 <xmqqzfugvhnf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzfugvhnf.fsf@gitster.g>

On Fri, 29 Mar 2024, Junio C Hamano <gitster@pobox.com> wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
> > +	if (take_worktree_changes)
> > +		exit_status |= report_path_error(ps_matched, &pathspec);
> 
> Hmph, are we sure take_worktree_changes is true only when
> add_renormalize is false?
> 
> >  	if (add_new_files)
> >  		exit_status |= add_files(&dir, flags);
> 
> If report_path_error() detected that the pathspec were faulty,
> should we still proceed to add new files?  This is NOT a rhetorical
> question, as I do not know the answer myself.  I do not even know
> offhand what add_files_to_cache() above did when pathspec elements
> are not all consumed---if it does not complain and does not refrain
> from doing any change to the index, then we should follow suite and
> add_files() here, too.
Sorry if I'm missing something, but in your last line after '---', do you mean
that we should proceed even after report_path_error() detected error like in
the above patch or perhaps something like this:

diff --git a/builtin/add.c b/builtin/add.c
index dc4b42d0ad..eccda485ed 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -64,7 +64,8 @@ static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
        return ret;
 }
 
-static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
+static int renormalize_tracked_files(const struct pathspec *pathspec,
+                                    char *ps_matched, int flags)
 {
        int i, retval = 0;
 
@@ -79,7 +80,8 @@ static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
                        continue; /* do not touch unmerged paths */
                if (!S_ISREG(ce->ce_mode) && !S_ISLNK(ce->ce_mode))
                        continue; /* do not touch non blobs */
-               if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
+               if (pathspec &&
+                   !ce_path_match(&the_index, ce, pathspec, ps_matched))
                        continue;
                retval |= add_file_to_index(&the_index, ce->name,
                                            flags | ADD_CACHE_RENORMALIZE);
@@ -370,7 +372,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
        int add_new_files;
        int require_pathspec;
        char *seen = NULL;
+       char *ps_matched = NULL;
        struct lock_file lock_file = LOCK_INIT;
+       struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
 
        git_config(add_config, NULL);
 
@@ -487,7 +491,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
        if (pathspec.nr) {
                int i;
                char *skip_worktree_seen = NULL;
-               struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
 
                if (!seen)
                        seen = find_pathspecs_matching_against_index(&pathspec,
@@ -544,18 +547,26 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
                free(seen);
                free(skip_worktree_seen);
-               string_list_clear(&only_match_skip_worktree, 0);
        }
 
        begin_odb_transaction();
 
+       ps_matched = xcalloc(pathspec.nr, 1);
        if (add_renormalize)
-               exit_status |= renormalize_tracked_files(&pathspec, flags);
+               exit_status |=
+                       renormalize_tracked_files(&pathspec, ps_matched, flags);
        else
                exit_status |= add_files_to_cache(the_repository, prefix,
-                                                 &pathspec, NULL,
+                                                 &pathspec, ps_matched,
                                                  include_sparse, flags);
 
+       if ((take_worktree_changes ||
+            (add_renormalize && !only_match_skip_worktree.nr)) &&
                                                  include_sparse, flags);
 
+       if ((take_worktree_changes ||
+            (add_renormalize && !only_match_skip_worktree.nr)) &&
+           report_path_error(ps_matched, &pathspec)) {
+               exit_status = 1;
+               goto cleanup;
+       }
+
        if (add_new_files)
                exit_status |= add_files(&dir, flags);
 
@@ -568,6 +579,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
                               COMMIT_LOCK | SKIP_IF_UNCHANGED))
                die(_("unable to write new index file"));
 
+cleanup:
+       string_list_clear(&only_match_skip_worktree, 0);
+       free(ps_matched);
        dir_clear(&dir);
        clear_pathspec(&pathspec);
        return exit_status;

Although I'm not sure if we should flush_odb_transaction() in the
cleanup, because end_odb_transaction() would not be called if we go
straight to cleanup.
