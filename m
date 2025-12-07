Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9397B2C3271
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 21:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765144557; cv=none; b=b4g7s+PacRZx4/yHZlA/iRokh99QqLQvLXVQ68q2/8my5IiPhZFB/fFyGXT2vDMlf3KgQB0BiHw3ppFXvNVdpzV2WIglmScWjGgDQFERpBHl4IM+KcLVD8q1yZs8baKxIYv0Y7bO120bvYDDPOnHjHxmYH8ONHEyeJEhk7O39Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765144557; c=relaxed/simple;
	bh=o4PBvkHrtj/t82vt14mB3r0s4g/dwWoNCtsOVF9Pors=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=WmYDUOqdgibLYDEC0bxazTB07ZPCK3vIvskzgs+iH2MYq9K6P9WOh/Yj51QR1q3MKdypYiAb7zvo1mJUnkhAwQeFnIwxyFwQKrAgxQZAfbEy4hvZpYU2kGNLN1oVzrchw1wo3oWth/CW3QfifUwsgmYERgj9tMwZor9clG2Imrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=akkartik.com; spf=pass smtp.mailfrom=akkartik.com; dkim=pass (2048-bit key) header.d=akkartik.com header.i=@akkartik.com header.b=XrdUcDXF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S3Nw24Oc; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=akkartik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akkartik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akkartik.com header.i=@akkartik.com header.b="XrdUcDXF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S3Nw24Oc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BBBA0EC05D3
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 16:55:53 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Sun, 07 Dec 2025 16:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkartik.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1765144553; x=1765230953; bh=zd0F4WKD51
	TJfV+3/AEOM1xSoiSB8L263TtBmQ2IeRE=; b=XrdUcDXFK/H76arQhZRp64mRfu
	/UiR/ZYUCnfeKAVXR+YS+xIWaWC5E10G2sZFkaTo+GSelUYWvSNAUJOpV+EtzZiF
	yKy9dJzLo8/DPA9jVfS3tBQm0leuxLXSuEV8uAo8wKwrSY37K+l8MPnZ8gtEgieK
	RkrS2EDjwjUah8LB4qdeRYTY4aKA69TzggUVtm29Ake4tV1Xea7MIcsM1PAaUN51
	iPPzJHk/ddZbJ3UBoH1YknaMLSuz19C1zvLuX5lxOTkbenJE1rIwCKBQ2wGnRWr7
	ZSQnwrTJArAnmD9vF38rTyqBovVJmG+WU2oRuZwnnByLE3573zg3jz8kwE2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765144553; x=1765230953; bh=zd0F4WKD51TJfV+3/AEOM1xSoiSB8L263Tt
	BmQ2IeRE=; b=S3Nw24OcR5cs6eMI1dBcEo7vwhA2y6qBIynUzpX5xFAV9zy/Ej3
	eybJeL8si46/2Eeo/wc+KkK2HZrsUmmVPzpbChM+bRbYsRks1v8zw5pwE5apE1mh
	JWerHuSnWJmuM8SnBQ8yMNNyXMPgNnJa5krEzBVJd6YdeKbAOyIwaSAJ5tcdbgyq
	Q1KAh1QENXo9DlwJ2o5HejLaqvAsZtN0hg0yrz1GAelnUJVI8jKg471Ks2xHWuq2
	1aI5CM7DVzchqwCGNnCCNXH9ahUU3wFZOgQRgHXKSrdRJV3Xc2kzXNt16QV4yRuq
	XwdfcjeOI8WA0hUgLkR0pefeygmG+SPEwaA==
X-ME-Sender: <xms:6fc1aeGgJz5xxlvS9FUrYbyIhLigCi_rJu8TvfXoSLerAzaL6ikt1w>
    <xme:6fc1aaJ5ZFo2TXQWuUN2Dhj-z24Vbn7PIVVBI4bQfJjey-hX5G-QgsXocUl5t1Sf_
    SOdYIP4dK95KorMVNYuDymjCHltnHHACUZsyV2lbdAOD1DkYYA7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkufgtgfesthejredtredttd
    enucfhrhhomhepfdfmrghrthhikhcutehgrghrrghmfdcuoegrkhesrghkkhgrrhhtihhk
    rdgtohhmqeenucggtffrrghtthgvrhhnpeevhefhiefgjeetjeeutdffudevvdelhfetvd
    dukeekieevteekvedvffffffetieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghksegrkh
    hkrghrthhikhdrtghomhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6fc1aT0HnalqWPNInuKZluodRpB-VLiKgSqbnvXBlSKK_3AH3BWZQw>
    <xmx:6fc1aSBkDkekOjcnMQbUvCj7NHWJJhvIkvlHA7ZOonmuteBDJ-Nwhw>
    <xmx:6fc1aQxXut2aK-WTmGLzEIJkX8ohEwJzIB8IzYg3t9Ln6Pv_P7Fi4w>
    <xmx:6fc1aQnFRjtKN-wuGo75GGrgvBlTYR6UDTeXgzmbGllVu48bO_EtIQ>
    <xmx:6fc1aaLSHnEWqZjsvwwHZUiyQ_KljJ9wmuqBH9MOqiZ1WhhQIGwuVLJG>
Feedback-ID: id12946ff:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9A6952CE0072; Sun,  7 Dec 2025 16:55:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 07 Dec 2025 13:55:33 -0800
From: "Kartik Agaram" <ak@akkartik.com>
To: git@vger.kernel.org
Message-Id: <896e4e13-5d2f-4c5c-ac32-2927dbff91a0@app.fastmail.com>
Subject: bug: `git pull --rebase` breaks in the presence of pushurls
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

What did you do before the bug happened? (Steps to reproduce your issue)

1. Create a bare hub repo.

  mkdir hub
  cd hub
  git init --bare
  cd ..

2. Create a bare mirror of the hub.

  git clone --bare hub mirror

3. Create a working directory A and set its pushurls to hub and mirror.

  git clone hub A
  cd A
  git remote set-url --add --push origin `dirname $PWD`/hub
  git remote set-url --add --push origin `dirname $PWD`/mirror

4. Create commit 1 and push it to both.

  echo a > a
  git add .
  git commit -m 'commit 1'
  git push

5. Create a second working directory B without pushurls.

  cd ..
  git clone hub B
  cd B

6. Create commit 2 in working directory B and push it to hub.

  echo b > b
  git add .
  git commit -m 'commit 2'
  git push

7. Create commit 3 in working directory A and try unsuccessfully to push it.

  cd ../A
  echo c > c
  git add .
  git commit -m 'commit 3'
  git push

This throws an error when pushing to hub, but successfully pushes to mirror.

8. Try to fix the problem:

  git pull --rebase

This completes successfully.

What did you expect to happen? (Expected behavior)

git log in working directory A should show all 3 commits

What happened instead? (Actual behavior)

git log shows commits 1 and 2 (created in B).

What's different between what you expected and what actually happened?

Commit 3 which was locally created is lost after the `git pull --rebase`.

Anything else you want to add:

I first encountered it in git 2.51.0. Also found to be present on HEAD of https://github.com/git/git

Problem exists independent of ~/.gitconfig.

[System Info]
git version:
git version 2.52.0.199.gbdc5341ff6
cpu: x86_64
built from commit: bdc5341ff65278a3cc80b2e8a02a2f02aa1fac06
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: disabled
libcurl: 8.16.0
OpenSSL: OpenSSL 3.5.3 16 Sep 2025
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 6.12.48-1-MANJARO #1 SMP PREEMPT_DYNAMIC Fri, 19 Sep 2025 16:11:04 +0000 x86_64
compiler info: gnuc: 15.2
libc info: glibc: 2.42
$SHELL (typically, interactive shell): /usr/bin/zsh


[Enabled Hooks]
