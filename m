Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A656F3CB8E9
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391295; cv=none; b=kf3Bp393KbEEP73zlZKNBVA18TkwyoNz4XYOU6NnSzK8P/E4/GUVmV66JCR2lPMfcfcpCBwm2OlRA/ET0vFsXf3+gnlP1BvWvj18Yy1MHWw6lcOrrvhSgSexrAd0Z+2lPz72Gpw+e+ofuKseU3kRM4RehjwN5KfZx67v5uAkebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391295; c=relaxed/simple;
	bh=pl5d3uA6/adDNvUMl5hBEA92P0Ulpf0sjddxtUpbFmk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NzdO8zAeTDn9QfE1BXaFMd6vFRPJ+6RsKOhHMhhCOqnmGS277Vj1nQqIDyiIhvEUqpjjrW3FHlRs3QoUnhsA8WBmxh8MUkGEjUag+SuHK0e6MT6G2wB84GhbRwIugT+V6nDPQUtWWIPyo/9AKL0dtwl9xDQpizeSVg1NsEahXZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qm0p0WL1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MoYUB8h/; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qm0p0WL1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MoYUB8h/"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id DA823EC06FA;
	Tue,  2 Jun 2026 05:08:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 02 Jun 2026 05:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1780391293; x=
	1780477693; bh=84O9/fwTawOdea3ktbATVw2OoPcX0syJNYG0EyYg7Qk=; b=Q
	m0p0WL1mF+ARgVsyPYXkYBTq3WvT1pu3I2fIAf2HpNDZU0C00ynF4kUOyakX+L5n
	ocicqCOdXpYkV0FYj6HqfWpDeB+UfQ0HZuN9Pd1JFbZKRgd3PUoIM1b7yVsqTRxW
	wiLRh4au6NAkap0UEwe1+9NBzcbWv1WLuZHIPqzFljt3MJSjzBz+yNXzgNiYzyx4
	mAF5AodN0lEMyk6tiDdhtkrZtOUZrs9BBZm3ZZhibgCOcwwINXvHGpdUE1fkcwmo
	PJygE2P9DG1vkplkyclVqitztq/nldWG8HX/+MDoZErWd81WS72T7ZdTbizVhfeZ
	vV0K4rvazyGd9fYKSktcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1780391293; x=1780477693; bh=84O9/fwTawOdea3ktbATVw2OoPcX
	0syJNYG0EyYg7Qk=; b=MoYUB8h/F5GBSuO7I5tabb9uN2fKWGLsNBlUD3qGdfh5
	jWXuDhpkHaXcNyRVu9p9XI1OCAPHf4mG+4FtoWwMGs/Fm6Box30iFszRCGLpQPaQ
	6eJ7LfeVAIZqR1jNBNhztHgliXiqQ/i+6BRDHh1iFiIGxT9g/iwlD7GB6NtfdYxm
	9XO4J5556dfAQZSrWUTosis+jmZ/k7G63szYxELUImzvNzhBFQmoNx8vMXcr8XHl
	4C/T26Ub3RxLKs3Ku8RPv+1TYfn0YtgzAFBRqug2UYkqqyJJocPiZzov2S4JVTCi
	LdY0HZQ0zHGZuZHM1MjBs3eW8iB8+REH8MZ0ykJS/w==
X-ME-Sender: <xms:fZ0eaqCFesEpNq-33KFHUntzd5mJM9YuBaupjgjF8MoELLLKAj1g8A>
    <xme:fZ0eaqhETD2pNPGCRpvYF9G1sQ59fFQ5ivPi2AjT4OataeteJm2OwNVqDo2DGhKbb
    nrc75940dpi7MUq9Hn58afM0OKxMKfx6CP4MAu0yzzio2DITEpT>
X-ME-Received: <xmr:fZ0earMhUc6dtwwKzSx1LNp91_846sUwLhlh_9-DVCanSdqa87_Ik-n6XijQyVHC1cOJ0blzf4qWAfiMx-_Oxf78QRueCaykLQVv>
X-ME-Proxy-Cause: dmFkZTEpe36oI+Cbp1T0TkrUjSRW/33NwbAOzOtRozTWOC2noerVlft8G+xb2CMkO5mgJN
    1kqAiuQxacqefNwOID1ILUmni3IJyw0b2xdiGB+GWds3hyzRmnyP+tZaLF6N/TK55TURRb
    4s+BZgZSUwFRKgT+j3sxZtO1KvSPXQZzPiboyeVi0vm56qKWNFJz9jTAJTok9hrxG8jxl5
    +EmimNhtsOrQO7MMcOKwXgdVmVPyhZB9WXJ3i0AWag9M6r6bLLuSYpgsBzSTEplg8KCxhC
    aSBvn/FBr1rFEfRk9T2IbirQhMCU6vRSo8yLR7RRdTcKH1DVV2iEH20j/4Jlfr3/o7gAas
    DkfyWRbZp5jGzNBPZXO/CseYEWKaRZPQAJYMALVIzdHmVqWbBhAGy+0ttK7N1husa0DZvf
    awBLB7MVh0EySuOdKq0mNRxp1YNEapqCj5fayUKUlB7c1YUP5MIs7CN3czzem9ivkONTUU
    att4c66yAnPYT4TzsMk1BDR1BpOcJ22O0xH+CNlRqsuS749lidaO77VKnLPTblLzBZjDiJ
    Ra5ZgNvBRqdqaU1Pg/uWD4BSkb092yLmBJJHAcRkjNV1KXwpTC7o+U2PP30pwBqok16tFw
    tYXTN44Ubngb62WQ4XyF9NlKX9XGyHeNLLm9lnxDNGNaik5abya8WRtZbV7Q
X-ME-Proxy: <xmx:fZ0eaj50sC8m8sRd0VQm1ZWUVWMBs063O6POjolNqQTBaQXwUTjHfw>
    <xmx:fZ0eah2wf63V0nX-XOary72k5q09ADkfEezJWZ5GqbUIvY4VsMv4qQ>
    <xmx:fZ0easb167URXDHbOY431ZMqT-7srnGs6flefy29tCIXHIoEn7nMOA>
    <xmx:fZ0eahA8ZJYCCxcYoOgatho1VtwvNp4zI4gq2vBenn6LBjyRmMWebQ>
    <xmx:fZ0eatbjoqzc-CWrdqZsBfnJq98XgJIudOtLeuE97sFpW1g75psDmBAm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 05:08:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/2] SubmittingPatches: describe cover letter
Date: Tue,  2 Jun 2026 18:08:08 +0900
Message-ID: <20260602090808.87837-3-gitster@pobox.com>
X-Mailer: git-send-email 2.54.0-567-gf25c749695
In-Reply-To: <20260602090808.87837-1-gitster@pobox.com>
References: <20260602090808.87837-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We talk about how a commit log message should look like, but do not
give advice on writing the cover letter to sell a series to widest
possible audience.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index dec8aea4cb..8ff1792b9b 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -472,6 +472,25 @@ highlighted above.
 Only capitalize the very first letter of the trailer, i.e. favor
 "Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
 
+[[cover-letter]]
+=== Cover Letter
+
+The purpose of your cover letter is to sell your changes, explain what
+they are about, and get your target audience interested enough to read
+the patches.
+
+. Make sure your target audience can understand what the patches are
+  about and why they are needed without prior context.
+
+. For a second or subsequent iteration of the same topic, make sure
+  people who missed the earlier discussion can still understand what
+  the patches are about, so they can judge if the topic is worth their
+  time to read and comment on.
+
+. To help those who are familiar with earlier iterations, give a
+  summary of changes since the previous rounds.
+
+
 [[ai]]
 === Use of Artificial Intelligence (AI)
 
-- 
2.54.0-567-gf25c749695

