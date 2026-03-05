Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF58830FF37
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715267; cv=none; b=NCSEwhBmXBBDzGDxfa51yetFa1LZ16S3T+d29E6mYLuWrWu1WLz4LZqjhRJV4+KCfpbUkQkEXxKVb1CJ7+DKDHe5bpqdePxFylrxK1hDwsNUCdGFMqIT/cmEzgjGB8Yhp5rJTalM9/+omrshexkyHYd2SUAz+aT2fovzjZ7SriA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715267; c=relaxed/simple;
	bh=pJN/hUgk93SnZzdsAtIGJj1QSgiE44SXgdvhS5tdQek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/AuaJBrpsrHrTGebktEGsz5F+QkPmBNk8DKBHCki8L1jbm50svXTMDm5v71A4V2YYUzLJSQ+SoRrvfDcxUXRondm6vqhhU8HwiI/dqe/q0U9CywAGvySYhn6zmTSnOStN3KpJsgUKZZ2DvbNb+GNa1lB49B0bbCrgSM5eFk1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m46xrA89; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m46xrA89"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a8fba3f769so35292695ad.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 04:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772715266; x=1773320066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqhPrk8wSqDA54BEuUZrtbIBa5tpZ57LjEA3LeGQR4w=;
        b=m46xrA89wGfdpRSSrWQ2uVAnaRIwgkNgLxd0Fi3k6CGQdl3RG++NfODJAihR8RAMYG
         tCAWYleVN3fW89nH3yxttDKZW0Z2O9Xxb60DVqQP+5ZT93oGXaBitw3Kcd63NKOkEDYS
         BmGae4hLpKfPyUYKrIzvnJ3FBS2WSIzXc6/gu2AfGfpTOsNdtfECNszTP09oPN7a3s/Z
         LJpdrvXmGiJVXVev9aYNRhDc5FiwdOWLRsNq6Y6HAdu2DLras3o+ML3JYdCLmh2jPTnU
         l8EEhN2+MDHQVNGwf3rgm1LJt08f0VW63xmBjXnXlnLwgp0EhQ5XNQ2fBVnUyvMeLRcn
         Tzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772715266; x=1773320066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iqhPrk8wSqDA54BEuUZrtbIBa5tpZ57LjEA3LeGQR4w=;
        b=YDCr7FuwptNE+KFoesCZWXQJnRdOiSldyEcRzs9hn3d4jTSuNBcdAdlboAf6HX72uO
         /Mlip4B61S0qbub5aTxbgx4K8zlhMf9SogTn/TTpXyMuPgmMTHpiG0MRMzfwX0pB+kmz
         t652ER2qU3CT2q/XZ6s0vVI9FZMp5G4JCBeX7N15wE6C/oAYUr7c+0gzJ1yBzCesAJh4
         c68o+6yab/zudzepz3QYL2tjKjoqLSSChYGz2yYRVYwr8Kfhl/hXmHsJt7o8sReD+rW1
         1cgny6K9GvBoGbCSEdztHvX+jimORFJ9Bu8+xNvxN9il1ub2Ts7SWAAYuJuV3wjXypgz
         kPJg==
X-Gm-Message-State: AOJu0YwUowwZjelTWlthU0JU5Jv0OpLIvGYNLFMX9yJ65EKiDmF7WMVa
	r0lh/8GRw3WIrWB1lls/YLD293GBlBS7FErxHM4uWAtuc/K7Wqj6Hgm3DK4S89IR
X-Gm-Gg: ATEYQzzKA5UZGZyWluQwmfwVOS2XREy6LBbt5xz0wV5Xlko2m54fNh6/6TAQQw7biT0
	v3f9C9Yy/xglrmTFQm5hH7Ykeexu+RVTnm0pITSYuE0R4dKwQabuxdU0pbP/tN+FTAohFVRIJkD
	haKpK9UnE1muPykS7SSxJG3yKMz2h+EuUngYhLxjewu7wGH8ZPEehNoA4ElNJfkyPLmvZlSkUu3
	+1BKCT9/pN9H+/aDeYTJMBBj+KuKAtkyxs4PqUrtceEMj4Gpdzh3YPTWjHy8rtnR2PBJ/06SraP
	Wd1oLYYSrGMdGIEv4GE2I996HLxRijKclZiBV8djtIvrBkOdR1++B2WvA8Km+u5OZzsY9iiT3Qd
	fwFsZB3CcZNyU21xSVssUsKkIJOVg9u/mfJQfSz966G+pBhiDcmjjGhZ6TKE0nzTSaVqcpMrvBP
	Fmu1/hJHKrkcfikoM4O/1z5ogFRZzDIzQaPVauCRKwx6+Au3DiQOmkfJ7gUVvjORJPGGYhqzQVa
	GQeG25h+kuyK1FrpzZw1SbpM+GbFJad
X-Received: by 2002:a17:902:e947:b0:2aa:e3c2:f920 with SMTP id d9443c01a7336-2ae6ab0f5a7mr63726125ad.36.1772715266097;
        Thu, 05 Mar 2026 04:54:26 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c738b823b76sm2578190a12.9.2026.03.05.04.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:54:25 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH v3 0/3] clean up a few things
Date: Thu,  5 Mar 2026 18:23:29 +0530
Message-ID: <20260305125332.27600-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304130502.8475-1-jayatheerthkulkarni2005@gmail.com>
References: <20260304130502.8475-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Changes since v2:
 - Update commit message of patch 2.

While reviewing path.c in preparation for the upcoming git repo info path expansions,
I noticed a few areas of accumulated technical debt.

This series cleans up the file by removing an unused header, enforcing proper
size_t typing for path lengths, and eliminating redundant settings evaluations
to keep the underlying path API clean.

K Jayatheerth (3):
  path: remove unused header
  path: use size_t for dir_prefix length
  path: remove redundant function calls

 path.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.53.0
