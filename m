Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1139C627
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943823; cv=none; b=ctIbHqpIWWMLMIbptaNseMka8ka3MAmnE0gGAAc+AEU4M8MV/smNT00qI+9qK4CuUVf4Oc6fg8gpRAswc7WA0pkKMxmmEvN1QGOx0U9IuNnh0xfyVEegWJj1lhxMJmCzp/L/tyOJJlqHQq9kLGimtc6rdfPxt2IOzIyQEzqLxwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943823; c=relaxed/simple;
	bh=qMxzngOLmdMVRtlgZPpz+XXv3NxKVH4guX6DkuEJ4Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9DYxkhdPMK16kAhN9//WV8QLaYZJa5VzZgT6yMC63L8jMKB+jQ/vQq3ZajP62QM8XPYKBcwrCYWAr9f3CUQcue9gQEzAEeKOKKd0Xs3ua3eOKKlHvmY5bWWHDitPmf/QBJEk59Sa9BSfpaXbYoz+ofendk7ycTsXsnzMtACBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bq+VO4nU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bq+VO4nU"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aadc18f230so34373255ad.3
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 06:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771943821; x=1772548621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoSvYlglYT66pOu5LurpDApiym5caENIZGaLpbsZ/ew=;
        b=Bq+VO4nUWc4RbJXA0iqyE8Xi8ZrPVTXfdo93udLkSEnvakR/Ui4Htx4QtVHoSNmIV+
         BWSZnpDCqPa4JnBtaHtuXd4G7a+W3//PnLNcqSM/AYPF9X4MRoM5U8xNe7D1NoF0jm2m
         mkGtIwJ/SGBNRbJUwm0lpBdkufnZcAgtmab5fth65WGkNk3vQOK+D8Ym/Uc5mGWyDIOC
         6UTo0RJDrX4IhxSW4S+hjAn4j6xBi87nsgmHXOyN8yokhh73t7Eb71vaoF95+VOKKht0
         jrmkXRGMWPJjIMh6f3fo98KXy5+9Kan+WqbD1lNTbNYT5d7NBzo4JeVX0tT1nPybnFhE
         Bf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771943821; x=1772548621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IoSvYlglYT66pOu5LurpDApiym5caENIZGaLpbsZ/ew=;
        b=Z1ASwhtaSOvPTACVI7lJSxo/4E6GE+xzBxv0YOOrMRg5bzV/bQOVE9lIwHnIlxJPwu
         aoroEpAPq5CehxFfAJiGURqKyl4ZC1dC9UGlqNq/oV7qynMjxwGZjsxUozjm7kiCHMJp
         YPTh3mVsufe7nWU8KilnrG4e+K3l5l503PW1JpUeeElanRiUVZF+SrvEGg86rfussSSX
         ib9nPZFYqqAOpykOZWjxtkNpFGQ99apXsiGBwA2+7zgnsGfxxxDIhau3t2JfkVM+2m8N
         r/onsnpEw6gxob7Z53HqzSVKQJZrEsxu2XMgP2rXQzmg941fal8fAvTn/IFVybzR3QFe
         PUlA==
X-Gm-Message-State: AOJu0YxKWf1nWxW+TrniBG+SWX+EULKjOQczMzUhgbRmdF6XjSOewMfo
	yE1UPPkD1Z9/EGvPEYibPewRY207iLUPufD5/DNJJ/MnpZREiaffp3bKZOWhAQ==
X-Gm-Gg: ATEYQzySU2UJdjcr/g3oqzbhu47A5peMZV0OPB980gYVqj7wuGjOSRABNZEk+cg9RSX
	Xw34hSix97WMAyBwdfBokZWCo2bnTmtKuuekeeSRNNhGfhlfGH9kyJrXQ1PNkfN5mAHZyaBzZSz
	rh9+ttRzYRz42qeYXYFeFA2cLSK6/HM3QNyHGy0iRJECQH8LdTTA+R876BCy4/fbqVdgs7Nkl7G
	jQvMv/XgaE3j6RCZ4W8Yb7W0GWgm3Mw15MgsCUfQLz9njiWP6Lc/vqwc6hBuaG8E+qxlAWk0N1X
	MEU2ISCdbPjAObDumTGauaezzi4AZUoAQjhjGIHybbkBNk95NfxAHq3L6S522eLLj4QoGXnRP9N
	jQvy2iMzdMgC4G+8hxxp6b5DyrQ3uroQQL0hLZTW6hC4iHN+zz8OHhMZjPfG3IASyGm56qgspY1
	PXAM5hvpxD5FsK1Fk6IQbpj7Htf+1r+ajZGKje4zMlmq8XGkSYHv5i+d7yHRCJAllYg6rZ
X-Received: by 2002:a17:902:e950:b0:2ad:ba7e:904b with SMTP id d9443c01a7336-2adba7e9197mr4082625ad.22.1771943820743;
        Tue, 24 Feb 2026 06:37:00 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:4f6d:51a:7183:89a2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7244dadsm11239936a12.20.2026.02.24.06.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 06:37:00 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	gitster@pobox.com,
	philipoakley@iee.email,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH] send-email: validate charset name in 8bit encoding prompt
Date: Tue, 24 Feb 2026 20:03:52 +0530
Message-ID: <20260224143624.23678-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g35e93594f7.dirty
In-Reply-To: <20260220145126.131651-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260220145126.131651-1-shreyanshpaliwalcmsmn@gmail.com>
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
input, and can allow invalid charset names to pass if the input is greater
than 4 characters.

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
 git-send-email.perl   | 15 ++++++++++++---
 t/t9001-send-email.sh |  2 +-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index cd4b316ddc..dc4e5418d3 100755
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
@@ -1005,7 +1007,13 @@ sub ask {
 			return $default;
 		}
 		if (!defined $valid_re or $resp =~ /$valid_re/) {
-			return $resp;
+			if ($warn_invalid) {
+				if (find_encoding($resp))
+					return $resp;
+				else
+					printf STDERR __("warning: '%s' does not appear to be a valid charset name.\n"), $resp;
+			} else
+				return $resp;
 		}
 		if ($confirm_only) {
 			my $yesno = $term->readline(
@@ -1044,8 +1052,9 @@ sub file_declares_8bit_cte {
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
-- 
2.53.0.155.g35e93594f7.dirty
