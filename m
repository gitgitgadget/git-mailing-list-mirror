Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A587935DA6D
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788713461; cv=none; b=rj3WvPipouReYXJGcQVAw4bFNz3gRGDMyLbu2Th2+EVxW6e0GADgfJQK3iJwJGJEIVo9Dn+2dBIhGmBlqxeYUwvcwGVK/EyIvtTO7Qh1SZaAfW8wDA1kVScHFTB/7rf9AOhD0W0+JyY7mDfoe8UMWI/r3uq0HPElr65oFNr+vHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788713461; c=relaxed/simple;
	bh=YVaGCL16KywWhB16+/VtncCID5vrMyL+9jC3/t4AKAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2nvB/ADEDkbN6Gfmt4CsZRdY0sayFN9vL1nm0cmB3eli3zn/VpERr7mWOkH5Z2pSUNrnw3bbCuNbS/8Tj7DddRdhXDMD59QJBoD/vncTLe3DsyCm0dClQiG7XntL3QohCIieTQ1aY6ZKepsicE7xuXYrDJ/cg2YX4AwSkOaZkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=EkUGYDHW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="EkUGYDHW"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49b965570d7so32097685e9.0
        for <git@vger.kernel.org>; Sun, 06 Sep 2026 09:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788713456; x=1789318256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YVaGCL16KywWhB16+/VtncCID5vrMyL+9jC3/t4AKAA=;
        b=EkUGYDHWdmM68b5VZ6mA5/htcVRejllbZXn/SnpB46OzYNnx9p5Z0qPxjtIRZ51IuZ
         T7iT6Fr1/nUDp/DGXo4J0wQj0LXwQxcehHJDX4B5rFAzJKFHS+bd9ltFFaSeIgyl14PK
         GSaINSNerQqCpyVemF2ZSagtnK4+2lqI7INinXrCohgM9BsvYyaNgqI/yIJBzAc66S8s
         nUdJXpDezWA2d4MT+i+D5twFoLnSbNNojqj6wfEZRh3v3K/K1x6IE+6mGQx0ODqKyAwQ
         eGi5QCDa1G7H5zq0j0Dcb4esfxwHLuNOFGxL8EULPZgj9nxneRtlQzFrxN+nboNu6PCb
         r7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788713456; x=1789318256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YVaGCL16KywWhB16+/VtncCID5vrMyL+9jC3/t4AKAA=;
        b=BIpWXpmFu86WtxuOZMP56TxXK48Km+Q/mDkP4Xezhew1aFlhcP+45sxdFwDzqR+J+5
         wMCeehFbKfXsEi8WxatuD8+mgLRRNnl+3okRtAJEwhYLdzhW2TWekEYFBL35N9AJWiGO
         qdvMQdU0yjd52w/x5uyrU1bGhl8dT3u1HvBWIgS4MctfikD1e6jblk+xooIr9zWGXXHY
         B1cqsACTj/Qpiv66P4sOvG0ZbQr9GjYyreV8pqXGyjwFnLBFtf4OzH6KAPNBSHHEfXXA
         9O5UL/o9snKM8p0hyRkoQTq0QvFH9C63eoT7SS3H4Tx+4vCmOnzPc7G9l6XpP6iSX8N7
         KaKQ==
X-Gm-Message-State: AFuF++msHbyqVkRhbDgGTWtzeZIj9CRYPsp5BbomO9oYXVtHtKaaK8Gk
	fZRK7DrH4v8Q34lFfV6Up+HDxRbGdGr3bB2u7ABEjbVShKheHAtf6mXRh73lijIMcXuwTEQOCHH
	QQ59DG2n4Wr8Q
X-Gm-Gg: AYBFou0APLwizLZ3TsEhjMZ7ovtvjRX/the0XDPhyCW36L37AOWYHIH7tL119nXP/9O
	oc+j7KS2Ks4W9srI5HjarB6tnpxSrpDINYTvCIumTHor/XvF1tvq1bAiWWc2RrtHsQK3CmHlGaD
	kM0zLioZjRLdAfuBTdoBmp1iLe4v0FLZTLBPvvPhSi9js5/qntNf4MyE8uISxMF64XhK+X3i6dE
	iYLoPgb6MFqQBXIrO20fXS+56YFX2E9DXi79pDTE7RC7Ozdi0ihAFpMUb0TZUB3w5AyJVHeA9ju
	6izZRaA28Ihqu+MQdhaAeDNqanVpJ9JQ1D/bVhgW3pKH0s52dMBmPaqxM1hhUs4ShCnr/NrNrUN
	kiUTX2YBHI/l8Xbsr6RVQghkpT4DrUxx/FWVVVxUWFF8REk0gtBfrfj7BMoN/HcSozD/raeEPmZ
	L+ETsdybjnbcVDpdZ10GZDIcJyu2NBxYlAkEpded0zPQqWaUL2cwBEkOBn+B13NA==
X-Received: by 2002:a05:600c:154f:b0:49c:fc6e:8cb5 with SMTP id 5b1f17b1804b1-49cfc6e8ee3mr174215265e9.25.1788713455366;
        Sun, 06 Sep 2026 09:50:55 -0700 (PDT)
Received: from ownbook.lan ([195.181.160.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9b49sm19151582f8f.17.2026.09.06.09.50.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Sep 2026 09:50:54 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] push: fix --force-if-includes when remote-tracking ref has no reflog
Date: Sun,  6 Sep 2026 19:50:52 +0300
Message-ID: <20260906165052.21780-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <xmqq33vn5hsq.fsf@gitster.g>
References: <20260903010547.85469-1-f@lex.la> <xmqq5x0mfgyh.fsf@gitster.g> <20260904124433.12840-1-f@lex.la> <xmqqzexx58hc.fsf@gitster.g> <xmqq33vn5hsq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:
> Which suggests to me that gc.reflogExpire or 90 days ago would be a
> lot more reasonable than year 1970 to use as a fallback cutoff date.

Entries older than 90 days do survive. The reflog expires when gc or
"git reflog expire" runs, not on its own, so I could build a branch
whose matching reflog entry is 200 days old and still sitting there.

A/B on one scenario with only the fallback differing: with now minus 90
days the push is rejected, with zero it goes through as a forced update.
The branch was created at the remote tip 200 days ago, that entry being
the matching one, rewound below the tip 150 days ago, one recent commit
on top, so the tip is not an ancestor of anything newer.

It takes two crossings of the bound to bite, which is why my first two
attempts to reproduce it failed. The match is tested before the
cut-off, so the entry sitting at the bound is still inspected, and the
merge-base fallback still covers the case where the tip is reachable
from something collected. You need a non-matching entry past the bound
and the tip unreachable from what was collected.

v3 went out a few hours before your mail; its third paragraph argues
zero over "now" or a fixed age. Your call.
