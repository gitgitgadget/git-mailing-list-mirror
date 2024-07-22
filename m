Received: from impout008.msg.chrl.nc.charter.net (impout008aa.msg.chrl.nc.charter.net [47.43.20.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9D38F58
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 07:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721631694; cv=none; b=CGcDotind0TpOGFPAIIhlMn9UaHSNoR9IRnKphR1/OgKSeHlTCycbHgSsCyIKiKE03id1IuCKn8kDAZ59AnoK3FkQbPZgkBRNHReYEYBpAs8c4TrwdygEoW9xzGOMtXjPqlkrukbgkyeQ4nfdoibSKI5vwNv18aAJR1fyHXZ2B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721631694; c=relaxed/simple;
	bh=azRrAol6oY2ZqA8UUK0XHRfn0bab1pszd8eEBOwppeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taLFbQ9TYi9ngZdhNnN8YuhIKCpulqGe7W9m+/dGL2f99RqyqEvHW2edZhyJtbxEQmpF7ck5zxjR5xCfYDw3MSyVTDY95kWXVsh3BjSRNDXqwvFN5RvzY2Ot/de2ypiJusaz0yPIBDr6KlDfh5CCAhjNN2RgYpJUzOdAAIkIo10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=VfvMO/lx; arc=none smtp.client-ip=47.43.20.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="VfvMO/lx"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id Vn1PsPWKO6kyQVn1XsyVj4; Mon, 22 Jul 2024 06:59:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1721631595;
	bh=azRrAol6oY2ZqA8UUK0XHRfn0bab1pszd8eEBOwppeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VfvMO/lxx6vdD99IKk2nbqJL0Eazm3EIZkfdeE8ld7tgbG+q4Yelc5LaW8aZtwCnu
	 hqBVp6JE8sOFm5UW1xYWRbueGA3ioI036H91x+vlfn7q5sgqsgfq3upc8uD/NRFkA7
	 rOCjgipRaW9B2XbxbcTG2SN5J6b9aKWRBm2X2ke2q7prsDpNlxuUSfqDMEl4gNYvY4
	 6yb+dcMGnF8T8uZGiSClx6hK8YMe0kkv+RFMGftbBhEXkfJcFH0j+13h38b21R7zLU
	 mQraNGSpALDQqXVJXIzsHCow7H1+husgXnWqNW0KP79o+dSdKyF1rFDXKxtDIRhQ0o
	 uXJut/bnzY5Kg==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=bKkQIu+Z c=1 sm=1 tr=0 ts=669e036b
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=xjmMxo3dIE4o5O_OhqsA:9 a=jYKBPJSq9nmHKCndOPe9:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 4/4] check-non-portable-shell: suggest alternative for `VAR=val shell-func`
Date: Mon, 22 Jul 2024 02:59:14 -0400
Message-ID: <20240722065915.80760-5-ericsunshine@charter.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722065915.80760-1-ericsunshine@charter.net>
References: <20240722065915.80760-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfK654EkRlGYxjL4b4/f9qU7qg3N5wjZgQCRwYOJj9qrcE9pNr1nbK5o4tYl8jmyESG+69SiDIEMoA6etlxcjc71CJPFs5qgCcN+eyhMayf8MR3e4xeej
 ODYLJ0OxuaSfjrHPGFEXqnjOe7PGuGe3FxHQTWeina6rfqAuLn4Tv1y6wy/LU/rEkmXY3MiWbQsrcr1HhRZ4BZyC0E95TvREh+RtOrdmPY47yKPHwtXjTbjk
 vDLO0s1BgfdCPqytbC/vmKlrV89XkAYq7R/dXoXIdyBSV3UwiFoWF75w1GZbHMNZ

From: Eric Sunshine <sunshine@sunshineco.com>

Most problems reported by check-non-portable-shell are accompanied by
advice suggesting how the test author can repair the problem. For
instance:

    error: egrep/fgrep obsolescent (use grep -E/-F)

However, when one-shot variable assignment is detected when calling a
shell function (i.e. `VAR=val shell-func`), the problem is reported, but
no advice is given. The lack of advice is particularly egregious since
neither the problem nor the workaround are likely well-known by
newcomers to the project writing tests for the first time. Address this
shortcoming by recommending the use of test_env() which is tailor made
for this specific use-case.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/check-non-portable-shell.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index 44b23d6ddd..56db7cc6ed 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -50,7 +50,7 @@ sub err {
 	/\blocal\s+[A-Za-z0-9_]*=\$([A-Za-z0-9_{]|[(][^(])/ and
 		err q(quote "$val" in 'local var=$val');
 	/\b([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and !/test_env.+=/ and exists($func{$4}) and
-		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
+		err '"FOO=bar shell_func" assignment extends beyond "shell_func" (use test_env FOO=bar shell_func)';
 	$line = '';
 	# this resets our $. for each file
 	close ARGV if eof;
-- 
2.45.2

