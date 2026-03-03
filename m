Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BA26BFCE
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 01:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772501710; cv=none; b=QC2qRuFobZgzFHeGUdnc+ukSzUM55RT8CVd9O1bhCnsX/h6zWszaGnGesNJ2Cz/Trm6MSr7cWQsup6A49n+4Ekk3xXAamT/knMCsgST/I13X4bW8mijW2fVYvb8e2b9YNQPmalZCOvymc/XxHnqz05XjrpiWfHS5xe3ZonStKcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772501710; c=relaxed/simple;
	bh=maZqfRNZc6XJESVTZczEEV9EeIizJONWcaj1RQn5APk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUmDctl0X1aSHXJBB9N6UWHK2kC9HYlH0zLVJ9vL2PyX6t9yvjoaByPzqS4wCZ72CzuErMSM8upojWeU6P3fFP2WWq3LoBeodP7JIRpvA0tguxEtjnKhdwlThnIZ9BM7CqOYXWvIC2h83Szq2Mh+gbOxXNmJPwbYxEW6fTiqLHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gxr8A4at; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gxr8A4at"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439aeed8a5bso2191341f8f.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 17:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772501708; x=1773106508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hiGb7z6ppacVuI7c4K9UqI9QEeRmB6oGzgbgpIBfpGU=;
        b=Gxr8A4at+q1W1lMS8FuVOSGalKzytBePWKorQuaBWWWvxagCb26cA+Am52tQ6zOC3I
         iXWOxutAAallyqfglg+tKR+0yYbYm30JfAWSyF60LB2Ra0ATLsfSbl6ZmbilRFirdaAA
         jGw2PajHv/ALi1+iS3MhiJtI2OIIzjUhntRE2c5TNAvn083NcqY0hfzEpA9smk9Uxl0t
         hhGvT67XU9/EtsaZpSNKqKOgtja/3qltiRadXx2XQUN53PuyIeQw4wb7zl61cFZ9dpeB
         7EFZ3YkotRY0odwUgvX0RAA2lQ+761lMhbxSzmYZEw6cglD0lVr0U8xAUdQ2bgNXF4fC
         8HqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772501708; x=1773106508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiGb7z6ppacVuI7c4K9UqI9QEeRmB6oGzgbgpIBfpGU=;
        b=PHIVwc5sHa9SNJXF99q9sE6QvHkXuPWLWmfO3Vfa2JyvyMlZS8Zo0aR9ulZ6WAhF0r
         cWrRoP3pQpc9WGgpUj9i3W2lAhO5EzQy6S8JDhOhBkHsE4sVCT+0S/KDgeU3FKG6BsLy
         PiGFnV9uhmSukBcX0jR6F1PNyJVPLG4YyX8FBBrHe5YE/Yw/fGdekoAf0U4fkbPDJNyW
         vxXnO+5zYFsepW8hIapen8UVUiovvqkhbjQ4JDKKmyXonnE4NUeNL2XMbWBfqp1SxJMp
         buVJ+zOvsfr6soR4Z6s0mL3gDUaKYsk7WHiI2i83UytoJzJwQWoVb0buLMCfriExDDUf
         ry+w==
X-Gm-Message-State: AOJu0YxCD/SBBOO4wq1Cu4ZUgUwKgzfPeWCw78l2qgSv0tNxybrWt/U5
	3d0cQ4EqJ3+1xgJMeMIKmHEIZpw40AxGFqw2mGpWJFH1Edy2d9pTxaP9DWR0Vw==
X-Gm-Gg: ATEYQzzGgH1D7EHznswE9oPsU0DaWkBJeLMCYlT3r2bhKSM21HWXn7/38HELiuYcsXu
	jdvOw8yDuDc/n13xzCZ+Pt5SBV7IhhN/NsFu0cT9yJbvbXgenr7RlmJrgeV5ve0LYoqzSpIdCN1
	fOv5RI4xEIdbV47/glJCxAD1TIrs5MB8EbG7JKLH5dO58EK4l4YMM7aRDa5EFcBoKNUWWV6lhIH
	btlaopPMJSaOMasKOTbFn9rR1pqq/eJ9h43V5XN+84igPWdbv7OXz6Ww/6QTc/r3WPmJi/DVaMq
	fK0bFNubdqEIKk2LuKWU/7Cb1TxhAhpQu8yelQpHM8VGxbA/7+20w9ga9D7D90EdS+jn1pHEs3a
	IzPsHLu58mLI+fol8qY+juDmcv6iDs7xuB+nxTZW8G/24Paq3dcj50Mvx+JwjUCLYZqAtoXWAxS
	1IQsBbaQK/yXTw5iOsO7cvLnmykfECK6Xu68k=
X-Received: by 2002:a05:6000:178c:b0:439:b6f9:b426 with SMTP id ffacd0b85a97d-439b6f9b8bdmr10663825f8f.26.1772501707536;
        Mon, 02 Mar 2026 17:35:07 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ad3daf89sm36356097f8f.20.2026.03.02.17.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 17:35:07 -0800 (PST)
Date: Tue, 3 Mar 2026 02:35:05 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH v2 2/3] doc: gitprotocol-pack: improve paragraphs
 structure
Message-ID: <8a6b5d4c98bd239e66faaaaf5883cbb50f1f1802.1772500189.git.lorenzo.pegorari2002@gmail.com>
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

Logically separate the introductory sentence from the first transport
description to improve readability and structural clarity.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 Documentation/gitprotocol-pack.adoc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitprotocol-pack.adoc b/Documentation/gitprotocol-pack.adoc
index 9952fac188..f4c9e024b0 100644
--- a/Documentation/gitprotocol-pack.adoc
+++ b/Documentation/gitprotocol-pack.adoc
@@ -47,7 +47,9 @@ process defined in this protocol is terminated.
 Transports
 ----------
 There are three transports over which the packfile protocol is
-initiated.  The Git transport is a simple, unauthenticated server that
+initiated.
+
+The Git transport is a simple, unauthenticated server that
 takes the command (almost always 'upload-pack', though Git
 servers can be configured to be globally writable, in which 'receive-
 pack' initiation is also allowed) with which the client wishes to
-- 
2.43.0

