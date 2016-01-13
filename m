From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 1/3] pull: allow interactive rebase with
 --rebase=interactive
Date: Wed, 13 Jan 2016 07:57:50 +0100 (CET)
Message-ID: <2ebf99214ba600b63a39c58bcb9abb7941a7619d.1452668201.git.johannes.schindelin@gmx.de>
References: <cover.1452612112.git.johannes.schindelin@gmx.de> <cover.1452668201.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:58:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJFNg-0006xI-5C
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 07:58:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284AbcAMG6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 01:58:00 -0500
Received: from mout.gmx.net ([212.227.15.15]:57184 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754112AbcAMG5z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 01:57:55 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M0h9K-1a36AL3Ycg-00utjK; Wed, 13 Jan 2016 07:57:51
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452668201.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:xx/ZFe/BT6Uqg8pkWDZiAgMOjZIJwER9ePovx9+EOEvrhiE+D1q
 NQj5UB8KgB84I6Kd6bhqetx+Y11uWQlk+Da6i6Pi2o8BgSMyFkxKs7MKNL/J9j7u2aOUNF4
 +1mt5IqnE/K9EBTKo61MKbFjoJ1f+wj5zhmUOKtmlkAc3dbTzekm2B98Kbv29X0jfJA8vsu
 0+AYT+2/ZJmIQkDtDhpow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DitrbenE1nY=:d6igcx6dg5OlOYbyJMTMiM
 2CpdhlSsQtPxpF7xgj1b+A3zOV334fNSEdJ/mbg/8Q8dreERIdPdIz/T+cK+V7w6/0m7cs7Aw
 yiJwdTGjsFVhBNWen4jkMn4ISLAZreiCQnfikN3SicvTcEsF8x3Zc6/ha90qAVzsrVDzuK5hH
 YVukQW6gtuqPpImon1BGqDJj3iT3iJ0rWNK3rOGDo+rV4i39fJGcSnfihzQKXu83Ag4itx9YK
 04OUxMYDqGaUHlSTXHLn/L4OpOm/a3XOW43ha2Pz4QJTmUwG13vJp9IuxvfkqGrmc6N6oGjQu
 4MMjCn35ghrblgDZF7YA0pVxz7zvbweO1SXg116kkxst9P6GjfYxAk+HYpyDD6ZIZyTDq6BLy
 CHiVqZsgOIpGsGEx5/wkPvUhfjePMcfDhHtExLiavw2gmlrxLQp3B5HoSjPrdzpBvYVsnjgLw
 I4RY4KjYoWBDfZ5dfSfSWPpaQ9I3QOUGCDiR4qgHkQkwTQkbi1hpxtaKW9CSP86goKXZllHqw
 KKp2aRgjvLPqTdQfthha6u1GfUZspJ1zBexIt/2jXgITZbl4B+p23v244DyacAAIstNweqMDD
 3ykSyNri3IaGkICBTaGUY/66EB5ejC+lF3YHT4ux/zQz2UqoNF7UaK99EVi7idm6jNirAUpPb
 7ZKO9N42KqnI9fPLmV5RGYDG/D2A+hZip6gVMxNWE3lPxd9MUdFm2BDrvafxCkOuy8m3wVC89
 2mKCbyL1LWgj6dcegXHAecN3zZVWmeffTP1YLpV/IQJLiVnJTaAzc14+UvY6FCU1r8yY47wK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283885>

The way builtin pull works, this change also supports the value
'interactive' for the 'branch.<name>.rebase' config variable, which
is a neat thing because users can now configure given branches for
interactively-rebasing pulls without having to type out the complete
`--rebase=interactive` option every time they pull.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt   |  1 +
 Documentation/git-pull.txt |  4 +++-
 builtin/pull.c             |  7 ++++++-
 t/t5520-pull.sh            | 10 ++++++++++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 07f7a3b..e5897e9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -865,6 +865,7 @@ branch.<name>.rebase::
 	instead of merging the default branch from the default remote when
 	"git pull" is run. See "pull.rebase" for doing this in a non
 	branch-specific manner.
+	When the value is `interactive`, the rebase is run in interactive mode.
 +
 When preserve, also pass `--preserve-merges` along to 'git rebase'
 so that locally committed merge commits will not be flattened
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 93c72a2..a62a2a6 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -101,7 +101,7 @@ Options related to merging
 include::merge-options.txt[]
 
 -r::
---rebase[=false|true|preserve]::
+--rebase[=false|true|preserve|interactive]::
 	When true, rebase the current branch on top of the upstream
 	branch after fetching. If there is a remote-tracking branch
 	corresponding to the upstream branch and the upstream branch
@@ -113,6 +113,8 @@ to `git rebase` so that locally created merge commits will not be flattened.
 +
 When false, merge the current branch into the upstream branch.
 +
+When `interactive`, enable the interactive mode of rebase.
++
 See `pull.rebase`, `branch.<name>.rebase` and `branch.autoSetupRebase` in
 linkgit:git-config[1] if you want to make `git pull` always use
 `--rebase` instead of merging.
diff --git a/builtin/pull.c b/builtin/pull.c
index 9e3c738..832d0ad 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -22,7 +22,8 @@ enum rebase_type {
 	REBASE_INVALID = -1,
 	REBASE_FALSE = 0,
 	REBASE_TRUE,
-	REBASE_PRESERVE
+	REBASE_PRESERVE,
+	REBASE_INTERACTIVE
 };
 
 /**
@@ -42,6 +43,8 @@ static enum rebase_type parse_config_rebase(const char *key, const char *value,
 		return REBASE_TRUE;
 	else if (!strcmp(value, "preserve"))
 		return REBASE_PRESERVE;
+	else if (!strcmp(value, "interactive"))
+		return REBASE_INTERACTIVE;
 
 	if (fatal)
 		die(_("Invalid value for %s: %s"), key, value);
@@ -778,6 +781,8 @@ static int run_rebase(const unsigned char *curr_head,
 	/* Options passed to git-rebase */
 	if (opt_rebase == REBASE_PRESERVE)
 		argv_array_push(&args, "--preserve-merges");
+	else if (opt_rebase == REBASE_INTERACTIVE)
+		argv_array_push(&args, "--interactive");
 	if (opt_diffstat)
 		argv_array_push(&args, opt_diffstat);
 	argv_array_pushv(&args, opt_strategies.argv);
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index a0013ee..c952d5e 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -326,6 +326,16 @@ test_expect_success 'pull.rebase=preserve rebases and merges keep-merge' '
 	test "$(git rev-parse HEAD^2)" = "$(git rev-parse keep-merge)"
 '
 
+test_expect_success 'pull.rebase=interactive' '
+	write_script "$TRASH_DIRECTORY/fake-editor" <<-\EOF &&
+	echo I was here >fake.out &&
+	false
+	EOF
+	test_set_editor "$TRASH_DIRECTORY/fake-editor" &&
+	test_must_fail git pull --rebase=interactive . copy &&
+	test "I was here" = "$(cat fake.out)"
+'
+
 test_expect_success 'pull.rebase=invalid fails' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase invalid &&
-- 
2.6.3.windows.1.300.g1c25e49
