Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D5E45027
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 02:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733193166; cv=none; b=MnqqD9YubswZg+DJUhlLoQp2cVrMf+9eh0EDTpYKonmoDQ1yKcNLshvUXCEIvT+A0rUT+GCJDf0YJMfRiKs3Nxzg4jmLnF0BYRlrjXoeRrw7s7gkdrjd8wvBOWSLD0HFTHwtrIab83mwZ3FpeZOQacHcdFKa2Tcd9S/37q8Px1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733193166; c=relaxed/simple;
	bh=oijtcYlWG96VdEAJMSsS5bJpk98PPPj0pL/4VhGfvIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AdiW9wDhq7G1Kj/SZqv2xaMaVpqv076ghDZu7yuW+GqDszFHH5/J+0fESdU5tZWVH0lF8Ym+Fu7BGWxTHGKgfUAtVTreroQRYsRiaszgBIKlg6JkDjG2SMHGRR9BTa/EXeYelCI2QTV5jW/kVcZoweZNlpWxt9cUgh+wQSv4UZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RSjDvEie; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RSjDvEie"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 93AC71140200;
	Mon,  2 Dec 2024 21:32:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 02 Dec 2024 21:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1733193162; x=1733279562; bh=vwwdGD/awX10Fh2MkUYFQAdfO3q+
	KmGztbz+VYzHOF4=; b=RSjDvEieWovH29QVm963TquUiXA2JarrGJdgjUGv6Ucf
	esJsV6GyaDeoYmS1Vhb8dfrSQLBC1P5QgdmTMDNirxX2ojaBMirsaX51CL219rJy
	ztY7NZ4WOFo+pOlvdHLWgOPJ6ehIO5svSfCZrmw0IDNQTOhzYIC4iseNLTNixSMs
	bBlBPLWxcAypFa8a6/u8+Vh/7f2uNxB2NIwB7tZ7rNE21iZEKCl068HAHM1E2isu
	htqeAEzxjKXCfp7D54j/eq5wy1+zmfqDIwqnIz76gvVgN7TX4X3egt+NaeE/A/9e
	HhshfuqsBL2y+dMgNEyTTvoe72OABEqPuWDnd+2Vug==
X-ME-Sender: <xms:ym1OZ-juQHxGKxNeUIEfk58Tnzm3ttMck-ZosFhulJ2iHaHGAjACPQ>
    <xme:ym1OZ_BEIPT6TACpxgempKWSqRBGqNunSa2xhFcHsGeJShELJc_q3brstDA4LsirY
    YhwJo8H5VQRuzFBFg>
X-ME-Received: <xmr:ym1OZ2FSTZQxHtqaeLN5M7VG3LChEn8gCRxYwOgm_1k1n9zzCjhOV8bhkMhQzN7Lr21z29oLIhwbHr5IKW16zl2GDN8i4IWV-nw5ofA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfh
    rhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtg
    homheqnecuggftrfgrthhtvghrnhepgfetheejteffveejhedtteelueeuheehffehhfdv
    ueelgfffveffuedviefhtdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthht
    ohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsehjohifihhlrdguvgdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ym1OZ3SlPvHDaxQhPrB7rgP0bHdDKswEShfdD4F0UDxpMi-qFfyNFA>
    <xmx:ym1OZ7xuhlv0WleMSCvjiXi8wnXrLBltzzmyTOKVqvUO1LW7OoIlvQ>
    <xmx:ym1OZ16q8F0-5ruLrR8gLO23BD36pTZkQOxmlpMQprvuShiIRBZHWg>
    <xmx:ym1OZ4yPzj1PAaKxTPQo8EB_jr4rVwWRquMUvotmcq_TV_oxBwz3HQ>
    <xmx:ym1OZ2pcY56QemZl8trNaRh-yzZ5muQppruybdO2bLa0KIkk7gD-9dwG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 21:32:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: git@jowil.de,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>
Subject: [PATCH v2 0/4] forbid HEAD as a tagname 
Date: Tue,  3 Dec 2024 11:32:36 +0900
Message-ID: <20241203023240.3852850-1-gitster@pobox.com>
X-Mailer: git-send-email 2.47.1-515-g5132b7d2ef
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As discussed earlier, if you accidentally did "git tag HEAD",
the command happily creates a tag with HEAD as its name, but then it
would be confusing as use of it becomes ambiguous with the most often
used ref, HEAD, the currently checked-out commit.

Let's forbid creation of such a tag using the "git tag" Porcelain
command, while still allowing creation of such a ref using the
plumbing command "git update-ref".  "git tag -d HEAD" can still be
used to remove such a tag to recover from an earlier mistake.  This
follows the design pattern used to forbid use of "HEAD" as a branch
name, where "git branch" refuses to create such a branch, but "git
update-ref" is usable to do so.

The intent is that the repository layout and format allows use of
such names and we keep our low-level command usable for those who
want to write a different UI with different usability constrants
(e.g. they may not even have a concept of "currently checked-out
branch" hence the word HEAD may not even be special).

The first two clean-up patches are unchanged.

The third step has an updated log message to mention an unrelated
clean-up of the test.

The final step has an extra test to make sure that "update-ref" is
still usable to create such a tag, and "git tag -d" can remove it.

Junio C Hamano (4):
  refs: move ref name helpers around
  refs: drop strbuf_ prefix from helpers
  t5604: do not expect that HEAD can be a valid tagname
  tag: "git tag" refuses to use HEAD as a tagname

 branch.c                   |  2 +-
 builtin/branch.c           | 10 ++++----
 builtin/check-ref-format.c |  2 +-
 builtin/checkout.c         |  2 +-
 builtin/merge.c            |  2 +-
 builtin/tag.c              | 13 +----------
 builtin/worktree.c         |  8 +++----
 gitweb/gitweb.perl         |  2 +-
 object-name.c              | 36 -----------------------------
 refs.c                     | 47 ++++++++++++++++++++++++++++++++++++++
 refs.h                     | 29 +++++++++++++++++++++++
 strbuf.h                   | 22 ------------------
 t/t5604-clone-reference.sh |  6 ++---
 t/t7004-tag.sh             | 12 ++++++++++
 14 files changed, 106 insertions(+), 87 deletions(-)

1:  717418e6c0 = 1:  717418e6c0 refs: move ref name helpers around
2:  e7b29c0967 = 2:  e7b29c0967 refs: drop strbuf_ prefix from helpers
3:  e143e68d9c ! 3:  a0efd9b681 t5604: do not expect that HEAD is a valid tagname
    @@ Metadata
     Author: Junio C Hamano <gitster@pobox.com>
     
      ## Commit message ##
    -    t5604: do not expect that HEAD is a valid tagname
    +    t5604: do not expect that HEAD can be a valid tagname
     
         09116a1c (refs: loosen over-strict "format" check, 2011-11-16)
         introduced a test piece (originally in t5700) that expects to be
    @@ Commit message
         Before forbidding "git tag" from creating "refs/tags/HEAD", update
         these tests to use 'foo', not 'HEAD', as the name of the test tag.
     
    +    Note that the test piece that uses the tag learned the value of the
    +    tag in unnecessarily inefficient and convoluted way with for-each-ref.
    +    Just use "rev-parse" instead.
    +
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## t/t5604-clone-reference.sh ##
4:  6595acfbf3 ! 4:  2c6438eccf tag: "git tag" refuses to use HEAD as a tagname
    @@ Commit message
         branch from getting called "HEAD" at the Porcelain layer (i.e. "git
         branch" command), teach "git tag" to refuse to create a tag "HEAD".
     
    +    With a few new tests, we make sure that
    +
    +     - "git tag HEAD" and "git tag -a HEAD" are rejected
    +
    +     - "git update-ref refs/tags/HEAD" is still allowed (this is a
    +       deliberate design decision to allow others to create their own UI
    +       on top of Git infrastructure that may be different from our UI).
    +
    +     - "git tag -d HEAD" can remove refs/tags/HEAD to recover from an
    +       mistake.
    +
         Helped-by: Jeff King <peff@peff.net>
    +    Helped-by: Rubén Justo <rjusto@gmail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## refs.c ##
    @@ t/t7004-tag.sh: test_expect_success 'creating a tag using default HEAD should su
      '
      
     +test_expect_success 'HEAD is forbidden as a tagname' '
    -+	test_when_finished "git tag -d HEAD || :" &&
    ++	test_when_finished "git update-ref --no-deref -d refs/tags/HEAD || :" &&
     +	test_must_fail git tag HEAD &&
     +	test_must_fail git tag -a -m "useless" HEAD
     +'
    ++
    ++test_expect_success '"git tag" can remove a tag named HEAD' '
    ++	test_when_finished "git update-ref --no-deref -d refs/tags/HEAD || :" &&
    ++	git update-ref refs/tags/HEAD HEAD &&
    ++	git tag -d HEAD
    ++'
     +
      test_expect_success 'creating a tag with --create-reflog should create reflog' '
      	git log -1 \
