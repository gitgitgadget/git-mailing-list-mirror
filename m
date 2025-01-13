Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B76D14373F
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736765423; cv=none; b=lllc0K2DV77C+9Lh0ZyRQ/CetpupAZRASCgPouFtP9CsHw32gXQhJRHUagYK+08dfUraCcN+KedO5IEgNv3Y83EbHcqI1FjbSsgQIMRKkVdsv1L7lkLXk8r4jQanzBeVjtU109pzYnnTShjKPRqJ54or5dIrkov7NzF7Qkp23tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736765423; c=relaxed/simple;
	bh=cxnKzsaQNSjfqYwRohXIa/KitfTy6YNsFeJ+CWIl3GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxkKHJu+SNZmVl0TbXDgXrzSYZTF6bqiV8WPb2GV+KV3I+vf4NaxpfZD9hcrIUeOZreEtL+Vc4tVf1h89Bgr8+GMsmKNGuG1Iz8rBaSQ3xmzUI9I7jSNwU66Be5h5PZn+EwJMsSmncC9vPKsK0XHy9bt9zWDUmH0tS9+pJ6ms7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b+QKSM1u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pa05dGjx; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b+QKSM1u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pa05dGjx"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 089B525401A6;
	Mon, 13 Jan 2025 05:50:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 13 Jan 2025 05:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736765417; x=1736851817; bh=WxzTQ3RTat
	vt+U5KhAq4VW2yPe7DohJp0rYodgF2uCY=; b=b+QKSM1uivQfiQ/bc7sEKNA/Rj
	7qLREUnUy9fPqjihTG8AcEXF81mLKURmpMjnAOE7cHs1R2QKGyo+v8vLVHEygO0v
	OIZfZzoPY641nfp4wCu1a3kcgJml0vRuHqDQY33dclttxJtJ+YJ9l1EF6bmuzklR
	GMuccx0fLkfWFk+M9h+jslYF9ebcSjEZ7MT7MrPD3212sRLzR2CA1W4mGoZCgLmY
	7sSxSZpdiJzrvJecTzOwcYF9HatYs7ZIhXUMHFeMqMFIglhnEyz1F0bucC2PutSS
	GiTun6O/e0F8SLWvBH/VQgFiG+5OsmXCDPBsLCjovj6hiXOPTMQBN4N2HtAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736765417; x=1736851817; bh=WxzTQ3RTatvt+U5KhAq4VW2yPe7DohJp0rY
	odgF2uCY=; b=Pa05dGjxYLjAOJ9ZfENLhTpzbXtfLbPSUAs7DvyEUcKqs7eX4u4
	GOIah5s5RlxSKBwdfeG7ZXtatMPB2FZW/H6np+wDpAbZ6s4yb/r38cftlC8vC8Cb
	nyUpxiUIV8LBNKTkI88f0AycGnQ7Poz15SnQxpdW/4rRQmN6VORZCJg7AXXNSnUr
	d3Lj91rAEYWJT6Zp+lt60JqLqNxC+oRIUy14gKi9AekrXGMrYxySqIQQ7Qukp44x
	J8rECUo4j+GigtLfldG5r/sAHfWXSdsj8AMOYl/fNshGF65ObtYIuVgoirGj5H2s
	/ejRfMiaRGVJB5CYdcIbckQMNjwYp8NE2RA==
X-ME-Sender: <xms:6e-EZ_TyPstjVEGFKY-K3ueQLxhYZHOpvE_hxtU2x5-rwIh5g6wgJg>
    <xme:6e-EZwzG-vCShDhYUT805V7reoKlNkC6znNtCLvwgbEThtgYVdGLUpJtXr-n6pikq
    nj8T32MtejV21X_pg>
X-ME-Received: <xmr:6e-EZ01zJdsYWq116UwsWlUUN8ooB2uzksg7PxDyWo16TS5W7GpphwkPy1jBpCMr9H-MtUwa4j5M0I3PY-u8zc91qIniX2CXaGgPVKSmf1Uhe6Gj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6e-EZ_CxaEp4wDzJsoo5PuLpiZT_kzEyF91sOOpHsuAqHIzKGzvJDA>
    <xmx:6e-EZ4gn9SMD2TUSd57G7eDz9F_wBwR9z2ZDu1xFabqWJsRlboXkgA>
    <xmx:6e-EZzqhLHM1bEgt0A_YsO20yAUfaS5m7gviwfmi6ncwxyt34yA2DQ>
    <xmx:6e-EZzhT8IK0-oFA9CtgfckK7aLFD5attAygE7UjuwTZ38Lnq1doTw>
    <xmx:6e-EZ7udmtGMmkqxsIwpAS7GcKIRF1V6dlOCnyFsgoct7im92uwRtP8Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 05:50:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dc7f82a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 10:50:14 +0000 (UTC)
Date: Mon, 13 Jan 2025 11:50:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] meson: ensure correct version-def.h is used
Message-ID: <Z4Tv37SXzKrPwd_M@pks.im>
References: <20250113-toon-fix-meson-version-v1-1-9637e2be32e3@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-toon-fix-meson-version-v1-1-9637e2be32e3@iotcl.com>

On Mon, Jan 13, 2025 at 11:28:04AM +0100, Toon Claes wrote:
> To build the libgit-version library, Meson first generates
> `version-def.h` in the build directory. Then it compiles `version.c`
> into a library. During compilation, Meson tells to include both the
> build directory and the project root directory.
> 
> However, when the user previously has compiled Git using Make, they will
> have a `version-def.h` file in project root directory as well. Because
> `version-def.h` is included in `version.c` using the #include directive
> with double quotes, some compilers will look for the header file in the
> same directory as the source file. This will cause compilation of
> `version.c` ran by Meson to include `version-def.h` previously made by
> Make, which might be out of date.

Makes sense.

> Copy `version.c` to the build directory before compiling it to ensure
> `version-def.h` from the build directory is used.

I was wondering whether there were other solutions that are a bit
less intricate. One was to include <version-def.h> instead and then play
around with include directories, but that feels even more fragile than
the proposed solution.

Another alternative would be to inject the full path to the generated
header file. For example something like this:

diff --git a/meson.build b/meson.build
index 3e31648dc1..dbe6e7651f 100644
--- a/meson.build
+++ b/meson.build
@@ -1543,7 +1543,9 @@ libgit_version_library = static_library('git-version',
     'version.c',
     version_def_h,
   ],
-  c_args: libgit_c_args,
+  c_args: libgit_c_args + [
+    '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
+  ],
   dependencies: libgit_dependencies,
   include_directories: libgit_include_directories,
 )
diff --git a/version.c b/version.c
index 4d763ab48d..4786c4e0a5 100644
--- a/version.c
+++ b/version.c
@@ -1,8 +1,13 @@
 #include "git-compat-util.h"
 #include "version.h"
-#include "version-def.h"
 #include "strbuf.h"
 
+#ifndef GIT_VERSION_H
+# include "version-def.h"
+#else
+# include GIT_VERSION_H
+#endif
+
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;

This feels least fragile and isn't adding a lot of complexity, either.

> diff --git a/meson.build b/meson.build
> index 0064eb64f546a6349a8694ce251bd352febda6fe..8ecb22c80e4fc3f194e97c14dbf83f541d72b25b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1486,11 +1486,15 @@ version_def_h = custom_target(
>    env: version_gen_environment,
>  )
>  
> +# Because most compilers prefer header files in the same directory as the source
> +# file, copy version.c to the build directory.
> +version_c = fs.copyfile(meson.current_source_dir() / 'version.c', 'version.c')

Unfortunately, `fs.copyfile()` is not supported in Meson v0.61 yet,
which is our minimum required version of Meson. You can use a custom
target with cp(1) though. I have a patch series pending that starts to
generate errors in our CI when warnings are printed to catch such issues
going forward.

Patrick
