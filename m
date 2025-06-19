Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA485229B29
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338500; cv=none; b=E9xUurNWJtwGjj3brwkoxr7FF9/QaPppaH5E9NiFQEbmntnl4FvD4gimSHkVypiEWdlwQenwfiWnrSAea39OIP3TjO6Mt0AQygzIu1JCODW/Tc831BP5qxmk6SEcw082QcVafVSf0QQaV64kdn82WrVsNbAc4OG460Vtw+CdFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338500; c=relaxed/simple;
	bh=9rHMd9JbGn6Mz/lB5igsdsjKvYlLV5fUeZ4K7XMXuxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+qIJclqvgJH11xpPtPSSV/MewZiSr27eJrfUo3bwN0f6MiHOegwOkSsnWsVqYwNZM1Czhqf0vm9dlxxBa5/CPPjkOz1WpJr5FoLnhuPHEAmwfs08IsVBoLHVAeIIViNYtFBjAxRQzZM/uSHLEGLIZOTZrJf3So0iRYV87Wynkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hi2k9qHK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hi2k9qHK"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-747fba9f962so562821b3a.0
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 06:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750338497; x=1750943297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vE7REZDISsxbk7tZGCZHRfAr1O+qkf07QEunpb3TcLw=;
        b=hi2k9qHKBtCIezKPR3M/z1rnQBoAzAwT2jNZ2IjVeHjOzcUmQQ/58xd54q98/yQO/4
         3D2F9k3jq/ljeFlIlNDqDccjaFNYPb1LjPb2bPD4h1Mt2WUbdXhvDdXzKt96PME5lrl6
         Euwv3x9mLjXPEwlKd9K37psgoDzqxhZjXO1bZO4Ae9h/bOabZ1N/tQEO28mXEn6CPOzA
         zP2YSROvwbIe1HrB1UCoTVKTHrV93okCrEtt5zrK1eeeg4w0Y4odcQRY0tkHLZU/BAsV
         +JV2RBigqvGCbp9uszcksG96M3/S3lqyBtJ0ho8+w53W2ee8LbEPOmP+P8qwnTBm4Nzl
         kC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750338497; x=1750943297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vE7REZDISsxbk7tZGCZHRfAr1O+qkf07QEunpb3TcLw=;
        b=HdbykSZpBC4QHQV8T9SOWKsV+PCLVcTy6sMsByzY1uJRHlTWszzZRlMTXFmDoFo2sF
         lAcW8PnkTJ4ejwnohiW3Nf3zxpY3YlDeh61EYEYdWpoU6gBgxhVhgT2g6k3phXeCwlME
         6ekbQf/7BUuUVYqlHRJ8rqvDlWWl9Sx0sV6zv+Ix+9zEP1tlom14fzZ2iX1lq+bVVk89
         0DgLfRNDJvfFhGFDLfsRjPLi6RDNt2FfU13mXfqMkZ+yaNBpaJHIBLrtSRhrbPeFZmPn
         FuGjnwVE2p493X8laqywXGbBWB3nfggc6KuzMahySQvbFVYl7vg08o0iiETjtisfLeOO
         btSA==
X-Gm-Message-State: AOJu0Yy8tI40KrLgPv2EdvgFW1HR3Xg+NhR6OjqItREKkNEviPqDKDux
	FdAptp/sLCwlpOVLDnpgqW1NtabvtV9DeslkY/oPhdU91pqyBTeE622sfGnJsg==
X-Gm-Gg: ASbGncuHfo6jQJkRMm7F6x88hl0eqUOZPR81AGE2/OQP03vycIOnLkmIU+v1zxCCB2f
	HkvbeDS/CSGTsFnqVbiPaFznROAyTWEdbis2mUC6nwxjdCdTahYBu+5W46XGzf3Zw40fC9bV5Jg
	tm9MSGppylK3H1uHmFv5bE8PrM+ImqIU2y5FIBe1m0TEZqXqGCvwC5Gp8tMUwBkOqZlOH0FtjwS
	6hiJAIfa1unSA6haqpJq+PCISQhElNYAEM0LZVy0ynAZDwJDT74WL6Fc0JBzmiRP6fLBLGmw8cC
	E9QiHpgVj6qH6vfSbAedSPXtByDLiIWqKLg+V7cc5RR2LKQDFHtg80AbjfAqIhBKH/rIjmiQk2N
	7PWbsDVrtWoLuMw4=
X-Google-Smtp-Source: AGHT+IH/XI23ETfevjpMysXjCnHxgRpoZBOVCcQtiuYGXLBuqVpmSQcgnru/mNDZRhtQEtetrq5NYw==
X-Received: by 2002:a05:6a00:3e28:b0:736:b400:b58f with SMTP id d2e1a72fcca58-748f746bf12mr5059487b3a.0.1750338497558;
        Thu, 19 Jun 2025 06:08:17 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:6060:cc4e:bcf:f4d2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffec9c6sm13138364b3a.9.2025.06.19.06.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 06:08:16 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
	gitster@pobox.com,
	newren@gmail.com,
	peff@peff.net,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH] fixup! repack: exclude cruft pack(s) from the MIDX where possible
Date: Thu, 19 Jun 2025 06:08:07 -0700
Message-ID: <20250619130807.48057-1-carenas@gmail.com>
X-Mailer: git-send-email 2.50.0.53.g63c9ac04f7
In-Reply-To: <52a069ef48f5a573c58a369b69827a40c7712247.1748473890.git.me@ttaylorr.com>
References: <52a069ef48f5a573c58a369b69827a40c7712247.1748473890.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In a previous commit, `grep -o` was introduced as part of t7704.

POSIX doesn't have that flag as defined and while it is a popular
one is not available at least in the latest release of AIX.

Use a sed equivalent that ought to be more portable.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t7704-repack-cruft.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 2b0a55f8fd..3df6b53cd3 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -795,7 +795,7 @@ test_expect_success 'repack --write-midx includes cruft when necessary' '
 
 		test_path_is_file $(ls $packdir/pack-*.mtimes) &&
 		ls $packdir/pack-*.idx | sort >packs.all &&
-		grep -o "pack-.*\.idx$" packs.all >in &&
+		sed -n "s/.*\(pack-.*\.idx\)$/\1/p" packs.all >in &&
 
 		git multi-pack-index write --stdin-packs --bitmap <in &&
 
-- 
2.50.0.53.g63c9ac04f7

