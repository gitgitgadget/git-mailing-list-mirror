From: David Kastrup <dak@gnu.org>
Subject: Re: Shell script cleanups/style changes?
Date: Fri, 03 Aug 2007 01:32:07 +0200
Message-ID: <85k5sdy0lk.fsf@lola.goethe.zz>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<7vsl71tyyq.fsf@assigned-by-dhcp.cox.net>
	<86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<20070802214103.GT29424@schiele.dyndns.org>
	<85vebxy47e.fsf@lola.goethe.zz>
	<7vwswdsfjp.fsf@assigned-by-dhcp.cox.net>
	<20070802232126.GU29424@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 01:32:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGk9V-00005Q-5c
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 01:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756444AbXHBXcR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 19:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756670AbXHBXcR
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 19:32:17 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:41375 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756444AbXHBXcP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Aug 2007 19:32:15 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 5204F1F5546;
	Fri,  3 Aug 2007 01:32:14 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 34DD43467E0;
	Fri,  3 Aug 2007 01:32:14 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-049-245.pools.arcor-ip.net [84.61.49.245])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id B950D1D3165;
	Fri,  3 Aug 2007 01:32:13 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 7C62D1D0344E; Fri,  3 Aug 2007 01:32:07 +0200 (CEST)
In-Reply-To: <20070802232126.GU29424@schiele.dyndns.org> (Robert Schiele's message of "Fri\, 3 Aug 2007 01\:21\:27 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3848/Thu Aug  2 22:22:06 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54643>

Robert Schiele <rschiele@gmail.com> writes:

> On Thu, Aug 02, 2007 at 04:05:46PM -0700, Junio C Hamano wrote:
>> However, there is a line we need to draw when bending bacwards
>> for compatibility, and I think a system that does not have a
>> working command substitution $( ... )  is on the other side of
>> that line.
>
> Well, I have now a patch ready for submission that would replace all
> occurences of ${PARAMETER#WORD}, ${PARAMETER%WORD}, and $((
> EXPRESSION )).  But if you say that you won't accept replacement of
> $( ... ) then this is not worth the effort since this one isn't
> accepted as well.

I absolutely can't understand your claim that most things work for
you, then.  Are you _really_, _really_ sure you are talking about
/bin/sh here?

Look:

-*- mode: grep; default-directory: "/home/tmp/git/" -*-
Grep started at Fri Aug  3 01:29:41

fgrep -nH -e '$(' *.sh
check-builtins.sh:6:	$(foreach b,$(BUILT_INS),echo XXX $b YYY;)
git-am.sh:24:    cmdline=$(basename $0)
git-am.sh:83:    his_tree=$(GIT_INDEX_FILE="$dotest/patch-merge-index" git write-tree) &&
git-am.sh:84:    orig_tree=$(cat "$dotest/patch-merge-base") &&
git-am.sh:160:   last=$(cat "$dotest/last") &&
git-am.sh:161:   next=$(cat "$dotest/next") &&
git-am.sh:216:	files=$(git diff-index --cached --name-only HEAD) || exit
git-am.sh:223:if test "$(cat "$dotest/binary")" = t
git-am.sh:227:if test "$(cat "$dotest/utf8")" = t
git-am.sh:233:if test "$(cat "$dotest/keep")" = t
git-am.sh:238:if test "$(cat "$dotest/sign")" = t
git-am.sh:301:	GIT_AUTHOR_NAME="$(sed -n '/^Author/ s/Author: //p' "$dotest/info")"
git-am.sh:302:	GIT_AUTHOR_EMAIL="$(sed -n '/^Email/ s/Email: //p' "$dotest/info")"
git-am.sh:303:	GIT_AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' "$dotest/info")"
git-am.sh:313:	SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' "$dotest/info")"
git-am.sh:415:		unmerged=$(git ls-files -u)
git-am.sh:453:	tree=$(git write-tree) &&
git-am.sh:455:	parent=$(git rev-parse --verify HEAD) &&
git-am.sh:456:	commit=$(git commit-tree $tree -p $parent <"$dotest/final-commit") &&
git-bisect.sh:59:	head=$(GIT_DIR="$GIT_DIR" git symbolic-ref HEAD) ||
git-bisect.sh:92:	orig_args=$(sq "$@")
git-bisect.sh:102:	        rev=$(git rev-parse --verify "$arg^{commit}" 2>/dev/null) || {
git-bisect.sh:127:		rev=$(git rev-parse --verify HEAD) ;;
git-bisect.sh:129:		rev=$(git rev-parse --verify "$1^{commit}") ;;
git-bisect.sh:141:	echo "# bad: "$(git show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
git-bisect.sh:147:	0)    revs=$(git rev-parse --verify HEAD) || exit ;;
git-bisect.sh:148:	*)    revs=$(git rev-parse --revs-only --no-flags "$@") &&
git-bisect.sh:153:		rev=$(git rev-parse --verify "$rev^{commit}") || exit
git-bisect.sh:164:	echo "# good: "$(git show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
git-bisect.sh:170:	test -n "$(git for-each-ref "refs/bisect/good-*")" || missing_good=t
git-bisect.sh:187:			case "$(read yesno)" in [Nn]*) exit 1 ;; esac
git-bisect.sh:214:	bad=$(git rev-parse --verify refs/bisect/bad) &&
git-bisect.sh:215:	good=$(git for-each-ref --format='^%(objectname)' \
git-bisect.sh:218:	eval="$eval $(cat "$GIT_DIR/BISECT_NAMES")" &&
git-bisect.sh:219:	eval=$(eval "$eval") &&
git-bisect.sh:243:	eval gitk bisect/bad --not $not -- $(cat "$GIT_DIR/BISECT_NAMES")
git-bisect.sh:291:			echo "# good: "$(git show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
git-bisect.sh:296:			echo "# bad: "$(git show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
git-checkout.sh:9:old=$(git rev-parse --verify $old_name 2>/dev/null)
git-checkout.sh:10:oldbranch=$(git symbolic-ref $old_name 2>/dev/null)
git-checkout.sh:60:		if rev=$(git rev-parse --verify "$arg^0" 2>/dev/null)
git-checkout.sh:69:				rev=$(git rev-parse --verify "refs/heads/$arg^0")
git-checkout.sh:73:		elif rev=$(git rev-parse --verify "$arg^{tree}" 2>/dev/null)
git-checkout.sh:206:    merge_error=$(git read-tree -m -u --exclude-per-directory=.gitignore $old $new 2>&1) || (
git-clone.sh:147:		upload_pack=--upload-pack=$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
git-clone.sh:181:if base=$(get_repo_base "$repo"); then
git-clone.sh:188:[ -z "$dir" ] && dir=$(echo "$repo" | sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
git-clone.sh:205:mkdir -p "$dir" && D=$(cd "$dir" && pwd) || usage
git-clone.sh:207:W=$(cd "$GIT_WORK_TREE" && pwd) && export GIT_WORK_TREE="$W"
git-clone.sh:231:		ref_git=$(cd "$ref_git" && pwd)
git-clone.sh:260:	    sample_file=$(cd "$repo" && \
git-clone.sh:391:	head_points_at=$(
git-commit.sh:463:	encoding=$(git config i18n.commitencoding || echo UTF-8)
git-commit.sh:479:	sign=$(git-var GIT_COMMITTER_IDENT | sed -e '
git-commit.sh:506:	eval "$(get_author_ident_from_commit "$use_commit")"
git-commit.sh:528:		PARENTS=$(git cat-file commit HEAD |
git-commit.sh:531:	current="$(git rev-parse --verify HEAD)"
git-commit.sh:533:	if [ -z "$(git ls-files)" ]; then
git-commit.sh:625:		tree=$(GIT_INDEX_FILE="$USE_INDEX" git write-tree)
git-commit.sh:627:		tree=$(GIT_INDEX_FILE="$TMP_INDEX" git write-tree) &&
git-commit.sh:630:	commit=$(git commit-tree $tree $PARENTS <"$GIT_DIR/COMMIT_MSG") &&
git-commit.sh:631:	rlogm=$(sed -e 1q "$GIT_DIR"/COMMIT_MSG) &&
git-fetch.sh:43:		exec=--upload-pack=$(expr "z$1" : 'z-[^=]*=\(.*\)')
git-fetch.sh:88:	origin=$(get_default_remote)
git-fetch.sh:89:	test -n "$(get_remote_url ${origin})" ||
git-fetch.sh:97:	exec="--upload-pack=$(get_uploadpack $1)"
git-fetch.sh:101:remote=$(get_remote_url "$@")
git-fetch.sh:112:ls_remote_result=$(git ls-remote $exec "$remote") ||
git-fetch.sh:125:if test -z "$update_head_ok" && test $(is_bare_repository) = false
git-fetch.sh:127:	orig_head=$(git rev-parse --verify HEAD 2>/dev/null)
git-fetch.sh:133:	case "$(git config --get "remote.$1.tagopt")" in
git-fetch.sh:144:reflist=$(get_remote_refs_for_fetch "$@")
git-fetch.sh:166:  eval=$(echo "$1" | git fetch--tool parse-reflist "-")
git-fetch.sh:192:			theirs=$(echo "$ls_remote_result" | \
git-fetch.sh:242:	  ref=$(expr "z$ref" : 'z\.\(.*\)')
git-fetch.sh:249:	  ref=$(expr "z$ref" : 'z+\(.*\)')
git-fetch.sh:253:      remote_name=$(expr "z$ref" : 'z\([^:]*\):')
git-fetch.sh:254:      local_name=$(expr "z$ref" : 'z[^:]*:\(.*\)')
git-fetch.sh:273:	  head=$(echo "$ls_remote_result" | \
git-fetch.sh:286:	  head=$(git rev-parse --verify TMP_HEAD)
git-fetch.sh:343:		taglist=$(IFS='	' &&
git-fetch.sh:368:	curr_head=$(git rev-parse --verify HEAD 2>/dev/null)
git-filter-branch.sh:43:	lid="$(echo "$1" | tr "A-Z" "a-z")"
git-filter-branch.sh:44:	uid="$(echo "$1" | tr "a-z" "A-Z")"
git-filter-branch.sh:154:tempdir="$(cd "$tempdir"; pwd)" &&
git-filter-branch.sh:156:workdir="$(pwd)" ||
git-filter-branch.sh:177:	GIT_DIR="$(pwd)/../../$GIT_DIR"
git-filter-branch.sh:190:		ref="$(git symbolic-ref "$ref")"
git-filter-branch.sh:195:		ref="$(git for-each-ref --format='%(refname)' |
git-filter-branch.sh:205:export GIT_INDEX_FILE="$(pwd)/../index"
git-filter-branch.sh:222:commits=$(wc -l <../revs | tr -d " ")
git-filter-branch.sh:230:	i=$(($i+1))
git-filter-branch.sh:245:	eval "$(set_ident AUTHOR <../commit)" ||
git-filter-branch.sh:247:	eval "$(set_ident COMMITTER <../commit)" ||
git-filter-branch.sh:272:		for reparent in $(map "$parent"); do
git-filter-branch.sh:277:		parentstr="$(echo "$parentstr" | eval "$filter_parent")" ||
git-filter-branch.sh:285:		$(git write-tree) $parentstr < ../message > ../map/$commit
git-filter-branch.sh:296:	sha1=$(git rev-parse "$ref"^0)
git-filter-branch.sh:301:	for p in $( (cd "$workdir"/../map; ls | sed "s/^/^/") |
git-filter-branch.sh:320:	sha1=$(git rev-parse "$ref"^0)
git-filter-branch.sh:321:	rewritten=$(map $sha1)
git-filter-branch.sh:344:		rewritten=$(echo "$rewritten" | head -n 1)
git-filter-branch.sh:351:	count=$(($count+1))
git-filter-branch.sh:370:			sha1="$(git rev-parse "$sha1"^{commit} 2>/dev/null)" || continue
git-filter-branch.sh:374:		new_sha1="$(cat "../map/$sha1")"
git-filter-branch.sh:376:		new_ref="$(echo "$ref" | eval "$filter_tag_name")" ||
git-ls-remote.sh:30:	exec=--upload-pack=$(expr "z$1" : 'z-[^=]*=\(.*\)')
git-ls-remote.sh:48:peek_repo="$(get_remote_url "$@")"
git-ls-remote.sh:75:	head=$(cat "$tmpdir/HEAD") &&
git-ls-remote.sh:78:		head=$(expr "z$head" : 'zref: \(.*\)') &&
git-ls-remote.sh:79:		head=$(cat "$tmpdir/$head") || exit
git-merge-octopus.sh:48:MRT=$(git write-tree)
git-merge-octopus.sh:64:	common=$(git merge-base --all $MRC $SHA1) ||
git-merge-octopus.sh:86:		MRC=$SHA1 MRT=$(git write-tree)
git-merge-octopus.sh:94:	next=$(git write-tree 2>/dev/null)
git-merge-octopus.sh:100:		next=$(git write-tree 2>/dev/null)
git-merge-one-file.sh:36:		rmdir -p "$(expr "z$4" : 'z\(.*\)/')" 2>/dev/null || :
git-merge-resolve.sh:43:if result_tree=$(git write-tree  2>/dev/null)
git-merge.sh:13:test -z "$(git ls-files -u)" ||
git-merge.sh:102:	rh=$(git rev-parse --verify "$remote^0" 2>/dev/null) || return
git-merge.sh:103:	bh=$(git show-ref -s --verify "refs/heads/$remote" 2>/dev/null)
git-merge.sh:107:	elif truname=$(expr "$remote" : '\(.*\)~[1-9][0-9]*$') &&
git-merge.sh:173:    test "$(git config --bool merge.diffstat)" = false && show_diffstat=false
git-merge.sh:184:	second_token=$(git rev-parse --verify "$2^0" 2>/dev/null) &&
git-merge.sh:185:	head_commit=$(git rev-parse --verify "HEAD" 2>/dev/null) &&
git-merge.sh:203:	rh=$(git rev-parse --verify "$1^0") ||
git-merge.sh:219:	merge_name=$(for remote
git-merge.sh:226:head=$(git rev-parse --verify "$head_arg"^0) || usage
git-merge.sh:235:	remotehead=$(git rev-parse --verify "$remote"^0 2>/dev/null) ||
git-merge.sh:281:	common=$(git merge-base --all $head "$@")
git-merge.sh:284:	common=$(git show-branch --merge-base $head "$@")
git-merge.sh:304:	echo "Updating $(git rev-parse --short $head)..$(git rev-parse --short $1)"
git-merge.sh:311:	new_head=$(git rev-parse --verify "$1^0") &&
git-merge.sh:334:		   result_tree=$(git write-tree)
git-merge.sh:337:			result_commit=$(
git-merge.sh:353:		common_one=$(git merge-base --all $head $remote)
git-merge.sh:435:    result_tree=$(git write-tree) && break
git-merge.sh:442:    parents=$(git show-branch --independent "$head" "$@" | sed -e 's/^/-p /')
git-merge.sh:443:    result_commit=$(printf '%s\n' "$merge_msg" | git commit-tree $result_tree $parents) || exit
git-merge-stupid.sh:69:if result_tree=$(git write-tree  2>/dev/null)
git-mergetool.sh:51:	echo "a symbolic link -> '$(cat "$file")'"
git-mergetool.sh:266:		eval "${eval_candidate}" --eval '"$(emacs-string "(ediff-merge-files-with-ancestor" @ "$LOCAL" @ "$REMOTE" @ "$BASE" "(lambda()(setq ediff-keep-variants nil))" @ "$path" ")")"'
git-mergetool.sh:268:		eval "${eval_candidate}" --eval '"$(emacs-string "(ediff-merge-files" @ "$LOCAL" @ "$REMOTE" "(lambda()(setq ediff-keep-variants nil))" @ "$path" ")")"'
git-mergetool.sh:314:	for i in "$GIT_EDITOR" "$(git config core.editor)" "$VISUAL" "$EDITOR"
git-parse-remote.sh:5:GIT_DIR=$(git rev-parse --git-dir 2>/dev/null) || :;
git-parse-remote.sh:16:		if test "$(git config --get "remote.$1.url")"
git-parse-remote.sh:32:	data_source=$(get_data_source "$1")
git-parse-remote.sh:58:	curr_branch=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
git-parse-remote.sh:59:	origin=$(git config --get "branch.$curr_branch.remote")
git-parse-remote.sh:64:	data_source=$(get_data_source "$1")
git-parse-remote.sh:105:		set $(expand_refs_wildcard "$remote" "$@")
git-parse-remote.sh:108:		if test "$remote" = "$(get_default_remote)"
git-parse-remote.sh:110:			curr_branch=$(git symbolic-ref -q HEAD | \
git-parse-remote.sh:112:			merge_branches=$(git config \
git-parse-remote.sh:125:			ref=$(expr "z$ref" : 'z+\(.*\)')
git-parse-remote.sh:130:		remote=$(expr "z$ref" : 'z\([^:]*\):')
git-parse-remote.sh:131:		local=$(expr "z$ref" : 'z[^:]*:\(.*\)')
git-parse-remote.sh:157:		if local_ref_name=$(expr "z$local" : 'zrefs/\(.*\)')
git-parse-remote.sh:168:	data_source=$(get_data_source "$1")
git-parse-remote.sh:174:			$(git for-each-ref --format='%(refname):')
git-parse-remote.sh:178:			$(git config --get-all "remote.$1.fetch") ;;
git-parse-remote.sh:180:		remote_branch=$(sed -ne '/#/s/.*#//p' "$GIT_DIR/branches/$1")
git-parse-remote.sh:185:		canon_refs_list_for_fetch -d "$1" $(sed -ne '/^Pull: */{
git-parse-remote.sh:254:	data_source=$(get_data_source "$1")
git-parse-remote.sh:257:		uplp=$(git config --get "remote.$1.uploadpack")
git-pull.sh:15:test -z "$(git ls-files -u)" ||
git-pull.sh:57:orig_head=$(git rev-parse --verify HEAD 2>/dev/null)
git-pull.sh:60:curr_head=$(git rev-parse --verify HEAD 2>/dev/null)
git-pull.sh:83:merge_head=$(sed -e '/	not-for-merge	/d' \
git-pull.sh:89:	curr_branch=$(git symbolic-ref -q HEAD)
git-pull.sh:121:merge_name=$(git fmt-merge-msg <"$GIT_DIR/FETCH_HEAD") || exit
git-quiltimport.sh:12:		quilt_author=$(expr "z$1" : 'z-[^=]*\(.*\)')
git-quiltimport.sh:29:		QUILT_PATCHES=$(expr "z$1" : 'z-[^=]*\(.*\)')
git-quiltimport.sh:48:	quilt_author_name=$(expr "z$quilt_author" : 'z\(.*[^ ]\) *<.*') &&
git-quiltimport.sh:49:	quilt_author_email=$(expr "z$quilt_author" : '.*<\([^>]*\)') &&
git-quiltimport.sh:70:commit=$(git rev-parse HEAD)
git-quiltimport.sh:73:for patch_name in $(grep -v '^#' < "$QUILT_PATCHES/series" ); do
git-quiltimport.sh:83:	export GIT_AUTHOR_NAME=$(sed -ne 's/Author: //p' "$tmp_info")
git-quiltimport.sh:84:	export GIT_AUTHOR_EMAIL=$(sed -ne 's/Email: //p' "$tmp_info")
git-quiltimport.sh:102:			patch_author_name=$(expr "z$patch_author" : 'z\(.*[^ ]\) *<.*') &&
git-quiltimport.sh:103:			patch_author_email=$(expr "z$patch_author" : '.*<\([^>]*\)') &&
git-quiltimport.sh:110:	export GIT_AUTHOR_DATE=$(sed -ne 's/Date: //p' "$tmp_info")
git-quiltimport.sh:111:	export SUBJECT=$(sed -ne 's/Subject: //p' "$tmp_info")
git-quiltimport.sh:113:		SUBJECT=$(echo $patch_name | sed -e 's/.patch$//')
git-quiltimport.sh:118:		tree=$(git write-tree) &&
git-quiltimport.sh:119:		commit=$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit-tree $tree -p $commit) &&
git-rebase--interactive.sh:29:test -f "$DOTEST"/strategy && STRATEGY="$(cat "$DOTEST"/strategy)"
git-rebase--interactive.sh:73:	count=$(($(wc -l < "$DONE")))
git-rebase--interactive.sh:74:	total=$(($count+$(wc -l < "$TODO")))
git-rebase--interactive.sh:80:	parent_sha1=$(git rev-parse --verify "$1"^ 2> /dev/null)
git-rebase--interactive.sh:103:	parent_sha1=$(git rev-parse --verify $sha1^ 2>/dev/null)
git-rebase--interactive.sh:104:	current_sha1=$(git rev-parse --verify HEAD)
git-rebase--interactive.sh:108:		sha1=$(git rev-parse --short $sha1)
git-rebase--interactive.sh:117:	sha1=$(git rev-parse $sha1)
git-rebase--interactive.sh:121:		current_commit=$(cat "$DOTEST"/current-commit) &&
git-rebase--interactive.sh:131:	for p in $(git rev-list --parents -1 $sha1 | cut -d\  -f2-)
git-rebase--interactive.sh:136:			new_p=$(cat "$REWRITTEN"/$p)
git-rebase--interactive.sh:154:		first_parent=$(expr "$new_parents" : " \([^ ]*\)")
git-rebase--interactive.sh:163:			author_script=$(get_author_ident_from_commit $sha1)
git-rebase--interactive.sh:165:			msg="$(git cat-file commit $sha1 | \
git-rebase--interactive.sh:192:		COUNT=$(($(sed -n "s/^# This is [^0-9]*\([0-9]\+\).*/\1/p" \
git-rebase--interactive.sh:204:	echo "# This is the $(nth_string $COUNT) commit message:"
git-rebase--interactive.sh:245:		test -z "$(grep -ve '^$' -e '^#' < $DONE)" &&
git-rebase--interactive.sh:250:		case "$(peek_next_command)" in
git-rebase--interactive.sh:265:		author_script=$(get_author_ident_from_commit $sha1)
git-rebase--interactive.sh:288:	HEADNAME=$(cat "$DOTEST"/head-name) &&
git-rebase--interactive.sh:289:	OLDHEAD=$(cat "$DOTEST"/head) &&
git-rebase--interactive.sh:290:	SHORTONTO=$(git rev-parse --short $(cat "$DOTEST"/onto)) &&
git-rebase--interactive.sh:294:			current_commit=$(cat "$DOTEST"/current-commit) &&
git-rebase--interactive.sh:296:		NEWHEAD=$(cat "$REWRITTEN"/$OLDHEAD)
git-rebase--interactive.sh:298:		NEWHEAD=$(git rev-parse HEAD)
git-rebase--interactive.sh:304:			git diff --stat $(cat "$DOTEST"/head)..HEAD
git-rebase--interactive.sh:344:		HEADNAME=$(cat "$DOTEST"/head-name)
git-rebase--interactive.sh:345:		HEAD=$(cat "$DOTEST"/head)
git-rebase--interactive.sh:400:			ONTO=$(git rev-parse --verify "$2") ||
git-rebase--interactive.sh:417:		HEAD=$(git rev-parse --verify HEAD) || die "No HEAD?"
git-rebase--interactive.sh:418:		UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
git-rebase--interactive.sh:441:			for c in $(git merge-base --all $HEAD $UPSTREAM)
git-rebase--interactive.sh:451:		SHORTUPSTREAM=$(git rev-parse --short $UPSTREAM)
git-rebase--interactive.sh:452:		SHORTHEAD=$(git rev-parse --short $HEAD)
git-rebase--interactive.sh:453:		SHORTONTO=$(git rev-parse --short $ONTO)
git-rebase--interactive.sh:470:		test -z "$(grep -ve '^$' -e '^#' < $TODO)" &&
git-rebase--interactive.sh:477:		test -z "$(grep -ve '^$' -e '^#' < $TODO)" &&
git-rebase.sh:54:	unmerged=$(git ls-files -u)
git-rebase.sh:82:	msgnum=$(($msgnum + 1))
git-rebase.sh:87:	cmt="$(cat $dotest/cmt.$1)"
git-rebase.sh:89:	hd=$(git rev-parse --verify HEAD)
git-rebase.sh:90:	cmt_name=$(git symbolic-ref HEAD)
git-rebase.sh:91:	msgnum=$(cat $dotest/msgnum)
git-rebase.sh:92:	end=$(cat $dotest/end)
git-rebase.sh:93:	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
git-rebase.sh:94:	eval GITHEAD_$hd='"$(cat $dotest/onto_name)"'
git-rebase.sh:167:			msgnum=$(($msgnum + 1))
git-rebase.sh:257:diff=$(git diff-index --cached --name-status -r HEAD)
git-rebase.sh:272:onto=$(git rev-parse --verify "${onto_name}^0") || exit
git-rebase.sh:298:branch=$(git rev-parse --verify "${branch_name}^0") || exit
git-rebase.sh:304:mb=$(git merge-base "$onto" "$branch")
git-rebase.sh:351:	msgnum=$(($msgnum + 1))
git-repack.sh:67:names=$(git pack-objects --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
git-reset.sh:27:		rev=$(git rev-parse --verify "$1") || exit
git-reset.sh:36:rev=$(git rev-parse --verify $rev^0) || exit
git-reset.sh:69:	   test "" != "$(git ls-files --unmerged)"
git-reset.sh:78:if orig=$(git rev-parse --verify HEAD 2>/dev/null)
git-sh-setup.sh:32:	: "${GIT_EDITOR:=$(git config core.editor)}"
git-sh-setup.sh:52:	cdup=$(git rev-parse --show-cdup)
git-sh-setup.sh:63:	test $(git rev-parse --is-inside-work-tree) = true ||
git-sh-setup.sh:89:	encoding=$(git config i18n.commitencoding || echo UTF-8)
git-sh-setup.sh:113:	GIT_DIR=$(GIT_DIR="$GIT_DIR" git rev-parse --git-dir) || {
git-sh-setup.sh:119:	GIT_DIR=$(git rev-parse --git-dir) || exit
git-stash.sh:22:	if current=$(git rev-parse --verify $ref_stash 2>/dev/null)
git-stash.sh:43:	if b_commit=$(git rev-parse --verify HEAD)
git-stash.sh:45:		head=$(git log --abbrev-commit --pretty=oneline -n 1 HEAD)
git-stash.sh:50:	if branch=$(git symbolic-ref -q HEAD)
git-stash.sh:56:	msg=$(printf '%s: %s' "$branch" "$head")
git-stash.sh:59:	i_tree=$(git write-tree) &&
git-stash.sh:60:	i_commit=$(printf 'index on %s' "$msg" |
git-stash.sh:65:	w_tree=$( (
git-stash.sh:80:		stash_msg=$(printf 'WIP on %s' "$msg")
git-stash.sh:82:		stash_msg=$(printf 'On %s: %s' "$branch" "$stash_msg")
git-stash.sh:84:	w_commit=$(printf '%s\n' "$stash_msg" |
git-stash.sh:104:	flags=$(git rev-parse --no-revs --flags "$@")
git-stash.sh:109:	s=$(git rev-parse --revs-only --no-flags --default $ref_stash "$@")
git-stash.sh:111:	w_commit=$(git rev-parse --verify "$s") &&
git-stash.sh:112:	b_commit=$(git rev-parse --verify "$s^") &&
git-stash.sh:128:	c_tree=$(git write-tree) ||
git-stash.sh:133:	s=$(git rev-parse --revs-only --no-flags --default $ref_stash "$@") &&
git-stash.sh:134:	w_tree=$(git rev-parse --verify "$s:") &&
git-stash.sh:135:	b_tree=$(git rev-parse --verify "$s^1:") &&
git-stash.sh:136:	i_tree=$(git rev-parse --verify "$s^2:") ||
git-stash.sh:145:		unstashed_index_tree=$(git-write-tree) ||
git-submodule.sh:50:	re=$(printf '%s' "$1" | sed -e 's/\([^a-zA-Z0-9_]\)/\\\1/g')
git-submodule.sh:51:	name=$( GIT_CONFIG=.gitmodules \
git-submodule.sh:108:	if base=$(get_repo_base "$repo"); then
git-submodule.sh:114:		path=$(echo "$repo" | sed -e 's|/*$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
git-submodule.sh:116:		path=$(echo "$path" | sed -e 's|/*$||')
git-submodule.sh:148:		name=$(module_name "$path") || exit
git-submodule.sh:149:		url=$(git config submodule."$name".url)
git-submodule.sh:152:		url=$(GIT_CONFIG=.gitmodules git config submodule."$name".url)
git-submodule.sh:173:		name=$(module_name "$path") || exit
git-submodule.sh:174:		url=$(git config submodule."$name".url)
git-submodule.sh:189:			subsha1=$(unset GIT_DIR && cd "$path" &&
git-submodule.sh:206:	revname=$( (
git-submodule.sh:232:		name=$(module_name "$path") || exit
git-submodule.sh:233:		url=$(git config submodule."$name".url)
git-submodule.sh:246:				sha1=$(unset GIT_DIR && cd "$path" && git rev-parse --verify HEAD)
git-tag.sh:39:		LINES=$(expr "$1" : '\([0-9]*\)')
git-tag.sh:64:		OBJTYPE=$(git cat-file -t "$TAG")
git-tag.sh:67:			ANNOTATION=$(git cat-file tag "$TAG" |
git-tag.sh:100:	    message="$(cat "$1")"
git-tag.sh:121:		cur=$(git show-ref --verify --hash -- "refs/tags/$tag") || {
git-tag.sh:137:	tag=$(git show-ref --verify --hash -- "refs/tags/$tag_name") ||
git-tag.sh:165:object=$(git rev-parse --verify --default HEAD "$@") || exit 1
git-tag.sh:166:type=$(git cat-file -t $object) || exit 1
git-tag.sh:167:tagger=$(git-var GIT_COMMITTER_IDENT) || exit 1
git-tag.sh:170:	username=$(git repo-config user.signingkey) ||
git-tag.sh:171:	username=$(expr "z$tagger" : 'z\(.*>\)')
git-tag.sh:202:    object=$(git-mktag < "$GIT_DIR"/TAG_TMP)
git-verify-tag.sh:24:type="$(git cat-file -t "$1" 2>/dev/null)" ||

Grep finished (matches found) at Fri Aug  3 01:29:41


-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
