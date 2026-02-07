Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635DB3502A7
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770476819; cv=none; b=qGDahB2ntjpFFcedWFSK8eoaxxI1nW9ToyTbqz1+ZRN15MdKBPa78kalFhxeAq0jXhKqs7c76piJrwoQFjgTcpXMbQi0gyEv3OG71wE3Kfdgev1lQPbLmEIsyaGYliIPFSrljLReDXVEJUqlGFia5n/mkyNmSMtKFOTLYco1hHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770476819; c=relaxed/simple;
	bh=SYxZefGyWWHAdVOBhUMDOA8HuEPCjhHZcnyo+7a+vg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFY54WgxjKsBBa7mw548DRR66CT6+bpBt0lmJO/JVTLpcPbPLk/RCqUftTCPeO43ctlgOaAmVEYj77TwsACPZr/zmyl/2ah737DippCADC9EbX+gDasYo8CjxUdN8hS3iRz/CzdHbDHZ7rZLAM2Z6/NSYWfObf8Vdvt/IsEbqgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kBpzA0yh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cXNhzZ58; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kBpzA0yh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cXNhzZ58"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9AA36140017E;
	Sat,  7 Feb 2026 10:06:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sat, 07 Feb 2026 10:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770476818; x=
	1770563218; bh=5WIseoxFOmylCkw1/uLk9KhiYR1Gx05aBb6b0eCrNrE=; b=k
	BpzA0yhmjSUyjSWkG3jK8hvGMOFLEU+DkPu/Q9SYXDi4WH6R9/jemRlvT5nZ1s6s
	9K2BNsUD+w96MfZ55EMi95nKnDbw5rF2ku2Z7aMADMOu+K4k8JkbaHe+Oe92MB4A
	ede9bRSo/dkNn09cIvl/RQsRkgg1Jc5OEmmlJ+xCJkrRToDLFFxVm/2JxbfyD41S
	gcQQnWpCzSE0yOPGrdMfQCtPVnv+uCcXOu1BsDlO58xBa7m4KUUW7AjDoERaDS8W
	YaArDRI6ZcUHjU9HIDLt0+cuZFYv+wVMZBAsM96S4CEf7ieCki5TA3r9TmiVqoiq
	2IPhSwvSnFwOzznrGEmpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770476818; x=1770563218; bh=5
	WIseoxFOmylCkw1/uLk9KhiYR1Gx05aBb6b0eCrNrE=; b=cXNhzZ58H7ioiPo3K
	mtGdglvkKeuVGUG6sZLa6Um5eZlGRMZU/+u1QsCkUESaP5vcZ/6oAcEvY/lJX5vt
	knQo/SJB6YSENBMAiazx9heVWup8F/BuDYNfsOg7pGsIQylkVM2x9cU4PFDSIdJb
	da2IAw2eP/fOtJ81deI41CAFYV4zXvZn1rRg6PIeEdLXFWBapkI3/bn+MFY4nl5j
	KO3SPVGicTeOLT3NKhhXIeEE9Fw6EYzRpdO1W9AtCJmNJ23XzuWt48OG/ydKxGGV
	pfMphesm14Sg0IVJ+hJ1L3Q9+w9cnRqB9QWZokReShxq8nCcweHl+mDpXJh9aN1G
	N4L8Q==
X-ME-Sender: <xms:ElWHadlmfprKJnZepRMiO1lngDvG6JXCllYk12Bx6o-YAGgQkJ7t7vs>
    <xme:ElWHaQS4Fgj1_zkrkyIhPRhygZtKW0f2v3olhfMQGVO_A9gRcdl1_ON8fC2I_0kQ7
    nMKjVxmxqP2rGQWqlFfKxsNEHjRomns6ljQ-UO7W8QHshYlSGA0AQ>
X-ME-Received: <xmr:ElWHaRD6LSvOKaIttkqWiS_THSPjL0oF-lADGZiEe0AHKg1vSZnqe7h5GxGdSeIWfeN0ZGo8hTsxwFedLDesXUmINCWyQ3Toiya8aeXxrlZ-KqlJLFlIHVODZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledufeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlvdefmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpedvgfetiefffeejgfeigfdukeejleeutddtgeei
    leegieelgedvkeetjeehjeekfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtth
    hopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdr
    ohhrgh
X-ME-Proxy: <xmx:ElWHaXRcyADmQiRevWA8xmx_pKsFomXfGpTAeaRFDYyIsc_Axc4uRw>
    <xmx:ElWHafoQsZVYUoJ6ckN7jaB88Edx_Q4Sm_elsbq8toWh-_EMmSVbQg>
    <xmx:ElWHaZxXrk6grYAwFII4F6AK4PivZ51oHCfpW_NCaJHM6EFPlGjt8w>
    <xmx:ElWHaUJ_lJx7Ob8gzTYZQzoLhlkbajTXAM_387Xco68Av1Sjk0tuOA>
    <xmx:ElWHaUQPVRKrZcehhSkBp357AfJfRwzLdmKgG6IVrE_Mb13fNKfhEBvS>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Feb 2026 10:06:57 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/3] doc: patch-id: add script example
Date: Sat,  7 Feb 2026 16:05:27 +0100
Message-ID: <mapper_example.277@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <CV_doc_patch-id_4.275@msgid.xyz>
References: <CV_doc_patch-id_4.275@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The utility and usability of git-patch-id(1) was discussed
relatively recently:[1]

    Using "git patch-id" is definitely in the "write a script for it"
    category. I don't think I've ever used it as-is from the command
    line as part of a one-liner. It's very much a command that is
    designed purely for scripting, the interface is just odd and baroque
    and doesn't really make sense for one-liners.

    The typical use of patch-id is to generate two *lists* of patch-ids,
    then sort them and use the patch-id as a key to find commits that
    look the same.

The command doc *could* use an example, and since it is a mapper command
it makes sense for that example to be a little script.

Mapping the commits of some branch to an upstream ref allows us to
demonstrate generating two lists, sorting them, joining them, and
finally discarding the patch ID lookup column with cut(1).

[1]: https://lore.kernel.org/workflows/CAHk-=wiN+8EUoik4UeAJ-HPSU7hczQP+8+_uP3vtAy_=YfJ9PQ@mail.gmail.com/

Inspired-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    The script will not list the commits in rev-list order because of
    the sorting.

 Documentation/git-patch-id.adoc | 38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
index e95391cd255..19780f86425 100644
--- a/Documentation/git-patch-id.adoc
+++ b/Documentation/git-patch-id.adoc
@@ -68,6 +68,44 @@ This is the default if `patchid.stable` is set to `true`.
 +
 This is the default.
 
+EXAMPLES
+--------
+
+linkgit:git-cherry[1] shows what commits from a branch have patch ID
+equivalent commits in some upstream branch. But it only tells you
+whether such a commit exists or not. What if you wanted to know the
+relevant commits in the upstream? We can use this command to make a
+mapping between your branch and the upstream branch:
+
+----
+#!/bin/sh
+
+upstream="$1"
+branch="$2"
+test -z "$branch" && branch=HEAD
+limit="$3"
+if test -n "$limit"
+then
+    tail_opts="$limit".."$upstream"
+else
+    since=$(git log --format=%aI "$upstream".."$branch" | tail -1)
+    tail_opts=--since="$since"' '"$upstream"
+fi
+for_branch=$(mktemp)
+for_upstream=$(mktemp)
+
+git rev-list --no-merges "$upstream".."$branch" |
+    git diff-tree --patch --stdin |
+    git patch-id  --stable | sort >"$for_branch"
+git rev-list --no-merges $tail_opts |
+    git diff-tree --patch --stdin |
+    git patch-id  --stable | sort >"$for_upstream"
+join -a1 "$for_branch" "$for_upstream" | cut -d' ' -f2,3
+----
+
+Now the first column shows the commit from your branch and the second
+column shows the patch ID equivalent commit, if it exists.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.53.0.26.g2afa8602a26

