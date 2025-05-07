Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4291C84CD
	for <git@vger.kernel.org>; Wed,  7 May 2025 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635271; cv=none; b=QFlvtYfnCprsg8QwFNf1+Lmde8wgexaf8T4yK+qnhf7OtyJWOyGReJmIRUtyDd4J3Ti67OBefVqEdlGD/LMajPQyxzjIC4g0l3/RGQKg51G+9Iseh2hYmBh08plfg0w08NRftIaD3CaLdvca0VJrFND/Evm/34Ooij5wJ9ZLzH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635271; c=relaxed/simple;
	bh=5XZuhByySv5bg+x27I2w9jLeM6cFVsrWMo0kTmotVdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hw0/0Vv9oTHo95GIKB6+iHaA4/7MSWNXeYgaIp03JdRRaCnvoNIBLEDL9rX6PP5BkG/pY9vt2c3ixt8YI26pDuiYVERKXshbdinAh0GrWOaEXm0TmdoMXaNJrXzwrY+Gb4TZhduXcfDmaMOkhLts/w73+eRi2pjuaDzGXMtI5Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GPjc5jt8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TaRqsqlJ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GPjc5jt8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TaRqsqlJ"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B395D13801F7;
	Wed,  7 May 2025 12:27:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 07 May 2025 12:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746635267;
	 x=1746721667; bh=hnHyHr8PJzZIFHw1nUYUSXgaZSfABE5ukyhpHntUGCk=; b=
	GPjc5jt8UOsNiOd6G19THYuDvuNVR/XXScsXktMYYU3RUU1+b+oF/2kJRpwtZvSH
	3q0go2IGkSKqzvSvcNBlUAYZlbsXpy7GqJjQO/82vhF8gYCZn8uTWqrhLeCh6EJJ
	ifhcOI1AdKG8kgn0PQa7aoOBT5pMqoD6Gy5yFN8Orm3F36osya74RjdzuszdaCYD
	AjitS03sF1CzUM5WjjEeooKRVzBv1trippjQsyr0AjlJ2FXi3NBh6PbCap9Vul6F
	YIuvViOnwtrKFi253iNyjZiaKWjexRvfzHdxrtbB3SXNQUL7Abp5TNG2jzvocT1x
	Rh//1BVzYLBj2/mJTUvIOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746635267; x=
	1746721667; bh=hnHyHr8PJzZIFHw1nUYUSXgaZSfABE5ukyhpHntUGCk=; b=T
	aRqsqlJs2OBcSrwZCC7EU/x9pyhrU+lZHoNcX+7DKpBXWVpiAxbQj2VHNv9p1xWV
	LRisT3SupoKaPZAQzeuJ4aqE4LVYGbb8N6HCLLKhIKRq4mB0I8gtaU5SkXjfhmO8
	KovZSLn2KPSmn/Hqg149VXnHV3Cbam2SNGV2DCgua1CpyYxwRMBV8hrx39g2ojro
	9il/a37uqQslMwjkJsfrY2Lnki0aFexkY0qAGg0oGVDUi13+kT6q9ZoZJy5lbPHL
	eKO69GyZFKPYO84wg2bvdW4g/xK0q7joxI4A0FS7fVHhPnuVl/hNwUpmPLEnTpLs
	cMcZsYHuoe57k4/CNy+Tw==
X-ME-Sender: <xms:A4obaA_3E3v0-v3acT_WXlsBuOgkv0hIE7rRdOSLY2EJmRMRhKch2Q>
    <xme:A4obaIvHQWMfewVt0R68U0Z4V7SzduljIlNLAyCasltLY3-XO_jsfsxRsMHS7EJBd
    3-iRFz8Kf1TXDhUMA>
X-ME-Received: <xmr:A4obaGAwzdGg0Q3iotSAzLpMwbtL4j8Kf9pkwwDLHpeeqslQn-lZTszYDP47qINYNkR4Bn_n7hj8GPADBNzVihStx_ds027rsIji>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeelhfeiueekfffhveekudeileetjeeu
    geejfeejueelhfelveetueffueevgfejveenucffohhmrghinheprghpphhlvgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehkohhjihdrnhgrkhgrmhgrrhhusehgrhgvvgdrnhgvthdp
    rhgtphhtthhopehtsghovghgihesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:A4obaAdFN8ubB25ZP18LxF8ThK2RCSjKav4TqD7XHQiLbFHNwo_czg>
    <xmx:A4obaFNyRB_Lurwei_ryzfRUK2JwOCyQq5zBa-3-4ks6_XSWmQ9HBA>
    <xmx:A4obaKnbRa5sQat88-jQzSdx7Fy9TCsc8-HlGYBwLNYhhJcX_IC_Uw>
    <xmx:A4obaHvugXcvXJTXBwfRTbG27Z0U1SMsSyOPOZVkQno69P6RwtH0gg>
    <xmx:A4obaClAI6CK3QE-YH0BvpWS-yn7etL-IIkRtij5e1VW5BDeL7YTteqw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 12:27:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Koji Nakamaru <koji.nakamaru@gree.net>
Cc: tboegi@web.de,  git@vger.kernel.org
Subject: Re: [PATCH/RFC v1 1/1] intialize
 false_but_the_compiler_does_not_know_it_
In-Reply-To: <CAOTNsDy4YcOP9H_xmUDKRdGuEu0GABDj8sM0Jt+oPEo7JVSQ9A@mail.gmail.com>
	(Koji Nakamaru's message of "Wed, 7 May 2025 10:22:51 +0900")
References: <7efc9c9c-8187-4e10-bf9d-1cbb6aeac124@web.de>
	<20250506120644.186968-1-tboegi@web.de> <xmqq5xidlkvv.fsf@gitster.g>
	<CAOTNsDy4YcOP9H_xmUDKRdGuEu0GABDj8sM0Jt+oPEo7JVSQ9A@mail.gmail.com>
Date: Wed, 07 May 2025 09:27:45 -0700
Message-ID: <xmqqikmce67y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Koji Nakamaru <koji.nakamaru@gree.net> writes:

> On Wed, May 7, 2025 at 2:16 AM Junio C Hamano <gitster@pobox.com> wrote:
>> Just for reference (as the proposed log message refers to an "older
>> macOS"), do we know if the toolchain on a more recent release of
>> macOS work without this workaround already?  It may be nice to tell
>> users what version they need to avoid the same issue in their own
>> program.
>
> I tested further with Xcode 14.3.1 (the last version of 14.x) and 15,
> where the former still had the issue and the latter worked without the
> workaround. Xcode 15 introduces a new linker which seems to fix the bug.
>
> cf. https://developer.apple.com/documentation/xcode-release-notes/xcode-15-release-notes#Build-System
>
> Koji Nakamaru

Wonderful.  Thanks for a quick report.

Here is an updated patch with the above information.

Thanks.

--- >8 ---
From: Torsten Bögershausen <tboegi@web.de>
Date:   Tue May 6 14:06:44 2025 +0200

intialize false_but_the_compiler_does_not_know_it_

Compiling/linking 82e79c63642c on an older MacOs machine (like Xcode
14.3.1, the last version of 14.x series) leads to this:

    Undefined symbols for architecture x86_64:
      "_false_but_the_compiler_does_not_know_it_", referenced from:
          _start_command in libgit.a(run-command.o)

The linker fails to pick up compiler-tricks/not-constant.o that
defines the needed false_but_the_compiler_does_not_know_it_ symbol,
which is the only thing defined in that object file, from the
libgit.a archive.

Initializing the variable explicitly to 0 works around the linker
bug; the symbol type changes from 'C' to 'S' and is picked up by the
linker.

Xcode 15 introduces a new linker, which seems to fix the bug, making
the workaround here unnecessary, and Apple requires [*] to build with
Xcode 16 or later in order to upload to their App Store Connect
since April 24, 2025, but not everybody is expected to upgrade their
toolchain immediately.

 [*] https://developer.apple.com/news/upcoming-requirements/?id=02212025a

Helped-by: Koji Nakamaru <koji.nakamaru@gree.net>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
[jc: update version info with Koji's help]
Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/compiler-tricks/not-constant.c b/compiler-tricks/not-constant.c
index 1da3ffc2f5..9fb4f275b1 100644
--- a/compiler-tricks/not-constant.c
+++ b/compiler-tricks/not-constant.c
@@ -1,2 +1,2 @@
 #include <git-compat-util.h>
-int false_but_the_compiler_does_not_know_it_;
+int false_but_the_compiler_does_not_know_it_ = 0;
