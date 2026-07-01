Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAF03DA5DB
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908333; cv=none; b=YzrGCTML5S05crO1o3qZCJ2QHGLVZHmlHUzcO3FzdcXiaNIuWgaWVMxK3S8KKPx4Q1z7hPsLdOMttbFIBPsp7tAOIQQBf6L/CJx9Utn/dQBxV11Sxb5gP4Z0G2yjHolQy6nSaVwfF/X+IuBGpPcn9zoNNQSUVbnqleIImCO5Fbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908333; c=relaxed/simple;
	bh=vj/HZG46tE9Xr+z0MD2ZBORgXol4rfDU1gj1MCD4nog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFq7Cty7GYzErYRpsg31GRWzQKHthcBkEYVwh92HHZg4eq1eKoYnibgCLdiOjPLJII5bSDM7D0T5O7C3XWVU/oe/iy1kh7kC+KTDyqY5GTEtQ7pfEacpSy5+yTtSlPFoGcOTS2ZV5SfC5xhfTBgEkQXOpq1G6dh4oxs3fCekSaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pz6wlCG/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pz6wlCG/"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so3091035e9.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 05:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782908330; x=1783513130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHVrwQG2sCdYD6mf9GgNO1KcIEjvwr13NGUllaWa9Ik=;
        b=Pz6wlCG/5BMafcMHDL6dbzU8zUVp854QgS6IOHCrYZ1ISbgrjGg949/8r0ApuV5Qf5
         Q0Hjm+CbU9ukcHL1XFWg8Sli32kxZ4yz46TKAVSRLSelmi29pxVgmqRaUhub6CPIdky0
         3j4e0pWs2qaHP14n0+suXPb1ueXIpNEquMAlRUYNKSAieZ+CTUoKbTeZIPT3CjySKRgs
         xuZQtCIfWbelVYALNAhAte0eFvTamlwW5wDwBKqpRyZD2gXmk1uN2c/WVJE2Y1N9QpwB
         v2DK2EtD/hlEp9ru7UYl4xaFTEGL7k+K0Dk5erL/w9ODNcnHpjGv2mxrxelqd1fTZlWB
         7y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908330; x=1783513130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WHVrwQG2sCdYD6mf9GgNO1KcIEjvwr13NGUllaWa9Ik=;
        b=fsDEnrWgSJGbjZGL7iCvQrfrySaBEOtCIPzuzSwf0GDaz9wOSIRfydGveBPn0A0QDN
         BmBtJYDjtCwh6G2Q0rVzAlP4DarfJCURG+n7HbA//GcshOnkRGpewu9z1l8u9RPSuu3D
         0cEb0YeTCIUzebwzHsdSfh+JainK4INLCvP10jznV1ToPXARmVybHN7F1MZt7985g53m
         0mOrvslB2ze3IkMwTPyPY/pOQPwqX1OICHNea+DtmsWiJE96Du3aa0a5Lm4YOWXpb7Mp
         kxoAeL7CRGY1niwCBXgz106gON4gKImll8Y4ADSzaY90zbD36+LmyDEIRdgws0Q6lnus
         fslw==
X-Gm-Message-State: AOJu0YybQCnOWbmIaLRiqsCgHmJ3XApI8gsmpLa0TvziziiwseSyXqis
	QPZZ5vOSj7inUsf6EFan0tM5Klc9rV6A0otqF6hl2QAL1Hazl4V+Us5cQ9ACQcOo
X-Gm-Gg: AfdE7cnNSanMHUks26in9RsR24mjEbS7iZhI8SNyOTqAVKK4aQJ7DQGEacSLNhuAg/x
	s4zMmGSPM6ZNKx/KQ63Z43jjzdgRYeEx34j+k9Xn7gYLfPvBRGDn47kMMnv4Kt1VDbTa1uX5+Nw
	aNOreyQv3QT2ndcdpoYYWrmeEjnYqjddy6uqJQS/WIm5qj3W+q/n799coV8bUyjJ4Q7orkFApc7
	WETVIyPa3LhObt3m1rQCis2FEmbrttgBFqGpUWyFz4ywXEl1h4LtLk/UMIdEEJtAbkssoufwl8u
	C3c3Tvw65FTeA53MOW2AqatLUkCADRo46dRnzV5sYnhbeXIs590ZBw8mFx4+wFFHxBBVnLt8Zkg
	7ZkSrsCMgF7mrxv7QcUUYEhZRcehapiMRVI3knZz8D2pOgabtLdowk2lzvdWiocLQ1rfEHGmmM1
	luoGgW6ECCsvGVjZtIbEXshIBHUMOAhIDWZ2QjKTgLujQ0EeGfAfrIXUgAUx4NlroEi+MjM2ZaK
	BGyUL1FXCzD6YgyKDDFnlD4P24ZIn/DRZOSp1d5zRMuGOM5NFju0Ld92ncGQFHanYYNZ+9Tnd6+
	I5bDmvm/ed9BLk9mgttsVcM2p24MH/huBzJwtcqE3MPwjM/9V8ZswfX70mQqCa6Z7fTlIplxjew
	DoruWUBMERAwkJvhxJCp6
X-Received: by 2002:a05:600c:e494:20b0:493:9661:f55d with SMTP id 5b1f17b1804b1-493c3cfd391mr4580365e9.30.1782908329958;
        Wed, 01 Jul 2026 05:18:49 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810be8sm68267235e9.9.2026.07.01.05.18.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 05:18:49 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v15 00/13] cat-file: add remote-object-info to batch-command
Date: Wed,  1 Jul 2026 14:18:34 +0200
Message-ID: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
References: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260608-ps-eric-work-rebase-b73ae84ba671
Content-Transfer-Encoding: 8bit

This patch series is a continuation of Eric Ju's (eric.peijian@gmail.com) and
Calvin Wan's (calvinwan@google.com) patch series [1] and [2] respectively.

Sometimes it is beneficial to retrieve information about an object without
having to download it completely. The server logic for retrieving size has
already been implemented and merged in "a2ba162cda (object-info: support for
retrieving object info, 2021-04-20)"[3]. This patch series implement the client
option for it.

Eric's series adds the `remote-object-info` command to
`cat-file --batch-command`. This command allows the client to make an
object-info command request to a server that supports protocol v2.

If the server uses protocol v2 but does not support the object-info capability,
`cat-file --batch-command` will die.

If a user attempts to use `remote-object-info` with protocol v1,
`cat-file --batch-command` will die.

Currently, only the size (%(objectsize)) is supported end to end in this
implementation. The type (%(objecttype)) is known by the client's allow-list
and request path but is not supported on the server side nor the response
parsing. A follow up series will add full end-to-end support for %(objecttype).

The default format for remote-object-info is set to %(objectname) %(objectsize).
Once %(objecttype) is supported, the default format will be unified accordingly.

If the batch command format includes unsupported fields such as %(objecttype),
%(objectsize:disk), or %(deltabase), the command will return empty strings for
each unsupported field.

This series completes Eric's work mainly with the refactor of the validation
of the placeholder with an allow-list that filters what the client asks with
what the server is capable of provide following Jeff King's idea [4].

GitHub CI: https://github.com/pabloosabaterr/git/actions/runs/28435046129

[1]: https://lore.kernel.org/git/20250221190451.12536-1-eric.peijian@gmail.com/
[2]: https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@google.com/#t
[3]: https://git.kernel.org/pub/scm/git/git.git/commit/?id=a2ba162cda2acc171c3e36acbbc854792b093cb7
[4]: https://lore.kernel.org/git/20250313060250.GH94015@coredump.intra.peff.net/

Changes since v14:
- Changed strtou_szt to be strtoumax_szt so there are no problems
  between `size_t` and `unsigned long`.
- Reworded commits to be more consistent and clear.
- gitprotocol-v2.adoc documentation is now being modified on commit
  [9/13].
- Added BUG() calls on [10/13].
- style and nits fixes.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Calvin Wan (3):
      fetch-pack: move fetch initialization
      serve: advertise object-info feature
      transport: add client support for object-info

Eric Ju (4):
      git-compat-util: add `strtoumax_szt()` with error handling
      cat-file: declare loop counter inside for()
      t1006: split test utility functions into new 'lib-cat-file.sh'
      cat-file: add remote-object-info to batch-command

Pablo Sabater (6):
      transport-helper: fix memory leak of helper on disconnect
      fetch-pack: drop static `advertise_sid` variable
      fetch-pack: move `write_fetch_command_and_capabilities()` to connect.c
      connect: make `write_fetch_command_and_capabilities()` more generic
      cat-file: validate remote atoms with an allow-list
      cat-file: make remote-object-info allow-list dynamic

 Documentation/git-cat-file.adoc        |  29 +-
 Documentation/gitprotocol-v2.adoc      |  11 +-
 Makefile                               |   1 +
 builtin/cat-file.c                     | 221 ++++++++++-
 connect.c                              |  34 ++
 connect.h                              |   8 +
 fetch-object-info.c                    | 115 ++++++
 fetch-object-info.h                    |  22 ++
 fetch-pack.c                           |  48 +--
 fetch-pack.h                           |   1 +
 git-compat-util.h                      |  20 +
 meson.build                            |   1 +
 object-file.c                          |  10 +
 odb.h                                  |   3 +
 serve.c                                |   5 +-
 t/lib-cat-file.sh                      |  16 +
 t/meson.build                          |   1 +
 t/t1006-cat-file.sh                    |  13 +-
 t/t1017-cat-file-remote-object-info.sh | 699 +++++++++++++++++++++++++++++++++
 transport-helper.c                     |  15 +-
 transport-internal.h                   |   8 +
 transport.c                            |  46 +++
 transport.h                            |  10 +
 23 files changed, 1257 insertions(+), 80 deletions(-)
---
base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
change-id: 20260608-ps-eric-work-rebase-b73ae84ba671

Best regards,
--  
Pablo Sabater <pabloosabaterr@gmail.com>
