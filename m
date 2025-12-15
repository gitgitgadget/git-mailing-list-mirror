Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD8E31354E
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784190; cv=none; b=OLbJMd27oUqUqN1hemdRdQWyUR+CVKnBFtqhhRLe/2jkXXd3OIn5r1b+rUq3NgSoharCIY/jFw5w7HqL0s1v4iKYl+1M3LvX9xfRA7tNsrTIdsy+bwIttwKL5g/VUxSkNHkW/R3JM2h2Ln9is+YSQowrpnl5n4ahRHUt7ANwBCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784190; c=relaxed/simple;
	bh=ToeWxr8NUrVdg6HjpLZEGzKq5vy4PkmpcF+pAsEl0+A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F13wUszPttFlVFU59RqKif1ptwZ0JiiTfnkeDLUXfIC0ZMyuvxDu32g+qicRK/NAQ4PP8TmALvS/sy+ALmAYqAvcrM95C6hWMBYKJENX/QNqrAPCL76sHdxWgpRydLydtGhoTfXCzRJb5vWoKmqDm/Sc1ZSdE6Uwv/HM+rGDQhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XPkKg73F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iXULQrxZ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XPkKg73F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iXULQrxZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8068DEC008B
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 02:36:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 15 Dec 2025 02:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1765784186; x=1765870586; bh=p0xIeJQ9if
	BPymA5wkvM5AaJAuaT8zMB/Rn4LJERhjU=; b=XPkKg73FIYqPYzTJOJdz1nGnP+
	ZYqYoMztW6WtcJCWcBpWJubkjXuRzxEdlZoJya53quQKKC8HHmcLmB36O3YNs6+Y
	FOcrsPLMUMhTGeiEWcNhCOjkXqDzqNl0hrNLcLmkUHIA1fIjJTdpHKkk2mQ0MG2i
	ljdErpF9kshydGinIkPyKfnblyQMkfHYs98XUt2s25pvRHuntNlZC4O0eLXXwd/k
	cResk6AQlUuB9hFwYuPzcPTj5aFhLMgxEjV4f1NNbhrubcPZRlEkIOKGhZILtQfF
	QHdH83lbPKk/7VBb8L7+ayQvR6qGh7DEenzHO4spfzn6PjjQBpbvj/pd+qng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1765784186; x=1765870586; bh=p0xIeJQ9ifBPymA5wkvM5AaJAuaT
	8zMB/Rn4LJERhjU=; b=iXULQrxZ8opT8iIllUlT6CtAnMPrGjE+26LsyDO9mn6f
	WJW21wfpN37yc1hrstSS+30b3aDznbXKqQzCCS/7Jk8LbpiuV64bN0TqV78IZVal
	vlqUDvb/K4i+12fWeP8Lp5eK2KUSt22S8Ixz6o9gVJOvnZJj2GRf1xeSrDMT5M+k
	e8iJL2Y75Ahe9PPngjHteFu/BsnZ2UtbY97zMA9Plr6JFDRv17fFj7jvdgtLYtQs
	GLmSRoqSdARPYjJRHq6KwhhYHw9cqPBGyloeq+WM46Jm4UZIDT68tryKqD0VptD9
	XyGunImKGBsBKv1q2T43pjDuVZH5wB7QXaQrHh+8eA==
X-ME-Sender: <xms:ero_adJqRDO9yFlx6k4E-5V-MjBt7pm3UMK2nKxceptzj5xhF477gA>
    <xme:ero_aQE8UogkNZUIs0tP1xdhaMBmh2JS-gjAFfEpMVJOpvzHIYEkCWBX8RuECX5ra
    s9Z_WAHOKqLtOjrprGzIpkLpavaXFW5nskYtl57GZgRHdkocuq_Avo>
X-ME-Received: <xmr:ero_abXd-pelaBc1VAjKSdf6VEZd_iieOaX_szWWnCovTGZ_nHd1TgbffgwUcirKgEcdlOxeFnyEK6Boz62LG-ZOqbCuM4vih38CL27J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefiedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecuogfvvgigthfqnhhlhidqqdetfeejfedqtdegucdlhedtmd
    enucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepveeugeektdetieegjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeev
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ero_aTiFUtp6AzFbgF2KwgYGMQndOTZtrRtZBPSJAnln4qaF2ckZLw>
    <xmx:ero_aUT-lxlRDWTdOuWFcEqgJNWqdttZCQ22UhIEZseDo-wuimS1LQ>
    <xmx:ero_aeFHg5Rr28QKc92XIRQJrp55h10kNyqh05-hYu5guozYWqx3eQ>
    <xmx:ero_aUnK5J7JP8d7da21_PuOfyZlo5sX_DykZHAAHo2agLuHlCezjQ>
    <xmx:ero_aaqSUtPAPmYxZAu9aP0ijAuE3U73aa03640dTEjNKANPSyTVP0TX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Dec 2025 02:36:25 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 048136dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 15 Dec 2025 07:36:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/10] Start tracking packfiles per object database source
Date: Mon, 15 Dec 2025 08:36:19 +0100
Message-Id: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHO6P2kC/x3MSwqEMAwA0KtI1hNo6w+8yjCL2kYNgi3JKIJ4d
 4vLt3kXKAmTwlBdIHSwctoK7KeCsPhtJuRYDM641jpjcWwwr4rZhxX1n4TwYI+adgmEU2zqGEz
 ftb6HUmShic+3//7u+wFDR76QbgAAAA==
X-Change-ID: 20251201-b4-pks-pack-store-via-source-fd43dc0765a7
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Hi,

the `struct packfile_store` tracks packfiles we have in the repository
so that we can look up objects stored therein. Right now, the packfile
store is tracked on the object database level -- each object database
has exactly one packfile store. Consequently, we track packfiles that
are part of different object database sources via the same packfile
store.

This patch series refactors this so that we instead have one packfile
store per ODB source. This means that access to any object, regardless
of whether it is stored in a packfile or in a loose object, is always
done via its owning source.

This is the last step required for pluggable object databases: all
object access is routed through sources, and we can thus now abstract
these sources and then plug in a different implementation. Of course,
these abstractions are still very leaky, and we still reach into the
implementation details in a bunch of files. But this is something that
will be addressed over subsequent steps.

This series is built on top of d8af7cadaa (The eighth batch, 2025-12-14)
with the following two series merged into it:

  - ps/object-read-stream at 7b94028652 (streaming: drop redundant type
    and size pointers, 2025-11-23).

  - ps/odb-misc-fixes at 8915881686 (odb: properly close sources before
    freeing them, 2025-12-11).

The latter topic isn't in "next" yet, but the second version of this
topic only contains two small memory leak fixes. I don't expect it to
change, and I guess it should land soonish anyway.

Thanks!

Patrick

---
Patrick Steinhardt (10):
      packfile: create store via its owning source
      packfile: pass source to `prepare_pack()`
      packfile: refactor kept-pack cache to work with packfile stores
      packfile: refactor misleading code when unusing pack windows
      packfile: move packfile store into object source
      packfile: only prepare owning store in `packfile_store_get_packs()`
      packfile: only prepare owning store in `packfile_store_prepare()`
      packfile: inline `find_kept_pack_entry()`
      packfile: refactor `find_pack_entry()` to work on the packfile store
      packfile: move MIDX into packfile store

 builtin/fast-import.c  |  37 +++++---
 builtin/grep.c         |  10 ++-
 builtin/index-pack.c   |   2 +-
 builtin/pack-objects.c | 104 +++++++++++-----------
 http.c                 |   2 +-
 midx.c                 |  19 ++--
 odb.c                  |  44 ++++------
 odb.h                  |  11 +--
 odb/streaming.c        |   9 +-
 packfile.c             | 229 +++++++++++++++++++++++++++----------------------
 packfile.h             |  95 +++++++++++++++-----
 reachable.c            |   2 +-
 revision.c             |   8 +-
 13 files changed, 325 insertions(+), 247 deletions(-)


---
base-commit: a531cef344bcbcdca16c33bd34fbf4ec0065ab5e
change-id: 20251201-b4-pks-pack-store-via-source-fd43dc0765a7

