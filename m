Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C523A2E25
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889487; cv=none; b=SdcPcD2T4UtLCWE8VVT6I2bmY1t1HLzW0bvScLEd5GlvI2H25/4pWEWk3sZ2qrPE/lwGHiE8nbq19zG56JY2thr91w3DX0hN44UnlJb2gVMr9sEJ+2RDmaANIYPDF2aHE2wjDg2CXrf651dDEmZnzkZxcKjXolTTM6B/T8lve7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889487; c=relaxed/simple;
	bh=+2IItQEyVHX52w16Mw2Fa5Y4y6KeUu4irCsi5FmyziQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Y4ZNC3YQa63om2/KzyxAO/si3Fg/eWTDxBqbozKwK+jDf/Vq2yRAgJ7Ovrh20w5cqRYncoeqwgdoXiyOrZJ3VssWjmHivxhN+3EfL7bhJu/Z689cWryIA28+HWPccPrQZpIJ6E0tZWolyKxPBCq1JJWv/SHzIgh6RhkDXPY3teg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4FmLR+T; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4FmLR+T"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8efcef23d21so2138246d6.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 00:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782889485; x=1783494285; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9mJ87xvlVJczGqhuEnnZ0tEz44Ej5YIwTQJFe38438=;
        b=L4FmLR+T346YGw58Q8ufldR6q/4m3s64yYHdT3/P7KYgiMwEbbkQXWPSh4W7MW1Ns7
         xdt0U7Tn7Q/sahX7FF5U60K3IVx9RviSi4ATIF87GA4c8uUTqDPUVCXFRyxX+Qy266Dx
         CWI+ZohZfMtAG/c2ofPqNb/ebI/O9RTp7Fta2QHOyJrVgS0lvbGpvem/iwWakFSX1Mbk
         Mes3OH8etfRHGknxthCViuTsb8UqBBW2w/zap/yC3KH4pxi4c8xKJuAHwt9cQMU28Ivv
         6RJ7i+cd/x5NNoAJaGsXQZZ53vhWEa0PhtHviFU+YIKo9CMJUktZroedMjU3nlQkU5rM
         ZW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889485; x=1783494285;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c9mJ87xvlVJczGqhuEnnZ0tEz44Ej5YIwTQJFe38438=;
        b=kF2hp5lnvnglKVtvanrQ+HllHaX6K2j7fvq7iCP9H7wBu9manmXAbLJWUlII+PPhAV
         EB4MgI87l9cYPaB+U1s3iUyxmzsyNF6LNDcNIXyk5TxCcQN5SrHGCmHyHp3WtDNC82Fl
         ty85W+DXaVPU1EJYgY6CnsR2boCvcKTqSHvZKna6vzvOXChg+RNQ3H1tuTl6RrOADkog
         HW16xp0bhfYn4ctZW4tu8D/Wqbm5bvF05n0iNX9qMNh3N9ChCkWgRxFO+gIy7OOvpY4k
         uarWh9NbZnEkuhUEw43WqF3Hj+FgmlXqcrnBX/J9oNgIXkXTxJnA9V9Qk1ECl5Aoy5/c
         +Few==
X-Gm-Message-State: AOJu0Ywza6tIK/73dIIeou2pjIK36rMBrixz3p48BLA5iLvIxQ9wgu6k
	36ksQnoXLPOErYwjDgZ4jK266CTz3CyGCN51AFl1XX5Muhy058vVSZGtcEjCwA==
X-Gm-Gg: AfdE7clKDX1Oo2xRoRCkfW1Z5jdsA8hyjovukWLGRfEbYn22+Dk+6Gi9zskQl8mrkrL
	N6kB4FRzqeDKg8ElaHWas7VPkk8BwDg4yickmM4vtIdtK6cenIo4tcNN1IHkHCF3U0CmrvShzK8
	id9d2JeGVqnhnytoRRc9xIxtxgKILY9TeKG0CE+vI54J1Bp8gP5he5a88jvorqU6525wZOOSgUa
	BkGZkEhjWBPLoDypUlwNcEdHYHQuNlqICwNDZtd+lBP+n28HDDsycNzdmSHLC4bHgWudEXmlYTG
	UunlxFchClPDmU/w9+9XcRM4/vnTistiJ0ZFTUJ84VhMKGK4xiMKC7MQmGgqfVLMZUJN1xnBJ1q
	bTCQpUxsDFHgS4am2fl7mENmlgzulOmdkvEstW7CShhV7ABSpWZTFvM0NT+n1icTSOs1rh1XGgg
	edTTfP0HdKbfBv7gThOv0f56wI1gY=
X-Received: by 2002:a05:6214:8012:b0:8ea:7785:f3e6 with SMTP id 6a1803df08f44-8f3c8ffa470mr4432186d6.42.1782889484940;
        Wed, 01 Jul 2026 00:04:44 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f35e791bd4sm13874776d6.10.2026.07.01.00.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:04:44 -0700 (PDT)
Message-Id: <6a43f952417259c23ca456c547b0e4587a0ce6fa.1782889472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 07:04:26 +0000
Subject: [PATCH 08/13] submodule: fix cwd leak in
 get_superproject_working_tree()
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

get_superproject_working_tree() allocates cwd via xgetcwd() at
the top of the function, but two early-return paths (when not
inside a work tree, and when strbuf_realpath for "../" fails)
return 0 without freeing it.

Redirect these early returns through a cleanup label that frees
cwd before returning.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 submodule.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index fd91201a92..8ddeebd8af 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2627,10 +2627,10 @@ int get_superproject_working_tree(struct strbuf *buf)
 		 * We might have a superproject, but it is harder
 		 * to determine.
 		 */
-		return 0;
+		goto out;
 
 	if (!strbuf_realpath(&one_up, "../", 0))
-		return 0;
+		goto out;
 
 	subpath = relative_path(cwd, one_up.buf, &sb);
 	strbuf_release(&one_up);
@@ -2693,6 +2693,10 @@ int get_superproject_working_tree(struct strbuf *buf)
 		die(_("ls-tree returned unexpected return code %d"), code);
 
 	return ret;
+
+out:
+	free(cwd);
+	return 0;
 }
 
 /*
-- 
gitgitgadget

