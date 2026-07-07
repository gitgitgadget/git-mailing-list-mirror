Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8407D43B6D6
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446464; cv=none; b=tW9p+MU1msqUuruzvClImAcY/U6qa1T9u+pt27+VIazPAreQ+OzUlz+HARqEnC01yONkwm2HlJ60iNoKcFmEthWPfrl3LQReJWdqfQ8CJgG2DUHlEuSEWI6/6ezzeT0aCkJI/Q2XDeYESxn+/D5XgU1j9syNAMheoZxZAX6V0Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446464; c=relaxed/simple;
	bh=ucd9NByU+joXSgs6kbSHEDBEPSPTINPGOV6AXrDzMHU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZdwQsFyOUGuDJBi7HwLqFKNC+apjVfsBg3w64IOJBxNslVvHtrAqfqrFM4HZbijJdSin4TRyzA9hn6m6V64wSdKugrJckSh2CaZgx+C72kWj7xpV0LF3CO5LUh1B+R516vqJrLbBUfZc7elfPI2W1CC97sLSObeEBrI2lICafpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vpmvsf/t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QXP2FkgE; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vpmvsf/t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QXP2FkgE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D17A31D000C7;
	Tue,  7 Jul 2026 13:47:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 07 Jul 2026 13:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1783446461; x=1783532861; bh=2zmCes7NT7iy+ptPBIVguLYqD5VkzWgs
	2x1B/dNX+1c=; b=Vpmvsf/tayFOggK5Eh1NkxRylWfOhrt1oJ6Rp8CB17vAYLM7
	I9wWBF3tzlob+OcAtlSOj4RWFWIFU5vh0cwOgmfQCkb+SDpZuEyPbehqnprc1jPf
	r/wQWflTE8FEo4zHKioYbS79CmhDI7kZ9xzeXOfcG1TzxjfCdM3EZN5t54WxNXRe
	vk5ZO14gVzAPVP3McR1jCE4kIKQ8K8ylhfD1otr0FrYTd8/ZLSR0HB9tz37eGl5n
	ALVhM7abpHPWhrGQeuwbXQr7jBf7yKPyHfiubxOaW2Y8zH3VNm4PlzQyhCtPoPWv
	7QHpPecM7uizZHyhN/DLYCSNegyiLXwYFDOWWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783446461; x=
	1783532861; bh=2zmCes7NT7iy+ptPBIVguLYqD5VkzWgs2x1B/dNX+1c=; b=Q
	XP2FkgE6rrlWGcDaXSzO5vaUJ6PzsEzGDoqVRI8LB/dXAVp1BhvC+7p/ckLNF1BN
	Ky5+iagvte/BgVMi0jbx0V+cqpvKN6t11KgmvYApcWzBE6MgnmxPMXZ/4J529/f+
	qkU+7mW5p8F/1007NNd/HMKChtQW+edWcA1m+aPI+tkKUAigKZT3/xSa+wK8CAM7
	Y7z3YT6PhlRGMlw/xEQD5GxLyg3ysCdBcq6tRnZVLQoWqGfS33bm72IlMzQVODP4
	KHfBGQPUrisoZbqqL0N/gbDsYAoPVDx5S7WhmiwVqMBY7sI+Fy2UBh4UG1mHJNtR
	dRUnrnlgXUcrXO4X3KvHw==
X-ME-Sender: <xms:vTtNagcxYxW7MeFQSL7aTIzKmTsplap5RzTU0cPwyyFGsU5bcVZwHw>
    <xme:vTtNaoPJT1aaV3idsry-rO1AwX2BR22lr54RQp55UX7dVyrMn-AxbjMBw7yssQxT9
    JOziMU1IMXH0BCocHzvhHDnjkiVGpEvIJjRydpDaKJZAKvnmx92xQ>
X-ME-Received: <xmr:vTtNavJ0EQKIzH12zGIN4rjYF79zLoLDVoR5nfRKq6a-5-TxmWa7NWal4q_OJho2Nu61VyZhCFL8jP9_L49xZ4sVCgKeRE6ExxFeVnI>
X-ME-Proxy-Cause: dmFkZTGTBMj8jxZ921gppxa75hTd5trbeQUdpkThFTDPGzR9t4hyhhaRt+rWXNvvxmc2dG
    Ww7t7pu0uX/LtDMCSJX1aE0ba/xh9kxQdbiycNvSr+fw3mXMFsTkq8OFFMH3AfrRLabYEA
    bki0prpC22JUBKw4M/wnk9/jYqwi+WwQpjIVdVWnEp7rBqc2riA43lrxE/QcTnrPzjc71/
    CPMGDA1YT4shwkiXf23mIEjBcvX+SkJOCFhuJR/b2Fc0J5urcxoETKON8L9UXSUDSb5fET
    Nj3HTSeHwW7lGeVFgrDR0pv01618BohzxPzR1kKKo6Iwd0hK4i2Xjb1ctImuclHRQJYWHf
    Vg3xBudYzhPB/lpnregUDf9swRZyreLY+8guYNRNSBobH8PVTVaVOqO9NMRF09MUi6vXHl
    lW1CMjYliFCQaBt6F5YvHtcpZVV6ZCIL1pPvrfIhYhFO6WJcrk0Vk/CjNrxTpLwakIPCSC
    GJ31ZYEn+cWENhhQGJyF1aHqu/ULiq3uAQbKy+BnFjr7MTM70z0UZur9LYsxVfTAc9b+cw
    ikNDkIVMKGoxTB7yD9uhKuP+D/CYJ9lBoQkdYYtKb/nCyQ182I3Hl82c0P5nnO+lhA3GUt
    l8jFEo+4aMje3sUpNajv+IMO6QIhWd8TO9yYnZw8JDR78gkyxnDBI2qyGZiw
X-ME-Proxy: <xmx:vTtNahGAcmPXPO0f1hGJRTkyw_0V3DlJ9X1M9KLi8TY-feXOaQeMVQ>
    <xmx:vTtNavRKQu7VzpOUlzNXK_4vdIaYF_hZMxW1eRVgvlGJZ1BtPrNjpA>
    <xmx:vTtNalENGVBao9AvBpAdTN3MeTkipx4lr3nS6TeXgRb-UqUCTqy2tA>
    <xmx:vTtNaj8k4vwQLImsG3DFLeIujUHVO17cPk9sFd9tYwbWV5sicUWVoA>
    <xmx:vTtNar1OoBZlX3ex4q4UtHCt8dXK_G6_kFsn2MSS1Q35N742En6eUPfX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 13:47:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] Rust: fix description in Release Notes to 2.55
Date: Tue, 07 Jul 2026 10:47:39 -0700
Message-ID: <xmqqpl0y4rpg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Finish incomplete sentence to say that we

 - build Git 2.55 by default with Rust,
 - but you can opt out and build 2.55 without Rust,
 - but Rust will become mandatory in Git 3.0 and later.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I usually do not bother with updating "historical" documents, but
   this one seems to have already caused a confusion, so...

 Documentation/RelNotes/2.55.0.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/2.55.0.adoc b/Documentation/RelNotes/2.55.0.adoc
index f5643534dc..e7e77a8112 100644
--- a/Documentation/RelNotes/2.55.0.adoc
+++ b/Documentation/RelNotes/2.55.0.adoc
@@ -85,8 +85,8 @@ Performance, Internal Implementation, Development Support etc.
  * Promisor remote handling has been refactored and fixed in
    preparation for auto-configuration of advertised remotes.
 
- * Rust support is enabled by default (but still allows opting out) in
-   some future version of Git.
+ * Rust support is enabled by default (but still allows opting out);
+   in Git version 3.0, Rust will become mandatory.
 
  * Preparation of the xdiff/ codebase to work with Rust.
 
-- 
2.55.0-270-g106a830b98

