Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66EB10785
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783456673; cv=none; b=ALrlC156L18GLjo6yLIVBkThkFPz2oRewbxbYFmymwInA36tHx/vkVJMzYDTDvSvEZxxXlJ+1E7YixA3m/CQjFLkaqY5cFQqhs83I6kAbqsTXh/GRWZK3RDXLRkaWYpIflPsVl5dEN91c2rhchfjMgXNXVJADNAhtzLViDPTV8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783456673; c=relaxed/simple;
	bh=4J3wk4dKxXbebYEkKMEaBdyei3ajef5yIgeIO4CLF+g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LdF5xmaSQDeXeba4FoW88WaEby2FQdYtaU+O3xF35hYB2QzKIYE3ltlfYLIiYzw2IT8DE8Q5ZfB7B2ar+NBR/MXwRS+mEWcPxQGKSAiV5g/03+jXFg8Bdnj0kQpj03SJyp2aK61+YEloK4YWSA3c9nQJUpyta/EOePgWFdJX3yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--snatu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RHMA6DWi; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--snatu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHMA6DWi"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37e5ef8299fso4836420a91.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 13:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783456671; x=1784061471; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b4Z67xtGA/93fMWQS/z9IKMWKMw7McsFrAT2Fc9Z3P0=;
        b=RHMA6DWi/IqNMWaaZamnDD3I7OZdoPGMyP8eciOYSqU4m70S6u83g2Jpe/MExq1t4y
         0dw8qBzW2Fx5mdzQPgAsguWjdXgG/BVAy/bvkP3nbx3qE/+9om8Ze9lkYhrFLgv358wn
         HXgdvp/Q9aHekCqh/jb0w7B/rXbtDueH3JsArSXvTRSGnrJg56dWOd3WdiamzJ7mOJUY
         ezp9s/S5vVbWibpZidLpv2UOb4vyiWyJ8kKj6FeLNGrf+37pSL6Aw1NZSDRSzHux+A9a
         WVzcCpTF6hgOZaAqSbP8zrub7L7sTzSyB8xFPlOS5XMXoaD5CAO4k5uZAuOvjLvlr1Sy
         fK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783456671; x=1784061471;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b4Z67xtGA/93fMWQS/z9IKMWKMw7McsFrAT2Fc9Z3P0=;
        b=mtij67eeH9pHyBnVpYRGiFk0S/aJw9olv87HacACWUkzCdRZ9VLLhu+f5SN5hSq5m8
         OBCx/THonM2fR5coDoiitFFeW/fZ6D8sTtOPvzhEdMn+ZewNh7awvSEKHGO54rlJB9vY
         agnog7/xDZsW552n71SMaRwRhOIwXEi1djyNuSRubFrT6geN9Fdu7e6XzGwI3kSTT2Ek
         iKXUANxrLI2mU92dmnY1ZgUTJaSnrIHiy19HIwLNviCcTLtad8ZINhmIblfB9AApDTDY
         LjjtGExfipyZM70NT/q04MUFPoA5ygT354fsu27wXo6N4ChyXGOv+H1PrXVWhRpEmSbn
         aicA==
X-Forwarded-Encrypted: i=1; AHgh+RpZf1xylZiFVEMpid3CtBpS4G2r41J4Rp3T5uJ8KdRT4+/VH4c40niohTgYL0fdFz7RDTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMheLFSinbCdiymJiSAkVZPg/oOMwpMNkreOa6LH1gWZHBg//0
	OJwCOysoCWI3JtIWLgkxyHdrrQ7BWGPSfy7an+3/0cAW03D+115MMmW/nb494BZbv9wnSAl9AX+
	PkA==
X-Received: from dycry5.prod.google.com ([2002:a05:7301:1005:b0:311:5783:c3e2])
 (user=snatu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5350:b0:37f:9cdf:f03d
 with SMTP id 98e67ed59e1d1-38757894fc7mr6473152a91.32.1783456671121; Tue, 07
 Jul 2026 13:37:51 -0700 (PDT)
Date: Tue,  7 Jul 2026 13:37:50 -0700
In-Reply-To: <xmqqmrw3aoas.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <xmqqmrw3aoas.fsf@gitster.g>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707203750.1860740-1-snatu@google.com>
Subject: Re: [PATCH v7 0/3] Makefile: link osxkeychain helper against Rust
From: Shnatu <snatu@google.com>
To: gitster@pobox.com
Cc: ben.knoble@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com, 
	koji.nakamaru@gree.net, kristofferhaugsbakk@fastmail.com, ps@pks.im, 
	shardul.27591@gmail.com, snatu@google.com
Content-Type: text/plain; charset="UTF-8"

> Did an automation go wrong, or something?  I have v6 queued already
> so I'd skip this round that is identical for now.

I saw my branch being some 700 commits ahead and just rebased it on top
of the latest on git/next. No changes to the PR code though.
