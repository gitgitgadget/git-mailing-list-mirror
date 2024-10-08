Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869D91E008B
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397787; cv=none; b=SiIjLS9YAWKOnSsHsReBLaFcDYJolC22gdgykpDE2Ks57I/S/305iLiZheb7W5XpzFPpDtA+jXVPEPPpdN9lbAuRIcAT2v/dUqrU7YFl3Ig6YE9hAuHay0kqJZSaeWCo3tQECLqycV4zeBBBB2kxGfkUudbNA926lgkG+s2r4s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397787; c=relaxed/simple;
	bh=bIxCvF+opDA5yCqNSUK+lEfBLsw5ukpPBnK7cRlE+5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kgM0AzqXrbzVkdOBW9GTAQJS3dEGQAE/OLcIxDcHuQ5R5yH3oz30o8/muToGd+hCgy3JkcgOk5CA1yWcWUXkMZub4TTHIVjXoIjyiD5Jd+5Dzz/O9ZHXRKlKtM9brii/W1p1pIJACobXML/7XNoWhgiZSq1Y9dC/tJNwigH2UBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLzTlLtl; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLzTlLtl"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e01eff868so167236b3a.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 07:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728397786; x=1729002586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gxq0hqjepC/K5KQu5ADnlgCJXxJacS49VPGMGuN7gYQ=;
        b=nLzTlLtlYVzwPPJH6XAsQFynOnlpDZXaV45bV+pM0EkYcp4YLsCkyWUrlEn348+0Ul
         +03/ZT52oxZ6N8tadCaA4aIQfBA/0s/+0rIAlNMrbT6k0w1EzBIJe81ARni8kK/BxVc8
         eOl4jxACETZ44SwNbjR80oXg0ZjFl9ZcdPfFzoQl0zgk5mfdild+kTQaFqdy6AxqG/U0
         9Gf+620JPsiHCwtDMI3we1YrkyKe0D952YQaEYiH+xpBicPYXvNxSlpYLkQ89Y/WFfLh
         z3Int3IL5lLx1wOHguXUajG/H5VQBdQL9efT0sDVYdZHe294TbS021NA1s4y2WbsTKce
         +39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397786; x=1729002586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gxq0hqjepC/K5KQu5ADnlgCJXxJacS49VPGMGuN7gYQ=;
        b=ckzolGwLZUrfNRH6une0ZBOhbY9ns3tGsecPLwtN6b6a4li4wNPEE4wKAdwyJymSuA
         p5tJiw0VTZi9NVK7jrA+8htHzbG9We836lpR3cjKFYjnNZ7vwXN7xLHRVICVZAThSZWl
         xoCLz7EJiCWr23Py7XPP767Af1b/CdOdR2wtZjno4sxpNJy8TD93Qug7LDjg0XRF4Kir
         Wh/YZJS2QI6ot/rK987WBZkaiYMQ9YA56FEeUNLgn2q63iEwaOa73QZvHUz64+BPH0GK
         Vt2uvpv5hfToPRwjgNjcvLID5S3cS/kBhFgq8gM1M1Rq5daIhKaC8KyaEr3z/rzSfBYq
         LPPg==
X-Gm-Message-State: AOJu0Yxpq9uQZg1Sj/S+kolrYrkVIGDo7uNpeariKUVvMQUzJSOfKlK0
	FcLC8bSr3QwIlMnGG0j6yFbOLpYQTcszzTnY4dZizEacRzGSxUMOfMqb6A==
X-Google-Smtp-Source: AGHT+IH5fXKRC5aUx7uzy0Xnhecg31K0+5gYi+2dj3BFFbwB1iq6uFLnm4GvpE7IiZ8w43JCZt9CfQ==
X-Received: by 2002:a05:6a21:6da4:b0:1cf:4bd8:3a02 with SMTP id adf61e73a8af0-1d6dfa1e607mr10658797637.3.1728397785533;
        Tue, 08 Oct 2024 07:29:45 -0700 (PDT)
Received: from localhost.localdomain ([2604:3d09:e083:d900:fddc:a13c:16ae:b340])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f681f089sm6795954a12.25.2024.10.08.07.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:29:45 -0700 (PDT)
From: Josh Heinrichs <joshiheinrichs@gmail.com>
To: git@vger.kernel.org
Cc: Josh Heinrichs <joshiheinrichs@gmail.com>
Subject: [PATCH v2 0/1] Remove value from position args in config unset usage
Date: Tue,  8 Oct 2024 08:29:19 -0600
Message-Id: <20241008142920.570244-1-joshiheinrichs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241008040749.69801-1-joshiheinrichs@gmail.com>
References: <20241008040749.69801-1-joshiheinrichs@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!

This version addresses the issues with my commit message that Patrick flagged
in v1.

Josh

Josh Heinrichs (1):
  git-config.1: remove value from positional args in unset usage

 Documentation/git-config.txt | 2 +-
 builtin/config.c             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Range-diff against v1:
1:  4bb9c65fb9 ! 1:  e3b5f3c8b2 git-config.1: remove value from positional args in unset usage
    @@ Metadata
      ## Commit message ##
         git-config.1: remove value from positional args in unset usage
     
    -    A single positional argument appears to be enforcecd at
    -    builtin/config.c:993. Values need to be provided via --value.
    +    The synopsis for `git config unset` mentions two positional arguments:
    +    `<name>` and `<value>`. While the first argument is correct, the second
    +    is not. Users are expected to provide the value via `--value=<value>`.
    +
    +    Remove the positional argument. The `--value=<value>` option is already
    +    documented correctly, so this is all we need to do to fix the
    +    documentation.
    +
    +    Signed-off-by: Josh Heinrichs <joshiheinrichs@gmail.com>
     
      ## Documentation/git-config.txt ##
     @@ Documentation/git-config.txt: SYNOPSIS
-- 
2.25.1

