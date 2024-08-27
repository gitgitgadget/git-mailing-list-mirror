Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808161D416E
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793223; cv=none; b=JCYcJntU1CNU8yNe0eEW7i1E2rakGqKZ3wHmy/MaCA9xpER2UD2sP84LZa9OqzTn9jtkGCLXCOqavlxcAazjMGdvBJjURS7erc9TwQTvMrROkt+pbz7t90x++7VIFVJTfaQtOH3a2yo6aCx1X33Xg52ojaNkMA08HFAFB1vohdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793223; c=relaxed/simple;
	bh=sRCenHX+uGn6RzKr6OENVaPcgml6ER3kG8hSFmLUk+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGEQzSaYNKhqgOmU1HOgjhdhDacOnJdYKYoL+1K8Hn4qwvzxOsmf4YaZHq+KwbnmFEXkFNm53Dq5X/bn/Q/0H2L3UyeIe5w3Jc7tksKGG7i0xaSxurjHllayGkOn0LkR5CLZHR4EvkXbuDyrwgbDSLJJQe4LkrMCr2087sOXyZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=1B6d4v9J; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1B6d4v9J"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e11693fbebaso6310103276.3
        for <git@vger.kernel.org>; Tue, 27 Aug 2024 14:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1724793221; x=1725398021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rWPLWUVIQMhKDaXo0VADEbWKFDERNdh3GSoAUeWfHqI=;
        b=1B6d4v9JUkjR+riwk54iEhd3zDWHfRVTZ2IG6FSZ132XgUnowYge0/rCRlr2MuOVuq
         8ltBARbhpjE0BZjrSOfSBwD7x9IiFzXPBLG/P7NNjnRYTp69WL50FyojwhANOtZbqdi8
         ChCodJn56VkK6m46sNbfZS6OVX5MgbY0/zdtdMnNBBmyVKbSckLBNpvjvd+afIBwwju+
         Ges6Iq10Nwt6hbMMipOW1B+W/3dmoLt7oNa/yi7kcHtKd5iJ00qRztPOhxu9z7z65mC6
         izGEmtO02JR82tfaPqgP/2CK5N1QwBA83xtMWTBCQz3jpbLEcX/Bh8XxeIN7W/xyj3Rn
         jHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724793221; x=1725398021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWPLWUVIQMhKDaXo0VADEbWKFDERNdh3GSoAUeWfHqI=;
        b=nb18g5mNbVrODHNdUu54IUCrovUhuOgEPhOygWaDUXZg5YEvPAz8/Sdi9t55Mo0X8d
         CCI/XaeDWTpxeyDu6gj3nU97asrynjLTEYBUWIp/5O0v/k09iBiPHnxmqKvV33wQOzTa
         DxbqFOwSSSb91sDWCB11QJHWVzgQjtWLeLlwHG7D1xDHKqNmLYhwTwUALfq2tM2XjRLB
         C6i1DczMwoq6sevUTL43sRJH/Y0WGg68U8Ov9SxWbgLNFbq3CgdTEgCXETbG5C5yvipN
         o0zhOdPuU8oZhckST8DLvu1/K1oOYrdU0smnFNl2mpaOxHI/ZPXe2NFxgc25LGH3QV6d
         SmaA==
X-Gm-Message-State: AOJu0YzM0XL9AgmVyd0Uz95LpXS+bO+VheBV99MqsUvxNIhRALykA/dQ
	fyiVH3sq7Jpog0UWpeTmYCZpbU5n/qgoFF7Yk2eEOilv2D5+M4BnkfndCiZggRQGl12IwPIQ9Ka
	o
X-Google-Smtp-Source: AGHT+IH/sHXVTqzUmnVN8zA4ZSHvjcQmNqLJVB1ejKz5eK8/xr6/K7kOugcxp0Gfq97OBr6SioW2Aw==
X-Received: by 2002:a05:690c:4d49:b0:66a:d93b:3047 with SMTP id 00721157ae682-6cfba48827cmr45703017b3.25.1724793221198;
        Tue, 27 Aug 2024 14:13:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39e50178fsm20507927b3.141.2024.08.27.14.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 14:13:40 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:13:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] builtin/pack-objects.c: do not open-code
 `MAX_PACK_OBJECT_HEADER`
Message-ID: <82754d92509e364e96fe35ca20eb709eb6f38641.1724793201.git.me@ttaylorr.com>
References: <cover.1724793201.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1724793201.git.me@ttaylorr.com>

The function `write_reused_pack_one()` defines an header to store the
OFS_DELTA header, but uses the constant "10" instead of
"MAX_PACK_OBJECT_HEADER" (as is done elsewhere in the same patch, circa
bb514de356c (pack-objects: improve partial packfile reuse, 2019-12-18)).

Declare the `ofs_header` field to be sized according to
`MAX_PACK_OBJECT_HEADER` (which is 10, as defined in "pack.h") instead
of the constant 10.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 700adfb5a8..c6e2852d3c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1072,7 +1072,7 @@ static void write_reused_pack_one(struct packed_git *reuse_packfile,
 		fixup = find_reused_offset(offset) -
 			find_reused_offset(base_offset);
 		if (fixup) {
-			unsigned char ofs_header[10];
+			unsigned char ofs_header[MAX_PACK_OBJECT_HEADER];
 			unsigned i, ofs_len;
 			off_t ofs = offset - base_offset - fixup;
 
-- 
2.46.0.426.g82754d92509
