Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A9028B7DA
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 00:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785718687; cv=none; b=V57IBKcV0lN2SPal/sIfPs20IuBxQ0QjbC04yTucDKXMuCvG0veH9IkcHPaZevMNGlguGDnTpiwIcxEB8tsfPAdb2JB/9fbYXW7hewpLt9Zn5BI99JsH9ndixeNjotXoSmXBjUymgHaZ0ROjOcR/5ApRm4TpZ64lswSkbdgNB7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785718687; c=relaxed/simple;
	bh=qotJCK9G2JFmViuN7ZXnscIgkBOualcK+p69yNa6TM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d+qqwytLoiwkkDjQUjz0ooMLuIgmYprVmu3wArsqXbGcDC2+2nbWRdPjBJBWJsnLWaVlhYymWgsc0pSMYsesnQxdkW2Va3mcDiq1sFJX4ftvOTs41y0rcBL9D44LPrto+/TejLs4Q6Rxm+ajIV9eo04UbrS1H5WZW83/c9aa0YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h3cahd0U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DnX6PEVZ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h3cahd0U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DnX6PEVZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id DA1BB1D000AF;
	Sun,  2 Aug 2026 20:58:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 02 Aug 2026 20:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1785718683; x=1785805083; bh=OAzVMdTu04YNuEWVqnxly5xzfNKxhYj5
	Mk4qoc2WhlE=; b=h3cahd0UmZy44iuZeb+e6QBg1pTEINcMnG+5wjFWaOFSSZJZ
	m6fqLj6GIWlM9TeVrT9pJ+qY0l3ZUjVuwoPRG4gnviigalSNPJdnnydzdKRAmUZ7
	o+S3IYQPMVoRSXMLzD3SiMqDkDZomjkfwj+va5RgbrLXgtRLRZaZ1VEXTJdJfyEE
	7TlTUt3bQopTKDe8MjCaEs9GRT91nrSOTawt5/doVkE31sHayQ6xfkzT85kBuRS0
	DNSgnN70DF8vthMULgSwjjK5qdhV13Dg6zfRAo4IoP3jy8cOPHI5BDYFMbNHSnEI
	7x0ptacfrF4yyuk96jjGZ2/is9Fac1aeUtQc7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785718683; x=
	1785805083; bh=OAzVMdTu04YNuEWVqnxly5xzfNKxhYj5Mk4qoc2WhlE=; b=D
	nX6PEVZWeeK9Sz1UcL3fvlWzvCcsvyqjhiRNMsV4Up12BvJb+POR3rH8xoC7Riy+
	TRjf46ds4tWmiAciKXLJcKxkpdgY1aTW6FZKB/a4nJyhwphWnAXoeoUsTA9+eWJw
	xDdo8aJ6Up36ylyjcoyJIUdkNxGohhXwCX1uEUrzJO798tDkA5Mh3aljHJoQm7Ut
	BaAFCFjMR7vjI0LFFf4WJai1DOITZ90a82Evop5deS7VVk72b7HaSGaArh00bZHs
	TsnEwVDqdFI6zhnaZxPMuf5Wa0+UmmHAshxOet2LTEJW8DNiqP9nj4izMq/Dyk0x
	YCmDPkoJf62Wwsw3CiTsw==
X-ME-Sender: <xms:m-dvaq0yljxqgeqVSGENMK7Eou_ehth7s5IRezfbRVN7vc_5x_Fxyw>
    <xme:m-dvavUFxXkgCpEdSh2zWJHXCRDfXqZPYfghkcpca-i4leIGmw01vlA2aRH_sNQhw
    eiD9EEVQAlwLk_0zivFedqI4Fcpe56Tq4PtMl98Q645uhbIDLY2Ric>
X-ME-Received: <xmr:m-dvalKDXbvMfCxUhCieR1mIG_aYhy3VHszpcR4iHzrdwLlBEofn2BGyVPBil-medBoC21OahXd5-inoIEZRdLqHQ90cn_mHoQ>
X-ME-Proxy-Cause: dmFkZTEdZ/Ni3ndKf68fgKbXWlOBPq5cMN7A/nWHbcaiD1tNv+kjT6W3PY7LDhN7xgWCGL
    PVcPFv4oZr50kuv+KbJdYVDlvqGx1OgA4VSdE3ysTWiQ+dxt7sJJWggs1KZQ3jHSgkmbHo
    qt5npqr682wURWb6fhxwz30cRmwY/vmPqHHY5pMNXC4SvXtRPQq6u6FJ5mg69uORoiwzBs
    qXKPhYzUXDJS7V1Ur3IEuR49cvnMdBgtjaCQZxWxEQR8eAsaIjKqHj6LeDusRZjENYz9EK
    8PPzMKDtp1sHILEC7AH1SoULdLm4DjJCCdfNudn04o19ESp2uHRpO4dSU9yCAfdosTUxgR
    3dA/LJlEsW1HCZERbSSePPavxP09l6DtdEG2rQnAceX7BYwEyW8p3ZxMa7e2WeFMFhMDrv
    qG04JVFl35ENxd/g7fzytwsdfiCJ+jK9S1Z+lPJ/I5lHnnbjQ6xPGRjj0oVp2XlZUCtGRt
    QL6sw+4vknEu476nyqyvUQe+GtYQeEBxX8UZ4eq2PLUpAOGKRhkNY0qeDMUAIiOSm3sx/Y
    FdHdsC/Ij7jRK8qIlKEsraVREpn3ROD6P0yGk/7mML/LGftEx7uT+jtSuZTt3zX3KVom0R
    +zsjuYCzfmwkjfjiB4nTZXzp0rqhSz/PcZJAzF/y4dhFL/GKV9h6Ndbhw5cA
X-ME-Proxy: <xmx:m-dvah0EFIVP9dIFo4o-Kaye17u3Eo2B-UhSTfG15FbZ2tp9Cv5kUQ>
    <xmx:m-dvar6iqN0VLM9cN_s4oR86uDMM71UxjVHaerDbiUZwYeKU9nU6Xw>
    <xmx:m-dvaq9eeQCvc_XOm2hTqb1nCjIBYHxpRWtqCI3KzQjW7OwNn4mtWg>
    <xmx:m-dvaiXm7L0p9IuUd5usgxeeTaXAUGc7uk3zs_TYY0V-A9dmU1f37A>
    <xmx:m-dvarKjnGSfjE6ZTJuhdqWftNnjwJF0ctDlkcz7JtU_Pla6g2o-gpch>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Aug 2026 20:58:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
    Britton Leo Kerin <britton.kerin@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
    Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] completion: complete tracked paths for 'git diff'
Date: Sun, 02 Aug 2026 17:58:01 -0700
Message-ID: <xmqqcxw010me.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

When completing arguments for 'git diff', _git_diff() delegates to
__git_complete_revlist_file(), which only completes revision
references.  This is good [*], as mixing both revs and paths in a
single list to have the user pick is simply too confusing.

If no reference matches, or if '--' is given, however, _git_diff()
leaves COMPREPLY empty. Bash then falls back to default filename
completion in $PWD. This fails when 'git -C <path>' is used because
$PWD is not the target repository.

Update _git_diff() to use __git_complete_index_file() when '--' is
present, or when revision reference completion yields no matching
candidates, so that tracked paths are offered as candidates.

[Footnote]

 * In https://lore.kernel.org/git/al%2Fw2qgBfhe9qMg6@szeder.dev/
   SZEDER made the same argument for "git send-email 0<TAB>".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is one of my pet peeves that I have raised a few times on
   the list but nobody reacted.  So I did a "monkey see, monkey do"
   patch without deeply understanding what is going on in the code
   paths.  When preparing the CC: list, I pulled a few folks, some
   very recognizable, some not recognizable immediately by me, out
   of "git shortlog --since=3.years" on this file.  The contribution
   by any of them looked more expertly done by whatever I did here.

   The use case is that I have a checkout of the 'todo' branch in an
   untracked subdirectory 'Meta' in my primary source tree.  I would
   do

    $ git -C Meta status wh<TAB>

   and it completes to whats-cooking.txt just fine, 'add' also adds
   it, but 'diff' dies not work, not because I have refs that 'wh'
   completes, but because bash completion is unaware that I want
   paths completed in the other directory.

 contrib/completion/git-completion.bash |  8 +++++-
 t/t9902-completion.sh                  | 40 ++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e875787710..8f5773292b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1947,7 +1947,10 @@ __git_diff_difftool_options="--cached --staged
 
 _git_diff ()
 {
-	__git_has_doubledash && return
+	if __git_has_doubledash; then
+		__git_complete_index_file
+		return
+	fi
 
 	case "$cur" in
 	--diff-algorithm=*)
@@ -1976,6 +1979,9 @@ _git_diff ()
 		;;
 	esac
 	__git_complete_revlist_file
+	if [ ${#COMPREPLY[@]} -eq 0 ]; then
+		__git_complete_index_file
+	fi
 }
 
 __git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 55dc9eabfc..eecd53f097 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2663,6 +2663,7 @@ test_expect_success 'setup for integration tests' '
 	echo content >file1 &&
 	echo more >file2 &&
 	git add file1 file2 &&
+	echo untracked >file3 &&
 	git commit -m one &&
 	git branch mybranch &&
 	git tag mytag
@@ -2712,6 +2713,45 @@ test_expect_success 'git -C <path> checkout uses the right repo' '
 	EOF
 '
 
+test_expect_success 'git diff completes tracked paths when no refs match' '
+	# file1 and file2 are tracked but file3 is not
+	test_completion "git diff f" <<-\EOF
+	file1
+	file2
+	EOF
+'
+
+test_expect_success 'git diff -- completes tracked paths' '
+	# file1 and file2 are tracked but file3 is not
+	test_completion "git diff -- f" <<-\EOF
+	file1
+	file2
+	EOF
+'
+
+test_expect_success 'git -C <path> diff completes tracked paths in specified repo' '
+	test_when_finished "rm -rf repo-for-diff" &&
+	git init repo-for-diff &&
+	echo content >repo-for-diff/otherfile &&
+	git -C repo-for-diff add otherfile &&
+	echo untracked >repo-for-diff/oops &&
+	git -C repo-for-diff commit -m otherfile &&
+	test_completion "git -C repo-for-diff diff o" <<-\EOF
+	otherfile
+	EOF
+'
+
+test_expect_success 'git -C <path> diff -- completes pathspecs in specified repo' '
+	test_when_finished "rm -rf repo-for-diff" &&
+	git init repo-for-diff &&
+	echo content >repo-for-diff/otherfile &&
+	git -C repo-for-diff add otherfile &&
+	git -C repo-for-diff commit -m otherfile &&
+	test_completion "git -C repo-for-diff diff -- o" <<-\EOF
+	otherfile
+	EOF
+'
+
 test_expect_success 'show completes all refs' '
 	test_completion "git show m" <<-\EOF
 	main Z
-- 
2.55.0-607-g47e9082d35

