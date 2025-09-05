Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ACE2AD2F
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 06:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757053092; cv=none; b=HzeGuOeineBox/8vAxhv+gAIYBr7XkFDEVz135AU+cH0UProW4HRR4AAq0xbHG2ELnkOg+zylz8KEmGLQKn6cDi8ZdvNdVpbUdAu4jwlgLR3HadB7MjwtzxNNcAJjX4CgTofteCFA2ktFMwKVlQbU+Ek0RDthgRVvy7AIb73uI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757053092; c=relaxed/simple;
	bh=ifnVw3dA4MiIiuj3sHHAumKn84HGGoC7gobLIg6+Gpk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Npx5M62PPRni0rqUX+qNuf3/tPbM+PPUCHjAzmBZbesmomp6YK3LzoJFC99Vwr2XW/5+Ije+1a2hM8ZurwEBPd/ycr6ejn5fM6lzRTfp07rSDFHw9Zz4KglH2tHWZ5kaFaFXzB6nI7Uyithm1ggsQvtaHL/VDJnobXDgMcfxrIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C6egMHoP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UWxMa0Se; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C6egMHoP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UWxMa0Se"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id DF9DE1D0042B;
	Fri,  5 Sep 2025 02:18:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 05 Sep 2025 02:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757053088;
	 x=1757139488; bh=RpQ92JJeP+fvImxnhHJyXwBiGgiDYuEUugKXSxHlfYc=; b=
	C6egMHoPJpw11NO42bQeMV+xkAwV7Wvagp7RY9A3aIvTfA31zuwMklSwQOrVBSDr
	ddJw5DEhn6zUf3cOW7IkIQ6l5w4Dln/X/cjTTQD5qO/Z1EiJsTggegpbYiwaqWrF
	78aCXFXLX9oYqjry8e4c2BdUOXjeE71Dwx1ZeKqthI0AZAw0SmiSr+3EB4+9Tg9y
	93JUw9J1o2z4ghsu/9e4xucMoNctszYm8/9NyDNUIi8Olf1Sq08Zm25paoZYpWWM
	5vCZCS7XVALc5C8g6nFy0hGJE3psh4JHp4ANRaWNnG38pqR3Yga1Prxghf6GitvL
	9gw9efz49ImPVTfArOwp7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757053088; x=
	1757139488; bh=RpQ92JJeP+fvImxnhHJyXwBiGgiDYuEUugKXSxHlfYc=; b=U
	WxMa0SeWfJbwDHsKapwRxnytTGFbt6K5IPEGOMmd79hfhEV8nsLcg9CKHxRRW92e
	WCOLfLyTchohVQco4dfnzbGSDe+mqAtIy9ansy3NmWlA2jqbyccDA8/l4XubRR/j
	WDZax2KzLFfNFsZ3kHcHoDmDYfM15XktDFDNblRF5ignCDYP+yBsrFogtzKgA94s
	GTNNcDoP0QefhgsrLfCawZqE4iuekdK208MxxX4twhst3WzcuPvHRVxyuiU2K1Na
	HNXzbB3e+42tnp5pAvbnAb7F0mxLNbqHfchdbRt6hSqFX8/G1ZkPm/VmyG4Vz0YG
	zHliKb0b+lWB3Xq6KsyMw==
X-ME-Sender: <xms:oIC6aGlb0n-aNOdKC_dp1Pg3kJ4VoV0ol9xbHGLVtfdXGwWUQL090A>
    <xme:oIC6aIZPZysUx8IyREC78RK-qVm7AyueXrg0gWzQK1CS64e72Pnr1xYKP9Xf9Rw7C
    J7k_TXiPhjqk_-Atw>
X-ME-Received: <xmr:oIC6aBNOF6k5arElU5Pjiggu1YJKLQ8oECNqumQ4koniNQYdL22PPm62sdBpHZH-v9PR81okF0Q-gff-4fugNKWyY5e-KZdJkk2cuT5sKWMx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepteeuueehhffhiedtueehtddtieekfedtudehtd
    ehfefhgeffveeggedthfehuedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:oIC6aNaF1g8Z3uQQsZahsa-13ATwzDCL67y8KdqXLfT9I9XoTVxEmg>
    <xmx:oIC6aP2Nc75MaRrGhh1cF8yyTymaoqsdByZRFH5Q0sD_fz2uFJFZMQ>
    <xmx:oIC6aDfW67ssDtzAP9dEMpg319HcMOVzhij6j4X1dUWX5cpVvDyLjA>
    <xmx:oIC6aAGGwC1n5tEbV-gASt_81aH-sh8V0FvFmk5syDGLA0vkiJGQgw>
    <xmx:oIC6aJ2xWkTJa9r6O99BhSdbc_Cxarv5rs87_B3mUceo8k8KJyCuA3Hr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 02:18:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57a9b8dc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 06:18:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/2] upload-pack: don't ACK non-commits repeatedly
Date: Fri, 05 Sep 2025 08:18:00 +0200
Message-Id: <20250905-b4-pks-upload-pack-repeated-non-commit-acks-v2-0-d2e67f3cb94c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJiAumgC/52NQQ6CMBBFr2Jm7ZgWqgmuvIdhUTqDTJC2aZFoC
 He3cgSX7yX/vxUyJ+EM18MKiRfJEnyB6ngAN1j/YBQqDJWqzqpRNXYG45jxFZ/BEkbrRkwc2c5
 M6INHF6ZJZiw+o2m6+lKzJsUaymNM3Mt7r93bwoPkOaTPHl/0z/7XWTQqNKx0Y3tDRO5WpieZo
 N227QupMcMh4wAAAA==
X-Change-ID: 20250903-b4-pks-upload-pack-repeated-non-commit-acks-49b363e1d0e1
In-Reply-To: <20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-0-4e019af4dddc@pks.im>
References: <20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-0-4e019af4dddc@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this patch series addresses an issue with storing duplicate object IDs
sent by the client in git-upload-pack(1). If the client sends repeated
"have" lines for an object ID that doesn't refer to a commit, then we
end up storing that object ID repeatedly in the `have_obj` array. This
leads to sending out repeated "ACK"s for the same object.

The series applies on top of "maint" at c44beea485 (Git 2.51,
2025-08-17).

Changes in v2:
  - Change ordering so that we always mark parents of already-seen
    commits as `THEY_HAVE`. The first version was _probably_ fine, but
    I don't feel too comfortable with a "probably".
  - Link to v1: https://lore.kernel.org/r/20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-0-4e019af4dddc@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (2):
      t5530: modernize tests
      upload-pack: don't ACK non-commits repeatedly in protocol v2

 t/t5530-upload-pack-error.sh | 68 +++++++++++++++++++++++++++-----------------
 upload-pack.c                | 19 ++++++-------
 2 files changed, 51 insertions(+), 36 deletions(-)

Range-diff versus v1:

1:  a42d231813 = 1:  26ecbcf460 t5530: modernize tests
2:  1544160961 ! 2:  11e32bf5e6 upload-pack: don't ACK non-commits repeatedly in protocol v2
    @@ upload-pack.c: static void create_pack_file(struct upload_pack_data *pack_data,
      
      	if (!o)
      		die("oops (%s)", oid_to_hex(oid));
    -+
    -+	if (o->flags & THEY_HAVE)
    -+		return 0;
    -+	o->flags |= THEY_HAVE;
     +
      	if (o->type == OBJ_COMMIT) {
      		struct commit_list *parents;
    @@ upload-pack.c: static int do_got_oid(struct upload_pack_data *data, const struct
     -	}
     -	return 0;
     +
    ++	if (o->flags & THEY_HAVE)
    ++		return 0;
    ++	o->flags |= THEY_HAVE;
    ++
     +	add_object_array(o, NULL, &data->have_obj);
     +	return 1;
      }

---
base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
change-id: 20250903-b4-pks-upload-pack-repeated-non-commit-acks-49b363e1d0e1

