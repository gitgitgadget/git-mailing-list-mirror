Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6A91E515
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736363674; cv=none; b=jRZWMwqQw2Ss3QKXQKlQvK+CSd+LcHU3YdzZ4uavWMFET2Pl0XbWnuhjWh7ejAXpZzq3cDvoAvguIAyCTHGugWQ5WEHF7vZUtbcc64Sl5r5qFlIhPygguBwrA9f5F6hOpMlbz1Bhqcq7tZG6V/J7zeKOztahaDNFwxjLpzl8WVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736363674; c=relaxed/simple;
	bh=Dzh9vOOLTrzDAG8KE0bZBVnqtA20EB2/LEabK4CTVPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/QQflxWdPW/CKuqYB9DCRNBj068z2zfH6dceJcUGREnHKYPuJoH2Aymf0VUwHY6TDqT90wK4lnQ+tsxY2k7vTfXzhjDm38n62UC1F4Z1AiGMRrytw1DiB566KnpFd8l3aSfobW1lIiYpSpiORsknV62qmwnEdn56WcwFyXpry0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=MbtsnVol; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MbtsnVol"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e53aa843a24so303637276.0
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 11:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1736363671; x=1736968471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5NUtHpsOY4hi0xRPJbHF1FyX3E2FlXAHJvIRKTFnXNs=;
        b=MbtsnVolk5MYraKgXnctvJ44g3aXFUIxTvN6tgojNJ2ZJGj+1eUphePCTRjtgiTWOd
         kxBrLb98bfETUQ39jYwt3w4VNtKjOwbWVcQSNrnnhFRTzVQIc89Q+AE/xuxWqkET2SD3
         waRCOcTm/p5qzB5a8FQET0CtNyQlD2N7WYNa4Qaddem19om5ukbmN3ULwMqUEgYID1z1
         nQaQnzIByW8IezRtQF81iAdnvgEhH7JSelrMawGfXtVGh6eAkZZ5CzN97JdMc3ksHAA/
         rLHbL+UuxSwXc143AOR3vQTuHF1BvQGGuDb+FlFiDx1NwcOeMepiWw4PduqSWXQMXprw
         +RJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736363671; x=1736968471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NUtHpsOY4hi0xRPJbHF1FyX3E2FlXAHJvIRKTFnXNs=;
        b=xSMQJClUOnNZS2UFNNOkGE1NWgOIYnumFWdf4ovC5IXZpgFG4ASFHpXk4btf26ZqbW
         iKYnX5yU3bWMZ6UiCBNDMKk1mqbykKJDpH4y4e+nnIkcyrckAhEyAJsrlYKHquX5ypVU
         YwjDCS0xiFms3VE2pCR17vpEgbpkn4yU6Y+FIJA7NPSZNPEZQaOcFUJZ/pCx4FVzLXMd
         LUrajZtligEgIj0mdZskiuxNKNJIM0ArGucRC+pzIadmPk8J+R2m5hjx+o+p3ToGLc6n
         Ig3Of1p/pcdZNx/LS68/GLoNWZ7daK8h6BownfaY9IOdeqQ2BYYCZwQvuQqxXcya+KdY
         XDzA==
X-Gm-Message-State: AOJu0YyiL9KStKVerYfYmB3bp5vFptb6XH429ermyFajxEI6zcIMrEhk
	7c4ZbKtyEoKgDLnCkSSBwAgYaHbnzgYrGL/XEGF9Zg4xrATpwtIUqNfmjqY7bxmmwGssU2PdS2E
	Xs0k=
X-Gm-Gg: ASbGncsepws+Gd/VRrMu7a8Cnry9569T5xs+SsR8aDAgSUgb4O9s4uByqUuAx2XqlpR
	aS3whcX9TyfsVEQNmvM7P3HA1kvpXiAQMW+ul31c+Bqq/CawsBR65GRijiEKFw23SqT+Ln1etiy
	FKS2wdSlZyhtdhIX2lezv7LfJ5aFZfC69dqO/kbsNsxh79uJdtJQR6ppYEEt5iK2qX+yMEofZGg
	tCuHART582GeCEqYBH/PVghdtPEbZKZdbEmcGHs9Bn9qNaRm0d3O+GKSSvYl+DmlwJ8jl8Jk9Sg
	VSjXsxm6yi416xd8xLhS+lfToEG2
X-Google-Smtp-Source: AGHT+IHW8QEaRHT+gvbcMdYtgeYCl9fnZdQd5rr7Pi3YHl5ep5nLiNa6pSwM3Nv/tMMMlnVGsdHqYw==
X-Received: by 2002:a05:690c:b17:b0:6e2:2684:7f62 with SMTP id 00721157ae682-6f543e68272mr5518697b3.8.1736363671093;
        Wed, 08 Jan 2025 11:14:31 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f52864ee8fsm5968087b3.35.2025.01.08.11.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 11:14:30 -0800 (PST)
Date: Wed, 8 Jan 2025 14:14:29 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/8] hash: introduce unsafe_hash_algo(), drop unsafe_
 variants
Message-ID: <cover.1736363652.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1732130001.git.me@ttaylorr.com>

(This series is rebased on 'master', which is 14650065b7
(RelNotes/2.48.0: fix typos etc., 2025-01-07) at the time of writing).

The bulk of this series is unchanged since last time, but a new seventh
patch that further hardens the hashfile_checkpoint callers on top of
Patrick's recent series[1].

The original cover letter is as follows:

------------

This series implements an idea discussed in [2] which suggests that we
introduce a way to access a wrapped version of a 'struct git_hash_algo'
which represents the unsafe variant of that algorithm, rather than
having individual unsafe_ functions (like unsafe_init_fn() versus
init_fn(), etc.).

This approach is relatively straightforward to implement, and removes a
significant deficiency in the original implementation of
unsafe/non-cryptographic hash functions by making it impossible to
switch between safe- and unsafe variants of hash functions. It also
cleans up the sha1-unsafe test helper's implementation by removing a
large number of "if (unsafe)"-style conditionals.

The series is laid out as follows:

  * The first two patches prepare the hashfile API for the upcoming
    change:

      csum-file: store the hash algorithm as a struct field
      csum-file.c: extract algop from hashfile_checksum_valid()

  * The next patch implements the new 'unsafe_hash_algo()' function at
    the heart of this series' approach:

      hash.h: introduce `unsafe_hash_algo()`

  * The next two patches convert existing callers to use the new
    'unsafe_hash_algo()' function, instead of switching between safe and
    unsafe_ variants of individual functions:

      csum-file.c: use unsafe_hash_algo()
      t/helper/test-hash.c: use unsafe_hash_algo()

  * The final patch drops the unsafe_ function variants following all
    callers being converted to use the new pattern:

      hash.h: drop unsafe_ function variants

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im/
[2]: https://lore.kernel.org/git/20241107013915.GA961214@coredump.intra.peff.net/

Taylor Blau (8):
  t/helper/test-tool: implement sha1-unsafe helper
  csum-file: store the hash algorithm as a struct field
  csum-file.c: extract algop from hashfile_checksum_valid()
  hash.h: introduce `unsafe_hash_algo()`
  csum-file.c: use unsafe_hash_algo()
  t/helper/test-hash.c: use unsafe_hash_algo()
  csum-file: introduce hashfile_checkpoint_init()
  hash.h: drop unsafe_ function variants

 builtin/fast-import.c  |  2 +-
 bulk-checkin.c         |  9 ++++++---
 csum-file.c            | 40 +++++++++++++++++++++++++---------------
 csum-file.h            |  2 ++
 hash.h                 | 20 +++++---------------
 object-file.c          | 41 ++++++++++++++++++++++++++---------------
 t/helper/test-hash.c   |  4 +++-
 t/helper/test-sha1.c   |  7 ++++++-
 t/helper/test-sha1.sh  | 38 ++++++++++++++++++++++----------------
 t/helper/test-sha256.c |  2 +-
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  3 ++-
 12 files changed, 100 insertions(+), 69 deletions(-)

Range-diff against v1:
2:  d8c1fc78b57 ! 1:  4c1523a04f1 t/helper/test-tool: implement sha1-unsafe helper
    @@ Metadata
      ## Commit message ##
         t/helper/test-tool: implement sha1-unsafe helper
     
    -    Add a new helper similar to 't/helper/test-tool sha1' called instead
    -    "sha1-unsafe" which uses the unsafe variant of Git's SHA-1 wrappers.
    +    With the new "unsafe" SHA-1 build knob, it is convenient to have a
    +    test-tool that can exercise Git's unsafe SHA-1 wrappers for testing,
    +    similar to 't/helper/test-tool sha1'.
     
    -    While we're at it, modify the test-sha1.sh script to exercise both
    -    the sha1 and sha1-unsafe test tools to ensure that both produce the
    -    expected hash values.
    +    Implement that helper by altering the implementation of that test-tool
    +    (in cmd_hash_impl(), which is generic and parameterized over different
    +    hash functions) to conditionally run the unsafe variants of the chosen
    +    hash function, and expose the new behavior via a new 'sha1-unsafe' test
    +    helper.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    + ## t/helper/test-hash.c ##
    +@@
    + #include "test-tool.h"
    + #include "hex.h"
    + 
    +-int cmd_hash_impl(int ac, const char **av, int algo)
    ++int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
    + {
    + 	git_hash_ctx ctx;
    + 	unsigned char hash[GIT_MAX_HEXSZ];
    +@@ t/helper/test-hash.c: int cmd_hash_impl(int ac, const char **av, int algo)
    + 			die("OOPS");
    + 	}
    + 
    +-	algop->init_fn(&ctx);
    ++	if (unsafe)
    ++		algop->unsafe_init_fn(&ctx);
    ++	else
    ++		algop->init_fn(&ctx);
    + 
    + 	while (1) {
    + 		ssize_t sz, this_sz;
    +@@ t/helper/test-hash.c: int cmd_hash_impl(int ac, const char **av, int algo)
    + 		}
    + 		if (this_sz == 0)
    + 			break;
    +-		algop->update_fn(&ctx, buffer, this_sz);
    ++		if (unsafe)
    ++			algop->unsafe_update_fn(&ctx, buffer, this_sz);
    ++		else
    ++			algop->update_fn(&ctx, buffer, this_sz);
    + 	}
    +-	algop->final_fn(hash, &ctx);
    ++	if (unsafe)
    ++		algop->unsafe_final_fn(hash, &ctx);
    ++	else
    ++		algop->final_fn(hash, &ctx);
    + 
    + 	if (binary)
    + 		fwrite(hash, 1, algop->rawsz, stdout);
    +
      ## t/helper/test-sha1.c ##
    +@@
    + 
    + int cmd__sha1(int ac, const char **av)
    + {
    +-	return cmd_hash_impl(ac, av, GIT_HASH_SHA1);
    ++	return cmd_hash_impl(ac, av, GIT_HASH_SHA1, 0);
    + }
    + 
    + int cmd__sha1_is_sha1dc(int argc UNUSED, const char **argv UNUSED)
     @@ t/helper/test-sha1.c: int cmd__sha1_is_sha1dc(int argc UNUSED, const char **argv UNUSED)
      #endif
      	return 1;
    @@ t/helper/test-sha1.sh
      da39a3ee5e6b4b0d3255bfef95601890afd80709 0
      3f786850e387550fdab836ed7e6dc881de23001b 0 a
     
    + ## t/helper/test-sha256.c ##
    +@@
    + 
    + int cmd__sha256(int ac, const char **av)
    + {
    +-	return cmd_hash_impl(ac, av, GIT_HASH_SHA256);
    ++	return cmd_hash_impl(ac, av, GIT_HASH_SHA256, 0);
    + }
    +
      ## t/helper/test-tool.c ##
     @@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
      	{ "serve-v2", cmd__serve_v2 },
    @@ t/helper/test-tool.h: int cmd__scrap_cache_tree(int argc, const char **argv);
      int cmd__sha256(int argc, const char **argv);
      int cmd__sigchain(int argc, const char **argv);
      int cmd__simple_ipc(int argc, const char **argv);
    +@@ t/helper/test-tool.h: int cmd__windows_named_pipe(int argc, const char **argv);
    + #endif
    + int cmd__write_cache(int argc, const char **argv);
    + 
    +-int cmd_hash_impl(int ac, const char **av, int algo);
    ++int cmd_hash_impl(int ac, const char **av, int algo, int unsafe);
    + 
    + #endif
3:  380133a1142 = 2:  99cc44895b5 csum-file: store the hash algorithm as a struct field
4:  e5076f003bf = 3:  1ffab2f8289 csum-file.c: extract algop from hashfile_checksum_valid()
5:  17f92dba34b = 4:  99dcbe2e716 hash.h: introduce `unsafe_hash_algo()`
6:  0d8e12599e2 = 5:  2dcc2aa6803 csum-file.c: use unsafe_hash_algo()
7:  a49a41703e2 = 6:  a2b9ef03080 t/helper/test-hash.c: use unsafe_hash_algo()
1:  0e2fcee6894 ! 7:  94c07fd8a55 t/helper/test-sha1: prepare for an unsafe mode
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    t/helper/test-sha1: prepare for an unsafe mode
    +    csum-file: introduce hashfile_checkpoint_init()
     
    -    With the new "unsafe" SHA-1 build knob, it would be convenient to have
    -    a test-tool that can exercise Git's unsafe SHA-1 wrappers for testing,
    -    similar to 't/helper/test-tool sha1'.
    +    In 106140a99f (builtin/fast-import: fix segfault with unsafe SHA1
    +    backend, 2024-12-30) and 9218c0bfe1 (bulk-checkin: fix segfault with
    +    unsafe SHA1 backend, 2024-12-30), we observed the effects of failing to
    +    initialize a hashfile_checkpoint with the same hash function
    +    implementation as is used by the hashfile it is used to checkpoint.
     
    -    Prepare for such a helper by altering the implementation of that
    -    test-tool (in cmd_hash_impl(), which is generic and parameterized over
    -    different hash functions) to conditionally run the unsafe variants of
    -    the chosen hash function.
    +    While both 106140a99f and 9218c0bfe1 work around the immediate crash,
    +    changing the hash function implementation within the hashfile API to,
    +    for example, the non-unsafe variant would re-introduce the crash. This
    +    is a result of the tight coupling between initializing hashfiles and
    +    hashfile_checkpoints.
     
    -    The following commit will add a new test-tool which makes use of this
    -    new parameter.
    +    Introduce and use a new function which ensures that both parts of a
    +    hashfile and hashfile_checkpoint pair use the same hash function
    +    implementation to avoid such crashes.
     
    +    A few things worth noting:
    +
    +      - In the change to builtin/fast-import.c::stream_blob(), we can see
    +        that by removing the explicit reference to
    +        'the_hash_algo->unsafe_init_fn()', we are hardened against the
    +        hashfile API changing away from the_hash_algo (or its unsafe
    +        variant) in the future.
    +
    +      - The bulk-checkin code no longer needs to explicitly zero-initialize
    +        the hashfile_checkpoint, since it is now done as a result of calling
    +        'hashfile_checkpoint_init()'.
    +
    +      - Also in the bulk-checkin code, we add an additional call to
    +        prepare_to_stream() outside of the main loop in order to initialize
    +        'state->f' so we know which hash function implementation to use when
    +        calling 'hashfile_checkpoint_init()'.
    +
    +        This is OK, since subsequent 'prepare_to_stream()' calls are noops.
    +        However, we only need to call 'prepare_to_stream()' when we have the
    +        HASH_WRITE_OBJECT bit set in our flags. Without that bit, calling
    +        'prepare_to_stream()' does not assign 'state->f', so we have nothing
    +        to initialize.
    +
    +      - Other uses of the 'checkpoint' in 'deflate_blob_to_pack()' are
    +        appropriately guarded.
    +
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    - ## t/helper/test-hash.c ##
    -@@
    - #include "test-tool.h"
    - #include "hex.h"
    + ## builtin/fast-import.c ##
    +@@ builtin/fast-import.c: static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
    + 		|| (pack_size + PACK_SIZE_THRESHOLD + len) < pack_size)
    + 		cycle_packfile();
      
    --int cmd_hash_impl(int ac, const char **av, int algo)
    -+int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
    - {
    +-	the_hash_algo->unsafe_init_fn(&checkpoint.ctx);
    ++	hashfile_checkpoint_init(pack_file, &checkpoint);
    + 	hashfile_checkpoint(pack_file, &checkpoint);
    + 	offset = checkpoint.offset;
    + 
    +
    + ## bulk-checkin.c ##
    +@@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
      	git_hash_ctx ctx;
    - 	unsigned char hash[GIT_MAX_HEXSZ];
    -@@ t/helper/test-hash.c: int cmd_hash_impl(int ac, const char **av, int algo)
    - 			die("OOPS");
    - 	}
    + 	unsigned char obuf[16384];
    + 	unsigned header_len;
    +-	struct hashfile_checkpoint checkpoint = {0};
    ++	struct hashfile_checkpoint checkpoint;
    + 	struct pack_idx_entry *idx = NULL;
      
    --	algop->init_fn(&ctx);
    -+	if (unsafe)
    -+		algop->unsafe_init_fn(&ctx);
    -+	else
    -+		algop->init_fn(&ctx);
    + 	seekback = lseek(fd, 0, SEEK_CUR);
    +@@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
    + 					  OBJ_BLOB, size);
    + 	the_hash_algo->init_fn(&ctx);
    + 	the_hash_algo->update_fn(&ctx, obuf, header_len);
    +-	the_hash_algo->unsafe_init_fn(&checkpoint.ctx);
    + 
    + 	/* Note: idx is non-NULL when we are writing */
    +-	if ((flags & HASH_WRITE_OBJECT) != 0)
    ++	if ((flags & HASH_WRITE_OBJECT) != 0) {
    + 		CALLOC_ARRAY(idx, 1);
    + 
    ++		prepare_to_stream(state, flags);
    ++		hashfile_checkpoint_init(state->f, &checkpoint);
    ++	}
    ++
    + 	already_hashed_to = 0;
      
      	while (1) {
    - 		ssize_t sz, this_sz;
    -@@ t/helper/test-hash.c: int cmd_hash_impl(int ac, const char **av, int algo)
    - 		}
    - 		if (this_sz == 0)
    - 			break;
    --		algop->update_fn(&ctx, buffer, this_sz);
    -+		if (unsafe)
    -+			algop->unsafe_update_fn(&ctx, buffer, this_sz);
    -+		else
    -+			algop->update_fn(&ctx, buffer, this_sz);
    - 	}
    --	algop->final_fn(hash, &ctx);
    -+	if (unsafe)
    -+		algop->unsafe_final_fn(hash, &ctx);
    -+	else
    -+		algop->final_fn(hash, &ctx);
    - 
    - 	if (binary)
    - 		fwrite(hash, 1, algop->rawsz, stdout);
     
    - ## t/helper/test-sha1.c ##
    -@@
    - 
    - int cmd__sha1(int ac, const char **av)
    - {
    --	return cmd_hash_impl(ac, av, GIT_HASH_SHA1);
    -+	return cmd_hash_impl(ac, av, GIT_HASH_SHA1, 0);
    + ## csum-file.c ##
    +@@ csum-file.c: struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp
    + 	return hashfd_internal(fd, name, tp, 8 * 1024);
      }
      
    - int cmd__sha1_is_sha1dc(int argc UNUSED, const char **argv UNUSED)
    -
    - ## t/helper/test-sha256.c ##
    -@@
    - 
    - int cmd__sha256(int ac, const char **av)
    ++void hashfile_checkpoint_init(struct hashfile *f,
    ++			      struct hashfile_checkpoint *checkpoint)
    ++{
    ++	memset(checkpoint, 0, sizeof(*checkpoint));
    ++	f->algop->init_fn(&checkpoint->ctx);
    ++}
    ++
    + void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
      {
    --	return cmd_hash_impl(ac, av, GIT_HASH_SHA256);
    -+	return cmd_hash_impl(ac, av, GIT_HASH_SHA256, 0);
    - }
    + 	hashflush(f);
     
    - ## t/helper/test-tool.h ##
    -@@ t/helper/test-tool.h: int cmd__windows_named_pipe(int argc, const char **argv);
    - #endif
    - int cmd__write_cache(int argc, const char **argv);
    + ## csum-file.h ##
    +@@ csum-file.h: struct hashfile_checkpoint {
    + 	git_hash_ctx ctx;
    + };
      
    --int cmd_hash_impl(int ac, const char **av, int algo);
    -+int cmd_hash_impl(int ac, const char **av, int algo, int unsafe);
    ++void hashfile_checkpoint_init(struct hashfile *, struct hashfile_checkpoint *);
    + void hashfile_checkpoint(struct hashfile *, struct hashfile_checkpoint *);
    + int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint *);
      
    - #endif
8:  4081ad08549 = 8:  f5579883816 hash.h: drop unsafe_ function variants

base-commit: 14650065b76b28d3cfa9453356ac5669b19e706e
-- 
2.48.0.rc2.33.gaab3d23ed4c
