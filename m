Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7154D252914
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745590296; cv=none; b=W7w1mqOPEIyy7KmEwEtA3lTE4IyV1BgfYbWnt6Q8aQ85/8/CSi+EeGXobw9Wchk9Xf0YP0NnsJ+ObDowBwntMZzjEwx6C/u6ZDo+oGcq2D+9ivGiWCdT1mfT7MOQ1GYshjZWVGDdaluynhEaP8wbQCgyTshHISSaZfVBtkFDIl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745590296; c=relaxed/simple;
	bh=jzw2SqKOdgyw0AAZE93DhBfubMkPI8EPzNC3isYp5O8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ZY/yiKcvl3uQm1YxCz/1aZK0sroQAQ9NfHHQ3wFbyhdw1Dw3CAuO2P+LYgVeJajWIZb2UDdb0hDHVD7f1rxv8b6XJf/xlvj6srVdVGJ9gGA7cJOzTed0IlTWkYHvqt0HiG2NP4gnPM+EGcjsqCrpB4f3DuOjGceruTVzRPnShOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yJmB2elC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DEPt18ts; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yJmB2elC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DEPt18ts"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 4703B114007C;
	Fri, 25 Apr 2025 10:11:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 25 Apr 2025 10:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745590292;
	 x=1745676692; bh=6lsCbnnca7efJJRnx8/hCUndGuZrTF5i9cKZrt3LfAg=; b=
	yJmB2elC6k9gN6zvhjH9uubc3jQ8aPcJtKlp3kOjLPwIGX60ai8vI/LJhPZisvUr
	wupj63uep7STInek/FDatLKkeT4E5x8JL9fY2AUx+mwiIhTZhrtac8Q3McqYN94o
	ujPDU5SnQ0wOhxHo6e/nj9zm1Q0A3xuQ6h2pEO1s+k2iR//AuuP9PiQgMq133g8K
	xXdKidWxy5Sg0kr9bWwO3wWxR5bRODArMFSqB3RHj1oO5Yd0SsMA4kLfA+VhjOtO
	GXMu4FuDxzZsnmgv9wkGys9VICs06eu9HttTJJLnF4CpUCEMqI+6PxmjblYd41+8
	GgRMBIYgFvtOlFQgZyw6eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745590292; x=
	1745676692; bh=6lsCbnnca7efJJRnx8/hCUndGuZrTF5i9cKZrt3LfAg=; b=D
	EPt18tsNbMPPIRh5zY7Qk7YQ5+LWCosnohNub/b+kvqKXTLsr+NyE39Sxc4GO/3Y
	3Y1egqV+UudbIX6+oG2m04E1cSwqu7Sc8Dts/dTTpnRXjZyrg72Netw5mmrqXTFV
	0N4L9qk9ePWIafXGxkJ1tQCgmc3HYRIu5lk6DGCI4og63wiqEPqikTnQz4Ng5jY5
	T9bhYtsrw8/kqETkbTW/JAXdHAqdHZtjOD/dahm22WpPHttvuFLZZEWBfN4N5wBG
	YLoBLBJ3ZDdnk0n7idvggweWchnoR+T5FW17DFxOeAlT0ZOhuDtqoJnfEAMYRN7X
	ymGppZ6QMMqmYHA9TpXMg==
X-ME-Sender: <xms:E5gLaMEzI8o3lenkxCAxhAWGbpMntWahnEKQJD31BnMQi79OS8qXzQ>
    <xme:E5gLaFWLXg3KPVzDLK5EaO1p2PDDoP51QwOwmkWAtsJkX2tN1wrTqZet50iMr6g7u
    tCH43RdowmUKQJ3SQ>
X-ME-Received: <xmr:E5gLaGIJLMLiUMrnfeiIyhJJ4BCeTv7gQwMHcHSevwR8zlnjKGVN-5Hlg81nX03Bi2ln3GFrBBh3WSe_0DpV2HnDcKu7RQjD63NPSp6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhht
    iiesghgvnhhtohhordhorhhgpdhrtghpthhtohepphhsrdhrvghpohhrthesghhmgidrnh
    gvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:E5gLaOF2aSQ-0SCFpJIMpaQIbQ7GxIpjhwFwveZhT0Iaw2d6xqjYjQ>
    <xmx:E5gLaCWIZTM0rPkfXlR8_bKg2t3yGnVxQXc3ujBScxdqeM7RB3sRig>
    <xmx:E5gLaBPSjjPUBoFAVE2GwFel6Hwmbaz7xSkekXhZcaqXt5ZdTNIpjg>
    <xmx:E5gLaJ0Vrtre1BkFzWrYeCQcOTj20CCtT2KiGgGYJ9n0nuVvLOxVUg>
    <xmx:FJgLaI8HlS0ac8xokbwQePySSb5g3yWmH_61QRtHYxo6nuk4Z9fvTvjE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 10:11:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2e3aff8e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 14:11:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/2] meson: prefer '/bin/sh' over PATH lookup
Date: Fri, 25 Apr 2025 16:11:27 +0200
Message-Id: <20250425-pks-meson-posix-shell-v3-0-01607a2e9334@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA+YC2gC/4XNQQ6CMBAF0KuYrh3TlrYJrryHcQF0kIlAScc0G
 MLdLSyMG+PyT/5/swjGSMjifFhExERMYcyhOB5E01XjHYF8zkJLbaXRBqYHw4AcRpgC0wzcYd+
 DKV2pnMqlxoq8nSK2NO/u9ZZzR/wM8bW/SWq7/hOTAgnGonSIpnaVv+TeiQaxcUl/E/YXoTPRe
 t84pQurVP0h1nV9AzJiVrr6AAAA
X-Change-ID: 20250424-pks-meson-posix-shell-4969161025c5
In-Reply-To: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
References: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
To: git@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>, Junio C Hamano <gitster@pobox.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Hi,

at GitLab, we recently got a couple of bug reports about Git not being
able to find its shell anymore. The root cause is that with Meson we
have started to look up the shell via PATH, which may exist on the build
host, but not on the target host. We have worked around this issue with
a cross file:

    $ cat >cross.ini <<-EOF
    [binaries]
    sh = '/bin/sh'
    EOF
    $ meson setup build --cross-file=./cross.ini

But this made me remember the report from Peter [1] that Debian also
faced this issue. So I decided to address the issue in Meson directly by
preferring `/bin/sh` over a PATH-based lookup.

Changes in v2:
  - Simplify how we generate the summary.
  - Add a comment to explain ordering of the program path.
  - Link to v1: https://lore.kernel.org/r/20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im

Changes in v3:
  - Stop claiming that "/bin/sh" is a POSIX-compliant path.
  - Link to v2: https://lore.kernel.org/r/20250425-pks-meson-posix-shell-v2-0-fddc6123511b@pks.im

Thanks!

Patrick

[1]: <20250209133027.64a865aa@gmx.net>

---
Patrick Steinhardt (2):
      meson: report detected runtime executable paths
      meson: prefer shell at "/bin/sh"

 meson.build | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

Range-diff versus v2:

1:  e749055ac00 = 1:  750aa492d76 meson: report detected runtime executable paths
2:  159a05d3533 ! 2:  d6417ba5ff6 meson: prefer POSIX-specified shell path
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    meson: prefer POSIX-specified shell path
    +    meson: prefer shell at "/bin/sh"
     
         Meson detects the path of the target shell via `find_program("sh")`,
         which essentially does a lookup via `PATH`. This may easily lead to a
         subtly-broken Git distribution when the build host has its shell in a
    -    non-standard location that the target host doesn't know about.
    +    location that the target host doesn't know about.
     
         Fix the issue by appending "/bin" to the custom program path, which
    -    causes us to prefer "/bin/sh" over a `PATH` lookup. As this location is
    -    specified by POSIX this should make us pick a better default shell path
    -    on all POSIX-compliant systems.
    +    causes us to prefer "/bin/sh" over a `PATH`-based lookup. While
    +    "/bin/sh" isn't standardized, this path tends to work alright on Linux
    +    and BSD distributions. Furthermore, "/bin/sh" is also the path we pick
    +    in our Makefile by default, which further demonstrates that this shell
    +    fulfills our needs.
     
         Note that we intentionally append, not prepend, to the custom program
         path. This is because the program path can be configured by the user via
    @@ meson.build: sed = find_program('sed', dirs: program_path, native: true)
      
     -target_shell = find_program('sh', dirs: program_path, native: false)
     +# Detect the target shell that is used by Git at runtime. Note that we prefer
    -+# '/bin/sh' over a PATH-based lookup given that '/bin/sh' is the location
    -+# specified by POSIX. This lookup can be overridden via `program_path`.
    ++# "/bin/sh" over a PATH-based lookup, which provides a working shell on most
    ++# supported systems. This path is also the default shell path used by our
    ++# Makefile. This lookup can be overridden via `program_path`.
     +target_shell = find_program('sh', dirs: program_path + [ '/bin' ], native: false)
      
      # Sanity-check that programs required for the build exist.

---
base-commit: a2955b34f48265d240ab8c7deb0a929ec2d65fd0
change-id: 20250424-pks-meson-posix-shell-4969161025c5

