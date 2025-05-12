Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1929D25B678
	for <git@vger.kernel.org>; Mon, 12 May 2025 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041609; cv=none; b=Df+bwVGKJvICrGGTA/2uiivmkUz48wAj7rBeF4mForbpA0vIyzAftXoEU08LdzTbP8AzdOxGNqDDDKQr+2L9WTojMZi+4wu5lKJE5Ps+IfbSrBptmv/GOB5cs+bI4MaZkUX2VwtyGEkmAQdMq9H0wujXV6poVtD/tUR+jMDoZik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041609; c=relaxed/simple;
	bh=I2iNnojScggmPMt4wLo1d3gxyn7qL0tHxOEWitQhO4o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=u8z0IdYSRgItkrXZ24ojYp/IoxUAvfJSiAUKDGYel0MJgNUUNaL7dAkg0+o/qLtgeD5fvH7lyOH/SXQKewPWwoMdUmj5naYAg9WHU+CDn55xYwkPYxPB4z23XIBveOHRl37f/zkOFMUNsjYWh3UsuRdSLBTHc8glmGHxxd5pfw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tj0u0Nu2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o4MebLQb; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tj0u0Nu2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o4MebLQb"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5792F25400FA;
	Mon, 12 May 2025 05:20:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 12 May 2025 05:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747041605;
	 x=1747128005; bh=zk/cFolJXoP4rAIrMptorpI+nzaPlqr+XfPdBndrXc0=; b=
	tj0u0Nu2cVcHcQ8rvVj3N2N3dyLTOKMliZOG96Ok48QsPxW7P9RO2uTznmJRsODg
	bZJ/8l3jRG+exhoLCrBNXThkWBNVowac8XwLai+519uOalh5wnavJGlD5rP2vtjI
	ZMJfxbw/SAYQ0+92BfBTt0ZwxLXdHLxtO7zTh/agIvQKrEzssVPeQbWSoICy5aAg
	k55V6qu0zdDjflRg+U+alN1A7v2hzyVQrUiUBnVEI3d1kGmeXo52BgET7VhUBcZj
	VIkIjpqsbHJjTog0vY5RYK30SQ49K9EngLI0xtVwXYnwORSUC7lw/367mD2Tl3Xb
	/khPnj5K+i4R1aVK2r1ysA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747041605; x=
	1747128005; bh=zk/cFolJXoP4rAIrMptorpI+nzaPlqr+XfPdBndrXc0=; b=o
	4MebLQbxgNVrimvmcxhiZfbc3JIsKY5g8nwzQYHeY12CjAIQwPdioXbmHk4E61lZ
	d+NZM26G6Nbmxw1XUi7sEAE6cxeqxFEs+WeWLH4Ud62cT6qC1zj88Z5nXNYYzxwH
	TbP/ZztLWz0cTrHYMt3F6wcqjZ3Ch9Uz36iu3p8n1yvPq9Rnp70H4O3wlsBHL4gL
	ufZNcQk2nSexkF2FgVVqGDFIkHIQ8r5V/n6kBzU0Y57bZjBN53kTa+LoenQlvRDk
	7r64bqYJV7UejF8eJHMPp+mVBRVLJiqCgeIOFZVzlOTeyyzhSGsfALWtgFjPwMuk
	EIccBPKIyzjzJnKNCbW3g==
X-ME-Sender: <xms:RL0haLvFZZuZXUg3kXJweh3L8h2tyZOgbPYovPGywIDmlUPl51j4Jg>
    <xme:RL0haMdOVVTArounbJGLDWT8oQ9yxRyXLh-CExIdaVnQwE2bnzSCtxlTI2NbwJOK1
    CJNgO9gQ7zYTIti7Q>
X-ME-Received: <xmr:RL0haOys7bXrN1SGFaRAIRnqRSJORARdCiZ4csNY0opwStSc0YGxImCnS4YC3UdI_u9ieDtva6vB0kWKwXKare-0XvrDbNkdpA_D06Bl3F4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvg
    ifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhm
    pdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtph
    htthhopehgihhtsehmrghtthhhihgvuhdqmhhohidrfhhrpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RL0haKMUAlbgX-fusW8zEcCK6CLng6csTta7XDJ8y7NGTxGXvJIi2A>
    <xmx:RL0haL__9BlpkRUR3FKtbX4Z4rJDaUMBzW7CxmEJafAA2wnlraw7OA>
    <xmx:RL0haKUaERJkDFzD_Zpt6C_YC7EXHCEfBE2LDTkxFPVFVWfU4Q29ZQ>
    <xmx:RL0haMcn8ifSAr6s2eg7SAxcFNeCBNHPQdjcm13QEZMc9MPc2Vz82Q>
    <xmx:Rb0haMdIqYt_SafioyCtz-w9ksV8Df7P3cmxTYxy4cl8enGUQMpp-j-X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 05:20:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 80951fc2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 12 May 2025 09:20:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/11] Spring cleanup of "contrib/"
Date: Mon, 12 May 2025 11:19:50 +0200
Message-Id: <20250512-pks-contrib-spring-cleanup-v3-0-32e151b0bfb0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADe9IWgC/43NQQ7CIBCF4as0rMUALdS68h7GRYFpO1EpgUo0T
 e8u7cK4Mi7/l8k3M4kQECI5FjMJkDDi6HKUu4KYoXU9ULS5iWBCMskU9ddIzeimgJpGH9D11Ny
 gdQ9PtRal5tIq21UkAz5Ah88NP19yDxinMby2X4mv619s4pRRUFZaa+umrcUpH+/xTlYziW+n+
 emI7PAKBLONBKMOH2dZljdlD5FbCQEAAA==
X-Change-ID: 20250506-pks-contrib-spring-cleanup-bb23b15d6df4
In-Reply-To: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Matthieu Moy <git@matthieu-moy.fr>, Eric Sunshine <sunshine@sunshineco.com>, 
 Todd Zullinger <tmz@pobox.com>, Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.2

Hi,

as I have lamented multiple times multiple times already (e.g. [1]), the
"contrib/" directory is a bit of a mess containing many bits and pieces
that just sit there gathering dust, without getting any maintenance and
sometimes even in a clearly-broken state. So I decided to finally bite
the bullet and do a spring cleanup of "contrib/", which resulted in this
patch series here.

I have used the following reasons for removal:

  - The tool is clearly broken, e.g. it doesn't even compile.

  - The tool has a clear alternative or just isn't useful anymore.

  - The tool has already been removed, but we still carry a stub.

The next step for me would be to spell out a policy around "contrib/" to
match what Junio has said [2]:

    Things in contrib/ should either move up (to become a part of the
    core), move out (to become an independent project), or disappear.

With this model, "contrib/" would be closer to Linux' staging drivers
with the expectation that a tool should eventually be part of proper Git
in case it proves to be useful, or booted out when it doesn't seem to be
getting there.

Another subsequent step would be to split out some parts of "contrib/"
to be hosted in their own hierarchy. CMake, Coccinelle, Unicode updates,
VScode and the like are all tools that are used during development, so
they should probably not be part of "contrib/" but rather of a new
"tools/" hierarchy (we can bikeshed the name at a later point, I'm not
yet doing that in this series).

There's also other bits and pieces that serve as examples. I think we
should move these into our documentation instead of having those in
"contrib/".

Anway, this series here is just the first step.

Changes in v2:
  - Remove "contrib/stats".
  - Provide some more details about why specific tools should be safe to
    be removed.
  - Link to v1: https://lore.kernel.org/r/20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im

Changes in v3:
  - Adapt the cover letter as well as commit 4 to clarify that a script
    not receiving any updates is only used as supporting evidence, not
    as a standalone reason to remove them.
  - Don't remove "contrib/stats/packinfo.pl". We don't have a
    replacement for it, and its functionality is useful. We should
    probably add this functionality into git-verify-pack(1) itself.
  - Link to v2: https://lore.kernel.org/r/20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im

Thanks!

Patrick

[1]: <aBhZHA7av8bWH9Ac@pks.im>
[2]: <xmqq5xieq3fs.fsf@gitster.g>

---
Patrick Steinhardt (11):
      contrib: remove "remotes2config.sh"
      contrib: remove "examples" directory
      contrib: remove remote-helper stubs
      contrib: remove "thunderbird-patch-inline"
      contrib: remove "hooks" directory
      contrib: remove "mw-to-git"
      contrib: remove "persistent-https" remote helper
      contrib: remove "git-resurrect.sh"
      contrib: remove "emacs" directory
      contrib: remove "git-new-workdir"
      contrib: remove some scripts in "stats" directory

 contrib/emacs/README                               |   33 -
 contrib/emacs/git-blame.el                         |    6 -
 contrib/emacs/git.el                               |    6 -
 contrib/examples/README                            |   20 -
 contrib/git-resurrect.sh                           |  181 ---
 contrib/hooks/multimail/README.Git                 |    7 -
 contrib/hooks/post-receive-email                   |  759 -----------
 contrib/hooks/pre-auto-gc-battery                  |   42 -
 contrib/hooks/setgitperms.perl                     |  214 ---
 contrib/hooks/update-paranoid                      |  421 ------
 contrib/mw-to-git/.gitignore                       |    2 -
 contrib/mw-to-git/.perlcriticrc                    |   28 -
 contrib/mw-to-git/Git/Mediawiki.pm                 |  101 --
 contrib/mw-to-git/Makefile                         |   61 -
 contrib/mw-to-git/bin-wrapper/git                  |   14 -
 contrib/mw-to-git/git-mw.perl                      |  368 ------
 contrib/mw-to-git/git-remote-mediawiki.perl        | 1390 --------------------
 contrib/mw-to-git/git-remote-mediawiki.txt         |    7 -
 contrib/mw-to-git/t/.gitignore                     |    4 -
 contrib/mw-to-git/t/Makefile                       |   32 -
 contrib/mw-to-git/t/README                         |  124 --
 contrib/mw-to-git/t/install-wiki.sh                |   55 -
 contrib/mw-to-git/t/push-pull-tests.sh             |  144 --
 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh       |  257 ----
 contrib/mw-to-git/t/t9361-mw-to-git-push-pull.sh   |   24 -
 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh        |  347 -----
 .../mw-to-git/t/t9363-mw-to-git-export-import.sh   |  218 ---
 contrib/mw-to-git/t/t9364-pull-by-rev.sh           |   17 -
 contrib/mw-to-git/t/t9365-continuing-queries.sh    |   23 -
 contrib/mw-to-git/t/test-gitmw-lib.sh              |  432 ------
 contrib/mw-to-git/t/test-gitmw.pl                  |  223 ----
 contrib/mw-to-git/t/test.config                    |   40 -
 contrib/persistent-https/LICENSE                   |  202 ---
 contrib/persistent-https/Makefile                  |   43 -
 contrib/persistent-https/README                    |   72 -
 contrib/persistent-https/client.go                 |  189 ---
 contrib/persistent-https/main.go                   |   82 --
 contrib/persistent-https/proxy.go                  |  190 ---
 contrib/persistent-https/socket.go                 |   97 --
 contrib/remote-helpers/README                      |   15 -
 contrib/remote-helpers/git-remote-bzr              |   11 -
 contrib/remote-helpers/git-remote-hg               |   11 -
 contrib/remotes2config.sh                          |   33 -
 contrib/stats/git-common-hash                      |   26 -
 contrib/stats/mailmap.pl                           |   70 -
 contrib/thunderbird-patch-inline/README            |   20 -
 contrib/thunderbird-patch-inline/appp.sh           |   55 -
 contrib/workdir/.gitattributes                     |    1 -
 contrib/workdir/git-new-workdir                    |  105 --
 t/meson.build                                      |    1 -
 t/t1021-rerere-in-workdir.sh                       |   58 -
 t/t3000-ls-files-others.sh                         |   19 -
 52 files changed, 6900 deletions(-)

Range-diff versus v2:

 1:  a333b8ed38d =  1:  34b7ec1f76f contrib: remove "remotes2config.sh"
 2:  f245f122af2 =  2:  e125d143fe1 contrib: remove "examples" directory
 3:  dabbf0431e4 =  3:  47774701ac8 contrib: remove remote-helper stubs
 4:  f2d4f3d7304 !  4:  f6aa95af070 contrib: remove "thunderbird-patch-inline"
    @@ Commit message
         been maintained in [2], that fork hasn't received any updates since
         2020, either.
     
    -    In addition, the script itself hasn't really seen a lot of maintenance
    -    outside of a couple of global cleanups. It is quite unlikely that this
    -    setup still works, and if it did it's even less likely that somebody
    -    uses this script.
    +    As such, the ExternalEditor extension does not work with modern versions
    +    of Thunderbird anymore, and as the "thunderbird-patch-inline" script
    +    depends on the ExternalEditor extension it likely doesn't work anymore,
    +    either. The fact that this script hasn't been touched for the last 10
    +    years outside of some global cleanup supports the idea that it is not
    +    useful anymore.
     
         Remove it.
     
 5:  8cefc981ac7 =  5:  10c74632780 contrib: remove "hooks" directory
 6:  1069dfe2cb8 =  6:  2ccc0bfc5f1 contrib: remove "mw-to-git"
 7:  a69c65a5063 =  7:  105008aa841 contrib: remove "persistent-https" remote helper
 8:  8439d6a67d6 =  8:  18f43925c5a contrib: remove "git-resurrect.sh"
 9:  aa07d3d19cc =  9:  53d5f9ac8f5 contrib: remove "emacs" directory
10:  e4a6ed62353 = 10:  4c6cbee2db7 contrib: remove "git-new-workdir"
11:  faeb543c78c ! 11:  5650e501610 contrib: remove "stats" directory
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    contrib: remove "stats" directory
    +    contrib: remove some scripts in "stats" directory
     
         The "stats" directory contains a couple of scripts to do some statistics
         on a repository:
    @@ Commit message
                 Type of arg 1 to keys must be hash or array (not private variable) at contrib/stats/mailmap.pl line 64, near "$h)"
                 Execution of contrib/stats/mailmap.pl aborted due to compilation errors.
     
    -        This should be good-enough signal to indicate that nodoby is using
    +        This should be good-enough signal to indicate that nobody is using
             this script at all anymore.
     
           - "packinfo.pl" takes the output from git-verify-pack(1) and performs
    @@ Commit message
             output to be easier to read and provide some summaries. On the other
             hand it may also print filenames of blobs.
     
    -        The script has last been touched in 3b1eb124932 (contrib: update
    -        packinfo.pl to not use dashed commands, 2008-10-17), but it still
    -        works nowadays. Even so, it is quite unlikely that anybody is still
    -        using it. And if the provided information really was useful we
    -        should rather think about moving it into git-verify-pack(1) itself.
    +        We don't have any replacement for this tool. Ideally, we should move
    +        its functionality into git-verify-pack(1) itself.
     
    -    Remove the whole directory.
    +    Remove the first two scripts, but retain "packinfo.pl".
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ contrib/stats/mailmap.pl (deleted)
     -	my ($n, $e, $h) = @_;
     -	print "$n <$e> ($h->{$order_by})\n";
     -}
    -
    - ## contrib/stats/packinfo.pl (deleted) ##
    -@@
    --#!/usr/bin/perl
    --#
    --# This tool will print vaguely pretty information about a pack.  It
    --# expects the output of "git verify-pack -v" as input on stdin.
    --#
    --# $ git verify-pack -v | packinfo.pl
    --#
    --# This prints some full-pack statistics; currently "all sizes", "all
    --# path sizes", "tree sizes", "tree path sizes", and "depths".
    --#
    --# * "all sizes" stats are across every object size in the file;
    --#   full sizes for base objects, and delta size for deltas.
    --# * "all path sizes" stats are across all object's "path sizes".
    --#   A path size is the sum of the size of the delta chain, including the
    --#   base object.  In other words, it's how many bytes need be read to
    --#   reassemble the file from deltas.
    --# * "tree sizes" are object sizes grouped into delta trees.
    --# * "tree path sizes" are path sizes grouped into delta trees.
    --# * "depths" should be obvious.
    --#
    --# When run as:
    --#
    --# $ git verify-pack -v | packinfo.pl -tree
    --#
    --# the trees of objects are output along with the stats.  This looks
    --# like:
    --#
    --#   0 commit 031321c6...      803      803
    --#
    --#   0   blob 03156f21...     1767     1767
    --#   1    blob f52a9d7f...       10     1777
    --#   2     blob a8cc5739...       51     1828
    --#   3      blob 660e90b1...       15     1843
    --#   4       blob 0cb8e3bb...       33     1876
    --#   2     blob e48607f0...      311     2088
    --#      size: count 6 total 2187 min 10 max 1767 mean 364.50 median 51 std_dev 635.85
    --# path size: count 6 total 11179 min 1767 max 2088 mean 1863.17 median 1843 std_dev 107.26
    --#
    --# The first number after the sha1 is the object size, the second
    --# number is the path size.  The statistics are across all objects in
    --# the previous delta tree.  Obviously they are omitted for trees of
    --# one object.
    --#
    --# When run as:
    --#
    --# $ git verify-pack -v | packinfo.pl -tree -filenames
    --#
    --# it adds filenames to the tree.  Getting this information is slow:
    --#
    --#   0   blob 03156f21...     1767     1767 Documentation/git-lost-found.txt @ tags/v1.2.0~142
    --#   1    blob f52a9d7f...       10     1777 Documentation/git-lost-found.txt @ tags/v1.5.0-rc1~74
    --#   2     blob a8cc5739...       51     1828 Documentation/git-lost+found.txt @ tags/v0.99.9h^0
    --#   3      blob 660e90b1...       15     1843 Documentation/git-lost+found.txt @ master~3222^2~2
    --#   4       blob 0cb8e3bb...       33     1876 Documentation/git-lost+found.txt @ master~3222^2~3
    --#   2     blob e48607f0...      311     2088 Documentation/git-lost-found.txt @ tags/v1.5.2-rc3~4
    --#      size: count 6 total 2187 min 10 max 1767 mean 364.50 median 51 std_dev 635.85
    --# path size: count 6 total 11179 min 1767 max 2088 mean 1863.17 median 1843 std_dev 107.26
    --#
    --# When run as:
    --#
    --# $ git verify-pack -v | packinfo.pl -dump
    --#
    --# it prints out "sha1 size pathsize depth" for each sha1 in lexical
    --# order.
    --#
    --# 000079a2eaef17b7eae70e1f0f635557ea67b644 30 472 7
    --# 00013cafe6980411aa6fdd940784917b5ff50f0a 44 1542 4
    --# 000182eacf99cde27d5916aa415921924b82972c 499 499 0
    --# ...
    --#
    --# This is handy for comparing two packs.  Adding "-filenames" will add
    --# filenames, as per "-tree -filenames" above.
    --
    --use strict;
    --use Getopt::Long;
    --
    --my $filenames = 0;
    --my $tree = 0;
    --my $dump = 0;
    --GetOptions("tree" => \$tree,
    --           "filenames" => \$filenames,
    --           "dump" => \$dump);
    --
    --my %parents;
    --my %children;
    --my %sizes;
    --my @roots;
    --my %paths;
    --my %types;
    --my @commits;
    --my %names;
    --my %depths;
    --my @depths;
    --
    --while (<STDIN>) {
    --    my ($sha1, $type, $size, $space, $offset, $depth, $parent) = split(/\s+/, $_);
    --    next unless ($sha1 =~ /^[0-9a-f]{40}$/);
    --    $depths{$sha1} = $depth || 0;
    --    push(@depths, $depth || 0);
    --    push(@commits, $sha1) if ($type eq 'commit');
    --    push(@roots, $sha1) unless $parent;
    --    $parents{$sha1} = $parent;
    --    $types{$sha1} = $type;
    --    push(@{$children{$parent}}, $sha1);
    --    $sizes{$sha1} = $size;
    --}
    --
    --if ($filenames && ($tree || $dump)) {
    --    open(NAMES, "git name-rev --all|");
    --    while (<NAMES>) {
    --        if (/^(\S+)\s+(.*)$/) {
    --            my ($sha1, $name) = ($1, $2);
    --            $names{$sha1} = $name;
    --        }
    --    }
    --    close NAMES;
    --
    --    for my $commit (@commits) {
    --        my $name = $names{$commit};
    --        open(TREE, "git ls-tree -t -r $commit|");
    --        print STDERR "Plumbing tree $name\n";
    --        while (<TREE>) {
    --            if (/^(\S+)\s+(\S+)\s+(\S+)\s+(.*)$/) {
    --                my ($mode, $type, $sha1, $path) = ($1, $2, $3, $4);
    --                $paths{$sha1} = "$path @ $name";
    --            }
    --        }
    --        close TREE;
    --    }
    --}
    --
    --sub stats {
    --    my @data = sort {$a <=> $b} @_;
    --    my $min = $data[0];
    --    my $max = $data[$#data];
    --    my $total = 0;
    --    my $count = scalar @data;
    --    for my $datum (@data) {
    --        $total += $datum;
    --    }
    --    my $mean = $total / $count;
    --    my $median = $data[int(@data / 2)];
    --    my $diff_sum = 0;
    --    for my $datum (@data) {
    --        $diff_sum += ($datum - $mean)**2;
    --    }
    --    my $std_dev = sqrt($diff_sum / $count);
    --    return ($count, $total, $min, $max, $mean, $median, $std_dev);
    --}
    --
    --sub print_stats {
    --    my $name = shift;
    --    my ($count, $total, $min, $max, $mean, $median, $std_dev) = stats(@_);
    --    printf("%s: count %s total %s min %s max %s mean %.2f median %s std_dev %.2f\n",
    --           $name, $count, $total, $min, $max, $mean, $median, $std_dev);
    --}
    --
    --my @sizes;
    --my @path_sizes;
    --my @all_sizes;
    --my @all_path_sizes;
    --my %path_sizes;
    --
    --sub dig {
    --    my ($sha1, $depth, $path_size) = @_;
    --    $path_size += $sizes{$sha1};
    --    push(@sizes, $sizes{$sha1});
    --    push(@all_sizes, $sizes{$sha1});
    --    push(@path_sizes, $path_size);
    --    push(@all_path_sizes, $path_size);
    --    $path_sizes{$sha1} = $path_size;
    --    if ($tree) {
    --        printf("%3d%s %6s %s %8d %8d %s\n",
    --               $depth, (" " x $depth), $types{$sha1},
    --               $sha1, $sizes{$sha1}, $path_size, $paths{$sha1});
    --    }
    --    for my $child (@{$children{$sha1}}) {
    --        dig($child, $depth + 1, $path_size);
    --    }
    --}
    --
    --my @tree_sizes;
    --my @tree_path_sizes;
    --
    --for my $root (@roots) {
    --    undef @sizes;
    --    undef @path_sizes;
    --    dig($root, 0, 0);
    --    my ($aa, $sz_total) = stats(@sizes);
    --    my ($bb, $psz_total) = stats(@path_sizes);
    --    push(@tree_sizes, $sz_total);
    --    push(@tree_path_sizes, $psz_total);
    --    if ($tree) {
    --        if (@sizes > 1) {
    --            print_stats("     size", @sizes);
    --            print_stats("path size", @path_sizes);
    --        }
    --        print "\n";
    --    }
    --}
    --
    --if ($dump) {
    --    for my $sha1 (sort keys %sizes) {
    --        print "$sha1 $sizes{$sha1} $path_sizes{$sha1} $depths{$sha1} $paths{$sha1}\n";
    --    }
    --} else {
    --    print_stats("      all sizes", @all_sizes);
    --    print_stats(" all path sizes", @all_path_sizes);
    --    print_stats("     tree sizes", @tree_sizes);
    --    print_stats("tree path sizes", @tree_path_sizes);
    --    print_stats("         depths", @depths);
    --}

---
base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
change-id: 20250506-pks-contrib-spring-cleanup-bb23b15d6df4

