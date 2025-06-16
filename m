Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D637E1ACEDC
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 05:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750052501; cv=none; b=FRMDf6xW0gcZeQ0SInNC+bL5rNT/D09ZX7WqDOX9GSwF9IXYx7z43nbVOUbaTtXSK8zVltVnYauYktnjoSwzk+vhF4S2lgPyErCWS4Vb/XUqJ5ASDTurGk29vE8iLEG3LKFfzFa1xEz4E8oLVVuvbO7dkpPoZqw96MSm6ZtLvWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750052501; c=relaxed/simple;
	bh=LgxM2fsw2b/fAGFe80XAxpYdjEYPahnsAaFCpgkrp0g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WrzaJ0MQ6b3X9Li9tlcT7YmrURlpjvCGPvYaqr+ILbaV61OMDZcgjElTlB74u11/DAqRxpz3FitphDhwpPN+QK5Z/v2FwRItSnMe72kRQGdVO8s/4gyCg3VBagEL0YT0KFbrooxUBXx+Mn8XkW/Jg4mfLD1xuZj3vDuyUzwIKQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z7JcLe84; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rR+mwxON; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z7JcLe84";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rR+mwxON"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id D23A1138029C;
	Mon, 16 Jun 2025 01:41:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 16 Jun 2025 01:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750052497; x=1750138897; bh=F/Zvvzd1q1
	9MsPpR9vFiQcLJD9zIpWUV9dHM0XkG8UE=; b=Z7JcLe84+zqldeZ2BquHoUGXto
	rYxK0ozOe+jjaxGUCYI7RoF1qeWozGXebmbTzvIh2Lj61ZmhXXtf7PGwNpYPc5kk
	bQC156Yh8yJmHI/M7dmk6c/CKWDYj1Wyxbx2VPsxZDcPaGkBo9g/8SgAqttgTe59
	0PMkx5vqcwAltlP6sMxYe2oHKUrSnPhTFXhtEPw3ahX1wCTZHX77NEgaa8+wIGzR
	UYCRQQ6iItFl2U7af5RaXgCO+7AR/q0YolB9ABRG2QrEH0ajwl9OAuZNGQX3njEI
	zjbH3t3hmjJ3hEOFxhL9gGoIB0eo1CLoZ0UBCkPiYw+sTdGEIPx+rFd1k03g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750052497; x=1750138897; bh=F/Zvvzd1q19MsPpR9vFiQcLJD9zIpWUV9dH
	M0XkG8UE=; b=rR+mwxON113EUMHtR4C7KhG9YuZtl1F06V6a6VFR7rYDEbhmM/7
	lGej9ERZdgu6aRoG1rn4OV+G+wU0CFUq2fmWjkh9RwueiZjWsCVXBwOD8xcrDTUh
	JI+nAOXJ14cbsVeDUO6rcjZ5P/1x5OUeByYXCGzpSDYaUCG1biDpISpMPPXnIVzd
	QSWAdsZYAPk0t+coMVpHAmBFRpLWUowr/5HHkymCiTQVJbrXSLwRSBRKTnH7rem+
	3L3/SO0t9RN7AmBV0JGCt+roq3y+hym2A5k76bC0dTOrXGw0Pd0u6nDsvWfcwmxL
	mGEx1/H+j19oRYCcYvTQBYukB8WzWQTAr2A==
X-ME-Sender: <xms:ka5PaOPz25qAJRj9ZwnWI6wdkT3_QI__wSgV8uR3bFPMdxafB7Yimw>
    <xme:ka5PaM_l_oO_1c4s16dzawdavDZLFWW7-R-iBoStETfUbTj3WDzyVdKF58FRwok9P
    wgm4fT3zh80gnTeFw>
X-ME-Received: <xmr:ka5PaFQrNIrqiQDTCn6BKKrql61dJfPxc9WiobYP4V4ub2MnmmesWdD59xz-yN1cifM1Bwhy_YnY-5riGAepXpbTcDxkLnQ4qSuh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvheejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohephedtvddtvdegfeeftddtheeisehsmhgrihhlrdhnjhhurdgvughurd
    gtnhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhopegthh
    hrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshhih
    rghmthhhrghkkhgrrhdttddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ka5PaOtWd8USlKDgMNoNNYA5ETWusJnuO5i8y36UmIkiGk-69u8jrg>
    <xmx:ka5PaGfoznJ05W1rsAYrYOQxRz7iTsifEd9KWHMf30EHfxe1NbORAg>
    <xmx:ka5PaC0awNj8LL_s21QXCr1F1fTqPsSP2CwYBp1xgsII7zShNu_mVw>
    <xmx:ka5PaK8kaXvCtdoI_O6kw2Y-kMjEg5NoGeuTSktcDd0RwNnZg1vrfg>
    <xmx:ka5PaICexP0sdG9SVpW-DCm2koLXf19Ihm2A6XozzjSq_oTrM4kJay_k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jun 2025 01:41:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <502024330056@smail.nju.edu.cn>
Cc: git@vger.kernel.org,  ayu.chandekar@gmail.com,
  christian.couder@gmail.com,  shyamthakkar001@gmail.com
Subject: Re: [PATCH v2] git.c: remove the_repository dependence in
 run_builtin()
In-Reply-To: <191FDEFA-786C-4CD7-9D4F-06495FCBDDA6@smail.nju.edu.cn> (Lidong
	Yan's message of "Mon, 16 Jun 2025 13:36:41 +0800")
References: <20250612045905.3023227-1-502024330056@smail.nju.edu.cn>
	<20250614050331.304405-1-502024330056@smail.nju.edu.cn>
	<xmqqwm9d6gn0.fsf@gitster.g>
	<BE43915C-E780-4166-9C23-81F9A8CBDEDC@smail.nju.edu.cn>
	<xmqqsek04id9.fsf@gitster.g>
	<191FDEFA-786C-4CD7-9D4F-06495FCBDDA6@smail.nju.edu.cn>
Date: Sun, 15 Jun 2025 22:41:36 -0700
Message-ID: <xmqqjz5c2qgf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <502024330056@smail.nju.edu.cn> writes:

> Which looks even worse, I will leave this comment intact.

That is perfectly fine.  After all, this is not about comment style.
It is about the_repository.  Let's stay focused on that.
