Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3034C1096F
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738004562; cv=none; b=bVYS2iy0uNlQd315+mmeznzUG+yZf5vo9rtwBgZ59s7ljnHLMGePZHSxsnUksY/Z5GIavO3v7KQekRecU4JSAGlwFv5gQcJl4+vXu5tvHLlXvyFFNDCYypWtOPSnfBzOl8UQwRk9sU9fJen4PZ82Lz8OKp3bQJGxqvKN1Ofn988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738004562; c=relaxed/simple;
	bh=g2hGzoPYJNFd6Y/pLkZVKevLrTqm1jEgFsZiUocXeeQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ggomMPh5GdAQJD7C2ZzbrKGMSIj9xdqE+YuKQ79YDN6eDm8id4+EJtcvOjOp56oXb8pG3oAMiWj3q//5CAYbxDKKFcPJSXiVT2c0DuVnwhSgMgDJ20x4BPeg9u7p8khOKJy5jcRoH2dBq5VAvhhmTjz/3mKBdVFe1t9U7bBwRgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/uzJKMl; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/uzJKMl"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3862d161947so2490385f8f.3
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 11:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738004558; x=1738609358; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKnfydD76uf8L7Si+WQ1MIxkF21DzjHZolQ1QCoNiQQ=;
        b=K/uzJKMldVb1Cz8pry9IvRi1VGSHsb7ORN9qcroEi5fyq9WUAzxEnn5Em1bIYPBf2h
         XGFOx81hvJCIj0tKhemV4iJJ4aTJdCLCTlkvBWkYRaNRescrrKWkG4hEC8L/CE0JL6Sj
         Zy5P4bZEGgNRC81RFT9GP/i17ida4FTUe/y0UVxjYATug64FDeiZe/0aoBWJCsuX8BlX
         /cftxa62Wf0I2vURURtLqllT2f7A423PrlHzOgdBqbGsSoPYOzb22lPYMqkPjAU0ydRB
         oPudyYrIcMUlVJqSXDk8ELc63gFb5c1nHJS7OzHPirkAtSI5Bf2Sx7M/+HznAeoGuh9e
         RQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738004558; x=1738609358;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKnfydD76uf8L7Si+WQ1MIxkF21DzjHZolQ1QCoNiQQ=;
        b=OuuND8FGZw+qBjBsTySRw+Z+ja3+Rj3ebQO2Bv92vc3xsykXLGuEVc98NzXU+e7GrV
         N1YM5l0zBvsW60CloDMrnVZjpPqFIGLP6Z07Wasx62ra07JvinKNh6UUtdFQAEgLcJI2
         RlfNNmtcZjKv7EYlBpZvijGvBA4KRSCI04c9rHHfS5bbaOYibHYrFvQcAPqA1ul7CM0f
         W0zHN6Sk/5igTdOPHtXp0EdmIEzV21b47DhVzPT7malb7/4gcgi7Kn/CUozr1BBRlRca
         EJTc7PK8TgUOcG+YNC48Zt00tV88SdEKcILd2I3r27qmUCO6PUh84ZQu6uL08fQNMXdK
         jeWQ==
X-Gm-Message-State: AOJu0YwMLojr4yFFDl89LvHhd68BcIrnMu0g4NeFj9FmhfdhsGbDQQZq
	94Cml6ZzWIw5hkP1dRMVs0+DhkaggJM7J8eWGo4mBrOnJ4ROHuyFOmlWgw==
X-Gm-Gg: ASbGncvVk3eZ7xVHbcanI5YsoPfOYu9fvI4JYHDwftS8zJpLyBfbLuOwIz/MMTXFMLK
	MmhpbWUGZDAskxqPT4qzBdSSOmk1tKTbzv72M0pBwopjxgUxOGncacV+gm6w4TS+xJHtNp5jGOI
	2jXcJrY7TWCUXmdjiEPSizRZX1hq3zJAv2V3MiZHq679uLcCHI8lyQ9fsGdflRzNyJjuFMgHcUg
	2gJsr6F/+7SdJuznt+lpFEwwIlFRaC/vaROpmEQdIFUHP2Mx4OQTCPyFtoQPv/9pBkZbP6PBUE+
	yAaqBw==
X-Google-Smtp-Source: AGHT+IHW/uzNlcb/aOgOJi6UKcSx693Yg84WBNc6FZck/GjHUS+zmoUf6LWUBgGLJUoc39tX3Wzh9w==
X-Received: by 2002:a05:6000:10cd:b0:385:e429:e591 with SMTP id ffacd0b85a97d-38bf566e433mr32599524f8f.23.1738004557767;
        Mon, 27 Jan 2025 11:02:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bbb39sm11946274f8f.65.2025.01.27.11.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:02:37 -0800 (PST)
Message-Id: <pull.1823.v4.git.1738004554.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
References: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 27 Jan 2025 19:02:27 +0000
Subject: [PATCH v4 0/7] pack-objects: Create an alternative name hash algorithm (recreated)
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    jonathantanmy@google.com,
    karthik nayak <karthik.188@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

This is a recreation of the topic in [1] that was closed. (I force-pushed my
branch and GitHub won't let me reopen the PR for GitGitGadget to create this
as v3.)

[1]
https://lore.kernel.org/git/pull.1785.v2.git.1726692381.gitgitgadget@gmail.com/

I've been focused recently on understanding and mitigating the growth of a
few internal repositories. Some of these are growing much larger than
expected for the number of contributors, and there are multiple aspects to
why this growth is so large.

This is part of the RFC I submitted [2] involving the path-walk API, though
this doesn't use the path-walk API directly. In full repack cases, it seems
that the --full-name-hash option gets nearly as good compression as the
--path-walk option introduced in that series. I continue to work on that
feature as well, so we can review it after this series is complete.

[2]
https://lore.kernel.org/git/pull.1786.git.1725935335.gitgitgadget@gmail.com/

The main issue plaguing these repositories is that deltas are not being
computed against objects that appear at the same path. While the size of
these files at tip is one aspect of growth that would prevent this issue,
the changes to these files are reasonable and should result in good delta
compression. However, Git is not discovering the connections across
different versions of the same file.

One way to find some improvement in these repositories is to increase the
window size, which was an initial indicator that the delta compression could
be improved, but was not a clear indicator. After some digging (and
prototyping some analysis tools) the main discovery was that the current
name-hash algorithm only considers the last 16 characters in the path name
and has some naturally-occurring collisions within that scope.

This series creates a mechanism to select alternative name hashes using a
new --name-hash-version=<n> option. The versions are:

 1. Version 1 is the default name hash that already exists. This option
    focuses on the final bytes of the path to maximize locality for
    cross-path deltas.

 2. Version 2 is the new path-component hash function suggested by Jonathan
    Tan in the previous version (with some modifications). This hash
    function essentially computes the v1 name hash of each path component
    and then overlays those hashes with a shift to make the parent
    directories contribute less to the final hash, but enough to break many
    collisions that exist in v1.

 3. Version 3 is the hash function that I submitted under the
    --full-name-hash feature in the previous versions. This uses a
    pseudorandom hash procedure to minimize collisions but at the expense of
    losing on locality. This version is implemented in the final patch of
    the series mostly for comparison purposes, as it is unlikely to be
    selected as a valuable hash function over v2. The final patch could be
    omitted from the merged version.

See the patches themselves for detailed results in the p5313-pack-objects.sh
performance test and the p5314-name-hash.sh test that demonstrates how many
collisions occur with each hash function.

In general, the v2 name hash function gets very close to the compression
results of v3 in the full repack case, even in the repositories that feature
many name hash collisions. These benefits come as well without downsides to
other kinds of packfiles, including small pushed packs, larger incremental
fetch packs, and shallow clones.

I should point out that there is still a significant jump in compression
effectiveness between these name hash version options and the --path-walk
feature I suggested in my RFC [2] and has review underway in [3] (along with
changes to git pack-objects and git repack in [4]).

[3]
https://lore.kernel.org/git/pull.1818.v2.git.1731181272.gitgitgadget@gmail.com/

[4] https://github.com/gitgitgadget/git/pull/1819

To compare these options in a set of Javascript repositories that have
different levels of name hash collisions, see the following table that lists
the size of the packfile after git repack -adf
[--name-hash-version=<n>|--path-walk]:

| Repo     | V1 Size   | V2 Size | V3 Size | Path Walk Size |
|----------|-----------|---------|---------|----------------|
| fluentui |     440 M |   161 M |   170 M |          123 M |
| Repo B   |   6,248 M |   856 M |   840 M |          782 M |
| Repo C   |  37,278 M | 6,921 M | 6,755 M |        6,156 M |
| Repo D   | 131,204 M | 7,463 M | 7,124 M |        4,005 M |


As we can see, v2 nearly reaches the effectiveness of v3 (and outperforms it
once!) but there is still a significant change between the
--name-hash-version feature and the --path-walk feature.

The main reason we are considering this --name-hash-version feature is that
it has the least amount of stretch required in order for it to be integrated
with reachability bitmaps, required for server environments. In fact, the
change in this version to use a numerical version makes it more obvious how
to connect the version number to a value in the .bitmap file format. Tests
are added to guarantee that the hash functions preserve their behavior over
time, since data files depend on that.

Thanks, -Stolee


UPDATES SINCE V1
================

 * BIG CHANGE: --full-name-hash is replaced with --name-hash-version=<n>.

 * --name-hash-version=2 uses Jonathan Tan's hash function (with some
   adjustments). See the first patch for this implementation, credited to
   him.

 * --name-hash-version=3 uses the hash function I wrote for the previous
   version's --full-name-hash. This is left as the final patch so it could
   be easily removed from the series if not considered worth having since it
   has some pain points that are resolved from v2 without significant issues
   to overall repo size.

 * Commit messaes are updated with these changes, as well as a better
   attempt to indicate the benefit of cross-path delta pairs, such as
   renames or similar content based on file extension.

 * Performance numbers are regenerated for the same set of repositories.
   Size data is somewhat nondeterministic due to concurrent threads
   competing over delta computations.

 * The --name-hash-version option is not added to git repack until its own
   patch.

 * The patch that updates git repack's synopsis match its docs is squashed
   into the patch that adds the option to git repack.

 * Documentation is expanded for git pack-objects and reused for git repack.

 * GIT_TEST_FULL_NAME_HASH is now GIT_TEST_NAME_HASH_VERSION with similar
   caveats required for tests. It is removed from the linux-TEST-vars CI
   job.

 * The performance test p5313-pack-objects.sh is now organized via a loop
   over the different versions. This separates the scenarios, which makes
   things harder to compare directly, but makes it trivial to add new
   versions.

 * The patch that disabled --full-name-hash when performing a shallow clone
   is no longer present, as it is not necessary when using
   --name-hash-version=2. Perhaps it would be valuable for repo using v3, if
   that is kept in the series.

 * We force name hash version 1 when writing or reading bitmaps.

 * A small patch is added to cause a BUG() failure if the name hash version
   global changes between calls to pack_name_hash_fn(). This is solely
   defensive programming.

 * Several typos, style issues, or suggested comments are resolved.


UPDATES SINCE v2
================

 * For extra safety, the new name-hash algorithm uses unsigned characters.

 * A stray 'full_name_hash' variable is removed.

 * Commit messages are improved.

 * 'git repack' documentation now points to 'git pack-objects' docs for the
   --name-hash-version option.

 * The changes to t5616 are delayed until the introduction of version 3,
   since the v2 name hash does not demonstrate the behavior.


UPDATES SINCE v3
================

 * Style fixes for switch statement and setting a test environment variable.

 * validate_name_hash_version() is now responsible for checking
   compatibility with other options.

 * The --name-hash-version=3 patch is removed to avoid user confusion since
   we don't have a clear way to predict when it would provide (modest)
   improvements over v2.

Derrick Stolee (6):
  pack-objects: add --name-hash-version option
  repack: add --name-hash-version option
  pack-objects: add GIT_TEST_NAME_HASH_VERSION
  p5313: add size comparison test
  test-tool: add helper for name-hash values
  pack-objects: prevent name hash version change

Jonathan Tan (1):
  pack-objects: create new name-hash function version

 Documentation/git-pack-objects.txt | 32 +++++++++++++-
 Documentation/git-repack.txt       |  9 +++-
 Makefile                           |  1 +
 builtin/pack-objects.c             | 63 ++++++++++++++++++++++++---
 builtin/repack.c                   |  9 +++-
 pack-objects.h                     | 28 ++++++++++++
 t/README                           |  4 ++
 t/helper/test-name-hash.c          | 23 ++++++++++
 t/helper/test-tool.c               |  1 +
 t/helper/test-tool.h               |  1 +
 t/perf/p5313-pack-objects.sh       | 70 ++++++++++++++++++++++++++++++
 t/perf/p5314-name-hash.sh          | 31 +++++++++++++
 t/t0450/txt-help-mismatches        |  1 -
 t/t5300-pack-object.sh             | 34 +++++++++++++++
 t/t5310-pack-bitmaps.sh            | 35 ++++++++++++++-
 t/t5333-pseudo-merge-bitmaps.sh    |  3 +-
 t/t5510-fetch.sh                   |  7 ++-
 t/t6020-bundle-misc.sh             |  6 ++-
 t/t7406-submodule-update.sh        |  4 +-
 t/t7700-repack.sh                  | 16 ++++++-
 t/test-lib-functions.sh            | 26 +++++++++++
 21 files changed, 388 insertions(+), 16 deletions(-)
 create mode 100644 t/helper/test-name-hash.c
 create mode 100755 t/perf/p5313-pack-objects.sh
 create mode 100755 t/perf/p5314-name-hash.sh


base-commit: 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1823%2Fderrickstolee%2Ffull-name-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1823/derrickstolee/full-name-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1823

Range-diff vs v3:

 1:  68b4127580e = 1:  68b4127580e pack-objects: create new name-hash function version
 2:  d035e3e59f4 ! 2:  7ee1845144f pack-objects: add --name-hash-version option
     @@ Commit message
          .bitmap file format, so we must force --name-hash-version=1 when bitmaps
          are being read or written. Later, the bitmap format could be updated to
          be aware of the name hash version so deltas can be quickly computed
     -    across the bitmapped/not-bitmapped boundary.
     +    across the bitmapped/not-bitmapped boundary. To promote the safety of
     +    this parameter, the validate_name_hash_version() method will die() if
     +    the given name-hash version is incorrect and will disable newer versions
     +    if not yet compatible with other features, such as --write-bitmap-index.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     @@ builtin/pack-objects.c: struct configured_exclusion {
       static struct oidset excluded_by_config;
      +static int name_hash_version = 1;
      +
     ++/**
     ++ * Check whether the name_hash_version chosen by user input is apporpriate,
     ++ * and also validate whether it is appropriate with other features.
     ++ */
      +static void validate_name_hash_version(void)
      +{
      +	if (name_hash_version < 1 || name_hash_version > 2)
      +		die(_("invalid --name-hash-version option: %d"), name_hash_version);
     ++	if (write_bitmap_index && name_hash_version != 1) {
     ++		warning(_("currently, --write-bitmap-index requires --name-hash-version=1"));
     ++		name_hash_version = 1;
     ++	}
      +}
      +
      +static inline uint32_t pack_name_hash_fn(const char *name)
      +{
     -+	switch (name_hash_version)
     -+	{
     ++	switch (name_hash_version) {
      +	case 1:
      +		return pack_name_hash(name);
      +
     @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
       		write_bitmap_index = 0;
       
      +	validate_name_hash_version();
     -+	if (write_bitmap_index && name_hash_version != 1) {
     -+		warning(_("currently, --write-bitmap-index requires --name-hash-version=1"));
     -+		name_hash_version = 1;
     -+	}
      +
       	if (use_delta_islands)
       		strvec_push(&rp, "--topo-order");
 3:  e2191244f6b = 3:  a4f3d127686 repack: add --name-hash-version option
 4:  86ff0d0a15e ! 4:  a507be2f19b pack-objects: add GIT_TEST_NAME_HASH_VERSION
     @@ builtin/pack-objects.c: struct configured_exclusion {
      -static int name_hash_version = 1;
      +static int name_hash_version = -1;
       
     - static void validate_name_hash_version(void)
     - {
     + /**
     +  * Check whether the name_hash_version chosen by user input is apporpriate,
      @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
       	if (pack_to_stdout || !rev_list_all)
       		write_bitmap_index = 0;
     @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
      +		name_hash_version = (int)git_env_ulong("GIT_TEST_NAME_HASH_VERSION", 1);
      +
       	validate_name_hash_version();
     - 	if (write_bitmap_index && name_hash_version != 1) {
     - 		warning(_("currently, --write-bitmap-index requires --name-hash-version=1"));
     + 
     + 	if (use_delta_islands)
      
       ## t/README ##
      @@ t/README: a test and then fails then the whole test run will abort. This can help to make
     @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'bitmapPseudoMerge.stableTh
       '
       
       test_expect_success 'out of order thresholds are rejected' '
     -+	# Disable this option to avoid stderr message
     -+	GIT_TEST_NAME_HASH_VERSION=1 &&
     -+	export GIT_TEST_NAME_HASH_VERSION &&
     -+
     - 	test_must_fail git \
     +-	test_must_fail git \
     ++	# Disable the test var to remove a stderr message.
     ++	test_must_fail env GIT_TEST_NAME_HASH_VERSION=1 git \
       		-c bitmapPseudoMerge.test.pattern="refs/*" \
       		-c bitmapPseudoMerge.test.threshold=1.month.ago \
     + 		-c bitmapPseudoMerge.test.stableThreshold=1.week.ago \
      
       ## t/t5510-fetch.sh ##
      @@ t/t5510-fetch.sh: test_expect_success 'all boundary commits are excluded' '
 5:  163aaab3e1b = 5:  a0247a679ac p5313: add size comparison test
 6:  e9ce79fa6e7 = 6:  06a95063186 test-tool: add helper for name-hash values
 7:  18a41f2fe6f ! 7:  bab2ac31880 pack-objects: prevent name hash version change
     @@ builtin/pack-objects.c: static void validate_name_hash_version(void)
      +		BUG("name hash version changed from %d to %d mid-process",
      +		    seen_version, name_hash_version);
      +
     - 	switch (name_hash_version)
     - 	{
     + 	switch (name_hash_version) {
       	case 1:
     + 		return pack_name_hash(name);
 8:  3d63954f318 < -:  ----------- pack-objects: add third name hash version

-- 
gitgitgadget
