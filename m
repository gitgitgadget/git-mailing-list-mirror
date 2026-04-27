Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B73930E0E4
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777285727; cv=none; b=BEZHq5s2kVfTag7xebsDY6Rna8br+TRbO0djQ771aKPeQuTgqWO0l4UsjaoisMymlS9TAAeqtoZiLPOaURTUnQ4HbT85d8PGXYFWoVf0jRoSODwnWwNWMbpJkuKKjNhb38FOWqNNqBytDpWROgi8ou/dbu4lZWMHKsbUd8xgSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777285727; c=relaxed/simple;
	bh=+KNqfDdOr2ZX07GkRsZ7oYm1QwEjFphJGfpoSISNi9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMKmqg33725KqEe44TAtjNB4IL7V6tjuoCSRabXNqsEhW8KoDgz7AGJq1bUCxtFcc/FTbN0g+hhAbKq8zupofAOBU7312arPlkaueNhQ+7MM2jadvRKJrLCD+ucDJMljQsV/9ZavLCTzbENz0guph9VP+OzsrbjOgYVO7vu7ulU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWIggSz5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWIggSz5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so67354245e9.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 03:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777285723; x=1777890523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuktkNbS20f/Ry5FwpNshJtxk22JJQCQ9P/9E8RZZAg=;
        b=NWIggSz5huJvlW3iLww68RyC2V2W3W4iN0sxceWdgnyetd01hWQfXmgIJkaEscuaCy
         gZvDCwU8DV0fCoQX+erL6ExxXjAd1l2eY5Wpg1/Z7L/g70Y3GQUsNQnmGbe1FymDJefq
         dyszWIEMkq/LhzJ8BPUg/8tYYJm7f+qlj318tdwTUjt3RAEcSLEFqXDBUwrLWUJ1rn53
         7lIycX4Bxaw8YIIlg6fcLqcpvxnIHcAmv/53JqZcyxY03neaS08FITdlLKJkYyK81a4Q
         0M3doyRcVkN+p4FYpEy1/34cVaaTsb2BofSE6nQZObQqilwx1MW7I7ZWQHEYISCLP7um
         a8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777285723; x=1777890523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cuktkNbS20f/Ry5FwpNshJtxk22JJQCQ9P/9E8RZZAg=;
        b=mi3gT17km2fDuri84MRRLcSIthYuhcMG6dE60+oSkGcGCi0zJ7QwUK7w5oCTmktQi9
         f1q05pPYp5XNYPAzwVxa8Ry0napI/8bFSHEHrNGKE/zRGjGHrZEZoVPCckOo+4VCs1Wm
         ryfjPqYNUrokOwrfuDHtF5YIflzHrWaT3lhpxUZcu4wHaEbrgQ9w/4Av7myAfhf85lpd
         KaF2JW6OAC+Nr5TC2LIvxL14HqjQHYHwS0CMi7jBFtGLa88n1mvwjayzZBUuE0SqNP/I
         QqMJjBJrTy205yKtDRwv1uzbKyyeVCKc8EGtrXhGBbk9IpgaHVxOKWaMTk44mxzSZhd6
         ySUg==
X-Gm-Message-State: AOJu0YxvJPHdQeZX79wmNANATORARvwXfeOFrU0EWVtMPqZ2oFrQVc5H
	84pUsL+gRQPIF+er9AxvQyYsNYcAU8TR0YOz9LDJ1pVdhvWAi1rhdllzCDYf3kpcUZc=
X-Gm-Gg: AeBDiet/nkFHriiKo+KqC/cCGrQHNtiGRTWOYzZVs4eYsdT2KefCHvxptybi0WzluC7
	QXnbA3WAkgi/d6r9gE9CjGxSuQ5ut/kX8dxzijm4IHes3ehEWO5/jD/0TLy1YKdxmDNOqe+TdRy
	xszSQxfU8HvPi6S5gfkmyEjXq2oq2BYIOa/F8unA26Mpmnhvp4dgdq9prJKJEEZuO2jewDRCuIo
	iFFFb9e44ACK2RVjt28+1fvbAdgV2FEKmxdjvKFM65OMLhdAcRLqboOFWNJMMDeIG8k/Mt0DfSB
	Ls4dmcwdsflc5espCN4gk2coMpPOzbwk7Mbqns4Quk5ZXqDpDoCDo9osekBN53nSpoT3D8o/KDw
	1xbSmzs+m94NS90n3t4nl8UJEiT3gbT6V6EtRMHtQR36HA03RWNPMBXFzL6UU17/3tTn3OR8Vy9
	v8reP1V/26Ian7xTVypLCNuWxmY7Dj6dRVqzVo7qUG8gWGbUIYdSt/Yvq4EdmNOHB3LhsCqzh4p
	d5jv0X0JscZDI5UFn2iOfwSYtNXpe9+fujh/p7dwzDS23gS9Dy+kKMnqWgJiRIER6jCfbEAv4P5
	3kIiWgMVlVQSpfhLBsn88x8dbNazoSZ7kl0q1R/kuFXfaNpcik9UlQ==
X-Received: by 2002:a05:600c:c0c8:b0:488:ab1d:dcc5 with SMTP id 5b1f17b1804b1-488fb787ba3mr438072355e9.27.1777285723324;
        Mon, 27 Apr 2026 03:28:43 -0700 (PDT)
Received: from farblopa.localdomain ([193.125.177.175])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a06f3sm285517735e9.22.2026.04.27.03.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:28:42 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH v3 0/1] graph: add indentation for commits preceded by a parentless commit
Date: Mon, 27 Apr 2026 12:28:37 +0200
Message-ID: <20260427102838.44867-1-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404092425.550346-1-pabloosabaterr@gmail.com>
References: <20260404092425.550346-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When having a history with multiple root commits or commits
that act like roots (they have excluded parents), let's call
them parentless, and drawing the history near them, the
graphing engine renders the commits one below the other, seeming
that they are related:

  * parentless A
  * child B
  * parentless B

This issue has been attempted multiple times:
  https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/

This happens because the engine prints left to right from the first free
column and their column of these parentless commits for the next row
becomes empty and the engine fills that gap with the next commit (child B)
seeming that parentless A and child B are related when they are not.

The actual implementation is very minimal.
This patch makes the parentless commits to be kept alive at least one more row
to avoid that, indenting the next commit to the next column and then clean
the mapping letting the indented commit to naturally collapse to the column
where the parentless commit was:

  * parentless A
    * child B
   /
  * parentless B

This is done by adding a is_placeholder flag to the columns, the parentless
commit is actually there but marked as a placeholder:

   * parentless A
  (A) * child B
    /
   * parentless B

(A) would be "parentless A" column with the placeholder flag active.

By teaching the rendering function to print a padding ' ' when meeting a
placeholder column hides them, printing the second example.

There could also be the case where there are multiple parentless commits

without the patch:

  * parentless A
  * parentless B
  * parentless C
  * child D
  * parentless D

with the patch, the indentation cascades:

  * parentless A
    * parentless B
      * parentless C
        * child D
     _ /
    /
   /
  * parentless D

the _ / might look weird but that's how the collapsing rendering does it
for big gaps, this case being from the 4th column to the 0th column.

A follow-up could change the collapsing rendering for placeholders?
I haven't done it to keep it minimal, but a follow up could make it
to be straight '/'. This would make it bigger but easier for the eye to follow.
Is not worth it IMO, but opinions are welcome.

The patch also adds tests for different cases like a parentless commit
preceding multiple parents merges and the examples above.

PSA: the tests are on t4215-log-skewed-merges.sh, which is not very related,
     but other graph related tests have +140 tests, and this one has less than
     20 and some of them are also not very related and differ in style.
     A cleanup patch before this renaming the file and style of the tests is fine?

Changes from v2:

- Removed trailing whitespace.
- Added more comments to make it more clear an reviewable.
- Changed is_root to is_parentless to follow the name at the cover letter and
  commit.
- simplified cover letter and commit ascii graphs.

Pablo Sabater (1):
  graph: add indentation for commits preceded by a parentless commit

 graph.c                      | 115 ++++++++++++++++++++++++++++++--
 t/t4215-log-skewed-merges.sh | 124 +++++++++++++++++++++++++++++++++++
 2 files changed, 233 insertions(+), 6 deletions(-)


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
--
2.43.0

