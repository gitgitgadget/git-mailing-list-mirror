Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B932E1885BE
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781575; cv=none; b=Imd0Fg1FH19RQIBSUl9+xB49iHJWabu/IjtPSaS/tSRK5UgnDFW2zuqfURnWdDmvkvzxz68vxkpN3EKQuS7AWkiMFLZmJQ6auTG9oQ6l437qVEwJr8GMJKef9+6QiXoAHnjtkejgXKft+BktXh/lojLEDp8pE0+ofIpfPVF4w3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781575; c=relaxed/simple;
	bh=T1yNL0DBvjDMdXecfDeTgbzPspTWpzyfachVPEU3wP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EY3EeMpJ33i/h1Q0uhMIBgR6M0/u5zzyRWM0bFHOz+8XZ160M7M3pxsHfWK/Q0tgzJB8nB73/d1i6yvDEKX/fwvO/bsO0CUjXJMtMVQ2loNdXZUgkd9PibJaqMnyZd1mK4k4uMo5GOxgbUwvzhiqCG4gye2m8hHVChoIzw2Ey5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFazC+g4; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFazC+g4"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f9d5f8a4b9so52395a91.0
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 10:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738781573; x=1739386373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqmZtH1UjlpT5uLhAfNXFKGP/8r3GiAZyVPMQ6micTM=;
        b=iFazC+g45vgjYZyt0D96ZdUgdgZ8zPkGbsA5IVHxxVuFtiAwU1gPal9/zIiXwsal+c
         iXfnakVeX9BhhOT244MBIPtfdCd3grGXBcAs8m9F0ooG4SpnvciM0jkEVudOFBM5978P
         rAyn5JbAgG9CbuLUegcD4kO11/K/QwNQCKhwzPvrrae4oILhxsplqbcnT5eGvbLgJDpu
         S+2D/FE/nY/tpNeOCxM+HZCjZntcjXCRaR93nPpwirfbQ9sI69dAi5EfgrBWiAv0d1OL
         QgLbz//b8pQ+3WWMZpkvThPwIjM/quAdcBXtsm8s+qMs8LnvY7Vfo/HiK6z6qMViL7OY
         hZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738781573; x=1739386373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqmZtH1UjlpT5uLhAfNXFKGP/8r3GiAZyVPMQ6micTM=;
        b=oeYW5SyqMsQKMws4es74BN4R6Q100hbT+5KZDTOrfeededhflE9Qnq23DK0OAu4qUu
         wxrjPmbFrdaGsTcNLHAcm7NnkFsJaxKPng40VvOV3ienq6jnGHLg3m+xMchPr3tUX+EV
         RCNRT4295WHtrsDGi1J++N1mREqeBJ9/6cN9iLFjEIVzMrs1ClEdaeGpukjctEhcrKkZ
         wG4nlq5LJUAgAj/bIiAONB2s0ar+SL9/wyBuJOxgZ/r4RJfgDTFotCxj0JhacF0+fHJL
         +NrjPm/qY1v21MSSvD1q9X/2cOHL6F+Pwr1khbwWbMLoG4zQ9Lt8a0frGLhAox/YigrQ
         58fg==
X-Gm-Message-State: AOJu0Yx5Z3LA7fwV9V5h0VqSLH438zl2ME5PWKtihy2aoZBji69d5g7c
	DdYK+PXc4+bmSyacb16hnH6k6RUe/6XmFMgvrNe33Fit4Zf5RDcCvfvN9p5k+Vs=
X-Gm-Gg: ASbGncv/Z0iUeRSupEpB9BwyIwp90h3yUWKZ2ZR5tbF1spimPhGaZRvICIxcUNmClqP
	aih1+0yJoOnuSzMaje444pLFLUhlIP40A/6nkdNxtF/xV9Rl8D/cjCLUnqRBSp3uDBJnbrQt2R5
	f3M8NAGFLZdyCp2BnP0aG1bgq4J4IGXwSV/gLSisQ87ZYWJ2NwkdFB/moN4AkLHNWatSStrcwys
	xDdKv1uylntWZNncag/L/HHFwks0GFjXo4ReNmUcwJEJl8LESkWpfbzCaOSt5riaUXm6a0FBBGT
	phXtElKRD3MpOdiELEKB6M8ne5gzrge+czPEpWOG
X-Google-Smtp-Source: AGHT+IFBNVOzWXTIN7pRLW8400SBR37QpqkICBvR9v3u2N4vbmVV9J0edRzTESp3rweuRCA/p9nH5Q==
X-Received: by 2002:a17:90b:1943:b0:2ef:19d0:2261 with SMTP id 98e67ed59e1d1-2f9e078374bmr6914557a91.16.1738781572602;
        Wed, 05 Feb 2025 10:52:52 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f1e9f3ebbsm13754285ad.190.2025.02.05.10.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 10:52:52 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	=christian.couder@gmail.com
Cc: gitster@pobox.com,
	Johannes.Schindelin@gmx.de,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	usmanakinyemi202@gmail.com
Subject: [PATCH v4 0/6][Outreachy] extend agent capability to include OS name
Date: Thu,  6 Feb 2025 00:22:30 +0530
Message-ID: <20250205185246.111447-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124122217.250925-7-usmanakinyemi202@gmail.com>
References: <20250124122217.250925-7-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For debugging, statistical analysis, and security purposes, it can
be valuable for Git servers to know the operating system the clients
are using.

For example:
- A server noticing that a client is using an old Git version with
security issues on one platform, like macOS, could verify if the
user is indeed running macOS before sending a message to upgrade."
- Similarly, a server identifying a client that could benefit from
an upgrade (e.g., for performance reasons) could better customize the
message it sends to nudge the client to upgrade.

Our current agent capability is in the form of "package/version" (e.g.,
"git/1.8.3.1"). Let's extend it to include the operating system name (os)
i.e in the form "package/version os" (e.g., "git/1.8.3.1 Linux").
The operating system name is retrieved using the 'sysname' field of 
he `uname(2)` system call or its equivalent.

Including OS details in the agent capability simplifies implementation,
maintains backward compatibility, avoids introducing a new capability,
encourages adoption across Git-compatible software, and enhances
debugging by providing complete environment information without affecting
functionality.

Due to privacy issues and concerns, let's add the `transfer.advertiseOSVersion`
config option. It defaults to `true` and can be changed to `false`. When `true`,
both the client and server independently append their operating system name(os)
to the `agent` capability value. The `agent` capability will now be in form of
"package/version os" (e.g., "git/1.8.3.1 Linux"). When `false`, the `agent`
capability will be in the form of "package/version" e.g "git/1.8.3.1". The server's
configuration is independent of the client's. Defaults to `true`. 

Note that, due to differences between `uname(1)` (command-line
utility) and `uname(2)` (system call) outputs on Windows,
`transfer.advertiseOSVersion` is set to false on Windows during
testing. See the message part of patch 5/6 for more details.

My mentor, Christian Couder, sent a previous patch series about this
before. You can find it here
https://lore.kernel.org/git/20240619125708.3719150-1-christian.couder@gmail.com/

Changes since v3
================
 - Dropped the last patch which introduced `os-version` capability. This
   was as a result of discussion on the mailing list on why adding the
   operating system name to the existing agent capability might be better.
   I stated the reasons above and you can also check the discussion
   here.
   https://public-inbox.org/git/xmqqed0sxdiz.fsf@gitster.g/
 - Extend the agent capability to include the operating system name.

Usman Akinyemi (6):
  version: replace manual ASCII checks with isprint() for clarity
  version: refactor redact_non_printables()
  version: refactor get_uname_info()
  version: extend get_uname_info() to hide system details
  t5701: add setup test to remove side-effect dependency
  agent: advertise OS name via agent capability

 Documentation/config/transfer.txt |  8 ++++
 Documentation/gitprotocol-v2.txt  | 15 ++++--
 builtin/bugreport.c               | 13 +----
 t/t5555-http-smart-common.sh      | 10 +++-
 t/t5701-git-serve.sh              | 19 ++++++--
 t/test-lib-functions.sh           |  8 ++++
 version.c                         | 79 +++++++++++++++++++++++++++++--
 version.h                         | 22 +++++++++
 8 files changed, 149 insertions(+), 25 deletions(-)

Range-diff versus v3:

1:  82b62c5e66 = 1:  82b62c5e66 version: replace manual ASCII checks with isprint() for clarity
2:  0a7d7ce871 = 2:  0a7d7ce871 version: refactor redact_non_printables()
3:  0187db59a4 = 3:  0187db59a4 version: refactor get_uname_info()
4:  d3a3573594 = 4:  d3a3573594 version: extend get_uname_info() to hide system details
5:  d9edd2ffc8 ! 5:  3e0e98f23d t5701: add setup test to remove side-effect dependency
    @@ t/t5701-git-serve.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      
     -test_expect_success 'test capability advertisement' '
     +test_expect_success 'setup to generate files with expected content' '
    -+	printf "agent=git/%s\n" "$(git version | cut -d" " -f3)" >agent_and_osversion &&
    ++	printf "agent=git/%s\n" "$(git version | cut -d" " -f3)" >agent_capability &&
     +
      	test_oid_cache <<-EOF &&
      	wrong_algo sha1:sha256
    @@ t/t5701-git-serve.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      	cat >expect.base <<-EOF &&
      	version 2
     -	agent=git/$(git version | cut -d" " -f3)
    -+	$(cat agent_and_osversion)
    ++	$(cat agent_capability)
      	ls-refs=unborn
      	fetch=shallow wait-for-done
      	server-option
6:  351d1eeddb < -:  ---------- connect: advertise OS version
-:  ---------- > 6:  67a2767026 agent: advertise OS name via agent capability

-- 
2.48.1

