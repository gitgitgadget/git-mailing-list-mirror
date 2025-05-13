Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8473F1F76A5
	for <git@vger.kernel.org>; Tue, 13 May 2025 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134452; cv=none; b=iUlESz5HQu/veBko2KWcqaMsoUfy8LQczn8W9sM+jugIl4PO8C14EjZgDTmXZ9JNJO/07HZlm2p4SPWT21JJoQS2ykPa213pHbIumMuxVurUAMjRE/WB+Gw8cYq6VpvqxrFvoS8vL6sVwclwNjWKVTNF5uwPZozbElWlTu82OoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134452; c=relaxed/simple;
	bh=Qs4RG0JAvoHYRxZKSmUYuS5GdAyDXJH46CZcOPRihrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fpkt998EpNZ8pfpHJWeL7VXJqBtqnNadA4ZW4GBWlMCeiwbNQ1dNR0P1ScG41R0OC1QRgN5xp4LwOS+9zW+CeLv+CNyVSkQlen+1CAR5w+N8sEto1FT0MHHTtZC1HlkLZb8X78UJzUYxvPLYXXFvwfwcd2pwoDVUVuZcXAndrnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZI87nwG; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZI87nwG"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7091d7244e8so51788187b3.3
        for <git@vger.kernel.org>; Tue, 13 May 2025 04:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747134449; x=1747739249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=67Py9NGTdtSEogEXnGUyxxYq5nkZNYRhcppywD1suJI=;
        b=JZI87nwGqTejzY9G1uXmfGzfwcCNZg4/ftuWLSRvxxGAbkKuFhy/QCqpA9PaHXazi9
         4WN8QDWaTcV6gT2j8GOCVCwq8+T+oiKcxnYgZFTiwC6C3vshp1IyA5SZ0s/E3gl5g1G4
         pC2Fh858AGTLz23IdzRaSryhAVCM/Tu31InXstFd8k6pMrYCKc7iNxLzCFGrWVxkTrLn
         aWsbM+l1vm2hI++2IskvnyAcrjVWjcUYNTkEpZ3Eu6ObAEIsO1bbYBpLegYSo9DaBR8V
         C+g071vf3t6lpY41T3mJD2sD+SDFbHKX5+Wh+8cxySpY9sgQfeRXDsAWeLmcTBy2C1u2
         3z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747134449; x=1747739249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67Py9NGTdtSEogEXnGUyxxYq5nkZNYRhcppywD1suJI=;
        b=TMJgJgiV5Z08JRbykssOSyKyAVg5PzgB/bS3AHJgUyGPSNRAff+cUycqajXoHKJMXX
         Ay17bn1d5shWM+jycnzQLGJwblL2M6xKTxWM2rtDvT1FVcX9Ym39Kx48jP3ppWaG3KEf
         KOYOm9XGHUBGJ0MDQ40Rw9RkNKcLYeIDKDvjMCeZRqP0+aBpsRx6um+4p2zFxyObyePJ
         MpmMA/ahC/KCe1rCHLyWYJE7lOMromP/gyJ25853wYlQPTwWc5Nr8+QjPWxyoJtvm559
         uGAegmnoF3b8klI7B4qzZ5LBDb2Qh2lnxycKiUMdeMVmSTjLCOfAYSrCCaaC79SjYr51
         OtZw==
X-Gm-Message-State: AOJu0YzX1MITKGuWBBURXVFhjYDDrDnXylbZwVIHL2+Mvek4P8ghocE8
	FJV1JGx5D4VwY3nbRRRQVl+mrM4KUuMHmgXeuHkhd+OTxEU88ZNhTsRfkw==
X-Gm-Gg: ASbGnctrTg0MCE6PsEbv0CP/tMHSGlbyLF/AEEccNaOUlU0nUBkwoysZ1TSMCnQcyBY
	cOBL/CwN1B8E1LojaXoe/vx6wl+crXEtRvq2YaMPEW8NIRtrHemzM2o0lZY4LgST7mypuUtw9Tz
	zUg1Upd3NUyG1kVDCsvwezeYxEnJXjFlWFMlUB9iw/IYIC0EigQkxYYQIkZjyIRbMaAhEv75wrW
	GZq246MfevyuxgKg9c1yszJDP+b6VERDvWXMuea/xMPQK+9V8RsTHTA5/hN5BwgkxmMd6ECbbpl
	DQXRoboql1HNsL92I1atyDYAOeeigs6NMUi0r398vLH2q5w=
X-Google-Smtp-Source: AGHT+IH+F6gf2XNueBHflRLxqukuE9Kr0nge8eIC6egd4r6+AfvJPFdRa64UTA5TXvDo/KIj6NC/hQ==
X-Received: by 2002:a05:6a00:190f:b0:740:9a42:a356 with SMTP id d2e1a72fcca58-7423bd5544cmr23228398b3a.11.1747134438061;
        Tue, 13 May 2025 04:07:18 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74237a3dbfesm7764441b3a.138.2025.05.13.04.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 04:07:17 -0700 (PDT)
Date: Tue, 13 May 2025 19:07:48 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 2/3] packed-backend: extract snapshot allocation in
 `load_contents`
Message-ID: <aCMoBMajlgYOVB9w@ArchLinux>
References: <aCMnrwkoJ2WyqGZT@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCMnrwkoJ2WyqGZT@ArchLinux>

"load_contents" would choose which way to load the content of the
"packed-refs". However, we cannot directly use this function when
checking the consistency due to we don't want to open the file. And we
also need to reuse the logic to avoid causing repetition.

Let's create a new helper function "allocate_snapshot_buffer" to extract
the snapshot allocation logic in "load_contents" and update the
"load_contents" to align with the behavior.

Suggested-by: Jeff King <peff@peff.net>
Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c | 53 +++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index fb91833e76..1da44a3d6d 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -517,6 +517,32 @@ static int refname_contains_nul(struct strbuf *refname)
 
 #define SMALL_FILE_SIZE (32*1024)
 
+static int allocate_snapshot_buffer(struct snapshot *snapshot, int fd, struct stat *st)
+{
+	ssize_t bytes_read;
+	size_t size;
+
+	size = xsize_t(st->st_size);
+	if (!size)
+		return 0;
+
+	if (mmap_strategy == MMAP_NONE || size <= SMALL_FILE_SIZE) {
+		snapshot->buf = xmalloc(size);
+		bytes_read = read_in_full(fd, snapshot->buf, size);
+		if (bytes_read < 0 || bytes_read != size)
+			die_errno("couldn't read %s", snapshot->refs->path);
+		snapshot->mmapped = 0;
+	} else {
+		snapshot->buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+		snapshot->mmapped = 1;
+	}
+
+	snapshot->start = snapshot->buf;
+	snapshot->eof = snapshot->buf + size;
+
+	return 1;
+}
+
 /*
  * Depending on `mmap_strategy`, either mmap or read the contents of
  * the `packed-refs` file into the snapshot. Return 1 if the file
@@ -525,10 +551,9 @@ static int refname_contains_nul(struct strbuf *refname)
  */
 static int load_contents(struct snapshot *snapshot)
 {
-	int fd;
 	struct stat st;
-	size_t size;
-	ssize_t bytes_read;
+	int ret;
+	int fd;
 
 	fd = open(snapshot->refs->path, O_RDONLY);
 	if (fd < 0) {
@@ -550,27 +575,11 @@ static int load_contents(struct snapshot *snapshot)
 
 	if (fstat(fd, &st) < 0)
 		die_errno("couldn't stat %s", snapshot->refs->path);
-	size = xsize_t(st.st_size);
-
-	if (!size) {
-		close(fd);
-		return 0;
-	} else if (mmap_strategy == MMAP_NONE || size <= SMALL_FILE_SIZE) {
-		snapshot->buf = xmalloc(size);
-		bytes_read = read_in_full(fd, snapshot->buf, size);
-		if (bytes_read < 0 || bytes_read != size)
-			die_errno("couldn't read %s", snapshot->refs->path);
-		snapshot->mmapped = 0;
-	} else {
-		snapshot->buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-		snapshot->mmapped = 1;
-	}
-	close(fd);
 
-	snapshot->start = snapshot->buf;
-	snapshot->eof = snapshot->buf + size;
+	ret = allocate_snapshot_buffer(snapshot, fd, &st);
 
-	return 1;
+	close(fd);
+	return ret;
 }
 
 static const char *find_reference_location_1(struct snapshot *snapshot,
-- 
2.49.0

