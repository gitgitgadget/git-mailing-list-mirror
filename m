Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA0A135A69
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337192; cv=none; b=Y96ZMl+JNm8ETQzhhJAyyqcEH1IYFGBosoZ+K1CQB5dLqqMiKJZTdrfIbN7Hvv9Qy0/B5M0zMCbjStZLAhr1fJe8CM4H4ql03ntidy5UxwrXD4oDJfjPSBELDDJ5llDOK21KtAUOQXe4WMmqPhy4pCshGQnztXczOUQy5pIhWdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337192; c=relaxed/simple;
	bh=HExtNAt9qYRbWRrnHaRceTp9U99VKjMNV2WtjBjXqs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWB/1LclAvl3+d2tz0+W4EJ5bVhnQcbcnfqUBEXo2guhbpUZGFdScLiwqvC2LW7SQR0e0gBx71La1HD4o6VVm5SiPUeQgeLcX4S9vGNoiTrVDCls0nk56WytDeCJUTo/+VDbb83sqUrAfjQYoHmA7yHY59pUaz2NtPwFd7Ep/3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=j672Hb6A; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="j672Hb6A"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79c0b1eb94dso39927685a.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1719337189; x=1719941989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Vs3tnu4meWjmIYRJ7lDBRU6mz410QWbZZuo9HFZiQ8=;
        b=j672Hb6ArQYKrutEydBAbCOnBrynTTqoQEWTjP11yWx9NerUSwHn/cjoDgUtg1VCPl
         iN2hM1eXMPpOBvHuNin0dW/cFu7HEBY/A5QcgFm7QzZ/pQ7VkQGuTpxo9NNLFsg5bRzM
         jNMLNCxNeO6Lf7KVaofoXgSEIS6nMG8zac/CYEmM+EFQal4N+WByDimLHPjj2olC6IL0
         p8WYEEdbJcsUShjGPB47TmqtgVohjSI4yaemzcHfcnymUzlFM33y6PcKDelI1PyIuu7B
         i8P0fL3sSRNRbazServZvhCF6dyFwXW2CT1cGq4Zos5OXvmR4u604XvWA7I+55ZguMow
         uoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337189; x=1719941989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Vs3tnu4meWjmIYRJ7lDBRU6mz410QWbZZuo9HFZiQ8=;
        b=OpTQ81i5eTiNn84S15c3nZAx4GhiSotq4g5ZugQswjvHpbXmipE316SZ16OL7szMPc
         BOvizL6pIYUXxyBiLCNsydegJTeSl15VB1sAl/NIehIJLWiLusRc75D5B/Qa5ET+GHB5
         927Ug52dZ05BIiFBnTvEsbHsOAVQB22y7HV8GrI5xwbE1yzAGiFzk4TqY5onSTWZwinA
         YUSBnd4+5Vv5A6K7sDR3gwUJuVeRDGZ6Gf2buLevxLmtWMoPjeJC3bXsdiTuIQUVRfa5
         KwWXZ5Y9B0oiNje7ILIEgqrIrllQ7L82OwnGCyfUj3fsfEGgliJoie9du6M00q/a4ulT
         RuZQ==
X-Gm-Message-State: AOJu0YzfJDYUKebK/3LZPE4JZO9UZ2mhaFm72Ptys4aOIoXedNhW+OYk
	cWhP65Dlu+arjMG8iTydyEfymGpdJjRhw5TL8n76p4MvJ4MbVDxeNQ2U1Vl0IfuT3lJgi1kaAS2
	xwTU=
X-Google-Smtp-Source: AGHT+IHhNScVWbW4zu4S3mbrEGEjrPtj3TL0VI7WS9/LQqIzrwGbVnH1L8in1CAWHkwsHJLO448Xug==
X-Received: by 2002:a05:620a:2688:b0:795:4671:d494 with SMTP id af79cd13be357-79be6e50e7fmr883509785a.25.1719337189278;
        Tue, 25 Jun 2024 10:39:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce89a369sm428452385a.20.2024.06.25.10.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 10:39:48 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:39:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 08/16] t4216: test changed path filters with high bit paths
Message-ID: <fbcaa686b1088544f22c883fe4437a6645d6619d.1719333276.git.me@ttaylorr.com>
References: <cover.1706741516.git.me@ttaylorr.com>
 <cover.1719333276.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1719333276.git.me@ttaylorr.com>

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
index c1977961d0..49d1113171 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -488,6 +488,57 @@ test_expect_success 'merge graph layers with incompatible Bloom settings' '
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
2.45.2.664.g446e6a2b1f

