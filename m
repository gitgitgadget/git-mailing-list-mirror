Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B5F2638BC
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 01:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772501681; cv=none; b=ttvbya813nqSMA4Md7N4kIjOg0tg/GiGSSC4Amsz5XFdY/eY3hxrpp9vym3bTMP1AICJ63IUnabmdZFrDb5XwbWEKNlj4ZFjlkcGf9YeoJWZJknuSaKFvEIPV+wehFuYh9MJUrT+6LtoHSdghhbP9gvTHHIbDZ1BADbD7ArrmqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772501681; c=relaxed/simple;
	bh=jKMCcbPf+ZnYcPAUvGVCiegb2J1txfwMBfGGSYfT+14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teQT8x4EGtuaxdXWZAFFdj81c3bPxwpjEjtOK6hSDjp6WYYzKBIojXaxyk5r2aYxWiSL6Mei7G4wlzm+V+r8nkKvj8sDXTSE+oFM2922R6FG2mTyhhqUsVXsVGCT4pq+OFBoV+7so700Pj9I4RxXK2klCuQUNrhZoOYHLy2SeUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koo8zFuP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koo8zFuP"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483a233819aso49093425e9.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 17:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772501679; x=1773106479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L45csCIdgk+pONsGWqywJCvf1w9HGgY8wwhSLSgRFv8=;
        b=koo8zFuPNkSIVF1AkhzZxWCs58wuQZwSvQqvuTB2Nmuv6TpSCVJZjua2Hp6tSqT+BJ
         GDbwe5POuOxjemHYI1NxRO5+WvS3iqpS650Aiv0VvX3q/vRrtSQvGCBG+ArTLDDmmsy9
         gH5FCNdg3t/TabVhtWJMs9mueOd5/edBj8ZebxBeNgKMCSxH+c/XUmo+CMcFvsQbJAYH
         k/YyDFxO0R7MXl2ScsUV1ctgqADA+5txghngyOgV/GXtzZH1BR9kjEy3bka/Sm28QwTm
         Up1Xp1+A/FEhlcBU2OX/TNiN6duEaEcpY7VIdNk3IA52cJv9fQ/z3xauz3AMThkP5uv0
         qA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772501679; x=1773106479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L45csCIdgk+pONsGWqywJCvf1w9HGgY8wwhSLSgRFv8=;
        b=a5mTOb9h1N2ax+khWFb3VsbCUI35Hhj0hPb8tmK/IQT/DdbllqvUOEjvTvHOW2hkDP
         qV/qHuNhAu/iQjIx4oTOWdnk4gG+Zu14vSHkKRtL27ww+c43EFLxdIB5dxDhjKnhzvmB
         j9LyBifTjuRQokx0FgxwJvmslT5850bLZY6BdJ/peQ03pMjE5qjtyTznl3pb5skSmpsA
         HWnTIOQwGUkdNxg8a53n9fk1v83DRXg0Zrw95JRqaYBG96W33NtYCoMve1puOF3pwG3O
         mvWn0ppqxMw2pr95Nw3gEwFso1TBiGvt0TMlhnuYbbHFSmj8+LBy0e5u89yTbpY3bKWO
         2egA==
X-Gm-Message-State: AOJu0YzwbBNb0JMzoM17x7UrGfvU2gKmkD9be/Hp4l4ct3GHWfGBRcqt
	C8IzFGTtbdzawrZDuEsJ8RZWohdUhBhRYpxEkfoA4j9lrRsyOyiNEMyHu9z5Fw==
X-Gm-Gg: ATEYQzyfuFRDl0r4npNsHtIi0I20fka7s011ddzDdHH34jZxYfP1yhfAISlZodu6S2l
	Jk6OZLq3wCRmFTsoJxuvz/7XCsOlcRBK7hmoNPsJ0H9wqD6V9q82qz5A5+l1AXEqjioDe5U2XQS
	EIdzWDYxG2e7KYPrmLeGasZOgNmPyhoy0CFJCnz+YlF9e6WqwmdGuhOVM+iD87Czj+1Q+iyFXQq
	LquNh5CZ16pU+IuEi3ykazlchq08wXD5wTATeJqRPhguuGtE3898zkKGZbpsT+nAoFM+ESrAY6B
	2KkRiTnIA4jAx/QBQhGRpWFuhKTrIkGxRy8vi9jKGFbMXHz+S32piNr/Eyid9Tbv+CUdT6s09sl
	7/ZJnpS1QOR5CCtauwtEcSe9/hkLxa5OlXnPFrSM3A9cvXTa82QklGHWwX5+B7jEYyVJWvX5x2Q
	mR4mgijzxJ8vD3sqZWuCWrZU1u7Z+f/oMVPcU=
X-Received: by 2002:a05:600c:4f50:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-483c9bb8ef7mr264098895e9.7.1772501678605;
        Mon, 02 Mar 2026 17:34:38 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485135d0676sm3768475e9.29.2026.03.02.17.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 17:34:37 -0800 (PST)
Date: Tue, 3 Mar 2026 02:34:35 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH v2 1/3] doc: gitprotocol-pack: fix pronoun-antecedent
 agreement
Message-ID: <0d679e5eb514f33aed92f7fba4843efc53e6c461.1772500189.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1772467050.git.lorenzo.pegorari2002@gmail.com>
 <cover.1772500189.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772500189.git.lorenzo.pegorari2002@gmail.com>

Fix "pronoun-antecedent agreement" errors.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 Documentation/gitprotocol-pack.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitprotocol-pack.adoc b/Documentation/gitprotocol-pack.adoc
index 837b691c89..9952fac188 100644
--- a/Documentation/gitprotocol-pack.adoc
+++ b/Documentation/gitprotocol-pack.adoc
@@ -65,7 +65,7 @@ Extra Parameters
 ----------------
 
 The protocol provides a mechanism in which clients can send additional
-information in its first message to the server. These are called "Extra
+information in their first message to the server. These are called "Extra
 Parameters", and are supported by the Git, SSH, and HTTP protocols.
 
 Each Extra Parameter takes the form of `<key>=<value>` or `<key>`.
@@ -277,7 +277,7 @@ out of what the server said it could do with the first 'want' line.
   filter-request    =  PKT-LINE("filter" SP filter-spec)
 ----
 
-Clients MUST send all the obj-ids it wants from the reference
+Clients MUST send all the obj-ids they want from the reference
 discovery phase as 'want' lines. Clients MUST send at least one
 'want' command in the request body. Clients MUST NOT mention an
 obj-id in a 'want' command which did not appear in the response
-- 
2.43.0

