Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4385E3CC7F3
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913691; cv=none; b=UPL1s2au3SCZD5tcKjxAV9i3odHvjnSEPDS1uNvDr/hhmZVt3JLaUhGucH8ueDNs1TBWWzOetA/9Yc9eAirzV8knY//8Z7LryiY/86z4n4Dxn/PHWB45pRcK9x5nxZplY8WjEg6f8mWk3t6bhOg37OFIWljmgtEpcdfGuacTYnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913691; c=relaxed/simple;
	bh=KJU0LPfHAjKLAqJ7t2na2ElPDCEWAV1v6ysFDbEbSFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nswawbi5YffJbE0zTs/uJyTMSoubRIf/8wqfT+sOGM+eM/HrMAGeLYhagOC6D9GinjO0hVPxxmlvBW38YHWx9zG5OcaXI+F//GutZR8loE729ikiEa3oWuJ07nPoegmd25spgcuBy7fkF/IlIThzRgsO7p9b+5jESv3I6JlPKy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lf+lhrDD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lf+lhrDD"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so3160057f8f.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 03:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780913688; x=1781518488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqAlYZGhQSFwpCeAVz2TuH6EKkClegzZDIxxAHxrC50=;
        b=lf+lhrDDqnRpsTmgISG/napCZa9+wvNDU0p/UzGyNbtdxyd7ANAJG4VBoXf9kcvAAf
         eNBsGvd8TDuYvEpWW83kpiwrPT1cVgfw6xJG0k/79qwgvLmOw8g/ZOatDauVpADxsnI5
         D7SLRDEgsUqct+3tWaKHJr9pUka4reA0nh3hrClWfBaYC/sm8W1dN6BlYIx3/vqxTwyY
         wnv1kiDTylyX8Dim6Em7VvJaNDM/9rvAx3iLVaxgA8KgZ/m1J1Ay7hRKAd+4TJReoPxD
         1k1wrMl5Uf5H6j5txdwd3mm05AB7jsfmZw2jZtsVfcrGR1nwRMlT94Dr6thEsqC1wgjw
         tOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913688; x=1781518488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OqAlYZGhQSFwpCeAVz2TuH6EKkClegzZDIxxAHxrC50=;
        b=qHTPGKBQ72vczz/FGHrYW6QqdZW2BPnRvRg49Oti0LkocmKQBxdVl+TBhTeavfDNrd
         xoB4z2H3I3xvxo+dlziCGFzECJjyEqmZuTKVO+2rYzf2yX/vnfSOxTMYjC/TI6ttS3BR
         B2A5tXxaWdtZCN0IzDaiKC93uXdjRyWwtcm+3SJTQJiO2Qnw5Z/ZvUiKcQksK3tmQUxw
         VefhW8Tldfw3YTNkfRBXq2l9Zr0xd10i6Eh6oYEkJOMUJlGvLZf/3gy1MRj0HseXZKGX
         jgG7Y9TurJPPlInH0C53IP6Qn5/aaNhZTFItuIbekjKe8UzJJmgIwqSE0a0lc42XNGMY
         YOAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Ye6/lyM5+GhUrIwjbUFzLy/zvj7wO0GQzCHJ93wepctBQ6rSO6AY+hwQfdtEIv4uvDPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX1GVOI+sA7MVgfr6khefU6BbgmoHClzfCOMtQIzWoC4uSKefP
	Qf/X3BMk8QpbgjzLQmQiSSMksMfqA/Ih/fiy+kHCPAauNCUTbszl6Lvt
X-Gm-Gg: Acq92OGdkefIN5Ch7xnR1kIxNzDYh6I/7Lj4xVq5L1lZgN2xEJ62JhRF6Qns7ioiUw0
	uwb+h1BPw/q7hJZsn57hhqE60W/BVLg7h0qCYMaEenUfebam/mdihmxZp2EFRBjGZErE7A2+LPH
	lk/tZeE7c2ESeuJix+yQrbckuVq6r+QFR2109mHCyEfYhSKXdbxf8B+j9mM0wiqkZJn0RyuCk9g
	JLYw303ztVFhRfTGe0PfvGitxhAzjCvjfFfcgSZA52Kp5Tipu+Z82sWY4M291UVeQ+pQNDe3ZAC
	LNc9T417NArDS77nIBR2ChWWIwUn0+9+EnmF95/eacB2PILjiOPz11/YdMbT4HanmYxPpB2WnYx
	QvGcPmomUa8Opb7uKWtCOJfHUuCYyVc7I8JNFj8mGlAeuYQrJ3D+SRvglFyRzFkGz1k4xC/HE5i
	FB+eCISBF0GVwN+CRBnhKd+d51/dGVM0MNq37h5xTbJ55fywNoH1JlFt0WxR1gAkVZ7YVkbCMoO
	SenZl9KJOdxk9AHj62XskXzayGpOkceE5L4zdhqQWj5xyoi0gFqXsaySJieA9a41fWLhe/tZ4rE
	AEZ8Fej/k8wmot6hygQLJ0qda3JOxWVlar6uiWQz/7TkNSqyVJNDQTcAuZ8TrTzEYA==
X-Received: by 2002:a5d:4d4c:0:b0:43d:50c:6f33 with SMTP id ffacd0b85a97d-4603060b001mr16709877f8f.26.1780913687410;
        Mon, 08 Jun 2026 03:14:47 -0700 (PDT)
Received: from localhost.localdomain ([188.87.4.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm51131949f8f.0.2026.06.08.03.14.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Jun 2026 03:14:47 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: eric.peijian@gmail.com
Cc: calvinwan@google.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	jonathantanmy@google.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC RFC v12 00/12] cat-file: add remote-object-info to batch-command
Date: Mon,  8 Jun 2026 12:14:23 +0200
Message-ID: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20250221190451.12536-1-eric.peijian@gmail.com>
References: <20250221190451.12536-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260608-ps-eric-work-rebase-b73ae84ba671
Content-Transfer-Encoding: 8bit

This path series is a continuation of Eric Ju's (eric.peijian@gmail.com) and
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

I have a question for the design:

1. If the format includes unsupported fields such as %(objecttype) or
   %(deltabase) it currently returns an empty string for each unsupported
   field, this follows what for-each-ref does with known but inapplicable
   atoms. However future placeholders that will be implemented: %(rest),
   %(objectmode) can return empty strings. How should we differentiate
   "unsupported" vs "no data".
   Eric proposed to use a placeholder like "???" [5].

[1]: https://lore.kernel.org/git/20250221190451.12536-1-eric.peijian@gmail.com/
[2]: https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@google.com/#t
[3]: https://git.kernel.org/pub/scm/git/git.git/commit/?id=a2ba162cda2acc171c3e36acbbc854792b093cb7
[4]: https://lore.kernel.org/git/20250313060250.GH94015@coredump.intra.peff.net/
[5]: https://lore.kernel.org/git/CAN2LT1D3d=yMYVhBjpj5PvyjfTVjwqcFPNViuCJ=f49YbCZuJg@mail.gmail.com/

Changes since v11:

- Rebased onto current master.
- Added fetch-object-info.c to meson.build.
- Added t1017-cat-file-remote-object-info.sh to t/meson.build.
- Fixed style feedback from v10.
- Replaced strstr() validation with a dynamic allow-list in
  expand_atom() based on server-advertised capabilities, filtering
  unsupported options in fetch_object_info() before sending.
- Unsupported placeholders return empty strings instead of die().
- Initialize data->type to OBJ_BAD with NULL check on type_name().
- Moved global variables to local scope in parse_cmd_remote_object_info.
- Decoupled batch_object_write() from sizep so output is always produced.
- Added remote_atom_map[] for protocol-to-atom name mapping.
- Included "type" in the client request path for forward-compatibility.
- Fixed memory leak of data->name in transport-helper disconnect.
- Changed error message "not our ref" to "server does not recognize object".
- Split fetch-pack refactoring into two commits (move + refactor).
- Updated caveats documentation and tests.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Calvin Wan (3):
      fetch-pack: move fetch initialization
      serve: advertise object-info feature
      transport: add client support for object-info

Eric Ju (4):
      git-compat-util: add strtoul_ul() with error handling
      cat-file: add declaration of variable i inside its for loop
      t1006: split test utility functions into new "lib-cat-file.sh"
      cat-file: add remote-object-info to batch-command

Pablo Sabater (5):
      transport-helper: fix memory leak of helper on disconnect
      fetch-pack: move function to connect.c
      connect: refactor packet writing
      cat-file: validate remote atoms with allow_list
      cat-file: make remote-object-info allow-list dynamic

 Documentation/git-cat-file.adoc        |  25 +-
 Makefile                               |   1 +
 builtin/cat-file.c                     | 191 ++++++++-
 connect.c                              |  34 ++
 connect.h                              |   8 +
 fetch-object-info.c                    |  93 +++++
 fetch-object-info.h                    |  22 ++
 fetch-pack.c                           |  51 +--
 fetch-pack.h                           |   2 +
 git-compat-util.h                      |  20 +
 meson.build                            |   1 +
 object-file.c                          |  10 +
 odb.h                                  |   3 +
 serve.c                                |   5 +-
 t/lib-cat-file.sh                      |  16 +
 t/meson.build                          |   1 +
 t/t1006-cat-file.sh                    |  13 +-
 t/t1017-cat-file-remote-object-info.sh | 684 +++++++++++++++++++++++++++++++++
 transport-helper.c                     |  13 +-
 transport.c                            |  28 +-
 transport.h                            |  11 +
 21 files changed, 1158 insertions(+), 74 deletions(-)
---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260608-ps-eric-work-rebase-b73ae84ba671

Best regards,
--  
Pablo Sabater <pabloosabaterr@gmail.com>
