Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5784E191476
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162706; cv=none; b=GMIeKAcmh9YB2pRfICjZBQLFXAV7m5K7soMNPneXlLnRF++it9c7RnsbJhywJeQsIxt+sKeYpI6RxdBM9O5dF6dVveLcZpYimgfYzaKqfVEU2FIlxYLO/ArnKCC+m2UFazDuXAW6Fkn1INuFGYFC2smZSAm06WcsDFSqTz4PU4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162706; c=relaxed/simple;
	bh=JSmfvtR/Ct2tqfGDjOlz6UwxLrCiRpmHYB+uixyz8DU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sESPGXBM7/eDG7PnLxJIxHKAGfSQH4iCiqIUQ75v5S8iSq4a1za9RQ7MkeIvnscRFNuNzLD4yKAcWRngGXAoqNBDhsU3Rmq0Dlia7uG2OsUsTJ7GvFytY0Z7MK6WwDdn84MoKwwOkCRvsfgXJnzvflECg/g4imSqf9TeRYa+xy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ohc/uhH6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tkx7xXzR; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ohc/uhH6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tkx7xXzR"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6AABF138D263
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 20 Aug 2024 10:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162704; x=1724249104; bh=osC24z7dhB
	sS6tpvNcPKRxMjKSKUX0C6NSUaScxGReA=; b=Ohc/uhH6+2H90UvV38pk3sTd7n
	N3E6moXgWbAGxwU3aWbDibq9wvOvlMF+/SxMzaOBtoAF3uS6SZc+v1kgkfiWjPfU
	gkYkWJFyQm+5AWKkeTDidKjffB20HW9O8VU3p8UXPN8xnq2jY/zLY47iFFDIJE9H
	F62nHFcgPeIfvQ9ZlU9J6jL5n+rSVSqzS5a/K9n6Pmne8phMtjPyCcwb1INpd8Uf
	JbcWlLkIs2aJd5Fk4AdlRrKesNcOMMz4jdnfRhyUpDoTAHmMr7tU/eQo3LfJJOP8
	yKPZrQDgGDJR4Eg6zsYtcxXCb/K4X7fdHMkqGKeLUD/ZBMKuKmvddwKfs7gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162704; x=1724249104; bh=osC24z7dhBsS6tpvNcPKRxMjKSKU
	X0C6NSUaScxGReA=; b=Tkx7xXzRunMLk4lskhO4TDCehcCCNz2WjlvwYyYN3f0x
	1Yh6yCktUZ1nTYMkPA3tlaiplePeZXYAqz6olsc7wYe6HPKlUS5q3OdV7R8+jXiX
	pdpN3joi5S6JAZlIfxlWgy+zXW1KqXX6LwTfK/7FLzz1pFnauSdW6vAERW1yV2na
	kKDlLEBBbj49Wy57u1qnNe1i2P75Wllt9lJ0HkfpXbt1v/Ts34ku1mz1Esw1zF1g
	JlV19i7COYBGedgewf9pb4yg0rbTZWPHW7OPN4jT+iOWTRKRFoRD+0bPvP0W5TI9
	F0w1VpWuAWPBuehJHxnErSl2bjpl1OjA8bClTrckiQ==
X-ME-Sender: <xms:kKLEZmioY4Q5rnY_L0cnqsrJ3UaEm2J5hW-z8KJF4rT2zAV51U5LAw>
    <xme:kKLEZnBAkp-ZUrF21ytApS-lUTNM7h2iBclvWON_MIRorAu-ciS5KCFtkrS-Ftwaw
    hUGKrN3C4XUventGA>
X-ME-Received: <xmr:kKLEZuFnytVcGPWt_WKWFmZWQEJfTizYH9_QWhtwQaRC5h1Qg6qXjwCR128trh2oJQ_y8SNtf8t5h2H9snM2S47PeSE4BAvNQ8rRt281MuKhrWvkXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kKLEZvTM0QbYw-tH_VImTqjXbC7RS3IfR1hOkgqTojJ2XrsTUsaaaQ>
    <xmx:kKLEZjxAqyp84zurrK_1k_06Opko9QGnxT-DXtf-u51pxrK1TnONOQ>
    <xmx:kKLEZt7d1sbgyLXHVip41xk6Bc9x2rIdfcBHjW_rbG9AEfp6l8CCTg>
    <xmx:kKLEZgx9FzQNyFh4_bAAKpqsz3NP5u0p61A2YEW1NMWV4U0gXsrxOg>
    <xmx:kKLEZsoC8nUBUa2agBoRBZyMdZN2aeINaXZvf9ik-t645Xg2So2vtPrr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2ec8664d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:04:32 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:05:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/20] mailinfo: fix leaking header data
Message-ID: <69e30ea5179eff6472be54ebba64ebca3e562f32.1724159575.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159575.git.ps@pks.im>

We populate the `mailinfo` arrays `p_hdr_data` and `s_hdr_data` with
data parsed from the mail headers. These arrays may end up being only
partially populated with gaps in case some of the headers do not parse
properly. This causes memory leaks because `strbuf_list_free()` will
stop iterating once it hits the first `NULL` pointer in the backing
array.

Fix this by open-coding a variant of `strbuf_list_free()` that knows to
iterate through all headers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 mailinfo.c          | 17 +++++++++++++++--
 t/t5100-mailinfo.sh |  1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 94b9b0abf22..a4fa64994ac 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1290,8 +1290,21 @@ void clear_mailinfo(struct mailinfo *mi)
 	strbuf_release(&mi->inbody_header_accum);
 	free(mi->message_id);
 
-	strbuf_list_free(mi->p_hdr_data);
-	strbuf_list_free(mi->s_hdr_data);
+	for (size_t i = 0; header[i]; i++) {
+		if (!mi->p_hdr_data[i])
+			continue;
+		strbuf_release(mi->p_hdr_data[i]);
+		free(mi->p_hdr_data[i]);
+	}
+	free(mi->p_hdr_data);
+
+	for (size_t i = 0; header[i]; i++) {
+		if (!mi->s_hdr_data[i])
+			continue;
+		strbuf_release(mi->s_hdr_data[i]);
+		free(mi->s_hdr_data[i]);
+	}
+	free(mi->s_hdr_data);
 
 	while (mi->content < mi->content_top) {
 		free(*(mi->content_top));
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index c8d06554541..065156c1f39 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -5,6 +5,7 @@
 
 test_description='git mailinfo and git mailsplit test'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 DATA="$TEST_DIRECTORY/t5100"
-- 
2.46.0.164.g477ce5ccd6.dirty

