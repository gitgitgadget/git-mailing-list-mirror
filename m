Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5633264F8
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610188; cv=none; b=LJ5YR+j/r2UuTmJPK7r6J9y0wbiAxBpOyEX/jNCj9wsnl6jeXFv5tlK3n8StnRQMOhaK1JmlYCxXX0F1xs6xc6ANrGhOlJt5Y15sKDzsGM0FyAuRrbsAyhvo0JPuPgH1Nvgn5vCtyEMRQtXGLp4cvpQYRQpzaX1oI+vi5/vRUj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610188; c=relaxed/simple;
	bh=qTAYPYEDUgKaY1Gp41zyKYYWICogCunHDZerPcAriY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+e96LrqQf4DR4adKY50zLGM19p9pgfg0cGk+DxUcVgC0uzmuYdMGNzWxUZGRqHDt58B4wmp8exKRzSNMO7lwUdTzMqW72kOR+b5wStHJtz2W40TUo0n7a4/nvkJSnQ04vjACHvk50tVLNXz24iCvzhWHcAjphyOiF/yo2oBetM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KWM+1zyY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=THMBltx1; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KWM+1zyY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="THMBltx1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BFE09EC007B;
	Wed,  4 Mar 2026 02:43:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Mar 2026 02:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772610186; x=1772696586; bh=l+j+cUiQE0
	wvg7os9QP8tZmjZtRwvodoHgcGsyFkU4Y=; b=KWM+1zyYvgslWoODs/Q7Fjxcwo
	SMtpp5ygJyG5kXRCr8o2urer1BdW7CURCF826xqyAlYblnioWx0xwpF+TIZWXeQE
	GC/6eWrYG22bS4qP0UgPL3Q7486m7PB+A0ZQ2DidYVjVfVM+WbYZmmLfpkSGJfk/
	SxNGB5M6N/TQmIu0p55KieqsRyr1LIjXRIJLGr10CoIwqugukaCHgUakv8swOn3W
	5vUJS8h68dcfv2mOInXkW+mBlok11cNvcpWUNrrSUJweQdSnN+D4V15XElfoOnJI
	ha7ilJGvZRfi95oTR+H1xkU/MySyUBlgd9C5pOu7p9P5YnzmhgS0OIgXkmXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772610186; x=1772696586; bh=l+j+cUiQE0wvg7os9QP8tZmjZtRwvodoHgc
	GsyFkU4Y=; b=THMBltx1wO3m60KCcm6k0b9WIEjHRl6lmH1/2VOGIz5YSr2vtnG
	oI18CIXszzLMOj9SB0INMQ2Nf1RL/xpnwGLLuPvUjeSZ1w6quUIDz6/Scdej8hj9
	+hG7qxOwRmxvuxxuQB7fBObW0KwFBduhMPOT72AsJvg1UMexlP/rcLtrta03IxP8
	XgKcwQp51DKve4PLqH/gp5sXfTgZhZd8CUrmTeOACr0Izpicenr9Zq+Gbne3Uf2c
	OtMMBMgKobqVHwvkoDwnX4cFIi2wCc0Z3m4FCUwpZSBHMBU+TnKws5HkAxlZPCe/
	fkQ5wIsB6fNNBNAU8DG200U3XP0pCmqleWg==
X-ME-Sender: <xms:iuKnaQwPDDEbEyGJUNOB43icDvugMZ5Mq1Spo-UihHyLu2L53wUy4g>
    <xme:iuKnabsnibACEKRSPIF94tdV_kmmqnNAySYHif79sCuvQi54CIwcLvgxBOUqar78B
    fGUUXNgt8Cd9AaQtsqIAV0hJ9JNL_uDuhz7yr-9ETqUGwbSfLMP8g>
X-ME-Received: <xmr:iuKnafv0-WKhgJxUDQhXo6FPnPRJNja5bbliJro_7CGhKo8b_fdcjJ7XrfBRVZFHVXN4AM4IczOUMfu4g5na7MtODs8aU-xWcQxpoH-8F21ypw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhthhhusgesphgruhhl
    ihhsrghgvggvkhdrtghomh
X-ME-Proxy: <xmx:iuKnaYNUtSDuVQGVq3bOBNE6PPfyp551cZds7HDBPboYypV-JKfIkg>
    <xmx:iuKnaV0pSMSkGxGGeXStAXkRigYacRac6n76VVdXcucqj4PVNAhuxQ>
    <xmx:iuKnacOrMDoFVpWsVVwqWPWuO4VGU0K9KXdw4go4nrYNJXs4vPoGTw>
    <xmx:iuKnad1doWByn77BHGnZ9LluYzxGz2c3BQy_nSWmdPSMuYMsusO5AQ>
    <xmx:iuKnaeIgfk8GO7erddMnFJagA7OZTPU1nLblSojtjf3-RxFqGFgleyvo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 02:43:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1bfec270 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Mar 2026 07:43:05 +0000 (UTC)
Date: Wed, 4 Mar 2026 08:43:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v7 06/10] fsmonitor: deduplicate settings logic for Unix
 platforms
Message-ID: <aafihm4MVoVOaD2l@pks.im>
References: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
 <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
 <0a83bb9c8e71f6c388a50eb62afd03680020eb94.1772065643.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a83bb9c8e71f6c388a50eb62afd03680020eb94.1772065643.git.gitgitgadget@gmail.com>

On Thu, Feb 26, 2026 at 12:27:19AM +0000, Paul Tarjan via GitGitGadget wrote:
> diff --git a/Makefile b/Makefile
> index 7480ce3e1d..062347997a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2365,15 +2365,11 @@ ifdef FSMONITOR_DAEMON_BACKEND
>  	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
>  	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
>  	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
> -ifeq ($(FSMONITOR_DAEMON_BACKEND),win32)
> -	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-win32.o
> -else
> -	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-unix.o
> -endif
>  endif
>  
>  ifdef FSMONITOR_OS_SETTINGS
>  	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
> +	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_OS_SETTINGS).o
>  	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
>  	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_DAEMON_BACKEND).o
>  endif

It's a bit weird that the only change to the Makefile here is to change
how we wire up fsm-ipc even though it's fsm-settings that this commit
cares about. Should this change be moved into the preceding commit?

> diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-unix.c
> similarity index 82%
> rename from compat/fsmonitor/fsm-settings-darwin.c
> rename to compat/fsmonitor/fsm-settings-unix.c
> index a382590635..27d89207af 100644
> --- a/compat/fsmonitor/fsm-settings-darwin.c
> +++ b/compat/fsmonitor/fsm-settings-unix.c
> @@ -5,7 +5,7 @@
>  #include "fsmonitor-settings.h"
>  #include "fsmonitor-path-utils.h"
>  
> - /*
> +/*
>   * For the builtin FSMonitor, we create the Unix domain socket for the
>   * IPC in the .git directory.  If the working directory is remote,
>   * then the socket will be created on the remote file system.  This
> @@ -22,25 +22,31 @@
>   * The builtin FSMonitor uses a Unix domain socket in the .git
>   * directory for IPC.  These Windows drive formats do not support
>   * Unix domain sockets, so mark them as incompatible for the daemon.
> - *
>   */
>  static enum fsmonitor_reason check_uds_volume(struct repository *r)
>  {
>  	struct fs_info fs;
>  	const char *ipc_path = fsmonitor_ipc__get_path(r);
> -	struct strbuf path = STRBUF_INIT;
> -	strbuf_add(&path, ipc_path, strlen(ipc_path));
> +	char *path;
> +	char *dir;
> +
> +	/*
> +	 * Create a copy for dirname() since it may modify its argument.
> +	 */
> +	path = xstrdup(ipc_path);
> +	dir = dirname(path);
>  
> -	if (fsmonitor__get_fs_info(dirname(path.buf), &fs) == -1) {
> -		strbuf_release(&path);
> +	if (fsmonitor__get_fs_info(dir, &fs) == -1) {
> +		free(path);
>  		return FSMONITOR_REASON_ERROR;
>  	}
>  
> -	strbuf_release(&path);
> +	free(path);
>  
>  	if (fs.is_remote ||
> -		!strcmp(fs.typename, "msdos") ||
> -		!strcmp(fs.typename, "ntfs")) {
> +	    !strcmp(fs.typename, "msdos") ||
> +	    !strcmp(fs.typename, "ntfs") ||
> +	    !strcmp(fs.typename, "vfat")) {
>  		free(fs.typename);
>  		return FSMONITOR_REASON_NOSOCKETS;
>  	}

Same here, it's not clear to me where those while-at-it changes are
coming from and whether we need them here. I'd rather drop them.

> diff --git a/meson.build b/meson.build
> index 8de795f9d4..589624f399 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1320,10 +1320,13 @@ else
>  endif
>  
>  fsmonitor_backend = ''
> +fsmonitor_os = ''
>  if host_machine.system() == 'windows'
>    fsmonitor_backend = 'win32'
> +  fsmonitor_os = 'win32'
>  elif host_machine.system() == 'darwin'
>    fsmonitor_backend = 'darwin'
> +  fsmonitor_os = 'unix'
>    libgit_dependencies += dependency('CoreServices')
>  endif
>  if fsmonitor_backend != ''

I think it might make sense to introduce the `fsmonitor_os` variable in
the preceding commit already. If so...

> @@ -1334,17 +1337,12 @@ if fsmonitor_backend != ''
>      'compat/fsmonitor/fsm-health-' + fsmonitor_backend + '.c',
>      'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
>      'compat/fsmonitor/fsm-path-utils-' + fsmonitor_backend + '.c',
> -    'compat/fsmonitor/fsm-settings-' + fsmonitor_backend + '.c',
> +    'compat/fsmonitor/fsm-ipc-' + fsmonitor_os + '.c',
> +    'compat/fsmonitor/fsm-settings-' + fsmonitor_os + '.c',
>    ]
> -
> -  if fsmonitor_backend == 'win32'
> -    libgit_sources += 'compat/fsmonitor/fsm-ipc-win32.c'
> -  else
> -    libgit_sources += 'compat/fsmonitor/fsm-ipc-unix.c'
> -  endif
>  endif

We could avoid the flip-flopping of the code here.

Patrick
