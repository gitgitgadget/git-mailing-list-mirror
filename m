Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE28B2063DD
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358291; cv=none; b=USHX44cujx6pZt9oTWQN6JAX+mTEr7BQR0gGxABTl3U/z4I0okz8WGi1F/ZMC69N2q8n2PK1nSuRzJkfKRcs3LkLJX7LqwtoGQuqffuTU6AUSsXRkQEV3HDU53mAav7o1BcIPDwMn1XCwT0mkYzGOZRVS2v3KODzaaRqOE/oHdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358291; c=relaxed/simple;
	bh=RuUuGZm6MsrXKxsC6bzIbQVSVcYO2CawSZwYAg4b+30=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MC/gAK8JqKTEOl2m1W1yXFCCM7xUi+2t4IS8nnZg1giTGiNXkYix5PR1pn1W3SasOSjSH6WArJOwlxyeEHU/h6co2K0Tr9YiPYFc2RIWBgLPp00iv9SttekGsdgvwBXN+IepefDZ1qBjv0zJj/QOa1ZByMOvMD8hjTCfhUI4T/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIeX/RRz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIeX/RRz"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43626213fffso23861375e9.1
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 06:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734358285; x=1734963085; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0p6+jmLOTX+bTgXDwTraidpgD0ermADb4dARWkSrZLc=;
        b=DIeX/RRzZn7viCLfajOs0QcDlzgH7GsziiECVFMHYXk2vfmyo40fRpZEyiwRF+ge9X
         iwcidkbJIzUbUyWvDEcVGJOoTKqPy9iQw4Gu7ZSrDjGM5Uzi0IPYeH2tGdqEClqBRZqg
         1LYm8ZyRIlNtyfL3eZ5TLl2vESYZ+QDHVICD+s42jcu3Ckv55EfcpjFYYBc1jiCGvuhF
         6y62VpJ1BN4RxDdpZGkhT12KT01TFrdbCLZA8+Pe4Xfn9x/uw+0jUTKlPcPU1jngITza
         USf32yHKrgNGgFlWgrd6Djm/MQYwm3JKaIxUNiVWfELes4lsCT304aw47PWEU3faB2ur
         jk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734358285; x=1734963085;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0p6+jmLOTX+bTgXDwTraidpgD0ermADb4dARWkSrZLc=;
        b=xTBBCBqGjhiRuta6uiEhZErSig2rUUq4a85D2sSzCcV7wxqw89iznBKZJHLWvN6ujJ
         oa9xvU8CfwGTBh+qT4Wk17ibTkDxtngCYgFsJAgbyCGPRc7wv8BC42zEbYc8gnNQFFMc
         XuEf96yTSzjExIodWQNlvx1KkjxeuKxzs+6qPR3cUCccWz5IXjf5tobiVVP0m8kSORt2
         IVbeaFi1sJF6J/gv54K4/O/KSwrMuFrJot1VHqoPxjGQ7T+gb2xF9Jzcsyo1uS0ffd/R
         0YlB7qfreUyOo7zKY7vf94jmxFWvH2gxLeSFQaCBCTg0NYHsaKNI7Kj+1wyIk+eZHIP2
         h3xQ==
X-Gm-Message-State: AOJu0YxMAr6rVTTT+5ioZnb65ICbtBaH+e6JzYJfQBKUusPyiCminCCt
	zMpV4db+ozD6dThFD3kXMSYme3nqp7s5O82IlB3nb1tQHycAESC+6SETeg==
X-Gm-Gg: ASbGncvajImXMCs5FP8ocZJKPZCgXpDjyOcZjzU+xFwp2GMCFXvZl4c+MpftCDcrvd4
	ceM5nHJXvUEHmhrml+CYW97VKPrszacrLLvpoFVmMwl1FJ+vXanghTZnLz48Xws280HUk9prqk2
	DiqaIepZFtD7t7/EqpBHonYu/XS96bQyrJ3A2nM8K/Zs2qKjHWYe5kRyr5G4cT/u3XCMrmtIMJA
	C9Ba62Ry6+gH/DQI9b8IB2jvPM8hS5as+HLXH+FDC0PNstvTNVtfRTVmg==
X-Google-Smtp-Source: AGHT+IFQT4Qhp5pLFz5a8A+AxEbOFzf7ol1NYbW+CyyHLPNHDUUm3AJwotK2/nwQLNOoNNRPv2LpPA==
X-Received: by 2002:a05:600c:1551:b0:435:1a2:262a with SMTP id 5b1f17b1804b1-4362b10271amr107663165e9.3.1734358285062;
        Mon, 16 Dec 2024 06:11:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8046e6dsm8410200f8f.84.2024.12.16.06.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:11:23 -0800 (PST)
Message-Id: <pull.1734.v3.git.1734358282.gitgitgadget@gmail.com>
In-Reply-To: <pull.1734.v2.git.1731073383564.gitgitgadget@gmail.com>
References: <pull.1734.v2.git.1731073383564.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 16 Dec 2024 14:11:20 +0000
Subject: [PATCH v3 0/2] Support diff merges option in range diff
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
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Elijah Newren <newren@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

The git range-diff command does the same with merge commits as git rebase:
It ignores them.

However, when comparing branch thickets it can be quite illuminating to
watch out for inadvertent changes in merge commits, in particular when some
"evil" merges have been replayed, i.e. merges that needed to introduce
changes outside of the merge conflicts (e.g. when one branch changed a
function's signature and another branch introduced a caller of said
function), in case the replayed merge is no longer "evil" and therefore
potentially incorrect.

Let's introduce support for the --diff-merges option that is passed through
to those git log commands.

I had a need for this earlier this year and got it working, leaving the
GitGitGadget PR in a draft mode. Phil Blain found it and kindly nerd-sniped
me into readying it for submitting, so say thanks to Phil!

Changes since v2:

 * Rebased onto js/log-remerge-keep-ancestry, to fix --diff-merges=remerge
 * Now the documentation suggests remerge instead of first-parent mode
 * Added a follow-up commit to introduce the convenience option git
   range-diff --remerge-diff

Changes since v1:

 * Changed the documentation to recommend first-parent mode instead of
   vaguely talking about various modes' merits.
 * Disallowed the no-arg --diff-merges option (because --diff-merges
   requires an argument).

Johannes Schindelin (2):
  range-diff: optionally include merge commits' diffs in the analysis
  range-diff: introduce the convenience option `--remerge-diff`

 Documentation/git-range-diff.txt | 17 ++++++++++++++++-
 builtin/range-diff.c             | 12 ++++++++++++
 range-diff.c                     | 17 ++++++++++++-----
 range-diff.h                     |  1 +
 t/t3206-range-diff.sh            | 16 ++++++++++++++++
 5 files changed, 57 insertions(+), 6 deletions(-)


base-commit: f94bfa151623d7e675db9465ae7ff0b33e4825f3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1734%2Fdscho%2Fsupport-diff-merges-option-in-range-diff-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1734/dscho/support-diff-merges-option-in-range-diff-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1734

Range-diff vs v2:

 1:  d01a395900b ! 1:  ef3c243da1b range-diff: optionally include merge commits' diffs in the analysis
     @@ Commit message
          merges, via the `--diff-merges=<format>` option.
      
          Let's add corresponding support for `git range-diff`, too. This makes it
     -    more convenient to spot differences between iterations of non-linear
     -    contributions, where so-called "evil merges" are sometimes necessary and
     -    need to be reviewed, too.
     +    more convenient to spot differences between commit ranges that contain
     +    merges.
      
     -    In my code reviews, I found the `--diff-merges=first-parent` option
     +    This is especially true in scenarios with non-trivial merges, i.e.
     +    merges introducing changes other than, or in addition to, what merge ORT
     +    would have produced. Merging a topic branch that changes a function
     +    signature into a branch that added a caller of that function, for
     +    example, would require the merge commit itself to adjust that caller to
     +    the modified signature.
     +
     +    In my code reviews, I found the `--diff-merges=remerge` option
          particularly useful.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     @@ Documentation/git-range-diff.txt: to revert to color all lines according to the
      +	corresponding `--diff-merges=<format>` option of linkgit:git-log[1],
      +	and include them in the comparison.
      ++
     -+Note: In the common case, the `first-parent` mode will be the most natural one
     -+to use, as it is consistent with the idea that a merge is kind of a "meta
     -+patch", comprising all the merged commits' patches into a single one.
     ++Note: In the common case, the `remerge` mode will be the most natural one
     ++to use, as it shows only the diff on top of what Git's merge machinery would
     ++have produced. In other words, if a merge commit is the result of a
     ++non-conflicting `git merge`, the `remerge` mode will represent it with an empty
     ++diff.
      +
       --[no-]notes[=<ref>]::
       	This flag is passed to the `git log` program
       	(see linkgit:git-log[1]) that generates the patches.
      
       ## builtin/range-diff.c ##
     -@@ builtin/range-diff.c: int cmd_range_diff(int argc,
     +@@ builtin/range-diff.c: int cmd_range_diff(int argc, const char **argv, const char *prefix)
       {
       	struct diff_options diffopt = { NULL };
       	struct strvec other_arg = STRVEC_INIT;
     @@ builtin/range-diff.c: int cmd_range_diff(int argc,
       	struct range_diff_options range_diff_opts = {
       		.creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT,
       		.diffopt = &diffopt,
     -@@ builtin/range-diff.c: int cmd_range_diff(int argc,
     +@@ builtin/range-diff.c: int cmd_range_diff(int argc, const char **argv, const char *prefix)
       		OPT_PASSTHRU_ARGV(0, "notes", &other_arg,
       				  N_("notes"), N_("passed to 'git log'"),
       				  PARSE_OPT_OPTARG),
     @@ builtin/range-diff.c: int cmd_range_diff(int argc,
       		OPT_BOOL(0, "left-only", &left_only,
       			 N_("only emit output related to the first range")),
       		OPT_BOOL(0, "right-only", &right_only,
     -@@ builtin/range-diff.c: int cmd_range_diff(int argc,
     +@@ builtin/range-diff.c: int cmd_range_diff(int argc, const char **argv, const char *prefix)
       	if (!simple_color)
       		diffopt.use_color = 1;
       
     @@ builtin/range-diff.c: int cmd_range_diff(int argc,
       	for (i = 0; i < argc; i++)
       		if (!strcmp(argv[i], "--")) {
       			dash_dash = i;
     -@@ builtin/range-diff.c: int cmd_range_diff(int argc,
     +@@ builtin/range-diff.c: int cmd_range_diff(int argc, const char **argv, const char *prefix)
       	res = show_range_diff(range1.buf, range2.buf, &range_diff_opts);
       
       	strvec_clear(&other_arg);
     @@ range-diff.c: static int read_patches(const char *range, struct string_list *lis
       		     /*
      @@ range-diff.c: static int read_patches(const char *range, struct string_list *list,
       		     "--pretty=medium",
     - 		     "--show-notes-by-default",
     + 		     "--notes",
       		     NULL);
      +	if (!include_merges)
      +		strvec_push(&cp.args, "--no-merges");
     @@ range-diff.c: static int read_patches(const char *range, struct string_list *lis
       				strbuf_reset(&buf);
       			}
       			CALLOC_ARRAY(util, 1);
     +-			if (get_oid(p, &util->oid)) {
      +			if (include_merges && (q = strstr(p, " (from ")))
      +				*q = '\0';
     - 			if (repo_get_oid(the_repository, p, &util->oid)) {
     ++			if (repo_get_oid(the_repository, p, &util->oid)) {
       				error(_("could not parse commit '%s'"), p);
       				FREE_AND_NULL(util);
     + 				string_list_clear(list, 1);
      @@ range-diff.c: int show_range_diff(const char *range1, const char *range2,
       
       	struct string_list branch1 = STRING_LIST_INIT_DUP;
 -:  ----------- > 2:  f99416acd5a range-diff: introduce the convenience option `--remerge-diff`

-- 
gitgitgadget
