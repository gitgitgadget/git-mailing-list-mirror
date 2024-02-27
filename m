Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E5113B2A8
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050662; cv=none; b=JQAKklRa2uq/4NFSJ+dGJtYkwnyqZuZ+jg/483ucOE4IcExCPDaTMjVFKD7mZHTqubG76lPGoaWgP/HqXb/AdyjZ/b8cYOa9wN1gfHwl0QdD/C0WGN6m49c4JERP/5uFn1/kj8K6aGB0nwOBCBDy97z8OQclvV6xZXDm6r+wVtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050662; c=relaxed/simple;
	bh=g73lqejpaJLAJAKOHBNB7snGG46HYYOulQLbIL0SpKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ke0KfCeXyw+z0x46WEUd4kv5cCZKG4WEdUk6oBUFe2jAMTGuvWSLJxnqE3rziUiTRTTl6CTym9RT7NxUqIqzh1Lq+NEIg8SMXwFuNSTz/eI9XTY0gbgve/PuFTLW4l++x2r5yIvNBHbj4URpZAXYgMqICh6Z8riqUrfkVff7QxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arjQzns4; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arjQzns4"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d288bac3caso30557701fa.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 08:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709050659; x=1709655459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ug2WtDZ1LQylxcumBxKdTxfOqyaXJiqu/glwWKXw6WU=;
        b=arjQzns4Jvrs+xEvGzfcU/zOCJGcq48sbhDweGYyuf+qMI7x4NKpTIRRJfXLFIZpqH
         IE4j+J++GThpXAfo0J3rUecaClqSzT5Ssfn5gTdadsGJ+jtZhIxywUII/cgdJtmJh8Qb
         iL4jbde7g1OnyO34d9Sx/4O5eGtNiPJrCUukg29sIpEP79TbDapXcRZdRRwjVZjXryFY
         BuU7D5O4qk8YLbTWfyoym/vQaJfBtQ8shgLnqls6eq8w8xi5cMc8AHNMWqOOrbJavB8c
         UIDHqyZUJ+uaPSlqv/r0xyFNRdiWsjirXVyJZsC2kWTIEKcyljzWqQXCDjfUnWyjSXnJ
         iDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709050659; x=1709655459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ug2WtDZ1LQylxcumBxKdTxfOqyaXJiqu/glwWKXw6WU=;
        b=ljMgvmrww4mj4VZfGPsNl8BBT9flmEcFZF0gqy9j8KSk+MgTJl1dm6iYKsCqGOYg8k
         j5dsxDH4/8ueCXel1JaWKoCQSvvO+lH0VYMtQR7jIcIGcI2zZKZtVYp7KTOkHo4ryPTO
         tFmZ0quzS+qJZPyDM+C2PkzyJaCvWCdYkbppIH5RXInTko5AI2Ma8yOyzOd9Ncr91fG+
         EiyxZ+/5/97MXzQRTA5hKXhNpJoUi54kXy4s15tFDUA3nbBoD+Nw+YtNvh1nPSR8n17Q
         nvc/qOqbQC1q8wGbhDcVpIt7LXkuSrHCc+jTFQIOdNHjIgivGDdIGNFAuJOFt0QMBGkL
         86Zg==
X-Gm-Message-State: AOJu0Yw6u3hJ71QI0gf9mnBwGyDj63Fe4T72Z5D8hzOx/BKynyGxnI5X
	i29qKvw4KPD2gnpvbNZLQJ08w8duBhWrHaXGXODnuRisMM86SnBuXzFnbtn/up2GLw==
X-Google-Smtp-Source: AGHT+IGmVDoIB4yRXoH2ep2HL50tqaUa/1vKIhnZBf89lMFhcQmgqJd/skg0b9rA8+RyQdEJ0JVZFA==
X-Received: by 2002:a2e:8752:0:b0:2d2:6237:a2ea with SMTP id q18-20020a2e8752000000b002d26237a2eamr7052207ljj.9.1709050659056;
        Tue, 27 Feb 2024 08:17:39 -0800 (PST)
Received: from sacco-Inspiron-5559.. (88-160-103-158.subs.proxad.net. [88.160.103.158])
        by smtp.gmail.com with ESMTPSA id r26-20020a2e8e3a000000b002d28b61d060sm764830ljk.133.2024.02.27.08.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:17:38 -0800 (PST)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: git@vger.kernel.org
Cc: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [GSOC][PATCH v2 0/1] microproject: use test_path_is_* functions in test scripts
Date: Tue, 27 Feb 2024 17:17:33 +0100
Message-Id: <20240227161734.52830-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219172214.7644-1-vincenzo.mezzela@gmail.com>
References: <20240219172214.7644-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Following previous discussions[1][2], this patch is submitted as a microproject
for the application to the GSOC.

Thanks,
Vincenzo

Changes in V2:
* Fixed commit message[2].

[1] https://lore.kernel.org/git/xmqqy1bo5k5h.fsf@gitster.g/
[2] https://lore.kernel.org/git/20240219172214.7644-1-vincenzo.mezzela@gmail.com/

Vincenzo Mezzela (1):
  t: t7301-clean-interactive: Use test_path_is_(missing|file)

 t/t7301-clean-interactive.sh | 490 +++++++++++++++++------------------
 1 file changed, 245 insertions(+), 245 deletions(-)

-- 
2.34.1

