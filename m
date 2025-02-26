Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29F3258CC0
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558146; cv=none; b=p5iVScgnyqFB8kmr1LemOROpiM+bqDODe6bhXFknUafIpNC4lPRSQsTHMrbFGsdK5D7J50yEmXeKqT522vG8wHT1Q/S7/1Vqe21+n7I9X6pc7ek2MXzBN/Yyt/E2Yz73abX9G+KsFgLR3eS95JzETz/ouhza07FYUrNoLwZ8Z/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558146; c=relaxed/simple;
	bh=Jp50BOp8LQNc2mDd8sJ8IQ7gVLQQWYSEyUtMOhIKPyI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=CA7oz43+eREq0kyjnP9XZ4GAXoLuwiw26fjYWvnf12ijDC4sTY5GWwtn5siyfEnHV3EguLD8UGC6mGNhLSy68EW2EEBO9mJ/OYAga5AN9a/SqMwyMKjOrQGMPe1vgPuRIcxsbFH2Wc58gSqar3u3xDRKziFdXklFg4V6LhtR8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CEZnhuS/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SY8PhiLQ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CEZnhuS/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SY8PhiLQ"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C1C76114015A;
	Wed, 26 Feb 2025 03:22:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 26 Feb 2025 03:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740558143;
	 x=1740644543; bh=Mo3o5cqXv8LAKLoXmmX+fZBs8NscdNz+4VzXww5Vi5g=; b=
	CEZnhuS/7EtrAOm96haLkyAXnWJg4QJGLVsARV5P81cHEC0XSvuVyo8jiVjA+LHc
	yQ78vGuTE+OsApFkcZz6SmFzr1DkZkpNHntg7HzcZ2wYoPnInyUVuQcNWSQzPhUw
	dipOk8fGWx6Dt8vc2iFRUl5FOO417ZtFXlDZ5bTfQhnwxkfWpfi4/OO44X8MYH5h
	bEiL3G+a3eeajT8cVLrWTU/kl6opB+Hy1wouD35TEGVVOBQ2S/YJ6XaCrFCEkTeS
	kCTFFnZsmRcyyYyAUfoQYidvklReTGFdz5+kA8H3HC8vyG+y6TyIPx94EZX7rbwE
	TmiZf/3KI5PgphWz1XOdtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740558143; x=
	1740644543; bh=Mo3o5cqXv8LAKLoXmmX+fZBs8NscdNz+4VzXww5Vi5g=; b=S
	Y8PhiLQGuFr6ZRRNUKteFoOHeFOeJmNnYjC66U+RqGSjNWxxnyX6dx0lBm8cX0Hc
	51Qy1ZPQ7Kfu2TQRX1lqHEjIIeR9KcQDDzLJdIyQfPskYeO5TUEcdgR7GfRNIbeB
	Flc8V7Xduy/WwEeQ07PttHqLgrci0hZpQBMZPduLlD3z1nJxI+s8YZ0eTr6+5YdW
	NxIPtpDZEDy1wAw9AV35iZ9guy6EyzJd9L7I85jJTBTs+odQj3uGC+9ocatDlIDI
	FJQ0RzxJtXekz2BIXmk7Y8x5PojuZN/2By96k/oTnJL6NfQmJEmibRLMhSDnXzIA
	u8Glz4V8fgz1SGvScvLVA==
X-ME-Sender: <xms:P8--Z2qh6gt9ix0GLqFfHp9EroeO-vz3QlEy8UHMYC5fqoaKzZLBzA>
    <xme:P8--Z0oSmuH-KnAWVV_i1qWX8lvfc9XUgv1bqxD8aJl_fPsX53CN2UvybcwVZESeE
    OklVM34fStiYUREOg>
X-ME-Received: <xmr:P8--Z7OdoHrHceuAvC7K0ZStdebF1uVfKAOYZ5yydxCMdYgO6n2rGcbpjEXoOiNF0LeSjhGBKKI9aHBh52bYW-LEkTNAncfbIyopWaLNfJlQMTAT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdeivdekjeekkeeuffdttdehudeutddtjeehffdv
    fedtleffgefftdejteegfefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhith
    hhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:P8--Z15j-WPJcNINhajn_3mwA2c_4haIktUxMfv6YR6ZRsXihZO4dQ>
    <xmx:P8--Z16HYfv5FxsVlhhYzY8pWxokQ7JuELvfzVnEZNk91e5YDIRviQ>
    <xmx:P8--Z1izs3fo1uDgQ9hJ_699wvoT-omVEsGPcg-vtcbrljJ1fiI2fA>
    <xmx:P8--Z_79YYLEhb6aGKgvMALjG5MYgo3Ppft3yGg7WClkMToDLACMiQ>
    <xmx:P8--Z40OCnhNHhc1W8ESGh6eCC2xyDk_l2_FOohpGaHk7_PCo9lHHluk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 03:22:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2e862e3a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 08:22:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/13] meson: cleanups, improvements, smallish fixes
Date: Wed, 26 Feb 2025 09:22:10 +0100
Message-Id: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADPPvmcC/33NzQrCMAzA8VcZPRvpx+qcJ99DPKwzdUHajnYUZ
 ezd7QaKJ4//kPwys4SRMLFTNbOImRIFX0LtKtYPnb8j0K00k1xqLqQAU8P4SOAwBQ/kxhgyOvR
 TAoW60eqgsBU9K/djREvPzb5cSw+UphBf26ss1ulHbf+oWQCHzjS8tdygkP25LO7JsZXM8odR/
 B8jCyMt1/oorDV1/WWWZXkDPLm9XQYBAAA=
X-Change-ID: 20250121-b4-pks-meson-improvements-3e575363e91c
In-Reply-To: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
References: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this patch series contains a mostly-random set of smallish improvements,
simplifications and fixes to the Meson build instructions.

Changes in v2:
  - Redo the two commits regarding PATH handling. We now only prepend
    system-specific paths to PATH and handle the `-Dsane_tool_path`
    option the same.
  - Continue to propagate libcurl include directories into libgit, as we
    need it for "help.c" to resolve LIBCURL_VERSION. Reorder the patch
    to minimize the required changes.
  - Fix a commit message typo.
  - Include another commit that fixes the OpenSSL fallback on Windows.
  - Include another commit to fix linker errors due to out-of-memory
    situations on Windows with GitLab CI.
  - Link to v1: https://lore.kernel.org/r/20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im

Changes in v3:
  - Fix missing linker arguments for a couple of aliased executables on
    Windows with MSVC.
  - Link to v2: https://lore.kernel.org/r/20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im

I've kicked off an extra pipeline at [1] to verify that this version
works on next and doesn't break anything.

Thanks!

Patrick

[1]: https://github.com/git/git/pull/1898

---
Patrick Steinhardt (13):
      meson: fix exec path with enabled runtime prefix
      meson: fix OpenSSL fallback when not explicitly required
      meson: inline the static 'git' library
      meson: simplify use of the common-main library
      meson: introduce `libgit_curl` dependency
      meson: stop linking libcurl into all executables
      meson: drop separate version library
      meson: improve PATH handling
      meson: improve handling of `sane_tool_path` option
      meson: prevent finding sed(1) in a loop
      meson: fix overwritten `git` variable
      meson: consistently use custom program paths to resolve programs
      gitlab-ci: restrict maximum number of link jobs on Windows

 .gitlab-ci.yml                  |   2 +-
 Documentation/howto/meson.build |   2 +-
 Documentation/meson.build       |  13 ++--
 meson.build                     | 156 +++++++++++++++++++---------------------
 meson_options.txt               |   4 +-
 oss-fuzz/meson.build            |   2 +-
 t/helper/meson.build            |   4 +-
 t/meson.build                   |   4 +-
 8 files changed, 89 insertions(+), 98 deletions(-)

Range-diff versus v2:

 1:  94730a8bdb4 =  1:  fd7097ab8bd meson: fix exec path with enabled runtime prefix
 2:  97710a79d0f =  2:  ff8d4cd70c6 meson: fix OpenSSL fallback when not explicitly required
 3:  66a8c6f24d0 =  3:  238a45c8bb0 meson: inline the static 'git' library
 4:  f717119b1a0 !  4:  1bd9f892310 meson: simplify use of the common-main library
    @@ Commit message
         instead of creating a static library, we now instead compile the common
         set of files into each executable separately.
     
    -    This change surfaces an issue when linking aliases for git-remote-http:
    -    we extract all objects from `git-remote-http` et al and then link them
    -    into the new executable. As such, these objects would already contain
    -    a `main()` function. But now that we also compile "common-main.c" into
    -    these aliased executables we see a linker error due to `main()` being
    -    defined twice. We fix this by only linking against `libgit.a`.
    -
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## meson.build ##
    @@ meson.build: if host_machine.system() == 'windows'
        endif
      endif
     -common_main_library = static_library('common-main',
    -+
    -+libgit_commonmain = declare_dependency(
    -   sources: common_main_sources,
    +-  sources: common_main_sources,
     -  c_args: libgit_c_args,
     -  dependencies: libgit_dependencies,
     -  include_directories: libgit_include_directories,
     -)
     -common_main = declare_dependency(
     -  link_with: common_main_library,
    ++
    ++libgit_commonmain = declare_dependency(
    ++  link_with: static_library('common-main',
    ++    sources: common_main_sources,
    ++    dependencies: [ libgit ],
    ++  ),
        link_args: common_main_link_args,
     +  dependencies: [ libgit ],
      )
    @@ meson.build: if get_option('curl').enabled()
          test_dependencies += executable(alias,
            objects: git_remote_http.extract_all_objects(recursive: false),
     -      dependencies: [libgit, common_main],
    -+      dependencies: [libgit],
    ++      dependencies: [libgit_commonmain],
          )
      
          install_symlink(alias + executable_suffix,
    @@ meson.build: test_dependencies += executable('git-imap-send',
        bin_wrappers += executable(alias,
          objects: git.extract_all_objects(recursive: false),
     -    dependencies: [libgit, common_main],
    -+    dependencies: [libgit],
    ++    dependencies: [libgit_commonmain],
        )
      
        install_symlink(alias + executable_suffix,
 5:  1b61303b130 !  5:  024f4297f5e meson: introduce `libgit_curl` dependency
    @@ meson.build: if get_option('curl').enabled()
        foreach alias : [ 'git-remote-https', 'git-remote-ftp', 'git-remote-ftps' ]
          test_dependencies += executable(alias,
     -      objects: git_remote_http.extract_all_objects(recursive: false),
    --      dependencies: [libgit],
    +-      dependencies: [libgit_commonmain],
     +      sources: 'remote-curl.c',
     +      dependencies: [libgit_curl],
          )
 6:  70dc5edc05c =  6:  7fa4957e256 meson: stop linking libcurl into all executables
 7:  7fe6d1d4e74 =  7:  b24c4e06deb meson: drop separate version library
 8:  1d0597eb7cf =  8:  8ca171f9694 meson: improve PATH handling
 9:  9219ab697a7 =  9:  beedc776a7b meson: improve handling of `sane_tool_path` option
10:  7e3e0bb409f = 10:  018f549375f meson: prevent finding sed(1) in a loop
11:  c1243c17dbe ! 11:  3da8f4f105d meson: fix overwritten `git` variable
    @@ meson.build: test_dependencies += executable('git-imap-send',
        bin_wrappers += executable(alias,
     -    objects: git.extract_all_objects(recursive: false),
     +    objects: git_builtin.extract_all_objects(recursive: false),
    -     dependencies: [libgit],
    +     dependencies: [libgit_commonmain],
        )
      
12:  f06585cd99e = 12:  b2febf1acac meson: consistently use custom program paths to resolve programs
13:  02f0ffdd362 = 13:  f5bb92726dc gitlab-ci: restrict maximum number of link jobs on Windows

---
base-commit: 6dd4e543f2219290db9faa61b30f7f30a34e4b50
change-id: 20250121-b4-pks-meson-improvements-3e575363e91c

