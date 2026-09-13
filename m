Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883473F327B
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789331198; cv=none; b=DOx5AxBOG3Q2bNr6n+wQsLAPXsEjSDlvZbPhsApzM1cxRIjifhUY8Sc8+46n2zJyb1gAy7Srb5tQTApgw2anwJAOypv/iTEuLHQYqxF5Q2OUIjsZN4PqJ7UYDviUtkrginiXP9sj3nLPgf6Vidl6B+dpsWDuwLW+RLsXV7TAFkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789331198; c=relaxed/simple;
	bh=of93voeNMq9BZLIbir606XJYMW1qFaIOWCB2B2fwhj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjBOyrbiHPp4d+Hf7n4ZZAH01iPFv1WAtYrID3zf8Cq7Xr4mq8b7Bj1HHHZs8GStJ11qO4cW7itPHyYwayRJS/TiYDsIBM0Vo+IlXyAtkqlpfwRojYxkHRhLCUzvS0WhyOv91FbdotkysogDpir7S2/jSGJJHquILjWnkos+/T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUZ1coKu; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUZ1coKu"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdcaso10109997b3.3
        for <git@vger.kernel.org>; Sun, 13 Sep 2026 13:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789331196; x=1789935996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7aqns7bstEKF/9L6/SUUIxXvje1ZLiycovjty6eGDmo=;
        b=NUZ1coKuIZ1zqc91mXdjd2L5vSm1apjjT9pxHGRA0yvxpNfnrNF8rxpzUHfvRE2fPM
         E4bIQcaEPOVSc4Efu81OROv1cKlL+L//9E7he/lAtM2kE5Br6RY5r/xHyL8D2uuPjYz8
         08hwW2mnnuUyZgK64M/Az/1F8DNAEP7p94fOszoSyxILD/V0LrZ8GN1GRXOHRgDPpf8U
         ArkxqQYi4bZrkYRAWR0MKyqR/o8MF2CquvFjIGBbvdCQ142AgQ7zrnKb9h9ioyVKpHuC
         yf6LVKLfZWcc8kKfvxtpe1b06tP0veyAlQ+HZDjt29el4eW87FXgGq6iGvIxSlruJn3O
         xkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789331196; x=1789935996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7aqns7bstEKF/9L6/SUUIxXvje1ZLiycovjty6eGDmo=;
        b=mDkB5UsFeKiDlRa2c3a5JmU4H9E7prJxsm3458NphMXi0vRI+teMECWEfleQjO4roa
         QMXL8HZrKUCYQWklkXaBYAwkM/cF2xIBFFTvcp8OxiWgM/06FvF7Nox8wG/T5BDIjkdf
         cTJWmvAi3Dl9qAZB5mUdUnUbNyWbf0Db0p1DO4lVmszBj2hDkVu2UUYTN4MLgNbUW/tv
         vRIljVoVeyKJqwCy0QolBKZqySMI/rZGeaabACNVhodvwwmyBC0e8yGOD4dKj9ZOZBkj
         WliG5d3U7Ml+QXSxs9cOW1NIbwKCUmsNXQDMG4XupzaygU15uw6g1IxERmhR5ved8+tR
         EBcA==
X-Gm-Message-State: AFuF++l8ZXOjd/ZQ2+KCmqXQ8gTCAli7n+kyHH7zjCGsawI0wbEfD4Ko
	7OCdaTuhnlBDhG5VB/xrTKPqm1STkr/OKjoq7AKn7FONLAkY2twLwG3i/XH3W+7v
X-Gm-Gg: AYBFou0ydlF7Ha6F4q2tKo7FJ+19xQUIpFwBJrNAw15OQ52xH4NNMfVhoPQ4Hb3P9WI
	jo66/s7pXD5qMMlFL/aYQ1e1hrFbDuAv4/c/khhkimF2Z7Nvv64mXYq4pgNLxc0ovA6dihEwiFm
	oO/Wk+MiSpBGXMKoQRE8zbGv2GVzMeWstocdH7E8j87xUMBa0ZgP2Va66/STE3K2RaKY7RYqH/2
	mwj+qUv42bWNuDxJoCTLbVlluXfgU/cUG6l6egjwPygDdxLEKEXZq+GPDV77JpeJjC55LdwaLel
	8o7Sjp1qiUWDKfnNazAoFRL21+7q5MUCAv4YKML7hIFOd5z1j2LgGpf6ANezb/VnKHT9bUkguxg
	hEQwPitree/h3hhqIDLALVBDSaBMkTOo9+qcPhnvSYuVHl0cXc8zrTq7L1HGEicBHeL0cfaYRXo
	1R/DnVrOv0tMeDOrvg3k6K5rTBcpSgQdW66QJ3xtYeKmchv4PTrbtZJHne8PBYhcYv3BnFI2KtA
	sZhaklla2uv1xQSeM4iln76WHJgpj8zadkjY9pvqXs5
X-Received: by 2002:a05:690c:e1db:10b0:87a:db19:ab5e with SMTP id 00721157ae682-884afc193ddmr39418887b3.10.1789331196413;
        Sun, 13 Sep 2026 13:26:36 -0700 (PDT)
Received: from jtobler--20250820-SHC54 ([12.86.123.90])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8847db4476bsm30317047b3.5.2026.09.13.13.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 13:26:36 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/2] object-file: flush transaction packfile before migrating objects
Date: Sun, 13 Sep 2026 15:26:22 -0500
Message-ID: <18a1798d958d7f089614ec588346096c10b0666a.1789328612.git.jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789328612.git.jltobler@gmail.com>
References: <cover.1789328612.git.jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A "files" ODB transaction creates a temporary directory to stage newly
written objects in when configured to batch fsync loose objects. Once
the temporary directory is created, it is configured as the primary ODB
and all object are written to it accordingly. This also includes
packfiles containing blobs that exceed `core.bigFileThreshold` written
via `odb_transaction_files_write_object_stream()`.

If a "large" blob packfile is written to the ODB transaction temporary
directory after other loose objects, the ODB transaction fails to commit
as a result of the temporary directory being migrated prior to the
packfile being flushed. Fix this bug by always flushing the packfile
transaction before objects are migrated to the main ODB.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c    |  4 ++--
 t/t1050-large.sh | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index 0f123b79fad1..210984f82532 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1262,6 +1262,8 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
 		container_of(base, struct odb_transaction_files, base);
 	int have_packfile = !!transaction->packfile.f;
 
+	flush_packfile_transaction(transaction);
+
 	if (transaction->objdir) {
 		struct strbuf temp_path = STRBUF_INIT;
 		struct tempfile *temp;
@@ -1292,8 +1294,6 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
 		transaction->objdir = NULL;
 	}
 
-	flush_packfile_transaction(transaction);
-
 	if (have_packfile)
 		odb_reprepare(transaction->base.source->odb);
 
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index d295c265c75c..fb83c8fba619 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -87,6 +87,22 @@ test_expect_success 'add a large file or two' '
 	test $count = 1
 '
 
+test_expect_success 'add large file with loose object in batch fsync' '
+	test_when_finished "rm -rf batch" &&
+	git init batch &&
+
+	git -C batch config core.bigFileThreshold 5 &&
+	echo foo >batch/1-small &&
+	echo foobar >batch/2-large &&
+
+	git -C batch -c core.fsync=loose-object -c core.fsyncMethod=batch \
+		add 1-small 2-large &&
+
+	# Neither object may be left behind in a temporary location.
+	git -C batch cat-file -e :1-small &&
+	git -C batch cat-file -e :2-large
+'
+
 test_expect_success 'checkout a large file' '
 	large1=$(git rev-parse :large1) &&
 	git update-index --add --cacheinfo 100644 $large1 another &&
-- 
2.55.0

