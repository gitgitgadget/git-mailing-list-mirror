Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B8E182D2
	for <git@vger.kernel.org>; Wed,  7 May 2025 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629541; cv=none; b=E20Wc/aHZPkT9sjDVcYtmCVil3Fop4YuHVhcNjSJ/N5s9RUzxBFQ+yeUXydSwwKefM9h/FroQfyV0oZdi9uYvXvbDVeayBSBiO+fg1Hi1R3HLQv7uDYz+GyWk33q6GhyCNHTQ0lvP/Oj8hJGp9Sm68sqU0ZwdPwnZw3U0rzhcbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629541; c=relaxed/simple;
	bh=4Vzj002uFT1p6802DV9mNCUH3Ej7a3YzMI+v9IIjxe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHiw14ESZ3U8awF8+4UBoz0quG1tyaSNsnaULS6EpODhVMi6WW7l0ZIyrlRrFlC8XYp4wiK1CTzqrkZdDhMSeyw2jvjBMwhC3JH3loTXRTp3LTxUi+uVC2aFl/nFnHeeYszf64pb4MGYUGgRlP8rLucURWqd2MbxORdhrjSjA1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJY1+doc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJY1+doc"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22c33677183so82643875ad.2
        for <git@vger.kernel.org>; Wed, 07 May 2025 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746629539; x=1747234339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YrJ8YM4VDA1MGmJjB8LmHzOtM56Ml5CGWU8tNfyupjA=;
        b=eJY1+doc2WMtqiSHwABVfTSdnCT5Q0FsGgiQ+vvr06EgS2WaESL6CtKi7eA+B9jp5u
         zAYeB9nuX+j5Y+dP9RsR4YozYwOwR+XcrKKnmkRWbsqbol6AcMna820qK8+swbHYFnns
         q96QTI4uQEkQDdJsffpj1f94ukH+ufZwx694ZUlwWg3iTCBwQtsDBZMI1gzNnmhkf4vg
         YImMicYokCe/9nyZj1QSUiDAQtpCjsu1xY26I2VnuQiBh0UBr2FC9Qk07KBrPNt45Y8W
         ppbNUj8jYZ8eCdScOH9TJ0g7ipTIX7qbwEznV5W/LA8/J6Z1Gaa5w777wO00N4CzTSGS
         6paQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746629539; x=1747234339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrJ8YM4VDA1MGmJjB8LmHzOtM56Ml5CGWU8tNfyupjA=;
        b=J0PwtS+0bGxEyePS4qiUvocaqzoRahcNdH73Mb5+GmZf7bD1Po99L8IZDAd1pa0sZD
         8X8bNdL9GrSbUHDsMaIYS2Tnw7rePYgJat0Fsei/jF/HGGkleuKTrlrp/nQvfXb0edL4
         70ftwYLyozS7xTxl6axYra8qP4xlnejDT1D80a9om5wGWqhIh+opkG1XduW6eGIbNXcK
         SYf2HUTI2z2rlyOX1JcpbDo/Ba5tS2bFDsRnMk3S3bUZd5dcNfC/2BAY3wL9fC2yMjBL
         pmK1M7xqRaqnBERReRonCRqShZDZVxHJLEgRgLvlzwWfthzrtd61fh4B+/HbJg5ASYwS
         ZfyQ==
X-Gm-Message-State: AOJu0YxalTqKGHrb1r9vY66C+raLLNQKB+hpr2LsKAlfos2FhP48SInL
	OLt3XFv+oirFVJoWb9q67CYaMj44y+KZpaUARxVQ+OZifO0xYwZgfDdNHiunCmE=
X-Gm-Gg: ASbGnctfHVihukUt1gMtnURUh9gd8RIFAjlHKhTbQOU87dHc/EavWaO+HP4/PtN+T5a
	JdBQo90y5N75JzVAE/EmDLxGY4yqJ9Io4CoQLKtiw23tHeOA1lbr9eJIRjFFryeOjV6iRZ+ctSU
	/h7PJ2/H8ZYdDcIuRHzV3YjU5vxVU5bku2BtPSGWH58a5HY0Jx0Kih3Aqod6yLGbF62XLEc5NLm
	ovkFC/FkLstfmtUJMRtMlBD0PoPebz/CClA46v1YTJ2JMJVnQZz0kTXvGHFK2cLJWtDjGc/iw9n
	UfY+1IWpTwignLSqN5VcwqoFa0//7bWrY+gk
X-Google-Smtp-Source: AGHT+IEu1SZeG8wv2HxpxB00QDJPkqxgoMlLVVjLuYyPH408mEV9+l8Ko+UBI9IF1guHdeAEIyjQEA==
X-Received: by 2002:a17:902:f606:b0:22e:421b:49a9 with SMTP id d9443c01a7336-22e5ea27b8fmr53994055ad.2.1746629538904;
        Wed, 07 May 2025 07:52:18 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22e61f3ad8asm17726025ad.211.2025.05.07.07.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 07:52:18 -0700 (PDT)
Date: Wed, 7 May 2025 22:52:15 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/4] align the behavior when opening "packed-refs"
Message-ID: <aBtzn4nwLsI9p5Cp@ArchLinux>
References: <aBo7OiCKHTyT4DzH@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBo7OiCKHTyT4DzH@ArchLinux>

Hi All:

As discussed in [1], we need to use mmap mechanism to open large
"packed_refs" file to save the memory usage. This patch mainly does the
following things:

1: Fix an issue that we would report an error when the "packed-refs"
file is empty, which does not align with the runtime behavior.
2-4: Extract some logic from the existing code and then use these
created helper functions to let fsck code to use mmap necessarily

[1] https://lore.kernel.org/git/20250503133158.GA4450@coredump.intra.peff.net

Really thank Peff and Patrick to suggest me to do above change.

---

Change since v1:

1. Update the commit message of [PATCH 1/4]. And use redirection to
create an empty file instead of using `touch`.
2. Don't use if for the refactored function in [PATCH 3/4] and then
update the commit message to align with the new function name.
3. Enhance the commit message of [PATCH 4/4].

Thanks,
Jialuo

shejialuo (4):
  packed-backend: fsck should allow an empty "packed-refs" file
  packed-backend: extract snapshot allocation in `load_contents`
  packed-backend: extract munmap operation for `MMAP_TEMPORARY`
  packed-backend: mmap large "packed-refs" file during fsck

 refs/packed-backend.c    | 113 ++++++++++++++++++++++++---------------
 t/t0602-reffiles-fsck.sh |  13 +++++
 2 files changed, 82 insertions(+), 44 deletions(-)

Range-diff against v1:
1:  aa9037ebfa ! 1:  26c3fd55a8 packed-backend: skip checking consistency of empty packed-refs file
    @@ Metadata
     Author: shejialuo <shejialuo@gmail.com>
     
      ## Commit message ##
    -    packed-backend: skip checking consistency of empty packed-refs file
    +    packed-backend: fsck should allow an empty "packed-refs" file
     
    -    In "load_contents", when the "packed-refs" is empty, we will just return
    -    the snapshot. However, we would report an error to the user when
    -    checking the consistency of the empty "packed-refs".
    -
    -    We should align with the runtime behavior. As what "load_contents" does,
    -    let's check whether the file size is zero and if so, we will skip
    -    checking the consistency and simply return.
    +    During fsck, an empty "packed-refs" gives an error; this is unwarranted.
    +    We should just skip checking the content of "packed-refs" just like the
    +    runtime code paths such as "create_snapshot" which simply returns the
    +    "snapshot" without checking the content of "packed-refs".
     
         Signed-off-by: shejialuo <shejialuo@gmail.com>
     
    @@ t/t0602-reffiles-fsck.sh: test_expect_success SYMLINKS 'the filetype of packed-r
     +		cd repo &&
     +		test_commit default &&
     +
    -+		touch .git/packed-refs &&
    ++		>.git/packed-refs &&
     +		git refs verify 2>err &&
     +		test_must_be_empty err
     +	)
2:  852e8a606b = 2:  4604be8b51 packed-backend: extract snapshot allocation in `load_contents`
3:  de146155f6 ! 3:  c0609afac9 packed-backend: extract munmap operation for `MMAP_TEMPORARY`
    @@ Commit message
         is "MMAP_TEMPORARY". We also need to do this operation when checking the
         consistency of the "packed-refs" file.
     
    -    Create a new function "munmap_snapshot_if_temporary" to do above and
    +    Create a new function "munmap_temporary_snapshot" to do above and
         change "create_snapshot" to align with the behavior.
     
         Suggested-by: Jeff King <peff@peff.net>
    @@ refs/packed-backend.c: static int allocate_snapshot_buffer(struct snapshot *snap
      	return 1;
      }
      
    -+static void munmap_snapshot_if_temporary(struct snapshot *snapshot)
    ++static void munmap_temporary_snapshot(struct snapshot *snapshot)
     +{
    -+	if (mmap_strategy != MMAP_OK && snapshot->mmapped) {
    -+		/*
    -+		 * We don't want to leave the file mmapped, so we are
    -+		 * forced to make a copy now:
    -+		 */
    -+		size_t size = snapshot->eof - snapshot->start;
    -+		char *buf_copy = xmalloc(size);
    ++	char *buf_copy;
    ++	size_t size;
     +
    -+		memcpy(buf_copy, snapshot->start, size);
    -+		clear_snapshot_buffer(snapshot);
    -+		snapshot->buf = snapshot->start = buf_copy;
    -+		snapshot->eof = buf_copy + size;
    -+	}
    ++	if (!snapshot)
    ++		return;
    ++
    ++	/*
    ++	 * We don't want to leave the file mmapped, so we are
    ++	 * forced to make a copy now:
    ++	 */
    ++	size = snapshot->eof - snapshot->start;
    ++	buf_copy = xmalloc(size);
    ++
    ++	memcpy(buf_copy, snapshot->start, size);
    ++	clear_snapshot_buffer(snapshot);
    ++	snapshot->buf = snapshot->start = buf_copy;
    ++	snapshot->eof = buf_copy + size;
     +}
     +
      /*
    @@ refs/packed-backend.c: static struct snapshot *create_snapshot(struct packed_ref
     -		snapshot->buf = snapshot->start = buf_copy;
     -		snapshot->eof = buf_copy + size;
     -	}
    -+	munmap_snapshot_if_temporary(snapshot);
    ++	if (mmap_strategy == MMAP_TEMPORARY && snapshot->mmapped)
    ++		munmap_temporary_snapshot(snapshot);
      
      	return snapshot;
      }
4:  be1e9e2540 ! 4:  c868e3dd16 packed-backend: use mmap when opening large "packed-refs" file
    @@ Metadata
     Author: shejialuo <shejialuo@gmail.com>
     
      ## Commit message ##
    -    packed-backend: use mmap when opening large "packed-refs" file
    +    packed-backend: mmap large "packed-refs" file during fsck
     
    -    We use "strbuf_read" to read the content of "packed-refs". However, this
    -    is a bad practice which would consume a lot of memory usage if there are
    -    multiple processes reading large "packed-refs".
    +    During fsck, we use "strbuf_read" to read the content of "packed-refs"
    +    without using mmap mechanism. This is a bad practice which would consume
    +    more memory than using mmap mechanism. Besides, as all code paths in
    +    "packed-backend.c" use this way, we should make "fsck" align with the
    +    current codebase.
     
         As we have introduced two helper functions "allocate_snapshot_buffer"
         and "munmap_snapshot_if_temporary", we could simply call these functions
    @@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
     +	if (!allocate_snapshot_buffer(snapshot, fd, &st))
      		goto cleanup;
     -	}
    -+	munmap_snapshot_if_temporary(snapshot);
      
     -	ret = packed_fsck_ref_content(o, ref_store, &sorted, packed_ref_content.buf,
     -				      packed_ref_content.buf + packed_ref_content.len);
    ++	if (mmap_strategy == MMAP_TEMPORARY && snapshot->mmapped)
    ++		munmap_temporary_snapshot(snapshot);
    ++
     +	ret = packed_fsck_ref_content(o, ref_store, &sorted, snapshot->start,
     +				      snapshot->eof);
      	if (!ret && sorted)
-- 
2.49.0

