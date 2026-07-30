Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD22D368D45
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 03:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785382872; cv=none; b=Ka7AT6r3Xg+8VJpeF4vnib1nZaunV+rZOU3660SfiNpURjevemFpFmskx7xZPlMDfOsUqAOOBY3jJZVFgc4lIdskto0GsrzWzfGEgBCMgbpH1YIHemouhYIF244IT9jIUMIIO/71KrSt1zFS4dWascI57XwuBbC8xXpPcLHpcMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785382872; c=relaxed/simple;
	bh=4YAz+TAjgz24aIcjYH060ekcugrDRiMBNS8q/pQQ02U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gaqOPRxerwWdFY2GExiWSIj7WzTs9YICPFJsYjwOjbeCqOBykJ2NcHsk+8+opiPbfTT2wxiJGE4en9disaa6ON+mxNwfVSz5/7flTU0qPfYRBBQ2fdzBWAIoltmrB8iVoU7D2Kh/vOhBsKpbwASYvvscvzyUNgxe2bxbAa1ps/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rrzfLnED; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MZRtrkpJ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rrzfLnED";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MZRtrkpJ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E99E11400343;
	Wed, 29 Jul 2026 23:41:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 29 Jul 2026 23:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1785382869; x=1785469269; bh=aZFBk2VN3PNjajIkvp90l
	NxvXSyFkU7p2AEiY0RYuT8=; b=rrzfLnEDc5dGcwffskE6goVK9rucLj/7DEuT1
	eXwOAoEdIaB0QUzpTKr8XXxldMGD3ShU2ilg/Wi3TRKCsRvDWHtHZErqqcuTKq/6
	zTRzD73NYqSM1rWt2MsNzxHeGU1woJ7+epWbK4sGAhdEEY/BiKXJE3vKQhNI69mf
	0uv5/SuG0MN5E2CsfqUWLLP/tAhUrBnhFBtM3CNviOf2XoWyY0A5jPnHzjvFKfR/
	oxRP3Na2P8yZc8jAuUsqGyLxuqz50v3K7G64aRGxl3rArjUVp4wWQbP9kReAa1yr
	aaugXgn/Yh6Ns4aGzODAPm6h4p5yUMa/GCKXeg11cni6E+iSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785382869; x=1785469269; bh=aZFBk2VN3PNjajIkvp90lNxvXSyFkU7p2AE
	iY0RYuT8=; b=MZRtrkpJWGtZdYl5p3rlG3K11niCKYt8ujPMyQ3XLpS60IEdEUW
	xSCdVLfp21/Uqeb9L3AvCSPijFusF0HtsPcF1YB7nTS6QMg05Zj+Lwhz72EcsWLV
	kuGEF6hI6a9Q2mIfkt/sJpD0yCXLwB6dSXJT6hXyRdBR+/PKKHBoecUDjjVqvBUJ
	Qi2FPvBV/re9I1VfbmNUs5aCjXaIjxCqbjW/XBd4ErLWJovaAMxC8nv2TMARevqQ
	JdTCIpl1jXKSHs0BhiIAay8NrOUjs0duEBq6tQpOfM4LOjz8VU83rX66NoGCInx5
	UiOvtwm5dQe0adUsramPJ+0oMdW8f1T+cFA==
X-ME-Sender: <xms:1cdqari7gbyORo-toQCA1iNJewl7EU4AzeVxZMTBtIzE7diNMOIR6Q>
    <xme:1cdqauDcF0iN44LrxSC-B0Jkv5k4x7aeLdOLBp239xNAVg2S6N0xtNXnL897vgR2N
    ZErXnDDirFfBOddBbK9CHZEPhboyoPAIX5XFWkzuh3brHtf5NSb>
X-ME-Received: <xmr:1cdqaotBYzUD3zv6ETC55TjEmNHrD9IaKpBvCLmN7ENW1NBJLdu6aC4s6HNsH2f32C58OPoUq0zeJcFy9WdqSuykyIIVuU_Bpw>
X-ME-Proxy-Cause: dmFkZTEjnVbzDMfF0b0370Sio+rdOFnC83qLNug9HKExoQIdhsAoaaqBI54HAueVNQeoQY
    1uewbIjxHt68aNO3TAJzzu/0JYU5UQuCPuVkIgMy4iQaw1fm5QQoBZRAcUrCUXYmg2PS45
    RxX+1b6mMS/hO9WRphKRA3ZxPQmYHx1WKTS7k75Phd+P+S9n0e4sPARHNjlnWd+Wat3pLe
    vdWq0ZU6M2KO0Zwot2AE0FZ08DoguAYj9KknM1bQJ0nljAKH62s43cLdOdtbeN2ijWAN34
    e0L3/ALI/l6gji3N2GVkKuiRRUMGD/lUqmWgSq8yzp2buKQQqpXclEgQaB7HbRrcmDx6HO
    zTQMVvXON2qtyEahF3HSluORALDTfB1MAdPSXvB81STL4Qxe+YE05CLWuxCLePpYmCs6gC
    IuBzWiX3zUReBjM1fC7Y+3+XNBJ4VWwiDYanPS1SpdS/AjIxJ3e0JgWMa0GLG0EPCMrrsw
    RCB7hZUJQiqKJ7bpUMvIpchfGXKg8z5WWi0aBwhpoyIQHa/MEdUaaLCyi4mC0QqlnSnvvk
    8dS94mFxU6licw535H3gg6WkEPNskc6cxCxEhmoVZ8/3AussqTj+wHhrmvzIlCd//VMavf
    hFoO0PCB7WTSaoRVcHpO7nuXPfC/4SwKaWoO7CdgqUFa4FY95UsCEMr8zrHw
X-ME-Proxy: <xmx:1cdqajYTJAYNNQ7ys54UeU1YsC2DpSZGAcCzdZizPJ1w74DUn9MTPw>
    <xmx:1cdqarUvLXrvfk_8M4P4z7ucHXgIc3Qk8heLS-r7X5CbJQ6xH_regw>
    <xmx:1cdqan7ZjSygfrtZJZV9NJgNbyxcBlqKunvzyHiBM0KHE8Znd6Q_5g>
    <xmx:1cdqamiBiQlC_QpKRLS-u2MpNf0w-jggaaxokhnijol-IQF9bhALtg>
    <xmx:1cdqau4Ft788E8LokvPb88WZ9AYQ8_Rtky78TV2iciqbjGFWXKpMSl1I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 23:41:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/2] git stash drop stash@{2.days.ago}
Date: Wed, 29 Jul 2026 20:41:06 -0700
Message-ID: <20260730034108.765430-1-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-597-ge6126a35d6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because 'stash' is implemented in terms of the reflog, it can accept
not only a small integer index (such as 'stash@{4}') but also a
time-based reference.  This is not a good thing.

 - 'git stash pop stash@{2.days.ago}' picks the first stash entry
   that is no younger than the specified time and uses it to modify
   the working tree and the index, but then removes all stash
   entries that are no younger than that specified time.

 - 'git stash drop stash@{2.days.ago}' does the same, except that
   no entry is used to affect the working tree and the index.

These two patches forbid passing time-based stash references to the
'git stash drop' and 'git stash pop' commands as minor safety
improvements.

 1/2: stash: record positional index in 'struct stash_info'
 2/2: stash: reject time-based selectors in drop and pop

 Documentation/git-stash.adoc |  8 ++++++++
 builtin/stash.c              | 18 ++++++++++++++++++
 t/t3903-stash.sh             | 13 +++++++++++++
 3 files changed, 39 insertions(+)

-- 
2.55.0-597-ge6126a35d6

