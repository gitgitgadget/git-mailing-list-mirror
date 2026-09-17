Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE6B4E36EC
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667568; cv=none; b=Ih0aJiSD0IRz3xTQYAkqPEuAAsK51fLtHREbl7DGGMHGyClQzapeK9FqSBWJ8BmMP3N2pKr4PY5YdUFiDxi2kHcEWNKa8kbLaxcFDRyqW5IlKxOin/7/G2nVAAUbe2cFyCdg5Glsah4EGN6gweF6ZaJGA05YyEZ4og3i0UWJse4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667568; c=relaxed/simple;
	bh=evcLcDPTiOmM6TYcsmqgACTVip2UD/w2q6az0+eAbL0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GXuuEtXeWnZFKAd1/Go8vV4Xf0W81sPSg/ynmej4Ie1Xj/uizp5Q3+bTO7Yg63jrcpxond8p4TWNu7BqgK0Sa/G3jQpOaMU9/bUvkZtaXagSiYZ/3vs9bPzqvPMoTLVNp90s36Hkg6WOwiLBuoSNWjbTln6cYSdmBDIBk3gmhtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsTEusyD; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsTEusyD"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469a34908so1010003b3a.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 10:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789667566; x=1790272366; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FAU+4ADF2ZuPLQu0elnjSuSxCk0wm3bZyiWbmN4GkPo=;
        b=AsTEusyDkp91obnkTxOI1D/uBOFRVWp4mX8PrrNA1Gj3QOjlLnkjB7jU5inh/DLCyB
         SQkwNCaZPmdxfcfl7hOV/FHnQAmtNl3e0JrFLOwVXFg61zclEdYiD4XOB+s18wysLTcS
         W+LKDoelO4EY8HnXES4Kxdje2ipl7xKHauSKI1wprV5jNbIePiOn7NsPz0QMWnQtH3yt
         GrnWLTSp7hxVBnbqwMidpnYYgxXdf2X+kuoAs5p0M9Yoqi2/jQtjbCKQlSj7xbr+F5CC
         JfwSl1YLHF7pAVskFrv2qag/1d8BW2JlfsG/UzZBMtccQTqvUovJ0Bg4A6u+UuqCXC5+
         nxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789667566; x=1790272366;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FAU+4ADF2ZuPLQu0elnjSuSxCk0wm3bZyiWbmN4GkPo=;
        b=H8myA5yNamaVyUaP3VhDJNbvmuYEXWk+e19UIow39wj5bOyfbSBHJbk9osnR4WzbRC
         EgRHsuJSkW5CNG68RBkVIAMmt1KD6JT6cYP8MS01RFshUfYtnttAcr+ZFuc0RVGbFgbl
         +Zl80xgpS8BSMTGJhdErKM6JVcz/VxSLsC8KcwHNi1kDfkrw5ihsNs5v+o4Y05z9zH3u
         JPBvVJS6b6yvozoCrYREysExzmOYOe9+JIovPkk0JvIoSXeHffD+Yv4h9B4Y5xUdyBKp
         zZ4R4F8n3UB8EDvr1nnahP1WVL8y7X2EZc2OWc7kjJ4CxUOSPQ+WjYyUuuiEWPH7t+n5
         Jw3A==
X-Gm-Message-State: AFuF++mEq0mjzfUgUS6UTO7R7NCPyvLcKktYu71bDaA6/nob+hIX/Yfo
	Sr7EK5uVD9lYOPpqfxK+NshoIMZcZ7JiR88ka1goTuz/q8vNCIAm9tWIQm6qoQ==
X-Gm-Gg: AYBFou02ABpxcvX9iTMq5wwC353Emzb+usnSlOoDDZD8IlJdtQrI10VXS14SG0G294U
	hg65k1dc3tGAYSvv2eePxnqzqz+khJpD8Zfa+LPGX+DNoYhQxmx1nOK2OSLrUAdQXiKlcMBB2Ix
	72sOfMMSoudsGNkGAJ6DJmxHR2lL45GUGO212QBEJQaZeWXfa5uJsd50XRVku1M5LwbLhG9PS0B
	JmP+xw8cMyv3ls5MkHAd4q3GmtuzDPR26symRIbIy61Wj7y1FWSwtONx6G9Xsi1hrTXgGqF3kx4
	1x4qKVUZjriB2cbt777ErneGAlzdiC/jlSoGPtOq4zoU7tFGfl+YCxLCDvFF+eJHPRp/fDriPKj
	XTCa+Yw3rZNQbTsqmz24GZghFeY+S9nMev1H7vjgxEoHO9jNNQfK3HYMnmuYfsa71Ovqb0qZZZT
	nK4AuHpTGVpxpiXvbw8wvJQMTaTX6Um+BNXFQuiNkVBP6cMiaSnQXkZNyqWHBHGBykE4VGBsD1
X-Received: by 2002:a05:6a00:299a:b0:871:fcff:e904 with SMTP id d2e1a72fcca58-8723d432cccmr16352588b3a.25.1789667565968;
        Thu, 17 Sep 2026 10:52:45 -0700 (PDT)
Received: from [127.0.0.1] ([52.157.33.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-872025dd04csm3256682b3a.60.2026.09.17.10.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:52:45 -0700 (PDT)
Message-Id: <bd9e06e46c6debb5a8fc8f1d3821250ca110d5ef.1789667556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2231.git.1789667556.gitgitgadget@gmail.com>
References: <pull.2231.git.1789667556.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Sep 2026 17:52:33 +0000
Subject: [PATCH 4/7] rerere: do not record failed conflict resolution data
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

`rerere` can mark a conflict variant as resolved even when writing its
preimage or postimage fails. A later invocation may then replay
incomplete data from the cache, turning a local filesystem failure into
an incorrect working-tree change.

629716d256a7 (rerere: do use multiple variants, 2015-07-30) introduced
the code paths without checks for those I/O results. Treat such failures
as failures, report them, and leave the rerere status unchanged unless
the corresponding data was recorded successfully.

The defect has been latent since 2015. Git for Windows' Coverity run
only reported it after merging v2.56.0-rc0, for reasons that could not
be figured out in a reasonable amount of time.

Assisted-by: GPT-5.6 Luna
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 rerere.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/rerere.c b/rerere.c
index 1c3745d9e3..45bbe6ab2c 100644
--- a/rerere.c
+++ b/rerere.c
@@ -476,8 +476,11 @@ static int handle_file(struct index_state *istate,
 			unlink_or_warn(output);
 		return error(_("could not parse conflict hunks in '%s'"), path);
 	}
-	if (io.io.wrerror)
+	if (io.io.wrerror) {
+		if (output)
+			unlink_or_warn(output);
 		return -1;
+	}
 	return has_conflicts;
 }
 
@@ -729,8 +732,25 @@ static void do_rerere_one_path(struct index_state *istate,
 
 	/* Has the user resolved it already? */
 	if (variant >= 0) {
-		if (!handle_file(istate, path, NULL, NULL)) {
-			copy_file(the_repository, rerere_path(&buf, id, "postimage"), path, 0666);
+		int ret = handle_file(istate, path, NULL, NULL);
+
+		if (ret < 0)
+			goto out;
+		if (!ret) {
+			const int had_postimage =
+				id->collection->status[variant] & RR_HAS_POSTIMAGE;
+			const char *postimage =
+				rerere_path(&buf, id, "postimage");
+
+			if (copy_file(the_repository,
+				      postimage,
+				      path, 0666)) {
+				if (!had_postimage)
+					unlink_or_warn(postimage);
+				error_errno(_("could not copy resolution for '%s'"),
+					    path);
+				goto out;
+			}
 			id->collection->status[variant] |= RR_HAS_POSTIMAGE;
 			fprintf_ln(stderr, _("Recorded resolution for '%s'."), path);
 			free_rerere_id(rr_item);
@@ -778,7 +798,9 @@ static void do_rerere_one_path(struct index_state *istate,
 	assign_variant(id);
 
 	variant = id->variant;
-	handle_file(istate, path, NULL, rerere_path(&buf, id, "preimage"));
+	if (handle_file(istate, path, NULL,
+			rerere_path(&buf, id, "preimage")) < 0)
+		goto out;
 	if (id->collection->status[variant] & RR_HAS_POSTIMAGE) {
 		const char *path = rerere_path(&buf, id, "postimage");
 		if (unlink(path))
-- 
gitgitgadget

