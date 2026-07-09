Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24B91B4224
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 02:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783563986; cv=none; b=lJP1rWfRRqN0EVCSXWZ45l1Uneh3YXYOJ5XkvgGnOC17ZYOHEqyaihQOF536H6qyTpy1hLoAcU33JseHtVaMBksfjB1ewovhTn0v2dwnd6CU5LCb9t92IiR81DuAt4W42iB/LVK/SIzpRTwWlOdS02E2U6nO6GdnJqHCpUxIjwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783563986; c=relaxed/simple;
	bh=EhWuX+tjz4EIP2NE06lOSV7gaAxrzU/qSNSSr4cEhjo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lOxwRVVJ3Hd0n58nlWrTqK1/e/mUTt6VtTdxRYBxBfusAllhs0oFHloULF92h0zuRJ3gDIQjbh8AzfXaHF2jsHSkiyFPgcxObEhjBODsJWRQVqPgKZ219HZz+DR6nQhNAC//aXP1Qw8iG7Oxr2PMmOz0LxMkJm63r0Bk0XOEIQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=gzHiIXhw; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="gzHiIXhw"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ff88549786so5069326d6.3
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 19:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783563983; x=1784168783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R4I0cVm73LX2ee0jtDYkDmsCtrtkVJpK47oN5nOJ1ks=;
        b=gzHiIXhwQps59MzOTRPRMN4HWQG53JvRS8jk53R0COTyLhsURw9vD6F0RlCr/gfiGQ
         ql6Wjcie/G4Sdkc16HmXZtV8c09xqotf6qxHSof7lf9fdb4iOFL1c4z/zJBE9TYFtbOX
         AmXybhHLBWogFILcN5pMxFmd8wuKFRa8zu7/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783563983; x=1784168783;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R4I0cVm73LX2ee0jtDYkDmsCtrtkVJpK47oN5nOJ1ks=;
        b=pCEJyI/E2WMggNi8d+Nwf/rUfygMJd+fzmVoP0DrqKvXhvoVLf4WfzS/xUxG8VMOih
         k8cerJyTj7RNsxdS11tC1j5DO3bbwj1lSksEi2uSR9IvMdl56DnXEV12cAChGkpUvaWA
         Wttep9nGpfin/Odfw369R7xVMr3Xed0VPFjQIQildsaIuL29IT6pCr11WvMbPJN4TEza
         IXYWfDebBDnVrmXMZREUzDT3czrZRoGsKtBdtgQ7lJj3j+DzkCI9Su8tzn8+kB1Wu3Qz
         FAmGxSkCPfRypQou2EUf1zs+29qvkrUHHQPQut4NiU8N8zuYsDA25gsK0DksnugKv5Dh
         6PYA==
X-Gm-Message-State: AOJu0Yy7ZirTKSLGRFKRvbOfjTdPWKBk69gwH7NpRtBfs4y+AMi59/2p
	BJGCNqvEO4mDNy4QrW0G7vNihfsE2VE1AeR/IpvkgZELgqHqOqjHfeQo36cHkSBAKhuVrFItCq9
	zqrTCRhcpjg==
X-Gm-Gg: AfdE7cmz1PRt1fPmv+z6TaGuzeKGvGcq10J5Q4/SBIeFIQj36u65CHOChZqOqnsIYP+
	svCOv2pt6C1tLok5hgReHHBpdlg4Ij+LCpjftD/J5VhtJo+UYQhd7dx2TrPJXo9YhcZ9PjEJDd6
	JbZTwHvYyeIxTrGz0M8JYsKbNLngz9tUQE3n70EIq2jgLPI1JIh5zAnJOL91DkRyHGHjwoqeVj3
	La6lYWmFRR0NpMgNGQBzuR1lW6LFdPpn+kOFbB9BH/RGoFb45EDSfrRWczTvZKBDMPi6NOtrerS
	kDPXtRH4SneShYT6UQU3Ahhoc4izbWg/8Q7ga5XYwEqA5znZHFHzFvgxj6RSwYLeQStwCymIf8V
	6BGlDwGaKpmCCsCzYbghItLC9GeHbwIRKHVdORmWJuBZks/4bU/hMvX+RIG6WH2sQVjO9wcgTii
	bw6AhymKOsS3HnBWFIQ51bet9E
X-Received: by 2002:a05:6214:5504:b0:8ef:295c:3acc with SMTP id 6a1803df08f44-8fec361e880mr53175876d6.56.1783563983530;
        Wed, 08 Jul 2026 19:26:23 -0700 (PDT)
Received: from com-79390 ([209.249.37.133])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1d3acsm6509816d6.24.2026.07.08.19.26.22
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 19:26:23 -0700 (PDT)
Date: Wed, 8 Jul 2026 19:26:20 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Subject: [PATCH] mailmap: map Taylor Blau's work address
Message-ID: <ak8GzO_ZBzg6hOV1@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index c2e3939beb..f8ede075ea 100644
--- a/.mailmap
+++ b/.mailmap
@@ -277,6 +277,7 @@ Sven Verdoolaege <skimo@kotnet.org> <skimo@liacs.nl>
 SZEDER Gábor <szeder.dev@gmail.com> <szeder@ira.uka.de>
 Tao Qingyun <taoqy@ls-a.me> <845767657@qq.com>
 Tay Ray Chuan <rctay89@gmail.com>
+Taylor Blau <me@ttaylorr.com> <ttaylorr@openai.com>
 Ted Percival <ted@midg3t.net> <ted.percival@quest.com>
 Theodore Ts'o <tytso@mit.edu>
 Thomas Ackermann <th.acker@arcor.de> <th.acker66@arcor.de>
-- 
2.55.0
