Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4A73033FB
	for <git@vger.kernel.org>; Sun,  5 Apr 2026 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775409946; cv=none; b=Zv8NvVnl3MY/FHSUgfVS+moMRtI2W/Tz0UkGBr24QjowGAFEcxkXp775EH/UVKTzmW/6LSIFkwpq8mLebLlE6hGL3ln+zTKB+6VA5iE48K3m8UNWh8c7LBg94NRkTRiFu3DJLLpjPLGQz7G/NAjLAvlh9kC/NOd41M0OW0XIbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775409946; c=relaxed/simple;
	bh=GaybOJP0dy3mJZM2EBGQFYYloGqPWFm7KPDW90b7By0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MH77QDlWt/a3x2jj7qz4op4bjmXqOeU5RZl5rbYSLe4Z7Cdy5RJgJQHcLfozlUIrGGYSSC7c3t+lpS77QqQeXh+JIc3wZBpf7CHKv8zpfFbzGlBm4k9DogdG949g6mSZKYzKy5nCiU6M/VKFvMQ5rHpzjDrHCcCEV3T8b3bbvG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r2ad8uN9; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2ad8uN9"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82a7539851fso1427575b3a.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2026 10:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775409945; x=1776014745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yghylTI8uHsf2oaD75szEzSzFH5ggyC+ia/fK+I6evo=;
        b=r2ad8uN9TNX6DTMJWSgUM4ao58xCiMBl7XblS0/ZvSUfz8+CcpXfix4KGV8HXtMceD
         4FCHcP0F0bO3Qck6sqg9SDxSixFKPv2fzOjQUcdZmnvPc4RuM4sWEBmO/Vr3NRoo/P6e
         W7GVp10SD9ouyAJyghz9T1ItdbKqB08d8IWon+GGtdcVLI5fUEj80jNgWGK01vNrl38P
         +e4qvkuXaCTWCFE6b2dS933A2NdS5kiClfdgVefb6AY0bH8CU4GVy9G30a+fiMGzjStD
         r1G+0kMqNvahodducBbHztRzMJjIdLqRW83KcebbijdFZBqd3UDQEOxwfiXn5S9kYaw4
         hRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775409945; x=1776014745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yghylTI8uHsf2oaD75szEzSzFH5ggyC+ia/fK+I6evo=;
        b=dtOFgoirAVofGoMz9Ivco9/oKGGBPNGZtgMmrSxJWrMZA8x9a99ray4TtkQlDPkGjS
         EC84BRqbRgk43pknaIgWrC/z21TOC1mGSUcl7LREMbkqEcyxgWELOCdVk5qwpOxJGPGN
         N9O1S/WXq4ulf+2YjE5aGktjgAA3RccePOSjTifDks4sj40l3Hvai2lGkbrMad/X6c3G
         v2kTg43TJZN+gwKdtcErj8ZnVxK3mR2rXM1AYy3jYetMwRHOy3IeInNQ1NUDDoe0Msbf
         X+w7hsAMrxUUOI6G2ftl0nioJW21NzdgKmkPs4XmQ1l85IuFVN8NrpDogycbTDmc7Ks5
         GgLQ==
X-Gm-Message-State: AOJu0YzAjJiBDlZiCNeAvQBAxkXGaQqpaTW2uKAAQhwd7k2zVd2kCHm5
	MMTXOogwYMbYnMPbh+o1fpcaB94VoCmgCVdQssWFVngSHiLDmqoGzVPMVI9xWlg9
X-Gm-Gg: AeBDieuhQ6JWN5x0Mk0HI7WFJbI52ouUX1q/8iDTfQds/TEOC7KH/0BRJGYZcqBi4UB
	5HlKOyPN3u2yb6Nq2hE8dPzgEBiQrZuBHIeXFy2G1UN9qtbEDdvOxuMKOjptdN2RDcbel15O+BR
	Klx6te9tgGqWI5dw5V0kxuTm82DbywxX8nQ3liQPXQALoRB4kYwtnLAAX7htnlWmFMLVZT6ESwn
	O8O6eWaJ4m/fSVcjHv4tNVDVJaYk8h6EDJkeQZYYKLXwaNqZJh+oGcOsEJAlCi4qDObskx8vEMS
	XQBh35CrY2llyyt4lpVEAvcRjcL1NMMAsKKsfYmfqGidiNDeUmuS0PFDz/iV1fjUsmfIOAQlZrC
	1j/49FYa44+OHnZUqkSbLx+jnqyYLIbGvEnN+/RhbbcPUgMjWpqAvR8xQbTE6ouJMkwcwvXKHEj
	+6SFyBkf3cWUTA+07iQ0EcqzLGVGq2NHbkl3/f4vvlm/BhPF+CMigIE4HwiD0AP2Wl16NYnWrFw
	68H2OGTWw==
X-Received: by 2002:aa7:88cd:0:b0:827:2ee0:411f with SMTP id d2e1a72fcca58-82d0da46a75mr8925561b3a.4.1775409944592;
        Sun, 05 Apr 2026 10:25:44 -0700 (PDT)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3aaeesm12492106b3a.13.2026.04.05.10.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 10:25:44 -0700 (PDT)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: Johannes.Schindelin@gmx.de,
	gitster@pobox.com,
	ps@pks.im,
	stolee@gmail.com,
	gitgitgadget@gmail.com
Subject: Re: [PATCH v12 13/13] fsmonitor: fix split-index bitmap bounds in tweak_fsmonitor()
Date: Sun,  5 Apr 2026 11:25:42 -0600
Message-ID: <20260405172542.94160-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cd82f960-88ff-661e-1e31-a119beb817e7@gmx.de>
References: <cd82f960-88ff-661e-1e31-a119beb817e7@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So the safest approach I can think of really is what I suggested,
> to force the `GIT_TEST_SPLIT_INDEX` variable to be unset in
> `t9210-scalar.sh`.

Thanks for the thorough analysis. I've dropped both the
fsmonitor.c workaround and the read-cache.c skipHash fix, and
added sane_unset GIT_TEST_SPLIT_INDEX to the scalar clone tests
that hit this (tests 12, 13, and 22), matching the existing
workaround in test 16.

Verified on Fedora: seen + fsmonitor-linux with
GIT_TEST_SPLIT_INDEX=yes passes all 22 tests.

--- >8 ---

diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -152,6 +152,10 @@ test_expect_success 'set up repository to clone' '
 '

 test_expect_success 'scalar clone' '
+	# index.skipHash (Scalar default) and GIT_TEST_SPLIT_INDEX are
+	# incompatible: the shared index gets a null OID and fails to
+	# load on re-read.
+	sane_unset GIT_TEST_SPLIT_INDEX &&
 	second=$(git rev-parse --verify second:second.t) &&
 	scalar clone "file://$(pwd)" cloned --single-branch &&
 	(
@@ -182,6 +186,7 @@ test_expect_success 'scalar clone' '
 '

 test_expect_success 'scalar clone --no-... opts' '
+	sane_unset GIT_TEST_SPLIT_INDEX &&
 	# Note: redirect stderr always to avoid having a verbose test
 	# run result in a difference in the --[no-]progress option.
 	GIT_TRACE2_EVENT="$(pwd)/no-opt-trace" scalar clone \
@@ -307,6 +312,7 @@ test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '

 SQ="'"
 test_expect_success UNZIP 'scalar diagnose' '
+	sane_unset GIT_TEST_SPLIT_INDEX &&
 	scalar clone "file://$(pwd)" cloned --single-branch &&
 	git repack &&

Paul
