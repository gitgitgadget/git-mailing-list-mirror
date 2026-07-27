Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704703DD862
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785149693; cv=none; b=cnf9DUc9bceWK4GLwUexu6h+qobLLOErOgIWYyj+wjpCl8zN+fjNGeS3EnQRXsQH6HDPj3VGSVf+oQpGkxcpG2KuurKSLKqTEuL2dY4n7/pyo6tCNGfMcp8H3OAwlbzn9BOZIKgR49MaeJahbhR+ifETWaHg0LpM5RVWWQpbZ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785149693; c=relaxed/simple;
	bh=mlqwuSmfblodlfu7SFYH218vqSsqfN2ejAF/oFlOTLE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=pbVYkLrTdeMKl7cXHVLmasH491bhBMZ688UKLapSLBke7n3+dN17azS6uuCFJ26y5rG2YmqCWUxDN/2jxepmQc+ryGNzbdvN81WkxB/ldlBQhf6kBkF2Tjio/iT00fvKzylniB/6mS6cuCt0xidTkwin8YIO9Yz+BHdTI/Hi7bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AueZVyWy; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AueZVyWy"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8486672f03cso2437228b3a.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2026 03:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785149690; x=1785754490; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5HgtFiyG/Z0GDIIsjgdR2Gir8EuXoP1wzpbd8QbEZck=;
        b=AueZVyWyH07xfDNEpLZSdxRqkCyc07yESCLvPJn6tRNPiMmwkOYXslh9AmHyPj/t6y
         nd/LlvGlSRFTvNTxRc7ZXot2J+jFMptMCoGvcFZUF8Q+PnRxKVHsVrmtYyyHNOLFea2/
         +lV8FCu8m3K28zOWWFI8fBj6xxavVpj6r/WZ6gwFLoc6vZTMEM1YXLMGZjrqNOhx+Wt3
         6SmhokNmRj7KvMpyS0JqVqtJdiRxphDAqmn6Lin/8xH53Og2F2+94i1KZHkJmyx80/JJ
         EkPp+S+aWjkjaMDlJpWAIxBfPZ4mJ5UC3yn2Zw4XI/gVf5Ibwh0wFc+iOWMEubE86bv2
         dF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785149690; x=1785754490;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5HgtFiyG/Z0GDIIsjgdR2Gir8EuXoP1wzpbd8QbEZck=;
        b=Q6Jbaje/2AJqBfSpx0u3RL01/Mo+3QwLsWmEq/uHpzk8NxlSRXK0fXu9g/43KIPChI
         yt7/XW0OtK8M6PiOorv45lXWgtHmL25VFwzH0uuXPI7cXUG4rPmr4iJCAaUtkLGZD7vu
         X3+FCSAYMtLA8XrTQVlxjTO5U0aNRec8wD2ikcR54owWI/JO3JFbJ2iCWtuyxx5MIlym
         IzV7eVSh/OAdiGeh0FqJknEAycQLB00/RpTFpbnB0JpIxKNZ9vBw/oiuf4R9jaqepuRb
         NszCqtJcie4+sZpgSmlFex84wfimFPE8/1TNZtAyl3CHh1VDBYSsK+4/+URCYNiiwyX6
         1X7Q==
X-Gm-Message-State: AOJu0YzSq4IOt0jqrwtw/cvuYQBz68Lm5eG7EjRhaJ3kE5dq52Om97wx
	QDtzY4+ugooWc1LnPqqHWaqOKWmE59sibShnDAQFhFtwH+z3hN4AlJTpr0IxkA==
X-Gm-Gg: AR+sD11e1PZGJ/tUVPwiE24yIbO+t9KY2dk2nnAXCGKiRE3LF5HrSzDqipFhHMncdvk
	urz4DmG+Dp/d5vNXoMB+owk8p/yFL6ZX/EIP+1jueLu1yEQ1YqCchqQZtqirGzhjeqmJrupWOX8
	etqBzGhZE152Y72KmKLVtNHr16ucy8m5B6hfNT16CpgtRsMjhjykopWALNO1haV9HPvm2ht+hQ4
	fVEqwlJx65EiR46a3DFvlMkevzeRGHAvvuIpFAzpzkJxeuvbINjX8D1H/cAOm858qNCeMn/UIQk
	RA7uOyYuxdy6fsnz4HQgukMNS1Vt9221MMYBK+Fd0ldDjVVkqDEyFyrugmPZ5HqPzx2WL1Q7Gkw
	aNOq0MPk1wyn8ect8UqUrGbAMGydlGkbXJpcwBEgA7zpUCa/wYXkieVIPHkD6yRCs7mOb5x+5LW
	8lREH5
X-Received: by 2002:a05:6a00:812:b0:848:2f7a:2e5f with SMTP id d2e1a72fcca58-84e595a9eabmr6160103b3a.78.1785149689250;
        Mon, 27 Jul 2026 03:54:49 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.59.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533d15c2sm2844090b3a.29.2026.07.27.03.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 03:54:48 -0700 (PDT)
Message-Id: <pull.2180.v2.git.1785149687514.gitgitgadget@gmail.com>
In-Reply-To: <pull.2180.git.1784190706028.gitgitgadget@gmail.com>
References: <pull.2180.git.1784190706028.gitgitgadget@gmail.com>
From: "Emin =?UTF-8?Q?=C3=96zata?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 27 Jul 2026 10:54:46 +0000
Subject: [PATCH v2] stash: add 'reword' subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Emin =?UTF-8?Q?=C3=96zata?= <eminozata@proton.me>,
    =?UTF-8?q?Emin=20=C3=96zata?= <eminozata@proton.me>

From: =?UTF-8?q?Emin=20=C3=96zata?= <eminozata@proton.me>

Stash entries accumulate with the default "WIP on <branch>" message
when they are created in a hurry, and there is no way to relabel the
ones worth keeping afterwards.  The only option is dropping an entry
and re-storing it by hand, which moves it to the top of the stash
list and gets fiddly for deeper entries.

Add 'git stash reword <message> [<stash>]', which defaults to the
latest entry like the other subcommands do.  The name follows the
verb git already uses for changing only a message, as in the reword
command of 'git rebase -i' and in 'git history reword'.  It reads
the whole reflog and writes it back in a single transaction, with
the new message on the target and every other entry left as it was.
Position, contents, timestamps and the reflog chain all stay put.

Before touching anything, the command inspects the target entry and
the ones above it, and refuses to start if any of them does not look
like a stash commit; that can only happen when refs/stash was
written to by hand.  The rewrite clears the reflog before writing
the new one, so if the transaction fails afterwards, the command
reports the object id of each collected entry and re-stores it
best-effort.  Whatever it fails to re-store can be recovered with
'git stash store'.

This was proposed before: in 2010, as a "git reflog update" command
that edited reflog entries in place [1].  When it came up again in
2013 [2], Junio rejected it on the grounds that reflogs are
append-only recovery logs, and that whoever really cares about a
stash message can pop and re-stash [3].  Michael Haggerty pointed
out in that thread that refs/stash does not fit the description:
its reflog is the primary data store for stash entries, and 'git
stash drop' rewrites it all the time [4].  So this patch rewrites
refs/stash directly, the way 'git stash drop' already does, through
ref_transaction_update_reflog(), which 'git remote rename' and 'git
refs migrate' already use to rewrite existing reflogs.

Name the target by index (stash@{1}); the command rejects
time-based selectors, because it needs the entry's position in the
reflog.  Writing the reflog back at once keeps the cost linear in
its length whatever that position is, and spares the reftable
backend from emitting and compacting a table per entry, which is
what dropping and re-storing the entries one by one would cost.

[1] https://lore.kernel.org/git/20100620093142.GF24805@occam.hewgill.net/
[2] https://lore.kernel.org/git/loom.20130104T192132-16@post.gmane.org/
[3] https://lore.kernel.org/git/7vbod4tynt.fsf@alter.siamese.dyndns.org/
[4] https://lore.kernel.org/git/50ED2C78.1030300@alum.mit.edu/

Signed-off-by: Emin Özata <eminozata@proton.me>
---
    stash: add 'reword' subcommand
    
    eo/stash-reword
    
    "git stash reword" learned to change the message of an existing stash
    entry without changing its position, its contents or its reflog
    timestamp.
    
    This came up in 2010 and again in 2013, and was rejected back then on
    the grounds that reflogs are append-only recovery logs. refs/stash is
    the exception Michael Haggerty pointed out in that thread: its reflog is
    the primary data store for stash entries, and "git stash drop" rewrites
    it already. So this rewrites the refs/stash reflog through
    ref_transaction_update_reflog(), which "git remote rename" and "git refs
    migrate" already use to rewrite existing reflogs, and touches nothing
    else. Details and links to the old threads are in the commit message.
    
    Costs, so nobody has to dig for them: the whole reflog is read and
    written back once whatever the target's depth, so the cost is linear in
    its length. The rewrite is not crash-safe. The reflog is cleared before
    the transaction writes it back, so a process killed in that window
    leaves refs/stash without the reflog that "git stash list" reads. If the
    transaction itself fails, the collected entries are re-stored
    best-effort, and whatever cannot be written back is reported with its
    object id so "git stash store" can recover it. The stash commits are
    never deleted either way, so "git fsck" still finds them. Closing that
    window for real needs a refs API operation that replaces a reflog in one
    step, which I would rather do as a follow-up.
    
    I picked a positional message argument over an -m option ("stash store"
    style); no strong opinion, happy to switch.
    
    Changes since v1, all from Patrick's review: the subcommand is 'reword'
    rather than 'rename', the reflog is rewritten in a single transaction
    instead of one drop-and-store per entry, and the commit message opens
    with the use case rather than with the observation that stash messages
    cannot be changed.
    
    t3903 passes with GIT_TEST_DEFAULT_REF_FORMAT=files and reftable.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2180%2Fozemin%2Fstash-rename-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2180/ozemin/stash-rename-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2180

Range-diff vs v1:

 1:  86af7ff53c ! 1:  d9def7b461 stash: add 'rename' subcommand
     @@ Metadata
      Author: Emin Özata <eminozata@proton.me>
      
       ## Commit message ##
     -    stash: add 'rename' subcommand
     +    stash: add 'reword' subcommand
      
     -    There is no way to change the message of a stash entry after the
     -    fact.  The only option is dropping the entry and re-storing it by
     -    hand, which moves it to the top of the stash list and gets fiddly
     -    for deeper entries.
     +    Stash entries accumulate with the default "WIP on <branch>" message
     +    when they are created in a hurry, and there is no way to relabel the
     +    ones worth keeping afterwards.  The only option is dropping an entry
     +    and re-storing it by hand, which moves it to the top of the stash
     +    list and gets fiddly for deeper entries.
      
     -    Add 'git stash rename <message> [<stash>]', defaulting to the
     -    latest entry like the other subcommands do.  It reads the object id
     -    and reflog message of the target entry and of the entries above it,
     -    drops them all like 'git stash drop' would, and stores them back in
     -    the same order, with the new message going to the target.  Position,
     -    contents and the reflog chain stay as they were.
     +    Add 'git stash reword <message> [<stash>]', which defaults to the
     +    latest entry like the other subcommands do.  The name follows the
     +    verb git already uses for changing only a message, as in the reword
     +    command of 'git rebase -i' and in 'git history reword'.  It reads
     +    the whole reflog and writes it back in a single transaction, with
     +    the new message on the target and every other entry left as it was.
     +    Position, contents, timestamps and the reflog chain all stay put.
      
     -    The command checks every entry it is about to rewrite and refuses
     -    to start if one of them does not look like a stash commit, which
     -    can only happen when refs/stash was written to by hand.  Finding
     -    that out halfway through the sequence would lose entries.  Should a
     -    write-back fail anyway, the entry's object id is reported so it can
     -    be recovered with 'git stash store', and the command only reports
     -    success when the reflog ended up in the requested state.
     +    Before touching anything, the command inspects the target entry and
     +    the ones above it, and refuses to start if any of them does not look
     +    like a stash commit; that can only happen when refs/stash was
     +    written to by hand.  The rewrite clears the reflog before writing
     +    the new one, so if the transaction fails afterwards, the command
     +    reports the object id of each collected entry and re-stores it
     +    best-effort.  Whatever it fails to re-store can be recovered with
     +    'git stash store'.
      
          This was proposed before: in 2010, as a "git reflog update" command
          that edited reflog entries in place [1].  When it came up again in
     @@ Commit message
          stash message can pop and re-stash [3].  Michael Haggerty pointed
          out in that thread that refs/stash does not fit the description:
          its reflog is the primary data store for stash entries, and 'git
     -    stash drop' rewrites it all the time [4].  So this patch stays away
     -    from the reflog machinery entirely and does the suggested
     -    pop-and-re-stash workaround mechanically, without the detour
     -    through the working tree.
     +    stash drop' rewrites it all the time [4].  So this patch rewrites
     +    refs/stash directly, the way 'git stash drop' already does, through
     +    ref_transaction_update_reflog(), which 'git remote rename' and 'git
     +    refs migrate' already use to rewrite existing reflogs.
      
     -    The sequence only works if entry positions hold still while it
     -    runs, so the command takes index-based selectors (stash@{1}) and
     -    rejects time-based ones.  It also refreshes the reflog timestamps
     -    of the rewritten entries, and renaming stash@{n} costs n+1 reflog
     -    deletions and ref updates.
     +    Name the target by index (stash@{1}); the command rejects
     +    time-based selectors, because it needs the entry's position in the
     +    reflog.  Writing the reflog back at once keeps the cost linear in
     +    its length whatever that position is, and spares the reftable
     +    backend from emitting and compacting a table per entry, which is
     +    what dropping and re-storing the entries one by one would cost.
      
          [1] https://lore.kernel.org/git/20100620093142.GF24805@occam.hewgill.net/
          [2] https://lore.kernel.org/git/loom.20130104T192132-16@post.gmane.org/
     @@ Documentation/git-stash.adoc: git stash create [<message>]
       git stash store [(-m | --message) <message>] [-q | --quiet] <commit>
       git stash export (--print | --to-ref <ref>) [<stash>...]
       git stash import <commit>
     -+git stash rename [-q | --quiet] <message> [<stash>]
     ++git stash reword [-q | --quiet] <message> [<stash>]
       
       DESCRIPTION
       -----------
     @@ Documentation/git-stash.adoc: with no conflicts.
       	created by `export`, and add them to the list of stashes.  To replace the
       	existing stashes, use `clear` first.
       
     -+`rename [-q | --quiet] <message> [<stash>]`::
     ++`reword [-q | --quiet] <message> [<stash>]`::
      +	Change the message of a single stash entry.  The entry keeps its
     -+	position and its contents.  _<stash>_ must name an entry by
     -+	index (e.g. `stash@{1}`); renaming refreshes the reflog
     -+	timestamps of the entry and of the entries above it.
     ++	position, its contents and its reflog timestamp.  _<stash>_ must
     ++	name an entry by index (e.g. `stash@{1}`).
      +
       OPTIONS
       -------
     @@ Documentation/git-stash.adoc: literally (including newlines and quotes).
       `--quiet`::
       	This option is only valid for `apply`, `drop`, `pop`, `push`,
      -	`save`, `store` commands.
     -+	`rename`, `save`, `store` commands.
     ++	`reword`, `save`, `store` commands.
       +
       Quiet, suppress feedback messages.
       
     @@ Documentation/git-stash.adoc: For more details, see the 'pathspec' entry in link
       _<stash>_::
       	This option is only valid for `apply`, `branch`, `drop`, `pop`,
      -	`show`, and `export` commands.
     -+	`show`, `export`, and `rename` commands.
     ++	`show`, `export`, and `reword` commands.
       +
       A reference of the form `stash@{<revision>}`. When no _<stash>_ is
       given, the latest stash is assumed (that is, `stash@{0}`).
      
       ## builtin/stash.c ##
     +@@
     + #include "abspath.h"
     + #include "config.h"
     + #include "environment.h"
     ++#include "date.h"
     + #include "gettext.h"
     + #include "hash.h"
     + #include "hex.h"
     ++#include "ident.h"
     + #include "object-name.h"
     + #include "parse-options.h"
     + #include "refs.h"
      @@
       	N_("git stash export (--print | --to-ref <ref>) [<stash>...]")
       #define BUILTIN_STASH_IMPORT_USAGE \
       	N_("git stash import <commit>")
     -+#define BUILTIN_STASH_RENAME_USAGE \
     -+	N_("git stash rename [-q | --quiet] <message> [<stash>]")
     ++#define BUILTIN_STASH_REWORD_USAGE \
     ++	N_("git stash reword [-q | --quiet] <message> [<stash>]")
       #define BUILTIN_STASH_CLEAR_USAGE \
       	"git stash clear"
       
     @@ builtin/stash.c: static const char * const git_stash_usage[] = {
       	BUILTIN_STASH_STORE_USAGE,
       	BUILTIN_STASH_EXPORT_USAGE,
       	BUILTIN_STASH_IMPORT_USAGE,
     -+	BUILTIN_STASH_RENAME_USAGE,
     ++	BUILTIN_STASH_REWORD_USAGE,
       	NULL
       };
       
     @@ builtin/stash.c: static const char * const git_stash_import_usage[] = {
       	NULL
       };
       
     -+static const char * const git_stash_rename_usage[] = {
     -+	BUILTIN_STASH_RENAME_USAGE,
     ++static const char * const git_stash_reword_usage[] = {
     ++	BUILTIN_STASH_REWORD_USAGE,
      +	NULL
      +};
      +
       static const char ref_stash[] = "refs/stash";
       static struct strbuf stash_index_path = STRBUF_INIT;
       
     -@@ builtin/stash.c: static int reflog_is_empty(const char *refname)
     - 					 refname, reject_reflog_ent, NULL);
     - }
     - 
     --static int do_drop_stash(struct stash_info *info, int quiet)
     -+static int drop_reflog_entry(const char *revision)
     - {
     --	if (!reflog_delete(info->revision.buf,
     --			   EXPIRE_REFLOGS_REWRITE | EXPIRE_REFLOGS_UPDATE_REF,
     --			   0)) {
     --		if (!quiet)
     --			printf_ln(_("Dropped %s (%s)"), info->revision.buf,
     --				  oid_to_hex(&info->w_commit));
     --	} else {
     --		return error(_("%s: Could not drop stash entry"),
     --			     info->revision.buf);
     --	}
     -+	if (reflog_delete(revision,
     -+			  EXPIRE_REFLOGS_REWRITE | EXPIRE_REFLOGS_UPDATE_REF,
     -+			  0))
     -+		return error(_("%s: Could not drop stash entry"), revision);
     - 
     - 	if (reflog_is_empty(ref_stash))
     - 		do_clear_stash();
     -@@ builtin/stash.c: static int do_drop_stash(struct stash_info *info, int quiet)
     - 	return 0;
     - }
     - 
     -+static int do_drop_stash(struct stash_info *info, int quiet)
     -+{
     -+	if (drop_reflog_entry(info->revision.buf))
     -+		return -1;
     -+
     -+	if (!quiet)
     -+		printf_ln(_("Dropped %s (%s)"), info->revision.buf,
     -+			  oid_to_hex(&info->w_commit));
     -+
     -+	return 0;
     -+}
     -+
     - static int get_stash_info_assert(struct stash_info *info, int argc,
     - 				 const char **argv)
     - {
      @@ builtin/stash.c: out:
       	return ret;
       }
       
     -+struct rename_entry {
     -+	struct object_id oid;
     ++struct reword_entry {
     ++	struct object_id old_oid;
     ++	struct object_id new_oid;
     ++	char *committer;
      +	char *msg;
      +};
      +
     -+struct rename_data {
     -+	struct rename_entry *entries;
     ++struct reword_data {
     ++	struct reword_entry *entries;
      +	size_t nr, alloc;
     -+	size_t want;
      +};
      +
     -+static int collect_rename_entries(const char *refname UNUSED,
     -+				  struct object_id *old_oid UNUSED,
     ++static int collect_reword_entries(const char *refname UNUSED,
     ++				  struct object_id *old_oid,
      +				  struct object_id *new_oid,
     -+				  const char *committer UNUSED,
     -+				  timestamp_t timestamp UNUSED,
     -+				  int tz UNUSED, const char *msg,
     ++				  const char *committer,
     ++				  timestamp_t timestamp,
     ++				  int tz, const char *msg,
      +				  void *cb_data)
      +{
     -+	struct rename_data *data = cb_data;
     ++	struct reword_data *data = cb_data;
      +	const char *eol = strchrnul(msg, '\n');
     ++	struct reword_entry *entry;
     ++	struct ident_split ident;
      +
      +	ALLOC_GROW(data->entries, data->nr + 1, data->alloc);
     -+	oidcpy(&data->entries[data->nr].oid, new_oid);
     -+	data->entries[data->nr].msg = xstrndup(msg, eol - msg);
     -+	data->nr++;
     ++	entry = &data->entries[data->nr];
     ++	oidcpy(&entry->old_oid, old_oid);
     ++	oidcpy(&entry->new_oid, new_oid);
     ++	entry->msg = xstrndup(msg, eol - msg);
     ++
     ++	if (split_ident_line(&ident, committer, strlen(committer)) < 0) {
     ++		entry->committer = xstrdup(committer);
     ++	} else {
     ++		struct strbuf name = STRBUF_INIT, mail = STRBUF_INIT;
     ++		const char *date = show_date(timestamp, tz, DATE_MODE(NORMAL));
     ++
     ++		strbuf_add(&name, ident.name_begin,
     ++			   ident.name_end - ident.name_begin);
     ++		strbuf_add(&mail, ident.mail_begin,
     ++			   ident.mail_end - ident.mail_begin);
     ++		entry->committer = xstrdup(fmt_ident(name.buf, mail.buf,
     ++						     WANT_BLANK_IDENT, date, 0));
     ++		strbuf_release(&name);
     ++		strbuf_release(&mail);
     ++	}
      +
     -+	return data->nr >= data->want;
     ++	data->nr++;
     ++	return 0;
      +}
      +
      +static int parse_stash_index(const char *revision, size_t *idx)
     @@ builtin/stash.c: out:
      +	return 0;
      +}
      +
     -+static int store_rename_entry(struct rename_entry *entry, const char *msg)
     ++static int do_reword_stash(struct stash_info *info, size_t idx,
     ++			   const char *reworded_msg, int quiet)
      +{
     -+	if (!do_store_stash(&entry->oid, msg, 1))
     -+		return 0;
     -+	warning(_("could not restore stash entry %s; "
     -+		  "recover it with 'git stash store %s'"),
     -+		oid_to_hex(&entry->oid), oid_to_hex(&entry->oid));
     -+	return -1;
     -+}
     -+
     -+static int do_rename_stash(struct stash_info *info, size_t idx,
     -+			   const char *msg, int quiet)
     -+{
     -+	struct rename_data data = { .want = idx + 1 };
     -+	size_t i, missing = 0;
     ++	struct ref_store *refs = get_main_ref_store(the_repository);
     ++	struct ref_transaction *transaction = NULL;
     ++	struct reword_data data = { 0 };
     ++	struct strbuf err = STRBUF_INIT;
     ++	uint64_t index = 0;
     ++	size_t i;
      +	int ret = -1;
      +
     -+	refs_for_each_reflog_ent_reverse(get_main_ref_store(the_repository),
     -+					 ref_stash, collect_rename_entries,
     -+					 &data);
     ++	refs_for_each_reflog_ent_reverse(refs, ref_stash,
     ++					 collect_reword_entries, &data);
      +	if (data.nr <= idx) {
      +		error(_("%s does not exist"), info->revision.buf);
      +		goto cleanup;
      +	}
      +
     -+	if (!oideq(&info->w_commit, &data.entries[idx].oid)) {
     ++	if (!oideq(&info->w_commit, &data.entries[idx].new_oid)) {
      +		error(_("%s changed concurrently; try again"),
      +		      info->revision.buf);
      +		goto cleanup;
      +	}
      +
     -+	/* refuse up front; do_store_stash() would die halfway through */
     -+	for (i = 0; i < data.nr; i++) {
     ++	for (i = 0; i <= idx; i++) {
      +		struct commit *stash = lookup_commit_reference(the_repository,
     -+							       &data.entries[i].oid);
     ++							       &data.entries[i].new_oid);
      +
      +		if (!stash || check_stash_topology(the_repository, stash)) {
      +			error(_("%s does not look like a stash commit"),
     -+			      oid_to_hex(&data.entries[i].oid));
     ++			      oid_to_hex(&data.entries[i].new_oid));
      +			goto cleanup;
      +		}
      +	}
      +
     -+	while (missing <= idx) {
     -+		if (drop_reflog_entry("stash@{0}"))
     -+			goto restore;
     -+		missing++;
     ++	if (refs_delete_reflog(refs, ref_stash)) {
     ++		error(_("could not rewrite %s"), ref_stash);
     ++		goto cleanup;
      +	}
      +
     -+	ret = 0;
     -+	while (missing) {
     -+		i = missing - 1;
     -+		if (store_rename_entry(&data.entries[i],
     -+				       i == idx ? msg : data.entries[i].msg))
     -+			ret = -1;
     -+		missing--;
     ++	transaction = ref_store_transaction_begin(refs, 0, &err);
     ++	if (!transaction)
     ++		goto restore;
     ++
     ++	for (i = data.nr; i-- > 0; ) {
     ++		if (ref_transaction_update_reflog(transaction, ref_stash,
     ++						  &data.entries[i].new_oid,
     ++						  &data.entries[i].old_oid,
     ++						  data.entries[i].committer,
     ++						  i == idx ? reworded_msg :
     ++							     data.entries[i].msg,
     ++						  index++, &err))
     ++			goto restore;
      +	}
      +
     -+	if (!ret && !quiet)
     -+		printf_ln(_("Renamed %s (%s)"), info->revision.buf,
     -+			  oid_to_hex(&data.entries[idx].oid));
     ++	if (ref_transaction_commit(transaction, &err))
     ++		goto restore;
     ++
     ++	ret = 0;
     ++	if (!quiet)
     ++		printf_ln(_("Reworded %s (%s)"), info->revision.buf,
     ++			  oid_to_hex(&data.entries[idx].new_oid));
      +	goto cleanup;
      +
      +restore:
     -+	/* dropping failed midway; put the dropped entries back */
     -+	while (missing) {
     -+		store_rename_entry(&data.entries[missing - 1],
     -+				   data.entries[missing - 1].msg);
     -+		missing--;
     -+	}
     ++	if (err.len)
     ++		error("%s", err.buf);
     ++	ref_transaction_free(transaction);
     ++	transaction = NULL;
     ++	for (i = data.nr; i-- > 0; )
     ++		if (do_store_stash(&data.entries[i].new_oid,
     ++				   data.entries[i].msg, 1))
     ++			warning(_("could not restore stash entry %s; "
     ++				  "recover it with 'git stash store %s'"),
     ++				oid_to_hex(&data.entries[i].new_oid),
     ++				oid_to_hex(&data.entries[i].new_oid));
      +cleanup:
     -+	for (i = 0; i < data.nr; i++)
     ++	ref_transaction_free(transaction);
     ++	strbuf_release(&err);
     ++	for (i = 0; i < data.nr; i++) {
     ++		free(data.entries[i].committer);
      +		free(data.entries[i].msg);
     ++	}
      +	free(data.entries);
      +	return ret;
      +}
      +
     -+static int rename_stash(int argc, const char **argv, const char *prefix,
     ++static int reword_stash(int argc, const char **argv, const char *prefix,
      +			struct repository *repo UNUSED)
      +{
      +	int ret = -1;
     @@ builtin/stash.c: out:
      +	};
      +
      +	argc = parse_options(argc, argv, prefix, options,
     -+			     git_stash_rename_usage, 0);
     ++			     git_stash_reword_usage, 0);
      +
      +	if (!argc)
     -+		usage_with_options(git_stash_rename_usage, options);
     ++		usage_with_options(git_stash_reword_usage, options);
      +
      +	if (!argv[0][strspn(argv[0], " \t\r\n")]) {
      +		ret = error(_("stash message cannot be empty"));
     @@ builtin/stash.c: out:
      +	if (get_stash_info_assert(&info, argc - 1, argv + 1))
      +		goto cleanup;
      +
     -+	/* positions must stay stable across the drop-and-store sequence */
      +	if (parse_stash_index(info.revision.buf, &idx)) {
     -+		error(_("cannot rename '%s': name the entry by index, "
     ++		error(_("cannot reword '%s': name the entry by index, "
      +			"like 'stash@{1}'"), info.revision.buf);
      +		goto cleanup;
      +	}
      +
     -+	ret = do_rename_stash(&info, idx, argv[0], quiet);
     ++	ret = do_reword_stash(&info, idx, argv[0], quiet);
      +cleanup:
      +	free_stash_info(&info);
      +	return ret;
     @@ builtin/stash.c: int cmd_stash(int argc,
       		OPT_SUBCOMMAND("push", &fn, push_stash_unassumed),
       		OPT_SUBCOMMAND("export", &fn, export_stash),
       		OPT_SUBCOMMAND("import", &fn, import_stash),
     -+		OPT_SUBCOMMAND("rename", &fn, rename_stash),
     ++		OPT_SUBCOMMAND("reword", &fn, reword_stash),
       		OPT_SUBCOMMAND_F("save", &fn, save_stash, PARSE_OPT_NOCOMPLETE),
       		OPT_END()
       	};
     @@ contrib/completion/git-completion.bash: _git_sparse_checkout ()
       _git_stash ()
       {
      -	local subcommands='push list show apply clear drop pop create branch import export'
     -+	local subcommands='push list show apply clear drop pop create branch import export rename'
     ++	local subcommands='push list show apply clear drop pop create branch import export reword'
       	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
       
       	if [ -z "$subcommand" ]; then
     @@ contrib/completion/git-completion.bash: _git_stash ()
       		__git_complete_refs
       		;;
      -	show,*|apply,*|drop,*|pop,*|export,*)
     -+	show,*|apply,*|drop,*|pop,*|export,*|rename,*)
     ++	show,*|apply,*|drop,*|pop,*|export,*|reword,*)
       		__gitcomp_nl "$(__git stash list \
       				| sed -n -e 's/:.*//p')"
       		;;
     @@ t/t3903-stash.sh: test_expect_success 'stash show --include-untracked includes u
       	test_grep "untracked" actual
       '
       
     -+test_expect_success 'rename a stash entry' '
     ++test_expect_success 'reword a stash entry' '
      +	git stash clear &&
     -+	>file-to-rename &&
     -+	git add file-to-rename &&
     ++	>file-to-reword &&
     ++	git add file-to-reword &&
      +	git stash push -m "original message" &&
     -+	git stash rename "new message" stash@{0} >out &&
     -+	test_grep "Renamed stash@{0}" out &&
     ++	git stash reword "new message" stash@{0} >out &&
     ++	test_grep "Reworded stash@{0}" out &&
      +	git stash list >list &&
      +	test_grep "stash@{0}: new message" list &&
      +	test_grep ! "original message" list
      +'
      +
     -+test_expect_success 'rename defaults to the latest stash entry' '
     -+	git stash rename "default target" >out &&
     -+	test_grep "Renamed refs/stash@{0}" out &&
     ++test_expect_success 'reword defaults to the latest stash entry' '
     ++	git stash reword "default target" >out &&
     ++	test_grep "Reworded refs/stash@{0}" out &&
      +	git stash list >list &&
      +	test_grep "stash@{0}: default target" list
      +'
      +
     -+test_expect_success 'rename a deeper stash entry keeps positions and states' '
     ++test_expect_success 'reword a deeper stash entry keeps positions and states' '
      +	git stash clear &&
      +	for i in 1 2 3
      +	do
     @@ t/t3903-stash.sh: test_expect_success 'stash show --include-untracked includes u
      +		git stash push -m "message $i" || return 1
      +	done &&
      +	git rev-parse stash@{0} stash@{1} stash@{2} >expect &&
     -+	git stash rename "renamed middle" stash@{1} &&
     ++	git stash reword "reworded middle" stash@{1} &&
      +	git rev-parse stash@{0} stash@{1} stash@{2} >actual &&
      +	test_cmp expect actual &&
      +	git stash list >list &&
      +	test_grep "stash@{0}: On.*message 3" list &&
     -+	test_grep "stash@{1}: renamed middle" list &&
     ++	test_grep "stash@{1}: reworded middle" list &&
      +	test_grep "stash@{2}: On.*message 1" list
      +'
      +
     -+test_expect_success 'rename the deepest stash entry' '
     ++test_expect_success 'reword the deepest stash entry' '
      +	git rev-parse stash@{0} stash@{1} stash@{2} >expect &&
     -+	git stash rename "renamed deepest" stash@{2} &&
     ++	git stash reword "reworded deepest" stash@{2} &&
      +	git rev-parse stash@{0} stash@{1} stash@{2} >actual &&
      +	test_cmp expect actual &&
      +	git stash list >list &&
     -+	test_grep "stash@{2}: renamed deepest" list
     ++	test_grep "stash@{2}: reworded deepest" list
      +'
      +
     -+test_expect_success 'rename accepts a bare index and honors --quiet' '
     -+	git stash rename -q "quietly renamed" 1 >out &&
     ++test_expect_success 'reword accepts a bare index and honors --quiet' '
     ++	git stash reword -q "quietly reworded" 1 >out &&
      +	test_must_be_empty out &&
      +	git stash list >list &&
     -+	test_grep "stash@{1}: quietly renamed" list
     ++	test_grep "stash@{1}: quietly reworded" list
      +'
      +
     -+test_expect_success 'rename rejects bad arguments' '
     -+	test_must_fail git stash rename "no such entry" stash@{99} &&
     -+	test_must_fail git stash rename "" &&
     -+	test_must_fail git stash rename "   " &&
     -+	test_must_fail git stash rename "not a stash" HEAD &&
     -+	test_must_fail git stash rename "not an index" "stash@{now}" &&
     -+	test_expect_code 129 git stash rename &&
     ++test_expect_success 'reword rejects bad arguments' '
     ++	test_must_fail git stash reword "no such entry" stash@{99} &&
     ++	test_must_fail git stash reword "" &&
     ++	test_must_fail git stash reword "   " &&
     ++	test_must_fail git stash reword "not a stash" HEAD &&
     ++	test_must_fail git stash reword "not an index" "stash@{now}" &&
     ++	test_expect_code 129 git stash reword &&
      +	git stash list >list &&
     -+	test_grep "stash@{1}: quietly renamed" list
     ++	test_grep "stash@{1}: quietly reworded" list
      +'
      +
     -+test_expect_success 'rename refuses to rewrite a non-stash reflog entry' '
     ++test_expect_success 'reword refuses to rewrite a non-stash reflog entry' '
      +	git stash clear &&
      +	>real-a &&
      +	git add real-a &&
     @@ t/t3903-stash.sh: test_expect_success 'stash show --include-untracked includes u
      +	git add real-b &&
      +	git stash push -m "real B" &&
      +	git stash list >expect &&
     -+	test_must_fail git stash rename "renamed A" stash@{2} &&
     ++	test_must_fail git stash reword "reworded A" stash@{2} &&
      +	git stash list >actual &&
      +	test_cmp expect actual
      +'


 Documentation/git-stash.adoc           |  10 +-
 builtin/stash.c                        | 201 +++++++++++++++++++++++++
 contrib/completion/git-completion.bash |   4 +-
 t/t3903-stash.sh                       |  79 ++++++++++
 4 files changed, 290 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index 50bb89f483..16a2a015f3 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -25,6 +25,7 @@ git stash create [<message>]
 git stash store [(-m | --message) <message>] [-q | --quiet] <commit>
 git stash export (--print | --to-ref <ref>) [<stash>...]
 git stash import <commit>
+git stash reword [-q | --quiet] <message> [<stash>]
 
 DESCRIPTION
 -----------
@@ -163,6 +164,11 @@ with no conflicts.
 	created by `export`, and add them to the list of stashes.  To replace the
 	existing stashes, use `clear` first.
 
+`reword [-q | --quiet] <message> [<stash>]`::
+	Change the message of a single stash entry.  The entry keeps its
+	position, its contents and its reflog timestamp.  _<stash>_ must
+	name an entry by index (e.g. `stash@{1}`).
+
 OPTIONS
 -------
 `-a`::
@@ -258,7 +264,7 @@ literally (including newlines and quotes).
 `-q`::
 `--quiet`::
 	This option is only valid for `apply`, `drop`, `pop`, `push`,
-	`save`, `store` commands.
+	`reword`, `save`, `store` commands.
 +
 Quiet, suppress feedback messages.
 
@@ -292,7 +298,7 @@ For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 
 _<stash>_::
 	This option is only valid for `apply`, `branch`, `drop`, `pop`,
-	`show`, and `export` commands.
+	`show`, `export`, and `reword` commands.
 +
 A reference of the form `stash@{<revision>}`. When no _<stash>_ is
 given, the latest stash is assumed (that is, `stash@{0}`).
diff --git a/builtin/stash.c b/builtin/stash.c
index c4809f299a..61471cf510 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -4,9 +4,11 @@
 #include "abspath.h"
 #include "config.h"
 #include "environment.h"
+#include "date.h"
 #include "gettext.h"
 #include "hash.h"
 #include "hex.h"
+#include "ident.h"
 #include "object-name.h"
 #include "parse-options.h"
 #include "refs.h"
@@ -63,6 +65,8 @@
 	N_("git stash export (--print | --to-ref <ref>) [<stash>...]")
 #define BUILTIN_STASH_IMPORT_USAGE \
 	N_("git stash import <commit>")
+#define BUILTIN_STASH_REWORD_USAGE \
+	N_("git stash reword [-q | --quiet] <message> [<stash>]")
 #define BUILTIN_STASH_CLEAR_USAGE \
 	"git stash clear"
 
@@ -80,6 +84,7 @@ static const char * const git_stash_usage[] = {
 	BUILTIN_STASH_STORE_USAGE,
 	BUILTIN_STASH_EXPORT_USAGE,
 	BUILTIN_STASH_IMPORT_USAGE,
+	BUILTIN_STASH_REWORD_USAGE,
 	NULL
 };
 
@@ -143,6 +148,11 @@ static const char * const git_stash_import_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_reword_usage[] = {
+	BUILTIN_STASH_REWORD_USAGE,
+	NULL
+};
+
 static const char ref_stash[] = "refs/stash";
 static struct strbuf stash_index_path = STRBUF_INIT;
 
@@ -1190,6 +1200,196 @@ out:
 	return ret;
 }
 
+struct reword_entry {
+	struct object_id old_oid;
+	struct object_id new_oid;
+	char *committer;
+	char *msg;
+};
+
+struct reword_data {
+	struct reword_entry *entries;
+	size_t nr, alloc;
+};
+
+static int collect_reword_entries(const char *refname UNUSED,
+				  struct object_id *old_oid,
+				  struct object_id *new_oid,
+				  const char *committer,
+				  timestamp_t timestamp,
+				  int tz, const char *msg,
+				  void *cb_data)
+{
+	struct reword_data *data = cb_data;
+	const char *eol = strchrnul(msg, '\n');
+	struct reword_entry *entry;
+	struct ident_split ident;
+
+	ALLOC_GROW(data->entries, data->nr + 1, data->alloc);
+	entry = &data->entries[data->nr];
+	oidcpy(&entry->old_oid, old_oid);
+	oidcpy(&entry->new_oid, new_oid);
+	entry->msg = xstrndup(msg, eol - msg);
+
+	if (split_ident_line(&ident, committer, strlen(committer)) < 0) {
+		entry->committer = xstrdup(committer);
+	} else {
+		struct strbuf name = STRBUF_INIT, mail = STRBUF_INIT;
+		const char *date = show_date(timestamp, tz, DATE_MODE(NORMAL));
+
+		strbuf_add(&name, ident.name_begin,
+			   ident.name_end - ident.name_begin);
+		strbuf_add(&mail, ident.mail_begin,
+			   ident.mail_end - ident.mail_begin);
+		entry->committer = xstrdup(fmt_ident(name.buf, mail.buf,
+						     WANT_BLANK_IDENT, date, 0));
+		strbuf_release(&name);
+		strbuf_release(&mail);
+	}
+
+	data->nr++;
+	return 0;
+}
+
+static int parse_stash_index(const char *revision, size_t *idx)
+{
+	const char *num = strstr(revision, "@{");
+	char *end;
+
+	if (!num || !isdigit(num[2]))
+		return -1;
+	*idx = strtoumax(num + 2, &end, 10);
+	if (*end != '}' || end[1])
+		return -1;
+
+	return 0;
+}
+
+static int do_reword_stash(struct stash_info *info, size_t idx,
+			   const char *reworded_msg, int quiet)
+{
+	struct ref_store *refs = get_main_ref_store(the_repository);
+	struct ref_transaction *transaction = NULL;
+	struct reword_data data = { 0 };
+	struct strbuf err = STRBUF_INIT;
+	uint64_t index = 0;
+	size_t i;
+	int ret = -1;
+
+	refs_for_each_reflog_ent_reverse(refs, ref_stash,
+					 collect_reword_entries, &data);
+	if (data.nr <= idx) {
+		error(_("%s does not exist"), info->revision.buf);
+		goto cleanup;
+	}
+
+	if (!oideq(&info->w_commit, &data.entries[idx].new_oid)) {
+		error(_("%s changed concurrently; try again"),
+		      info->revision.buf);
+		goto cleanup;
+	}
+
+	for (i = 0; i <= idx; i++) {
+		struct commit *stash = lookup_commit_reference(the_repository,
+							       &data.entries[i].new_oid);
+
+		if (!stash || check_stash_topology(the_repository, stash)) {
+			error(_("%s does not look like a stash commit"),
+			      oid_to_hex(&data.entries[i].new_oid));
+			goto cleanup;
+		}
+	}
+
+	if (refs_delete_reflog(refs, ref_stash)) {
+		error(_("could not rewrite %s"), ref_stash);
+		goto cleanup;
+	}
+
+	transaction = ref_store_transaction_begin(refs, 0, &err);
+	if (!transaction)
+		goto restore;
+
+	for (i = data.nr; i-- > 0; ) {
+		if (ref_transaction_update_reflog(transaction, ref_stash,
+						  &data.entries[i].new_oid,
+						  &data.entries[i].old_oid,
+						  data.entries[i].committer,
+						  i == idx ? reworded_msg :
+							     data.entries[i].msg,
+						  index++, &err))
+			goto restore;
+	}
+
+	if (ref_transaction_commit(transaction, &err))
+		goto restore;
+
+	ret = 0;
+	if (!quiet)
+		printf_ln(_("Reworded %s (%s)"), info->revision.buf,
+			  oid_to_hex(&data.entries[idx].new_oid));
+	goto cleanup;
+
+restore:
+	if (err.len)
+		error("%s", err.buf);
+	ref_transaction_free(transaction);
+	transaction = NULL;
+	for (i = data.nr; i-- > 0; )
+		if (do_store_stash(&data.entries[i].new_oid,
+				   data.entries[i].msg, 1))
+			warning(_("could not restore stash entry %s; "
+				  "recover it with 'git stash store %s'"),
+				oid_to_hex(&data.entries[i].new_oid),
+				oid_to_hex(&data.entries[i].new_oid));
+cleanup:
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
+	for (i = 0; i < data.nr; i++) {
+		free(data.entries[i].committer);
+		free(data.entries[i].msg);
+	}
+	free(data.entries);
+	return ret;
+}
+
+static int reword_stash(int argc, const char **argv, const char *prefix,
+			struct repository *repo UNUSED)
+{
+	int ret = -1;
+	int quiet = 0;
+	size_t idx;
+	struct stash_info info = STASH_INFO_INIT;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_reword_usage, 0);
+
+	if (!argc)
+		usage_with_options(git_stash_reword_usage, options);
+
+	if (!argv[0][strspn(argv[0], " \t\r\n")]) {
+		ret = error(_("stash message cannot be empty"));
+		goto cleanup;
+	}
+
+	if (get_stash_info_assert(&info, argc - 1, argv + 1))
+		goto cleanup;
+
+	if (parse_stash_index(info.revision.buf, &idx)) {
+		error(_("cannot reword '%s': name the entry by index, "
+			"like 'stash@{1}'"), info.revision.buf);
+		goto cleanup;
+	}
+
+	ret = do_reword_stash(&info, idx, argv[0], quiet);
+cleanup:
+	free_stash_info(&info);
+	return ret;
+}
+
 static void add_pathspecs(struct strvec *args,
 			  const struct pathspec *ps) {
 	int i;
@@ -2472,6 +2672,7 @@ int cmd_stash(int argc,
 		OPT_SUBCOMMAND("push", &fn, push_stash_unassumed),
 		OPT_SUBCOMMAND("export", &fn, export_stash),
 		OPT_SUBCOMMAND("import", &fn, import_stash),
+		OPT_SUBCOMMAND("reword", &fn, reword_stash),
 		OPT_SUBCOMMAND_F("save", &fn, save_stash, PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e875787710..261c6bf101 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3465,7 +3465,7 @@ _git_sparse_checkout ()
 
 _git_stash ()
 {
-	local subcommands='push list show apply clear drop pop create branch import export'
+	local subcommands='push list show apply clear drop pop create branch import export reword'
 	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
 
 	if [ -z "$subcommand" ]; then
@@ -3508,7 +3508,7 @@ _git_stash ()
 	import,*)
 		__git_complete_refs
 		;;
-	show,*|apply,*|drop,*|pop,*|export,*)
+	show,*|apply,*|drop,*|pop,*|export,*|reword,*)
 		__gitcomp_nl "$(__git stash list \
 				| sed -n -e 's/:.*//p')"
 		;;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index ecc35aae82..07fbbddac8 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1831,4 +1831,83 @@ test_expect_success 'stash show --include-untracked includes untracked files' '
 	test_grep "untracked" actual
 '
 
+test_expect_success 'reword a stash entry' '
+	git stash clear &&
+	>file-to-reword &&
+	git add file-to-reword &&
+	git stash push -m "original message" &&
+	git stash reword "new message" stash@{0} >out &&
+	test_grep "Reworded stash@{0}" out &&
+	git stash list >list &&
+	test_grep "stash@{0}: new message" list &&
+	test_grep ! "original message" list
+'
+
+test_expect_success 'reword defaults to the latest stash entry' '
+	git stash reword "default target" >out &&
+	test_grep "Reworded refs/stash@{0}" out &&
+	git stash list >list &&
+	test_grep "stash@{0}: default target" list
+'
+
+test_expect_success 'reword a deeper stash entry keeps positions and states' '
+	git stash clear &&
+	for i in 1 2 3
+	do
+		>file$i &&
+		git add file$i &&
+		git stash push -m "message $i" || return 1
+	done &&
+	git rev-parse stash@{0} stash@{1} stash@{2} >expect &&
+	git stash reword "reworded middle" stash@{1} &&
+	git rev-parse stash@{0} stash@{1} stash@{2} >actual &&
+	test_cmp expect actual &&
+	git stash list >list &&
+	test_grep "stash@{0}: On.*message 3" list &&
+	test_grep "stash@{1}: reworded middle" list &&
+	test_grep "stash@{2}: On.*message 1" list
+'
+
+test_expect_success 'reword the deepest stash entry' '
+	git rev-parse stash@{0} stash@{1} stash@{2} >expect &&
+	git stash reword "reworded deepest" stash@{2} &&
+	git rev-parse stash@{0} stash@{1} stash@{2} >actual &&
+	test_cmp expect actual &&
+	git stash list >list &&
+	test_grep "stash@{2}: reworded deepest" list
+'
+
+test_expect_success 'reword accepts a bare index and honors --quiet' '
+	git stash reword -q "quietly reworded" 1 >out &&
+	test_must_be_empty out &&
+	git stash list >list &&
+	test_grep "stash@{1}: quietly reworded" list
+'
+
+test_expect_success 'reword rejects bad arguments' '
+	test_must_fail git stash reword "no such entry" stash@{99} &&
+	test_must_fail git stash reword "" &&
+	test_must_fail git stash reword "   " &&
+	test_must_fail git stash reword "not a stash" HEAD &&
+	test_must_fail git stash reword "not an index" "stash@{now}" &&
+	test_expect_code 129 git stash reword &&
+	git stash list >list &&
+	test_grep "stash@{1}: quietly reworded" list
+'
+
+test_expect_success 'reword refuses to rewrite a non-stash reflog entry' '
+	git stash clear &&
+	>real-a &&
+	git add real-a &&
+	git stash push -m "real A" &&
+	git update-ref -m junk --create-reflog refs/stash HEAD &&
+	>real-b &&
+	git add real-b &&
+	git stash push -m "real B" &&
+	git stash list >expect &&
+	test_must_fail git stash reword "reworded A" stash@{2} &&
+	git stash list >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: 55526a18268bbc1ddaf8a6b7850c33d984eac9e9
-- 
gitgitgadget
