Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A678B5CDF1
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655695; cv=none; b=U3uEUrxL27JpueKUs5YbDpCoco+3WgK2jheBzhfwYsUIyA7Jp8XHu7oXRfPtOznn29tRgHKjYyQ3CM8SY9Wn4BAzcyR0gLEIyNGBb2lINZP69fc2UMV4L0TUbng0UT8bTUMhPET6jTPjbwNUh+WZ8LUSe32KAdfxEoNUZ4H5/aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655695; c=relaxed/simple;
	bh=joWlbHz7d9F7A6j2PMbgMsdt3v4Ti7xRnxOWVhUE35k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=HKKpeeLN07I58swqhgVIzeq+JEHPhKjSb0FGhJv6edAVzJrGIj1ovCQYDd5lWzYVVYWMRDZKrBet5hZzMV8HvAsG3p+xYY/DJC1F3JQOtlV5gLTP58xsiEhqeBw5gyWFNdYW68TDBhueFKwwyr2oMUmlqClgorjRAOK8Jir5vb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bc6iGqCK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kYdpGayR; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bc6iGqCK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kYdpGayR"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED06814001D1;
	Mon, 16 Mar 2026 06:08:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 16 Mar 2026 06:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773655692;
	 x=1773742092; bh=7c1nkUb/HttiXunZ1wO8hfLpgtl86q8lwaQJLoXrRos=; b=
	Bc6iGqCKFZsx+KKZq0VB3itW1RmBZFtg+FJv+xFhyPhvs4VF2jT5CqNYf4xIZg53
	dIQUIt7UvIUGrdrYGjwpgIGBSXgHtMrMA613TobMjrE3Rj/o3h+rJSW0AMf0p0HO
	D9oNWJFpTztd3WfsdWDwn9n+eS9J4VTKfFMcYi1DMO2RVbj1TbPLjnk3fJ5n36pK
	6jicBMJsZ7yxz+norYHfa88ETNWEcI1dN6fOw+O0KODYqJYmYinrSP4uPLBEx+CV
	adlL2CLlY0uuNWOpv/on2dXeVDnPTlukZLwGGBG0B2v6Ng08tMj/YE8bTbwfpyTX
	48h3KHw86wwlURabgXO1HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773655692; x=
	1773742092; bh=7c1nkUb/HttiXunZ1wO8hfLpgtl86q8lwaQJLoXrRos=; b=k
	YdpGayRjXYcJGRZKEcI7nBj0pNTL4D2K9v3H8DUOQRfQQ0f11UokNt0/GTi3rBo1
	08GPerpwSk1K9My8Az8Knofe0h/hwKddBSw7kg8AXBvE+lTsM6gpll62uJfqzhyD
	j+UDW9D33BsF5WSxZiX21RKMET1D26YU7xcM4H1811VoxI2Hf3WCrQKw6vwcwIUJ
	a1EwAyYapSbbyqfsIyU/TwILvLV2qhg97BaWrm+TBiILpLydbyGs7N5o3G3XfX8u
	0Vfyde5n6f65Kcyvu8R090lZsx92fSCIEYOjX1PV1vhCQCrdHG9NcV+vCs2Dz7Kr
	lkXsQ5JQbAKHJx8iNnFZg==
X-ME-Sender: <xms:jNa3aTPX4q8UjX0O6uf5uwSe8UecogoAo2KAAKVjjl8jUW0aOmKISg>
    <xme:jNa3abyAESccUxrNtHOUgRvk6T4hiiCDRWnadeWflUS4SXTiQC2mJwvaiRNveoKwC
    1U1YcL4fUeM01TtDE5ICvz-ZwgdePrsTvmum5oMpAsyQLK6ISrDvA>
X-ME-Received: <xmr:jNa3acvtrb4IruBLCtBO6urrNwTCxNVudCEcTP2tWSOJ_mk1V3CzhZKeRSDhJugVlXA77HCyR2F1MUER4MyGdZt1TWUbtLETsp_EL5Y5oyI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedtfeeulefhudejleehkeevkeejvdegvedufedugfeludfhfedvveetfedtffdtveen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhmrghkrdguvghvpdhgnhhurdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehp
    khhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsiigvuggv
    rhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    esughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:jNa3aU7vbAN8JCg7Z6QJRz3vrybU77CJpSCupl9sDp0YAPKlUCqRqg>
    <xmx:jNa3abQLNRxqFYwsFIL-yZkjNtP9lFvj0R-j9N3aT7Ca1yU9vh9kKQ>
    <xmx:jNa3aTqaNqgIQApIbHNuPYTHuIdFNvHov_7GLRA3Tj8xSMvMeWDhSg>
    <xmx:jNa3aZJZWsprUI6oldqvCXuXalOPSfmv4mU8MjnNCRahFLOxlSRUDA>
    <xmx:jNa3aYpiPvuHINoAMi7ZcmjoycXxv1VPupJoCE2TUwEtgQXzSgFXFMe7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 06:08:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e5a4fc1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Mar 2026 10:08:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/8] Some build system improvements
Date: Mon, 16 Mar 2026 11:07:55 +0100
Message-Id: <20260316-b4-pks-build-infra-improvements-v2-0-4b2c2c0c0425@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHzWt2kC/4WNQQ6CMBBFr0Jm7ZhpKZC48h6GBbSDTJRCWmw0h
 LtbjXuX7+fnvQ0iB+EIp2KDwEmizD6DPhRgx85fGcVlBk26ppIM9gaXW8T+IXeH4ofQoUxLmBN
 P7NeI1hpS2lZlbRiyZQk8yPNbuLSZR4nrHF7fYFKf9edW9NedFBKybSpHjSJXd+d8P8oE7b7vb
 51eKvnLAAAA
X-Change-ID: 20260304-b4-pks-build-infra-improvements-cc4012c5364e
In-Reply-To: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3

Hi,

this patch series contains a small set of build system improvements:

  - The first couple patches introduce a new "tools/" directory that
    contains items related to our build infrastructure and to our
    developer tooling. This finally follows up on my promise to do this
    back when I did the spring clean of "contrib/". [1]

  - The last couple patches introduce precompiled headers into Meson for
    a nice compilation speedup of ~30%. It's 

The two topics are not really related with one another other than being
related to build systems. I decided to throw them in the same patch
series though so that I can introduce "precompiled.h" in "tools/".

Changes in v2:
  - Turn array of precompiled headers into a simple string.
  - Point out in the commit message that the precompiled header is
    included implicitly.
  - Link to v1: https://lore.kernel.org/r/20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im

Thanks!

Patrick

[1]: https://lore.kernel.org/git/20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im/

---
Patrick Steinhardt (8):
      Introduce new "tools/" directory
      contrib: move "coccinelle/" directory into "tools/"
      contrib: move "coverage-diff.sh" script into "tools/"
      contrib: move "update-unicode.sh" script into "tools/"
      builds: move build scripts into "tools/"
      git-compat-util.h: move warning infra to prepare for PCHs
      meson: compile compatibility sources separately
      meson: precompile "git-compat-util.h"

 Makefile                                           | 76 ++++++++---------
 ci/run-static-analysis.sh                          |  2 +-
 config.mak.dev                                     |  2 +-
 contrib/buildsystems/CMakeLists.txt                | 18 ++--
 contrib/meson.build                                |  1 -
 contrib/subtree/meson.build                        |  2 +-
 git-compat-util.h                                  |  8 +-
 meson.build                                        | 96 +++++++++++++---------
 tools/README.md                                    |  7 ++
 check-builtins.sh => tools/check-builtins.sh       |  0
 {contrib => tools}/coccinelle/.gitignore           |  0
 {contrib => tools}/coccinelle/README               |  2 +-
 {contrib => tools}/coccinelle/array.cocci          |  0
 {contrib => tools}/coccinelle/commit.cocci         |  0
 .../coccinelle/config_fn_ctx.pending.cocci         |  0
 {contrib => tools}/coccinelle/equals-null.cocci    |  0
 {contrib => tools}/coccinelle/flex_alloc.cocci     |  0
 {contrib => tools}/coccinelle/free.cocci           |  0
 .../coccinelle/git_config_number.cocci             |  0
 {contrib => tools}/coccinelle/hashmap.cocci        |  0
 .../coccinelle/index-compatibility.cocci           |  0
 {contrib => tools}/coccinelle/meson.build          |  0
 {contrib => tools}/coccinelle/object_id.cocci      |  0
 {contrib => tools}/coccinelle/preincr.cocci        |  0
 {contrib => tools}/coccinelle/qsort.cocci          |  0
 {contrib => tools}/coccinelle/refs.cocci           |  0
 {contrib => tools}/coccinelle/spatchcache          |  6 +-
 {contrib => tools}/coccinelle/strbuf.cocci         |  0
 {contrib => tools}/coccinelle/swap.cocci           |  0
 {contrib => tools}/coccinelle/tests/free.c         |  0
 {contrib => tools}/coccinelle/tests/free.res       |  0
 {contrib => tools}/coccinelle/the_repository.cocci |  0
 {contrib => tools}/coccinelle/xcalloc.cocci        |  0
 {contrib => tools}/coccinelle/xopen.cocci          |  0
 .../coccinelle/xstrdup_or_null.cocci               |  0
 {contrib => tools}/coccinelle/xstrncmpz.cocci      |  0
 {contrib => tools}/coverage-diff.sh                |  0
 detect-compiler => tools/detect-compiler           |  0
 generate-cmdlist.sh => tools/generate-cmdlist.sh   |  0
 .../generate-configlist.sh                         |  0
 generate-hooklist.sh => tools/generate-hooklist.sh |  0
 generate-perl.sh => tools/generate-perl.sh         |  0
 generate-python.sh => tools/generate-python.sh     |  0
 generate-script.sh => tools/generate-script.sh     |  0
 tools/meson.build                                  |  1 +
 tools/precompiled.h                                |  1 +
 {contrib => tools}/update-unicode/.gitignore       |  0
 {contrib => tools}/update-unicode/README           |  0
 .../update-unicode/update_unicode.sh               |  0
 49 files changed, 123 insertions(+), 99 deletions(-)

Range-diff versus v1:

1:  224e28be31 = 1:  9d09d2c39a Introduce new "tools/" directory
2:  b217df51e5 = 2:  1b96bfe0f4 contrib: move "coccinelle/" directory into "tools/"
3:  e371b6c221 = 3:  ed6e90bd36 contrib: move "coverage-diff.sh" script into "tools/"
4:  3efeda9fa0 = 4:  48d8275ed1 contrib: move "update-unicode.sh" script into "tools/"
5:  ee074c1396 = 5:  daafeb3462 builds: move build scripts into "tools/"
6:  d30d4a3119 = 6:  947fc0f7b4 git-compat-util.h: move warning infra to prepare for PCHs
7:  ca118197a9 = 7:  6a2fb99aae meson: compile compatibility sources separately
8:  a865a8650b ! 8:  857b478896 meson: precompile "git-compat-util.h"
    @@ Commit message
         set up properly it means that the file won't need to be reprocessed.
     
         Set up such a precompiled header for "git-compat-util.h" and wire it up
    -    via Meson. This leads to a significant speedup when performing full
    -    builds:
    +    via Meson. This causes Meson to implicitly include the precompiled
    +    header in all compilation units. With GCC and Clang for example this is
    +    done via the "-include" statement [1].
    +
    +    This leads to a significant speedup when performing full builds:
     
           Benchmark 1: ninja (rev = HEAD~)
           Time (mean ± σ):     14.467 s ±  0.126 s    [User: 248.133 s, System: 31.298 s]
    @@ Commit message
             ninja (rev = HEAD) ran
               1.40 ± 0.02 times faster than ninja (rev = HEAD~)
     
    +    [1]: https://gcc.gnu.org/onlinedocs/gcc/Precompiled-Headers.html
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## meson.build ##
    @@ meson.build: libgit = declare_dependency(
            c_args: libgit_c_args + [
              '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
            ],
    -+      c_pch: [ 'tools/precompiled.h' ],
    ++      c_pch: 'tools/precompiled.h',
            dependencies: libgit_dependencies,
            include_directories: libgit_include_directories,
          ),
    @@ meson.build: test_dependencies = [ ]
      
      git_builtin = executable('git',
        sources: builtin_sources + 'git.c',
    -+  c_pch: [ 'tools/precompiled.h' ],
    ++  c_pch: 'tools/precompiled.h',
        dependencies: [libgit_commonmain],
        install: true,
        install_dir: git_exec_path,

---
base-commit: af2c8a61818d773325ef2324dd135786a03ebca0
change-id: 20260304-b4-pks-build-infra-improvements-cc4012c5364e

