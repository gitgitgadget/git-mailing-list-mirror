Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268E53EDE56
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785958979; cv=none; b=dco6Z16wdSSX/aLs1Tf1jtOO7uyPMyzKtDcchyZCuRdKu0FFFybsKQIXqCC8+g4xWnxxyqn/04wTekkAEPtCocjjtsZzh9hI6KKXH4Knq/QLvpqhBhLN8afx/RPUiuR9xflqEEI9SSEZG0bhEmOykx+eCn0N+GFJDA2UTbhKbPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785958979; c=relaxed/simple;
	bh=okfuNyYGe+LbqszBfC7HkGpGvqRughJHbrE5NrlB5uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cclH3u6k/RwROIzxppIY/OPJELKP0Ik79EHU7O2Sgqd1ln/BMfvUwNSRXArwGhbh8C3vmgDZMOoSE5GxpyA5Cm3xJjM/lP7ojM6iBID3cLolimM/uCOa9CvOkJDxN3nsW4Msv/aVYUCVQJi6mIfNWF5PxMLfO6WtLDsA/LptzC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vveHVD6i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WbYiO/C4; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vveHVD6i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WbYiO/C4"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 44F081D000CC;
	Wed,  5 Aug 2026 15:42:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 05 Aug 2026 15:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1785958977; x=
	1786045377; bh=zSiTnpbQ9YRk+UyRaa9Hxl7fRXmPdfuBm7lsH0ouvjE=; b=v
	veHVD6i56jS5lFCDNg2W/DbnvcbiimJ92+wyM1sehQDrMajAYoge/SpBIXVVqstl
	WgM32cndK87rF43XwZyyPuXBjOFwGvL/eC9ANgNY0zj7SmihMZd0ladmZ3dQ04lD
	3c0X2On6EGeQsjxXGS42bqndzAbtWP1pUIBQuwNvSNGSQaUcAXT0R/CwVn45wV5S
	EFCd1iUR4JLkd4/tkOMMWX+9Y/qKSFHPZJ0+bCbyhNaFLQk76AsD/nKXfGqq64tA
	Nw2+swn8Tg5dvSfOjdGMWR/kjAeuzZx6eVWlWDn97ehpfSaufxGEPQ+N3PzvASIy
	jYzlTLljv2bbalB2asDpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785958977; x=1786045377; bh=z
	SiTnpbQ9YRk+UyRaa9Hxl7fRXmPdfuBm7lsH0ouvjE=; b=WbYiO/C4L4AK4KoVr
	ziRJ2JX7uFrttrYz0/hbcgWI0yT6audOB/D3YVvo1ZgCvMpQk+bD3roKsW4xVzLL
	U4EURsZjk+N1v7MO1t+mrVAbknqIgzwecQNfvSZ4KFA+uhTkeMJuuVCHmsO0g01E
	Pb5HQ34OyYH+ZcwZ97e0EvovEQ5cOZCFiRA7xhuDKJLxBYSjmDnRYIDYuEtIU8e4
	UggTvdcfJOPowRlFZEcK7VkZrq2mDJx53w7vIFW6euGZ0WBv7lkgxxC6uqbHvD0M
	v7gJwaOyM2LSIOQcOpi0VbQYKWLzs9w+aUdpYWJH/VQdQCUzf8VzqKewzz6VxJwi
	IXA9g==
X-ME-Sender: <xms:QZJzaphq9cLiJio-txBS0_WKSF34us7CkIZ_159u0_dEeG7VK5DFNA>
    <xme:QZJzatHtyyJM-v8xVcVJDm8D4RLjKrVsAYYxhPDXod-WSNcnDIiVxNGGEVfP5blri
    8vmLQe7MPLB1Ms-pqv1Fqt0t0RJlQU7mAjSM9ElLEdV_m7UHeyu910>
X-ME-Received: <xmr:QZJzavTFthbaDjHph6xcx0-13EhpKz2uBUQMyup9x3TrmmiZGp70wktU5-meRKGCaG7INJnmyII1ZXthzK8nLsGAivCG3cFg3Q>
X-ME-Proxy-Cause: dmFkZTGm9QyF7bXjndb2+u/OpjiG/kK4FbHStejrxzvJIY7hJu/+Tb9pMI282mIFoD0vA5
    hcRP3Uu01648yTvf0u76zmhs6Y7x3GKEC/UOOMcbhGrMZPLP4AeBhPf1IXo0gIyDWYfk7T
    /FWIHjmQFk+Z/w14tpHusKF1DB7l7V3BaVsnKSTTVjZZEDe2As5AH1iAjlntBLQ/Dxt5i8
    upUaC+/t/Uh3Y/mnkuX9jHISw8ppMriO5qBTZpq+l//CW+W05AQYp/hGZEmwwZfL/WhMdA
    PIKMjAm7fgRgNF6fwwQ0PLpMXIkjSgETvqs76eatqaGcpd2VVPNR6ghm2AFusrZWt8Yjh0
    hLhtOdlxnVnGEMAKYKFwAY+chogewMr7ErP7s9XS6ZijtX3wBoaAMHXxZ5/hbKyyWpYG2P
    8CmZAvyAB424X+lhXzeMBQCPiwJcHAp24isKX+TlWwUG2hDOtiMuZp6SHITlDmt+MrfrAQ
    EMrIsM3C53zgqCiB7sS/n1y+/NG9ARrQv44uAhnEXBrsH5uAV0hhZIk1DucTCMwbfrm+5y
    iOI/9KWpDMjcRBOBTeO9xbXotAC5Zitx9bWGBkb/jJY6gxvo6iLtjg6dOxgUA5NthpowMc
    19iVaM2H+mbB8LllavKVYz/KeJElMxMcswJR3k0gVjPLNRkuhAJ4mUFTcEuw
X-ME-Proxy: <xmx:QZJzaqyehGu50QQzVu7bOpmTENiH-ecxOzpqNxwtwOX1vOz9b-zvxw>
    <xmx:QZJzarel1ITZjINtZOi1m-9mMtvtTc8oUM0AsIyorkrrEY7-cg6rmg>
    <xmx:QZJzatP22PJe79YEpjwAlNkjGgCCjbzZPay6csLFJabnHF_rMycMSg>
    <xmx:QZJzamv6aVuRFZpQRt5FukJTSZ4vryWIs3RD7o61VZCDJLGaeIJbsA>
    <xmx:QZJzasXM63JPo10oBDHLkdkGJNwhzrrb9kC-BCYyQISfFrfsYNkmZO_i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 15:42:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
	Britton Leo Kerin <britton.kerin@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 2/3] completion: complete tracked paths for 'git diff'
Date: Wed,  5 Aug 2026 12:42:49 -0700
Message-ID: <20260805194250.3316220-3-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-653-g9745b9777e
In-Reply-To: <20260805194250.3316220-1-gitster@pobox.com>
References: <xmqqcxw010me.fsf@gitster.g>
 <20260805194250.3316220-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 contrib/completion/git-completion.bash |  4 +++
 t/t9902-completion.sh                  | 39 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ccd3b2a372..845fd19f70 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1981,6 +1981,10 @@ _git_diff ()
 		esac
 		__git_complete_revlist_file
 	fi
+
+	if [ ${#COMPREPLY[@]} -eq 0 ]; then
+		__git_complete_index_file
+	fi
 }
 
 __git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 55dc9eabfc..10ac690e21 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2712,6 +2712,45 @@ test_expect_success 'git -C <path> checkout uses the right repo' '
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
2.55.0-653-g9745b9777e

