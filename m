Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFE22798E5
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173895; cv=none; b=skrhfaL7DwhUa7XQXSDA+pUt7KFnCzIYJ8amAcxMH27xYwM8xt9a4CmsbbOfyXtIOZyrKhKAKzFapSrvsVaiDKzjHpckWZXxIB041LudCzFb0vICtuSSx650CZiV2KOWw5LkQwrrTehMWwUnFr/RT3pnY3jx3yC8bak5BR3t5G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173895; c=relaxed/simple;
	bh=sQExFeXsU1eF3i8coD7fUKKSPspdLwY9GwJ69YormhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uykP0+pcjgBgsYrTa/vQADIzjndEe86tpO/N5AzJ0Cx2ipfO6ZGCiKd+WOcLWrP7tS/2UBZAWQJQRgA28ZT1dn0q+T12f/knfAwI40kTLVEfbmAF1tSVSoUw8dVVSxBdOYBQRcDGZoADEY/ZEGpWWl+WaVtq37nuhW5rHikzCg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6JM0aYG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6JM0aYG"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2adff872068so7968195ad.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 22:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772173892; x=1772778692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQExFeXsU1eF3i8coD7fUKKSPspdLwY9GwJ69YormhM=;
        b=P6JM0aYGCVQ4inadqXw0ZUupfNgj7pHvR0Y3jrGqR6ElOHXacopYGw+xT8pbOFJeu+
         Xw22gPJrSA4wAisvs7yuO+A/WmqEO2odhfhpuY/iSg9hhb/TkfW00DiDgvdcVoWuuwmK
         BNficYxJ1TbScpDeo1vxJOAyMxZLRwXF15ctf9DgToU1jJjTtvAwVDM9M1xuunU9468j
         6giW5RCHXJdWlKgSI25xZAH0Nsw5tkGEqBfSAoLztEFVDKLt9bWNnsEBTz1LqC8yBIqB
         qYiF4Z8dEmQcNL883GOfOnRZEinop7dRvUW4DOa2Zj/4YLNziVJUcPeIbvun/X4egc0H
         Giqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772173892; x=1772778692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sQExFeXsU1eF3i8coD7fUKKSPspdLwY9GwJ69YormhM=;
        b=wpSVCoeBWG/ln52RYIpGagh3GBrOiULNBMp9jlH/HRuBR9XU7rvv2VKjj8H8qb1EM1
         en4eBzqy4xiz9JhJpNQsssOjQ4CkOZ1ytCSmHwkhaIKcyiUzlgjDkWhnPXj8QluITkdT
         7DIR09P4zwBSGcAYyyaMBr2+73UD3msa9bVBbTKUjwTzMHBucfSegHWsO/udPdBP7ZOT
         DRzllH2m6hP7atlfGZXlZghp3mCTL3oAln3VMd2FsX9AnV7jkuW4AbfbOYVVkOcl/5Gd
         kbc4uuoemgLBDAAhGDRpczG1W5G0YyRmSUcxSE3PExs2BEQ9JlH++0ClKOrUtZle0v2l
         uIjg==
X-Gm-Message-State: AOJu0YyAHcldH55aILf5oqniYvEc8Kho87U8m2a0r+N1W52G4upQgefO
	/y+AGAme7kVZwWRn/Mm/XfBwFEXgzjmcUACG9smL3JvgnXBvRqEmNCsXm81H7w==
X-Gm-Gg: ATEYQzzqZD8i43zWl6bVt4sNklUaW+WRHYi/AqYjOjem6fBkSOJY3VwwTWlD2hfGTDP
	BvyVSh+LCL57xZ+jNYptyLewt1bQ2xTZmc1p+NgayviAhw4wiJzVb0zN8xxXxFC9V4j/2f3fiMB
	1yIGKxq2w2wmbHpHvaFl/xrTbYXDU1ki8jU68AXvY9XsN5jiNR1GJ+oXXIbrTsNHv8sJZwKGf3M
	s9Bdx8C/X5dtKfRrAajacQCsOvzb0tZm9xjbyg0frlBYh3ZP5bgaHGUlGJ+Nq8ZjjVy6op85NYg
	t5EekiX8W8jBQtf2buTw8ME+1w+CWaeFxoXAetg7GU3Q/mAJkvpooT4FdFH8WNeJsPhfU3qHtRl
	j3QpNGDrx43QT6EpVpAoTeXx7P2QQrEhg9zllwzW87DOWSKl8JICP/IymQxTCrYvFe1VSPgLXgg
	0ur/dwbJj/6Su6iZ1z/rVTo5wxyIC2GFHkcVCRf1scCPePpllaPl3DGB7h7Oi/0pmSanvd5GZ7c
	lEL/IpX1g==
X-Received: by 2002:a17:903:22c2:b0:2a9:5c0b:e5d3 with SMTP id d9443c01a7336-2ae2e40a0d8mr16387305ad.20.1772173891666;
        Thu, 26 Feb 2026 22:31:31 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dde70sm44443785ad.38.2026.02.26.22.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:31:31 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v6 06/10] fsmonitor: deduplicate settings logic for Unix platforms
Date: Thu, 26 Feb 2026 23:31:30 -0700
Message-ID: <20260227063130.9156-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqms0w8q8p.fsf@gitster.g>
References: <xmqqms0w8q8p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> I guess exactly the same comment as the one for 05/10 applies here
> as well?

Yep, same fix applied here. Also rewrote both commit messages to
describe what's actually happening (renaming darwin to unix) rather
than "merging two implementations".

Thanks,
Paul
