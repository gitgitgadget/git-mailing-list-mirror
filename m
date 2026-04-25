Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBB62B9A4
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139296; cv=none; b=MZPAW3PhrOy2G6kLZjwacXvAbEg7oNGAiyHgOiATfg2Vbz8CWBAq8Vk35EFed8LEg8F5TseFlIAt6ezfUGP31BTCLvLrfJWm+zEtzB6zQsypAK4PTXeXILaLbXl0FrIQmePBZNqhlRBv2FODTYXdk9FgFu5Ftt5T/4Gg6SDLQ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139296; c=relaxed/simple;
	bh=KItqbkBAw6/pA2yhv7MPqq4FCcyChJiAw9HCOruLdwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFI2j2KL1j6QIVYZRtbFKzPnNMMMMNtgcMXceJbS3pHwn8yB1CgUxQqWsH3ZW5ZmqS47vKK3ilfFEVWKTiTjPV78xAQWxR+jDPtricDrvEVIt23JyBKeaS02jWx1gUhlscPNI95BDaXHaq1Nl9mD4jSqlg5JbiCjRMALT6Filpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfB+xKTX; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfB+xKTX"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a2c3dfb4a1so8929341e87.2
        for <git@vger.kernel.org>; Sat, 25 Apr 2026 10:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777139293; x=1777744093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KItqbkBAw6/pA2yhv7MPqq4FCcyChJiAw9HCOruLdwc=;
        b=nfB+xKTXObX7mXNx+qRFgWabRwiWOlt19KDxbJOYgczC9Ywm1jdWh/Rqh9jEpiqXP7
         MyfEAlOE2RJRKJE7wWqUZIKzW9WBcWK1EjB9hGDKwQlpt/iZeLk8yBve4wXCDeRK+cnW
         A0yzf5NK3sU7HGuRHKU/W2OzFd4AYmhQut08HDNDeg0qx2PryEaXuVoqxKucn8eI5w1z
         SwpOMIsI2OUFtFXwvktW7qUOPd57w1oD/tjMZ7b+ep0cfis2H1rJdO7DTkKLQ3pAKKPE
         v96mYdoHuseXiayGJvkmaXnZByTJuOgLKzqT+8703O97Xd+aTwAOP0W6gxg28kM6xrw4
         8cNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139293; x=1777744093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KItqbkBAw6/pA2yhv7MPqq4FCcyChJiAw9HCOruLdwc=;
        b=iQL4QzXAmZq4q3Yp/fa0uoQv7Pg54L0VsqbgMVAH2bQhPd7qlRmEl4gbzsmz0BFEWg
         Ui8c/zXcRsLFQwTJaRNzxWKL6rk+P7xreoaPM1R5YakYkZG5H17mzh8nwMdhLLi82WOA
         E67S17mnGCojnjGRC49FDCFuAJmcDnYNGShKS14u8Pjxnx8qnJi8LRmqoHSLSWUQqStS
         hEWVd8vRQb7w7yJpcc7mNPge0hXE2YY4tDyBcpGgAAbhn6LOubS7Xd80tAfohLtwke/m
         cqDendJj10pqN7NDf/jQ41AgWsT+SgPfYJC1c/fBn7kuN5lXOrZdhvV6JJB6f26bA5v+
         Bz5g==
X-Gm-Message-State: AOJu0Yxnn34OrMGcPeAq2FntbngARdVLYj+VC4xyVqZE+WS56pXzgTvD
	H/p3vbVNTmOOsxk3ZkiD+SYD2Fg+29eRF2KWGZOIqVIuBKk9JDwojl3P
X-Gm-Gg: AeBDiesENLhAil02jL23MkJl6Oz4XOivJcWLrhaNkII8/eBiCSJbbdDg/mnjUbsLp/t
	MR4/Hyqcxr0kI0kkvgcCvMgwzffOqFjPScM/+F9Otgn2LPozixSXjSLcgsDHq/nfjKm6yFqXfgD
	oVzX+1AwzG4YwXPlPtSiLIqYvDHF//Z/GbSn0TqKNwc63VwFPmj5xPbn6c2C11bqv87kMB/hMRk
	ARHpYV2lzc48hffw2kFZeZkdKJ6v0pJFun3wYTiVTe+lmcynm7DDMibygSoxS5W9QaXMeEpyOVd
	iNc2boxHK59mtcY6eBgfuScLnTPm6ZfEyXtmV2W3Dzv4QxOELGYQx5NnH/B0MVEmb157tG2n7TW
	t0VK70pYLZ5G/r9pt0PoYDppsgsS55lortHqhiA1usvyF789XCflGyht+HHh4AI6x6Vo7a46+3A
	mEUhV2EMIL2TGLhFPlsqmztQn1HERshocIM75AqSHkFiFVv2xoe7ER4E622y74QBpK90H8weWRb
	GyUMBW44IpfTXURKh0HYi9fqDk=
X-Received: by 2002:a05:6512:3b83:b0:5a2:bacd:21bb with SMTP id 2adb3069b0e04-5a4172be0dbmr10602561e87.3.1777139293158;
        Sat, 25 Apr 2026 10:48:13 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187e1063sm6923815e87.48.2026.04.25.10.48.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Apr 2026 10:48:12 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: marcnarc@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Wrong subject line
Date: Sat, 25 Apr 2026 19:48:11 +0200
Message-ID: <20260425174811.46941-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0-rc2
In-Reply-To: <42a620db-6110-4894-97fb-8e49ec577817@gmail.com>
References: <42a620db-6110-4894-97fb-8e49ec577817@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I know you are not Ben. Forgot to change the subject line from a previous message.


Harald
