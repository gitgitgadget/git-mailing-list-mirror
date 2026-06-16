Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2589A3BFACA
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621410; cv=none; b=hCpA9q4V2Pb+vd/Rismv2Fp71U0hvXC/RzN4iiimKp61s9wk0TYbJjcYHaqwPET6SehyZ+wwf3W9Q698UkbI/s/7+HeFouOycKLmqxWUDKr3m2E25dZFEdjeQLiCiTLsf5YcT0zcZ+BC/h2Cu/E4/IfNMhJNoXqvNYMdMNphg0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621410; c=relaxed/simple;
	bh=M9QM9oX3G2acAqY2O/ftdIXEUocyR0HGaMiOD2sV3BA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TqiGXkx+BFGoTcBvSgCY/8XFZF3+VqIfsRtm9YOwsaaeSdN49A7UJwsvnx0NPrgT+PEzsv+yXV/1r1dkgBYKDHztxVkQgy+Aqs6nUrCE+VknpSzfo9PrF+bpYAeMGhXmdrVdrz2G7gDUXrkXPd8dvgP6woxE4Cc4H2Ht1eCg4Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s8oy6Ubs; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8oy6Ubs"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5176fc0cc72so49627581cf.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781621408; x=1782226208; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+YZ/1M1GBu6weaOX1unwnA/k1/pZaaidG9yILOLLzU=;
        b=s8oy6Ubs9E9lmg68zLmOT7qqo1jRoGEn/q3neIXZxTQTh1B6JNlpTIcaDSA0Clr5r1
         xTGt0kT9GhQGZ1/V+vh8GzM4VhMq3nhsMZLEzvQjl6Ae9IhR3gxeLbqw7no5HZejKMez
         aguM+rUn6le9Jy6yF+v8yI7cHrdwrvXGqHo3BdRRhL7zAI4QTyIVmWLplDWYsWpdBI6E
         /WLGajwKct0y8MrmtH5ybjBE1AlPPpPeMWlN2CSemrnoixi6QhN9qtvKRl4gBFT/s4er
         MzKf/fRYbTNh0Ns/Kr5QSnGmvGGlcUhBPQO1ecnv1Kni9xF8IcK5QmMJUbllvF/PfG5t
         x0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781621408; x=1782226208;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K+YZ/1M1GBu6weaOX1unwnA/k1/pZaaidG9yILOLLzU=;
        b=jMeFq93J0bTdTAcSpDqnrhY9oF4jd6j5yXnLUuDxuRJjABQGBnI0UqWHGsLcVhKi34
         q38p5Vut+1qvDaDUEjWzpHtRW6Wb1zHlXaZpK/ZZZYMt1VFeuWFjNd5Mnw4DfXijTOFG
         99ffpzA4AnvftyxzMmXFlnuSv2x2Q5Lp2NFzQ8bN3RHSC7hFHKXf1mynhTamQfFdM2Bw
         rdqNTW3F1gf0r+m+PJdS2bqMvCP8NAFN/+pT5t1L68qIIILLosHoQVgHwQ+OXGWZZuq9
         Jhf2KHdwEz0tsFANSIpqeCRl0OztNnJG9r3WFKSR0kPz5NKKrpykBNe3wsSNub27ZDC4
         +HSA==
X-Gm-Message-State: AOJu0YxOJdYRJNPGGc+DLI4BXlW9j6ySavsa7sJEq5IP9WNNte0BH2Lu
	a2X8/oVogGHWEv2i4JUnaJJtAMJ0ihkOhB7rYBYpqlb5/lUVZcoOnYLTFq1Wvw==
X-Gm-Gg: Acq92OG3Wi7BcTCYKBGbyYS7NzQP45IAOje1ayi6EuVmI+zndHlJs+XSoO547I1Ivm2
	CZHujIs8prVeJWMdia3gTJz/jsK6AbmyJ3vEDjBfa9Lfsf5c7VrXK4P8a0A+zXRGcaKG219edd2
	3egwwOa6qER/DL1A38x3wOcQ0acuPDdI/2mNcmwJ0qQBpr1iRNDxRNrkr3WW5Q1IcNu1QZKDbmt
	SJalRg4tu0c5wiDj5wdxFruNPQd7t7PBo0SosHSjSTw68hwqaLdtOSqwE8M0aquiY2uU8cEHfWI
	0y5lbeXK2KqxpdKGAijsftOPbNADCst9ijAbru2fox4Dlo2tGe7Zh75RTpkjUlUiq+pU76Nh/Vx
	wI50KX7xdhpmbunt/sTyTD0hWHZm2jCkOkBrPsaJKIQV5HTok57EmM1ONYSFCBc4iXiVQRdmenm
	ZkGPw0k0arXJD5sGzvRVZgvDK+yg==
X-Received: by 2002:ac8:6488:0:b0:517:2c1e:8b6 with SMTP id d75a77b69052e-5195353725bmr184390011cf.38.1781621408032;
        Tue, 16 Jun 2026 07:50:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.77.160])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb642740sm141673821cf.7.2026.06.16.07.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:50:06 -0700 (PDT)
Message-Id: <411727336af817f2d3da18a1aabee73be71510ca.1781621398.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v2.git.1781621398.gitgitgadget@gmail.com>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
	<pull.2138.v2.git.1781621398.gitgitgadget@gmail.com>
From: "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Jun 2026 14:49:55 +0000
Subject: [PATCH v2 4/6] hash-object --stdin: verify that it works with
 >4GB/LLP64
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Philip Oakley <philipoakley@iee.email>

From: Philip Oakley <philipoakley@iee.email>

Just like the `hash-object --literally` code path, the `--stdin` code
path also needs to use `size_t` instead of `unsigned long` to represent
memory sizes, otherwise it would cause problems on platforms using the
LLP64 data model (such as Windows).

To limit the scope of the test case, the object is explicitly not
written to the object store, nor are any filters applied.

The `big` file from the previous test case is reused to save setup time;
To avoid relying on that side effect, it is generated if it does not
exist (e.g. when running via `sh t1007-*.sh --long --run=1,41`).

Signed-off-by: Philip Oakley <philipoakley@iee.email>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1007-hash-object.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index f028a1cbcc..bcae3fc54c 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -269,4 +269,12 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 	test_cmp expect actual
 '
 
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
+		'files over 4GB hash correctly via --stdin' '
+	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
+	test_oid large5GB >expect &&
+	git hash-object --stdin <big >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

