Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152318E02A
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 01:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765069442; cv=none; b=GMZ0qzQkYqWoQfizXzOVjte8aFoe9RI7WqLgNiy3rODVWPl2s6m6EJxZkKDYwf8Wdwf0Q+ZQ5hbozPm98eDEd4O8KJDHknAVEA12HmVoeOyqVvZNRrYe8zSQjJQiA4M++Xbv36N8guc2xhe6fSLtSsXovQVkP2cISEMBCYvWKRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765069442; c=relaxed/simple;
	bh=xDZYIhJ2P3clfkCHnkwLiFxMSrJXHaLayPrRNNoh0R4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=estXw/wiKLIG1jgwl5h2GlQKUSTqinDT+8dp14r3xqf+3PWWCNHUi4FISLeC9tVRXuczdH/HrG5rbnw7KsTQ3y5fDFGkBnRAUcRBZtDESRzqW7+IbqTMfx8YRwosSzBCvXOdvmav2oxgDPPKFNSwChG37zGOcPI7yVO6jakzcIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ODFI+2Js; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S/v0JdU7; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ODFI+2Js";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S/v0JdU7"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 5ACA2EC011D;
	Sat,  6 Dec 2025 20:03:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sat, 06 Dec 2025 20:03:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1765069438; x=1765155838; bh=LcxshHSZCbMg0cEkGvRXK/m/9qi2/qVH
	PHq6p5bjgWg=; b=ODFI+2Js27x59KHXuRrstO0AOdhtx0q9F8HWD8SdTyzitZQK
	s0qFwV8sEhi1Afgnic5/oDXdNqYVl5X1t2rBJbNQy3JI9/8AC9aXjs0z1UuFRY0p
	oSU7H5ULmlfswtzWctesIETSuH5nz/tjXQQaIA1eCRjC/iRrxcH6p1mVn4TFJzxa
	5yWv+RS7saH6RfQl7APZGIC0k/2FTuO2CWtlI23nDDg02GgP5ZV4bZHLHgkEVE26
	XkHNn3JeVrm9wxSgvLwGe6a/r95Kahy0gG99tfNOe8s7xUCMVV0OwbQoGJ1YQ3UY
	E+cOERhrPY//39sqzzPf6ta49b83os164Zzt7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765069438; x=
	1765155838; bh=LcxshHSZCbMg0cEkGvRXK/m/9qi2/qVHPHq6p5bjgWg=; b=S
	/v0JdU7trBBoxwm5hBRSiU2axxl8nYwcqA0yqpWP6h4S+m96VB07vbzENmUupw0v
	94ROF6TYjaxQjYLr4X92EQKV036dp3JJmNZfJLM8HaSXOzCeLQ0qWOebMKdyVHFi
	z8LAUnAVf8/wB0X+nT4EOUyxqxznRPC92x/ZkbMiKMyuyeMjEzST9QylqvDrGjbQ
	1ZuNzBw9+n6JHTdhsv2u+TRTOVX9qLlwQB5dKPFbdFayP7B7EkedJIyq1Lqu54yr
	mHVSXX0BgbKPg6fmo2ZWDS+DU+ulwKcg3Ol9d8xq6VW/CS3/3c5Wzyt3jzS3HxOH
	KiCTdoXDfGg0rtO1XI5Ww==
X-ME-Sender: <xms:ftI0afnZeQ7LwitFSYgHPpGbC9rK9agm1VJsW6n8hW7hxIQqTgm96w>
    <xme:ftI0aY0k11sDtdYk0A8WCALfhNLnvg3kaojcllXMZvg0f8lLYMtSL6SoWQlLxKN0j
    3tn4kDIOsYIqHylq7b40JYNtnZq1uQU8NXym9dzRnFCLhVEJIQZ>
X-ME-Received: <xmr:ftI0aTQ0tpE7GxWRC-5fvw953fHWRhfiGF9Pw7fMcQVDguId11T4UZgfMNtLHRzMu5PUpOyZ8s7ewE8UpwATEhocuSMQnmjc7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkfgfgggtsehttdertddtredtne
    cuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohig
    rdgtohhmqeenucggtffrrghtthgvrhhnpeelvdeftdeftdekfeeuveelgfelteeiueffff
    ekhffgkeevheekhffgteejhfffgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtph
    htthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ftI0aSs7RR2G1GTbdiFb7NJIlam16fcU4wtVjujrVOgoS9gszLu4wg>
    <xmx:ftI0aQZRDWmpCYe8ae76ltKL8Zhc5qQORUHSfysC72GilJ-Xn5M3_Q>
    <xmx:ftI0afvOljQHDasivRtQM5MdKTWnbr2xJBNEegtkzCtWO-38T6tsiA>
    <xmx:ftI0aaFVJDcghcrOej5RK_Gu2_CtDZUdv6OOK5ExcWBvPbRKgYJtIA>
    <xmx:ftI0aa9YSLzXWXOatukxMECRFIRsL7eo64TamosQZ25JYDdLjQq-S1V0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 20:03:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] completion: clarify support for short options and arguments
Date: Sun, 07 Dec 2025 10:03:56 +0900
Message-ID: <xmqqzf7vm7b7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The list of supported completions in the header of the file was
mostly written a long time ago when Shawn added the initial version
of this script in 2006.  The list explicitly states that we complete
"common --long-options", which implies that we do not complete
not-so-common ones and single letter options (this text dates back
to May 2007).

Update the description to explicitly state that single-letter
options are not completed.  Also, document that arguments to options
are completed, even for single-letter options (e.g., "git -c <TAB>"
offers configuration variables).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git c/contrib/completion/git-completion.bash w/contrib/completion/git-completion.bash
index 73abea31b4..538dff1ee5 100644
--- c/contrib/completion/git-completion.bash
+++ w/contrib/completion/git-completion.bash
@@ -13,7 +13,8 @@
 #    *) git email aliases for git-send-email
 #    *) tree paths within 'ref:path/to/file' expressions
 #    *) file paths within current working directory and index
-#    *) common --long-options
+#    *) common --long-options but not single-letter options
+#    *) arguments to long and single-letter options
 #
 # To use these routines:
 #
