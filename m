Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A8652F80
	for <git@vger.kernel.org>; Fri, 17 May 2024 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.14.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715951954; cv=none; b=jOFw8Xt2bitvrXHnql+ikQtSRGZcFlTl2M2bE2puVr+XorOds05uSB+OFVHQ329uGU/1gELP0o3IiW5DRgkVLUJFJLFhimDHD43cYq36y5lHj02YoJMyM6YQubJSM2Y3ot7UgNIgZjVd+0errMth93AvqtsNd9H1Lv1JGzdYc+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715951954; c=relaxed/simple;
	bh=v6SV9vul3Fif5mpXjjJvabcs8zBcV3bsZR0+jbqyw9o=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iL9Pn2TEbWSJRaf/cgdL1v/H49aVOCi0ujFB/5FvpeSs8SSpvwzKW/LtvMUk9QGZPSm5ujkfm5kitEHF7wh1ydt48T/Y42LtTA+65x6BXy4uCSNIZPsBM8gSSfDklbhUDiwys+kbSYdENZ0iHRfm20mkaNbun9zidFAH66TOAaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk; spf=pass smtp.mailfrom=telka.sk; arc=none smtp.client-ip=185.14.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telka.sk
Received: (qmail 14123 invoked from network); 17 May 2024 13:19:02 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
  by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted); 17 May 2024 13:19:02 -0000
Date: Fri, 17 May 2024 15:19:00 +0200
From: Marcel Telka <marcel@telka.sk>
To: git@vger.kernel.org
Subject: [PATCH] t/t0600-reffiles-backend.sh: rm -v is not portable
Message-ID: <ZkdZRAn6KGgxBnT5@telcontar>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The -v option for rm is not specified by POSIX.  The illumos
implementation of rm does not support -v.  Since we do not need the
verbose rm output we just drop -v for rm.

Signed-off-by: Marcel Telka <marcel@telka.sk>
---
 t/t0600-reffiles-backend.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index a390cffc80..92f570313d 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -424,7 +424,7 @@ test_expect_success SYMLINKS 'git branch -m with symlinked .git/refs' '
 	test_when_finished "rm -rf subdir" &&
 	git init --bare subdir &&
 
-	rm -rfv subdir/refs subdir/objects subdir/packed-refs &&
+	rm -rf subdir/refs subdir/objects subdir/packed-refs &&
 	ln -s ../.git/refs subdir/refs &&
 	ln -s ../.git/objects subdir/objects &&
 	ln -s ../.git/packed-refs subdir/packed-refs &&
