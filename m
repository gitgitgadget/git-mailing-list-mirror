Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199D7181318
	for <git@vger.kernel.org>; Tue, 14 May 2024 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716611; cv=none; b=ROyWCwW/hQOeShyLFlopsnsoQ/btbkPwNr1H4UC+/y08633uMNuhLOeeVFAI8IWENyUuqyot/PggvZJ/V/KLeX/y8YyY5l42iI0dZz+IPKZ8mwptjYpYRdtxuxJfITGYNuOPOrtI+KrwiH/f3MwZlg5wCzUO79h7E1tRoUj3TB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716611; c=relaxed/simple;
	bh=CMR3BS+x7qzngmRs/e4i66CEd/LM56lJqrYAZEyefLE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gwmlsyp1vOkAxK2/Zq0mMKraI7TZuHLzuKq+aOfXm03hdX3SLGBhH1phc1tgaDSC6dhZGNHCM4cGeuCAe6Xkve3ooipPclw1HQX6xPdZ6K6FBsiGAUZO3Y901QNIl5dG/uskGn7mt1xb6S2O0vJpI/p9fXMjS2RrpXF4H14QYds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=VaGdEIjq; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VaGdEIjq"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-62036051972so66722417b3.1
        for <git@vger.kernel.org>; Tue, 14 May 2024 12:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715716608; x=1716321408; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06RogiNDwwVrrCRMck2YH0WY0L05aonLA1g1mijkvJQ=;
        b=VaGdEIjqq1aHR3arHSSpLhHnZZt+LjF2TgOguH8y05jVNZPjPYdo3GKvWLUzwreCoI
         GnuSL78LzSoxvxnlOBIico0HLPB4iG4fIu1SjLE8ZWso3Rj8ev3/fzBWTj46CtKOq+ov
         UVK+i9ugDMrY+qOHOvdMzKUtJ92TzxDB9otopCPfM9sInWxacz/bIdmedex/RSZ4PI0x
         WNCbz54Q/Y08DMBZ33BlqTx4t6W3+8grunCRt/NrVaFX6+VaiSO32sney4y0kluo7gR/
         ZlCRNEF/bzw2BgT6JLTWCJ3/jBY+z4w9xhCcheZ+ihqxlJOqcwfW5izjxZeItM0UT3Zv
         K7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716608; x=1716321408;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06RogiNDwwVrrCRMck2YH0WY0L05aonLA1g1mijkvJQ=;
        b=RF7aITHdEJwLScpxW10S+bLzqHnyXO7FOVdmwxKA8htX7FEt0XHXmp3tlZLKCd53jq
         psvAJE0VrZC61ijTYazEQqO2S7RHwZg2+CUX8qyIpYE7m23SYTCDrc+OvBRFemm/KLSS
         w9JsfSJdNJGtHsJubBV8SugDu5UUX7nvF492djjywqgfs55vIZEvnZDkcSD8tP0Byb8v
         8k3jI5ZUmqOWucm3i+IkfUjm5G1zbv0ei5u//ijwLN1m/2BAqoX0xKTxRZoY+HvlaY7R
         LkagndDsNXKVu+U5gqpGwC31CxBKDQf0BERbwGT6e/PRlQPkT8OJfauEYhMGhb3/Mzx5
         p1KQ==
X-Gm-Message-State: AOJu0YzKqLXX4RR4KPp1U6SnTTi3COOb08UksUgWSBUHx7MHc6k5bvyo
	ZO4rGABYBKqMVulB0uCQi2Mc4L90AXXDCfmYFWIrOFNMOba6ZykSdF55F3VHpfLN3Jop8ueJ7SH
	0
X-Google-Smtp-Source: AGHT+IGF2PImhNYm3JtY2I0TJTPRPwLXrJc6+Vm2xvoEIXq7eT5lVTSjzfKmsnoEcflgiZUPPBY/6w==
X-Received: by 2002:a81:83c5:0:b0:61a:af95:9fcc with SMTP id 00721157ae682-622b013c4eemr135483267b3.39.1715716608516;
        Tue, 14 May 2024 12:56:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e1c32e8basm26164381cf.36.2024.05.14.12.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 12:56:47 -0700 (PDT)
Date: Tue, 14 May 2024 15:56:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/6] pack-bitmap: various pack-bitmap-write cleanups
Message-ID: <cover.1715716605.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This topic was born out of tb/pseudo-merge-bitmaps, which has a few
quality-of-life improvements in the pack-bitmap machinery.

The main changes are to remove the static 'struct bitmap_writer', drop
one unused fields, and start using another unused one (see "move
commit_positions into commit_pos fields").

There are other smaller changes, too, like cleaning up the flag
allocation table in object.h, as well as introducing a new
bitmap_writer_free() function.

The next round of tb/pseudo-merge-bitmaps will be based on this branch.

Thanks in advance for your review!

Taylor Blau (6):
  object.h: add flags allocated by pack-bitmap.h
  pack-bitmap-write.c: move commit_positions into commit_pos fields
  pack-bitmap: avoid use of static `bitmap_writer`
  pack-bitmap: drop unused `max_bitmaps` parameter
  pack-bitmap-write.c: avoid uninitialized 'write_as' field
  pack-bitmap: introduce `bitmap_writer_free()`

 builtin/pack-objects.c |  19 +++-
 midx-write.c           |  17 ++-
 object.h               |   1 +
 pack-bitmap-write.c    | 248 +++++++++++++++++++++--------------------
 pack-bitmap.h          |  38 +++++--
 5 files changed, 185 insertions(+), 138 deletions(-)


base-commit: 83f1add914c6b4682de1e944ec0d1ac043d53d78
-- 
2.45.1.151.g7cc3499008c
