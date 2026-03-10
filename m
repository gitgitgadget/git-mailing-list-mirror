Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD7D361DDF
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132686; cv=none; b=oFguznrb+FYkOSp8lvsaelsnaUSGforaocckjrjcUB2HcaOuK74cGE8gbI+ZhJwI7mYtjibv9VSwfyXtEFbmk0WXgIlwnw9z1T2PRu9mWurp4zkCXHomi1SXErG9mgoI7JOrySqRWZ/7+cd4KOxbSs0RMW7lXZr5NfITQ358B5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132686; c=relaxed/simple;
	bh=5uXY6wCzDajj76J0Nq6agX7ElW+9dYFTsNEOCJ/ML0o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Gyhjyshi7wFZBY63/YS+/GIv9lcPmZVJ6HASE4Cj31h8ipkg3jzTJf5wMRRuyVGBVdUXCKOgLyGy2V8gm8N1piRyM7Mz6oSPPbLcvqIx+tBElhMA6kuWWabZiR6dNvgh2c1IEtnBZdUCrWmR+86D5sAFo8FCLF1ThZ/zoOVH3SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLHsJRgE; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLHsJRgE"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1271195d2a7so1013174c88.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 01:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773132684; x=1773737484; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCkTsnb1hredHypLItPMz8YZYDvNGarS+hExRw76J04=;
        b=HLHsJRgEjEfe3nVzVMDYHM2jxZWS4Pa+t9XfwRXRE+L4NtlNCGutGbgiwWkRunyPKR
         ovJEEOIMOv73cO1eThzb9sTGf6LS+hRK3pXa9dHyFqXgGDZc95B4Hm0/lOczcmPhqsR1
         2QW9CRQ6yO35J/UW2EaXj/dlP90EOpD65z67rx6+jLd+rFvqXyAtPgqhSJtf2ICLzsTd
         LrMaIyvzjrYicVydtl/JwVvz6vnzJH+PqKDKFNZkiS2DrL3Ym++IlQlO+28Sw09JNoZB
         SgwFWXfuBYmS3fXz7tx5Ws23hKlkN5xijC5MIg4ZVya5AOq1DoZ96eGP52sKaEm6n2pF
         H7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773132684; x=1773737484;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xCkTsnb1hredHypLItPMz8YZYDvNGarS+hExRw76J04=;
        b=h/RN5ik63n525qFFIODauWNTmPSjxXXFmx/Lg9Ca+zGcQSOy6g9dsDJv2gVgS9yyiQ
         d8M0XMuur1BLWVr4O7l6b/HDmji4g3kF55TcgiYGAEH98rWTJYADO5XJgCBuZHIsye4d
         PifbtnGgDqjXtZ9ly+ofqzK+r1ngGnTY5zlr0m+FsUz6TZlychdjZHC/4WXW5UbgA8jz
         5hRtCWCgT15WzFRBQdERaqm137FTqnweV++l6i0xryAjm2+lBZ3sa5IRhMkAJRXm5fgM
         Cmtcdgt9hTn1iDh10At03vnpm6Id3OX6vfDDIYWELJmomipsBdtdjlmVkmrEsguea4Pp
         C4wg==
X-Gm-Message-State: AOJu0Yzfso0MlrDFbnek/o7vPu6FsSgqd6ImcnNycq2Oo6mXq8XAe3sn
	gso/8ZKEsgv2Gj34NvjwiQ3MD1DiuIKcMfsYjCWL/S02WnMPJNgMpQy0HXsbVg==
X-Gm-Gg: ATEYQzxriwoL3743WyJH7Z+UjVj2e2xJECEPisEkr4WnMc/IuqcMvhJ+A4rXDVpnij5
	Ras3NS26Gb9zHqANm6EC5SujaOfHZtJeFGcOpjRRKTrDpuz9WcTzL8lpkN5rF0ToTBAijN7/wDc
	yZhtTanHY08VOTtQq8bGXbicMT3ARc5v1Jl7sk1LvRUPbTiMlyD5S3k6IHNoCsPb8UxfZK1V0xC
	+eDSEtVEXaK2CpefneqXuZ0nravAGYCjSxDJxUw4/YMW5/NHyZg1A7cJh2+WIRCOVJ1GNsl+rBR
	OhP+qOHuUNNJw3psbU3CfgaCjvkl5TfyXkVnKGy6AS6crO6glKHMUPf3GQoqiWojR69bMlcjsvd
	Xw0fPVP6/VMr26wqmmCMIbxc5iUOaKW3wn15SMUY4uRtTtLTj7trhvloof2xzhAFmISfglZhcn7
	Gyx7uHyArYIpgLttu4LPz86Np1
X-Received: by 2002:a05:7301:fa0a:b0:2b8:30b8:58cf with SMTP id 5a478bee46e88-2be4de76edcmr6302486eec.8.1773132683805;
        Tue, 10 Mar 2026 01:51:23 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.69.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f948390sm12210689eec.22.2026.03.10.01.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 01:51:23 -0700 (PDT)
Message-Id: <c70043a2c0d4e33286508b5699a8bf0285b2f51f.1773132678.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
From: "LorenzoPegorari via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Mar 2026 08:51:15 +0000
Subject: [PATCH 2/5] t4052: test for diffstat width when prefix contains ANSI
 escape codes
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
Cc: Arsh Srivastava <arshsrivastava00@gmail.com>,
    LorenzoPegorari <lorenzo.pegorari2002@gmail.com>

From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>

Add test checking the calculation of the diffstat display width when the
`line_prefix`, which is text that goes before the diffstat, contains
ANSI escape codes.

This situation happens, for example, when `git log --stat --graph` is
executed:
* `--stat` will create a diffstat for each commit
* `--graph` will stuff `line_prefix` with the graph portion of the log,
  which contains ANSI escape codes to color the text

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4052-stat-output.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 740bb97091..7c749062e2 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -413,4 +413,36 @@ test_expect_success 'merge --stat respects COLUMNS with long name' '
 	test_cmp expect actual
 '
 
+# We want git-log to print only 1 commit containing a single branch graph and a
+# diffstat (the diffstat display width, when not manually set through the
+# option "--stat-width", will be automatically calculated).
+# The diffstat will be only one file, with a placeholder FILENAME, that, with
+# enough terminal display width, will contain the following line:
+#     "<RED>|<RESET>  ${FILENAME} | 0"
+# where "<RED>" and "<RESET>" are ANSI escape codes to color the text.
+# To calculate the minimium terminal display width MIN_TERM_WIDTH so that the
+# FILENAME in the diffstat will not be shortened, we take the FILENAME length
+# and add 9 to it.
+# To check if the diffstat width, when the line_prefix (the "<RED>|<RESET>" of
+# the graph) contains ANSI escape codes (the ANSI escape codes to color the
+# text), is calculated correctly, we:
+#     1. check if it contains the line defined before when using MIN_TERM_WIDTH
+#     2. check if it contains the line defined before, but with the FILENAME
+#        shortened by only one character, when using MIN_TERM_WIDTH - 1
+
+test_expect_success 'diffstat where line_prefix contains ANSI escape codes is correct width' '
+	FILENAME="placeholder-text-placeholder-text" &&
+	FILENAME_TRIMMED="...eholder-text-placeholder-text" &&
+	MIN_TERM_WIDTH=$((${#FILENAME} + 9)) &&
+	test_config color.diff always &&
+	git commit --allow-empty --allow-empty-message &&
+	>${FILENAME} &&
+	git add ${FILENAME} &&
+	git commit --allow-empty-message &&
+	COLUMNS=$((MIN_TERM_WIDTH)) git log --graph --stat -n1 | test_decode_color >out &&
+	test_grep "<RED>|<RESET>  ${FILENAME} | 0" out &&
+	COLUMNS=$((MIN_TERM_WIDTH - 1)) git log --graph --stat -n1 | test_decode_color >out &&
+	test_grep "<RED>|<RESET>  ${FILENAME_TRIMMED} | 0" out
+'
+
 test_done
-- 
gitgitgadget

