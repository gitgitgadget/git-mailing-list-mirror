Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014BB37160
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299768; cv=none; b=tVX7tokrgAVSz0QUz/gOeSdXcUnW9YcCFaZYJG8ujXs2GmlUCc/G7vfmcS0lquXD1xqUgz92EO/t5mrNc+ELxzmuuLcxEhP7WXkQDFjx09+CY1IMH4ju9cR9SslpuuXEmBr187PDZI3u055+f+u7aP3pjZEpSbC/l3TzilAo38k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299768; c=relaxed/simple;
	bh=C/i3ld3UjQ0pxf/+ak+a6VC6Z27Ld+NT50WdkpaMexE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Wq7f8AuJQBtHxSYwF9l0TciaHFLyvGRxW1zpYvj4IzVeqshZ1zeCmrz8nYCdIvOQZCdW+3PunLPsM2S/3k/fwJz5eJ/kYPeiT4mXRoyRm7XVW6FXDRTMSZszg710Epu7h2jOu64LHGrwyoJzsxHMMkk1xp2miSB5tu0jsAxSNss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bIR2L3ry; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OC0EIwWe; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bIR2L3ry";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OC0EIwWe"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1CEE514001FC
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 24 Oct 2025 05:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1761299766; x=1761386166; bh=UfkF8W2hOm
	8T+jrlf7CFoKo8pWKl9P/6tkLc6dl9iv4=; b=bIR2L3ryXZs5oCOjZGniN/aBya
	aKm4+qDg4PX5lcSSC3NpLn2Yy48u6PkhYEea+/MUKpSKERhxDpOhuHvF7vAx2iMv
	4husg8cqAfGucEiit8Oe+uu5kOKtAKJok/9/LN0n8c+mIHf7wA1qBQ2MKS2dL9+2
	V2NXNNkYRpDDH+i/1OyYZK7FG2mcNMK16oGfwVM+3Oz+ofyMQuEfhdc7d5SXCtPa
	U4LIal0uhWbEm3fhTq3D64GPi34lXxp1JFabXPilth1dPL6I8nrrtls0WeijieZu
	q79/tupLZwRj2KPu9Kf3+rov0j3obwxe/haTTtBItAVmRLqcX8kEshoa0eUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1761299766; x=1761386166; bh=UfkF8W2hOm8T+jrlf7CFoKo8pWKl
	9P/6tkLc6dl9iv4=; b=OC0EIwWe6MhtDOwreCmswW028yvdJ4LTfLUyzQDCTqbe
	by+lObmpC4znLOeieUouhWDfbqkzMr8A0gVdufDDi6rHWB4l+jFoLxE6yv53UK0Z
	0Idvw28XJVHWfvpZxdao4Q+lsd4mfaOLbz1u7TZDqb/2kdOjicWG7T9CR9Wy/Dsr
	Fh8he1uSG1ZHc17kW3/GoJQBRAH5Me/36MHC6Epfyd5RJA3HB6GHrGT6X7YiDAiB
	hhRBiKjlYYZACRwpaVRxOl5Y1+Hq01GcVghu004gG6O4LLCNPN2UHqAAV+uwZU3B
	7pc4fn7GlDDjLGcWxBDWzkYyUh5XJcxLNSnERs6fSw==
X-ME-Sender: <xms:NU37aIW0BlMGxJ4kkPZK_sTHmMdOO7ndghjxAHXgUG-6ny74Y0LK6Q>
    <xme:NU37aDhvRsdpX93M7uly4apvmP3Le5MLYe4i9c_7K5m_ILbSIlhYSnkbyxwc5IPYe
    Ty2LoKa15HRYyLm5bjNSZobLBM92oNDKtyY_Vb8c_zgCLFyypSCTZ8>
X-ME-Received: <xmr:NU37aCAWrLRP3gqjCKRnha5jcKw2IzI-W_c7GWL90-gTpDj4do7Q1WuE4_AB8yWWJhva9-IeearMqre8hjh4yCkKaJkCv3Lna7KQsOgCmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevhe
    euhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:NU37aMesGxe0_-RTxOxy37nDNlEEdii6INAmmHRxB7uuuIgt5i3ciA>
    <xmx:NU37aCdQnC6WKlm_Lduf_5VwICwf0xzYYvd7IWiBMfid1eqo1nCQ1g>
    <xmx:NU37aIgXMMBM6WmjZlOUjZ4Etk-CabpBKZ-sy2jNPOFiH78cJrItkg>
    <xmx:NU37aGQ-_bmbAeQLh3pghGlVTFQQpNGcYe5cN2WkyITANt1EC4N3vQ>
    <xmx:Nk37aPm7gGHccCPfQuGn2EWZh-sks9SAm6kKFekbjHKmpa5wvSJ1RDeU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 553c7965 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Oct 2025 09:56:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/13] Carve out loose object source
Date: Fri, 24 Oct 2025 11:55:59 +0200
Message-Id: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC9N+2gC/x3MTQqEMAxA4atI1hNI/KHgVYZZ2DZqqLTSwDAg3
 n2Ky2/x3gUmVcVg7i6o8lXTkhv41UHYl7wJamyGnvqJiR36Ec9kWKLHoxQT9EtIkiN6FqIhjMz
 koOVnlVV/z/r9ue8/GvHjfWoAAAA=
X-Change-ID: 20251017-b4-pks-odb-loose-backend-b1e003c41107
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Hi,

this patch series carves out loose object sources. The idea is to store
all data that relates to loose objects in a single structure, similar to
our `struct packfile_store`.

The series is structured as follows:

  - Patches 1 to 4 perform some cleanups in the vicinity of object
    databases.

  - Patches 5 to 8 create a new `struct odb_loose_source` and move all
    state that is specific to loose objects into it.

  - Patches 9 to 13 then adjust functions to work on top of that new
    structure.

The motivation here is to make handling of loose objects completely
self-contained as a step towards pluggable object databases.

Thanks!

Patrick

---
Patrick Steinhardt (13):
      odb: fix subtle logic to check whether an alternate is usable
      odb: introduce `odb_source_new()`
      odb: adjust naming to free object sources
      object-file: move `fetch_if_missing`
      object-file: introduce `struct odb_loose_source`
      object-file: move loose object cache into loose source
      object-file: hide internals when we need to reprepare loose sources
      object-file: move loose object map into loose source
      object-file: read objects via the loose object source
      object-file: rename `has_loose_object()`
      object-file: refactor freshening of objects
      object-file: rename `write_object_file()`
      object-file: refactor writing objects via a stream

 builtin/pack-objects.c   |   4 +-
 builtin/unpack-objects.c |   7 +-
 loose.c                  |  19 ++---
 object-file.c            | 175 +++++++++++++++++++++--------------------------
 object-file.h            |  98 ++++++++++++++------------
 object-name.c            |   2 +-
 odb.c                    | 104 +++++++++++++++++++---------
 odb.h                    |  41 +++++++----
 packfile.c               |  16 +++++
 packfile.h               |   3 +
 repository.c             |  14 ++--
 streaming.c              |  11 ++-
 12 files changed, 287 insertions(+), 207 deletions(-)


---
base-commit: c54a18ef67e59cdbcd77d6294916d42c98c62d1d
change-id: 20251017-b4-pks-odb-loose-backend-b1e003c41107

