Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C8F23393B
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785080363; cv=none; b=hNIsCOk/c61tORFDfqk5YO4C0M/HAjoX8Yhmv3AY6gi2/mVlyYozT0EBhTh0JlLMtwYozAiDlgJfNZKIW4qqY7znnhZ8sGPn7eg2fG2/jg5B4CZ51JfoYxXgkcmovcFStrK6f8UjjtAOlh65pz27rdBxtV5Er9L+NMix2bhhduM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785080363; c=relaxed/simple;
	bh=eNvdXsfSmmFbnv77WxLYfrPZh2SPfoC5SdC+kb59sjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DoZQCxk34xt855gk8O6gs4Og5VvehPmxFhe92hVO0VM7guHW79yK6c3nzkrjINCzghiEu0Psqy2aCKXwjbYw6t6WzcMTsaSKMRGmwWy32uR9q+AzUSSQcan7CyXSrTrFpAYDUyHDKfujVTGXAqnCJJaBy87nh18RboQ+9qduSGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXgqBai0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXgqBai0"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493f75f7172so17057515e9.1
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 08:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785080360; x=1785685160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q1kYEjL1xWNQj+92lfJSByNRrNBexiMxcC+n5zn//Ok=;
        b=WXgqBai0Jk6g2mV8sifvhFfmiKW7U8seO+h5cE1T8hN77BcdlLK4phVu+M1009Mfh8
         S+ohfdiB43AIsnL1vfotOBL39mEc7gKbihAIcAKtSDbmMptKn3pU1CZUpxZJGqoc9Kv/
         f02lALdVREebj5N8xTky3FVE3FcpNer6pDJUk0okzq5Fdab/xKmt7F0eNGae8lWF/I19
         JiHPA8Yoy6sS0VcNli9dYuOgNN0VIC28PFdP9iESAmeNmCJYQnKri+UVeuxqEk/1ttTC
         TPSnKaA+9XbkwvXKTGdw/dS3ciVt33UAX+n/i9Mvx94GrDh4XMly8BeP9fbL0/B9w7JJ
         rc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785080360; x=1785685160;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q1kYEjL1xWNQj+92lfJSByNRrNBexiMxcC+n5zn//Ok=;
        b=Ht5gGA8ZXyn4LFhLVPYKHSYCCtpT6ycQ9z13U0InlFeycVfwZLLOqaXCttiSuKdVEJ
         bklNo2WfAkEXn/dnbepmvULz3Z/ffsMM2MVniufy+q3he3DAmtifnJF2hUdT1bAqwSr6
         hsSWH6V5so202BBMqJ1APHFCM7v14aCjUQXp6a5pNCaPx+ODdfS2MKzZLKroISVqUIKO
         7vhkwV8fSYmQq6us7gPk6yvUpREv0DkJQel2izUKMm2KV1BdqDDyc81uLdkhVmQGRBkL
         MKk4rfBUe8GFmtOIk1bHPSMZqrZC3H7zd6ZY1/e5HbFSyvoXyp2jEZeqiC3tf+8qHqD+
         jRrg==
X-Gm-Message-State: AOJu0YzfcCBG8V80KjdpLiw8b7QO1yWjEIWfQU+iMRKgWfmSPJbNclkt
	/jjM0l9XKHvFuL6qUrHD40zTKp9bWElwDjwJzjkCu3zxSdOdB+/+Xtw+RMb01Q==
X-Gm-Gg: AR+sD10N6nSHj5ZGTStNK0Exuu0h3OHFktpQcPm3IOsuAsu7F5/kbWFOdqzmS9s/kEv
	ECHRfYrDTsjeFU/BdPl9M4l0RqbKg+GP+iuUilp+LGIbEo2ye2q1UhLjOlC9zVQlmpnX1A3+mLQ
	LAZU9ShY3Ti9NygmbiRkAVT2zDEUF5GcSgybRd+Kx4zwBasJI2WGwdWrAF1sUNbAnxZw0Xuansi
	9ELYQ5LKZa+PMCKoHoOHdaI9fhqZJp2aKgKiWAMd1eJJJxQce+aQhiifcFJMYNW1/Bv/v+0g9YB
	KjvC7NN0EarGfVPL+lTjQXX1KiMRmOzn/LGNyHHxf9jdHP5j8ndgctk4+OGUeeVU/tkhDOJOFt2
	uVgNOJlS5twIhHB7usvvcxi56WykDIKrtfrH2BDeRP6ejdfRbI2gaPdImVaul/O4Jc01XAs8ar9
	Ix53wmzw==
X-Received: by 2002:a05:600c:35d0:b0:493:e79e:da63 with SMTP id 5b1f17b1804b1-496b5708bacmr67999985e9.34.1785080360352;
        Sun, 26 Jul 2026 08:39:20 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f2639csm144035805e9.10.2026.07.26.08.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 08:39:19 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 0/2] rebase: a couple of fixup fixes
Date: Sun, 26 Jul 2026 16:38:58 +0100
Message-ID: <cover.1785080337.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1784304378.git.phillip.wood@dunelm.org.uk>
References: <cover.1784304378.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches fix a couple of small bugs in the way skipped "fixup"
and "squash" commands are handled. A skipped command can lead to
an incorrect commit count in the template message which is fixed in
patch 1. It can also mean we fail to open the editor after a "fixup
-c" command which is fixed in patch 2

Thanks for the comments on V1. The only change here is to make sure
a character non-NUL when we're checking if it isn't a LF in patch 1
as suggested by Junio.

base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Frebase-fixup-fixes-part-1%2Fv2
View-Changes-At: https://github.com/phillipwood/git/compare/9a0c4701d...3089979e2
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/rebase-fixup-fixes-part-1/v2


Phillip Wood (2):
  rebase -i: fix counting of fixups after rebase --skip
  rebase: remember fixup -c after skipping fixup/squash

 sequencer.c                     | 31 ++++++++++++++++++----
 t/t3418-rebase-continue.sh      | 36 ++++++++++++++++++++++---
 t/t3437-rebase-fixup-options.sh | 47 +++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 9 deletions(-)

Range-diff against v1:
1:  c37a518486a ! 1:  f95668512a8 rebase -i: fix counting of fixups after rebase --skip
    @@ sequencer.c: static int read_populate_opts(struct replay_opts *opts)
     +				 * inserted blank lines when a fixup
     +				 * was skipped.
     +				 */
    -+				if (p[1] != '\n')
    ++				if (p[1] && p[1] != '\n')
     +					ctx->current_fixup_count++;
      				p++;
      			}
2:  7c8075ff267 = 2:  3089979e2da rebase: remember fixup -c after skipping fixup/squash
-- 
2.54.0.200.gfd8d68259e3

