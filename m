Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB11A9B54
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735579359; cv=none; b=EMbKNJi1E0UEmmY43LonmZkB8QdlczlOUINk/aUqNIslqcpd7IMuCf70rUBL0oI7o2ZNO0MehC2Z82sCjmMt7LCmY5qiNjg3gIMnA0pgqCU35tQ7q09QgWUaqy3JiPnUpA2shPmem6Vf53fuCOEJWdLsdx1DsK1gfgD9Js8gOD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735579359; c=relaxed/simple;
	bh=9FHGu54aGzDzikvZ6N8ZOKwx/tm6Et0CemG5wg8kx5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4iR2zi2TMpV0kKxKMlk+TCWgb6IwraCNKGi1/aNIZTSSrBzjUQLtLYOqF/3dcNZgV9+PULwF9/ZR+IP8Fl6OHRZI1xk4lef+3NvZ4q042I9SGq7E0wjjmoi4Dl/rjjHmAvdYDQYcAOdmcJJRhnXR1yid82j4F84k0nMCHHzS/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=hnCVwjko; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="hnCVwjko"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso12458516276.3
        for <git@vger.kernel.org>; Mon, 30 Dec 2024 09:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1735579356; x=1736184156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0CYpuq2LtqmSSzKlmf3zq4mNpSTkp4jSUp9NQWG/QqQ=;
        b=hnCVwjko4tHA1iMzegHo/V4vJuXD66p7mxU3NRbQ09b7Od96zK0T2k1H4e8ljAXPRk
         BVaplKYmTn4Wij2SUBNUnk3YIlzyxpCgXkY0Ji/1E4eXsOefMk5gZD7sQnHam/wQnLgd
         pKVfWD1LspO2rPK1GrsJDnWdiXtZpJPKMPqGLjqLljlz6VwbjVCpyAP0bFpS5vVlFP3X
         dsp4iBf3GO7zAEaiMu57YIN4w/KGVFnSnEm6o25ZPFavOxBbemesQ2i3idvKizRqRrND
         oj5Hy9HlvCcDjoImBsqvAOH9hW4GzF0mA6RLkJ+mQt5fxDhOCMemtczc3SZUdNeezdaV
         s5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735579356; x=1736184156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CYpuq2LtqmSSzKlmf3zq4mNpSTkp4jSUp9NQWG/QqQ=;
        b=nsfhBuMI4uHoNbhpbQBKyHMyCasJxK13yPCuQsWdcXYN6xLUMgSjGGjdG66kiU8imP
         admLGy4UJqIr6+21d/f5HNRZJvYic7pF2xhyX9w/ygDoGRn3LkTdKtiIh/GcBiqzLysS
         DPQ/YcE1PbqLng9tCbAtL3mPUk6Vo4Jc6yTDv8L2flnR2DstCg4CWFYEQttMFHqtsQsW
         2odP6c8Fr/KLlD1o+yE+dSOyrlXiaXhVApthc3j/yGsl2t70ok78T3Nwuur/mQyEDxG7
         XVJ9OqpkjPjP52uWJccFxuN7p5ePhQkcQ9igFK4Ow3Qzlcf+qDkiTAt7YD3gMRtKGuKs
         VG9w==
X-Gm-Message-State: AOJu0YwaSwxXM0NRzISFu70XQjguHrdY4xAEhT5q5wVHIsKCAZtDvB/s
	2C26s4iV3WdnDTxfyDWcT0r5ilJvCJSM4lkMd2z2jbdjLjxyi+oJUj2iFBYBr+htm2HQ5dH3d25
	VdtY=
X-Gm-Gg: ASbGncvuXZ9JIObiaShTgs4tkVR8yq4DVzUhtwFZFK4yU2rIS18lTTb/S7xtycD1xVN
	JfFelfFhqL6drbLtrnBsSmJubkcIo3cfPqrQGhkwK+CE1YUny1A/j6+dvinQm3+eqAgyL4Q0UVt
	YYediMO57D03mMFiiF2hugRsz5dfXN5QnQiKuuD7N/+19ldvi1BRs0QrALEdj9P02A9noalIWRh
	oAVetRL2nLOO5b5Ur0IsNNGR9nelbYAiOm/xrmCVVpdpw8xCzMKnwIWRhNOeFwpjZeQKc1s5niN
	qQXMO2JDMjaJmQrRrVQRzTfSYFYW
X-Google-Smtp-Source: AGHT+IHEqdlcwYC3ko+VYsWgXBzwUUBccIogxLYmS8S7FP1kO0xQo5yoE/jtpFy4CryGWY1vWSYFLw==
X-Received: by 2002:a25:c704:0:b0:e48:260f:2259 with SMTP id 3f1490d57ef6-e543d65aa8dmr2367592276.10.1735579356385;
        Mon, 30 Dec 2024 09:22:36 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cf46c26sm6043229276.44.2024.12.30.09.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 09:22:35 -0800 (PST)
Date: Mon, 30 Dec 2024 12:22:34 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/10] builtin/fast-import: fix segfault with unsafe SHA1
Message-ID: <Z3LNVzw9UlS7SWqe@nand.local>
References: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
 <20241230-pks-meson-sha1-unsafe-v1-2-efb276e171f5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241230-pks-meson-sha1-unsafe-v1-2-efb276e171f5@pks.im>

On Mon, Dec 30, 2024 at 03:24:02PM +0100, Patrick Steinhardt wrote:
> Same as with the preceding commit, git-fast-import(1) is using the safe
> variant to initialize a hashfile checkpoint. This leads to a segfault
> when passing the checkpoint into the hashfile subsystem because it would
> use the unsafe variants instead:
>
>     ++ git --git-dir=R/.git fast-import --big-file-threshold=1
>     AddressSanitizer:DEADLYSIGNAL
>     =================================================================
>     ==577126==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000040 (pc 0x7ffff7a01a99 bp 0x5070000009c0 sp 0x7fffffff5b30 T0)
>     ==577126==The signal is caused by a READ memory access.
>     ==577126==Hint: address points to the zero page.
>         #0 0x7ffff7a01a99 in EVP_MD_CTX_copy_ex (/nix/store/h1ydpxkw9qhjdxjpic1pdc2nirggyy6f-openssl-3.3.2/lib/libcrypto.so.3+0x201a99) (BuildId: 41746a580d39075fc85e8c8065b6c07fb34e97d4)
>         #1 0x555555ddde56 in openssl_SHA1_Clone ../sha1/openssl.h:40:2
>         #2 0x555555dce2fc in git_hash_sha1_clone_unsafe ../object-file.c:123:2
>         #3 0x555555c2d5f8 in hashfile_checkpoint ../csum-file.c:211:2
>         #4 0x5555559647d1 in stream_blob ../builtin/fast-import.c:1110:2
>         #5 0x55555596247b in parse_and_store_blob ../builtin/fast-import.c:2031:3
>         #6 0x555555967f91 in file_change_m ../builtin/fast-import.c:2408:5
>         #7 0x55555595d8a2 in parse_new_commit ../builtin/fast-import.c:2768:4
>         #8 0x55555595bb7a in cmd_fast_import ../builtin/fast-import.c:3614:4
>         #9 0x555555b1f493 in run_builtin ../git.c:480:11
>         #10 0x555555b1bfef in handle_builtin ../git.c:740:9
>         #11 0x555555b1e6f4 in run_argv ../git.c:807:4
>         #12 0x555555b1b87a in cmd_main ../git.c:947:19
>         #13 0x5555561649e6 in main ../common-main.c:64:11
>         #14 0x7ffff742a1fb in __libc_start_call_main (/nix/store/65h17wjrrlsj2rj540igylrx7fqcd6vq-glibc-2.40-36/lib/libc.so.6+0x2a1fb) (BuildId: bf320110569c8ec2425e9a0c5e4eb7e97f1fb6e4)
>         #15 0x7ffff742a2b8 in __libc_start_main@GLIBC_2.2.5 (/nix/store/65h17wjrrlsj2rj540igylrx7fqcd6vq-glibc-2.40-36/lib/libc.so.6+0x2a2b8) (BuildId: bf320110569c8ec2425e9a0c5e4eb7e97f1fb6e4)
>         #16 0x555555772c84 in _start (git+0x21ec84)

Wow. This is a really good catch, and I'm embarrassed to have introduced
the bug in the first place.

If I can state back to you what I think is going on to make sure that
we're on the same page... In fast-import, we initialize a
hashfile_checkpoint struct using regular the_hash_algo callbacks, like
the_hash_algo->init_fn(), the_hash_algo->update_fn(), etc. But we also
have a hashfile, which will use the unsafe variants of these functions.

If we're using a specialized unsafe variant, then calling
hashfile_checkpoint() will crash. In your example, the crash happens
when we try and call the clone_fn, but I think it could also happen
with hashflush() when it tries to call update_fn().

I thought that my series here:

    https://lore.kernel.org/git/cover.1732130001.git.me@ttaylorr.com/

would have prevented this, but I don't think that it would have in its
current state. A little more on that in a second...

> ---
>  builtin/fast-import.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 1fa2929a01b7dfee52b653248bba802884f6be6a..0f86392761abbe6acb217fef7f4fe7c3ff5ac1fa 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -1106,7 +1106,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
>  		|| (pack_size + PACK_SIZE_THRESHOLD + len) < pack_size)
>  		cycle_packfile();
>
> -	the_hash_algo->init_fn(&checkpoint.ctx);
> +	the_hash_algo->unsafe_init_fn(&checkpoint.ctx);

This will obviously fix the issue at hand, but I don't think this is any
less brittle than before. The hash function implementation here needs to
agree with that used in the hashfile API. This change makes that
happen, but only using side information that the hashfile API uses the
unsafe variants.

The series I mentioned above made the algop a property of the hashfile
itself, and introduced a specialized "unsafe" variant that did not
require using separate callbacks.

So that on its own would not have saved us here (or in the other spot
from the previous patch). But something on top like this would have:

--- 8< ---
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 76d5c20f14..89fc20d436 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1101,7 +1101,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		|| (pack_size + PACK_SIZE_THRESHOLD + len) < pack_size)
 		cycle_packfile();

-	the_hash_algo->init_fn(&checkpoint.ctx);
+	pack_file->algop->init_fn(&checkpoint.ctx);
 	hashfile_checkpoint(pack_file, &checkpoint);
 	offset = checkpoint.offset;
--- >8 ---

(and an analogous change to the other spot).

I think we should perhaps combine forces here. My ideal end-state is to
have the unsafe_hash_algo() stuff land from my earlier series, then have
these two fixes (adjusted to the new world order as above), and finally
the Meson fixes after that.

Does that seem like a plan to you? If so, I can put everything together
and send it out (if you're OK with me forging your s-o-b).

Thanks,
Taylor
