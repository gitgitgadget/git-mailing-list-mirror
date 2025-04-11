Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC2B29AAFD
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744366020; cv=none; b=KFvr7qSmJGZZEAWUjwrWtMR27PiRbqYw4If04Z3lUlHC5VuL+AEveqpdEAWoxrkt4Uu9UYWgrel6O45Kw7o32a2joX7wT186zk547TCFdWTG/005H/ZFWyRnBwCsB1QJ6MJEI3Hn4Q7ZrNKLIHOwM6nuzPxl11ybNjq5Cg4d58w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744366020; c=relaxed/simple;
	bh=LD9O0vRxWqgmJZfZfKNOf2PEBEPFs+kAUUJbR2fPvtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNKVCzX4PPV5tvKMWEcMgvAYc9HfcvS7Pg8RPDoRCx3vuEN/41EJJqAF2kTAFfTgtI5onTIYarwXK5PHBiBsPzNgz9lUcY7eOXRdbftpdIglfihpwqPCaRQnp6wVqNbctDRMUhSve7dsvr5D/N6FBEmKJtMOmh4FCNP74Xr08qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bwDaMW4w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SQACwTSB; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bwDaMW4w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SQACwTSB"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5642411402D1;
	Fri, 11 Apr 2025 06:06:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 11 Apr 2025 06:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744366017; x=1744452417; bh=r1cFlZ4PxW
	8UkBG/qsvFqaU7pLAt77Lkg/u/faz48l8=; b=bwDaMW4wTPfbVY/VPSWVLJGj75
	JeYxkhS4iY37u76oiTn/bkS2U8S+lHj5KiDDgRDx/8oGqJehEn/XXKTmTTyXjH7i
	7isGdvmz3ArpUSD3Ad/DXH3TXUAwsX1XmIIrQHoyxdiH6awV0rKhQOmBKqiMboXS
	yilHs3n2qZOfe63ZvFBK0lqITvD0mr442rtfYuXZ8YobFI3egJtF98nceWXT1W2p
	mFU6VGRmao/zFfyhWkV9Xb1F1ButGeBBp12/SYX02EBe5tHfL5mJl3QGh0q3ODoB
	pBF13XWThs0uIhVcP9El49WFha1Z0aFsexKWNxFNKOgwgF3e/NNzRnE0DhvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744366017; x=1744452417; bh=r1cFlZ4PxW8UkBG/qsvFqaU7pLAt77Lkg/u
	/faz48l8=; b=SQACwTSBr7nv0fW7qwoKTkzLzcBE/9rPmtTvJbBjPRm6biu0eF2
	lu0onD6IyKg4lgNKJE5Jp4pEL7Jy9MDxwcR6SmXueARZRlBgWoupg2akrueiujeL
	Z99yruxEbyvOk5xyAfgzw7sD1RhwlH7dKHlgrsx6sn/omTiwHUS4SgTgd3DP8dnI
	4MERhNBW4ILQ2HDOAwcQMzSH7UH3QSfoFTpxH7eQMJ+DGAL6BrrGFg1OaOUEq8In
	uwGiVVlhOMOFEy04MmH7VpZojyu1ojdBSR5ZfUbykUaf3tZfLMCTFmJlx5OLyPCq
	yDPTOpaNaZueidzP9TTbhV98DM9073qHw1g==
X-ME-Sender: <xms:wen4Z1YuisXbE4lJKEgrxsaIMMTSoi7lOySZKQU9BYwaeIK-8OcVdA>
    <xme:wen4Z8YatdRoLjJsnsOKblsFpp9Ew6eqBEcbLYHLk97xfJxYp3ieSAVOvQt6hbzPc
    XmLq5XuChq499WTfg>
X-ME-Received: <xmr:wen4Z3-iEqGumnoiRgvHd1PScP_MmVL-TCi6g5aMiszPunkq4gyeIc9dRj8RWdy7vt1MHgzv5hiFpOhTvoQTi3jU-9vFIrliFkdo2ym0zoc9evo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudduheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepleevgeegjeeukeeghffhhedvieehhedvvddtueff
    iedvheegleehueeiffdthfdunecuffhomhgrihhnpeiilhhisgdqtghomhhprghtrdhhth
    dpfhhigihtuhhrvghsrdhhthdpphhrihhnthdrhhhtpdhsuhhmmhgrrhihrdhhthenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:wen4Zzq25IYDg9LAecqD-kYRdcLzglKLcGque5aSbN6KlT1pM2FKGQ>
    <xmx:wen4Zwp31XAwxhMeZTpEr4NGAGgEbc91K9ip9yrZVq6fL9CfpT0JfA>
    <xmx:wen4Z5RH9b2KOKhQynSUBqMWF2xglWTi1Sc7OpKavVqoKi0EDoKUTQ>
    <xmx:wen4Z4oDzAbp8wCSz4ytcWSr5QQvNKTTFPfIVJ0MfC8sbNtOgKkbzQ>
    <xmx:wen4Z_13w360zL73ie4thb_oCDH-SCbisqq4j_caeNPmTwJTXgkqrITC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 06:06:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id efb31a39 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Apr 2025 10:06:56 +0000 (UTC)
Date: Fri, 11 Apr 2025 12:06:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, toon@iotcl.com
Subject: Re: [PATCH v2 3/4] meson: add support for 'hdr-check'
Message-ID: <Z_jpvghOGHvw2Y4x@pks.im>
References: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
 <20250410-505-wire-up-sparse-via-meson-v2-3-acb45cc8a2e5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-505-wire-up-sparse-via-meson-v2-3-acb45cc8a2e5@gmail.com>

On Thu, Apr 10, 2025 at 01:30:33PM +0200, Karthik Nayak wrote:
> The Makefile supports a target called 'hdr-check', which checks if
> individual header files can be independently compiled. Let's port this
> functionality to meson, our new build system too. The implementation

Nit: Meson is typically spelt with an upper-case 'M'.

> resembles that of the Makefile and provides the same check.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  meson.build | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 790d178007..6fce1aa618 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -655,6 +655,12 @@ if git.found()
>    endforeach
>  endif
>  
> +headers_generated = [
> +  'command-list.h',
> +  'config-list.h',
> +  'hook-list.h'
> +]
> +
>  if not get_option('breaking_changes')
>    builtin_sources += 'builtin/pack-redundant.c'
>  endif
> @@ -1995,6 +2001,107 @@ endif
>  
>  subdir('contrib')
>  
> +headers_check_exclude = headers_generated
> +headers_check_exclude += [
> +  'compat/apple-common-crypto.h',
> +  'compat/bswap.h',
> +  'compat/compiler.h',
> +  'compat/disk.h',
> +  'compat/fsmonitor/fsm-darwin-gcc.h',
> +  'compat/fsmonitor/fsm-health.h',
> +  'compat/fsmonitor/fsm-listen.h',
> +  'compat/mingw.h',
> +  'compat/msvc.h',
> +  'compat/nedmalloc/malloc.c.h',
> +  'compat/nedmalloc/nedmalloc.h',
> +  'compat/nonblock.h',
> +  'compat/obstack.h',
> +  'compat/poll/poll.h',
> +  'compat/precompose_utf8.h',
> +  'compat/regex/regex.h',
> +  'compat/regex/regex_internal.h',
> +  'compat/sha1-chunked.h',
> +  'compat/terminal.h',
> +  'compat/vcbuild/include/sys/param.h',
> +  'compat/vcbuild/include/sys/time.h',
> +  'compat/vcbuild/include/sys/utime.h',
> +  'compat/vcbuild/include/unistd.h',
> +  'compat/vcbuild/include/utime.h',
> +  'compat/win32.h',
> +  'compat/win32/alloca.h',
> +  'compat/win32/dirent.h',
> +  'compat/win32/lazyload.h',
> +  'compat/win32/path-utils.h',
> +  'compat/win32/pthread.h',
> +  'compat/win32/syslog.h',
> +  'compat/zlib-compat.h',
> +  't/unit-tests/clar/clar.h',
> +  't/unit-tests/clar/clar/fixtures.h',
> +  't/unit-tests/clar/clar/fs.h',
> +  't/unit-tests/clar/clar/print.h',
> +  't/unit-tests/clar/clar/sandbox.h',
> +  't/unit-tests/clar/clar/summary.h',
> +  't/unit-tests/clar/test/clar_test.h',
> +  'unicode-width.h',
> +  'xdiff/xdiff.h',
> +  'xdiff/xdiffi.h',
> +  'xdiff/xemit.h',
> +  'xdiff/xinclude.h',
> +  'xdiff/xmacros.h',
> +  'xdiff/xprepare.h',
> +  'xdiff/xtypes.h',
> +  'xdiff/xutils.h',
> +]

Many of these feel as if they should've been part of
`third_party_sources`.

> +if sha1_backend != 'openssl'
> +  headers_check_exclude += 'sha1/openssl.h'
> +endif
> +if sha256_backend != 'openssl'
> +  headers_check_exclude += 'sha256/openssl.h'
> +endif
> +if sha256_backend != 'nettle'
> +  headers_check_exclude += 'sha256/nettle.h'
> +endif
> +if sha256_backend != 'gcrpyt'
> +  headers_check_exclude += 'sha256/gcrypt.h'
> +endif
> +
> +if headers.length() != 0 and compiler.get_argument_syntax() == 'gcc'
> +  hco_targets = []
> +  foreach h : headers
> +    if headers_check_exclude.contains(h)
> +      continue
> +    endif
> +
> +    hcc = custom_target(
> +      input: h,
> +      output: h.underscorify() + 'cc',
> +      command: [
> +        shell,
> +        '-c',
> +        'echo \'#include "git-compat-util.h"\' > @OUTPUT@ && echo -n \'#include "' + h + '"\' >> @OUTPUT@'
> +      ]
> +    )
> +
> +    hco = custom_target(
> +      input: hcc,
> +      output: h.underscorify().replace('.h', '.hco'),

You can use `fs.replace_suffix()` instead of `.replace()`.

> +      command: [
> +        compiler.cmd_array(),
> +        libgit_c_args,
> +        '-I', meson.project_source_root(),
> +        '-I', meson.project_source_root() / 't/unit-tests',
> +        '-o', '/dev/null',
> +        '-c', '-xc',
> +        '@INPUT@'
> +      ]
> +    )
> +    hco_targets += hco
> +  endforeach
> +
> +  alias_target('hdr-check', hco_targets)
> +endif
> +
>  foreach key, value : {
>    'DIFF': diff.full_path(),
>    'GIT_SOURCE_DIR': meson.project_source_root(),

Patrick
