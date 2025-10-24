Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8900B262FE7
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761287852; cv=none; b=GK0jQ1ciEMozi2vLiErAgHWSrRTH8cWYcP2A0m1OZewD49B/D66dLdfJAIhs4D2ag/IlXMU28DYbG+lXA+f0JZak3F5X3C0pncd3G3G7gVOZsVlJ4VeXfcmJHMU6R1a/F+35PIw1Njn2iV4+ZeAsG/WxyS3b+ESHQfiK82rRJjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761287852; c=relaxed/simple;
	bh=TxqOzhcBFI5cGI6SNTL3HGIlvsjAWNCa6XOjbLwti8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5V04aHfVvyuHErtn0aOWSOkS3uwpcgQr6LED/XOxOSlsSVlgMtdxHMtOA1b/2MmHbxeQ7RNyO9603jp7FNTzJ+nDhrl4+MBdk6EW3JUP/MBUOxnUIx8Ne5FKqPF6Z1ug+L4lwumYCw7R+Pql780oBNl/a1d9uxBCUkUgNwciyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f/zeNv9W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WawbR4A7; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f/zeNv9W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WawbR4A7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B7996EC0271;
	Fri, 24 Oct 2025 02:37:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 24 Oct 2025 02:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761287849;
	 x=1761374249; bh=jPzow6lCtkSD0ZDD2+ple/CVCHCKzoTGl7UobBeUWUI=; b=
	f/zeNv9WDjEe319Xg6+wdh/KnMDzF2u0R+qqYdl/Pcp13/VAyJsykgyxGPIpA86E
	M+uXQQ8bhbkuRu+44a0b63FGqw3cS1Kdet4+Xog644EirYKarv0Yn+/x29w4Alsd
	ktZzA4L46pWX6bDFGw8ZU3NZKbcOImb7SRmEf8bREIhwXkWjead5rnuuHMcVj9ej
	3oqqQNFoD6RQD1z7lug+V9XiMqOeTbWF2MdguCivpnW9Fi0L5JEyUy5AO182j8Af
	UeswecO2kqcGbQLg52wDWtImpTTa+uzF+epgiPvhcAwOj+diFp8kFQy8d6eZVuD8
	zavVAu9C82i8N3AZLPNdzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761287849; x=
	1761374249; bh=jPzow6lCtkSD0ZDD2+ple/CVCHCKzoTGl7UobBeUWUI=; b=W
	awbR4A7VA0NcuDqw8BDEBe5+iraFoQ5fqGgDbNpcGrNSFTFdMIeL69cGkSuUIaEQ
	HNULKQMJHlIS2I9c/IVsys/VjxUzvKdPAew53HrJ4XY4mUQu/qsT2nUKy29oPfQK
	deK3qSEFlo5pvOa+U6flBzEC5LNhYCep1A2gyQpL7zrynacpuTrP7NzB4T6RTb31
	BxkG7N5gqf2ghnGHGim4fkYhYoGQl2jticgAQwHWqpbIY28w51mbqHnQuQ+iRTsl
	aWpZmLw/RcdBx5dti90TSvMhNTueU++08UEi/jwsTfGYBHBU0XQd/r+sarSI56Xo
	a1GH+B9Z1KLh6aiQd4PsQ==
X-ME-Sender: <xms:qR77aIWqzVk6HNV1TGhoB0r9QsBBjLGtjgX0KeGnpkpfmbpo08UkvQ>
    <xme:qR77aP0g38CkpWellTdZJ0ZwfliTqEn1wYE53gUMtpJwzbYpevpHK6CE2n8_9xTR_
    3d64jq-Ardf3qPpQuOXE_jt-bxh3jScC9SCGRGQxFvUlPckq962>
X-ME-Received: <xmr:qR77aF3dqk4O8-NT5eqxyGkl_tddQFeA5qpJp65H2wofYi9vY9fXgJwyyRoNtxRPeYoUjwHCtrs8uZx9FGNi4qT1faIx_u3Utdd_TplPWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepvgiivghk
    ihgvlhhnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:qR77aC9KvyPxP1GWFkMfYFQYfjr0NtAiYxTZbPQRnW-p4sLbbWMvkQ>
    <xmx:qR77aC1R_kTWKLdsISB8TJkziTULVFQoBLNtMUB-4hR7sXb74wsaZw>
    <xmx:qR77aP8HhibCqxJccswwLC229xIs_QvsiYd_ebbVkwsxTQCbugbNgw>
    <xmx:qR77aCtCg7btcIzYH6wgUKvaNJ1QjcMkRzeZNpTfeG4Xt8F2Nhc2Iw>
    <xmx:qR77aJWYgMrIeuTy8Nq5s67krsg2GViboY4qmaSium538AqDLaKKOt5U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 02:37:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id db3ba2ad (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 06:37:27 +0000 (UTC)
Date: Fri, 24 Oct 2025 08:37:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 3/3] rust: generate bindings via cbindgen
Message-ID: <aPsepOtUf92fqDL-@pks.im>
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
 <20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im>
 <CAH=ZcbADTLvTioBf+LYQej1G0biZM8s3-iJG+BZjnpxj+8NjsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH=ZcbADTLvTioBf+LYQej1G0biZM8s3-iJG+BZjnpxj+8NjsA@mail.gmail.com>

On Thu, Oct 23, 2025 at 12:00:21PM -0600, Ezekiel Newren wrote:
> On Thu, Oct 23, 2025 at 1:17 AM Patrick Steinhardt <ps@pks.im> wrote:
> > +C_BINDINGS = c-bindings.h
> > +
> > +GENERATED_H += $(C_BINDINGS)
> > +
> > +$(C_BINDINGS): cbindgen.toml $(RUST_SOURCES)
> > +       $(QUIET_CBINDGEN)cbindgen --output $@
> > +
> 
> My preference is to store all generated header files from cbindgen
> under interop/ that way we don't pollute the root of Git. It also
> makes ignoring generated header files easier (if we choose to) since
> we'd only need to specify `/interop/` in .gitignore.

It's (unfortunately) common practice to generate headers all over the
place in Git. So I'd propose that until we grow a second interop header
we keep it in the root hierarchy.

The proper fix for this in my opinion is out-of-tree builds. In Meson
for example we don't have to worry about this issue at all. If we wanted
to fix this more broadly for our Makefile, as well, I'd propose to
instead introduce a "generated/" directory and move all of our generated
headers into it.

> For platforms that can't compile Rust how are they going to build C if
> they depend on those generated headers?

For now they don't have to care about this, as the interop header is
only included in case we build with Rust support enabled.

> > diff --git a/cbindgen.toml b/cbindgen.toml
> > new file mode 100644
> > index 00000000000..ba4b2d63672
> > --- /dev/null
> > +++ b/cbindgen.toml
> > @@ -0,0 +1,7 @@
> > +language = "C"
> > +
> > +# Don't include standard C headers. These are managed by "git-compat-util.h".
> > +no_includes = true
> > +
> > +# Use plain structs instead of using typedefs.
> > +style = "tag"
> 
> This is what my cbindgen.toml file looked like.
>
> ```
> sys_includes = ["git-compat-util.h"]

Our headers generally don't include "git-compat-util.h". The rule is
that it should always be included first by our code files. So I think we
should stick to that rule for this generated file, as well.

> autogen_warning = "/* Warning, this file is autogenerated by cbindgen.
> Don't modify this manually. */"

Makes sense.

> language = "C"
> no_includes = true
> style = "tag"

Yup, also got these.

> usize_is_size_t = true

Ah, this feels like the right thing to do, agreed.

> tab_width = 4
> 
> tab_width is the number of spaces, there is no option to use a tab
> character in cbindgen.

Shouldn't this rather use 8 then to match our coding style better, even
if it's not a perfect match?

> [parse]
> parse_deps = false

This is the default according to cbindgen's documentation, so I'll not
include this line.

> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > index b7b3cf35edf..3bce6f47f87 100755
> > --- a/ci/install-dependencies.sh
> > +++ b/ci/install-dependencies.sh
> > @@ -37,7 +37,7 @@ fedora-*|almalinux-*)
> >                 MESON_DEPS="meson ninja";;
> >         esac
> >         dnf -yq update >/dev/null &&
> > -       dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS cargo >/dev/null
> > +       dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS cargo cbindgen >/dev/null
> >         ;;
> >  ubuntu-*|i386/debian-*|debian-*)
> >         # Required so that apt doesn't wait for user input on certain packages.
> > @@ -64,7 +64,7 @@ ubuntu-*|i386/debian-*|debian-*)
> >                 make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
> >                 tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
> >                 libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
> > -               libsecret-1-dev libpcre2-dev meson ninja-build pkg-config cargo \
> > +               libsecret-1-dev libpcre2-dev meson ninja-build pkg-config cargo cbindgen \
> >                 ${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
> 
> cbindgen is a Rust crate and it should be specified in the Cargo.toml
> under [build-dependencies] block.

What is the benefit for us? The generated code is not a dependency of
the Rust code, and neither do we use it via "build.rs". And if we use
cbindgen via "Cargo.toml" we'd be forced to build it first, which slows
down our CI jobs.

Please let me know in case I miss any reasons to have it in our build
dependencies instead.

> Also I think that we should convert from using a Cargo crate to using
> a Cargo workspace, so that we can generate multiple header files (1
> per crate) rather than a monolithic generated header. This is because
> cbindgen operates at the granularity of a crate.

I'm basically still punting this into the future. There is no good
reason yet to have workspaces, so I'd rather introduce them once we have
a better way to sell them and demonstrate their immediate benefits.

Patrick
