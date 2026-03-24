Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE69E37CD2C
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 01:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774317536; cv=none; b=iaaUhd4qwcJLWyGYdfaPH+oM4ZgoRnI5pxTD2HKwqAtBK5sV+9s/nvyEhNN1wCMmPznfNvgRZpS8V9Ifn4O2XvLwefoCUinOFOn840crzuLInn7p1cX1bhhwZyp44bqQUO5IBjRWTzjrEg8jeXVIWQ/zTghDsxwieFDP6wnw98o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774317536; c=relaxed/simple;
	bh=/d3xElgjndEiLu6Jnq3HAjrDbn47M4lqua4MVEK3SjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnVhSKRcriVqsx0IQZiRZQUEOsU3eGR3OocehStWMOK09h97NMIrgCAcg3VSoxEPThWyWoXj21TmGeKrZIuP+i7F/46ev6DL/fXSRQgszA+K0OT3myvRmdtVUZ8vfamMRv0rmr13BZrO1VYMCZZ9xzdVRYs4e2oE5n3VCfQyH40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2Hiars8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2Hiars8"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-829ac4670c4so3639867b3a.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 18:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774317534; x=1774922334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nxJQPXt8I+7FAXEq8ZLinddRaEEWHbFTE9GSQIRwMg=;
        b=A2Hiars8oQGYgCq2Bc0kkkzDpib2P0Ef44Cxto8ySw2mS3EjWy2+g7OA2Majj1v/rr
         CrY58ogT3AVxir1Ex7LaVDDqAgyAzBG1yzSFDUZmjyIL7J1sXGK7B+Nj/Q3np3dwR8ly
         G4/6dGR/X/GF7sUJR/eGYw/jqD3KoDbvdMkqxTOddLtSJYfqGkahhXoKuGf5Wrb1H47J
         m0/2va0Kso6WWLAhgWf/Y9WgcLyQGtPzajLNUecXEYCdzSzRSk25sC+3nh+ZT6lgIdHm
         7SLnaCcw7TWxEWulBCsbkjlepdV0uoGbmIl7H01lQdLs9Np20BAhZAqgs6rza601Uwfy
         +yMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774317534; x=1774922334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5nxJQPXt8I+7FAXEq8ZLinddRaEEWHbFTE9GSQIRwMg=;
        b=hlq+3bi9LzfxM2hjZ+LQRtK/PPIFPlqkP7PLDoGLRCbw/deIsEol7UimVrPiI+2FH1
         +pWNGG58MYVEY5q6L2Vm/lF23KHmGh8ghHcOFUenf/aa+YHZXbzZhSIa4+Nqo7vGkszK
         GhsKHi51DbrZISRtDNkX83U2oJdzNqu6LmhKgV4hW1eDsIeov8rpKtkp1BjSQobA9zFO
         nemB889+6GOnWIbcgwZ7oTul+6JEQBIEjAp0O8NO2wFKM0KNafBg5o4EZ5RHR1cBLHQk
         5eXdq3D9nfZs9WvR2z+OjnTuWGG65L8X8avmPr6intl+r4jJab59oASzgTw4otuGe0dg
         0MaA==
X-Gm-Message-State: AOJu0YxWmpwng3cqeudp32DRBPnWhPuklID1be5euXqE6WHaaJI7qim2
	j5jRO5AWlvHEVKohRW6JlSJNXvfJzJVAlMG/74eQA8qL0aCdatNYWP1j
X-Gm-Gg: ATEYQzxUpskETCFHFeixkNBuvyDAkVSB66ZNpx215USA8B9TU6kgQ0Y3nlhUY93ZjVd
	BkJsAGp7wrI2rLYdMOsGOKhvOwY+rUNyPnDvnalA3WFp/X8YcejmVGyqNJTt/LvAeTULRp984G/
	TFq6HMJD/crRUltPACDAm1jnXfNwq6jcvdxOXrFxBUmxO5Yl3pcPH7QOrAfsbbK1UJhMeK7UwGu
	g6G3YMnDg+NmPttX+c3EasxRW7c5l/ji2/pfNoAgPLka2qShd9/ulVRwIqaAVAb5QDbLo/nAPZu
	odpfzI+fPxAdizUz30t+8y0TaMAW8dSbXzFTpJG7bFc+viElhRBTkdqwSAihunwaAZKH7k2okr9
	NJ08a3zknXPwJP64eMtKAviP5HZ26LpIgAhjEKmS8p9M89/JlQqEiIIEgmaQ6MTzZvyS0dajm29
	szNcBVV6zSzKMep8cSK4Nf3OnKKZDDoiC+dfHq/CAfb9gfUMuMaDaQ2hiQx5o1Ct/GEtO1Fq0Z+
	YcjyLFig8xlihJsH37HC2BpTr8L8nevxg==
X-Received: by 2002:a05:6a00:71c3:b0:82c:2468:9c74 with SMTP id d2e1a72fcca58-82c2468a018mr8250317b3a.53.1774317534106;
        Mon, 23 Mar 2026 18:58:54 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c6besm12467623b3a.32.2026.03.23.18.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 18:58:53 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	joliss42@gmail.com,
	joliss@gmail.com,
	peff@peff.net
Subject: [PATCH v4 2/2] refspec: fix typo in comment
Date: Tue, 24 Mar 2026 07:27:34 +0530
Message-ID: <20260324015734.18470-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324015734.18470-1-jayatheerthkulkarni2005@gmail.com>
References: <20260322023557.15907-1-jayatheerthkulkarni2005@gmail.com>
 <20260324015734.18470-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a long-standing typo in a comment: "refpsecs" -> "refspecs".

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 refspec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refspec.c b/refspec.c
index 0775358d96..fb89bce1db 100644
--- a/refspec.c
+++ b/refspec.c
@@ -85,7 +85,7 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 		if (!*item->src)
 			return 0; /* negative refspecs must not be empty */
 		else if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
-			return 0; /* negative refpsecs cannot be exact sha1 */
+			return 0; /* negative refspecs cannot be exact sha1 */
 		else if (!check_refname_format(item->src, flags))
 			; /* valid looking ref is ok */
 		else
-- 
2.53.0

