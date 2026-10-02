Received: from mail-dy2-f34.google.com (mail-dy2-f34.google.com [74.125.229.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B01A4BA1F5
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790960059; cv=none; b=K68/rRD9Pji6clrnYuSkCnLzFLsyUrTp86XNoSCcuRnphshQJam3fkYwR6r0P09bz+WpHxfy39Lul+d8B2q1GoB8YWQue6S7dALYgr93x48+Q9/isVzgEVBFWV8h0d16ahvycc8qC56hgvbmv7X8eKBsZ2MuBYCIbXJY/Xj2Gv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790960059; c=relaxed/simple;
	bh=/13xrUxCMoYmpdN6CCFghOB0LdJ7LVe6MVD6AFozS2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UslU3phwGEGM+8i5q2oiOIFmy7bjKvsULI5Gr9wMvFeBmQE9p+k2IpqiyrSRuXydFtkJF5LWqJU4w61hi2Ep9JOXFHppYdZMlV51z0+8soAvyATg1AfPRVdseD504BBcVhQpMQcV/j8hO5iwwweYsEkIie3tzMticB1RxB22nmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhzAjvGt; arc=none smtp.client-ip=74.125.229.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhzAjvGt"
Received: by mail-dy2-f34.google.com with SMTP id 5a478bee46e88-33be7dfcfc1so10000230eec.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 09:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790960057; x=1791564857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/13xrUxCMoYmpdN6CCFghOB0LdJ7LVe6MVD6AFozS2k=;
        b=OhzAjvGtpoIRpcKdU9gxFWftRy8EkAOHTK7UzSlQvsI9IE+zY9pCpJEdW7aBxkAoxd
         otgm/ikv9r/XJyyOKquEf/JbUiFGDwQ64WpnqQRkziRMw/fNOTx7jo8NYF33FHuzjRjk
         VI4tb4C2z0OIEMxdQ0FKileO1pa2NhBBkCmimYiAxgTYVh0TQZ+0ZBrbnoQw0g0ijzBr
         0IqwOqJrb+vfCaI1c6W3gQSktIugVUUI4X3qy16Yf0K2CmTuFAaccXgkj7yGzspVokmS
         NpI3wPdgDtBqSX18df/nEbTPRxzfKqCHv/NODSOY4BiICLXEfO480s2GeF4tn9IXhI99
         cSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790960057; x=1791564857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/13xrUxCMoYmpdN6CCFghOB0LdJ7LVe6MVD6AFozS2k=;
        b=NaBm5x42sQmxYX4HPnIq/Jlf+ZF8X2F30Hol2+l4/Arc9V9u4QXv3RXg2kgAJCF8+a
         BmxS10P6qMhh6NpDf6ejw8mYDOT28lvkXEztepl/bmKUVpmI90R51pzCAwfsVLsoVoj2
         G+7px1Q/iJW5qTdY1X3ygxFcCEcx0hGZwJ5l2bwHo0yeOZWJgjec5y9bGRKpzqXlh9Dc
         2ZDV8mdYhmpDFvMwYuSORRGr96a0sDNS94lv+uj5LiaeWhWeQltp1zbrYtBsrMle6c3V
         XbSonlTOII3GR7ITS/lrG0Ej1kQfZZqKKf5a/y6ryhzu0I5Q0II/L0etEOIg92HR1kQc
         axVw==
X-Gm-Message-State: AFq9FYI9hCG5MIQf/83RWqMx7mTtugqF/9gWy7m+q0NG2iR365nQgyZG
	b+yrYQkC4/L7tYKRwTYEVkz+tvdtrXc4KgCa+utaGbXJ3v8r5Trrtq4x
X-Gm-Gg: AYBFou2eb1nY4rxHq67oJ3/i8g0NuTDSpV1mV1gbamD41mcCYjg6WPpT1KQzwg/SBgo
	U8EtddH+C8GRU5k4BXfXRc2IIOSpNNjIFZn5GGb+xLDzZttME/gBLxkWHoWWHoo5+QaiZEs/ep+
	A+G2BFD+1FxVIeN1AsBEr7EafMhCrV8A5e5iZOf8XnFH7Y+eZMOk6xO203vV0CepXFLnwKZZn7i
	anomlhPtkjYf8Ha67xRW/Ylo4S0IGOSSDFkQy6ZK1o4+cE+GNGOPyN7uPgdz6mrud3wgefXUwDX
	bJVsj+t0rtZHHbaw+X9s+e0HN/5BQVIuZbSL+oyn60l92INa4sxSiVx7kXSDbXIKiQgdOJ9B53h
	p+i0RfVPHItL/xHqz900BpE4qYwaCoyspycpu4euW/1PXDBoyMCKUJ/v6sruYt5zOg/F3HvKvzq
	1wotR2IV1XSBRFxjVGoTqSK1zHsVH2ZoSWmOYlvw/AdELp4RQTd6V71JABCB2BUyRn8HWGRgQ/3
	KpIyogKrCCvO/FPzWI2ZioUgtyEIYEmlObZFeFcTOaxOuY2TFyDxlywwW2MtHSuWVHcZuIBEGBN
	ORe4CpKo/S+ol2Q+
X-Received: by 2002:a05:693c:8854:b0:34b:c18d:c28e with SMTP id 5a478bee46e88-34f1509eaaamr3525482eec.7.1790960057415;
        Fri, 02 Oct 2026 09:54:17 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f2dfbbsm7721460eec.10.2026.10.02.09.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 09:54:17 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git
Date: Fri,  2 Oct 2026 22:24:06 +0530
Message-ID: <20261002165407.36721-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.56.0-rc2
In-Reply-To: <xmqqv77l2g2e.fsf@gitster.g>
References: <xmqqv77l2g2e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>* kj/repo-info-more-path-keys (2026-09-11) 7 commits
> - repo: add path.cdup
> - repo: add path.git-prefix
> - repo: add path.grafts with absolute and relative suffixes
> - repo: add path.index with absolute and relative suffixes
> - repo: add path.hooks with absolute and relative suffixes
> - repo: add path.superproject-root with absolute and relative suffixes
> - repo: add path.toplevel with absolute and relative suffix formatting
>
> The 'git repo info' command has been taught more keys to output
> paths of various repository components (such as the working tree
> root, superproject working tree, object database, etc.), supporting
> both absolute and relative path formats.
>
> Expecting a reroll.
> cf. <CA+rGoLcRRZPu8SD-vZw+rEjVzKO02=nMn_x+4ANJX7eh9jgBcw@mail.gmail.com>
> source: <20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>

Hey Junio, I have sent a new series at the message ID
<20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
