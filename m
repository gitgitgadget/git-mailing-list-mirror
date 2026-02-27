Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5A4296BBF
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 23:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772235778; cv=none; b=AXPSIPDDDVFzeoePB5dZePn4Q88Qq6QbsAZKbNRA1Noq56XovFxGzxn0FOv+9E2oPEfqJMI6xPnZbeLQj+wTptVdMAotvprK8NZRKBCEJfqkF9S5Kp4uY7UH61/SW3dPRvha5+5j7eGZSvdR7IcBcBcFR/lP+MGlgwl0L1jjISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772235778; c=relaxed/simple;
	bh=uGMmbmSGti8tVPszMpjyLFkxHtLIR2oYeqFu8yTZh8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiHGy/EwbIAS1xTiSybqx8KbiQDckJ5j5xo+eFkifIgpPxOR9q5pzFHChAC/J9fiI4IDEb3WegrpLVtBXq/uQE5IIieOEPbPu1DF4m8ES7Q/enZaVS6XohbDD6q4/kYKZZa9oc7+RZLHW1MwoHcGLffWYfQvh+MHopyCnhIMbEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCIE4Ncu; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCIE4Ncu"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4398913af88so2267935f8f.2
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 15:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772235775; x=1772840575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3Z/n+1CxnYwK1fBsgJFps56ZeQoKd6svcB3MrTBPho=;
        b=XCIE4Ncurjgkxydf0eRn4M4+IsqMcuKDV2sXG5EiVKDpPcGQm7nrRonQyGFo8G7KUp
         ukBRdRTUis7rfYH3Mw8YiEeZEkrQFTemSND0dxr7lvDCMkWEXaQ9+FhjEY32HnehOBQB
         OPOWhbYLWaF4tCVjCg1MHaL+6JKutGM659DWelpVKnPUiNs79BivQuYB90jFLM6aEO/u
         IU8MxTD8ACN+AJOu02sfsfeAXUmeHx9VS5AoTR3OqEafccLFZLv6XvNQMM0x+u7tQb5x
         tDD5nSzMaLzTLke8UzN71CsDIZot2iIr0vNBZvmH44+yI+39osDNMpIsl8SSvAvGZMUc
         jXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772235775; x=1772840575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u3Z/n+1CxnYwK1fBsgJFps56ZeQoKd6svcB3MrTBPho=;
        b=X2jW1EeUzejvZdUk+GTpuPQh9UoXr5vLEN6pkiydzqMCOzOUAvGx6A11prW6L2dy7d
         wIEgGNPXeEUw9hlUdQUEItbLUttpdP8ozwlKZJ7nDj2qwXLYlrvIQQ+Nn9pPJdtsMlZL
         KIOOPDS5EfphmXu+3rI3Em37+u4+bpXkfNfluC1CSHLYvFYHCzlmVnzJQ0ml/BORtrt8
         oxJOlAtfgKG1WPPvuabTDbmJmjR5OitelLJc1x69sjWtmCsAgOjpMTzNgdtigjfKB43q
         VECV4SiNQRxyttBPy6zjiXESdIc34j92dNFN2Hgs1xZIMq0YAyy3OU4YWMt1EsNOenl6
         khWQ==
X-Gm-Message-State: AOJu0YxDeNf0IVtVnWU6yM5GmBiwXbZY6OGjEVSNFuAVBikmTDw6eOLn
	JjdBW2QuBjlmhK95gpFK67+/rFsoZl7G+4G6Ur/k8QBPSNrnlhOQt+i79rTQ46Ju
X-Gm-Gg: ATEYQzyKEmeRnNXMiifrHyxPe0cAbVDcyBAUVLLbyuSUPC3Ln30paWkutpduOz0p5+Z
	qvvqHTIKJgRigezMoLAIvDaCcnU8tKQTKkzEUwLpeNfvKetkZsPcJL9kvHRCewzGn4RNPQt1yWH
	HOKGDk0a311Y2FZcheWPyvKVbyccw/H4LFJSXtFJuf3i2gCCZBHOr10nlh07jf6DFZ50I5ogXuw
	o4JRM+J8vBD1EXEA3U5nm6GLyXEXm3cCCB8nX5v+yAJBm9IpiXixbCirTg3HqoUSTz2wEKNaNbc
	OUp8a5h6J6tdhKGcvKtiUlh0tPxisYzAJy6k/glX1HS+JVm2+2u2m70xWY4zqOGX1M/p3rP/j6A
	ciyqgXApIq7spssJgAZfte8SPqcROaUxHy7NZn7HKbewGAinlTsEqCoBxSVlXbSiFAyWh7cHWRP
	PZ+NowrqtthN5U5Ii2rx7O5Tfdx3UvP3D7pX8GMLZlRyRFFtioDbwF
X-Received: by 2002:a5d:584f:0:b0:430:f985:a7b2 with SMTP id ffacd0b85a97d-4399de38167mr7740199f8f.51.1772235775023;
        Fri, 27 Feb 2026 15:42:55 -0800 (PST)
Received: from localhost.localdomain ([105.113.107.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c76b40esm9710899f8f.36.2026.02.27.15.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:42:54 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Seyi Kufoiji <kuforiji98@gmail.com>
Subject: [PATCH 2/5] builtin/rev-list: migrate missing_objects cleanup to oidmap_clear_with_free()
Date: Sat, 28 Feb 2026 00:42:10 +0100
Message-ID: <20260227234213.17633-3-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227234213.17633-1-kuforiji98@gmail.com>
References: <20260227234213.17633-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seyi Kufoiji <kuforiji98@gmail.com>

As part of the conversion away from oidmap_clear(), switch the
missing_objects map to use oidmap_clear_with_free().

missing_objects stores struct missing_objects_map_entry instances,
which own an xstrdup()'d path string in addition to the container
struct itself. Previously, rev-list manually freed entry->path
before calling oidmap_clear(&missing_objects, true).

Introduce a dedicated free callback and pass it to
oidmap_clear_with_free(), consolidating entry teardown into a
single place and making cleanup semantics explicit. This improves
clarity and maintainability.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 builtin/rev-list.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ddea8aa251..567dc5e7f5 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -88,9 +88,17 @@ static int arg_print_omitted; /* print objects omitted by filter */
 
 struct missing_objects_map_entry {
 	struct oidmap_entry entry;
-	const char *path;
+	char *path;
 	unsigned type;
 };
+
+static void free_missing_objects_entry(void *e)
+{
+	struct missing_objects_map_entry *entry =
+		container_of(e, struct missing_objects_map_entry, entry);
+	free(entry);
+}
+
 static struct oidmap missing_objects;
 enum missing_action {
 	MA_ERROR = 0,    /* fail if any missing objects are encountered */
@@ -935,10 +943,9 @@ int cmd_rev_list(int argc,
 		while ((entry = oidmap_iter_next(&iter))) {
 			print_missing_object(entry, arg_missing_action ==
 							    MA_PRINT_INFO);
-			free((void *)entry->path);
 		}
 
-		oidmap_clear(&missing_objects, true);
+		oidmap_clear_with_free(&missing_objects, free_missing_objects_entry);
 	}
 
 	stop_progress(&progress);
-- 
2.43.0

