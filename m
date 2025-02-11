Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4551F0E2A
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263861; cv=none; b=u2scBczD53baFJ8B1kdN5UP5tWWAfJb3h2Ou4Cm5yfclWHw22XZgg7jMz1d53jfmHXPkubOKdlbu1u4anO8eXK+l6fLeLTpNu6CMnYWTP2YZHwnhNcrW+96cKGKA9rdmvRMd9gQeubIpC9mqsWeEbThqnN2SxGdXI7amoHA+5dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263861; c=relaxed/simple;
	bh=RGjw+3NsTs+RCA10TmYXBkF7rHaCb2sF+LgeIGkJLEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FELfNG5Ohm/8UyWSABEnV4S+f/t2vHJKQq5EZ5eztacvb/wDtsdlBFyuxumsjISc/tugJ3FINhB9iVZrRI7vcCdwDLDyBQUCJFu0BeMUU9xX76r3lTP9bHJ72cruzbQJy6+38mtUNzQdlad0BuLWB2lMRlON7X5n7jfmggI/vCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvPa7asW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvPa7asW"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f6a47d617so46948825ad.2
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 00:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739263859; x=1739868659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJBX9ytmhXtnnyRTC0AdDS8eKcCd0GaltPvaNbkp3n4=;
        b=XvPa7asWbqLZm72NBZu/8xtH1ata9UfV3jLM72fnljNFwoIjldi+K/ix/MTj00jCZ2
         EBnggnGU3pAu6sp7u3jEMykjgPYMeokGHcABnB1CHZYIOY0VQ2JgAE7bDR4jFZkpKDCO
         UOuNRfeaRzFvzGrQeYFpniC+mC0JDolalvjGZbmAU0zYhkhnSFuWu0ocXBAV/TleTqtr
         AFK4Y7ZMRg4n/v+41Z9lbrVSC4G/sp7hzqL6dMG6JOZNNeNzozQPpfQwzG9gAqb936j8
         +ZaeVgemzJ5Sw7whG5jrgC5Oe8TF+jDGah38q+1fXW9Ti8NUT0728kLUwRpW6u3i1joj
         SjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739263859; x=1739868659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJBX9ytmhXtnnyRTC0AdDS8eKcCd0GaltPvaNbkp3n4=;
        b=ehX2waWusA8hdnymkfKxRATYuBeDTjrlO74IMm7W1fkOoZfRhSMVDWQTVOk4z0Y5qx
         lICTLfQXYtAQOIzGjQv1RkukaH1p+RtHiniQHYT6E5HmLImaq9ftiW17R2NHrNwwLFaz
         gUX2lVBKi6VeojMm6cQe8dyOnBBx6153mD1iWJ5/GgMMCVM639Kdhl5hrnRZje3kQ6N5
         5w62VklPeAL8UYWd6jGTZa3ST9WPydrweiitPElP2a9UkPeu8+38kHnwC5Ec+7PjDxg/
         pOLjA0AoxuBw3YcF0xYZTRF4i2D8hJyAF3f4cDBxdTyJRUkyWRQBBvqm4JD70OX8MQ4I
         TrUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7dUClE8dMOqmUvs0PtHGOuqqDeuevE7ZN5MvzsblyB/4qI1jdKl0g/TVp68inNNe3oF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLP2nz8YYocfmL8wl3rS9J/4ACCsysivu+NKrsS+phMxvFzWb0
	2uV667pc+mG8JfbZ5dKDifQ59huWVx5U9g99aKgzavtkDatKagPW/0AlLF3C
X-Gm-Gg: ASbGncu+nMRC3OwgI/HhrztvVZqsegCltbRaOOdCkjjWLXZFBzsGGcmMdGXI6p6pDSa
	YMa3eAOLuBNewPGrQtznK9o/uvtLBJDU2PLmY4Z0j3BXTvDTPUWTnvDZIPVBN6wA65cVCx6LanF
	Zot8f5s+YgHC0w5i7PZXR0hynnNpKZo4Iv+U+eQQ7CPX9/9e9jfeH0h0LtoBGtXloR5oLetUWfu
	RrJQifTYku2iA7oALc7FEmzawQ7ope+3kjzZ03bLemeL9KSDEF2zc3zfjDsWZ8PiqMveV66rR58
	EzVfhR5NLUvtY06Swk65EmL1CMP/IGLyIrU4yLo=
X-Google-Smtp-Source: AGHT+IE1XA28dfMmcUdxaDzfLXvKZBC0pfL8x87T7NGiXNP7vCB6EhQmMR9XhX+8vG4bVWybSDXg0Q==
X-Received: by 2002:a17:902:ebc1:b0:216:7175:41bd with SMTP id d9443c01a7336-21f4e759750mr251359175ad.39.1739263859548;
        Tue, 11 Feb 2025 00:50:59 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:3858:1e16:caad:e1d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a46534sm10201701a91.21.2025.02.11.00.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:50:59 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v4 05/10] docs: gitdiffcore: -G and -S: Use regex/string placeholders
Date: Tue, 11 Feb 2025 00:50:17 -0800
Message-ID: <20250211085028.3923875-6-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206014324.1839232-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the rest of the documentation (and in the code) we use `regex` and
`string` as `-G` and `-S` argument placeholders.  While
`regular-expression` and `block-of-text` are a bit easier to read, it is
a bit consistent.

And we could assume that everyone who uses git should be able to
understand that a "string" and a "block-of-text", as well as a "regex"
and "regular-expression" are the same thing.  So, using a shorter
version is also more consistent.
---
 Documentation/gitdiffcore.adoc | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/Documentation/gitdiffcore.adoc b/Documentation/gitdiffcore.adoc
index 642c5..0d7d66 100644
--- a/Documentation/gitdiffcore.adoc
+++ b/Documentation/gitdiffcore.adoc
@@ -245,26 +245,25 @@ diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
 
 This transformation limits the set of filepairs to those that change
 specified strings between the preimage and the postimage in a certain
-way.  -S<block-of-text> and -G<regular-expression> options are used to
-specify different ways these strings are sought.
+way.  `-S<string>` and `-G<regex>` options are used to specify
+different ways these strings are sought.
 
-"-S<block-of-text>" detects filepairs whose preimage and postimage
-have different number of occurrences of the specified block of text.
+`-S<string>` detects filepairs whose preimage and postimage
+have different number of occurrences of the specified _<string>_.
 By definition, it will not detect in-file moves.  Also, when a
 changeset moves a file wholesale without affecting the interesting
 string, diffcore-rename kicks in as usual, and `-S` omits the filepair
 (since the number of occurrences of that string didn't change in that
 rename-detected filepair).  When used with `--pickaxe-regex`, treat
-the <block-of-text> as an extended POSIX regular expression to match,
+the _<string>_ as an extended POSIX regular expression to match,
 instead of a literal string.
 
-"-G<regular-expression>" (mnemonic: grep) detects filepairs whose
-textual diff has an added or a deleted line that matches the given
-regular expression.  This means that it will detect in-file (or what
-rename-detection considers the same file) moves, which is noise.  The
-implementation runs diff twice and greps, and this can be quite
-expensive.  To speed things up, binary files without textconv filters
-will be ignored.
+`-G<regex>` (mnemonic: grep) detects filepairs whose textual diff has
+an added or a deleted line that matches the given _<regex>_.  This
+means that it will detect in-file (or what rename-detection considers
+the same file) moves, which is noise.  The implementation runs diff
+twice and greps, and this can be quite expensive.  To speed things up,
+binary files without textconv filters will be ignored.
 
 When `-S` or `-G` are used without `--pickaxe-all`, only filepairs
 that match their respective criterion are kept in the output.  When
-- 
2.45.2

