Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672711D5CCC
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743623571; cv=none; b=Lt0tqhMqrraHaWE/+igr2AsLnAjPKhx1VXohWpbDB92qdClIBeu9z3HUUA8kTa5PUGL/IsJb5+13rEHK6c+XxR8kK2GWfCH3rpwDOSHYbm7QrvfEEBWQhqaGvs056FL1MGj/JEIA/AJ3QozepldFZM0edKOdpSfRmcLBn3px8K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743623571; c=relaxed/simple;
	bh=Y5A3z9jH2Uak3kJz/za1ylx1ME1a3T4xAHHxYEooxAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWvq/Qx+8vGdP+cEtw+nFf1KPVt1x60g8pKsU6hmx9I4AaOqxGdNWDVXG7PQhoGFDMCRw0y82xZ32F1lJxS3A7U9/asMLf+r1X4UmO00pVJIvExv4Gujw8mwXpCaKMLivhJPYuozKZ+AnJDFtey5DH46I2LOXpRWqTAt6TDQey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FTlaD3z4; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FTlaD3z4"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so16994a12.0
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 12:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743623567; x=1744228367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5A3z9jH2Uak3kJz/za1ylx1ME1a3T4xAHHxYEooxAk=;
        b=FTlaD3z4ddLbxGCffCSrTCo/gHL4svsbXjxRFNY+h0U9t2dHMFf0SBk9yM6zZ8l20P
         99vPjM6nctHyu9yI6619sHsQ96L8nI+h4V5rH54YrmEu3XiAzwloQEYhJWKFEGouBCJz
         AYI+hrqay9TpDQmLn1TdoOitpLnyZ0O7m2rr5ytJ4uh2OgrwXDgrnNNbnkktoskW1wEc
         XXSAKamnTguWm8K0no+KwnFKLTGsVmjZQYw0lVGSfyPmRrtyLUOp0x5IpTWu7MTqxpit
         8tVnkaYmYyy0OICGqbTLKtnUdQ00qHCEPEBIH4j0wWf2fn2HIDvzY5MhvbiCNS1wPdH1
         S3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743623567; x=1744228367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5A3z9jH2Uak3kJz/za1ylx1ME1a3T4xAHHxYEooxAk=;
        b=sfDZOlc4buWncg2ZypUlSz/l3Wy80Z4x2VlVBqN9+Ie3c9WDcXJrgF2FT5HDYRW5A8
         p8d0jOXPf7ojhZtVDnd/0xjKImgsVjoCV21ivGvTIwHorgDJhgBfeuvsnOdBw8BrzphW
         e40KBE6tNNrAOTnGScYVblhRlwYGevWV6CEGYXjHjxU2lbn4iHkqW4fwngkMo/T/n+fI
         SrdEOaOCqYBe4HKPVdxSsDnKdQe6KiaEfgpusurR687zfSpq7deSAkPb3oQ8yDlkKho0
         SXbiTjCoxnCZ6s22sttghaxm+tq4u60XWKeEpBNtKkuLRNirFwEED3RzCgHLdNmlr6ke
         83BA==
X-Gm-Message-State: AOJu0Yx/r5E1mTIF99YJj8WNH3GeYG5uTaMEJO5jkJn1wz+orEM5+cPx
	q6byclpQOXpdsn5GgZed07AacTUeI6QiCvi980vO2UZBtxk+naYVbJ2HQ30hhxTUu0RQlyCTgJn
	R6PxE0G6jmth7pQRlbMHj1wvSsSJmFZVgYdB6sxcMHoRRElIUmg==
X-Gm-Gg: ASbGncuyo0RSPUpyydaPsROMSbrKiAEf9FWMXVIVzizcDJ/ZqKxd23eA++d1QJlLXUV
	8f4bp+S96Eln08HEExAfqZtFS1Mm5SbcwuaZwQq6yowf8QdVsaWFt+znwU0EUt3luvQoFM5b688
	kYQYVspZcTddw/4Suq3yxD9vxt7Cwx5efdlo/0P/x7zc0+Hr2qZ9d+Dstl
X-Google-Smtp-Source: AGHT+IGlw12NRHcEOWk07g1IMyvl7PjeeteS5YQEdYgCBCzb/gcByuDyIkKmwKlH7simiv/E01tiehs/qpi+wCgTifc=
X-Received: by 2002:a50:d689:0:b0:5de:c832:89ad with SMTP id
 4fb4d7f45d1cf-5f085189ac4mr19395a12.6.1743623566928; Wed, 02 Apr 2025
 12:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
In-Reply-To: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Wed, 2 Apr 2025 12:52:35 -0700
X-Gm-Features: AQ5f1Jq6dLDYTNZ0OyjMuztoQrY8JvOjS7qmrBzmEEJIK__uxMdrY7xm6_-Kgnw
Message-ID: <CAESOdVBBeQDtRmRSQeHomuxQubTP5ggKZWGG88n88qKYBHR=+w@mail.gmail.com>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
To: Git Mailing List <git@vger.kernel.org>
Cc: Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"

Sorry about the typo in the subject line. I meant "commit *header*".
