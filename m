Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA71344DBB
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477843; cv=none; b=APr6G7MAyIH2V15//MSXm842JXdZjDsOhq79RSFYQNrWJZ20wvgbYi8CV2zaLz3+mldyobtT2b2lKvvVVkpJDJAHXI3lDRSfgDlCEpb2D+IuB1w8Le3MLQ/hfHm5Hm1ktaR9T92QjV3mU3XdtEPGYjhBsbVY2N8XYP5AoMXe4QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477843; c=relaxed/simple;
	bh=ORBlZW0RFfVAwbotQhn+MGy6zhnUIFNeu5Xnw9LHt/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmG1xB+d5VSE1sWl12UdahXENJqMXXCnSaHSk0Ya8nrQW/1IQeY6+R20J62fIDqtN7lYIP9a4BKy6ptBID7ioR4Vxblb7IbhpfEL4Tw4hVG4IvLQZtdVODYlu4G7PHjBuoWxMSPfA0t/4Lh1hWVyyTjI5ZdoHb3rltx9e3Te0DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HNi7EboX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gOS4RerY; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HNi7EboX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gOS4RerY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CC07CEC05D1;
	Tue, 15 Sep 2026 09:10:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 15 Sep 2026 09:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1789477840; x=
	1789564240; bh=w94+GoJdGrZT3tZ/E81U5mu1FLS9cHt6GJu6WjpF5pA=; b=H
	Ni7EboXM+w/G7DiiTNjLPFiaDPGQlwxsvZ83IULmLgDBdWpSI9OI/X0q7ogS5Dh+
	32AmMFBATKF1swqEwh3IzL5WrHyoDV+aihXHO2ZxlmtCd80hjm8PajpTZ9h1wN7W
	sIEEw7NpSlR9Vv3zr8fjX1lYs3ei2B+X8U+UTVN2uRKvv+lxJH578ghInr2Wzogy
	RjqEC2Ht8BdZITbJi4Y7SH6PRtDFexe9sre0sPTZ9KI00e5gvHrjeV7xKPJbG/Mu
	aHXlcP1iiGfEJ8CDOBD7YmBiM3CORFwFlHgmw2F/8l7hPkFRLEF9MQnKjkMX0rR2
	4muVZWyFg/xq7WrwW469Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789477840; x=1789564240; bh=w
	94+GoJdGrZT3tZ/E81U5mu1FLS9cHt6GJu6WjpF5pA=; b=gOS4RerYZAcHR4ySj
	HsuYShjyc1AJwM+Pop4o02K7IWp5b55T65dNYXGJMKQUw/9kPaC0JzImMo2tMgCX
	8zQCLcXMsmH3HLIWaEeGMWu07qfPZ2kMTgunO4HD7QcOArBIcAz0oQZcJP7uV+J2
	Hlhz+vSYedk9At8RbGPQXMFMW2i0J+Pt1ZlWYX5r7uHU+1XJpJRh6ugaz1JXB+Al
	bp9NT4T6CJ4FL/1eKBV33SZ2oHKfs2DdQ7MFjtnTE9U3Ab8s2M40Y2CqHT//5pI8
	cYj1jNenrx1Iru945ytX9+A2nPu/ZNtdagK8XiS53KtCB2p4jEpoYUSYOyF/UPLh
	WsFaA==
X-ME-Sender: <xms:0EOpam2S7KBrg72p01xcPuArUtEvkZ7QkbCrks85Qewaxg7VBHzdGA>
    <xme:0EOpagg-lkQEUvqzVJ3VfLkiOTLlQmg0uz2ZDKz51X2yFr59dTDQf6vm8yEtU_aU2
    T7s1ULzBA_5UjXfwdQUNZeT1AMd8-h3bBd3LjzOXGJ4D7FJcS49-Go>
X-ME-Received: <xmr:0EOpasShkYPmO8ecm_TwJQ6QXHBrXPhnHu0V8oWqAxGhgAaEPRg6pRjU4Qwl5IGWm_w3tnvxInWdwOBo7vQI-Zt5YH6WLo0LuKe-l4tkufNcYuAw0vSJqWFeUQSeQoiFOnX-FembibSNn6rN>
X-ME-Proxy-Cause: dmFkZTGaL/lTLcRn1DJsnPWw44q0NNKOzA5ar1GEYzN4sNiu+Tn1DLpDhZloNx9XKLPG5F
    FwL6eWhbw2UwZDvX2hzDSZT8MmuRDmlR88/Qh0x8eXqR2VtB9AvTeVLGn2Sn1mKOhy97BI
    3M/XeQSuR98fAH1WgT61U7Oo0gmhwbPuxzqSOz/JVTYkz2AIAWBp6IxM0YI67GEsswwO+c
    OQmvlMudtthr/sna93fGII5fkeXCVdiJpYT1bmq8uVz55AzULtYXk7l/cSKIVhPwp7f5gr
    oAYLc7DW1GG4K0ll1laI3EHX3y1VkOFsKRGxGWpYqsEW8RWjQswEznrhGgj8JaTACOSxH7
    cj0aDaR3ErcFfr3+BYN5YglV3tgw4Y0dm8ndOJMsTSP5O3TOXb7AfsCNdW0GtKC4QMgBz2
    fWPenVdOHSZy31NSYM8KmdSIkSgda3RPyi8MxmpcpsFE16KEwQ3dUFdp9NutVD3U/azatD
    i+TklSSgIMkEMJthVz9Mcvl2KgF89K6nPLP2hjsJFS5aNraKvNyuIy2hYCmPxSJvx+/n0E
    rLfFYoBoh9okxWFWaRp4NPj0kkrTGIZo2G8EiMJq7FeRpfXYm7N3QVZZ2CwAgXj1ZZ7Ng3
    7V6wzJrnzMfVL+n8mHDofyMxjXmUIq4zBq/J6ghb0EQh5i/l/l/JOQRErSaw
X-ME-Proxy: <xmx:0EOpahh80t1Qy4TKXhfLWkQ7q4xqtgSRBVBjpTxaMtZ6gLp09JwtPA>
    <xmx:0EOpas7hnS7E9XSxo0-qaJ1DZxPFpJfIWl_MC3vKnAzs2zuVIyL65A>
    <xmx:0EOpauC5kYrYPZAXdtBP-H5cEAz6LTvw6go-afPHXmD8MMnelvaSVA>
    <xmx:0EOpajZuXvUSA18UVlR3GFlWBQGQBhB19Tk8VVTW18wQaMH79ir6tw>
    <xmx:0EOpamIphL72S2PKwafdfeD8uWu-SwbBfJPbHavygymsTCm82ZRXbUUw>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 09:10:40 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	git@vger.kernel.org
Subject: [PATCH v3 2/2] doc/refs: backtick-quote commands and options consistently
Date: Tue, 15 Sep 2026 09:10:32 -0400
Message-ID: <20260915131036.393249-3-tmz@pobox.com>
X-Mailer: git-send-email 2.56.0.rc0
In-Reply-To: <20260912191509.844954-1-tmz@pobox.com>
References: <20260912191509.844954-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The git-refs doc was converted to the synopsis style in 89be7d2774
(builtin/refs: add '--no-reflog' flag to drop reflogs, 2025-02-21).  The
commands and options were not backtick-quoted at that time.  84f3d6e11e
(doc lint: check that synopsis manpages have synopsis inlines,
2025-08-11) applied backtick-quotes to the existing commands and
options.

Subsequently, a number of commands and options were added without such
quoting, leaving the documentation rendered inconsistently.  Apply
backtick-quotes to all entries.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/git-refs.adoc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index 9063892651..9dc08cbca9 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -54,40 +54,40 @@ These limitations may eventually be lifted.
 `verify`::
 	Verify reference database consistency.
 
-list::
+`list`::
 	List references in the repository with support for filtering,
 	formatting, and sorting. This subcommand is an alias for
 	linkgit:git-for-each-ref[1] and offers identical functionality.
 
-exists::
+`exists`::
 	Check whether the given reference exists. Returns an exit code of 0 if
 	it does, 2 if it is missing, and 1 in case looking up the reference
 	failed with an error other than the reference being missing. This does
 	not verify whether the reference resolves to an actual object.
 
-optimize::
+`optimize`::
 	Optimizes references to improve repository performance and reduce disk
 	usage. This subcommand is an alias for linkgit:git-pack-refs[1] and
 	offers identical functionality.
 
-create::
+`create`::
 	Create the given reference, which must not already exist, pointing at
 	`<new-value>`.
 
-delete::
+`delete`::
 	Delete the given reference. This subcommand mirrors `git update-ref -d`
 	(see linkgit:git-update-ref[1]). When `<old-value>` is given, the
 	reference is only deleted after verifying that it currently contains
 	`<old-value>`.
 
-update::
+`update`::
 	Update the given reference to point at `<new-value>`. If `<old-value>`
 	is given, the reference is only updated after verifying that it
 	currently contains `<old-value>`. As a special case, an all-zeroes
 	`<new-value>` deletes the branch, whereas an all-zeroes `<old-value>`
 	ensures that the branch does not yet exist.
 
-rename::
+`rename`::
 	Rename the reference `<oldref>` to `<newref>`. The old reference must
 	exist and the new reference must not yet exist, and both must have a
 	well-formed name (see linkgit:git-check-ref-format[1]).
-- 
2.56.0.rc0

