Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F32423EA1
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052349; cv=none; b=pfupTM7AsifDaJtdVygxiMpa4+utXHr8loBSXdoSHCPvVIqzJs+PIqWNvkWcv6AuAsmI9UJoGBQqBOZXxX8Fz3irXv/wghSiKYfruQ90os75gb0q1nO/IozTHwEk9hC9rZXgqH8B8aRUiqUMPRxiJSrdCenhyQHetYXIILMQ4bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052349; c=relaxed/simple;
	bh=D6MaacfakIhwn9T/lEg77OZn205lbdEtZsQ/bl+WCXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mXs/FFCvxZqC+fEYA0rmuGqHrv3g4GcWsc0dStf+XTCTlRgTUQ3li0gqhqF6GPq98ZKSVox+8XD0Z7/uq1q+300N3SjI8G9/9SGBlUftInYs5sexHXITkM4clstGxEdGR+EsgVNuxR1hqFyN1EO3B2TdrEzI4tPtivOxcqVhjzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s4FxjJj9; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4FxjJj9"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6aca0f482e5so1809939eaf.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 14:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786052344; x=1786657144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+PqHAJa9E7rtSTsgxbI86VZvN172qFQbL6EO9lTOx5E=;
        b=s4FxjJj9umSxSbUP6oXwzCSY89a/6u62kIwLB64K3p7oKOiy9SSOeMrYLd/XFjlq+g
         Gug3wuLouw5Dv6DHcArVlsI+XCDe+sLofFaf8LXlCV2F2oz3WnWbESVEIX46u/zdK5Z1
         vhiueRfR0fT66W+FWaChJO6kdbRMh11OoSUhh9XbODapkW0vvb+/iQIvmvetZ5RQY0nh
         wYMHNJagpcxzla6G5XutjvC1WY64KiNxkeUOGzJsy9PUmfiMYqwlbksJeZFmUgbWoc1b
         e6gJ3PdzyK80aIRiLsKeYG01N6s1l/xUU08PSoufCUQXB53Kd88JphWy7ZCgnq2kcB1P
         VZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052344; x=1786657144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+PqHAJa9E7rtSTsgxbI86VZvN172qFQbL6EO9lTOx5E=;
        b=HUE+bf1XyTbpVfRrzChCp3QMO6/YvxaXNP5Artq8ZFwhxLVJmFlq8odaspOvHEFYm5
         5nCG+F70L6zWXBC/PV74LRFAFTUI3nBOcb+IHaOGigDsnE1Bi8hLtcieVG5fccqgCumW
         GNbOReBK3lX2UOwhJUtdhI5E73OWbqAu7ZdGnVkHo/Xb08NNW3h8kHLn9O1efegxU4Dq
         1kZBzjsgqHUNQlgf9FMYSTlIdrLf/ML+9WhyDV2aIcdO6aU8R/FzT1+cip5IGMhhIzPP
         bVj9S4h8TRFc2pzEx5gwmYkNbqZF+lf+jiH2W8Da4zANQF3jW7zr9nz1ucbPZiA6sV35
         cM9w==
X-Gm-Message-State: AOJu0YyWg9xryZw7/0NtejNwZElvFzXyuzZCdNtEAByEWSM+7WDfh1JR
	009V/sh05wGnVof5FZK9Oll8KdWPRvqEpkMKrZOEw92YyHC5bQQ+q1+yVrHeaA==
X-Gm-Gg: AR+sD12m9sV7wVa91VaeVOZp8j0mgIiMUmp3HIhbYo7jWp9yeurRL86vSCjLxNgDYkf
	VIkR3VDcAcIMX9W40dzN9fe+kC+4Rh/m3MIFfu5GSlS11/O/kU6BNeIrusSfhdAOamaJR4PdS9f
	szZ5tICzzz0CRKvQa6/ozv1l7P9fob4/ondLVWnipM4l4C3LZe9lyS4U90PgfKJ5afpO1x87gON
	dxLLCEcXqoWVAVa/zu1tX7EG4ILS6q0uKj2o5X5eoW4bXM8hMO4HfCn6pupcb4rvvsOFVW9qCJc
	HzqOkEFCvyV0JLCl/FeJedDYPGpy4MsJb1GaFavA9YnhQOYfWgk7TqfXWVns7uAIPnSB5erF2Tp
	I3VVzSjQ1zCveXNcXIAu8YuECWYAjuOTjSRLqHG7qaNzkCopUE/1hUnM0yexKRlYoqYw3Ic6cAk
	FSrIOVF/PQYz6bRn+cLrG8m5sKp3stF90ftRysenfiyqkF44/p4WwdbvEinW9JZjl1vGaY
X-Received: by 2002:a05:6820:189a:b0:6aa:f2f9:b3ee with SMTP id 006d021491bc7-6b0211b73e2mr2807521eaf.6.1786052344454;
        Thu, 06 Aug 2026 14:39:04 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02be475b6sm587078eaf.11.2026.08.06.14.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:39:04 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/6] builtin/receive-pack: support pluggable packfile writes
Date: Thu,  6 Aug 2026 16:38:53 -0500
Message-ID: <20260806213859.816157-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

With bdee7b3013 (builtin/receive-pack: stage incoming objects via ODB
transactions, 2026-07-10), git-receive-pack(1) started using the ODB
transaction interfaces to stage incoming objects. While this brought the
command closer to being ODB backend agnostic, the underlying
git-index-pack(1) and git-unpack-objects(1) processes used to actually
write the objects to the transaction are still fundamentally tied to the
"files" backend.

This series aims to address this by introducing a generic
`odb_transaction_write_pack()` transaction interface to handle writing
the incoming packfile to the transaction. The existing logic in
git-receive-pack(1) that spawns the child processes to write the
packfile becomes the "files" backend implementation of this interface.

As part of this series, the first patch also introduces the
`odb_transaction_release()` transaction interface. This is done to
decouple freeing the transaction from committing it and is used later in
the series to allow the post-commit cleanup of the ".keep" lockfile to
be deffered until after references have been updated. I'm a bit
uncertain as to whether the "release" part of the transaction lifecyle
is really the appropriate spot for such logic though. An alternative
could be to introduce a separate post-commit transaction interface that
would exist to remove any lockfiles after reference updates have been
performed. I am not certain such an explicit transaction interface is
also the best route either. In this version, I've opted to keep it
simple for now and tie the lockfile cleanup to transaction release, but
I am open to change based on feedback. :)

Most of the other patches are just structural refactorings to prepare
git-receive-pack(1) to eventually use `odb_transaction_write_pack()`.
The final patch makes the switch in git-receive-pack(1).

Thanks for the review,
-Justin

Justin Tobler (6):
  odb/transaction: add transaction release interface
  builtin/receive-pack: pass shallow file explicitly
  builtin/receive-pack: lift global state out of unpack()
  builtin/receive-pack: report unpack errors via strbuf
  builtin/receive-pack: explicitly pass packfile fd
  odb/transaction: add transaction interface to write packfiles

 builtin/add.c            |   3 +-
 builtin/receive-pack.c   | 192 ++++++++++-----------------------------
 builtin/unpack-objects.c |   1 +
 builtin/update-index.c   |   2 +
 cache-tree.c             |   4 +-
 object-file.c            | 153 ++++++++++++++++++++++++++++++-
 odb/transaction.c        |  19 +++-
 odb/transaction.h        |  77 ++++++++++++++++
 read-cache.c             |   4 +-
 9 files changed, 305 insertions(+), 150 deletions(-)


base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
-- 
2.55.0.424.g13c7afec21

