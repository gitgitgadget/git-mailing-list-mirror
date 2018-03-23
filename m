Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F8321F404
	for <e@80x24.org>; Fri, 23 Mar 2018 21:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeCWV0A (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 17:26:00 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37302 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752101AbeCWVZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 17:25:57 -0400
Received: by mail-pg0-f65.google.com with SMTP id n11so5049619pgp.4
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 14:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=gRaB35zKT86Wrs/phZWFA/B/ZlxKSlipD3ADqPZ/3Jk=;
        b=kdAGHulR2JrbFZosThokFuzoXhFOJ/T8nZr8QWeVIqp3ZGzDW1q2Uihn6J21YQZZH2
         UolFO7ZDMDu4IVrbaQ9c7iVpPQyjwTIXfbIAWX2wa637OnpwhNpgFBnUfI4Ni/oWXl/v
         YkVBBhyob5ZL4DbFuU50CODRgS6Rhu/DdZmrBgATVDwcFng2orVeqzXdU8jBjct1yWwN
         4jnmj4y36lBqUmfCYWsQGkPy635d6lxJ8Cjcy3TSEUnznDNlD/M0/wE1MizQ7a5sSpUa
         773VA0lbmfxmwQwpev0NF3MVABIgVI8eu7clnKxyV5JcrgYrpQD5CVpg/gJJ+3ZqP3uW
         Q8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=gRaB35zKT86Wrs/phZWFA/B/ZlxKSlipD3ADqPZ/3Jk=;
        b=Nz7hiBqSlGE1vh7V+5OfZK3AbqJmzD9hT1OlNp/hcw79Z0LIaZAgP2/6iFyqUsZduf
         RtHf39spN4zUl1ILlX8bb7I+uVwLkYSHccQNTWAEcnHaUeMDM4xtXQX1h2WZPePLsFvO
         93mma0gx5I0riZd9/2X3kxIDZbmZesaffh1EcO3hLeN58OSDiivOA29zxIvS0gFYK7GV
         EcGO6GjmeQ77hddKjhg+oZ4EXH1gcitjMfk7MAOBj+z6wMp9lwxijzRjcnIpRCDwkUca
         RPGEIQ27eVGI90uV4jbc6mLR/gMeGIPNu+BAmYKPTLm1Os+MlreMgc12Tc4UAB6ne/Ew
         OQPg==
X-Gm-Message-State: AElRT7GAlb9X8QOU79PGa8sAAgP7iiEr8xaMtZhqGQ4fhY3Kr5J+1r5q
        4Sh1pFXZonCeTv0+WxeWSAusA786EL4=
X-Google-Smtp-Source: AG47ELudnO3+86IlpjQB2f4ISqWCbjiqF6446yAcaIYBBGabPJoPzUWNVsHHd1Zpl9DbkmHiXtoueg==
X-Received: by 10.98.65.72 with SMTP id o69mr25147396pfa.97.1521840356601;
        Fri, 23 Mar 2018 14:25:56 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id z28sm15380096pgc.15.2018.03.23.14.25.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 14:25:54 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, gister@pobox.com,
        sunshine@sunshineco.com, Johannes.Schindelin@gmx.de
Subject: [RFC PATCH v5 5/8] Add and use git_rebase__interactive__preserve_merges
Date:   Fri, 23 Mar 2018 14:25:26 -0700
Message-Id: <784c1d59b7d4831c57e923be3515ddf68a3a8f14.1521839546.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521839546.git.wink@saville.com>
References: <cover.1521839546.git.wink@saville.com>
In-Reply-To: <cover.1521839546.git.wink@saville.com>
References: <cover.1521779249.git.wink@saville.com> <cover.1521839546.git.wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the moment it's an exact copy of git_rebase__interactive except
the name has changed.

Signed-off-by: Wink Saville <wink@saville.com>
---
 git-rebase--interactive.sh | 108 +++++++++++++++++++++++++++++++++++++++++++++
 git-rebase.sh              |   2 +-
 2 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2c10a7f1a..ab5513d80 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1058,3 +1058,111 @@ git_rebase__interactive () {
 
 	complete_action
 }
+
+git_rebase__interactive__preserve_merges () {
+	initiate_action "$action"
+	ret=$?
+	if test $ret = 0; then
+		return 0
+	fi
+
+	setup_reflog_action
+	init_basic_state
+
+	if test t = "$preserve_merges"
+	then
+		if test -z "$rebase_root"
+		then
+			mkdir "$rewritten" &&
+			for c in $(git merge-base --all $orig_head $upstream)
+			do
+				echo $onto > "$rewritten"/$c ||
+					die "$(gettext "Could not init rewritten commits")"
+			done
+		else
+			mkdir "$rewritten" &&
+			echo $onto > "$rewritten"/root ||
+				die "$(gettext "Could not init rewritten commits")"
+		fi
+		# No cherry-pick because our first pass is to determine
+		# parents to rewrite and skipping dropped commits would
+		# prematurely end our probe
+		merges_option=
+	else
+		merges_option="--no-merges --cherry-pick"
+	fi
+
+	init_revisions_and_shortrevisions
+
+	if test t != "$preserve_merges"
+	then
+		git rebase--helper --make-script ${keep_empty:+--keep-empty} \
+			$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
+		die "$(gettext "Could not generate todo list")"
+	else
+		format=$(git config --get rebase.instructionFormat)
+		# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
+		git rev-list $merges_option --format="%m%H ${format:-%s}" \
+			--reverse --left-right --topo-order \
+			$revisions ${restrict_revision+^$restrict_revision} | \
+			sed -n "s/^>//p" |
+		while read -r sha1 rest
+		do
+
+			if test -z "$keep_empty" && is_empty_commit $sha1 && ! is_merge_commit $sha1
+			then
+				comment_out="$comment_char "
+			else
+				comment_out=
+			fi
+
+			if test -z "$rebase_root"
+			then
+				preserve=t
+				for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
+				do
+					if test -f "$rewritten"/$p
+					then
+						preserve=f
+					fi
+				done
+			else
+				preserve=f
+			fi
+			if test f = "$preserve"
+			then
+				touch "$rewritten"/$sha1
+				printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
+			fi
+		done
+	fi
+
+	# Watch for commits that been dropped by --cherry-pick
+	if test t = "$preserve_merges"
+	then
+		mkdir "$dropped"
+		# Save all non-cherry-picked changes
+		git rev-list $revisions --left-right --cherry-pick | \
+			sed -n "s/^>//p" > "$state_dir"/not-cherry-picks
+		# Now all commits and note which ones are missing in
+		# not-cherry-picks and hence being dropped
+		git rev-list $revisions |
+		while read rev
+		do
+			if test -f "$rewritten"/$rev &&
+			   ! sane_grep "$rev" "$state_dir"/not-cherry-picks >/dev/null
+			then
+				# Use -f2 because if rev-list is telling us this commit is
+				# not worthwhile, we don't want to track its multiple heads,
+				# just the history of its first-parent for others that will
+				# be rebasing on top of it
+				git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$dropped"/$rev
+				sha1=$(git rev-list -1 $rev)
+				sane_grep -v "^[a-z][a-z]* $sha1" <"$todo" > "${todo}2" ; mv "${todo}2" "$todo"
+				rm "$rewritten"/$rev
+			fi
+		done
+	fi
+
+	complete_action
+}
diff --git a/git-rebase.sh b/git-rebase.sh
index 6edf8c5b1..fb64ee1fe 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -197,7 +197,7 @@ run_specific_rebase () {
 		autosquash=
 	fi
 	. git-rebase--$type
-	git_rebase__$type
+	git_rebase__$type${preserve_merges:+__preserve_merges}
 	ret=$?
 	if test $ret -eq 0
 	then
-- 
2.16.2

