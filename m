Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB92DDC1
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749050256; cv=none; b=D8rR0T4LosQPRmsWBchG4dRu7QteU+COuPs06hZIU6KsAFTZKtkR+/sSN9g8jMif7U+WZEvP9Y0jIYUuCtEs+6iKA3PcCZZ2nYMiRR4q3y5Gpxv/wIg3cfjCGtBKOd2zC2et08svtp5OtN/b1xHvxzbA42YfSam4tcJkedcJ7MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749050256; c=relaxed/simple;
	bh=Uj1j62y+ksx/6J9XoZea/DJcGz1q/wqoPYLgOsFGEnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bzObdL1NwVrXKYZ0tT6oDMmvPEC/omUEDAK6SaBWUEFhL712Ct9LT18c/fIMPGak3xB100bs0osIoLAJA99+PdcIwGKZKV+GrwbJH01/Zx+8YoI2MqQHpV+0pxeLzniBduiBxEzfiBZq25OFDrB3uHIHuPCp3wDDRD4iLnywGRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AsaqoxEn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WbpdiSnm; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AsaqoxEn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WbpdiSnm"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C22E51380456;
	Wed,  4 Jun 2025 11:17:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 04 Jun 2025 11:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749050253; x=1749136653; bh=HYh62sCq0I
	SqnHtyx9VyLH9WSXGFg+TwMYu6u8SoZbU=; b=AsaqoxEnUrcIbHLTYuPH3y0bVi
	5QyOaAKgEmrj0k0i5zKJSLkaiffFIkHMOsh2hJ7c/TVcRlzKZ0PMFkQVwGxZHsnu
	aly5aP5/r22k2Wv+C8F14F7Hce1v9AERW9kv0j3jBsWe76KD15KETO83Bz1zshsO
	1SvQOCqV7foLwPEBMrAIO++Mz4ymlZvLv0EJwapb+0JRnqFCcMvOC3yFtOeLzbW3
	btGc+WWPV3WTG21Ncq76gb6s6DBCeSA1KyIxXHaa4p1e4zq7IZUxhzHtcYeIfma+
	FeMQ8w3NyXpmR+5fJDiPw35plwCXVZdxJxzh/g9h/AwOlZse6/5NNRtYEo0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749050253; x=1749136653; bh=HYh62sCq0ISqnHtyx9VyLH9WSXGFg+TwMYu
	6u8SoZbU=; b=WbpdiSnmw/g37fyE0hC4CFw+c7tE/+pH+CP9Cur7wgM1vOWEhBb
	uSYAu1+IR/HmcWfnwHEeTr7iiwInYDl+p03PAhveLWxRcT8pMMhD3hHAPADXlTM5
	MQFATdn42wpDgNsCR4yzjs0FItIWaUWjlieHsE4LOVcpI5zac5+6khZazZiY5BAl
	dur5g2ILMqHpOAmLXtWMVuQHEgxTKsznA8CDyEEaCZw5pTvVzQrLVIk1ZqQwP6jv
	a37D1PirTmbxIXqkUctCObA1rKav+Y8v0TTkSP2BwaTRJNxbCK5eobJNbimZhHFe
	8iRXQyQYQivt0KXSk1+uXN5YrjPKg6ypB6g==
X-ME-Sender: <xms:jWNAaO8sDt7meFNGYmqNm3G09zWZUTsOUqmEDlHHH-2K0vxG-t-dsg>
    <xme:jWNAaOv3sT6841TsEe5iLBm1MmhvKv3hK1H1Cp3LH_qVsqRRuBUBPRSIHK_01l7ha
    b5Cb_NRJfGMmBtrWQ>
X-ME-Received: <xmr:jWNAaEAJiORCdybG4R5raSA0KESAUqQ-10d4I57M3rd3Fo86ZJYOUCIQgro6LhbTR4BQkNAO3xXANx_HiJsBM6rsJ1Z95ANj-WZG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepjheitheskhgusg
    hgrdhorhhgpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jWNAaGfcHtIY5O0GuneG-0KSkW4Tl8v3VRPGbaS8bCSYrHNPZW3oKQ>
    <xmx:jWNAaDMmYO53TkciIVRjVmFCP2pKka5jLu5XZ_zhUu0mpQN6wiMpDA>
    <xmx:jWNAaAmyLNPmTgHkTuRcWSdLFMm460j4EoNsbj6SO4REPJ_zhaUoPA>
    <xmx:jWNAaFt15XLhFYoROBTaofCJdV9Xs0xoJlSJBIkf-A-jLcyCJGZphg>
    <xmx:jWNAaBy1pmykXD1ezYZWdO4S-DOhWgP2Lm7qrN69_NnkEb21jT7_eq6B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 11:17:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Cc: rsbecker@nexbridge.com,  git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.50.0-rc1 - Test Failed
In-Reply-To: <aEBPdFXpIca7lMls@teonanacatl.net> (Todd Zullinger's message of
	"Wed, 4 Jun 2025 09:51:48 -0400")
References: <xmqqsekgn4gk.fsf@gitster.g>
	<007a01dbd4d7$89ebf100$9dc3d300$@nexbridge.com>
	<007d01dbd4d9$356ded70$a049c850$@nexbridge.com>
	<aEBPdFXpIca7lMls@teonanacatl.net>
Date: Wed, 04 Jun 2025 08:17:31 -0700
Message-ID: <xmqqjz5rcz90.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> rsbecker@nexbridge.com wrote:
>>>I hit a new issue during the test phase.
>>>
>>>Makefile:200: recipe for target 'lib/tclIndex' failed
>>>
>>>Is there any way to suppress this? I don't think we need TCL - don't have it anyway
>>>on NonStop.
>> 
>> More info:
>> 
>> The actual more complete error is:
>> 
>> /usr/coreutils/bin/bash generate-git-gui.sh "git-gui.sh" "git-gui" ./GIT-GUI-BUILD-OPTIONS ./GIT-VERSION-FILE
>> /usr/coreutils/bin/bash generate-tclindex.sh . ./GIT-GUI-BUILD-OPTIONS 
>> usage: generate-tclindex.sh <BUILD_DIR> <BUILD_OPTIONS> <LIBFILE> [<LIBFILE>...]
>> Makefile:200: recipe for target 'lib/tclIndex' failed
>> 
>> This seems like a legit problem to be fixed rather than ignored.
>
> If you don't have TCL, are you not setting NO_TCLTK for your
> builds?
>
> I don't think that's changed in ages, but perhaps something
> has changed in the build process or your build system which
> now exposes that you aren't setting it, which then tries to
> build git-gui (and would surely try to build gitk as well).

Curious.

$ git diff --name-status v2.50.0-rc0 v2.50.0-rc1 -- git-gui/ gitk-git/
M	git-gui/.gitattributes
M	git-gui/.gitignore
A	git-gui/GIT-GUI-BUILD-OPTIONS.in
M	git-gui/GIT-VERSION-GEN
M	git-gui/Makefile
A	git-gui/generate-git-gui.sh
A	git-gui/generate-macos-app.sh
A	git-gui/generate-macos-wrapper.sh
A	git-gui/generate-tclindex.sh
A	git-gui/lib/meson.build
A	git-gui/meson.build
A	git-gui/po/meson.build
M	gitk-git/Makefile
M	gitk-git/gitk
$ git diff --stat v2.50.0-rc0 v2.50.0-rc1 -- git-gui/ gitk-git/
 git-gui/.gitattributes            |   1 +
 git-gui/.gitignore                |   2 +-
 git-gui/GIT-GUI-BUILD-OPTIONS.in  |   7 ++
 git-gui/GIT-VERSION-GEN           |  44 ++++++++----
 git-gui/Makefile                  | 115 ++++++++---------------------
 git-gui/generate-git-gui.sh       |  29 ++++++++
 git-gui/generate-macos-app.sh     |  30 ++++++++
 git-gui/generate-macos-wrapper.sh |  35 +++++++++
 git-gui/generate-tclindex.sh      |  32 +++++++++
 git-gui/lib/meson.build           |  74 +++++++++++++++++++
 git-gui/meson.build               | 148 ++++++++++++++++++++++++++++++++++++++
 git-gui/po/meson.build            |  38 ++++++++++
 gitk-git/Makefile                 |   2 +-
 gitk-git/gitk                     |  10 ++-
 14 files changed, 458 insertions(+), 109 deletions(-)

So the build procedure for git-gui (but not gitk) has changed rather
extensively after we tagged the preview before -rc1?  Honestly, I
would have preferred to see a change with this impact go through the
regular 'seen' to 'next' to 'master' way before -rc0, but that is
water under the bridge.

We are in an exciting cycle X-<.

J6t?

I do not spot anything obviously wrong (and it is not expected that
I would---we wouldn't have this code sent to me in the first place
if this is something I can immediately notice).  git-gui/Makefile
sets ALL_LIBFILES to $(wildcard lib/*.tcl) and then does

    $(SHELL_PATH) generate-tclindex.sh . ./GIT-GUI-BUILD-OPTIONS $(ALL_LIBFILES)

So the error message in Becker's message, i.e.

> /usr/coreutils/bin/bash generate-tclindex.sh . ./GIT-GUI-BUILD-OPTIONS 
> usage: generate-tclindex.sh <BUILD_DIR> <BUILD_OPTIONS> <LIBFILE> [<LIBFILE>...]
> Makefile:200: recipe for target 'lib/tclIndex' failed

suggests that $(wildcard lib/*tcl) expanded to *nothing*, which
sounds horribly wrong.  They are source material and should exist in
an unmodified checkout or a tarball extract.

