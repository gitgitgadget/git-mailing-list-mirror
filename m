Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDBF1B012D
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641764; cv=none; b=K1b295x3oqiug29LhJVXoOFeIT0wrJbn91txIqxdwDc8iL/ScWi6VXMJbzykngOW469Ag3PIhjsDP61r/J0opK4oFV88AGkLhB5X5BEkYAq5J3PNAZah1LVRSPvQoaHBsG66HjQBB6K/UwRLHq6nhuwuuXZkZcovvBzgRkrvGs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641764; c=relaxed/simple;
	bh=jtj4pplmpq8U7D+6ROkDfmKQ4Mw3B22dY+LoXewQtA0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g+V3lhylZV1Mn/f54lIrGdeW4MlCYQZDtT7r777mAnN3InRDA6eKYlUQ0faVKWu2fTr5s7XaOSFHhORHuA33nTC1sAUluGPIeFh2sQ1+5ZT5zOQwPHDgqQKUYDnxnDCKERH8keYKw7oFO2MthzX0MPzxzclWtCz0JXgd+bzIS9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rnq15gON; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JTHLkech; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rnq15gON";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JTHLkech"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 18CA1138F9EB;
	Wed, 14 Aug 2024 09:22:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 14 Aug 2024 09:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1723641761; x=1723728161; bh=NGS+h4gdrQ06nnks7EkCMdEx4yoyj/rH
	NppXkzh3ng0=; b=Rnq15gONq65szPKhY5pjWWGLPfvgX3nZGxn8rS2K4SALHRlJ
	AkcLDTWdHokrD3UXjC3ujUAI96A6tHK9LbCD1X1R2SNi1RRPP5H0hrWAffXsockm
	bURgID2loqld3QdMRym4euIcqbRfKNmBNyBlwoAw0wyiadw7Hl9kbZw+JH0pgque
	iS04aT6yFjGXi+gXCh0Jg4uEk9tkn4HbfLQ3GJv+V/EPcag9PsgnS2lTfpmxQzFN
	Gxzx4t849Oy05FJvRRkxhzyzmB5uk4t+ugRy19WF7kk73IBovPdOckt9ymWHXFfl
	j9lcRHPuf5iiwP26nOAS/J1c20LSs1ZRbqpWVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1723641761; x=1723728161; bh=NGS+h4gdrQ06nnks7EkCMdEx4yoyj/rHNpp
	Xkzh3ng0=; b=JTHLkechOn4vEYw0HGBh3a/fKKkAKtegFNMfeBvpLqxfEm8pgOV
	/1b3KJvjVwfnZ3Ht+kml12KaJ/fGQGiiAf2zrE/PBSlzNmZv9z6DwFqjGxZciP3w
	bBmgGKbBdf4A8DYQ+ofxutP1wmg+lZ+UV0DUY+d+rskBipl9DMN9S8+2kmNuacwx
	dKF+rG2clbbp37EIR31OL9Cy1jfVNoYB5kd4mmCPXKfnM7Ok981Iqt8C2+/wF7Lr
	Z6yFR554Io70DUJLU/JWvpBRLa3JpR9w4unfRXe42zf1Zj8Q5fMKft7nXBT7UK2t
	62eWWdYr2KOAykw2STPoEkQv4cOZFbf3ZGA==
X-ME-Sender: <xms:oK-8ZnxmtBy6RH9T7HmEZ6fsE8acCXa0SUMrBiS3PMo2dadn0DIlpw>
    <xme:oK-8ZvQmKZcup5JgfBzx-XgPaCCZ3HGfJQBhJ_8CoLHULy5gbHe3eUEC7BJXajv_j
    7-Pe6FgnbwjBjucMg>
X-ME-Received: <xmr:oK-8ZhUm1c0DH7MJeqJANpSm0YBav6CroDaw1KbrjJJtduz8pFXZQsqIJ9b9wCiA-5Yedhz3cuOfOalxNPKJv09ghC1Qy5kLc1YC2qFYgP_OyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkgggtugesthdtredttddtvdenucfh
    rhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqne
    cuggftrfgrthhtvghrnhepgffffeetgeduuddvudevueelieehvddujeeliefgledtvedt
    jeethfeigfeiteevnecuffhomhgrihhnpehvrghlvddrthgrrhhgvghtpdhuphgurghtvg
    drnhgrmhgvpdhuphgurghtvgdrvghmrghilhdpuhhpuggrthgvrdhtiidpuhhpuggrthgv
    rdhnvgifnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:oK-8ZhiBN7prJrivoAG1dig6xqLLnFtFUuI0hZJdYg0i5MSggwVOdA>
    <xmx:oa-8ZpBLATa-wujm4I6QR1hRVV76IiZW7SFvjNMYOlcdjiUhkwH1jA>
    <xmx:oa-8ZqIoFzJJ_g3OkotfIqttfmjBr8NyuBiKH-XLybDNw6SPWPPcPg>
    <xmx:oa-8ZoBqU4Y0iu13VLi4JktzPAX5ac8RGGSF3WT-MIdCGl_P9-mptg>
    <xmx:oa-8ZsM6tNxFW1kZtRDCjujqsFaeJFbvJ7R7pV-iZlPbN7MllCi6iyeq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:22:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6aa3ffb2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 13:22:19 +0000 (UTC)
Date: Wed, 14 Aug 2024 15:22:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 00/15] reftable: drop generic `reftable_table` interface
Message-ID: <cover.1723640107.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

this is the second version of my patch series that gets rid of the
generic `reftable_table` interface. It made it way harder to understand
the reftable code base and is not really required nowadays anymore where
we have generic re-seekable reftable iterators.

Changes compared to v1:

  - Fix some commit message typos.

  - Remove some braces while at it.

  - Drop the "-c" switch from the test-tool's help output.

  - Restore printing-related functionality, but move all of it into the
    test-helper. It has no reason to exist in the reftable library.

Thanks!

Patrick

Patrick Steinhardt (15):
  reftable/merged: expose functions to initialize iterators
  reftable/merged: rename `reftable_new_merged_table()`
  reftable/merged: stop using generic tables in the merged table
  reftable/stack: open-code reading refs
  reftable/iter: drop double-checking logic
  reftable/generic: move generic iterator code into iterator interface
  reftable/dump: drop unused `compact_stack()`
  t/helper: inline `reftable_dump_main()`
  t/helper: inline `reftable_reader_print_file()`
  t/helper: inline `reftable_stack_print_directory()`
  t/helper: inline `reftable_table_print()`
  t/helper: inline printing of reftable records
  t/helper: use `hash_to_hex_algop()` to print hashes
  t/helper: refactor to not use `struct reftable_table`
  reftable/generic: drop interface

 Makefile                         |   2 -
 reftable/dump.c                  | 111 ---------------
 reftable/generic.c               | 229 -------------------------------
 reftable/generic.h               |  37 -----
 reftable/iter.c                  | 126 ++++++++++++++---
 reftable/iter.h                  |  30 +++-
 reftable/merged.c                |  72 ++++------
 reftable/merged.h                |   4 +-
 reftable/reader.c                |  70 +---------
 reftable/reader.h                |   4 +
 reftable/record.c                | 127 -----------------
 reftable/record.h                |   1 -
 reftable/reftable-generic.h      |  47 -------
 reftable/reftable-merged.h       |  26 ++--
 reftable/reftable-reader.h       |   9 --
 reftable/reftable-record.h       |   8 --
 reftable/reftable-stack.h        |   3 -
 reftable/reftable-tests.h        |   1 -
 reftable/stack.c                 |  94 ++++++-------
 reftable/stack_test.c            |  29 ++--
 t/helper/test-reftable.c         | 189 ++++++++++++++++++++++++-
 t/unit-tests/t-reftable-merged.c |  17 +--
 22 files changed, 422 insertions(+), 814 deletions(-)
 delete mode 100644 reftable/dump.c
 delete mode 100644 reftable/generic.c
 delete mode 100644 reftable/generic.h
 delete mode 100644 reftable/reftable-generic.h

Range-diff against v1:
 1:  404d64effd =  1:  472c169b50 reftable/merged: expose functions to initialize iterators
 2:  511416fb73 =  2:  bc6f1cd8c1 reftable/merged: rename `reftable_new_merged_table()`
 3:  86e2f9f5dc =  3:  58e91ab4b3 reftable/merged: stop using generic tables in the merged table
 4:  d5d24e03bd =  4:  6ba3fcee41 reftable/stack: open-code reading refs
 5:  ab7538d0bb !  5:  cac08a934c reftable/iter: drop double-checking logic
    @@ Commit message
     
         The filtering ref iterator can be used to only yield refs which are not
         in a specific skip list. This iterator has an option to double-check the
    -    results it returns, which causes us to seek tho reference we are about
    +    results it returns, which causes us to seek the reference we are about
         to yield via a separate table such that we detect whether the reference
         that the first iterator has yielded actually exists.
     
 6:  14924604ce !  6:  103262dc79 reftable/generic: move generic iterator code into iterator interface
    @@ Commit message
         Move functions relating to the reftable iterator from "generic.c" into
         "iter.c". This prepares for the removal of the former subsystem.
     
    +    While at it, remove some unneeded braces to conform to our coding style.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## reftable/generic.c ##
    @@ reftable/iter.c: void iterator_from_indexed_table_ref_iter(struct reftable_itera
     +
     +void reftable_iterator_destroy(struct reftable_iterator *it)
     +{
    -+	if (!it->ops) {
    ++	if (!it->ops)
     +		return;
    -+	}
     +	it->ops->close(it->iter_arg);
     +	it->ops = NULL;
     +	FREE_AND_NULL(it->iter_arg);
 -:  ---------- >  7:  4011fa65d8 reftable/dump: drop unused `compact_stack()`
 9:  4184f46f92 !  8:  ceaa296bfd reftable/dump: move code into "t/helper/test-reftable.c"
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    reftable/dump: move code into "t/helper/test-reftable.c"
    +    t/helper: inline `reftable_dump_main()`
     
    -    The code in "reftable/dump.c" is only ever used by our test-tool to
    -    implement the "reftable" subcommand. It also feels very unlikely that it
    -    will ever be useful to any other potential user of the reftable library,
    -    which makes it a weird candidate to have in the library interface.
    +    The printing functionality part of `reftable/dump.c` is really only used
    +    by our "dump-reftable" test helper. It is certainly not generic logic
    +    that is useful to anybody outside of Git, and the format it generates is
    +    quite specific. Still, parts of it are used in our test suite and the
    +    output may be useful to take a peek into reftable stacks, tables and
    +    blocks. So while it does not make sense to expose this as part of the
    +    reftable library, it does make sense to keep it around.
     
    -    Inline the code into "t/helper/test-reftable.c".
    +    Inline the `reftable_dump_main()` function into the "dump-reftable" test
    +    helper. This clarifies that its format is subject to change and not part
    +    of our public interface. Furthermore, this allows us to iterate on the
    +    implementation in subsequent patches.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ reftable/dump.c (deleted)
     -
     -static void print_help(void)
     -{
    --	printf("usage: dump [-cst] arg\n\n"
    +-	printf("usage: dump [-st] arg\n\n"
     -	       "options: \n"
    --	       "  -c compact\n"
     -	       "  -b dump blocks\n"
     -	       "  -t dump table\n"
     -	       "  -s dump stack\n"
    @@ reftable/dump.c (deleted)
     -{
     -	int err = 0;
     -	int opt_dump_blocks = 0;
    +-	int opt_dump_table = 0;
    +-	int opt_dump_stack = 0;
    +-	uint32_t opt_hash_id = GIT_SHA1_FORMAT_ID;
     -	const char *arg = NULL, *argv0 = argv[0];
     -
     -	for (; argc > 1; argv++, argc--)
    @@ reftable/dump.c (deleted)
     -			break;
     -		else if (!strcmp("-b", argv[1]))
     -			opt_dump_blocks = 1;
    +-		else if (!strcmp("-t", argv[1]))
    +-			opt_dump_table = 1;
    +-		else if (!strcmp("-6", argv[1]))
    +-			opt_hash_id = GIT_SHA256_FORMAT_ID;
    +-		else if (!strcmp("-s", argv[1]))
    +-			opt_dump_stack = 1;
     -		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
     -			print_help();
     -			return 2;
    @@ reftable/dump.c (deleted)
     -
     -	arg = argv[1];
     -
    --	if (opt_dump_blocks)
    +-	if (opt_dump_blocks) {
     -		err = reftable_reader_print_blocks(arg);
    +-	} else if (opt_dump_table) {
    +-		err = reftable_reader_print_file(arg);
    +-	} else if (opt_dump_stack) {
    +-		err = reftable_stack_print_directory(arg, opt_hash_id);
    +-	}
     -
     -	if (err < 0) {
     -		fprintf(stderr, "%s: %s: %s\n", argv0, arg,
    @@ reftable/dump.c (deleted)
     -	return 0;
     -}
     
    + ## reftable/reftable-tests.h ##
    +@@ reftable/reftable-tests.h: int record_test_main(int argc, const char **argv);
    + int readwrite_test_main(int argc, const char **argv);
    + int stack_test_main(int argc, const char **argv);
    + int tree_test_main(int argc, const char **argv);
    +-int reftable_dump_main(int argc, char *const *argv);
    + 
    + #endif
    +
      ## t/helper/test-reftable.c ##
     @@
      #include "reftable/system.h"
     +#include "reftable/reftable-error.h"
     +#include "reftable/reftable-reader.h"
    ++#include "reftable/reftable-stack.h"
      #include "reftable/reftable-tests.h"
      #include "test-tool.h"
      
    @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
      
     +static void print_help(void)
     +{
    -+	printf("usage: dump [-cst] arg\n\n"
    ++	printf("usage: dump [-st] arg\n\n"
     +	       "options: \n"
    -+	       "  -c compact\n"
     +	       "  -b dump blocks\n"
     +	       "  -t dump table\n"
     +	       "  -s dump stack\n"
    @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
     -	return reftable_dump_main(argc, (char *const *)argv);
     +	int err = 0;
     +	int opt_dump_blocks = 0;
    ++	int opt_dump_table = 0;
    ++	int opt_dump_stack = 0;
    ++	uint32_t opt_hash_id = GIT_SHA1_FORMAT_ID;
     +	const char *arg = NULL, *argv0 = argv[0];
     +
     +	for (; argc > 1; argv++, argc--)
    @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
     +			break;
     +		else if (!strcmp("-b", argv[1]))
     +			opt_dump_blocks = 1;
    ++		else if (!strcmp("-t", argv[1]))
    ++			opt_dump_table = 1;
    ++		else if (!strcmp("-6", argv[1]))
    ++			opt_hash_id = GIT_SHA256_FORMAT_ID;
    ++		else if (!strcmp("-s", argv[1]))
    ++			opt_dump_stack = 1;
     +		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
     +			print_help();
     +			return 2;
    @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
     +
     +	arg = argv[1];
     +
    -+	if (opt_dump_blocks)
    ++	if (opt_dump_blocks) {
     +		err = reftable_reader_print_blocks(arg);
    ++	} else if (opt_dump_table) {
    ++		err = reftable_reader_print_file(arg);
    ++	} else if (opt_dump_stack) {
    ++		err = reftable_stack_print_directory(arg, opt_hash_id);
    ++	}
     +
     +	if (err < 0) {
     +		fprintf(stderr, "%s: %s: %s\n", argv0, arg,
 -:  ---------- >  9:  a62e4612e9 t/helper: inline `reftable_reader_print_file()`
 -:  ---------- > 10:  7acfe4fecc t/helper: inline `reftable_stack_print_directory()`
 7:  0aa7186067 ! 11:  8bd53a1a65 reftable/dump: drop unused `compact_stack()`
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    reftable/dump: drop unused `compact_stack()`
    +    t/helper: inline `reftable_table_print()`
     
    -    The `compact_stack()` function is exposed via `reftable_dump_main()`,
    -    which ultimately ends up being wired into "test-tool reftable". It is
    -    never used by our tests though, and nowadays we have wired up support
    -    for stack compaction into git-pack-refs(1).
    -
    -    Remove the code.
    +    Move `reftable_table_print()` into the "dump-reftable" helper. This
    +    follows the same reasoning as the preceding commit.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    - ## reftable/dump.c ##
    -@@ reftable/dump.c: license that can be found in the LICENSE file or at
    - #include <unistd.h>
    - #include <string.h>
    + ## reftable/generic.c ##
    +@@ reftable/generic.c: int reftable_table_read_ref(struct reftable_table *tab, const char *name,
    + 	return err;
    + }
      
    --static int compact_stack(const char *stackdir)
    --{
    --	struct reftable_stack *stack = NULL;
    --	struct reftable_write_options opts = { 0 };
    +-int reftable_table_print(struct reftable_table *tab) {
    +-	struct reftable_iterator it = { NULL };
    +-	struct reftable_ref_record ref = { NULL };
    +-	struct reftable_log_record log = { NULL };
    +-	uint32_t hash_id = reftable_table_hash_id(tab);
    +-	int err;
    +-
    +-	reftable_table_init_ref_iter(tab, &it);
     -
    --	int err = reftable_new_stack(&stack, stackdir, &opts);
    +-	err = reftable_iterator_seek_ref(&it, "");
     -	if (err < 0)
    --		goto done;
    +-		return err;
    +-
    +-	while (1) {
    +-		err = reftable_iterator_next_ref(&it, &ref);
    +-		if (err > 0) {
    +-			break;
    +-		}
    +-		if (err < 0) {
    +-			return err;
    +-		}
    +-		reftable_ref_record_print(&ref, hash_id);
    +-	}
    +-	reftable_iterator_destroy(&it);
    +-	reftable_ref_record_release(&ref);
    +-
    +-	reftable_table_init_log_iter(tab, &it);
     -
    --	err = reftable_stack_compact_all(stack, NULL);
    +-	err = reftable_iterator_seek_log(&it, "");
     -	if (err < 0)
    --		goto done;
    --done:
    --	if (stack) {
    --		reftable_stack_destroy(stack);
    +-		return err;
    +-
    +-	while (1) {
    +-		err = reftable_iterator_next_log(&it, &log);
    +-		if (err > 0) {
    +-			break;
    +-		}
    +-		if (err < 0) {
    +-			return err;
    +-		}
    +-		reftable_log_record_print(&log, hash_id);
     -	}
    --	return err;
    +-	reftable_iterator_destroy(&it);
    +-	reftable_log_record_release(&log);
    +-	return 0;
     -}
     -
    - static void print_help(void)
    + uint64_t reftable_table_max_update_index(struct reftable_table *tab)
    + {
    + 	return tab->ops->max_update_index(tab->table_arg);
    +
    + ## reftable/reftable-generic.h ##
    +@@ reftable/reftable-generic.h: uint64_t reftable_table_min_update_index(struct reftable_table *tab);
    + int reftable_table_read_ref(struct reftable_table *tab, const char *name,
    + 			    struct reftable_ref_record *ref);
    + 
    +-/* dump table contents onto stdout for debugging */
    +-int reftable_table_print(struct reftable_table *tab);
    +-
    + #endif
    +
    + ## t/helper/test-reftable.c ##
    +@@ t/helper/test-reftable.c: static void print_help(void)
    + 	       "\n");
    + }
    + 
    ++static int dump_table(struct reftable_table *tab)
    ++{
    ++	struct reftable_iterator it = { NULL };
    ++	struct reftable_ref_record ref = { NULL };
    ++	struct reftable_log_record log = { NULL };
    ++	uint32_t hash_id = reftable_table_hash_id(tab);
    ++	int err;
    ++
    ++	reftable_table_init_ref_iter(tab, &it);
    ++
    ++	err = reftable_iterator_seek_ref(&it, "");
    ++	if (err < 0)
    ++		return err;
    ++
    ++	while (1) {
    ++		err = reftable_iterator_next_ref(&it, &ref);
    ++		if (err > 0) {
    ++			break;
    ++		}
    ++		if (err < 0) {
    ++			return err;
    ++		}
    ++		reftable_ref_record_print(&ref, hash_id);
    ++	}
    ++	reftable_iterator_destroy(&it);
    ++	reftable_ref_record_release(&ref);
    ++
    ++	reftable_table_init_log_iter(tab, &it);
    ++
    ++	err = reftable_iterator_seek_log(&it, "");
    ++	if (err < 0)
    ++		return err;
    ++
    ++	while (1) {
    ++		err = reftable_iterator_next_log(&it, &log);
    ++		if (err > 0) {
    ++			break;
    ++		}
    ++		if (err < 0) {
    ++			return err;
    ++		}
    ++		reftable_log_record_print(&log, hash_id);
    ++	}
    ++	reftable_iterator_destroy(&it);
    ++	reftable_log_record_release(&log);
    ++	return 0;
    ++}
    ++
    + static int dump_stack(const char *stackdir, uint32_t hash_id)
      {
    - 	printf("usage: dump [-cst] arg\n\n"
    -@@ reftable/dump.c: int reftable_dump_main(int argc, char *const *argv)
    - 	int opt_dump_blocks = 0;
    - 	int opt_dump_table = 0;
    - 	int opt_dump_stack = 0;
    --	int opt_compact = 0;
    - 	uint32_t opt_hash_id = GIT_SHA1_FORMAT_ID;
    - 	const char *arg = NULL, *argv0 = argv[0];
    + 	struct reftable_stack *stack = NULL;
    +@@ t/helper/test-reftable.c: static int dump_stack(const char *stackdir, uint32_t hash_id)
      
    -@@ reftable/dump.c: int reftable_dump_main(int argc, char *const *argv)
    - 			opt_hash_id = GIT_SHA256_FORMAT_ID;
    - 		else if (!strcmp("-s", argv[1]))
    - 			opt_dump_stack = 1;
    --		else if (!strcmp("-c", argv[1]))
    --			opt_compact = 1;
    - 		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
    - 			print_help();
    - 			return 2;
    -@@ reftable/dump.c: int reftable_dump_main(int argc, char *const *argv)
    - 		err = reftable_reader_print_file(arg);
    - 	} else if (opt_dump_stack) {
    - 		err = reftable_stack_print_directory(arg, opt_hash_id);
    --	} else if (opt_compact) {
    --		err = compact_stack(arg);
    - 	}
    + 	merged = reftable_stack_merged_table(stack);
    + 	reftable_table_from_merged_table(&table, merged);
    +-	err = reftable_table_print(&table);
    ++	err = dump_table(&table);
    + done:
    + 	if (stack)
    + 		reftable_stack_destroy(stack);
    +@@ t/helper/test-reftable.c: static int dump_reftable(const char *tablename)
    + 		goto done;
      
    - 	if (err < 0) {
    + 	reftable_table_from_reader(&tab, r);
    +-	err = reftable_table_print(&tab);
    ++	err = dump_table(&tab);
    + done:
    + 	reftable_reader_free(r);
    + 	return err;
 8:  1f211e514d ! 12:  c50aabbb80 reftable/dump: drop unused printing functionality
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    reftable/dump: drop unused printing functionality
    +    t/helper: inline printing of reftable records
     
    -    We have a bunch of infrastructure wired up that allows us to print
    -    reftable records, tables and stacks. While this functionality is wired
    -    up via various "test-tool reftable" options, it is never used. It also
    -    feels kind of dubious whether any other eventual user of the reftable
    -    library should use it as it very much feels like a debugging aid rather
    -    than something sensible. The format itself is somewhat inscrutable and
    -    the infrastructure is non-extensible.
    -
    -    Drop this code. The only remaining function in this context is
    -    `reftable_reader_print_blocks()`, which we do use in our tests.
    +    Move printing of reftable records into the "dump-reftable" helper. This
    +    follows the same reasoning as the preceding commit.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    - ## reftable/dump.c ##
    -@@ reftable/dump.c: int reftable_dump_main(int argc, char *const *argv)
    - {
    - 	int err = 0;
    - 	int opt_dump_blocks = 0;
    --	int opt_dump_table = 0;
    --	int opt_dump_stack = 0;
    --	uint32_t opt_hash_id = GIT_SHA1_FORMAT_ID;
    - 	const char *arg = NULL, *argv0 = argv[0];
    - 
    - 	for (; argc > 1; argv++, argc--)
    -@@ reftable/dump.c: int reftable_dump_main(int argc, char *const *argv)
    - 			break;
    - 		else if (!strcmp("-b", argv[1]))
    - 			opt_dump_blocks = 1;
    --		else if (!strcmp("-t", argv[1]))
    --			opt_dump_table = 1;
    --		else if (!strcmp("-6", argv[1]))
    --			opt_hash_id = GIT_SHA256_FORMAT_ID;
    --		else if (!strcmp("-s", argv[1]))
    --			opt_dump_stack = 1;
    - 		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
    - 			print_help();
    - 			return 2;
    -@@ reftable/dump.c: int reftable_dump_main(int argc, char *const *argv)
    - 
    - 	arg = argv[1];
    - 
    --	if (opt_dump_blocks) {
    -+	if (opt_dump_blocks)
    - 		err = reftable_reader_print_blocks(arg);
    --	} else if (opt_dump_table) {
    --		err = reftable_reader_print_file(arg);
    --	} else if (opt_dump_stack) {
    --		err = reftable_stack_print_directory(arg, opt_hash_id);
    --	}
    - 
    - 	if (err < 0) {
    - 		fprintf(stderr, "%s: %s: %s\n", argv0, arg,
    -
    - ## reftable/generic.c ##
    -@@ reftable/generic.c: int reftable_table_read_ref(struct reftable_table *tab, const char *name,
    - 	return err;
    - }
    - 
    --int reftable_table_print(struct reftable_table *tab) {
    --	struct reftable_iterator it = { NULL };
    --	struct reftable_ref_record ref = { NULL };
    --	struct reftable_log_record log = { NULL };
    --	uint32_t hash_id = reftable_table_hash_id(tab);
    --	int err;
    --
    --	reftable_table_init_ref_iter(tab, &it);
    --
    --	err = reftable_iterator_seek_ref(&it, "");
    --	if (err < 0)
    --		return err;
    --
    --	while (1) {
    --		err = reftable_iterator_next_ref(&it, &ref);
    --		if (err > 0) {
    --			break;
    --		}
    --		if (err < 0) {
    --			return err;
    --		}
    --		reftable_ref_record_print(&ref, hash_id);
    --	}
    --	reftable_iterator_destroy(&it);
    --	reftable_ref_record_release(&ref);
    --
    --	reftable_table_init_log_iter(tab, &it);
    --
    --	err = reftable_iterator_seek_log(&it, "");
    --	if (err < 0)
    --		return err;
    --
    --	while (1) {
    --		err = reftable_iterator_next_log(&it, &log);
    --		if (err > 0) {
    --			break;
    --		}
    --		if (err < 0) {
    --			return err;
    --		}
    --		reftable_log_record_print(&log, hash_id);
    --	}
    --	reftable_iterator_destroy(&it);
    --	reftable_log_record_release(&log);
    --	return 0;
    --}
    --
    - uint64_t reftable_table_max_update_index(struct reftable_table *tab)
    - {
    - 	return tab->ops->max_update_index(tab->table_arg);
    -
    - ## reftable/reader.c ##
    -@@ reftable/reader.c: void reftable_table_from_reader(struct reftable_table *tab,
    - 	tab->table_arg = reader;
    - }
    - 
    --
    --int reftable_reader_print_file(const char *tablename)
    --{
    --	struct reftable_block_source src = { NULL };
    --	int err = reftable_block_source_from_file(&src, tablename);
    --	struct reftable_reader *r = NULL;
    --	struct reftable_table tab = { NULL };
    --	if (err < 0)
    --		goto done;
    --
    --	err = reftable_new_reader(&r, &src, tablename);
    --	if (err < 0)
    --		goto done;
    --
    --	reftable_table_from_reader(&tab, r);
    --	err = reftable_table_print(&tab);
    --done:
    --	reftable_reader_free(r);
    --	return err;
    --}
    --
    - int reftable_reader_print_blocks(const char *tablename)
    - {
    - 	struct {
    -
      ## reftable/record.c ##
     @@ reftable/record.c: static void reftable_ref_record_copy_from(void *rec, const void *src_rec,
      	}
    @@ reftable/record.c: void reftable_record_init(struct reftable_record *rec, uint8_
     -}
     
      ## reftable/record.h ##
    -@@ reftable/record.h: struct reftable_record_vtable {
    - 	 * the same type.
    - 	 */
    - 	int (*cmp)(const void *a, const void *b);
    --
    --	/* Print on stdout, for debugging. */
    --	void (*print)(const void *rec, int hash_size);
    - };
    - 
    - /* returns true for recognized block types. Block start with the block type. */
     @@ reftable/record.h: void reftable_record_init(struct reftable_record *rec, uint8_t typ);
      /* see struct record_vtable */
      int reftable_record_cmp(struct reftable_record *a, struct reftable_record *b);
    @@ reftable/record.h: void reftable_record_init(struct reftable_record *rec, uint8_
      void reftable_record_copy_from(struct reftable_record *rec,
      			       struct reftable_record *src, int hash_size);
     
    - ## reftable/reftable-generic.h ##
    -@@ reftable/reftable-generic.h: uint64_t reftable_table_min_update_index(struct reftable_table *tab);
    - int reftable_table_read_ref(struct reftable_table *tab, const char *name,
    - 			    struct reftable_ref_record *ref);
    - 
    --/* dump table contents onto stdout for debugging */
    --int reftable_table_print(struct reftable_table *tab);
    --
    - #endif
    -
    - ## reftable/reftable-reader.h ##
    -@@ reftable/reftable-reader.h: uint64_t reftable_reader_min_update_index(struct reftable_reader *r);
    - void reftable_table_from_reader(struct reftable_table *tab,
    - 				struct reftable_reader *reader);
    - 
    --/* print table onto stdout for debugging. */
    --int reftable_reader_print_file(const char *tablename);
    - /* print blocks onto stdout for debugging. */
    - int reftable_reader_print_blocks(const char *tablename);
    - 
    -
      ## reftable/reftable-record.h ##
     @@ reftable/reftable-record.h: const unsigned char *reftable_ref_record_val2(const struct reftable_ref_record *
      /* returns whether 'ref' represents a deletion */
    @@ reftable/reftable-record.h: void reftable_log_record_release(struct reftable_log
     -
      #endif
     
    - ## reftable/reftable-stack.h ##
    -@@ reftable/reftable-stack.h: struct reftable_compaction_stats {
    - struct reftable_compaction_stats *
    - reftable_stack_compaction_stats(struct reftable_stack *st);
    - 
    --/* print the entire stack represented by the directory */
    --int reftable_stack_print_directory(const char *stackdir, uint32_t hash_id);
    --
    - #endif
    -
    - ## reftable/stack.c ##
    -@@ reftable/stack.c: int reftable_stack_clean(struct reftable_stack *st)
    - 	reftable_addition_destroy(add);
    - 	return err;
    + ## t/helper/test-reftable.c ##
    +@@ t/helper/test-reftable.c: static void print_help(void)
    + 	       "\n");
      }
    --
    --int reftable_stack_print_directory(const char *stackdir, uint32_t hash_id)
    --{
    --	struct reftable_stack *stack = NULL;
    --	struct reftable_write_options opts = { .hash_id = hash_id };
    --	struct reftable_merged_table *merged = NULL;
    --	struct reftable_table table = { NULL };
    --
    --	int err = reftable_new_stack(&stack, stackdir, &opts);
    --	if (err < 0)
    --		goto done;
    --
    --	merged = reftable_stack_merged_table(stack);
    --	reftable_table_from_merged_table(&table, merged);
    --	err = reftable_table_print(&table);
    --done:
    --	if (stack)
    --		reftable_stack_destroy(stack);
    --	return err;
    --}
    -
    - ## reftable/stack_test.c ##
    -@@ reftable/stack_test.c: static void test_reftable_stack_add_one(void)
    - 	EXPECT(0 == strcmp("master", dest.value.symref));
    - 	EXPECT(st->readers_len > 0);
      
    --	printf("testing print functionality:\n");
    --	err = reftable_stack_print_directory(dir, GIT_SHA1_FORMAT_ID);
    --	EXPECT_ERR(err);
    --
    --	err = reftable_stack_print_directory(dir, GIT_SHA256_FORMAT_ID);
    --	EXPECT(err == REFTABLE_FORMAT_ERROR);
    --
    - #ifndef GIT_WINDOWS_NATIVE
    - 	strbuf_addstr(&scratch, dir);
    - 	strbuf_addstr(&scratch, "/tables.list");
    ++static char hexdigit(int c)
    ++{
    ++	if (c <= 9)
    ++		return '0' + c;
    ++	return 'a' + (c - 10);
    ++}
    ++
    ++static void hex_format(char *dest, const unsigned char *src, int hash_size)
    ++{
    ++	assert(hash_size > 0);
    ++	if (src) {
    ++		int i = 0;
    ++		for (i = 0; i < hash_size; i++) {
    ++			dest[2 * i] = hexdigit(src[i] >> 4);
    ++			dest[2 * i + 1] = hexdigit(src[i] & 0xf);
    ++		}
    ++		dest[2 * hash_size] = 0;
    ++	}
    ++}
    ++
    + static int dump_table(struct reftable_table *tab)
    + {
    + 	struct reftable_iterator it = { NULL };
    + 	struct reftable_ref_record ref = { NULL };
    + 	struct reftable_log_record log = { NULL };
    + 	uint32_t hash_id = reftable_table_hash_id(tab);
    ++	int hash_len = hash_size(hash_id);
    + 	int err;
    + 
    + 	reftable_table_init_ref_iter(tab, &it);
    +@@ t/helper/test-reftable.c: static int dump_table(struct reftable_table *tab)
    + 		return err;
    + 
    + 	while (1) {
    ++		char hex[GIT_MAX_HEXSZ + 1] = { 0 }; /* BUG */
    ++
    + 		err = reftable_iterator_next_ref(&it, &ref);
    +-		if (err > 0) {
    ++		if (err > 0)
    + 			break;
    +-		}
    +-		if (err < 0) {
    ++		if (err < 0)
    + 			return err;
    ++
    ++		printf("ref{%s(%" PRIu64 ") ", ref.refname, ref.update_index);
    ++		switch (ref.value_type) {
    ++		case REFTABLE_REF_SYMREF:
    ++			printf("=> %s", ref.value.symref);
    ++			break;
    ++		case REFTABLE_REF_VAL2:
    ++			hex_format(hex, ref.value.val2.value, hash_len);
    ++			printf("val 2 %s", hex);
    ++			hex_format(hex, ref.value.val2.target_value,
    ++				   hash_len);
    ++			printf("(T %s)", hex);
    ++			break;
    ++		case REFTABLE_REF_VAL1:
    ++			hex_format(hex, ref.value.val1, hash_len);
    ++			printf("val 1 %s", hex);
    ++			break;
    ++		case REFTABLE_REF_DELETION:
    ++			printf("delete");
    ++			break;
    + 		}
    +-		reftable_ref_record_print(&ref, hash_id);
    ++		printf("}\n");
    + 	}
    + 	reftable_iterator_destroy(&it);
    + 	reftable_ref_record_release(&ref);
    +@@ t/helper/test-reftable.c: static int dump_table(struct reftable_table *tab)
    + 		return err;
    + 
    + 	while (1) {
    ++		char hex[GIT_MAX_HEXSZ + 1] = { 0 };
    ++
    + 		err = reftable_iterator_next_log(&it, &log);
    +-		if (err > 0) {
    ++		if (err > 0)
    + 			break;
    +-		}
    +-		if (err < 0) {
    ++		if (err < 0)
    + 			return err;
    ++
    ++		switch (log.value_type) {
    ++		case REFTABLE_LOG_DELETION:
    ++			printf("log{%s(%" PRIu64 ") delete\n", log.refname,
    ++			       log.update_index);
    ++			break;
    ++		case REFTABLE_LOG_UPDATE:
    ++			printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %04d\n",
    ++			       log.refname, log.update_index,
    ++			       log.value.update.name ? log.value.update.name : "",
    ++			       log.value.update.email ? log.value.update.email : "",
    ++			       log.value.update.time,
    ++			       log.value.update.tz_offset);
    ++			hex_format(hex, log.value.update.old_hash, hash_len);
    ++			printf("%s => ", hex);
    ++			hex_format(hex, log.value.update.new_hash, hash_len);
    ++			printf("%s\n\n%s\n}\n", hex,
    ++			       log.value.update.message ? log.value.update.message : "");
    ++			break;
    + 		}
    +-		reftable_log_record_print(&log, hash_id);
    + 	}
    + 	reftable_iterator_destroy(&it);
    + 	reftable_log_record_release(&log);
 -:  ---------- > 13:  5498395872 t/helper: use `hash_to_hex_algop()` to print hashes
 -:  ---------- > 14:  5390be75c3 t/helper: refactor to not use `struct reftable_table`
10:  723495adf6 = 15:  5aeab8ee07 reftable/generic: drop interface
-- 
2.46.0.46.g406f326d27.dirty

