Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E14C24677B
	for <git@vger.kernel.org>; Thu, 28 May 2026 23:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780012191; cv=none; b=odBfr9xsWkpBnL78JT6oTZfHFXMS0ZPWkCNVpIRk8B+EAbahLej/cQsAZuAWnKCmAt5tCBVvtVbHwS18Muw2ie7LlajjqwCAXARYjX/+N7sAeG/Yg2Ouko75RIIiFC+460CxR0AEE+tEG+Ul6NYQ0UMXn9bD2haVmDFv3KmpJ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780012191; c=relaxed/simple;
	bh=eQTPmJJt4PLGiVSDi7k3AT0VdtjuWXBozCK6o283OoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLFBW1O+F5EKPpMaxSb2bFG10iocuImqIhiy4iwP8bgpYp0Ibfpoc4dsfbhxpDIyPF4h+mZ29z+qhN7F9ToZeGA2h+hQjV/hxseZGQKqFGnx58zIEiMZ1MFeSUMpgJzFIjdZfgW5ZvgEmTiO4l7RhYs/rQ03uZKJIOgCifi4zk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkBU0sWy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkBU0sWy"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so8088325f8f.2
        for <git@vger.kernel.org>; Thu, 28 May 2026 16:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780012188; x=1780616988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQ2ZJMwsvTef92Y1UW8Z+Aj0fqTfuoRZH2MvmnlKg0E=;
        b=mkBU0sWyN8C4FD4dOV5kodwCxDxFmu2lRU7nJhhqQNkI3I1/2yd+emLB7CKtvrlJ0Q
         R4iLWbrhiKuN7ADq2wa3pqfSmep7+QPH/4tQ7e4tL869v8P/Mm/BPSJaWzbdM4AjPaxM
         pTflSMNTFGS8uzQDuU2Jxh5Vp/b4iNv1Yg/FxYbk+BTHFF/Fy3F+u2GfxCGw38kJvVh4
         kxrVrKqgCQmoM4CFuPKpY3CASKn8EpSM8HVHf+0lnDmAg+osHNN1hmSxm4F3Jt841GEL
         UxO2Wgj9c4C7DwwKEmJeCKgsXguqmNggCkg6eW7f4iruj/UpfZKT010+LZLjfwfC5JSe
         Dhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780012188; x=1780616988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQ2ZJMwsvTef92Y1UW8Z+Aj0fqTfuoRZH2MvmnlKg0E=;
        b=iGCLTB43knlBKq9N66emQLHW8lTUEG9DEwTZnr0i+ry3G7QtUOgPV9lfMdanAwYbwE
         mhTzVP03D0gIvs/STLfERMJsmXUdZwYdZkhggcTlPmLDDfHsIn16zw6MsdC/NWXrAfU6
         Yfb3RStGRG/C+SGCURUKgeyhyJcdfKU3yTLY39XmmmrJAaJfrijuqXi53NcrOBmi10qy
         dOuP+MTSQM/KpGZDEWFZGFduVGodv71qMg6IqirvwVj689Q959Msnl6iLjNycGFxMeuW
         OEUM5bbuzI2V+qN86GSzwhJvLXfzN97AsX/5CjNtYvnAsnyoLJHL7bAREDm/Lf2y8SR6
         UqqQ==
X-Gm-Message-State: AOJu0YyY22HH5IiJX3X/+AMok8r6WFYsyAfqkeDU3QxyzDDj7pwphlsz
	ZyaDIl/4Z8r2+kC3pxjGR8l0iLAO77do44hUdY6tyD2L8xQcT7Zze9Ks4EL2Og==
X-Gm-Gg: Acq92OEgUVlI0tiL/3l0CsYPFSUmsNjdXMgXFIs6Xm9Nr54E036EH8+k8yjH5i4/frv
	UF12Vd0KTjIb5Hsy9dtzkNUj2V7LXcw+UYwNUs0flxLfcXRzSEzDEk22/r6ZzZC65/zfzzocUdR
	rHTH1yoPpdMnMuheMhmIStAk/TEwbjhQp67qdmCICTBln/7XXX0g1zaraWPUDaba4kzAG2ydQ/2
	VCbqqgY9iksNuEeAFliQLMTaPJM7mXcOJiUOSGeWaOVUJMeeIAtSTBWTjvd2941WGSj7q4q3iQ7
	gGcK7E+vWB+05VHz6TNsiYtxXZ3G3M08+zGvAcJjdKiFOztFIoTsQ98KAuT5ugzUBaTRM+jEJg8
	HfwAnNAg09hxTv/RYCehk4Pa3iaWgyW9q5XuzveJPBnnfxAl8/kcdJe7fZV2Pp17LiCsRhhFjTL
	fpPbggmYos1/MJxVrMZ/XfvVgjYdWMrpchQjxu/vBSkVYCkM1w2Ckq6ln2ZMyvilQBYdp21+htc
	2SHuLSIxB20aenohFGka0uWMpnZyFJJPw==
X-Received: by 2002:adf:fd8d:0:b0:43f:e990:2f5d with SMTP id ffacd0b85a97d-45ef145aad5mr428322f8f.35.1780012187997;
        Thu, 28 May 2026 16:49:47 -0700 (PDT)
Received: from lorenzo-VM ([84.33.159.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef258f1ffsm180331f8f.21.2026.05.28.16.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 16:49:47 -0700 (PDT)
Date: Fri, 29 May 2026 01:49:44 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>, fox <fox.gbr@townlong-yak.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2] http: fix memory leak in fetch_and_setup_pack_index()
Message-ID: <ahjUmMCKxREamQE-@lorenzo-VM>
References: <agx5tblaCZNsYEBq@lorenzo-VM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agx5tblaCZNsYEBq@lorenzo-VM>

Inside the function `fetch_and_setup_pack_index()`, when the pack
obtained using `parse_pack_index()` fails to be verified by
`verify_pack_index()`, the function returns without closing and freeing
said pack.

Fix this by calling `close_pack_index()` to munmap the index file for
the leaking pack (which might have been mmapped by `fetch_pack_index()`
or `verify_pack_index()`), and then free it, when the verification
fails.

Also, do some more cleanup by removing the useless call to the function
`unlink()`. This is not necessary anymore since 63aca3f7f1 (dumb-http:
store downloaded pack idx as tempfile, 2024-10-25), when
`fetch_pack_index()` started registering its return value (in this case
`tmp_idx`) as a tempfile to be deleted at process exit.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 http.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/http.c b/http.c
index 67c9c6fc60..99da4d7529 100644
--- a/http.c
+++ b/http.c
@@ -2538,18 +2538,18 @@ static int fetch_and_setup_pack_index(struct packfile_list *packs,
 
 	new_pack = parse_pack_index(the_repository, sha1, tmp_idx);
 	if (!new_pack) {
-		unlink(tmp_idx);
 		free(tmp_idx);
-
 		return -1; /* parse_pack_index() already issued error message */
 	}
 
 	ret = verify_pack_index(new_pack);
-	if (!ret)
-		close_pack_index(new_pack);
+
+	close_pack_index(new_pack);
 	free(tmp_idx);
-	if (ret)
+	if (ret) {
+		free(new_pack);
 		return -1;
+	}
 
 	packfile_list_prepend(packs, new_pack);
 	return 0;
-- 
2.54.0.129.g2dffd77b94.dirty

