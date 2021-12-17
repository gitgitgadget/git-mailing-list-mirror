Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10005C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 11:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhLQL2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 06:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbhLQL2l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 06:28:41 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D000FC061574
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 03:28:40 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id p13so2028749pfw.2
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 03:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iJgkkNBSVRjeafKIJmXpkSQF+/WV+eDw6hCVfs3Wqps=;
        b=VoiHwQ0HSbslKIt6nH3pzEj/djZ5Oy21SfZKk0XwTiOXbnHDeVzHBiIgmNJ/HavskC
         FBg4C4H56oNyn820wiFk1nT7jkEzhnzLYdynLGN024lL8ejSfKJNIRk0vj70OwQC8Nl+
         RLwIl8DehZOiuUiNnaecs0VMqKHVH0GEr7WqrfKoilTObeJDwOfrRq0CNo6Ea2FZKQWc
         GzwRnPn1u6yXJ+lzFMUcPhmRDrA7Ya5TKbrPBIS0O5InAAcSywjTpwv/b+QAUfkZbxHh
         Krb2Twum4IWRLoCDVXALXD79Ftox6p/sxneQIaWUTVUjAOLRz/3GQBgpHqqoKLFV/K86
         6qWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJgkkNBSVRjeafKIJmXpkSQF+/WV+eDw6hCVfs3Wqps=;
        b=jsJQcNR7sV+oICOIgXWx2QOvVHRJBFty2Qkab5CKCyMdhZtmO42cJSM9vmGLsvuVpx
         B4vpY8lKbsXWJqHtxngkKmDsCNCOIaTKh0Nrm5M1AjeYkV+GMbwY0oqkuH/vBD66ezok
         MVJq99jSDq8czpUg6BhTV3MCj+p/vRsJkq3oyQWWkEw8esdBHCcNaY4TKDA7HFXZByed
         CKLTBXtjN+1tMu+c1xTJRe2UMAYMaoLOUVxvoZbdUjqDMRhkk4PMR2aWe+3Aj0JEqMp8
         2JA89guERxFmgMJsMfRBGTeGAAK3BE7KvNVTPa1j09GJaCbHFE1sNxZ/YmqovWap/62h
         Ezuw==
X-Gm-Message-State: AOAM531aC4OIDoMuRoZFv4Np3y27VHEfTQFxA1XbTtiti9bpiVwoOFKP
        wxqjmsU9eGToYIa0xYps7dUE/OWdSRirrHHF
X-Google-Smtp-Source: ABdhPJwDpnJSCr/eAZYdXOQp8qw+DXiQ+hg8rY4mB/vs2PC8IRxQzTcLP5irtVDtjHQDhNvwLOqdYg==
X-Received: by 2002:a62:e907:0:b0:4a0:3a71:9712 with SMTP id j7-20020a62e907000000b004a03a719712mr2804187pfh.73.1639740520412;
        Fri, 17 Dec 2021 03:28:40 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.97])
        by smtp.gmail.com with ESMTPSA id f10sm5194673pge.33.2021.12.17.03.28.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Dec 2021 03:28:39 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v6 1/6] object-file.c: release strbuf in write_loose_object()
Date:   Fri, 17 Dec 2021 19:26:24 +0800
Message-Id: <20211217112629.12334-2-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.1.52.gfcc2252aea.agit.6.5.6
In-Reply-To: <20211210103435.83656-1-chiyutianyi@gmail.com>
References: <20211210103435.83656-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

Fix a strbuf leak in "write_loose_object()" sugguested by
Ævar Arnfjörð Bjarmason.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index eb1426f98c..32acf1dad6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1874,11 +1874,14 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	fd = create_tmpfile(&tmp_file, filename.buf);
 	if (fd < 0) {
 		if (flags & HASH_SILENT)
-			return -1;
+			ret = -1;
 		else if (errno == EACCES)
-			return error(_("insufficient permission for adding an object to repository database %s"), get_object_directory());
+			ret = error(_("insufficient permission for adding an "
+				      "object to repository database %s"),
+				    get_object_directory());
 		else
-			return error_errno(_("unable to create temporary file"));
+			ret = error_errno(_("unable to create temporary file"));
+		goto cleanup;
 	}
 
 	/* Set it up */
@@ -1930,7 +1933,11 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 			warning_errno(_("failed utime() on %s"), tmp_file.buf);
 	}
 
-	return finalize_object_file(tmp_file.buf, filename.buf);
+	ret = finalize_object_file(tmp_file.buf, filename.buf);
+cleanup:
+	strbuf_release(&filename);
+	strbuf_release(&tmp_file);
+	return ret;
 }
 
 static int freshen_loose_object(const struct object_id *oid)
-- 
2.34.1.52.gfcc2252aea.agit.6.5.6

