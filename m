Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776DE29AAF7
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 22:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773094509; cv=none; b=ucbKERTiTGZrYNKB81pJQDUOoqUpbO85YpHgpFoQePwh4K80Z7fSD7Q8Msr/Xv9w1KLZmPKpv+Z1I/5TgPXOggileFPNgOUdJGW/DG4vus+NsCFZIdPzUVASDfjynqU8VDcgDGtZAHaqAR9E0iU2x6JfRjJTgv1YaLhsvF6TXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773094509; c=relaxed/simple;
	bh=DxwN7EIqvMTU6MBe25bl+3avFAqobIjpzodnB7pA77o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZdfinktIbpFYcMxy4GgFRGANPtMjAy5gNL9SpkqwIIgJ9+bq+PIoMXcZ41R3UOz5mhf6/6DDXHY/w8qQuy0j0KErZe7UPdYeBp2ps0xIGyvzG2yFiEPUqL8YhhJ0g1WakDd1fKq4aEsqHqOojRGoaMrwHiX7d40i3tUWvlPm/SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IJCnVp2L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=co//IcSW; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IJCnVp2L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="co//IcSW"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C62BB14001CF;
	Mon,  9 Mar 2026 18:15:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 09 Mar 2026 18:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1773094506; x=1773180906; bh=GpRQP8dZaLD7C3wmir/D6srqQokiaBEY
	0GRqNNmqTuI=; b=IJCnVp2LbY2kQxLZVTxANWWTMVTi31DYJjd43h3SyhiqSTd0
	ndQOeNXNtoYvQuDLE6KDe+jY+T98OPeICkg9gKOD7sW78nsmRTCT+qw/eXoolRtT
	KxKW6kJCkSZoTfMGpkfWrCiV21zssv971JdxixUIVfdnPcCg29Uc0Mxshqwk1tEy
	sd0dT7QbeMRFwjauprZpCwB2jH3FUowc/N3cPiFWx3yewSebEqhLsEVjKZWAZ2w0
	gM4Pi1DpY3zeKgYUWV7ixinIHEPV0BLE0n5ivs9YWb9ObhJMJgs4OjyUTuZXO06a
	80up0Nr3z27pVT0uWYAT++c6nqLvB4+BCLwEYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773094506; x=
	1773180906; bh=GpRQP8dZaLD7C3wmir/D6srqQokiaBEY0GRqNNmqTuI=; b=c
	o//IcSWJUtgYzQqg4iilx3EMYJ7FwZ62Q1yHdulgOGFcio2QFHl/xih0wMglonXZ
	s/ON+C1R85PlOLih0n6nESwRJIGzrPCpiCrzde6iAedsz4wMz6IPI8b2y4c9iVnp
	k/ZQARCt0Ab4ELVKiIFGDk50qcssPKSGKPEHdDyXjg9gSrHbCiQ19/PpfqpyFTD2
	YVqrPDISWJ/mpLPIcj15sGGX2C13tP6ENpgDaSi68tJnQd7PZ8/pvNltLHRi+h1I
	Es79M3RF1f4fKkjaRts9j5SkeAMWVAvCQy9CVzMhYcrKrJSR97CkxfhkWyCjFkVJ
	z9hxtruJmwwjWdw8G6Rkw==
X-ME-Sender: <xms:akavaZ3Z309ON1CNjCEBwWL9wQKFqZZVgx2otGJdch5ZafMNLtGPmg>
    <xme:akavaWFVIrs5PHdo87-7iWD9XevRgUac9gnuXx4EeirbUb2831GjvI-WkDj9ZMEVt
    oynHOfDEXnoB4HB0fpRJNpQZYr7IU9yWRBD45gCbLdkwzpXNzTh>
X-ME-Received: <xmr:akavaXh2CI7Vh5TK1ubSJHCbwtpAcTziqFd1DQMBnTP5rpMYNXtnrys4QKOEoitcDEK_epD1MDgVvQDNCL6dgin8Rpjhniqt-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeelfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepiefgieeggffhtdelveehueejleekhedtte
    dtgeffueetlefgudeuieekveefhfeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:akavaR-KhIKVbraYBdcWD1diJ8M_lsngjPO27XOO-JBJzzhqK_Esew>
    <xmx:akavaeom4cZWMrIqKXTqFj9V9G_iG9J0X0pk1O3oPgUHvKZaHPJiyA>
    <xmx:akavaQ-5I2DZjK2LracekSGQjZ4zCtlfus_vk0A1lfKRULFv5i9LMg>
    <xmx:akavaSX44X50C5GBGJJsMSxEhkmtmkihhqzMgjwD__BYVCyuLuFHOg>
    <xmx:akavaVP6erurOzG94PuFIMqp8QhuuL6ndP-WoF0Cd3sfOjeYeGpaEr6I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 18:15:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] SubmittingPatches: spell out "replace fully to pretend to
 be perfect"
Date: Mon, 09 Mar 2026 15:15:05 -0700
Message-ID: <xmqq34283b12.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

It unfortunately is a recurring theme that new developers tend to
pile more "fixup" patches on top of the already reviewed patches,
making the topic longer and keeping the history of all wrong turns,
which interests nobody in the larger picture.  Even picking a narrow
search in the list archive for "pretend to be a perfect " substring,
we find these:

    https://lore.kernel.org/git/xmqqk29bsz2o.fsf@gitster.mtv.corp.google.com/
    https://lore.kernel.org/git/xmqqd0ds5ysq.fsf@gitster-ct.c.googlers.com/
    https://lore.kernel.org/git/xmqqr173faez.fsf@gitster.g/

The SubmittingPatches guide does talk about going incremental once a
topic hits the 'next' branch, but it does not say much about how a
new iteration of the topic should be prepared before that happens,
and it does not mention that the developers are encouraged to seize
the opportunity to pretend to be perfect with a full replacement set
of patches.

Add a new paragraph to stress on this in the section that describes
the life-cycle of a patch series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cf. https://lore.kernel.org/git/xmqqo6kw3bjp.fsf@gitster.g/

 Documentation/SubmittingPatches | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index e270ccbe85..f6ec8a3dde 100644
--- c/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -43,6 +43,18 @@ help you find out who they are.
   respond to them with "Reply-All" on the mailing list, while taking
   them into account while preparing an updated set of patches.
 
+. These early update iterations are expected to be full replacements,
+  not incremental updates on top of what you posted already.  If you
+  are correcting mistakes you made in the previous iteration that a
+  reviewer noticed and pointed out in their review, you _fix_ that
+  mistake by rewriting your history (e.g., by using "git rebase -i")
+  to pretend that you never made the mistake in the first place.  IOW,
+  this is a chance to pretend to be a perfect developer, and you are
+  expected to take advantage of that.  In the larger picture, nobody
+  is interested in your earlier mistakes.  Just present a logical
+  progression made by a perfect developer who makes no mistakes while
+  working on the topic.
+
 . Polish, refine, and re-send your patches to the list and to the people
   who spent their time to improve your patch.  Go back to step (2).
 
