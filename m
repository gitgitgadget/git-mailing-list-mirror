Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39EA377000
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 01:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786066733; cv=none; b=Wjd20mGs2pkZFbI6t8/W9GiYE/V70j8hU/Enx7hwo4KPDTFhl7DBLVbQXgU37Jf5iyGg/CQi69GQzHpt/RKN4MmND2KQMHnb4y59W5ff+Y5Tk8/CQc8zCnmSanOpTqEXlLATKAIhpDdHyxQFR0+gcPqBFMgbTPqV4nKVBfTbRi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786066733; c=relaxed/simple;
	bh=eDgEXonGgnarlr6ehirnk1HH7LwaNW/BY6nvf90ZOMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=br5gVh+4ZgjQc3dajhDoQuO3hGb2B8r5VtkMF1M0hAoyBNJdt/A+Nqc+dG98LZTUj0peegIHj0TJYPXAbc35DRALUjq5AQoomC3dWumrIZPri1zbM7GNgXJHntoxKA3d+JSujwdpbGssART9N/R1TZ8l166oT4FZql/1R6yFI8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jscbKSZu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gEYc5X/G; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jscbKSZu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gEYc5X/G"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 74D731D00099;
	Thu,  6 Aug 2026 21:38:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 06 Aug 2026 21:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786066718; x=
	1786153118; bh=ivmE6RUeM1wbEn04JZywSMwGk0uUMYo6FR0BDJ4UuIo=; b=j
	scbKSZu8DYXRXgShX0axvsPVxN8LoSAuVmBUsYGDb9uwZY295+QY3i+cJkL1EB9j
	CXs8yNe6gwM6INQaPQcg2l+S+Gdbxza8SMHPt66Lv9xHwJ5voCFB+NUxtlebhqoX
	1KEQQwN8QJC5Yq77Nn4hx77lfRD9hqggj/arMmghtGPQP6tDR9i/BW8Jnmo2LV2i
	U/RuMPS8K//ofW23v1Z8rPLGAZTJcVqLcEGz4TRyiMKYtx5OCgYQi9Aj7eRW7eTW
	6ZkVw7631R2uGac9kxdcQJAoVjMRSwIqsxWD3gC7Cv51AhNC+7l1olf1+9adWwI+
	f8Vz1XC7TlW1+tjqbeEDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786066718; x=1786153118; bh=i
	vmE6RUeM1wbEn04JZywSMwGk0uUMYo6FR0BDJ4UuIo=; b=gEYc5X/GwN+aoooZt
	utztckxlsK5j2rC4V6oVxApat/1Z1ojoZFHTBDRWq0U18WkkVXW+J8zxQWjGs4jP
	seP8+uLVeXYKbk5lrP8RjN/9AB38z48CCg6iCAopUObvoSFgBxnGDIoNK0p59UqY
	lBgr/VTR987jhMZuBZOfNcncxJPVvXSq4xQGZjIDf3zo4anHt7g2yUTXqiGzM7BO
	WhXrwq/ouFRu+XbkBGTHCy88Z6RdbmSRQOzQ1zOcVzoUxTcygNW82MzdlgzLK0DW
	uC3J43jfxLGYXZA+iYsinZi6aQbwCKAchwr2/OQzXzGhxU78teLrZfylOq/pvWLi
	X/DUg==
X-ME-Sender: <xms:Hjd1ai8Pzokf7zfWtZ3EKvOspmwbr4CVYOkx6484-ra-CB7iFQ4xIg>
    <xme:Hjd1avmF0hYcHz1x1NU2JvqxXGniqvcJcPhPnh1EwPVyUa8qzsIXjrDbEsqiS1ZNu
    5iSXJDhW-DzF8rUlzcATdE7Lqt-JmEOxgUx_uiHpS3Jxj8yi5LBVGI>
X-ME-Received: <xmr:Hjd1anx2GVlxxQQ_Blss9to8ZL0lqwViZOuZhtvs1XSN4hkOIQDdSDJPn_OfvdRQqj4jDqhVxRMwFCsDZgdcF4UcvbObFuq50w>
X-ME-Proxy-Cause: dmFkZTFq7MzKWLxG+4X43Fk1A+9+V44cVi14HmRnlZI3MPpq0IXmpruKrxVv3EBIxIBKPP
    jGWkcZ1SfvzfgAZqhyYXPJhiexxo4v20CG8uf5ATK5plYBugOG7rVR9zbDzeeQ06XeAZ3c
    2xIJvlyaLhvEmLOoJVwNI1e9Eih3SPcNk+clOEydmVRIe09dtZs3cRi6WsO8rRs0leHQJh
    h0CD+jxxGRxSHYDfyAe4OoJPtMxecAcr0vz2jF5EWiuoyarsJe9bl9xfK7cGU+kvOkJLQr
    2xQfrEoMlwoHhIGtRjiKLNC9/olDxKb9Ai3/ZlxO1afrgzsIfdkKaWB2MkyVyhPZ0EiXRc
    8X9bAi2PgIqX41Hx3s4WQIa4KXKrhb5Wf3uwM4YIHnRTu+WkMSlZN6So5hk46AK009xnix
    7FsjIBQ47Ntxei86bs1Yy23/dmDc4Lajjuvrixu++XAKfuKbNiLcCpsyRB7sGh0JuvuZoP
    2jEZxD0Hf/ujTw7qkgNEdwcEaMqeQ3Ydo5vQiYqu6KAUJAZxjUnNZnbQyUK7XIULzp0DKg
    AjD3ZHpLSGmoEA3WPHGm9NV/oTa38oEt4Hb/AgkFg+7g5J+SJyD6ZTyYeFGdDrnGAuWZq1
    kfQlxAu4MzryG4YjlMp4iU1zei21qplGGI/ujdkCPzcnpP4I2ELmrIj4DnEQ
X-ME-Proxy: <xmx:Hjd1ap4KGxTLSlNkM2oenBund_8MBFQnYKFc5ntVyvwOKYsSSuVW0w>
    <xmx:Hjd1anUvV7qdNFTxi2E1q0zOHMFlLbQUzs-P7ZoxV-O0NftO2UzqJg>
    <xmx:Hjd1ahJPpaqzKJ2jN3TGb9G5Tz5OwlhFJIUszuab0vMaVqs4iMpt0g>
    <xmx:Hjd1apu90CUUh18oL_MYxv4lpKj183E_1WGnNpDhQwM_hD4J56HxqA>
    <xmx:Hjd1anfuCmgYDqr5tspUmmjlfZCCIkXQFzPHWP1YdIIHH0AqtGoYIpsc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 21:38:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
	Britton Leo Kerin <britton.kerin@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 3/3] completion: 'git diff' completes untracked paths as a last resort
Date: Thu,  6 Aug 2026 18:38:30 -0700
Message-ID: <20260807013830.698340-4-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-655-g8b87133eb9
In-Reply-To: <20260807013830.698340-1-gitster@pobox.com>
References: <xmqqcxw010me.fsf@gitster.g>
 <20260807013830.698340-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We taught 'git diff' to first try to complete revisions (unless '--'
is present on the command line) and, failing that, to complete
tracked paths.  If this yields nothing, it lets the Bash default,
which offers paths in $PWD, kick in.

Teach it to complete untracked paths before giving up and letting
the Bash default kick in.  With this change,

    $ git -C another-directory diff un<TAB>

finds the 'untracked' file in another-directory and offers it as a
completion candidate.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash |  4 ++++
 t/t9902-completion.sh                  | 22 ++++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 845fd19f70..7741789e41 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1985,6 +1985,10 @@ _git_diff ()
 	if [ ${#COMPREPLY[@]} -eq 0 ]; then
 		__git_complete_index_file
 	fi
+
+	if [ ${#COMPREPLY[@]} -eq 0 ]; then
+		__git_complete_index_file "--others --directory"
+	fi
 }
 
 __git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index adfaf414fd..eea4bdbb7e 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2664,6 +2664,7 @@ test_expect_success 'setup for integration tests' '
 	echo more >file2 &&
 	git add file1 file2 &&
 	echo untracked >file3 &&
+	echo untracked >ufile &&
 	git commit -m one &&
 	git branch mybranch &&
 	git tag mytag
@@ -2726,21 +2727,38 @@ test_expect_success 'git diff completes tracked paths when no refs match' '
 	EOF
 '
 
+test_expect_success 'git diff [--] completes untracked paths, too' '
+	# there is no ref or tracked path that begin with u
+	test_completion "git diff u" <<-\EOF &&
+	ufile
+	EOF
+	test_completion "git diff -- u" <<-\EOF
+	ufile
+	EOF
+'
+
 test_expect_success 'git -C <path> diff completes in the specified repo' '
 	test_when_finished "rm -rf repo-for-diff" &&
 	git init repo-for-diff &&
 
-	# otherfile is tracked, oops is untracked
+	# otherfile is tracked, oops and ufile are untracked
 	echo content >repo-for-diff/otherfile &&
 	git -C repo-for-diff add otherfile &&
 	git -C repo-for-diff commit -m otherfile &&
 	echo untracked >repo-for-diff/oops &&
+	echo untracked >repo-for-diff/ufile &&
 	test_completion "git -C repo-for-diff diff o" <<-\EOF &&
 	otherfile
 	EOF
-	test_completion "git -C repo-for-diff diff -- o" <<-\EOF
+	test_completion "git -C repo-for-diff diff -- o" <<-\EOF &&
 	otherfile
 	EOF
+	test_completion "git -C repo-for-diff diff u" <<-\EOF &&
+	ufile
+	EOF
+	test_completion "git -C repo-for-diff diff -- u" <<-\EOF
+	ufile
+	EOF
 '
 
 test_expect_success 'show completes all refs' '
-- 
2.55.0-655-gb2c071042d

