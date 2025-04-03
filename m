Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9661719E83C
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 05:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656768; cv=none; b=JqJOoffkJPfQDZRc55EXlXHgOp/C2LOqfxlxlxYurgtFX+1BcYx9upIr04rL+nhBWAUXrWD+21lOl89fHpisPYCx6uYBcfbyvUBhvjxPG3wGXiz1fRXyjcYCpIu+oT10yN8ZhS/COhsLgn89F6w362lWJeK4arriJYdnIICAzOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656768; c=relaxed/simple;
	bh=oczR3tK3WL0kD8rSlM5sbfVwsHZN72mliVn4vs7I4Q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1tjRkFlakExMkRpmlU0BbrHUxW0fuRyTXxyUjp41qq2kEcW6dVRjG9cX7FelEeNQDZ5HcB3MLdtyuanxlPfhPedoQDVo8T3uAyV4V5CYQs6CtlNYzOTEKh/qYDt0oANZqPPOqNaac7A3NMjsEZiETS8am6iWHFIlzULPdjtu0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W3fQ/9Om; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z+gDT3HD; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W3fQ/9Om";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z+gDT3HD"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 9868E11401A5;
	Thu,  3 Apr 2025 01:06:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 03 Apr 2025 01:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743656765;
	 x=1743743165; bh=r3UIbSZeb/C6rSRm1C8D9UXIKxzV8B8tNAes9pQ8he8=; b=
	W3fQ/9Om0N2xZmSaYhXCmbzYlndoDj23CTCoRDkNRk9usafjcOmQRL2lbR+y9WAo
	iJ/x96zH9r1BFxo8w6881N3G3+j4tVHAVm8M2LZHHFw8JCrmQSliu2gg/mMiopp5
	kFDCmlffKYn7KtJLb5cQhtU5Ap4afUvUJTWmBbyDloPw7W6y/5nzR52mNjzCtEZr
	AathP9gMIHIFlNEhKufA9T95nk0e3f+55g1e6Y9Kqwbn+VsRrcIw94Yi7TST0maV
	hAz8O3rswvHRQ7aTrL98leicBhmfJ9nZuQoTj7CZYg8JlpuVmNyiH/Iyl9FQpGxb
	Mc5QphWgKxdC9XiiDl+DWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743656765; x=
	1743743165; bh=r3UIbSZeb/C6rSRm1C8D9UXIKxzV8B8tNAes9pQ8he8=; b=Z
	+gDT3HDhszmYhYxmKCrGLIkp0FwWZ+G1Z6fG8JxnFUjJudN/tuVqoefaBU99PKwH
	VpTCfSmbyvFmix1OqcS2g8s0EW1AjiKNFe4Supd6+yECDxRnhi4XFrU5VlniZbWW
	oke+w8PXHhSEAF+5ayyb52Ao0I/8PRUEMxkiZU2hJQX+GMJnGdiVDcEHA/6L3rJq
	QuV7R41p1NRIwf+x7PuJ2LQ2jYfZ9IWXcz2ZZV0IvuuOUI2L9H2kze3Me3HobaCp
	tB3KNPGnnXkyqgF8fVRg2e7nXerXSUQHRUkwcAs5+Fancjy6NCbwenS+pkmZZlQx
	M7FjfBjb54Lect7L1R9fQ==
X-ME-Sender: <xms:PRfuZ9TGwhxf5vK2IQW11F3pcxi50Wmj4m6haEDXsaURbTW5upONOQ>
    <xme:PRfuZ2w896hmNOH6ZV91Tm-r00KlFONn6Jroswj_xW4pciaUIXEpEBdf-uSuql5cr
    BYV7dOlqELKn48GOQ>
X-ME-Received: <xmr:PRfuZy0afmR9KNscvpym9YJjFCAm90ZuBkH1C83_8upunhheICHLNOYjYdMcjYVTtzdydGdZ9nffDe1ZRvouoVXrgHpPqE9N5vtOzOnOEajvxGU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:PRfuZ1D_lIF697F56vuUdtUQQQ34L0K1k06rJYAATCGxQuYJPctzMA>
    <xmx:PRfuZ2hZ1gP5O3znfOqmnt2K0OCfgvom3xfwkh1cg5akWQtNMP4SEg>
    <xmx:PRfuZ5odXlMmcLOc0ckYlb_0R-4b26qPop6iQwMXe-byyEwI3AEjXA>
    <xmx:PRfuZxiIQFa2NY12_4KOtw_F1Wf86dvcpXrTEziOOOgygqQIpN6u9A>
    <xmx:PRfuZwluuQAVobXgoFMJSG6c856c4DHTjprhx_wfS4_1yG9zf-GPYtMy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 01:06:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d2da7247 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 05:05:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Apr 2025 07:05:56 +0200
Subject: [PATCH v4 05/20] t: adapt `test_readlink()` to not use Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-pks-t-perlless-v4-5-be20ac3db39a@pks.im>
References: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
In-Reply-To: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

The `test_readlink()` helper function reads a symbolic link and returns
the path it is pointing to. It is thus equivalent to the readlink(1)
utility, which isn't available on all supported platforms. As such, it
is implemented using Perl so that we can use it even on platforms where
the shell utility isn't available.

While using readlink(1) is not an option, what we can do is to implement
the logic ourselves in our test-tool. Do so, which allows a bunch of
tests to pass when Perl is not available.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-path-utils.c | 13 +++++++++++++
 t/test-lib-functions.sh    |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 72ac8d1b1b0..54d9ba98c0e 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -323,6 +323,19 @@ int cmd__path_utils(int argc, const char **argv)
 		return 0;
 	}
 
+	if (argc >= 2 && !strcmp(argv[1], "readlink")) {
+		struct strbuf target = STRBUF_INIT;
+		while (argc > 2) {
+			if (strbuf_readlink(&target, argv[2], 0) < 0)
+				die_errno("cannot read link at '%s'", argv[2]);
+			puts(target.buf);
+			argc--;
+			argv++;
+		}
+		strbuf_release(&target);
+		return 0;
+	}
+
 	if (argc >= 2 && !strcmp(argv[1], "absolute_path")) {
 		while (argc > 2) {
 			puts(absolute_path(argv[2]));
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index c4b4d3a4c7f..bff8c4d1b41 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1979,7 +1979,7 @@ test_remote_https_urls() {
 # Print the destination of symlink(s) provided as arguments. Basically
 # the same as the readlink command, but it's not available everywhere.
 test_readlink () {
-	perl -le 'print readlink($_) for @ARGV' "$@"
+	test-tool path-utils readlink "$@"
 }
 
 # Set mtime to a fixed "magic" timestamp in mid February 2009, before we

-- 
2.49.0.604.gff1f9ca942.dirty

