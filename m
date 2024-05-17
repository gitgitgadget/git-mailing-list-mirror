Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767C112F586
	for <git@vger.kernel.org>; Fri, 17 May 2024 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.14.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960375; cv=none; b=RgYdwf3UKXwunBwI5+7q9FQdG6pcJaNqLMNNor9uR6Mon79SFaZ/Zw8cbUK6hxm60jx+XmGWw62KZzOfUiCmDaYN8FMZjuT6NpFQ7BPFHg5qpM4H4JYR+VokDVNIzC5h2OOu96/2bzLs8d6G+vEQByUSuyvzD/oO0O9OMyxRaG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960375; c=relaxed/simple;
	bh=Jd86A+9pgh0N/EhgEEkwXrNhJVFkUIPka3ffYhOv7Po=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R3d9xGwrfeBzFN1/DqWw5RQUXF4IxEsy/gmKmq84YdHTAfE/DRdLfhi6ZsMoh4ThjFnrj9r7gd9c19DypUMNBrPIEoqP9jEryqFK8b7hZWu23AGjmCntcGR/GYiQvEd592Jcqmflgy+7242eFcNSRTnJwSaGD58/ea0hPMCu5Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk; spf=pass smtp.mailfrom=telka.sk; arc=none smtp.client-ip=185.14.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telka.sk
Received: (qmail 21256 invoked from network); 17 May 2024 15:39:30 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
  by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted); 17 May 2024 15:39:30 -0000
Date: Fri, 17 May 2024 17:39:28 +0200
From: Marcel Telka <marcel@telka.sk>
To: git@vger.kernel.org
Subject: [PATCH] t/t9118-git-svn-funky-branch-names.sh: sed needs semicolon
Message-ID: <Zkd6MNomE4HLRlYh@telcontar>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

POSIX specifies that all editing commands between braces shall be
terminated by a <newline> or <semicolon>.

Signed-off-by: Marcel Telka <marcel@telka.sk>
---
 t/t9118-git-svn-funky-branch-names.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
index d3261e35b8..a34fd46ecc 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -38,7 +38,7 @@ test_expect_success 'setup svnrepo' '
 # SVN 1.7 will truncate "not-a%40{0]" to just "not-a".
 # Look at what SVN wound up naming the branch and use that.
 # Be sure to escape the @ if it shows up.
-non_reflog=$(svn_cmd ls "$svnrepo/pr ject/branches" | sed -ne '/not-a/ { s/\///; s/@/%40/; p }')
+non_reflog=$(svn_cmd ls "$svnrepo/pr ject/branches" | sed -ne '/not-a/ { s/\///; s/@/%40/; p; }')
 
 test_expect_success 'test clone with funky branch names' '
 	git svn clone -s "$svnrepo/pr ject" project &&
