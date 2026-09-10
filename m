Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D950397E89
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 04:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014539; cv=none; b=RGSzMklZI+RVl7KsEm2Ct5EY1OH2EG4DZpuoUZrb56sEd33rEeiL3+osTd0M1ktvZVaoVCMxZtKibegqG/jc4v1KXgjZKJ2y1s25P1aRTr1BeFHlCTxr5kRWmhGHCiXdnowvasbmrdp3Bz54L8pTVuMmF8mkU2jKTo46DQPYhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014539; c=relaxed/simple;
	bh=ix3jwhPHRSY4WYUXuL9PSS0AcPScu1CKBqh7C0LfFi0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WkQNYyjGCMfOiztpildMV7SE2I5sNsOsiWrj+kNDQx4skErz2r85AvKysN4h7uyocSqwzufYv+YK/imnxTJgGYIWNmSNCLICg084mPL7K0nHFpqRncyGrO+hjhmue+OHFERpwENSAcWZzrKxXMGG3GuFMjmIi50sr24GC4zuGxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h2DJHRmT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HgaElkPZ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h2DJHRmT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HgaElkPZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 888171D00126;
	Thu, 10 Sep 2026 00:28:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 10 Sep 2026 00:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789014536; x=1789100936; bh=BdG/t1T01x
	poreBBfJNFVns4NoV+ewiP4ShH8R6HOQY=; b=h2DJHRmTAmiDggmHBoEwerwHSC
	ludwPyp/Y1Lx8j9oO62TqTppQGep0HQTw2dGZ4FIrZlCOMDFsDe3CHXW2Sx2pDjU
	dsvYCTzf8iDUVhrPaI2TSaSG/kh9scc0n7X4HGGWocId9VWRO1ponRik77kCvgkH
	n8yC4DRkzDfENCKK6FwyyI8HxQqCY3tr8GqbcTbpAVu5HzSEYwaF5J1vLLqIJ57T
	A69RqPIKsuWqJ3sb8nYuaP8JOIy6lPuY1LXX19wZdUSZTC/PCaxbwiiczoHjVk1/
	IMr7YRuRxJQPm0ZblBiZZfQHkdff7//CNteSvZEWKRBIga1/H/0C62tFd0zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789014536; x=1789100936; bh=BdG/t1T01xporeBBfJNFVns4NoV+ewiP4Sh
	H8R6HOQY=; b=HgaElkPZWUoOW1LgLeAam7HqzgIHku6iuUjy690nPnunIx5iigB
	EE03sj1ryiq8GzcdtLL29boN9UoOQ6Zz+r+Mq2c0Cb37zpzgxwY/QjQEMmqEABUv
	nfa8Ig7ZADBImQnS9JG37/hS34iRpJYhy3dCCTeKAUyQxi12aW0dFRUajTlx7rNE
	6pm+Fq2ELapuR4APS1RgwK9KaghE6RcZpv5XFkoLwGqom/yzw49+DUn/mNS7BRjG
	iXsaVow408mLtWvxS4vt5T9116KbOAinH7OWk9yUyXC+2GOSMDeadTI55JDmYxZd
	EPPrmw7GsBshVv8eUZmWANeiIA7eDNvTcow==
X-ME-Sender: <xms:CDKiasyCj8VillArniKUUQDezEUnbF_ZtjuZPYbgtiBvQfJkNfDNuw>
    <xme:CDKianLf2qR691jbA7SmcFma-0eSj2hXpRJRE9NF_74X5lBcVmCFv5pQtyJSzOuOC
    e1KzOWpFjxIq-GvFN4PNEQSsJmKDehUomw9PYt0nW442EylQipWJfw>
X-ME-Received: <xmr:CDKiamoiHFJp17gI9Gnrt1sRv_uA4D8ZZ8N-VG3rfx1n-z7B7fTVBoB-6s8SIgMmK8n6TNG9MCv2fAJWx0pVqF9jf2La_iTos3BS>
X-ME-Proxy-Cause: dmFkZTFcZNzj8309y3P1SFuPxU3K/k1w33UI/R5QhANE5hemJUCxCR1gbfxQVgai/qAq5l
    O/xB3CF2lXpKquok1ExHbF+DG3qFL6xy888klap9oxTnpcnlvDG+s/7AMfY1UAagpmgdRx
    rIjB1+QTLYH7CHovfYNueJ7JdFu4jN5d484etLFZg7V6uHwcugmhNBnTevITLz14SuRoCW
    ewiW/eAGShAfY9yBrIVEEbnCPkJtWCxPFutCuMFF0t+QTLaT4Gbsd0VIlEu8jbgLU9bTmU
    l32UCbAfcX3uJOlOwszpWuuX+u8fZ4NvhjenJjVXoVjuS1ie8lYQcAh9Fda4ff//S18er/
    Vg+pNz4jTb5dz4NtXa53L7dS+oPS2h3/ye021CCoyJiY1DqGXniYemga3/k8eX1u2g0csU
    4A8GdvgEdAUhzMQyEPz9/Y1Wb8qqEpV9KejpIyJQzclmRg+Q6/ZNUy6j8BfW/08FPY/0F6
    kwRZwhUlX8DLD3sNpaqOp3VCla7o2JXYjQC/RBtjyJLhkLS6mLszqwTinSvylfNDhdfs0K
    95gE9zsjIRPf4HrSjG5sJY8O2vYTypxiBpuEvaP/a2Q2SbPF9Zjfi7zv4Hi9j4Ci0JHTfc
    kQf4eWQqMIyiQ+eJ0YAM1ZadFh42d1D1uvRls1v8X96l7ldxF0MSn+3Pup2A
X-ME-Proxy: <xmx:CDKiamINP2gBvU65Q_Mq4b6g09DgmKFeTFB3OY8ZA8Ky-s9E4AJzwA>
    <xmx:CDKiarR7TJBdO4yrFm1lUAMniTnwF9_z-MgEaEUuihgN6z7OzlKrkw>
    <xmx:CDKialu9oE2cJnVc7CpC2QrrKpYHFh_7INstWhaCTueteyMiJX0lBQ>
    <xmx:CDKiasaprUeBya3vCp19IIND6R1zTAIS1u8wU3W3_dm8R-R8HIrz5w>
    <xmx:CDKiamIParkI4UR14V_XKmHANAEtTHD3BTgLGo5AZ9CCG-clLFCuQrKy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 00:28:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Vsevolod Myalitsin <ub4nal@mail.ru>,  ben.knoble@gmail.com,
  git@vger.kernel.org
Subject: Re: [PATCH] advice: use global config for default branch name
In-Reply-To: <20260909195132.GA182066@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 9 Sep 2026 15:51:32 -0400")
References: <xmqqik4fyaav.fsf@gitster.g>
	<20260908213840.37833-1-ub4nal@mail.ru> <xmqqik4fwoz5.fsf@gitster.g>
	<20260909155440.GA94069@coredump.intra.peff.net>
	<xmqqv78eqmw8.fsf@gitster.g>
	<20260909195132.GA182066@coredump.intra.peff.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 09 Sep 2026 21:28:54 -0700
Message-ID: <xmqq5x0d4tmh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Sep 09, 2026 at 11:51:03AM -0700, Junio C Hamano wrote:
>
>> > will. So there are many missed opportunities for offering the turn-off
>> > instructions. Nobody seems to have complained, which makes me wonder if
>> > the turn-off instructions would be annoyingly chatty if we printed them
>> > all the time. Most of those calls predate the addition if the turn-off
>> > instructions and advise_if_enabled(), which was added in 2020. I wonder
>> > how people would feel if we converted them all and started printing the
>> > turn-off instructions everywhere.
>> 
>> Depends on how we do so, I guess.  Do you mean we should rewrite
>> advise() call above to advice_if_enabled(), even though the check
>> for ADVICE_FOO token appear redundant?
>
> I mean we could mechanically rewrite:
>
>   if (advice_enabled(ADVICE_FOO))
> 	advise(...);
>
> to:
>
>   advise_if_enabled(ADVICE_FOO, ...);

Surely, and I think we are pretty much on the same page.  Such a
mechanical rewrite is not too bad.  Here is what I came up with:

    $ edit tools/coccinelle/advice.cocci
    $ make coccicheck
    $ git add -N tools/coccinelle/advice.cocci
    $ git apply .build/tools/coccinelle/ALL.cocci.patch
    $ git add -p

    Some of the hunks I simply accepted with (y), but most of them
    needed (e)dit to make them presentable; otherwise we ended up
    with too many overly long lines and losing some comments.

--- >8 ---
Subject: [PATCH] advice: use advise_if_enabled() more

One very common pattern is

	if (advice_enabled(ADVICE_FOO))
		advise(_("MESSAGE FOR FOO"));

but we have a perfect short-hand for that.  Using coccinelle,
rewrite the above as

	advise_if_enabled(ADVICE_FOO, _("MESSAGE FOR FOR"));

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 advice.c                      | 13 ++++---------
 branch.c                      |  6 +++---
 builtin/am.c                  |  4 ++--
 builtin/checkout.c            |  4 ++--
 builtin/submodule--helper.c   |  4 ++--
 sequencer.c                   |  9 ++++-----
 tools/coccinelle/advice.cocci |  7 +++++++
 7 files changed, 24 insertions(+), 23 deletions(-)
 create mode 100644 tools/coccinelle/advice.cocci

diff --git a/advice.c b/advice.c
index 63bf8b0c5f..c60b33ee33 100644
--- a/advice.c
+++ b/advice.c
@@ -216,13 +216,8 @@ int error_resolve_conflict(const char *me)
 	else
 		BUG("Unhandled conflict reason '%s'", me);
 
-	if (advice_enabled(ADVICE_RESOLVE_CONFLICT))
-		/*
-		 * Message used both when 'git commit' fails and when
-		 * other commands doing a merge do.
-		 */
-		advise(_("Fix them up in the work tree, and then use 'git add/rm <file>'\n"
-			 "as appropriate to mark resolution and make a commit."));
+	advice_if_enabled(ADVICE_RESOLVE_CONFLICT,
+			  _("Fix them up in the work tree, and then use 'git add/rm <file>'\n" "as appropriate to mark resolution and make a commit."));
 	return -1;
 }
 
@@ -235,8 +230,8 @@ void NORETURN die_resolve_conflict(const char *me)
 void NORETURN die_conclude_merge(void)
 {
 	error(_("You have not concluded your merge (MERGE_HEAD exists)."));
-	if (advice_enabled(ADVICE_RESOLVE_CONFLICT))
-		advise(_("Please, commit your changes before merging."));
+	advice_if_enabled(ADVICE_RESOLVE_CONFLICT,
+			  _("Please, commit your changes before merging."));
 	die(_("Exiting because of unfinished merge."));
 }
 
diff --git a/branch.c b/branch.c
index 22f4f46b96..a87facd311 100644
--- a/branch.c
+++ b/branch.c
@@ -812,9 +812,9 @@ void create_branches_recursively(struct repository *r, const char *name,
 			int code = die_message(
 				_("submodule '%s': unable to find submodule"),
 				submodule_entry_list.entries[i].submodule->name);
-			if (advice_enabled(ADVICE_SUBMODULES_NOT_UPDATED))
-				advise(_("You may try updating the submodules using 'git checkout --no-recurse-submodules %s && git submodule update --init'"),
-				       start_committish);
+			advice_if_enabled(ADVICE_SUBMODULES_NOT_UPDATED,
+					  _("You may try updating the submodules using 'git checkout --no-recurse-submodules %s && git submodule update --init'"),
+					  start_committish);
 			exit(code);
 		}
 
diff --git a/builtin/am.c b/builtin/am.c
index e9623b8307..6039b69475 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1910,8 +1910,8 @@ static void am_run(struct am_state *state, int resume)
 			printf_ln(_("Patch failed at %s %.*s"), msgnum(state),
 				linelen(state->msg), state->msg);
 
-			if (advice_enabled(ADVICE_AM_WORK_DIR))
-				advise(_("Use 'git am --show-current-patch=diff' to see the failed patch"));
+			advice_if_enabled(ADVICE_AM_WORK_DIR,
+					  _("Use 'git am --show-current-patch=diff' to see the failed patch"));
 
 			die_user_resolve(state);
 		}
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2bc21aa49b..34f05d2381 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1612,8 +1612,8 @@ static void die_expecting_a_branch(const struct branch_info *branch_info)
 		 */
 		code = die_message(_("a branch is expected, got '%s'"), branch_info->name);
 
-	if (advice_enabled(ADVICE_SUGGEST_DETACHING_HEAD))
-		advise(_("If you want to detach HEAD at the commit, try again with the --detach option."));
+	advice_if_enabled(ADVICE_SUGGEST_DETACHING_HEAD,
+			  _("If you want to detach HEAD at the commit, try again with the --detach option."));
 
 	exit(code);
 }
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e7cd3225fa..5e4989a9aa 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1806,8 +1806,8 @@ static int add_possible_reference_from_superproject(
 		} else {
 			switch (sas->error_mode) {
 			case SUBMODULE_ALTERNATE_ERROR_DIE:
-				if (advice_enabled(ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE))
-					advise(_(alternate_error_advice));
+				advice_if_enabled(ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
+						  _(alternate_error_advice));
 				die(_("submodule '%s' cannot add alternate: %s"),
 				    sas->submodule_name, err.buf);
 			case SUBMODULE_ALTERNATE_ERROR_INFO:
diff --git a/sequencer.c b/sequencer.c
index 65afd100d9..6d8be0c036 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -624,8 +624,8 @@ static int error_dirty_index(struct repository *repo, struct replay_opts *opts)
 	error(_("your local changes would be overwritten by %s."),
 		_(action_name(opts)));
 
-	if (advice_enabled(ADVICE_COMMIT_BEFORE_MERGE))
-		advise(_("commit your changes or stash them to proceed."));
+	advice_if_enabled(ADVICE_COMMIT_BEFORE_MERGE,
+			  _("commit your changes or stash them to proceed."));
 	return -1;
 }
 
@@ -3497,9 +3497,8 @@ static int create_seq_dir(struct repository *r)
 	}
 	if (in_progress_error) {
 		error("%s", in_progress_error);
-		if (advice_enabled(ADVICE_SEQUENCER_IN_USE))
-			advise(in_progress_advice,
-				advise_skip ? "--skip | " : "");
+		advice_if_enabled(ADVICE_SEQUENCER_IN_USE, in_progress_advice,
+				  advise_skip ? "--skip | " : "");
 		return -1;
 	}
 	if (mkdir(git_path_seq_dir(), 0777) < 0)
diff --git a/tools/coccinelle/advice.cocci b/tools/coccinelle/advice.cocci
new file mode 100644
index 0000000000..da4851c5d0
--- /dev/null
+++ b/tools/coccinelle/advice.cocci
@@ -0,0 +1,7 @@
+@@
+expression A;
+expression list args;
+@@
+-if (advice_enabled(A))
+-	advise(args);
++advice_if_enabled(A, args);
-- 
2.55.0-967-gab67bff200

