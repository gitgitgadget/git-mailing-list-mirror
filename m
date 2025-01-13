Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818981BBBE0
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736790856; cv=none; b=iId6ZIrjhrFforraVbAmgIXUbvTb65zX5WHaXNX22ScFJxnuQFt0R58+kFpX/P3b2z9nrt/R9MXhvxx2F5dibafSMG8RtkppVvwYWn4XcmtS6ay+gCCtioRtx1UaK6fYLS0Wn9rmbv/SIBqujfrhnsJyn2Z4qRr8DEp2LTM8FpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736790856; c=relaxed/simple;
	bh=8z28keBvZ8vHJx80oLhkGP7dtRw4+8yjMjSMOgoaBNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2EWzeUYdG1NU5BrtHU0q1T47bTwdKN8nWBKaqxKiA5rVm8M6tVsw8GKKLBeajkVrDAfP0ND9j9OUu28Kky5KkYnhCnt1WlmGZhVCqgo7AonbLB4FPwOmzsGJii6nK3Xuu5JvuTR8Cqtri2TKMIzgU0oPvOrR8VlKO6Kx8gEA3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3LFHaqI4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3LFHaqI4"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21625b4f978so2565ad.0
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 09:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736790854; x=1737395654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSUqxzvygef+LpNFbJ+bNW8kTkCUIzWAQLTWl67AKPo=;
        b=3LFHaqI4Vjk4iaAoSvNzCp1NrGRVd0wVhkWo0vHGp2BZv1YJzzlkZVxxhznvSD+tW5
         JCjwjfvvP4gZqw11bW50Y/HenVEt1b5sANSf8ukcF1yfdVcAfIIKABTTDK+bjX2k9EJG
         NmotjDPF4ysUgnCfswMaW2XSIHFGXodDMkZ+nkprzhLpodbOPMnWsTpTslQTpYL7m2MA
         DcFoDVVYXN2UDBWwPjxLQRJwi0urAH0sjOGRpdqI/8wxvrNVzLYZ1LKOY8RjcRoPK6XC
         0jqq6DXt3mvbcuPmvrLFo9PekInrPoQxVArxU7QoYK1SgPS2dH26kGjKlBZmT3i1HDvz
         WrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736790854; x=1737395654;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSUqxzvygef+LpNFbJ+bNW8kTkCUIzWAQLTWl67AKPo=;
        b=JzsBOXBYjI7iu926VbVUdcmXY59owxhuC9aZnR72bOS9UctkH2mMxAiakWJQlxxsjk
         p/F8SS7fO77sYZszWV2U8uIzQ6aqL6G4F4qonrSd9qNG9TArBHHgDgy+eDrp8i7Dll64
         2t6puNOHHjrsHDY7feL8Gz2xGiys9auKb8TqbXDSsf/kH0jvshCxeaowQc0RMeGEOvD1
         WBtyDQX9YF6BcEHhFUe9Rh14+4YiKr3EA1+asC4pzwcVICDjkN7KprxgKDFRNG9bNFk4
         K7Zbv+XGlkSKCCU0iaJ8vn7eSb5+/q2gR86gszl9SzODOIPHf1iKiwK9PfcoXwgJrMzY
         SZSQ==
X-Gm-Message-State: AOJu0YxvcU9Ph6RX2lB1KkiUw+XZHwrLR9zwCGwK1SZx4EiI05Vbi/ol
	tc7QfKD08X0fqqGcZ326CI086hI3pGi1bOFH9y9RvEnHtE97qXzsrxE5e3kOel17kl0zc70HYeE
	beQ==
X-Gm-Gg: ASbGncvHOX+Tfs2qMH4sZg5Xxt2EKlkGssXQ1rK7xMwvc7gNnzv30DOmbYPCVphNlbE
	2DIBO1nkoEhIrtCRi4do6uSc1QZeE8iLA+lpZBm4LDNVM6IkDI82SsXL0OK7vw6LHhNF7Oh1onq
	A4SodYMxaFXUZkNzZQWtVUINvYWDD75UnsH+onBowJj8oFIz3dhfcxHUTXd1MeW4JM0s5GQbrvg
	DYAjH3aze3RgsbbcJs/U688cFEoDJnmKuNPkJx8FLVXr/nJXGktvVc=
X-Google-Smtp-Source: AGHT+IErvVY1lqRaXylgMvdOCwqg88LDeB+hyS8MVFy5LguHN1/aGIHcBC5Yw2OPxm1e5MY5tk4q6w==
X-Received: by 2002:a17:903:1787:b0:20b:81bb:4a81 with SMTP id d9443c01a7336-21aa338ab92mr6728725ad.7.1736790853527;
        Mon, 13 Jan 2025 09:54:13 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:948b:e441:40c5:b7af])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4056a5fesm6101264b3a.48.2025.01.13.09.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 09:54:12 -0800 (PST)
Date: Mon, 13 Jan 2025 09:54:07 -0800
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, James Mills <prologic@shortcircuit.net.au>
Subject: Re: Git v2.46.0 and --allow-multiple-definition linker flag
Message-ID: <egtxf4f3dufiz56g276lt4qtediarj5kkuqbv222edrwcgf5dk@ocnbky74w3tv>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, James Mills <prologic@shortcircuit.net.au>
References: <CALGqR9+bH3nMrGqPQ18aqs-epSHRFQOtnd6Da55=KrtSu+Jrkg@mail.gmail.com>
 <xmqqbjx4bgae.fsf@gitster.g>
 <xmqq7c7sbfhi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7c7sbfhi.fsf@gitster.g>

On 2024.12.21 18:47, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > James Mills <prologic@shortcircuit.net.au> writes:
> >
> >> tcc: error: unsupported linker option '--allow-multiple-definition'
> >>
> >> I bisected the Git releases and traced the introduction of this new
> >> flag to v2.46.0
> >>
> >> I can't find any details of this flag really or when this was
> >> introduced in the GNU binutils and so far I haven't asked if the Tiny
> >> C devs intend to support this option (yet).
> >
> > Would
> >
> >     $ make LINK_FUZZ_PROGRAMS=""
> >
> > help?
> >
> > The platform-specific tweak defined in config.mak.uname file assumes
> > that you have glibc plus gcc or clang with usual binutils niceties
> > once you claim that you are Linux.  It lumps all different variants
> > of Linux into a single ball of wax and defines LINK_FUZZ_PROGRAMS
> > Makefile macro, which is a bit unfortunate.
> 
> Having said that, I am not sure if the commit that introduced the
> fuzz-all linkage rules, which is 8b9a42bf (fuzz: fix fuzz test build
> rules, 2024-01-19), needed to do so in the first place.  With this
> trivial patch at the end of the message applied on top of 8b9a42bf
> (or more recent 'master', for that matter), "make fuzz-all" seems to
> link things just fine.
> 
> Note that "make CC=clang fuzz-all" in the older code used to fail
> due to something else from gcc+ (which recent build no longer makes
> mandatory), but in today's code with gcc/clang/ld available locally,
> the linker flag does not seem to be needed for "make fuzz-all".
> 
> Josh, do you offhand know what made us add the option?
> 
> Thanks.
> 
> diff --git c/Makefile w/Makefile
> index c0cbed69d8..5af8935968 100644
> --- c/Makefile
> +++ w/Makefile
> @@ -3848,7 +3848,6 @@ FUZZ_CXXFLAGS ?= $(ALL_CFLAGS)
>  
>  $(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS
>  	$(QUIET_LINK)$(CXX) $(FUZZ_CXXFLAGS) -o $@ $(ALL_LDFLAGS) \
> -		-Wl,--allow-multiple-definition \
>  		$(filter %.o,$^) $(filter %.a,$^) $(LIBS) $(LIB_FUZZING_ENGINE)
>  
>  fuzz-all: $(FUZZ_PROGRAMS)

Sorry for the delayed response, I'm finally back to work after holidays
/ sick leave.

Unfortunately, the --allow-multiple-definitions flag is still required.

When simply running "make fuzz-all" with no other args (with or without
the patch above), we do not actually produce a working fuzzer:

$ make clean
$ make fuzz-all
$ ./oss-fuzz/fuzz-date
BUG: oss-fuzz/dummy-cmd-main.c:12: We should not execute cmd_main() from a fuzz target
zsh: IOT instruction  ./oss-fuzz/fuzz-date

This is because we're linking with common-main.o and
oss-fuzz/dummy-cmd-main.o. commain-main.o:main() calls cmd_main(), which
it finds in oss-fuzz/dummy-cmd-main.o. If we instead build with a
fuzzing engine enabled:

$ make clean
$ make CC=clang FUZZ_CXX=clang++ \
     CFLAGS="-fsanitize=fuzzer-no-link,address" \
     LIB_FUZZING_ENGINE="-fsanitize=fuzzer,address" \
     fuzz-all
$ ./oss-fuzz/fuzz-date
INFO: Running with entropic power schedule (0xFF, 100).
INFO: Seed: 2884061060
INFO: Loaded 1 modules   (55020 inline 8-bit counters): 55020 [0x562aff0d2840, 0x562aff0dff2c),
INFO: Loaded 1 PC tables (55020 PCs): 55020 [0x562aff0dff30,0x562aff1b6df0),
INFO: -max_len is not provided; libFuzzer will not generate inputs larger than 4096 bytes
INFO: A corpus is not provided, starting from an empty corpus
[...]


This works because the fuzzing engine provides its own main() which
overrides ours, and so we never end up calling
dummy-cmd-main.o:cmd_main().

However, that build will fail if we remove the
--allow-multiple-definition flag:

$ make clean
$ make CC=clang FUZZ_CXX=clang++ \
     CFLAGS="-fsanitize=fuzzer-no-link,address" \
     LIB_FUZZING_ENGINE="-fsanitize=fuzzer,address" \
     fuzz-all
[...]
    LINK oss-fuzz/fuzz-commit-graph
/usr/bin/ld: common-main.o: in function `main':
common-main.c:(.text.main[main]+0x0): multiple definition of `main'; /usr/lib/llvm-16/lib/clang/16/lib/linux/libclang_rt.fuzzer-x86_64.a(FuzzerMain.cpp.o):(.text.main+0x0): first defined here
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [Makefile:3890: oss-fuzz/fuzz-commit-graph] Error 1


As Junio says, a short term fix would be to build with
LINK_FUZZ_PROGRAMS="". A better solution would be to make
config.mak.uname smarter about whether to enable this by default. I see
that we use "detect-compiler" in config.mak.dev, would it make sense to
check this in config.mak.uname as well?
