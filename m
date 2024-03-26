Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2CF6CDA3
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453942; cv=none; b=Pdc6ZLIe5Oq84fk5OTAxOladzGBFKj810CYq/9MkHQUx+1vOT0GeUofm8euG6sLE1IKKbALNcLUBREzcrNom3T4qwb6otkjyQC1fsuRNL+Sktb6kp8jigl6Mz3tOXgiDDkSneIpY7QQBhugp4hjgOUwWjhsG19jpriuR8lFm6hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453942; c=relaxed/simple;
	bh=Z3bBaqakSPvBZH0GwAb7B3tpoIGPmQGm5/Z+Ecp/ci8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXC/N8F7ipG0e8jKOPwjeFGSZMNZNFjbH2cWDffY3SoqsjI40Ekp04GmYdU/Usd1wPwQszOTXkblu6K3UD6DPC7P0VDziuYV7ojz57yqCqypiUU0UyiqDLooi7UASoytBoiOZErsU0BayCUcBKiX+7dfgKF6WzPzAASXP2QF++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyneqExk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyneqExk"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0d8403257so9881025ad.1
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 04:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711453940; x=1712058740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3bBaqakSPvBZH0GwAb7B3tpoIGPmQGm5/Z+Ecp/ci8=;
        b=FyneqExkPhKvrtNkAT6+sHWIE9r5BWEL9dyzpSDxJzN/qZQK7IVSu+vpZKNHIbOHfR
         VVL+uFkO9kZFxgX+I9eckQ1eOpUhyvBZJWDyXJfn/Kg/eDhsgMS7AuSTi9bt3n3TmwjL
         xXumVO4VQc0XPowCrdFDsskEWTQDj/3HQHAVomn+Lvenq3dvXIwbtI/LhoLM69pBfOed
         YSkW8rYh2xaJQdT/ndeEpfNsJ9+Gg4u3MCKtRnibjK39WJjacLksS4X8kWLmHgki189J
         mFn1f1xzOhPNIMtjMtkcsNQevmO+oHOL+PS1YfnLTXJFv4D/2OoQZU30AYpwuEHneKXK
         wJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711453940; x=1712058740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3bBaqakSPvBZH0GwAb7B3tpoIGPmQGm5/Z+Ecp/ci8=;
        b=Ls4N/o+6hHgzmgdYf8SS16ecv7WBACjBaVQ+tPwm2+Fm6IOiujYvUMIpsI7IrtKwMp
         6Jm6P9aN2WvuKxjog4UA+Xt3TYeK/8PdjJ2fy/xeXICUN9hl6pAWFxNWxK67kv8JR8Zf
         f5iWmqPoV6/4xeBjs9unvOq2O4O4BT+iIFAjh6l7bdtYAvatyqkvjHvRAGGrb7UaLt91
         aaRwcG0je9q799lVDlmEuYgM0UqiV/qridS8FycJjXpPv9j1pqezoIBvrOteGmCJrw1A
         y5fO0ArQQgVgVYYSI/ErZdb7OcDgof3BIrxdPaG6aFJQfmtJoEPoC/yEqVYcOPdbpmN+
         ssOw==
X-Gm-Message-State: AOJu0Yy/zYzl1lDpMers8a6nGTMyFkHN5ET2c8DRfHr/8vJ/ocyOBpw5
	sf8ixM6z4T3fAP86+XKnhCOh3v3/tUXS8vHAQ+1ayLPv/BTA2xQcu26knJFAD50=
X-Google-Smtp-Source: AGHT+IGA2HORFGQeAljvHDoeuN1f1riogE2F9ljgNS3++9UYP9kMCnveRLAQzydHd/ABGnZ2lq/BUA==
X-Received: by 2002:a17:902:e752:b0:1e0:b5d4:9f55 with SMTP id p18-20020a170902e75200b001e0b5d49f55mr7287252plf.50.1711453940084;
        Tue, 26 Mar 2024 04:52:20 -0700 (PDT)
Received: from ArchLinux.localdomain ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id ko12-20020a17090307cc00b001e0f2dc4165sm1173884plb.60.2024.03.26.04.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 04:52:19 -0700 (PDT)
From: shejialuo <shejialuo@gmail.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	karthik.188@gmail.com
Subject: Re: [GSoC][PROPOSAL v1] Implement consistency check for refs
Date: Tue, 26 Mar 2024 19:52:15 +0800
Message-ID: <20240326115215.40180-1-shejialuo@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <ZgEwgNl3fug3qGG5@tanuki>
References: <ZgEwgNl3fug3qGG5@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Hum, okay. This does sound extremely taxing and I do wonder whether this
> is going to be a sustainable mode of working for multiple months in a
> row.

Such a long schedule might indeed be too intense, but I think it's very
flexible, and I can continue to improve this aspect of the work after
GSoC.

