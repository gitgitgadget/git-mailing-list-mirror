Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684383815DD
	for <git@vger.kernel.org>; Thu, 21 May 2026 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349361; cv=none; b=P+H3vvGM/9GuC/+YH48ZRrGsMdbBVYiMILECnHygpiutAJXSJOPcAVMOXchTG0+q13su0nz5a1LPsivotCdWQH4uG4mfE59+9UkXr6L9J1clIhTcszPTQBH9cfJS69wMgXk79/jvXwZCz1JA68z+Dp619hRjeXxO9NFdCCnsHVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349361; c=relaxed/simple;
	bh=LvfTjDXKPyiu8TdAOUnAQHR7wR2MyJxdmq+T2oeRFDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j4XF5+BjMRm+m6SWG9TwxscHOLMgvPzBXsKlLo8/dXSjnKrts7DEhkGZos45iaTf0AuqjubVqH+jbKaXDnwCZGgefwkDP1LNukp2SXDGT/wgwE2IJFH3pe0CsHahm2+vaZ+dFBA4TGcvnuwLty2lQi2nkrRFXZgYKFRllmddfBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pMW0vfo7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W5gIEwPc; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pMW0vfo7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W5gIEwPc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 89A2BEC00A2
	for <git@vger.kernel.org>; Thu, 21 May 2026 03:42:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 21 May 2026 03:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779349359;
	 x=1779435759; bh=qZIpod9oCrOSlvKEd2OJ40NL1WF8dIzOLf4jbc/Nz94=; b=
	pMW0vfo7NVLOHrm4/cpV3EKJyvEJbKhKvTIA12Tg4k3jNbfTjbSeLOuetApMUS0U
	+zRIk1DNvdiLyHiIeL46e3TolRYuOF8q4+KhNYdtDrnGNcziqMYspGWBXvcWov+2
	9VUihs2YtJa9efR9N6YYeiPM8ga3P8PhU/5kSTuZAx/rMiKWcdN69odQtx0y2ud1
	fZuX5ez7zRx1XypWjP7Hnx1mB0zpNv3y1RKSgJTJqiThiPy340i4CjCuPE7gEgwJ
	fKH+fZpM84j6+OUEOI8fTLSgbLykpmK6CqDc+IwRljmyOcRrNSnUNUofV3bskbtk
	9Y9q2izoqJFznICQI9NEQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779349359; x=
	1779435759; bh=qZIpod9oCrOSlvKEd2OJ40NL1WF8dIzOLf4jbc/Nz94=; b=W
	5gIEwPctBSvYBXlpDMkEBJy0H4cCgo6DqG/qqETFUjzVrlAlEvYzinfWDut9NmXZ
	AEIbpvK3C+rwowwk5JpMkyiExjAUcio5eCyjqbvZL/47x0gYhzi3lTbGiikINQJS
	NlIeJ+qOkfQHFEcBixR9k2mJBWojx2bwcy5wywJWrdRN4NRNBijAUkJN5PWBmUwb
	RfJre+WtLQGh0gTr/3wCVdStk8EdjX2UlBJPbN5cmEFKFEWaJXKicdrVaKAT8RDo
	fcov9pPFjfAhbajYssleiNxbFpiyvZL60c83uvAIbKQyPLNnxbQ0URki+dlXhrMi
	gwmFP3Zkv/Mp4DXRJ7pJw==
X-ME-Sender: <xms:b7cOaj8jbL3ooxNRY--LaooOByPQ2hNersW6gq2NXd4-4hxDOiQ-6Q>
    <xme:b7cOamqwaZUuYhFT1UFLov-RvzZSiqMktF8oJVo9Sv--zhlrE88LO7gpHlkwkdTPp
    kEceuGOCejp3Twno38MwRVSsbyb_s8ARVaGHohe3cGr2sK9i90jQQ>
X-ME-Received: <xmr:b7cOamrEWZwG84k_6EYYmRML2zOWOohEFHy7sHekxpOPJLsojSjYvCX4hcCSEKGSlNE3qlJfaPADS3Kxn1yNaLNWExdFoLMBIfOlNTICre8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeileegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:b7cOakle3Z5fgVSSdnNNtBy2i63R8TNW-gyTT4-J-G-zsxqyu6aSBA>
    <xmx:b7cOaoGwZ2ECEjSzHFDdExBN2T95zPmonedV94-nk5BltRbqno7Zew>
    <xmx:b7cOatr5UPiQJkynWPAaZTUADDfcR0xWM21Iu62G2F5JG40z6XLATw>
    <xmx:b7cOak5H6-o6phnTGB6rzR0vTZovFnaOMyMSZcmUuWkuzD-5xS4fKw>
    <xmx:b7cOavvR-Yv3VfR2QzSQz1YQUG2OtISqh1yI6pxK-mm14RmpciqIgZRY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 03:42:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 04c81e28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 07:42:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 09:42:28 +0200
Subject: [PATCH 1/8] t0001: plug test gaps for git-init(1) with
 GIT_OBJECT_DIRECTORY
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-setup-centralize-odb-creation-v1-1-f130d2a7e8ae@pks.im>
References: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
In-Reply-To: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In subsequent commits we'll rework how we set up the repository. This is
a somewhat intricate and thus fragile sequence, there's many things that
can go subtly wrong, and there are lots of interesting interactions that
one can discover.

One such discovered edge case was the interaction between git-init(1)
and the "GIT_OBJECT_DIRECTORY" enviroment variable. When set, the
behaviour is that the object directory should be created at the path
that the variable points to. This behaviour is documented as such in
its man page:

  If the object storage directory is specified via the
  GIT_OBJECT_DIRECTORY environment variable then the sha1 directories
  are created underneath; otherwise, the default $GIT_DIR/objects
  directory is used.

Curiously enough though we don't seem to have any tests that exercise
this directly, and thus a subsequent commit inadvertently broke this
expectation.

Plug this test gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0001-init.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index e4d32bb4d2..e89feca544 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -980,4 +980,14 @@ test_expect_success 're-init reads matching includeIf.onbranch' '
 	test_cmp expect err
 '
 
+test_expect_success 'init honors GIT_OBJECT_DIRECTORY' '
+	test_when_finished "rm -rf init-objdir custom-odb" &&
+	mkdir custom-odb &&
+	env GIT_OBJECT_DIRECTORY="$(pwd)/custom-odb" \
+		git init init-objdir &&
+	test_path_is_missing init-objdir/.git/objects/pack &&
+	test_path_is_dir custom-odb/pack &&
+	test_path_is_dir custom-odb/info
+'
+
 test_done

-- 
2.54.0.771.g3ed373ac14.dirty

