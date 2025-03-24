Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3B1261384
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828037; cv=none; b=R+kZuf0l9lTNz6r8KnfxYAmJJLZaBjP6FT3X9Xey2natL6k99AFNLjzpbEuQ29q66wOMvECwfLe/8JtWoVcCgBe/3SIkLkC71KD/CA8sp4uYtqZGvF0ZlcGrCjHIwzBXyPiRO9b/KqdyOaDTIIc1jVgemtQs2L3D+ePly9ENrts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828037; c=relaxed/simple;
	bh=nKhvXlc9VUII90V9y72s85XoWwWJsAf0yjAam36cztE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWfjUFJKtLyMB2u1kfDSrvw1BJXsdChvvUArVe5Z6uHcBtcnhCojgscEG7DLG9WmRTxhCzrKcs9YLYvVILYgcuLT0eTDnPv5v2vM+VNsiXBzVP5y/rmhs4SshBywsuO+9wOeWaOwntV1PNOF7PRW+n4wGYEJIrkgeEHQBwUxHq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXRoJhV6; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXRoJhV6"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3011737dda0so5687106a91.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742828035; x=1743432835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRR1coZaRVYg9azhpKZc62eH1qYjUJErx0dIYunF7Sw=;
        b=LXRoJhV6Z2CXNq46lqZaQtyBV5q8Exl+rlLNXcBg+GQinduxzWON4M1xtc/q6B/9Hz
         MXZVhAoS93uM9ewJbhUvGS1mJcp19vgaobK2mfXCA7yOTqaVuFqSfp2yPTnbUEoiQBHy
         5+GhFv1IIKHP1dlkE7J9V0XStnsZx4xvrLFgyUrByLiYidGAYGFNBIzXfM3hYi/pt9lb
         IawHNKjbCX4pOBqfs3F7/KwEAFihKHcfga0bVbnp3AvkaQIrcVJ4WTx8UzFzHK00UMu1
         hw0kO0BnEgIAPUI9jjag49ftnZx4O9aj/jyyMKjWtCSm4b9YmGgMfjLzXoVb/lTG0P/Y
         zNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742828035; x=1743432835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRR1coZaRVYg9azhpKZc62eH1qYjUJErx0dIYunF7Sw=;
        b=GnFAqOOZ/XRhXWbc1Qd9k580dzHgLHiYNEJPppizvq3qTYiCRN+kv1jERRtwndqxNb
         gxHo5nPz7JwTrKKViFxcZihc2/bkyhww9cjShC7/eNAVWtbKhGryBNBkF0ukyew+68UU
         qJhXDlldvNy+M24c81RjZdyy2VQ80rz4zoXcVe1/ttYM2UmMuxrPWu+ORjtVicqYkp7A
         deTHoaoFLOqbdmhL50TLSEfUq/ZF5+mhqT+WVsOZDb2Ow6bbEaCxaWebb6IiQjfeZE8s
         aKtHu4E7o3iFnjbvtqmNFizMREIQKvkXfej/qbPPrfEAG9w4JGCB2jV0j36zmW2Tewd3
         O7VA==
X-Gm-Message-State: AOJu0YxTpxYO+SBL17XC/KBZOSScFNmZrUdBHboWUJbI0vgIIKrDv7wc
	+IqspLA35rZqMCH0opD+/dS83ijWZLeskwjIecQSigS4xIsjOlcRW9ekrxh2
X-Gm-Gg: ASbGncuH/ABtglxnAW/6FKJtaT5Ykn6/FR4yZaBzCw6CDkQSlGNZ55Lej0N0mb8Z0Tc
	+XvYwBWixcgD7XscZns8t2sPFJaPEo9Avqjyir04Cw4XwFF3KGgFalp8hLOYhI+IOu2icYYOjoY
	JbLjQTlbi9gTPyA43iEMmaxj0hZzskprma6YRzEr+ZqpqzgDRdyMTS+MF+fLr9+aBBeGn/XkcY4
	0nYedm4KiRJ2AjCf0DoRS93MpkGvpR29hegOawYV9WUjv6w0MqsWxMCwtmXkGdZORyfetbG2l5n
	1uO3X9McoNrHX7nEcovBHrDCWkIrqq+kup35oWRYar2K5xBUDVyI
X-Google-Smtp-Source: AGHT+IGKYmd850rdnMnCAOQboW8sj5hCgRdAqFSd+MVG/U6EJeB1N0MLVWTSqXZx4cgwCz/9ZDuqlA==
X-Received: by 2002:a17:90b:2ed0:b0:2ff:5e4e:864 with SMTP id 98e67ed59e1d1-3030ff108a6mr22700568a91.25.1742828035177;
        Mon, 24 Mar 2025 07:53:55 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf635929sm13464061a91.40.2025.03.24.07.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:53:54 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: 05zyt30@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	meetsoni3017@gmail.com,
	Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v8 1/2] send-email: capture errors in an eval {} block
Date: Mon, 24 Mar 2025 22:53:31 +0800
Message-ID: <20250324145332.571813-2-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324145332.571813-1-05ZYT30@gmail.com>
References: <20250321025128.68463-1-05ZYT30@gmail.com>
 <20250324145332.571813-1-05ZYT30@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Auth relied solely on return values without catching errors. This misjudges
non-credential errors as auth failure without error info.

Patch wraps the entire auth process in an eval {} block to catch
all exceptions, including non-credential errors. It adds a new $error var,
uses 'or do' to prevent flow break, and returns $result ? 1 : 0. And merges
if/else branches, integrates SASL and basic auth, with comments for
future status code handling.

Signed-off-by: Zheng Yuting <05ZYT30@gmail.com>
---
 git-send-email.perl | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 798d59b84f..0f05f55e50 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1419,7 +1419,7 @@ sub smtp_auth_maybe {
 		die "invalid smtp auth: '${smtp_auth}'";
 	}
 
-	# TODO: Authentication may fail not because credentials were
+	# Authentication may fail not because credentials were
 	# invalid but due to other reasons, in which we should not
 	# reject credentials.
 	$auth = Git::credential({
@@ -1431,21 +1431,32 @@ sub smtp_auth_maybe {
 		'password' => $smtp_authpass
 	}, sub {
 		my $cred = shift;
-
-		if ($smtp_auth) {
-			my $sasl = Authen::SASL->new(
-				mechanism => $smtp_auth,
-				callback => {
-					user => $cred->{'username'},
-					pass => $cred->{'password'},
-					authname => $cred->{'username'},
-				}
-			);
-
-			return !!$smtp->auth($sasl);
-		}
-
-		return !!$smtp->auth($cred->{'username'}, $cred->{'password'});
+		my $result;
+		my $error;
+
+		# catch all SMTP auth error in a unified eval block
+		eval {
+			if ($smtp_auth) {
+				my $sasl = Authen::SASL->new(
+					mechanism => $smtp_auth,
+					callback => {
+						user     => $cred->{'username'},
+						pass     => $cred->{'password'},
+						authname => $cred->{'username'},
+					}
+				);
+				$result = $smtp->auth($sasl);
+			} else {
+				$result = $smtp->auth($cred->{'username'}, $cred->{'password'});
+			}
+			1; # ensure true value is returned if no exception is thrown
+		} or do {
+			$error = $@ || 'Unknown error';
+		};
+
+		# NOTE: SMTP status code handling will be added in a subsequent commit,
+		# return 1 when failed due to non-credential reasons
+		return $error ? 1 : ($result ? 1 : 0);
 	});
 
 	return $auth;
-- 
2.49.0

