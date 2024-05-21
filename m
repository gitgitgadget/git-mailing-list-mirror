Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20800147C9F
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318112; cv=none; b=CC9dDTGylo0ymVKfxorX85+Uut5zV/vukhpvLe29AvOp/gK5xlD9lO9WaCjXAw8SIw3dIK0wgWiDYHHJrzjd+JKW3MthxyqbHExJKFzEMds0dbucwBvwDQMnhgGWH0T8eDs39Z0wCmu4Ss69UPGUnGUtVhjx+QNNQ/N70bwwegM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318112; c=relaxed/simple;
	bh=2oerGoMXWmoobyoUwz4ZjGS6g5RpBPMLp3F7s4a0uR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm7XA7YqsixSphfqGNNMLkBlA0qnjzJBrZHxzbgeZMLwjJkfbrLXtxhFnAKgLDfejVggE+E6y+EuexjjRBU0YiFIyBmRPlyyMoNSK5AIe97EbOclZKU3ssvudeYfiiuCXp6glPTuLsqZ0YiXMhVbBeIPbJ0N5+e0QoJealjMlHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=P2appik7; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="P2appik7"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7948b768497so27017485a.3
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318110; x=1716922910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jTxZe62Q6V3kBii8AUf3/8CgYS7X/VqIbDLCVFTJTT4=;
        b=P2appik7V6xa+DNYH2GzRaGm520r1P9HXiw7/6cNEvhqkpPYgvate7DC3RUtW15gzV
         20CKtCFSv+zYTW/VCgQT+lQvAM5o4eA0wiTfxpqldUSVv3aSBSPhMhr4HwZZa5ucjkRM
         knTc1f5fpy5lN2uugfcadM5zBtjty2t3fKni/xDQNvTWh112azC4RDkX9lvAwFkeNvdc
         H/QkirFU/cEfoiV+COrT+25dKiMpf0IkxsWnboOnabUWpNkafAN4DVTFhKaAB3veBMmO
         iSYurRqyl8wrorZpjNnCX7CNpdMYFThbL0RLx89ALsBzuUOf7OO4GlGNVK5HKFvvnQfW
         8XHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318110; x=1716922910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTxZe62Q6V3kBii8AUf3/8CgYS7X/VqIbDLCVFTJTT4=;
        b=oM8QzScdZIQMZOGk9nHgDRzTOqkkroDcJxlCl+G9NXT9wh2RdwKKFKjNJ4riTJHRaH
         sa7uTfQGb7/27KAIXhGi/NUX0uDWT5iXHUQ4F96kC0AIOn99yRFa7+LRtEkGnINJRjL1
         XSOT5twxg9O2ukt1fAaEHyzZwY8HDv34MN0+m6slX72xH3D1tRtHL0t0LstpkPzIsVWQ
         8pV+T63AQNWQTRSk2l7o0kvqP9FmwURRBaZyqX85G71Uv/GtIIQS08Al/Y/kXwIpBM11
         ApDxNDWvE/L8y0A++6VWsT1n1wLG8GNmk0BFjiKBzJ7nPWV9f2fSUvc5vNLGznvjxfW9
         pbEA==
X-Gm-Message-State: AOJu0YyZO3xj8498yiRJdDS0yCBO5FDjMgBZHgr/NDSoqhkFE1/ljMkN
	in+JV6aPgDXAfJaffHvdvH52x7WzJ1iSzj7mdMCSDSVWjaW+7WlEiyzteGihaUZAwZjTVaT+gNF
	+
X-Google-Smtp-Source: AGHT+IG9i4xXjlizKAWc3IWBu5Bc5uVaNfBIIqXLDvVzFxYDW0zWE/YDdM3vW1AzWUQdHSWgdgjCSQ==
X-Received: by 2002:a05:6214:3d8a:b0:6a8:e485:f59e with SMTP id 6a1803df08f44-6a8e486054emr103606226d6.26.1716318109740;
        Tue, 21 May 2024 12:01:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f194cddsm126569876d6.64.2024.05.21.12.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:01:49 -0700 (PDT)
Date: Tue, 21 May 2024 15:01:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/30] object.h: add flags allocated by pack-bitmap.h
Message-ID: <38c96fc1909162a4d9c188f55b7c708cfc1b14b9.1716318089.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716318088.git.me@ttaylorr.com>

In commit 7cc8f971085 (pack-objects: implement bitmap writing,
2013-12-21) the NEEDS_BITMAP flag was introduced into pack-bitmap.h, but
no object flags allocation table existed at the time.

In 208acbfb82f (object.h: centralize object flag allocation, 2014-03-25)
when that table was first introduced, we never added the flags from
7cc8f971085, which has remained the case since.

Rectify this by including the flag bit used by pack-bitmap.h into the
centralized table in object.h.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/object.h b/object.h
index 9293e703ccc..99b9c8f114c 100644
--- a/object.h
+++ b/object.h
@@ -81,6 +81,7 @@ void object_array_init(struct object_array *array);
  * reflog.c:                           10--12
  * builtin/show-branch.c:    0-------------------------------------------26
  * builtin/unpack-objects.c:                                 2021
+ * pack-bitmap.h:                                                22
  */
 #define FLAG_BITS  28
 
-- 
2.45.1.175.gbea44add9db

