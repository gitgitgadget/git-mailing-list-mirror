Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E027819
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 03:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740714447; cv=none; b=R8UXVu1V6D98b0jQMGya4F7T6nN3OnJBGolxqMNc1pNGE6CtA9Zuq875f7yZomklHhNG5fYT9hkciZGP9COyNvrFJ6n/bAdxngTD+BC09IrRtCDXKDzUDTrjxsxdd/RGnMysSIJcfr/0JlmCy2AOOKS1DKP+sIgjQRGccjj7v9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740714447; c=relaxed/simple;
	bh=u5x9+i0XJZAjAO4uVXOooSssJcmRmil2DE/zYe1ynCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SupzOLdzUCCLg3xSLfTSREgOe2iTXfGtGtNQlfpQjp8GLTHe3P6iM4ZCXZthn76nbkn+ZEBjpcPcZtmVGXZzlH1+JcM3mWnLFFqkWNvpo33S3kQWN1+qf1fGRiQOpSu6rEDIypa9WNoJV1m/mfb7RnxWmMdLUm6dcyF0QmWNyoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ftcE1eMq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XUyNmsyu; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ftcE1eMq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XUyNmsyu"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9A7FB2540102;
	Thu, 27 Feb 2025 22:47:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 27 Feb 2025 22:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1740714444; x=1740800844; bh=An/sXr2KOGlraBNmXNyNh
	q/+rPMgpyiuU9zy1BOt0RA=; b=ftcE1eMqyiSgKvw8bv+vBmE6nhTfdZHtbfmQI
	zRh4PM2Y6isBo652zD5FTCbpw0h+xMhv7rlyAE+ykaFOwtSG3wnjBMjo5JQnqGMC
	lU/EHR8TxYnHS7urr/jXHi59EyabZwfOwN1CkB3I6E0zQxON9YSakHTQVCMqSQsE
	42btFwOs8GFaoBFqPiHkGdq2BrWxYQfhdg/0V8tRtXwNqd/XezWYNA8mploKNbP3
	1SlPG+Xq0YtY1VlAMOYI5qieGPVzG9V8+XRwHXZDGm1ToYkIusBuQRsEv/ESrjDZ
	/5kI/haeFhEkqvI29iVecC5/KD39P1sm/NqVF33CXjLuYU+Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740714444; x=1740800844; bh=An/sXr2KOGlraBNmXNyNhq/+rPMgpyiuU9z
	y1BOt0RA=; b=XUyNmsyuHm+Rq37Z80TmbumaUoZUOrX0THDrAqRATQ8fA1ZRcp0
	yAO4WLMrfHdAhT3dEU3Q0Ef3G7lO6ccnVfJiy4LXISi10TjmuRDK7CrcjWjm+mRa
	6kl0NLdVH2SZfCJvRXg3q4QdXuiaxlfmdfuMH9hrZf2wZQY4sqxDMFOn4afg3YNh
	NA47cGSOQTL21HKUKCN/vOU/kJ80uJd9Q4NudTqAjaN9cjM9N9xeQ8Iv9cefEmsK
	OdhELvd7uIQRPenI/9XHBW9AWVP5Hfb5DBw3UXSHl9aoJbtzll6qjrHd5DoumnIt
	idaeXJ8UxmfX5jTwnPlhM1i6+7/li1He4Uw==
X-ME-Sender: <xms:zDHBZ6R1kkct54cmbHZsdgm6XAt0MML7s_TYXJadHrinQ38P6mqIFg>
    <xme:zDHBZ_yKMwKIPCNJAj3uwKuBdLZgUaDpk1nP4wqOqNC8cy5vJnmIqzlMSpW_WjnJn
    pPxwaRbmVtrJzBqfw>
X-ME-Received: <xmr:zDHBZ33tgN56vlY2vsv4IogiBXAr_s-LdqnoPUlbtBiWLfNm-YydSu8kkaL_uYc0e4phuh5_Tk2zdA42fQpHzsUNDeo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekleefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpefvohguugcukghulhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtohhmqe
    enucggtffrrghtthgvrhhnpeefgfehkeelkefhtddtfeetkeefudfggeefgeetheefkeek
    udeitefhleetkeefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsrghnuggrlhhssegt
    rhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:zDHBZ2DYYiwd-71ULRvRmLQdk0iaPJCOD6sx2A6ltuhW9Vo17R1LXw>
    <xmx:zDHBZzglQKkOdFMag88FRwC7fDPPC7EKQMjyIcRqHrWtP0j6rln9zQ>
    <xmx:zDHBZyrFRhLFRlOoP6xuq2QICKEkmf03IFDLqATjscSyp6LeT22jgQ>
    <xmx:zDHBZ2hAm_5ONIOBF8qoFT0tEvPhW_VzQM7h_pPjle__SdBngUiC3w>
    <xmx:zDHBZwvmTsrZrLDVab5goRluDIomx1qsUgOYRMJmSykAZ98oZDTUbny2>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 22:47:23 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/3] doc: txt -> adoc fixes
Date: Thu, 27 Feb 2025 22:47:03 -0500
Message-ID: <20250228034713.203461-1-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I noticed broken links in the howto-index.html output of v2.49.0-rc0.
This is due to the recent txt -> adoc renaming.  I chose to replace the
numerous occurences of "txt" with "adoc" in howto-index.sh for consistency
within the script.  It could be argued that only the few instances which
glob '*.txt' should be changed, of course.

I also renamed the git-*.txt files in contrib/contacts and contrib/subtree
while I was here.  The only other file in contrib which might warrant that
treatment is contrib/mw-to-git/git-remote-mediawiki.txt.  I skipped it as
I am not sure whether it is actively maintained anymore.  If we want to
rename it to be consistent, that's easy enough.

Todd Zullinger (3):
  doc: update howto-index.sh for .adoc extensions
  contrib/contacts: rename .txt to .adoc
  contrib/subtree: rename .txt to .adoc

 Documentation/howto/howto-index.sh                 | 14 +++++++-------
 contrib/contacts/Makefile                          |  2 +-
 .../{git-contacts.txt => git-contacts.adoc}        |  0
 contrib/subtree/Makefile                           |  2 +-
 .../subtree/{git-subtree.txt => git-subtree.adoc}  |  0
 5 files changed, 9 insertions(+), 9 deletions(-)
 rename contrib/contacts/{git-contacts.txt => git-contacts.adoc} (100%)
 rename contrib/subtree/{git-subtree.txt => git-subtree.adoc} (100%)

-- 
2.49.0.rc0

