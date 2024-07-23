Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042A414C586
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722880; cv=none; b=dcOd41J9dX09Skpm3lGfYP2bVsWfDaNnOhrkKGuTaw/6PbgOnmL7cySxabEJiYoCRGjzwr+w5P1cleVGdNYCGfrERi5w914J/hqtIPu/vEK3Gpyes0amZtTONBB11UgcP8UrFdmKYxJhAvwozO3ySL2rwO0tW6hLp80qbLCBo7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722880; c=relaxed/simple;
	bh=f+9t1NpkVoe+I5qn36ZdOhXw0efovMxsbbnwFmTI/jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrV0L9JgV/PaR+ExOXoZSj4gRgQAbucgucpNPK+ZwAat7INUzChhl6RKiobIS6M2nwpGH39UTZ+dZ80rC1/MwbJSyKV8FY0S3SSpOEW6LNBBsBvTOXVY+TrR0bEmbqnJxqa2U0I4fMithwcONDkeg1dSRpBb3BtNSHV7SBWK4X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wp2bU0P2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wp2bU0P2"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a797c62565aso506189766b.2
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 01:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721722877; x=1722327677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kW/pu3ynQau+YcaNh9IHKcFwebEUBcLLIFlf5rzAZnM=;
        b=Wp2bU0P28nUdCVgKvZ+j4KtD/rH5iABENqBA8/eGEtyCwcjW3VxcDSazgHNb3Skk7m
         ONhJSV//1+mcLH8U34b5szAXgIZxIFUiUtT1VICNqI8ho61iLZvxN9N4UWe5g/MCziiZ
         m6QX2Ed+X1LlUn+/SIWNSWeMJ5i5l3PkQwQQMGB/xG2S1U+JlKxRguun+o/7UKhANjsd
         aJzMBn26GmSPe92iz/kbVmqAOg4xH60tNCHfFTfFOjwWbO5L0a/0jaOZaM8DEwpM3GMh
         wgfIbUBEvAn+YbFMcgOJxR4CaA8beiRlVv4EYSWfKj/lsOSmBA+k+PqNJ3DP/LgFG4KU
         fDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722877; x=1722327677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kW/pu3ynQau+YcaNh9IHKcFwebEUBcLLIFlf5rzAZnM=;
        b=D3P/7VYsZlpUUB9XuyJSe8wkkA/PguzCxmXGsTyHHnby/MfERMkQNncnbCuX6erl/G
         AlQ+JLcwEzFvGnZbhGPmDmJQDlePRb3lc9V+wBX7Jw0UZ6jfXwnIkmaiHfQrxGsD4TDw
         i/aYRSiqVssVr/10uFC+lR49soS8uzamPR4AQkwb3+s8pe/I1kxsPgrV37cKuGLsf0YJ
         S/IIr7IVTxlE0KvBVJkrwTrc0j+epT/LhhjTVQPIZMHLE8AU2ZdS8DypEGuODv2IMJ0h
         vRGAoWNda/mjybdq6ex3L9vDcHb5yV+kVzdZ1qclpx5ijWYdXJPH2PXnExXuGvDASQkH
         TQlA==
X-Forwarded-Encrypted: i=1; AJvYcCXBuzsI44VgchivckMsY7E7b6jHYo+d9pNbALE4ySdNv7YWoDYBCew0P+vQElURDUwi6dPirEpjsXpXyazjLTArSo2j
X-Gm-Message-State: AOJu0YzhSCueYbClXJ1Vnk2+lyJY5zwAJ9ql6GFh+yLJdcBbkHCOlAue
	Eerpq6he3ejYEJ81y5BUAECDk6nzX5MvlNH1ds5qlbcsr3r3AknhvbovH54L
X-Google-Smtp-Source: AGHT+IGJ65RLwQ0nlzO203w4QIoUjV1uk7ag4uK714v6J1taDIHGCLMZRdVqKkLuTYe7grqfDbpbTg==
X-Received: by 2002:a17:907:7209:b0:a7a:a06b:eec8 with SMTP id a640c23a62f3a-a7aa06bf03dmr47532266b.37.1721722876991;
        Tue, 23 Jul 2024 01:21:16 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:45ae:72d0:1982:e034])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a9f463194sm24026266b.112.2024.07.23.01.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 01:21:16 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v6 3/6] clang-format: formalize some of the spacing rules
Date: Tue, 23 Jul 2024 10:21:08 +0200
Message-ID: <20240723082111.874382-4-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723082111.874382-1-karthik.188@gmail.com>
References: <20240718081605.452366-1-karthik.188@gmail.com>
 <20240723082111.874382-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some spacing rules that we follow in the project and it makes
sense to formalize them:
* Ensure there is no space inserted after the logical not '!' operator.
* Ensure there is no space before the case statement's colon.
* Ensure there is no space before the first bracket '[' of an array.
* Ensure there is no space in empty blocks.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/.clang-format b/.clang-format
index 803b274dd5..3c8018a1dd 100644
--- a/.clang-format
+++ b/.clang-format
@@ -118,11 +118,18 @@ PointerAlignment: Right
 # x = (int32)y;    not    x = (int32) y;
 SpaceAfterCStyleCast: false
 
+# No space is inserted after the logical not operator
+SpaceAfterLogicalNot: false
+
 # Insert spaces before and after assignment operators
 # int a = 5;    not    int a=5;
 # a += 42;             a+=42;
 SpaceBeforeAssignmentOperators: true
 
+# Spaces will be removed before case colon.
+# case 1: break;    not     case 1 : break;
+SpaceBeforeCaseColon: false
+
 # Put a space before opening parentheses only after control statement keywords.
 # void f() {
 #   if (true) {
@@ -134,6 +141,14 @@ SpaceBeforeParens: ControlStatements
 # Don't insert spaces inside empty '()'
 SpaceInEmptyParentheses: false
 
+# No space before first '[' in arrays
+# int a[5][5];     not      int a [5][5];
+SpaceBeforeSquareBrackets: false
+
+# No space will be inserted into {}
+# while (true) {}    not    while (true) { }
+SpaceInEmptyBlock: false
+
 # The number of spaces before trailing line comments (// - comments).
 # This does not affect trailing block comments (/* - comments).
 SpacesBeforeTrailingComments: 1
-- 
2.45.2

