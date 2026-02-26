Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9142C3290A3
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124980; cv=none; b=DuMRgdUWLWqVhBGBx3TX3D/F/AxSVziMt1DGNj/dtjkOmxH3HerAbBbJmZcd8XqumFGolmBMmM20aht21tGAmRG+yQwmw1mry7uFHXtgc2qLXX3jNbEAB753FbNpSxDz+g7iC1jMP3ywaWqSMCxMgpq0pKQKl7os+EDDEWftIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124980; c=relaxed/simple;
	bh=B2uIq/DFe2GaTxiohcOSHNcgfB2UgDAv9Dxd2fGUXUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dq/U8fXmPoYla5rHCgzMjgQeE+/LQSpfoEwZncBrErtXGWDfivB54YQar/jlhu+sn+XVzU5pdm8yZdiUHMlQlX7V+ckK44TPRRNwD/taqHRMKAPNtQcjP4N9I8hlkMCsPmHKGJVevoFLHQPHxn2XQTKlOOyXnMXAChzj879PCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0pJc3TL; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0pJc3TL"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35851eadc17so621096a91.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 08:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772124978; x=1772729778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJJtTPg6P1d4SopxumdMJ67vYATSDF7J9paoHOiL+U8=;
        b=V0pJc3TLAhGYUttvJBxJxzTDEaZ6hL0Cn8Io6TLNo/ZT69cAub1bLapKr7nrpt1z1W
         U1++dZV3ZZNlx8pffhuKH4XX6AL1hGretAHxK50Zc9VrqnA2hJoBHKB5LDeVt9YIciK1
         UbIQAZgNLaQKwi303mPO05SmsRy94IakJTQI+RJ4N0C6mejaqHxeQp6icXGsD9QPkT1E
         jPOiJbBYhneH1t+FH+Oc48J6xzw2EFrTKQokeCuqIG9zXWw03h8NjmbIgtXInikeCSOD
         0Q5XT7zbnXVhet4+MhYnIRTo3zqsarPa0sWxPs/BZTK0lPM8+Z86yY1PLGDBSm8npoJU
         xWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772124978; x=1772729778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yJJtTPg6P1d4SopxumdMJ67vYATSDF7J9paoHOiL+U8=;
        b=kAf2vIu4mdsNEcs17HpRG7sVc8AqTewBcX4fKFJ6w7skHWgRtwixO4kFPGcv+J1/rn
         MOVFkZApLlP7c8/SG7lWk3GXxKR7dmHctv8YqW6BBj6vg3ce8GxVtahFXCdlV5hG+LcV
         0Q355fL7hetNIJaTaT1pXheNHz0bQBzk8qUJiiTfxtHJ+G4XJ0ESwXD0BK0bPBzfNksP
         k2yWDvbscwgdxzf3UjnhAbz05o3jFvQAByFn2QNgc44i/875KQALvpgFi4IetqZFp4yb
         V1Xth2ZXZ87Eor3/rZ9OHVzS5O4stECbhfZfP3FKWDZj4ZB2WHgtz7ZF3GApghwjP6Gn
         kMuQ==
X-Gm-Message-State: AOJu0YwX8M8CX3Z7QoH7NTlWLJUYL+6B5pNnAaX9xhQrI7f8pwDX0nZ4
	fv+npKbwEAhntyaOoFhyiitq/63eLb5xNKJLur3QgWyGIeCNM38eOXPwXV+P3w==
X-Gm-Gg: ATEYQzwG52yyYeY2xvtpwzuhopM5w2Qkfju2XLgGwPgFv8UdEUhOrk2OMW6tbq+ER7U
	o/8zMySITQ9nP7n0QSq+x6aJHd7CxVrc/kaCH31qneuKC0bOgCVJnZEjKn8a3UKmTXM+Ta6nSZt
	Bkr47OCVoGeo83n1gQv4HpyKLu4ToPDU6tel6bSVeq0CxVCNq7rc3dO9Iy1KZcZ0lx22sgwMlM2
	3zfY80THBD5v0zuqY3gsoiLFjgbpl/b8i9Tlo3DlwgBEQ/gwvQFtg7xVqSU9zf4E0lDQyWDMXDW
	DhOthsXP2nFVk48d4HNsIC4HW94/6WDE6P892QZknTmjgLjTWaC0vAm2WXcr25GKlyk4BIbQ+VC
	N3NP6wAFYUlU/wUrDCNrF/Nc6NVcLt/mVdGwedZSlIymgSR3PaoGarJ0BAmP+haYALknUmaM2YL
	FdQHFLpS2UJJalAkyibQscJVckqlY9ltV5KeU5egU/C47YRtOLEvvjmCjwJjI=
X-Received: by 2002:a17:90b:1f86:b0:354:9b26:cdf7 with SMTP id 98e67ed59e1d1-358ae8121camr20346322a91.14.1772124977618;
        Thu, 26 Feb 2026 08:56:17 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:5354:a570:7b23:3daf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593dcad237sm3006692a91.3.2026.02.26.08.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 08:56:17 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	gitster@pobox.com,
	philipoakley@iee.email,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v3] send-email: validate charset name in 8bit encoding prompt
Date: Thu, 26 Feb 2026 21:46:34 +0530
Message-ID: <20260226165559.187261-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0.154.g7c02d39fc2.dirty
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

Introduce a dedicated helper for confirmation handling that can be reused
both by ask() and the custom 8bit prompt flow. Make the encoding warning
logic specific to the 8bit prompt, this reduces the load on ask(), and
improves maintainability.

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
 - Added a helper function confirm_ask() to handle yes/no confirmation prompts.
 - Added the validation and warning logic in the 8bit prompt instead of ask().

 git-send-email.perl   | 36 +++++++++++++++++++++++++++++-------
 t/t9001-send-email.sh |  2 +-
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index cd4b316ddc..3230b80701 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -23,6 +23,7 @@
 use Git::LoadCPAN::Error qw(:try);
 use Git;
 use Git::I18N;
+use Encode qw(find_encoding);

 Getopt::Long::Configure qw/ pass_through /;

@@ -984,6 +985,18 @@ sub get_patch_subject {
 	}
 }

+sub confirm_ask {
+	my ($resp) = @_;
+	my $term = term();
+	return 0
+		unless defined $term->IN and defined fileno($term->IN) and
+		       defined $term->OUT and defined fileno($term->OUT);
+	my $yesno = $term->readline(
+		# TRANSLATORS: please keep [y/N] as is.
+		sprintf(__("Are you sure you want to use <%s> [y/N]? "), $resp));
+	return defined $yesno && $yesno =~ /y/i;
+}
+
 sub ask {
 	my ($prompt, %arg) = @_;
 	my $valid_re = $arg{valid_re};
@@ -1008,10 +1021,7 @@ sub ask {
 			return $resp;
 		}
 		if ($confirm_only) {
-			my $yesno = $term->readline(
-				# TRANSLATORS: please keep [y/N] as is.
-				sprintf(__("Are you sure you want to use <%s> [y/N]? "), $resp));
-			if (defined $yesno && $yesno =~ /y/i) {
+			if (confirm_ask($resp)) {
 				return $resp;
 			}
 		}
@@ -1044,9 +1054,21 @@ sub file_declares_8bit_cte {
 	foreach my $f (sort keys %broken_encoding) {
 		print "    $f\n";
 	}
-	$auto_8bit_encoding = ask(__("Which 8bit encoding should I declare [UTF-8]? "),
-				  valid_re => qr/.{4}/, confirm_only => 1,
-				  default => "UTF-8");
+	while(1) {
+		my $encoding = ask(__("Declare which 8bit encoding to use [default: UTF-8]? "),
+		valid_re => qr/^\S+$/,
+		default  => "UTF-8");
+		next unless defined $encoding;
+		if (find_encoding($encoding)) {
+			$auto_8bit_encoding = $encoding;
+			last;
+		}
+		printf STDERR __("warning: '%s' does not appear to be a valid charset name.\n"), $encoding;
+		if (confirm_ask($encoding)) {
+			$auto_8bit_encoding = $encoding;
+			last;
+		}
+	}
 }

 if (!$force) {
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

Range-diff against v2:
1:  954c1dae9f ! 1:  748bb03a00 send-email: validate charset name in 8bit encoding prompt
    @@ Commit message
         When a non-ASCII character is detected in the body or subject of the email
         the user is prompted with,

    -      Which 8bit encoding should I declare [UTF-8]? foo
    +            Which 8bit encoding should I declare [UTF-8]? foo

         After this the input string is validated by the regex, based on the fact
         that the charset string will be minimum 4 characters [1]. If the string is
         more than 4 letters the email is sent, if not then a second prompt to
         confirm is asked to the user,

    -      Are you sure you want to use <foo> [y/N]? y
    +            Are you sure you want to use <foo> [y/N]? y

         This relies on a length based regex heuristic check to validate the user
         input, and can allow clearly invalid charset names to pass if the input is
    @@ Commit message
         validation the lenght based validation becomes redundant and also breaks
         flow, so change the regex of valid input to any non blank string.

    +    Introduce a dedicated helper for confirmation handling that can be reused
    +    both by ask() and the custom 8bit prompt flow. This makes the encoding
    +    warning logic specific to the 8bit prompt, reduces the load on ask(), and
    +    improves maintainability.
    +
         Additionally, the wording of the first prompt can confuse the user if not
         read properly or under any default assumptions for a yes/no prompt. Change
         the wording to make it explicitly clear to the user that the prompt needs a
         string input, UTF-8 being the default.

    +    The intended flow is,
    +
    +            Declare which 8bit encoding to use [default: UTF-8]? foobar
    +            warning: 'foobar' does not appear to be a valid charset name.
    +            Are you sure you want to use <foobar> [y/N]?
    +
    +    [1]- https://github.com/git/git/commit/852a15d748034eec87adbee73a72689c8936fb8b
    +
         Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>

      ## git-send-email.perl ##
    @@ git-send-email.perl
      Getopt::Long::Configure qw/ pass_through /;

     @@ git-send-email.perl: sub get_patch_subject {
    + 	}
    + }
    +
    ++sub confirm_ask {
    ++	my ($resp) = @_;
    ++	my $term = term();
    ++	return 0
    ++		unless defined $term->IN and defined fileno($term->IN) and
    ++		       defined $term->OUT and defined fileno($term->OUT);
    ++	my $yesno = $term->readline(
    ++		# TRANSLATORS: please keep [y/N] as is.
    ++		sprintf(__("Are you sure you want to use <%s> [y/N]? "), $resp));
    ++	return defined $yesno && $yesno =~ /y/i;
    ++}
    ++
      sub ask {
      	my ($prompt, %arg) = @_;
      	my $valid_re = $arg{valid_re};
    -+	my $warn_invalid = $arg{warn_invalid};
    - 	my $default = $arg{default};
    - 	my $confirm_only = $arg{confirm_only};
    - 	my $resp;
     @@ git-send-email.perl: sub ask {
    - 			return $default;
    - 		}
    - 		if (!defined $valid_re or $resp =~ /$valid_re/) {
    --			return $resp;
    -+			if ($warn_invalid) {
    -+				if (find_encoding($resp)) {
    -+					return $resp;
    -+				} else {
    -+					printf STDERR __("warning: '%s' does not appear to be a valid charset name.\n"), $resp;
    -+				}
    -+			} else {
    -+				return $resp;
    -+			}
    + 			return $resp;
      		}
      		if ($confirm_only) {
    - 			my $yesno = $term->readline(
    +-			my $yesno = $term->readline(
    +-				# TRANSLATORS: please keep [y/N] as is.
    +-				sprintf(__("Are you sure you want to use <%s> [y/N]? "), $resp));
    +-			if (defined $yesno && $yesno =~ /y/i) {
    ++			if (confirm_ask($resp)) {
    + 				return $resp;
    + 			}
    + 		}
     @@ git-send-email.perl: sub file_declares_8bit_cte {
      	foreach my $f (sort keys %broken_encoding) {
      		print "    $f\n";
      	}
     -	$auto_8bit_encoding = ask(__("Which 8bit encoding should I declare [UTF-8]? "),
     -				  valid_re => qr/.{4}/, confirm_only => 1,
    -+	$auto_8bit_encoding = ask(__("Declare which 8bit encoding to use [default: UTF-8]? "),
    -+				  valid_re => qr/^\S+$/, confirm_only => 1,
    -+				  warn_invalid => 1,
    - 				  default => "UTF-8");
    +-				  default => "UTF-8");
    ++	while(1) {
    ++		my $encoding = ask(__("Declare which 8bit encoding to use [default: UTF-8]? "),
    ++		valid_re => qr/^\S+$/,
    ++		default  => "UTF-8");
    ++		next unless defined $encoding;
    ++		if (find_encoding($encoding)) {
    ++			$auto_8bit_encoding = $encoding;
    ++			last;
    ++		}
    ++		printf STDERR __("warning: '%s' does not appear to be a valid charset name.\n"), $encoding;
    ++		if (confirm_ask($encoding)) {
    ++			$auto_8bit_encoding = $encoding;
    ++			last;
    ++		}
    ++	}
      }

    + if (!$force) {

      ## t/t9001-send-email.sh ##
     @@ t/t9001-send-email.sh: test_expect_success $PREREQ 'asks about and fixes 8bit encodings' '
--
2.53.0.154.g7c02d39fc2.dirty
