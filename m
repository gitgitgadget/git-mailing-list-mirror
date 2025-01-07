Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07081F37C8
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736276250; cv=none; b=KAyVNn0Allau6ylK1sTm/qiuJz91ImhgQKVMQHi8k6tW0Q1SESkznrsDon4J4iTgJhSqXXwwZUyWdCgck2aCtYJoT6nQfWjljQkq2N3mUtBJzqhyK2lrfBRGFuDW0bG6PeOnmaNu6yS2C8agOY+eq7Ojtt63bt//2pnnQKcNdlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736276250; c=relaxed/simple;
	bh=9ehk6wzEBSMTJS6BpIPW778BNTv0Cx83U2D9ZBXneZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tHLkuCnFBI9BoX4khs7WHQ2T/2k5m4TeJdb6MLaqUisfioSy65Csn6llyKuokKjEPZx6rn/d6k2rnaGBEEg+LAe1WSyTbvzuCkDwN7z+jkFTmzFWTs3u0lMFFkfpiX+c3lwpHDnFzn+dOwg22VBY6gIaQteRQOLy6HBlwI1bvZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu; spf=pass smtp.mailfrom=cepl.eu; dkim=pass (2048-bit key) header.d=cepl.eu header.i=@cepl.eu header.b=WXbUoHKc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eFH1Y+Sh; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cepl.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cepl.eu header.i=@cepl.eu header.b="WXbUoHKc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eFH1Y+Sh"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 8409F1D40586;
	Tue,  7 Jan 2025 13:57:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 07 Jan 2025 13:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cepl.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1736276244; x=1736279844; bh=hX1rSf49sA
	hATlUECQHzM6lr2sWHS/2ER7VxBpBNGaM=; b=WXbUoHKcYq6NvzblYvesn80TBO
	hIBTcT+3Awpxnpv9khRR2zn9Ls+oeeoEQsUrujvrX0vXEFzkUeHmBCsPK3W2ssAY
	JW/YQ8R/IEPs0U3kNanh5YpIgd8EtIFgPKt/xFXS/3phwdPNvoVv/4wMezVT5M3S
	JxjL+BmkWz3MW06FfL+Se2vD3gW4i8/kVQ1QfI1ShD7B+JWsOi3Z2m8nQuG9/mGu
	A4lZDDDdzDgYYCj8KNCwzQx9IpIMD0uraOm7Lw/Vq7KThAJK4m6nFqjrhhoT6TI5
	8MgsUz1QpM//7HEEqiQNDzAE6Q32uR+PcEklFkUL5Z5elQf3T7My3UZUEKmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1736276244; x=1736279844; bh=hX1rSf49sAhATlUECQHzM6lr2sWH
	S/2ER7VxBpBNGaM=; b=eFH1Y+ShoR7Ps6G4kjhNLz9zKCVpnM4TwpXnhyWbP6Qm
	qfCGE4y71710L6UG5G2pd6/s4bo/ktDoGUTLcIZKOp2UY9iRRJi7d6UOEivAuZkb
	P3lcbzZyHLj6oZY3DivPI6V8k6pPxY8HSsoUICIsr8PNqexU7NLXnesLHAuJUXm8
	OK0YBaF3hlt5Ew2vo47yZGqEuLLqjFWeB2BLSJAYz/H52WgIE3AzSgKmAMzhcbAm
	EnjvHMKyaQT8e4KBJahSzM4X9QXmtYJpSyHoOYFDH7JMUHSPVWa0zLwJKBKvnjDf
	ET48ok44KKtF1jvNPR/bCfMyrQvIACMWlSzdpuDy5g==
X-ME-Sender: <xms:E3l9Z-gVyOmVrnxrpH8AEYZ2vMmG3asfECJWgDVfrMe8G23mOj5SoA>
    <xme:E3l9Z_Dftfdx4PzcJObqaOi_puzKZhPgq3qMCd_xE4zYSEh61_PzJXWmz-1RJT3_V
    yfa3qMYeO0u-LxyzBg>
X-ME-Received: <xmr:E3l9Z2FRQmjqnDs9-Y9groxhMddR9YeNT2Csb3Nm9gNMzkq_MlaQSWADSZtnLAVQc2IP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeforghtvmhjucevvghplhcuoehm
    tggvphhlsegtvghplhdrvghuqeenucggtffrrghtthgvrhhnpedtuefhheehieffvddtve
    fhjefhffetvdelleefueeivdegleeiudevjefgtdeuveenucffohhmrghinhepghhithhl
    rggsrdgtohhmpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmtggvphhlsegtvghplhdrvghupdhnsggprhgtphht
    thhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgtvghplhestggvphhlrdgvuh
X-ME-Proxy: <xmx:E3l9Z3Q4qWHdMmY_FEVV4YlbUJPa8B-TPfz1zOMTOETiLO0fFFWUYw>
    <xmx:E3l9Z7wF-Xz5XLqvm2G2WSVTXhxkhYn4HgVb4iJHBWfzcbAG1UmFYg>
    <xmx:E3l9Z171ZMN9_T6aRGOiQAwrISSoI1CUtqPNRQQg0J2LOxR4Q7XFGA>
    <xmx:E3l9Z4x-tA9ol-YsWaThmuwOSRA8S5pbfEmuvGOHYlAEvgoWfg2FfA>
    <xmx:E3l9Z8sg_MFZWLMA6F7xhk6m3EUs7SJ1NJBjLdaIdJ4JlZfUZmjkX3VV>
Feedback-ID: i8c5e488c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 13:57:22 -0500 (EST)
From: =?UTF-8?q?Mat=C4=9Bj=20Cepl?= <mcepl@cepl.eu>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Mat=C4=9Bj=20Cepl?= <mcepl@cepl.eu>
Subject: [PATCH] RFC: git-request-get maintainer receiving from git-request-pull
Date: Tue,  7 Jan 2025 19:56:35 +0100
Message-ID: <20250107185716.1562311-1-mcepl@cepl.eu>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This should be fulfilment of my comment on the GitLab bug [1] from 2016-05-01:

> Well, the minimal solution would be a parser for the
> git-request-pull(1), which would check every comment and if recognized
> the comment as the pull request, it would add button for the owner of
> the repo (e.g., [Create Pull Request]). After pressing that (so it is
> constantly under the control of the owner repo), gitlab would setup
> new remote (if doesn't exist still), fetch it, and create a merge
> request.

In the end, the best UI I could come up with is to pull all
commits to the new review branch and send all of them via
git-send-email(1) to the review email list.

The script can either receive git-request-pull(1) output on
stdin, or it can be driven by the command line arguments with URL
and (optionally) branch names for all those “I have some commits
on SOMEWHERE, but I don’t want to fiddle with git-send-email(1)
just because of that.”

[1] https://gitlab.com/gitlab-org/gitlab/-/issues/14116
---

I would like to get these types of comments (before I finalize
a proper commit for git):

* whether the idea of the script makes sense at all (or
  suggestions on the UI improvement),
* a general code review
* advice how to proceed with testing before rewriting it into the
  proper git test harness: is there only way to add those ugly
  `if test -z "$DEBUG"` constructs everywhere, or there is some
  better way?

Thank you for any reply,

Matěj

 Makefile        |   8 +++
 git-request-get | 186 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 194 insertions(+)
 create mode 100644 Makefile
 create mode 100755 git-request-get

diff --git a/Makefile b/Makefile
new file mode 100644
index 0000000..4d686f5
--- /dev/null
+++ b/Makefile
@@ -0,0 +1,8 @@
+export DEBUG := true
+export WANT_REMOTE := 1
+
+test:
+	./git-request-get < gitk-email.mbx 2>&1 | \
+	grep -e "ensure_remote: getting REMOTE = j6t and URL = https://github.com/j6t/gitk.git" \
+		-e "make_branch: getting BRANCH_NAME = mcepl-07012025 and HEAD = master" \
+		-e "main: DEST_ADDR= ~mcepl/git-test@lists.sr.ht, AUTHOR=Matěj Cepl <mcepl@cepl.eu>, BASE=c18400c6bb04f4e8875c1930db72ddd9b94649ca, HEAD=master"
diff --git a/git-request-get b/git-request-get
new file mode 100755
index 0000000..1f6edfa
--- /dev/null
+++ b/git-request-get
@@ -0,0 +1,186 @@
+#!/bin/sh
+# Requires: perl, sed, awk
+set -eux
+
+# Initialize internal variables
+DEBUG="${DEBUG:-}"
+WANT_REMOTE="${WANT_REMOTE:-"$(git config get --type int --default=0 git-request-get.wantRemote)"}"
+BASE=""
+HEAD=""
+DEST_ADDR=""
+
+usage() {
+    echo "usage: $(basename "$0") [-t ADDRTO] [-s] [-h] URL [HEAD] [BASE]" >&2
+    echo "Generate git-send-email messages from remote URL or from the email message"
+    echo "formatted by git-request-pull"
+    echo
+    echo "-t ADDRTO send emails to this email address"
+    exit 1
+}
+
+die() {
+    echo "$1" >&2
+    if test $# -gt 1
+    then
+        exit "$2"
+    else
+        exit 1
+    fi
+}
+
+log() {
+    echo "$1" >&2
+}
+
+parse_message() {
+    STR="$(perl -pe 'use MIME::QuotedPrint; $_=MIME::QuotedPrint::decode($_);')"
+    # Collect URL of the incoming repo
+    USTR="$(echo "$STR" | sed -n -e '/^are available in the Git repository at:/{n;n;p}')"
+    U="$(echo "$USTR" | awk '{print $1}')"
+
+    # Find the tip of the offered branch
+    # for you to fetch changes up to 102cd4d5c1818ecb5926dd538962f8b42c43b022:
+    B="$(echo "$STR" | awk '/^The following changes since commit / { print $NF }' | sed -e 's/[=:]*$//')"
+
+    E="$(echo "$USTR" | awk '{print $2}')"
+    if test -z "$E"
+    then
+        E="$(echo "$STR" | awk '/^for you to fetch changes up to / { print $NF }' | sed -e 's/[=:]*$//')"
+    fi
+    printf "%s^%s^%s" "$U" "$B" "$E"
+}
+
+ensure_remote () {
+    URL="$1"
+    REMSTR="$(git remote -v | awk -v url="$1" '(NR%2 == 1) && index($0, url) {print $1, $2}')"
+
+    if test -n "$REMSTR"
+    then
+        log "REMSTR found: ${REMSTR}\n"
+        REMOTE="$(echo "$REMSTR"|cut -d ' ' -f 1)"
+    else
+        # try to generate some good name for the remote
+        case "$URL" in
+        *github.com*|*gitlab.com*)
+            REMOTE="$(echo "$URL"|cut -d/ -f 4)"
+            ;;
+        *sr.ht*)
+            REMOTE="$(echo "$URL"|awk -F'[~/]' '{print $5}')"
+            ;;
+        *)
+            REMOTE="_4review"
+            ;;
+        esac
+        if test -z "$DEBUG"
+        then
+            git remote add "$REMOTE" "$URL"
+            git remote update "$REMOTE"
+        else
+            printf "ensure_remote: getting REMOTE = %s and URL = %s\n" "$REMOTE" "$URL" >&2
+        fi
+    fi
+
+    printf "%s" "$REMOTE"
+}
+
+#### main
+while getopts ":dht:" arg ; do
+    case $arg in
+        h)
+            usage
+            ;;
+        t)
+            DEST_ADDR="$OPTARG"
+            ;;
+        ?)
+            die "Invalid option: -${OPTARG}." 5
+            ;;
+    esac
+done
+
+shift $((OPTIND - 1))
+
+MASTER="master"
+if git rev-parse -q --verify main >/dev/null 2>&1
+then
+    MASTER="main"
+fi
+
+if test $# -lt 1
+then
+    PARSED_STR="$(parse_message)"
+    test -n "$PARSED_STR" || die "Not enough arguments and no message in stdin!" 2
+    URL="$(echo "$PARSED_STR"|cut -d '^' -f 1)"
+    BASE="$(echo "$PARSED_STR"|cut -d '^' -f 2)"
+    HEAD="$(echo "$PARSED_STR"|cut -d '^' -f 3)"
+# Ignore all command line arguments when stdin parsed
+else
+    if test $# -ge 1
+    then
+        URL="$1"
+    fi
+
+    if test -z "$URL"
+    then
+        die "Insufficient input: no parseable input or command line arguments." 3
+    fi
+
+    if test $# -ge 2
+    then
+        HEAD="$2"
+    else
+        HEAD="FETCH_HEAD"
+    fi
+
+    # find the base commit where PR roots in the default branch
+    if test $# -ge 3
+    then
+        BASE="$3"
+    fi
+fi
+
+if test "$WANT_REMOTE" -eq 1
+then
+    REMOTE="$(ensure_remote "$URL")"
+    if test -n "$HEAD" && ! git rev-parse -q --verify "$HEAD"
+    then
+        git rev-parse -q --verify "$REMOTE/$HEAD" || die "Cannot find $HEAD branch on the remote $REMOTE!" 4
+        HEAD="${REMOTE}/${HEAD}"
+    fi
+
+    BRANCH_NAME="$(git log --pretty="%aL" -1)-$(date '+%d%m%Y')"
+
+    if test -z "$DEBUG"
+    then
+        git branch "$BRANCH_NAME" "$HEAD"
+    else
+        printf "make_branch: getting BRANCH_NAME = %s and HEAD = %s\n" "$BRANCH_NAME" "$HEAD" >&2
+    fi
+else
+    git fetch "$URL"
+fi
+
+if test -z "$DEST_ADDR"
+then
+    DEST_ADDR="$(git config --default='' sendemail.to)"
+    test -z "$DEST_ADDR" && die "Unknown destination for the emails" 4
+fi
+
+test "$HEAD" = "FETCH_HEAD" && HEAD="$(git rev-parse -q --verify FETCH_HEAD)"
+
+ROOT="$(git merge-base "$MASTER" "$HEAD")"
+
+# commit is not part of our tree
+test "$ROOT" = "$HEAD" && die "Final commit cannot be included in our tree" 4
+
+test -z "$BASE" && BASE="$ROOT"
+
+test "$BASE" = "$HEAD" && die "No change observed" 1
+
+AUTHOR="$(git log --pretty="%an <%ae>" -1)"
+if test -z "$DEBUG"
+then
+    git send-email --to="$DEST_ADDR" --from="$AUTHOR" --no-annotate --no-cc --no-bcc --no-identity --quiet "${BASE}..${HEAD}"
+else
+    printf "main: DEST_ADDR= %s, AUTHOR=%s, BASE=%s, HEAD=%s\n" "$DEST_ADDR" "$AUTHOR" "$BASE" "$HEAD" 
+fi
-- 
2.47.1

