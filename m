Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C0C2BD04
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762032; cv=none; b=lZQkrox+y/25irg00QWVME/OTW6CMA34wTnPOCOc36zfk8U1f7Aa67X5pecdS8srbTCri2Lve5SW1tvTpedrkPAYDkQDkZfVf5eGHitFe9RKcsjI8ns0gWWHyuFPBi5TIk35B89cnXydUYT/dVuJ6F5xV+x75ETkRdVtgj6A4lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762032; c=relaxed/simple;
	bh=BFFgvJQGUxErSUdrD74FkRBm/k1fY80H2O/2RMT6Fbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LiL9QhW2KDJtn4BYYeBifEpeTeP+Iq2JZIjWHohdBmozMv5zNlO8DRHcfxaKmlSAOT4caIf8mGO9o9Z0W+BICcnupl4c8kpb7mypLVkYTiZCffavpOBv817LTko35wevsQpB+CKyepIvdTR/c4z1pJa1DtkOM+jJruxIf5GJQHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnxreAwC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnxreAwC"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224341bbc1dso86984395ad.3
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 23:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741762030; x=1742366830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5Xhs1NG9F5A6/RV+Mh6n/Y8SaScpd0nSlf+wSP21RI=;
        b=QnxreAwC6nj3ggAczMQhxbKSMBm2gFroWgJRQtYCwwpDNeWEHx5T22BmMR9lTVisHg
         BZh6IOy1kYEExtA/0Gpr9ZMs8jWZDykaNpLZuSYlgjtBUDlkjHQUiAgNRUw5omWHnoaW
         Oow9GVVLqT5+jb+U12OzI+3zm1nvPpT8y90AdJSR6RvQ0zUGdoSh6/843Ejabz/B6LWA
         ZqB9nE58E6BwuuvkQmWzMavHG8fG+hfVboV5LUzPayaVcpLNnyvS8zDD8ED6E57lO6j3
         9LiZRKqgGnbT5cc9GDAl2GDzyHcxcI/1DKlJ89vFh2xkKS/B2tuaRSkbxhdRydQIaeeS
         O6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741762030; x=1742366830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5Xhs1NG9F5A6/RV+Mh6n/Y8SaScpd0nSlf+wSP21RI=;
        b=t4oJ9UF9FaSWmazwnAsVmzwhfICZzFUutWI5NQcTCkYmI92rtfhISpzBuAOx92mAVe
         Uq/xW4Infw05dqWDXAUhXEL+VydwA5juzOlHdeMjfY8BcbBa65K9QBC8CCN7lhLhS/gb
         OYBUGdSBfGIIGXyqNNwQN2mlxlx3J56lu82Xnkd2pvq/e1mBHDwjhQFV8hykHw9KqwHv
         wZGt2KQinyB6ZcpY9SOOQtHngY9SOq5CLHfZIT56NGxDkMhKlZ5tSl6mywnwNLsKPM+2
         jdYuMIXoJ2wPHOnvJF1wyitsl91P6ZT3RcRl7Lb2/KEQKjtfaQq5vD5sCj3TZ+cvq+/Y
         5iGA==
X-Gm-Message-State: AOJu0Yy5o1gfCexzWT8s6swGkonVJeJev+Tf4CZ9qOw4VMAu7sdBAYF3
	Pv2x8N8lDDmpPA62afFAGJvF+rW3BKarfuqFgaH5BjdgXn7JMCWKYNS50R4I
X-Gm-Gg: ASbGncs8EAiyMqOH3wbfVgD06z30wVeBr1N+UbKTCRGimYW2torrLI+vjPYLxI+3PZn
	UuUyu+4NQiXBd0QXNAg+MSsNQpsQ+JQWu3ZI8C5mYkgF5c1Jro7BjGxFOJCo/4QJWMUUo4ftRjp
	IamNNe1P61ZnpkXwzyWZm4qltuUtsPoRIKSFf0sewjZjTkR7DLbeKrmVoqFlepbAyFFp159Jazm
	KNcASYUbmpTmIhR2smUEtqA1L1gOa7iigxUIvOLyqpDBN2a9prQM7BJRLUMM5/1G7JHU8SNGP/9
	K31C8daLHdWlatsqk7OHzKZ3PKYoDeAVIoCChDHsmD+GxfpsCjUq
X-Google-Smtp-Source: AGHT+IG4eOYVfzf5+toPSjjkp49r0SbXxsOSE+1gHmVLtT6Ps7VOpTRWmLCGjFg9KpBcJBAqHn06xQ==
X-Received: by 2002:a05:6a00:189b:b0:736:755b:8317 with SMTP id d2e1a72fcca58-736eb8a15femr9186579b3a.21.1741762030254;
        Tue, 11 Mar 2025 23:47:10 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736e6262982sm3889822b3a.120.2025.03.11.23.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 23:47:09 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: git@vger.kernel.org
Cc: Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v3 1/1] Unify SMTP auth error handling
Date: Wed, 12 Mar 2025 14:46:36 +0800
Message-ID: <20250312064639.668875-2-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0.57.gdb91954e18
In-Reply-To: <20250312064639.668875-1-05ZYT30@gmail.com>
References: <20250312064639.668875-1-05ZYT30@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactored SMTP authentication to use a unified error capture block for
both SASL and plain methods. Errors are now handled by parsing SMTP status
codes (4yz for transient, 5yz for permanent) instead of relying on regex
matching. This change improves clarity .


Signed-off-by: Zheng Yuting <05ZYT30@gmail.com>
---
 git-send-email.perl | 72 +++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index a012d61abb..532dda264c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1411,7 +1411,7 @@ sub smtp_auth_maybe {
 	eval {
 		require Authen::SASL;
 		Authen::SASL->import(qw(Perl));
-	};
+	}

 	# Check mechanism naming as defined in:
 	# https://tools.ietf.org/html/rfc4422#page-8
@@ -1426,42 +1426,56 @@ sub smtp_auth_maybe {
 		'protocol' => 'smtp',
 		'host' => smtp_host_string(),
 		'username' => $smtp_authuser,
+		# if there's no password, "git credential fill" will
+		# give us one, otherwise it'll just pass this one.
 		'password' => $smtp_authpass
-
 	}, sub {
 		my $cred = shift;
 		my $result;
 		my $error;
-		if ($smtp_auth) {
-			my $sasl = Authen::SASL->new(
-				mechanism => $smtp_auth,
-				callback => {
-					user => $cred->{'username'},
-					pass => $cred->{'password'},
-					authname => $cred->{'username'},
-				}
-			);
-			return !!$smtp->auth($sasl);
-		} else {
-			# Handle plain authentication errors
-			eval {
+
+		# catch all SMTP auth error
+		eval {
+			if ($smtp_auth) {
+				my $sasl = Authen::SASL->new(
+					mechanism => $smtp_auth,
+					callback => {
+						user => $cred->{'username'},
+						pass => $cred->{'password'},
+						authname => $cred->{'username'},
+					}
+				);
+				$result = $smtp->auth($sasl);
+			} else {
 				$result = $smtp->auth($cred->{'username'}, $cred->{'password'});
-				1; # Ensure true value is returned
-			} or do {
-				$error = $@ || 'Unknown error';
-			};
-		}
-		# Unified error handling logic
+			}
+			1; # Ensure true value is returned if no exception is thrown.
+		} or do {
+			$error = $@ || 'Unknown error';
+		};
+
+		#check if an error was captured
 		if ($error) {
-			# Match temporary errors
-			if ($error =~ /timeout|temporary|greylist|throttled|quota\s+exceeded|queue|overload|try\s+again|connection\s+lost|network\s+error/i) {
-				warn "SMTP temporary error: $error";
-				return 1;
+			#Parse SMTP status code from error message in:
+			#https://www.rfc-editor.org/rfc/rfc5321.html
+			if ($error =~ /\b(\d{3})\b/) {
+				my $status_code = $1;
+				if ($status_code =~ /^4/) {
+					# 4yz: Transient Negative Completion reply
+					warn "SMTP temporary error (status code $status_code): $error";
+					return 1;
+				} elsif ($status_code =~ /^5/) {
+					# 5yz: Permanent Negative Completion reply
+					warn "SMTP permanent error (status code $status_code): $error";
+					return 0;
+				}
+				# If no status code is found, treat as permanent error
+				warn "SMTP unknown error: $error";
+				return 0;
 			}
-			return 0;
-		}
-		return !!$result;
-	});
+			return $result ? 1 : 0;
+		});
+
 	return $auth;
 }

--
2.49.0.rc0.57.gdb91954e18
