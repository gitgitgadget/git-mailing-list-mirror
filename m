Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163A8330D5E
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771969190; cv=none; b=AKasA3dknQTZfZsI3HAXIgximmAErhodibvooW/egeCsmLwq2qRnkrSrPAmq7Xxw5yrjP34D6L50tvZftN4FGTruGxnYSjpPI2wLtqA2GiOZ/j0BeM/vvcMretFrNduoIMnBWEvWQyKaSWN/8ttDEi8oNf59uh+wU88zc0U7obo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771969190; c=relaxed/simple;
	bh=4/wYLaY7DZs15tIIac3Np5JsHvwGNknoHK8pLFqrGG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dP1Qdlu+xgEeMYk5uWHQypnT1mX2Ef3ChxSGdSNBEKcwFkFnQQd2pwSGco3ynBRyhl+bjpUzqX4I0WOyLvKPsHUWKshu+VgDx1D5jHuYNT3PMFs9VTTxcYUrWWYMQS1TuZYR/jF3OHNuY1QQl0RGHRqZ3wR4rJOxI6/FgM65oyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjOz+m4/; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjOz+m4/"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bde0f62464cso2296859a12.2
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 13:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771969188; x=1772573988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FybDoIzXWmBHRgR2NXAcF2TLbqLZKcpjErHri7cLe3g=;
        b=YjOz+m4/yMlQZJ7v49YrdGmVTBC2b6gPKFg91RuJyMap8SmAX35Jwjy6qWYi/WDliF
         wZrPIVEFDmwl0MKk9LJM8K3XEjOwwLMtACquLc6NTmDvVkjhpHBTmlG1RJF+3yc4mqEy
         6dD2tgV7zpfdaLOGjoB/MF8TiNn2B5LI/j/SH48aiBlap2uwXTd6SNtOzYRGCz8g9FoQ
         kiTHGFoWMwikns0fl0vghaBtTgOJuEHMVNdZNDQpALAY+8S7EjncesZEEE0DtnYJgHu2
         M2Vmtmwx20jh0x7SZrL27/81/ay5/3ritkxSiI9npaL+GM1f0kkcPzUK2PWJ3KzCi9UT
         mqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771969188; x=1772573988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FybDoIzXWmBHRgR2NXAcF2TLbqLZKcpjErHri7cLe3g=;
        b=hHqkhVPjYPBSqJeqj+VmWHCrPhDlr3MKfNDrAeKbUwOm+OWaGE7FeBi0R3xUT0c+vh
         +/pzXMbdD1mC+kB4SlCrTkvn4f4/FLmngM9prSU5KAib6LALJPt+/+3jITbae0D6mVlH
         9XkRcGlteVMzKs/9wdz0nwsR9YWmq9ifcfu1x/RfmOWHG6uuJk3sKQOaEFsQWDlX14WP
         M7XWk0w+Yb95BDG0la/a71jRT4rVNA4yAn7GMjfxmy4A5VI91rM4sqzlpqCFfbYZKXHq
         0dtBJYOJY7YlvAQCwYAAm8H9BJv+x9MVbbUvPWQmm/PPvZUOD2x1/Jmj0liC/eivrSu/
         bIUg==
X-Gm-Message-State: AOJu0Yxsk/q+qljq2WDE2sLf7aNOpc/JY0H/ceYFZrPV/PIM7BUIv9hG
	vQBTbE79uN0yJXDy/1rLWOpg/KZXZE8ZG1qKLCjDmg/9sfirgYdhyFJwOmzKmw==
X-Gm-Gg: ATEYQzzE1eX/Ld13dNhF30t+ZGuV2vt+PXlwI7Jw0FWAlVv1FneDmJRJTVpixpdWIgq
	Ec76MaCw77BNNZMm75TW7wo0Rhw1hdthNdfu2k76ArTfmJQ/u3ZsX1wsxnJjscF3AeuAzLHGjUm
	BWwVPYFoWJ/VuP1J5xvipKg/ZT1h1sLik21tVYXZ7Ni+8081phIhbzzwGGdX1X5dQPXMM+/xlFs
	YIRT4G/xLzk/g/dAEjJVuVFe6qlncDGhqzUF/hzPS60dvQcCqssIAdujHMua9dQ5n2pZYbo1+xX
	BDRCkCXKKEv8/PjYbAfKFEj/e6TkMC9aJ81UHgyHMUmsVTgQ+y6dgMRRhOTAR3trDcDsfK+3DgZ
	8lCkBdipIAHKm9yTilqWK4RTwoEavBrZswXfyxALrxa+9FAtxg4jZhkHo4uxJYmpIQc0BODrIn1
	HUrJkX8FfdGacZqqggB9fVkbUqT0d8ntp77hJ+QK8aScVwOo8y/g/I2/NdtyQ=
X-Received: by 2002:a17:90b:2885:b0:340:9d52:44c1 with SMTP id 98e67ed59e1d1-3590f2462e9mr96744a91.35.1771969188176;
        Tue, 24 Feb 2026 13:39:48 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:b842:6614:18b3:b64d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3590e7f1f84sm56859a91.9.2026.02.24.13.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 13:39:47 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	gitster@pobox.com,
	philipoakley@iee.email,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v2] send-email: validate charset name in 8bit encoding prompt
Date: Wed, 25 Feb 2026 03:07:39 +0530
Message-ID: <20260224213932.92364-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224143624.23678-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260224143624.23678-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a non-ASCII character is detected in the body or subject of the email
the user is prompted with,

  Which 8bit encoding should I declare [UTF-8]? foo

After this the input string is validated by the regex, based on the fact
that the charset string will be minimum 4 characters [1]. If the string is
more than 4 letters the email is sent, if not then a second prompt to
confirm is asked to the user,

  Are you sure you want to use <foo> [y/N]? y

This relies on a length based regex heuristic check to validate the user
input, and can allow clearly invalid charset names to pass if the input is
greater than 4 characters.

Add a semantic validation of the charset name using the
Encode::find_encoding() module of perl. If the encoding is not recognized,
warn the user and ask for confirmation before proceeding. After this
validation the lenght based validation becomes redundant and also breaks
flow, so change the regex of valid input to any non blank string.

Additionally, the wording of the first prompt can confuse the user if not
read properly or under any default assumptions for a yes/no prompt. Change
the wording to make it explicitly clear to the user that the prompt needs a
string input, UTF-8 being the default.

The intended flow is,

  Declare which 8bit encoding to use [default: UTF-8]? foobar
  warning: 'foobar' does not appear to be a valid charset name.
  Are you sure you want to use <foobar> [y/N]?

[1]- https://github.com/git/git/commit/852a15d748034eec87adbee73a72689c8936fb8b

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
Changes in v2:
 - Added braces in if-else block.

 git-send-email.perl   | 17 ++++++++++++++---
 t/t9001-send-email.sh |  2 +-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index cd4b316ddc..15387ac377 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -23,6 +23,7 @@
 use Git::LoadCPAN::Error qw(:try);
 use Git;
 use Git::I18N;
+use Encode qw(find_encoding);

 Getopt::Long::Configure qw/ pass_through /;

@@ -987,6 +988,7 @@ sub get_patch_subject {
 sub ask {
 	my ($prompt, %arg) = @_;
 	my $valid_re = $arg{valid_re};
+	my $warn_invalid = $arg{warn_invalid};
 	my $default = $arg{default};
 	my $confirm_only = $arg{confirm_only};
 	my $resp;
@@ -1005,7 +1007,15 @@ sub ask {
 			return $default;
 		}
 		if (!defined $valid_re or $resp =~ /$valid_re/) {
-			return $resp;
+			if ($warn_invalid) {
+				if (find_encoding($resp)) {
+					return $resp;
+				} else {
+					printf STDERR __("warning: '%s' does not appear to be a valid charset name.\n"), $resp;
+				}
+			} else {
+				return $resp;
+			}
 		}
 		if ($confirm_only) {
 			my $yesno = $term->readline(
@@ -1044,8 +1054,9 @@ sub file_declares_8bit_cte {
 	foreach my $f (sort keys %broken_encoding) {
 		print "    $f\n";
 	}
-	$auto_8bit_encoding = ask(__("Which 8bit encoding should I declare [UTF-8]? "),
-				  valid_re => qr/.{4}/, confirm_only => 1,
+	$auto_8bit_encoding = ask(__("Declare which 8bit encoding to use [default: UTF-8]? "),
+				  valid_re => qr/^\S+$/, confirm_only => 1,
+				  warn_invalid => 1,
 				  default => "UTF-8");
 }

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index e56e0c8d77..24f6c76aee 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1691,7 +1691,7 @@ test_expect_success $PREREQ 'asks about and fixes 8bit encodings' '
 			email-using-8bit >stdout &&
 	grep "do not declare a Content-Transfer-Encoding" stdout &&
 	grep email-using-8bit stdout &&
-	grep "Which 8bit encoding" stdout &&
+	grep "Declare which 8bit encoding to use" stdout &&
 	grep -E "Content|MIME" msgtxt1 >actual &&
 	test_cmp content-type-decl actual
 '

Range-diff against v1:
1:  70fa4d2899 ! 1:  954c1dae9f send-email: validate charset name in 8bit encoding prompt
    @@ git-send-email.perl: sub ask {
      		if (!defined $valid_re or $resp =~ /$valid_re/) {
     -			return $resp;
     +			if ($warn_invalid) {
    -+				if (find_encoding($resp))
    ++				if (find_encoding($resp)) {
     +					return $resp;
    -+				else
    ++				} else {
     +					printf STDERR __("warning: '%s' does not appear to be a valid charset name.\n"), $resp;
    -+			} else
    ++				}
    ++			} else {
     +				return $resp;
    ++			}
      		}
      		if ($confirm_only) {
      			my $yesno = $term->readline(
--
2.53.0
