Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8F656B7F
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442969; cv=none; b=RpJd3oiGzQuIk+RuTF77IeYWIOUQCzFG3NQ/IaxMuVyx0Ybe6q3i0oYc/eZat5sg1JNhjqwzhbce9gBPfPpetanznE2FYFEz5+nDI61Ix/TjEmB6j5hnLtDR0oWB9L8vMt//1FIv6M1f85kUDWmWCiGGoAusMKC5QfUcCHCjdMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442969; c=relaxed/simple;
	bh=v9fi1NZIhp1xi1G7evsRiRRy0PGycUDBhZ7s0X9mq6w=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JAtt0MY36FgnUFyOCzqZckJWz035sp7XEF9J6qK21/ehoUy3qF+BR8GryEXL2GdjMv/sbfhUAPsVXDyCmB4c1Ddd98AzxfFb12aZRGQPrrjkYH77N/tnOMFkoy7CPXdqg3nC7S8ClQ3+5eCrBI9aJ5qcKghoYqcANuAemWV9gqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=UVPyZCKG; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UVPyZCKG"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ddee0aa208so4900751a34.3
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705442966; x=1706047766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+XPN8KT3cfPkEbL9Y2+Wb2qHbLtIeC9qIuXubwQUSec=;
        b=UVPyZCKG/fzlz4x4KExOohctgNqylAkcZUpPXnc93SWZrVKfzCKtl38uxvKLKzg5RL
         OEp8FGP0NIgFf6CSVJn8g387rs2MoUOdPyqF19j7wI3d1YkfAQDfmD8+pAmdrB5Cy6rw
         2h54HEAncJI65MLBdPH0Dsr7w6xGLw31eS4zXuWudUeo5OxhWi7tE83vtFg8iXxFBshW
         plkFHwBZGL9TviOLGDxaALW0cT7s12ZCZn1Y5+v+mZG6Qliz6h/r6aldMJbrV9zRK8En
         lHY/KpvRzt0Om0m9yCB+g1eUwVw3cH3zJ8+Td+P8T2IDPMdg9IEQq6nmUl6oTIKNcUTD
         K+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442966; x=1706047766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XPN8KT3cfPkEbL9Y2+Wb2qHbLtIeC9qIuXubwQUSec=;
        b=EHkEneMr+8M/pIQuwudj07VlU63a2l6CuSQ0ojuFGQ/ecteSz3z5WMJ3za55UakpaT
         WaY0AG+WeJGWDhhnAqeh5v2kvgFciINmD+IzsoJFkdv7yA/Ohkfo9VdgWB3Jum3nehvb
         uWM9Fikfrjfu7GeRgzrE+ip/s7PDP5m5+vcNgymUFsZrOWS+Xq5Om1wKzAlC6CNuo4Gk
         THMaoonEqeTZWT8F9AOh69IQAwWLeS0Ok+3TNznemMc5x3TouRON4jmjEHeaxRFpWDAq
         GnRhqDPdKWWU7Vj9+zgt+76CPCNT6YIP4zzBKvpv0lzptT43VJp2NMVWg9h4/FWsNf3a
         V93w==
X-Gm-Message-State: AOJu0YypDTHFLOyZCGL1JPK83qDDQuoMyH3MKeSwYpZ4ecu6baxKJ7Hy
	Gx9w8lVj8MtVZxiCZuTwAjGGvzQLP42HM56OdhuwYhHachOzig==
X-Google-Smtp-Source: AGHT+IH7o974iCc1FrobWUaxvTu0gn9G0LhfcU8KfoHVjCU++U1qS3l7luB5JEgreTVv01KBUDp6wQ==
X-Received: by 2002:a05:6830:b:b0:6df:b685:978 with SMTP id c11-20020a056830000b00b006dfb6850978mr8494331otp.35.1705442966772;
        Tue, 16 Jan 2024 14:09:26 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b19-20020a05620a119300b007832575779esm4013031qkk.52.2024.01.16.14.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:09:26 -0800 (PST)
Date: Tue, 16 Jan 2024 17:09:25 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v5 08/17] t4216: test changed path filters with high bit paths
Message-ID: <aa2416795da980cf5ef1000a3dfc1bc04fa7710f.1705442923.git.me@ttaylorr.com>
References: <cover.1697653929.git.me@ttaylorr.com>
 <cover.1705442923.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1705442923.git.me@ttaylorr.com>

Subsequent commits will teach Git another version of changed path
filter that has different behavior with paths that contain at least
one character with its high bit set, so test the existing behavior as
a baseline.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t4216-log-bloom.sh | 51 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 20b0cf0c0e..484dd093cd 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -485,6 +485,57 @@ test_expect_success 'merge graph layers with incompatible Bloom settings' '
 	test_must_be_empty err
 '
 
+get_first_changed_path_filter () {
+	test-tool read-graph bloom-filters >filters.dat &&
+	head -n 1 filters.dat
+}
+
+# chosen to be the same under all Unicode normalization forms
+CENT=$(printf "\302\242")
+
+test_expect_success 'set up repo with high bit path, version 1 changed-path' '
+	git init highbit1 &&
+	test_commit -C highbit1 c1 "$CENT" &&
+	git -C highbit1 commit-graph write --reachable --changed-paths
+'
+
+test_expect_success 'setup check value of version 1 changed-path' '
+	(
+		cd highbit1 &&
+		echo "52a9" >expect &&
+		get_first_changed_path_filter >actual
+	)
+'
+
+# expect will not match actual if char is unsigned by default. Write the test
+# in this way, so that a user running this test script can still see if the two
+# files match. (It will appear as an ordinary success if they match, and a skip
+# if not.)
+if test_cmp highbit1/expect highbit1/actual
+then
+	test_set_prereq SIGNED_CHAR_BY_DEFAULT
+fi
+test_expect_success SIGNED_CHAR_BY_DEFAULT 'check value of version 1 changed-path' '
+	# Only the prereq matters for this test.
+	true
+'
+
+test_expect_success 'setup make another commit' '
+	# "git log" does not use Bloom filters for root commits - see how, in
+	# revision.c, rev_compare_tree() (the only code path that eventually calls
+	# get_bloom_filter()) is only called by try_to_simplify_commit() when the commit
+	# has one parent. Therefore, make another commit so that we perform the tests on
+	# a non-root commit.
+	test_commit -C highbit1 anotherc1 "another$CENT"
+'
+
+test_expect_success 'version 1 changed-path used when version 1 requested' '
+	(
+		cd highbit1 &&
+		test_bloom_filters_used "-- another$CENT"
+	)
+'
+
 corrupt_graph () {
 	test_when_finished "rm -rf $graph" &&
 	git commit-graph write --reachable --changed-paths &&
-- 
2.43.0.334.gd4dbce1db5.dirty

