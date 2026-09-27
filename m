Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83FE35A39D
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 07:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790493368; cv=none; b=TPEJRHGFnkiXvY+ZX64BkESv8cBcpB2fETZDsl3qMEuVjATtog8WBBX269nDy1h/n7Bfb3AG+cOPkwpp+QKAZDQEW9759zsLGwWLoBqKAr0L8/nhJiMIzpxhF7TPNp1M4b6w3EeFOrTlnKNJpDEa1XuauRJH66iOYjvFr/uEhwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790493368; c=relaxed/simple;
	bh=iK7ijIPTuTuWPWSITmDjzTFaDfPAsFvpquPTXz6e+3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CEhiD7WXfIHPNBiyqZwEnf0yHl46TQ+9q7nmqU+onzILA2AnZApiekbb2eWkOH+y0leJKLDk9PFspngNVsQ+LpO9ff8fK+pBb/7+h4gaBFh9sIZT3KhdM9Iw8KjZvfBSIVffX8Th92RVZ2/LI0ZRdiE5yQG8Lz+aKgDyGnu2x/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mluXnIqJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nS/zkv+Q; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mluXnIqJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nS/zkv+Q"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id B5CFBEC00B3;
	Sun, 27 Sep 2026 03:16:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 27 Sep 2026 03:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1790493365; x=1790579765; bh=xB
	omwR4HJd9sVHSwuvkQ+C3pGCnwgwz00O6GVMaSTN0=; b=mluXnIqJ2PCl8gZmCj
	UFpY48BfDitZHMSPzKnyGVBgZnRfrpNbcXtM7sPuV3EVR4lWKJ/pBssmxVPFwxT7
	NyXWLjLTVfMv7Q/IQ22fYi4lGR2E44EbBvXdsM9At0dCL2OiHCJ3PGR/nWW8bRMG
	rTUk1Am6xYDv7DvgKVvQn/v0DoIYnUwsogxeeqRHQoT9oPM3YwsO5gMbEY4Wu3Mh
	2MkK8p5cf/8o4hm0ywEB2YmhMUIaAw1iovLbc/V/Ywo9rhjJKZC9a7bo8z85XanW
	nPcjVs6sXSsCjpxk3PtMloVdkudzjrrr9YV0FHA2lZ+mQBTpptJVb56SKetDbUhU
	TmqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790493365; x=1790579765; bh=xBomwR4HJd9sVHSwuvkQ+C3pGCnw
	gwz00O6GVMaSTN0=; b=nS/zkv+QqtCMkA5DOBRpvoqWinbTqBd0WRSZq/dLf+Lx
	xXkCZlIT3YBKNkk8LelWsJWq3sb2M3ysMBqLBbfkBFEk2wi+QmVjOqVEjAJMpqdF
	SKbDQumIwyCMPVa4b7sif+S9v7Hi58d/ZhcRgh18wjWOZ/fdXN4x30l9/JtKnF4S
	VxIV+zUGg7b4mhf3JJbfe5YXzx2S3shLE+oP6/a3vfhYhqOibrA7RyuFQQaOopfA
	fJ7xCpzwoq62nmlfnRd+lCssS6HU1sJ79eHww4hJwfWlCRoY2TDfM+ZugpVBntiD
	+WgRGKGj/WbnzquDdmfVpnCJ/qix83iYuoB+nwFI0g==
X-ME-Sender: <xms:tcK4aqe3A6XwJOnoAgHBXx8_y4t4Ib3aOQAqxiaoWJOPf5bgB4OrkdM>
    <xme:tcK4aqPbHJIyyBSQvR7330NDSdyZfPS7Ptc6NT5Urq4mXChTwDOm1oQe81bVtzM0U
    B0qhJR-iJZWjcn0OkvgUvavUOlbB_9sTpjlchieLsNJfCgURJSleQ8>
X-ME-Received: <xmr:tcK4apLsKiydQb0mklWOm-bKmqwaLd2Y_nV8vAyw3nZ8m2ZFwuHFYhoNnsPbli8GyjBLb0FAsejXF-JfenRZm0XoH3MXlLAGKoMvyP9EcYf1mOie-cF58SE>
X-ME-Proxy-Cause: dmFkZTFNGcdCDO+n3TxRx/XcEuN8MetRMRfzvo6NwVuIoCbS5xWES6ZdowUXfjzq1F/iFm
    UXR9Sxo1XIKlkvITEa/eRRVeR4ZW4CgAjIgMrDq2kZ/tSCi7Wxfwyn2tMOGZOA0zfgI/yX
    bX+jyrwydzZwJeJBdNgRWRr8CyEhvv15nm9fqiQf0SGjl5Kv6KdmXE2KWKP1YME/0wqNUQ
    aVeI+1ZpYbqB5NJu9tw73teorbnw6DEtk5PO71MB2JxRV1cCB1Lq3jIXUBRGD6WoV5X1nK
    Rq8RxT0vHTuLI6JFMtZg3/guRRSv3k2u73//C5x6EVeoY6RR+XKaHoov06EaNB9Vg8OkPS
    ewvlPx9p0vTTFZ1Y7/biNLGAdp08qLzbgtZju9muujiTCZuTZePwn5+8dnOLTtSL+NYlhI
    YOJknkUnRpQ56xSB/hZIaZw59oqIdv67pg/FbpMQUMH95TcGolC9f0HtFdICYcp94845Mh
    z/fI3HEuaiiD9ZKelXNkQuCJ+neRaRshiFG22OIxXo7sXHYFS0CAi+u6mSsMUKP2fuXlYC
    aJszFdtQrGXaibCjP1NRnQaktczGicNO6qRlqTYpVb42bfPyfn4BkaEdZFit2KDXsG74Fs
    wzxT6p6AEEaWJm8M5yWD8qofrmAMwOnXWQsfvTd7WBkKzACsn4RO9ELaqoZA
X-ME-Proxy: <xmx:tcK4ajEvRDnpjK2JyJoxGSmSkZQG_aiq_DbeD7X1mPLk9tcPF-4Mdg>
    <xmx:tcK4apSbYI38OGO_y-M-WIHfJY-tmv5AaNymRyNpRez4oq3zq0mB_A>
    <xmx:tcK4anEh8V8tmTvYpW3BMtnq4uOqC8ESNkCmeJmvHcMbLsIkcomsPg>
    <xmx:tcK4at91dytvDSvigulaS4KHGZhihh2xy3lMoIxv-l80GY-GyR-1og>
    <xmx:tcK4al2lKOP2_8R8IoE-QAR3jic1jdWMuSPbs64ODl-cmzKn1hxtTJUW>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Sep 2026 03:16:04 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] .mailmap: map Kristoffer H.
Date: Sun, 27 Sep 2026 09:15:20 +0200
Message-ID: <mmkh.cde@msgid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Map my email addresses for Fastmail and Gmail. Fastmail has been used
for some trailers and Gmail for my first four commits.

The `code@` address is my canonical address here both for commits and
for trailers. I recently posted about that preference.[1] But I can do
more than state my preference, namely to make it possible to look up my
preferred name+email pair:

    git check-mailmap 'Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>'

Which one can use as a trailer command via `trailer.<key-alias>.cmd`.

† 1: https://lore.kernel.org/git/add1abaa-5d51-43dc-9907-d6d3851004f5@app.fastmail.com/

That’s the only motivation for this change. The Gmail adddress is just
for completeness.

Although the proper long-term solution would be to fix my domain so that
Gmail doesn’t think it is suspicious anymore.

Assisted-by: GNU Emacs
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 29b48905327..3aec9edfd16 100644
--- a/.mailmap
+++ b/.mailmap
@@ -157,6 +157,8 @@ Kevin Leung <kevinlsk@gmail.com>
 Kirill Smelkov <kirr@navytux.spb.ru> <kirr@landau.phys.spbu.ru>
 Kirill Smelkov <kirr@navytux.spb.ru> <kirr@mns.spb.ru>
 Knut Franke <Knut.Franke@gmx.de> <k.franke@science-computing.de>
+Kristoffer Haugsbakk <code@khaugsbakk.name> <kristofferhaugsbakk@fastmail.com>
+Kristoffer Haugsbakk <code@khaugsbakk.name> <kristoffer.haugsbakk@gmail.com>
 Lars Doelle <lars.doelle@on-line ! de>
 Lars Doelle <lars.doelle@on-line.de>
 Lars Noschinski <lars@public.noschinski.de> <lars.noschinski@rwth-aachen.de>

base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
-- 
2.55.0.793.gc667de3f2c5

