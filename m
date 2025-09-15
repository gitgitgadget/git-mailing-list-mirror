Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A47221FAE
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 04:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757909529; cv=none; b=pY1E5EuKHgzgidZsjxnj5d53VL0m74XIjeoX0tu05gO4mS9QmjQD5qg+eXuXo9WBtP+8cHg4+JezzUM6AT284u3WjkiZ8UIuGyJGS6i77Le/JNlmJWi7b5KYrFjdWLZi1s+1FYjXwRCrz/lzSbXiWvdFU/tVJFaRlf16GXXPGbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757909529; c=relaxed/simple;
	bh=BzBEae2ZYtWsT26cL7CS6Oq7y5Y5i0K4T82SRebC0yo=;
	h=Content-Type:MIME-Version:From:To:Subject:Date:Message-id; b=sq71MtlSLwTnx1Cw76Fs5jVNqTYOgLonaqVl/iFF7I14uLzaN2V0wz/gaPPi/Kofs3E8Dl8MA+rwjaNEUween1JWYinyjtNfiGcrxSVbbt+umBj7nKs+bbcneggGdNLTO8uxE3CFdA0Buc8d2XE0/wDSU0MPJn2b0ICkcK9ABxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=m4+Hmdnh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZGIOmWq8; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="m4+Hmdnh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZGIOmWq8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 54F197A0096
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 00:12:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 15 Sep 2025 00:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to; s=fm1; t=1757909525; x=1757995925; bh=LN
	V94/1iuTbpmtYQhjoehPntb/KqT1OXf61/tQPAAn4=; b=m4+HmdnhEEZUUk1fin
	ci3yE72JRFFoHBVnvfG1Dqlv0AFDfXtCkpeJjYCniO6N5PNclqvoZlyVghznSWqB
	VjY5NhOdER35kEtQYUHUcn2kgFe0WPEf/sh+TsfZOsli7+51jMSsMle+D5DdmMb2
	N3ISwtDnvNfXRtK2SQK7hiWC8/hvhxndmWgqRrcnonxYOubxhEGf029zBgwo2zR7
	ovZA3ter0RwBLaXGa1wnrPauLPkOyWrWHBO0CMPM6TthFSXMb5kDaWjHDSYvZh9o
	mMZqs/f/uOm7SWWNPSLJAmSKu8Xwn6pcxfI4fAnamJkASE8ahWnwZp6Fwg1hCUKs
	aNyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1757909525; x=1757995925; bh=LNV94/1iuTbpmtYQhjoehPntb/Kq
	T1OXf61/tQPAAn4=; b=ZGIOmWq8nJcVtFv/y3/bmjpGC95lfJ8SZ44eDxyzq6Np
	e9Gwoh44AkvrE1JcTo/OsB5ByRZ3f5XANfhRLWFTG0bHqposZwcz0Q/U3aSThRdH
	zTko7ac6cWeXsZi5Pv/kOwz0m3ktnwpF+dSpSYPNoXQpZTpiqpE0Jx4BMLbmIR+n
	xD1bbGXldEnldBgfzmQpFKCJ2Ey4tnApjiUqwEFf08EVvX+8taD5ClNNBZmOqduO
	SsvoirSPgezna6S1L52WcUFNHqokv6JwFgY2JwrWRNPaMkdkV8qePcy1aCCoDdbL
	hfdGBML7e/jK1Hf+rUzySTfDrP6y1p3n/BxYY95qhQ==
X-ME-Sender: <xms:FZLHaDaOWgIqbELfpat-YMnvcEk5BUiBdIW5_-StmVU3KLWnr6m9wA>
    <xme:FZLHaEZ8Pca3srnLl_vkDhxyF1f4xOFb11kFKrmLTrQwjV3R-A8RHgMgmh7hQAvaA
    0_GpyEGO5EsOQ>
X-ME-Received: <xmr:FZLHaPVO0lJUp0GNlmf0Nc2qXhPzfPyjvPsnnR1XGJGoBzrx-FZOU92SLMqS4xtUAfNWZYJozCw6Ia6EmzGZvoDU2nX4cXMgv1aBsmFR2S53>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefieejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurheptgfgggfhvffufffkrhesthejredttddtje
    enucfhrhhomheppfgvihhluehrohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvght
    qeenucggtffrrghtthgvrhhnpedtgfdvveekgeejueefffdtueekgeehvdelfeeggeevve
    eiudegvefgkeeuteehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhope
    dupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:FZLHaL2xfBcOIkv9c0w0uTK0rHYar9VidjzKGgeRUhej0UDFYTzqWQ>
    <xmx:FZLHaGZoronclnHn--b_32rccHGpiRBq18JW9A0cEemEqywCpQwJaw>
    <xmx:FZLHaOogFRLGVSbmEsBdpU8u_aweAIZl07xlZSTRu3WD9qXee2eUgQ>
    <xmx:FZLHaCrf3MqPuzpuMFgOjvPmxpDAfs_XzE1klhhzs4y8CNvR_vZN4g>
    <xmx:FZLHaOy_2yufRtvVWad42Tk0bJJ8aEtTFrawmVGg3yeeD0Un221CkUgO>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Sep 2025 00:12:04 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: git@vger.kernel.org
Subject: [PATCH] send-email: don't duplicate Reply-to:
Date: Mon, 15 Sep 2025 14:12:01 +1000
Message-id: <175790952167.1696783.4795702220839036460@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>


If I run
  git send-email --compose --reply-to 'ME <my@address.net>' .....

and edit the intro message, then the message will get two copies of the
Reply-To field.  gmail.com rejects such messages.

This happens because a Reply-To is inserted into the intro message
template, and then the intro message headers are copied and another
Reply-to is added.

This patch fixes the problem by noticing the Reply-To: header when the
intro is parsed, and using it to assign $reply_to rather than blindly
coping it into the new headers.

Signed-off-by: NeilBrown <neil@brown.name>
---
 git-send-email.perl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 437f8ac46a85..e2248c223119 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1931,6 +1931,9 @@ sub pre_process_file {
 					$in_reply_to = $1;
 				}
 			}
+			elsif (/^Reply-To: (.*)/i) {
+				$reply_to = $1;
+			}
 			elsif (/^References: (.*)/i) {
 				if (!$initial_in_reply_to || $thread) {
 					$references = $1;
-- 
2.50.0.107.gf914562f5916.dirty

