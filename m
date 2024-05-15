Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7FF3B79F
	for <git@vger.kernel.org>; Wed, 15 May 2024 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715779565; cv=none; b=upnbuZI57EoxWvH+EbFKX67M6q9R0eSfx6k/brlCpuDsnvzrpS8Tt5cvwuZp2/52loR8hfhXjwa9ev81/jtCTY6141fS9XINH45us2nG7qronFgmz1D1lh6D1/brUuZ1QgfDO9KNsK5uy7JvrG4JjJ+YuTntNaQbAl1zk6VC/mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715779565; c=relaxed/simple;
	bh=o2L1lpxie7UdR43oy1QRoF3NFIiH5VCQCru0U0TTXKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VumQF/bOcDJY2nd8e7+NEEdOmgD4vgJGrFm7As/UhcR5wxE/jHhzjQE03gIB8hj/3tBhRmp4WX0J1NIiB9O+6Gh1CWo5AygPSlMBFe4iM8u7pN8x2jVZJQYs6PW+HPf06TGjL7XCv5L9Vecbspa/IIeobsVFZbZCAvsIu86v5Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7E1jocx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7E1jocx"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-420157ee56cso25821695e9.2
        for <git@vger.kernel.org>; Wed, 15 May 2024 06:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715779557; x=1716384357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aplGTXq+HjwV6Hc6s2n7c1z0ExWbpvfiIU5zJk9t2rE=;
        b=C7E1jocxocQKuYqckE36zGlzPvCvA9vaawbDTjxgEhVzaEQpNGgeHQ1Mi5c5C3PYb+
         KRnuAhpMSjqXxHBJ6c1lsge3Lhjd6Er1NvEpnUTHjwMjwDrfuJi3rcLgK7PC2ReffIQo
         EvVrqPOWkB49yrp5NQHvREBFcfJPLCjogsxUuIz1YsxJvdfporhOuNcEPFVP0NF+ZutP
         yZnoe9xKki5KHHndSA9QNIrwYMo2dZOLXRtQUF1DisUe00xoONvIt66qDh0NWN4zw+BK
         93STcktryDU9hMACE3NAnxCoslfGCKw15K3RJHSoTvywyZKVknO0fCxBMFzieq/1fHZt
         LN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715779557; x=1716384357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aplGTXq+HjwV6Hc6s2n7c1z0ExWbpvfiIU5zJk9t2rE=;
        b=PHkkTuFHrcGgflZ2iKir3L5Qi4Jq2zkltWOs7f7Y5BTGasfSRMLq/KNtBodcT20xA9
         FS4XbKXFUYYFZab5JRyCUVeNsCgVOZpKKcfcgROXxrC3PIftkusfpaSsGLupEwKXlrEO
         2w2EL6CKBpLNJPZK+XOiKP1v971U7p+BGw8a2Pocq4/m24QCYnKQGv4nBtznKPVzQgGq
         wOdOhMQGF77MB5P2BV9eD1pmPVWpIvW6VW1D+UEZ3yJ7TzBuj6Vd0fpqxGT38ggTcaiU
         Vqz6WwwJZOFYTP2XZRhth0eut29/fbTEg+VDhQWT9oJ/iU/yO0xUPpsGo2r8k31CQbN9
         ZCxA==
X-Gm-Message-State: AOJu0Yxhl9q3XqqI/jmBnTvzuDGmsLWjZsXCRFgFtldH3xaqFuZOSiHX
	t/dRxPMu7Ev16ollCcVtWNOZg2ZUCNlQMcnd0GeyO+8OXdyoaHizOmPufA==
X-Google-Smtp-Source: AGHT+IH0xf6H0yiny7nS/eCJ/YkBgb+QtHU8IZwW0++z8qjUJaShBsqToytNtNlDsWYWH1/+y6aDlg==
X-Received: by 2002:a05:600c:5846:b0:41f:cc6f:d677 with SMTP id 5b1f17b1804b1-41feaa38723mr121310375e9.13.1715779556819;
        Wed, 15 May 2024 06:25:56 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4201592e5f3sm117171695e9.43.2024.05.15.06.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 06:25:56 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 0/3] upload-pack: support a missing-action
Date: Wed, 15 May 2024 15:25:40 +0200
Message-ID: <20240515132543.851987-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.45.1.148.g0f5efb064b
In-Reply-To: <20221012135114.294680-1-christian.couder@gmail.com>
References: <20221012135114.294680-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`git pack-objects` already supports a `--missing=<missing-action>`
option, so that it can avoid erroring out if some objects aren't
available.

It is interesting to have `git upload-pack` support a similar way to
avoid sending some objects in case they aren't available on the
server.

For example, in case both the server and the client are using a
separate promisor remote that contain some objects, it can be better
if the server doesn't try to send such objects back to the client, but
instead let the client get those objects separately from the promisor
remote. (The client needs to have the separate promisor remote
configured, for that to work.)

This could work better if there was something, like perhaps a
capability, for the client to tell the server something like:

  "I know how to fetch missing objects from this and that
  promisor remotes, so if you choose to, you may omit objects
  that you know are available from these promisor remotes when
  sending objects to me."

But that capability could be added later as other similar capabilities
in this area could be very useful. For example in case of a client
cloning, something like the following is currently needed:

  GIT_NO_LAZY_FETCH=0 git clone
      -c remote.my_promisor.promisor=true \
      -c remote.my_promisor.fetch="+refs/heads/*:refs/remotes/my_promisor/*" \
      -c remote.my_promisor.url=<MY_PROMISOR_URL> \
      --filter="blob:limit=5k" server

But it would be nice if there was a capability for the client to say
that it would like the server to give it information about the
promisor that it could use, so that the user doesn't have to pass all
the "remote.my_promisor.XXX" config options on the command like. (It
would then be a bit similar to the bundle-uri feature where all the
bundle related information comes from the server.)

Another example use of this feature could be a server where some
objects have been corrupted or deleted. It could still be useful for
clients who could get those objects from another source, like perhaps
a different client, to be able to fetch or clone from the server.

The fact that the new `uploadpack.missingAction` configuration
variable has to be set to a non default value on the server means that
regular client users cannot hurt themselves with this feature.

As `git rev-list` also supports a `--missing=<missing-action>` option,
the first 2 patches in this series are about refactoring related code
from both `git rev-list` and `git pack-objects` into new
"missing.{c,h}" files. Patch 3/3 then adds a new
`uploadpack.missingAction` configuration variable.

The changes since v1 are the following:

  - In patch 1/3 the refactored parse_missing_action_value() function
    doesn't change the fetch_if_missing global variable anymore. The
    clients of this function change it by themselves instead.

  - In patch 1/3 a minor typo was also fixed.

  - Old patch 2/4 that added a 'int print_ok' argument to
    parse_missing_action_value() was removed, and now callers deal
    with only the values they recognise.

Thanks to Junio for his review and for suggesting of the above
changes.

Christian Couder (3):
  rev-list: refactor --missing=<missing-action>
  pack-objects: use the missing action API
  upload-pack: allow configuring a missing-action

 Documentation/config/uploadpack.txt |   9 ++
 Makefile                            |   1 +
 builtin/pack-objects.c              |  48 ++++++-----
 builtin/rev-list.c                  |  43 ++--------
 missing.c                           |  36 ++++++++
 missing.h                           |  19 +++++
 t/t5706-upload-pack-missing.sh      | 125 ++++++++++++++++++++++++++++
 upload-pack.c                       |  19 +++++
 8 files changed, 242 insertions(+), 58 deletions(-)
 create mode 100644 missing.c
 create mode 100644 missing.h
 create mode 100755 t/t5706-upload-pack-missing.sh

-- 
2.45.1.148.g0f5efb064b

