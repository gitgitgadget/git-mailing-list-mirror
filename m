Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACBD3CC7FB
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701685; cv=none; b=W8c39dklbBK8Min7nPzRF919ksOIR82Wjk4YZDkHIwB6ceiTm81ld1O4pXQk2fYnwj9QH/fzU1Oui9+McIm1wNz8G3pMn968wPrbuxhqcVM69birYJcjfwZ/boJa03SL65L9XnR0+RQm+pWfdgwRP6+aw8clR3ETy9j5wNrujGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701685; c=relaxed/simple;
	bh=F4gUv9BmEzBWYb71z15DrQDplUW7djrmBlG8YqUm7bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYzdacKpywZscvtdGRbJYFTK8qeuM+sxjaHt8tXrEy6u/X9Qd+n5m01N6oeKUhrZdn60pqSunMW/T0jYoNeTpc6euQns42yicf6JwFuye9ogp33XpPWVdaJjWAdPvV5YxZPoHqesc9LIUhkDj9EOJ6FAFMN3BHbY2RlCGx2b5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpifC60+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpifC60+"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so8477665e9.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701682; x=1784306482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aSNzPhCi4k1WxxgGlC+UxEASre31S05D484mMsgaxKk=;
        b=XpifC60+uxLGPT7OwPtkWs6UtC7BINETOLT6/SXYaOQYFIDoAP9vmZBePgatL5Cppn
         zZoeOaasAn7S+x6EaHJPk0rSENXhDBgIa9Crfwl3NhtcufdMQKpmxemLyPaSs4UGMQks
         bZ8f7tT33tjFnMxcASnTabVDrFVDDAsvDmLnAbTRi0uHLervBC2/mkJS2Bc+Gj9hfExq
         wO8I0HaGjG/9kRKqzbLEosmsRlWhh1EGFNhH1tA+M+dsqpf2ea9bvlP4gLg8EWiIkNFX
         VL80wONjLKpxvb05Qs6/3x9UI1r3DD6Dd8xq5vmUu79Jxggwr5efK9i7WeOqAgtQyEzo
         aPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701682; x=1784306482;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aSNzPhCi4k1WxxgGlC+UxEASre31S05D484mMsgaxKk=;
        b=dWquA/8gLkjN9bNNRRqDqAmuf/APV5c9mg0xefpGAo7Mmca0Pn1exxagOSXj8e1RT2
         xgq4+aLGZq5drJM5Z7NRgkpplMH+u6y8mH4m+Xa2cmWAuo1E70gVMiQ5KifJ6tT6Xk6Y
         QJtBIzBojUDsb1LJ8xqLzIpduISW7Kia149TkIs3cn1cYAYi7mzRJR+qDGRU5rCQOpIg
         OOxgnGaaIAqIFb3tmGt83qmCsggVzFr+Jwp7Rb9jCJhbzqxGz41tzUm5fgILWPZtlLnK
         0LygrwRGwRBhBohKP4RlcYn2cKn57Y1w1L0UJE7B/oCDxXpq8lgCRdSX6UjZzkkwq39/
         LT/g==
X-Gm-Message-State: AOJu0YxtR+Gk6z6dLkjZJfYr6a0yUZf8tSfNqY6pG8egqV14+lb0KQd/
	dA61A/08K/eEBEJvoztGeOoc9OewWX31MAYfuobRlwx5FC2ugVcrynS0FYBTa8gM
X-Gm-Gg: AfdE7cl/DTfHvFbvWKo9Xq3ZJashrdcgG6lqZM0LSW0It9KC0Q92N/7ztK2J4PNcEjd
	4hlMGkGWrlgnMlKnVF4vnlHsztVuAAjnbGg1o4woZFerPU42CR8BvsjXxwnbonMEnTvxGcdy/i+
	VPUddp5NziCB95Sgq0P6GvuH5KcaSzv2evW/7kFgQ/tpgSsF1la8ub5yUYrWGreDF5+0yQ4M8Mr
	l6rFbh+wL+nkL5MhCQzE3ru8NVzFJDWMsiiJuIqwv0W8bCPDj0FjbmljlXWbu9YqnfH/IY4cj9a
	oBo8M8R+emKeOcy9NtWzE9ABZaCAqSTSIrVGLS3yB/GSH1n5SF0WMkAqDON6I9e5ZwQXJNey5um
	HDWH1bqDWsd+Kan/kVQfHiDlhJRMsMY3dtqfWHs6Bg7nmmyzFWJ2I6vUNJkDtKBPMwfUL4m0t5Q
	tP+wkenS9iXB7RqYiy3fp8Ula41eHqXovTKNYpyd6kKQpt/cQFX85xLtyDUBrVJGdBo3yRJNfiX
	cehDFN9j/TPhwTMDo8RquiIjfKBWFLlrD6okJFdbN0xnhW0KzNfPSCyIzUPc+uE40n4XERc9+Ye
	24UN1wyCDrbB9qSGWnMCojtwGQdrAFpC/BL4u9wHw1ErD5x/PqAk2Rl1LKdpyCDdCd+JaLZxd98
	0IK/UL39qTQ==
X-Received: by 2002:a7b:cb46:0:b0:493:a87f:52e5 with SMTP id 5b1f17b1804b1-493f2ab772amr32759675e9.10.1783701682090;
        Fri, 10 Jul 2026 09:41:22 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm63643639f8f.2.2026.07.10.09.41.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 09:41:21 -0700 (PDT)
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
Subject: [PATCH GSoC v16 00/13] cat-file: add remote-object-info to batch-command
Date: Fri, 10 Jul 2026 18:41:06 +0200
Message-ID: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
References: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260608-ps-eric-work-rebase-b73ae84ba671
Content-Transfer-Encoding: 8bit

This patch series is a continuation of Eric Ju's
(eric.peijian@gmail.com) and Calvin Wan's (calvinwan@google.com) patch
series [1] and [2] respectively.

Sometimes it is beneficial to retrieve information about an object
without having to download it completely. The server logic for
retrieving size has already been implemented and merged in a2ba162cda
(object-info: support for retrieving object info, 2021-04-20) [3].
This patch series implement the client option for it.

Eric's series adds the remote-object-info command to cat-file
--batch-command. This command allows the client to make an object-info
command request to a server that supports protocol v2.

If the server uses protocol v2 but does not support the object-info
capability, cat-file --batch-command will die.

If a user attempts to use remote-object-info with protocol v1, cat-file
--batch-command will die.

Currently, only the size (%(objectsize)) is supported end to end in this
implementation. The type (%(objecttype)) is known by the client's
allow-list and request path but is not supported on the server side
nor the response parsing. A follow up series will add full end-to-end
support for %(objecttype).

The default format for remote-object-info is set to "%(objectname)
%(objectsize)". Once %(objecttype) is supported, the default format will
be unified accordingly.

If the batch command format includes unsupported fields such as
%(objecttype), %(objectsize:disk), or %(deltabase), the command will
return empty strings for each unsupported field.

This series completes Eric's work mainly with the refactor of the
validation of the placeholder with an allow-list that filters what the
client asks with what the server is capable of provide following Jeff
King's idea [4].

GitHub CI: https://github.com/pabloosabaterr/git/actions/runs/29091116939

[1]: https://lore.kernel.org/git/20250221190451.12536-1-eric.peijian@gmail.com/
[2]: https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@google.com/#t
[3]: https://git.kernel.org/pub/scm/git/git.git/commit/?id=a2ba162cda2acc171c3e36acbbc854792b093cb7
[4]: https://lore.kernel.org/git/20250313060250.GH94015@coredump.intra.peff.net/

Changes since v15:
- Completely dropped the static advertise_sid variable at fetch-pack.c
- Split the hash_algo type change into its own commit.
- Removed strtoumax_szt() from git-compat-util.h (and its commit) into a
  static parse_object_size() helper.
- Removed backquotes from commit message bodies and fixed typos.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Calvin Wan (3):
      fetch-pack: move fetch initialization
      serve: advertise object-info feature
      transport: add client support for object-info

Eric Ju (3):
      cat-file: declare loop counter inside for()
      t1006: split test utility functions into new 'lib-cat-file.sh'
      cat-file: add remote-object-info to batch-command

Pablo Sabater (7):
      transport-helper: fix memory leak of helper on disconnect
      fetch-pack: fix hash_algo variable type
      fetch-pack: drop static advertise_sid variable
      fetch-pack: move write_fetch_command_and_capabilities() to connect.c
      connect: make write_fetch_command_and_capabilities() more generic
      cat-file: validate remote atoms with an allow-list
      cat-file: make remote-object-info allow-list dynamic

 Documentation/git-cat-file.adoc        |  29 +-
 Documentation/gitprotocol-v2.adoc      |  11 +-
 Makefile                               |   1 +
 builtin/cat-file.c                     | 221 ++++++++++-
 connect.c                              |  34 ++
 connect.h                              |   8 +
 fetch-object-info.c                    | 129 ++++++
 fetch-object-info.h                    |  22 ++
 fetch-pack.c                           |  58 +--
 fetch-pack.h                           |   1 +
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
 22 files changed, 1255 insertions(+), 86 deletions(-)

base-commit: f60db8d575adb79761d363e026fb49bddf330c73
