Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD9B2500CC
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 05:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732512843; cv=none; b=DusKf+IvOZyBNL1ihNh1LH9xBnZNVFhibX/3Me1Km3rw6wd5Dkj5KDlTqmN68Nka3QpR37W/NW5a8D2lCxoxvFJy6kotFc0xdAlSta+pUBhiuRt7ZHexvGRrL/GJYD5vqXezbW2Ai5ox2UXguB60dQduXrXIbhS0mp2KWoPxUM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732512843; c=relaxed/simple;
	bh=/5DJYmMM5qJRUf2sUvRLzVLvsm5LC503Qksv0j4+3hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URG7n/uKgK63GVUAEky46EgkzVD/4faY8vUyrIulqwKTwYxEsgj4ed8uWDhT4ojMgbjYZXd5V24c0C5px69e05baiGMUvnEfIidXDalQbMvFOzGyNEeFAVDMPF9yM8SrN9sW74AYn83kjMmzp5HSFbf7/Ivr1NWv1FrAXwlwboo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JqaUyZ2r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vD/fD9W7; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JqaUyZ2r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vD/fD9W7"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1EDEC2540115;
	Mon, 25 Nov 2024 00:33:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 25 Nov 2024 00:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732512837; x=1732599237; bh=Hh7QRctCQS
	7G8asxY8dwoTfeWG+NcKuCVNRyBFykR44=; b=JqaUyZ2rDsVCEI44TjK/9Qrlvh
	LV10K3W52HF2jl2Zh5YotEfuGAXHgVgQmE9TI+aKJSDm89z3iu+K1sLRBE6Bz7xg
	KAjpU/9cPwg52E2a+9qjX0qVY+pbJZKfUiFGgFVraDxoViAWV4Too0+8IgPvEDyu
	d2zdZsnZsd6CxL5MMtSNYrSi+JiJcoboTG53BzN6CVKk2iTiZiCjVVSbxt/d6L/h
	61C+9T7coXBfqqUQGJofYv3vcyqV67r26OBbEK0jXcFVGyuZDre4Zf5WK9txEWeQ
	DcLi+3stUcUdd+jtAEWokkztp0ukQrCiMFPd851C+4IYrp2iSZQpEF9hprXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732512837; x=1732599237; bh=Hh7QRctCQS7G8asxY8dwoTfeWG+NcKuCVNR
	yBFykR44=; b=vD/fD9W7ft4cbLNQsr9pQRGIwDpDtcROOhPbEPiPVjsqPxcmui5
	7fUK0KxUzKFK1XF+O7ZiDipbHVN/uQ+l4T43vAXxzpq9Hpfy37v1NfohxacHJGlI
	uuweAmXMhG3SJtiPi1Nv3K0CGbhrWVrrhQDr89D1OUjxBupjdgmH9cJnXRgJ0rvg
	+ZgHYcCktqCgR75lZShMWQxTlcdcuoNH+CSWvAsi8Yt1Ss5607fIFDhXhXKQyOQs
	V5KCS0I+M2IKW3oTHMvHLYrKe/dWo4Mi+AFLgvgjvKtBD7PTi7aPJxkREyFH84Fz
	jhq0iYDuHk1Y+ycXebQ6xTn8eeuU1Y8lrWQ==
X-ME-Sender: <xms:RQxEZ_iiu-tCGXDoiXqp2Hi84acz5CelBhX1YlvZnNYjUF_YY-5W1A>
    <xme:RQxEZ8BP5YeOYC95ZM9dtmqJ5BsRiXgsKgrXwhcAmxQebHuWo5nW7cJr3cSPOuC6A
    VFWipj1rudLfvGmdw>
X-ME-Received: <xmr:RQxEZ_HMqd6H7Fr_EQ_CPDnweAqt7soliDHQXZfEehGqZHlU01XE0uIlwdfmK2jPnlZ6hubnqTKMuGaZQWT3aP9k1k9DfLGNKyylBTMiP0KP3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkkhhlohhsshesghhithhl
    rggsrdgtohhmpdhrtghpthhtohepmhhrihhntghonhesghhithhlrggsrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RQxEZ8Q0fI339qVtrBrr20HTSt1Bd6VDyRSkDJe5VF1CsaxlYnDJTw>
    <xmx:RQxEZ8xTPq5a7SDzikXl--XdOJpF7Jk6u8wNbPHKJOyGkcWBJenAgA>
    <xmx:RQxEZy6SydiE6cBtAiaMFCjophFONJrxuyutxZzXaS92fE7A_58esw>
    <xmx:RQxEZxwjLoB7eiFKXoTzwd-R86TlqhwsIGjabQGhyPQjsUyYqiPDVg>
    <xmx:RQxEZ7rKHGQjao743iQHmeH8am7Cy5qNTdhlm8-l5TG8jvRDvuh_ht3N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 00:33:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0c0bd62c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 05:32:53 +0000 (UTC)
Date: Mon, 25 Nov 2024 06:33:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Miguel Rincon Barahona <mrincon@gitlab.com>,
	Kev Kloss <kkloss@gitlab.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t7900: fix host-dependent behaviour when testing
 git-maintenance(1)
Message-ID: <eb504a75147d8609be66e131d239a69d192d693d.1732511129.git.ps@pks.im>
References: <20241122153033.GA1737136@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122153033.GA1737136@coredump.intra.peff.net>

We have recently added a new test to t7900 that exercises whether
git-maintenance(1) fails as expected when the "schedule.lock" file
exists. The test depends on whether or not the host has the required
executables present to schedule maintenance tasks in the first place,
like systemd or launchctl -- if not, the test fails with an unrelated
error before even checking for the lock file. This fails for example in
our CI systems, where macOS images do not have launchctl available.

Fix this issue by creating a stub systemctl(1) binary and using the
systemd scheduler.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

Oh, true, thanks for reporting. This here should fix it.

Patrick

 t/t7900-maintenance.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 6d6ffaaf37..4bbc171958 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -1012,10 +1012,15 @@ test_expect_success 'repacking loose objects is quiet' '
 '
 
 test_expect_success 'maintenance aborts with existing lock file' '
-	test_when_finished "rm -rf repo" &&
+	test_when_finished "rm -rf repo script" &&
+	mkdir script &&
+	write_script script/systemctl <<-\EOF &&
+	true
+	EOF
+
 	git init repo &&
 	: >repo/.git/objects/schedule.lock &&
-	test_must_fail git -C repo maintenance start 2>err &&
+	test_must_fail env PATH="$PWD/script:$PATH" git -C repo maintenance start --scheduler=systemd 2>err &&
 	test_grep "Another scheduled git-maintenance(1) process seems to be running" err
 '
 

base-commit: 2f2daa412d02135a1f1f00da3f424217467f8d16
-- 
2.47.0.274.g962d0b743d.dirty

