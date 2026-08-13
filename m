Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3765422540
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648362; cv=none; b=Ff+qvb3U5hecSOkRHYxEwvyjEY/oLW6BN0WvkBxoTuytsj3vrZli9Ft7ENMq/8ItVJR1z5qAEIPnuX6XbqSIbOcmC8UnIv6pLCZmFMGcBItNOjYI4mugF2/1gEqduK5G0TwiqjrfA3ZNLIuIOou2A1AV0XTj6FOrlz1W63nENbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648362; c=relaxed/simple;
	bh=KNXOeQ1CboUrTz3e3ym+xqty5HMz69c3R6D42VDwAig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3JvQginlVGHAOBxqNTxNOMFpcLZIYLvK0KKYywrEi6z4TIHXp6XX84B5NYo5mskEcDf+2lyGG4L/bocpJxwu/aY6j98FHeQ0NRjFq7UctCzSTj3Q3JnKi5yOLIjCYySbyQXhQ/0ChNNME9R3c3QNDA6dT4nTGLU1e+FWF9hFS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rQ1I/4YT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IkQWZUlW; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rQ1I/4YT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IkQWZUlW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E00571400149;
	Thu, 13 Aug 2026 15:12:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 13 Aug 2026 15:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786648359; x=
	1786734759; bh=E+XzRN93WzpeE0XILCoZd1gmW9hAX/3/A2Lod4scisg=; b=r
	Q1I/4YT3nUF5CvM9ITCICQBh2w6pNaG05pSI06vp7yjn6S0AKBOcEiExxwQDqXn+
	nOy9h+VW9sQAlVaRCbswGK9XgKMLwqdS2g9jdPRmEx95An+d5HERf4Jia5rjuxEy
	q+iU35jiYGEqhOvDJXSXVqwU4VZn5MCIFYZZPxyaA/k1YO8iyy5ChUUh04oadZ2U
	g6eYhw8Xhwj6vEhpdEbWHzgjL6cK+xKFweHLl4eFvpbyVsyAkmET0d1XUc6NS8i6
	4alwLH/1OoEYhcxmrbxT+IzG7sjBiYpYCPEbxVluzr1Ze88n7Kj8DWAOTJ5jU8rX
	eP4b9pulSawxPFgxTadxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786648359; x=1786734759; bh=E
	+XzRN93WzpeE0XILCoZd1gmW9hAX/3/A2Lod4scisg=; b=IkQWZUlWgc7yggahB
	9OD1/vIgml4JLRoqe+cYc2WvGLr+2ZNE3xlzPqvQCtiIBnkWQugxpK7iHswe24pF
	HbBIlYNdj1PoHdub0ZT2VLg1qC/KfhYu+AybZgQNvRDkDPnaOJOFYWHT1S3D0A5/
	1pr6NqTxnTrvTVQpQkzDcSDEOJV2uN7+jbh9Q8OugnNYgaINpZnqVr7Jg6Lu26Mr
	wfCU1ew+TCKduOx1sOpXWqZNtTxTLjASvmw/mIAX77SK0P2nGTooo+3HCAgMRI5c
	uNcvGoSram8+AFdm0pZ4fpDS5lTQAB9yAD51Evk9ezDuGKKUeZixSem6J+XCdvda
	DusDg==
X-ME-Sender: <xms:Jxd-ah7EfTQz6nGpHpzAv7sHHVtEVKc1wAc-Lp3FQHSKgRwUf7Ca6A>
    <xme:Jxd-amVsOdl1X_SksW-2L5ri1DzKfR-8BGQ3SVHG0X1J1VwBI0lnTCIDp2N_CV1Wm
    rI9Lyy9TDWfzubeoyN1ZKiJ6TGpft15tlPNDVvhfnWfB8g8nHblw3c>
X-ME-Received: <xmr:Jxd-al3tb8yXZwXDgXvdTfCXHLG45X4LljqIpOjgS879c6IxD0dQba32z_s8hG8YLJ3UG5lmRLKFh4sRbcr1BZHOlDoR3i0POg>
X-ME-Proxy-Cause: dmFkZTGVo/fISZo4Lx3HK5G8K/1BKX3rHaUfQ1GhyoRRdn6Nithie5qYTfeC9KFsFsj9IO
    FfIQhTWNZReJIExNHeaNCqaGUYHXy0AzBu+O9KE2pAHOOVVYHIcLuLUH3VVk+vTyVQXZrH
    iwFYVSjAus7MHuU0HHGX8CNfaUc4skXRllj61lrG0APnG1vXDhaQY4hAJT7T2PQyIshaMo
    a1vMRS+lfCMDBPndDILWWaow50Mg0ab9BWmQ+AtT01rsr2Zm2thSQgFXM3Dr0rir7Qbi2s
    6f/mtC25y1Fu8n3GWKoUoCLmuDqaHOsdT09qPtCRd3qbBx0YbGruOiVwWwn70VHy0sB9bv
    y4zKMoS7fVM/GfBfCdXn5xE22IeLUNA2KFrCeC7Kfb6TCmT8G3z7WiipHuOjRGktLfGafM
    xxZWIT2RcDe9RxbRCCqwwJR6ylfDDOvZxGOYJs+yfEknlKWiHKaKN27Gtrrw7k45yqs9Ik
    eEwfpY8pzo5ArDHHfhf1OYSZVXg2Iz4OZsHV3UDLnhkE1sohppyn+HkC2omsDTiojULjhb
    d9bSTtaXN+uSiJXl5WxLqOmZYXf0hwYqJtOqjjN2q7drlk9S9R6yoUUjL6mYjnAGS2jZ4O
    rMxtgpcqy56Ka5cebn/O2LRvgY1/4Ez+F0CUTicHr5PKybBqoF37qzvysO+A
X-ME-Proxy: <xmx:Jxd-aj0icPt2Oz-SamXlYHljmId7CSlMegQg0DCVQTVQXyiYsCNLIg>
    <xmx:Jxd-ao_dHq4G5rr8agT1hhSSPtMIWCwCO6NnmM9gTT3cWd-5RNveyQ>
    <xmx:Jxd-ag1RmCr-sQFAJ7eHeXQwRNTsJioBWTzl5lOyhyUcn5SRPFl_ew>
    <xmx:Jxd-al86e2cczitYIfhv8CUQxL6UjakHZ6fSBq-Y-Mei_FndtxhRbQ>
    <xmx:Jxd-auWmPxMjHugBPHh8ZK4utB-psilp6qjD3CC7MSMMnUY-8bb8-1I3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 15:12:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 2/3] completion: complete tracked paths for "git checkout"
Date: Thu, 13 Aug 2026 12:12:33 -0700
Message-ID: <20260813191234.1066662-3-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-759-g9dcc51a0fd
In-Reply-To: <20260813191234.1066662-1-gitster@pobox.com>
References: <xmqq7blx5oor.fsf@gitster.g>
 <20260813191234.1066662-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When completing arguments for "git checkout", _git_checkout()
delegates to __git_complete_refs(), which only completes revision
references.  This is good, as mixing revisions and paths in a single
list from which the user can choose is confusing.  However, if no
reference matches, or if "--" is given, _git_checkout() leaves
COMPREPLY empty.  Bash then falls back to the default filename
completion in $PWD.

This fails when "git -C <path>" is used, as $PWD is not the target
repository.

Update _git_checkout() to use __git_complete_index_file() when "--"
is present, or when revision reference completion yields no matching
candidates, so that tracked paths are offered as candidates.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash |  4 +++
 t/t9902-completion.sh                  | 39 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 38dec1cabe..0eecfcbf8b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1780,6 +1780,10 @@ _git_checkout ()
 			;;
 		esac
 	fi
+
+	if [ ${#COMPREPLY[@]} -eq 0 ]; then
+		__git_complete_index_file ""
+	fi
 }
 
 __git_sequencer_inprogress_options="--continue --quit --abort --skip"
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index b889ec8c77..13fa5c65c3 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2714,6 +2714,45 @@ test_expect_success 'git -C <path> checkout uses the right repo' '
 	EOF
 '
 
+test_expect_success 'git checkout completes tracked paths when no refs match' '
+	# file1 and file2 are tracked but file3 is not
+	# there is no ref that begins with f
+	test_completion "git checkout f" <<-\EOF &&
+	file1
+	file2
+	EOF
+	test_completion "git checkout -- f" <<-\EOF
+	file1
+	file2
+	EOF
+'
+
+test_expect_success 'git -C <path> checkout completes paths in specified repo' '
+	# otherfile is tracked, oops is not
+	# lostfile is tracked but lost
+	test_when_finished "rm -rf repo-for-checkout" &&
+	git init repo-for-checkout &&
+	echo content >repo-for-checkout/otherfile &&
+	echo content >repo-for-checkout/lostfile &&
+	git -C repo-for-checkout add otherfile &&
+	git -C repo-for-checkout add lostfile &&
+	git -C repo-for-checkout commit -m otherfile &&
+	echo untracked >repo-for-checkout/oops &&
+	rm -f repo-for-checkout/lostfile &&
+	test_completion "git -C repo-for-checkout checkout o" <<-\EOF &&
+	otherfile
+	EOF
+	test_completion "git -C repo-for-checkout checkout -- o" <<-\EOF &&
+	otherfile
+	EOF
+	test_completion "git -C repo-for-checkout checkout l" <<-\EOF &&
+	lostfile
+	EOF
+	test_completion "git -C repo-for-checkout checkout -- l" <<-\EOF
+	lostfile
+	EOF
+'
+
 test_expect_success 'git diff completes tracked paths when no refs match' '
 	# file1 and file2 are tracked but file3 is not
 	# there is no ref that begins with f
-- 
2.55.0-759-g9dcc51a0fd

