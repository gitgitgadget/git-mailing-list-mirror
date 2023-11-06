Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5961CF81
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 22:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wbNdR/g8"
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26B0D6E
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 14:56:29 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7789a4c01ddso332766185a.1
        for <git@vger.kernel.org>; Mon, 06 Nov 2023 14:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699311388; x=1699916188; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HuXjv9ijgQOCue+WSPkudYo6iC8i1EQnq6tbg5ri6Ac=;
        b=wbNdR/g8Wz77BJ97dz8BErAJAqZf+CiuYSQLXu3ebIgVzK1QAS7r/2FNvxOOxb7QAM
         0wunK88Fd+mKPT2RmV+93bNQX3NIFYULpIhj2rjiyLbHZb5fqgAmZijXZYnPpQIcEAI+
         8eEcYifGJ/M7tXN9wyS1+Im+ekt+IJgDIOhOW1On3muYCxMvEY/pxU+FjQQ7BRC1PjST
         C5yi9cw59YB5hfg5486OsTDzdzGhh8Oij75nPHzkGkQ0ppNK1LkJQB6TWdOFZYVpPLOp
         GNBhyp+0WnUnq3rkWTncyG9580zkcmycIm+6urwJ0mjxa3h2VCaUHnuusKR0P98wEyyw
         F9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699311388; x=1699916188;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HuXjv9ijgQOCue+WSPkudYo6iC8i1EQnq6tbg5ri6Ac=;
        b=rZ9pFy0EYivpWH+AIStmXP0KICH63hQDKGhNn5qoEOTmdLkcI+SjEItK60klCo/9cn
         sRekkyKFB6HVKVdo5wTBIFzDS/woFgBVjkcWrSDRts7+jT9go8dQZKkpDJyU5231b2m9
         3XhIo7kq/SQIf49Ihj5CYdS3HS2PcBKYODAEreOAd1biHqh724J/CUfU3rku6I9b34QA
         5aU2VhSvwXuQ3/vnGcw+XU8OaIE1+CympopFRvVUYt4WuHhlWMlx3V+pP6qSSHAXugn3
         Dv82+cs3kuwjUnSATr3ycO6L5bKaQ48Lymsa9N8nhLXVbhVQxa98v9p3yS20jAbeSeu8
         Vmjg==
X-Gm-Message-State: AOJu0Yy2oCs7cwqYJ1AgdktY2WMjU3HD7bpKA8BFyW5OzW6RvcMd6iAy
	IJqL9iVqlCrtRP5K7FvSaqdFrJEBayQRZ5VTOMEUnA==
X-Google-Smtp-Source: AGHT+IHVwXeU+yA+baZAl6ybwt7eQzY709ROHdfMtdTXdrDl4Uxxill9RSjhhq8pkgT8OWJyaWnmRg==
X-Received: by 2002:a05:620a:4556:b0:779:cf0f:e4cf with SMTP id u22-20020a05620a455600b00779cf0fe4cfmr39399952qkp.49.1699311388680;
        Mon, 06 Nov 2023 14:56:28 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a26-20020a05620a125a00b0077892023fc5sm3695832qkl.120.2023.11.06.14.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:56:28 -0800 (PST)
Date: Mon, 6 Nov 2023 17:56:27 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] revision: exclude all packed objects with `--unpacked`
Message-ID: <cover.1699311386.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

While working on my longer series to enable verbatim pack reuse across
multiple packs[^1], I noticed a couple of oddities with the `--unpacked`
rev-walk flag.

While it does exclude packed commits, it does not exclude (all) packed
trees/blobs/annotated tags. This problem exists in the pack-bitmap
machinery, too, which will over-count queries like:

    $ git rev-list --use-bitmap-index --all --unpacked --objects

, etc.

The fix is relatively straightforward, split across two patches that
Peff and I worked on together earlier today.

This is technically a backwards-incompatible change, but the existing
behavior is broken and does not match the documented behavior, so I
think in this case we are OK to change --unpacked to faithfully
implement its documentation.

[^1]: Which, I'm very excited to say, is working :-).

Taylor Blau (2):
  list-objects: drop --unpacked non-commit objects from results
  pack-bitmap: drop --unpacked non-commit objects from results

 list-objects.c                     |  3 +++
 pack-bitmap.c                      | 27 +++++++++++++++++++++++++++
 t/t6000-rev-list-misc.sh           | 13 +++++++++++++
 t/t6113-rev-list-bitmap-filters.sh | 13 +++++++++++++
 t/t6115-rev-list-du.sh             |  7 +++++++
 5 files changed, 63 insertions(+)


base-commit: bc5204569f7db44d22477485afd52ea410d83743
-- 
2.43.0.rc0.2.gef6b2154a3
