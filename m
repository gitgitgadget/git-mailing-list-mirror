Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052B33A75BD
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 04:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014204; cv=none; b=ATMNS8BmNdvrR0qh/0xxVkVHxLvS6RmfkEtp5uNXjPDHDCnKDMt+M0NdqwjSh0v9aTq33si0T/5UiYkGqquQf1JYtrSFfvvMJINANRW/68oZHfTo08u1B+yqSayvNu/oJh7nTYLxzOVlmEVk5X5GNuzTVvhku6dVLEdavvVzlJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014204; c=relaxed/simple;
	bh=pWEgQslnc7s5W7AFGT1+fEX/eW0/pWIRzRSA5skujzs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fQbP2dwgsYdgkDohrDRzRQrhZ/mfZKoaIzeQ1fh80Bmj2YOqIc869DC3RsuweUtEOxAIbaxhVz1980l1fa1+M/VIDGGV8uCKTEDQjNwSZHcs6DBMVaZlP35YWN41LSkNbVOGlGJsUocXMJQo/o9J5GTOEaMgxdk47OUO4gSUtVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MWiBi6uR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N7bu0OdQ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MWiBi6uR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N7bu0OdQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B5E91D000BC;
	Thu, 10 Sep 2026 00:23:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 10 Sep 2026 00:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789014200; x=1789100600; bh=q7OL15dxwZ
	aRtb+ZiDlcuwNr6zY3aZFJpQ3/w1LY+7I=; b=MWiBi6uR2NH+G7aRMVCJ9dW/g5
	Lkes54iwElmySm5FbrO1ufkw+X2r7wBUyRGFDKFWdj3W9AVZoU2AimzdceN7Wk/T
	CkOkJ/3BpwphOSfg/nsvXxeIdKq7VbyuBPR8R8pt3pb9FVKLcWXnV1oykw78Tfkg
	En4XfK90VO0FpUfTuSUdT6MDjcrqxE1X9luXDMiLVvywJimLh9WlgsTdJznw7/Sn
	66p7NZkWG68MuAFICPDFbHe5UJ4h7Kh/zSZTZYGoombvuJ9e+FZ3u7xLwrdlfnz3
	VmJbySH3g+YTO4V09HAEKo005vwzplTO3PpRgPqPyhQm+iXNhyG+5UzcyA2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789014200; x=1789100600; bh=q7OL15dxwZaRtb+ZiDlcuwNr6zY3aZFJpQ3
	/w1LY+7I=; b=N7bu0OdQMoTedHKWunnnlEh2DPT2JF2rDG5Co4ToWmTjbwrgptO
	81i/XW3ayzE6qcKD8qdDtclBUwbD5+17d7pyScqTZlJDvXITcjhjs/dEjgzRaSJv
	YXuGetFBukZpatvC9PNQWuMRdww9Klb6OGXr3DVh2A37i2P0Esyqhc1Gw40ghWbY
	uv2mWE1nhWykHudZt54IbrjtD7Bp801Hgtu2DUdcm/FuG//Zx1mKlGtxUvfrm+eN
	2H/ASGFkgQKPFFl37VAJ6Dhgs0Nqqeh9ztM6iz+sOyB2AtBnhz8ieaeeC2gk5+oh
	+To5m8QasROxueW4UAOjV0baHbEF8TPi6Pg==
X-ME-Sender: <xms:uDCiaoklBnZDu7_iPRIUaRJkK8RAA0lAcWnX701XW9Zktc2lIqH26A>
    <xme:uDCiauv3z0lFu849WSPBSTMMDQkWNRUTQvk_P0t1DpVvatZkQvx3G2NHP0hiHmAYd
    SF77Z9xIEG3pC3yKQuq4-y5JYlJ5P1taa2vZLYg6PrO0XV7XIGkW5g>
X-ME-Received: <xmr:uDCiau9DAEDEcCPksHkSC1e9ObN3Ha-FMXr4-AGps4ybvQG0a8Tz6WcbjZ2XG9ARg21WmLeUBAw_0gRCIjWNQYYxh87gTGKb2BXR>
X-ME-Proxy-Cause: dmFkZTEn22xMAdqBWFkrD8m0vs/ecPa9Y0DqgxveeHkmPurtSjvJMiIDsZejwyr965Uc1+
    WjlAGcFNvmu7isj1yud8yoXsfpWR7n6pQmQiYirKBsrpPm/0o4ky04ScPoKvbNTwuFINa1
    LxjUk8EYUszTvPKXs694XmTK5CVVcvfUQBAsVB0uC1nCT64UmAk4f0gp0MwqiS2QNDBr6A
    T+ByhrhqqdzYIZa1GMhRB2Uj7wMASPhoj+55qfeZvyx1C2gtAr/zi2kcHgyQTld2ZsXR6z
    Sm9OenCS7rm0Bzu7OX8ytShKNzngR9F1cGkR4G2PkxidjA/gKGWhJXoJsbl6cWYiGiVahs
    PiJ2IAgSBFtqHgVHeMRYg3Gj7t9kgih6RvdUpGXHMd4EfiwlpY6Rm0XyvmvaygnK0Mvmtd
    WkuqtiFEGsKvPMtryjeMrcO8xABecCVpEvziBr5JpDKqvoYfA49iXq+2pEQfF8uGcflXWv
    TWIB44mrCqL/+kmRlfnbHPiWp/IsVGtQOL+u0/QHhFAXBRAwx8iX8mOyLdUjGo/fon0iBS
    O4JTPmqZHoLljaaDR7mZRsKWva76FdRDAhatWxASyRpsYbG5Q0EHU2X2gGBhjJ+VidAz/t
    pID+2rpdaI6jDjyDUysRqAUgcYanRhcRJfLp+1nx6/vddSwxL0PxJQSaZ5ow
X-ME-Proxy: <xmx:uDCiagPRGuV7Gb_fsuiyvhKq3bk2Un-x6b81n42iC3IbcaFqXOBgsQ>
    <xmx:uDCiakFtDSK_wiO_nXuoS4enACj2iUoRbnfrrfYjuxZw6_hWh2nJ8A>
    <xmx:uDCiamREyKkUJQ1FhivaJ0RIcJ5n7w-_FE_4VOsw9C7NsAo-I_UbsQ>
    <xmx:uDCiaps-IFKInzYlRkhHqawq9uLi1_m0O4NOp63DI6hgCNQjZkGnNw>
    <xmx:uDCianTkvRZk2fCt6KX1wjvedYVo0wl5VUnzKdv8Dyxmi8xNnOiaa7ff>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 00:23:20 -0400 (EDT)
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
Date: Wed, 09 Sep 2026 21:23:19 -0700
Message-ID: <xmqq8q594tvs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
    with too many overly long lines.



 tools/coccinelle/advice.cocci |  7 +++++++
 advice.c                      | 13 ++++---------
 branch.c                      |  6 +++---
 builtin/am.c                  |  4 ++--
 builtin/checkout.c            |  4 ++--
 builtin/submodule--helper.c   |  4 ++--
 sequencer.c                   |  9 ++++-----
 7 files changed, 24 insertions(+), 23 deletions(-)

diff --git c/tools/coccinelle/advice.cocci w/tools/coccinelle/advice.cocci
new file mode 100644
index 0000000000..da4851c5d0
--- /dev/null
+++ w/tools/coccinelle/advice.cocci
@@ -0,0 +1,7 @@
+@@
+expression A;
+expression list args;
+@@
+-if (advice_enabled(A))
+-	advise(args);
++advice_if_enabled(A, args);
diff --git c/advice.c w/advice.c
index 63bf8b0c5f..c60b33ee33 100644
--- c/advice.c
+++ w/advice.c
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
 
diff --git c/branch.c w/branch.c
index 22f4f46b96..a87facd311 100644
--- c/branch.c
+++ w/branch.c
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
 
diff --git c/builtin/am.c w/builtin/am.c
index e9623b8307..6039b69475 100644
--- c/builtin/am.c
+++ w/builtin/am.c
@@ -1910,8 +1910,8 @@ static void am_run(struct am_state *state, int resume)
 			printf_ln(_("Patch failed at %s %.*s"), msgnum(state),
 				linelen(state->msg), state->msg);
 
-			if (advice_enabled(ADVICE_AM_WORK_DIR))
-				advise(_("Use 'git am --show-current-patch=diff' to see the failed patch"));
+			advice_if_enabled(ADVICE_AM_WORK_DIR,
+					  _("Use 'git am --show-current-patch=diff' to see the failed patch"));
 
 			die_user_resolve(state);
 		}
diff --git c/builtin/checkout.c w/builtin/checkout.c
index 2bc21aa49b..34f05d2381 100644
--- c/builtin/checkout.c
+++ w/builtin/checkout.c
@@ -1612,8 +1612,8 @@ static void die_expecting_a_branch(const struct branch_info *branch_info)
 		 */
 		code = die_message(_("a branch is expected, got '%s'"), branch_info->name);
 
-	if (advice_enabled(ADVICE_SUGGEST_DETACHING_HEAD))
-		advise(_("If you want to detach HEAD at the commit, try again with the --detach option."));
+	advice_if_enabled(ADVICE_SUGGEST_DETACHING_HEAD,
+			  _("If you want to detach HEAD at the commit, try again with the --detach option."));
 
 	exit(code);
 }
diff --git c/builtin/submodule--helper.c w/builtin/submodule--helper.c
index e7cd3225fa..5e4989a9aa 100644
--- c/builtin/submodule--helper.c
+++ w/builtin/submodule--helper.c
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
diff --git c/sequencer.c w/sequencer.c
index 65afd100d9..6d8be0c036 100644
--- c/sequencer.c
+++ w/sequencer.c
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
