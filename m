Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C17C26FD9B
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130251; cv=none; b=tT1a89G/Ipp1crfZH580g6e3z822+RQAcCkDXGH59JKgawqscATteNcMhAfdWWnKZYELMgLT2kjxKKmR86j43pp0A5QMcjw9tEcauFZolcEwdCPnqXGlH0jJLvUBLKmqbrHzJdM9713U7FIuiDjxz6/V2LnZzPyD0rh3XWLgJA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130251; c=relaxed/simple;
	bh=tBoANFTE3NvzuAGeByPRcfi7DpSF56B4yifQ0mAysaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ew3Ig8IOlUi0OSf1yMtRrdIYduY3yy05IPRJBP3qTYpbjXOpkOFe8j1U1CtYgpr0j4D93L98P1jbWeS+AMKEyzIOqPz9DZ+eLcNpajQZUPDNbM/cZz2FTxy690qVf6kG7+53/QpG2SQR0oZkDEsUbx5IUteBWrYXm+vkqQwtoSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lLYgxX8W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CmkGKAL1; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lLYgxX8W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CmkGKAL1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id EE9E61D00081;
	Wed, 10 Jun 2026 18:24:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 10 Jun 2026 18:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781130249;
	 x=1781216649; bh=Inyfmc159wrCYauRjPSa3eo+7mkWxxkYZbcIWkxkRaE=; b=
	lLYgxX8WMV8/kiAZyJTyJw9AqJ/Ps7r/4LTXPhebgVFpuftJ3POQ/mcrDWBz/iFE
	L/flXwLgXUmPTBiuzaZi5OjfHxwjuQbDRGS1HAmIXkJV9SGbGJlZgnO2H42iB2wB
	XcqWEx7vjoa5ieLQeEQCIkiV1yWrlYVICH0fYKUa2FGABcu7V/ar2HI0ZXdN7Jdb
	zzJhCDZXY5tYx3FvtmB3f+Ex6VlRia/pjnXKODsVDm/+5gwpIqfh7KJMmyutKtKl
	VjJ3BXfI8c9Wl/fyGpapxu9w/PL3CmMrNYAvGnTPFHJAGMMNVJVQFwn6lVBlHKrP
	r1F19hhC0SsE8Tpuns2oDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781130249; x=
	1781216649; bh=Inyfmc159wrCYauRjPSa3eo+7mkWxxkYZbcIWkxkRaE=; b=C
	mkGKAL1iyziDxskR/EKsBCWLju/boE++iOXVDZUYOTazM3/q+6SqnPsRj0P8/3Nq
	EhzLvMfGKdaHdsLZmSCQTpvLieWDB07xQXT4uc4Tl9Y1MVs+3Slj774/5IgiE3Qk
	+2/ngEcyDg/kITpoEqVERgP0gJBKW00aTht0gJsNYjN6vdR/mfcwR4xuo0fm2PTv
	w9NgTM6CmbNKK1oMogczdbBk6lQZPlz2xbpZx8pKYmdDTmoPPAGPXPQ4SqHK9VCi
	TYMwCWyee7n5ebRglqJ95KK8xHzovqYs8zRmyszipSz8JvXxhWiUoOfZlt8WMyrN
	zJ2j/+hL0jYtbxFkbYlwQ==
X-ME-Sender: <xms:CeQpaifyknRQ9PjM-8v2td4EXUzKljPFoXsthf8hXaN6U9zmv6xdVbc>
    <xme:CeQpaiPEp464xCq9O3DGDa_QcOdmX8gnkvZ8viyeTRXVlDxUCCc7blbYcEr880CI7
    Fe2j76JXVWjBYJyryOm5KZ9SHwgLyLnylXPakMebN4XgZ2J9XFHTQ>
X-ME-Received: <xmr:CeQpahLrMtajtaKZpOAhpWqU12E8VTciK7tYs4ZPzNsXj6vUiHd9VRyQQSJWh9jCrwwfAbfs01cqYri5bzNj77bn1Rr-sSCrPiaz_dThSWugTJolpGO8KM2Yow>
X-ME-Proxy-Cause: dmFkZTEuzp3KKBn7AMpNkiUqx7nkmzpOcQnlZKh+EjhB0tl2hcQWLy/Vp41mo1Uy0mK2OC
    saFPiNrE/21c3YyBIP8u6dc9vQQGza6H/29w5f3nyKbgA1rsGQsG5sDcuFQeWxO6SEacGf
    SUd544wv1Z7K/AfH/15jIj5T8TBXnTX01CztV+3qCw/WC+tftNgIHB0U5FUHNOUXAixbkK
    5E4pn5FkC9EzMPz/heteaHmUDvhWlMI7PdmSZQx+ktMZdvimnyepM/Ku/ivY4VKQSq4FYI
    JXOlW79tVbM4aor6rIneEz77lvoEhjSVUG0VhHehozL9cQSgZaF4nqqYWWwsmMWXr8IGCb
    35E80ZbbxQ9TvPztJBub7/yJG8QIX4XltxFq22ZsDB29gDj1SGhhovhDuq4jmJqf5VFUvP
    WJ7DbzJqtIvRPtn+VHNBW3+EYtkJ2R/e5KNb2vk2LXFov/VSI/6ROp36gnt9Y8ypZ11kPM
    SQK7Mrgaww7rIWdqQfVpDLTbvGxw9CD00hQBJ439P1S8111mkz7w7y3Iml51p/dUxVRMUv
    scaY2PdeQFLWrxIjzjXO9Cqr/y7wuq1nGiCY7WnOqROSUuvajRX5xE2ZeWTKlYwaGWBcG5
    B7wPpeGrdgDSDbTlqtZR7p95MfusGLlRLNmYSYmmSLHq4r3d2kzoXFyoTLMw
X-ME-Proxy: <xmx:CeQparGLUmsLSFvXcDFpsRWN0pF9NDygW8r9krowUc0pmOfNFWohmA>
    <xmx:CeQpahT-mApSIzGoiZLp8_qKU6R-9dVkIZeqbdCqAG4awwxUzFSTRw>
    <xmx:CeQpavERcicFmdr-IEVPNkSBL68AVCRa4zZbAzf_n2kJQXK6nY7sFQ>
    <xmx:CeQpal_ccKvEp3WcuXL_VPKo95hbzCtjvY9KswZQMdrShGOsHZttAg>
    <xmx:CeQpat0fZ9MRy0xQzNzmQ3z45lX7J6c3CGxSFWqYy8uYGQgBM96zmSgJ>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 18:24:09 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 3/6] SubmittingPatches: discourage common Linux trailers
Date: Thu, 11 Jun 2026 00:22:46 +0200
Message-ID: <discourage_Linux.8f6@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <CV_SubPatches_trailers.8f3@msgid.xyz>
References: <CV_SubPatches_trailers.8f3@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The Linux Kernel regularly uses trailers (or “tags”) `Fixes` and
`Link`. Sometimes people submit patches to this project with them.
They have their use in that project but it is not clear what purpose
they would serve here.

For `Fixes`: Linux has many trees, and applying patches with
cherry-picks is common. A `Fixes` trailer in commit C2 pointing to
commit C1 helps the cherry-picker figure out that she probably needs
C2 if she wants to apply C1. See linux/d5d6281a (checkpatch: check for
missing Fixes tags, 2024-06-11):[1]

    Why are stable patches encouraged to have a fixes tag?  Some people
    mark their stable patches as "# 5.10" etc.  This is useful but a
    Fixes tag is still a good idea.  For example, the Fixes tag helps in
    review.  It helps people to not cherry-pick buggy patches without
    also cherry-picking the fix.

In contrast the Git project has few trees (to my knowledge), and there
is much less need to cherry-pick fixes as opposed to either using
backmerges or rebasing all of the downstream tree’s commits on top of
git.git `master` from time to time.

This project does regularly mention what commits a patch/commit fixes,
but that is done inline in the commit message proper (c.f. the trailer
block of the message).

For `Link`: These are used both to link back to the patch submission as
well as with footnotes. In contrast this project has `refs/notes/amlog`
for linking back to the patch submissions, and footnotes are only used
in the commit message proper.

† 1: Commit linux/d5d6281a has “linux” in front of it since this commit
     is from the Linux Kernel, not Git. Example of a Linux tree—as well
     as an example of `Link`—is [2].

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ [2]
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/SubmittingPatches | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 51c308a89a8..5dc32128883 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -479,6 +479,10 @@ to be accepted since these are the most common ones. But another kind of
 trailer might be relevant, for example to link to an issue tracker
 belonging to a downstream project that is affected by a bug in Git.
 
+Other projects might regularly refer to other kinds of data, like
+`Fixes:` and `Link:` in the Linux Kernel project, but these ones in
+particular are not used in this project.
+
 Only capitalize the very first letter of the trailer, i.e. favor
 "Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
 
-- 
2.54.0.22.g9e26862b904

