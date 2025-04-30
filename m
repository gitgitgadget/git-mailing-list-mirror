Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651CC1B5EB5
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008719; cv=none; b=afoSsLL+lKmi1oKJjdT9kFaa1XymVwyOzNHyz/QCTcI/Oq3tahcm1GLF12/TBrGS2iDhC3KbpnDuQFy4y5h/zm4HM19fO8Wb4MXTXtjONYSiIVYCTVegAgUhjBhkXLHT+OunBj/hBnQmQH9FvV4OGwL244vlB2M4R58TISzfexY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008719; c=relaxed/simple;
	bh=OnBS4Uey5YM0g7cdSbzmlKHGOkJIwulQF4AAEWvkmA8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=bDaCrjsosmFxxa4g5I6fOmAeJypr6gAMXcWlTn90A7SX56atB1sAiWvqaVDoEsfbXfdjcqQ3o0QQo0oYQfTlPUQgbsn/VG/cKjYJYyprDb6x81E9n0cHyPeKAeTIKGpmQLcUU/3P7kxoH9In8nn8geXh2s/2ykPrSI5eZOntYec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BwpzSmHm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lnlzc9Eg; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BwpzSmHm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lnlzc9Eg"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 69AE625401F2;
	Wed, 30 Apr 2025 06:25:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 30 Apr 2025 06:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746008714;
	 x=1746095114; bh=Gpll+Z4isY+wdRqQzEklYOc+LlBcOW2k5HhAm3zRFYQ=; b=
	BwpzSmHmCEtyZ0Z1TlAJDqjJ8sdmwDVOUWvOEv99mj9WVljJtf6e9Mr2DmYwBkyL
	wuEea00DVst6UQQTU2x0bHfz0hhKGak6uLxJrrntjbvIMjaEUycdjUXdh3jpFH6/
	842QVQbCqBsL6uyBefUKBoTR/+aI6jDSq2wmf7M2fp+fkpocUTkqh/dwkl6Zuixd
	ZpIgDl4fu8udPhdkMl544BRQL0UZDBVPOnpm6gKgCQLhNHIfrLc0z2jzRsgYsxFS
	2uhc1MfWYyol03mupjPoUEaFntEjvez8RLUt9AcRU95bs9QrGqBvlP1OU5PG/RYp
	imoUKvns2Wh+Y7mdQOK3Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746008714; x=
	1746095114; bh=Gpll+Z4isY+wdRqQzEklYOc+LlBcOW2k5HhAm3zRFYQ=; b=L
	nlzc9EgVxkmHWxz7HYKiXSsVmRNy2oohw89d7hIySYH7Z5Q7GtX79h64pPZ2dYbB
	3eFEtVBwy/4NqteAVc3nbapKK0lDkqB6eUx+4O7Ja7oBmp/5ODV86Aaoax0YNb4N
	NYO6E4KafnxBGgTRJTTkSEcXLP072Vcwy2rRPQ2V144J/vk90byP6flbLfzlF4i+
	QrS0pZVJxNrKTY0FMQLjab+z4iqpUL2T1R3+u5cNRW+2bZf//En5eu8z2t8ffYYr
	+9wAfHmnCpAI4GCzYowWE2lyaIeO68dEm3uy4j7mz1FSqj1qR3ao7CyD1djHACnV
	i/zSWhtMmstXl8ek2glUw==
X-ME-Sender: <xms:ifoRaD0xqMsJ41TJqqrkWpDPfUmaaBYTBieq9PvnVnfv4egQ4Zu82g>
    <xme:ifoRaCHhC2UpDChHF6zoAEbGylPdm8TDO9_uINqVm4hEwHCcZd-EpFuGlB0vQG3t1
    RpT-o-syTMET7D8Bg>
X-ME-Received: <xmr:ifoRaD7ZHtIXP42l-r3gjhMP10LWXCjYzIE4jTsx8WKbJn3PE446JJmd4XzdujWjBUZFS0kOXr87lH-3eS1U1LLMc5z3KHdDYsNw-0VqRm8CRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeigeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpefghfffieffudeigfdvfefggffggeefkeeguddu
    uddujefhvdegueffkeeggfeuheenucffohhmrghinhepfihorhhkthhrvggvqdhprhhunh
    gvrdgruhhtohdprhgvrhgvrhgvqdhgtgdrrghuthhopdhkvghrnhgvlhdrohhrghdprhgv
    fhhlohhgqdgvgihpihhrvgdrrghuthhopdhlohhoshgvqdhosghjvggtthhsrdgruhhtoh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ifoRaI2fW3zYhfy4Y3F3GZntFfQwdEFg6js6_8PUZu4dQWBlDCRy8A>
    <xmx:ifoRaGFhm9zXBi49t3Pah04PtxPADKT7RIWcrhPecHJyl-bLUD5kSw>
    <xmx:ifoRaJ84-OsMgjMOa4kZVqFi6AOxjxvB52D0OfGd74DQwrVoebiAaA>
    <xmx:ifoRaDmHwAJUDIsDzs3bDBw_ZkCKhHU6x2UcwyWtnuGB4gKYWCgw0Q>
    <xmx:ivoRaNgSov6BmVD42UXjogL9FbH7vrpiMLPfzllwgWcYD40bSMTKabz9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 06:25:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8f7872fd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Apr 2025 10:25:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/8] builtin/maintenance: implement missing tasks
 compared to git-gc(1)
Date: Wed, 30 Apr 2025 12:25:04 +0200
Message-Id: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAID6EWgC/4WNzQ6CMBCEX4Xs2TWl8iOefA/DobQLbAyFdEmjI
 by7lcSzx29m8s0GQoFJ4JZtECiy8OwT6FMGdjR+IGSXGLTSpSp0gctTcDLsV/LGW8KJRdgPuBp
 JzbXvrXNlU3X1BZJjCdTz6/A/2sQjyzqH93EX82/6M5d/zDFHhU2tyVWm01a5e9qfeYJ23/cPj
 fw1U8cAAAA=
X-Change-ID: 20250424-pks-maintenance-missing-tasks-8ffcdd596b73
In-Reply-To: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
References: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this small patch series implements the last couple of remaining tasks
that are missing compared to the functionality git-gc(1) provides.

Right now, git-maintenance(1) still executes git-gc(1). With these last
gaps plugged though we can in theory fully replace git-gc(1) with finer
grained tasks without losing any functionality. The benefit is that it
becomes possible for users to have finer-grained control over what
exactly the maintenance does.

This patch series doesn't do that yet, but only implements whatever is
needed to get there.

Changes in v2:
  - Introduce "maintenance.worktree-prune.auto", which controls how many
    stale worktrees need to exist before executing `git worktree prune`.
  - Introduce "maintenance.rerere-gc.auto", which controls how many
    stale rerere entries need to exist before executing `git rerere gc`.
  - Add tests to verify that "gc.worktreePruneExpire" works.
  - Remove some fragile test logic by introducing functions that check
    for a given maintenance subprocess.
  - Link to v1: https://lore.kernel.org/r/20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (8):
      builtin/gc: fix indentation of `cmd_gc()` parameters
      builtin/gc: remove global variables where it trivial to do
      builtin/gc: move pruning of worktrees into a separate function
      worktree: expose function to retrieve worktree names
      builtin/maintenance: introduce "worktree-prune" task
      rerere: provide function to collect stale entries
      builtin/gc: move rerere garbage collection into separate function
      builtin/maintenance: introduce "rerere-gc" task

 Documentation/config/maintenance.adoc |  16 ++++
 Documentation/git-maintenance.adoc    |   8 ++
 builtin/gc.c                          | 153 +++++++++++++++++++++++++++-------
 builtin/worktree.c                    |  25 +++---
 rerere.c                              |  92 +++++++++++++-------
 rerere.h                              |  14 ++++
 t/t7900-maintenance.sh                | 125 +++++++++++++++++++++++++++
 worktree.c                            |  30 +++++++
 worktree.h                            |   8 ++
 9 files changed, 399 insertions(+), 72 deletions(-)

Range-diff versus v1:

1:  0304b81df0b = 1:  9c62b493297 builtin/gc: fix indentation of `cmd_gc()` parameters
2:  22c499601ee = 2:  9ae42b139fa builtin/gc: remove global variables where it trivial to do
3:  db9622a408f = 3:  50a5305b6d2 builtin/gc: move pruning of worktrees into a separate function
4:  f42205e1b6b = 4:  b71dcb0debc worktree: expose function to retrieve worktree names
5:  eade37df904 ! 5:  47d31f41c2e builtin/maintenance: introduce "worktree-prune" task
    @@ Commit message
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    + ## Documentation/config/maintenance.adoc ##
    +@@ Documentation/config/maintenance.adoc: maintenance.reflog-expire.auto::
    + 	positive value implies the command should run when the number of
    + 	expired reflog entries in the "HEAD" reflog is at least the value of
    + 	`maintenance.loose-objects.auto`. The default value is 100.
    ++
    ++maintenance.worktree-prune.auto::
    ++	This integer config option controls how often the `worktree-prune` task
    ++	should be run as part of `git maintenance run --auto`. If zero, then
    ++	the `worktree-prune` task will not run with the `--auto` option. A
    ++	negative value will force the task to run every time. Otherwise, a
    ++	positive value implies the command should run when the number of
    ++	prunable worktrees exceeds the value. The default value is 1.
    +
      ## Documentation/git-maintenance.adoc ##
     @@ Documentation/git-maintenance.adoc: reflog-expire::
      	The `reflog-expire` task deletes any entries in the reflog older than the
    @@ builtin/gc.c: static int maintenance_task_worktree_prune(struct maintenance_run_
     +	struct strbuf reason = STRBUF_INIT;
     +	timestamp_t expiry_date;
     +	int should_prune = 0;
    ++	int limit = 1;
    ++
    ++	git_config_get_int("maintenance.worktree-prune.auto", &limit);
    ++	if (limit <= 0) {
    ++		should_prune = limit < 0;
    ++		goto out;
    ++	}
     +
     +	if (parse_expiry_date(cfg->prune_worktrees_expire, &expiry_date) ||
     +	    get_worktree_names(the_repository, &worktrees) < 0)
    @@ builtin/gc.c: static int maintenance_task_worktree_prune(struct maintenance_run_
     +
     +		strbuf_reset(&reason);
     +		if (should_prune_worktree(worktrees.v[i], &reason, &wtpath, expiry_date)) {
    -+			should_prune = 1;
    -+			goto out;
    ++			limit--;
    ++
    ++			if (!limit) {
    ++				should_prune = 1;
    ++				goto out;
    ++			}
     +		}
     +		free(wtpath);
     +	}
    @@ t/t7900-maintenance.sh: test_expect_success 'reflog-expire task --auto only pack
      	test_subcommand git reflog expire --all <reflog-expire-auto.txt
      '
      
    -+test_expect_success 'worktree-prune task' '
    -+	GIT_TRACE2_EVENT="$(pwd)/worktree-prune.txt" \
    -+		git maintenance run --task=worktree-prune &&
    -+	test_subcommand git worktree prune --expire 3.months.ago <worktree-prune.txt
    ++test_expect_worktree_prune () {
    ++	negate=
    ++	if test "$1" = "!"
    ++	then
    ++		negate="!"
    ++		shift
    ++	fi
    ++
    ++	rm -f "worktree-prune.txt" &&
    ++	GIT_TRACE2_EVENT="$(pwd)/worktree-prune.txt" "$@" &&
    ++	test_subcommand $negate git worktree prune --expire 3.months.ago <worktree-prune.txt
    ++}
    ++
    ++test_expect_success 'worktree-prune task without --auto always prunes' '
    ++	test_expect_worktree_prune git maintenance run --task=worktree-prune
     +'
     +
     +test_expect_success 'worktree-prune task --auto only prunes with prunable worktree' '
    -+	GIT_TRACE2_EVENT="$(pwd)/worktree-prune-auto.txt" \
    -+		git maintenance run --auto --task=worktree-prune &&
    -+	test_subcommand ! git worktree prune --expire 3.months.ago <worktree-prune-auto.txt &&
    ++	test_expect_worktree_prune ! git maintenance run --auto --task=worktree-prune &&
     +	mkdir .git/worktrees &&
     +	: >.git/worktrees/abc &&
    -+	GIT_TRACE2_EVENT="$(pwd)/worktree-prune-auto.txt" \
    -+		git maintenance run --auto --task=worktree-prune &&
    -+	test_subcommand git worktree prune --expire 3.months.ago <worktree-prune-auto.txt
    ++	test_expect_worktree_prune git maintenance run --auto --task=worktree-prune
    ++'
    ++
    ++test_expect_success 'worktree-prune task with --auto honors maintenance.worktree-prune.auto' '
    ++	# A negative value should always prune.
    ++	test_expect_worktree_prune git -c maintenance.worktree-prune.auto=-1 maintenance run --auto --task=worktree-prune &&
    ++
    ++	mkdir .git/worktrees &&
    ++	: >.git/worktrees/first &&
    ++	: >.git/worktrees/second &&
    ++	: >.git/worktrees/third &&
    ++
    ++	# Zero should never prune.
    ++	test_expect_worktree_prune ! git -c maintenance.worktree-prune.auto=0 maintenance run --auto --task=worktree-prune &&
    ++	# A positive value should require at least this man prunable worktrees.
    ++	test_expect_worktree_prune ! git -c maintenance.worktree-prune.auto=4 maintenance run --auto --task=worktree-prune &&
    ++	test_expect_worktree_prune git -c maintenance.worktree-prune.auto=3 maintenance run --auto --task=worktree-prune
    ++'
    ++
    ++test_expect_success 'worktree-prune task with --auto honors maintenance.worktree-prune.auto' '
    ++	# A negative value should always prune.
    ++	test_expect_worktree_prune git -c maintenance.worktree-prune.auto=-1 maintenance run --auto --task=worktree-prune &&
    ++
    ++	mkdir .git/worktrees &&
    ++	: >.git/worktrees/first &&
    ++	: >.git/worktrees/second &&
    ++	: >.git/worktrees/third &&
    ++
    ++	# Zero should never prune.
    ++	test_expect_worktree_prune ! git -c maintenance.worktree-prune.auto=0 maintenance run --auto --task=worktree-prune &&
    ++	# A positive value should require at least this many prunable worktrees.
    ++	test_expect_worktree_prune ! git -c maintenance.worktree-prune.auto=4 maintenance run --auto --task=worktree-prune &&
    ++	test_expect_worktree_prune git -c maintenance.worktree-prune.auto=3 maintenance run --auto --task=worktree-prune
    ++'
    ++
    ++test_expect_success 'worktree-prune task honors gc.worktreePruneExpire' '
    ++	git worktree add worktree &&
    ++	rm -rf worktree &&
    ++
    ++	rm -f worktree-prune.txt &&
    ++	GIT_TRACE2_EVENT="$(pwd)/worktree-prune.txt" git -c gc.worktreePruneExpire=1.week.ago maintenance run --auto --task=worktree-prune &&
    ++	test_subcommand ! git worktree prune --expire 1.week.ago <worktree-prune.txt &&
    ++	test_path_is_dir .git/worktrees/worktree &&
    ++
    ++	rm -f worktree-prune.txt &&
    ++	GIT_TRACE2_EVENT="$(pwd)/worktree-prune.txt" git -c gc.worktreePruneExpire=now maintenance run --auto --task=worktree-prune &&
    ++	test_subcommand git worktree prune --expire now <worktree-prune.txt &&
    ++	test_path_is_missing .git/worktrees/worktree
     +'
     +
      test_expect_success '--auto and --schedule incompatible' '
-:  ----------- > 6:  5550c115e84 rerere: provide function to collect stale entries
6:  66b2b033743 = 7:  f5b234c859e builtin/gc: move rerere garbage collection into separate function
7:  9604fc4fc6b ! 8:  092e57cce01 builtin/maintenance: introduce "rerere-gc" task
    @@ Commit message
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    + ## Documentation/config/maintenance.adoc ##
    +@@ Documentation/config/maintenance.adoc: maintenance.reflog-expire.auto::
    + 	expired reflog entries in the "HEAD" reflog is at least the value of
    + 	`maintenance.loose-objects.auto`. The default value is 100.
    + 
    ++maintenance.rerere-gc.auto::
    ++	This integer config option controls how often the `rerere-gc` task
    ++	should be run as part of `git maintenance run --auto`. If zero, then
    ++	the `rerere-gc` task will not run with the `--auto` option. A negative
    ++	value will force the task to run every time. Otherwise, a positive
    ++	value implies the command should run when the number of prunable rerere
    ++	entries exceeds the value. The default value is 20.
    ++
    + maintenance.worktree-prune.auto::
    + 	This integer config option controls how often the `worktree-prune` task
    + 	should be run as part of `git maintenance run --auto`. If zero, then
    +
      ## Documentation/git-maintenance.adoc ##
     @@ Documentation/git-maintenance.adoc: reflog-expire::
      	The `reflog-expire` task deletes any entries in the reflog older than the
    @@ builtin/gc.c
      #include "environment.h"
      #include "hex.h"
      #include "config.h"
    +@@
    + #include "pack-objects.h"
    + #include "path.h"
    + #include "reflog.h"
    ++#include "rerere.h"
    + #include "blob.h"
    + #include "tree.h"
    + #include "promisor-remote.h"
     @@ builtin/gc.c: static int maintenance_task_rerere_gc(struct maintenance_run_opts *opts UNUSED,
      	return run_command(&rerere_cmd);
      }
    @@ builtin/gc.c: static int maintenance_task_rerere_gc(struct maintenance_run_opts
     +static int rerere_gc_condition(struct gc_config *cfg UNUSED)
     +{
     +	struct strbuf path = STRBUF_INIT;
    ++	struct string_list prunable_dirs = STRING_LIST_INIT_DUP;
    ++	struct rerere_id *prunable_entries = NULL;
    ++	size_t prunable_entries_nr;
     +	int should_gc = 0;
    -+	DIR *dir;
    ++	int limit = 20;
    ++
    ++	git_config_get_int("maintenance.rerere-gc.auto", &limit);
    ++	if (limit <= 0) {
    ++		should_gc = limit < 0;
    ++		goto out;
    ++	}
     +
     +	/* Skip garbage collecting the rerere cache in case rerere is disabled. */
     +	repo_git_path_replace(the_repository, &path, "rr-cache");
    ++	if (!is_directory(path.buf))
    ++		goto out;
     +
    -+	dir = opendir(path.buf);
    -+	if (!dir)
    ++	if (rerere_collect_stale_entries(the_repository, &prunable_dirs,
    ++					 &prunable_entries, &prunable_entries_nr) < 0)
     +		goto out;
    -+	should_gc = !!readdir_skip_dot_and_dotdot(dir);
    ++
    ++	should_gc = prunable_entries_nr >= limit;
     +
     +out:
    ++	string_list_clear(&prunable_dirs, 0);
    ++	free(prunable_entries);
     +	strbuf_release(&path);
    -+	closedir(dir);
     +	return should_gc;
     +}
     +
    @@ builtin/gc.c: static struct maintenance_task tasks[] = {
      static int compare_tasks_by_selection(const void *a_, const void *b_)
     
      ## t/t7900-maintenance.sh ##
    -@@ t/t7900-maintenance.sh: test_expect_success 'worktree-prune task --auto only prunes with prunable worktr
    - 	test_subcommand git worktree prune --expire 3.months.ago <worktree-prune-auto.txt
    +@@ t/t7900-maintenance.sh: test_expect_success 'worktree-prune task honors gc.worktreePruneExpire' '
    + 	test_path_is_missing .git/worktrees/worktree
      '
      
    -+test_expect_success 'rerere-gc task' '
    -+	GIT_TRACE2_EVENT="$(pwd)/rerere-gc.txt" \
    -+		git maintenance run --task=rerere-gc &&
    -+	test_subcommand git rerere gc <rerere-gc.txt
    ++setup_stale_rerere_entry () {
    ++	rr=.git/rr-cache/"$(printf "%0$(test_oid hexsz)d" "$1")" &&
    ++	mkdir -p "$rr" &&
    ++	>"$rr/preimage" &&
    ++	>"$rr/postimage" &&
    ++
    ++	test-tool chmtime ="$((-61 * 86400))" "$rr/preimage" &&
    ++	test-tool chmtime ="$((-61 * 86400))" "$rr/postimage"
    ++}
    ++
    ++test_expect_rerere_gc () {
    ++	negate=
    ++	if test "$1" = "!"
    ++	then
    ++		negate="!"
    ++		shift
    ++	fi
    ++
    ++	rm -f "rerere-gc.txt" &&
    ++	GIT_TRACE2_EVENT="$(pwd)/rerere-gc.txt" "$@" &&
    ++	test_subcommand $negate git rerere gc <rerere-gc.txt
    ++}
    ++
    ++test_expect_success 'rerere-gc task without --auto always collects garbage' '
    ++	test_expect_rerere_gc git maintenance run --task=rerere-gc
     +'
     +
    -+test_expect_success 'rerere-gc task --auto only prunes with existing rr-cache dir' '
    -+	mkdir .git/rr-cache &&
    -+	GIT_TRACE2_EVENT="$(pwd)/rerere-gc-auto.txt" \
    -+		git maintenance run --auto --task=rerere-gc &&
    -+	test_subcommand ! git rerere gc <rerere-gc-auto.txt &&
    -+	: >.git/rr-cache/entry &&
    -+	GIT_TRACE2_EVENT="$(pwd)/rerere-gc-auto.txt" \
    -+		git maintenance run --auto --task=rerere-gc &&
    -+	test_subcommand git rerere gc <rerere-gc-auto.txt
    ++test_expect_success 'rerere-gc task with --auto only prunes with prunable entries' '
    ++	test_expect_rerere_gc ! git maintenance run --auto --task=rerere-gc &&
    ++	for i in $(test_seq 19)
    ++	do
    ++		setup_stale_rerere_entry $i || return 1
    ++	done &&
    ++	test_expect_rerere_gc ! git maintenance run --auto --task=rerere-gc &&
    ++	setup_stale_rerere_entry 20 &&
    ++	test_expect_rerere_gc git maintenance run --auto --task=rerere-gc
    ++'
    ++
    ++test_expect_success 'rerere-gc task with --auto honors maintenance.rerere-gc.auto' '
    ++	# A negative value should always prune.
    ++	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=-1 maintenance run --auto --task=rerere-gc &&
    ++
    ++	for i in $(test_seq 20)
    ++	do
    ++		setup_stale_rerere_entry $i || return 1
    ++	done &&
    ++
    ++	# Zero should never prune.
    ++	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=0 maintenance run --auto --task=rerere-gc &&
    ++	# A positive value should require at least this many stale rerere entries.
    ++	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=21 maintenance run --auto --task=rerere-gc &&
    ++	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=10 maintenance run --auto --task=rerere-gc
     +'
     +
      test_expect_success '--auto and --schedule incompatible' '

---
base-commit: a2955b34f48265d240ab8c7deb0a929ec2d65fd0
change-id: 20250424-pks-maintenance-missing-tasks-8ffcdd596b73

