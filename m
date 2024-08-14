Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A1313AA27
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618323; cv=none; b=uNH3k7Vd710FRqWWgq2zIWFDffK3VAFQ0RgYDbf3/WLmrcnbCGCETh1wVUru/CnmF1aAE5u4Ow/6wxcn/gV+s4I8BWzaXDRzj8ABU58oIbTWnSuwHAODHDh29Kkv7XH8/el5nZfAoAuRRXkUc1dUdh203PXQuQ7ALPFRx6Nj/Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618323; c=relaxed/simple;
	bh=hoFFcWuv/vPMkUdi5Yo7jCwyC10IxIxjt9eqsrkZNsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jpl+xrFgT38cE9VAVbs9JClKv359RPyLmpZhn91EMYuNSAbWJHAHPT43dryBqlHmXQ85J84Nm8EIL92fvImo/cWOZ+s2sBLIY3Hye6l8BRmXny3CWOGpZ/FkdSK7bfwg19JHtwD2nP6epxCqFJOiYgdqqV6aC6KJCexiLLSca+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KFKsZJ05; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I73bxPts; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KFKsZJ05";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I73bxPts"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 07680138FC5C;
	Wed, 14 Aug 2024 02:52:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 14 Aug 2024 02:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618321; x=1723704721; bh=zF6cR7mg03
	Nqj6lX7Glae3/XyFq1o41rAfNOBYrNcFA=; b=KFKsZJ05Ch/9CsBZo0dOAXIjN9
	XEbWsKEirundCQwTPwDxiKDKT2Fgjv9M3ASo/DQEL3CZ26B20ZHOTENGfSHBAe/g
	RdvG3gChvSNgMGORTWc6fcVRR3AgmVJGP9/q5DjI+foobmx+2iDaYjJwAbM0eSp0
	pzHg02xLguOhD308I5YOJFOB6e4w9I+Gaw88l95oP3Ii0snRYdZbZB1rkylYYL56
	9+9Hr7pPQ7o6XffNVENireJ4iqd+599KHg4Jk3es5+tuR9Sd2/AuKhRVRtlXb8Yi
	OIAUAw0WqRIOftRdON2sDiY4lY+LVEIOHLVq67k/CSRlCQeeXyvQ4eZklazQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618321; x=1723704721; bh=zF6cR7mg03Nqj6lX7Glae3/XyFq1
	o41rAfNOBYrNcFA=; b=I73bxPtstwMDgfqwcADgk+LCYNsn5oz5BprtZAg80smQ
	s/bSqA53ZN2MfzuUohXoUl21mJoDN6wjpSgf0x2nuBDkYd/reT6e09RStWxfhAON
	7mlbkSwKEa/gIca+sp+2vggQZ6BxRCCltfjoGWXCQ7mde7zXkgy5OzxS0dsWc6S7
	msFKRe4NplLMwfNjT/ll3UjPxNTshsubAumsWM9qV4H/TYHFBIjb2VG63V1X3cO0
	Bbt8Wj6ye910kzH7CG+5PXOj2beNTLqKTim1rtkZMZa2h8hA2m+TuOgEPxfDM3/Y
	rSarHjDXWbgSFnaBxE0ctUvGM1pHPr7xQTI4RuNPpw==
X-ME-Sender: <xms:EFS8ZvM71wRHAd3SOv4C2OFtJ6JmsQWi3AIFyR-eZ-POwZ952BlOwQ>
    <xme:EFS8Zp_0erW6mPjZhejiSFNNMfXN5nTz0XgqW9rBU0yX4CMc8GT3oVQL_P8vnuE6i
    5rvNnXt1wr3xgsxHQ>
X-ME-Received: <xmr:EFS8ZuRZFRmSSD0dOBFDRUCLpIgwzG4cNcSCDbh917mA930F14hq3AXUfz3qJbnF2uVrGRkSOY4i_I6vXnkq4w_jDOX4WP-PoJgGu_OOWxJoMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrmhgvshesjh
    grmhgvshhlihhurdhiohdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:EFS8ZjuK7bfaoxc8ZALLXT5o7SXzu047Szr2kFAAcYvtJU95avlHOQ>
    <xmx:EFS8Zneh_I5RohG-wwu08Mc8MWq1xQRv4YmytTOjt52PedfGkKEVHg>
    <xmx:EFS8Zv1FPGfSakoGSZCPDlhzobE6Vnq8lR8GOZ6fC3rc8lw1Wl3JBQ>
    <xmx:EFS8Zj-sZHlpJgljfCDAxTK-ILwDm5zMhKSchxhspV8DRaMwcDgEtQ>
    <xmx:EVS8ZvSDp96BdACSBSh7psx2WmxDpq8lMfXAbmvJYkAfLUi-yt7P6DWX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:51:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5330a6c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:51:41 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:51:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 03/22] object-file: fix memory leak when reading corrupted
 headers
Message-ID: <0415ac986dc8c04917502a1bb0b03afcca47ec67.1723614263.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723614263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723614263.git.ps@pks.im>

When reading corrupt object headers in `read_loose_object()`, we bail
out immediately. This causes a memory leak though because we would have
already initialized the zstream in `unpack_loose_header()`, and it is
the callers responsibility to finish the zstream even on error. While
this feels weird, other callsites do it correctly already.

Fix this leak by ending the zstream even on errors. We may want to
revisit this interface in the future such that the callee handles this
for us already when there was an error.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c   | 1 +
 t/t1450-fsck.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/object-file.c b/object-file.c
index 065103be3e..7c65c435cd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2954,6 +2954,7 @@ int read_loose_object(const char *path,
 	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
 				NULL) != ULHR_OK) {
 		error(_("unable to unpack header of %s"), path);
+		git_inflate_end(&stream);
 		goto out;
 	}
 
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 8a456b1142..280cbf3e03 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -6,6 +6,7 @@ test_description='git fsck random collection of tests
 * (main) A
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-- 
2.46.0.46.g406f326d27.dirty

