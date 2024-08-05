Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E9114830D
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 23:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902386; cv=none; b=S7WeqaKm8dTaMKjhpWMbPvBfKGyBOYKjNFCPBiZAW6PHCLb4ceaXXtXQhfaz9bHALnOakbDI5gCiA/wR35RGfHiMRJhGc4WuumH3sO5Hq0X5KFDFPFxzjnaK3eVR9EfNJ1SfybW/A27iWaHc3zDbiGSePwv5h192g1m/qNBVKqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902386; c=relaxed/simple;
	bh=q8YXDuwMqS3hhWBJvXC4Xn4Kj0lndNyAvBzjkk4QHoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oztdsv4p4j4bm98ufsajt6R0pJhA8n1iPgFV+SY6Y0TrcpV7snog0GyQGUfuFDjE9d3H8o51s2C+2DFJcNDtrRKttfzO43YLBvspXzZLMsEQueJnjSZaUUTJPUKl7bcClcQgbKm6UNVCjPGSdqgMvgxPNEBUNf6VfSk5Yk+8ruA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIbeBqDd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIbeBqDd"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42816ca797fso69396325e9.2
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 16:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722902383; x=1723507183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pq3ro5IH1OG7l56beatb7MQ5O2PtY/Nv8PQPpKCn1i0=;
        b=GIbeBqDdqEpHid1iy41DDIh4mxFDiIurt9xejKZuf3mb1Zj1tVNMWmUlT1L/S8arE5
         YQZb/PNkWHgPOPX/zn24kgTBLL4eq6+wgsMeGYiFkCxMvc0vMdkOJsHn6sVPY31H0n0L
         +6SC3GGIku6lzkJiaPMe/4PZpaw2Y1aH5WL1W0hlli0R964i0yCHJEBCIoBGhOKPXzT0
         jf2fSBxXeQKfCP62jRjPhC4Op2/w+qjUl/GrL3yqq7jIr8ngf6Go3v9yHt3lQo2byVhc
         01o+SFHT3S21MzcEyvUnrah+J7bJYIu5hA+2rFIMNaZIsF3GEAYElxQZT2G7beh8J9uS
         AYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722902383; x=1723507183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pq3ro5IH1OG7l56beatb7MQ5O2PtY/Nv8PQPpKCn1i0=;
        b=UA5boXrfkvOmFBtYI/PQFk6cJIcsU0RhZCyTcKyEvoUYumEa9mLNiZ0VjSd+QDRBit
         FFKL/FSvQB9fONTyDKuyWcrIYgSkBlSPeaFmaKtUTW+j4Il99VHAD5/Pr0RCivS5/cWA
         4/gUtMb2medem7h9++qL/ztToM9V1P00hNLzN4rsyuKHWxNgFDkEj1ltc8bNu8wbDgSx
         9vfnMhWpWNJ57yqjiaatMKb3QOjgCiL0mVQ6pa09XS5VMXZC+YDvHnFG2jDBCUj8uGXJ
         j0sM+oZA9ccM2Q+5tWFy1ebTSv0YKxoWFZea0eRGnb1UXjbfvDVjbpiIkqisePZcWIOo
         FsbA==
X-Gm-Message-State: AOJu0YwOZb0jLg2Z+SIjLxCeHtxTEMhmSGK7TfRv3A51h4o3VrLIxegG
	JOkOTQaX+yv7UNJFLrb+czvkKCrl1r0VUUgUugDOdXta1+4g84Ipfik910D+
X-Google-Smtp-Source: AGHT+IHyydjwY9nfopqKVUVI6ReyZF0C4WhZ9Q4bEmez/LFti8YZm+4cfE+2amXfJqjeVWQJOB8aXg==
X-Received: by 2002:a05:600c:a41:b0:427:ffa4:32d0 with SMTP id 5b1f17b1804b1-428e6b7b614mr96875305e9.28.1722902382742;
        Mon, 05 Aug 2024 16:59:42 -0700 (PDT)
Received: from abdobngad.. ([197.40.47.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd074583sm11219065f8f.108.2024.08.05.16.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 16:59:42 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v4 0/8] t7004: Modernize the style
Date: Tue,  6 Aug 2024 02:59:09 +0300
Message-ID: <20240805235917.190699-1-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Remove whitespace after the redirect operators.

- Move number of expect files prepared outside of
  test_expect_success to be inside the tests that use it.

- Split some lines that have two commands into two lines
  one command each.

- Turn some "<<\EOF" into "<<-\EOF" and indent their body.

- Avoid using pipes in the output from "test-tool ref-store"
  and write the output to a file.

- Change test_expect_success that are seperated from its name
  to be on the same line.

- Avoid separating test Description and test body with backslash

- Use single quotes instead of double quotes for test description and
  body.

AbdAlRahman Gad (8):
  [Newcomer] t7004: Remove space after redirect operators
  [Newcomer] t7004: Do not lose exit status to pipe
  [Newcomer] t7004: One command per line
  [Newcomer] t7004: Do not prepare things outside test_expect_success
  [Newcomer] t7004: Use indented here-doc
  [Newcomer] t7004: Description on the same line as test_expect_success
  [Newcomer] t7004: Description and test body seperated with backslash
  [Newcomer] t7004: Use single quotes instead of double quotes

 t/t7004-tag.sh | 1154 +++++++++++++++++++++++-------------------------
 1 file changed, 557 insertions(+), 597 deletions(-)


base-commit: 406f326d271e0bacecdb00425422c5fa3f314930
-- 
2.43.0

