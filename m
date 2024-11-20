Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112761BBBDA
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110005; cv=none; b=n9xUtmD4JVjSfEzXV2D8oLb+FK8egLYbcTq9YA9YP/lQOl8bqlUZDf/E/L9laT5fD8N4VyN2ZuWasW37LlVnPSHzD3q5pxbiKqnZ57C4tjEDtlMmfLL+PRlYsAzRDIwBCukZInqDfuKdl71lOk6HSue1lEpkOF0mudk7K9i3WOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110005; c=relaxed/simple;
	bh=7ohwjNq13BzlF/LQWmfIPSMf6T0trn226dTOqUgigGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lnDvCQWQp8M9PZpEqtaq+00sNRfnXfkoTDuxxUYUPl+d/qNtAy4SIc5PRu4I4M/Ad3rsG1cKgbisj3DQXSbcZNGlD2qXckUbSHSl+59N7M0GsM3Xe94mbYCLO7+vdD+RH0kGuIDWb+fEFZsBWWesWmAdSEiI9R55xk7X3ct84sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Iqeq+FZy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z9oIFUtZ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Iqeq+FZy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z9oIFUtZ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5014013806CF;
	Wed, 20 Nov 2024 08:40:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 20 Nov 2024 08:40:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732110003;
	 x=1732196403; bh=pULchFMEqG6DUYqA1tM1jXAiE6UPJzbrZe4bpU/3Wcc=; b=
	Iqeq+FZylzCK7B1GYe6gbERauHeSjFoU3iltPwGSjx2PluoLsin9xT0tJkQ7iGy4
	9FN6g02cTAJ74m6nM22yzprbuUZYwsCpu4LyjtXn0xGl60YpjQQAmV0zKtkEzR9l
	fyuoTBZGQJ2md7u1qg2kQZPkI+9ywgBlrpjBvVwIPh6wXKywzNqp+dmKitZJmaPw
	nMQiYlM2nvxU4JLQNh4h/yIREY/oQ0wKV9fnvNMrvyxncdgCAHiJEaJLfOHg2WJT
	vUpf9JL36/gWiRdxRLIbbj0d9+bGQCCjSpVoPWmrZeNmLHh2lC6PeRsLRXkLEXxq
	nSXi8ekI2cPX3f1Wvn8C+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732110003; x=
	1732196403; bh=pULchFMEqG6DUYqA1tM1jXAiE6UPJzbrZe4bpU/3Wcc=; b=Z
	9oIFUtZaz5uczgPrEX+kz83NRHFgzA6r+yuF6+ql02rHRkLirklZqxeaXPBoyXx9
	aiUtyxmuffHSOD+4Pmv0zyg95a6EoRiiYsTwesmKRCp4bkLZAcTcuuyXyG9fH5HS
	ybgb9ObljW7EY6fLqjr3b1DnqwWk+V7gMg4rfewCackSpU0iA5gpvET823jO1D85
	xAzVbP2tUDe6MUVg9lMjvzSC344PwK0IYVE+vRNK0/likphSmht1HvDfys7Vd/zr
	YkWcEtnDG3yogTF0nVi1sEkwrQbxo3I42AT4wrLjCqa7J6VojanKu/htCpjkYb73
	DbWccCLgc4wE28goidSrA==
X-ME-Sender: <xms:s-Y9ZweSDZ3rXQ88jHfkU52ByofplVykMYMOMhGFbwgMF60nTIUb-w>
    <xme:s-Y9ZyOTYwg0mmQksPtpKsZDdFVpBRG1pdOUyleWwq7-wxZDrgXBLj9Jf2pdM2NO-
    OTUFm8YHsgz9xSRSw>
X-ME-Received: <xmr:s-Y9ZxhwO_624JKrGxsfvuHYb6rs12nnVCtuS0ge3KiViM0SMC7kP0veo1zD9IuIaTySfK_h6EBkPyakSIBoZqR36ZOjdfvquzUIBRk9xw0-gA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:s-Y9Z1-2BxEH3hsguT-N_lkg5LKggpOKa_OY_vijkadVbSBYzhYe2g>
    <xmx:s-Y9Z8vE-esSq44iMwlxqtUrOkajX47T3M0ka3K7GqppWhHyV_8ueg>
    <xmx:s-Y9Z8HIMdZzqkDbaTzvuyIevt6qOO3T6ANK09ss-Ejr9ZcUO6BOGQ>
    <xmx:s-Y9Z7NxGdAT9ijZ6cO0JSqQWSLcx6YLZJ0z5iZzlRIBD21p_Kt_0Q>
    <xmx:s-Y9Z-JjtpFn1WOjhC3GO5_-o2fiMav24SLc2kDz4XvF6N52My2B6bp5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:40:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f92f1fe5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:39:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:44 +0100
Subject: [PATCH v3 15/27] help: fix leaking `struct cmdnames`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-15-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

We're populating multiple `struct cmdnames`, but don't ever free them.
Plug this memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 help.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/help.c b/help.c
index 8794f81db9bbf457b7cabca59222299922f3cc7f..8b56cd6e25ba5f2be2cbf2a7a9ed48136e12a0c7 100644
--- a/help.c
+++ b/help.c
@@ -723,6 +723,10 @@ const char *help_unknown_cmd(const char *cmd)
 				   (float)cfg.autocorrect/10.0, assumed);
 			sleep_millisec(cfg.autocorrect * 100);
 		}
+
+		cmdnames_release(&cfg.aliases);
+		cmdnames_release(&main_cmds);
+		cmdnames_release(&other_cmds);
 		return assumed;
 	}
 

-- 
2.47.0.274.g962d0b743d.dirty

