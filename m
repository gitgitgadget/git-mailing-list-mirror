Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322B812F5A3
	for <git@vger.kernel.org>; Fri, 17 May 2024 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.14.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965073; cv=none; b=enIX8hJEfF+dJpFLgPWswwW5u7WVIQ3wPdcsjnsCXVDy+4O9Tx8W0fBvabAkrzXX5oXvjK7LQ8MHG1yKJgVnD2bE8wAUah6f5X0HxjKsYgjSLSlUESX+6lZZiXP49+Yiao2fSqa+dhF30cqxGj/hkpjlGnaYLwvo7RZVDgKS7xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965073; c=relaxed/simple;
	bh=qjO41A/Ah1jn+bgvIAs6xfilJjQ1q7aujgDKu1SL5AI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gsjTqNg+G+eyLWKCnCohWx5Yk2HYxd5AWckLDpY9bSe+lFd18n2VuNq5vKAvqt593ds5WuOZf0pQ9SIu96O+PQ+0b51z6MgxTzevoL30kmHrT02InU81VuGHu8F+ND4qAeRUe6XXi7uKRXYw79/MAW+C7Q2kb0ZcBYdI/s6X03M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk; spf=pass smtp.mailfrom=telka.sk; arc=none smtp.client-ip=185.14.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telka.sk
Received: (qmail 25270 invoked from network); 17 May 2024 16:57:47 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
  by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted); 17 May 2024 16:57:47 -0000
Date: Fri, 17 May 2024 18:57:46 +0200
From: Marcel Telka <marcel@telka.sk>
To: git@vger.kernel.org
Subject: [PATCH] t/t9001-send-email.sh: sed - remove the i flag for s
Message-ID: <ZkeMiifGHkIsehz3@telcontar>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The 'i' flag for the 's' command of sed is not specified by POSIX so
it is not portable.  Replace its usage by different and portable
syntax.

Signed-off-by: Marcel Telka <marcel@telka.sk>
---
 t/t9001-send-email.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 5a771000c9..58699f8e4e 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2526,7 +2526,7 @@ test_expect_success $PREREQ 'test forbidSendmailVariables behavior override' '
 
 test_expect_success $PREREQ '--compose handles lowercase headers' '
 	write_script fake-editor <<-\EOF &&
-	sed "s/^From:.*/from: edited-from@example.com/i" "$1" >"$1.tmp" &&
+	sed "s/^[Ff][Rr][Oo][Mm]:.*/from: edited-from@example.com/" "$1" >"$1.tmp" &&
 	mv "$1.tmp" "$1"
 	EOF
 	clean_fake_sendmail &&
