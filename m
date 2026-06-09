Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CFB3F0ABA
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999652; cv=none; b=OmtjBRQ8V5x6GAoICwCmeirfe741P4/TA5rB+vB+8ZnJMnJliRJlt/QgPfyTpRDzsp5PwcP5AZL4e67BHrU6Nf7cqawXeRRnYNQkrosTaYMakVtwxBFBK7F282vIOGHQ/hLeQP6+u271FLoU9ccr0fff8qv+jtqLx15c8A/r/J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999652; c=relaxed/simple;
	bh=+HPCnyoeYB24OkIDQEOBCo9PJTJ6srTJbMzc8MaH0Hs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KC81XaTOfgW77gbBppMBXtYazWBu3wqWSZG3qGbjQRxsY8WDR1B3LmHvoiP0P/kBnLaQjgNkqCe8xCl+q+GSkj3WtyqZAnM1bY2kLkb1d9uikKF22wf2/31KnDT8s2riRUcYyO33nQOQAm24+b6Y+ClqcQmnJHarvFZtokOVeVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+2oJTyw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+2oJTyw"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68c3421b009so9025675a12.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 03:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780999644; x=1781604444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O/19VW/KX3I81zFokDgcBgqVX/4nSNN1QY6Vn3gEBYU=;
        b=L+2oJTywGPBAuewz/vspGfjuCiK3uE2B3b8jERS8M4k6oJs8s02ydcDsx0ZhWChtdS
         2PiuBtXW0iXkKON0pWqml2R1jbn9AsWlJG491onFS6+SmfqeKhGn9XseztUHVG2BTJaB
         l7JG+H+xVV7d4lm0gBxF1ti6mW9FLtJbI0jkv6iIA2DpueBh3JyrGIOb0B61lKbAsiw5
         sflOh7fPiCf8H1B54UD1B5CMBQ90jzkB03AuZTDlz9ykRjDToD6zXaEfrccX+pjgghym
         dYPcUgqEjP038IISY5PaseOlA3W4rsUSRp4KShuG16TN21JJligtmnl+U/5Fe981/AeS
         d9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780999644; x=1781604444;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/19VW/KX3I81zFokDgcBgqVX/4nSNN1QY6Vn3gEBYU=;
        b=qDNYZEVPd/pjgwWzET1knT/4m8F83ExaQUIgUVfBmpVkBoDryB740ycS6C+b//zeWI
         fw1fIKPygVD5vRLhHtSpAemxylka1v1e+kXcdmFobI1YmzFP4gByNEK7qqqnOVC2JUAe
         4Cpy9dUs+vqP0K/qWo8MEjHQiKF+MZxh0ajolXBU1dT3t2h44F7aaVGuYi+MgC6FaFq8
         sdXSdVVuhUG/wLHjjzIT+gVjnr8MRzZtLqW7kIcOLW06wW5rUeOdL3j40BTAJrmx4Tee
         6je2HTqyxIIM+GpmvNTjKjKFbf1BP2VC5G+2F1zmzomg/IzIoPOGHOrcND46sSZIxp/m
         H9eg==
X-Forwarded-Encrypted: i=1; AFNElJ8MRdnQfMw6in3b5L5CB7YR1LqJg1bD3Epz9JQ4ge136FArgeCoAUBXK4xe1ScmICzEZFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuYf3AJVGOW0ZfnNOHDGmkzp/KxgZmTHI9mHLATF6S4qtt1LpZ
	+P1x/bk8kDHJy+VPb1sKgUC5lLACjlhmSQBJRTu6XE7NmuE8fAu8R5mp
X-Gm-Gg: Acq92OG6t+huqdn6Ir6ADDTwFwY3LxGQ4WUPCzMlTtPzh1CznxfAa00Z7Zp/Zl5PPvE
	lWpKjp2uwKiRv1cM5EyJlQIhUaFoDPv5jler2UXKn+aoz6NGkvzIJdYn8l84Ve4tqpPq3tOO5tR
	HZBapy5FcJCq9hUwsOrXg11h8Ac0ufCeryY2Vvc+po2TQpS2wfV+GwNIb/jUcllQTt3Lm2sZ6Va
	W+kADlMCE9DGraq49z54/aJ6hTbVd0P0vp5fOwXhCHHNU2BPLZo984DOlO6j4fUakNjBmcibVlv
	n24YTl8zgCy3Ss9WkfOvb7/mKs4nJTXximR9HGdHGozza9NxuMpsLgxgSMprctnpPIX445rJv4G
	xnmf3OSgPrA4ValhMG1K5uXAhS8BYq5R9u+4kfLPuT5glB193UFXqseLUHv0vAFzrZYSF26GhaA
	7DOYJr3nCV1hvn7pycaP5psjbBzuxI6dAGNA5a2O0ExJLvNpnlY/Lgf/TjLzuXB8nTFQlELxHCZ
	2B8CiuA+7qYuGzwGSLCrfSS63s=
X-Received: by 2002:a17:907:6c11:b0:bf9:b543:bb86 with SMTP id a640c23a62f3a-bf9b543c0aemr45494266b.6.1780999643243;
        Tue, 09 Jun 2026 03:07:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:56bf:64ff:fe70:f122? ([2a0a:ef40:69a:b801:56bf:64ff:fe70:f122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65868049sm8276914a12.24.2026.06.09.03.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 03:07:21 -0700 (PDT)
Message-ID: <2c44ef71-7530-495e-8d3f-ddfaa851b6ad@gmail.com>
Date: Tue, 9 Jun 2026 11:07:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] worktree: record creation time and free-form note
To: "Kiesel, Norbert" <norbert.kiesel@creditkarma.com>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, Chris Torek <chris.torek@gmail.com>,
 kristofferhaugsbakk@fastmail.com
References: <CAPGaHku+RAV+FA3C0md0xHiavfdB_anoqcMM06MAiU1VyMAdLA@mail.gmail.com>
 <b1b15a47-0842-4a26-9a95-bfdae12799e0@gmail.com>
 <CAPx1Gvegc0KvE8zb90n7vLJLKx6EkmBvCWW=NPf+nwiZc+oWdQ@mail.gmail.com>
 <CAPGaHkv=p62gLwkufc6TWjJR3OdV+DYdmWUZ6Xn0-qgHsw5_4Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPGaHkv=p62gLwkufc6TWjJR3OdV+DYdmWUZ6Xn0-qgHsw5_4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Norbert

On 08/06/2026 17:12, Kiesel, Norbert wrote:
> Hi team,
> I updated my proposed extension in a couple of ways you suggested, and
> also added some more test code.

It would be much easier to comment on these changes if they were split 
out into three separate patches (adding the description, adding the 
creation time and adding sorting) with commit messages that explained 
the motivation for each change.

Without a descripion of why each change is useful it is hard to comment 
further. At this stage explaining why these changes are useful is much 
more important than the code itself so that could be done without any 
patches.

Thanks

Phillip

> Best,
>    Norbert
> 
> diff --git Documentation/git-worktree.adoc Documentation/git-worktree.adoc
> index fbf8426cd9..1cdbdc8dbe 100644
> --- Documentation/git-worktree.adoc
> +++ Documentation/git-worktree.adoc
> @@ -10,8 +10,11 @@ SYNOPSIS
>   --------
>   [synopsis]
>   git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]
> + [--description <string>]
>    [--orphan] [(-b | -B) <new-branch>] <path> [<commit-ish>]
> -git worktree list [-v | --porcelain [-z]]
> +git worktree describe <worktree> [<description>]
> +git worktree list [-v | --porcelain [-z]] [--show-created]
> + [--show-updated] [--show-description] [--sort=<key>]
>   git worktree lock [--reason <string>] <worktree>
>   git worktree move <worktree> <new-path>
>   git worktree prune [-n] [-v] [--expire <expire>]
> @@ -106,6 +109,16 @@ passed to the command. In the event the
> repository has a remote and
>   command fails with a warning reminding the user to fetch from their remote
>   first (or override by using `-f`/`--force`).
> 
> +`describe <worktree> [<description>]`::
> +
> +Set, replace, or clear a free-form description on a linked worktree.
> +Useful for recording what a worktree was created for so it can be identified
> +later. With _<description>_, the worktree's description is set or replaced;
> +without a description argument, the existing description is cleared. The
> +description for a worktree may also be set at creation time with
> +`git worktree add --description <description>`. The main worktree cannot be
> +described.
> +
>   `list`::
> 
>   List details of each worktree.  The main worktree is listed first,
> @@ -114,6 +127,28 @@ whether the worktree is bare, the revision
> currently checked out, the
>   branch currently checked out (or "detached HEAD" if none), "locked" if
>   the worktree is locked, "prunable" if the worktree can be pruned by the
>   `prune` command.
> ++
> +Each worktree's creation timestamp is recorded when it is created with
> +`git worktree add`. Worktrees created before this feature existed have no
> +recorded creation timestamp; for them, `list` reports `created: unknown`
> +in human output and omits the `created` line in `--porcelain` output. Pass
> +`--show-created` to include creation timestamps in human output. Worktrees
> +without a recorded timestamp sort last (or first when reversed) with
> +`--sort=created`.
> ++
> +Pass `--show-updated` to include each worktree's last-updated timestamp,
> +which is the modification time of the worktree's `HEAD` file and so
> +reflects checkouts, commits, resets, rebases, and similar Git operations.
> ++
> +Pass `--show-description` to include any user-provided description in human
> +output. In `--porcelain` output, the `created`, `updated`, and
> +`description` lines are emitted whenever the underlying data is available.
> ++
> +Use `--sort=<key>` (where _<key>_ is `path`, `created`, or `updated`,
> +optionally prefixed with `-` to reverse) to order the linked worktrees;
> +the main worktree always remains first. Sorting by `created` or `updated`
> +implies the matching `--show-created` / `--show-updated` flag so the order
> +is visible alongside the data.
> 
>   `lock`::
> 
> @@ -286,6 +321,46 @@ _<time>_.
>    With `lock` or with `add --lock`, an explanation why the worktree
>    is locked.
> 
> +`--description <string>`::
> + With `add`, attach a free-form description to the new worktree.
> + The description is stored alongside the worktree's administrative
> + files and can be displayed with `git worktree list --show-description`
> + or in `--porcelain` output. It can be changed later with
> + `git worktree describe`.
> +
> +`--show-created`::
> + With `list`, include each worktree's creation timestamp in the
> + human-readable output. Worktrees with no recorded creation time are
> + shown as `created: unknown`. In `--porcelain` output, the creation
> + timestamp is always included (when available) on a `created` line.
> +
> +`--show-updated`::
> + With `list`, include each linked worktree's last-updated timestamp in
> + the human-readable output, derived from the modification time of the
> + worktree's `HEAD` file. Linked worktrees whose `HEAD` cannot be read
> + are shown as `updated: unknown`. The main worktree is not annotated
> + with an updated timestamp. In `--porcelain` output, the timestamp is
> + included on an `updated` line whenever it is available (and the
> + worktree is not the main worktree).
> +
> +`--show-description`::
> + With `list`, include each worktree's description (if set) in the
> + human-readable output. In `--porcelain` output, the description is
> + always included (when set) on a `description` line.
> +
> +`--sort=<key>`::
> + With `list`, sort linked worktrees by _<key>_, which is one of
> + `path`, `created`, or `updated`. Prefix with `-` to reverse the order,
> + e.g. `--sort=-created` lists newest first. The main worktree is always
> + listed first regardless of sort order. For `created`, worktrees with no
> + recorded creation timestamp sort after those that have one (or before,
> + when reversed). For `updated`, ordering is by the modification time of
> + each worktree's `HEAD` file (a proxy for when the worktree was last
> + touched by checkout, commit, reset or rebase); worktrees whose `HEAD`
> + cannot be read sort after those that can. Sorting by `created` or
> + `updated` implies the matching `--show-created` / `--show-updated`
> + option so the values driving the order appear in human output.
> +
>   _<worktree>_::
>    Worktrees can be identified by path, either relative or absolute.
>   +
> @@ -462,7 +537,10 @@ are terminated with NUL rather than a newline.
> Attributes are listed with a
>   label and value separated by a single space.  Boolean attributes (like `bare`
>   and `detached`) are listed as a label only, and are present only
>   if the value is true.  Some attributes (like `locked`) can be listed as a label
> -only or with a value depending upon whether a reason is available.  The first
> +only or with a value depending upon whether a reason is available.  Optional
> +valued attributes (like `created`, `updated`, and `description`) appear
> +only when the corresponding metadata has been recorded for that worktree.
> +The first
>   attribute of a worktree is always `worktree`, an empty line indicates the
>   end of the record.  For example:
> 
> @@ -474,10 +552,15 @@ bare
>   worktree /path/to/linked-worktree
>   HEAD abcd1234abcd1234abcd1234abcd1234abcd1234
>   branch refs/heads/master
> +created 2026-06-01T12:34:56Z
> +updated 2026-06-04T17:20:11Z
> +description investigating login bug
> 
>   worktree /path/to/other-linked-worktree
>   HEAD 1234abc1234abc1234abc1234abc1234abc1234a
>   detached
> +created 2026-05-28T08:15:00Z
> +updated 2026-05-30T09:42:08Z
> 
>   worktree /path/to/linked-worktree-locked-no-reason
>   HEAD 5678abc5678abc5678abc5678abc5678abc5678c
> diff --git builtin/worktree.c builtin/worktree.c
> index d21c43fde3..132de668e3 100644
> --- builtin/worktree.c
> +++ builtin/worktree.c
> @@ -27,13 +27,17 @@
>   #include "utf8.h"
>   #include "worktree.h"
>   #include "quote.h"
> +#include "date.h"
> 
>   #define BUILTIN_WORKTREE_ADD_USAGE \
>    N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason
> <string>]]\n" \
> +    "                 [--description <string>]\n" \
>       "                 [--orphan] [(-b | -B) <new-branch>] <path>
> [<commit-ish>]")
> 
>   #define BUILTIN_WORKTREE_LIST_USAGE \
> - N_("git worktree list [-v | --porcelain [-z]]")
> + N_("git worktree list [-v | --porcelain [-z]] [--show-created]\n" \
> +    "                  [--show-updated] [--show-description]\n" \
> +    "                  [--sort=<key>]")
>   #define BUILTIN_WORKTREE_LOCK_USAGE \
>    N_("git worktree lock [--reason <string>] <worktree>")
>   #define BUILTIN_WORKTREE_MOVE_USAGE \
> @@ -46,6 +50,8 @@
>    N_("git worktree repair [<path>...]")
>   #define BUILTIN_WORKTREE_UNLOCK_USAGE \
>    N_("git worktree unlock <worktree>")
> +#define BUILTIN_WORKTREE_DESCRIBE_USAGE \
> + N_("git worktree describe <worktree> [<description>]")
> 
>   #define WORKTREE_ADD_DWIM_ORPHAN_INFER_TEXT \
>    _("No possible source branch, inferring '--orphan'")
> @@ -66,6 +72,7 @@
> 
>   static const char * const git_worktree_usage[] = {
>    BUILTIN_WORKTREE_ADD_USAGE,
> + BUILTIN_WORKTREE_DESCRIBE_USAGE,
>    BUILTIN_WORKTREE_LIST_USAGE,
>    BUILTIN_WORKTREE_LOCK_USAGE,
>    BUILTIN_WORKTREE_MOVE_USAGE,
> @@ -116,6 +123,11 @@ static const char * const git_worktree_unlock_usage[] = {
>    NULL
>   };
> 
> +static const char * const git_worktree_describe_usage[] = {
> + BUILTIN_WORKTREE_DESCRIBE_USAGE,
> + NULL
> +};
> +
>   struct add_opts {
>    int force;
>    int detach;
> @@ -124,6 +136,7 @@ struct add_opts {
>    int orphan;
>    int relative_paths;
>    const char *keep_locked;
> + const char *description;
>   };
> 
>   static int show_only;
> @@ -131,6 +144,9 @@ static int verbose;
>   static int guess_remote;
>   static int use_relative_paths;
>   static timestamp_t expire;
> +static int show_created = -1;
> +static int show_updated = -1;
> +static int show_description;
> 
>   static int git_worktree_config(const char *var, const char *value,
>           const struct config_context *ctx, void *cb)
> @@ -544,6 +560,16 @@ static int add_worktree(const char *path, const
> char *refname,
>    strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
>    write_file(sb.buf, "../..");
> 
> + strbuf_reset(&sb);
> + strbuf_addf(&sb, "%s/created", sb_repo.buf);
> + write_file(sb.buf, "%"PRItime, (timestamp_t) time(NULL));
> +
> + if (opts->description && *opts->description) {
> + strbuf_reset(&sb);
> + strbuf_addf(&sb, "%s/description", sb_repo.buf);
> + write_file(sb.buf, "%s", opts->description);
> + }
> +
>    /*
>    * Set up the ref store of the worktree and create the HEAD reference.
>    */
> @@ -815,6 +841,8 @@ static int add(int ac, const char **av, const char *prefix,
>    OPT_BOOL(0, "lock", &keep_locked, N_("keep the new working tree locked")),
>    OPT_STRING(0, "reason", &lock_reason, N_("string"),
>       N_("reason for locking")),
> + OPT_STRING(0, "description", &opts.description, N_("string"),
> +    N_("attach a free-form description to the worktree")),
>    OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
>    OPT_PASSTHRU(0, "track", &opt_track, NULL,
>         N_("set up tracking mode (see git-branch(1))"),
> @@ -963,6 +991,8 @@ static int add(int ac, const char **av, const char *prefix,
>   static void show_worktree_porcelain(struct worktree *wt, int line_terminator)
>   {
>    const char *reason;
> + const char *description;
> + timestamp_t created;
> 
>    printf("worktree %s%c", wt->path, line_terminator);
>    if (wt->is_bare)
> @@ -975,6 +1005,26 @@ static void show_worktree_porcelain(struct
> worktree *wt, int line_terminator)
>    printf("branch %s%c", wt->head_ref, line_terminator);
>    }
> 
> + created = worktree_created_at(wt);
> + if (created)
> + printf("created %s%c",
> +        show_date(created, 0, DATE_MODE(ISO8601_STRICT)),
> +        line_terminator);
> +
> + {
> + timestamp_t updated = worktree_updated_at(wt);
> + if (updated)
> + printf("updated %s%c",
> +        show_date(updated, 0, DATE_MODE(ISO8601_STRICT)),
> +        line_terminator);
> + }
> +
> + description = worktree_description(wt);
> + if (description && *description) {
> + fputs("description ", stdout);
> + write_name_quoted(description, stdout, line_terminator);
> + }
> +
>    reason = worktree_lock_reason(wt);
>    if (reason) {
>    fputs("locked", stdout);
> @@ -1034,6 +1084,32 @@ static void show_worktree(struct worktree *wt,
> struct worktree_display *display,
>    else if (reason)
>    strbuf_addstr(&sb, " prunable");
> 
> + if (show_created > 0 || verbose) {
> + timestamp_t created = worktree_created_at(wt);
> + struct date_mode mode = { .type = DATE_ISO8601, .local = 1 };
> + if (created)
> + strbuf_addf(&sb, "\n\tcreated: %s",
> +     show_date(created, 0, mode));
> + else if (show_created > 0 && !is_main_worktree(wt))
> + strbuf_addstr(&sb, "\n\tcreated: unknown");
> + }
> +
> + if (show_updated > 0 || verbose) {
> + timestamp_t updated = worktree_updated_at(wt);
> + struct date_mode mode = { .type = DATE_ISO8601, .local = 1 };
> + if (updated)
> + strbuf_addf(&sb, "\n\tupdated: %s",
> +     show_date(updated, 0, mode));
> + else if (show_updated > 0 && !is_main_worktree(wt))
> + strbuf_addstr(&sb, "\n\tupdated: unknown");
> + }
> +
> + if (show_description || verbose) {
> + const char *description = worktree_description(wt);
> + if (description && *description)
> + strbuf_addf(&sb, "\n\tdescription: %s", description);
> + }
> +
>    printf("%s\n", sb.buf);
>    strbuf_release(&sb);
>   }
> @@ -1068,6 +1144,48 @@ static int pathcmp(const void *a_, const void *b_)
>    return fspathcmp((*a)->path, (*b)->path);
>   }
> 
> +static int createdcmp(const void *a_, const void *b_)
> +{
> + struct worktree *const *a = a_;
> + struct worktree *const *b = b_;
> + timestamp_t ta = worktree_created_at(*a);
> + timestamp_t tb = worktree_created_at(*b);
> +
> + /* Worktrees without a recorded timestamp (legacy) sort after those
> with one. */
> + if (!ta && !tb)
> + return fspathcmp((*a)->path, (*b)->path);
> + if (!ta)
> + return 1;
> + if (!tb)
> + return -1;
> + if (ta < tb)
> + return -1;
> + if (ta > tb)
> + return 1;
> + return 0;
> +}
> +
> +static int updatedcmp(const void *a_, const void *b_)
> +{
> + struct worktree *const *a = a_;
> + struct worktree *const *b = b_;
> + timestamp_t ta = worktree_updated_at(*a);
> + timestamp_t tb = worktree_updated_at(*b);
> +
> + /* Worktrees whose HEAD mtime can't be read sort after those that can. */
> + if (!ta && !tb)
> + return fspathcmp((*a)->path, (*b)->path);
> + if (!ta)
> + return 1;
> + if (!tb)
> + return -1;
> + if (ta < tb)
> + return -1;
> + if (ta > tb)
> + return 1;
> + return 0;
> +}
> +
>   static void pathsort(struct worktree **wt)
>   {
>    int n = 0;
> @@ -1078,11 +1196,45 @@ static void pathsort(struct worktree **wt)
>    QSORT(wt, n, pathcmp);
>   }
> 
> +static int sort_worktrees(struct worktree **wt, const char *key)
> +{
> + int n = 0, reverse = 0;
> + struct worktree **p = wt;
> + int (*cmp)(const void *, const void *);
> +
> + if (*key == '-') {
> + reverse = 1;
> + key++;
> + }
> + if (!strcmp(key, "path"))
> + cmp = pathcmp;
> + else if (!strcmp(key, "created"))
> + cmp = createdcmp;
> + else if (!strcmp(key, "updated"))
> + cmp = updatedcmp;
> + else
> + return -1;
> +
> + while (*p++)
> + n++;
> + QSORT(wt, n, cmp);
> + if (reverse) {
> + int i;
> + for (i = 0; i < n / 2; i++) {
> + struct worktree *tmp = wt[i];
> + wt[i] = wt[n - 1 - i];
> + wt[n - 1 - i] = tmp;
> + }
> + }
> + return 0;
> +}
> +
>   static int list(int ac, const char **av, const char *prefix,
>    struct repository *repo UNUSED)
>   {
>    int porcelain = 0;
>    int line_terminator = '\n';
> + const char *sort_key = NULL;
> 
>    struct option options[] = {
>    OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
> @@ -1091,6 +1243,14 @@ static int list(int ac, const char **av, const
> char *prefix,
>    N_("add 'prunable' annotation to missing worktrees older than <time>")),
>    OPT_SET_INT('z', NULL, &line_terminator,
>        N_("terminate records with a NUL character"), '\0'),
> + OPT_BOOL(0, "show-created", &show_created,
> + N_("show worktree creation timestamps")),
> + OPT_BOOL(0, "show-updated", &show_updated,
> + N_("show worktree last-updated timestamps")),
> + OPT_BOOL(0, "show-description", &show_description,
> + N_("show worktree descriptions")),
> + OPT_STRING(0, "sort", &sort_key, N_("key"),
> +    N_("sort worktrees by key (path, created, updated); prefix with -
> to reverse")),
>    OPT_END()
>    };
> 
> @@ -1107,8 +1267,27 @@ static int list(int ac, const char **av, const
> char *prefix,
>    int path_maxwidth = 0, abbrev = DEFAULT_ABBREV, i;
>    struct worktree_display *display = NULL;
> 
> - /* sort worktrees by path but keep main worktree at top */
> - pathsort(worktrees + 1);
> + /* sort worktrees but keep main worktree at top */
> + if (sort_key) {
> + const char *bare_key = sort_key;
> + if (*bare_key == '-')
> + bare_key++;
> + /*
> + * Sorting by a timestamp without showing it would
> + * leave the user guessing why the order is what it
> + * is, so opt in the matching display by default.
> + * An explicit --show-* / --no-show-* still wins.
> + */
> + if (!strcmp(bare_key, "created") && show_created < 0)
> + show_created = 1;
> + else if (!strcmp(bare_key, "updated") && show_updated < 0)
> + show_updated = 1;
> +
> + if (sort_worktrees(worktrees + 1, sort_key))
> + die(_("unknown sort key '%s'"), sort_key);
> + } else {
> + pathsort(worktrees + 1);
> + }
> 
>    if (!porcelain)
>    measure_widths(worktrees, &abbrev,
> @@ -1200,6 +1379,32 @@ static int unlock_worktree(int ac, const char
> **av, const char *prefix,
>    return ret;
>   }
> 
> +static int describe_worktree(int ac, const char **av, const char *prefix,
> +      struct repository *repo UNUSED)
> +{
> + struct option options[] = {
> + OPT_END()
> + };
> + struct worktree **worktrees, *wt;
> + int ret;
> +
> + ac = parse_options(ac, av, prefix, options, git_worktree_describe_usage, 0);
> + if (ac < 1 || ac > 2)
> + usage_with_options(git_worktree_describe_usage, options);
> +
> + worktrees = get_worktrees();
> + wt = find_worktree(worktrees, prefix, av[0]);
> + if (!wt)
> + die(_("'%s' is not a working tree"), av[0]);
> + if (is_main_worktree(wt))
> + die(_("The main working tree cannot be described"));
> +
> + ret = set_worktree_description(wt, ac == 2 ? av[1] : NULL);
> +
> + free_worktrees(worktrees);
> + return ret;
> +}
> +
>   static void validate_no_submodules(const struct worktree *wt)
>   {
>    struct index_state istate = INDEX_STATE_INIT(the_repository);
> @@ -1469,6 +1674,7 @@ int cmd_worktree(int ac,
>    parse_opt_subcommand_fn *fn = NULL;
>    struct option options[] = {
>    OPT_SUBCOMMAND("add", &fn, add),
> + OPT_SUBCOMMAND("describe", &fn, describe_worktree),
>    OPT_SUBCOMMAND("prune", &fn, prune),
>    OPT_SUBCOMMAND("list", &fn, list),
>    OPT_SUBCOMMAND("lock", &fn, lock_worktree),
> diff --git t/meson.build t/meson.build
> index 2af8d01279..7b6e8435d7 100644
> --- t/meson.build
> +++ t/meson.build
> @@ -308,6 +308,7 @@ integration_tests = [
>     't2405-worktree-submodule.sh',
>     't2406-worktree-repair.sh',
>     't2407-worktree-heads.sh',
> +  't2410-worktree-metadata.sh',
>     't2500-untracked-overwriting.sh',
>     't2501-cwd-empty.sh',
>     't3000-ls-files-others.sh',
> diff --git t/t2402-worktree-list.sh t/t2402-worktree-list.sh
> index e0c6abd2f5..fb1f4b1d3c 100755
> --- t/t2402-worktree-list.sh
> +++ t/t2402-worktree-list.sh
> @@ -71,7 +71,8 @@ test_expect_success '"list" all worktrees --porcelain' '
>    echo "HEAD $(git rev-parse HEAD)" >>expect &&
>    echo "detached" >>expect &&
>    echo >>expect &&
> - git worktree list --porcelain >actual &&
> + git worktree list --porcelain >actual.raw &&
> + grep -Ev "^(created|updated) " actual.raw >actual &&
>    test_cmp expect actual
>   '
> 
> @@ -86,7 +87,7 @@ test_expect_success '"list" all worktrees --porcelain -z' '
>    "$(git -C here rev-parse --show-toplevel)" \
>    "$(git rev-parse HEAD)" >>expect &&
>    git worktree list --porcelain -z >_actual &&
> - nul_to_q <_actual >actual &&
> + nul_to_q <_actual | tr Q "\n" | grep -Ev "^(created|updated) " | tr
> "\n" Q >actual &&
>    test_cmp expect actual
>   '
> 
> @@ -220,7 +221,7 @@ test_expect_success '"list" all worktrees from bare main' '
>   '
> 
>   test_expect_success '"list" all worktrees --porcelain from bare main' '
> - test_when_finished "rm -rf there actual expect && git -C bare1
> worktree prune" &&
> + test_when_finished "rm -rf there actual actual.raw expect && git -C
> bare1 worktree prune" &&
>    git -C bare1 worktree add --detach ../there main &&
>    echo "worktree $(pwd)/bare1" >expect &&
>    echo "bare" >>expect &&
> @@ -229,7 +230,8 @@ test_expect_success '"list" all worktrees
> --porcelain from bare main' '
>    echo "HEAD $(git -C there rev-parse HEAD)" >>expect &&
>    echo "detached" >>expect &&
>    echo >>expect &&
> - git -C bare1 worktree list --porcelain >actual &&
> + git -C bare1 worktree list --porcelain >actual.raw &&
> + grep -Ev "^(created|updated) " actual.raw >actual &&
>    test_cmp expect actual
>   '
> 
> diff --git t/t2410-worktree-metadata.sh t/t2410-worktree-metadata.sh
> new file mode 100755
> index 0000000000..e1ecb1c1bf
> --- /dev/null
> +++ t/t2410-worktree-metadata.sh
> @@ -0,0 +1,245 @@
> +#!/bin/sh
> +
> +test_description='git worktree creation timestamp and description metadata'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> + test_commit init
> +'
> +
> +test_expect_success 'add writes created file' '
> + test_when_finished "git worktree remove -f wt1 && git worktree prune" &&
> + git worktree add wt1 &&
> + test_path_is_file .git/worktrees/wt1/created &&
> + # contents should be a positive integer (unix timestamp)
> + created=$(cat .git/worktrees/wt1/created) &&
> + test "$created" -gt 0
> +'
> +
> +test_expect_success 'add --description writes description file' '
> + test_when_finished "git worktree remove -f wt2 && git worktree prune" &&
> + git worktree add --description "investigating bug" wt2 &&
> + test_path_is_file .git/worktrees/wt2/description &&
> + echo "investigating bug" >expect &&
> + test_cmp expect .git/worktrees/wt2/description
> +'
> +
> +test_expect_success 'add without --description does not create
> description file' '
> + test_when_finished "git worktree remove -f wt3 && git worktree prune" &&
> + git worktree add wt3 &&
> + test_path_is_missing .git/worktrees/wt3/description
> +'
> +
> +test_expect_success 'describe sets a description on an existing worktree' '
> + test_when_finished "git worktree remove -f wt4 && git worktree prune" &&
> + git worktree add wt4 &&
> + git worktree describe wt4 "later description" &&
> + echo "later description" >expect &&
> + test_cmp expect .git/worktrees/wt4/description
> +'
> +
> +test_expect_success 'describe replaces an existing description' '
> + test_when_finished "git worktree remove -f wt5 && git worktree prune" &&
> + git worktree add --description "old" wt5 &&
> + git worktree describe wt5 "new" &&
> + echo "new" >expect &&
> + test_cmp expect .git/worktrees/wt5/description
> +'
> +
> +test_expect_success 'describe with no text clears the description' '
> + test_when_finished "git worktree remove -f wt6 && git worktree prune" &&
> + git worktree add --description "to delete" wt6 &&
> + test_path_is_file .git/worktrees/wt6/description &&
> + git worktree describe wt6 &&
> + test_path_is_missing .git/worktrees/wt6/description
> +'
> +
> +test_expect_success 'describe refuses to operate on the main worktree' '
> + test_must_fail git worktree describe . "should fail" 2>err &&
> + grep -i "main working tree" err
> +'
> +
> +test_expect_success 'list --show-description displays description in
> human output' '
> + test_when_finished "git worktree remove -f wt7 && git worktree prune" &&
> + git worktree add --description "release branch" wt7 &&
> + git worktree list --show-description >actual &&
> + grep "description: release branch" actual
> +'
> +
> +test_expect_success 'list --show-created displays created timestamp' '
> + test_when_finished "git worktree remove -f wt8 && git worktree prune" &&
> + git worktree add wt8 &&
> + git worktree list --show-created >actual &&
> + grep "created: " actual
> +'
> +
> +test_expect_success 'list --show-created shows unknown for legacy worktrees' '
> + test_when_finished "git worktree remove -f wt9 && git worktree prune" &&
> + git worktree add wt9 &&
> + rm .git/worktrees/wt9/created &&
> + git worktree list --show-created >actual &&
> + grep "created: unknown" actual
> +'
> +
> +test_expect_success 'list --show-updated displays updated timestamp' '
> + test_when_finished "git worktree remove -f wt8u && git worktree prune" &&
> + git worktree add wt8u &&
> + git worktree list --show-updated >actual &&
> + grep "updated: " actual
> +'
> +
> +test_expect_success 'list --porcelain always includes created,
> updated, and description' '
> + test_when_finished "git worktree remove -f wtp && git worktree prune" &&
> + git worktree add --description "porcelain test" wtp &&
> + git worktree list --porcelain >actual &&
> + grep "^created " actual &&
> + grep "^updated " actual &&
> + grep "^description porcelain test" actual
> +'
> +
> +test_expect_success 'list --sort=created orders by creation time' '
> + test_when_finished "git worktree remove -f a && git worktree remove
> -f b && git worktree remove -f c && git worktree prune" &&
> + git worktree add a &&
> + git worktree add b &&
> + git worktree add c &&
> + echo 1000 >.git/worktrees/a/created &&
> + echo 2000 >.git/worktrees/b/created &&
> + echo 3000 >.git/worktrees/c/created &&
> + git worktree list --sort=created --porcelain >actual &&
> + grep "^worktree " actual | sed -n "2,4p" >linked &&
> + awk "NR==1" linked | grep -q "/a$" &&
> + awk "NR==2" linked | grep -q "/b$" &&
> + awk "NR==3" linked | grep -q "/c$"
> +'
> +
> +test_expect_success 'list --sort=-created reverses order' '
> + test_when_finished "git worktree remove -f a && git worktree remove
> -f b && git worktree remove -f c && git worktree prune" &&
> + git worktree add a &&
> + git worktree add b &&
> + git worktree add c &&
> + echo 1000 >.git/worktrees/a/created &&
> + echo 2000 >.git/worktrees/b/created &&
> + echo 3000 >.git/worktrees/c/created &&
> + git worktree list --sort=-created --porcelain >actual &&
> + grep "^worktree " actual | sed -n "2,4p" >linked &&
> + awk "NR==1" linked | grep -q "/c$" &&
> + awk "NR==2" linked | grep -q "/b$" &&
> + awk "NR==3" linked | grep -q "/a$"
> +'
> +
> +test_expect_success 'list --sort=created places legacy worktrees last' '
> + test_when_finished "git worktree remove -f early && git worktree
> remove -f legacy && git worktree prune" &&
> + git worktree add early &&
> + echo 1000 >.git/worktrees/early/created &&
> + git worktree add legacy &&
> + rm .git/worktrees/legacy/created &&
> + git worktree list --sort=created --porcelain >actual &&
> + grep "^worktree " actual | sed -n "2,3p" >linked &&
> + awk "NR==1" linked | grep -q "/early$" &&
> + awk "NR==2" linked | grep -q "/legacy$"
> +'
> +
> +test_expect_success 'list --sort=updated orders by HEAD mtime' '
> + test_when_finished "git worktree remove -f u1 && git worktree remove
> -f u2 && git worktree remove -f u3 && git worktree prune" &&
> + git worktree add u1 &&
> + git worktree add u2 &&
> + git worktree add u3 &&
> + # Force a known ordering: u2 oldest, u1 middle, u3 newest.
> + test-tool chmtime =1000 .git/worktrees/u2/HEAD &&
> + test-tool chmtime =2000 .git/worktrees/u1/HEAD &&
> + test-tool chmtime =3000 .git/worktrees/u3/HEAD &&
> + git worktree list --sort=updated --porcelain >actual &&
> + grep "^worktree " actual | sed -n "2,4p" >linked &&
> + awk "NR==1" linked | grep -q "/u2$" &&
> + awk "NR==2" linked | grep -q "/u1$" &&
> + awk "NR==3" linked | grep -q "/u3$"
> +'
> +
> +test_expect_success 'list --sort=-updated reverses order' '
> + test_when_finished "git worktree remove -f u1 && git worktree remove
> -f u2 && git worktree remove -f u3 && git worktree prune" &&
> + git worktree add u1 &&
> + git worktree add u2 &&
> + git worktree add u3 &&
> + test-tool chmtime =1000 .git/worktrees/u2/HEAD &&
> + test-tool chmtime =2000 .git/worktrees/u1/HEAD &&
> + test-tool chmtime =3000 .git/worktrees/u3/HEAD &&
> + git worktree list --sort=-updated --porcelain >actual &&
> + grep "^worktree " actual | sed -n "2,4p" >linked &&
> + awk "NR==1" linked | grep -q "/u3$" &&
> + awk "NR==2" linked | grep -q "/u1$" &&
> + awk "NR==3" linked | grep -q "/u2$"
> +'
> +
> +test_expect_success 'list --sort=created auto-shows created timestamp' '
> + test_when_finished "git worktree remove -f autoc && git worktree prune" &&
> + git worktree add autoc &&
> + git worktree list --sort=created >actual &&
> + grep "created: " actual
> +'
> +
> +test_expect_success 'list --sort=-created auto-shows created timestamp' '
> + test_when_finished "git worktree remove -f autocr && git worktree prune" &&
> + git worktree add autocr &&
> + git worktree list --sort=-created >actual &&
> + grep "created: " actual
> +'
> +
> +test_expect_success 'list --sort=updated auto-shows updated timestamp' '
> + test_when_finished "git worktree remove -f autou && git worktree prune" &&
> + git worktree add autou &&
> + git worktree list --sort=updated >actual &&
> + grep "updated: " actual
> +'
> +
> +test_expect_success 'list --sort=-updated auto-shows updated timestamp' '
> + test_when_finished "git worktree remove -f autour && git worktree prune" &&
> + git worktree add autour &&
> + git worktree list --sort=-updated >actual &&
> + grep "updated: " actual
> +'
> +
> +test_expect_success 'list --sort=path does not auto-show timestamps' '
> + test_when_finished "git worktree remove -f autop && git worktree prune" &&
> + git worktree add autop &&
> + git worktree list --sort=path >actual &&
> + ! grep "created: " actual &&
> + ! grep "updated: " actual
> +'
> +
> +test_expect_success 'list --sort with unknown key fails' '
> + test_must_fail git worktree list --sort=bogus 2>err &&
> + grep -i "unknown sort key" err
> +'
> +
> +test_expect_success 'list --sort=updated --no-show-updated suppresses
> auto-show' '
> + test_when_finished "git worktree remove -f noshowu && git worktree prune" &&
> + git worktree add noshowu &&
> + git worktree list --sort=updated --no-show-updated >actual &&
> + ! grep "updated: " actual
> +'
> +
> +test_expect_success 'list --sort=created --no-show-created suppresses
> auto-show' '
> + test_when_finished "git worktree remove -f noshowc && git worktree prune" &&
> + git worktree add noshowc &&
> + git worktree list --sort=created --no-show-created >actual &&
> + ! grep "created: " actual
> +'
> +
> +test_expect_success 'list --show-updated formats human output in
> local timezone' '
> + test_when_finished "git worktree remove -f tz && git worktree prune" &&
> + git worktree add tz &&
> + # Pin HEAD mtime to a fixed unix time outside any DST transition
> + # so the rendered offset is deterministic in PST8PDT (-0700 in July).
> + test-tool chmtime =1500000000 .git/worktrees/tz/HEAD &&
> + TZ=PST8PDT git worktree list --show-updated >human &&
> + grep "updated: 2017-07-13 19:40:00 -0700" human &&
> + # Porcelain stays in UTC ISO-8601 strict form regardless of TZ.
> + TZ=PST8PDT git worktree list --porcelain >porcelain &&
> + grep "^updated 2017-07-14T02:40:00Z$" porcelain
> +'
> +
> +test_done
> diff --git worktree.c worktree.c
> index 97eddc3916..4b019a532b 100644
> --- worktree.c
> +++ worktree.c
> @@ -14,6 +14,8 @@
>   #include "dir.h"
>   #include "wt-status.h"
>   #include "config.h"
> +#include "date.h"
> +#include "wrapper.h"
> 
>   void free_worktree(struct worktree *worktree)
>   {
> @@ -24,6 +26,7 @@ void free_worktree(struct worktree *worktree)
>    free(worktree->head_ref);
>    free(worktree->lock_reason);
>    free(worktree->prune_reason);
> + free(worktree->description);
>    free(worktree);
>   }
> 
> @@ -324,6 +327,100 @@ const char *worktree_lock_reason(struct worktree *wt)
>    return wt->lock_reason;
>   }
> 
> +timestamp_t worktree_created_at(struct worktree *wt)
> +{
> + if (is_main_worktree(wt))
> + return 0;
> +
> + if (!wt->created_at_valid) {
> + struct strbuf path = STRBUF_INIT;
> + struct strbuf buf = STRBUF_INIT;
> +
> + strbuf_addstr(&path, worktree_git_path(wt, "created"));
> + if (file_exists(path.buf) &&
> +     strbuf_read_file(&buf, path.buf, 0) >= 0) {
> + char *end;
> + timestamp_t t;
> + strbuf_trim(&buf);
> + t = parse_timestamp(buf.buf, &end, 10);
> + if (end != buf.buf && *end == '\0')
> + wt->created_at = t;
> + }
> + wt->created_at_valid = 1;
> + strbuf_release(&path);
> + strbuf_release(&buf);
> + }
> +
> + return wt->created_at;
> +}
> +
> +timestamp_t worktree_updated_at(struct worktree *wt)
> +{
> + struct stat st;
> + char *git_dir;
> + char *head_path;
> + timestamp_t result = 0;
> +
> + if (is_main_worktree(wt))
> + return 0;
> +
> + git_dir = get_worktree_git_dir(wt);
> + head_path = xstrfmt("%s/HEAD", git_dir);
> + if (!stat(head_path, &st))
> + result = (timestamp_t) st.st_mtime;
> + free(head_path);
> + free(git_dir);
> + return result;
> +}
> +
> +const char *worktree_description(struct worktree *wt)
> +{
> + if (is_main_worktree(wt))
> + return NULL;
> +
> + if (!wt->description_valid) {
> + struct strbuf path = STRBUF_INIT;
> +
> + strbuf_addstr(&path, worktree_git_path(wt, "description"));
> + if (file_exists(path.buf)) {
> + struct strbuf description = STRBUF_INIT;
> + if (strbuf_read_file(&description, path.buf, 0) < 0)
> + die_errno(_("failed to read '%s'"), path.buf);
> + strbuf_trim_trailing_newline(&description);
> + wt->description = strbuf_detach(&description, NULL);
> + } else
> + wt->description = NULL;
> + wt->description_valid = 1;
> + strbuf_release(&path);
> + }
> +
> + return wt->description;
> +}
> +
> +int set_worktree_description(struct worktree *wt, const char *text)
> +{
> + char *path;
> + int ret = 0;
> +
> + if (is_main_worktree(wt))
> + return error(_("cannot set description on the main worktree"));
> +
> + path = repo_common_path(wt->repo, "worktrees/%s/description", wt->id);
> + if (!text || !*text) {
> + if (file_exists(path) && unlink(path))
> + ret = error_errno(_("failed to remove '%s'"), path);
> + } else {
> + write_file(path, "%s", text);
> + }
> +
> + /* invalidate cache so a follow-up worktree_description() re-reads */
> + FREE_AND_NULL(wt->description);
> + wt->description_valid = 0;
> +
> + free(path);
> + return ret;
> +}
> +
>   const char *worktree_prune_reason(struct worktree *wt, timestamp_t expire)
>   {
>    struct strbuf reason = STRBUF_INIT;
> diff --git worktree.h worktree.h
> index 1075409f9a..2568830237 100644
> --- worktree.h
> +++ worktree.h
> @@ -13,12 +13,16 @@ struct worktree {
>    char *head_ref; /* NULL if HEAD is broken or detached */
>    char *lock_reason; /* private - use worktree_lock_reason */
>    char *prune_reason;     /* private - use worktree_prune_reason */
> + char *description; /* private - use worktree_description */
>    struct object_id head_oid;
> + timestamp_t created_at; /* private - use worktree_created_at; 0 if unknown */
>    int is_detached;
>    int is_bare;
>    int is_current; /* does `path` match `repo->worktree` */
>    int lock_reason_valid; /* private */
>    int prune_reason_valid; /* private */
> + int description_valid; /* private */
> + int created_at_valid;  /* private */
>   };
> 
>   /*
> @@ -96,6 +100,34 @@ int is_main_worktree(const struct worktree *wt);
>    */
>   const char *worktree_lock_reason(struct worktree *wt);
> 
> +/*
> + * Return the worktree's recorded creation timestamp, or 0 if no timestamp
> + * was recorded (e.g. a worktree created before this metadata existed, or
> + * the main worktree which never carries the file).
> + */
> +timestamp_t worktree_created_at(struct worktree *wt);
> +
> +/*
> + * Return the modification time of the worktree's HEAD file as an
> + * approximation of "when was this worktree last touched by Git" (checkout,
> + * commit, reset, rebase, etc.). Returns 0 for the main worktree, and 0 if
> + * HEAD cannot be stat'd.
> + */
> +timestamp_t worktree_updated_at(struct worktree *wt);
> +
> +/*
> + * Return the user-supplied description for the given worktree, or NULL
> + * if none was set.
> + */
> +const char *worktree_description(struct worktree *wt);
> +
> +/*
> + * Write or replace the worktree's description. Pass NULL or "" to delete
> + * the description. Returns 0 on success, -1 on failure. Not valid for the
> + * main worktree.
> + */
> +int set_worktree_description(struct worktree *wt, const char *text);
> +
>   /*
>    * Return the reason string if the given worktree should be pruned, otherwise
>    * NULL if it should not be pruned. `expire` defines a grace period to prune
> 
> On Fri, Jun 5, 2026 at 9:57 AM Chris Torek <chris.torek@gmail.com> wrote:
>>
>> On Fri, Jun 5, 2026 at 8:31 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>> Isn't "what is the worktree for" a property of the branch that's checked
>>> out, not the worktree itself?
>>
>> I don't think it is.
>>
>> A lot of things within Git have, shall way say, "less than optimal"
>> names, with "branch" (with at least three different meanings),
>> "HEAD", and "index" being examples of this. (This is just an
>> observation, not a complaint: we know from studies that
>> oddities in names don't matter that much after a bit of usage
>> of some system. They're just minor stumbling blocks when
>> getting started.)
>>
>> Work-tree or working tree is not one of them, though. It's
>> concise and pointed: a working tree is where you do work.
>>
>> As such, the *purpose* of a working tree is exactly as general
>> as the purpose of doing work! That's a wide-open set.
>>
>> Git's internal constraint, of requiring each working tree that
>> is using a branch name to have a unique-to-that-tree branch
>> name, is a property specific to branch names, not to branching
>> in general (an example of the ambiguity of "branch" here).
>> And of course, as you note, any working tree can be on
>> a detached HEAD.
>>
>> Exactly what properties any given working tree should
>> have, and the weird entanglement Git has between the
>> "primary" working tree (the one created by any non-bare
>> clone) and all "secondary" working trees, is a mere (ahem)
>> matter of implementation. Descriptions, creation times,
>> modification times, etc., are all potentially useful.
>>
>> I think, had Git initially made all repositories effectively
>> bare, with separate working trees added later, this might
>> all be a little clearer, but of course that ship sailed,
>> crossed *all* the oceans, sank, was refloated and refitted,
>> and sailed for another decade already. :-)
>>
>> Chris
> 
> 
> 

