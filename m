Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46313A16B0
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460658; cv=none; b=eUegrkujaFS/V/JckfLFVBUTMJmIVLfsUhVT6F53Wc2GR6wmcyMvQLxFe+yLNsGpG6mLHB7z8OvrnB9F49r1zHwwY3COWx535stvf1O9M3t+mY/F6unMyYAfkNYQXpVq2pZM60PD0paTJkwWtnDEO9/nJ2vGIZMRF4acbZwBg0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460658; c=relaxed/simple;
	bh=Bykxf6i9AwPmr7V3LbO5ylLEOH4Ng8TXvoVxuVfbga8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vdh5FMBdo0WDjEodwofXGESykJGNB+Nx2sW85Z9ItDoS7kYhJh0JN9iLPwj+HbrN7sbUtXYT9sE47ZMaZ21/5DMAks/jVbsW1cuWktYr8ea2HJZWxP87AHZsBR14VqVPhOAr3TGkhwaA11HHp2MMXe9ppwoAzc6EClUpi5N+nDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsVN9xGW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsVN9xGW"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48538c5956bso542095e9.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 10:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774460655; x=1775065455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeVCVOSlCLK164b52Kdvw6OYDzwZUWJEvkVpF6kbWes=;
        b=JsVN9xGWXAnxwDC3Z9KGrsgCyNT7QLbQqViAI7CYZY6Kzx5luh5TlysS/TdmXCvIxn
         OXDoXtULMSp65VpYKtLOohK+9bIe3UXmk02pwYkQevZTDa4QTIxXHYQKs6Rnf4YgA4QP
         aEKORlT8TIiIp3O9a2610T0b2x6zcxHDYg2H59mLNDXEe0QcFrhg7PORY2N4fugpiPzz
         4szDpHMn83vOIPsNvDD4IORaYpgUg5P+U1WsjpXMzpZCtnJu4xDfSspmXzSsDlBwt6GB
         Yc9d0oy1U1ua8dLbySaWmd+H7D6+r9yU7BRO6SkSPnlmNTRhn1zOW5HTlDYCSbkRSjqt
         YW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774460655; x=1775065455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LeVCVOSlCLK164b52Kdvw6OYDzwZUWJEvkVpF6kbWes=;
        b=VsXihCvrngqH5RKoJBfGz63P0eaqWWwnq5umj8EbPEyM8LBF0RsilAZPnb6GiQ4rdc
         /mEodIVOtDomS2sh2s5w0b/8yz4fZYn1ROCtOYiCvoZOtFNsWk5NSXSM0vup8D0YDm0d
         mkWptTnY0o/R+1/E8XuktfzAHWeQThgE15xXtbUKFT49xJnb3aK2Ax7+9dIHOWQUxhll
         YOapDP+85Emg21xoS5Ce2p/37f6DM3fdy33+zddaEstPphvMYEmvWreLXZSZFQNZ85aM
         yOPZIkLgjib140Z/xlDnBbtqkY2HKQB29FxJ23JOcg77PC5ksMAPJAXonA2y2CSDXQ2z
         /4Qw==
X-Gm-Message-State: AOJu0Yy/DMwU8yK+X/qJofyRCLResSKs8ZV021tOXw3ZRU/32BWV/iC4
	8pD3MXqRjbVUPsUtv7Aj2sze5GEpnYsaMKo5s3ZbQXfVrYgcQXvPly5pHpQFDOTm0t9Arg==
X-Gm-Gg: ATEYQzxZzLHuFKfETZhTralUDsuXpHjbAD6Uwml4pxFQCrQImYvxiPYVak+ziIpyE1M
	9qDwV4G1CaJ83BFcR/rDuJy5/aPKae3u5NwTJjDZIe6a/yznweuC645EKXzL8jGhe4JGvvJFt26
	N+er/sGmWiyeJK+nowdfOwNymrL4CrJ011EhZP3JLxLnvaUVc8jkRu49K/h5PUW2Ln1Obg7WI6Y
	AXsKzTfFQF+rpUmrj8zpKX4h0sPBHocf+HscPQN1qtP/FskwRIVNxf+pBSHsJ621594RgHfYRfs
	VvVn4EtbqXjKYd8kEnZvYXCZp6942Rg0i+J7VSXgF5SlM7VTMJN3ZUN0JQUQt9TiJjcZS+flNhL
	eXDDIfJUxGindTi2GFf7XyWPMKIrhKo18EjC+aot1gZh/Ta0tLFETpfBatEe61AasXvxSAtVJEk
	VnUgh5KKvq9+4PV5s2LjFUNc7l8Asx9cwpKOmQYJwtP6i0K+fB4JvlQoqgHf5EjUd1ucTzvESu2
	B37Sza/bG8os8mPIHduHLzm5CsymrDtKaFYBXF14DshYToFT5MRbAjE5aE=
X-Received: by 2002:a05:600c:524f:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-48715fc76bdmr59436645e9.1.1774460654686;
        Wed, 25 Mar 2026 10:44:14 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48716547814sm47106145e9.0.2026.03.25.10.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 10:44:14 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	gitster@pobox.com,
	j6t@kdbg.org,
	szeder.dev@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH v5 0/2] graph: add --graph-lane-limit option
Date: Wed, 25 Mar 2026 18:43:59 +0100
Message-ID: <20260325174401.217577-1-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323215935.74486-1-pabloosabaterr@gmail.com>
References: <20260323215935.74486-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Repositories that have many active branches at the same time produce
wide graphs. A lane consists of two columns, the edge and the space
padding, each branch takes a lane in the graph and there is no way
to limit how many can be shown.

The limit is a horizontal truncation, each lane is cut at the lane limit:

  Without --graph-lane-limit:

  *   7_M1
  |\  
  | * 7_E
  * | 7_C
  | | *   7_M2
  | | |\  
  | | | * 7_H
  | | |/  
  | |/|   
  | * | 7_D
  | | * 7_G
  | | * 7_F
  | |/  
  |/|   
  * | 7_B
  |/  
  * 7_A

  With --graph-lane-limit=1:

  *   7_M1
  |\  
  | * 7_E
  * ~ 7_C
  | ~ 7_M2
  | ~ 7_H
  | ~ 
  | ~ 
  | * 7_D
  | ~ 7_G
  | ~ 7_F
  | ~ 
  |/~ 
  * ~ 7_B
  |/  
  * 7_A

The '~' is the truncation mark, not an actual lane. It was chosen because '.' is
already used in octopus merges and '~' is not used elsewhere in the graph. Yet
the edges between the last visible lane and the truncation mark are still
conserved.

The '*' commit mark is visible when it lives on a visible lane or the first
hidden lane, any deeper lane doesn't show the commit mark but keeps the commit
message visible. 

Merges where neither the commit nor its parents live on a visible lane are skipped
because they don't carry any visible information.

The original idea to limit columns was noted as a TODO in c12172d2ea
(Add history graph API, 2008-05-04).  This does not implement
gitk-style column rearrangement, it only truncates the visual output.

Possible future improvements:

- When all branches involved in collapsing or padding are over the limit, the
  truncated lane doesn't show any information, this lane could be removed to
  make the graph more compact. Currently these lanes still appear because
  graph_output_collapsing_line() mixes state handling with rendering, so it can't
  be skipped but callers always expect a non empty buffer. Fixing it would need
  to refactor the callers to handle empty buffers instead of expecting them to
  always have content.

- Collapsing and merges lanes that start on visible lanes but end on hidden ones
  are kept to maintain the most information possible on the visible lanes, but
  the information about where they go is lost. They can be kept, removed or think
  of a way to show that information without showing the lanes.

Changes since v4:

- Merged the option parsing and the truncation logic into a single
  patch, fixing the DEVELOPER=1 build break when the first patch was alone.
- Added before/after example to clarify horizontal truncation.
- Fixed error message to match existing format strings.
- Shortened code comment.
- Changed truncation_max -= 1 to truncation_max--.
- Fixed pre-existing indentation in graph_output_collapsing_line().
- Fixed unnecessary blank line changes.
- Added that zero and negative values mean no limit in the docs.
- Changed truncation mark from '.' to '~' because '.' is already
  used in octopus merges.
- Added more tests.

Pablo Sabater (2):
  graph: add --graph-lane-limit option
  graph: add documentation and tests about --graph-lane-limit

 Documentation/rev-list-options.adoc |   6 ++
 graph.c                             | 149 +++++++++++++++++++++++-----
 revision.c                          |   6 ++
 revision.h                          |   1 +
 t/t4215-log-skewed-merges.sh        | 144 +++++++++++++++++++++++++++
 5 files changed, 283 insertions(+), 23 deletions(-)


base-commit: ce74208c2fa13943fffa58f168ac27a76d0eb789
-- 
2.43.0

