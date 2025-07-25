Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F07243378
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460660; cv=none; b=MHu2A8Lybp4C6YAadyF4BGsSXYivBaZUFcObrbloCBXEJeXx8rwv4lQdYJPXbbvS50EPlbRMh+kpPOlHlzsl0TZWGsHkWhDTz/C7JublfEfsUa93erLQMQbKLUp8MefOIrlUxivYHxB0lUxfV6sUzJ9sn3mD+mkVMFwTseDqkpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460660; c=relaxed/simple;
	bh=uAGOYWPRFwYcgezXUQQVNUaSB1jtM7l042WjhN60Uos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQzKZfnCq9g4gJ03pdbgzbTdeSEiCAPd50XQV/Z+xAJ1bAdRs0Zqoq5JGr8yJPSjm7AH9qsBRvR2gWoGTkiFEdogOyUDKxSiBDFKLsgGhtIHVQUn/iNxuSL8CUVktxI7AGm+G94gINSzVbaIYJlJJclg1CvzPW3pbQ+zXgLPJtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5mfYIfP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5mfYIfP"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2363616a1a6so19194375ad.3
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 09:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753460657; x=1754065457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npUY5MgZGmZKLv9LDlAYl4SbYj927PuI56n5H30BHzg=;
        b=V5mfYIfPLpQYxq/KPiP/OrGSkF63lVsEC9NxYkyRL902wvgcDhLTT8OfIndi0C4i26
         xli0gAGMGsl9oxrS8knBUMrTFCLwHAXzJyDe3Qomx9nyt4MQvLNVtJXzpWCoBtJyWcAl
         YYzN/hYV6ezmc7xe2aB/afNxSS6fGKVvO83Td8Q2TYA+SvTnu1+YJ6V/QSk8JpGy/EfA
         Nlquptdxxkuf+U7vayV3MCwYbW/eBYB4DoJzO0J45J8CqL3BUNVYGwYpHZFZZxmYwNzN
         //vgud7EqEBe/Gz4FE08guj5ptOFLFsyyTmPuLCc98PUJFBcS5gmJYURKmGBBO4gCkfj
         78/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753460657; x=1754065457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npUY5MgZGmZKLv9LDlAYl4SbYj927PuI56n5H30BHzg=;
        b=dGssseGChB/scMOb0jjvCyzZEc1vH2xtgG1nnZRGyb1buL6sfKn5HnnQtAz0n9cSfu
         +lgJMNZoleMCG7lvjrC5/0InIgt8fxEIsWRmLvPLKgba9MelVQ/oPOaloAe63aVYP8L3
         rnvSIIeifhVyjDg2RylwzpnwbL0EWdXFX93FMuO+ZPEt5zO7G+DvKoXpZxQUSbGVUAOQ
         7DQpPWQzz+boKeAoV1dOVexLN8K2PJrWUGEZ6FL4VgSW/327MSBt8CJXm2u+8xUJ9RuZ
         /8BzUXwQf+BUcnQy1V34Gb8Jy9L2soQIP29Y7J3KDTmiVwtY0zmXE2DvuBHlWgpAeWVT
         2jeA==
X-Gm-Message-State: AOJu0YyJLxmL79ZQbwy9BDSZ3RW13JW3jlfXWoSkMmDMaj5q2gGiLxKL
	OaW48ApjhjgUZLHY2CdeFNnkwnAsCS5mnjdgs3wiHRqJ3RDsNZQdFLTH2282JA==
X-Gm-Gg: ASbGncsl6qduWaVwV9uUO+UlxxCrzKq/rnEcpSMCb4CdRDCbZFLBXbqYq1CD488tAEl
	HLuAnh9aCik8Qn3nk3YjzHdahWG5RZ2lk+M40bUrUqxoAfdtjhgkGmstd3vulDkUGBFpkfqfBjF
	gpjpJ0JnxYotQjKj5hGGSCvXWr/Bonelx5OIPVN5L7q+c96kZLoBJvqFxLnTrdaVT5EmoxsBiOU
	6ga6MTay3a3IKhWTyZ7A0tJvmSRMbHVHeyLejifKrAsonoYe/S3u0ksEV2x1meApmcLpmHLMYa9
	lihFCaczJz2iPdxfE9f1OBPeXEBOjLO8WUkWCMy8O38jwCbzC6cfEbNZ4MqtUK9TrTGDwGsWWSX
	5mW3wXg/VyecCz6bTh61/y7m6JkQ6nViloiA=
X-Google-Smtp-Source: AGHT+IHDuAeUR3aZMrAnqf+VjQvWA1zg/LJbC7bTynqumkaRjTTtmgYJRmyfmkf6Z2qZNFyod1kjAg==
X-Received: by 2002:a17:902:ccc4:b0:234:aa98:7d41 with SMTP id d9443c01a7336-23fb3164f8cmr38589815ad.42.1753460656901;
        Fri, 25 Jul 2025 09:24:16 -0700 (PDT)
Received: from fedora ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe5740d9sm704335ad.200.2025.07.25.09.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:24:16 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 0/2] Avoid submodule overwritten and skip redundant active entries
Date: Fri, 25 Jul 2025 21:54:00 +0530
Message-ID: <20250725162402.92098-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.50.GIT
In-Reply-To: <20250724152418.45226-1-jayatheerthkulkarni2005@gmail.com>
References: <20250724152418.45226-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes:
1. Test now has an explicit error message in patch 1 
2. Nice catch on the double function calls those were not needed 
   a single function call to git_config_get_string_multi did get job done.
3. While I am at it also fixed some indentation issues (Only hoping i didn't create any unknown ones)
and localized the loop variables.

K Jayatheerth (2):
  submodule: prevent overwriting .gitmodules on path reuse
  submodule: skip redundant active entries when pattern covers path

 Documentation/git-submodule.adoc |  7 +++++
 builtin/submodule--helper.c      | 54 ++++++++++++++++++++++++++------
 t/t7400-submodule-basic.sh       | 22 +++++++++++++
 t/t7413-submodule-is-active.sh   | 15 +++++++++
 4 files changed, 88 insertions(+), 10 deletions(-)

-- 
2.50.GIT

