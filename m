Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE2837268B
	for <git@vger.kernel.org>; Wed,  6 May 2026 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778107411; cv=none; b=lDCaW4qx1VHS8mPjZe34HeIdsZo4hTNw2RnpySvEHVz6Jx8PDRl1vZKNszo68ZobTeYcwnCo9ZImy9jIl2pyY9Ui3OfuUgs55zRUME38czK4LjqNMdVNpA/U29nJHlDAYFwPdaD/AwbC512qwzRUZ6qBRzOD+kF0KdevUj2VJvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778107411; c=relaxed/simple;
	bh=1qTYoBt7ar2JYqHycFcZ2KNKH/JVKiido6cL59tpGGc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=PzDfMPBcGTY/2v7UCDo0+iKVMgv95wd3Rb6n/Ht4lGqqwz/38pRLgHhF+6VPbXuB/yvYQjajqFDf97eEm/KIj7MYH6i61JnsreOZIg65iUq8q5X6aXbLZDsJLaRjiR+Mat9fwFo4qCwCn+BCEsQEvAfFrKsOYI1f9H7fLrVqZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDZ9haSm; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDZ9haSm"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so510137eec.1
        for <git@vger.kernel.org>; Wed, 06 May 2026 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778107406; x=1778712206; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3AtBnLONG9NspwWZ+4FqCG6oB9tYAZxqEqn3yw7aMJ0=;
        b=ZDZ9haSmHmg5zeUk9ps8uv4uxq/B+/Uw2r1oa1JDZrjnK/W0v/MnSSZuxRrJPO6n89
         PKYmqymlWoi0t+RB3Xg7TcJHTEXztfUvTSM7fqQs7OXCa04fLIAqx9mp+qR6bInr2xEZ
         zH7MtuW/MWBXAlu4936urbJQrGPEhZH8oBBeNBtFq+teCYlCaF+z6jXMK0uRGLed+qq5
         UaQzBwjBW+uQIh3KsvV9hatBiOdTh5hwAOiz0/DEVURuE8zTtmAQz2Diuhxx6Ml0fhrU
         nsqjaluUkLHI2x9judLY5U6rSMA7oPMPuXezV2NWEb96LLfRbjs0xym+VjzNAQBwdOZk
         EZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778107406; x=1778712206;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AtBnLONG9NspwWZ+4FqCG6oB9tYAZxqEqn3yw7aMJ0=;
        b=auO1u+RenenxfNvJ96b88lpNLhXsp01EgJqCS/Bmujsj2u6x8McXKpCc6uQrvgH17I
         GNZCb1QxtH3oiWjulpv7VKdYY+JcBX0UH/83KMhpXcv36RZiK5Z5RlyQzLNbOCW2zxIQ
         oLP0ohiAG6yczG3skBP++7Tx3n+i1qova9SjqkzVXKrdTYjqGFyd2DbRnqjSbjQOWYbH
         2jbkr2meNywoO/rD8//slzgjAXXC6bNDq+arMEIpgqrZFmvvyyJadYZiDcgE7/JQZ+9Z
         o2TjsMcHXuq0yVxHGQUA12Ra4ZgY7WgnqomRPOjpYma1T8LYcbVLjXMBG2l4q/iylH5O
         3UnQ==
X-Gm-Message-State: AOJu0YzlsRa1mBbi4q1ovLdRJ/hliiQInDjw2km8qZ7xQefrO5w+50B9
	ovsk3alKral9rQuAjyp/AKyAB85AiIBRRaW587Yv3OWDg7RK8xqTcGQ/VjoOXQ==
X-Gm-Gg: AeBDietGbOQQLRsDwRxxA6oHQjuQMlmewwLJBCXh8pvEhezrvHX6FhuBto6xbParTIX
	AG6c467DvYiz6Xp0rn3LxA5PYVLdvRtL+JCFqOIRT8gSj72m5QbFss91uvJg/okSNW6xtJoiR0i
	d1NtOJjPB+4pUwb+OvYm46nZSCE1C/3w9ukMOAiJuIheUnJqkdiUtv7g0z7K54RPKqkr/mMngTt
	hoKugOml9Bl/ijf+2raVIgSXjzymc55YVe+RJ1y3uZ7ZY6Xqalp9wx7R7o18ZfU3N4Qu6ksST3T
	5ICOJsouHwpGG9n6jdasWlG4Jq10TVp1iW/wv030Arv0kkvVh7CHvCoMGZ4o7ksdbHU1kukv6gb
	NBC7XQsxy2UsjYmieIShQMvQI5t6GslrveRdk/pI6Jmf0Nr6KX5B/hQ6Oyi7M9uCJYJvDG4/vRp
	8srdhzivf7pzzvjC0xs2H0XheLby+n9+So7fdHNA==
X-Received: by 2002:a05:7300:a987:b0:2dd:c066:bf7 with SMTP id 5a478bee46e88-2f54b360d4emr2650938eec.11.1778107406462;
        Wed, 06 May 2026 15:43:26 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.225.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56cec592asm5999436eec.5.2026.05.06.15.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 15:43:25 -0700 (PDT)
Message-Id: <pull.2106.git.1778107405.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 06 May 2026 22:43:19 +0000
Subject: [PATCH/RFC 0/5] replay: support replaying 2-parent merges
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
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

git history, the new history-rewriting builtin in v2.54, dies on any merge
in the rewrite path with replaying merge commits is not supported yet!. That
makes it not very useful for the workflows I actually have, where almost
every interesting branch contains at least one merge of a feature topic. The
natural fallback, git rebase --rebase-merges, is interactive and stops to
ask for re-resolution even when no re-resolution is needed.

This series lifts that limitation for the common 2-parent case. The
algorithm itself is not new: Elijah Newren wrote it down in his replay
design notes
[https://github.com/newren/git/blob/replay/replay-design-notes.txt] and
prototyped it in a 2022 work-in-progress sketch
[https://github.com/newren/git/commit/4c45e8955ef9bf7d01fd15d9106b3bdb8ea91b45].
What is new is wiring it into the replay_revisions() API that backs both git
replay and git history, plus three specific tweaks that make the trickier
cases work where the WIP sketch bailed out: identical conflict-marker labels
for the inner remerges of the original and the rewritten parents (so their
conflict-markered trees compare equal in the regions the user did not
touch), tolerating result.clean == 0 from those inner merges (their
well-defined conflict-markered trees are valid inputs to the outer 3-way
merge), and self-fallback for both merge parents combined with mapping the
rev-range boundary commits to the onto commit.

Octopus merges and revert-of-merge are surfaced as explicit errors at the
dispatch point. The split sub-command of git history continues to refuse
when its target is a merge: split semantics simply do not apply there. The
xdiff special mode for matching conflict-marker hunks across inner remerges,
the XDL_MERGE_FAVOR_BASE variant, and the modify/delete and binary-file
specials that the design notes flag as future work all remain future work.

While I was at it, git history reword had a pre-existing silent-success bug:
a positive return from replay_revisions() (which means "conflict, no updates
queued") was treated as success. Obviously this should never occur, as a
reword simply does not change any of the file contents, but bugs do happen.
The merge-replay work is complex enough to make that class of bugs more
likely, therefore I introduce error messages for those instances.

Johannes Schindelin (5):
  replay: support replaying 2-parent merges
  replay: short-circuit merge replay when parent and base trees are
    unchanged
  history.adoc: describe merge-replay support and its limits
  test-tool: add a "historian" subcommand for building merge fixtures
  t3454: cover merge-replay scenarios with the historian helper

 Documentation/git-history.adoc |  27 ++-
 Makefile                       |   1 +
 builtin/history.c              |  16 +-
 replay.c                       | 258 +++++++++++++++++++++++++--
 t/helper/meson.build           |   1 +
 t/helper/test-historian.c      | 189 ++++++++++++++++++++
 t/helper/test-tool.c           |   1 +
 t/helper/test-tool.h           |   1 +
 t/meson.build                  |   1 +
 t/t3451-history-reword.sh      |  21 ++-
 t/t3452-history-split.sh       |   6 +-
 t/t3454-history-merges.sh      | 308 +++++++++++++++++++++++++++++++++
 t/t3650-replay-basics.sh       |  46 ++++-
 13 files changed, 840 insertions(+), 36 deletions(-)
 create mode 100644 t/helper/test-historian.c
 create mode 100755 t/t3454-history-merges.sh


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2106%2Fdscho%2Fsupport-merge-commits-in-git-history-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2106/dscho/support-merge-commits-in-git-history-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2106
-- 
gitgitgadget
