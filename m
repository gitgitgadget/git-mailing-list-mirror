Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7AE34D918
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885586; cv=none; b=XrYIWLMOMm+nwJPtc/ufO1XsOfb4pF/cG85KpYjTfdRHkDryRHKqD2P3AFwXMqpJG39l7bBPa7o5tGgeWE/eN17IwCSYKf5CvOYJZMeVwDBuR7KOrbamtXznGnoSliibdBE6EdVAuKEiaxuf809VROaV2DoUDj/m/lPfB+JyJQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885586; c=relaxed/simple;
	bh=dIjnLR0Pm8ydUMKDkaN3BtqG2Rzpl8PfETW0XxDe9BA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=B18aLg4Rp1DOJ0es++dQG+CarSfZkfvi6MSH2MtjBw9X6arHgXrMa51C78KsNL01YI4F0NE4w5ZzoXbbxEC/vpfJcklK1PbnlWTZ1odNvNpfDg7TsWWWghJAuxZXBYQq+n+LKqSHWzj9T3qZ0E07l6zstmeBLatQwIGRLIWeXHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROO4OffA; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROO4OffA"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-bde0f62464cso4346323a12.2
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 03:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765885583; x=1766490383; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFdVNEgOTlqSWg1JAHPExwML0bX7vIQNcJCraNoA6uA=;
        b=ROO4OffAjCx7xGYhJkGlRtY9X2ZkszJoXavMjvrr+OXI2wKHv70hmEuN7jyaY1O5Qt
         SShyhDJCvfpa2fPQl+5agLQgjueCA+7Er5dL1d8IHd3O6bF+dH/dapdDsLerDHlbiBTO
         HER3VUFu1mfYE6paU3XRndHhdtujXNXmp6BRg/FQCtz0iutbis1jQEQgkMtiQXtAI6SF
         XMrwbr81g1ngkwV2MRtEcnv55rb3YdojSrlWqMJhMmF5J9XYTvuV9Wwr63RUznkxW7iK
         73QESyT+FRe2w/3xEU68Z+S3RbMXBeibTulnpUh/EI8/dVFJ/k85ZpCyDESO9byy8Q7W
         39Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765885583; x=1766490383;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jFdVNEgOTlqSWg1JAHPExwML0bX7vIQNcJCraNoA6uA=;
        b=uP4FSS6VfE5IE9ICliV7LzMb5Uyat27DO9HkAR6KnCYcGx0mvmIftRYMTwsfD+ECNI
         f3dsLIm+h7Asa9F/WmrCZezMYsr1d3z7UMsbnIg0r57cQ1DeaON4m6OvLu2izBfdY8az
         KUDG7VF4cLzMtaT55AppXkMWXRD+A76kHKdRq38TCQ3xTqwvvAxoXsjaYBuS0NKU13Sc
         kQVjsYopu5wl37BfMyiSxrGADDvcKgqYmnFqBmGSCNeSLkWn6DISQqvyIesi6JkMx/A4
         o3feOGg/mWCE/QIbQMYjKUGvk+7g+s6oOpBy3pW5Qbq0p5dkds/WNdQAaKKZaZk/hQ76
         DqhA==
X-Gm-Message-State: AOJu0YzdWIbFWhZigaxIckYnjqSBYQQ8Hio9zW5zlcoO73BC/Qw3KIVa
	5OllkwsVLm/S8EK9ER4K8O4gsCw8wtVZ1C5IEoeGplan7nnZar/FS/6z7X4NpQ==
X-Gm-Gg: AY/fxX7Xd0pwB32fwXwTSrutaRrNDQHHjVo+6gGRblAwdioeKu87HshCGeRAyTVLU6S
	kBzliVjgpWMFZ869uNLoM1kyWRD/Lvai/NHNQ2y33L1oVmxmPYAlhS4dFrNYlZnCqTlEPaa4FNR
	9q8KZ3JxDFEwb5tuxVTYHszvTBrRs5o3K6S5z9rC/wsY3bSN8DwrdyP15JTaMtvN+XH0V5+IRpe
	mPxqznKYyNe1gpgf/Hmav/yAuI4Y5arjaGlEBDBOjaZ4o9B2UpnL+z/bqkyAxA75liIRaSz+i8B
	OpXn5nBr78yZdFrY4fcm3EqZOzYTWh32r8iJt8KurHyNbP+wVAEUQjhxjvwsARtZ+8G+xNcWBCG
	q4ls7UzmhFQQicoAFv899SL8FwHukejAoutWXCj8siXYsYCCv3LuL22yrsn/A9694A1dDYI1Y5E
	eY5oXO+ivO2uXk
X-Google-Smtp-Source: AGHT+IE//D/aQW1ORYJjwK4zRE6OQw3G7HyDeLtBzV2dXwJo9WFGv2+w6gIFZbFKeVHR5TX8pp+ztg==
X-Received: by 2002:a05:693c:2c0f:b0:2a4:7a4c:6e49 with SMTP id 5a478bee46e88-2ac3012d6c2mr11561710eec.35.1765885582979;
        Tue, 16 Dec 2025 03:46:22 -0800 (PST)
Received: from [127.0.0.1] ([52.161.69.165])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ae4f054619sm917029eec.20.2025.12.16.03.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:46:22 -0800 (PST)
Message-Id: <f42a2f14bce6920200e4ee993b76b37d4a762441.1765885577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
References: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
	<pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Dec 2025 11:46:10 +0000
Subject: [PATCH v3 03/10] mingw: special-case `open(symlink, O_CREAT |
 O_EXCL)`
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `_wopen()` function would gladly follow a symbolic link to a
non-existent file and create it when given above-mentioned flags.

Git expects the `open()` call to fail, though. So let's add yet another
work-around to pretend that Windows behaves according to POSIX, see:
https://pubs.opengroup.org/onlinepubs/007904875/functions/open.html#:~:text=If%20O_CREAT%20and%20O_EXCL%20are,set%2C%20the%20result%20is%20undefined.

This is required to let t4115.8(--reject removes .rej symlink if it
exists) pass on Windows when enabling the MSYS2 runtime's symbolic link
support.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 736a07a028..9fbf12a3d3 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -627,6 +627,7 @@ int mingw_open (const char *filename, int oflags, ...)
 	int fd, create = (oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL);
 	wchar_t wfilename[MAX_PATH];
 	open_fn_t open_fn;
+	WIN32_FILE_ATTRIBUTE_DATA fdata;
 
 	DECLARE_PROC_ADDR(ntdll.dll, NTSTATUS, NTAPI, RtlGetLastNtStatus, void);
 
@@ -651,6 +652,19 @@ int mingw_open (const char *filename, int oflags, ...)
 	else if (xutftowcs_path(wfilename, filename) < 0)
 		return -1;
 
+	/*
+	 * When `symlink` exists and is a symbolic link pointing to a
+	 * non-existing file, `_wopen(symlink, O_CREAT | O_EXCL)` would
+	 * create that file. Not what we want: Linux would say `EEXIST`
+	 * in that instance, which is therefore what Git expects.
+	 */
+	if (create &&
+	    GetFileAttributesExW(wfilename, GetFileExInfoStandard, &fdata) &&
+	    (fdata.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT)) {
+		errno = EEXIST;
+		return -1;
+	}
+
 	fd = open_fn(wfilename, oflags, mode);
 
 	/*
-- 
gitgitgadget

