Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8BD1E4928
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 06:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674306; cv=none; b=cc+GTmflbvVpBTg7G9hcn+IlnI6CocaLJ9lRkV1f/ZyFewrkeQCMvjoOh3hlegq5Ac47lFwIYMQo7ToJhFt6sR9MzyYuC4EwQOBvJhVTFwPfinOhtftK6zKngQI6+xT/KcRVTqsdYXGlJyBRMXWP5ae2AUmZwjfVaFcR2Gq79iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674306; c=relaxed/simple;
	bh=QIsUzZ6A6cDWQ3sCO6K4IvFwhhQaSpbKvWBluGsbdwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uf0sMXaw54DV2X6EV04rBmUtQo+D0pULrqz1OjSCvj7uqYuptlo3etnMrQ+hXsXYoNtZ0anEHjzbF0I8A24y++IHShI/5dlp0r17ygbEpPSfZ2MyK8CvUxTVxJoiOIxN0fIrCLSBytKnZzY/bC7ihwvh12SC6hj8yGJ4HifrYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U08NcEQH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U08NcEQH"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so7583678a91.2
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 23:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741674304; x=1742279104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+FI5cc+nOI4qdPzOAN1dTfUN4HjT76BDJX6n0rFZ5A=;
        b=U08NcEQHnbdgPVpfJ2vc8I/V2gfJgKclO+p6fFmi59P0XyzJy+EQ1JNfVAkzhthtQs
         uLbTq9HZtHb3i+ZBYnDwAuFcP0wBepdqYWmgyat44fSMx+0oa2yIKmHujJ33/W6PXztw
         1YZHp7Fz6IssCHO+Cx9UAS5MKNqVoq0FpX7OO+DZeaN5o+b6Ze+UhdI1MwhEErHs3ts5
         mO8Ljqnt5HHorKXk0KqKcBvD4ztFs+9288/lw7LNNUt6gwssv1uvsIQ+dNBlAEUIPpNN
         jyzJXUCcczXs/vC3tdAEVUND8fMdRNsQlmYZ3d0/ZtL7Mch1E0UYsICsickxC0ZYfjIS
         TeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741674304; x=1742279104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+FI5cc+nOI4qdPzOAN1dTfUN4HjT76BDJX6n0rFZ5A=;
        b=n0vqF5VM5vMWCyeFR6b1klwSU3Rj8+Ten8GU/hWJvF+NeQlop8+mcCgEkssauZh0RT
         KSWmk7bBvgblVr4GfXh0ldGhdpNvfmMh7KKSLvYcUKZ7AfnF7Mx6gYOg1xpLIKANRsQq
         CEda2RMAWmeg76T2PvEyvRQnV2dqutILilz8vIFAQxDFh9DAawSfalmhmi2d0809a/hJ
         n6ZfDRzUbSZEgB/sSsadvrrEp7sRelPjVpPkv5GeHCCXQiz4x5Prb7/sRlpzLJ1MNnPQ
         Wklcx+gsYJCF64EubmSTa7hacTcMqHQVePBJN8yUcBffm8HQ7AuJxA4q0qMyuam49X8o
         P/gw==
X-Gm-Message-State: AOJu0YwejlfzucW548C0ZTRyY1lo4G+UxRPhfQ3PJeuRsGTKkL6S+Iaf
	VV2TOcLxfoWyQtTmQGyiyuJP0hfDghNQhDdoOruvvdkTReSTfCRZrUYIINZo
X-Gm-Gg: ASbGncvwBLfzvY+YRBXenNbA/CGW9JQkm/fcHJYwUW0dVzYm40smbwZK8oDrKCYM5TK
	D6u+HY23XwZBmF0Bei5jilLoc0QYqiAxBHJm5p9amBw+BxykFkDPj5HFv0hTE0ckGlES0d0dt+H
	Igc3frnTV5ewTQ1TLbRpa9Ep8kp4FyL2ZQ+2pL+aP3dNVisO84jtURoTFxYm02w+XJ8mx3/SimD
	9BmWbrok3k2uD8Iy/G4LYJZcpC2zwO3l+qCnMEZgRoPewGmyzozLAmpsWIft4n66ep/o+mc8nod
	3G01T3h2z1IlZ31uMeaeT0poV58i6QX5RkdDdNrDwqACaHGU6Y+9
X-Google-Smtp-Source: AGHT+IFetYXv/6mp6JDSJMEBX9EdCod/UwLHQ1fv2cZWiPdwF5LaZLnR+WWJHfBFIV25ZElkeLBqnw==
X-Received: by 2002:a17:90b:1dce:b0:2ff:62f3:5b19 with SMTP id 98e67ed59e1d1-2ff7ce6f0bcmr25029107a91.13.1741674304267;
        Mon, 10 Mar 2025 23:25:04 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693f991fsm10250099a91.48.2025.03.10.23.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 23:25:03 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: git@vger.kernel.org
Cc: Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v2 1/1] improve smtp authentication error handling logic
Date: Tue, 11 Mar 2025 14:24:13 +0800
Message-ID: <20250311062440.3566116-2-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0.57.gdb91954e18
In-Reply-To: <20250311062440.3566116-1-05ZYT30@gmail.com>
References: <20250311062440.3566116-1-05ZYT30@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 git-send-email.perl | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 798d59b84f..a012d61abb 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1419,19 +1419,19 @@ sub smtp_auth_maybe {
 		die "invalid smtp auth: '${smtp_auth}'";
 	}

-	# TODO: Authentication may fail not because credentials were
+	# Authentication may fail not because credentials were
 	# invalid but due to other reasons, in which we should not
 	# reject credentials.
 	$auth = Git::credential({
 		'protocol' => 'smtp',
 		'host' => smtp_host_string(),
 		'username' => $smtp_authuser,
-		# if there's no password, "git credential fill" will
-		# give us one, otherwise it'll just pass this one.
 		'password' => $smtp_authpass
+
 	}, sub {
 		my $cred = shift;
-
+		my $result;
+		my $error;
 		if ($smtp_auth) {
 			my $sasl = Authen::SASL->new(
 				mechanism => $smtp_auth,
@@ -1441,13 +1441,27 @@ sub smtp_auth_maybe {
 					authname => $cred->{'username'},
 				}
 			);
-
 			return !!$smtp->auth($sasl);
+		} else {
+			# Handle plain authentication errors
+			eval {
+				$result = $smtp->auth($cred->{'username'}, $cred->{'password'});
+				1; # Ensure true value is returned
+			} or do {
+				$error = $@ || 'Unknown error';
+			};
 		}
-
-		return !!$smtp->auth($cred->{'username'}, $cred->{'password'});
+		# Unified error handling logic
+		if ($error) {
+			# Match temporary errors
+			if ($error =~ /timeout|temporary|greylist|throttled|quota\s+exceeded|queue|overload|try\s+again|connection\s+lost|network\s+error/i) {
+				warn "SMTP temporary error: $error";
+				return 1;
+			}
+			return 0;
+		}
+		return !!$result;
 	});
-
 	return $auth;
 }

--
2.49.0.rc0.57.gdb91954e18
