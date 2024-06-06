Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47B71419BA
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715092; cv=none; b=E9Kw8qgFJvgll8YSEBBjNWJ+GTFHBcPqhn5wJIM8ZgtxATXjSwsuITqEcg3312qjry1JLdxMGdE+AT/RywRnBV8pMxlqtOynqwd8pk9BUPrHmviD3cOZGM8qyLLTI7G/uZw2Pg7heWRhMI3F8g6+eibAbZ/+hVpg4lEeAFQiHt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715092; c=relaxed/simple;
	bh=7WMj4MRg9OvM3QTcBDWlSSZwm774Snua9Wn22SkRkEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qzq1uu075oK34G4X1igm0GgVNHmli9DUqaw1BUA/N+c09ZCUfm2CXK59aZ9+95ovuwirTKyqY08fQ5Gut/I3RsfTObYcI4uySDQ9jVX5cSeqbOFpkWPhDPIVACExReOuDoKheHAvbh6cLDQLaElrTZOMRClGepjzvDIUD1QOofE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=FduXq6AB; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="FduXq6AB"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6ae093e8007so3716116d6.3
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717715089; x=1718319889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xSqSR6/DZLooFDhAZ7Eo1qreExrut3EIGAUfb+Nrtvo=;
        b=FduXq6AB/K3JIllj4tokvJzszR99YAxxknPjXGG7c78sJ4UA0iAWeLX60mvVw7tVGT
         kEI45+8MHMZRoTWIoXBWsQsrmYvncPt/xzweA5nmi22JaUeM7dPXw+1dnICiczgnXnFR
         StGLuCIQfsr8bwLbrGc8lI/lCTb+gCZPKUEd/R1TDFQ0nzduRkSptu0CjtUdQ+zsKSTG
         HbqyQsa8An11sC61XdIKq+9IWu/LvJYlnKi8L7aAx0Up+waDYSkJm63FMOf7wB+9ticR
         mIH//cfADkyYkbCgV17jVl+wWcBVPeI31MaFcu5a0devXZiiqDji0P+gTCuUpBMhd0Uu
         8+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715089; x=1718319889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSqSR6/DZLooFDhAZ7Eo1qreExrut3EIGAUfb+Nrtvo=;
        b=rdaOrUEbgKeL8jX+YpiJBQLmtQcYpnlUv7i8srXSvsXANvpgZj76v2Bug1og08lTMG
         vf46z/R5ej0ulO5tSnRH9Pn1I4P/9G9+Spefm4J/FdfdEUP2zPIhHS/XweRKPD7MOqRb
         V7B/1KwDEsXAHycpAk4+HWHsIklrnK318rtF8eacaCWacllnv6hzgUwgPumMpH3e75b7
         kCwgtHl3TsTwccuKCPEiKVaOsmENuHAB63NUEw4gUFid46cV9T5km9EXoYhMYuvT2vvI
         yUGMCZ+Cd8/wvvj6AMYGyJhqNSL3vdaviV6/XrCNN2uEapJq9LypeKe6Y+0vamtHcfK2
         kLkA==
X-Gm-Message-State: AOJu0YzwKR0KHV9+5BW/QdquE91dwYzQKHs8S9EXH28wRIQtqhaLsJRx
	v0C40N6sSxDhj3a5YasXuCr02K3A+jmnTzZG2RORUh+HulpNGYKmGV5r5qeDbSeJv+1yS5ZbJw/
	DN9Y=
X-Google-Smtp-Source: AGHT+IGb1SAD6CMhHO8zIIbQh3TlRNEpFFJmjXjW3hOAATIhBruU/dUk1ke3v5Yjn0UvkqkPuBqnpw==
X-Received: by 2002:a05:6214:5d89:b0:6ae:cfb:480e with SMTP id 6a1803df08f44-6b059f654dcmr8957076d6.45.1717715089587;
        Thu, 06 Jun 2024 16:04:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f66734asm10539966d6.35.2024.06.06.16.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:04:49 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:04:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/19] midx: teach `bsearch_midx()` about incremental MIDXs
Message-ID: <f3c37c83696deb03ad06c59df393e9b66a72ddab.1717715060.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717715060.git.me@ttaylorr.com>

Now that the special cases callers of `bsearch_midx()` have been dealt
with, teach `bsearch_midx()` to handle incremental MIDX chains.

The incremental MIDX-aware version of `bsearch_midx()` works by
repeatedly searching for a given OID in each layer along the
`->base_midx` pointer, stopping either when an exact match is found, or
the end of the chain is reached.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 1b4a9d5d00..7c4f58f7f1 100644
--- a/midx.c
+++ b/midx.c
@@ -341,7 +341,10 @@ int bsearch_one_midx(const struct object_id *oid, struct multi_pack_index *m,
 int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m,
 		 uint32_t *result)
 {
-		return bsearch_one_midx(oid, m, result);
+	for (; m; m = m->base_midx)
+		if (bsearch_one_midx(oid, m, result))
+			return 1;
+	return 0;
 }
 
 struct object_id *nth_midxed_object_oid(struct object_id *oid,
-- 
2.45.2.437.gecb9450a0e

