Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E4938228C
	for <git@vger.kernel.org>; Fri,  8 May 2026 08:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228220; cv=none; b=AQPz/R5Y6xCjNO8dVP1GAA8SpWLoaLotlAjcPTaPiy47XpR3WpX0xZwUBwsYNAIx0rFNuuKlYz6lpgzyCk42TdmOz5IOoU9YOnKxMFZsL7sPkQP5UCdiUsnTgOD9UzaX+Of3lfyfjkWvGjfDTyuwLr2NzbmGK1MJhjnc2C4tYAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228220; c=relaxed/simple;
	bh=Ch4ZBErVbusY8xMbrJ5XYeRQDTufxLWyl7o+Gu9/3+k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hDXIKhEKOioQ+do+smiiAvovDOrLvY3FAe7FgbgPo87puPU0bcP4ia9pnJidkcpRCIY6IpKo2RYvVdtDELQhaRAuDycPblTGcYUV+jMO4nfgCT6XY58sJMKfSIIzp+cIVsP9vXXm4/lmMug+d6KyS6AVnIu0pT8RN2RkmnMu7Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECq89e+r; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECq89e+r"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8acae26e564so16274026d6.2
        for <git@vger.kernel.org>; Fri, 08 May 2026 01:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778228218; x=1778833018; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhEmXpTPl9UV9prc2XZBCvUOi1tEp9rSq6HI2bWF4+U=;
        b=ECq89e+rw2LEcK6eAD1mP7oAshpMa/27cainrFOOwE/WBDIktAKAkVkA17Ya8JmVzj
         v5B0VVnPtryP3WAuksw4fCdxHBB2s1LwH/kKtr233IamSxr6kd/E5vsfaOtMFi8dtI5n
         qX2f1A9mmithGB0kbAdyoo0c1sfKEuQRQ4H/nkWPNZzxxJ1h+l+xi0fMUQRnoqBFt7Tf
         szy3ReuiX5SDKRq56brWHOtccW51Uv3QPbu2rRqTAcGdFo9t4zfRGVbraYu3tGf3II9O
         JWqXE/7aRCmfEUxw/6L+zaso9pCNkdLifIgjabIdTAaUruUdKmXSFGsIO0k9FHVhte4u
         eqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778228218; x=1778833018;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uhEmXpTPl9UV9prc2XZBCvUOi1tEp9rSq6HI2bWF4+U=;
        b=coqc35qCYFTJrOzUVEYkjlK761+PuVYAc3eTd8k3agjt8K5XDQwcZZnaun2RtNihFt
         0j0+ogKRaoDruESjJkHjJFIzeIqiuld1s+jdioeQvlPYVfpi7gWhP0psZUMtQw2BNQWg
         ay/NEWKzELwU0GHeCMpDrEWQOGgWwXgioxmWoeJLkiO3XVBpiHzib2TYylsWkF4tDjuB
         S45S6HRl8DSnjmW4Oeawqlqvg/B0j96ekXm+v9+AT+OokBpqcIDUrxa2d/n2YNe1DKJl
         QumVQcIgnIdQJY/JRneN8WBjbxgnRpn3e4pMg6adugGwAYXhnhww3gNr55J47xnUnI51
         YTGg==
X-Gm-Message-State: AOJu0YwtIdHY/aKmArAf7Cxei8m2pbQAHz7cqEX2NMmOuywhb2wUjyDs
	LJQI1VVWvR6Yoc/FFOwdK9iwVXGAz+XsbLS20a8epHaSj1elwXnD7isNUn3oEQ==
X-Gm-Gg: Acq92OEDlCm/YCNrp6MQkQRy8Eaz5gxGR3YToSNrSQJ3MPna4mmivPJ2THaZGf0/lDm
	1UdgNSUZ3DDu9NAFmL94NOUCL2z3J/LFxxOC7l/EczEbYv1QQx3Cl6bZNOnCj9yvROh8XwtP3dq
	dQOEw6YtSpzY+uLZbgv88ewwcOBdCpdcyza7l5hBHbN1CaFDk1XDe1mis7LjK4CJgu6oxIHvwf7
	9mDw1Uxa91vz2toUWcxGHrZ6za+NgqfBBIDMbrlooAxfbOMUcQ8kBCfN0ZIfLNE7XBwo83/VTqP
	kZuleuVPlLkhqWCqYA3pwhk7Qg+U2v2PQYkvPrqAFi1h248i2iCFG8mTo6Zlr1HE2USZ+2dkDsE
	9GRgyynLAY/fyHef823lurPhDBpkkkkU8muRJSWeQ3eeb6sCTPZBmw0GgkH40kDlT62+3NryBQE
	l4F/f9RwHCLQE4v9NIC8LixoQ9EA==
X-Received: by 2002:a05:6214:cc5:b0:8b5:6654:7556 with SMTP id 6a1803df08f44-8bc45b31797mr184414796d6.42.1778228217652;
        Fri, 08 May 2026 01:16:57 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf88247a3csm5687756d6.11.2026.05.08.01.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 01:16:56 -0700 (PDT)
Message-Id: <8e87a4e71f8684fbd4331b42b3237ffa4284501c.1778228209.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
References: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
	<pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 May 2026 08:16:42 +0000
Subject: [PATCH v3 04/11] delta, packfile: use size_t for delta header sizes
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The delta header decoding functions return unsigned long, which
truncates on Windows for objects larger than 4GB. Introduce size_t
variants get_delta_hdr_size_sz() and get_size_from_delta_sz() that
preserve the full 64-bit size, and use them in packed_object_info()
where the size is needed for streaming decisions.

This was originally authored by LordKiRon <https://github.com/LordKiRon>,
who preferred not to reveal their real name and therefore agreed that I
take over authorship.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 delta.h    | 14 ++++++++++++--
 packfile.c | 33 ++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/delta.h b/delta.h
index 8a56ec0799..fad68cfc45 100644
--- a/delta.h
+++ b/delta.h
@@ -86,8 +86,11 @@ void *patch_delta(const void *src_buf, unsigned long src_size,
  * This must be called twice on the delta data buffer, first to get the
  * expected source buffer size, and again to get the target buffer size.
  */
-static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
-					       const unsigned char *top)
+/*
+ * Size_t variant that doesn't truncate - use for >4GB objects on Windows.
+ */
+static inline size_t get_delta_hdr_size_sz(const unsigned char **datap,
+					   const unsigned char *top)
 {
 	const unsigned char *data = *datap;
 	size_t cmd, size = 0;
@@ -98,6 +101,13 @@ static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
 		i += 7;
 	} while (cmd & 0x80 && data < top);
 	*datap = data;
+	return size;
+}
+
+static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
+					       const unsigned char *top)
+{
+	size_t size = get_delta_hdr_size_sz(datap, top);
 	return cast_size_t_to_ulong(size);
 }
 
diff --git a/packfile.c b/packfile.c
index fdae91dd11..4208f53046 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1161,9 +1161,12 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 	return used;
 }
 
-unsigned long get_size_from_delta(struct packed_git *p,
-				  struct pack_window **w_curs,
-				  off_t curpos)
+/*
+ * Size_t variant for >4GB delta results on Windows.
+ */
+static size_t get_size_from_delta_sz(struct packed_git *p,
+				     struct pack_window **w_curs,
+				     off_t curpos)
 {
 	const unsigned char *data;
 	unsigned char delta_head[20], *in;
@@ -1210,10 +1213,18 @@ unsigned long get_size_from_delta(struct packed_git *p,
 	data = delta_head;
 
 	/* ignore base size */
-	get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
+	get_delta_hdr_size_sz(&data, delta_head+sizeof(delta_head));
 
 	/* Read the result size */
-	return get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
+	return get_delta_hdr_size_sz(&data, delta_head+sizeof(delta_head));
+}
+
+unsigned long get_size_from_delta(struct packed_git *p,
+				  struct pack_window **w_curs,
+				  off_t curpos)
+{
+	size_t size = get_size_from_delta_sz(p, w_curs, curpos);
+	return cast_size_t_to_ulong(size);
 }
 
 int unpack_object_header(struct packed_git *p,
@@ -1618,14 +1629,18 @@ static int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_off
 				ret = -1;
 				goto out;
 			}
-			*oi->sizep = get_size_from_delta(p, &w_curs, tmp_pos);
-			if (*oi->sizep == 0) {
+			/*
+			 * Use size_t variant to avoid die() on >4GB deltas.
+			 * oi->sizep is unsigned long, so truncation may occur,
+			 * but streaming code uses its own size_t tracking.
+			 */
+			size = get_size_from_delta_sz(p, &w_curs, tmp_pos);
+			if (size == 0) {
 				ret = -1;
 				goto out;
 			}
-		} else {
-			*oi->sizep = size;
 		}
+		*oi->sizep = (unsigned long)size;
 	}
 
 	if (oi->disk_sizep || (oi->mtimep && p->is_cruft)) {
-- 
gitgitgadget

