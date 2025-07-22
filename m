Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1882882BB
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183269; cv=none; b=irXxk+ypW/w0iuxo/rt3UJf3FJPguBJJ8yQRAjR6BFGEak8hFUFA2IrNzKXResExQcMNAf54/S9wzYWhopojVM8C+9WkVfFa6C2cTeSuDx/cqwVOcQ0w54TO6SaJ1B4VPDfPK4zb9igZ6K2CX4NsDOdoeUlRpfaL/W2bsAXXKsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183269; c=relaxed/simple;
	bh=3aRgzCnq6iqBz+0P6BI8fm/UhZNxzOdmVXmO21FJ+rI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=seJnNX/ugC6o/g2Xs+qWy8icMrIjJhPF1gYoopQWaAP46RtrVPkOvEUWz3l3ep3u3F7H7TGw7oVq2I03B8YMIREfAXKNFp4a0UkG8dkhca0FHfcIBXvgEpUncSSjm24nfho/nUflfdrDtUdOzVaYyiOKSt7YzcBSTnSWev/a6b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wP7J2J7+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EXjqNtMX; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wP7J2J7+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EXjqNtMX"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9AE447A021D;
	Tue, 22 Jul 2025 07:21:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 22 Jul 2025 07:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753183266;
	 x=1753269666; bh=0bgOyG6TuzWtHUl8YtpWqaVzQpRqGlZItc9Y+aHuFxM=; b=
	wP7J2J7+/t8+JkpVwHVYkMfS633SxBQBfA2osEdW+WSvlRwIB0/K+SojZ//BdA6S
	wc6filzeU06PQvrnIdXORqRL91uwHmwruhI02BR4ql+LYwndpfW06sNv8F2VhM5y
	/rgy2OFDQ7pEFtTkokSTz10CREDkFEwYwfW6hMCQ1xLFzOWWCy89/p3fGvoGDOTE
	qUJjQmdjwP50xmCwyHVLkK1gxZKIIELqbzjs2oXrDsDQgBq5RN/E4MYYgkywCd8C
	z/DVdj0U9BEHJC2+vCQXjRDmeJfT5baG70ymBkfkQghrXnsI+m/pkzsSzblp5uyT
	IiD30KgbSJg1X2RiJ/7xfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753183266; x=
	1753269666; bh=0bgOyG6TuzWtHUl8YtpWqaVzQpRqGlZItc9Y+aHuFxM=; b=E
	XjqNtMXOjhFrhrXevhWP8Tdr3R8mGIRsj+lVb6IhCZwE5fv3tsoz9DvFHFUUg0zn
	264ayRZJfyiv6lQeCeCN1JKQ+3IbCdGqyPJe2SBdY1k3z0sb+o+cvDfhJIuobFFA
	lQdCXfcKWkFQ9BqErhzzbrK8J9QL+4BgVz2iNQGbE5DS0J/q7mxfCet7Vri0C1MY
	neFSJ4NgLAKIZyuFMS7cg1L6GXm/3j1oKnWYTfxld4Mh56LNsvedvef+ESwfZzo1
	5CHJ/C4xV5WWOHyuAgGAX800Ji9uzUiioPVyXXoSbovtI9EltXT0p8srA9SNgSFj
	YPkqmFLN8uHD0WMSS1NHw==
X-ME-Sender: <xms:InR_aGCieoxWOxnqgY_IF8rmTHN-_gmz73Vt4VLjW7sF1Df6nWFZEg>
    <xme:InR_aAtZ4iL_gvaXX2-bT_1SOaX7TwJ3gvrc4cnKpelNe2JjMn2jrIZxGxXQZm8Sn
    xIHSK9ZHaow2JZNsw>
X-ME-Received: <xmr:InR_aLYUXv7vRwiu2mWIKYG755yGok2JdJD9ccGx3-i3S2M_hFdRZJ8BgPebehXVgy9YM0_BWwoysAN529v6eSlcjnFg_D8e26OumRSWVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:InR_aDXTOKoU-_RekELiuFaF5XxX_8Suq4meq30IBHGCYF6sgGyYlg>
    <xmx:InR_aP52Z9C1N2KrgEv2vaUHrt8w8zSHRQbJDD6GAg7MCrKr5LYJ5Q>
    <xmx:InR_aOiQsoIE4emexStdZhykV3of_7qeNqe18PUTREH9_FAZd-Dafg>
    <xmx:InR_aGca6ov5TLdYDbcyzHWBg-jGkbd2eMaotmT8QuI8C7EUYU0sFQ>
    <xmx:InR_aDRVFoozN4dbnzrvdvQStV1bUcn2q7BeHn2AYdVtHjjNmSMlrXaM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 07:21:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1e4b67ed (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Jul 2025 11:21:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 22 Jul 2025 13:20:50 +0200
Subject: [PATCH 1/8] Documentation/git-reflog: convert to use synopsis type
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-pks-reflog-append-v1-1-183e5949de16@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
In-Reply-To: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

With 974cdca345c (doc: introduce a synopsis typesetting, 2024-09-24) we
have introduced a new synopsis type that simplifies the rules for
typesetting a command's synopsis. Convert the git-reflog(1)
documentation to use it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-reflog.adoc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
index 412f06b8fec..707a9b39edb 100644
--- a/Documentation/git-reflog.adoc
+++ b/Documentation/git-reflog.adoc
@@ -8,16 +8,16 @@ git-reflog - Manage reflog information
 
 SYNOPSIS
 --------
-[verse]
-'git reflog' [show] [<log-options>] [<ref>]
-'git reflog list'
-'git reflog expire' [--expire=<time>] [--expire-unreachable=<time>]
+[synopsis]
+git reflog [show] [<log-options>] [<ref>]
+git reflog list
+git reflog expire [--expire=<time>] [--expire-unreachable=<time>]
 	[--rewrite] [--updateref] [--stale-fix]
 	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
-'git reflog delete' [--rewrite] [--updateref]
+git reflog delete [--rewrite] [--updateref]
 	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
-'git reflog drop' [--all [--single-worktree] | <refs>...]
-'git reflog exists' <ref>
+git reflog drop [--all [--single-worktree] | <refs>...]
+git reflog exists <ref>
 
 DESCRIPTION
 -----------

-- 
2.50.1.465.gcb3da1c9e6.dirty

