Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF1540D57F
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 05:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781847937; cv=none; b=JjmLsUGAh43Wq2nfC/fKVkSIZpu7qU/PVMcRctisq7ufwfYHhfngJOuNq6d9vBEe2oUOD5OrWnw3f38MlSxkDYDXgVPShBkZVKOw9zuf1dF7y5qGeFuRtFpqA6pHL2b1WsvWk7dt7hDuoLHonMEGMVlXchbIeoX0hEwtAcnxfWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781847937; c=relaxed/simple;
	bh=ZBfC7cEPZ+21MCfS3iTSIMyxqDZW/yJDgs+PUFkYYlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTrryhcq2afkCHYys/sIyuyW8C9n9VhhdjnEB+TKiq32d0oVBv5AXlwsOnTmBFvywjibamb6wYx/UPdJ7EpE8lZYnVXgaxNCPsVI/FkvmLLzr2uvbVnrXoPmug1OKbtIQvlUxKNIKUXJalwSfGCarzJl0AAsXgBTahdn3IV+fhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AhrF+qP5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PfgFxtTA; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AhrF+qP5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PfgFxtTA"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BD081EC01F2;
	Fri, 19 Jun 2026 01:45:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 19 Jun 2026 01:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781847934;
	 x=1781934334; bh=mnsp0t5WkuPQIdirysrPxwvm1Om8DnWRF0vGvwCDvbM=; b=
	AhrF+qP5IVvDJCBGEZGZmlm0sS+vEdLaLPkaLxyUnb0qOEgZOPojCPaHrF7q2Tk6
	EewN2vf4/7ZZBnsiLqjlUuqn/aY+3FYCG/kSVyCYcqlPaYxSLbXwBIUkNa7sxUtJ
	dff9YaA83OVvld8wKJSFLChehhaudDMcstnPs4AiA2xBVzfxWT2C71/TCZzHg9O9
	biK5CMzjkkKWOs/FEKk9xr5IS3bBOad5OCCxYWtF4CYw3YdFBXYt+rXDge/2LyL6
	BphGQTV88KxkgXAxhxaaE4fkgwD9yHDk2rmrfKNTOhYMt0iNLqWMizB5u0ouU0Qh
	BmSfGgJ+rCf24lbwXzbXwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781847934; x=
	1781934334; bh=mnsp0t5WkuPQIdirysrPxwvm1Om8DnWRF0vGvwCDvbM=; b=P
	fgFxtTA9SHPOIBGWQHY1ScHVcZH7qqC9UHs7mNESByilYeuDY8SmGUypxAa4zOYC
	zj/k0TXOze4oJGCAofkXdwgpp2VhwWOMuiDgV53uoMzltazwopLrTJ22ZKJlRkua
	3037qPbUB0cg8NGfvf3MFZzIq73jVXCYptku1aEN/qFDufxgGgDIu34LGfJf4r22
	XD/zSvcO9E/R2VLGAbhCcie3Xg95WRZI1srYbXwNtMPvnQraUo6srviwQZ7A5W75
	+KkDUfaP8TAVsGdcthqgDZ5+yqBV1/gBnVcYrxwt2A9P6ElY1RIafwiPoKfOYhB5
	TyqRmxWtbe13dE8tqXc8A==
X-ME-Sender: <xms:ftc0avWdd7TTCp87_R6OKmqEk5v6o4OyjxHGZTvL3pEPh4E6PU8sc50>
    <xme:ftc0aq1nMpcL8rM04ILmsi7hb6F-RW5rdDOW3yRpEA02yf2xn9QYGSpTuKUkS1HI0
    CE5MFjbQdZ2sByfaKfuAgh-u07yDVXEtJPmwKe99Ki0IsVnQ3RB5-w>
X-ME-Received: <xmr:ftc0ak0W4isEoRdk3nFXsrusQItQrbCbZ1g8i9CnH4AXf4GWezmxA2UxiwNYO9GlGN-AeFhJeFAUIlKLKxbfckbSlOWMIikNw8WzyTPAQEkrBB4>
X-ME-Proxy-Cause: dmFkZTGZQEK4KEvmdy5HXBpi304qWvpeR54M7kR3rn0yoepEgJ8kjc8dWFHDjBXYjGcf6Q
    hHYRCiCpFb3sA0l0AmyruiiZKzumtxQ0lSixR9NZEj2eKgXD2xYAiM73Eqe9DBG24MgmY+
    gVfT8zJEpcqqxPdvo5uo5CvgRbXz52iDVwkZ2jAzywYD1MpkaqUQUBu1fcUkqduX3ljzjb
    qe0sZzkV1D66Lzy/KIksNF2z66uc3od/ZMqWi7fH84vVTUkFoIZVvlNEvr+MEDnw3KitK+
    kwe+QswTYwm4uoT6dGM+hMxJKs7gaPqIv2k+Pc6L/bnZgbhR2wN8Pr0YJuIyHxYIgybYmU
    gi5HNIZahdgxKdE6rQ2flzSOA8DOq2vt5YauhWWlKx5/EZiKvF8bHwoz7vsye4LRovhjEn
    MKMJUSFXqvXyP2CkM6ExhawyTp1+f3mfcS0JiZEO9AhAu6MmkT5cIfqk3nZWIgOzikdJlG
    tx/23oYPb+mAOOunMfvCLWTuHm4JjwXVlIquGZpMgsy9A7415jleuZKZS/5wvHc6xFCxa6
    rQGtcdAnr6cUBU6IUyHBifqmVDECfW6lqPPRl33XPUZiV32Qo8wGhm7kh/RV5zX/bmEB/d
    jWxrmkQbHD57w4LY4XC4EBztXwE1TrLTUF7DpmX5bc77gqITR1n+KuCs6Llg
X-ME-Proxy: <xmx:ftc0al8oqo63Q9mTFdteN3zQvByaqwzs2HfqDND8KBGV4pYd53YVaA>
    <xmx:ftc0ap0L3kKw6kDTfO6kK1lBxJt-cRt7S7hqVJY9jBu0kUxs_-ne7w>
    <xmx:ftc0aq8JiT9xvEI3KjgjJV3aFiz9Dq1W7iPcwR1xtlsVAMz-vy0TdQ>
    <xmx:ftc0ahsajz5rP1L6bai2z9ck5cnj-KG5M_5nayr-WDTATTPpgyzHsg>
    <xmx:ftc0aiaNjZwQCjfu2Nkv7eFJC82ucuoM2JxyB7zBtmDQtwZo5HcMhwKB>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 01:45:33 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/5] SubmittingPatches: update and flesh out trailer sections
Date: Fri, 19 Jun 2026 07:44:49 +0200
Message-ID: <V3_CV_SubPatches_trailers.9ec@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <CV_SubPatches_trailers.8f3@msgid.xyz>
References: <CV_SubPatches_trailers.8f3@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name (applied) kh/submittingpatches-trailers

Topic summary: Flesh out and update the trailer sections.

All of these points have come up on the mailing list. At least for me.
And `Based-on-patch-by` is a nice-to-have documented kind of thing.

[elide “since January” from v1...]

Link to v2: https://lore.kernel.org/git/V2_CV_SubPatches_trailers.9b6@msgid.xyz/

§ Changes in v3

Patch “encourage trailer use for substantial help”: correct AsciiDoc anchor
placement.

[1/5] SubmittingPatches: encourage trailer use for substantial help
[2/5] SubmittingPatches: discourage common Linux trailers
[3/5] SubmittingPatches: document Based-on-patch-by trailer
[4/5] SubmittingPatches: be consistent with trailer markup
[5/5] SubmittingPatches: note that trailer order matters

 Documentation/SubmittingPatches | 46 ++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 10 deletions(-)

Interdiff against v2:
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index dceeb5a1817..56706e55ea1 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -447,8 +447,8 @@ identifying, and not misleading.
 The goal of this policy is to allow us to have sufficient information to contact
 you if questions arise about your contribution.
 
-=== Commit trailers
 [[commit-trailers]]
+=== Commit trailers
 It is polite to credit people who have helped with your work to a
 substantial enough degree. This project uses commit trailers for that,
 where the credited person is written out like a Git author, i.e. with
Range-diff against v2:
1:  835eb736f39 ! 1:  dc75b862d73 SubmittingPatches: encourage trailer use for substantial help
    @@ Commit message
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/SubmittingPatches ##
    -@@ Documentation/SubmittingPatches: identifying, and not misleading.
    - The goal of this policy is to allow us to have sufficient information to contact
    +@@ Documentation/SubmittingPatches: The goal of this policy is to allow us to have sufficient information to contact
      you if questions arise about your contribution.
      
    -+=== Commit trailers
      [[commit-trailers]]
     -If you like, you can put extra trailers at the end:
    ++=== Commit trailers
     +It is polite to credit people who have helped with your work to a
     +substantial enough degree. This project uses commit trailers for that,
     +where the credited person is written out like a Git author, i.e. with
2:  5a652b8e14d = 2:  86b9973a8e8 SubmittingPatches: discourage common Linux trailers
3:  5e53999b2e9 = 3:  a142f66c3b8 SubmittingPatches: document Based-on-patch-by trailer
4:  dd47fabe917 = 4:  439fa864da7 SubmittingPatches: be consistent with trailer markup
5:  726386d976b = 5:  2d133f2ad5e SubmittingPatches: note that trailer order matters

base-commit: 1ff279f3404a482a83fb04c7457e41ab26884aea
-- 
2.54.0.22.g9e26862b904

