Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8772744C7A
	for <git@vger.kernel.org>; Fri, 17 May 2024 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.14.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715953207; cv=none; b=n31RHoSAOGNNRE6hiu2TyQfzGyyK5AQRXJHXaQcxZW0tkc8Zf1VRBZH7cFr5CybjAf5MwWtJFOU0NeWUaIer6VOfPvTYMqEkpA6FZJ3sUA9ViM8a0lDNvXhGDEe6zu5lIFOJEJXRVYiyYxSoxOdrqVTvnHgFipBIpdZoY4EFbdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715953207; c=relaxed/simple;
	bh=p+X1EXrDKy9ULA6mAPYBolVVYQxPQEfbEKaqIQ0+4v0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QsBJnn8Pc4Q07ssV80/LkLcwY7zox9b6bbiNKjANrnWfeK5iBay36Fc3B5+KKFDqdsLFFu4gaw488FbBWdyTjPeuEviBxaEwXynRbTz/ZM1aSpW5g//dDtFBtZg1vTW/jPI0HQ7Hx13gCizIsJS1WJydFvttvsvR2TJSc16bc4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk; spf=pass smtp.mailfrom=telka.sk; arc=none smtp.client-ip=185.14.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telka.sk
Received: (qmail 15178 invoked from network); 17 May 2024 13:40:01 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
  by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted); 17 May 2024 13:40:01 -0000
Date: Fri, 17 May 2024 15:40:00 +0200
From: Marcel Telka <marcel@telka.sk>
To: git@vger.kernel.org
Subject: [PATCH] t/t4202-log.sh: fix misspelled variable
Message-ID: <ZkdeMLeDUsAAqYBL@telcontar>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The GPGSSH_GOOD_SIGNATURE_TRUSTED variable was spelled as
GOOD_SIGNATURE_TRUSTED and so the grep was used the null RE that
matches everything.

Signed-off-by: Marcel Telka <marcel@telka.sk>
---
 t/t4202-log.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 60fe60d761..86c695eb0a 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -2022,7 +2022,7 @@ test_expect_success GPGSM 'log --graph --show-signature x509' '
 test_expect_success GPGSSH 'log --graph --show-signature ssh' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git log --graph --show-signature -n1 signed-ssh >actual &&
-	grep "${GOOD_SIGNATURE_TRUSTED}" actual
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '
 
 test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log shows failure on expired signature key' '
