Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542AAEAF1
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731768961; cv=none; b=s9+Avod68TQF50U6N4Fo/Su9u3dW6+Z1M6iPV6kcKrx1J570MSC68ETAqq8IVi/oWUbdzZgfSOi8mjmSZe1OuqKAZQkA8YHc5eQJdib0R1t8XZE8twO3C3B9aUvwQaLy7NEHJbMYUkZ16VMGSg/FLI3fxy/P93h4MKvZ/5X2+LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731768961; c=relaxed/simple;
	bh=m72Fhd0LYMNJOuTcl+0EkOMBgCbpdTum1NXiOJH/YQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiSaZJQgT5nHpBSoRZVorr9y/37d8Eq2Qpipv4WxaqaXw03mQ53JaxSXdShsim2kPbe8IL5vw6r4ag0oMwD7rEKoXm5Vaq8US/If63CvjoD5yhcTg10MPIU2XpniZ6dXlBU3xHZDSy1KttYjtSqkZDYSHctCSTE/XrfpnGo3vG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SGVPs5hz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EF1GqJHV; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SGVPs5hz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EF1GqJHV"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6E47E1140085;
	Sat, 16 Nov 2024 09:55:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sat, 16 Nov 2024 09:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731768958;
	 x=1731855358; bh=rvlI4qdIhflD+LAhup2n+PNiUEpki9MCcIjxcE4x94c=; b=
	SGVPs5hzhYUNPcQnkjkGswcRvIQM0TcKh2ExBC3H1ubP6p7zU1YAA7Lyd0x3w4yH
	2TqObNgf6vU1iRfkuDeL7S9AkqPFlQCyv7TQVr02lDC4Zra2YLWRPxSaHITKNMvS
	9pe2tZvnzHB2c1JyYTZk54Zh2I3TnYGBvjeTuoAWtNzgBMfGkyKodrhE8qd3+PQA
	cCWtuN3xz2ewD0yByMqHmMwWBNVRUEXPiX3nT9WHE0svoURNbNfKMsrYBhEZLZsd
	vmUTJrLzxocybUnYumSpWbeksIqVl+B2MbWJWvQo5WsNCpDsXfxjYv9Aoz0eWQrL
	NiT5sfyDcLhLwX+5boncOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731768958; x=
	1731855358; bh=rvlI4qdIhflD+LAhup2n+PNiUEpki9MCcIjxcE4x94c=; b=E
	F1GqJHVuz6/7Z6BvnYHB1A9fniuxU3Jd6lAJXxhgG3yY8A1MxMe5CsYzvfDJtkzE
	KVNo/87ktuu628fTOO60FZt/LlLD7H3GEk1CI4Ow9L7uuAW6u+VqGNaZjnTmLxGx
	fSL1Q5z75tmc/4VKmLJX+sNPXzbq6BUFLJ0vk3bUHp0tj3LxePyLnAAMgrVyW8lm
	dDXdls9LYx92Kl5aMYmOJvLmUZoIF5JofM+eYDNB+712GYV+wj214ATOfVeI5zjv
	h6WJNAh1KfryAknYJlBeManpBuILjh7YXy7jMfh0LdOlBqUBKjZxH4kRMTcHJyEN
	8Gk++qKkFg1ErzgLXhfiA==
X-ME-Sender: <xms:frI4Zwyz9T0JUEFFXY0saGzGVGwlWabZXJW2EsK4cJ2qQ1_nttz_-Pk>
    <xme:frI4Z0QggN8eB3XlQIH47iM8VflwnAnfkejfSHA9QD3f3nm-8qAJAgrTbR16AAaHH
    7PBlqc1XCUjl5Z76Q>
X-ME-Received: <xmr:frI4ZyUtm_QCBCp5D6GxvWt5KemwKM2yCWFzbjDkP-R1qTkRFh5O75FUo4Znlv11JNFyGw3yb7QBvCOvdqsLVi1vPW02RFYzk8PseuygfKp8qZFFmISqRZptFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeigdeijecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:frI4Z-jioIkqu2Fqu-1FCE82SXFS2gxodD8Sml3SfRI0D0PlhX4lDA>
    <xmx:frI4ZyDRgL_-Gc5WJDFP21rf_vaN6utGueDj9SONTdjxEU306pjTjg>
    <xmx:frI4Z_JmIlCO9usXojZyWvqTdiBuK9JSBG_ggzWq3tvmMRzpPmo1JA>
    <xmx:frI4Z5DS2DxfEa40pTJWvIB8NqPqnZylIrEPS8de3Vr7IoD1coMcLQ>
    <xmx:frI4Z55ff2zLLeBvPKIVHGec5JqeILYTv-1ZlZ4EyszK4Jor1iXGGk5X>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Nov 2024 09:55:56 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com,
	me@ttaylorr.com,
	gitster@pobox.com
Subject: [PATCH v4 1/4] Documentation/git-bundle.txt: mention full backup example
Date: Sat, 16 Nov 2024 15:54:51 +0100
Message-ID: <5121edfee674aaa44d047c16040c39bdbe7dae30.1731768344.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.47.0.317.g7d2562b9734
In-Reply-To: <cover.1731768344.git.code@khaugsbakk.name>
References: <cover.1730979849.git.code@khaugsbakk.name> <cover.1731768344.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
    v4:
    • Drop the part about `refs/stash` since that is wrong.  What we want to
      communicate is that the state of the stash is not transferred since
      git-clone(1) does not include the reflogs.  We can just lump that in
      with the existin list of the index, working tree, … etc.
    
      Link: https://lore.kernel.org/git/xmqqh68c3vr8.fsf@gitster.g/
    • Add para. describing how to recover the backup
    
      Link: https://lore.kernel.org/git/xmqq1pzmqy97.fsf@gitster.g/
    • Correct tense: “transferring”
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

 Documentation/git-bundle.txt | 37 ++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 3ab42a19cae..b9eb9cef2f8 100644
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
 
@@ -216,8 +215,34 @@ bundle.
 EXAMPLES
 --------
 
-Assume you want to transfer the history from a repository R1 on machine A
-to another repository R2 on machine B.
+We'll discuss two cases:
+
+1. Taking a full backup of a repository
+2. Transferring the history of a repository to another machine when the
+   two machines have no direct connection
+
+First let's consider a full backup of the repository.  The following
+command will take a full backup of the repository in the sense that all
+refs are included in the bundle:
+
+----------------
+$ git bundle create backup.bundle --all
+----------------
+
+But note again that this is only for the refs, i.e. you will only
+include refs and commits reachable from those refs.  You will not
+include other local state, such as the contents of the index, working
+tree, the stash, per-repository configuration, hooks, etc.
+
+You can later recover that repository by using for example
+linkgit:git-clone[1]:
+
+----------------
+$ git clone backup.bundle <new directory>
+----------------
+
+For the next example, assume you want to transfer the history from a
+repository R1 on machine A to another repository R2 on machine B.
 For whatever reason, direct connection between A and B is not allowed,
 but we can move data from A to B via some mechanism (CD, email, etc.).
 We want to update R2 with development made on the branch master in R1.
-- 
2.47.0

