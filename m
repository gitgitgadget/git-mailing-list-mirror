Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47E933E34E
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302033; cv=none; b=i9cuoVjKhFjKEeQ24bKgCXvDCx9NsXFGwyajtoMCPHOcuGyrvYeIkpdAj8EkcTujDgEViB4DX32cby1Xqw3GNoaYRFQGY5s+AVBE+9TsHEdRScXu5YZrIPS3sAYbD/WT6DEdTD0r80o38IIWk81MB7KbmHtCWqtcApHQXDlgq04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302033; c=relaxed/simple;
	bh=Y/er6sSgD2Bmby1JoYSuVAOepCR+loeJfYa8yqltHv8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=f52IRMVoUf/vOpvLhvplxWNDXO5yoVN+RjjolP4wTaQG6PaOswWuq091/gZUmfpPY4cNlOC1huJgUHmzMGTADKF182qHEjS+EtXbrEhn94T2ynBZe3yf2sly8ntsF+jV0TIg6jXD8hWbVk//6EuQgMNkNtrjvAdl4w9qzc1uWXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uOBwZctj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=By1aKSca; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uOBwZctj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="By1aKSca"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 232D11400083;
	Mon,  1 Jun 2026 04:20:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 01 Jun 2026 04:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780302031;
	 x=1780388431; bh=Ua3ayZIQisfxqZOyr96CvNodghVTKlen9EqDVulKJAM=; b=
	uOBwZctjrLITpcoVlTbrVdw5VyN3W9O9EPJewe3plRMbt24l8Eafg7IBWH5iB51O
	yNmrMBzXENGhqDLcygEHUv77GtszvV+FcCHKLW7dH2mzjKyAF0KeQNbm1ydGbC0x
	lPpC5OsIXsssAw3P4U+CCF7p62aFLQcNcNEo4A5izveDD0QIqyF6KiE4f/RQV1Bu
	QVquhaa2LdEPsvvLFo7IIOuESvbSmdhDuEuKjJAk5z6/lKlVbVzpiB3dzM1V6gNX
	YSACC9Wa8N6Pdg66HE7FLfda0/XY1+wCWqsJ/tcBei7VOy1giX2Ft/LWwm+RFJMI
	LqBf5EV4AKx2MZgi63ROuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780302031; x=
	1780388431; bh=Ua3ayZIQisfxqZOyr96CvNodghVTKlen9EqDVulKJAM=; b=B
	y1aKScaNfV3akhIRfpVymCAotbZXJI9lA+tc1ow9p4DDlY/K6nEKBRsG0Jg4uqDq
	RNZiOVbsuBg7Y4a8/2zFsIKQUIGjpRubR3bme7T5gwGMacWJ3oT3QiSg5gU6qvPv
	syGHqqjRnYwugutMXWohoEjt6IzhrrJsvAUj/UuXapVzh+9HgzuRgD4v4H/eFBY+
	rvnhnjPX92RSCuWs/ucM6w26LtiBFvI7oWgQOze9zb6IGORNa2UMRnTXo62uk6ux
	6T0l/HokjXwdbCYoh83kyUXY2TREh+mUOG1M89MIJMZUSU4c5XTV0wqJKz9ltjnW
	IsQo/qJy3B7TS9UOuWi0w==
X-ME-Sender: <xms:z0Adanh-LwO4ocHCl5F6CCEiRockSMMp-ErnNZSJlrrY0W0xjclzPw>
    <xme:z0AdaqBIDIb1JRvlTsSFjRQuuyMKViSHmtBrm7xZ-gkGEEI0chfnP82is7jnIJ5-Q
    mVaQSdi75SRrACMZG3X8dn69tTUTX04aDs0Lfj0TWtwUSZetYbDcw>
X-ME-Received: <xmr:z0AdakuiQwRY1loHEHoWeFW0zD8uqcjYK_2ZjJS0XWnC4Um10QYfaqAV-l9WX91D-joCoMZApAxK6vBJ9vO1-Od9ptLd8N68qOewiHIFJmHJ>
X-ME-Proxy-Cause: dmFkZTGhTLKBqCArw18o2teAVq/REBEi9flIJLQXc+2XzFd9aX3CWlmd2+bENirqkyuJXv
    W3ZpKbZXZi6zNk/US128A9RQsCQGBZHXyBMSJ6KG8eO5ZANnqaAwH5R+VBliuE0wTuUgiF
    P1kUdaX1slS9gtcuhf5GaU1z4KKuxOchEipTNHTWDP+c8kr5WIcgXnWYLbE8j5zm7Wy3uq
    b6JrwjYXw8vCsxoiyxeh6xP6AWEujJsoCkBXXVkvmXiNH10SAOk3wSZo0TSI9bFQQqooCC
    Pup8vc+PjTOeM1fIJvuposyE+nTkMf3DdTb7TO+EyLlT8DxFP0W9Ji8xYRE9Yz50MJCWhm
    hen6rpRxAqhLBXgc/ndCbiHIznxOWyp+CoHdKl6u42m16goyrD0kVCde1dX9XVTgEkDdFX
    +sHxNhpFpO0avyUyaeMVIDok2NGu0xCVuYtXKMalmbkS+pKQRnEXMG1oAfRZqIrV8MkRFH
    ixvARymMis9JiBX0XyolkGjsjupxmDBXTcCKWLNupXAipss9BKXGR7VNDOkVVscfvhmNOC
    ydYnR9k8WIIrT6juknhU1aJ5Z/8CSujVVwuiQMNT+Rpwdne13INOXYTVB1Em/OoD4rb4mO
    Rn2ORp1gLfVDfHx2n/jy0svSe7nRZqI9MMXBVFZPdEKvRsIU5sFiAh2bMRmA
X-ME-Proxy: <xmx:z0AdavbEmWN_MaKkd5rX2ICgXZ-YIqXe9QdzPB1zR53ANNycNjyLZg>
    <xmx:z0AdanVe_F-9vaQd8bGKLu4dgAfOp7K4CAjuknvA1630bGY9T01sNg>
    <xmx:z0Adaj5BxcIZqnWUE5T-bRf-qG2Qm1fF7OQjl6ImIjUjYinhQXpFzg>
    <xmx:z0AdaiguV-uDNQTLrPfxiRurQKI9rHFDo_p734bdc2HqXSL2iFIUXg>
    <xmx:z0Adaq4oPbxfgxHRIaaKuwJwfNdPzZ5Y9F1n93z8-JeFzsFBBFiqQtdr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:20:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f8a14553 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:20:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/18] odb: make loose object source a proper `struct
 odb_source`
Date: Mon, 01 Jun 2026 10:20:23 +0200
Message-Id: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMdAHWoC/3WNyw6CMBBFf4XM2jFtecS68j8MC9qOUh+UdIBoC
 P9ugbXLk5x7zwxM0RPDOZsh0uTZhy6BOmRg26a7E3qXGJRQlShkjqbA/skYnEEOY7SErxCYsNB
 C2JNttHQG0rqPdPOf7fla78yjeZAd1rvVaD0PIX639CRXb6+USv6tTBIFVmWZm1xrQ8pdknb0b
 6iXZfkBeS23jM0AAAA=
X-Change-ID: 20260413-b4-pks-odb-source-loose-4900c8ca91db
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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

Changes in v2:
  - Some smaller typo fixes.
  - Link to v1: https://patch.msgid.link/20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im

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

Range-diff versus v1:

 1:  f25aaf0889 =  1:  7c97c1687c odb/source-loose: move loose source into "odb/" subsystem
 2:  0bfebeb0da =  2:  1e1e267b39 odb/source-loose: store pointer to "files" instead of generic source
 3:  35787e6ca6 !  3:  847cb523ee odb/source-loose: start converting to a proper `struct odb_source`
    @@ odb/source-loose.h: struct odb_source_loose {
      
     +/*
     + * Cast the given object database source to the loose backend. This will cause
    -+ * a BUG in case the source uses doesn't use this backend.
    ++ * a BUG in case the source doesn't use this backend.
     + */
     +static inline struct odb_source_loose *odb_source_loose_downcast(struct odb_source *source)
     +{
 4:  392962c177 =  4:  af543598ee odb/source-loose: wire up `reprepare()` callback
 5:  b4102668c3 =  5:  884f573f89 odb/source-loose: wire up `close()` callback
 6:  63da6e4abb =  6:  de85ffb4a9 odb/source-loose: wire up `read_object_info()` callback
 7:  12b0c5c32d =  7:  522aaa9c3d odb/source-loose: wire up `read_object_stream()` callback
 8:  8df176e282 =  8:  75cf3f4428 odb/source-loose: wire up `for_each_object()` callback
 9:  6199ae90e0 =  9:  87c1c9ae5e odb/source-loose: wire up `find_abbrev_len()` callback
10:  d0b1ef48d4 = 10:  f6405c8070 odb/source-loose: wire up `count_objects()` callback
11:  0476d8b0c4 = 11:  0e8d6b6487 odb/source-loose: drop `odb_source_loose_has_object()`
12:  27bb7b0724 = 12:  58cc626dd1 odb/source-loose: wire up `freshen_object()` callback
13:  f8ce6a169d = 13:  51a22e7400 loose: refactor object map to operate on `struct odb_source_loose`
14:  7ab570b776 = 14:  a9a88d6200 odb/source-loose: wire up `write_object()` callback
15:  8c9240aaa0 = 15:  9236d2fd26 object-file: refactor writing objects to use loose source
16:  de69621fa1 ! 16:  6316efb890 odb/source-loose: wire up `write_object_stream()` callback
    @@ object-file.h: int index_path(struct index_state *istate, struct object_id *oid,
      
     -int odb_source_loose_write_stream(struct odb_source_loose *loose,
     +/*
    -+ * Write the given stream into the loose object source. The only difference to
    -+ * the generic implementation of this function is that we don't perform an
    ++ * Write the given stream into the loose object source. The only difference
    ++ * from the generic implementation of this function is that we don't perform an
     + * object existence check here.
     + *
     + * TODO: We should stop exposing this function altogether and move it into
17:  f2d45e1a56 = 17:  789ec50474 odb/source-loose: stub out remaining callbacks
18:  070052fc22 = 18:  0a64d23377 odb/source-loose: drop pointer to the "files" source

---
base-commit: 072edab49f312c80561b2899f03f361f74fc38e4
change-id: 20260413-b4-pks-odb-source-loose-4900c8ca91db

