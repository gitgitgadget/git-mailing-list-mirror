Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1423E15FCE1
	for <git@vger.kernel.org>; Fri, 10 May 2024 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715334738; cv=none; b=e1dNQoTCAIhOaOI5Tma4w3Nq+biAOSgRCqr44f6HfZ94oMFo0ooqcAelJomO8+2OIwY5QktsqWPbswDCQsO8TIciiN3vowIXLFwWFDHJio0FqLVGs9MwsBa3qXdyQW7P68Nz53MVotvc4u0Rj1B5yKVvh6U6JJdc4mxlw+FryaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715334738; c=relaxed/simple;
	bh=4OkadkKNy4ibbpD6AAC3WJpC9QqAbkzbDnm4Ch1vECc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YPGmPlJcxAPAg/cWkGLyOP0BZGQ/uyemP5OSf0XfJpF/0oxvgZSahJJ6DYrVo+bnjPaDnyqgzuJY/zerlhfMhOIw3PIw067hferJP5b84WrcqkLmxqtk3oa0e33OwRmDeMeMld1MBd2ZjZ7jV9TVdCuRjyJ03qdPXWKVnnYngBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjjclKEv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjjclKEv"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41fc2f7fbb5so9447085e9.1
        for <git@vger.kernel.org>; Fri, 10 May 2024 02:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715334735; x=1715939535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UptE9qKaLjfE+ohj/kHQTQcL9aZzGblzgY76QP+O58E=;
        b=MjjclKEv52Zq2+GnYfFXEfQpRNrW+hncv+upLEzy364PoNoi112Od4FtNGeczan6ea
         tADGOMWhXe/cYns+b10qEuA+bYT1R7aZmiTPhpeDZT3g8TnKHEEILNbMgMjZvMicPm7f
         QgzYn232aIRRFVf6bclyG4wuEyXRQU6qfNV/Wl3N5/zoXGIpBSTG69f4T9k9KcCtGOig
         DwaJ3kjCfcKgchPR818pBgFJdEyv2Eys2UDxhUHINM13UuZhJpHpRFZNdqPNY+3QdG5D
         kQ4Dpr/0lvB7tt5b5aU5i6BmgD1NlItQarCyXDWrwxtkO0WxS505cR+rY2f0cvoa7hDO
         sulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715334735; x=1715939535;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UptE9qKaLjfE+ohj/kHQTQcL9aZzGblzgY76QP+O58E=;
        b=hlw6RruMtIa/dOunPT+VMj8OUACr0sFEIqyF/zw3hLexnJMtxLqexhgxWEZAKYVjNh
         7MtUUz9FnJOBjcbL/z+8JiWvr0h0BZtW1cyzZLtnl4Y5rOsZOphGwWtStP9QFrz245s7
         RxE2ljNQdj7EPoiq5DGygeIOzcdb4vMPcA+gpf6ckURYJW6R/z71ajO1pIKRJBUuelLw
         2fmQ7waZDx5t97iOD88nSTGKXm/9/ksUR6nNAjM1BwzjMf3TOJsusJmVqBoGyD6YpyuM
         AY66bj8PRLwShyMk9yCkKOsTH86bkPhIxyG6/X3FrKRiOck8eFte/bh70RpJ8DNHqF6c
         RcyA==
X-Gm-Message-State: AOJu0YwMe36ge0KczeWQGm4+AboLSs1FlvkxuSrBtKjffRnow89Lpqxf
	nsQVLBQ9cF0XCKuEauS1yKw2eyMahIbl8WFhsW9mdRTyk3YbqCrPm2h79Wfb
X-Google-Smtp-Source: AGHT+IFGCDYhGqTmI4Ptox3DETnymeDYD2c/911m+5f9m9BFX4+Kw00Hnw59wDKZqo6SHZxvFzTXdA==
X-Received: by 2002:a05:600c:1381:b0:41a:56b7:eb37 with SMTP id 5b1f17b1804b1-41fead61bc5mr16155995e9.20.1715334735141;
        Fri, 10 May 2024 02:52:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce7464sm58362635e9.23.2024.05.10.02.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 02:52:14 -0700 (PDT)
Message-ID: <12a4cd37-1cef-45a0-9b96-36a978e52dba@gmail.com>
Date: Fri, 10 May 2024 10:52:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [RFD] Libification proposal: separate internal and external
 interfaces
Reply-To: phillip.wood@dunelm.org.uk
To: Kyle Lippincott <spectral@google.com>, Calvin Wan <calvinwan@google.com>
Cc: Git Mailing List <git@vger.kernel.org>,
 "brian m. carlson" <sandals@crustytoothpaste.net>, rsbecker@nexbridge.com,
 phillip.wood@dunelm.org.uk, Josh Steadmon <steadmon@google.com>,
 Emily Shaffer <nasamuffin@google.com>, Enrico Mrass <emrass@google.com>
References: <CAFySSZAB09QB7U6UxntK2jRJF0df5R7YGnnLSsYc9MYhHsBhWA@mail.gmail.com>
 <20240422162617.308366-1-calvinwan@google.com>
 <CAO_smVg_RmL2_ERXG0uZ+CgEHZBm34PvmNucbSTdsEDLjU-fhA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAO_smVg_RmL2_ERXG0uZ+CgEHZBm34PvmNucbSTdsEDLjU-fhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kyle

On 09/05/2024 02:00, Kyle Lippincott wrote:
> // RENAMED from previous code block (no other changes)
> // In a .c file that is "library internal".
> // This translation unit can assume that we've done #include
> "git-compat-util.h" and anything else it wants.
> int strbuf_grow_impl(struct strbuf *sb, size_t extra)
> {
>          int new_buf = !sb->alloc;
>          if (unsigned_add_overflows(extra, 1) ||
>              unsigned_add_overflows(sb->len, extra + 1))
>                  return -1;
>          if (new_buf)
>                  sb->buf = NULL;
>          ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
>          if (new_buf)
>                  sb->buf[0] = '\0';
>          return 0;
> }
> 
> // In a .c file for the interface as used by other projects:
> int gitlib_strbuf_grow(struct strbuf *sb, size_t extra)
> {
>          return strbuf_grow_impl(sb, extra);
> }
> 
> // NEW from previous code block
> // In a .c file for the interface as used by the git project itself:
> void strbuf_grow(struct strbuf *sb, size_t extra)
> {
>          if (strbuf_grow_impl(sb, extra))
>                  die("you want to use way too much memory")
> }
> 
> I'm recommending this pattern primarily because of our platform
> support concerns. If we can't elevate the entire project to assume
> that C99 is available in a standards compliant way, we can't have
> header files that look like this be part of building the `git` binary
> itself (or any of the helper binaries):
> 
> #include <stdint.h>  /* Our platform support policy doesn't allow this */
> int gitlib_strbuf_grow(struct strbuf *sb, size_t extra);

We have had a test balloon [1] requiring C99 for two and a half years 
without any bug reports so I think we are probably safe to assume the 
test balloon has succeeded and that we can depend on on the presence of 
<stdint.h>. Note that the [u]intptr_t types are optional and so we'd 
need to make sure we avoid them in public interfaces.

[1] 7bc341e21b5 (git-compat-util: add a test balloon for C99 support, 
2021-12-01)

> It's not just the #includes, though. As stated in the original
> document, we run into problems with platform-defined types and
> everything else that's tweaked in/provided by git-compat-util.h:
> - This header file that's included in the non-git projects can't use
> `off_t` or `struct stat`.

In principle we could change the interfaces that currently use `off_t` 
to use `int64_t` and convert to `off_t` in the function body which would 
avoid having to have separate wrappers for the internal and external 
callers. I'm not sure how invasive that would be though. `struct stat` 
is trickier - where do we expose that in our interfaces?

> - This header file can't assume that any types related to sockets are
> available, because those come from <sys/socket.h> on Linux and from
> winsock2.h on Windows.
> - It can't assume that we have `NORETURN` (and it can't assume that we
> don't need it), or `MAYBE_UNUSED`, or ...

These problems and the _GNU_SOURCE on you mention below must be pretty 
common for cross-platform libraries - how do other projects handle them?
On the face of it this seems like it would be fairly simple to solve by 
including a file that contains the subset of git-compat-util.h that 
defines these macros (with a suitable LIBGIT_ prefix) in libgit.h.

> Most of those issues _may_ be able to be resolved by having a
> "gitlib-compat-util.h" file included at the top of the "external
> project" .h file. But that's insufficient. Example:
> 
> #include <unistd.h>
> #include "git/gitlib.h"  // Oops, the `#define _GNU_SOURCE` in the
> transitive "gitlib-compat-util.h" has no effect!
> 
> Or the opposite:
> 
> #include "git/gitlib.h"  // Oops, this set _FILE_OFFSET_BITS=64 when
> the project wasn't expecting it!
> #include <unistd.h>  // For this translation unit only, `off_t` might
> be a different size than elsewhere in the project, I hope you like
> debugging segfaults.
> 
> The only ways I could come up with to solve these problems were to
> hold the "external interface" to a different standard, that is
> simultaneously both more permissive (it can assume C99), and
> restrictive (it can't rely on things like off_t),
 >
> incompatible with these external interfaces being used by the git
> project itself, which has a broader set of platforms it needs to
> support. But the external interfaces must be very simple wrappers
> around code that _is_ shared with the git executable.

I agree we should minimize the amount of code in the wrappers for 
external callers.

Best Wishes

Phillip
