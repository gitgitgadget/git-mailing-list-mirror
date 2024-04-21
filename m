Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B8A1DFD1
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713722673; cv=none; b=J2N13k9esjmEHyiRekGC7ItCVTWb3VjvwkU1t3Y2A6dN/Ji/vwcIqnme9DNlQqpsI+2xot3TLEIk946oVTbQmcSxB3mE6/B4BM9Fw2HWXcrGpXHrjA16C5mV1ki2COlXvAI/pzfW+ZsqNfuX6RYL678STT2wszspQ9TW5N4ASIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713722673; c=relaxed/simple;
	bh=xqttu7wwH1km7C6PmJLpqJfrtXTGQbn/nwvNlSgSbd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ep50wVv/AEH+1CbjmRdN8Fxo9Uin051Th7zgjZQaQ7XHW7cENA32BKlToc9vUYj/G+NyEtirW3PKOL8bA3WoeI7Ws9k6ZeaWyaaoG2clJlFimVIYkaYcm3l3/Ida573A/S4Vaa+HPp3yiREWHgBj6RKKviWPSQI8GZ5dcfIonxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=1BU1ffI5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="1BU1ffI5"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4715991c32so374155366b.1
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 11:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1713722669; x=1714327469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dEIoMbWeouZMwiYRi8PjYDLp8nGchR/OdbkdBjXncak=;
        b=1BU1ffI5gclFtKAy1ADpgU1Aj5iIQfLaL61ffEfU3AMrLsD+ZtfSAt2HdFPmHRf9+L
         ENcIuMhf33VKTsWEr81owKngV3NjZXqypDGaLBIgMae5LhWsAahSFjgJ59wN1VC8iT3a
         h/2CRpfzDeFr2ofy7FDnS7HRP20nHzqZj5O9Y7gwq19pueUWJbJf76BjfPUvFzrteUV/
         HmrL9ejfAkO4e5r3Vz46ElbqM3ZMBxlCZKrWllFHn+5+EYpKH3nhzoKRCAOAA5OMVZBH
         yb0Umhs617QhO1ASc9ADae/0fIKBPWZt7qjDYUiaaaBGX0+FglKQmWDXdXUS6PcmY5/9
         nHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713722669; x=1714327469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEIoMbWeouZMwiYRi8PjYDLp8nGchR/OdbkdBjXncak=;
        b=jyDbLuj5j9FMAR6joUEZq0prLoTz2Kr5UXiFKbH0V/QwqzpHwZSQUav2pxF+ceFHk3
         S/mUq0Sf+SosgobGFA0Db9EGaYVVyxeUYQhD9Er8dvGYdfDQ9iZrAmIUE46mzmlE5fqR
         SsqKl9U0RWSENCW/BkxePXNPHQazsLvaGK4zW0h+r45UqFDgzFcJrWwI7WoqcB2NjZAk
         xJ8aBbknMcSm1XCtTdIa9wTR36NFODc/5+rtWDiiWX9eS3HsV0aNuOC5UuSvXP/X4a9L
         nKmx/FUbHrV0lrnYKylOIug2uRc7D5IudrvifPndNhjY73g1dbuH8QHa0b2vrVCoupc7
         Ct7A==
X-Gm-Message-State: AOJu0YwNFGttspcRFYmhC1JnfAUnYtjTUwKYMzxhZRp6nbDr7Ii11+YE
	0/MCjfgLzMG5+phGae3V4fgbTZGpfSlBKNg3hzmNqxcqo3qZwZt3vvb1FmAF/g6F2gmXgbvKzyi
	sDfY=
X-Google-Smtp-Source: AGHT+IFHJm+NDRlkuQJSAasBNsesoGSC4N/ujvpHy7/bZYlzZxB781MJsFF38OuzjGq4M11DKD6IoQ==
X-Received: by 2002:a17:906:6549:b0:a52:645a:8ebd with SMTP id u9-20020a170906654900b00a52645a8ebdmr4744631ejn.14.1713722669010;
        Sun, 21 Apr 2024 11:04:29 -0700 (PDT)
Received: from ashopov-C7P4TNH9MQ.corp.uber.internal ([165.225.240.154])
        by smtp.gmail.com with ESMTPSA id j18-20020a1709062a1200b00a557616395csm4420974eje.85.2024.04.21.11.04.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 Apr 2024 11:04:28 -0700 (PDT)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH] Consistency for substitution hints (i18n) 0/1
Date: Sun, 21 Apr 2024 20:04:21 +0200
Message-ID: <20240421180425.78940-1-ash@kambanaria.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In previous patches translators were allowed to use characters different than
`<>' for pointers for substitution. In particular non-latin languages can
skip such characters altogether. This enables this functionality for parse-options

Alexander Shopov (1):
  parse-options: use localized substitution hints

 parse-options.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

-- 
2.44.0

