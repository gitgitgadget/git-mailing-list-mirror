Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC9335E1A8
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789452617; cv=none; b=KMvrx5DUcibjI79Ap5RzsGcA2EY4+90XWFAHOnyimw+s77mw8E5uns2vTB1hk0QZgrcl/mYtxMRTrDlF6MjpgvHKrHwrIzH7jFvi+ZL/JOfBrPKSMF46hh/nll0N4e+YnrQLKhrtbNaEp41WoZLc5giofK+Xc1j6Vl+xvCr+QbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789452617; c=relaxed/simple;
	bh=OtTZDFRuWUPI5XE9NGxWjw6eqyt5JU925pMlKb0e7wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2aOR5NWkZoBujx7pt6FToPjiMWoZXe2suidlckva51nUQw96mLfhRdSN8GLMOeiX3UGMNcxkLVW99lIwxqTSVDKK4KZnkdyxc1e03Tr7QeHvh1Wz6XXuQ2n7mayDhD3im0r+38Oqwsg7AO22TmHnRErsY+1p/0NCgEwu3F8ViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUnxb1Cx; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUnxb1Cx"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ff2313so210482266b.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 23:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789452613; x=1790057413; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y4QrU+O7iWwD/h2D59FZsKeoUayCXgAqa/oL77GJuCY=;
        b=CUnxb1Cx6ZM69jAQeWhNZ7YYppJCSLh2WZl4t0k74yteXIieyiotbk4mxYRjvCe4sb
         mgn7MAt7LEt/sO3msuUDBVGZzY+rXZxnalBV3y7vnU78p3Er8QiERreNDwnNkR09We2S
         gyfpUei2iZ1N1XZhDOZ7B6e+pjET4lQaCEV/yYqoT5jtmsy3jQOErUDZGotXARDQdelJ
         Ohefriv3jo4+wU7xMi1sHFx/5KQPk6vBZ/FLCeC8aHzoYa3T/Y60AhFUOwHa4UMoAGkF
         QQ1LiD/MdvE2aMbpS7zHmRje8uNkp54RABXfYuHfDsCtVXl0uo6jHhHSOXJKBJrTfeQB
         CL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789452613; x=1790057413;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y4QrU+O7iWwD/h2D59FZsKeoUayCXgAqa/oL77GJuCY=;
        b=i21Z2b3QE1T7yD35ATecslm9kHmDBTo6db6kh0TWynDsCX8JX9cYQw3ok+cKXYJ4hT
         hczD/MELVOAz5EPES0TOOMMINPd1NrJMI/uUEbD6Awd5IgRgu1MFznTLFB+P13im32av
         ZDmm2LwMQkRp6UOO96EQYI98R7BUHQlh3CbT81INOP1PeWHAYZyQuDw6Lxj1clsdvNOY
         /J0Qx2/LW2ShLCW4oGQyiorsLhnYVvNt7XmHL92UOmmGeQb76zIQVRXInghAHR0EKNPE
         4WSJvoLlwrIwzIgli+GJCHDveKywbxg5Eb+mW2C3xmkKm1rqUawlFqEMHkYUVpkd1ncO
         1ePg==
X-Gm-Message-State: AFuF++ldotJ4B5FcUvtvAEyPvMmAhHCT1ElZytd3u4rgDyFMbF4swjis
	0/OcB4JqDMiN1LhSp69H9sZ7bpFDYZ2MrkJbgwd6gA+oIeNjDy2A6kNqTnkLWA==
X-Gm-Gg: AYBFou2I2gagsPv3JmD6CRaSeZ/z4PT8nEY9tKdG8Y6o4Uv8dLGV8y3KI3T8Tkftl1s
	+2dy9aNNDyDrbBFlH5ffXM66kkeBThZaEyiCzeYqV1K0tYXMVpMBMxdlDsnhnjHe258Canu0eh9
	KiVjgFiTz3F/I6H40V+dOrtB9VwmEAH94QWOphFkTwy5GRMcTiqL6bughX7fgbkUZ1MAdcYqLmk
	Bk4rV4mlUMJ8fBpQPtIzCVWljjknn/1/06NnULbVReOHv+myxiCcY+jp8J8BGAWaBQIsYn8P+fs
	KL1BVjkdpHrmaoZluwU/Ovx6KSCC6YRH1+pZOnRpy5dlkOUDb2Ib/u1tl38M0JUMGd2ewBR5lLk
	n7GCONWXc85AbuaWe+KcemqF+1G6DBA1Pi/fSgoAoxNmKpgI9HFYznnZQgGYWlE5i4D0CmMNPfM
	NEqUBZ7w4UeIKnAk+TyboeXMUXOs7n6kNd8o1ww2NwfmBhLLf8lODliucqpD7d8/jsD3N0LB5MD
	hmekx6DjDtwMEQB2tN/Q7NwzM5i
X-Received: by 2002:a17:906:6a06:b0:c25:35cd:fdb2 with SMTP id a640c23a62f3a-c29c8973785mr157602966b.7.1789452613278;
        Mon, 14 Sep 2026 23:10:13 -0700 (PDT)
Received: from localhost (78-131-17-112.pool.digikabel.hu. [78.131.17.112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29660234e7sm516215166b.15.2026.09.14.23.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 23:10:12 -0700 (PDT)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/4] make: precompile "git-compat-util.h"
Date: Tue, 15 Sep 2026 08:09:48 +0200
Message-ID: <20260915060952.569535-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.56.0.rc0.467.ge054dd0dd6
In-Reply-To: <20260909195006.2179119-1-szeder.dev@gmail.com>
References: <20260909195006.2179119-1-szeder.dev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update our Makefile to make use of the recently introduced precompiled
header to make builds faster (on my setup by about 35%).

Changes since v1:
  - Update the commit message of patch 3/4 per Junio's suggestion.


SZEDER Gábor (4):
  Makefile: remove XDIFF_OBJS initialization
  cmake: remove any "$(*_OBJS)" variables when parsing Makefile for
    sources
  Makefile: reintroduce REFTABLE_OBJS
  Makefile: precompile "git-compat-util.h"

 .gitignore                          |  1 +
 Makefile                            | 59 +++++++++++++++++++----------
 contrib/buildsystems/CMakeLists.txt |  6 ++-
 3 files changed, 45 insertions(+), 21 deletions(-)

Range-diff against v1:
1:  d52a1476d1 = 1:  d52a1476d1 Makefile: remove XDIFF_OBJS initialization
2:  5d60181efd = 2:  5d60181efd cmake: remove any "$(*_OBJS)" variables when parsing Makefile for sources
3:  0296c6cffc ! 3:  cfc77c0b2c Makefile: reintroduce REFTABLE_OBJS
    @@ Metadata
      ## Commit message ##
         Makefile: reintroduce REFTABLE_OBJS
     
    -    Object files under "reftable/" used to be listed in the REFTABLE_OBJS
    -    Makefile variable so we could build a static library from them.  This
    -    static library was removed in f3b4c89d59 (make: delete REFTABLE_LIB,
    -    add reftable to LIB_OBJS, 2025-10-02), along with filling
    -    REFTALBE_OBJS with object files.
    +    In the next commit we are about to precompile "git-compat-util.h" with
    +    "make" to reduce build times.  But using the precompiled header should
    +    not change what actually gets compiled, therefore a source file can
    +    only be compiled using the precompiled header if the first included
    +    header file is "git-compat-util.h".
     
    -    However, the reftable source files are kind of special, because the
    -    reftable implementation is supposed to be easily includable in other
    -    projects.  Therefore, the reftable source files don't include
    +    The reftable source files are kind of special, because the reftable
    +    implementation is supposed to be easily includable in other projects.
    +    Therefore, the reftable source files don't include
         "git-compat-util.h", with the sole exception of the purposefully
         project-specific "reftable/system.c".  Consequently, they shouldn't be
    -    compiled with our precompiled header, as it does include
    -    "git-compat-util.h".
    +    compiled with our precompiled header.
    +
    +    List object files under "reftable" in the REFTABLE_OBJS Makefile
    +    variable, so in the next commit we'll be able to easily filter them
    +    out and keep building them the old way, without the precompiled
    +    header.
     
    -    Resurrect listing object files under "reftable/" in REFTABLE_OBJS (but
    -    not the static library), so in the next commit we'll be able to easily
    -    filter them out and keep building them the old way, without the
    -    precompiled header.
    +    Note that object files under "reftable/" used to be listed in
    +    REFTABLE_OBJS so we could build a static library from them.  This
    +    static library was removed in f3b4c89d59 (make: delete REFTABLE_LIB,
    +    add reftable to LIB_OBJS, 2025-10-02), along with filling
    +    REFTALBE_OBJS with object files.  This change essentially reverts the
    +    removal of REFTABLE_OBJS, but not the building of that static library.
     
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
4:  ce9fd91413 = 4:  a933be0664 Makefile: precompile "git-compat-util.h"
-- 
2.56.0.rc0.467.ge054dd0dd6

