Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D254022D4F4
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622286; cv=none; b=qrl0dik47UxoHZLsqt3SNM9j+Zw439bex8R3bEZEAaIFuGAM8CT9s1QXYrMOmHic9nN1PdbJ8O3c22MKrvVdOD37c1P2JCIYqE8a9NEj/+XehVQB7Ep+h727Ax/y6tDcAcOYoHupHhby7EVWG9hIr0KV5G4Aywj89zhIRLKydK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622286; c=relaxed/simple;
	bh=GqCMCAxT5wPNNVcAbqLWciAGguPUf0rM22udvjDLXaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+AARDTuiEfQNbVuxxDpWH1m09ptpfqu7b8c1BsqYox8wHZDrus3cgQyFwUGmyJVaE9AjwqypwyCm9NQpRe2Gr/oqZxZ3ZI6Xw3V4b7+UVIPD79w909eEgKXDGQL9L4Xg3GRmdIU0zkz6YudsOo1peX6D33DmC0DOVP4FyfI8+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C21QwI5G; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C21QwI5G"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3911748893aso2763143f8f.3
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 08:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741622282; x=1742227082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3WsJyapCWU6o9GGKdn5za47YWfJBl0N2fexXw6vSKg=;
        b=C21QwI5GCc3psGrEk9W+DiJckz/P9pvKC48+t7qFHVjvh3BFqVhoDqzJzqHo9x0I62
         mJJWPIQ4tZ0m70RvpXRaBiMbgNhuBWXz8KuptIiattK4VW3pZbkcg9V+NPxovFJP4z0m
         W6EEcEs46EYn5dFm1S4csT0+nz/t5zAl92uxfDZWum2d0CPTcv7gOMBEmNu+REqI4ssS
         82TzPsGMuMKozlODahedEaHK95t2krDeIychMfahZcycgtDsIxj4NWdaEn0awXFQUyRp
         8Tk4pwUUBxPPiNVwpq20oaIVX4++TxGHQCW2+jegxI2mmAB9B/Exj+FBqAsjrAKBa7Ou
         MGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741622282; x=1742227082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3WsJyapCWU6o9GGKdn5za47YWfJBl0N2fexXw6vSKg=;
        b=ZEqV1o7yl5U9aT8z1xn8nMqePbldiU+3laziIbrMCh3v86AMhJDgRaGLQT8B7/esGQ
         a+pc6+uy6og/ewWWzBf8ry4H5vhsvNWKadk9L7f3WyXlgLdQ0eaf9flDCWJGocZcJkuj
         3G9zJDfYbKWoFCLUrLj7iRfHR/02jix5DgvbBtoB4zxcvQYa/3jvFFNuwbNhnFc9L+mS
         /hQk3SslKMlu+cOFu+LEfphabpAEkUHmlurDkzDbM5YFuwbfu3onluWBk0B2ljmrV1k8
         T6JkT1n6lJ1qv5x5EOfl9v80CH6Q2gIrOgm14EWKD4H3x286qG4W9zKhJP/FxEDawXJi
         GtYw==
X-Gm-Message-State: AOJu0YxCTkpb3xRg+gMcLKHbKWUf1fWeHdGDyrC6fIyUXeYg2mhaiVLC
	MjRsIowRi+92NQXS4zVpxzrt5k1/W2iG6vQbgiD9R0up6SBXep0h1MbRMQ==
X-Gm-Gg: ASbGncsq+mMlqa+y4iJs9ypstrOr0PqscQxyBPxAywveI+cfnIwyUJRwBS2LuCNif5J
	2W8DMyZ3SXj6Jlc1KQH6aAugiisgvNXyXAapE9ne7osH1/w3hjzxlnyIRhrz1GuujSd3s+3TOSt
	OPBBB0MlVAT2TmCEq1KkFzFGvJRRaysgLEI9PzlM3CJjIGR3SSC32mcRQHbAeZ5Kv8LVrG2sLq1
	DWKk2OcfDs5Frv5CZoI0YfvhRHo8enEJfeNiON+ftiLcWBjf5m3hDljqCwQC3LcJZpkXUGSygYN
	U52gRY73FdZLgUf9bMeQGJsN7/fxRv+oHZJE9TkuAPTFKscuKOezIiiaaQGEzbfhYLlawliuPCA
	gJcZhY+sHGdA4qhjxRkmdiabygBQ=
X-Google-Smtp-Source: AGHT+IFdAJU9S99d46eIu20XgxAWBruzcvublhIbYddIqirsiOPVlVChNRibrsYpLgGYb5CxG4VLQQ==
X-Received: by 2002:a5d:6d8c:0:b0:391:ab2:9e71 with SMTP id ffacd0b85a97d-39132d8b608mr8762658f8f.20.1741622282085;
        Mon, 10 Mar 2025 08:58:02 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e4065sm15551831f8f.62.2025.03.10.08.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:58:01 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Luke Shumaker <lukeshu@lukeshu.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 0/6] fast-export, fast-import: add support for signed-commits
Date: Mon, 10 Mar 2025 16:57:40 +0100
Message-ID: <20250310155746.879481-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.89.g148d1db992
In-Reply-To: <20250224142744.279643-1-christian.couder@gmail.com>
References: <20250224142744.279643-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Luke Shumaker sent the first 4 versions of this series in April 2021,
but it looks like he stopped before it got merged. Let's finish
polishing it.

Goal of this series
~~~~~~~~~~~~~~~~~~~

fast-export has an existing --signed-tags= option that controls how to
handle tag signatures.  However, there is no equivalent for commit
signatures; it just silently strips the signature out of the commit
(analogously to --signed-tags=strip).

So implement a --signed-commits= flag in fast-export, and implement
the receiving side of it in fast-import.

Big picture goal
~~~~~~~~~~~~~~~~

Independent from these --signed-tags/--signed-commits options
addressed in this series, we want to have an option, that allows the
person who performed the import to attest to the result by adding
their own signature on tags and commits, whether these tags and
commits were originally signed or not.

This series lays the groundwork for that future option by upstreaming
the earlier effort started by Luke Shumaker and stops there. Future
follow-up work will build on it towards the big picture goal.

Overview of the changes since v5
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There is no real code change since v5, only a commit message, the
documentation and some code comments are improved.

Details of the changes since v5
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - Rebased on top of current 'master' branch at a36e024e98 (Merge
    branch 'js/win-2.49-build-fixes', 2025-03-06). This is to get a
    base as close as possible to v2.49.0 final.

  - In patch 4/6 the commit message subject started with
    "git-fast-export.txt:" instead of "git-fast-export.adoc" which has
    been fixed.

  - In patch 4/6 the documentation for `--signed-tags` in
    "Documentation/git-fast-export.adoc" is improved to better explain
    when it makes sense to use 'verbatim' and 'warn-verbatim', thanks
    to Elijah.

  - In patch 6/6 the documentation for `--signed-commits` in
    "Documentation/git-fast-export.adoc" now spells out that its
    default is 'abort', thanks to Elijah.

  - In patch 6/6 a code comment in front of
    find_commit_multiline_header() in "builtin/fast-export.c" has been
    improved:

      - a "rathar" vs "rather" typo has been fixed, thanks to Elijah,

      - what should be done to the memory returned by the function has
        been corrected, thanks to Phillip Wood.

CI tests
~~~~~~~~

All the CI tests passed, except perhaps the osx-gcc one which isn't
finished yet, see:

https://github.com/chriscool/git/actions/runs/13767984505

Range diff compared to version 5
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1:  f97247e17d = 1:  395dc9b1d9 git-fast-import.adoc: add missing LF in the BNF
2:  b71588563d = 2:  6265fd51aa fast-export: fix missing whitespace after switch
3:  947bc267e6 = 3:  9e290bab22 fast-export: rename --signed-tags='warn' to 'warn-verbatim'
4:  45087db345 ! 4:  923885134f git-fast-export.txt: clarify why 'verbatim' may not be a good idea
    @@ Metadata
     Author: Luke Shumaker <lukeshu@datawire.io>
     
      ## Commit message ##
    -    git-fast-export.txt: clarify why 'verbatim' may not be a good idea
    +    git-fast-export.adoc: clarify why 'verbatim' may not be a good idea
     
         Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    @@ Documentation/git-fast-export.adoc: OPTIONS
      exported and with 'warn-verbatim' (or 'warn', a deprecated synonym),
     -they will be exported, but you will see a warning.
     +they will be exported, but you will see a warning.  'verbatim' and
    -+'warn-verbatim' should only be used if you know that no
    -+transformation affecting tags will be performed, or if you do not
    -+care that the resulting tag will have an invalid signature.
    ++'warn-verbatim' should only be used if you know that no transformation
    ++affecting tags or any commit in their history will be performed by you
    ++or by fast-export or fast-import, or if you do not care that the
    ++resulting tag will have an invalid signature.
      
      --tag-of-filtered-object=(abort|drop|rewrite)::
      	Specify how to handle tags whose tagged object is filtered out.
5:  20f085a790 = 5:  49f73ee6ef fast-export: do not modify memory from get_commit_buffer
6:  48e0d4203c ! 6:  542c692e67 fast-export, fast-import: add support for signed-commits
    @@ Commit message
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## Documentation/git-fast-export.adoc ##
    -@@ Documentation/git-fast-export.adoc: they will be exported, but you will see a warning.  'verbatim' and
    - transformation affecting tags will be performed, or if you do not
    - care that the resulting tag will have an invalid signature.
    +@@ Documentation/git-fast-export.adoc: affecting tags or any commit in their history will be performed by you
    + or by fast-export or fast-import, or if you do not care that the
    + resulting tag will have an invalid signature.
      
     +--signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)::
     +	Specify how to handle signed commits.  Behaves exactly as
    -+	'--signed-tags', but for commits.
    ++	'--signed-tags', but for commits.  Default is 'abort'.
     ++
     +Earlier versions this command that did not have '--signed-commits'
     +behaved as if '--signed-commits=strip'.  As an escape hatch for users
    @@ builtin/fast-export.c: static void anonymize_ident_line(const char **beg, const
      
     +/*
     + * find_commit_multiline_header is similar to find_commit_header,
    -+ * except that it handles multi-line headers, rathar than simply
    ++ * except that it handles multi-line headers, rather than simply
     + * returning the first line of the header.
     + *
     + * The returned string has had the ' ' line continuation markers
    -+ * removed, and points to statically allocated memory (not to memory
    -+ * within 'msg'), so it is only valid until the next call to
    -+ * find_commit_multiline_header.
    ++ * removed, and points to allocated memory that must be free()d (not
    ++ * to memory within 'msg').
     + *
     + * If the header is found, then *end is set to point at the '\n' in
     + * msg that immediately follows the header value.


Christian Couder (1):
  fast-export: fix missing whitespace after switch

Luke Shumaker (5):
  git-fast-import.adoc: add missing LF in the BNF
  fast-export: rename --signed-tags='warn' to 'warn-verbatim'
  git-fast-export.adoc: clarify why 'verbatim' may not be a good idea
  fast-export: do not modify memory from get_commit_buffer
  fast-export, fast-import: add support for signed-commits

 Documentation/git-fast-export.adoc |  26 +++-
 Documentation/git-fast-import.adoc |  20 ++-
 builtin/fast-export.c              | 188 +++++++++++++++++++++--------
 builtin/fast-import.c              |  23 ++++
 t/t9350-fast-export.sh             | 116 ++++++++++++++++++
 5 files changed, 317 insertions(+), 56 deletions(-)

-- 
2.49.0.rc1.89.g148d1db992

