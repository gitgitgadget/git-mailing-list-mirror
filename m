Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307CE174EF0
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986061; cv=none; b=qabj1ydShLWEN8L8pA39HlrV6wdQBnOn1CWoDZyQydPpyj4pXLTcY2jUUskwK/t7uCKtqJDoWS3ELc+zI7PNJ3dSAm2OuYWtK1KTvP4BGXoRtfoi1tKJxYYtINeUakVBqxOvxiiDYgjeYfGRqCxu9DrfaFQsF0OoKTfKcs9NL18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986061; c=relaxed/simple;
	bh=mpMQV83AowuzqWSs+bB3//z0Eg67AeRiDNQlMRa8pNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GMLwflWuO1bZ2NnodLqCsJXSlmbG9y4T0YmVschaCYCycE59McHhPTM/fvy6CKRl/Jr+U7WTUPbbwE01A0yEBUlUOLXF1tXHcI8ukfDyxsB9rx5SZKokWDqQWELBYp+nBoZ8IJZbC+p2nbRWdnxmZ2qRhc74OIU81ODJxKAP44Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Skz6dMCp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NybrCqEP; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Skz6dMCp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NybrCqEP"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2CCE71140198;
	Thu, 12 Dec 2024 01:47:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 12 Dec 2024 01:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733986058;
	 x=1734072458; bh=0cQRARztA0W/Fi2HfSYPDPp4L4gvmTtbzVPsSSwCl1Q=; b=
	Skz6dMCp/UKQbs3sMYMObwaA5HSAA1V0V29mmUkQ8ZYGkVGDEoO3bvLD7niyMZ+r
	nPM/5d8Xy5/mZBbhSPYdBnMOTZdYntkuTMv6KjLk0si4/bf9T/6p2lOfq/HVokz+
	kC4rmeotA1UZ0Wr1pjb8Qyaq24uabep0yFXwYcO1huFKdOUSXWzRI8MajUaRJpwH
	qo0gUksE1jIqV9OMFLxVAAOWaUORO7TSdrr9/yI8OVhV2UeZvwtLCcEIuAWBpIL6
	QYsAfspeLyteLGUVR+jKEc6rXo1VNXMdKBlzGKZ7LksuYTg3jgUxNCRuKgU0SUP1
	JTz7/bJ26KVkIGnSmcGlHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733986058; x=
	1734072458; bh=0cQRARztA0W/Fi2HfSYPDPp4L4gvmTtbzVPsSSwCl1Q=; b=N
	ybrCqEP33aF4S1KN+tIhldsznVytQ9RxAsff9pP4/MMgic6domcJx6HiKkZS6lVV
	+v+77eNK9g8wpIQV2Thc6UjUcfOr/efJwp+cEdCi7ZQ4hRWeLb+34YBl2yrWlatL
	J0NxkjU31/Syztj6Si95n6kY264hGFAKET7kSOxxDZivE717rsSn+cO9Z6Z4w6MM
	goAIJxL5YZhshFrRZMn8ln6lpyEXuxF0cynwMn5358Fu/JQjJu7V2vKEM79X+8+p
	Ac/BjK1tku90Grds69oS4EgBfoM69LVrteTfUTnWcY4nNpaGXGCZZDTjSV/84db7
	r/jj30xrvbIfhrSzJJB+Q==
X-ME-Sender: <xms:CYdaZx5dQ7z2-xnMElddzgTld5oreUwS4zZbPJ-dRlZr3f_PkhLnsw>
    <xme:CYdaZ-619dGYqcaDa_iDvi8w5bNx-sDx2ayzw-6c3lKmhiBMP1C9Vu12qqvOHBRJ_
    RDDTeow0W6QUvqYxA>
X-ME-Received: <xmr:CYdaZ4ei2jnqq2BU3jB9IoEA-7ApA4IVwK6f8xBxSkCUh0H7GUK9Jk1tCcM5PXUH1XqVzi3toRl0jXf0aAoV0HTA38a06RaMKYxTp-IVG5kGBghr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeggddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmh
    igrdguvgdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:CYdaZ6LpczvFw0Rnn_NiXFsxxkajRPUXHUw8TFZ_IfYudl5OCXMi7g>
    <xmx:CYdaZ1LK3Y0UWeWqXyrKfim6kiji3L-e31PKZy6zF2c1crzlltVYEg>
    <xmx:CYdaZzxts8u5iaHB_ahsF4dONvwjcsrKPDVxeEMswiNS9369ND4u_A>
    <xmx:CYdaZxL8dh3Cs7DxjyGu1fEDfrss8VQPp3aHSgalG42Jh_dyKwyCjQ>
    <xmx:CodaZyE7caScj5bgKOvUci2AWUFx3TjbCtfhz0Oe9SUJ4sNgZItFBPgB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 01:47:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 76d532b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Dec 2024 06:45:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 12 Dec 2024 07:47:15 +0100
Subject: [PATCH v3 2/4] ci/lib: remove duplicate trap to end "CI setup"
 group
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-pks-ci-section-fixes-v3-2-d9fe6baee21e@pks.im>
References: <20241212-pks-ci-section-fixes-v3-0-d9fe6baee21e@pks.im>
In-Reply-To: <20241212-pks-ci-section-fixes-v3-0-d9fe6baee21e@pks.im>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 karthik nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

We exlicitly trap on EXIT in order to end the "CI setup" group. This
isn't necessary though given that `begin_group ()` already sets up the
trap for us.

Remove the duplicate trap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 930f98d7228166c37c236beb062b14675fb68ef3..a54601be923bf475ba1a9cafd98bb1cb71a10255 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -56,7 +56,6 @@ group () {
 }
 
 begin_group "CI setup"
-trap "end_group 'CI setup'" EXIT
 
 # Set 'exit on error' for all CI scripts to let the caller know that
 # something went wrong.

-- 
2.47.1.447.ga7e8429e30.dirty

