Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187063CAA3B
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400172; cv=none; b=OTVnUiqUNoOyQ7zMnx6RSHDw2895zYY383PsAwU3U/8Ks9nW3/mnrMqpEl2MwnnsujFkhf89vpYflCE5UyNQNfT+j5ohFY7gHG9bcule07MVbfcuFM9xgr6eKE9gYKciHgMsoYXnJVD45/p8wpMTwAoJR0AhrwAfQW90etvdaEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400172; c=relaxed/simple;
	bh=CE785o1GlW0nDucK4TLl/uaCGKnXGu/HQIyHSNIZyfg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z98e+2mWvqRLGR81VjnZvVTsWTjILrfKLeJbpcvKf+SQ34gDFBM2pTMy2lhf/FrADgc1DrQiVvPMDMyPqjEqaU9bbDx5EDaRJTu4z924X/aF9TH7jLTqYdEVe53j8bcBRz0pem9W1pIlvCu8wvLX8LYXeQ/wkZbMYlsR1H3bLPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qcamfSOr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bdbYB0V5; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qcamfSOr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bdbYB0V5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id F339C1D000CC
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 04:56:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 19 Oct 2026 04:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1792400169; x=1792486569; bh=sQsQpNS5O9
	DriHD5VM4gteaC90lnVtg+T4GGKldLGFU=; b=qcamfSOrsTWQBsXgrk2+pnnsGK
	/SwRqhXKrV0B1z+DNVrBXHp3go9vs9w4hDIcDpI1N+5Ys9oXbOLEGRe1FxQqHLTm
	ESk4mh7ucBrq2e6sRVX/2skJwEG9ZlcHqeIlokJUfeSgOWiMZ/iPOpPmbDjKNe7k
	zIUgGuD7rIOmcn8tD8mrSLP8Aeh6zJ0Mio4gViXWiH6L5I2DQkgcSgYl/X7lOx7b
	5LD2ytFurn47kw2TXH23baFwBpYn4EEBpHIpweV+9j65h6Y3V0dq18JY3BEZSW/N
	kNz/QLRWGSFZhudN8XWdcryNUP8J2hkALWRx3ve4Y1z9UnzMmCz52dNkc9kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792400169; x=1792486569; bh=sQsQpNS5O9DriHD5VM4gteaC90ln
	Vtg+T4GGKldLGFU=; b=bdbYB0V5o8kFPnHIOmyJaJRjIuNGN+5/JaPA8mD+Apcp
	B0WrJVpp3I4xg4+l+9A4hFqB1n5kSoTqpS1//v4cRdPE3AOn4dqh6demPf/r4ZlE
	TYJxKd4J9IoJI+mLaI/9N+4WbW2RFJlsrVlaelJnyi0rSNl78ataE7abDCVF8qJC
	AEHjwUfCL2h94DQRHkJQOWlOuOLEQczrwC9ZAv4Y1n1CLFda5Crlu1oA00kx1AyE
	CsNCEaOV3o6KqNCz4narIocAgH0mffwZG1TfiFV/6CwcgtVYVVUdHenCPlLB0qkk
	lEknynbI31yVUU8/CSbEwvv/hHK81AIhu0OBFF7Keg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792400169; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jK6NFxJXIwg7EtFKulUXUCHGmuD7yf+A9a9AO+jmIVT4/hE
	D27fv7RHox4wP6CKBM4nuppMUndorym8v02x/mAvAQuYeuUMf1c/kXY+71XYIexz
	xxrDC5hiXz2NX1jNpTmFxT8HrugDJqABKByfMGDLLlmjRwCD1vmnjLWyef3BpeQ1
	mfmGmvO5m1APYXk6V1wgk07DMv7Gd8vd2VjONZCnpaX8awJd8tgtsejeqlhpcDca
	11Y/xalXlQhkI01GQkTD6Fkg2FdpPzxd+Tf05q8M4cJxNYC0M5EKC8ynK16zVKsq
	/UjxrEgxPGOxQQJOm9KoxI9mLjWKVPHyJ6/JcTg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:2rAfLbXiY1w3ZB7YPC4IOyWRMDyUDz9vvTE2DVrvu38=:CE785o1GlW0nDucK4TLl/uaCGKnXGu/HQIyHSNIZyfg=;
X-ME-Sender: <xms:KdvVas-AGcscwU3siL8JAvuoBuIinFeoiSqnTFwr5WmmwOzvafiXng>
    <xme:KdvVarrmCUt8r9UHdZGezJ3gVTLRXwDRky1u1DhACQZLhkMWtmCetiElM0epM5qF3
    Jvklsfj8GQ4KvMSi22e5WTw97GpimmKmMtl6XFdU3nSZx2eZqE2gA>
X-ME-Received: <xmr:KdvVanrEHFS2ueG7GwP-p-kvM1_gum_TfQUK6z0lQ9-Jn_75CYK_vQ>
X-ME-Proxy-Cause: dmFkZTG1xZV9DeBhPrHnrkpJfIWMvML9HMqyXPQRM2JIrWMpcTQ6m1qFPuKezZbBBnN9HL
    kfjchT17z+Gt+7ku/XuZwJ5fPzbAQnj9Lk32IdblBwehDBO1MNU2hH9HvU1RjQlGM873PS
    3+OTQ4IFonkIuxl8pYaos6V7GsMqj7NGefyOmNnmdjDWTbiy+Ccvn4NOvIVbjLeyFRdl7y
    9sX769a+oTkJdMRHE+eo0yt05RiqdWVPstOIo736ULITutpeQZ27jpeH8v3W89NaOvn3Rs
    BY/GPUkWcFw/vFHs3F2qdWRBBWu4yNUPKGma5ZvXonb3Tqg+GyPLtRxB6gngAmkitQVyZe
    3oHKU0Qhli0pJIEygKfXbHvB2lMdIhHcltAksGZ+TLstSJjNiN8jvO6PIhIg96D61e6++A
    mKm+l2KO6jw6l/p64TNz2IGcFT8khIJI1ksBhMBj2UpkqX+cThHHwjaXgBuM3dZ4Mut59u
    I09v/lb9R5IoOfiE8EWQUoKOSbqsiFfb9XyRwUxOV5OrUcngrFicqBJPUDljh/KhyExkTA
    WuW9cooyhYkJ0U+mn0aGzOKHUuToyTSzc40cD8B2LTgc0L0GQmkFsLOA609r5XcTnK3+6g
    mWum+etvLpwcO5lBpzHiUIUEiySJhf1vVmyqTFfbCXsgWNdDWq6HsO5rScwg
X-ME-Proxy: <xmx:KdvVahnFsv2S-6ZJ42JNQ9vD3OuSwdK8vrtp-2BfIE6ycTJm6K9F1Q>
    <xmx:KdvVahFXY6TkcM7p9ZibZHGgYxKRESBvicLA7fF1LUc6ZWU4RTDVOQ>
    <xmx:KdvVaipF3AH21Td4B6-zWGoDED2Gu5yUDMPSEe2r_LMc9YZIE4neig>
    <xmx:KdvVal44pO4LhWUbcJcUIah1lcaH_cVgcGR7dvQPLxE-w818BoVuww>
    <xmx:KdvVasuMNuFruMnCK91yMm2iSXCPuDPleim5TcG6LOEdQFhpKUJtQGE_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 19 Oct 2026 04:56:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1834edd5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 19 Oct 2026 08:56:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/7] odb: introduce object storage extension
Date: Mon, 19 Oct 2026 10:55:55 +0200
Message-Id: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrDsQjQTsVUoXHfPbTgtRMloE8
 e6Ndfkt3tvIkBVG12qjjK+ajqmgvlTUvx7pCdZYTI1rQu1cYGl5+hiPURjrjHQE7ENE6LxI13o
 q6ZQx6Prf3u6nbZE3+vl40b7/AONsnFV4AAAA
X-Change-ID: 20261006-b4-pks-odb-extension-36de693bb943
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this patch series introduces the object storage extension. The extension
is of course similar in spirit and design to the ref storage extension:
it can be configured via "extensions.objectStorage", has the same syntax
with "<schema>[://<payload>]", and we have the same mechanisms to
configure it ("--object-storage-format=", GIT_OBJECT_STORAGE_FORMAT,
GIT_DEFAULT_OBJECT_STORAGE_FORMAT, "init.defaultObjetcStorageFormat").

For now, we only support the "files" object storage format, so not a lot
of stuff really changes. That being said, its optional payload allows
you to configure a different location for the ".git/objects" directory.
So if you specify "extensions.objectStorage=files://objs", objects would
be stored in ".git/objs" instead.

The series is built on top of c51408889c (The 6th batch, 2026-10-16)
with the following dependencies merged into it:

  - ps/odb-files-alternates at 0ba59c8453 (odb/source: drop
    `read_alternates` callback, 2026-10-08) merged into it.

  - ps/setup-enforce-repo-passed-to-create-repository-has-no-state
    (phew, what a mouthful) at 0ba59c8453 (odb/source: drop
    `read_alternates` callback, 2026-10-08).

Note that these two series conflict with one another. The conflict can
easily be resolved by just deleting the whole conflicting sections.

Thanks!

Patrick

---
Patrick Steinhardt (7):
      loose: drop unused `repo_write_loose_object_map()`
      setup: introduce object storage extension
      setup: allow overriding object storage format via environment
      builtin: expose the object storage format
      builtin/init: introduce handling of object storage format
      builtin/clone: introduce "--object-storage-format="
      builtin/submodule: propagate "--object-storage-format="

 Documentation/config/extensions.adoc       |  23 +++
 Documentation/config/init.adoc             |   5 +
 Documentation/git-clone.adoc               |  11 ++
 Documentation/git-init.adoc                |  10 +-
 Documentation/git-repo.adoc                |   6 +
 Documentation/git-rev-parse.adoc           |   5 +
 Documentation/git-submodule.adoc           |  10 +-
 Documentation/git.adoc                     |  10 ++
 Documentation/object-storage-format.adoc   |   6 +
 builtin/clone.c                            |  58 +++++++-
 builtin/init-db.c                          |   7 +-
 builtin/repo.c                             |  10 ++
 builtin/rev-parse.c                        |   7 +
 builtin/submodule--helper.c                |  28 ++++
 environment.h                              |   1 +
 git-submodule.sh                           |  18 +++
 loose.c                                    |  46 ------
 loose.h                                    |   1 -
 odb.c                                      |   2 +-
 odb/source-files.c                         |   7 +
 odb/source-files.h                         |   1 +
 odb/source.c                               |  48 ++++++-
 odb/source.h                               |  12 +-
 repository.c                               |   8 ++
 repository.h                               |   8 ++
 setup.c                                    | 116 ++++++++++++++-
 setup.h                                    |   2 +
 t/meson.build                              |   1 +
 t/t0001-init.sh                            | 221 +++++++++++++++++++++++++++++
 t/t1900-repo-info.sh                       |   3 +
 t/t5601-clone.sh                           |  68 +++++++++
 t/t7427-submodule-object-storage-format.sh |  91 ++++++++++++
 32 files changed, 788 insertions(+), 62 deletions(-)


---
base-commit: 0d31382da9336683214372ba328fe9ecbc8bcb9a
change-id: 20261006-b4-pks-odb-extension-36de693bb943

