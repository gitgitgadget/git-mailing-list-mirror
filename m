Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E8472F73
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860551; cv=none; b=P2RtJv5/j0BX8Ou/jbs1j3zAm+DKrOCjcNSxQCx9pXXkGROMBBhtvrUHeUWVKtEgee22RW1juDe+pl0lB93gTRp+1bNDIyY8EhSvPeuR9pvjlHpUWBnPDlyyKX7e1hfT8G+c/1DsidnjBoJk4e3c/zmAjdJUWcfQXpIocOCNoHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860551; c=relaxed/simple;
	bh=d5Lqw++fvwV+AureYXsK19FADQdFHrVTarpK/xukU0g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XYctzTab1ZHofwSHl1XBqSH0k0+rzHm0WV8Oqiq3laRWffXu5dJWAaYbCywzlxifBG4aTaMvLvzTp+u+ZODfExYLQhVk3wGXAF4eun7gbUBDafgbFJmO2wNF2LwfNEyhrC/LJ7hnFVCvzP7AqbcFUl/Ru9+juFs98ZvAggEkQbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TP6WZmW3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DBqUWO46; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TP6WZmW3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DBqUWO46"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 243A81D000DD;
	Tue,  4 Aug 2026 12:22:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 04 Aug 2026 12:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785860547; x=1785946947; bh=HuexXrqQ5i
	oPapTSn5j/kkcFhhAoaZvikep14AUOXKk=; b=TP6WZmW3utHSF65jP6KfGOaFXh
	aPBSMj/8V+t5MGOpcpjzk8/Cz+EqxnDv+ZHLGFaZtL6xNh7cBiNePuAPGVndehc2
	XKQn9lXmonCX52HdjeoJpEfE97Xy1SmFCNsEj+BSTB50vXivOz3gu1afBAqQ/wuF
	jZoYU1nPw/Wo/zoRHO94BXlk3DfqdEM+IMxptWdKnuA2GD0M5qJJx7yjzMlzByQ4
	JfhRjQABpvzoMvGiwXsTLc7Lv2NRV+Z3iaihJwihtQt151SG60jW4Z9dE95ypZQB
	z86lZ08BJYDwoDQM1GzovNXOuzjV7hV33ei0uFwUn6F65siJicZjXo7jtveA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785860547; x=1785946947; bh=HuexXrqQ5ioPapTSn5j/kkcFhhAoaZvikep
	14AUOXKk=; b=DBqUWO46nE0W8jwpV5fL8lbvJfEFqL94XV/HVgOoOjYya4UPoUn
	iw8wtwB+fTB3y5owrOf89OAEvESK5ilnZyyx6PZuU9WAbsAwAvmKtqZ/sMz4ncSY
	py0D5bYTEtG1TPWSq2yrAjNSaKuSs/eu0jsJx4zCtmdU08XMYmEStKfvGiMKkfSG
	lM+ggjELLQQZWtfOBeR/B16TqhOkq8boUcQwKKSc9jeKik/PgE8fnsanmGWoFcle
	DvNDx2ackls0EbKwsCbasX8GSJocNUQoOFCTNSx7dRMLcLa2a8Mv6x9R39ALiid4
	tqJHMPqAzL2yoaOXHwN3feoK+VL9MRd1bKw==
X-ME-Sender: <xms:wxFyarq9U8-I6rxQqsawRyf5YVsvTD8nhb8BMYxWtFCxShawbmL7IA>
    <xme:wxFyan7oYrUZLmUwvvEgjxU83_lTbqd4R2vWKjTWDXD79Uu5xA69oYd-49No7HBZE
    wXSdRba7Udg26voShB-N_bPbPRFS9USyAAj8gkfJOFHUjNnBsY1hDA>
X-ME-Received: <xmr:wxFyaqcNaps7gcO8hG0jOW8uz6WIKE79v5ZayY-_KzJtAlKgPmKRGbGF3LkWDyWujfyfwBKJpj0Xlyfkg1DFBV4KpNmiacW3xg>
X-ME-Proxy-Cause: dmFkZTEDj+8H/o9eoLslkmcmPseaMAH/AMTFNQON5n4137UyeKdFoGK1xOff/SOAnGWEsF
    /vaiLl75I79Lia3npOLkt5cFN1mAqg4H5O1MLVgTThW8RNhyNhAZENkGXcJlWmtdf/5Qlr
    68Pgvz0MgxZJIDVrYscgEp/VBxgCMB9GIMF78xgcMQdzA3cRh8YZjYwj2kPDnEd4rES/tS
    q+Tf5ZmApWMQ8g51dGkKARJOP+i/t/gOWFzL/1sYLMOHJiih9morQubJ2E+VMGv/o30aDI
    2wjwjBPh3cW9+Q4Mnl57IodRPgNnPUox6ACCMiAIXyjWciXAJmFFU4kGoqUDeCbnjNlajO
    raIW6dUgQ/kwNGxAKIVQvrT3zBTJPv0+VVKeO1a8j8dYrVxbwCuLWTtL1fw1SYvXDTdwH4
    1daur9oUm9zXqzzt+vc4i9YV/Wmv3sF4drfAZj9V3QDwA1yu0RNqww9Hr4S4Zme9aVMP39
    6bKRKpCKmtDTsjgrpw4zBDADkqz6VNdQDYpuo+BD93o4N4KlP3G+McYQKqFYaCdRyaXqyv
    I6Vy91AX4wFv4vFXwE6IZ1ehl5aeSiV1z7KotC8vxNKR5aFDyFJ6305TlBxT4pufTlFVOR
    py7q+ELgtx7DqrzHzFtQ/3wA8WvKTabpIgTohb3cfm6I433zysTDHlkUNqRw
X-ME-Proxy: <xmx:wxFyak5ID2sAqQ6Znfwxax4knJru_tNbwIv_TqZgK9BdJP_T938nkg>
    <xmx:wxFyapuxFOQA2O0YDqOKlEbDBTLcNbA6Rok5jLHxDloNY-VmycI0EA>
    <xmx:wxFyashAkiuW6yg_lJrIyLbKBzgwtqHyumRzQCB7_grfj85FAK65vA>
    <xmx:wxFyasqgs48abUVWyjpiEHhCNscXX68qExA3XebCaA2ijlFOY0-P7A>
    <xmx:wxFyagu_Ik-RGCBNg5MHCfMyDRh2xNxPrtPv4Q2nsIPJCiV-aKy6LeE5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 12:22:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,  Britton Leo Kerin
 <britton.kerin@gmail.com>,  Elijah Newren <newren@gmail.com>,
  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2] completion: complete tracked paths for 'git diff'
In-Reply-To: <xmqqcxw010me.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	02 Aug 2026 17:58:01 -0700")
References: <xmqqcxw010me.fsf@gitster.g>
Date: Tue, 04 Aug 2026 09:22:25 -0700
Message-ID: <xmqqfr0tx3cu.fsf@gitster.g>
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
references.  This is good [*], as mixing both revisions and paths in a
single list for the user to pick from is simply too confusing.

If no reference matches, or if '--' is given, however, _git_diff()
leaves COMPREPLY empty.  Bash then falls back to default filename
completion in $PWD.  This fails when 'git -C <path>' is used because
$PWD is not the target repository.

Update _git_diff() to use __git_complete_index_file() when '--' is
present, or when revision reference completion yields no matching
candidates, so that tracked paths are offered as candidates.

This changes behavior even in the case where '-C <there>' is not
used.  The new behavior omits untracked paths from suggestions when
no revs match the prefix but matching tracked paths exist, which is
more useful in the context of 'git diff'.

When run outside the working tree of a repository, or when nothing
matches from revisions or tracked paths, Bash still falls back to
default filename completion in $PWD, so such a use case would be
just like completing paths for any 'diff' command, rather than for
'git diff'.

[Footnote]
 * In https://lore.kernel.org/git/al%2Fw2qgBfhe9qMg6@szeder.dev/
   SZEDER made the same argument for "git send-email 0<TAB>".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The last two paragraphs in the proposed commit log message are
   new, to explain why the code posted as-is would be sufficient to
   support the "'git diff --no-index' is not Git but is diff" usage,
   and there is no code change between v1 and this iteration.

   By the way, I, as a relative newbie to the completion script, had
   trouble with the test_completion helper and wasted some time
   wondering why an additional test:

    test_expect_success 'git diff completes untracked paths if  nothing matches' '
	    >untracked &&
	    test_completion "git diff -- u" <<-\EOF
	    untracked
	    EOF
    '

    did not work, even though under manual testing, u<TAB> completed
    'untracked' just fine.  The reason is that test_completion
    does not test the final "Bash default" fallback.  It might not
    be necessary for those who are familiar with the completion test
    suite, but I thought it would help others.

    This message comes with a range-diff that shows only the commit
    log changes.

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
index 9ae3c48ebd..82488f3b50 100755
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

Range-diff against v1:
1:  100043822f ! 1:  fa4461a192 completion: complete tracked paths for 'git diff'
    @@ Commit message
     
         When completing arguments for 'git diff', _git_diff() delegates to
         __git_complete_revlist_file(), which only completes revision
    -    references.  This is good [*], as mixing both revs and paths in a
    -    single list to have the user pick is simply too confusing.
    +    references.  This is good [*], as mixing both revisions and paths in a
    +    single list for the user to pick from is simply too confusing.
     
         If no reference matches, or if '--' is given, however, _git_diff()
    -    leaves COMPREPLY empty. Bash then falls back to default filename
    -    completion in $PWD. This fails when 'git -C <path>' is used because
    +    leaves COMPREPLY empty.  Bash then falls back to default filename
    +    completion in $PWD.  This fails when 'git -C <path>' is used because
         $PWD is not the target repository.
     
         Update _git_diff() to use __git_complete_index_file() when '--' is
         present, or when revision reference completion yields no matching
         candidates, so that tracked paths are offered as candidates.
     
    -    [Footnote]
    +    This changes behavior even in the case where '-C <there>' is not
    +    used.  The new behavior omits untracked paths from suggestions when
    +    no revs match the prefix but matching tracked paths exist, which is
    +    more useful in the context of 'git diff'.
    +
    +    When run outside the working tree of a repository, or when nothing
    +    matches from revisions or tracked paths, Bash still falls back to
    +    default filename completion in $PWD, so such a use case would be
    +    just like completing paths for any 'diff' command, rather than for
    +    'git diff'.
     
    +    [Footnote]
          * In https://lore.kernel.org/git/al%2Fw2qgBfhe9qMg6@szeder.dev/
            SZEDER made the same argument for "git send-email 0<TAB>".
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    ---
    +
    +     * The last two paragraphs in the proposed commit log message are
    +       new, to explain why the code posted as-is would be sufficient to
    +       support the "'git diff --no-index' is not Git but is diff" usage.
    +       I, as a relative newbie to the completion script, had trouble
    +       with the test_completion helper and wasted some time wondering
    +       why an additional test:
    +
    +        test_expect_success 'git diff completes untracked paths if  nothing matches' '
    +                >untracked &&
    +                test_completion "git diff -- u" <<-\EOF
    +                untracked
    +                EOF
    +        '
    +
    +        did not work, even though under manual testing, u<TAB> completed
    +        'untracked' just fine.  The reason is that test_completion
    +        does not test the final "Bash default" fallback.  It might not
    +        be necessary for those who are familiar with the completion test
    +        suite, but I thought it would help others.
     
      ## contrib/completion/git-completion.bash ##
     @@ contrib/completion/git-completion.bash: __git_diff_difftool_options="--cached --staged
-- 
2.55.0-624-gcdeb5fd34c

