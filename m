Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B446637F8C5
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 04:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775017190; cv=none; b=mT3yYpOk+OtFfb30tfBGLRBkyzmyLG2xJOadao8uKTTUniShaj1c7ndjP5G7QSv16m3jYVbAF0TKYlSxS7lvw+ykS6bbKSYaAFZnQErDSVRpNlplxY9HJxXMhIiov5hENYxI6GK+lmSm+PxosOfqQeTWshN4JpmDhW8MwSUOCz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775017190; c=relaxed/simple;
	bh=HO3bM3Nvzb/B1mzoeD49cKsiTg6XeBSa5AZzrWzBYuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WyAMJJB6YJTw+UG8N6csdzv5YezxpGgUEBEepWXgnVL2Yy9BICeYNGNz/YDccKluHP8AH+VCPCrswQe36m8ve406vQ0AkSpZu2ZDhcmUGoxuh+j7os8nDR6CVbLtih6a+H9MFlv3S/qauV87xrzfa2mbHqu3Mj4U2QqPPKThKAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pdUcvfzY; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdUcvfzY"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-827270d50d4so5612051b3a.3
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 21:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775017187; x=1775621987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZEFv0mb5mHVOK3/Q+cjB2k4YvIot91/SOC+vWEdcjM=;
        b=pdUcvfzYf5O8bwP0sdBoA6mOTCZ71cts4zfxdMIQIbayBxMJDwwxcwNnfNODiz9IZs
         hIIlOTQAvQjj5wm92G3BJhdaEpfCvzkX/Kbb/S9mEWpgYdPQ/m4HMIc4BHkV+nS8DVg5
         9d7QD2PlJ7sNm18SUVf6s2Cjpik3WKUnqApWuJIkaVRzb12ZCEw+QelSKp/SIgr5uLAc
         8PwVTXWD/Buucu13aXJLF31FWvjoGXN+g0D+AL31kplJ8+Ufk5gGgwRMqnvIuvq2FYdS
         vVKaDSsimZqbAALZ6vwmMC2RtlChrRI1IzhbFgkosVfcE04wNbwQ3cak9fOsF7HbBzyt
         gyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775017187; x=1775621987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZEFv0mb5mHVOK3/Q+cjB2k4YvIot91/SOC+vWEdcjM=;
        b=o0omajjD6FZm5OWjBbv9W3nnproOz0ur2zuSoHVm6i6l6pbmGFo2PKPcbWo+8I6qiQ
         pq/sp21h9j/+k3begZy2a52eJ2v29koXxY2S/6RNmxegQyhw1ZwOsf8lmmzfJ9bqAB3R
         dSuRAxEq6aiuOBB0RfG+TmMbnDGcmntxMMaam4staqBAX7+nhwox6XAcyYFSDh8vnThM
         KqIMOwsA9wSA/R7fR/jQ5QBz6TwdCF4+BBaXe/s8PfxNmcqtqWd/NrNLYJtreRRbsKg6
         Lhp6xDmdq6PmzteejvEEmfG3GoA6uAE7/LB8ZLBvnG9l2OSXZOpkhLCWEZuO1nzjWaFA
         l5vg==
X-Gm-Message-State: AOJu0YzUR5nb75fCLk2vFMvPFvJIZb7mmcwSKJWZjzGUaBE+ONPlEmXh
	8WtOClyq4XRg6MWBSpjvEh0fhi0PwmApHEvtiTgSVycWSJgLITj93nkuSoWKkRKb
X-Gm-Gg: ATEYQzw+qn42hCT7LapGevEckK37yKe7zz7etj0td619LCs0eXx4O5kpyWTxM2G3Q+0
	SR0Af18pYXDYv3NGHSFM9tJsrSpwwp8fezfi7Wgaakb4s6aE0smTyAm2rfyNwxcdpc1ioZpxusP
	RnjzEnQ2Au5eSYwfL6Nkdus3a4ulXNJWfpHfS58dse1F+bRI/b4y8ET5Ei88JZ6eiQ9D3BEJs+l
	GYdCx3X5uOLZmTMNu224uMdxeWqtVr/kp7MvRjojCRU2IbVxZZgGa/12aXpA9F136Bo7+xHVWRf
	0d0oGlzehmI9R2HAf9mTMMQ1yO51UhnOc9IFLeDd8A6tFw1Qdo0nnZSK4fTbLQ8jyyEcI/TYIwN
	8/AIGZQ2e+V7e1IrO3A7tZHV83HPDY6P0Ke84Lvb1oi38lOxUDk1Z4aJoiygRc9MiazY/YZdc0a
	gOni9is1WZmIUjTlCo5+29zwE4ZUfebDvbPi8CcrzA9IOnGX19TctyA2Z7HngsmCPKETTi03TwQ
	gY6NKrkxg==
X-Received: by 2002:a05:6a00:451b:b0:824:a01f:6335 with SMTP id d2e1a72fcca58-82ce88f63a2mr2548238b3a.22.1775017187443;
        Tue, 31 Mar 2026 21:19:47 -0700 (PDT)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85d60c3sm11195114b3a.32.2026.03.31.21.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 21:19:46 -0700 (PDT)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	stolee@gmail.com,
	gitgitgadget@gmail.com
Subject: Re: [PATCH v12 13/13] fsmonitor: fix split-index bitmap bounds in tweak_fsmonitor()
Date: Tue, 31 Mar 2026 22:19:45 -0600
Message-ID: <20260401041945.86738-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqfr5f289u.fsf@gitster.g>
References: <xmqqfr5f289u.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> While this may avoid this "assert" stopping the process, what is the
> implication of returning from here?  Who are the callers, what did
> the callers want us to do to the cache entry at the "pos", and what
> happens to their expectations if we simply returned to them without
> doing anything they asked us to do?

The callback's job is to clear CE_FSMONITOR_VALID on the entry at
pos (marking it dirty). The only caller is tweak_fsmonitor() via
ewah_each_bit().

In practice this guard shouldn't fire during normal operation.
By the time tweak_fsmonitor() runs, merge_base_index() has already
merged the split-index entries, so cache_nr is the full merged
size and the bitmap positions are all in range. The call order in
read_index_from() is:

  do_read_index()           -- reads split index, sets fsmonitor_dirty
  do_read_index(base)       -- reads shared index
  merge_base_index()        -- merges base into istate, cache_nr grows
  post_read_index_from()    -- calls tweak_split_index, then tweak_fsmonitor

The guard only fires if the bitmap references positions that no
longer exist (e.g., entries were removed between write and read).
In that case returning is correct -- there's no entry to mark
dirty.

And even if we somehow missed marking something, refresh_fsmonitor()
runs right after (line 813) and re-queries the daemon by pathname,
so it catches any changes independently of the bitmap.

That said, if you'd rather keep the BUG() assertion as a canary
and handle this on the test side like Derrick did, I'm fine with
dropping the callback change and just keeping the
!istate->split_index guard in tweak_fsmonitor().

> This part does make sense; the minimum may be relevant only when
> split-index is in effect, so we limit the check to non split case.

Right.

> I do have to wonder if there are some invariants we can/want to
> enforce here in the split case, but I do not mind punting it to a
> fix that is more focused on the split-index theme, as Derrick hinted
> in the earlier commit you found.

Agreed. The bitmap is written against the full merged index and
read back before the merge, so during the read phase the positions
can legitimately exceed the split cache_nr. After the merge they
should all be in range. The read and write paths already punt on
this with the !istate->split_index guard; enforcing anything
tighter probably belongs in a split-index focused series.

I've also moved this commit to 1/13 per your earlier feedback
about bisectability.

Paul
