Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8A331735
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="n8IOdxYr"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7815ba075f9so106682585a.0
        for <git@vger.kernel.org>; Fri, 05 Jan 2024 08:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704472405; x=1705077205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2AS1cqtWZpIxYbn10K75+Z6UVsEXJkxO+yfkV8vkwu8=;
        b=n8IOdxYrwbFypPU7Rvni7Z/39Em2lNWKhB3PS3G4G4uNaPek0E4mIV9IZ4h+t2UbeL
         0b05JcYtf3qDFPNjG0s6k3555OPwZcHWuBtbsmEBGIIt6P5rhRMJJlx38Rr04QiOUmso
         QykM8pl4gnMg2iLPJRVr1xYcbp3F4AlXavx4DlZ6PM2gvUwF9ssRag8fGBlm1YVWfrjI
         neghlG158BsT7LeY1z51YUHHKzLYgYw5LEGGhjiw8dkaSOhb2fgSzxVm2TonkepxnJvC
         umq0LuWFHeH6PDDiYIeUPqB7xbJuZRjrgeOF2bYEPJTNVpNo3a1YDSwB9kWeELv9aFQQ
         J3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704472405; x=1705077205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AS1cqtWZpIxYbn10K75+Z6UVsEXJkxO+yfkV8vkwu8=;
        b=mRTGimMLMUjy822yagza2HBnCUnkBgv3KbjY2SLzLlhJe770aYLR1cfEzqIQH+Fjf6
         8mZtsBD5x6tuQbl6TukZ6Y5GRA7bqu3Hf/kTus6J7N777qaoNr9laIYy/VjqalP1lBci
         G8sQHkcbCkSuvJ6G/1bmtZs6sIkTUwHppU6w35zIuyzHRyWAi0ZGxJhN5MI/DkZM0u9b
         Mf0hCZ2h3HjrQWBik+9XK1i3j39rrZvJbqIOt5TjVTUEOpDL+k3EgE3sinbsvIqO710B
         V34hMGQbrH5BQ2Ts0ibnBflODrzL0QOJAccywRm+g+AOHXVkQfeVFbjp34dU7PM2RzZA
         wbMg==
X-Gm-Message-State: AOJu0Yzz1+4KDUcdMJShMY61fd+Q58z3YTmjDp+WahNrUhRO1pP93Ael
	818qorD0ryh1YqDLej8xQXqXLendLRcSiw==
X-Google-Smtp-Source: AGHT+IEChLDUdVZI2lGGrlTDkBT9oNhmqw9aYZio74ntdiNq4yKVLCmpMeYGDjSfQIKWzsexBa9OMQ==
X-Received: by 2002:a05:620a:1a20:b0:781:54f4:6d5 with SMTP id bk32-20020a05620a1a2000b0078154f406d5mr2654769qkb.116.1704472405259;
        Fri, 05 Jan 2024 08:33:25 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q5-20020ae9e405000000b007815c8ab309sm700406qkc.34.2024.01.05.08.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 08:33:24 -0800 (PST)
Date: Fri, 5 Jan 2024 11:33:23 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] index-pack: spawn threads atomically
Message-ID: <ZZgvUyQK6X/MacDC@nand.local>
References: <20240105085034.GA3078476@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240105085034.GA3078476@coredump.intra.peff.net>

On Fri, Jan 05, 2024 at 03:50:34AM -0500, Jeff King wrote:
> The t5309 script triggers a racy false positive with SANITIZE=leak on a
> multi-core system. Running with "--stress --run=6" usually fails within
> 10 seconds or so for me, complaining with something like:
>
>     + git index-pack --fix-thin --stdin
>     fatal: REF_DELTA at offset 46 already resolved (duplicate base 01d7713666f4de822776c7622c10f1b07de280dc?)
>
>     =================================================================
>     ==3904583==ERROR: LeakSanitizer: detected memory leaks
>
>     Direct leak of 32 byte(s) in 1 object(s) allocated from:
>         #0 0x7fa790d01986 in __interceptor_realloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:98
>         #1 0x7fa790add769 in __pthread_getattr_np nptl/pthread_getattr_np.c:180
>         #2 0x7fa790d117c5 in __sanitizer::GetThreadStackTopAndBottom(bool, unsigned long*, unsigned long*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_linux_libcdep.cpp:150
>         #3 0x7fa790d11957 in __sanitizer::GetThreadStackAndTls(bool, unsigned long*, unsigned long*, unsigned long*, unsigned long*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_linux_libcdep.cpp:598
>         #4 0x7fa790d03fe8 in __lsan::ThreadStart(unsigned int, unsigned long long, __sanitizer::ThreadType) ../../../../src/libsanitizer/lsan/lsan_posix.cpp:51
>         #5 0x7fa790d013fd in __lsan_thread_start_func ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:440
>         #6 0x7fa790adc3eb in start_thread nptl/pthread_create.c:444
>         #7 0x7fa790b5ca5b in clone3 ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
>
>     SUMMARY: LeakSanitizer: 32 byte(s) leaked in 1 allocation(s).
>     Aborted

We discussed this in another thread (beginning here [1]), and I would be
fine with this approach. I share your feeling that it is a little gross
to have to work around LSan's implementation by tweaking production
code, but I think that this doesn't have to be the most pristine patch
ever written, either ;-).

Just playing devil's advocate for a moment, I wonder if another approach
might be to disable the threading altogether for the purposes of this
test. The performance difference is negligible, and I don't think we're
exercising any interesting paths in this particular test that have to do
with pack.threads > 1 that aren't covered extensively elsewhere.

So, in other words, I think a reasonable approach would be to do
something like:

--- 8< ---
diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
index 4e910c5b9d..1d132b6324 100755
--- a/t/t5309-pack-delta-cycles.sh
+++ b/t/t5309-pack-delta-cycles.sh
@@ -73,7 +73,7 @@ test_expect_success 'failover to a duplicate object in the same pack' '
 		pack_obj $A
 	} >recoverable.pack &&
 	pack_trailer recoverable.pack &&
-	test_must_fail git index-pack --fix-thin --stdin <recoverable.pack
+	test_must_fail git index-pack --threads=1 --fix-thin --stdin <recoverable.pack
 '

 test_done
--- >8 ---

And call it a day. I built with SANITIZE=leak, and then ran:

    $ GIT_TEST_PASSING_SANITIZE_LEAK=true ./t5309-pack-delta-cycles.sh --stress --run=6

For a while and didn't see any failures. That could be luck, of course,
but without the above patch I was seeing failures within a few seconds.
I'm reasonably confident that this would do the trick.

For what it's worth, I'm fine with either approach, mostly to avoid
tying up more of the list's time discussing the options. But I have a
vague preference towards `--threads=1` since it doesn't require us to
touch production code.

> Rescuing this from:
>
>   https://lore.kernel.org/git/20231221105124.GD570888@coredump.intra.peff.net/
>
> where it was buried deep in a thread. I still think it's kind of gross,
> but it may be the least-bad thing.

In either case, thanks for digging it back up :-).

Thanks,
Taylor

[1]: https://lore.kernel.org/git/xmqqbkasnxba.fsf@gitster.g/
