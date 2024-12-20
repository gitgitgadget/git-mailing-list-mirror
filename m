Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3F013C914
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734679614; cv=none; b=sQdtn9NB/WyWD5w/rIlW7GWo7Nb5hXxl7GCWAD7GtT2W5pr69/OZZs87ol0jL8vpXGaJLkOix+ERSLR0+ZjNKZYUF2RLzLX323VjUtmQQ/UsmuThh6nXowojVWUX+GZCHY4P4dj1U+odL5dVa0/cljXN20dhdhK7z5ZszXvJsXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734679614; c=relaxed/simple;
	bh=E8xuQgusScG1fL+oNHkH48+IWNfQ7PIaYFg/rZIYaQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R16zCuy2v1t5/Cm7vOj3B9Aal6bsplcu3cicqxBhp25Cr4g8FbbCsWvOKThoRFmHB9f5fGORpx8xnWuDxT1rInP4eLQFabXNPOQMK56ir2b6oUY0X1UCoiXHi1N/JhRBd76PfsgngRsY65GIZw2Gv9FWIso/CEmscvP4PkHQSYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gm3OAoAK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yc9ijcPj; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gm3OAoAK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yc9ijcPj"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6DBD211400FE;
	Fri, 20 Dec 2024 02:26:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 20 Dec 2024 02:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1734679611; x=1734766011; bh=rWzpybRyy/
	ttEy/D6OvIv6g3/c45rGQgkBkgYQo4Tsw=; b=gm3OAoAKXCRalm3nlbaY2+M1uv
	NK959rYKDW0KUq5ual/Kd815v6PLTS0N9jFFsk7aJEuLBOqENxE80XjEQU2Z3Uuo
	YRKwIgBXZOYdhM9wimvv0AsBBDyZfCySPQYrQVq1UzDQ8q9Ec5MuNj1DfqSvcXK8
	JJrTIatUOsFMhwpjoyi/O6kS08D49dakGIeBnOcyNJ36iDe7TcnhKhHbiLOWQPUx
	Xp+q4yRU9vrlGEIIq9D8pQiAV1hKnTqckyCrVBhvnksULqhPzOjymUy+AqAXiQxh
	kc6uMqpCOMl5uUC1X38tfkNbv+4yaTc5C5xrkGeLQu05W9TMSHgOxYPd9l4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1734679611; x=1734766011; bh=rWzpybRyy/ttEy/D6OvIv6g3/c45
	rGQgkBkgYQo4Tsw=; b=yc9ijcPjpDXPcgKvq3BgwtpydnmYR3FjlX0WQ+NnuFZv
	zknhtf6rfGPbFNFoMdZvjBVKGrWa9cTmq/oTkK+8he/hZeAJ1GwRU+IlTWaclh5f
	muuoxDGJlrIeYNM9G7DE3aj60VB8LpO5KHD+apcuPFwGXHhh2i0GP6rr98zX6kI9
	5jSwe7cK3BO0LYoegmbvs8jm6NbawC/adWsaKAKfM8/9akVcBmVDAJQ7AMlvKysm
	AQ+ApCxBBsRkytk/Y+QHGkDuDZN9HzoY+E6We/ka8GKf1QUUefaShOwrdfBQYfFJ
	01DMaL5Ypu9VXCqJY7tmOQp1T+ucWJ0sr7e6P9xr9w==
X-ME-Sender: <xms:OxxlZ2Ry5BKFqOjhuEA11Q-Y3ZM3eEmVdZf9bY7PpwIY0H50Yv2K7g>
    <xme:OxxlZ7yoML58gIH2pjlRMasoCQYLXGO6lYMUIZlTu0sNISoSqis8lEx0XUw0wylG9
    vm42PNLrlw2wQAB6A>
X-ME-Received: <xmr:OxxlZz0YAT81QaNAwF7P7H5eLiEffspr5j8ueQy6H4gCPyrUqCz5fYWxwlN5MNYVRYwszKrZKxjXQ2mzz-y16G1tuC-E01qQdj_VNrGtchpnj_M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtuddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeeigfeitdffff
    dvvdeuheehjeehheeludduhfehkeekgeeggfeuffehveegteejfeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdgvnhhgsggvrh
    hgrdhlihhsthhssehphihrvghtrdhnvght
X-ME-Proxy: <xmx:OxxlZyCMXVIWpCisiFK8EKDokR0Fy90J9sW5FQ1Qb2xPLeNTXb-lDA>
    <xmx:OxxlZ_gtfUdh3g8m6R0y_eR-7PZ9jS7PKmJ5u7eyr4Y_PtctTFNSaw>
    <xmx:OxxlZ-r-H9lRyLaz-aXA7-CtFLPF015sASU8u2rbA6bZyo_dhhqD5Q>
    <xmx:OxxlZyhX-4-WbYO59evwPPmBUNdo_SGmKEaSK80nTf0M3bU7T4QD_g>
    <xmx:OxxlZysCU2D5CYMlwtmHQk_QkF5DnbR0Xf4jR348-ZZ0d2WfgjUf5X20>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 02:26:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eb9aacf1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 07:24:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Dec 2024 08:26:30 +0100
Subject: [PATCH] meson: skip gitweb build when Perl is disabled
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-b4-pks-meson-fix-gitweb-wo-perl-v1-1-41039ad8d8d4@pks.im>
X-B4-Tracking: v=1; b=H4sIACUcZWcC/x2NQQrCMBQFr1L+2gdNWtB6FXFhm2f9qEnIL1Yov
 bvB5cAws4mxKE3OzSaFHzVNsYI7NDI9bnEmNFQW3/reeXfC2CM/DW9airjrF7MuK0esCZnlhaH
 rjkMI7UQGqZVcWK3/4XLd9x+sgoRmcQAAAA==
X-Change-ID: 20241218-b4-pks-meson-fix-gitweb-wo-perl-93379dd0ceed
To: git@vger.kernel.org
Cc: Daniel Engberg <daniel.engberg.lists@pyret.net>
X-Mailer: b4 0.14.2

It is possible to configure a Git build without Perl when disabling both
our test suite and all Perl-based features. In Meson, this can be
achieved with `meson setup -Dperl=disabled -Dtests=false`.

It was reported by a user that this breaks the Meson build because
gitweb gets built even if Perl was not discovered in such a build:

    $ meson setup .. -Dtests=false -Dperl=disabled
    ...
    ../gitweb/meson.build:2:43: ERROR: Unable to get the path of a not-found external program

Fix this issue by introducing a new feature-option that allows the user
to configure whether or not to build Gitweb. The feature is set to
'auto' by default and will be disabled automatically in case Perl was
not found on the system.

Reported-by: Daniel Engberg <daniel.engberg.lists@pyret.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

I received an off-list mail from a user interested in the new Meson
build system who has done a bit of testing of it on FreeBSD. They found
an issue when configuring the build without Perl enabled, which can be
achieved by both disabling tests and Perl-based features. This patch
here fixes the issue.

Thanks!

Patrick
---
 meson.build       | 13 +++++++++++--
 meson_options.txt |  2 ++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 0dccebcdf16b07650d943e53643f0e09e2975cc9..8e34a895dca80da77d6809a6fe90fe7661f142a1 100644
--- a/meson.build
+++ b/meson.build
@@ -740,7 +740,7 @@ endif
 # features. It is optional if you want to neither execute tests nor use any of
 # these optional features.
 perl_required = get_option('perl')
-if get_option('tests')
+if get_option('tests') or get_option('gitweb').enabled()
   perl_required = true
 endif
 
@@ -1874,7 +1874,15 @@ if intl.found()
   subdir('po')
 endif
 subdir('contrib')
-subdir('gitweb')
+
+# Gitweb requires Perl, so we disable the auto-feature if Perl was not found.
+# We make sure further up that Perl is required in case the gitweb option is
+# enabled.
+gitweb_option = get_option('gitweb').disable_auto_if(not perl.found())
+if gitweb_option.enabled()
+  subdir('gitweb')
+endif
+
 subdir('templates')
 
 # Everything but the bin-wrappers need to come before this target such that we
@@ -1893,6 +1901,7 @@ summary({
   'curl': curl.found(),
   'expat': expat.found(),
   'gettext': intl.found(),
+  'gitweb': gitweb_option.enabled(),
   'https': https_backend,
   'iconv': iconv.found(),
   'pcre2': pcre2.found(),
diff --git a/meson_options.txt b/meson_options.txt
index 32a72139bae870745d9131cc9086a4594826be91..1b38d9b716ee2d06ac1484a744529547f7ed4acd 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -23,6 +23,8 @@ option('expat', type: 'feature', value: 'enabled',
   description: 'Build helpers used to push to remotes with the HTTP transport.')
 option('gettext', type: 'feature', value: 'auto',
   description: 'Build translation files.')
+option('gitweb', type: 'feature', value: 'auto',
+  description: 'Build Git web interface. Required Perl.')
 option('iconv', type: 'feature', value: 'auto',
   description: 'Support reencoding strings with different encodings.')
 option('pcre2', type: 'feature', value: 'enabled',

---
base-commit: d882f382b3d939d90cfa58d17b17802338f05d66
change-id: 20241218-b4-pks-meson-fix-gitweb-wo-perl-93379dd0ceed

