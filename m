Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7232445AFA
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518178; cv=none; b=lMjS5Rptaw0PimdSqBrDQD5Zj/0Srp+Ysa8NTN9nL4OuwzoCo5twdUJFnD4ap446bRnVxmsLQ0M2fyGZW9xhbtPatPhXqvjLUzO4MdOYIL5mcMTjZ9bdKcRsFmrxoJtVLdH6/rii7dQ1Y8cXlfpt22ey5DB72hSlOuflfGImkbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518178; c=relaxed/simple;
	bh=FcV/Xngrnb9ONgYiz7sYsFu/Sc6iJgL/rbAnq6EB34E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mt1GcNDo3iRrYQWOx98HhzLgbKqqrXPnmh9c3BA78B5I3sJzoIxGFLLGl6D+y2yeBfecRtlv34E5qPBGKBXncOiFhsOJO7L5p9zxXP+7k52scG3nnmR938JwguVGxcePQpMfWZMRetScJXgX08Nw59YgDuyMmHQw/WmTaUPYdl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=km1b9uPp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aU+A6lev; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="km1b9uPp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aU+A6lev"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D5CD21D0012D;
	Fri,  4 Sep 2026 06:36:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 04 Sep 2026 06:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1788518174; x=1788604574; bh=9pYHCVOj3E
	2VT2NoElgqk5PMFBdMpjGi8FDRep0f4h4=; b=km1b9uPpfRZ1sM4lGkzP2mflL0
	zL65KkWLbZzAqCalXalyzdykSZeTeAS78bKAvDqq4rWKvqVDKLOxArD9/yt6SQ9z
	QZLXcNA65Yz/SuAJKTog6nuNHSExxm9KteMxXzQcY+zW0Pr1uEBMdH7y77Wc4wH4
	AprOgTbPe4XLcBX+8Dizmwf/HAuyLxhTV6ad045EBXnS6AqgyIQ0fzwS5EAIqZl5
	dOyBkjNHvAH/KT+nmj9iwB1hZ169PhqYyNyYYdMyNO6nisJashTh7VU/3UlHcjew
	TwCXMiXpAxT2bzA0DVgBaEKe2V/8ewzmEqa/VIBnhlPPM03V9bM1ymxRT2ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1788518174; x=1788604574; bh=9pYHCVOj3E2VT2NoElgqk5PMFBdM
	pjGi8FDRep0f4h4=; b=aU+A6levxEljyv4SGaIh9GczXCewjSv+Mokhdp24W3QA
	BSxz9si4kVomSyFY6vpstqP7Jb8BkQBk//zrCMVLtrIJhAScNzPQnNkvFVBQuqv2
	cXKt08ZfXrLGjoThz901y7+xqxbxEVq/ksPYVoTeZZ3koXRZ5hOnM+GF+ruk2cPb
	43unzo73ZgYJidBcVjwJ7sq3Att4c6+5IKTJVXNJ7m1LL+a6XlheXIOwfZzJMfls
	F7WBZLwzmV4U4mPybDf/rrBrgDnoysZvFuorHAUCMxbk5lnvdx/JCw7Uu/VJdUMB
	ZAh719bIdpbP1OpSLQJl0k01FzV0jf01iKrmuveadQ==
X-ME-Sender: <xms:Hp-aamOZe6zTgy4oTAllgQ8rpZ_fm2ZJWrDoWNuoDpbqnlE3fJIBuA>
    <xme:Hp-aaq_gRpaWq04SHj7_Z3pcejEq2H5kaMzXTYy0bZcJi-0gJozlRKhVpfeBArq1W
    rNofoLEXrTHXL20pGMMX5VnxnBj3wlIpMIKpHc0ikozZkYrEVyQMTY>
X-ME-Received: <xmr:Hp-aaq7ap8GvBn8lszpC0lG04k7EtvEts5mAAzIecHvUjYapib0XupGp6zeS5-a74snZ3w>
X-ME-Proxy-Cause: dmFkZTGuT0qoCsAmtineiKRwumxkIQsklkerLsYGpcsfNWH16cEfcCu9QyXpb9OiPO5vRJ
    KY4KSySP1t5onFxVSNEP8IOt0A14Uz8Hor7v9SUr83KF0pAGGejc76YlQR8LTX82AwpqcN
    rNa2Da87aeKgvN9U5RLZbSkx/sP8+FIkEzDWPiGx9FdjaRY0/bu+6Gny0FnrsZvd2OTBE7
    F6ui//Bqr9VqTZJ3PM8+M1B4KwTbOEyiZZsxbedohh8e4h07DJprjNXbGOj6ld770xkdid
    H0eWH7akYawRt3UIUUmt64ZS2AdbdHbs6OE8h/4WTXCIXRiiXarC9ZSEjDUpUc9JB4qAE/
    eOM0cztPk8dnqtuS7r99aq0QmVg79L7Jmn8ts+U+yNAVFlOhGOT11AVdFZ/89CIRSvNlu+
    xSfF0x0mbsIMtW6prQJ3pp2rMzAmhjDd4JQNVXlbs4GnAUmUn/22Lx0wy/3IwJM1Zl4yc+
    htX9RLb78+CLcsKcjUs3jdzmKrzWdpuw2aG/qZ59giYXoHF30Rco90hn9VquV0yyogyQLT
    KEuHLggVULOOIKni9sJhS2PzmkVX+O566peO8gun0Vd+eNR5gkp5fnYk13mGvWd/ohQX29
    fp0zh6e0h9zWhoCfgrXfULUT9xK0X1zeqpuGT4NV3KtthJ4Wf/IdndsOw3Bw
X-ME-Proxy: <xmx:Hp-aah25MudVfqLGs5A7BxWG5bwWEZKqcCHEkGUWzQ5SbErv0pVMaQ>
    <xmx:Hp-aahBda7lfwPQPOsVCOAcG-_tuJVvhqMH_bWuksD9MNogiQI62Dw>
    <xmx:Hp-aaj3rqrAcwjwGQXbdYBSX9PBW8b37ocwu1ftLpxjk9PgrjvNuQQ>
    <xmx:Hp-aarup72V7MNuKJxZitzDlMUfRVKViD9JvcDJ8wMUSAPFUuNHDJg>
    <xmx:Hp-aao8ynrhP_tJObTKFQXqsUucSQqHHAMmPP4aC9htdJoQ8hAiC7_5U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 06:36:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d83fc2d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Sep 2026 10:36:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/11] Fix inconsistent ref storage format terminology
Date: Fri, 04 Sep 2026 12:36:01 +0200
Message-Id: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQrCMBAAv1L27MKmllr9inhI0o2uYlKyqVhK/
 27U48Aws4JyFlY4NStkfolKihXMrgF/s/HKKGNlaKnt6Ugdug6nh+IcJSyYOaCWlG31QspPW5D
 8YIKj/dAfDNTKVB15/w7ny591dnf25ZuFbfsAzqN8CYMAAAA=
X-Change-ID: 20260904-b4-pks-unify-ref-storage-format-0c81fb038671
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Hi,

back when we gained support for reftables we of course introduced the
ability to control the reference storage format that is used by newly
created repositories. This infrastructure has grown over time, and
unfortunately without a lot of consistency:

  - The command line parameter to specify the ref storage format is
    called "--ref-format=", while the corresponding repository extension
    is called "refStorage".

  - In most cases we refer to the "ref storage format" in our docs, so
    calling it "--ref-format=" is inconsistent with them.

  - It is possible to override the ref storage format via an environment
    variable that is called "GIT_REFERENCE_BACKEND", which is not even
    remotely consistent with anything else.

  - There is also an "object format", but that format does not control
    how we store objects but rather whether we use SHA1 or SHA256.

So in summary, it's a huge mess.

This problem is about to become even worse though, as we're soon going
to introduce an object storage extension. This extension is the
equivalent to the ref storage extension, and of course we also want
users to be able to control which object storage format new repositories
are using. But we cannot properly name that parameter without creating
even more inconsistencies:

  - "--object-format=" would match "--ref-format=", but that parameter
    name is already taken to specify the hash function.

  - "--object-storage=" would be a good fit, but be inconsistent with
    "--ref-format=". Asking the user to execute `git init
    --ref-format=reftable --object-format=sha256 --object-storage=foo`
    just feels extremely awkward.

So this patch series aims to clean up this huge mess that we (well, to a
large extent I) have created, by bringing consistency to our command
line switches, environment variables and config options to all use "ref
storage" instead. And that also paves the way for the eventual "object
storage" switches.

As a cherry on top, this patch series also extends the "--ref-storage="
switch to allow URIs in the form of "files://foo/bar" to bring it in
line with all the other ways to specify the ref storage format that
already allow for URIs.

Thanks!

Patrick

---
Patrick Steinhardt (11):
      builtin/init: rename "--ref-format=" to "--ref-storage="
      builtin/clone: rename "--ref-format=" to "--ref-storage="
      builtin/refs: rename "--ref-format=" to "--ref-storage="
      builtin/submodule: rename "--ref-format=" to "--ref-storage="
      builtin/rev-parse: rename "--show-ref-format" to "--show-ref-storage"
      help: rename "default-ref-format" to "default-ref-storage"
      refs: expose function to parse reference URIs
      setup: refactor how we configure the ref storage format
      setup: rename ref storage format environment variables
      setup: rename "init.defaultRefFormat" to "init.defaultRefStorage"
      setup: allow "git init --ref-storage=" to specify a payload

 Documentation/BreakingChanges.adoc     |   2 +-
 Documentation/config/feature.adoc      |   2 +-
 Documentation/config/init.adoc         |   6 +-
 Documentation/git-clone.adoc           |   2 +-
 Documentation/git-init.adoc            |   9 +-
 Documentation/git-refs.adoc            |   6 +-
 Documentation/git-rev-parse.adoc       |   2 +-
 Documentation/git-submodule.adoc       |   8 +-
 Documentation/git.adoc                 |   8 +-
 Documentation/ref-storage-format.adoc  |   8 +-
 builtin/clone.c                        |  18 ++--
 builtin/fetch.c                        |   2 +-
 builtin/init-db.c                      |  19 ++--
 builtin/refs.c                         |  11 ++-
 builtin/rev-parse.c                    |   2 +-
 builtin/submodule--helper.c            |  24 +++--
 contrib/completion/git-prompt.sh       |   2 +-
 environment.h                          |   1 +
 git-submodule.sh                       |  20 ++--
 help.c                                 |   2 +-
 refs.c                                 |  23 +++++
 refs.h                                 |   4 +
 setup.c                                | 162 ++++++++++++++++++---------------
 setup.h                                |   2 +-
 t/perf/p1401-ref-store-tombstones.sh   |   4 +-
 t/perf/perf-lib.sh                     |   4 +-
 t/t0001-init.sh                        | 126 +++++++++++++------------
 t/t0610-reftable-basics.sh             |  34 +++----
 t/t0611-reftable-httpd.sh              |   2 +-
 t/t1400-update-ref.sh                  |   2 +-
 t/t1419-exclude-refs.sh                |  16 ++--
 t/t1423-ref-backend.sh                 |  62 +++++++++----
 t/t1460-refs-migrate.sh                |  54 +++++------
 t/t1500-rev-parse.sh                   |   8 +-
 t/t1900-repo-info.sh                   |   6 +-
 t/t5510-fetch.sh                       |  14 +--
 t/t5601-clone.sh                       |   6 +-
 t/t7424-submodule-mixed-ref-formats.sh |  30 +++---
 t/test-lib.sh                          |   8 +-
 39 files changed, 407 insertions(+), 314 deletions(-)


---
base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
change-id: 20260904-b4-pks-unify-ref-storage-format-0c81fb038671

