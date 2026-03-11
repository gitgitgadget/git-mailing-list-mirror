Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3772BEFED
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250430; cv=none; b=kdRMfXHdZ1qvy8COA0NuACbbQnBSxZKM63q6HA5W2fPiTxOQ0hfMPPQTw6zNG+ZBzBvXusoBhVTC3fVqH+EvpNLfidnjOzrToRcRduDsn67B/sLSRe+KBTUWfIepeQgr/gzBRgKyj8bcBwLsp20l5wSYYoSSkEyWbJH32SfcItg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250430; c=relaxed/simple;
	bh=MOEfyq0R0J6uHAwKBjDTALRFtzXdiC/QSO4Y+E9tNng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyGv4e3MKeFiugZPl51scSl++Mmm+pp54qzr3N3KC3RtYJel5mhjqabMth7HfeqElU8QYa8df+ctPwy3tnYidBJwiWWAqcsYgBcOtdK99X8J8tBtOaXfUlzvVtTVs9+F1WzEX484298xvIQZBDulky+mU5ObaJOP6YKO204A45g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJFjPxjR; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJFjPxjR"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35a07c4b17dso28322a91.2
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773250426; x=1773855226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsDM5/GAf4gBOU4Qh+0dyY+oNXh5OzYL9myNTcpoLV8=;
        b=LJFjPxjRx82zNO3KJGyu+PZdBxRF0IPn0cCpznsSaPNDEGYEoBk8nHWTJY5ZW5nAjm
         zfVNoTEVRLg+bFn27OOF+ef2VQGzfXT2RBalUjxK8eP1OCznp5EJ20Mb9FXA+NE1GOR6
         wzL+6RczhVSvkQLEPkIMueuE5a7pMAZenzCiBhah17ykMIW+56Ww81mXICd5u9xoJLcF
         xB5te7mURc1QeFv76QJSehHm77WVnBhOpyVPR0c+H9zNU0tjzMM69mOA2hsmA1I2PAmQ
         rgtqfVOK1prn6a5hCcGmxZ1K8rywa3OI5F4+v6bg22lOc256Yvb3PKkQj09aiJfRZiRa
         KVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773250426; x=1773855226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MsDM5/GAf4gBOU4Qh+0dyY+oNXh5OzYL9myNTcpoLV8=;
        b=mVIsK56126vIckbe3065s5gAx7XivZhLMWeX+5aevr5x+oT5kBVGLRhHVIgcn7Etg5
         AwG/ZV1S00XXignHspinmZuypdCmknxyIhBKBNHVz+MhYLCX8GrotXkqU7+m3i7VM8JE
         l7e5RX49Rq4Dem8XGn8NerBmj4B2XZfr/yYKDyXfJdhyB5s2s9sZqDPI3HOsa1XbqXiS
         MZFr7XFigizygdK5ljhS47OVmcizLkv6NrGBWnA8v9i8kY71/rPUpVL2szUic90UShKF
         nK+hy4snMkPVGaCCaYA/T9r9eIzitfeQkOBikteP57GxP/mFzYawI4KHx8h8yYrcqVjQ
         K0fg==
X-Gm-Message-State: AOJu0YxSxX8p38EDpQT6YcgA32v5o4BN34Ja467Mdw/QXkBl7mCTA+mB
	3nXsZmdMsinOsLZxS67RoSKPJWDX/Tba+w71IbMyLlxTTzMvAWkUKzKfadNAOQ==
X-Gm-Gg: ATEYQzwL3VEpUJXwd+Q7ZjyF79gd2ch4wUy55MM96S7XRBBDw+jgAPBlPByNt+gxkqn
	E5h514SW6pJ8k/Ko9tVumY1dSkq4mSGd5ItmZsueuyGJ/lYXeV7hTHbkdeG+/CKaI24xLnc5zsK
	EmSpg7Grq2itD8M+5YCeFV8SMjz9av533mZSNEwM4WhHsXAoEdyLvCnIzKAQEfeXi4S6Gee67qV
	b5hql1K0gKUplkBLzfeCzmpZw2pXi4Zftfp+LZgXs2O7/QyA+Hc2uYoeL+hugc0yzKSNCFgRrKS
	JLDSvmdn7Sk92xvnjn06wP5QSu98zi7oYUgaXCWZS18I4dYWqS6mPWz5zoHlY3YgE8bzv21W6CW
	WvKdJoRx0LeE6J4gE6TVMgk3CsTPWhFv4kkb02VOfq/cWY7jPueqmYZNsUVRhtqEwC+YUC9L+Xv
	qgH531UjczZqnZ82AzUmy18ELfPIvnjIzIvvm0SiSzfznuURFihmgd19ggqWHABjKzHMTw/QUUL
	MR1
X-Received: by 2002:a17:90b:3889:b0:354:a57c:65dd with SMTP id 98e67ed59e1d1-35a012c96f4mr2950190a91.24.1773250426139;
        Wed, 11 Mar 2026 10:33:46 -0700 (PDT)
Received: from d.iiitdmj.ac.in ([14.139.241.214])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a0f6d190csm749973a91.14.2026.03.11.10.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 10:33:45 -0700 (PDT)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH v3 0/2] avoid unnecessary strbuf_split*() and strbuf-by-value usage
Date: Wed, 11 Mar 2026 17:33:34 +0000
Message-ID: <20260311173336.8395-1-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260311132041.12044-1-deveshigurgaon@gmail.com>
References: <20260311132041.12044-1-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio's "do not overuse strbuf_split*()" series calls out remaining
uses of strbuf_split*() as leftover bits for others to continue.
This series picks up two of them.

write_worktree_linking_files() takes two struct strbuf parameters by
value even though it only needs plain path strings.

parse_combine_filter() in list-objects-filter-options.c uses
strbuf_split_str() to split a combine: filter spec at '+'.  An array
of strbufs is unnecessary; walking the string directly with
strchrnul() is simpler and cleaner.

Changes since v2:

 * Patch 1/2: no changes.
 * Patch 2/2: Incorporate review feedback from Junio C Hamano.
   - Reuse a single strbuf instead of xmemdupz()/free() per
     iteration to avoid repeated allocations.
   - Skip empty sub-specs consistently (e.g. "foo++bar" or "foo+")
     instead of only handling the trailing case.
   - Trim commit message to focus less on implementation details.

Deveshi Dwivedi (2):
  worktree: do not pass strbuf by value
  list-objects-filter-options: avoid strbuf_split_str()

 builtin/worktree.c                  |  2 +-
 list-objects-filter-options.c       | 40 ++++++++++++++---------------
 t/t6112-rev-list-filters-objects.sh |  4 ---
 worktree.c                          | 22 ++++++++--------
 worktree.h                          |  2 +-
 5 files changed, 33 insertions(+), 37 deletions(-)

Range-diff against v2:
1:  ee6b7d1e6a = 1:  ee6b7d1e6a worktree: do not pass strbuf by value
2:  c04ddaeb95 ! 2:  9f8690b9c7 list-objects-filter-options: avoid strbuf_split_str()
    @@ Commit message
         parse_combine_subfilter(), only read the string content of the strbuf
         they receive.
     
    -    Walk the input string directly with strchrnul() to find each '+'.
    -    strchrnul() returns a pointer to the terminating '\0' when the
    -    delimiter is not found, so no separate "found separator?" branch is
    -    needed.  Copy each sub-spec into a temporary buffer using end - p,
    -    which naturally excludes the '+', so the separator is always stripped
    -    cleanly.  A trailing '+' causes the outer while (*p) test to fail on
    -    the next iteration rather than passing an empty string to the parser.
    -    Change the helpers to take const char * instead of struct strbuf *.
    +    Walk the input string directly with strchrnul() to find each '+',
    +    copying each sub-spec into a reusable temporary buffer.  The '+'
    +    delimiter is naturally excluded.  Empty sub-specs (e.g. from a
    +    trailing '+') are silently skipped for consistency.  Change the
    +    helpers to take const char * instead of struct strbuf *.
     
         The test that expected an error on a trailing '+' is removed, since
         that behavior was incorrect.
    @@ list-objects-filter-options.c: static int parse_combine_filter(
     -	struct strbuf **subspecs = strbuf_split_str(arg, '+', 0);
     -	size_t sub;
     +	const char *p = arg;
    ++	struct strbuf sub = STRBUF_INIT;
      	int result = 0;
      
     -	if (!subspecs[0]) {
    @@ list-objects-filter-options.c: static int parse_combine_filter(
     -			filter_options, subspecs[sub], errbuf);
     +	while (*p && !result) {
     +		const char *end = strchrnul(p, '+');
    -+		char *sub = xmemdupz(p, end - p);
     +
    -+		result = parse_combine_subfilter(filter_options, sub, errbuf);
    -+		free(sub);
    ++		strbuf_reset(&sub);
    ++		strbuf_add(&sub, p, end - p);
    ++
    ++		if (sub.len)
    ++			result = parse_combine_subfilter(filter_options, sub.buf, errbuf);
    ++
     +		if (!*end)
     +			break;
     +		p = end + 1;
      	}
    ++	strbuf_release(&sub);
      
      	filter_options->choice = LOFC_COMBINE;
      
-- 
2.52.0.230.gd8af7cadaa

