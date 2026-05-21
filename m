Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27403343D72
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351753; cv=none; b=aEVZoBjTNEB4fpczm7FN0CU+vmCgaSH5EwcH3vWrmZhcwYKZtpJmIZK3rKrz6LRyfXg1CigYo/ZmgkK8lZ16dgC3bqWEDxbfQ56RzJqawvmmD2IjId8qQnhICtvUqVLD0ZLoKgQ4TY2QGxsyBrfWym5MNMgW987QKtaYD7oH0p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351753; c=relaxed/simple;
	bh=7YjAEQgU/uapN4OZaaO9NmWHGtySqJRWlhPwMv3eJQ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=InRinMhYudizZO3vfQ6bm/+GoOsVjrBB/CMQ1sZUNbjZXzXzRGWuqEouhjOTyoyO5iOSUg8GlABPkzJpSzdQLFTgsb1nk10U9aUkh4NLR+2ejW/diZrNdMMnx3GLJh6GDSyX6TBl4qeIHPilQuAKrhLwAmxhjhBhEb+Ogr5YU8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oG1qDdP6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f39VGfCC; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oG1qDdP6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f39VGfCC"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A7D6EC0067
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:22:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 21 May 2026 04:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1779351751; x=1779438151; bh=561rpS0uz5
	ur25nptijuTsKL9V+2L3Qu2Cri/u9taT8=; b=oG1qDdP6LCr1UIu6Qhfuqm/NWN
	pexmGJi/qsGaKmGx8hws7SEL8M/O57HTgGlpTZjOl1FmVWhPaapmPYxFUNDybCgV
	OKOksJEbPWSLvBSWklG6HoGpMCwt6NWqM0g3hDE9KgL8UN+qEopNQef4GhW1TfHt
	Y7YDkQTX1zjEN6Uy2hUpR7YlEYcmFg2CGyMhgSpyVd6onB8uliINZcIUUWAYFBNW
	IfZloE2RcL8nIIJQwhbmNKZbkytFRJW1RTMZGjftGFaJSf3HFdkZ1GttNBWKYuEi
	+uvYdcRn/lnfuSq4tGEVzQtk7jdozm7Skr9kRFXQ1fVLk/YYrr49UzRDxzgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1779351751; x=1779438151; bh=561rpS0uz5ur25nptijuTsKL9V+2
	L3Qu2Cri/u9taT8=; b=f39VGfCCD1Izq3vboyA4QbL369PTlo1UefiAyyMgRalb
	T6kdmgvpv4nU/9/tL19HwYP6LYmpP7QlUy1TM3rL/ouiec0sFACB8tNPAq+K+RaK
	J/Nrwv1cAu3wTndk+BrlCpvV/pz7OUm/NTbI0LTsumwZE/cJbgSxssS6VL0PKWX3
	EU7G7IkY1nQ+v9WjSXU+g4lxZ7iSxpSvfECQcGVvHUphOBl4rS5Um/eaGTm7rytZ
	z444Mxc0QG/pPoFJ8juj+Pks84Vw9TM7pH1EkZzGeJ35jcN37bPGG8ArW4GvDe3r
	+i3vliD8C+Dd2LHxWEPryV/2lJEwumnwzjfxYtXV/g==
X-ME-Sender: <xms:x8AOao6xgOn7EfuaQoem5GgISe9yB3sQdg7DjQHhdbRfYfaCaVSonQ>
    <xme:x8AOag1C2YSJSW0mXDnkKYe65V_g-yNNFLFOpxospj6P8W3SKl2WdKcSGRf1_u0bF
    QSbWdPwrCsASqA4Sqa80gl9l0_c-iuGb1fhBpgoN527k8DMVz2XgA>
X-ME-Received: <xmr:x8AOatE492fXqZ_NFBJfhlLomE2tumAk_oGv90nvBaWowV7uTcu4aqmRv57fN_8zM2nf1-Y8Jh27W44S31NQ60vTsF3IIwH_sXsCHoWvpEM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeiieetlefhjeekffdtieffvefgvdduhfdtheduvdekveeitddtueevheejudet
    ieenucffohhmrghinhephhegqdhmvghsohhnrdgsuhhilhgunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:x8AOaiR4cGiF05kQzcZEyYHzsDST-rYJUGaDG61nhbORHqB5NDRBKg>
    <xmx:x8AOasB0KB72FuqtoWku_OfP8XKxPf7-FlxU3zoKh91hKqAzLOr7BA>
    <xmx:x8AOaq0iyRLK5aDGl7DN5qtAJrFldclzvX3x6emMg3DTf0nsKul9pQ>
    <xmx:x8AOaiU7RsFJvLCJLJqOOcPhXSA0c1O4ieNGUdCB7enQoZKP0dcj7w>
    <xmx:x8AOapYYw7ef82OUgRLkG4fzft840qnEAvNjnQL89AH5I7pjbLC05YN1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:22:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 52228827 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:22:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/18] odb: make loose object source a proper `struct
 odb_source`
Date: Thu, 21 May 2026 10:22:20 +0200
Message-Id: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALzADmoC/yXMwQ6CMAyA4VchPdNkg8WIr2I8sK5q1VCyiiEhv
 DtDjt/h/xcwzsIGl2qBzD8x0aHA1xXQsx8ejJKKoXHNyQXfYgw4vg01RTSdMjF+VI0xdM7Rmfr
 OpwilHjPfZf6fr7fDNsUX03ffwbpumUKaGnsAAAA=
X-Change-ID: 20260413-b4-pks-odb-source-loose-4900c8ca91db
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this patch series converts the loose object source into a proper `struct
odb_source` so that it can be used via our generic interfaces.

The patch series is relatively straight-forward, as the source basically
already exists as such and the interfaces already match. So for most of
the part we are just moving around some code and converting functions
that were previously called directly into callbacks.

I guess the only part that needs some attention is that there is some
confusion at first with the `struct odb_source_loose::source` parent
pointer that initially points at the owning `struct odb_source_files`.
This relationship doesn't make much sense, as a loose source can totally
exist standalone without the files source.

We're thus getting rid of this relationship in this series, too. I found
it quite hard to reason about which pointer one is holding at any point
in time though, doubly so because the parent pointer was named "source",
which is rather generic. The second commit thus renames the pointer to
`files` and converts it into `struct odb_source_files` to make the
transition cleaner, but the whole pointer will be dropped at the end of
this series.

The series is built on top of aec3f58750 (Sync with 'maint', 2026-05-21)
with ps/odb-in-memory at d2902a4549 (t/unit-tests: add tests for the
in-memory object source, 2026-04-10) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (18):
      odb/source-loose: move loose source into "odb/" subsystem
      odb/source-loose: store pointer to "files" instead of generic source
      odb/source-loose: start converting to a proper `struct odb_source`
      odb/source-loose: wire up `reprepare()` callback
      odb/source-loose: wire up `close()` callback
      odb/source-loose: wire up `read_object_info()` callback
      odb/source-loose: wire up `read_object_stream()` callback
      odb/source-loose: wire up `for_each_object()` callback
      odb/source-loose: wire up `find_abbrev_len()` callback
      odb/source-loose: wire up `count_objects()` callback
      odb/source-loose: drop `odb_source_loose_has_object()`
      odb/source-loose: wire up `freshen_object()` callback
      loose: refactor object map to operate on `struct odb_source_loose`
      odb/source-loose: wire up `write_object()` callback
      object-file: refactor writing objects to use loose source
      odb/source-loose: wire up `write_object_stream()` callback
      odb/source-loose: stub out remaining callbacks
      odb/source-loose: drop pointer to the "files" source

 Makefile               |   1 +
 builtin/cat-file.c     |   5 +-
 builtin/gc.c           |   6 +-
 builtin/pack-objects.c |  12 +-
 http-walker.c          |   3 +-
 http.c                 |   6 +-
 loose.c                |  45 ++-
 loose.h                |   4 +-
 meson.build            |   1 +
 object-file.c          | 796 ++++---------------------------------------------
 object-file.h          | 149 ++++-----
 odb/source-files.c     |  28 +-
 odb/source-loose.c     | 736 +++++++++++++++++++++++++++++++++++++++++++++
 odb/source-loose.h     |  48 +++
 odb/source.h           |   3 +
 15 files changed, 973 insertions(+), 870 deletions(-)


---
base-commit: 072edab49f312c80561b2899f03f361f74fc38e4
change-id: 20260413-b4-pks-odb-source-loose-4900c8ca91db

