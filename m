Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00533E9292
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936415; cv=none; b=BXHu+9UfF3rbmDitQFl8MsqMzDnzW19qxfwkUoiCwi2Yb6Yhe7N1GYnEjFWSOpY9FcIJ38EBU+z4RF9Sgv77L6xZxT+4oT4vcRs7THW0U8v5mlQmtVUxKsr35T4V+cSIJL+7zIxixmTUExay5/lDbjurVCC9hbT1EQMGHm63LbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936415; c=relaxed/simple;
	bh=jMqeNiH61/jGQH9rmORkEDFftkU8m17s1w65XJtHM+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tdgvg0toPjs3pgOKaSaCcGmKtujNdJg05sxYFtl9K0ppkl/MTYXxiTkgY1LJ5Vrwaw9FhGCB68RrsHNlWditfV62vVyjI5ENIByHcleoW2+NTHfy9D/+0mQVEOexBqcEE2otcqAFjsL58YCtybxv53qNuzs4CmkXvUtIHpy+Ij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ppg1UH2x; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ppg1UH2x"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d7447778b9so554225a34.2
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 09:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773936413; x=1774541213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L5Q+4Ed+m+HBTyQXDiTxemPD/y34eFXpbKsgmm8E9BY=;
        b=Ppg1UH2x8dw+RvQ6+90ZtNYqp2Pk6hyJ6N7QetJPKucBGcIhq/oeoK+rsHLkiBl2tg
         XPEwIklpuxXUtj74ZOXUUZ1Fw7C8tU7mWsQh+s9Gi1gsble1qH29f86Y46bkkxNlDf+a
         XNGzMrpyveVRxYIYD/v0FqDkhbNzDisFL/b7p6R/gvqDAMNapT0KxzG4KV3TTrv3/Slu
         vCUbBrACiAlYMJ1Wg7fAoH9BkOGkFbZ7YOzffAjQG3HDDgz8g5TG9XdMer9QYoftLfne
         hMQT4B3clifw6beonOU9zzTs5v1bvUoKNq6oA8CvsyMkd4YvcwwJ0agqxRRrWKdWEFTt
         epLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773936413; x=1774541213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5Q+4Ed+m+HBTyQXDiTxemPD/y34eFXpbKsgmm8E9BY=;
        b=OeBMZ5duvq+TU0xF+msHvtNKfdiOX5S/Q6bjbBFlG0HWihdE88onHmTau8+IwRNelc
         3nCS16UYwtrJayF6FGfqktEzcNo48YSCVwzzf3vqXJn5dpviC7BNmYrtdchYLR+8Y0jv
         Zluk0JFzubVzJEKZ8/TvQ+GEIhHokwezSWoxauJtwZT55+oaxjOY35sDKhg/b3Kxa+Zh
         +sa6Ikl9QDdNu3NbPwjAYE7XTuvRRHJYYXcu103aPYGwIkMmWHd7yRhB9D4YruSjYSda
         CF4HpacrRqi1hkUv3XVpiMvmcoVnxAPah1S+nzmJ7lyDJJzhTXI6/GxQg5N9tLpcGasw
         4Ukw==
X-Forwarded-Encrypted: i=1; AJvYcCVrVmZwsZRHLVeSqtmiy4EIcZHUIYoDPqRP0pRk8KHnTtDvI7PoAGiiAFC9t60cLRMhQ1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRdmRCml5DsMpyIWatf+gkis1aVfdajHHrhJhQ2fOEzlhRl4mN
	LTwLzrFgIxG5ciM0q2ZcjstUyUy2wKWLfOZonr0cS80EffFV60Qc4k/J
X-Gm-Gg: ATEYQzwNfkdsdojIBZVHRWjLjVJEB+9C+i6sIGR2ytdv9GMBR25ToLpy3R5gSyrZdtm
	roo32I4VtorkDTOIxipACDUYxN4Qs+DwfmDtWpFcNKhylTcof3Dcpvhs5733jXL2PK635HWEnor
	E860hlYBrtFwFohUp58O8BU9lKklmUde6E1fOPxrgPmbDeQoEuYtNdU/CyFB9+o8Cz2nCboNfT2
	xlAJjdMvzkon+/gaSyICXgPRed6llWW411ZVdXGkAnjmZOvQ+sFQAkCRT3E45VvT1SU+vagxItJ
	on4QCWSZUxVD9/0goodWBJXrnXWyn51Hdd8eKy/T0VqmxS22Evzpmk8v1osYHUb1bp5vcTYx71B
	6HYmL5KXKaPGPb9DBYNqE2vXov+kXFMiqLiBvMZWiB9bUPbtGYq0IQebk0GtUHfMeOhyis5bg6i
	tqzzEatOLHQDXl/irj09VzuR/SnTUfoMnosyC2XjmnUlk9GSw7
X-Received: by 2002:a05:6830:67d6:b0:7d7:c987:5d00 with SMTP id 46e09a7af769-7d7ca57066bmr4832644a34.12.1773936412535;
        Thu, 19 Mar 2026 09:06:52 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7d7e23e0aaasm1094599a34.17.2026.03.19.09.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:06:51 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: joe@perches.com,
	linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH 1/1] get_maintainer.pl: add --cc option to produce comma separated list of emails
Date: Thu, 19 Mar 2026 10:06:33 -0600
Message-ID: <20260319160633.1149562-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This new option works as follows:

  git send-email --cc=$(scripts/get_maintainer.pl -cc 0*.patch) 0*.patch

A complementary patch has been sent to git@vger.kernel.org, allowing:

  git send-email --cc=scripts/get_maintainer.pl 0*.patch

send-email recognizes that its single arg is executable, and runs it
in a subshell with --cc @ARGV, eliminating the chance that the user
forgets options and arguments.

It also does the same for --to and --bcc, in case get_maintainer can
usefully distinguish who should get the to's from the cc's.

cc: git@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/get_maintainer.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 4414194bedcf..6c9ca793fd6e 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -48,6 +48,7 @@ my $email_remove_duplicates = 1;
 my $email_use_mailmap = 1;
 my $output_multiline = 1;
 my $output_separator = ", ";
+my $output_cc = 0;
 my $output_roles = 0;
 my $output_rolestats = 1;
 my $output_substatus = undef;
@@ -265,6 +266,7 @@ if (!GetOptions(
 		'moderated!' => \$email_moderated_list,
 		's!' => \$email_subscriber_list,
 		'multiline!' => \$output_multiline,
+		'cc!' => \$output_cc,
 		'roles!' => \$output_roles,
 		'rolestats!' => \$output_rolestats,
 		'separator=s' => \$output_separator,
@@ -320,6 +322,15 @@ if (!defined $output_substatus) {
     $output_substatus = $email && $output_roles && -t STDOUT;
 }
 
+if ($output_cc) {
+    $email_usename = 0;
+    $output_multiline = 0;
+    $output_separator = ",";
+    $output_rolestats = 0;
+    $output_roles = 0;
+    $output_substatus = 0;
+}
+
 if ($sections || $letters ne "") {
     $sections = 1;
     $email = 0;
@@ -1096,6 +1107,7 @@ MAINTAINER field selection options:
   --bug => print bug reporting info if any
 
 Output type options:
+  --cc => print comma separated list of all emails
   --separator [, ] => separator for multiple entries on 1 line
     using --separator also sets --nomultiline if --separator is not [, ]
   --multiline => print 1 entry per line
-- 
2.53.0

