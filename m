Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A26653
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737545499; cv=none; b=ahaNSik7W/3CHoYa9xDb1cBnQ4PJuhqApoPRPi7fOG2qxr2kSTCdFUDn5oRb/Gpxdsu525KMuNPhcsfWGj6gZ9N6Py1IRkW/qsQZd8SvBMxRZJg8gCjzV2iq58nC631/QEm/SPrOLOaW99r9fgauYD6J4n8JjjMdEmPNtm0Ja4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737545499; c=relaxed/simple;
	bh=arnB5XR+H/yKV2akvwn1vf1zxw2RHXvxM3sJy6AbNkI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=JrBOpZKfLNvdopgj9r/4tYzRY+FqJveMfD8FOXmxLPhXOiEpxLSNtbxQyyGJm1m54ukZBAa4f8tzGUA/6K8Vx5cHT3dYCzhmHvGslAvO7BvQdUljv1wj1FkyOfdJ7JjHD++BQs4MJCXYDVCvjiUc1CZgKDlWeEtowqUJ0Hnuuxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O/giE+5g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KVU6xpHW; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O/giE+5g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KVU6xpHW"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D84CC2540143;
	Wed, 22 Jan 2025 06:31:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 22 Jan 2025 06:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737545495;
	 x=1737631895; bh=q3ZEUmQXBPvJEYxvNMycG2/y959pmT0Ne6RqeNxdb2M=; b=
	O/giE+5gAuCwinoE9pWeI9Tb2M8hQuATNC2LZXjRe9cEKAQ9rbXIVWVSSjSRNluT
	syLpF5Rxl1TBkWE2MwvohnEY20gDIBCLxuA4j6gGS53kqQm5mxtqqP8InXmqxgvn
	jGub4GqWH019iFba7DYjjCLhZiPKGnuLB4WiYlf4QF5dSercBJoGLWjwU0iTcoZj
	eskJkybt98Bf7CumQxkyaxPu9Lf4WZhM37i3EQ2galqs8ZXQTIqocJEpTTqBsfHB
	1f2rwbp38CJUg920l7hjyS4ItZwW+Slzx/52Nuf4imL/VR4gIqW+mFYiDXsK51y/
	s+CAdDaJtbAIB97zL9R88g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737545495; x=
	1737631895; bh=q3ZEUmQXBPvJEYxvNMycG2/y959pmT0Ne6RqeNxdb2M=; b=K
	VU6xpHW8rToR3Kb3znVJREpfkGpcsrBxxekfQeKrj5DHcoeJuEngaEykhn2AMiIA
	NO3NSVIrrnZrm26HxGmgTbHR75RgpvkkzZ33feEJcC2spYEO/LiPks9FNiy5rPdq
	7pPqpLl67ZmelwQuYALlsmoc1gBAoDdb8Rj7DftZXPGAZ3iP1hiYdIr/+ZiQhU8n
	JfhDXDmkrWlIXLgac2knyXoX4zfo/zpziYhtNa9cxaSsnfJQUnbAe6wMeuEuiolD
	pG4cd9L5L7ffN2qORIpwEc0QN+KZB8vaDUO82Sh/hqKP10eSizU4gJUlmBUfOcFb
	ECb6tdB2MQlh4kyaNLfbQ==
X-ME-Sender: <xms:F9eQZ0aisbQeSkDIbkBaXH3jJhTltR8ZkIdi6LpWVw152uFgBALgYg>
    <xme:F9eQZ_YX6xuKruXuGp831JZDxfuWrxj9VonDyM9VNUljym09it4q7WcvVy_Pb_GjH
    qZv-9iDICCw03u3Rg>
X-ME-Received: <xmr:F9eQZ--PyHxXCXslJSsesLyNz-MgObfA0fh7JLYwpLhbnu-KX_kbqoPU5OQvEhjHqfo5zgS8aMgImaykhQPcI_nDGhSDHiDyS1Mm3BWM8ycgIfE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepteeuueehhffhiedtueehtddtieekfedtudehtdeh
    fefhgeffveeggedthfehuedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrnhgurghllhdr
    sggvtghkvghrsehnvgigsghrihgughgvrdgtrgdprhgtphhtthhopegthhhrihhstghooh
    hlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheprhhosggvrhhtrdgtohhupheskhhoohhrughinh
    grthgvshdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:F9eQZ-pu7Yl6Ijf8UMVGDch08ENEsz8KWejs6mCjrQXEvFIXp3hFaA>
    <xmx:F9eQZ_o5unO7xvKrK0qCcyLmmY6pEJSHSsskZiefFXv1AqY82mTI1g>
    <xmx:F9eQZ8Tnv1XZWLZauZWz0DCsflpyn_GK_9lBcOn0nkFOmuxVIVPHGQ>
    <xmx:F9eQZ_pXPQBao1MHMcBhqlQRzNjslGqUUl9THlLqcP1V94P6_brcWg>
    <xmx:F9eQZwclhLdGvqpHrL59_Hhi0Yo7cr6zIQSXCfbflt5P6N8er44w7EgM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 06:31:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1e8bcb30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 11:31:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/5] remote: announce removal of "branches/" and
 "remotes/"
Date: Wed, 22 Jan 2025 12:31:28 +0100
Message-Id: <20250122-pks-remote-branches-deprecation-v4-0-5cbf5b28afd5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABDXkGcC/4XOTY7CMAwF4KugrCcojpOmZcU9EIsQDI1GtCUpF
 Qj17pifGWDV5bPl7/kqMqVIWSxmV5FoiDm2DQfzMxOh9s2eZNxyFlppA1pZ2f1mmejQ9iQ3yTe
 hpiy31CUKvudbqdB5g2Xl0TnBCm928fxoWK2fOdHxxEX9e1jH3Lfp8vhigPv0VQgwWTiAVBIMA
 mksKkC75It5PIg7POg/zCpQxTSmGdOBSheURYvFF4YfmFbTGDIWHFmsNoUvze4fG8fxBk0w/RR
 6AQAA
X-Change-ID: 20241205-pks-remote-branches-deprecation-037a4389a377
In-Reply-To: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
References: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Robert Coup <robert.coup@koordinates.com>, 
 Christian Couder <chriscool@tuxfamily.org>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>
X-Mailer: b4 0.14.2

Hi,

back when Git was in its infancy, remotes were configured via separate
files in "branches/" (back in 2005). Later that year we introduced a
more powerful mechanism with the "remotes/" directory. These mechanism
have eventually been superseded by config-based remotes, and it is very
unlikely that anybody still uses these directories to configure their
remotes. Both of these directories have been marked as deprecated, one
in 2005 and the other one in 2011.

This patch series follows through with the deprecation of these and
announces them for removal in Git 3.0. Furthermore, it creates the infra
to compile Git with such breaking changes enabled and wires up a CI job
both for GitHub and GitLab to test those breaking changes.

The series is based on top caacdb5dfd (The fifteenth batch, 2024-12-10)
with ps/build at 904339edbd (Introduce support for the Meson build
system, 2024-12-06) merged into it.

Changes in v2:
- Some small fixes to the deprecation notice of "branches/" and
  "remotes/".
- Some small fixes to commit messages.
- Link to v1: https://lore.kernel.org/r/20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im

Changes in v3:
- Print warnings when reading remotes from "remotes/" or "branches/".
- A couple of commit mesasge improvements.
- Link to v2: https://lore.kernel.org/r/20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im

Changes in v4:
- Add migration instructions to the warning when reading deprecated
  remote types.
- Clarify the deprecation text a bit.
- Link to v3: https://lore.kernel.org/r/20250120-pks-remote-branches-deprecation-v3-0-c7e539b6a84f@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (5):
      Makefile: wire up build option for deprecated features
      ci: merge linux-gcc-default into linux-gcc
      ci: repurpose "linux-gcc" job for deprecations
      builtin/pack-redundant: remove subcommand with breaking changes
      remote: announce removal of "branches/" and "remotes/"

 .github/workflows/main.yml             |  6 +----
 .gitlab-ci.yml                         |  6 +----
 Documentation/BreakingChanges.txt      | 25 ++++++++++++++++++
 Documentation/gitrepository-layout.txt |  7 +++--
 GIT-BUILD-OPTIONS.in                   |  1 +
 Makefile                               |  7 +++++
 builtin/remote.c                       |  2 ++
 ci/lib.sh                              |  5 ----
 ci/run-build-and-tests.sh              |  3 ++-
 contrib/buildsystems/CMakeLists.txt    |  1 +
 git.c                                  |  2 ++
 meson.build                            |  6 +++++
 meson_options.txt                      |  2 ++
 remote.c                               | 26 +++++++++++++++++++
 remote.h                               |  2 ++
 t/t5323-pack-redundant.sh              |  6 +++++
 t/t5505-remote.sh                      |  6 ++---
 t/t5510-fetch.sh                       | 13 ++++------
 t/t5515-fetch-merge-logic.sh           | 47 ++++++++++++++++++----------------
 t/t5516-fetch-push.sh                  | 14 +++++-----
 t/test-lib.sh                          |  4 +++
 21 files changed, 132 insertions(+), 59 deletions(-)

Range-diff versus v3:

1:  c9ab464545 = 1:  b72e562c5a Makefile: wire up build option for deprecated features
2:  992c55543e = 2:  a6c0aa40f0 ci: merge linux-gcc-default into linux-gcc
3:  e9d9721fbf = 3:  c4aa9d092b ci: repurpose "linux-gcc" job for deprecations
4:  2588dff0f8 = 4:  7977a853ef builtin/pack-redundant: remove subcommand with breaking changes
5:  671a527782 ! 5:  c607948f6a remote: announce removal of "branches/" and "remotes/"
    @@ Documentation/BreakingChanges.txt: Cf. <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.c
     +As our documentation mentions, these directories are not to be found in modern
     +repositories at all and most users aren't even aware of these mechanisms. They
     +have been deprecated for almost 20 years and 14 years respectively, and we are
    -+not aware of any reason why anybody would want to use these mechanisms.
    ++not aware of any active users that have complained about this deprecation.
     +Furthermore, the ".git/branches/" directory is nowadays misleadingly named and
     +may cause confusion as "branches" are almost exclusively used in the context of
     +references.
    @@ remote.c: static void add_instead_of(struct rewrite *rewrite, const char *instea
      static const char *skip_spaces(const char *s)
      {
      	while (isspace(*s))
    +@@ remote.c: static const char *skip_spaces(const char *s)
    + 	return s;
    + }
    + 
    ++static void warn_about_deprecated_remote_type(const char *type,
    ++					      const struct remote *remote)
    ++{
    ++	warning(_("reading remote from \"%s/%s\", which is nominated for removal.\n"
    ++		  "\n"
    ++		  "If you still use the \"remotes/\" directory it is recommended to\n"
    ++		  "migrate to config-based remotes:\n"
    ++		  "\n"
    ++		  "\tgit remote rename %s %s\n"
    ++		  "\n"
    ++		  "If you cannot, please let us know you still use it by sending an\n"
    ++		  "e-mail to <git@vger.kernel.org>."),
    ++		type, remote->name, remote->name, remote->name);
    ++}
    ++
    + static void read_remotes_file(struct remote_state *remote_state,
    + 			      struct remote *remote)
    + {
     @@ remote.c: static void read_remotes_file(struct remote_state *remote_state,
      
      	if (!f)
      		return;
     +
    -+	warning(_("Reading remote from \"remotes/%s\", which is nominated\n"
    -+		  "for removal. If you still use the \"remotes/\" directory\n"
    -+		  "it is recommended to migrate to config-based remotes. If\n"
    -+		  "you cannot, please let us know you still use it by sending\n"
    -+		  "an e-mail to <git@vger.kernel.org>."), remote->name);
    ++	warn_about_deprecated_remote_type("remotes", remote);
     +
      	remote->configured_in_repo = 1;
      	remote->origin = REMOTE_REMOTES;
    @@ remote.c: static void read_branches_file(struct remote_state *remote_state,
      	if (!f)
      		return;
      
    -+	warning(_("Reading remote from \"branches/%s\", which is nominated\n"
    -+		  "for removal. If you still use the \"branches/\" directory\n"
    -+		  "it is recommended to migrate to config-based remotes. If\n"
    -+		  "you cannot, please let us know you still use it by sending\n"
    -+		  "an e-mail to <git@vger.kernel.org>."), remote->name);
    ++	warn_about_deprecated_remote_type("branches", remote);
     +
      	strbuf_getline_lf(&buf, f);
      	fclose(f);

---
base-commit: 713ec79a9091cec60b110d605b418904759982ab
change-id: 20241205-pks-remote-branches-deprecation-037a4389a377

