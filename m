Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006EF3E1201
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146224; cv=none; b=a+eu3kXzyLXQK9TPjMMQDpCDHyjNAMfHW5cGPGJTZp5mE7mah0IRUXWMhCMOiwwlbA6dLVZsOM7K6IgbQdJ2Flv87Lj/c4Av73YSTZQrrEiNkZMItOwoVmdgNC0HO0EC23t79D/mfhtcc2o6HfkiUk9W0OoMAiCOhuWUizlGqlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146224; c=relaxed/simple;
	bh=9D0ql/B8iae7AEhUjhJEtfF/A4dEgO4GjFnmfZ72Czc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0xDpfrkB8qaP8mzJ5X6eNicruAv0diL0XQi1+aRWNz9XpjfdViQHVYPGtQe0iRaTEdRtSTeQJQuUlVCuzie4OzqlBsSv+YDhqmBOf6Ey0RglCrkl2IlWBoRcbju4q1K/AHA3tiJRk7jlPzLdUddeUHyZL2NG6Ff5DKjeWFl/qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+lEYCUm; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+lEYCUm"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbb973e6749so2848834a12.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2026 02:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785146222; x=1785751022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2W0zygcCtlszEg5crsQkDu7cfbF51GVSJfKXWDD9OnU=;
        b=b+lEYCUmEdpdF57mdbcX8xN7i2GIuJxlvYpsjjf6xjoKZhhkWLWxhxlruueCoHYBZK
         FVBWNUidun4/rN8EGyIra6Jy+qKp4BpxAnGfPkSvtL445nwV3l9SIoG7De5XY7ofd1h2
         28gAxftSBvhxqQZcbAFOTZsq/pThWw4qF3Px63D7/3dEgSKwFcsQDX66lcaRjWToWMRK
         js9gM19BXnvQXMgA+x3Wff1VNZYir3FyguX34oSkKEgrmj/kX9Tus2Dspewnjdg9aa7V
         jzxtg2V2TEDHOzdTc9Z4GMGO1RahGYOCENUBI7FFFgk0tK8W6AiCOHduCE5xpyg3chH3
         57/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785146222; x=1785751022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2W0zygcCtlszEg5crsQkDu7cfbF51GVSJfKXWDD9OnU=;
        b=Y47+lkAJg4Rg0K9HdYtwWKtr5FAV8RExcg9+VFg4OJgKwOmN03OAr5GCx3loZc7crO
         mDK1TO3ipEB1GiGJBlbbAkK5+dYk04+Rwt0AiJ4f55T99n9MfcIVDkU1eFmJ6qf4DPK5
         0VUjKKRH7MKND/PsGWxvVskG6j2D4TQnfcSxoNruuuQsB73dWra2AMMg0OvpuRI6HSMF
         VlfjW53+Szi6i6HHtyqJC3wNNwM2FWTQW3TlhCTbcxrle4j9YoxGlZXIQM38pUPbg7yg
         wG2BT+YaoqeZg3p286FICadeDTCp7eZMdAF+pWuP7a+p8GtXrS5SvmWfSlBS3ipd5YX4
         xh9g==
X-Gm-Message-State: AOJu0Yz8ZohzsWJv28hyjhOknf9p608lwfeKZ9LxrisqJeaKLb++ym4D
	Tj7CdM5O8EJp4/wr8lv9lQ1aMKd+XPq54d+gFjLzs1sirVA4HHnKtADcfQsawA==
X-Gm-Gg: AR+sD12nmVyj45yMJzFI+Ze7l4gqWp2FRFRdW4kUxxD04eIpDb7WpJnCCT09uJU8RlW
	25hFfC8YJEZSfIZ1XgSx0RtjWWUEi3+1axnc8LPYxKlWq05oaBGFW76ErYnuvkP8DYHccgGwe73
	95Vigng+9KMtNU1Yo+CXXlmIixYPntE6/hOWXvERwnjQR/fGrlMEI/8tBYb3bhehAEULULxHzxh
	BtxlAMmNFYEHf51X3rOX/hxZwK3sYk6oFZt3SXB3sq1wljc4utj3tW3pcDVD1z6xEWkT1fzwInV
	gysVOlYmZJm48YnPQvrrTpw2dxdyZvo9c8yH080gcQh5psnwHkR1BMXMyiK9TPT1VFqw7qbBaoq
	cQM2x6AVL4SPQ9vor9a7y6Z87m0vc2DV2DLeP+SB2kU485nYKNvUe5CMMBbaMNeu0pAB1f+SrMJ
	r0zYv0+efB0IWwAHnY0gXy1o6PqFQ=
X-Received: by 2002:a05:6a20:939a:b0:3c3:724d:ae7a with SMTP id adf61e73a8af0-3c67d9b4663mr7436714637.9.1785146222208;
        Mon, 27 Jul 2026 02:57:02 -0700 (PDT)
Received: from localhost.localdomain ([14.141.116.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e127asm49203193eec.2.2026.07.27.02.57.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 02:57:01 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Shlok Kulshreshtha <diy2903@gmail.com>
Subject: [PATCH v2 0/2] t: add and use a commit_body test helper
Date: Mon, 27 Jul 2026 15:26:54 +0530
Message-ID: <20260727095656.75496-1-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqldawq24y.fsf@gitster.g>
References: <20260726224803.45131-1-diy2903@gmail.com> <xmqqldawq24y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio pointed out that t7509-commit-authorship.sh defines its own local
message_body() helper that wraps the same "git cat-file commit | sed"
idiom commit_body was introduced to replace, which the first version of
this series missed. Rechecking the whole idiom by its sed
address, rather than by grepping for "cat-file", turned up one more
inline occurrence with a spacing/escaping variant in
t3404-rebase-interactive.sh that also didn't match the four spellings
enumerated in v1.

Changes since v1:

  2/2: fold in t7509's message_body helper (drop it, convert its six
       call sites to commit_body) and the missed inline site in t3404.
       Site count is now 61 in 12 files, plus the removed helper.

Shlok Kulshreshtha (2):
  test-lib-functions: add commit_body helper
  t: use commit_body to extract commit message bodies

 t/README                                  | 11 ++++
 t/t3404-rebase-interactive.sh             |  2 +-
 t/t3405-rebase-malformed.sh               |  8 +--
 t/t3408-rebase-multi-line.sh              |  4 +-
 t/t3434-rebase-i18n.sh                    |  3 +-
 t/t3900-i18n-commit.sh                    |  4 +-
 t/t4150-am.sh                             |  8 +--
 t/t7500-commit-template-squash-signoff.sh |  4 +-
 t/t7501-commit-basic-functionality.sh     | 21 +++----
 t/t7502-commit-porcelain.sh               | 77 ++++++++---------------
 t/t7509-commit-authorship.sh              | 23 +++----
 t/t7600-merge.sh                          | 14 ++---
 t/t7604-merge-custom-message.sh           | 18 ++----
 t/t7614-merge-signoff.sh                  |  9 +--
 t/test-lib-functions.sh                   |  8 +++
 15 files changed, 91 insertions(+), 123 deletions(-)

-- 
2.52.0

