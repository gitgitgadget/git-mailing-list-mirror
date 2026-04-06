Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6465CA45
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 05:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775454338; cv=none; b=gqjNIRUYcStZC0sKfrrbRiPz0ZcRSWdC3WpMtsgtMaLoDQ12XEpzD21KTufBGN4v0Pr0XHBVTki8Ty8lcuiE/RomsmpWeY4mGfBYGqC3jWahJlhXYyD8EHVMDv84ju18wVCmC7uN77LZswbdqOgshIRPRFFzh/4rkHlKpfwzARA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775454338; c=relaxed/simple;
	bh=R5LFTfzuuGeW2JcC3owsFD7Q/S06cvb4LkZpU+ta9z0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=duSj1m4niHnFQVBJcZTeUxB5aKRwe7YIztdWZ1rR1V6jFD34F5JYR17nMhKOKgY4p5NFvZF33hbZw0AKoiCoHTncO//6QEqwKH+OU7uTOdS5kl1WlCb2HzYO4pz+CqJbd6l/ZHgnZWyqe6iySXNYOM7110SpVrWkPBrYIVa/6nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iScxcay0; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iScxcay0"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cfc2d1fdbfso285015685a.3
        for <git@vger.kernel.org>; Sun, 05 Apr 2026 22:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775454335; x=1776059135; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AR8w7edUWq2Uac5H2XYq7L7HW1t1F5yvVa5k3t0qt7Q=;
        b=iScxcay0cpjnX84QKWr7b9my2w4lCZeNwqHKavXm/p87VdvCNTUWeLLI1LAMSQTVk1
         +7tWKLDRdLdMJKTf+uySZxhxYy9UqYLypXYw7TOEgyoQoeuU4V5PEVzknIlC0mJ4TgRl
         rbqM/AXDwkcvUqqPwv8PVvzEUEykOIE35nlTrFqmy3qeksmtE+7xTWskLKkVW+4wNM+h
         gne/6dpgMizG2NHNTUwzPhlHrRYZG8PY6Acpx6m+9D0P+K9a4A3zcPhQ+hYqwrY2OMYj
         Qs+zyTWCkNl3RPTVjLamG7MpDPwi+jvHM2A9TjXFgkfKwZx5Sh1ycfJBmenUUZpevJ4H
         TydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775454335; x=1776059135;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AR8w7edUWq2Uac5H2XYq7L7HW1t1F5yvVa5k3t0qt7Q=;
        b=sXCY3pFPWHjPZeZFeiD3k2J3SoO5L9wruCRw8U7FY88ktySzDuQcqhGDftwg4FQDni
         AN2BxFGkmjuukN87zdJ57NuqtYF9t6Aai5HQn7sE1xzu0L+x6X/yE+dE5uiMZIt9RYKk
         g+E7AV+TLEgW9RXCbdyaaTA6NlD0dA8tHbxrw+Ry+03vqKLVk5VdvrAg2jV7QqRM3k4o
         FLhptykO9YNgFfJ90PqEqYqJXQB+1Ergq+c4HZ5zW/PEfVKFH3S/ko8YEdLJ07rXyPl0
         13ArTLJ+6sR5il4pTVKmPYjR7Qk4qOkEMAEml3gd7ECWnIwKMtBY3NhLdqPsMyZx7T8V
         w9zg==
X-Gm-Message-State: AOJu0Yyz+x5DUDVtsZaEm9AQ4RqcQZ2IS9qHv8tYhXVhuUgTtlE1kV5d
	gvbrJ+y+WP+Sy6ctuPZQ/OGvcYLVXdY2TXxoWlBwd6VLGvcXEhXeWZTCazWdvA==
X-Gm-Gg: AeBDieufLlatP66H/fgG94ZfmBkiJSme7RvpaW/YIXSU4AfSsjeq4+JvoWwcznSXUTe
	V9Brs+0tNb6HbIc8O1gg6kdxcUtfchEnixJd7rtelgHrvzJgo7p4+onGq86pkuuvFVdFPP9cyf7
	QIRbMv1eJ1NuPIlYwAqIVBVUwIdDsNHdaFGowfTJKGCxrqnlICKeVjlXqv+LJiQGd35nql/dQ2v
	n1kY8IZlfBsKejLelW91dRvBeWAKitGSPFHkalsEqoO1WHtaj6Guk7IuX1RrKFcVs18utETNiXO
	vi3hNfrT6elVmcIlaK4FJsY/rX+mpshWC20kvYWiLCqJhGbb9zdh48sYvZJCwja1SZHXH8AmFQW
	8vDW1LggpZbHoUpW4TCqFhv9G7fteQa2aZpEF6XHAAuLfTju2+CaePE0I9mrhWZ/g6W8c7IGvD/
	C96/7VXATWrtl8719Romu/fr1CUzw=
X-Received: by 2002:a05:620a:2a0b:b0:8d7:e7f4:7e9b with SMTP id af79cd13be357-8d7e7f484d3mr348750785a.44.1775454335098;
        Sun, 05 Apr 2026 22:45:35 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.140.198])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596ff619asm138415056d6.37.2026.04.05.22.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 22:45:34 -0700 (PDT)
Message-Id: <0b50c30cdd97e52212dcbbd13f16632f04258431.1775454330.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2081.v2.git.1775454330.gitgitgadget@gmail.com>
References: <pull.2081.git.1775386448854.gitgitgadget@gmail.com>
	<pull.2081.v2.git.1775454330.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Matthias=20A=C3=9Fhauer?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 05:45:30 +0000
Subject: [PATCH v2 2/2] compat/winansi: drop pre-Vista workaround
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

1edeb9a (Win32: warn if the console font doesn't support Unicode,
2014-06-10) introduced both code to detect the current console font on
Windows Vista and newer and a fallback for older systems to detect the
default console font and issue a warning if that font doesn't support
unicode.

Since we haven't supported any Windows older than Vista in almost a
decade, we don't need to keep the workaround.

Signed-off-by: Matthias Aßhauer <mha1993@live.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 37 ++++---------------------------------
 1 file changed, 4 insertions(+), 33 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index ac2ffb7869..3ce1900939 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -32,47 +32,18 @@ static int non_ascii_used = 0;
 static HANDLE hthread, hread, hwrite;
 static HANDLE hconsole1, hconsole2;
 
-#ifdef __MINGW32__
-#if !defined(__MINGW64_VERSION_MAJOR) || __MINGW64_VERSION_MAJOR < 5
-typedef struct _CONSOLE_FONT_INFOEX {
-	ULONG cbSize;
-	DWORD nFont;
-	COORD dwFontSize;
-	UINT FontFamily;
-	UINT FontWeight;
-	WCHAR FaceName[LF_FACESIZE];
-} CONSOLE_FONT_INFOEX, *PCONSOLE_FONT_INFOEX;
-#endif
-#endif
-
 static void warn_if_raster_font(void)
 {
 	DWORD fontFamily = 0;
-	DECLARE_PROC_ADDR(kernel32.dll, BOOL, WINAPI,
-			GetCurrentConsoleFontEx, HANDLE, BOOL,
-			PCONSOLE_FONT_INFOEX);
+	CONSOLE_FONT_INFOEX cfi;
 
 	/* don't bother if output was ascii only */
 	if (!non_ascii_used)
 		return;
 
-	/* GetCurrentConsoleFontEx is available since Vista */
-	if (INIT_PROC_ADDR(GetCurrentConsoleFontEx)) {
-		CONSOLE_FONT_INFOEX cfi;
-		cfi.cbSize = sizeof(cfi);
-		if (GetCurrentConsoleFontEx(console, 0, &cfi))
-			fontFamily = cfi.FontFamily;
-	} else {
-		/* pre-Vista: check default console font in registry */
-		HKEY hkey;
-		if (ERROR_SUCCESS == RegOpenKeyExA(HKEY_CURRENT_USER, "Console",
-				0, KEY_READ, &hkey)) {
-			DWORD size = sizeof(fontFamily);
-			RegQueryValueExA(hkey, "FontFamily", NULL, NULL,
-					(LPVOID) &fontFamily, &size);
-			RegCloseKey(hkey);
-		}
-	}
+	cfi.cbSize = sizeof(cfi);
+	if (GetCurrentConsoleFontEx(console, 0, &cfi))
+		fontFamily = cfi.FontFamily;
 
 	if (!(fontFamily & TMPF_TRUETYPE)) {
 		const wchar_t *msg = L"\nWarning: Your console font probably "
-- 
gitgitgadget
