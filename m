Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37DD1DFD99
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738171305; cv=none; b=HKjHToRAuzjvs/X40fNnh4+swf4+R5cQ+PS/xaqK0TPgC/mBD99zwweCwyF7iq6+K2351nR+IrHlKX3OIK5q2oSBmq8P36hvDD3R/qFhBT7kr7zi4BU5KvIkMvxBy3lBQQ97L5OcYUTGm3ANTvlivoXpsIfwdWY7zbbbUqdZvnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738171305; c=relaxed/simple;
	bh=oFvQXNjOgdD1kNnxX7+evHLP+OZFizjhu5tPaBOIqPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aRBFlrnSeCitsUEHO935hzQaLerqCy1/PRTLzjWKwQN9wBtPwNtXBnNZfGtVVTjVOniqUvnk4WK2OuE4Hp6LHA6LoVsouMKAsV6mwPRBpPDDz7yLJZz01F57q05EOB8/lxflI2bfl7Ohu8VoF7u0WUlbf9dcWyn9YbpM1IwqK+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lt9bUFAk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0xQC/rAX; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lt9bUFAk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0xQC/rAX"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DE90E1140101;
	Wed, 29 Jan 2025 12:21:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 29 Jan 2025 12:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738171301; x=1738257701; bh=hnAmirygPx
	UbgLvQvRaqPNIr1f8Sy+uXiZ+daQWTpgQ=; b=Lt9bUFAkbfwGM56Yj0lCzut25k
	1TdpOBd2O0yRonOs7osLQQStHWtL3AHCZE9N9FxHLhCmmeaJUXUzB/zJsBEKufCp
	QXrH5xoAV0lDukppxvwmpDmkWHHDirEdBUXz9l6VtwtbgfKgmoyxFt1+9slgnnB5
	L9plTrraXDJKVf5BUaJi0zmEM9Alwj8wkceVbJnXrs4zyVZsg0zUn0yiRe1OjJ3W
	XiEV4MkNKCQxNzM+VOL/l5u+2z2WuxcuTwtyEAZ300BcCzQA+BgfPDAkMXF3uvYo
	sGTDVi/RpoTsVf+7iohFajkbFIkT92Tc4k9FVhHBXUxAqdSnU4Ddi0vhe4ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738171301; x=1738257701; bh=hnAmirygPxUbgLvQvRaqPNIr1f8Sy+uXiZ+
	daQWTpgQ=; b=0xQC/rAXY15X+p0oycqByfDEmRF733p7QsHgXpR4S2G+UlTD+ct
	vGSDlbfKORixh1qWOAy68NnoArBozEvEa5QSBoyqQMn1ZO96jdgADDaU75LgSwuy
	iXJhgfmqcUOwl9TKd0C3WC2HO2RGbEKly7lyKexdB38Z9Zp0LVm4tjSRHing1vvU
	DVImibJS7TXGFo1iu6F0Z+Q9JSfzu8Jw1HLkzzMsyKWGyGfWkabW/FD6HLWUBs6u
	cvpuwTKr3v/VXHxPr1yO6lSlj2fR0PIUwSAnBatSNAR9a4ItjA2ck9Hr68LQF4pR
	YUfKRMaCM80Mc/KG62gMXCiYFzA+p4sn2ew==
X-ME-Sender: <xms:pWOaZzD70379sf3qUrxa7MllyTa2Kq1KT1biVYqzGHnIrxA3MM5wQQ>
    <xme:pWOaZ5gvJezU0EScJYBMSfuHdYcp3ydT4f5ko1XH5jGpffSvHtMEIXBE0gPo59DrL
    NenisvjeFXo2FJh0A>
X-ME-Received: <xmr:pWOaZ-krGJwD1c521g72I0eQZ96yorMqx2mbbiKgUGUCCGGHY6i4yV0XiwtYBb4Fwb0LhK87pJkT9qPbh6bdHsf-vajDhL4UXQfx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pWOaZ1x0bfsez7d6zQz6VgBdFSECRrFIX-CiQOn5Q8P3qDbAK7TYgA>
    <xmx:pWOaZ4T3OK2kWLm3P1pgD7sV0WgAqkJU23zlo1Akp3QcyN1sKIKoWA>
    <xmx:pWOaZ4aXOBZF_jP9XPDFVGpCpkKgNjFZYy9nu7_Ues5bnP69BSqcYQ>
    <xmx:pWOaZ5R5YKSYFSJ_J-Sfc0V33XRcDJ_MikFdMgHEA97peuDHhmp79A>
    <xmx:pWOaZ-cnbgmLCF91N2lPQh7qyYOBhbenhCi0RXwtT6kRbKLCO4Gh9ANK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 12:21:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] unix-socket: fix memory leak when chdir(3p) fails
In-Reply-To: <20250129-b4-pks-memory-leaks-v1-1-79e41299eb0c@pks.im> (Patrick
	Steinhardt's message of "Wed, 29 Jan 2025 17:24:14 +0100")
References: <20250129-b4-pks-memory-leaks-v1-0-79e41299eb0c@pks.im>
	<20250129-b4-pks-memory-leaks-v1-1-79e41299eb0c@pks.im>
Date: Wed, 29 Jan 2025 09:21:39 -0800
Message-ID: <xmqq34h1k02k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When trying to create a Unix socket in a path that exceeds the maximum
> socket name length we try to first change the directory into the parent
> folder before creating the socket to reduce the length of the name. When
> this fails we error out of `unix_sockaddr_init()` with an error code,
> which indicates to the caller that the context has not been initialized.
> Consequently, they don't release that context.
>
> This leads to a memory leak: when we have already populated the context
> with the original directory that we need to chdir(3p) back into, but
> then the chdir(3p) into the socket's parent directory fails, then we
> won't release the original directory's path. The leak is exposed by
> t0301, but only via Meson with `meson setup -Dsanitize=leak`:

Did you mean

    $ meson configure -Db_sanitize=leak
    $ meson test t0301-credential-cache

I'll need to figure out how to make various tweaks at runtime
working with meson based build tree.  The next thing I need to
figure out is to see how to get verbose error output from the tests,
as I cannot just go back to the source tree and say "cd t && sh
t0301-credential-cache -v -i -x" because the build is out of tree.

>     Direct leak of 129 byte(s) in 1 object(s) allocated from:
>         #0 0x5555555e85c6 in realloc.part.0 lsan_interceptors.cpp.o
>         #1 0x55555590e3d6 in xrealloc ../wrapper.c:140:8
>         #2 0x5555558c8fc6 in strbuf_grow ../strbuf.c:114:2
>         #3 0x5555558cacab in strbuf_getcwd ../strbuf.c:605:3
>         #4 0x555555923ff6 in unix_sockaddr_init ../unix-socket.c:65:7
>         #5 0x555555923e42 in unix_stream_connect ../unix-socket.c:84:6
>         #6 0x55555562a984 in send_request ../builtin/credential-cache.c:46:11
>         #7 0x55555562a89e in do_cache ../builtin/credential-cache.c:108:6
>         #8 0x55555562a655 in cmd_credential_cache ../builtin/credential-cache.c:178:3
>         #9 0x555555700547 in run_builtin ../git.c:480:11
>         #10 0x5555556ff0e0 in handle_builtin ../git.c:740:9
>         #11 0x5555556ffee8 in run_argv ../git.c:807:4
>         #12 0x5555556fee6b in cmd_main ../git.c:947:19
>         #13 0x55555593f689 in main ../common-main.c:64:11
>         #14 0x7ffff7a2a1fb in __libc_start_call_main (/nix/store/h7zcxabfxa7v5xdna45y2hplj31ncf8a-glibc-2.40-36/lib/libc.so.6+0x2a1fb) (BuildId: 0a855678aa0cb573cecbb2bcc73ab8239ec472d0)
>         #15 0x7ffff7a2a2b8 in __libc_start_main@GLIBC_2.2.5 (/nix/store/h7zcxabfxa7v5xdna45y2hplj31ncf8a-glibc-2.40-36/lib/libc.so.6+0x2a2b8) (BuildId: 0a855678aa0cb573cecbb2bcc73ab8239ec472d0)
>         #16 0x5555555ad1d4 in _start (git+0x591d4)
>
>     DEDUP_TOKEN: ___interceptor_realloc.part.0--xrealloc--strbuf_grow--strbuf_getcwd--unix_sockaddr_init--unix_stream_connect--send_request--do_cache--cmd_credential_cache--run_builtin--handle_builtin--run_argv--cmd_main--main--__libc_start_call_main--__libc_start_main@GLIBC_2.2.5--_start
>     SUMMARY: LeakSanitizer: 129 byte(s) leaked in 1 allocation(s).
>
> Fix this leak.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  unix-socket.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thanks.  The analysis and the fix looked superbly clear.

Will queue.

> diff --git a/unix-socket.c b/unix-socket.c
> index 483c9c448c..8860203c3f 100644
> --- a/unix-socket.c
> +++ b/unix-socket.c
> @@ -65,8 +65,10 @@ static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
>  		if (strbuf_getcwd(&cwd))
>  			return -1;
>  		ctx->orig_dir = strbuf_detach(&cwd, NULL);
> -		if (chdir_len(dir, slash - dir) < 0)
> +		if (chdir_len(dir, slash - dir) < 0) {
> +			FREE_AND_NULL(ctx->orig_dir);
>  			return -1;
> +		}
>  	}
>  
>  	memset(sa, 0, sizeof(*sa));
