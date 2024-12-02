Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0FF1DF266
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733181692; cv=none; b=O+VX40wmyp0wi1RzLnfQhaqFto+sS5lYQEtcND+cGDYecZz3oLHHqjMPjll4x4I7tMQ1uSMRIymfHu1TXowtTgTxYrR1IMqjNvexmZLVt55lPrfptRIgIxO6wvrLry/BSdNOzM3eCF9pVSNQQBMHoC6IfTpma4R5NSDkV7/g/lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733181692; c=relaxed/simple;
	bh=ghRAUivxLNsLm9WEladjaVx6wpcDNoIx8EJLY0yPt2E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bf/7OVzimzZIqiBy8u3RidfRiWS1RwpKKxajFAgGSEc3vxvE90giQtk+zb05JgHzAcV5zsTKxIBiIp5AakUXtHrxiY3NEdkg7c6JWAdoiGoOaiLnKKgZrbqsBr9jsHTEC47y0xiXu2JoSeIsZBlR85PdLmPKXT1G8gVg6SLMWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWQ+b9CH; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWQ+b9CH"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53de579f775so6778822e87.2
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 15:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733181686; x=1733786486; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DE7QOamZ337nEc8AkL3f6o6RG8WcKmp7llNnQ2wxmQ=;
        b=TWQ+b9CHT5zqJaWHcoTqRJsQE3wRbLKvjYxmFryQs6+XdX1xqAc3/29uvUsKmS/kBc
         nowOyoQI9H7OvJ5X29Gupy57bHXFOLU70cZdIY6F2GFzvEv5GQmUs7ItOufDo4pmiLoI
         gL6OdpbX6Q96xTVX1qx29BuYxnEz/h65idB9xAejUmPhjnQukGCPP4WFVyiJvbtNN5Pa
         KrIcsFpHcykOuDOqAXCqjpYWWmVCqS0XnPvIhzEAD1hCJdbQghQm+qL28PZ6CqldyhWM
         +3V4JJUmF3NfrEFYfYZcf/Eu3AdBnue5l90eD43GrvZ5dEeXIIgQcA7FhKwszQweH2Wu
         lolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733181686; x=1733786486;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DE7QOamZ337nEc8AkL3f6o6RG8WcKmp7llNnQ2wxmQ=;
        b=DFzDOv4YY0jYiYfw6OfF/IY7BPpwN37vWQa4fbCsveO5cN/b7i85qoW53ApWjvHoBL
         DTvYO9sUDGfp41iflsGR4RZlcCvX8fWUqvDtlsknZpOhxRxwnaQgHDd+CvaXvCV4sKFK
         TnTZlWc1rigOd71+zTKgWiWqzm1qIJRd5OooI8QesfjwP+h3zZ6cZdmNmOh1WfWS0KNW
         LrqBSsCrr9HUKMW7o4McNGW9Z5nkf5ZW1Xf/Xt1eFyfLMmIQ05d+xdQbvh1SShB90vxD
         Wj2MDciowd65xeCmcZ6/XIWNHdsN0QEiedRjeg3W4ulEcFrs8n1iy3/hgwphDYgix2wp
         eeVg==
X-Gm-Message-State: AOJu0YzyxyqMrcBORHxkAcGCK0BIrK2+iwO+X8IuUZrLmm/Y+mEDK318
	24fn3Xt5CCGpPeUBdD22lnqi6aViob7Nq38DpIDoe2TfZYTK+REozxBLwA==
X-Gm-Gg: ASbGncvv45UPwm1cLxL27Mut6Ngv+JCtlPKEWaxtfVapH5p6p2lb77zSnOQKg8jXYeq
	nEjQigUEQK4GJ+Ko6yq9aRp0hHVnJXl9QRZkVmw+TzOsLiWJpIyX5Z313BDMTrOxdGw+n/iJU77
	rf9J5kE0739aHH1DOu9lF71M9+rNFs1hF8agEwmCWpYr3GEPgJzViaOlnulkvT+xh3KzOqQJfIR
	YvUCZHe1vIl9Hek/UdoaCa4tEZFQVr7RHYZ+FHWE327kfOSWqY=
X-Google-Smtp-Source: AGHT+IHbkUSbskiNVZyxlkFPSinzU4RTy0gwBAEqB7k4xx9c5cWhXP2rFfiCO0VwUq5x3QPyzxEYDQ==
X-Received: by 2002:a05:6512:239a:b0:53d:a132:14f5 with SMTP id 2adb3069b0e04-53e12a39372mr349251e87.57.1733181684854;
        Mon, 02 Dec 2024 15:21:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599908be5sm553160766b.140.2024.12.02.15.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 15:21:23 -0800 (PST)
Message-Id: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Dec 2024 23:21:14 +0000
Subject: [PATCH v2 0/8] pack-objects: Create an alternative name hash algorithm (recreated)
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

Derrick Stolee (7):
  pack-objects: add --name-hash-version option
  repack: add --name-hash-version option
  pack-objects: add GIT_TEST_NAME_HASH_VERSION
  p5313: add size comparison test
  test-tool: add helper for name-hash values
  pack-objects: prevent name hash version change
  pack-objects: add third name hash version

Jonathan Tan (1):
  pack-objects: create new name-hash function version

 Documentation/git-pack-objects.txt | 41 ++++++++++++++++-
 Documentation/git-repack.txt       | 43 +++++++++++++++++-
 Makefile                           |  1 +
 builtin/pack-objects.c             | 63 ++++++++++++++++++++++++---
 builtin/repack.c                   |  9 +++-
 pack-objects.h                     | 54 +++++++++++++++++++++++
 t/README                           |  4 ++
 t/helper/test-name-hash.c          | 24 ++++++++++
 t/helper/test-tool.c               |  1 +
 t/helper/test-tool.h               |  1 +
 t/perf/p5313-pack-objects.sh       | 70 ++++++++++++++++++++++++++++++
 t/perf/p5314-name-hash.sh          | 31 +++++++++++++
 t/t0450/txt-help-mismatches        |  1 -
 t/t5300-pack-object.sh             | 34 +++++++++++++++
 t/t5310-pack-bitmaps.sh            | 35 ++++++++++++++-
 t/t5333-pseudo-merge-bitmaps.sh    |  4 ++
 t/t5510-fetch.sh                   |  7 ++-
 t/t5616-partial-clone.sh           | 26 ++++++++++-
 t/t6020-bundle-misc.sh             |  6 ++-
 t/t7406-submodule-update.sh        |  4 +-
 t/t7700-repack.sh                  | 16 ++++++-
 t/test-lib-functions.sh            | 26 +++++++++++
 22 files changed, 484 insertions(+), 17 deletions(-)
 create mode 100644 t/helper/test-name-hash.c
 create mode 100755 t/perf/p5313-pack-objects.sh
 create mode 100755 t/perf/p5314-name-hash.sh


base-commit: 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1823%2Fderrickstolee%2Ffull-name-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1823/derrickstolee/full-name-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1823

Range-diff vs v1:

 -:  ----------- > 1:  454b070d5bb pack-objects: create new name-hash function version
 1:  812257e197c ! 2:  fb52ca509da pack-objects: add --full-name-hash option
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    pack-objects: add --full-name-hash option
     +    pack-objects: add --name-hash-version option
      
     -    The pack_name_hash() method has not been materially changed since it was
     -    introduced in ce0bd64299a (pack-objects: improve path grouping
     -    heuristics., 2006-06-05). The intention here is to group objects by path
     -    name, but also attempt to group similar file types together by making
     -    the most-significant digits of the hash be focused on the final
     -    characters.
     +    The previous change introduced a new pack_name_hash_v2() function that
     +    intends to satisfy much of the hash locality features of the existing
     +    pack_name_hash() function while also distinguishing paths with similar
     +    final components of their paths.
      
     -    Here's the crux of the implementation:
     +    This change adds a new --name-hash-version option for 'git pack-objects'
     +    to allow users to select their preferred function version. This use of
     +    an integer version allows for future expansion and a direct way to later
     +    store a name hash version in the .bitmap format.
      
     -            /*
     -             * This effectively just creates a sortable number from the
     -             * last sixteen non-whitespace characters. Last characters
     -             * count "most", so things that end in ".c" sort together.
     -             */
     -            while ((c = *name++) != 0) {
     -                    if (isspace(c))
     -                            continue;
     -                    hash = (hash >> 2) + (c << 24);
     -            }
     +    For now, let's consider how effective this mechanism is when repacking a
     +    repository with different name hash versions. Specifically, we will
     +    execute 'git pack-objects' the same way a 'git repack -adf' process
     +    would, except we include --name-hash-version=<n> for testing.
     +
     +    On the Git repository, we do not expect much difference. All path names
     +    are short. This is backed by our results:
      
     -    As the comment mentions, this only cares about the last sixteen
     -    non-whitespace characters. This cause some filenames to collide more
     -    than others. Here are some examples that I've seen while investigating
     -    repositories that are growing more than they should be:
     +    | Stage                 | Pack Size | Repack Time |
     +    |-----------------------|-----------|-------------|
     +    | After clone           | 260 MB    | N/A         |
     +    | --name-hash-version=1 | 127 MB    | 129s        |
     +    | --name-hash-version=2 | 127 MB    | 112s        |
     +
     +    This example demonstrates how there is some natural overhead coming from
     +    the cloned copy because the server is hosting many forks and has not
     +    optimized for exactly this set of reachable objects. But the full repack
     +    has similar characteristics for both versions.
     +
     +    Let's consider some repositories that are hitting too many collisions
     +    with version 1. First, let's explore the kinds of paths that are
     +    commonly causing these collisions:
      
           * "/CHANGELOG.json" is 15 characters, and is created by the beachball
             [1] tool. Only the final character of the parent directory can
     -       differntiate different versions of this file, but also only the two
     +       differentiate different versions of this file, but also only the two
             most-significant digits. If that character is a letter, then this is
             always a collision. Similar issues occur with the similar
             "/CHANGELOG.md" path, though there is more opportunity for
     -       differences in the parent directory.
     +       differences In the parent directory.
      
     -     * Localization files frequently have common filenames but differentiate
     -       via parent directories. In C#, the name "/strings.resx.lcl" is used
     -       for these localization files and they will all collide in name-hash.
     +     * Localization files frequently have common filenames but
     +       differentiates via parent directories. In C#, the name
     +       "/strings.resx.lcl" is used for these localization files and they
     +       will all collide in name-hash.
      
          [1] https://github.com/microsoft/beachball
      
     @@ Commit message
          common name across multiple directories and is causing Git to repack
          poorly due to name-hash collisions.
      
     -    It is clear that the existing name-hash algorithm is optimized for
     -    repositories with short path names, but also is optimized for packing a
     -    single snapshot of a repository, not a repository with many versions of
     -    the same file. In my testing, this has proven out where the name-hash
     -    algorithm does a good job of finding peer files as delta bases when
     -    unable to use a historical version of that exact file.
     -
     -    However, for repositories that have many versions of most files and
     -    directories, it is more important that the objects that appear at the
     -    same path are grouped together.
     -
     -    Create a new pack_full_name_hash() method and a new --full-name-hash
     -    option for 'git pack-objects' to call that method instead. Add a simple
     -    pass-through for 'git repack --full-name-hash' for additional testing in
     -    the context of a full repack, where I expect this will be most
     -    effective.
     -
     -    The hash algorithm is as simple as possible to be reasonably effective:
     -    for each character of the path string, add a multiple of that character
     -    and a large prime number (chosen arbitrarily, but intended to be large
     -    relative to the size of a uint32_t). Then, shift the current hash value
     -    to the right by 5, with overlap. The addition and shift parameters are
     -    standard mechanisms for creating hard-to-predict behaviors in the bits
     -    of the resulting hash.
     -
     -    This is not meant to be cryptographic at all, but uniformly distributed
     -    across the possible hash values. This creates a hash that appears
     -    pseudorandom. There is no ability to consider similar file types as
     -    being close to each other.
     -
     -    In a later change, a test-tool will be added so the effectiveness of
     -    this hash can be demonstrated directly.
     -
     -    For now, let's consider how effective this mechanism is when repacking a
     -    repository with and without the --full-name-hash option. Specifically,
     -    let's use 'git repack -adf [--full-name-hash]' as our test.
     -
     -    On the Git repository, we do not expect much difference. All path names
     -    are short. This is backed by our results:
     -
     -    | Stage                 | Pack Size | Repack Time |
     -    |-----------------------|-----------|-------------|
     -    | After clone           | 260 MB    | N/A         |
     -    | Standard Repack       | 127MB     | 106s        |
     -    | With --full-name-hash | 126 MB    | 99s         |
     -
     -    This example demonstrates how there is some natural overhead coming from
     -    the cloned copy because the server is hosting many forks and has not
     -    optimized for exactly this set of reachable objects. But the full repack
     -    has similar characteristics with and without --full-name-hash.
     -
     -    However, we can test this in a repository that uses one of the
     -    problematic naming conventions above. The fluentui [2] repo uses
     -    beachball to generate CHANGELOG.json and CHANGELOG.md files, and these
     -    files have very poor delta characteristics when comparing against
     -    versions across parent directories.
     +    One open-source example is the fluentui [2] repo, which  uses beachball
     +    to generate CHANGELOG.json and CHANGELOG.md files, and these files have
     +    very poor delta characteristics when comparing against versions across
     +    parent directories.
      
          | Stage                 | Pack Size | Repack Time |
          |-----------------------|-----------|-------------|
          | After clone           | 694 MB    | N/A         |
     -    | Standard Repack       | 438 MB    | 728s        |
     -    | With --full-name-hash | 168 MB    | 142s        |
     +    | --name-hash-version=1 | 438 MB    | 728s        |
     +    | --name-hash-version=2 | 168 MB    | 142s        |
      
          [2] https://github.com/microsoft/fluentui
      
     @@ Commit message
          reproduction. The results are so significant that I find it important to
          share here:
      
     -    | Repo     | Standard Repack | With --full-name-hash |
     -    |----------|-----------------|-----------------------|
     -    | fluentui |         438 MB  |               168 MB  |
     -    | Repo B   |       6,255 MB  |               829 MB  |
     -    | Repo C   |      37,737 MB  |             7,125 MB  |
     -    | Repo D   |     130,049 MB  |             6,190 MB  |
     +    | Repo     | --name-hash-version=1 | --name-hash-version=2 |
     +    |----------|-----------------------|-----------------------|
     +    | fluentui |               440 MB  |               161 MB  |
     +    | Repo B   |             6,248 MB  |               856 MB  |
     +    | Repo C   |            37,278 MB  |             6,755 MB  |
     +    | Repo D   |           131,204 MB  |             7,463 MB  |
      
     -    Future changes could include making --full-name-hash implied by a config
     +    Future changes could include making --name-hash-version implied by a config
          value or even implied by default during a full repack.
      
          It is important to point out that the name hash value is stored in the
     -    .bitmap file format, so we must disable the --full-name-hash option when
     -    bitmaps are being read or written. Later, the bitmap format could be
     -    updated to be aware of the name hash version so deltas can be quickly
     -    computed across the bitmapped/not-bitmapped boundary.
     +    .bitmap file format, so we must force --name-hash-version=1 when bitmaps
     +    are being read or written. Later, the bitmap format could be updated to
     +    be aware of the name hash version so deltas can be quickly computed
     +    across the bitmapped/not-bitmapped boundary.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     @@ Documentation/git-pack-objects.txt: SYNOPSIS
       	[--stdout [--filter=<filter-spec>] | <base-name>]
      -	[--shallow] [--keep-true-parents] [--[no-]sparse] < <object-list>
      +	[--shallow] [--keep-true-parents] [--[no-]sparse]
     -+	[--full-name-hash] < <object-list>
     ++	[--name-hash-version=<n>] < <object-list>
       
       
       DESCRIPTION
     +@@ Documentation/git-pack-objects.txt: raise an error.
     + 	Restrict delta matches based on "islands". See DELTA ISLANDS
     + 	below.
     + 
     ++--name-hash-version=<n>::
     ++	While performing delta compression, Git groups objects that may be
     ++	similar based on heuristics using the path to that object. While
     ++	grouping objects by an exact path match is good for paths with
     ++	many versions, there are benefits for finding delta pairs across
     ++	different full paths. Git collects objects by type and then by a
     ++	"name hash" of the path and then by size, hoping to group objects
     ++	that will compress well together.
     +++
     ++The default name hash version is `1`, which prioritizes hash locality by
     ++considering the final bytes of the path as providing the maximum magnitude
     ++to the hash function. This version excels at distinguishing short paths
     ++and finding renames across directories. However, the hash function depends
     ++primarily on the final 16 bytes of the path. If there are many paths in
     ++the repo that have the same final 16 bytes and differ only by parent
     ++directory, then this name-hash may lead to too many collisions and cause
     ++poor results. At the moment, this version is required when writing
     ++reachability bitmap files with `--write-bitmap-index`.
     +++
     ++The name hash version `2` has similar locality features as version `1`,
     ++except it considers each path component separately and overlays the hashes
     ++with a shift. This still prioritizes the final bytes of the path, but also
     ++"salts" the lower bits of the hash using the parent directory names. This
     ++method allows for some of the locality benefits of version `1` while
     ++breaking most of the collisions from a similarly-named file appearing in
     ++many different directories. At the moment, this version is not allowed
     ++when writing reachability bitmap files with `--write-bitmap-index` and it
     ++will be automatically changed to version `1`.
     ++
     + 
     + DELTA ISLANDS
     + -------------
      
       ## builtin/pack-objects.c ##
      @@ builtin/pack-objects.c: struct configured_exclusion {
       static struct oidmap configured_exclusions;
       
       static struct oidset excluded_by_config;
     -+static int use_full_name_hash;
     ++static int name_hash_version = 1;
     ++
     ++static void validate_name_hash_version(void)
     ++{
     ++	if (name_hash_version < 1 || name_hash_version > 2)
     ++		die(_("invalid --name-hash-version option: %d"), name_hash_version);
     ++}
      +
      +static inline uint32_t pack_name_hash_fn(const char *name)
      +{
     -+	if (use_full_name_hash)
     -+		return pack_full_name_hash(name);
     -+	return pack_name_hash(name);
     ++	switch (name_hash_version)
     ++	{
     ++	case 1:
     ++		return pack_name_hash(name);
     ++
     ++	case 2:
     ++		return pack_name_hash_v2(name);
     ++
     ++	default:
     ++		BUG("invalid name-hash version: %d", name_hash_version);
     ++	}
      +}
       
       /*
     @@ builtin/pack-objects.c: static void add_cruft_object_entry(const struct object_i
       					    0, name && no_try_delta(name),
       					    pack, offset);
       	}
     +@@ builtin/pack-objects.c: static int get_object_list_from_bitmap(struct rev_info *revs)
     + 	if (!(bitmap_git = prepare_bitmap_walk(revs, 0)))
     + 		return -1;
     + 
     ++	/*
     ++	 * For now, force the name-hash version to be 1 since that
     ++	 * is the version implied by the bitmap format. Later, the
     ++	 * format can include this version explicitly in its format,
     ++	 * allowing readers to know the version that was used during
     ++	 * the bitmap write.
     ++	 */
     ++	name_hash_version = 1;
     ++
     + 	if (pack_options_allow_reuse())
     + 		reuse_partial_packfile_from_bitmap(bitmap_git,
     + 						   &reuse_packfiles,
      @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
       		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
       				N_("protocol"),
       				N_("exclude any configured uploadpack.blobpackfileuri with this protocol")),
     -+		OPT_BOOL(0, "full-name-hash", &use_full_name_hash,
     -+			 N_("optimize delta compression across identical path names over time")),
     ++		OPT_INTEGER(0, "name-hash-version", &name_hash_version,
     ++			 N_("use the specified name-hash function to group similar objects")),
       		OPT_END(),
       	};
       
     @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
       	if (pack_to_stdout || !rev_list_all)
       		write_bitmap_index = 0;
       
     -+	if (write_bitmap_index && use_full_name_hash) {
     -+		warning(_("currently, the --full-name-hash option is incompatible with --write-bitmap-index"));
     -+		use_full_name_hash = 0;
     ++	validate_name_hash_version();
     ++	if (write_bitmap_index && name_hash_version != 1) {
     ++		warning(_("currently, --write-bitmap-index requires --name-hash-version=1"));
     ++		name_hash_version = 1;
      +	}
      +
       	if (use_delta_islands)
     @@ builtin/repack.c: struct pack_objects_args {
       	struct list_objects_filter_options filter_options;
       };
       
     -@@ builtin/repack.c: static void prepare_pack_objects(struct child_process *cmd,
     - 		strvec_pushf(&cmd->args, "--no-reuse-delta");
     - 	if (args->no_reuse_object)
     - 		strvec_pushf(&cmd->args, "--no-reuse-object");
     -+	if (args->full_name_hash)
     -+		strvec_pushf(&cmd->args, "--full-name-hash");
     - 	if (args->local)
     - 		strvec_push(&cmd->args,  "--local");
     - 	if (args->quiet)
     -@@ builtin/repack.c: int cmd_repack(int argc,
     - 				N_("pass --no-reuse-delta to git-pack-objects")),
     - 		OPT_BOOL('F', NULL, &po_args.no_reuse_object,
     - 				N_("pass --no-reuse-object to git-pack-objects")),
     -+		OPT_BOOL(0, "full-name-hash", &po_args.full_name_hash,
     -+				N_("pass --full-name-hash to git-pack-objects")),
     - 		OPT_NEGBIT('n', NULL, &run_update_server_info,
     - 				N_("do not run git-update-server-info"), 1),
     - 		OPT__QUIET(&po_args.quiet, N_("be quiet")),
     -
     - ## pack-objects.h ##
     -@@ pack-objects.h: static inline uint32_t pack_name_hash(const char *name)
     - 	return hash;
     - }
     - 
     -+static inline uint32_t pack_full_name_hash(const char *name)
     -+{
     -+	const uint32_t bigp = 1234572167U;
     -+	uint32_t c, hash = bigp;
     -+
     -+	if (!name)
     -+		return 0;
     -+
     -+	/*
     -+	 * Do the simplest thing that will resemble pseudo-randomness: add
     -+	 * random multiples of a large prime number with a binary shift.
     -+	 * The goal is not to be cryptographic, but to be generally
     -+	 * uniformly distributed.
     -+	 */
     -+	while ((c = *name++) != 0) {
     -+		hash += c * bigp;
     -+		hash = (hash >> 5) | (hash << 27);
     -+	}
     -+	return hash;
     -+}
     -+
     - static inline enum object_type oe_type(const struct object_entry *e)
     - {
     - 	return e->type_valid ? e->type_ : OBJ_BAD;
      
       ## t/t5300-pack-object.sh ##
      @@ t/t5300-pack-object.sh: do
       	'
       done
       
     ++test_expect_success 'valid and invalid --name-hash-versions' '
     ++	# Valid values are hard to verify other than "do not fail".
     ++	# Performance tests will be more valuable to validate these versions.
     ++	for value in 1 2
     ++	do
     ++		git pack-objects base --all --name-hash-version=$value || return 1
     ++	done &&
     ++
     ++	# Invalid values have clear post-conditions.
     ++	for value in -1 0 3
     ++	do
     ++		test_must_fail git pack-objects base --all --name-hash-version=$value 2>err &&
     ++		test_grep "invalid --name-hash-version option" err || return 1
     ++	done
     ++'
     ++
      +# The following test is not necessarily a permanent choice, but since we do not
      +# have a "name hash version" bit in the .bitmap file format, we cannot write the
     -+# full-name hash values into the .bitmap file without risking breakage later.
     ++# hash values into the .bitmap file without risking breakage later.
      +#
      +# TODO: Make these compatible in the future and replace this test with the
      +# expected behavior when both are specified.
     -+test_expect_success '--full-name-hash and --write-bitmap-index are incompatible' '
     -+	git pack-objects base --all --full-name-hash --write-bitmap-index 2>err &&
     -+	test_grep incompatible err &&
     ++test_expect_success '--name-hash-version=2 and --write-bitmap-index are incompatible' '
     ++	git pack-objects base --all --name-hash-version=2 --write-bitmap-index 2>err &&
     ++	test_grep "currently, --write-bitmap-index requires --name-hash-version=1" err &&
      +
      +	# --stdout option silently removes --write-bitmap-index
     -+	git pack-objects --stdout --all --full-name-hash --write-bitmap-index >out 2>err &&
     -+	! test_grep incompatible err
     ++	git pack-objects --stdout --all --name-hash-version=2 --write-bitmap-index >out 2>err &&
     ++	! test_grep "currently, --write-bitmap-index requires --name-hash-version=1" err
      +'
      +
       test_done
 2:  93395c93347 ! 3:  1947d1bf448 repack: add --full-name-hash option
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    repack: add --full-name-hash option
     +    repack: add --name-hash-version option
      
     -    The new '--full-name-hash' option for 'git repack' is a simple
     +    The new '--name-hash-version' option for 'git repack' is a simple
          pass-through to the underlying 'git pack-objects' subcommand. However,
          this subcommand may have other options and a temporary filename as part
          of the subcommand execution that may not be predictable or could change
     @@ Commit message
          The existing test_subcommand method requires an exact list of arguments
          for the subcommand. This is too rigid for our needs here, so create a
          new method, test_subcommand_flex. Use it to check that the
     -    --full-name-hash option is passing through.
     +    --name-hash-version option is passing through.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     + ## Documentation/git-repack.txt ##
     +@@ Documentation/git-repack.txt: git-repack - Pack unpacked objects in a repository
     + SYNOPSIS
     + --------
     + [verse]
     +-'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>] [--write-midx]
     ++'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
     ++	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
     ++	[--write-midx] [--name-hash-version=<n>]
     + 
     + DESCRIPTION
     + -----------
     +@@ Documentation/git-repack.txt: linkgit:git-multi-pack-index[1]).
     + 	Write a multi-pack index (see linkgit:git-multi-pack-index[1])
     + 	containing the non-redundant packs.
     + 
     ++--name-hash-version=<n>::
     ++	While performing delta compression, Git groups objects that may be
     ++	similar based on heuristics using the path to that object. While
     ++	grouping objects by an exact path match is good for paths with
     ++	many versions, there are benefits for finding delta pairs across
     ++	different full paths. Git collects objects by type and then by a
     ++	"name hash" of the path and then by size, hoping to group objects
     ++	that will compress well together.
     +++
     ++The default name hash version is `1`, which prioritizes hash locality by
     ++considering the final bytes of the path as providing the maximum magnitude
     ++to the hash function. This version excels at distinguishing short paths
     ++and finding renames across directories. However, the hash function depends
     ++primarily on the final 16 bytes of the path. If there are many paths in
     ++the repo that have the same final 16 bytes and differ only by parent
     ++directory, then this name-hash may lead to too many collisions and cause
     ++poor results. At the moment, this version is required when writing
     ++reachability bitmap files with `--write-bitmap-index`.
     +++
     ++The name hash version `2` has similar locality features as version `1`,
     ++except it considers each path component separately and overlays the hashes
     ++with a shift. This still prioritizes the final bytes of the path, but also
     ++"salts" the lower bits of the hash using the parent directory names. This
     ++method allows for some of the locality benefits of version `1` while
     ++breaking most of the collisions from a similarly-named file appearing in
     ++many different directories. At the moment, this version is not allowed
     ++when writing reachability bitmap files with `--write-bitmap-index` and it
     ++will be automatically changed to version `1`.
     ++
     ++
     + CONFIGURATION
     + -------------
     + 
     +
     + ## builtin/repack.c ##
     +@@ builtin/repack.c: static int run_update_server_info = 1;
     + static char *packdir, *packtmp_name, *packtmp;
     + 
     + static const char *const git_repack_usage[] = {
     +-	N_("git repack [<options>]"),
     ++	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
     ++	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
     ++	   "[--write-midx] [--name-hash-version=<n>]"),
     + 	NULL
     + };
     + 
     +@@ builtin/repack.c: struct pack_objects_args {
     + 	int no_reuse_object;
     + 	int quiet;
     + 	int local;
     +-	int full_name_hash;
     ++	int name_hash_version;
     + 	struct list_objects_filter_options filter_options;
     + };
     + 
     +@@ builtin/repack.c: static void prepare_pack_objects(struct child_process *cmd,
     + 		strvec_pushf(&cmd->args, "--no-reuse-delta");
     + 	if (args->no_reuse_object)
     + 		strvec_pushf(&cmd->args, "--no-reuse-object");
     ++	if (args->name_hash_version)
     ++		strvec_pushf(&cmd->args, "--name-hash-version=%d", args->name_hash_version);
     + 	if (args->local)
     + 		strvec_push(&cmd->args,  "--local");
     + 	if (args->quiet)
     +@@ builtin/repack.c: int cmd_repack(int argc,
     + 				N_("pass --no-reuse-delta to git-pack-objects")),
     + 		OPT_BOOL('F', NULL, &po_args.no_reuse_object,
     + 				N_("pass --no-reuse-object to git-pack-objects")),
     ++		OPT_INTEGER(0, "name-hash-version", &po_args.name_hash_version,
     ++				N_("specify the name hash version to use for grouping similar objects by path")),
     + 		OPT_NEGBIT('n', NULL, &run_update_server_info,
     + 				N_("do not run git-update-server-info"), 1),
     + 		OPT__QUIET(&po_args.quiet, N_("be quiet")),
     +
     + ## t/t0450/txt-help-mismatches ##
     +@@ t/t0450/txt-help-mismatches: rebase
     + remote
     + remote-ext
     + remote-fd
     +-repack
     + reset
     + restore
     + rev-parse
     +
       ## t/t7700-repack.sh ##
      @@ t/t7700-repack.sh: test_expect_success 'repack -ad cleans up old .tmp-* packs' '
       	test_must_be_empty tmpfiles
       '
       
     -+test_expect_success '--full-name-hash option passes through to pack-objects' '
     -+	GIT_TRACE2_EVENT="$(pwd)/full-trace.txt" \
     -+		git repack -a --full-name-hash &&
     -+	test_subcommand_flex git pack-objects --full-name-hash <full-trace.txt
     ++test_expect_success '--name-hash-version option passes through to pack-objects' '
     ++	GIT_TRACE2_EVENT="$(pwd)/hash-trace.txt" \
     ++		git repack -a --name-hash-version=2 &&
     ++	test_subcommand_flex git pack-objects --name-hash-version=2 <hash-trace.txt
      +'
     -+
      +
       test_expect_success 'setup for update-server-info' '
       	git init update-server-info &&
 3:  259734e0bce ! 4:  6a95708bf97 pack-objects: add GIT_TEST_FULL_NAME_HASH
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    pack-objects: add GIT_TEST_FULL_NAME_HASH
     +    pack-objects: add GIT_TEST_NAME_HASH_VERSION
      
     -    Add a new environment variable to opt-in to the --full-name-hash option
     -    in 'git pack-objects'. This allows for extra testing of the feature
     -    without repeating all of the test scenarios.
     +    Add a new environment variable to opt-in to differen values of the
     +    --name-hash-version=<n> option in 'git pack-objects'. This allows for
     +    extra testing of the feature without repeating all of the test
     +    scenarios. Unlike many GIT_TEST_* variables, we are choosing to not add
     +    this to the linux-TEST-vars CI build as that test run is already
     +    overloaded. The behavior exposed by this test variable is of low risk
     +    and should be sufficient to allow manual testing when an issue arises.
      
          But this option isn't free. There are a few tests that change behavior
          with the variable enabled.
     @@ Commit message
          variable.
      
          Third, there are some tests that compare the exact output of a 'git
     -    pack-objects' process when using bitmaps. The warning that disables the
     -    --full-name-hash option causes these tests to fail. Disable the
     -    environment variable to get around this issue.
     +    pack-objects' process when using bitmaps. The warning that ignores the
     +    --name-hash-version=2 and forces version 1 causes these tests to fail.
     +    Disable the environment variable to get around this issue.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     @@ builtin/pack-objects.c: struct configured_exclusion {
       static struct oidmap configured_exclusions;
       
       static struct oidset excluded_by_config;
     --static int use_full_name_hash;
     -+static int use_full_name_hash = -1;
     +-static int name_hash_version = 1;
     ++static int name_hash_version = -1;
       
     - static inline uint32_t pack_name_hash_fn(const char *name)
     + static void validate_name_hash_version(void)
       {
      @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
       	if (pack_to_stdout || !rev_list_all)
       		write_bitmap_index = 0;
       
     --	if (write_bitmap_index && use_full_name_hash) {
     -+	if (use_full_name_hash < 0)
     -+		use_full_name_hash = git_env_bool("GIT_TEST_FULL_NAME_HASH", 0);
     ++	if (name_hash_version < 0)
     ++		name_hash_version = (int)git_env_ulong("GIT_TEST_NAME_HASH_VERSION", 1);
      +
     -+	if (write_bitmap_index && use_full_name_hash > 0) {
     - 		warning(_("currently, the --full-name-hash option is incompatible with --write-bitmap-index"));
     - 		use_full_name_hash = 0;
     - 	}
     -
     - ## ci/run-build-and-tests.sh ##
     -@@ ci/run-build-and-tests.sh: linux-TEST-vars)
     - 	export GIT_TEST_NO_WRITE_REV_INDEX=1
     - 	export GIT_TEST_CHECKOUT_WORKERS=2
     - 	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
     -+	export GIT_TEST_FULL_NAME_HASH=1
     - 	;;
     - linux-clang)
     - 	export GIT_TEST_DEFAULT_HASH=sha1
     + 	validate_name_hash_version();
     + 	if (write_bitmap_index && name_hash_version != 1) {
     + 		warning(_("currently, --write-bitmap-index requires --name-hash-version=1"));
      
       ## t/README ##
      @@ t/README: a test and then fails then the whole test run will abort. This can help to make
       sure the expected tests are executed and not silently skipped when their
       dependency breaks or is simply not present in a new environment.
       
     -+GIT_TEST_FULL_NAME_HASH=<boolean>, when true, sets the default name-hash
     -+function in 'git pack-objects' to be the one used by the --full-name-hash
     -+option.
     ++GIT_TEST_NAME_HASH_VERSION=<int>, when set, causes 'git pack-objects' to
     ++assume '--name-hash-version=<n>'.
     ++
      +
       Naming Tests
       ------------
       
      
     + ## t/t5300-pack-object.sh ##
     +@@ t/t5300-pack-object.sh: do
     + done
     + 
     + test_expect_success 'valid and invalid --name-hash-versions' '
     ++	sane_unset GIT_TEST_NAME_HASH_VERSION &&
     ++
     + 	# Valid values are hard to verify other than "do not fail".
     + 	# Performance tests will be more valuable to validate these versions.
     +-	for value in 1 2
     ++	# Negative values are converted to version 1.
     ++	for value in -1 1 2
     + 	do
     + 		git pack-objects base --all --name-hash-version=$value || return 1
     + 	done &&
     + 
     + 	# Invalid values have clear post-conditions.
     +-	for value in -1 0 3
     ++	for value in 0 3
     + 	do
     + 		test_must_fail git pack-objects base --all --name-hash-version=$value 2>err &&
     + 		test_grep "invalid --name-hash-version option" err || return 1
     +
       ## t/t5310-pack-bitmaps.sh ##
      @@ t/t5310-pack-bitmaps.sh: test_bitmap_cases () {
       			cat >expect <<-\EOF &&
       			error: missing value for '\''pack.preferbitmaptips'\''
       			EOF
     +-			git repack -adb 2>actual &&
      +
     -+			# Disable --full-name-hash test due to stderr comparison.
     -+			GIT_TEST_FULL_NAME_HASH=0 \
     - 			git repack -adb 2>actual &&
     ++			# Disable name hash version adjustment due to stderr comparison.
     ++			GIT_TEST_NAME_HASH_VERSION=1 \
     ++				git repack -adb 2>actual &&
       			test_cmp expect actual
       		)
     + 	'
      
       ## t/t5333-pseudo-merge-bitmaps.sh ##
      @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'bitmapPseudoMerge.stableThreshold creates stable groups' '
     @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'bitmapPseudoMerge.stableTh
       
       test_expect_success 'out of order thresholds are rejected' '
      +	# Disable this option to avoid stderr message
     -+	GIT_TEST_FULL_NAME_HASH=0 &&
     -+	export GIT_TEST_FULL_NAME_HASH &&
     ++	GIT_TEST_NAME_HASH_VERSION=1 &&
     ++	export GIT_TEST_NAME_HASH_VERSION &&
      +
       	test_must_fail git \
       		-c bitmapPseudoMerge.test.pattern="refs/*" \
     @@ t/t5510-fetch.sh: test_expect_success 'all boundary commits are excluded' '
       	ad=$(git log --no-walk --format=%ad HEAD) &&
      -	git bundle create twoside-boundary.bdl main --since="$ad" &&
      +
     -+	# If the --full-name-hash function is used here, then no delta
     ++	# If the a different name hash function is used here, then no delta
      +	# pair is found and the bundle does not expand to three objects
      +	# when fixing the thin object.
     -+	GIT_TEST_FULL_NAME_HASH=0 \
     ++	GIT_TEST_NAME_HASH_VERSION=1 \
      +		git bundle create twoside-boundary.bdl main --since="$ad" &&
       	test_bundle_object_count --thin twoside-boundary.bdl 3
       '
     @@ t/t5616-partial-clone.sh: test_expect_success 'fetch lazy-fetches only to resolv
      -	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
      +	#
      +	# TODO: the --full-name-hash option is disabled here, since this test
     -+	# is fundamentally broken! When GIT_TEST_FULL_NAME_HASH=1, the server
     ++	# is fundamentally broken! When GIT_TEST_NAME_HASH_VERSION=2, the server
      +	# recognizes delta bases in a different way and then sends a _blob_ to
      +	# the client with a delta base that the client does not have! This is
      +	# because the client is cloned from "promisor-server" with tree:0 but
     -+	# is now fetching from "server" withot any filter. This is violating the
     ++	# is now fetching from "server" without any filter. This is violating the
      +	# promise to the server that all reachable objects exist and could be
      +	# used as delta bases!
      +	GIT_TRACE_PACKET="$(pwd)/trace" \
     -+	GIT_TEST_FULL_NAME_HASH=0 \
     ++		GIT_TEST_NAME_HASH_VERSION=1 \
      +		git -C client \
       		fetch "file://$(pwd)/server" main &&
       
     @@ t/t5616-partial-clone.sh: test_expect_success 'fetch lazy-fetches only to resolv
      -	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
      +	#
      +	# TODO: the --full-name-hash option is disabled here, since this test
     -+	# is fundamentally broken! When GIT_TEST_FULL_NAME_HASH=1, the server
     ++	# is fundamentally broken! When GIT_TEST_NAME_HASH_VERSION=2, the server
      +	# recognizes delta bases in a different way and then sends a _blob_ to
      +	# the client with a delta base that the client does not have! This is
      +	# because the client is cloned from "promisor-server" with tree:0 but
     -+	# is now fetching from "server" withot any filter. This is violating the
     ++	# is now fetching from "server" without any filter. This is violating the
      +	# promise to the server that all reachable objects exist and could be
      +	# used as delta bases!
      +	GIT_TRACE_PACKET="$(pwd)/trace" \
     -+	GIT_TEST_FULL_NAME_HASH=0 \
     ++		GIT_TEST_NAME_HASH_VERSION=1 \
      +		git -C client \
       		fetch "file://$(pwd)/server" main &&
       
     @@ t/t6020-bundle-misc.sh: test_expect_success 'create bundle with --since option'
       	test_cmp expect actual &&
       
      -	git bundle create since.bdl \
     -+	# If the --full-name-hash option is used, then one fewer
     ++	# If a different name hash function is used, then one fewer
      +	# delta base is found and this counts a different number
      +	# of objects after performing --fix-thin.
     -+	GIT_TEST_FULL_NAME_HASH=0 \
     ++	GIT_TEST_NAME_HASH_VERSION=1 \
      +		git bundle create since.bdl \
       		--since "Thu Apr 7 15:27:00 2005 -0700" \
       		--all &&
     @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update --quiet passe
       	) &&
       	git clone super4 super5 &&
       	(cd super5 &&
     +-	 git submodule update --quiet --init --depth=1 submodule3 >out 2>err &&
      +	 # This test var can mess with the stderr output checked in this test.
     -+	 GIT_TEST_FULL_NAME_HASH=0 \
     - 	 git submodule update --quiet --init --depth=1 submodule3 >out 2>err &&
     ++	 GIT_TEST_NAME_HASH_VERSION=1 \
     ++		git submodule update --quiet --init --depth=1 submodule3 >out 2>err &&
       	 test_must_be_empty out &&
       	 test_must_be_empty err
     + 	) &&
      
       ## t/t7700-repack.sh ##
      @@ t/t7700-repack.sh: test_expect_success 'no bitmaps created if .keep files present' '
       	keep=${pack%.pack}.keep &&
       	test_when_finished "rm -f \"\$keep\"" &&
       	>"$keep" &&
     +-	git -C bare.git repack -ad 2>stderr &&
      +
     -+	# Disable --full-name-hash test due to stderr comparison.
     -+	GIT_TEST_FULL_NAME_HASH=0 \
     - 	git -C bare.git repack -ad 2>stderr &&
     ++	# Disable --name-hash-version test due to stderr comparison.
     ++	GIT_TEST_NAME_HASH_VERSION=1 \
     ++		git -C bare.git repack -ad 2>stderr &&
       	test_must_be_empty stderr &&
       	find bare.git/objects/pack/ -type f -name "*.bitmap" >actual &&
     + 	test_must_be_empty actual
      @@ t/t7700-repack.sh: test_expect_success 'auto-bitmaps do not complain if unavailable' '
       	blob=$(test-tool genrandom big $((1024*1024)) |
       	       git -C bare.git hash-object -w --stdin) &&
       	git -C bare.git update-ref refs/tags/big $blob &&
     +-	git -C bare.git repack -ad 2>stderr &&
      +
     -+	# Disable --full-name-hash test due to stderr comparison.
     -+	GIT_TEST_FULL_NAME_HASH=0 \
     - 	git -C bare.git repack -ad 2>stderr &&
     ++	# Disable --name-hash-version test due to stderr comparison.
     ++	GIT_TEST_NAME_HASH_VERSION=1 \
     ++		git -C bare.git repack -ad 2>stderr &&
       	test_must_be_empty stderr &&
       	find bare.git/objects/pack -type f -name "*.bitmap" >actual &&
     + 	test_must_be_empty actual
 4:  65784f85bce < -:  ----------- git-repack: update usage to match docs
 5:  c14ef6879e4 ! 5:  3b5697467c9 p5313: add size comparison test
     @@ Commit message
          adjust how compression is done, use this new performance test script to
          demonstrate their effectiveness in performance and size.
      
     -    The recently-added --full-name-hash option swaps the default name-hash
     -    algorithm with one that attempts to uniformly distribute the hashes
     -    based on the full path name instead of the last 16 characters.
     +    The recently-added --name-hash-version option allows for testing
     +    different name hash functions. Version 2 intends to preserve some of the
     +    locality of version 1 while more often breaking collisions due to long
     +    filenames.
      
     -    This has a dramatic effect on full repacks for repositories with many
     -    versions of most paths. It can have a negative impact on cases such as
     -    pushing a single change.
     +    Distinguishing objects by more of the path is critical when there are
     +    many name hash collisions and several versions of the same path in the
     +    full history, giving a significant boost to the full repack case. The
     +    locality of the hash function is critical to compressing something like
     +    a shallow clone or a thin pack representing a push of a single commit.
      
          This can be seen by running pt5313 on the open source fluentui
          repository [1]. Most commits will have this kind of output for the thin
     @@ Commit message
      
          Checked out at the parent of [2], I see the following statistics:
      
     -    Test                                               HEAD
     -    ---------------------------------------------------------------------
     -    5313.2: thin pack                                  0.37(0.43+0.02)
     -    5313.3: thin pack size                                        1.2M
     -    5313.4: thin pack with --full-name-hash            0.06(0.09+0.02)
     -    5313.5: thin pack size with --full-name-hash                 20.4K
     -    5313.6: big pack                                   2.01(7.73+0.23)
     -    5313.7: big pack size                                        20.3M
     -    5313.8: big pack with --full-name-hash             1.32(2.77+0.27)
     -    5313.9: big pack size with --full-name-hash                  19.9M
     -    5313.10: shallow fetch pack                        1.40(3.01+0.08)
     -    5313.11: shallow pack size                                   34.4M
     -    5313.12: shallow pack with --full-name-hash        1.08(1.25+0.14)
     -    5313.13: shallow pack size with --full-name-hash             35.4M
     -    5313.14: repack                                    90.70(672.88+2.46)
     -    5313.15: repack size                                        439.6M
     -    5313.16: repack with --full-name-hash              18.53(123.41+2.53)
     -    5313.17: repack size with --full-name-hash                  169.7M
     -
     -    In this case, we see positive behaviors such as a significant shrink in
     -    the size of the thin pack and full repack. The big pack is slightly
     -    smaller with --full-name-hash than without. The shallow pack is slightly
     -    larger with --full-name-hash.
     +    Test                                         HEAD
     +    ---------------------------------------------------------------
     +    5313.2: thin pack with version 1             0.37(0.44+0.02)
     +    5313.3: thin pack size with version 1                   1.2M
     +    5313.4: big pack with version 1              2.04(7.77+0.23)
     +    5313.5: big pack size with version 1                   20.4M
     +    5313.6: shallow fetch pack with version 1    1.41(2.94+0.11)
     +    5313.7: shallow pack size with version 1               34.4M
     +    5313.8: repack with version 1                95.70(676.41+2.87)
     +    5313.9: repack size with version 1                    439.3M
     +    5313.10: thin pack with version 2            0.12(0.12+0.06)
     +    5313.11: thin pack size with version 2                 22.0K
     +    5313.12: big pack with version 2             2.80(5.43+0.34)
     +    5313.13: big pack size with version 2                  25.9M
     +    5313.14: shallow fetch pack with version 2   1.77(2.80+0.19)
     +    5313.15: shallow pack size with version 2              33.7M
     +    5313.16: repack with version 2               33.68(139.52+2.58)
     +    5313.17: repack size with version 2                   160.5M
     +
     +    To make comparisons easier, I will reformat this output into a different
     +    table style:
     +
     +    | Test         | V1 Time | V2 Time | V1 Size | V2 Size |
     +    |--------------|---------|---------|---------|---------|
     +    | Thin Pack    |  0.37 s |  0.12 s |   1.2 M |  22.0 K |
     +    | Big Pack     |  2.04 s |  2.80 s |  20.4 M |  25.9 M |
     +    | Shallow Pack |  1.41 s |  1.77 s |  34.4 M |  33.7 M |
     +    | Repack       | 95.70 s | 33.68 s | 439.3 M | 160.5 M |
     +
     +    The v2 hash function successfully differentiates the CHANGELOG.md files
     +    from each other, which leads to significant improvements in the thin
     +    pack (simulating a push of this commit) and the full repack. There is
     +    some bloat in the "big pack" scenario and essentially the same results
     +    for the shallow pack.
      
          In the case of the Git repository, these numbers show some of the issues
          with this approach:
      
     -    Test                                               HEAD
     -    --------------------------------------------------------------------
     -    5313.2: thin pack                                  0.00(0.00+0.00)
     -    5313.3: thin pack size                                         589
     -    5313.4: thin pack with --full-name-hash            0.00(0.00+0.00)
     -    5313.5: thin pack size with --full-name-hash                 14.9K
     -    5313.6: big pack                                   2.07(3.57+0.17)
     -    5313.7: big pack size                                        17.6M
     -    5313.8: big pack with --full-name-hash             2.00(3.07+0.19)
     -    5313.9: big pack size with --full-name-hash                  17.9M
     -    5313.10: shallow fetch pack                        1.41(2.23+0.06)
     -    5313.11: shallow pack size                                   12.1M
     -    5313.12: shallow pack with --full-name-hash        1.22(1.66+0.04)
     -    5313.13: shallow pack size with --full-name-hash             12.4M
     -    5313.14: repack                                    15.75(89.29+1.54)
     -    5313.15: repack size                                        126.4M
     -    5313.16: repack with --full-name-hash              15.56(89.78+1.32)
     -    5313.17: repack size with --full-name-hash                  126.0M
     -
     -    The thin pack that simulates a push is much worse with --full-name-hash
     -    in this case. The name hash values are doing a lot to assist with delta
     -    bases, it seems. The big pack and shallow clone cases are slightly worse
     -    with the --full-name-hash option. Only the full repack gains some
     -    benefits in size.
     +    | Test         | V1 Time | V2 Time | V1 Size | V2 Size |
     +    |--------------|---------|---------|---------|---------|
     +    | Thin Pack    |  0.02 s |  0.02 s |   1.1 K |   1.1 K |
     +    | Big Pack     |  1.69 s |  1.95 s |  13.5 M |  14.5 M |
     +    | Shallow Pack |  1.26 s |  1.29 s |  12.0 M |  12.2 M |
     +    | Repack       | 29.51 s | 29.01 s | 237.7 M | 238.2 M |
     +
     +    Here, the attempts to remove conflicts in the v2 function seem to cause
     +    slight bloat to these sizes. This shows that the Git repository benefits
     +    a lot from cross-path delta pairs.
      
          The results are similar with the nodejs/node repo:
      
     -    Test                                               HEAD
     -    ---------------------------------------------------------------------
     -    5313.2: thin pack                                  0.01(0.01+0.00)
     -    5313.3: thin pack size                                        1.6K
     -    5313.4: thin pack with --full-name-hash            0.01(0.00+0.00)
     -    5313.5: thin pack size with --full-name-hash                  3.1K
     -    5313.6: big pack                                   4.26(8.03+0.24)
     -    5313.7: big pack size                                        56.0M
     -    5313.8: big pack with --full-name-hash             4.16(6.55+0.22)
     -    5313.9: big pack size with --full-name-hash                  56.2M
     -    5313.10: shallow fetch pack                        7.67(11.80+0.29)
     -    5313.11: shallow pack size                                  104.6M
     -    5313.12: shallow pack with --full-name-hash        7.52(9.65+0.23)
     -    5313.13: shallow pack size with --full-name-hash            105.9M
     -    5313.14: repack                                    71.22(317.61+3.95)
     -    5313.15: repack size                                        739.9M
     -    5313.16: repack with --full-name-hash              48.85(267.02+3.72)
     -    5313.17: repack size with --full-name-hash                  793.5M
     +    | Test         | V1 Time | V2 Time | V1 Size | V2 Size |
     +    |--------------|---------|---------|---------|---------|
     +    | Thin Pack    |  0.02 s |  0.02 s |   1.6 K |   1.6 K |
     +    | Big Pack     |  4.61 s |  3.26 s |  56.0 M |  52.8 M |
     +    | Shallow Pack |  7.82 s |  7.51 s | 104.6 M | 107.0 M |
     +    | Repack       | 88.90 s | 73.75 s | 740.1 M | 764.5 M |
     +
     +    Here, the v2 name-hash causes some size bloat more often than it reduces
     +    the size, but it also universally improves performance time, which is an
     +    interesting reversal. This must mean that it is helping to short-circuit
     +    some delta computations even if it is not finding the most efficient
     +    ones. The performance improvement cannot be explained only due to the
     +    I/O cost of writing the resulting packfile.
      
          The Linux kernel repository was the initial target of the default name
          hash value, and its naming conventions are practically build to take the
          most advantage of the default name hash values:
      
     -    Test                                               HEAD
     -    -------------------------------------------------------------------------
     -    5313.2: thin pack                                  0.15(0.01+0.03)
     -    5313.3: thin pack size                                        4.6K
     -    5313.4: thin pack with --full-name-hash            0.03(0.02+0.01)
     -    5313.5: thin pack size with --full-name-hash                  6.8K
     -    5313.6: big pack                                   18.51(33.74+0.95)
     -    5313.7: big pack size                                       201.1M
     -    5313.8: big pack with --full-name-hash             16.01(29.81+0.88)
     -    5313.9: big pack size with --full-name-hash                 202.1M
     -    5313.10: shallow fetch pack                        11.49(17.61+0.54)
     -    5313.11: shallow pack size                                  269.2M
     -    5313.12: shallow pack with --full-name-hash        11.24(15.25+0.56)
     -    5313.13: shallow pack size with --full-name-hash            269.8M
     -    5313.14: repack                                    1001.25(2271.06+38.86)
     -    5313.15: repack size                                          2.5G
     -    5313.16: repack with --full-name-hash              625.75(1941.96+36.09)
     -    5313.17: repack size with --full-name-hash                    2.6G
     +    | Test         | V1 Time  | V2 Time  | V1 Size | V2 Size |
     +    |--------------|----------|----------|---------|---------|
     +    | Thin Pack    |   0.17 s |   0.07 s |   4.6 K |   4.6 K |
     +    | Big Pack     |  17.88 s |  12.35 s | 201.1 M | 159.1 M |
     +    | Shallow Pack |  11.05 s |  22.94 s | 269.2 M | 273.8 M |
     +    | Repack       | 727.39 s | 566.95 s |   2.5 G |   2.5 G |
     +
     +    Here, the thin and big packs gain some performance boosts in time, with
     +    a modest gain in the size of the big pack. The shallow pack, however, is
     +    more expensive to compute, likely because similarly-named files across
     +    different directories are farther apart in the name hash ordering in v2.
     +    The repack also gains benefits in computation time but no meaningful
     +    change to the full size.
      
          Finally, an internal Javascript repo of moderate size shows significant
     -    gains when repacking with --full-name-hash due to it having many name
     +    gains when repacking with --name-hash-version=2 due to it having many name
          hash collisions. However, it's worth noting that only the full repack
     -    case has enough improvement to be worth it. But the improvements are
     -    significant: 6.4 GB to 862 MB.
     -
     -    Test                                               HEAD
     -    --------------------------------------------------------------------------
     -    5313.2: thin pack                                  0.03(0.02+0.00)
     -    5313.3: thin pack size                                        1.2K
     -    5313.4: thin pack with --full-name-hash            0.03(0.03+0.00)
     -    5313.5: thin pack size with --full-name-hash                  2.6K
     -    5313.6: big pack                                   2.20(3.23+0.30)
     -    5313.7: big pack size                                       130.7M
     -    5313.8: big pack with --full-name-hash             2.33(3.17+0.34)
     -    5313.9: big pack size with --full-name-hash                 131.0M
     -    5313.10: shallow fetch pack                        3.56(6.02+0.32)
     -    5313.11: shallow pack size                                   44.5M
     -    5313.12: shallow pack with --full-name-hash        2.94(3.94+0.32)
     -    5313.13: shallow pack size with --full-name-hash             45.3M
     -    5313.14: repack                                    2435.22(12523.11+23.53)
     -    5313.15: repack size                                          6.4G
     -    5313.16: repack with --full-name-hash              473.25(1805.11+17.22)
     -    5313.17: repack size with --full-name-hash                  861.9M
     -
     -    These tests demonstrate that it is important to be careful about which
     -    cases are best for using the --full-name-hash option.
     +    case has significant differences from the v1 name hash:
     +
     +    | Test      | V1 Time   | V2 Time  | V1 Size | V2 Size |
     +    |-----------|-----------|----------|---------|---------|
     +    | Thin Pack |    8.28 s |   7.28 s |  16.8 K |  16.8 K |
     +    | Big Pack  |   12.81 s |  11.66 s |  29.1 M |  29.1 M |
     +    | Shallow   |    4.86 s |   4.06 s |  42.5 M |  44.1 M |
     +    | Repack    | 3126.50 s | 496.33 s |   6.2 G | 855.6 M |
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     @@ t/perf/p5313-pack-objects.sh (new)
      +	EOF
      +'
      +
     -+test_perf 'thin pack' '
     -+	git pack-objects --thin --stdout --revs --sparse  <in-thin >out
     -+'
     -+
     -+test_size 'thin pack size' '
     -+	test_file_size out
     -+'
     ++for version in 1 2
     ++do
     ++	export version
      +
     -+test_perf 'thin pack with --full-name-hash' '
     -+	git pack-objects --thin --stdout --revs --sparse --full-name-hash <in-thin >out
     -+'
     ++	test_perf "thin pack with version $version" '
     ++		git pack-objects --thin --stdout --revs --sparse \
     ++			--name-hash-version=$version <in-thin >out
     ++	'
      +
     -+test_size 'thin pack size with --full-name-hash' '
     -+	test_file_size out
     -+'
     ++	test_size "thin pack size with version $version" '
     ++		test_file_size out
     ++	'
      +
     -+test_perf 'big pack' '
     -+	git pack-objects --stdout --revs --sparse  <in-big >out
     -+'
     ++	test_perf "big pack with version $version" '
     ++		git pack-objects --stdout --revs --sparse \
     ++			--name-hash-version=$version <in-big >out
     ++	'
      +
     -+test_size 'big pack size' '
     -+	test_file_size out
     -+'
     ++	test_size "big pack size with version $version" '
     ++		test_file_size out
     ++	'
      +
     -+test_perf 'big pack with --full-name-hash' '
     -+	git pack-objects --stdout --revs --sparse --full-name-hash <in-big >out
     -+'
     ++	test_perf "shallow fetch pack with version $version" '
     ++		git pack-objects --stdout --revs --sparse --shallow \
     ++			--name-hash-version=$version <in-shallow >out
     ++	'
      +
     -+test_size 'big pack size with --full-name-hash' '
     -+	test_file_size out
     -+'
     ++	test_size "shallow pack size with version $version" '
     ++		test_file_size out
     ++	'
      +
     -+test_perf 'shallow fetch pack' '
     -+	git pack-objects --stdout --revs --sparse --shallow <in-shallow >out
     -+'
     ++	test_perf "repack with version $version" '
     ++		git repack -adf --name-hash-version=$version
     ++	'
      +
     -+test_size 'shallow pack size' '
     -+	test_file_size out
     -+'
     -+
     -+test_perf 'shallow pack with --full-name-hash' '
     -+	git pack-objects --stdout --revs --sparse --shallow --full-name-hash <in-shallow >out
     -+'
     -+
     -+test_size 'shallow pack size with --full-name-hash' '
     -+	test_file_size out
     -+'
     -+
     -+test_perf 'repack' '
     -+	git repack -adf
     -+'
     -+
     -+test_size 'repack size' '
     -+	pack=$(ls .git/objects/pack/pack-*.pack) &&
     -+	test_file_size "$pack"
     -+'
     -+
     -+test_perf 'repack with --full-name-hash' '
     -+	git repack -adf --full-name-hash
     -+'
     -+
     -+test_size 'repack size with --full-name-hash' '
     -+	pack=$(ls .git/objects/pack/pack-*.pack) &&
     -+	test_file_size "$pack"
     -+'
     ++	test_size "repack size with version $version" '
     ++		gitdir=$(git rev-parse --git-dir) &&
     ++		pack=$(ls $gitdir/objects/pack/pack-*.pack) &&
     ++		test_file_size "$pack"
     ++	'
     ++done
      +
      +test_done
 6:  b8a055cb196 < -:  ----------- pack-objects: disable --full-name-hash when shallow
 7:  ab341dd0e58 ! 6:  36f2811e3d9 test-tool: add helper for name-hash values
     @@ Commit message
          important that these hash functions do not change across Git versions.
          Add a simple test to t5310-pack-bitmaps.sh to provide some testing of
          the current values. Due to how these functions are implemented, it would
     -    be difficult to change them without disturbing these values.
     +    be difficult to change them without disturbing these values. The paths
     +    used for this test are carefully selected to demonstrate some of the
     +    behavior differences of the two current name hash versions, including
     +    which conditions will cause them to collide.
      
          Create a performance test that uses test_size to demonstrate how
          collisions occur for these hash algorithms. This test helps inform
     @@ Commit message
          My copy of the Git repository shows modest statistics around the
          collisions of the default name-hash algorithm:
      
     -    Test                                              this tree
     -    -----------------------------------------------------------------
     -    5314.1: paths at head                                        4.5K
     -    5314.2: number of distinct name-hashes                       4.1K
     -    5314.3: number of distinct full-name-hashes                  4.5K
     -    5314.4: maximum multiplicity of name-hashes                    13
     -    5314.5: maximum multiplicity of fullname-hashes                 1
     +    Test                               this tree
     +    --------------------------------------------------
     +    5314.1: paths at head                         4.5K
     +    5314.2: distinct hash value: v1               4.1K
     +    5314.3: maximum multiplicity: v1                13
     +    5314.4: distinct hash value: v2               4.2K
     +    5314.5: maximum multiplicity: v2                 9
      
          Here, the maximum collision multiplicity is 13, but around 10% of paths
          have a collision with another path.
     @@ Commit message
          In a more interesting example, the microsoft/fluentui [1] repo had these
          statistics at time of committing:
      
     -    Test                                              this tree
     -    -----------------------------------------------------------------
     -    5314.1: paths at head                                       19.6K
     -    5314.2: number of distinct name-hashes                       8.2K
     -    5314.3: number of distinct full-name-hashes                 19.6K
     -    5314.4: maximum multiplicity of name-hashes                   279
     -    5314.5: maximum multiplicity of fullname-hashes                 1
     +    Test                               this tree
     +    --------------------------------------------------
     +    5314.1: paths at head                        19.5K
     +    5314.2: distinct hash value: v1               8.2K
     +    5314.3: maximum multiplicity: v1               279
     +    5314.4: distinct hash value: v2              17.8K
     +    5314.5: maximum multiplicity: v2                44
      
          [1] https://github.com/microsoft/fluentui
      
     @@ Commit message
          assigned to a single value, leading the packing algorithm to sort
          objects from those paths together, by size.
      
     -    In this repository, no collisions occur for the full-name-hash
     -    algorithm.
     +    With the v2 name hash function, the maximum multiplicity lowers to 44,
     +    leaving some room for further improvement.
      
          In a more extreme example, an internal monorepo had a much worse
          collision rate:
      
     -    Test                                              this tree
     -    -----------------------------------------------------------------
     -    5314.1: paths at head                                      221.6K
     -    5314.2: number of distinct name-hashes                      72.0K
     -    5314.3: number of distinct full-name-hashes                221.6K
     -    5314.4: maximum multiplicity of name-hashes                 14.4K
     -    5314.5: maximum multiplicity of fullname-hashes                 2
     +    Test                               this tree
     +    --------------------------------------------------
     +    5314.1: paths at head                       227.3K
     +    5314.2: distinct hash value: v1              72.3K
     +    5314.3: maximum multiplicity: v1             14.4K
     +    5314.4: distinct hash value: v2             166.5K
     +    5314.5: maximum multiplicity: v2               138
      
     -    Even in this repository with many more paths at HEAD, the collision rate
     -    was low and the maximum number of paths being grouped into a single
     -    bucket by the full-path-name algorithm was two.
     +    Here, we can see that the v2 name hash function provides somem
     +    improvements, but there are still a number of collisions that could lead
     +    to repacking problems at this scale.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     @@ t/helper/test-name-hash.c (new)
      +	struct strbuf line = STRBUF_INIT;
      +
      +	while (!strbuf_getline(&line, stdin)) {
     -+		uint32_t name_hash = pack_name_hash(line.buf);
     -+		uint32_t full_hash = pack_full_name_hash(line.buf);
     -+
     -+		printf("%10"PRIu32"\t%10"PRIu32"\t%s\n", name_hash, full_hash, line.buf);
     ++		printf("%10u ", pack_name_hash(line.buf));
     ++		printf("%10u ", pack_name_hash_v2(line.buf));
     ++		printf("%s\n", line.buf);
      +	}
      +
      +	strbuf_release(&line);
     @@ t/perf/p5314-name-hash.sh (new)
      +
      +test_size 'paths at head' '
      +	git ls-tree -r --name-only HEAD >path-list &&
     -+	wc -l <path-list
     -+'
     -+
     -+test_size 'number of distinct name-hashes' '
     -+	cat path-list | test-tool name-hash >name-hashes &&
     -+	cat name-hashes | awk "{ print \$1; }" | sort -n | uniq -c >name-hash-count &&
     -+	wc -l <name-hash-count
     ++	wc -l <path-list &&
     ++	test-tool name-hash <path-list >name-hashes
      +'
      +
     -+test_size 'number of distinct full-name-hashes' '
     -+	cat name-hashes | awk "{ print \$2; }" | sort -n | uniq -c >full-name-hash-count &&
     -+	wc -l <full-name-hash-count
     -+'
     ++for version in 1 2
     ++do
     ++	test_size "distinct hash value: v$version" '
     ++		awk "{ print \$$version; }" <name-hashes | sort | \
     ++			uniq -c >name-hash-count &&
     ++		wc -l <name-hash-count
     ++	'
      +
     -+test_size 'maximum multiplicity of name-hashes' '
     -+	cat name-hash-count | \
     -+		sort -nr | \
     -+		head -n 1 | \
     -+		awk "{ print \$1; }"
     -+'
     -+
     -+test_size 'maximum multiplicity of fullname-hashes' '
     -+	cat full-name-hash-count | \
     -+		sort -nr | \
     -+		head -n 1 | \
     -+		awk "{ print \$1; }"
     -+'
     ++	test_size "maximum multiplicity: v$version" '
     ++		sort -nr <name-hash-count | head -n 1 |	\
     ++			awk "{ print \$1; }"
     ++	'
     ++done
      +
      +test_done
      
     @@ t/t5310-pack-bitmaps.sh: has_any () {
      +	first
      +	second
      +	third
     -+	one-long-enough-for-collisions
     -+	two-long-enough-for-collisions
     ++	a/one-long-enough-for-collisions
     ++	b/two-long-enough-for-collisions
     ++	many/parts/to/this/path/enough/to/collide/in/v2
     ++	enough/parts/to/this/path/enough/to/collide/in/v2
      +	EOF
      +
      +	test-tool name-hash <names >out &&
      +
      +	cat >expect <<-\EOF &&
     -+	2582249472	3109209818	first
     -+	2289942528	3781118409	second
     -+	2300837888	3028707182	third
     -+	2544516325	3241327563	one-long-enough-for-collisions
     -+	2544516325	4207880830	two-long-enough-for-collisions
     ++	2582249472 1763573760 first
     ++	2289942528 1188134912 second
     ++	2300837888 1130758144 third
     ++	2544516325 3963087891 a/one-long-enough-for-collisions
     ++	2544516325 4013419539 b/two-long-enough-for-collisions
     ++	1420111091 1709547268 many/parts/to/this/path/enough/to/collide/in/v2
     ++	1420111091 1709547268 enough/parts/to/this/path/enough/to/collide/in/v2
      +	EOF
      +
      +	test_cmp expect out
 -:  ----------- > 7:  3885ef8a2f7 pack-objects: prevent name hash version change
 -:  ----------- > 8:  64fd7b3ccad pack-objects: add third name hash version

-- 
gitgitgadget
