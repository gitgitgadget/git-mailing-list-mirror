Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CFE1F3BAC
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783798021; cv=none; b=IJQHfBzhdByLZOJZjwDpUGjrezd5FDEDe6qu+PJ7kuzUYTzzdQHHcc2qN4LvWl2IMbTjZ50KlAo7DP6lnpoLRlLJXn+yq/50qJiM41Rcqet5WaH+7huPxwUOoph6F032SKA8lNKs9Q/R4BNP+q+irkZix2vAndQcKOt2GNZiNLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783798021; c=relaxed/simple;
	bh=eu1LsRcHBA2hwmZT5JAer3iHQ5T386rcimf57VgGzxY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LF097oF3pXdMWovj1pkLfSVeo/SEkxe24AJXYvdt130X6Jtdp/AlNUtbTMA6R0KEToJsdJqVr4/iS/r6FPf2Cg4ZLDBqvHlqjvM1KtjsdYgzT/jaUuTOmP4QQi2yq6YBCP06deNb4wdae9vPo/B/AjfKcan9MhurHaJ3y91Fyh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ecP4mVGO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iiqv7aYw; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ecP4mVGO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iiqv7aYw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6F44EEC00BA;
	Sat, 11 Jul 2026 15:26:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 11 Jul 2026 15:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1783798019; x=
	1783884419; bh=ZKwmIR2R/+9PGDOMp98pEC2NLtqPP4HUXjHtJZd7/p0=; b=e
	cP4mVGOM0e9pC9QmiQxwv+FVj6ZKrIrHKIH2XALvSu7ppkxRxlEpYcqLeBsf84HE
	xIlmC9+YE99XkpZXvucGyFohECUrF9T//ZvrC/sMX2h743yP1O6hITNoRHtVPhmu
	895Sc1/EBVUR57JwPuB1ZdBgCNjxt1Odi+Y9DJWgw1O6O+hSK8YVsf3HbPNvGOz/
	S0O9mheHmVBG+6czxxlXg3U+5SLdCGGEUK9BWJR+TaSLlQr06tilzYAQrO+uSkl1
	fcEAF28VCDPpR2JKvN6cCb8xatD5LZDaoVbBQ+z9rX2mEgGN+bKJwQd/Ior4FwbX
	xNebfTOwzVoTY7VcTzlRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1783798019; x=1783884419; bh=ZKwmIR2R/+9PGDOMp98pEC2NLtqP
	P4HUXjHtJZd7/p0=; b=iiqv7aYwWwmWnmTMUd8g5Q6AdhQqBiksiA+8JEsJsKfG
	RPPTZDeFxIFebMVqSxDJbUS2n7rXf9HzrGYogye/YnqfC4g+tM8VjuS/vwNC+SUl
	7Nww7k7M3EM1boXjDeYEAhgiGg1erK2bBuorMD7926V+POrGXxTVRyqupx6LQbq+
	/h8TQRtIyo6+sRfKAqKPeV2RHy+SLMy22n9iH+BWf5KT13XRsFr8KHxFOm0ZgzS6
	NiYzMLYpcBQly2Nf009J79HvLc4UXo5gZeoZHsZT1zkTK4i/T8eZaoapbYO23HZC
	W9sFMPFj51KRSTXKPp1JKHEDYilOLNHk5NVcZKzsCQ==
X-ME-Sender: <xms:A5lSaqqE63ARqN_k9hpBzDU2uGhoERJ30Cv_MJrIoQiMJz3mZZq8VQ>
    <xme:A5lSaurXwz79XKiIdzTzPs21ML-Bd0-Tp0G2_ujzhZdSpCbatiorbblACvsS7JvZx
    STeiGnQzkhaZ5A20SgG3t4c3v0-NENyn6u1nh1balzJlWVy7K-C>
X-ME-Received: <xmr:A5lSas0gYNl-MFjKPz0fk83Tca-HBoBe4Fva9WDgIthbQ5Ogjnso7scVRa9pI3Wr_YW3NXVd14UIF9zBsYooy5dkghCW8Hv-WFKaFHg>
X-ME-Proxy-Cause: dmFkZTFJqDDiLOtZNK9IvspcieMba+1eLNTx4J7Cw7UAxOT6+ouPyrq6BGv8CmHUd2yp1c
    3LMnbIMYWc/oetxfu+mKHTLz17Exy8hCJVcRjfraJGA6VV5ICpS2oZCzWdS24PVZ+aLY30
    MyWDLG0gm/JKg0jlleOwkLmuavqw28VyOz2mUZP3kBlXWWbiFNtEgxOTnhjArRJLn4v9Wj
    kHHNDOhwlLq9Ne68NTTJxEAZclo3E+temZV1Dtje6ypm11Jz6233+i5EmhGrzCZCODkNrq
    f85z6kei2FP7RRJRW4N9tS+iJtQgbwn8ErEA7bx+HSh0jiSqZlcbsxbC3vQz5oeokJ9gkA
    OaZZDImWgaqR25jHGm9pD1ln4PMJlUBkcIb1mo5P5c8teBjfa9+HZVXU8tPK2lKn0+MQBZ
    QpESroXGr+kx8D+7e68DtVowg6SoxrAQVH2R3JXX34Rnm4ujYOsvMqr2FPk3+kuU6J7zjV
    d2lQvHu6y1qUDo5opb+aSAIMEDfXBdAAKmr07ExRbHo/RYtXQhScZzVGr1c7nHlRf7nN2v
    hJRSJmxajTPnXmfdrf7wAQ7l4xHjhZf4661PmNsuU6D4u6B/gpRDgVcI922UlCeu+kketT
    czsvS93ubjcC8z6XQUgdcV7uKc5UTU4CScgorYv5Dk01pV69OrR3iyGZfBZw
X-ME-Proxy: <xmx:A5lSalBuPBYFX5v1_4M7ejx-b-ldQ5ugR9DmkU_ylNFlOOPo_GED7A>
    <xmx:A5lSasdVXb71ioa4_i1MFB3ogSs_EDaU3y5ZjZF71uCCCBOzghRblw>
    <xmx:A5lSaig72itK6BkhS8pLkz9zejsSKanLGl8xW_iH4XZbUMRfmnb4QA>
    <xmx:A5lSasrShdEsNJ1_cpkVPpC8WNvRDKbu5XhiaovBtj0xK_WsOXVy5w>
    <xmx:A5lSauAvwuioRzPwrzb_Ww3LqR7Qg52rCT2HUqUHDnVUw6-v2QtJKjcZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 15:26:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 5/6] SubmittingPatches: clarify the meaning of "Will queue"
Date: Sat, 11 Jul 2026 12:26:49 -0700
Message-ID: <20260711192650.2417665-6-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-391-gdf86bf5712
In-Reply-To: <20260711192650.2417665-1-gitster@pobox.com>
References: <20260711192650.2417665-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document that "Will queue" contributors get is merely a promise to
put the topic in 'seen' and has no other meaning.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 12f9660cef..0a80358703 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -104,7 +104,9 @@ of review.
   branch, in order to make it easier for people to play with it
   without having to pick up and apply the patches to their trees
   themselves.  Being in `seen` has no other meaning.  Specifically, it
-  does not mean the patch was "accepted" in any way.
+  does not mean the patch was "accepted" in any way.  The maintainer
+  may reply with "Will queue" when choosing to add the patches to
+  `seen`, but it does not mean the patch has been "accepted", either.
 
 . When the discussion reaches a consensus that the latest iteration of
   the patches are in good enough shape, the maintainer includes the
-- 
2.55.0-391-gdf86bf5712

