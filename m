Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598AC382F10
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670076; cv=none; b=rgLrr5SdCXfTNTmAgEbf9i30QH+lANFE4gpQ9bRuCm+s+bUxfCVGxXorEwoBhQGBDDJT9Ut/vv4TRIyvPOby+JSGkT43XQgL0AlmsuiKDFQRUqVs/rilnsHj6ogiOYjG+N96OqolhZLaWDTT8zui0oV0AyZV7zlumK6iAvs42uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670076; c=relaxed/simple;
	bh=btpJKUiFNlUXA1LKD9q90pol3SWi1ccsm86g6cgPVbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MvdzWbTKwEDmm3Ku3qnbv6FNfNaU5hzYkPZivVnXNFpdeokbtV869Wuz0Wkk7eD8JWIkyrBoNmEE39tkeV4zj+5ZaPYXOJnUiTV1ROxnP0+q1GsCOa2sKEKraxMQ1wCCmFkJX0rqqI30rn3tUZialfK35V9BljnAHotkrb1MJfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=0k0EiFdo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eHNiHHyQ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="0k0EiFdo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eHNiHHyQ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A0DE14000BB;
	Mon, 20 Apr 2026 03:27:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 20 Apr 2026 03:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776670074;
	 x=1776756474; bh=Qec/Dl8HiNegnp6O5X03Pa/AAEyuglTunFMmWaoK2V4=; b=
	0k0EiFdoDkvShoc95/AfLdh5jWO567t9R+fMjcJfAyeJi6wvHHLQ9zm7ZnN44d9k
	8dn8XGIdaEB3U9PGqpGLaL9HuA6Pu6MFqNYtJRmmNPMj1u4AF90huRjLlFwgYwfH
	JYKZGBqXafCN2UiXPmNic9tMxwZxVuDygeew7R/w0IJ6BqNpDAotHXrvqC7AigZ1
	YojytF3Pv9FuVa0HS4wlY3XMbLbBLlFdnwgTFislNJT06Ik2n3sb1t8PJUH0XP68
	6qsyQM4CyM7AkNyBaYkDiPQHZ5nzKGc6zzQj0+OxyZ+CpkcTdnedqaWEOHzIT26P
	ywWdQJ6pK1gJG0E9rr7GNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776670074; x=
	1776756474; bh=Qec/Dl8HiNegnp6O5X03Pa/AAEyuglTunFMmWaoK2V4=; b=e
	HNiHHyQqeTIYc0akCeEyOl14pIo3iaSiM4XQ1vT4Fbp2dDjclm7r7Mu5tJ94RAPV
	3olmPeRWMuO9QwFJMZbhfFLUl3u/X7df7z/mDg4LQzeDfpI4zeek+suHx2YD3Ppt
	cLDWmfZFzEWZF/N+INZqLIAsP/03+oNb6Ir6HTJpRMuBHolNYQHlLCTfIzPzn7T6
	F41EyF6eWqQ/v1AUsH//PhtvBNpkiq0RWh9YF22BbwFGi3cjTDNDlsflEEKxRfB2
	Zsz01GfFcvDH6qf00PbbLQDnafz/9P+WW01ir6Wa+7vmWbWAgBwxFhhCVelt6iZJ
	Eotf2tD/PgGzLCKxtrqzw==
X-ME-Sender: <xms:etXlaX0qwzDGhm89Nyh2Yb7cz2KioIWv0NRCtzf2wfJzICm2iJ24_Q>
    <xme:etXladElsA-LV_mMtDt9NzaOYZaCuH_JXY_G0YWhPpcnncl5_7lDLuHpd-qGlDDdj
    QoNm7MvWlb9bwxrJVHcGzsqA55CqbOgDVOj0JOGe3ebDyXtHmIusg>
X-ME-Received: <xmr:etXlac7tj3h0dbxdCYT-ZiISE5WVGw0GRyhaxV7VDc7gIoWlXc3VEXHl5pfS8EqTdI4VOIumqpTAquAv38wDh4MpYhSdDpptZtQ298Q8TAkh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvght
X-ME-Proxy: <xmx:etXlabti91tEvCYv49HA-7-ntyLYtQ4dZD00VjWyv3nlr9vQtwPZzA>
    <xmx:etXlaV5BrkYSYVbmrIdzIMYjUyCs2HtQPsNajMZED-SoeXGN4Z_y8A>
    <xmx:etXlaeWWKryKNGJi1KSEtWFN7cMytGLOnR4c-TS-sGd8T7CMds4W0g>
    <xmx:etXlaf8Qu5oXcSv9VnIhwrY9_6rWKuczPK3sJ069QdNSvs_y2zlz4A>
    <xmx:etXlaU3-nTm5m8gkBGsX6S0WuQ79niakZjXavH2xIHU1MEr7ACYgXWnJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 03:27:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ad62ec0b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 07:27:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 09:27:28 +0200
Subject: [PATCH v5 09/12] t1301: don't fail in case setfacl(1) doesn't
 exist or fails
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-b4-pks-tests-with-set-e-v5-9-7d3d68292f6b@pks.im>
References: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
In-Reply-To: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.1

In t1301 we're trying to remove any potentially-existing default ACLs
that might exist on the transh directory by executing setfacl(1).
According to 8ed0a740dd (t1301-shared-repo.sh: don't let a default ACL
interfere with the test, 2008-10-16), this is done because we play
around with permissions and umasks in this test suite.

The setfacl(1) binary may not exist on some systems though, even though
tests ultimately still pass. This doesn't matter currently, but will
cause the test to fail once we start running with `set -e`. Silence such
failures by ignoring failures here.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1301-shared-repo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 630a47af21..0e0d07a1a1 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -12,7 +12,7 @@ TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 # Remove a default ACL from the test dir if possible.
-setfacl -k . 2>/dev/null
+setfacl -k . 2>/dev/null || :
 
 # User must have read permissions to the repo -> failure on --shared=0400
 test_expect_success 'shared = 0400 (faulty permission u-w)' '

-- 
2.54.0.rc2.529.gd9106f7525.dirty

