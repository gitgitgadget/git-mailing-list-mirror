Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42FE28E8
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 05:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742101784; cv=none; b=T69jizhqb/I1/IclKK5jqHMFl+3I/dpSm50ZYEGpM4E9e0gXWQ5nyG9vQxcPs2Abm8J5JII4BehNtLeW5bhM7DP98s5djU5Pn68hvUns1jYv4koXENYDoZRZQKpegSSbPY+4gnuupubkt0EVJIiEKAOIjuRJtJMvt4tckM2isZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742101784; c=relaxed/simple;
	bh=eG/4duFtkJXoI7JqDQKwYk2FM8ka8VIudRK4vpaSrtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lu0dEgW2iOwhiKkTooi8S7khvW83ty14EVoJ+yrcaT54dMa5rl27P3htumoy63gyDQaxFVyW1v6OWayi4CSB/vLR8VyFtSO0941Vno2+wWF1wqo9eIujo7YRXrowVrXX5EAtbNtsR/0ie+2wTJmLN9RKplpgXlDZ1W/Jhn3nfHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcZbeYhA; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcZbeYhA"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff797f8f1bso1288642a91.3
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 22:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742101781; x=1742706581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rf43RuLIAI9KCX2e3JsJQJRP9CeeCIPQVg+PIAqido=;
        b=IcZbeYhAS+C6K1zPaF2NdZ9/yWfHdC+jH49dwT2yqz38mjWgmT8Bjppl/kUjgJVpOr
         W5WDv/5LQ5FkdSP1/sszTsBOm46LTyPhIBCrkyrrNI4gUUToGo72oFqisTF0LywPaOSU
         KQ7gvpRV4ntUDRcDbTeAAqgnjorzN+mdFpNHd4Oky7F+cBvz0ylUieaJWeEjaDlANsJO
         aK0wwnXbutRYa/ou15gefI0H0WRjS9KNtv/l8MtSTFtcwlaWy6hsIQg/83qFI4NHWZ9q
         ucz8Ky9UYdWM4eRNfoxHZjfo7zzP+7jvSlE/tBpUCymuiKOap6v8a/oj239QPl0q7x7d
         rzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742101781; x=1742706581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rf43RuLIAI9KCX2e3JsJQJRP9CeeCIPQVg+PIAqido=;
        b=XEgsbO4jrzmblQ22R7gwJBnWwfw2xZfVz43xbyGb1U+hD2BL8djCDddK1oPss73Ebn
         7gc3D/oOSCX/aXh+GFuDAGl86M3PEjGLT2+BeH8cuW8hTT/nlUDCJ8BPnjWkZWBSoWyu
         pinIWfdUrHJUREDcbk9EUdvtLVk/Jb01b//mJD0ipm9nS507NlC5pFhx9G4J97sCoCwt
         4UI3f+z1HCvawREGc62DCdjjZ+GUKBn3ZS/Apk1TulDFVwsQGQvBSRiuHF7I10glvH4A
         Q6nmdQ4m0o4Im12CQ3Q5Awv9HVoZd91O0rVrz7MvwCo40Fax7t2qW/yykIGH9grRGHJG
         DxxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+oPRr0H7wp8JgDexSQ+bVBgPwbDdEIXahOwuWxPiPoVmawQWdEu23L+ebEkoOqsoDoHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy67BHRxprs8ZSNA8ev+0GZPHAOku+MYokNJQN/pF9iy7YGG6RL
	4OzvEKtCiwBLsMHN6QnuxQunzoU7aOeRIcpl/FcOHgc8SDEZ2YuI
X-Gm-Gg: ASbGncscR+I901IZGLtlLJp+7YGKNPFN9tSLnf+fdHrazS1YLvrTA3dbnO8IPG8LAh0
	utGXMC4dD85pIh/p9MIUP6cfj6jf6YLWEpsSP1MyJk6jg7O8Fv1zUXXC/nIKii49ayCsIKiYlbS
	oXcHyizIrtOV3lO8YJr/WoIjspPtEcZlIfsSCUspgo2HhBpCBfSraZ5WYS6OOHzyVRkQ+OphXXK
	XIDZBFhj7crXaWaPcH15uMMEXbklXAVu5oGmTWg18muxhh0PuZu80WazILknjtStHab86C0VQUG
	wyoIxTWcwv4KJbUi09OOY/a1+M2cUeZfcD/wup9b0i3h9XDRXQ25
X-Google-Smtp-Source: AGHT+IH6uHiRsW+AJipq5aSajQnaNoo1dXFOvNV9qS8F7Eum2YfMQBxUj9tvYqYxM2AGDtuSA0kJKw==
X-Received: by 2002:a05:6a20:cd91:b0:1ee:b8bc:3d2e with SMTP id adf61e73a8af0-1f5c113735bmr12009663637.8.1742101781413;
        Sat, 15 Mar 2025 22:09:41 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115511cfsm5216002b3a.45.2025.03.15.22.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 22:09:41 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: gitster@pobox.com
Cc: 05zyt30@gmail.com,
	git@vger.kernel.org,
	Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v4 1/2] Unify capture of SMTP errors
Date: Sun, 16 Mar 2025 13:09:19 +0800
Message-ID: <20250316050920.3264895-2-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316050920.3264895-1-05ZYT30@gmail.com>
References: <xmqqsengn1ms.fsf@gitster.g>
 <20250316050920.3264895-1-05ZYT30@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change adds local variables $result and $error to store authentication
return results and exception information respectively.

In the eval block, different auth methods are called depending on whether
the SMTP authentication mechanism is specified, and true is returned when
there is no exception.

After catching the exception, the error information is saved. This makes
the error capture logic more centralized and easier to understand, and
lays the foundation for subsequent expansion.

Signed-off-by: Zheng Yuting <05ZYT30@gmail.com>
---
 git-send-email.perl | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 798d59b84f..8feb43e9f7 100755
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
@@ -1431,25 +1431,32 @@ sub smtp_auth_maybe {
 		'password' => $smtp_authpass
 	}, sub {
 		my $cred = shift;
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
-	});
-
-	return $auth;
-}
+		# NOTE: SMTP status code handling will be added in a subsequent commit
+		return $result ? 1 : 0;
+	}

 sub ssl_verify_params {
 	eval {
--
2.48.1
