Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CF1207DF7
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 01:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764292876; cv=none; b=fNkZCxld8gkWwORdX/3+IDaQnVf1GYbOW1HT2HKlGUfVbFMdAKQJPvc6s4KwuSNz3UnhSsGjl3bEV1YlC/jfV/qurmecZtTZIA45e0CSTCsGzF+4st4o80CYOCVvJVvh7V1t7V0o12Y4Eci/nME4ODFOqtaOqlPBz3mZkisJs0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764292876; c=relaxed/simple;
	bh=OtigQ3o7NKYA8qmDnYSuCd1uLE8aubuN++uZm1FcgYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S7gZuTPXNANTB/kYT5GRCXJVpSOZBdPbTDd4m3HYpRNMuw/UOHKoJcia862bGB12OOhix4TQR4C2QhHYW54uIuUbfxr9o0gJRUnO0Au1hiM1giMo6ii+OKBKoYEUINJBVgOhVhoGhlEgA2u1G1mRMq38o1qeAPHnwLqhoNesRBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=LuGKZVwn; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="LuGKZVwn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1764292873;
	bh=OtigQ3o7NKYA8qmDnYSuCd1uLE8aubuN++uZm1FcgYs=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=LuGKZVwnoouTJbHK05kTh815NwaRuteAVW1M+v6Ba8E1UZ1TB3pk32SFJiRqGIuq4
	 acg+bM7V80tXlMg4fjoH9woBLOkumcylQreJWilSvObMYLF0CG0xALS2D4V1rH4Z8h
	 7PB+bUsfWhAIq9N0SjGp3NiRsWHXuFXqHI4bFTk9Y5UU2wjEp+rmPvCpgNnGfrOj6/
	 WJgEaPu0Y5XlvwP9XMzFQU7BdmjVbyqkIGTUS5nTkITgXreyUuZzWcat7VSzFHeBra
	 D4ZG+adm4q7p1L/4Id6JWGyLpOJGELIrhhGj1Rexd8n5wIsuQ+JLNPcRY/Dn3m3zl9
	 3TNNYheLpASvdVmdRYxsrncTX/YgU1Qk9/fMkkfbvBomalZZFyi8tySSR11eUst5df
	 0JBs+dDpiy2p8IoTtroyAo44Yb6AnaPYh0o7jTKXGeWDSiD3TYjxb6op/YcxaldDAO
	 Zbza3sCRqM0Fiex/IBvsnt+/wyCvvldRg9KvMvpW8qTGl67HUA1
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d48d:a8fd:1e1f:2dee])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5167C2003B;
	Fri, 28 Nov 2025 01:21:13 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] zsh testsuite fixes
Date: Fri, 28 Nov 2025 01:21:04 +0000
Message-ID: <20251128012107.101431-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains two small patches to make our testsuite pass under
zsh's sh mode with 5.9.  This is the mode that is in use when zsh is
invoked as `sh` and differs from zsh's default behavior.

Note that no attempt has been made to make the testsuite work under
zsh's default or ksh modes, since it is known that many tests will
fail in this case (in part, because outside of sh mode, zsh runs the
final process in a pipeline in the main shell instead of a subshell).

The first patch fixes a compatibility issue in which we've accidentally
requested behavior from POSIX 1003.1-2024, which is too new to be
portably supported.  It just so happens that most shells happen to
support it anyway, but zsh does not at the moment.

The second patch fixes a more mysterious issue with the testsuite
hanging.  It's unclear why it does so, but it almost certainly has to do
with the internals of the testsuite since creating a simple testcase
does not reproduce the problem.  However, the patch is simple and easy
(simply change to a subshell), so we do so.

With these two patches, the testsuite passes in zsh's sh mode.  This
should offer users whose `/bin/sh` is AT&T ksh93 (which does not support
`local` and therefore does not work as our shell) an additional choice
of shells to use for portability.

brian m. carlson (2):
  t0614: use numerical comparison with test_line_count
  t5564: fix test hang under zsh's sh mode

 t/t0614-reftable-fsck.sh | 2 +-
 t/t5564-http-proxy.sh    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

