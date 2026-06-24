Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A954C233939
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303572; cv=none; b=R0zTAz0bQ7hIw+oFi9oRj9XfvQ0nduHDcF26GPNYZFqmKJ8fIL81wka8eFNrOfX/Xr5fy8wgPub6oFOLd2eokpddk62t05FDSh2uWhl75eITCIJL1yfIiFIRGZ1CAApjzfesGsh6GTeJ5kmXWmvR16jQCJhA9aF/CqNMLJY5gH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303572; c=relaxed/simple;
	bh=bTdao1+m0AtHVEHtle+64ibA66wNO9toK438lzWjlj4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nRFWLwDMzvisSNcD+cmVS5c98VPFjfrPRQzAovOXc0UrkHnouMKOkON7DILFCbZdoKsvBYj8DX+Hx0xZCJQfIBYBYXliF5uD/7YrSIA2jWpEJ5uRW5QHFbIqBXrP2osocHxgvLbmhg2jTCS0BO0EQ9DIFt8MBjYfhaNxXIkCFBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ql/LAKem; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xv4fqNX5; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ql/LAKem";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xv4fqNX5"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 043871D000D8
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 08:19:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 24 Jun 2026 08:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1782303569; x=1782389969; bh=xcfH7ctvKZ
	aztOub/5mgkooUyeKAzBljHI2Re6gsrnM=; b=ql/LAKemt8GBp9KXYWd5mR51ob
	fH+abEn0OklIF6Kif8uisdTx0t3aMvRODTakoyoNyQX2jQHVOkSi4f1e7/rbiLTS
	zA8RIUnaCkCyiTO4AJ7rpEHx+ry6iqzJ5pEplf8HvQgKbA0R5urjr3RChycmHYsJ
	X8+zPHSaZcQU/SWnv8Yrb2iSrxjE0DCdFgBZUX0Iu289h2NprdcThLnsor9smZU4
	aCntiBWstDtGPAie73t+C6QRomQdhf0Y/nYOOwXrf+LVeoxVFvVOftLcraIBri5k
	tx7EFC61yWDVwjEqAzn6TqwQ7JnzOiZHlGWo1k9ngrbBgGmJpw9PhPVY1elQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1782303569; x=1782389969; bh=xcfH7ctvKZaztOub/5mgkooUyeKA
	zBljHI2Re6gsrnM=; b=Xv4fqNX5+LkbovciQjwh4Afh6qpPWCUhhE5mhGQJ4tD7
	5zOBG/ofc8Uh6WPi1UhHCTCPT91bED/FU/vNxJSKcOBNOuoT6rDaa1T9k99qd9NU
	It5xOPWOH/P9epubRNn5IpjJ+W0oHayd9B1zi0izyetukplLshVj4sv/Q3LQnq1k
	7FI2JevNVT2264DI7UAQCffkDr195YWOxhGf8YLB76/dW8++6z3Bf6XtaLGx8GkZ
	L9OuiFq16jawvxWLeec3zldft82Iw3PQgIfqHTkc24m3KjC1Qe8O9YI+4MZ7VdCm
	Bv4c3tQ2Am3jrN5LxMoYHR2c/28pBd5vqNqqjTZ+nA==
X-ME-Sender: <xms:Ucs7anhd0ROZHx4Yv5WVXrTB1utHhEGXCxjZ1oD8utZV11o0kd0kQQ>
    <xme:Ucs7aq-wXmtdGByGXzktCL53c4Kc4miBLUppPs7LDmPMRcgrOki6iCLa_vhMF_jz-
    6r5HBG0ZCzWpOMZ46VfD0SEdmi1G9JAVD97EG3bbByNkqd-wRWT>
X-ME-Received: <xmr:Ucs7asvfhOk4Pk3vOz0qFWEn7edbTNJyQTMXR96nth6DfG5pqQSANe3WtPZC88gmApmdn54KuqyGM7ncCOtHGSg5hCZ-h0jXypmkXVoN>
X-ME-Proxy-Cause: dmFkZTE0QXX3oGX/6ms+Uk0nzzgi1bEOHKImRuojGRqkeU/ONcX5+833QNLx31STgCyabK
    OeNn5NSY55bw/0R6Ra5ViG1f3RBpJH0hn6aO6LloH4hz+KfvoUE7kxt+C9g+nKTUFqiLXx
    uhtn7SSXlIQk6ND4PRjbWwG3szqOHF1S3acV/i2MAUUPpFat2SSDCV277kStnGy+pXYodO
    buQ3UDIwqaGbBf8PBwTUJUCk1U/ACYIbm642/m2Gnb1QepcoQ18japLyCE4LdXPxXH9asx
    Zy8b25JVEb8GLEmv3iujsiCoVnjLECFOClXjQ9nJjnTEaMWaGdEOlps81OD8GRA1KoSMDw
    EovdmKnkGNnXd9hMoP5gjpQFn5BigKaK+qZMYAxwBJTeBxxQluKHhd45bSbnHkf6K96VP2
    dk7bNHdpWLPlqFSU1MHX6lckKBd8Rpk9te6cNL5IexZ4l/gb9HeeCPyCEYQMEIwbtd2ltk
    H8SFqkJ1nQ2ZVNAOWhrjd7soNReqM9HOHcJVxq3JIrakWFZi4hCa6h6z4JjagN/1IsExji
    9F7Ai0kPczXVh759jzazHwqOJTZmIHc8BMex3Gtw0RqSujYzt0kPb9pIR86IdKTIy2vcMz
    1/GrHxVejbS33/tC0G9taiZnsATwB70DN1vdt45PUAuTXIUqY+11y8LJTsNw
X-ME-Proxy: <xmx:Ucs7apYsPZC-P-2egHqF_YIHLYvfc9fLLoBXCwquPtOHKUHt9VsU9g>
    <xmx:Ucs7akq1hy8TwVpy8qcV42zIDceY9RHTgDsKeNSglslFola4e_0-oQ>
    <xmx:Ucs7am-ZizfhB-BqdIScLgvEYDjvG548Vh7h8oFvwHdfaEIDSKQvHg>
    <xmx:Ucs7ar8XndUvyKfvT4-88fBX5WRQZOxXU7mgwLPc3bsJSS2EWnu2xQ>
    <xmx:Ucs7aojNze9hNad8thlrzHz96t56MTH9tezOJqFUJqTHse2XnjKgiE4X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 24 Jun 2026 08:19:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5ed5bfb6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 24 Jun 2026 12:19:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/6] odb: refactor source-specific information in object
 info
Date: Wed, 24 Jun 2026 14:19:13 +0200
Message-Id: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEHLO2oC/yXMwQoCIRCA4VdZ5tyAyiLUq0QHR8d2ClSc2oJl3
 z2r43f4/w2Uu7DCadqg8yoqtQzYwwRxCeXKKGkYnHHeeOuQZmx3xZoIU68NXwuXyGjJhHwMZH2
 eYcStc5b3b3y+/K1PunF8fG+w7x/m7Y3IegAAAA==
X-Change-ID: 20260612-b4-pks-odb-drop-whence-1b0af9ab16f4
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this patch series refactors `struct object_info` to not contain the
`whence` field anymore.

This field only gave the caller information about the type of source
this was read from, but it didn't allow them to figure out which source
specifically yielded the object. So instead, we replace this information
with a new `struct object_info_source` field that both contains info
about the source, and any backend-specific data.

With this in place we can re-query the same backend for any given
object. More importantly though, we can eventually also use the backend-
specific data to also uniquely identify any given object, e.g. by
recording the packfile and offset, so that we can even yield the same
object in case one source contains the object multiple times.

Furthermore, with this change all information in `struct object_info` is
now following the same request-response-field style.

The series is built on top of 26d8d94e94 (A few more topics before -rc2,
2026-06-21) with ps/odb-source-packed at 1bba3c035d (odb/source-packed:
drop pointer to "files" parent source, 2026-06-17) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (6):
      packfile: thread odb_source_packed through packed_object_info()
      odb: make backend-specific fields optional
      odb: add `source` field to struct object_info_source
      treewide: convert users of `whence` to the new source field
      odb: drop `whence` field from object info
      odb: document object info fields

 builtin/cat-file.c     | 12 +++++---
 builtin/index-pack.c   |  9 ++++--
 builtin/pack-objects.c | 19 ++++++++----
 commit-graph.c         |  2 +-
 odb.c                  |  4 +--
 odb.h                  | 80 +++++++++++++++++++++++++++++++++++---------------
 odb/source-inmemory.c  |  3 +-
 odb/source-loose.c     |  4 +--
 odb/source-packed.c    |  4 +--
 pack-bitmap.c          |  2 +-
 packfile.c             | 45 ++++++++++++++++------------
 packfile.h             |  6 ++--
 reachable.c            |  7 +++--
 t/helper/test-bitmap.c |  2 +-
 14 files changed, 130 insertions(+), 69 deletions(-)


---
base-commit: 969dbd51a70f9105ee9965adec5c5a02e75ab5b3
change-id: 20260612-b4-pks-odb-drop-whence-1b0af9ab16f4

