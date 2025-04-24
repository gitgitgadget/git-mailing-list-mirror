Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656BE2918CC
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745523724; cv=none; b=oBKsTbLe45DCdyIFEJZef36AhG/MLVMBVTBVLMvorjv5H9uSU+sZyjszY0UQm/wyo2mp6E6JW3/+kfW21N351Mkvr95BX/RpL1MAszBhE1vkLvMI+62u1JYLntodVNgj/8eYbezu4Ttjn1N5weV1uJvVVYYeb+We7J88cmd+p2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745523724; c=relaxed/simple;
	bh=98q+6MbTVUpUgqPl4m+nQHCbV+HusR+e7ecuILDSLdU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rOfyhhns8ecnpAEvWwBdNjRkr9aNaSm0fRZX+3EKKkkVGECyngjI/tccsqVMqLVuiC3NklRiYCxcu2tYPmxdGrkfh4ewD3ZnsmozqPTH22RVhd7SqsOAbzVjcFWzJyzkuhH4z898yr8HTpUkIhby66hP6LCGhqSPgUxVdt2lNrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NcgLL/9y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uhq8RY+N; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NcgLL/9y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uhq8RY+N"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6E67211401DD;
	Thu, 24 Apr 2025 15:42:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 24 Apr 2025 15:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745523720; x=1745610120; bh=xs0WuApp9Y
	w6LTQbmMYDIpPB1nsi4pyrDc1u7G4nK8M=; b=NcgLL/9yvDCKBgOVgsWjfElq5Y
	d7mzDI9oooR4ubtPFRzedAiN02XB6crvIu/3FJHp0BKyFC73d3mTXux/EJ1sMmcz
	HLcY4Ta4az00/pXll0bM8c80bIs05qyLqmwqEp1lIfj+lHLmML9+vsWf0GrSpQG2
	fSB7FMnrDwdIHZINihk4vDw0iPIZEnPvB2ZBoxtSVgIz49+0bJbO2KswhvkozeH9
	ZGmqv22tksHA4lcsMWScTaYm++wuDgl7bRwZNO7HA8BXXh80Vae+hQRtw+6lIIR2
	YxMwULXNIenHSO9+07wBt5s3H8uut5PsB1Ully1iEU6oirnYUfrDrBE97FGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745523720; x=1745610120; bh=xs0WuApp9Yw6LTQbmMYDIpPB1nsi4pyrDc1
	u7G4nK8M=; b=uhq8RY+Nu8fVv6mMgPu9m+Pkt40EidUGuccu5z3bNMShvESR1xR
	JxTcQyHkaxuv5GsLBZB7fMQ33f1lbWv4ShTbncVi1G4yT0+rakACjGYUXmYzDp0A
	8cde5yJ2By+grnSZYIZXOF+u0nXHItxDbWBeI+bPYpAYGqsdrkiARFMp8AuvuznV
	k8fzHpqJY0SukpISE/B9jp/7DcNH9ORygY0JFKxjJdtvO8ifavMyFAHoDCZt9YcB
	B+sYOdykNyt08f5PaFGFp43ystIEwNC63+1jNu7icQAEyqzTfB4RXTJK/VFmBl7k
	wr1ntvOUvdqwvoa7yePU3SUMHePKkYCqbTQ==
X-ME-Sender: <xms:CJQKaFEjo4YR4C1ZfUc8eQxhxxmnxFoQPDQYxV-sW59XUZzhtrnZtg>
    <xme:CJQKaKXr0vmPxqc2W6Vbsvghuo6KlcMPciY1oQRzrIwGFtJPNM6hEZSh6_FnMahJv
    aBBN1s9ijMrP2ZTpQ>
X-ME-Received: <xmr:CJQKaHLrACjhH0AVs08-dimhyINNpnXBTtNoGNOYVhRHAimcZAUOgoAjyCZHE-vzYDzxJ3hlXZXBibWLUk8vMuBPOyV3XtAe1Ezf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedtfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:CJQKaLEX6Al5DHugmQRi8CeTE2FipPB-Udn7uyPGZZm-x6ZKISENTA>
    <xmx:CJQKaLXgik5OeOKUkTd-BGcEfn1l4P9_BpWkMQs1fznJ6fetjoXYJQ>
    <xmx:CJQKaGPnxtQgdq-AOHcIGSckcJ4ZKGMRGSBilX4wLoJYDYsSzqMm1A>
    <xmx:CJQKaK0Idega0zWoaPzpd-qf5WuDADcnjyfFY4HNpkPOru2fmLdRkg>
    <xmx:CJQKaJDa19GUEVWRZc7u2eXPjOxScr4a3xszdlaeAcnkLeSeJKbicXC1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 15:41:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/3] test-tool: add pack-deltas helper
In-Reply-To: <5d4beb202d6ed842de72928462a10a4f5faa2718.1745430004.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 23 Apr 2025
	17:40:02 +0000")
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
	<5d4beb202d6ed842de72928462a10a4f5faa2718.1745430004.git.gitgitgadget@gmail.com>
Date: Thu, 24 Apr 2025 12:41:58 -0700
Message-ID: <xmqq34dxuz21.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I needed this to make

$ SANITIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=true make
$ cd t && sh t5309-pack-delta-cycles.sh

pass.
--- >8 ------ >8 ------ >8 ---
Subject: [PATCH] fixup! test-tool: add pack-deltas helper

 t/helper/test-pack-deltas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
index db7d1c3cd1..c8e837ea06 100644
--- a/t/helper/test-pack-deltas.c
+++ b/t/helper/test-pack-deltas.c
@@ -122,6 +122,7 @@ int cmd__pack_deltas(int argc, const char **argv)
 			if (get_oid_hex(base_oid_str, &base_oid))
 				die("invalid object: %s", base_oid_str);
 		}
+		string_list_clear(&items, 0);
 
 		if (!strcmp(type_str, "REF_DELTA"))
 			write_ref_delta(f, &content_oid, &base_oid);
-- 
2.49.0-555-g43235db9c8

