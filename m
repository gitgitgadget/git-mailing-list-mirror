Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A23341644
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439858; cv=none; b=NZBquF7tVhkmWElDZ51Ld5wb6lulmXcpwjpl7+XT4+/3nJLwOMPIsm+QM50ajzDYbO20ylVFwlGAB0ogdvZVRFSQffBwiXTM70ZbSDTvWBgzWiIz5sZTtiR+euYqmcyjtyY3bci4hBeMIEc4tV/O+/21dA6zyblkYn4n9wuDk3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439858; c=relaxed/simple;
	bh=mswq228AEpp0rihtTEaOYiDUk0VLY47+4i6fL4di+1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nI6lf/NsMRF7gjonNmviIN/XKzeAYTGh0GMEleDbvZiX4eGvfZB718775L0wwDJyvh/AMDONg4e6GgjJfQibYFyKUsmeQqM0AlnnvwG1bqSBsDoq2XJ+4RSIeTupB7nKOpo9g1GOZ8XE9jj6ehAA6zCgOC8cuq+PRGLUPzVCs14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HeC/gbAz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O7Ul1TAf; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HeC/gbAz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O7Ul1TAf"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id DB356EC0433;
	Thu,  6 Nov 2025 09:37:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 06 Nov 2025 09:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762439855; x=1762526255; bh=N1U7M8bCLQ
	2Q2qwMrq27anaK0qmw4ehm9dVBDkprK74=; b=HeC/gbAzi/+n8+syO0TbzFIcCG
	bKYxJ7l6wKgDi/F1OmYy77CBqZoBGmnJSUHaxtXx9OfRCbn0hvH2XyqhXTQkd1Mw
	LvqUuehqn1vA4En7iv+oG5K1mlXAXVb44hs1lSav2IfVOze4ErDSVVvC+wylnVZC
	qH0IB/j3xr7SvNfi0J8UxQswkhXYlnqqIx08tL1hOoGgmuvKk2VYHhTsC9bdHFcd
	kcOSCltWWpsw1qR3U2ZAXTl9ONz5b2E+KsViiEFBPqkDZgHrIodq4kqzGLsw56DI
	8i28ikTn8r31p6svisPra22gIgzS5vAhK+lQOmjhRGretdzZAIHcdMfUE1mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762439855; x=1762526255; bh=N1U7M8bCLQ2Q2qwMrq27anaK0qmw4ehm9dV
	BDkprK74=; b=O7Ul1TAfvV3p6LI2Kw+EacdAG6rgyhnp6WC8tlY2YmhUQ/p8xLh
	6Mc7Vl+spU8ymesGE1WgOgmxDFs583wUDEqD0nJClNrjULCYppToZdlWFECoo07n
	vzKURGSF/5NPtkCxnluSH0Ar9EdLapkb92I3nbMQFlE0Lw+EII8xc27IO8R1gTDI
	JXbsVxswo7+RsK8mTMC1c01Hfp6E3WxUFTiuumKXApoHE6mqs1XsjkhCY2NUXcSt
	RwiLV+1z0ZnaOAl+lFv8DjBUSaCDub7coBvnfDt/y7aWeLim6E+3lpIg+F0lB1jH
	mRqtAS/4cvmzo/Ga6/d0Fr/Ivi4jQi+wkXw==
X-ME-Sender: <xms:r7IMaSiBjGVlo-weUbkD5H7Lh9lAVhxG2aj1Z4-9pekPJ7_E-_9Kfg>
    <xme:r7IMaQ383BLEO1nn3U_9s8SjVwThI_W1G0Q0Ik3pxjstbxoAlebvNZ1QxLSMJuOAR
    pCNO9Ho6AY0YYNn3YPWU4I_nu4EIkG_Lfeabd-fexarS5P8SCp0>
X-ME-Received: <xmr:r7IMaUg1yOEUye7kGNOyEo1HfwOJWxQWpwVL__ORRlLuQMRomcLpZYYQ2OJs2DQZjMrlCVs-zh3s5h7_xAdUROr7DweKfvwciIEx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhhohhmrghsrdhuhhhlvgesmhgrihhlsghogidrth
    huqdgurhgvshguvghnrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgi
    druggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:r7IMaYetE9_SwZfRtbzQxo8sb3BLO1-LnJIqOSAZzVMAzTj3OBi5Tw>
    <xmx:r7IMafk_pzulQC2OegywD9z1B6EMchYI6SvPL6FKyUKZEmSIltZuiA>
    <xmx:r7IMaZvZaKxz6QIY31XEUqeP36SdDqUNfk9msKuZk4tbjey5whTsmQ>
    <xmx:r7IMad97HERl5mAbcUvALvXaD2yca23VqPRRlKVcZ1MZEzTWQ36gEQ>
    <xmx:r7IMaWCpRfJVRO2VppUeDcX7X708HmclF7xGLmChf2b0pO78J4ZvEhAY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 09:37:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
Cc: <git@vger.kernel.org>,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] wincred: align Makefile with other Makefiles in contrib
In-Reply-To: <3869ec21-e20d-cf9b-5913-6389c372a5f0@mailbox.tu-dresden.de>
	(Thomas Uhle's message of "Wed, 5 Nov 2025 20:55:19 +0100")
References: <3869ec21-e20d-cf9b-5913-6389c372a5f0@mailbox.tu-dresden.de>
Date: Thu, 06 Nov 2025 06:37:34 -0800
Message-ID: <xmqqtsz7jkgh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de> writes:

> * Replace $(LOADLIBES) because it is deprecated since long and it is
>   used nowhere else in the git project.
> * Use $(gitexecdir) instead of $(libexecdir) because config.mak defines
>   $(libexecdir) as $(prefix)/libexec, not as $(prefix)/libexec/git-core.
> * Similar to other Makefiles, let install target rule create
>   $(gitexecdir) to make sure the directory exists before copying the
>   executable and also let it respect $(DESTDIR).
> * Shuffle the lines for the default settings to align them with the
>   other Makefiles in contrib/credential.
> * Define .PHONY for all special targets (all, install, clean).
>
> Signed-off-by: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
> ---
>  contrib/credential/wincred/Makefile | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Looks sensible (to a person who does not do Windows, anyway), but I
do not know what depends on the way it is currently laid out, so
will queue only after I see a Windows person or two give their acks
to the patch.

Thanks.



> diff --git a/contrib/credential/wincred/Makefile b/contrib/credential/wincred/Makefile
> index 5b795fc..d92e721 100644
> --- a/contrib/credential/wincred/Makefile
> +++ b/contrib/credential/wincred/Makefile
> @@ -4,20 +4,22 @@
>  -include ../../../config.mak.autogen
>  -include ../../../config.mak
>
> -CC ?= gcc
> -RM ?= rm -f
> -CFLAGS ?= -O2 -Wall
> -
>  prefix ?= /usr/local
> -libexecdir ?= $(prefix)/libexec/git-core
> +gitexecdir ?= $(prefix)/libexec/git-core
>
> +CC ?= gcc
> +CFLAGS ?= -O2 -Wall
>  INSTALL ?= install
> +RM ?= rm -f
>
> -git-credential-wincred.exe : git-credential-wincred.c
> -	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@
> +git-credential-wincred.exe: git-credential-wincred.c
> +	$(LINK.c) -o $@ $^ $(LDFLAGS) $(LDLIBS)
>
>  install: git-credential-wincred.exe
> -	$(INSTALL) -m 755 $^ $(libexecdir)
> +	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
> +	$(INSTALL) -m 755 $< $(DESTDIR)$(gitexecdir)
>
>  clean:
>  	$(RM) git-credential-wincred.exe
> +
> +.PHONY: all install clean
>
> base-commit: 4cf919bd7b946477798af5414a371b23fd68bf93
