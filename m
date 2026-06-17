Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D476D395ACD
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 06:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678401; cv=none; b=G+Wii6mYAIt1M7X88dh8kD2ZboOyWurDZZ1TRSg0xgoqMQRUQQCDrf8kpxOwCsuA8cYMAsd+SFWLH1WCW6VjtOxJNAAjj+/ErrM3qGwTDW7hr6V3u8UzZH7sED7NzMFZim6Z0NxCxIwAhiDMHpzuCWIWas6fD8loFWhilDVDenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678401; c=relaxed/simple;
	bh=9IV9XbpEl4zoTs+AIwMburMG71OOfDgRQ0NfIkLM+8Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=qleO/Ytm1Pyrrr6BlNpMSH2RP+74EmKT+Kopckc7iS8lAR/PM2jK1gUxk8Xq6XwANtq8zBwdw0H8V6IsVNQ61oHsb9qhOHMd4otOftafVGvRg7hwG6nT2tz3DH1s66ogwmqU0V+cfzwvMfNJ04/PG33El9tADCNLO5Hu5QDG6uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tf1fmnd0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TOVVsAEQ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tf1fmnd0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TOVVsAEQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0AF7D7A00D4;
	Wed, 17 Jun 2026 02:39:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 17 Jun 2026 02:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781678398;
	 x=1781764798; bh=f1WB7K5XcMdcCow+t+xAsQRk60MqdYGp/ZXa0ngk1Kg=; b=
	Tf1fmnd0IJVto5ofy+BBOhbTXN5eFM/XHTWX5udUGj5Tp+uVbyFAZdJNcR9fPCaj
	8ZixSpSWcSYK5QJfgKxrwcJNfMIkNJGGepivRqytFh0Ajubh108x0kyrchnmiOV9
	ir9ecQ+SR/19guwKz4OTfdT+NrXPHytpHz8/X6kNdwO8J3q8prL7vSoE4s7hYlrf
	IdK3g1VaQbuKa8O8F1JCtDbeJSPvu/NqPo3sr3K/F2569Cr7tRredz0Bxhxxr+41
	KlNWQ9GyLiz8M/2Cv6+txVV379Qi2Pzx2HDpSZ4w5AjIjweY5F68Pn7G7eyFqdBz
	GudPa2EI72jQaGckBW0FNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781678398; x=
	1781764798; bh=f1WB7K5XcMdcCow+t+xAsQRk60MqdYGp/ZXa0ngk1Kg=; b=T
	OVVsAEQ5Nh5AkizrGRviIj6tbYrBjln9+SKNvh/7t4gel5X/xhLjlG3Oda/40ypC
	18/rdlmiNgf0J0Vyi+hqDVp/Pn7DgbDjmUwFL1ya93g46id06hQ9glgOy0HvSWEe
	wHMpyCZJkJWvVrVZpCQjXamxe4C8RCwlYODKRruGglhMwvkxDmNfxq8STWRrihBU
	IXXNj/naXkNjCu7kY9AD/y1aFmEaEYth5SpPdZChuIMbXTLPv70Qjkunoy2G5Z3s
	cpAsJj1uMNUyYusWJ1PsVctRsU4p8JBv4dBa2IiD9mhviwhLhn7fh5XD2b0Z62Fg
	ayz65X5affH9xbkkl9igw==
X-ME-Sender: <xms:PkEyalJmBAIz9pf8aYt5FEPPknmosqk7Z5MPwxNDj6DUotP5ZNf11g>
    <xme:PkEyaok0N_FuC0yaTi_uWxVdHfVJzalO43mXnGPGrFxiAWni_SEuJK695uWJvjnXE
    Y4XCqRDhuGmbyNw85nPrmFcA2b45dHw9e9PLphZ5HCEHwDD4jKh>
X-ME-Received: <xmr:PkEyarF8fr4apnIMiEVmk0ETCE5g4FeA0AsVaSEviDvCSKDCXnD9QreGegVtkbGiS6iVlbHhgGYA0AHIPPzaGRdEQfLLtAI1316JiIg>
X-ME-Proxy-Cause: dmFkZTFI8Qd8j6YHDuv+q5UqAZll9VoWg+5FC5DBEanMTAJFfQCGGoFgP7rNfMoxE66Mgx
    OgORW0kSi9zUx4Qf3riw2GEemonrVnbt+vkWQRoiiorcwespp/ntINjxlnxbXxiUnUTbYk
    ZAUyCBaTSuNAWH2EFSLbrwuFccB4S1xNu7v8pAls34x2cAIEvbT+EOAG+oYH47CU+Z/xaN
    88nmCOfDG9INTStO7anxlWS9hur6cWnhHd7GJKY7cWkt/r1Zgd4nBZ4sHSrEKY5mZRk3wN
    Wb60QNepNSqRIed663yaGbqy18JTbH1ByJXxXzUZvJOISjw0hp3HoNY7AyO4nwknQlkYqv
    Fb6TCAE3YcnICQQ5U3ewUh3YKvjFkNZ80WuZHYjJCEzi816oG+KZRKjKy5LaU+vfuUV0TK
    1IGLktyWUsPHR2Ln7UFEUu9xJWDbSPjZbaRCD62y91KmcJtvBH9fSSBCXHQSKoZApCMXw5
    QA/s6dy+nZ6IF5GBcD8+0FoKdxwAWhOUtG6qU14Y1hyhBumIiwnk51SwF0ESdfdX9I7H8x
    yb3S/w4SIMLmhLnNP5F1IBFFKVeMiNsPmrLk9JfdCaJ3IHoXTKCUDTtj530e37D7biLNZO
    uCwiqfokE9me1thc/4y15F82GDTMfnAERvCTV5ze7jaBS5F46R7bnYTArLGQ
X-ME-Proxy: <xmx:PkEyagGh2Bl8lxi71szrfM1qXshFuG2Gm_OsRxfYwTCKnx4CUJnfqA>
    <xmx:PkEyagPvMFd0sRmaTlXIO0EuWBdPAQwpmtQROx_bd--7WRZyoD5vfA>
    <xmx:PkEyanH35xF4Mgv9TRWvSxtjUM2wQAttZNWxOZXg35vS3Sl1Buag-g>
    <xmx:PkEyavPqEpBm7IUQygCJAhWsDAqlPLRUUAJvnJFOGtvZyHsENaUSOA>
    <xmx:PkEyamBtkQ63L1rdVSIGmPFrkG3Ev3ipppQhfhJ_Ce9AZsW2vY3NjAQe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 02:39:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eec2c287 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 06:39:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/17] odb: make packed object source a proper `struct
 odb_source`
Date: Wed, 17 Jun 2026 08:39:43 +0200
Message-Id: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADBBMmoC/3WNQQ6CMBQFr0K6tqb9BSyuvIdxQctHqpGSFhoN4
 e62GI0bli+ZNzMTj86gJ8dsJg6D8cb2cYhdRnRX91ekpombAIOSlQzocPfUNop6OzmNdKj1HRs
 qJJRaFNCyoiLxOzhszXP1ni+f7Sd1Qz0mWSI640frXms48MR9G/lGI3DKKOChVoKrXBX6FLm9e
 ZAUCPCvqLYUEBVSVExWXICW6qdYluUNuHbIjwwBAAA=
X-Change-ID: 20260602-pks-odb-source-packed-3826c352f059
In-Reply-To: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this patch series converts the "packed" source into a proper `struct
odb_source`. It's thus the equivalent to [1], which did the same thing
for the "loose" source.

This series here is unfortunately a bit bigger, mostly because I'm also
renaming `struct packfile_store` to `struct odb_source_packed`. Back
when I introduced the packfile store I didn't yet have the full vision
of how the final layout will look like, so I didn't have the foresight
yet to call it `struct odb_source_packed`. But now that the layout has
materialized I think it's sensible to adjust its naming to match all the
other sources that we have.

Also: I don't have anything else in the pipeline anymore that moves
around large pieces of our code in the vicinity of the object database.
So after this series got merged, subsequent changes should be of a more
incremental nature.

This series is built on top of 9ac3f193c0 (The 11th batch, 2026-06-02)
with ps/odb-source-loose at ef4778bcba (odb/source-loose: drop pointer
to the "files" source, 2026-06-01) merged into it.

Changes in v3:
  - Add some more explanations to the commit messages.
  - Link to v2: https://patch.msgid.link/20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im

Changes in v2:
  - Split out `struct packfile_list` into a separate code unit to fix a
    cyclic dependency between "packfile.h" and "odb/souurce-packed.h".
  - Fix an extraneous newline.
  - Link to v1: https://patch.msgid.link/20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im

Thanks!

Patrick

[1]: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>

---
Patrick Steinhardt (17):
      packfile: rename `struct packfile_store` to `odb_source_packed`
      packfile: split out packfile list logic
      packfile: move packed source into "odb/" subsystem
      odb/source-packed: store pointer to "files" instead of generic source
      odb/source-packed: start converting to a proper `struct odb_source`
      odb/source-packed: wire up `close()` callback
      odb/source-packed: wire up `reprepare()` callback
      packfile: use higher-level interface to implement `has_object_pack()`
      odb/source-packed: wire up `read_object_info()` callback
      odb/source-packed: wire up `read_object_stream()` callback
      odb/source-packed: wire up `for_each_object()` callback
      odb/source-packed: wire up `count_objects()` callback
      odb/source-packed: wire up `find_abbrev_len()` callback
      odb/source-packed: wire up `freshen_object()` callback
      odb/source-packed: stub out remaining functions
      midx: refactor interfaces to work on "packed" source
      odb/source-packed: drop pointer to "files" parent source

 Makefile                   |   2 +
 builtin/cat-file.c         |   4 +-
 builtin/grep.c             |   2 +-
 builtin/multi-pack-index.c |  29 +-
 builtin/pack-objects.c     |   7 +-
 builtin/repack.c           |   8 +-
 commit-graph.c             |   4 +-
 meson.build                |   2 +
 midx-write.c               |  34 +-
 midx.c                     | 118 +++----
 midx.h                     |  30 +-
 odb/source-files.c         |  20 +-
 odb/source-files.h         |   4 +-
 odb/source-packed.c        | 764 +++++++++++++++++++++++++++++++++++++++++++
 odb/source-packed.h        |  94 ++++++
 odb/source.h               |   3 +
 pack-bitmap.c              |   8 +-
 pack-revindex.c            |   6 +-
 packfile-list.c            |  86 +++++
 packfile-list.h            |  28 ++
 packfile.c                 | 784 +--------------------------------------------
 packfile.h                 | 180 +----------
 repack-geometry.c          |   3 +-
 repack-midx.c              |   9 +-
 repack.c                   |   6 +-
 t/helper/test-read-midx.c  |   7 +-
 26 files changed, 1163 insertions(+), 1079 deletions(-)

Range-diff versus v2:

 1:  9f917fe0cd =  1:  9c4cb4106c packfile: rename `struct packfile_store` to `odb_source_packed`
 2:  eb6740c34c =  2:  198b137c84 packfile: split out packfile list logic
 3:  5c363883f1 =  3:  fa91889861 packfile: move packed source into "odb/" subsystem
 4:  caa19f59bb !  4:  5f0da3a334 odb/source-packed: store pointer to "files" instead of generic source
    @@ Commit message
     
         Make this relationship more explicit by storing a pointer to the "files"
         source instead of storing a pointer to a generic `struct odb_source`.
    -    This will help make subsequent steps a bit clearer.
    +    This will help make subsequent steps a bit clearer by making it more
    +    obvious whether we're using the generic "base" source or the owning
    +    "files" source.
     
         Note that this is a temporary step, only. At the end of this series
    -    we will have dropped the parent pointer completely.
    +    we will have dropped the "files" pointer completely.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 5:  8eb3cb17a1 !  5:  c9b1e1da26 odb/source-packed: start converting to a proper `struct odb_source`
    @@ Commit message
         odb_source`, as it's missing all of the callback implementations. These
         will be wired up in subsequent commits.
     
    +    Further note that we're also registering a `chdir_notify` callback to
    +    reparent our path. This wasn't previously necessary (and still isn't at
    +    this point in time) because all paths are taken from the owning "files"
    +    source, and that source already handles the reparenting for us. But a
    +    subsequent commit will change that so that we're using the path of the
    +    "packed" source, and once that happens we'll need it to be updated when
    +    changing the working directory.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## odb/source-files.c ##
 6:  0b81cf21c8 =  6:  350cc18b4c odb/source-packed: wire up `close()` callback
 7:  3024f236eb =  7:  b42a633423 odb/source-packed: wire up `reprepare()` callback
 8:  e3553cae61 =  8:  2eda992ff9 packfile: use higher-level interface to implement `has_object_pack()`
 9:  0d4d888c66 =  9:  81201eca00 odb/source-packed: wire up `read_object_info()` callback
10:  0a81bc811f = 10:  2f6ea598a5 odb/source-packed: wire up `read_object_stream()` callback
11:  fc4b2477b5 = 11:  154ded231a odb/source-packed: wire up `for_each_object()` callback
12:  58c7c4c6c1 = 12:  a35c357358 odb/source-packed: wire up `count_objects()` callback
13:  b81e053716 = 13:  134c51a0cd odb/source-packed: wire up `find_abbrev_len()` callback
14:  424b9ee1b2 = 14:  542694cff2 odb/source-packed: wire up `freshen_object()` callback
15:  f91f6355fe = 15:  fa222d0cda odb/source-packed: stub out remaining functions
16:  877721f2ea = 16:  cee3806dc7 midx: refactor interfaces to work on "packed" source
17:  5779eab630 = 17:  200fbcf4bb odb/source-packed: drop pointer to "files" parent source

---
base-commit: 06d49cec508464ced5d42541890ce5d749542a61
change-id: 20260602-pks-odb-source-packed-3826c352f059

