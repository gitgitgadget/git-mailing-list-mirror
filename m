Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A0F1799B
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958648; cv=none; b=FajtsysBlcSz0yKhwdVG2dCs+6H+9S1av8cBhqx9/1+b0xCEArqaL5KPNuw1ZSYa6NQREL7u5CdTspGAZsHioSViIRl1G90ESr70/L/A2p4jlcT5dr7U4PVnKd88zNXvLQ+nsk0ao83rt9H7VZjqnE1IhNBBw/Wpo3UxczC/+oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958648; c=relaxed/simple;
	bh=0QTD/S3loZbpDanEny7YsLfKvDpI20eU36WXVz8jNvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMx3GubNNpSBGlPW+MIiIZMX+TkdRZcYCcljcKD2HoO6CLAAsgW5bbQ8s1cbJi5Fx+QtDj98xUU+eF+luyq/fIy9KO1Gi5qfsPp1lNa9Ga9X54Lh5ggpu5vDu/ySl+dn1e5msXTgX3NOzDafvdqJvAYRXcEh85VVjd9iQtTbvRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BseqLjA9; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BseqLjA9"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-690af536546so8783307b3.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 08:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722958646; x=1723563446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K+jJH0I0zUZUGxrC82+YHBH2XRXd0I0zLiSIY0smqO8=;
        b=BseqLjA9y5I7kJoUNhQUhrMdjTT+1/BVpCPCkGUviGAxXQwUCvN3VJnQ583XRBVzpK
         bNRr2gajHx53vfUDzgfDNjEInyfMuxAFKZ5OT5Rg40q1DeNQ+c5NHhj5cOowl7YoI9VW
         KutrmVPG64gMU5zZ3SPnbLkgnAkWR3we1KUuAhMe0EzQN0CsTbpOSyrc3GsDAQO/ZAsD
         Rzd6qNTPGRU8OK5ssPyDh+JwXi9YtLrEVgLw0LbFCscEBAa9ZegHMJjswbk2lTgIEeJd
         sgYNUV0E/YGgB1s3vVngmDUAaNKH83mBibZzuL88Waczgj1WThjHXKfACwPOE73u4MhJ
         2qYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958646; x=1723563446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+jJH0I0zUZUGxrC82+YHBH2XRXd0I0zLiSIY0smqO8=;
        b=JEkRUBATltV0ogDUtJOivkL1QknpL06eGqJW/9z/ZKEgtwFvTXgGDTL3w03TBL9CB+
         88buGLEVWvU/QUqr/6SX+miJjctoPYzYiF0tLykT3vEP/LvFALEA7jqcU3zYr9PBCquL
         KWbBYt3ttpNeVqwHNeIwpqn9Wfe2kZ0s+3wwUTX4al1bIKVp0rcKHLckNo3o9fR7ZQ4C
         L6LWos4Hn1VRFALysk1PyNFdkojQB46tb0Ozjp1dxCJSENqZDZ2XyhGn6hxhlpAknwXx
         6B5g9yckM2/Zimkkr3CSUC0ERq/m+uVzm7Q3ZG0guPhG9trkkn/OOnYNN4BLh4+N0IpB
         3G/Q==
X-Gm-Message-State: AOJu0YzJe0lOngVGygDMaWv7W6QrxoTqednFgpyyWIqjfl9bDiQW5Q7W
	+SmdHQwm4YK41aVAfeZRAqzo9yhXLajZlisTetHw1UGWobOaUWCDQzkW8srTj+V++2yTH6+T2ty
	U
X-Google-Smtp-Source: AGHT+IEZ/SHDxUEZuKtVZQNjq43orXWCvXScpcOM/tT/4bBkeighPItijZHGm5XVmf0uKutJpOfOkg==
X-Received: by 2002:a0d:f585:0:b0:687:f1f3:6738 with SMTP id 00721157ae682-68960589767mr170009467b3.19.1722958646209;
        Tue, 06 Aug 2024 08:37:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68f3452478csm10809897b3.86.2024.08.06.08.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:37:25 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:37:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 05/19] midx: teach `nth_midxed_object_oid()` about
 incremental MIDXs
Message-ID: <e68a3ceff9a3dc3d9c2504ed13217cac150c3640.1722958596.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1722958595.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1722958595.git.me@ttaylorr.com>

The function `nth_midxed_object_oid()` returns the object ID for a given
object position in the MIDX lexicographic order.

Teach this function to instead operate over the concatenated
lexicographic order defined in an earlier step so that it is able to be
used with incremental MIDXs.

To do this, we need to both (a) adjust the bounds check for the given
'n', as well as record the MIDX-local position after chasing the
`->base_midx` pointer to find the MIDX which contains that object.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 07b3981a7a..64a051cca1 100644
--- a/midx.c
+++ b/midx.c
@@ -338,9 +338,11 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 					struct multi_pack_index *m,
 					uint32_t n)
 {
-	if (n >= m->num_objects)
+	if (n >= m->num_objects + m->num_objects_in_base)
 		return NULL;
 
+	n = midx_for_object(&m, n);
+
 	oidread(oid, m->chunk_oid_lookup + st_mult(m->hash_len, n),
 		the_repository->hash_algo);
 	return oid;
-- 
2.46.0.46.g406f326d27.dirty

