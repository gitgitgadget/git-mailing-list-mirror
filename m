Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA671C697
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710623797; cv=none; b=hHqFCbFywpKCl7cwVCg3oaXuBi+u5vB4hgBF0gE3Lxm9y7Ui3EySJlz9a1m9PIIHNyUCP4T20HA+abJlSarOZVyv1FiIQ4Mbguiz/sapIMCVPXT8gUYrzuOBe46R7lMSSzsMHqOjBEDRevRsr6IpUcc0502/URSFc1qqkf0lVbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710623797; c=relaxed/simple;
	bh=GXJtKDc6731gr6hQU1dscO3DE6csWv1oroosGcDXgn8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JF9rV5HrG7YU2OaJEF4b5AG4KnuHF3Wg/AFzENP/Abm0W2mWZIjfiT9FKUYIBWBNEUIJKFGjC1LP069wSWrQFP4j5wizQDihVe4u/dWHB2JpaSZ7rV3ww0ACUFK8xEMMi4W4Gt/EvsX8pM8AsMGeSklcm/Ww9NSkDuHskrq22Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWwP2411; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWwP2411"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ecb04e018so1404215f8f.1
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 14:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710623793; x=1711228593; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hC1fzjWd8UKB6sbDKF4PEX5P+lg8ONQ8fk/2FeSBhOI=;
        b=AWwP2411sx3Uihbz5DHR9lWQ3kF8PTYYP3r9k9lEg5HboCfyUV22GVuFOGrtdlVtZo
         Uu22anTeCf3tl8m7M08HjWeafURhZ7gwOudgX+tHSDLnuf86sFJhq9H4L7bPTy8gAiT8
         f9D57xqsoGMkx/AmxNmK33u0wH/ZAwP9Z3K8NnNMDfJP5O27/wYTECAUtCSX7HL45F+O
         7PKcYWLVjVUJYEYVMNyN3E9jJaVX1B+0DGtpxhe8KAjfSPgxPvdQE+xh13DWq6ZHhWsQ
         U7ioTZXwlYIO/aLVmX/Pt2cOsnoxklVCutVA7jyuzfzmAL+O9qOjL1vXAFaEw/uQmg2d
         f1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710623793; x=1711228593;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hC1fzjWd8UKB6sbDKF4PEX5P+lg8ONQ8fk/2FeSBhOI=;
        b=WJTD/tTQQ/r/CQ3BCdRHFvWMtVA5hS3NJl/5CPWrh69UlPWzQSkwBeuP5Of9S+9NMT
         01t49POJ//m3ygfA4+itu2XQm5dhqAXl4Mql7HMWpF/f8RisOOdUA0kph+ujvOQXQEcD
         i+tnRkvn6dEC3tf//vBYWetq45pNUhEHwExfxC8tO60l5KXmB7Af7WPA7aBXPsfPqHVn
         b9DKg3q8TM2H6lsiPrQyCH6mkSango7gLrkriS4pO8H8m+y0j+me4+eHYEVyfs2OdL3/
         8ovsyG+u7LmBz8CXKMOoM8eU95p2pba0MdYJQ7sS2CFpn4vBsPoLs8DkDpbGZoYZzSUd
         Wuuw==
X-Gm-Message-State: AOJu0YxyPnY1AEtPWhA6D/GMfV7H+NCfMX4benzbH1yHiq2oPJ1e9h5h
	G5pHQ1BcInzYeztPLdvfxpshpVGsvURj/dQpbUc0vO5on9F5pjz/xPihGB6p
X-Google-Smtp-Source: AGHT+IHcUnza5y8rgRKNCO8DtgPlYm/qrd2ttuYEdZbyrJlFh6f4MfT8Zt4sLiy8uIJ7du49xRqXQQ==
X-Received: by 2002:adf:db44:0:b0:33e:9311:5fda with SMTP id f4-20020adfdb44000000b0033e93115fdamr4672379wrj.29.1710623792550;
        Sat, 16 Mar 2024 14:16:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d44c5000000b0033b87c2725csm6112225wrr.104.2024.03.16.14.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 14:16:31 -0700 (PDT)
Message-ID: <pull.1682.v3.git.1710623790.gitgitgadget@gmail.com>
In-Reply-To: <pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
References: <pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 Mar 2024 21:16:28 +0000
Subject: [PATCH v3 0/2] Allow disabling advice shown after merge conflicts
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    ZheNing Hu <adlternative@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    =?UTF-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

This series introduces a new config 'advice.mergeConflict' and uses it to
allow disabling the advice shown when 'git rebase', 'git cherry-pick', 'git
revert', 'git rebase --apply' and 'git am' stop because of conflicts.

Thanks everyone for the reviews!

Changes since v2:

 * expanded the commit messages to explain why the tests for 'git rebase' do
   not need to be adjusted
 * adjusted the wording of the new 'advice.mergeConflict' in the doc, as
   suggested by Kristoffer for uniformity with his series which is already
   merged to 'master' (b09a8839a4 (Merge branch
   'kh/branch-ref-syntax-advice', 2024-03-15)).
 * checked all new output manually and consequently adjusted the code in 1/2
   to avoid a lonely 'hint: ' line.
 * adjusted the addition in advice.h in 1/2 to put the new enum
   alphabetically, as noticed by Rubén.
 * added misssing newlines in 2/2 as noticed by Phillip and tweaked by
   Junio.
 * rebased on master (2953d95d40 (The eighth batch, 2024-03-15)), to avoid
   conflicts in 'Documentation/config/advice.txt' due to Kristoffer's merged
   series

Changes since v1:

 * renamed the new advice to 'advice.mergeConflict' to make it non-sequencer
   specific
 * added 2/2 which uses the advice in builtin/am, which covers 'git rebase
   --apply' and 'git am'

Note that the code path where 'git rebase --apply' stops because of
conflicts is not covered by the tests but I tested it manually using this
diff:

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 47534f1062..34eac2e6f4 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -374,7 +374,7 @@ test_pull_autostash_fail ()
     echo conflicting >>seq.txt &&
     test_tick &&
     git commit -m "Create conflict" seq.txt &&
-	test_must_fail git pull --rebase . seq 2>err >out &&
+	test_must_fail git -c rebase.backend=apply pull --rebase . seq 2>err >out &&
     test_grep "Resolve all conflicts manually" err
 '


Philippe Blain (2):
  sequencer: allow disabling conflict advice
  builtin/am: allow disabling conflict advice

 Documentation/config/advice.txt |  2 ++
 advice.c                        |  1 +
 advice.h                        |  1 +
 builtin/am.c                    | 14 +++++++++-----
 sequencer.c                     | 33 ++++++++++++++++++---------------
 t/t3501-revert-cherry-pick.sh   |  1 +
 t/t3507-cherry-pick-conflict.sh |  2 ++
 t/t4150-am.sh                   |  8 ++++----
 t/t4254-am-corrupt.sh           |  2 +-
 9 files changed, 39 insertions(+), 25 deletions(-)


base-commit: 2953d95d402b6bff1a59c4712f4d46f1b9ea137f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1682%2Fphil-blain%2Fsequencer-conflict-advice-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1682/phil-blain/sequencer-conflict-advice-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1682

Range-diff vs v2:

 1:  a2ce6fd24c2 ! 1:  6005c1e9890 sequencer: allow disabling conflict advice
     @@ Commit message
          merge conflict through a new config 'advice.mergeConflict', which is
          named generically such that it can be used by other commands eventually.
      
     +    Remove that final '\n' in the first hunk in sequencer.c to avoid an
     +    otherwise empty 'hint: ' line before the line 'hint: Disable this
     +    message with "git config advice.mergeConflict false"' which is
     +    automatically added by 'advise_if_enabled'.
     +
          Note that we use 'advise_if_enabled' for each message in the second hunk
          in sequencer.c, instead of using 'if (show_hints &&
          advice_enabled(...)', because the former instructs the user how to
     @@ Commit message
      
          Update the tests accordingly. Note that the body of the second test in
          t3507-cherry-pick-conflict.sh is enclosed in double quotes, so we must
     -    escape them in the added line.
     +    escape them in the added line. Note that t5520-pull.sh, which checks
     +    that we display the advice for 'git rebase' (via 'git pull --rebase')
     +    does not have to be updated because it only greps for a specific line in
     +    the advice message.
      
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## Documentation/config/advice.txt ##
      @@ Documentation/config/advice.txt: advice.*::
     - 		Advice on how to set your identity configuration when
     - 		your information is guessed from the system username and
     - 		domain name.
     + 		Shown when the user's information is guessed from the
     + 		system username and domain name, to tell the user how to
     + 		set their identity configuration.
      +	mergeConflict::
     -+		Advice shown when various commands stop because of conflicts.
     ++		Shown when various commands stop because of conflicts.
       	nestedTag::
     - 		Advice shown if a user attempts to recursively tag a tag object.
     + 		Shown when a user attempts to recursively tag a tag object.
       	pushAlreadyExists::
      
       ## advice.c ##
     @@ advice.c: static struct {
      
       ## advice.h ##
      @@ advice.h: enum advice_type {
     + 	ADVICE_GRAFT_FILE_DEPRECATED,
       	ADVICE_IGNORED_HOOK,
       	ADVICE_IMPLICIT_IDENTITY,
     - 	ADVICE_NESTED_TAG,
      +	ADVICE_MERGE_CONFLICT,
     + 	ADVICE_NESTED_TAG,
       	ADVICE_OBJECT_NAME_WARNING,
       	ADVICE_PUSH_ALREADY_EXISTS,
     - 	ADVICE_PUSH_FETCH_FIRST,
      
       ## sequencer.c ##
      @@ sequencer.c: static void print_advice(struct repository *r, int show_hint,
     @@ sequencer.c: static void print_advice(struct repository *r, int show_hint,
       
       	if (msg) {
      -		advise("%s\n", msg);
     -+		advise_if_enabled(ADVICE_MERGE_CONFLICT, "%s\n", msg);
     ++		advise_if_enabled(ADVICE_MERGE_CONFLICT, "%s", msg);
       		/*
       		 * A conflict has occurred but the porcelain
       		 * (typically rebase --interactive) wants to take care
 2:  3235542cc6f ! 2:  73d07c8b6a7 builtin/am: allow disabling conflict advice
     @@ Commit message
          on stderr instead of stdout. In t4150, redirect stdout to 'out' and
          stderr to 'err', since this is less confusing. In t4254, as we are
          testing a specific failure mode of 'git am', simply disable the advice.
     +    Note that we are not testing that this advice is shown in 'git rebase'
     +    for the apply backend since 2ac0d6273f (rebase: change the default
     +    backend from "am" to "merge", 2020-02-15).
      
     +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## builtin/am.c ##
     @@ builtin/am.c: static const char *msgnum(const struct am_state *state)
       
      -		printf_ln(_("When you have resolved this problem, run \"%s --continue\"."), cmdline);
      -		printf_ln(_("If you prefer to skip this patch, run \"%s --skip\" instead."), cmdline);
     -+		strbuf_addf(&sb, _("When you have resolved this problem, run \"%s --continue\"."), cmdline);
     -+		strbuf_addf(&sb, _("If you prefer to skip this patch, run \"%s --skip\" instead."), cmdline);
     ++		strbuf_addf(&sb, _("When you have resolved this problem, run \"%s --continue\".\n"), cmdline);
     ++		strbuf_addf(&sb, _("If you prefer to skip this patch, run \"%s --skip\" instead.\n"), cmdline);
       
       		if (advice_enabled(ADVICE_AM_WORK_DIR) &&
       		    is_empty_or_missing_file(am_path(state, "patch")) &&
       		    !repo_index_has_changes(the_repository, NULL, NULL))
      -			printf_ln(_("To record the empty patch as an empty commit, run \"%s --allow-empty\"."), cmdline);
     -+			strbuf_addf(&sb, _("To record the empty patch as an empty commit, run \"%s --allow-empty\"."), cmdline);
     ++			strbuf_addf(&sb, _("To record the empty patch as an empty commit, run \"%s --allow-empty\".\n"), cmdline);
       
      -		printf_ln(_("To restore the original branch and stop patching, run \"%s --abort\"."), cmdline);
      +		strbuf_addf(&sb, _("To restore the original branch and stop patching, run \"%s --abort\"."), cmdline);

-- 
gitgitgadget
