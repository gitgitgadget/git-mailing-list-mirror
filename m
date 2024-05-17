Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160CB12DD9F
	for <git@vger.kernel.org>; Fri, 17 May 2024 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.14.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959667; cv=none; b=Fy9oXFhCzEKcAwAd/08FyWB1B23uhBSrvgT8Y0ojK9ir01DuKEspchoKyy8XsW+PV0+Fa8Ce+oeMdKxTDpsNcKwBlejRZXCaeWQ9z497JlSlXNkn61MRDyybJpDjSwmaaV5AbYbDWvjiy9YmdOk354TsI/+dPnsO1uR/Og4Rpm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959667; c=relaxed/simple;
	bh=N6vOFt3Z0cAyPVvbZ34oZqBYhQDlnxAOtkdO8TIVuBI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dAw4YDks00zSWmi6qf5hPxQ7HGxA/2Vpf6evnbzhs/fdvH5G4KEboHgpPx1H7OXPnKqQi9pZuDSNIOGdbgrD0P8GTGriIOwLWZYtlquE9VXc6hvx7YPMl7MilhKZvF7Jkmyx8tV/Oydw3zQGoLlgMDOb44615REAB8sr8Dy40E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk; spf=pass smtp.mailfrom=telka.sk; arc=none smtp.client-ip=185.14.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telka.sk
Received: (qmail 20788 invoked from network); 17 May 2024 15:27:42 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
  by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted); 17 May 2024 15:27:42 -0000
Date: Fri, 17 May 2024 17:27:41 +0200
From: Marcel Telka <marcel@telka.sk>
To: git@vger.kernel.org
Subject: [PATCH] t/t1700-split-index.sh: mv -v is not portable
Message-ID: <Zkd3bXM6itnh04IP@telcontar>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The -v option for mv is not specified by POSIX.  The illumos
implementation of mv does not support -v.  Since we do not need the
verbose mv output we just drop -v for mv.

Signed-off-by: Marcel Telka <marcel@telka.sk>
---
 t/t1700-split-index.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index a7b7263b35..ac4a5b2734 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -527,7 +527,7 @@ test_expect_success 'reading split index at alternate location' '
 
 	# ... and, for backwards compatibility, in the current GIT_DIR
 	# as well.
-	mv -v ./reading-alternate-location/.git/sharedindex.* .git &&
+	mv ./reading-alternate-location/.git/sharedindex.* .git &&
 	GIT_INDEX_FILE=./reading-alternate-location/.git/index \
 	git ls-files --cached >actual &&
 	test_cmp expect actual
