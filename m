From: =?UTF-8?q?Philip=20J=C3=A4genstedt?= <philip@foolip.org>
Subject: [PATCH v2] completion: remote set-* <name> and <branch>
Date: Tue, 21 Feb 2012 22:54:34 +0100
Message-ID: <1329861274-21418-1-git-send-email-philip@foolip.org>
References: <CAKHWUkZjQYnf=LwS_RC-E_7gV73AzbWjxs33E5-FL25s6_qX4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>,
	=?UTF-8?q?Philip=20J=C3=A4genstedt?= <philip@foolip.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 22:55:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzxgF-0006k8-2z
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 22:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755562Ab2BUVzV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 16:55:21 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:60553 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754623Ab2BUVzT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 16:55:19 -0500
Received: by lagu2 with SMTP id u2so8174602lag.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 13:55:17 -0800 (PST)
Received-SPF: pass (google.com: domain of philip@foolip.org designates 10.152.145.135 as permitted sender) client-ip=10.152.145.135;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of philip@foolip.org designates 10.152.145.135 as permitted sender) smtp.mail=philip@foolip.org
Received: from mr.google.com ([10.152.145.135])
        by 10.152.145.135 with SMTP id su7mr20514691lab.5.1329861317913 (num_hops = 1);
        Tue, 21 Feb 2012 13:55:17 -0800 (PST)
Received: by 10.152.145.135 with SMTP id su7mr17124033lab.5.1329861317852;
        Tue, 21 Feb 2012 13:55:17 -0800 (PST)
Received: from localhost.localdomain (h128n3-g-hn-a11.ias.bredband.telia.com. [217.209.32.128])
        by mx.google.com with ESMTPS id jb2sm23041821lab.7.2012.02.21.13.55.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Feb 2012 13:55:17 -0800 (PST)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <CAKHWUkZjQYnf=LwS_RC-E_7gV73AzbWjxs33E5-FL25s6_qX4g@mail.gmail.com>
X-Gm-Message-State: ALoCoQkRSSep0+O2wV/Fz8YkzllBJLq7LsYYvPvif1JuC8NuLd+vBwq+KM4wiudzzMQL9Vl6YIym
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191189>

Complete <name> only for set-url. For set-branches and
set-head, complete <name> and <branch> over the network,
like e.g. git pull already does.

The style used for incrementing and decrementing variables was fairly
inconsistenty and was normalized to use ++x, or ((++x)) in contexts
where the former would otherwise be interpreted as a command. This is a
bash-ism, but for obvious reasons this script is already bash-specific.

=46inally, remove out-of-date documentation for how to submit patches a=
nd
(silently) defer to Documentation/SubmittingPatches like all other code=
=2E

Signed-off-by: Philip J=C3=A4genstedt <philip@foolip.org>
---
 contrib/completion/git-completion.bash |   42 +++++++++++++-----------=
-------
 1 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 1505cff..9dac084 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -60,18 +60,6 @@
 #       per-repository basis by setting the bash.showUpstream config
 #       variable.
 #
-#
-# To submit patches:
-#
-#    *) Read Documentation/SubmittingPatches
-#    *) Send all patches to the current maintainer:
-#
-#       "Shawn O. Pearce" <spearce@spearce.org>
-#
-#    *) Always CC the Git mailing list:
-#
-#       git@vger.kernel.org
-#
=20
 if [[ -n ${ZSH_VERSION-} ]]; then
 	autoload -U +X bashcompinit && bashcompinit
@@ -395,7 +383,7 @@ __git_reassemble_comp_words_by_ref()
 	fi
 	# List of word completion separators has shrunk;
 	# re-assemble words to complete.
-	for ((i=3D0, j=3D0; i < ${#COMP_WORDS[@]}; i++, j++)); do
+	for ((i=3D0, j=3D0; i < ${#COMP_WORDS[@]}; ++i, ++j)); do
 		# Append each nonempty word consisting of just
 		# word separator characters to the current word.
 		first=3Dt
@@ -408,7 +396,7 @@ __git_reassemble_comp_words_by_ref()
 			# Attach to the previous token,
 			# unless the previous token is the command name.
 			if [ $j -ge 2 ] && [ -n "$first" ]; then
-				((j--))
+				((--j))
 			fi
 			first=3D
 			words_[$j]=3D${words_[j]}${COMP_WORDS[i]}
@@ -416,7 +404,7 @@ __git_reassemble_comp_words_by_ref()
 				cword_=3D$j
 			fi
 			if (($i < ${#COMP_WORDS[@]} - 1)); then
-				((i++))
+				((++i))
 			else
 				# Done.
 				return
@@ -738,6 +726,9 @@ __git_complete_remote_or_refspec ()
 {
 	local cur_=3D"$cur" cmd=3D"${words[1]}"
 	local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_complete_refspec=3D0
+	if [ "$cmd" =3D "remote" ]; then
+		((++c))
+	fi
 	while [ $c -lt $cword ]; do
 		i=3D"${words[c]}"
 		case "$i" in
@@ -755,7 +746,7 @@ __git_complete_remote_or_refspec ()
 		-*) ;;
 		*) remote=3D"$i"; break ;;
 		esac
-		c=3D$((++c))
+		((++c))
 	done
 	if [ -z "$remote" ]; then
 		__gitcomp_nl "$(__git_remotes)"
@@ -788,7 +779,7 @@ __git_complete_remote_or_refspec ()
 			__gitcomp_nl "$(__git_refs)" "$pfx" "$cur_"
 		fi
 		;;
-	pull)
+	pull|remote)
 		if [ $lhs =3D 1 ]; then
 			__gitcomp_nl "$(__git_refs "$remote")" "$pfx" "$cur_"
 		else
@@ -995,7 +986,7 @@ __git_find_on_cmdline ()
 				return
 			fi
 		done
-		c=3D$((++c))
+		((++c))
 	done
 }
=20
@@ -1006,7 +997,7 @@ __git_has_doubledash ()
 		if [ "--" =3D "${words[c]}" ]; then
 			return 0
 		fi
-		c=3D$((++c))
+		((++c))
 	done
 	return 1
 }
@@ -1129,7 +1120,7 @@ _git_branch ()
 		-d|-m)	only_local_ref=3D"y" ;;
 		-r)	has_r=3D"y" ;;
 		esac
-		c=3D$((++c))
+		((++c))
 	done
=20
 	case "$cur" in
@@ -2289,7 +2280,7 @@ _git_config ()
=20
 _git_remote ()
 {
-	local subcommands=3D"add rename rm show prune update set-head"
+	local subcommands=3D"add rename rm set-head set-branches set-url show=
 prune update"
 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
@@ -2297,9 +2288,12 @@ _git_remote ()
 	fi
=20
 	case "$subcommand" in
-	rename|rm|show|prune)
+	rename|rm|set-url|show|prune)
 		__gitcomp_nl "$(__git_remotes)"
 		;;
+	set-head|set-branches)
+		__git_complete_remote_or_refspec
+		;;
 	update)
 		local i c=3D'' IFS=3D$'\n'
 		for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "remote=
s\..*" 2>/dev/null); do
@@ -2580,7 +2574,7 @@ _git_tag ()
 			f=3D1
 			;;
 		esac
-		c=3D$((++c))
+		((++c))
 	done
=20
 	case "$prev" in
@@ -2633,7 +2627,7 @@ _git ()
 		--help) command=3D"help"; break ;;
 		*) command=3D"$i"; break ;;
 		esac
-		c=3D$((++c))
+		((++c))
 	done
=20
 	if [ -z "$command" ]; then
--=20
1.7.5.4
