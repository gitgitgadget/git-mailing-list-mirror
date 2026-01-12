Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA4F2BE034
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 23:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768261503; cv=none; b=qt56FudaG9vOVeYT5OTU8wyiF3YIbAJfpTSKtEiH7Mr0334qCfUzJB+Dx1lD/6jAo0pCTrY1+S4xCs48E53jSAqABM4Egee0ZurmSHxuQALPfT+8m8ir0vhHizOEQeq7QiJv2pj014R4pyFNll2OHrVqO1l5OyPgIGt5gGfJfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768261503; c=relaxed/simple;
	bh=2wJzWEIgAVlHoRZb4eM4aJw7peqy1wvnf64GOfVYNWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NaDxWFjV7ZRzOz+f/AHjHzK7yhokXqdNWG6jeyIjyXyNBsddERxr6rvQLqy9qYlLok6wBwcZqxZ2OPdE/inKkgPPZzFtD+Fv4APwgJOEFW1LAP78CN+5wCHt7y0vMdz6g/CloRw6UY4WweYTatQHnqOtZ/20diQgwK0Pl9VBDN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=iY1PPuxP; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="iY1PPuxP"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64760131fc1so3652749d50.2
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 15:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768261501; x=1768866301; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=efw282N2NOkfC+7tCSKXHhjfVJtPZ/h5gkt/ZI1nN74=;
        b=iY1PPuxPP5UdqVQb4/+fPykg01FemsTkOkYhlKkMM7xRARlRxqieQLEDvMl9VIcSV6
         m6A65yDC2zogehBQMn+Py2dZp8UTRdDiGkRknVvQYPOmn/llJeyK81zWGMytDqNnP/WU
         lgkOpNwduiDQKVN8rL0BcJR6SmA8Tph1Kq/ebYBCpnBl4QNgWmj6Zx1tEORBjV/5UFHz
         HRGVCwO8dxXKIvgm5nRvV8KA69tVqEJpUHypP+E1wTopVVgH3TbLpFhVCaBzF83UkfDF
         pc0YN5Vrix2oD6HnSYVVarJfhx+Y2G+SGag/GRatiDPe4p0tLgHfz948baFssQQp/5Ka
         of+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768261501; x=1768866301;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efw282N2NOkfC+7tCSKXHhjfVJtPZ/h5gkt/ZI1nN74=;
        b=NwdVEPLqt5yrLJ4JkaP9SWWzCOfUS6sTs7MNovnS7vWMMKqKD1FzMJnRehQO/RY2ge
         jxWBBH5vpcqo48rXeSYY0c52KC17JTbXGsOIS+QHRJzAJzJFTYkgYLoa5GMfUntwND0i
         S8edFE0rwEi33sN2Hh6x97PS6nF8xbWOa0TqjN2CjbcowAYsHlXOe6exFJriQRihKVog
         O5EMZWwxbWy2OIVXW7BCgOOhPmXYJnh677KO9dJzTG35ZTbR1u5fBxRMRxPR+qxhmqiR
         lg3QM7pWa4DbblpK7AUjn82OiRspG8ROcxXlwRhseR4QzFYRi6zzu7sEd2++8hUl/ixn
         7Alg==
X-Gm-Message-State: AOJu0Yz5cIomD1EBApsxR70OWm0r2QoItpaM6u4GzU3guwUj/wu+ZcVG
	l+IsQ9/6FsNiLgzc6bhA1YuFxxDEGL04D2lExBhBWXsPWiai9jOgqiQxkPlfxYJh9R5MLiz+z6U
	Bwy505NH0RQ==
X-Gm-Gg: AY/fxX6iuGVDeZOYvX1YxPZ2ejFRti8XgMnkAXvu2tsXqwTX4mMXkXoylH3WVAdNXng
	Fjirj8Y7oGHx1QXg8Zozee6YWfjCs+MqT2JF6+Ci+Iva/TGO2TDmFDsVdi/mo8N3oo7hA5RDr+J
	ZAixNuT+MzYPQjfE6NFdlJ6pK3fYY4FI56zkYq+AWEZzVRGhdTZjD+5MzBIpghmdXsyqTydGO9/
	2AhXTBxEexRG4QhavwioS1Dli2Nr67X4sN/yiE41VnRdSQ0/y/3Eis6TLk0xpH+bLdv+fqqgf0Y
	uW8hnwPORYVAzjnhbgi9/y4ZbnMmcFCY0m0dF5ZrLDngBF3anLqIRfYrIcT82uXly+06KIl0yZQ
	0LTB42jjAyN2KeAGiNNPlMOh7CUXeoItV/LXJarf4EOam737guuAsYGCss6f0qFFmL9W3C1kmfd
	Z/VPvokoG/ebNkGTPescH5isnjPhOVNZ68NpzqlZbhwmZVgP+AuvwX7trpT3PBXwU29jYvOc9g1
	OpqpxVDPRLLZLo0Pw==
X-Google-Smtp-Source: AGHT+IExz6JyS1i2Dvh6ncTkt+1rHv+2tRqYpttuQuTApZKnSkTKFv7XOuV7pB+q24+HCUhuPxrp5A==
X-Received: by 2002:a05:690c:7449:b0:786:a774:e415 with SMTP id 00721157ae682-790b5833132mr366813767b3.56.1768261500843;
        Mon, 12 Jan 2026 15:45:00 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa670b16sm74388427b3.35.2026.01.12.15.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:45:00 -0800 (PST)
Date: Mon, 12 Jan 2026 18:44:53 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] midx-write.c: do not optimize out writes with corrupt
 MIDXs
Message-ID: <cover.1768261435.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

These two patches came from my work on implementing incremental MIDX
layer compaction.

When rebasing on top of current 'master' (at the
time of writing, 8745eae506f (The 17th batch, 2026-01-11)), I noticed
an early 'test_done' in t5319 added by 6ce9d558ced (midx-write: skip
rewriting MIDX with `--stdin-packs` unless needed, 2025-12-10). The
series is structured as follows:

 - The first patch removes the extraneous 'test_done', which exposes a
   failing test which is marked as such.

 - The second patch explains and fixes the bug, un-marking the test
   as test_expect_failure.

I was originally planning on adding these onto my series under
tb/incremental-midx-part-3.2. But I opted to split these patches out
into their own topic to ensure they are picked up before v2.53.0 is
tagged, should the larger series not be ready by then.

Thanks in advance for your review!

Taylor Blau (2):
  t/t5319-multi-pack-index.sh: drop early 'test_done'
  midx-write.c: assume checksum-invalid MIDXs require an update

 midx-write.c                | 14 ++++++++++++++
 t/t5319-multi-pack-index.sh |  2 --
 2 files changed, 14 insertions(+), 2 deletions(-)


base-commit: 8745eae506f700657882b9e32b2aa00f234a6fb6
-- 
2.52.0.437.gcc6f76a88cd
