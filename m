Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D501991A9
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982873; cv=none; b=bBplXMycBkVHaYzgVEF9nWuGcf19mx6ov2wQwJ3aXZWD2NgLggyLbM6IdFkpXptTmiBSO4jeq1SSN5Hb3djHXep+Wm0yJrraN+whCKXHKpUXmSn+ssTRLpZbVrXIB08sn6oUbRDXAdvxADHKnhJqL+O0hihC8RaNJgRxx5fqE4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982873; c=relaxed/simple;
	bh=6CvryRCsz44BRua355UPSzTsKBxpY+tLnbZ/2LQ5Us0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TnCFXbc1wBTGkxl38n/o9EqU44Qz80fhWn3WasNNEEAYLe3q6hgWS8ECUea4s6Je/hkRBLKsn4PWIsrJPkLZxGCYY/+cjMwhmpM4HqpK8kkM4DdXuGcNGPjxxmYHpsYJowwRgejX1iLY3ZedjzmbL3a7mL4i5/QlqM/DpiPoaps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FSLg3tMY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TSLPEDrt; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FSLg3tMY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TSLPEDrt"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CDD28114018F;
	Wed, 19 Feb 2025 11:34:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 19 Feb 2025 11:34:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1739982868; x=1740069268; bh=8UMKId/vW8ft7bb7iHu1uo39X5f5/Tb5
	OMTP8E4lnqI=; b=FSLg3tMYawEVCTkeuDbr+9dja7U79L8wrTkZHkD6iaipXPMp
	5R3DgDXHj9MpT2fl01CNK6ck5lqVGsNg79EglWINYzM1IyQF3IPE0IzgX5PkHMTT
	Czeip9s1V1soXiuMhy7LG/RUFe62kTWB3Ksw4tHx5yXw3IZRvnS0ru03XFzQ0tqR
	Hhmt/Ii93ZOgNtNP+84dXX7I6udMAbIL1U3bxBYpEdMMkv9dhLkuObBwiDzQGJRU
	O3ofi1FSbPj982DhSFh1QyEqkLxKwVJzo+T2GXm/TSgyZ6m2ur9qjTusx1gQPsZ/
	DbeeJNqJrPCwpAgbffvL2S5o0cXO2sGBFEC83A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739982868; x=
	1740069268; bh=8UMKId/vW8ft7bb7iHu1uo39X5f5/Tb5OMTP8E4lnqI=; b=T
	SLPEDrtPFrcFIAaXjQEkr46wJ6VeNX4QklR7Dl2uRnBkfaQ+4gKvMUtOkoODZMYc
	DvufNo2yMwptoooDnFBXfANkY78rAKDLxEY4X8YZa4Za0RsvFslbjtf7Q0jJhttr
	e7Jj+GpoVU23PXqxIc81kXUCF86ZLSBY9NCN3hP0EM3J6knoPYShgJJoglWJFoV3
	uql1OArbeniQKvI7FDVmDoVcQnHUgitn25uGJP/bQ1I6Ef/ejPAlnHIIyK8Lez0T
	OvOE3d7BPI5aDB7n8ZSNA+yWJwHAiB5n+CX/03GcCuw8EJm17DPvEclECyOFMO3p
	nC+gwZjxwGip9Z8keGXmQ==
X-ME-Sender: <xms:FAi2Z_6kQrGejiQvCgTbITpYTFMclGPvYgCvU8EWHwx4em2pUcY5CQ>
    <xme:FAi2Z06Quv_WRpWtDL6GZdc5Xoztlg-Qi3Jp0fOOpi9yBS5nVLCWHVaormI1AneqP
    xCYvUJompAPNhHoWw>
X-ME-Received: <xmr:FAi2Z2fdXSNHcNfAr4ZqajPelowHqIdFQNjzxQWPQH154iwa2AGe1hdzsH6ja5xSD3S9tUnMKEoJBZN4_SbQz8mQrsqEonT5o0bNlMs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcu
    oehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeiudevff
    fhteefveduvddufeehgfehgfffjedvfeehfeeigfffffejhffgvdelieenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdhgihhtqdhstghmrdgtohhmpdhgihhthhhusgdrtghomh
    dpghhithhfohhrfihinhguohifshdrohhrghdptghonhhtrhhisghuthhinhhgrdhmugen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FAi2ZwI7uRVrpXEcFlmCliyJgqDAXDVl5YlowxVMghbh1EWt6ZxRSw>
    <xmx:FAi2ZzKw_Qjpuom1QBdVcpUY1V0bvb652gu9t6896dzgroEmst_79g>
    <xmx:FAi2Z5yNTwtcv9l3-UlHWOqrH8orfHXgNvSpqAnv42OW14FbUUlyeg>
    <xmx:FAi2Z_IEh5AW5dyPYAfC_Iy7WLvLWidVvpG9eKCvYsUBQTHYrmkDPw>
    <xmx:FAi2Z6XRJ_vp0pbkqw6U0vG7H5UP41xBKxCmscFsFB8nXkXAQs2EXuwM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 11:34:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [RFH] Issues and Contributions to friendly third-party projects
Date: Wed, 19 Feb 2025 08:34:26 -0800
Message-ID: <xmqqcyfdhp0t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

After seeing a issue report on git-scm.com (and remembering number
of issues reported on friendly third-party projects on this list
and getting redirected to elsewhere), it may probably make sense to
document who they are, what they do, and how to contact them, in the
same document that drove these contributors to this list in the
first place.

I am still not sure which of our document is the best place to do
so, but no matter where it eventually goes, it would be better to
first agree on 

 - if doing so is a good idea to begin with (such a list in a
   document will incur maintenance cost)

 - who to include on such a list (the list will become useless if it
   includes everything on earth that claims to be related to Git;
   where do we draw the line?)

 - how the list will be maintained (are we responsible to ping them?
   will they update us to keep their entry from going stale?)

As a discussion starter, here is what I added to the source to "A
note from the maintainer" message I send out every once in a while
(https://lore.kernel.org/git/xmqqr05a5wjv.fsf@gitster.g/ is the last
one I sent out).

Comments?  Corrections?  Opinions?

Thanks.


 MaintNotes | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/MaintNotes b/MaintNotes
index 743e3b6..ebda282 100644
--- a/MaintNotes
+++ b/MaintNotes
@@ -29,6 +29,13 @@ As an anti-spam measure, the mailing list software rejects messages
 that are not text/plain and drops them on the floor.  If you are a
 GMail user, you'd want to make sure "Plain text mode" is checked.
 
+The mailing list, while welcoming non code contributions like bug
+reports, mostly discusses updating contents of the source tree to the
+(core) Git software, including documentation "git help" gives.
+Non-code contributions may have places other than the mailing list
+that are more preferrable.  See the "other places" section near the
+end.
+
 Before sending patches, please read Documentation/SubmittingPatches
 and Documentation/CodingGuidelines to familiarize yourself with the
 project convention.
@@ -293,3 +300,36 @@ own authoritative repository and maintainers:
 When sending proposed updates and fixes to these parts of the system,
 please base your patches on these trees, not git.git (the former two
 even have different directory structures).
+
+
+* Other places.
+
+As the Git ecosystem has grown larger over the years, there are
+documentation sites and third-party tools that have been created and
+maintained by friendly third-parties.  Reporting issues with them to
+the main mailing list is still welcomed by the list participants, but
+most likely you will be asked to contact these third-parties directly.
+
+ - git-scm website (https://www.git-scm.com/) is maintained directly
+   on its GitHub repository and its issues are managed there.
+
+   https://github.com/git/git-scm.com/issues
+   https://github.com/git/git-scm.com/?tab=readme-ov-file#contributing
+
+ - Git for Windows (https://gitforwindows.org/) is a project that
+   packages (core) Git software with some other goodies for the
+   Windows platform.  They manage their own issues list and their
+   changes are managed directly on GitHub via pull requests, focused
+   primarily on Windows specific issues and their additions (like
+   Windows installer).
+
+   https://github.com/git-for-windows/git/wiki/How-to-participate
+   https://github.com/git-for-windows/git/issues
+
+ - The online edition of ProGit Book hosted at git-scm.com/book/ is
+   managed by the Pro Git book folks, and they maintain their work and
+   issues at their GitHub repository.
+
+   https://github.com/progit/progit2/issues
+   https://github.com/progit/progit2/blob/main/CONTRIBUTING.md
+
