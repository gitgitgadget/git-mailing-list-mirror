Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D852222DE
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463337; cv=none; b=G38bc4IyDcmQL3h1dE1EFDFkhahgTv+E63t4dTT8p5+qZfl2P7aQKLLDRTGBEL5v0Y/5CxgXR3NodlfRsINpqqmaByn6qgVl90HF9jco7/l8y4WAIlc9X3E1rkGLP6YdzbAgqAbI5jafjYRf+fkWa65bH3hyNDoMoiFeX6t5YtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463337; c=relaxed/simple;
	bh=kKgvJiD5iH1IYiP1JXsWCfXPuHkS/ptohqpHvpbx2tI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M8zAcUG1KIQqW+IXSetYJvy5ohrQJMcbfNUlyc7AFDydJD16gY8XFQD0Qc1o62pCcDtAseDP8f+jfCNsHEKlItRNNy/pDCfgKzFbAPiS0Yr0A5sFzkxhKThuzEE9HsKeWpYA8wpvHPmEtZEea/4JfSdupg20bcOc4ViN/8U9JoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YMgdx/HS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xzeVwd2n; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YMgdx/HS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xzeVwd2n"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6FBF22540170;
	Thu, 20 Mar 2025 05:35:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 20 Mar 2025 05:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742463335;
	 x=1742549735; bh=REpbEfss2O2yYYKccRFcgbK1nvTKhdXojvppgXjTFuc=; b=
	YMgdx/HSc9UVFzs22DlTH1VAEsrXwdinXJq8fyruc4hsWhDZnmqxtP5Umw7jV6ps
	k9vzwRHkG/SNYMxIO9HMKCRr0be/s4lDSpihc+j1sZL3pmkMdbmlRtYa/shE+oql
	1JXOPk5WSmOIPAUJZRHJpCpA8NZ+kf2lsH9nndS1TdCYk+F4bH2bUeZloKi8DXtt
	fATsy+sb7HHPext3OCAnv7b4l3JYkBhGdQ47rnnpMrmqECRM0unjhRRfBiUFHPHj
	Mbh4HeL88CiMINS1O6VIkdeIHuans2rL1oWqv+CTdPriZj3ZcDLhYAZMWcfpklo9
	39mKVD/vaso6lLjsLG2cUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742463335; x=
	1742549735; bh=REpbEfss2O2yYYKccRFcgbK1nvTKhdXojvppgXjTFuc=; b=x
	zeVwd2nr7Wh7v1gun5qF/BtVaScb9IffM1thv59rP61gM7QyN8V0tvXWwh6575q/
	FflpMzgySpdUBS8XiEAbvejcK5h5KXb2Q1OKKY29AE4oy49eXJTTRNqpE27FNreA
	Dkdf4pupJXnLjLk40TohTeDV2v+S9X3myJwFCAR1Lf9yeqSRHUpLkc41SQhMfKDT
	tJAeoTZp9OYaPM1I2LyEAqoN3DQz/59DnOgivBDvjtBGzJyDX0B+v1pFavDa2T84
	anSWIrOp/zK/hmkTm4WCyU3v+Php1YJaGOiMG8sF2XOv7PCaPdpJEVskUbFwvDH4
	b2oaPvjLvs01qKPeKlXuQ==
X-ME-Sender: <xms:Z-HbZ7LFLV2JQoNt6ZAEbg_1WAGzXAlcrI5kh5L8hkKs4jtVC5DbZQ>
    <xme:Z-HbZ_I0KbDCxDN3KJMq1G8lIdaIrazit_gcvJv2tEXmpysfMAdRnbgIgeDnPcK6I
    -B4ZLZWUDm-afOIxg>
X-ME-Received: <xmr:Z-HbZztPlakSazXL_ZCu2UnH_fUuHjsdHn_7hgJ7eY7hTSUyJubhCWo2FuCPa2Z0_YUqJo78C7glZevOryQQDw4kRs_PX7InwXCbc8jw5Kw653M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:Z-HbZ0YqCdN-dA6eUdV4F56vfVAbNndPN107frVTncvr7HA4X67uaw>
    <xmx:Z-HbZyaorf-G-F2RC8L9tnGvnOur4lMkvrSsfgI02lOr1oGC2ifhSQ>
    <xmx:Z-HbZ4BY8VlbS84yyUd0PA86xmpSuZiJcqAJTPo6OCnUbR-kwldZSw>
    <xmx:Z-HbZwZA4yl2gQRokTirmM7DNZwdOHdi6lDYcorOfZCu5Fwc3gMF2g>
    <xmx:Z-HbZxlUG3VxOoxGtDfD6hI0sgdCBuh7iV3s9zkcfnTMaCmSx0ZQp96a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:35:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d9dfd41c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:35:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Mar 2025 10:35:30 +0100
Subject: [PATCH 03/20] t: adapt character translation helpers to not use
 Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-b4-pks-t-perlless-v1-3-b1eefe27ac55@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

We have a couple of helper functions that translate characters, e.g.
from LF to NUL or NUL to 'Q' and vice versa. These helpers use Perl
scripts, but they can be trivially adapted to instead use tr(1).

Note that one specialty here is the handling of NUL characters in tr(1),
which historically wasn't implemented correctly on all platforms. But
quoting tr(1p):

    It was considered that automatically stripping NUL characters from
    the input was not correct functionality.  However, the removal of -n
    in a later proposal does not remove the requirement that tr
    correctly process NUL characters in its input stream.

So when tr(1) is implemented following the POSIX standard then it is
expected to handle the transliteration of NUL just fine.

Refactor the helpers accordingly, which allows a bunch of tests to pass
when Perl is not available.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib-functions.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 79377bc0fc2..377f08a1428 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -88,15 +88,15 @@ test_decode_color () {
 }
 
 lf_to_nul () {
-	perl -pe 'y/\012/\000/'
+	tr '\012' '\000'
 }
 
 nul_to_q () {
-	perl -pe 'y/\000/Q/'
+	tr '\000' 'Q'
 }
 
 q_to_nul () {
-	perl -pe 'y/Q/\000/'
+	tr 'Q' '\000'
 }
 
 q_to_cr () {

-- 
2.49.0.472.ge94155a9ec.dirty

