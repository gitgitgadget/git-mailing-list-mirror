Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB43F1E1043
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980835; cv=none; b=fj7v1mbVLEooVnxm7XIDZ3c5X4xpmIwWCDftXNDk/xeTz+zMgdc5Hu1IiryHz85ygkP32pdQ4FBUgwX4GAjbQmM+/9BDE8oI1Z6MRxq1DdP3uCAEd/GYF7jQgCjyt3p8hQkWntP93zjRJkJ3U4b7f4QzbxgpCQ+CtA9yzW55zcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980835; c=relaxed/simple;
	bh=2LMx7U2lCvDPnNbkztiDbT7A9tXQIkQETOvhQMEvWQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcwooouwaqnmClxHQgGJNduOuOqAa20PikfaaS7buy9oIesmj4NbMl5C+5MlkPLJ55bsgi8IZfMQZX9lnVTdW3ts/iadtfUfXw+zpML/UGGzyAISWfMamyYYrtb2AFI41fyc6JxraPvy4v+nLvtrQGrJqZjeVtD9b6u2mRJKWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fbwX/5u9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iClZTZIS; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fbwX/5u9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iClZTZIS"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id EC36B11400F3;
	Thu,  7 Nov 2024 07:00:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 07 Nov 2024 07:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730980831;
	 x=1731067231; bh=KKXHSc6B+JkVnUdn8iMHyu5NkdT+q3FQQIdpcm/COgc=; b=
	fbwX/5u9TJi980wrptbZ7sxaly75cZLlUNFl6fk53PEZ56HvptGFCLtB+gpicHtZ
	iuK18hTgn312YyXjziYk23jmPdzW1wTVKj5jo71zEZk3bZONyQsWZaDcBqGeKEvj
	0badZrAAruH+BQZsysG+AvZrtQzXji/8oQ2CyHvy+Az3Tt4lLjdj7tKGuLRQyX5f
	vW4/raGFAkDezRGW1jt9PRJi/kGCAcx5GsVt9f9xLzzieale7loj2SVE9l6jnuYu
	XdXl2aXENlaT/26JBX6j/lXIlNDBY2DlnEZPQWkhrGYD04VuIgxo+ogWztlf7+Uh
	JJpUeRtGjoDsbdNBFHtqCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730980831; x=
	1731067231; bh=KKXHSc6B+JkVnUdn8iMHyu5NkdT+q3FQQIdpcm/COgc=; b=i
	ClZTZISEP0XyModQkQIxONQqyTNlXTCB4d1iu9swvA3u5b8D3IkY5jcWmIGu82k+
	/1tF9WE/vN55mi6/ilfy+VQSq3I8gq7KLXrh+WcT/BxmzPhSjaelT2d2ezZqiRub
	dGATIr+jDWPhgqeqfX5cAqAIxmumxyXsRRRc0qqaaLr2a+sk4InPBGYOOHV5MmSi
	d7vt17dDKatGtIsremEFeVGBHQcDrsg+FsGW4LmKUQyOIa4Amgjyw6ZEBQa0SsI5
	Q1y4mY4oO43s7nJ6gBVrfiTnM0z3GWNsVk9BnIoBF2f5cw2xqARrW0ZAxsNxVqTZ
	W0X+kMtpLYiD2qh1ag6VQ==
X-ME-Sender: <xms:36ssZ_gwwpZbyCGWXbceqRnrlOCiIoDdcdn1c2Iicjcyup3cfDP7pc0>
    <xme:36ssZ8DFQyVXoMfBtAH-9KTtGk-59sBaTiaGhKifDz1Txq0NU3VzMWRWMU467N-g5
    s2LT4aRVJB0EyIr6A>
X-ME-Received: <xmr:36ssZ_EK5oVghRU75wYJJMp-yDPbzrqZ0n0PnoyNGnE8UIfhyk9fRWRjnPQ7BB8GQU6_beONSoatma2guEN2WjK0e5r_eHMY5ZsYw52h1LliZpMYytVzIuGerA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeggdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpedtffdthf
    elieevgfethfdvffetffejfeejteetjeelveetgedtffdtgfehuddvffenucffohhmrghi
    nhepshhtrggtkhhovhgvrhhflhhofidrtghomhdpkhgvrhhnvghlrdhorhhgpdgtrghnrg
    hlshhoohhpvghrrghtvghonhgsuhhnughlvghfihhlvghsrdhithenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrg
    hughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphht
    thhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:36ssZ8Sa1gm3j4ekvwqjM5nnOCeCpTDAgKNNdwXXO4ZyDw90e1_R8w>
    <xmx:36ssZ8zBX-AsbcMGWAawna_I_GVaorJXIYptVwWTKuvldACT5fgPeA>
    <xmx:36ssZy5o2aE1RiLDTkRRptFTbpaDgSy4WUSe_fOm8P1rFcQJqVQi0w>
    <xmx:36ssZxxBMJ7dl42DuPiy-l613bxEEzR2SjgfEuxUURI4TPYqzmVpGw>
    <xmx:36ssZ7pQSvRLB_2RA-cwSbhPOkJ8XobL3hgYj3kNDTuwoKW1VIMMbQsC>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Nov 2024 07:00:30 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com,
	me@ttaylorr.com,
	gitster@pobox.com
Subject: [PATCH v3 1/4] Documentation/git-bundle.txt: mention full backup example
Date: Thu,  7 Nov 2024 12:57:33 +0100
Message-ID: <b222c6787a79c852442969721dadc629ca84cd5b.1730979849.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1730979849.git.code@khaugsbakk.name>
References: <cover.1730234365.git.code@khaugsbakk.name> <cover.1730979849.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: b222c6787a79c852442969721dadc629ca84cd5b
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Provide an example about how to make a “full backup” with caveats about
what that means in this case.

This is a requested use-case.[1]  But the doc is a bit unassuming
about it:

    If you want to match `git clone --mirror`, which would include your
    refs such as `refs/remotes/*`, use `--all`.

The user cannot be expected to formulate “I want a full backup” as “I
want to match `git clone --mirror`” for a bundle file or something.
Let’s drop this mention of `--all` later in the doc and frontload it.

† 1: E.g.:

    • https://stackoverflow.com/questions/5578270/fully-backup-a-git-repo
    • https://stackoverflow.com/questions/11792671/how-to-git-bundle-a-complete-repo

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    • Elaborate on “full backups” in Examples instead
    • Just point to the section in the second paragraph where everything is
      elaborated
    • Incorporate some of Junio’s suggestions:
      • Mention what the “full backup” here does not include
    
        Link: https://lore.kernel.org/git/xmqqh68q1l37.fsf@gitster.g/
        Link: https://lore.kernel.org/git/xmqqzfmiza69.fsf@gitster.g/#t
    • Remove the final paragraph pointing to Examples now that we mention it
      in the second paragraph
    v2:
    • Mention as a parenthetical on an existing paragraph (don’t create a
      new sentence and paragraph)
    • Remove the “mirror” mention
    
      Link (both): https://lore.kernel.org/git/ZxbIWEGS1UB3UIg+@nand.local/

Notes (meta-trailers):
    Helped-by: Junio C Hamano <gitster@pobox.com>
        Link: https://lore.kernel.org/git/xmqqzfmiza69.fsf@gitster.g/

 Documentation/git-bundle.txt | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 3ab42a19cae..f39cafee927 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -23,8 +23,9 @@ the "offline" transfer of Git objects without an active "server"
 sitting on the other side of the network connection.
 
 They can be used to create both incremental and full backups of a
-repository, and to relay the state of the references in one repository
-to another.
+repository (see the "full backup" example in "EXAMPLES"), and to relay
+the state of the references in one repository to another (see the second
+example).
 
 Git commands that fetch or otherwise "read" via protocols such as
 `ssh://` and `https://` can also operate on bundle files. It is
@@ -34,8 +35,6 @@ contained within it with linkgit:git-ls-remote[1]. There's no
 corresponding "write" support, i.e.a 'git push' into a bundle is not
 supported.
 
-See the "EXAMPLES" section below for examples of how to use bundles.
-
 BUNDLE FORMAT
 -------------
 
@@ -216,8 +215,27 @@ bundle.
 EXAMPLES
 --------
 
-Assume you want to transfer the history from a repository R1 on machine A
-to another repository R2 on machine B.
+We'll discuss two cases:
+
+1. Taking a full backup of a repository
+2. Transfer the history of a repository to another machine when the two
+   machines have no direct connection
+
+First let's consider a full backup of the repository.  The following
+command will take a full backup of the repository in the sense that all
+refs are included in the bundle (except `refs/stash`, i.e. the stash):
+
+----------------
+$ git bundle create <file> --all
+----------------
+
+But note again that this is only for the refs, i.e. you will only
+include refs and commits reachable from those refs.  You will not
+include other local state, such as the contents of the index, working
+tree, per-repository configuration, hooks, etc.
+
+For the next example, assume you want to transfer the history from a
+repository R1 on machine A to another repository R2 on machine B.
 For whatever reason, direct connection between A and B is not allowed,
 but we can move data from A to B via some mechanism (CD, email, etc.).
 We want to update R2 with development made on the branch master in R1.
-- 
2.46.1.641.g54e7913fcb6

