Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E8C220F52
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961473; cv=none; b=LEBikX7F/FO8+uVh95a3EJJiOrOAI0cZ8qfDs9ZKKq3yTedEGtE6oRChmuyhTAER0PCXovlOx+PVCiYMvA1dqsZoSzzYKVVUkuuvaz+KvrY7pPzMwA65m1h5bxGlcOllEO7HuGNnh7JraexEwsT+CtokF15d2il02ftva/WeVVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961473; c=relaxed/simple;
	bh=DvGqP+Mi0sSze6nmf48jAJbfzs/cjYc6J/JKpoGEKck=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=jO6VvNiqhV26vzlnOBkK3Ov8lW2if01CmkRaeDnLquRFpZKeqbmGUji33UFKkK5BVAAeR1b1yNOOQJEYhBOJZAoqOj/uL6noQqQN4fkLxrDpyXVWxdhjFwanw9N17ZgAmqqSXlQB77BrV0jDoz837uDK1fxa5QSkvkJDgFcZvmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lupplcmv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fTHXLqfD; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lupplcmv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fTHXLqfD"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 61A28EC0886;
	Tue,  8 Jul 2025 03:57:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 08 Jul 2025 03:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751961470;
	 x=1752047870; bh=r5QAU8hm4JBm4KfduWvnK2oxPKKo1YotcZD7rwuyDkw=; b=
	lupplcmv9hsMoGah2VoPM9A+LKfdvx1kAwHIfnE8rtav7qQwAIGjV1qDoshMX6qE
	Tybr8ZRXRkz3KvJLVN7STFWrxgHNb4qoOtMDz56WZ3jrB3aH9Ke1M7qO+MMtYYN1
	YpDsNqo12LgDS3iaemhGqWafAM5ANnDyysiCYYXOoN5vAWqKM20He+VVaJ6gz6uh
	xypX377Ixvj4wr+C7g21aBOSpnUMAwbkYJqwdtoV10kj3zVnoFwaYUYN6t5uXXoN
	9FtBRY7NLZkg7S8eKJgDqe/8mHEp4DHg1/hcY0wpCtOHrIT577qJoLC4Y4Wwas02
	VLpj9zYJjPP3pr6/usyfvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751961470; x=
	1752047870; bh=r5QAU8hm4JBm4KfduWvnK2oxPKKo1YotcZD7rwuyDkw=; b=f
	THXLqfDpiAorGUMhtlVRi1ZhEEGTZK0X/mW25A2s1QpCPl/NkFE0BWyxl4npeGoQ
	WS0GHnAEUSouSlBCv00A6n2EyshMlMrSgoKXeQFULxAzZnuXOoAVvTLBKRLe83gt
	DONfOVx2HwMKagqeso7RF7C8VXVoD6H8pDVyg418hPMMmoQJqws4WPMLEolX9MCD
	chUchwC7mACLJ/xKEv2inuZ+MjXTb4HzIZuAG065JymeHg/+httq5YVVjw9zDnTM
	gxD/2c8VZ0nsHeHAhZyZxrHxtmsdV9ptNXwR4LBlNrOE3QNtBa4RZBvowU4mcYQC
	Jg6HR5AlaYzk48Kj3dq+g==
X-ME-Sender: <xms:fc9saPpJLQX4Q9fuvgLyZzz17iERUitXQE3hWex5re44JuDUV-PP4g>
    <xme:fc9saKbqrElom1Qare73a0bDsu-lxX6jzjIQcRxzVHn1ObXlRsmqp0P5mlBLB_rOo
    hec5SzpO0RetpxH7g>
X-ME-Received: <xmr:fc9saIUrqY3KJ087K-cMvq3YO4uJgK-1KzNREXrIvGFAWK7CtSkaTIHso4cI8SjbjMMVFZUMQGMTN7czR1uHjI59Xl5sK3WCwWUoglYc4rE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteegveehtdehffeuveegudelkeeludetieffvdefvdduffegueduueefueehgfdvnecu
    ffhomhgrihhnpehgihhtlhgrsgdrtghomhdpghhithhhuhgsrdgtohhmpdhkvghrnhgvlh
    drohhrghdpmhgrthhrihigrdhnrhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehirhgvtg
    gtrgdrkhhunhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:fc9saD98xdB3dKk0RT9Jp9h3p2UPLc_ORscloyfmEhTnRH5zdtjIiw>
    <xmx:fc9saB-FmHzRYIeOEK7sdv6w6FXYpTFZeiFx_qRzvdEOcvBvsE6Fag>
    <xmx:fc9saDRkYpoxXXsArfMUC-6G_8RT30g223zOAJa7O0G_rJOErHHnhQ>
    <xmx:fc9saFfQiigbwW2l7EhMNvhdbf37qRKMk7xnCLdpMH_1jVOijJphdg>
    <xmx:fs9saFLs8hkISgwL0rCh7vsHITOU-5MTbCm1948ZMvMpK-go2eJzdbNY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 03:57:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d9a5944f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 8 Jul 2025 07:57:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/8] A handful of Meson cleanups and improvements
Date: Tue, 08 Jul 2025 09:57:41 +0200
Message-Id: <20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHbPbGgC/4WNQQ6CMBBFr0Jm7ZjSggIr72FYlDLIRGlJR4mGc
 HcrF3D5fv5/fwWhyCTQZCtEWlg4+AT6kIEbrb8Rcp8YtNKlOiuDXYHzXXAiCR7dg6x/zYJDaaq
 y6k91MRhI2znSwO/de20TjyzPED/7zZL/0n/GJUeFulKF07XRtqNLKh15gnbbti8HpcECtwAAA
 A==
X-Change-ID: 20250703-b4-pks-meson-cleanups-f53858d694f3
In-Reply-To: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this patch series contains a couple of more-or-less random cleanups and
improvements for Meson that I have accumulated over the last two months.

Changes in v2:
  - Fix an off-by-one error for test slices used in GitHub Workflows.
  - Now tested with both GitLab (https://gitlab.com/gitlab-org/git/-/merge_requests/375)
    and GitHub (https://github.com/git/git/pull/2010).
  - Link to v1: https://lore.kernel.org/r/20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (8):
      meson: stop discovering native version of Python
      meson: stop printing 'https' option twice in our summaries
      meson: improve summary of auto-detected features
      meson: clean up unnecessary variables
      meson: fix lookup of shell on MINGW64
      meson: fix GIT_EXEC_PATH with overridden -Dlibexecdir=
      meson: update subproject wrappers
      ci: use Meson's new `--slice` option

 .github/workflows/main.yml |  2 +-
 .gitlab-ci.yml             |  2 +-
 Documentation/meson.build  |  5 ++---
 meson.build                | 26 ++++++++++++--------------
 subprojects/expat.wrap     | 18 +++++++++---------
 subprojects/pcre2.wrap     | 18 +++++++++---------
 6 files changed, 34 insertions(+), 37 deletions(-)

Range-diff versus v1:

1:  34bb9288218 = 1:  2130ccdfb14 meson: stop discovering native version of Python
2:  a6f1b52d44f = 2:  4274c321f0b meson: stop printing 'https' option twice in our summaries
3:  01a8c379314 = 3:  cdc8c9d8655 meson: improve summary of auto-detected features
4:  306af85a4a3 = 4:  373496880ce meson: clean up unnecessary variables
5:  d8308e96c74 = 5:  cd2bfeaccd2 meson: fix lookup of shell on MINGW64
6:  583c3e701c8 = 6:  9135b7f6012 meson: fix GIT_EXEC_PATH with overridden -Dlibexecdir=
7:  c3edc233952 = 7:  16e0f2d1e22 meson: update subproject wrappers
8:  22a62721031 ! 8:  2ab73ae33df ci: use Meson's new `--slice` option
    @@ .github/workflows/main.yml: jobs:
          - name: Test
            shell: pwsh
     -      run: meson test -C build --list | Select-Object -Skip 1 | Select-String .* | Group-Object -Property { $_.LineNumber % 10 } | Where-Object Name -EQ ${{ matrix.nr }} | ForEach-Object { meson test -C build --no-rebuild --print-errorlogs $_.Group }
    -+      run: meson test -C build --no-rebuild --print-errorlogs --slice ${{ matrix.nr }}/10
    ++      run: meson test -C build --no-rebuild --print-errorlogs --slice "$(1+${{ matrix.nr }})/10"
      
        regular:
          name: ${{matrix.vector.jobname}} (${{matrix.vector.pool}})

---
base-commit: 8b6f19ccfc3aefbd0f22f6b7d56ad6a3fc5e4f37
change-id: 20250703-b4-pks-meson-cleanups-f53858d694f3

