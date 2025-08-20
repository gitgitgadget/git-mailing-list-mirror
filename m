Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62772229B2A
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755730548; cv=none; b=ZV5IYnWg4BhbgMMj6xXjM+zZiLL/7WN+zdQmrHc8n+PseBQ2I3sXGtX+/L2F0kEjEYlTSkhf7A33qfiaYlYL8e6+yoAcX1hlruT+vITzJS7D08AWFn6lVE9fR3+dP7tr3wIGH9hRTpeV/5kfVLnF6cjbGIKabFNgVkC1TGUVXyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755730548; c=relaxed/simple;
	bh=H53oBRhNOfmYNq8hxGAVJvxdl/w2jt06dZsL+YBHL1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nhJvwM7jR01ozW5KRHc6Mt6p4KJRlcnU7ZX3spOGukyBRlQRuAozGFOAgSIwgZ2Ofdq/VDKBYDQ5P2oxi3thXw3H+8UHPW66NHRzyX/OxDfcchOd/M/Wn9ojAkGl47/rEiKXId+RdNSX3YP2HfdJhB8bflBZ0zffuJQiguoV0gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftIkConT; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftIkConT"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30cceaaecd8so223092fac.2
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 15:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755730546; x=1756335346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MfAWIm7v3lkDh+EfzxMzZR5V1P0z6xujRrzSrW5QBRo=;
        b=ftIkConTToDBaTFpn7Y1umEL+PAZsYjA7MDDqESFq/DmovRVAFDoRnAysj5tn/eNGe
         oDDGirgttwhgEBHZ8XZPYPABTzxxB/DL7mr00a2sCU3KYXJa53yFTMkuW8oAhSlz8mFK
         l+lY+KDpp2/GTC+3iKwfAfzzBnEAoRDZzOQP2/23GyBbyCo1L70hkS+Zyjvq2pm0H8nY
         YgaP0PPkTzXFSFQqxotTACjpWOjHoez7wYvjDEyiQ/nWdZRe9jZ/7QVDOPpmXyR4zVpj
         PRlzF/UvR2LNDec+cKpmTX8Bkb6RJNZd8p1ZbAXaWTFqMU+2cmn+xQ0xSn3F375n6NVr
         xRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755730546; x=1756335346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfAWIm7v3lkDh+EfzxMzZR5V1P0z6xujRrzSrW5QBRo=;
        b=h4sHW9PCIgIqRMLUoARqZeHyx/ubT48najuMn5vDeSZ/GKTX4XyGEULt+z+pjverS8
         Auvb9tGJAWUi+GJF5c2OtjuFyvYoqyT1hSMgl5ahfBTL66DhrLsqgH6qiugl2wcNA8IX
         0Sp0Go9axNTUca6BfiKnzODg84juuvPlS2XhSZjNiYtIlfRZrGaEUFRYq8llKcDW5JEO
         jp0Jiq6rMPJa/0QpcdGSXNKO5lsMN9gp5CG8QY0/U8NbQe5f9tYExB19yodIdHYcRVGL
         +iP2JBCQpQ7O57ChpubHL6hVj0ooOs39e8USQHJ0GjQFFUMhkOWmU8GCRlUkwAk7eHQe
         uMeA==
X-Gm-Message-State: AOJu0YyFdx4DCcKGjj5ZAElsHD2mGKfI5BBkjDpRns0keaRrNoUvQ7Zw
	prK3kr0Bqy8zRg8adBs/B6s/EE+4s1KtwedMevB8tDLdN0bLc52hyWbQCWOwp2iR
X-Gm-Gg: ASbGncvNEsxc1sVK6m/fMjgpriu/Uu2Kox4kteTcSNRgN1HUjg2P16CTDmoO/5Eapr9
	eDLgjS5mBH0SXHH2iTaX5RqhBnSYdmuH+dK7GbHKUPgCqdSHMeghwOSiycYuj78VnoBJntmiuum
	80gnfY8wDQ9Zva98Vucfv1w78ZIy6rUhOIypoTdfNpP/pfDhMsnQNw5e6mtDkRwSS8nEkbivjOB
	3Hq5DuMfGN1wybEcODcJGmTA58yOONVVBRYxd+aWx/QWW0WVHPWlKX9u6HixX+9jIPf90+aQGT3
	ouT3WPFJ1Ta7pLuLfe5GOTpZjWuA9sSP4qGyQxgX8rQbVXWahN2Avz1buMUExhLIGOScERC/JWY
	c64rCriNX2wtCNMXMJIjgkI2Lylogy14=
X-Google-Smtp-Source: AGHT+IEMG9pU5Z185sh/wCyNdiDZkUuBfPTqqilX+TYLQmz0BL6DT0WIs+YpiL8ld2MyuI5z3414lQ==
X-Received: by 2002:a05:6870:b492:b0:2eb:adf2:eb2 with SMTP id 586e51a60fabf-314c660c0eamr182670fac.36.1755730546014;
        Wed, 20 Aug 2025 15:55:46 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3111d32f9e8sm1175860fac.21.2025.08.20.15.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 15:55:45 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/3] bulk-checkin: remove global transaction state
Date: Wed, 20 Aug 2025 17:55:28 -0500
Message-ID: <20250820225531.1212935-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

The bulk-checkin subsystem provides an interface to write objects to the
object database in a bulk transaction. The state of an ongoing
transaction is stored across several global variables. This series aims
to remove this global transaction state in favor of storing state in in
`struct object_database`. This is done in preparation for a follow-up
change where the goal is to eventually move these transaction interfaces
into "odb.h".

Thanks,
-Justin

Justin Tobler (3):
  bulk-checkin: introduce object database transaction structure
  bulk-checkin: remove global transaction state
  bulk-checkin: wire repository variable

 builtin/add.c            |   5 +-
 builtin/unpack-objects.c |   5 +-
 builtin/update-index.c   |   7 +-
 bulk-checkin.c           | 136 ++++++++++++++++++++++++---------------
 bulk-checkin.h           |  19 ++++--
 cache-tree.c             |   5 +-
 object-file.c            |  12 ++--
 odb.h                    |   8 +++
 read-cache.c             |   5 +-
 9 files changed, 128 insertions(+), 74 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
2.51.0

