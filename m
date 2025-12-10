Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD72302770
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380773; cv=none; b=jEA1+EfAVLhDIeSf1JQx3wiqMFxypN7YwJ0XBUQ48mSyaGxJJTCnu1hb87pRqXTCbWAadOGq+gbt8o2KpKoI36DoDqNh+gvHAyM26weRyDraaret50LRROa+SXTH6p2fIfE9Pd98pvIUWMD9nNLhQYNWQgMwJ3OcMuK/+WgDlf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380773; c=relaxed/simple;
	bh=Vb+xmGg8iR0WPtUUMNmkbKYOXI+uHsWjrGkRikCGf7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A8qQ+eah/22ou8mAF0BhOugDkxn/eB2Gs0sV6vh8A+z7QcoUDeAb6iyKymNdA5grj5CpMEql7z/mjfKsN59uU/aFxxyhjaxCoHAorXCe8ntrSphyX8fsSPaUOyrzF495Fqq9Zbr2bRv51a28NuHGMYImg9CHIr7LA0MiJ9ByJn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NGr2KOs0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bSbvkJrT; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NGr2KOs0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bSbvkJrT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E391EEC0595;
	Wed, 10 Dec 2025 10:32:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 10 Dec 2025 10:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765380770;
	 x=1765467170; bh=aAo0ngPpq4S+8jQ2+4E63AjHdEnXcLFklT9f38ln6Dg=; b=
	NGr2KOs0v1ytdFZOXbac4hvWEYxqXMeBPhA4mpGSG64R19rwNHlBOJ6ihuI5bFBj
	7KfsoA2QZ/bdCESG7UKlsMUhT1lsLijm5nXXcB0/zWArTJW059MsrGu9wdeIbU9W
	sVu9OCtfMfuNLjVDEngtXAkXifM2PDKuwiJ16rSo422xxCV7Y4LxgIGzovUQRJIJ
	KuHRGb5shQAJcc9KqQqu97FQm4k08GzfMpHDQKLG/5V5gu2XT2F0mNxwXv+7LJ3p
	fscd4QIbCEDz5TvxJqSsIi6pfPPhFgIWzIebxactLr7JYfrJOM8VAjUjH5XDWW+i
	vslF/ZWElAOVOLVC4Zng7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765380770; x=
	1765467170; bh=aAo0ngPpq4S+8jQ2+4E63AjHdEnXcLFklT9f38ln6Dg=; b=b
	SbvkJrT1glViFxzudbhzIQU4itJXid9sJAWIMXUNo1nx2L3LlVaoJUaSfbgo6DYM
	OHv/h05Js5RbjdyNQik3XbP+6tjALUlJFu4kred3dt6yO53VD7WRSz8v6T2bWLQT
	6/K7ZXM3mRE/IVtCYCaE8C3ZhUEXxxJxpSFY152VoIE1t6XiAAWVIHlMaCoj40+G
	rsU45s6nh+72hU17Hhe7f+MvdXgb+7UFqAT2mlMRGHYLlZ2ArqnzjPqOXqv+EWaV
	naVEoI19Z56Xip4v2AalLoC5W7EKXlO8YgO8a+aG0iKBz2n3w3iOIOD09kMQ0omd
	UWalHgif7LFFcoWcAAECQ==
X-ME-Sender: <xms:opI5afuijLJ5ZS_ciQKA30ZcIOxhewXnGAg_Y-x-70w-hETdrEcBRg>
    <xme:opI5aWeGRiKzI1ceG1POEFdeL5CL-6yjPzOY371mBz7FJ8tz5lXYsqJ8iNpphgak0
    3hcgHR9fN3RkSWNbJSVB7V2yryxs3j2-hpPXHacr5SZBRyg2zxt4Q>
X-ME-Received: <xmr:opI5aQa6BGIDHbt7FVkdjYrLY88VXtlTtgxnizs7slBul4-TXHmV6n4d6CRE5uJDJn6WocEIihYD_K3UjgFh3BQaBQ8MMLxb1B1a0adUw7W9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:opI5aZXhhtTsRHJlwTVdzOH2C1l5tNy0y6aH-baJ7WhcVdC1Vkmp9w>
    <xmx:opI5aShoPMEI_QF39w-cUyJopXmvqhcIVg4VYId7BfmjCVAJj-98_w>
    <xmx:opI5aXU0xN4g8Ho4_k-xDAeYBmEvfzfCSAnkumfdq3P38VFHAD5RVA>
    <xmx:opI5aZMmHM7K-hFd0YYZZw4qUmk-4efutEZuHgPflTjNXhT-KISoEw>
    <xmx:opI5aacVzBPKxNQFGUXY1iyajvPnt90_jSvNrVzeeAZrghC-12CJsxky>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 10:32:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 47082937 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 15:32:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Dec 2025 16:32:37 +0100
Subject: [PATCH v2 4/8] odb: adapt `odb_add_to_alternates_file()` to call
 `odb_add_source()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-b4-pks-odb-alternates-via-source-v2-4-eb336815f9ab@pks.im>
References: <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
In-Reply-To: <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

When calling `odb_add_to_alternates_file()` we know to add the newly
added source to the object database in case we have already loaded
alternates. This is done so that we can make its objects accessible
immediately without having to fully reload all alternates.

The way we do this though is to call `link_alt_odb_entries()`, which
adds _multiple_ sources to the object database source in case we have
newline-separated entries. This behaviour is not documented in the
function documentation of `odb_add_to_alternates_file()`, and all
callers only ever pass a single directory to it. It's thus entirely
surprising and a conceptual mismatch.

Fix this issue by directly calling `odb_add_source()` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/odb.c b/odb.c
index e314f86c3b..d97e50fb61 100644
--- a/odb.c
+++ b/odb.c
@@ -338,7 +338,7 @@ void odb_add_to_alternates_file(struct object_database *odb,
 		if (commit_lock_file(&lock))
 			die_errno(_("unable to move new alternates file into place"));
 		if (odb->loaded_alternates)
-			link_alt_odb_entries(odb, dir, '\n', NULL, 0);
+			odb_add_source(odb, dir, 0);
 	}
 	free(alts);
 }

-- 
2.52.0.270.g3f4935d65f.dirty

