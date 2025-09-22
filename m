Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20A127A465
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 21:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758577630; cv=none; b=TBXjZ/gxpLX+o45DUwg7thhyZn4Laqd8xsoGOP3MhjNrBXrbRhwfr+r7FtDt6d2e89x1fyqulG9yi6/WReoSw1hez5pAb/GnUePRofStSmI1XiacefO89F02cL6EAoCY9Iewp8PCybKWZVyVHJ+8pMU+BqzPJ15Hndd6JRwaT8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758577630; c=relaxed/simple;
	bh=jPxo40Lz0ce4a/4KJ2DxLLYVFBmrz0ST7jBYT8KMl80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fq6C1c47fl297ybbkpHhxA5AzucD3Hds9SGF6RW3nd9dVNqw9hlUzLfGR55sXSjuT1t9no3evrofosgazDtijRjK8tFBGZXAtbJidAEGNA1riTzLWJrB8e1YEVaPK/Pbk6Mr7zvGY/TtzTeDr1kuUut/NY50G3vW9Bv6VCHFdu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id ADE2B3410A2;
	Mon, 22 Sep 2025 21:47:05 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Michael Orlitzky <michael@orlitzky.com>,  ezekielnewren@gmail.com,
  20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im,
  Johannes.Schindelin@gmx.de,  ben.knoble@gmail.com,  cb@256bit.org,
  collin.funk1@gmail.com,  contact@hacktivis.me,  eschwartz@gentoo.org,
  git@vger.kernel.org,  gitster@pobox.com,  me@ttaylorr.com,
  newren@gmail.com,  phillip.wood123@gmail.com,
  pierre-emmanuel.patry@embecosm.com,  ps@pks.im
Subject: Re: [PATCH RFC 0/3] Introduce Rust and announce that it will become
 mandatorty
In-Reply-To: <aNHBIHXYPmS5AvpP@fruit.crustytoothpaste.net>
Organization: Gentoo
References: <CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com>
	<20250922155949.27019-1-michael@orlitzky.com>
	<aNHBIHXYPmS5AvpP@fruit.crustytoothpaste.net>
User-Agent: mu4e 1.12.12; emacs 31.0.50
Date: Mon, 22 Sep 2025 22:47:03 +0100
Message-ID: <878qi66tyg.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-09-22 at 15:59:49, Michael Orlitzky wrote:
>> There is no problem with supporting rust on Gentoo. Gentoo users build
>> from source, and rust is a problem for anyone who builds from
>> source. I'm writing this on a riscv/musl system. If there are no
>> binaries for your CPU/libc, let me tell you, it's not fun. And this is
>> like, my job. A normal person would be completely helpless.
>
> This is a problem with languages that bootstrap from earlier versions of
> themselves.  It also happens with other, less common languages.  GHC (a
> Haskell runtime) also has this problem and any distro that ships pandoc
> has to deal with it.

Usually there's nothing too critical in such a language ;)

>
> It is certainly inconvenient, but there is mrustc to help the bootstrap
> process.  Granted, it does not work everywhere yet, but it should also
> not be too difficult to make it do so.
>
> I do think the difficulty is worth it, though.  With Rust, we're going
> to get code that is thread-safe and memory-safe by the virtue of the
> fact that it compiles and that will allow us to have threading in more
> parts of the code where it might benefit us.  I also cannot tell you how
> many segfaults and null pointer dereferences I've written in Git (some
> in the past week) that are just no longer possible with Rust.
>
> As my proposal originally mentioned, there is enormous pressure from
> governments, security professionals, and large companies to improve
> memory safety, which I believe are legitimate concerns.  If we want Git
> to continue to be used widely, then we need to address those issues and
> Rust seems to be the best possible way to do that.  I don't think
> continuing in C only is going to be viable long term.
>
>> Nevertheless, the arch support issues are secondary. I'm sure it's a
>> lot of fun for the people who are writing rust code to do cargo
>> updates in the two or three directories they work in all day. But I'm
>> not writing rust code, don't care what language git is written in, and
>> have hundreds of other packages to keep up-to-date on multiple
>> machines. I want to be able to use my package manager to do that
>> efficiently. You know, the main tangible benefit of using a linux
>> distribution.
>
> I don't think this is going to happen as you anticipate it will.  My
> original policy was to target Debian stable's release for a year after
> the new Debian stable came out and that will make using many crates
> nearly impossible.  We are going to have to be _extremely_ careful about
> dependencies in general and the things we are likely to use are things
> like bindgen and cbindgen, where typically an old version will work just
> fine and which are already packaged in major distros.  We are not going
> to be adding dependencies willy-nilly and running `cargo update` every
> other day.

That brings me significant comfort and I'm glad to hear it. I hope
others agree with your position on having significant restraint on the
use of external crates.

git has always been quite good about dependencies pre-Rust.

>
>> But every distribution is "packaging" rust the same way. They're
>> bundling random old versions of crates in violation of their own
>> policies because the ecosystem is unstable and the tooling encourages
>> tight coupling. By requiring rust, you are require me to go back to
>> managing dependencies like I'm on Windows XP again. Git is the most
>> important program I use, but it's not more important than package
>> management itself.
>
> I expect Debian already packages the crates that we need in acceptable
> versions, and I assume other distros do as well, so I don't anticipate
> this being a problem for us.

Yes, I expect on our end in Gentoo, that we'll probably need to use this
to finally migrate to a Debian-style handling of crates, though that's
not your problem.
