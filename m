Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24100389DE8
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940030; cv=none; b=mQQf94G/7X5GAK1+tqC6Pd6ERc6uHqmlS3Sr/U5h543gNZFB+Q/m3hHO2tzhA46gQDqEuqim6FIjDIaapPIZxYe61D0p2L3PDUg0wMW2kPpHd34rwDiqoZnGleSRSP8J7xvryD6rcMR32M4nMM2kMbfedMXwZ5IsjwvM5yuaB44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940030; c=relaxed/simple;
	bh=H0PizsPPV+MUAUIJw03y2J4nzFYS8HH7EkBFpHktLpc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VTTpE83JkUCYn0N/INCwfEugvXjC+nyCw5PH3OjQzRYYKyYymO0LlRYvTa6ZBIRqsD+UF19lm7DVkTq4DcXpQXqch7AFA8xff0U2dlw4W4IunaJ6N/TgaXGoowvt1xFfgEgX2OMY1IncDaink/qtl+4dxmQect7wd4JLBEuGGdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sTkPEvgZ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTkPEvgZ"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81e83f1f15aso15771227b3.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 07:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785940019; x=1786544819; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BU7QYyd1JGW8st5nbHVrxZlsyyeMc3aYDaoFk0R7Cks=;
        b=sTkPEvgZLyqj3hXKa+d9y0xb/KGnwt/7KDX4wddsvCE6JM8lCZZKyGsEV3E+IYn238
         ppqdNbPZ14sexVmOqHh1ItrlPyiW386SAYDxIy/X1AkLMKD9xdJjA7Fyq63iLXUkJaNY
         FBbT4uZYWxbp0oycfZf6zYlOqXwpNzNZWOjxT+2OP1Zn+8imBo5CjH/u50t3dJik55ua
         odVP+BJ7rRcD7rmUdjAx9wIrZS2TFdTvwEFpvpZBO+Rsi4NDSxye8AGrED/jpWPMcwRw
         2yCWjyKlBvDyRbZZg9vV+K9PM7ZXXd+zAEjiCFOTLjxrRD8VeKOG9p32JS6iTf8NIdr9
         7a/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785940019; x=1786544819;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BU7QYyd1JGW8st5nbHVrxZlsyyeMc3aYDaoFk0R7Cks=;
        b=DfbZt9x/MjhBeH6zfIyZWw/4uMWmzrdvSQg7ZYWQsZPMCt+wsKzRVmCHia8IGSTIHi
         coJywbMaX9v0aHcbOX2UhsBXprBoVTBmnhzpeKFEJ6vn9kP39M62cMjFf8DPTakVdJzm
         aq20fFRQDZr/KjKU7o7NdHNN8cWAhFAkYr48ggVZc4HpMecAzmRqJO30/Ek81umKCSm1
         AE31NZPm4R3ORJd6sHzBFqw2H5/MgNZbOXWzkxKQHk8rLjorBMaE6L28Gsu5WL6w3tY9
         K6QRIX4l5GtBNzdo0MHQGkEivWg9nTBioveCfebwRStZ7nuMCakuWKhJOEoz6Z4l5DYB
         FkQg==
X-Gm-Message-State: AOJu0YzLPqeWKkYva2r8PWw/nAzR8Fkc+bZJXkUXH/t1uTyJzzx0Ao8W
	+HnIwAUmmMVElUX39rYwXXADLsnYvV2qgE5h3ytQS3rehtDWtkZ0cPDOCEISdw==
X-Gm-Gg: AR+sD11zQMBHz8uRZv/EiwvM8JKpg/fD2Qpt4swNHwfaYRVCPZkWGnvXBcCdlzMAxMw
	A4TJvvge4L1P7R2pTKK/xLLXu8sw5p206Iii181jYcwEECw8Zg5kBt06qhGI1B+mYvtbq+7yert
	eBU8xYxzVuvQkWlBw3bMCIwEHYBKCfCan1otRedfXkFSGgkEseAeV/UiLX2NGcRds13aFJaAjHX
	37DTOAetb3OqCxnx8+PUFw/HXZ2yXm+jz1w+DdxxgVzEmzKEEx/QUMnPFHg5mWAewYPypf30Dkd
	Pu2808UHSSMDOMP0sfIaxORN/3FlJFz+3AffD1miCZwVbNgdjTBlooI7idgMAdHfz0ADCKYfS6k
	QkUPHCkjk2xSTvRP+14A846yPtUSyjQwlPnZwabFhDvZHYeKUyZb5+f9HZ5J62cSBgnXbZ5FurH
	Ouibsziqynh3NCeU/Ox6NbgCcl0ZW2EzUQQd8rSZKINqlWPjGTmfqcIL7skikwW/NVeiJ5pOpzK
	Q==
X-Received: by 2002:a05:690c:385:b0:81e:dcba:ab93 with SMTP id 00721157ae682-82009622685mr87672577b3.16.1785940018981;
        Wed, 05 Aug 2026 07:26:58 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.162])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-820134a8e08sm21873257b3.41.2026.08.05.07.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:26:58 -0700 (PDT)
Message-Id: <39a138a773793ad59979a494f11e00ce6c06bbbb.1785939999.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 14:26:37 +0000
Subject: [PATCH 11/12] mingw: ensure valid CTYPE
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A change between versions 2.4.1 and 2.6.0 of the MSYS2 runtime modified
how Cygwin's runtime (and hence Git for Windows' MSYS2 runtime
derivative) handles locales: d16a56306d (Consolidate wctomb/mbtowc calls
for POSIX-1.2008, 2016-07-20).

An unintended side-effect is that "cold-calling" into the POSIX
emulation will start with a locale based on the current code page,
something that Git for Windows is very ill-prepared for, as it expects
to be able to pass a command-line containing non-ASCII characters to the
shell without having those characters munged.

One symptom of this behavior: when `git clone` or `git fetch` shell out
to call `git-upload-pack` with a path that contains non-ASCII
characters, the shell tried to interpret the entire command-line
(including command-line parameters) as executable path, which obviously
must fail.

This fixes https://github.com/git-for-windows/git/issues/1036

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index e0fbd2c66d..afdc1ef2db 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3185,6 +3185,9 @@ static void setup_windows_environment(void)
 		if (!tmp && (tmp = getenv("USERPROFILE")))
 			setenv("HOME", tmp, 1);
 	}
+
+	if (!getenv("LC_ALL") && !getenv("LC_CTYPE") && !getenv("LANG"))
+		setenv("LC_CTYPE", "C.UTF-8", 1);
 }
 
 int mingw_platform_has_symlinks(void)
-- 
gitgitgadget

