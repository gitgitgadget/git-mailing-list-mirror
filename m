Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A810B387372
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467833; cv=none; b=oluR3gwpW8cUwotmavO+O6eTK6n4O3CXGz8uchsxcgOGTGfXMA01SC6U3QliFSn9WMeKhe+gNxUZEfYUTfnL7JltPQ8FruOEbPjg3tTj9hJlOjYUqpWT6/XdJOnWgnTiEbDn6CcYGIWjYrht+YNYSIL+CfGr75vL6o6rtYePkok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467833; c=relaxed/simple;
	bh=maZqfRNZc6XJESVTZczEEV9EeIizJONWcaj1RQn5APk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOQv7rBUQ8xdsiZO2JBsTfjN/nukjDEno/QVHmR1cR/AQTuvjPYk1pmOrwDHPymX0lhTzrv71aE9BKvssAqpfFQwiZOEFh/5ORuOKK6NCXhk5gRYyuRM3N1jkYfcifctrCVFzSCesYF/3+FlggG8aBIk77Uz0TgKyZ6cUD5iTz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PperF82P; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PperF82P"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48371bb515eso71366295e9.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 08:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772467831; x=1773072631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hiGb7z6ppacVuI7c4K9UqI9QEeRmB6oGzgbgpIBfpGU=;
        b=PperF82P8KDHrV80Prbgv7miqo86BuKjQVJZeQSoGV2s+f9bBAe9O/AoqeCdMRvWjd
         ukaJOjgzOigzaXe+7Lf+0GNfdxAhsZG9l7POA4e6Ogvfz57I3zTMqhMeGINLY7J3Ugbn
         +Go5cBxU++MIBuABkJe4KFSYsJSmDNr4ACxE42FJkAPjqprlrM9hRkXHTTn4+jVunjz4
         Feuo3OZJ/1B7CVJI8tpMTB63BFjFy8CygcWgSNe25ne52WPzJpZnc4O53EyG/YTuhm/T
         opWMuLP6pvu89L9JwNLLXAuRsWDMgVfO1Ze7htalLjpilwh7ORx0dhAY+BwfKNRW+fK/
         jLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772467831; x=1773072631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiGb7z6ppacVuI7c4K9UqI9QEeRmB6oGzgbgpIBfpGU=;
        b=i2ssHte5qXEk3fjq9C3uvnceRgGthjaiqsHv5aV3+EkiChhBl/juu788m5aheI8put
         wwwhqkbzKRgxxPzItkyLgdu8AaQdrY2H6DJBcex38QOYqsR7YPtPD1ROF3UHFhWtfrY6
         MZy11QrWqp+RhiPdL0N17eXJ9w187j3jaY689HeE7ZYkd0uBniFZbbkEU/p3iwST6Da0
         0xo0u4B17ZMnQzWpNSZZ0R7S2SbLVi1C1nCEYa+0F6RN4fu6CBTenMWSxF9Dl82AhyKL
         3/AhUvOZdbtM+WcF/Xw5DtvIBYU2IwE190d2CGYFOPerwgwxOApg6FFhK9lcBrh7aivx
         JSXA==
X-Gm-Message-State: AOJu0Yy+eM8t4xtlxZWzBpT490aLmAydN+mmSd+ZW98nFhiNoKwv1f0j
	oxtDBlVaGUPsdEi+8WAwabhm50kk4CI5E3CB6XRbEzb01wAvJLLnmDYLQN7ETg==
X-Gm-Gg: ATEYQzx4dxL9+p8lxnRYmC7HeKcTJvuB/h4VieRbPinkjZy8UMq8G0sCP4H61HUhqam
	xWbMPlVhSAGqMOD8V7DVlkhFF/7j9TheO1DFknrbYOO2z/PzT6EK+nA9rCkEVJc/uFrYXMEK1JK
	x3bbNTm222hqFwaQbPgHPoQ7m8XTJPbUHNACDNjtXTdzF4mEFco1yZ/ev25n3re/acdxRSK/tn0
	zw9k/F4xnqQ0EQckfbgs9bKAyVDPYpvQ0BIxllSM/J+3MsKE2VJRvrjpgo1UVsGpRYnY5ONyh4S
	2beBEW62heDTYzeXrDgTD8pwGyZ9u/NOT8nmehC08UigkVrRxwkINp13y/c1v+Wzvy50TRK7ecg
	kU46oi2XPfqfijMecA2m50DbIE/Hah0odXxBgiFZP82wPkO8wFJ1BxwE/FsnrQZj8LPQNLNQJ9D
	3q6xiP8rydHm1LaM3JKdQi3lh7hw6F6YhGcRI=
X-Received: by 2002:a05:600c:1393:b0:483:498f:7963 with SMTP id 5b1f17b1804b1-483c9c1f8fcmr217778065e9.26.1772467830788;
        Mon, 02 Mar 2026 08:10:30 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd68826asm674980615e9.0.2026.03.02.08.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 08:10:30 -0800 (PST)
Date: Mon, 2 Mar 2026 17:10:28 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH 2/3] doc: gitprotocol-pack: improve paragraphs structure
Message-ID: <8a6b5d4c98bd239e66faaaaf5883cbb50f1f1802.1772467050.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1772467050.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772467050.git.lorenzo.pegorari2002@gmail.com>

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

