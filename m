Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C043920248
	for <e@80x24.org>; Mon,  4 Mar 2019 12:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfCDMEc (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 07:04:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34208 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfCDMEc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 07:04:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id i130so2979476pgd.1
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 04:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8VsBrlAJdWndRm8JUwA6zLjX8Ob5CGg6vqTVeuFOt+Q=;
        b=DLhmAK9lLcGhcvjU96GwyqTMgy1y7JFYEZ570koFzSms4R54NKqnFlgor3KbQgiB7f
         Lzadtno2/sByH5tZkTtXK52bfO0u+Ske6xap29F8Jkg/4J0HiwDgMa90JBcqsmd+NtVk
         n26FJ9WbQ/oboLvVklxKFCrKzCSyOmCuf89byMwsI4QQdy8JHb6FqYumYF+OpDrriBlG
         gIlgQrE3kbCNBUweCnBymMIoQTwsZeMvOZKOMPmVE8M3a+8OJax+Pf6pxck8kAcADM0P
         p7z+E2EekPOYJZD34rILWbzt1NditHuHGKCVRMy6sLpvAQGb27TEhM9wxMjEXZgcDZqh
         RyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8VsBrlAJdWndRm8JUwA6zLjX8Ob5CGg6vqTVeuFOt+Q=;
        b=tY4I4GNrWv944k5UU3mxOayZC63fbC7iIPPnaEROjr401uh/tcpV56RHipTPYegdw2
         sUlRcfZEJNHSfMZXNd0dItkYbPcTM6nklpF5HT3E8I774W99lZGLyGBbru5h8m9QgYeq
         6QPj4NLs+JeDrR5irBqMJjW9n2RbtVe3EhIBIIld9Vnj+JqmHPYC0SyszxZ22s1A0cIx
         6ae2QvUErIrEPe+3X7cCtFv15lIf22bGMSV2rajqs1EGCMr27w6tvSWJdDPXVDQQ2d2m
         VsLHWo8rqVg+jn3ecCyByqXVsTspOGeXTSt2cyDDiS7/4c2lEQrvM2ob/rj7iYa9181o
         pibg==
X-Gm-Message-State: APjAAAU4LCusmiyExinc5s8n3P0MixBo043MuVBjjR5KvUsdSC+31EMP
        zrMmR1zpNeOrOjaW9MkBs+QXr+Uw
X-Google-Smtp-Source: APXvYqydBQCeubjgt4zADTa9WI2R5/ff2tZsdeofOZNAHgvrX3lXOaCYAWRo5MOhP8EIYRVPMu4tgA==
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr20064421pld.236.1551701071178;
        Mon, 04 Mar 2019 04:04:31 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id b6sm8520194pgl.49.2019.03.04.04.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 04:04:30 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 04 Mar 2019 19:04:24 +0700
Date:   Mon, 4 Mar 2019 19:04:24 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Konstantin Kharlamov <hi-angel@yandex.ru>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 1/1] worktree add: sanitize worktree names
Message-ID: <20190304120424.GA7966@ash>
References: <20190221121943.19778-1-pclouds@gmail.com>
 <20190226105851.32273-1-pclouds@gmail.com>
 <20190226105851.32273-2-pclouds@gmail.com>
 <20190227120859.GB10305@sigill.intra.peff.net>
 <CAPig+cRJZBvwsptPOzx3oPSOnt6+uGLoyOr_JbUnku4kdSwdgA@mail.gmail.com>
 <20190227160457.GA30817@sigill.intra.peff.net>
 <CACsJy8D0o6-ihNcpmfhCfQPNo-t2i=NySp65Y8h2e3md2GvXVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8D0o6-ihNcpmfhCfQPNo-t2i=NySp65Y8h2e3md2GvXVw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 04, 2019 at 06:19:15PM +0700, Duy Nguyen wrote:
> On Wed, Feb 27, 2019 at 11:05 PM Jeff King <peff@peff.net> wrote:
> >
> > On Wed, Feb 27, 2019 at 09:23:33AM -0500, Eric Sunshine wrote:
> >
> > > > If we just cared about saying "is this worktree name valid", I'd suggest
> > > > actually constructing a sample refname with the worktree name embedded
> > > > in it and feeding that to check_refname_format(). But because you want
> > > > to actually sanitize, I don't think there's an easy way to reuse it.
> > > >
> > > > So this approach is probably the best we can do, though I do still think
> > > > it's worth renaming that function (and/or putting a big warning comment
> > > > in front of it).
> > >
> > > The above arguments seem to suggest the introduction of a companion to
> > > check_refname_format() for sanitizing, perhaps named
> > > sanitize_refname_format(), in ref.[hc]. The potential difficulty with
> > > that is defining exactly what "sanitize" means. Will it be contextual?
> > > (That is, will git-worktree have differently sanitation needs than
> > > some other facility?) If so, perhaps a 'flags' argument could control
> > > how sanitization is done.
> >
> > I agree that sanitize_refname_format() would be nice, but I'm pretty
> > sure it's going to end up having to duplicate many of the rules from
> > check_refname_format(). Which is ugly if the two ever get out of sync.
> >
> > But if we could write it in a way that keeps the actual policy logic in
> > one factored-out portion, I think it would be worth doing.
> 
> I think we could make check_refname_format() returns the bad position
> and several different error codes depending on context. Then
> sanitize_.. can just repeatedly call check_refname_format and fix up
> whatever error it reports. Performance goes straight to hell but I
> don't think that's a big deal for git-worktree, and it keeps
> check_refname_format() simple (relatively speaking).

The new refs.c code would look something like this.
do_check_refname_component() does not look so bad.

-- 8< --
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 21469eb52c..ca63dd3df6 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -262,36 +262,6 @@ static void validate_worktree_add(const char *path, const struct add_opts *opts)
 	free_worktrees(worktrees);
 }
 
-static void sanitize_worktree_name(struct strbuf *name)
-{
-	struct strbuf sb = STRBUF_INIT;
-	int i;
-
-	for (i = 0; i < name->len; i++) {
-		int ch = name->buf[i];
-
-		if (char_allowed_in_refname(ch))
-			strbuf_addch(&sb, ch);
-		else if (sb.len > 0 && sb.buf[sb.len - 1] != '-')
-			strbuf_addch(&sb, '-');
-	}
-	if (sb.len > 0 && sb.buf[sb.len - 1] == '-')
-		strbuf_setlen(&sb, sb.len - 1);
-	/*
-	 * a worktree name of only special chars would be reduced to
-	 * an empty string
-	 */
-	if (sb.len == 0)
-		strbuf_addstr(&sb, "worktree");
-
-	if (check_refname_format(sb.buf, REFNAME_ALLOW_ONELEVEL))
-		BUG("worktree name '%s' (from '%s') is not a valid refname",
-		    sb.buf, name->buf);
-
-	strbuf_swap(&sb, name);
-	strbuf_release(&sb);
-}
-
 static int add_worktree(const char *path, const char *refname,
 			const struct add_opts *opts)
 {
@@ -322,7 +292,7 @@ static int add_worktree(const char *path, const char *refname,
 
 	name = worktree_basename(path, &len);
 	strbuf_add(&sb_name, name, path + len - name);
-	sanitize_worktree_name(&sb_name);
+	sanitize_worktree_refname(&sb_name);
 	name = sb_name.buf;
 	git_path_buf(&sb_repo, "worktrees/%s", name);
 	len = sb_repo.len;
diff --git a/refs.c b/refs.c
index f23f583db1..2d9730e792 100644
--- a/refs.c
+++ b/refs.c
@@ -63,6 +63,17 @@ int char_allowed_in_refname(int ch)
 		refname_disposition[ch] == 0;
 }
 
+enum check_code {
+	 refname_ok = 0,
+	 refname_contains_dotdot,
+	 refname_contains_atopen,
+	 refname_has_badchar,
+	 refname_contains_wildcard,
+	 refname_starts_with_dot,
+	 refname_ends_with_dotlock,
+	 refname_component_has_zero_length
+};
+
 /*
  * Try to read one refname component from the front of refname.
  * Return the length of the component found, or -1 if the component is
@@ -78,10 +89,11 @@ int char_allowed_in_refname(int ch)
  * - it ends with ".lock", or
  * - it contains a "@{" portion
  */
-static int check_refname_component(const char *refname, int *flags)
+static enum check_code do_check_refname_component(const char *refname, int *flags, const char **cp_out)
 {
 	const char *cp;
 	char last = '\0';
+	enum check_code ret = refname_ok;
 
 	for (cp = refname; ; cp++) {
 		int ch = *cp & 255;
@@ -90,18 +102,26 @@ static int check_refname_component(const char *refname, int *flags)
 		case 1:
 			goto out;
 		case 2:
-			if (last == '.')
-				return -1; /* Refname contains "..". */
+			if (last == '.') {
+				ret = refname_contains_dotdot;
+				goto done;
+			}
 			break;
 		case 3:
-			if (last == '@')
-				return -1; /* Refname contains "@{". */
+			if (last == '@') {
+				ret = refname_contains_atopen; /* @{ */
+				goto done;
+			}
 			break;
 		case 4:
-			return -1;
+			ret = refname_has_badchar;
+			goto done;
 		case 5:
-			if (!(*flags & REFNAME_REFSPEC_PATTERN))
-				return -1; /* refspec can't be a pattern */
+			if (!(*flags & REFNAME_REFSPEC_PATTERN)) {
+				/* refspec can't be a pattern */
+				ret = refname_contains_wildcard;
+				goto done;
+			}
 
 			/*
 			 * Unset the pattern flag so that we only accept
@@ -113,16 +133,67 @@ static int check_refname_component(const char *refname, int *flags)
 		last = ch;
 	}
 out:
-	if (cp == refname)
-		return 0; /* Component has zero length. */
-	if (refname[0] == '.')
-		return -1; /* Component starts with '.'. */
+	if (cp == refname) {
+		ret = refname_component_has_zero_length;
+		goto done;
+	}
+	if (refname[0] == '.') {
+		ret = refname_starts_with_dot;
+		cp = refname;
+		goto done;
+	}
 	if (cp - refname >= LOCK_SUFFIX_LEN &&
-	    !memcmp(cp - LOCK_SUFFIX_LEN, LOCK_SUFFIX, LOCK_SUFFIX_LEN))
-		return -1; /* Refname ends with ".lock". */
+	    !memcmp(cp - LOCK_SUFFIX_LEN, LOCK_SUFFIX, LOCK_SUFFIX_LEN)) {
+		cp -= LOCK_SUFFIX_LEN;
+		ret = refname_ends_with_dotlock;
+	}
+done:
+	*cp_out = cp;
+	return ret;
+}
+
+static int check_refname_component(const char *refname, int *flags)
+{
+	const char *cp;
+	enum check_code ret;
+
+	ret = do_check_refname_component(refname, flags, &cp);
+	if (ret)
+		return -1;
 	return cp - refname;
 }
 
+void sanitize_worktree_refname(struct strbuf *name)
+{
+	int last_length = -1;
+	int flags = 0;
+
+	while (1) {
+		const char *cp;
+
+		enum check_code ret = do_check_refname_component(name->buf, &flags, &cp);
+		if (last_length != -1 && cp - name->buf == last_length)
+			BUG("stuck in infinite loop! pos = %d buf = %s",
+			    last_length, name->buf);
+		last_length = cp - name->buf;
+		switch (ret) {
+		case refname_ok:
+			return;
+		case refname_contains_dotdot:
+		case refname_contains_atopen:
+		case refname_has_badchar:
+		case refname_contains_wildcard:
+		case refname_ends_with_dotlock:
+		case refname_starts_with_dot:
+			name->buf[last_length] = '-';
+			break;
+		case refname_component_has_zero_length:
+			strbuf_addstr(name, "worktree");
+			return;
+		}
+	}
+}
+
 int check_refname_format(const char *refname, int flags)
 {
 	int component_len, component_count = 0;
diff --git a/refs.h b/refs.h
index 61b4073f76..3b65b8d27a 100644
--- a/refs.h
+++ b/refs.h
@@ -459,7 +459,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data);
  * repeated slashes are accepted.
  */
 int check_refname_format(const char *refname, int flags);
-int char_allowed_in_refname(int ch);
+void sanitize_worktree_refname(struct strbuf *name);
 
 const char *prettify_refname(const char *refname);
 
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index ea22207361..24c574f365 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -571,10 +571,10 @@ test_expect_success '"add" an existing locked but missing worktree' '
 '
 
 test_expect_success 'sanitize generated worktree name' '
-	git worktree add --detach ".  weird*..?.lock.lock." &&
-	test -d .git/worktrees/weird-lock-lock &&
+	git worktree add --detach ".  weird*..?.lock.lock" &&
+	test -d .git/worktrees/---weird-.--.lock-lock &&
 	git worktree add --detach .... &&
-	test -d .git/worktrees/worktree
+	test -d .git/worktrees/--.-
 '
 
 test_done
-- 8< --

--
Duy
