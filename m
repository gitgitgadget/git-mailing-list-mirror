Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5329A275863
	for <git@vger.kernel.org>; Fri,  9 May 2025 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782236; cv=none; b=olvEUBEDM8FwIc1V1eGBH3Y8KjGn8Dm1vSOIaRraLi9+LcOwU1tOGZLss6YDTirz3kcFGOHKVIHW+0AVVoc1KyZ5lKSfy6hBdZfW9ROozqWQ3LGU40kw/ulwhD/foMGD8BHkHhshOqh+I/yzl9B6v75rjrub5lusKtWij4P7Q2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782236; c=relaxed/simple;
	bh=hd9vZNj4lHBKfAV5+JFqjlcaW4Hb3lJ+aI54K/2VU00=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=lsNdSJSpHT8PofvGW44pB2XUYqgPYu0nG4B7DBbtG46POM725D8RysovbrWTkmXyqB+4mFaE6TnD/CkNjeQiXbMSO9Vs5w7lvXmOtIqcY+mFFd1vRRCRia6OitEQIXuBNp+V6F7NeJL5Oeo23SNiyyXpz97n7nrXaZ+CsI+0yS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kl9bFLKV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oFE8ajQt; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kl9bFLKV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oFE8ajQt"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 359FB114019E;
	Fri,  9 May 2025 05:17:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 09 May 2025 05:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746782232;
	 x=1746868632; bh=iBrGnb3T8EmPaUlbHBzI0lWKqEKdo4QpA/gsm3qh5j4=; b=
	Kl9bFLKVA0JHymBQ8KAilmOPC2a7fynycshg7xY6IWubId/R+TZ5mJ4M66B58q7n
	VxgSgmhjONthn+gKyO0Nv4yzid6lqu5G1hBdkPYKeGUZ3icspUsamDqSgk7kVCJ1
	VX5mA3pVPbSWK325YibipsyvDP2oJ20+mEDqgOlIwQZ5GfdYkORrOVf21kZaRsE3
	qz96jyvnvxqZTyHFNq+Z9EuZhY9Gqynxv27PTQWU0ybGuCx8TUqsUzivDRz2ogJi
	gY4tr0LXPgblp9Lgi6AelSr1ze/B4kIZ1eP3sSiVojwsCxWQBg38qMEKL9NKm47A
	8pNjo+SvvQLfG/jCQE+GRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746782232; x=
	1746868632; bh=iBrGnb3T8EmPaUlbHBzI0lWKqEKdo4QpA/gsm3qh5j4=; b=o
	FE8ajQtAsUSk9BemFNF3sNCh3/rw8mKjPffNufHpizrdrrDCp6FMY8xTrQaXQPpT
	jsZlRwKdlIm3uu8s0HGdBznLQdbKQUyPP6DDve15AsT3OyjEzu6tiioVHW1HId5g
	vNZRiiEji0lcFEGIBXP6zyc689pbO1fHs1Jz/ekyxe0vD81bukw4JwhrAxp7LEob
	rjjbh2pT9SpuTb+YL7omgL7whs7sn7A0jcXOghReBFD6eNeknBq5zfkA30q1YL4A
	QKnG5b+awLN4rnfdZjHHT7XErkH+AZlSjbIsg2yEO5HeMlkezo6BvgqmLa6Goz+0
	+BgS1kuE7PtI0emSFtNMA==
X-ME-Sender: <xms:F8gdaHB64TxclmpCZpYw6FjiiA6LwsMleuILPUO2lZpr6tu2I2A3Fg>
    <xme:F8gdaNjdN8eBXUbP0BwRkhiCiPV9RBYG-rkVwhQWcvNO_Ynh2t4zBEwjLjYKIBuPH
    D1CqXxwur2uJn7_Qw>
X-ME-Received: <xmr:F8gdaCndmc4iVsXyUZ5D_lBXZRGQ50KCVyBylvwFvKLoI-i_lsNixbhTOm8gMfqNX8IlpcspHhNFdN7PC7RpR33vA6y0bFgMIZg-FdOHYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeegtddugedvhedttddugfeljeefgeejueegfeek
    tdeggfdvleejhfetieffveevteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgih
    hthhhusgdrtghomhdpshhtrggtkhhovhgvrhhflhhofidrtghomhenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehm
    rghtthhhihgvuhdqmhhohidrfhhrpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnsh
    hhihhnvggtohdrtghomhdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghp
    thhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:F8gdaJxs5egRNtKqSdqKNNT38v1ms4CpWvYy542l0EMUDGFYpgYDnQ>
    <xmx:F8gdaMQqV-0gEBOEV4-9pFGrUrbe2MJjAlx9T-Q70gyJYpNWkuNC0g>
    <xmx:F8gdaMbpH0RwoVrTER1gv1aQjpDbP-kBHkuH1r8YUQDZk1F2v3mNgw>
    <xmx:F8gdaNT-w1ZkF5Bv8MPVM3vpKa4HfBxY4sQzNktFaqVc2VY7hmzCKw>
    <xmx:GMgdaNAm0BpeAqO_OppkoHvhCHckRKOGuSicvQPKFO6wixoACiV-nO56>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 05:17:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 629c2772 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 09:17:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/11] Spring cleanup of "contrib/"
Date: Fri, 09 May 2025 11:17:00 +0200
Message-Id: <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA3IHWgC/42NQQ6CMBBFr0Jm7ZhSLURX3MOwoMwAE7VtWiQaw
 t2tnMDle/l5f4XEUTjBtVgh8iJJvMugDwX0U+dGRqHMoJU2yqgKwz1h790cxWIKUdyI/YM79wp
 orT7Z0lBFwxlyIEQe5L3Hb23mSdLs42f/Wsqf/Su7lKiQKzJEVF+6Wjd5fJQntNu2fQEiqlGXw
 QAAAA==
X-Change-ID: 20250506-pks-contrib-spring-cleanup-bb23b15d6df4
In-Reply-To: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Matthieu Moy <git@matthieu-moy.fr>, Eric Sunshine <sunshine@sunshineco.com>, 
 Todd Zullinger <tmz@pobox.com>
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

  - The tool hasn't received any updates for at least the last 5 years.

  - The tool has a clear alternative or just isn't useful anymore.

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
      contrib: remove "stats" directory

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
 contrib/stats/packinfo.pl                          |  212 ---
 contrib/thunderbird-patch-inline/README            |   20 -
 contrib/thunderbird-patch-inline/appp.sh           |   55 -
 contrib/workdir/.gitattributes                     |    1 -
 contrib/workdir/git-new-workdir                    |  105 --
 t/meson.build                                      |    1 -
 t/t1021-rerere-in-workdir.sh                       |   58 -
 t/t3000-ls-files-others.sh                         |   19 -
 53 files changed, 7112 deletions(-)

Range-diff versus v1:

 1:  2554d816f13 !  1:  f5208d15e68 contrib: remove "remotes2config.sh"
    @@ Commit message
         mechanism to use config-based remotes. Notably though, the migration
         path doesn't even use the migration script. Instead, git-remote(1)
         itself knows how to migrate any such remote via `git remote rename`.
    -    Furthermore, the script hasn't been touched since afa75bc8aa1 (contrib:
    -    Make remotes2config.sh script more robust, 2007-12-02).
     
    -    Given that there is a migration path without this script it is very
    -    unlikely that anyone still uses the script. Remove it.
    +    In fact, a full migration _cannot_ use the script as it only knows to
    +    migrate remotes from ".git/remotes/", but not ".git/branches/". As such,
    +    the migration path via `git remote rename` is the only feasible way to
    +    fully migrate repositories over to the new format.
    +
    +    Last but not least, the script doesn't even work as-is as it sources
    +    "git-sh-setup". For this to work it would need to be invoked either via
    +    Git so that this script is in our PATH, users would have to manually
    +    call it with an adjusted PATH, or distributions need to install the
    +    script into "$prefix/libexec/git-core" with a "git-" prefix. All of
    +    these steps are unlikely enough to underpin the claim that this script
    +    is not used at all.
    +
    +    So given that:
    +
    +      - The script cannot perform a full migration of all deprecated remote
    +        types.
    +
    +      - We don't advertise it anywhere.
    +
    +      - It has been basically untouched since 2007.
    +
    +      - It doesn't even work unless users do manual steps.
    +
    +    It should be safe enough to just remove it. Do so.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 2:  bfd219d38e6 =  2:  5da41b6f6ff contrib: remove "examples" directory
 3:  23b029002fc =  3:  cb0307a65dd contrib: remove remote-helper stubs
 4:  2ae101c8533 =  4:  8156f427807 contrib: remove "thunderbird-patch-inline"
 5:  a2e22a4ce7e =  5:  7fbc6d73eb1 contrib: remove "hooks" directory
 6:  54df2acaf10 !  6:  1267e17e14a contrib: remove "mw-to-git"
    @@ Commit message
         bitrotting, like e.g. documented in f8ab018dafc (remote-mediawiki tests:
         annotate failing tests, 2020-09-21).
     
    -    Furthermore, the code has been spun out into a separate project at [2].
    -    Remove the directory in favor of this new home.
    +    According to Matthieu Moy [1], one of the original developers of this
    +    tool, it didn't receive any attention recently and there is no
    +    motivation to keep maintaining it anymore in the community. The project
    +    has been spun out of Git [2] and thus has a new official home, but did
    +    not receive much attention over there, either.
     
    +    As such, it seems like the MediaWiki transport helper is slowly fading
    +    away. But given that there is a new home, it doesn't make sense to have
    +    it as part of Git anymore only to let it rot. Remove the directory.
    +
    +    [1]: <108f297a-b415-4742-80e4-51ea02af18e9@matthieu-moy.fr>
         [2]: https://github.com/Git-Mediawiki/Git-Mediawiki
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
 7:  80862dd3f3a =  7:  711a73eed73 contrib: remove "persistent-https" remote helper
 8:  5bff15bb57c !  8:  8e5cf72a292 contrib: remove "git-resurrect.sh"
    @@ Commit message
         e1ff064e1bf (contrib git-resurrect: find traces of a branch name and
         resurrect it, 2009-02-04).
     
    -    Remove it.
    +    Furthermore, the tool does not work with the "reftable" backend at all
    +    as it directly reads ".git/logs/HEAD". As reflogs are stored as part of
    +    the individual tables though that file wouldn't exist in a "reftable"-
    +    enabled repository.
    +
    +    Last but not least, the tool doesn't even work unless it is explicitly
    +    invoked via `git resurrect` as it sources "git-sh-setup". As none of our
    +    build systems know to install this script, users thus have to go out of
    +    their way to really make it work, which is highly unlikely.
    +
    +    Another source that indicates that this tool can be removed is a
    +    question for how to restore deleted branches on StackOverflow [1]. The
    +    top-voted answer uses git-reflog(1) directly and has received more than
    +    3000 votes to date. While "git-resurrect.sh" is also mentioned, it only
    +    got 16 upvotes, and comments mention the above caveat that users have to
    +    do some manual setup to make it work.
    +
    +    It's thus rather clear that the tool doesn't have a lot or even any
    +    users. Remove it.
    +
    +    [1]: https://stackoverflow.com/questions/3640764/can-i-recover-a-branch-after-its-deletion-in-git
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 9:  8ec63910c32 =  9:  ae90457d6cc contrib: remove "emacs" directory
10:  5f673e64206 = 10:  a9258add931 contrib: remove "git-new-workdir"
 -:  ----------- > 11:  fda94bd7579 contrib: remove "stats" directory

---
base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
change-id: 20250506-pks-contrib-spring-cleanup-bb23b15d6df4

