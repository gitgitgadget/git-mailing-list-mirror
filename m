Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175461B85DC
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 23:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725664426; cv=none; b=tHlVwnrAh0ACOf0csA7WTiZkcoJ0iV19E5NWYRexDwo/yVuH4VToDFd2dTDf3SooKSwhn6h5AyJpq3w6/hhr2UMbG4XWPqutednYf75Bz10PaM4tPAzMpQfsuVRh67zuNfp0Zmo3M3ZgA1GSTXmaeng4G+o5BFmR3nxdwZfcDZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725664426; c=relaxed/simple;
	bh=Jtyb9eT873KCJV5ksLE5Zq5VmFRPuZ5xrx04DzdCkyw=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=gLB4hK5BV8LtuUJ34wP2XQe3hyY6yq+H9FdfswghcLRvz8Z5TLd8+jXfTttfEo1zZwplnpIfhFN4ikDTD0u6lFXZ75L4h059zIi87Fo1dWF7YPDFb9SZ0jNUkEEQVHJmRRtT620m6CMrpszVzxQvr6EogAafNg7qee3vpjjy/Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jol.dev; spf=pass smtp.mailfrom=jol.dev; dkim=pass (2048-bit key) header.d=jol.dev header.i=@jol.dev header.b=bfe0sLLW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jjB4XAaZ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jol.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jol.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jol.dev header.i=@jol.dev header.b="bfe0sLLW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jjB4XAaZ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 28D131380224
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 19:13:43 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-09.internal (MEProxy); Fri, 06 Sep 2024 19:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jol.dev; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1725664423; x=1725750823; bh=+alZV0vcdN
	c43tarCjnzOSNRrAVelhXAb+vbI+ixUqQ=; b=bfe0sLLWRZL/EEF8H3XweP46El
	fSKlGiav8VsOHEpLglODceJs4e307+ErnDWNkM0O1ZAuJ+7dGA8KC/V4WWE2YoIb
	xf8lbS2FCAJBNdGCNwbP0VQZm2JSxxBjG1zfTc1WhteYBHZ/FlSW/3wjQgqiSAgl
	/8N312hUyziK3G52MXv7P0osRDAVqdKbVDvxicEr9tHBevi+eUIJH0+4z5s5uiVs
	Z0RKUhD4fcBp0MLpQtvaB+hDM+Maoh6DvBGvZux2FZXcm6wH3Pz4/Hn04OAhRO28
	Vwb02VpDdOFV4KU4wLYYRYGKuZEl5nUp4euq952HTRqBhx1CFw7hlV0OZccw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725664423; x=1725750823; bh=+alZV0vcdNc43tarCjnzOSNRrAVe
	lhXAb+vbI+ixUqQ=; b=jjB4XAaZ1HDnBqZjR52nkW5j/JP4qHQxvGEbUx3MzpH0
	cAZbc0GjjBrUcN0CyhCzUKDC1VODV+o9z1/8xHS826WNnr3/g238jadxH2zNVjzO
	AGgbnWf+7L+6NKRYfKKxGScuM06xqP66A/8wZCMVAb9468HToMtbz7SUZ5Fc0khQ
	br2cirleefV78igL/X61p6SuiiF4lX228645L6ECx6oqIjTBx+8THIC+UoT0BVdN
	yGyH4Co1Jl49RP4h9YNhJ/sbJ2mOshZ7HD4fJoFTwlAJGBrYgysK8LbsWt2K5+Bn
	S12Hj7HvjV8P3OvoZxFIMtor0JdmLLHX84A9AnYuCA==
X-ME-Sender: <xms:p4zbZl3Td0SrEKEuzKdgKpcPJ2aRXZpxm65Uek-Ijo0R98rj0GhcaQ>
    <xme:p4zbZsGonJb6e3Jg8LE3BXa345vmJXSsmZ9R9bCioSuzWL1CaTd_YzwsX7aNmOcZn
    b46QCGOBQ8Tvda4Yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeivddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvkffutgfgsehtjeertdertddtnecuhfhrohhmpedflfhorhhgvgcunfhuihhsucforghr
    thhinhgviicuifhomhgviidfuceojhholhesjhholhdruggvvheqnecuggftrfgrthhtvg
    hrnhepudelleegudejteejveeltdevudeuueejffeuudethedtfeeguefhtdeltdegueeg
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehjohhlsehjohhlrdguvghvpdhnsggprhgtphht
    thhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:p4zbZl6Ynccj-Kc8bNgNkfc4CGQMAp8y3wyznX_6btUgV7bfmzQSCw>
    <xmx:p4zbZi3AidSVuQ-iXENTG00EOAACEeM8h_c9gfApf5tdG8IhyXqvDg>
    <xmx:p4zbZoEFD626YqhmGVY-D87v2wnGYWjMMh9GrUAKgtK6S_cl_Y3FPg>
    <xmx:p4zbZj_aKaDsbefdk0JGsv9z3nt6oBVKcsIk6Co-xC8UgXU9YLPmXQ>
    <xmx:p4zbZjMj1iwoYD0b1rcj1w3YDAbUQmrR-ai994dDUOW6130nuTag3UD5>
Feedback-ID: i43a94432:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E871D18A0065; Fri,  6 Sep 2024 19:13:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 06 Sep 2024 16:12:02 -0700
From: "Jorge Luis Martinez Gomez" <jol@jol.dev>
To: git@vger.kernel.org
Message-Id: <0241cbcc-11b3-483a-8a63-d523291b92ff@app.fastmail.com>
Subject: bug report - `git diff --quiet --cached` returns 0 when a rename is staged
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

  $ mkdir /tmp/git-diff-test; cd /tmp/git-diff-test
  $ git init 
  Initialized empty Git repository in /tmp/git-diff-test/.git/
  $ touch foo 
  $ git add foo 
  $ git commit -m "foo"
  [main (root-commit) f60d7bc] foo
   1 file changed, 0 insertions(+), 0 deletions(-)
   create mode 100644 foo
  $ mv foo bar 
  $ git status -s
   D foo
  ?? bar
  $ git add foo bar 
  $ git status -s
  R  foo -> bar
  $ git diff --quiet --cached; echo $?
  0
  $ git diff --quiet --cached --no-renames; echo $?
  1

What did you expect to happen? (Expected behavior)

  Versions prior to commit d7b97b7185521e3b9364b3abc6553df2480da173
  returned 1 for `git diff --quiet --cached`.

What happened instead? (Actual behavior)

  It returned 0.

What's different between what you expected and what actually happened?

  The status code.

Anything else you want to add:

  This bug report originates from a PR I filed with Magit here:

  https://github.com/magit/magit/pull/5221

  I thought this difference between using `--no-renames` and not made
  sense, so I thought the problem lied with Magit. However, like tarsius in
  that thread points out, this is a change that happened recently with git
  and it's not in the release notes. After finding the commit that
  introduces the change, I see the message mentions "The new options are
  off by default, keeping the old behavior." It really doesn't seem
  intentional, so here's a bug report.

  Also, the above difference with --no-renames also happens if I move my
  ~/.gitconfig elsewhere, so there's no use of external diff tools. I
  verified that with strace, too.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.46.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.9.0
OpenSSL: OpenSSL 3.3.1 4 Jun 2024
zlib: 1.3.1
uname: Linux 6.10.6-arch1-1 #1 SMP PREEMPT_DYNAMIC Mon, 19 Aug 2024 17:02:39 +0000 x86_64
compiler info: gnuc: 14.1
libc info: glibc: 2.40
$SHELL (typically, interactive shell): /usr/bin/zsh


[Enabled Hooks]

-- 
  Jorge Luis Martinez Gomez
  jol@jol.dev
