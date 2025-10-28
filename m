Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B61F344053
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675576; cv=none; b=hzVzWFbqvTvqgt4HZpnW+DzEUs4ZAO8Midj4OOjoGJ+cLVSl4X3qzlXPvQ4zUrJIT+xWhRI1DYc62gaaQ+k9l6KMyhFgTuoNabOydOy/ZOr+ieAUikp4K1/ja3kgbkqrYl+GWrSM7cURjBB+6DCa1o3FFITp+RIZ32g39sodE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675576; c=relaxed/simple;
	bh=TKuE/kXJSLvvsI6FeZS63T20mPqVlxphlwjjeeqskJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N2/6QaUPIYsWL5F+oIvJAbDwx1ZLZYO7l0z0dTbz3rueUE9OlVl5ZZ+x7Qi4Tl7Ia16aDE6IP6DGAR3zAAWoP+BAMTLuY/QrUFd9Fc1i5hpdgz5rrbsm7VWKpCsT5JQwPq8XmnFK+SdT1NHmuODe3M8mxCQqKxh/cjDlOpQXNKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=S7COJqJN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WFnalWpV; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="S7COJqJN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WFnalWpV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 718041D000CD;
	Tue, 28 Oct 2025 14:19:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 28 Oct 2025 14:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1761675572; x=1761761972; bh=hN
	xGvz5ulzJmRURUkzIEZTitpjEXoudXB+scHOqYALo=; b=S7COJqJNNSk+s93XZl
	nSXyrxx3KcATJICFzJktSpqZkTa+Uy6aH8gXMYxMmknQDANS3ZVRFxd1F5QVg90E
	bmA84FdLJ34JmAC4zrN6tQ1avQJOK90LT8EyxPFBPlYnBxI9k2+dqR227kXYdQt6
	EJEzmMIi5YlpDnZNmMTzpNi2M4nbM10pPQP0FhBAirRddaHSOUD+7eVz2tLejtBx
	HbZ+CYY7ZzV5UKof5gGc0YlbSZ+XZTwCiLtbkTlFjyNpniSUgKeiKFdSbuD3CYX9
	v8K+5D5OMP6A9evZVnDhwcrK+GNm4EOJDywqMl5xXpHvGtYPYoeCUsZBDtJKQzuv
	9FMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1761675572; x=1761761972; bh=hNxGvz5ulzJmRURUkzIEZTitpjEX
	oudXB+scHOqYALo=; b=WFnalWpVw7xlYva3TfaKTjgvXmwl23guQsYfdxpRJ3dn
	Smkj/CqFT9IVlUAuoBejipc9Y2zQOtOTpaSYIoNfdMRJEIy3oYG2FnKfPsBA/5gA
	7q5OpA8dvwcx7OaP2MZL65W/glC3e6D4PlSpUO8k7FTyQx5MQ/lOuDqsMJa8RCgy
	IY5RxGz93Kp9RbQeev9EWQRuQf+A3hzh9mtruIKHrqQnphKF4gugSYkA4E3STFnf
	viHDx1vK2xICD2cGoxHn6m/yxYFM88CV2Ipdd/f/e3ZWeOKxLHUp4j2FP2sspEok
	WEcc1c8qYsUQ1sOdqHSQ8ie7weGLxIwHcw1uA5uFnQ==
X-ME-Sender: <xms:MwkBacneMK--wmU_uXFV7e-UUqtTmoKlP376RQYL6vn2dkbxbZMwFlk>
    <xme:MwkBaStYcEqVYoy7BbfoTHbs9EwtzB_Z-LT4f5WlEjZvi_WFOhB8eQbkF4s_D-E_r
    dCYB_vD76b9kMBe-gvmLQEfxiaiaeFJBx2WHO0BxcY6He9OPgrlVw>
X-ME-Received: <xmr:MwkBaS-_wtU8tA_kdkOmx_S768DZlezE5hBRF1eljJd41g7Xo5XnsCeeIzofpyMZcgFD-R4jc93DWoqbU5unfJwNzqNW_0QEIX6M5ckciZrKUoUgeLlvl_zgMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieduheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtre
    dtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmnecuggftrfgrthhtvghrnheptefgkeejffdufeefffegkeevgfevvdegff
    eujeejleegudfhtdffieekleefhffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhulhhirgesjhhvnhhs
    rdgtrg
X-ME-Proxy: <xmx:NAkBaUPLpIKZMwIoFdLBM3BE_EmsS4oLr1fdWUAgHuqUFmEQi_wsfQ>
    <xmx:NAkBaYF6ol-_QhNJ_WnP6Rf2wNMn6LlHsisPr59xd8KS2MqzpaifCQ>
    <xmx:NAkBaaRoJoOsHIyUZQcJjO7PzTaVlOELTnBot40ivLYbIs3QVTv0SQ>
    <xmx:NAkBadstx15S6WDKIAMSzWv8AQV5FyvH5jpMxlZMRxwWwbp4CwiqcA>
    <xmx:NAkBaTe_VbSQk2rHXkHDHnY06RbvQjhi_9xqjah-jMklcfugjqgXs79a>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 14:19:30 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: kristofferhaugsbakk@fastmail.com,
	git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ben.knoble@gmail.com,
	julia@jvns.ca
Subject: [PATCH v2 resend v2] doc: git-checkout: fix placeholder markup
Date: Tue, 28 Oct 2025 19:19:19 +0100
Message-ID: <v2-cb38c701537.1761675472.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.1.498.g8f0801f1c10
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The placeholder markup is underscore (_), not backtick (`) as well.

The inline-verbatim markup (backticks) handle interior formatting. This
means in this case that it applies HTML `<code>` to the underscores and
`<em>` to the placeholder.

That is the effect, anyway; we can see from the rest of 042d6f34 (doc:
git-checkout: clarify `-b` and `-B`, 2025-09-10) that this was probably
an unintended mix-up.

Acked-by: Julia Evans <julia@jvns.ca>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2 resend:
    Resend as a separate thread this time. v2 is here:
    <v2-cb38c701537.1760716150.git.code@khaugsbakk.name>
    
    v2:
    Add Ack.  I also considered removing “probably” from “mix-up” but
    left it alone as a point-in-time note.  The msg + ack makes it clear.
    
    v1:
    Since this has landed in `master` now.

 Documentation/git-checkout.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 431185ca0ba..6f281b298ef 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -61,7 +61,7 @@ uncommitted changes.
 `git checkout -B <branch> [<start-point>]`::
 
 	The same as `-b`, except that if the branch already exists it
-	resets `_<branch>_` to the start point instead of failing.
+	resets _<branch>_ to the start point instead of failing.
 
 `git checkout --detach [<branch>]`::
 `git checkout [--detach] <commit>`::
@@ -155,7 +155,7 @@ of it").
 
 `-B <new-branch>`::
 	The same as `-b`, except that if the branch already exists it
-	resets `_<branch>_` to the start point instead of failing.
+	resets _<branch>_ to the start point instead of failing.
 
 `-t`::
 `--track[=(direct|inherit)]`::

Range-diff against v1:
1:  54bc6875cc5 ! 1:  cb38c701537 doc: git-checkout: fix placeholder markup
    @@ Commit message
         git-checkout: clarify `-b` and `-B`, 2025-09-10) that this was probably
         an unintended mix-up.
     
    +    Acked-by: Julia Evans <julia@jvns.ca>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    +    v2 resend:
    +    Resend as a separate thread this time. v2 is here:
    +    <v2-cb38c701537.1760716150.git.code@khaugsbakk.name>
    +
    +    v2:
    +    Add Ack.  I also considered removing “probably” from “mix-up” but
    +    left it alone as a point-in-time note.  The msg + ack makes it clear.
    +
    +    v1:
         Since this has landed in `master` now.
     
      ## Documentation/git-checkout.adoc ##

base-commit: 83a9405e59e9cdfb587b19c50f0c040f346dd4ea
-- 
2.51.1.498.g8f0801f1c10

