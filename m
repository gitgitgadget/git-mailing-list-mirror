Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD5B2C3253
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 22:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748990974; cv=none; b=BxkZy4MMB2V2Hy2zJhOsngbQO5yorACtF0cvp7ufSXR1UDxMCfRJffi2toqPArHaFhtDkZCyd8PSlx9IAi/ZkJqW3nXKkHURuq74FON/2dWSYdLl59AmZqUkRc2hXLAVX5QiL1CR3Nleu8jWzn/Xql1AAkxWri2zjS4jk8EHXv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748990974; c=relaxed/simple;
	bh=jzpX0PrbeIhO13E3ws3a1DmxFnlJANmnkL3LtS2EfUA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OEzitYa+Nxuep0aKcjDm7drUHdQE97WbyPKLlbb+WsL3rRiwnNKqtXmhbNI72DtRHqx6iAnNjyK15Mv3puf/vGLjyNZXxxavi0h1h/j00rGtU5N/q9YruC4Dc6Dt2KhXxYgH57ZyWGLayBNcknzv4WTOE6A6o2GnPFFHR1XHaIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jvn09Uw0; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jvn09Uw0"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30e8feb1886so6614008a91.0
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 15:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748990972; x=1749595772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzpX0PrbeIhO13E3ws3a1DmxFnlJANmnkL3LtS2EfUA=;
        b=Jvn09Uw0AG5m9X6PbmZ41wb2ps1U22RHpdMXT5BqhiCKw16qHDiny2rB1hWos0bUy4
         0uhAHQFUFlpSl0yqg37FfZshUy/ljxZORK7SZ38usSCJIX2Ytp3AkSeMXat7b+c9R+vt
         IC+KK72a/6MNZZQlsrDBFjoFWFQpPsckBcx+sRedb0dYIQyqMTRyGVTMxBcUcadevFEg
         TwXgNT0/v2ShJSEcQeW4sglcRD77xVPTo7Jyc57Ev50IPiXyIYS+rcsIwVFu9/1V9DM1
         bk5ovHFlIC16zilPWtrIyrr1uNidBImU6o7sL5VMnjUUQUGr4glspaATcwsawPiNLEzh
         FwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748990972; x=1749595772;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jzpX0PrbeIhO13E3ws3a1DmxFnlJANmnkL3LtS2EfUA=;
        b=tYEbWMXPVrx4H88dzpqQ7KGAvMCK/gW3FZyuZxbDeGmSw8dSWCUtqNp1teaxOQQ/mY
         c30nmDKmXDArNFPImSg+JK2pWTgB2SOLLz8D8C244M6nHi2skELuQLeA9fia2z4hL0nb
         DzoeQLavKDR55EHJSayhuyVdCAS/2rlA1SeZG0CCyF5hXlJN4UN6OKrEvpuJYytJQBZI
         NhNh3AKCsK5KHqjT05/racHjQBOd8+A15PbFbecnZiHZr0/diVUnbhOlTcC0vQ+Nj89z
         3ZBdKg1TyijFyVT13xMPp9Lc4DLXMYOJx7dp3ZD6utfq9RivlaqDiv8GoZce5XG52D2+
         FBQg==
X-Gm-Message-State: AOJu0Yyw+e7QER/DZUGCRezG+3+A1iu2forsK6llw/SBgFbadLGwGXwA
	+A9bE38DEMKRb7oQaogRQsvohwodnkC9RGZtgHKJG3wKGWSE89uxO9by
X-Gm-Gg: ASbGncvKr/B6WMbrUEtMHx2V6RDJe/EK6AUv0JU7nLgaCDMf4Dp5xshlfGyh72QUX8p
	GCoSlP4z9zxzarCbjtqrf8LC6muJ5lELvSPVFFbTY4eHvJEbdLgs+dgTIRqOqkKCXsOlRZxEnKm
	hmBLvkl3VtX6LTwDlaA9BqNzvmAb7fRdI6t5ohJOTH2hAER78wJil4X2/dTCLuYmUX//SqzaGyz
	1PzmOtHeK1SsI0J/jV8VVXVpOvmlOSKI+pcIcrHNIIpKhyXkNyIgyjTikuWO4yfEwxjP7dA/mFq
	/7POc+EFCA5dn2PbEaroQD6CCp9FgTk=
X-Google-Smtp-Source: AGHT+IHDgTJhE0JKWCS/v9RPl1wza/9GWZmflhF/vfWlzbFPqJnkwhUGnKWbPkmto+73vwkKu1/YLw==
X-Received: by 2002:a17:90b:4f86:b0:311:b0ec:1352 with SMTP id 98e67ed59e1d1-3130cd15a4fmr1153507a91.11.1748990972187;
        Tue, 03 Jun 2025 15:49:32 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::9eb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-312db4a4de5sm2461364a91.38.2025.06.03.15.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 15:49:31 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH] CodingGuidelines: document formatting required by
 generate-configlist.sh.
In-Reply-To: <xmqq5xhcimid.fsf@gitster.g>
References: <xmqqplflsmic.fsf@gitster.g>
	<45c586122afab8ae3624be6963d64e770b7396b2.1748911713.git.collin.funk1@gmail.com>
	<xmqqiklcri3o.fsf@gitster.g> <87sekgpsbe.fsf@gmail.com>
	<xmqq5xhcimid.fsf@gitster.g>
Date: Tue, 03 Jun 2025 15:49:30 -0700
Message-ID: <8734cgphj9.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> We are updating them gradually while avoiding collisions with
> patches that do other "real" work; see many recent patches to
> Documentation/config/ area by Jean-No=C3=ABl Avila for more, e.g.
> d30c5cc4 (doc: convert git-mergetool options to new synopsis style,
> 2025-05-25).

Ah, okay. I must have just looked at files that have not been touched in
some time.

I sent V2 which uses the example you sent [1]. Feel free to add yourself
as 'Co-authored-by:'.

Thanks,
Collin

[1] https://lore.kernel.org/git/802402a288f0976765f1ba1c82d14c2289c8cf72.17=
48990700.git.collin.funk1@gmail.com/T/#u
