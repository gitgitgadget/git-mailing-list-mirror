Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219E62BE03B
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868490; cv=none; b=pCfFEuS3TH+EDw3fi154WTZ//SD1jiYxaL4pf/pyJzSybrxNivps+wmv5HjtxfLj0Sf7UZvVW0Jt0T0e7fze7o+a6Q52u7pI6nweRTM7vko3+m/siaVJW7UI0xFNpiZwMQLstiZPW5mmexpAGL8KfedKvnqHo+T0vPr54TRNKYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868490; c=relaxed/simple;
	bh=XBqUrib8HKXX0tbAPP/BPTU7YieVWmMGNSmusqrExEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qs44ytbpNkALgEr1M3IEh4MElUETElgXfleTIUXg32jAMNHFqr/F8g4k3coB6AvLk4p7zmCwme3UlDhi60AcEKEmoW9CLbamNFUXliYz+YDVLfwrx3n4NBLEHQwv7N2HiTE+5Gm8Hu3bWge47NvALvj7EtIonOWPYbexP/FyYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALaDz/dD; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALaDz/dD"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d4c85307b2so2764060a34.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771868488; x=1772473288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmB5ETV5NyN2GXygBGTu74YqwHHI8pfAW8O3NiNt9ws=;
        b=ALaDz/dDEIhsOy2HTUffiwoCpjEvqLrghWAAs4516Ws3QpEZhFTwXLLOGviXDOBWqO
         5g3jSgFR3V1nZxb78PSRKiC3NxzItXqegJ+Bo1+BkyOu974sHu1oSQWwlcsvJJpeKcp7
         wTGyicprf9c5bLuWMW3SQqvrUawrFtZMxG4NIJu8GaVn4vhgJc2GJn8kKZ8P7nuA2aMc
         K6uoJpdOXlr9kWdyB2ztHmJQFKrZXQeu/IybvdTaxFbE1aUQXvCeg8Tm1R3cS/C56BK9
         QbjkAWBfGMXP8wP1DU/AexyhrztxRtqhotz6GUgy30HQIgHUxBSDj5HEBnwnnKQANBHM
         ZVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771868488; x=1772473288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EmB5ETV5NyN2GXygBGTu74YqwHHI8pfAW8O3NiNt9ws=;
        b=vJzxypcTeWbTsOw+/qnZlHUdoByAgxfzfDsCkh2Lmkt8Khs5F34fBA6XiCCoNgtixg
         LtLwjpVa2Op/Wo8Z2aU/Zv+i1qr9i34bjXSLD2dG+p6GhoWI6v0OZpy5h+ffRVJEyPYn
         uKXEmoxWBvu6+Jkc4wad2iwlyxSycdLmMO5S2bk0c4YCeS4/82Os59VEXPUE+BSkt0+0
         D/j6XRLIwJFWkZrWU+PubFDTiqXPNZS+N3FX4u3m15Qle7dDAcYn7DOBjCNi/fGPC98S
         TA/d8DOm691y3Lz67OCJUTlQ3gaCZtimPp/2dFas8QhqSo8zoWi8EeJ0LuQmED0mgJFH
         FFPw==
X-Gm-Message-State: AOJu0YwhtRUy9AvC2R7V5Fg4bo8bThL2SSZWajiJS3HE6Zg9kGfjNQv7
	zPNZZIOfvZgamEOl3JTXHXV3aYEGEhX5Ak3D/OM1rm6HHsiG4bdGweOHPZSwXQ==
X-Gm-Gg: AZuq6aIgCXEpOFLLfqIz7XdWHMoV3oSOEo0gI65X0R0UBeUbrYoKgkvh7ew+jAg6DmG
	OdyekDgWqpiIFMJxnRn84Mxv66W+cYyNVWrj0mQ+BGeYHTXXnS0g1JzSQSxE/x4uMj3lzL/AfSV
	yXADd+Yb6vKPxy673rn5q3AmCM+BgpjZztCx90ID71V8X/itoho5ma5xNlBx/LPVE4G2JJ9yRTw
	esc/7gS7taMtXdk0HjJrO6hnEVUHjJO0pA3tbbAl9gkZqlYbfcWHzL827ecT3jBeNs/UK/Qxf+5
	EQtmKclg/zJS1yoVRktcv6bIogD+3AAaRyH+cVhmjiLs8ghvAhCU3vh2+nR+p+OUvmTRuf694yE
	P1iWP/0qWPtw/2Lse2tiQ07CgtBoCvfgy8m8FJvX2io/JDQqNSqkvZ86C+QxtU7bB+p/m4iW72U
	7sv0/3n1jYgat6/cJR2Kiskj0EcaYToGE=
X-Received: by 2002:a05:6830:25c3:b0:7d4:4c00:aa95 with SMTP id 46e09a7af769-7d52bfaf411mr4859925a34.35.1771868487596;
        Mon, 23 Feb 2026 09:41:27 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d0386c6sm8305476a34.13.2026.02.23.09.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:41:27 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	kristofferhaugsbakk@fastmail.com,
	eslam.reda.div@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/5] builtin/repo: include largest object information
Date: Mon, 23 Feb 2026 11:41:15 -0600
Message-ID: <20260223174120.2356504-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260203221758.1164434-1-jltobler@gmail.com>
References: <20260203221758.1164434-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

The "structure" output for git-repo(1) currently provides count
information for references/objects as well as total inflated/disk sizes
of objects by type. Info regarding the largest individual objects in the
repository is not yet collected, but would be useful to users wishing to
identify such large objects.

This patch series adds the following data points:
- The OID and size of the largest objects by object type
- The OID and parent count of the commit with the most parents
- The OID and entries count of the tree with the most entries

Changes from V1:

- Avoided duplicating the annotation string by handing over ownership.
- I decided to leave the `struct object_stats` structure alone for now
  as storing the various object values per-type does make it convenient
  to calulate the various totals. I may revisit this in a future series
  though.

Thanks,
-Justin

Justin Tobler (5):
  builtin/repo: update stats for each object
  builtin/repo: collect largest inflated objects
  builtin/repo: add OID annotations to table output
  builtin/repo: find commit with most parents
  builtin/repo: find tree with most entries

 Documentation/git-repo.adoc |   1 +
 builtin/repo.c              | 249 +++++++++++++++++++++++++++++++-----
 t/t1901-repo-structure.sh   | 143 +++++++++++++--------
 3 files changed, 313 insertions(+), 80 deletions(-)

Range-diff against v1:
1:  94a44e0e0f = 1:  94a44e0e0f builtin/repo: update stats for each object
2:  92dbf34f2c = 2:  92dbf34f2c builtin/repo: collect largest inflated objects
3:  1811d03afe ! 3:  1457d5d59c builtin/repo: add OID annotations to table output
    @@ builtin/repo.c: static void stats_table_vaddf(struct stats_table *table,
     +		entry->index = table->annotations.nr + 1;
     +		strbuf_addf(&buf, "[%" PRIuMAX "] %s", (uintmax_t)entry->index,
     +			    oid_to_hex(entry->oid));
    -+		string_list_append(&table->annotations, buf.buf);
    ++		string_list_append_nodup(&table->annotations, strbuf_detach(&buf, NULL));
     +	}
      	if (entry->value) {
      		int value_width = utf8_strwidth(entry->value);
4:  471d352cc1 = 4:  f4e92e3f09 builtin/repo: find commit with most parents
5:  7f1b7f9657 = 5:  af404fcc6c builtin/repo: find tree with most entries

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.53.0

