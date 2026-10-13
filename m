Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D880037B02D
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877010; cv=none; b=Z1gaWsAfjVM122c+YV5/b5ALIQTfet28TI1aBPTtY8qLWvfgyEhJmgA+5eqGaNIWV1FMwD9WY//gxP8D0epXWz0VPTO+39EEdZuILgNl37tJledSBJHZjTdLHUiBAq9cZ0IUt5I9yLdBWs0tMsGorJc9HdiP46XN7kfNaLmwRX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877010; c=relaxed/simple;
	bh=PSIn2NvkXJ+sxTIMwzUtf5SCYLoyX0FUhJp2hgVb9Zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LDo6mWR5cfsKswyU/U1gcx/saBUOPrWHzCUmkmIQZZLu4hnWkO9ftzLn5U9vlsoxxDBtQSOlwhkuce7WitF+jT5ZlkNEwZg/JzUFql6vnTFxQ1B1j/zFa2xJxjbJyJ5TQCWSo0cFqhcw0N7vEI+uHLeCFjDkkza7J7id0gkDwZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cmv8zats; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UmP/swbT; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cmv8zats";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UmP/swbT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 131C8EC0400
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 03:36:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 13 Oct 2026 03:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791877008;
	 x=1791963408; bh=UQkBZAwBmhkgCJVh0q5Fo+1NIW5QW3+wGHZIJjr+Ga4=; b=
	Cmv8zatssaJYRl5v2HTzVY9G/f+ncaIpnR7XFbAXa33Fg8ovTIBBdUVob6e04Rrm
	bDXxqm9rauQUs+onk7TG8r7Z4B59JNgmriNwbIbOIeglVvXbpTqglXdx7ji3AXzT
	D1rzYznNQBjzGCqqRBf9bSkFvpHJF+WOrd83LXh9rT8dz3NOLGbQXil3XJJ4yTNG
	o/9Gn5UpTYKoGsvIufB44JtvNoA79MjCsJxgXhI3ZCDrfyvF51oVMwDdz5zNvmja
	S2vGZbjheRt/xRHSn8ilb601cffLD2mi09eA7aWYJEF34oxhJC+uOL7ziXbxylsP
	A4civkkdd7Y8ddnB567psA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791877008; x=
	1791963408; bh=UQkBZAwBmhkgCJVh0q5Fo+1NIW5QW3+wGHZIJjr+Ga4=; b=U
	mP/swbTMyqpuEZIJ1L1pTv5ZiGnB3pgP/H8Ndnl4gMjZHZ23MEC47uWgYa3c/6LT
	iO1A7JeFZqoOHKuE35XzGaz+xIKB6+v6pPgwbuQwyHyEcIGxFt1tNhnjLyiv/s0a
	HItm0P0aVGHI/nns0qqN72Hzvk0ItaCzR3rp50Tkj0MALpT3Fa66zZLNVWz8Gv3f
	GAZ70r2uxqMVcSv1ktYYomydY6u0k+cDcbhVsRMwBf9LqFu9bHTylq3pT5AWM46L
	5QioPTw+ICCIoPFZECH15d3kYdptTGUhvcLt95yAbgBXXyha6JZnhVVvzMBshCso
	niDRVraq8njlNR+NdSAuw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791877008; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KUpQhSeSFialSJ/Y0Ak9AJoPSPWhVwq8UIipK4h8e1czgeW
	yC6sICPEoOANNuW7hLd5HlO5TegJ31QO1mTBL5wj31UnlunzlY0EpGzrjOrUdMZ1
	OYiVTnUZSr8NSXnjCLmq/VHKJjalFiyM3tKi3f5j891P6vJ9lbvbah0079IgKeJg
	D1yPiViDkejAyOymclSHE3U7KsegH5dpnGTGqtjvpBJA83iMMIoixCbN7R/6DDLe
	Dtv3QFRzwOCVu3KM3JXl/4wNqxY0h8Njms/vy+X1ZRFE4IEddv7bh3oWWof6GAsp
	JYLhiy8gEcfTH44z47kmotunkOHD62S+w5Akm4g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:NBgPtupdaljbDoJ3nY7bR9DhQQ3SAWYJVv2QLSwIAlc=:PSIn2NvkXJ+sxTIMwzUtf5SCYLoyX0FUhJp2hgVb9Zc=;
X-ME-Sender: <xms:j9_NahQg5gLps7dhEwgvtXKI1XiJIvr5ou6lUZ7-NXczcsjZFu2NGA>
    <xme:j9_NaiOYD5lmWQmdNuVQtX6Rtx1bp6bpuoBupbIUSS6U9PVBrd_jLFh85AjSNKUZJ
    OMOEISsosOkm5oso810twWPzrCSnMetkxJ0coPnXSJow0UeWyQiPwM>
X-ME-Received: <xmr:j9_NakNBFf3OT5jsYgubmC1fw3G9IbmqgBUY2GMsvAwcqwkuNRXyag>
X-ME-Proxy-Cause: dmFkZTGdZSgd9syDqOvlhCW7goz/MOAYCu8RwGVzsPgMZPawd14CufpCQ6GG2lNJY6dcJy
    LOqI6c3NBn4TggXf/HCIF9GxwCAlUbhvQ+MOh97mATsxWEm/Fv15nxqMzJXw7ZE5SpmpDL
    I4CTkE7shBVWVOLKssUz9cN3WTabhERQaiHB91xQpEmN0+WAXRkMtn2+se0ZzUMMdG0ge8
    gK/IvN+Gh8iBvI5gKoe9WdlOcme6QZxLgiqw1lT53Fv5E2HF9G5dyRbWcbjZWzi/MPciEv
    LlATOLtqd1NQR/o3LQ6I2SplWBbvdy8E162xrDVIZyAmeWbY79mZziMFyIFQ+aSU3Wg4lR
    I9oO7/Ok1aijHLfK62QDD2C/bLZucxxvakFkipjPL97s26tvCrBpgCQBTb+dqAjX4r8uwu
    Aa4k2AyB9j93HEHBcIZAmEGwTJzVF1WuZGLOD8/WI+oxuOEXUMQDkUUW9K4YH8EO1KUgIn
    D81L0ScMZCG1lS/itqJrd/QTeu2Vb+t26y+pyAQGSj25Q61IW34QUqqMRXEDYWqhzeKT7B
    Uft/ZdfEDe0X+FnNsWmNehmHmd7aETwRT9o5OtlbOKKaia3ZtKuTLuYXxnkQ1wPtVeDs6n
    yeZ2EygkBtaVNBO0ig3OQTcjunDkNTV+Ea3/pn1UwUH0+NcvUuCHp4aaYAzA
X-ME-Proxy: <xmx:j9_Nait_PQcQOQh4C_aZjKSGFr5TZ4azoJFD9VYRE0tWWWGLykVJFQ>
    <xmx:j9_NauVCdUUKfMRxsXfSG5OMHWYPMebYuxENyg8oIEl2IiRn2-m8cg>
    <xmx:j9_Naqu6tDjfebWCNKQtnXNbPHPsIcoiJMK_JD4TG_kaZ1CzYEy64g>
    <xmx:j9_NaqUmIFIZYDCtHw1aeuL7IFNgtUlb9Kc2VleNgXTyuKqNHTtuZw>
    <xmx:kN_NaieEYJz5uDgaGKHD8aOgqKJGobbfxdzPw6enfnHrQ84kiNksTscs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 03:36:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 504f43a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Oct 2026 07:36:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 13 Oct 2026 09:36:26 +0200
Subject: [PATCH 2/5] odb/source-files: fix performance when streaming
 objects with alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-pks-odb-files-alternates-cleanups-v1-2-b7030ff2b26f@pks.im>
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
In-Reply-To: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Wolfgang Kritzinger <wkritzinger@atlassian.com>
X-Mailer: b4 0.15.2

This patch is essentially the equivalent to the preceding patch, but for
streaming objects instead of just reading them directly.

Exercising performance is a bit more complicated here as streaming only
really kicks in for large objects. Furthermore, I expect that the impact
is not as big as with the last commit, either, because for large objects
the time to stat the file will probably be dwarfed by the time it takes
to read the object itself.

But even though this is probably not as impactful, it makes sense anyway
to do this change to align behaviour across both of these functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 9268f5aa9a..54235821d5 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -462,8 +462,10 @@ static int odb_source_files_read_object_stream(struct odb_stream **out,
 	struct odb_source_files *files = odb_source_files_downcast(source);
 
 	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next)
-		if (!odb_source_read_object_stream(out, &dir->packed->base, oid) ||
-		    !odb_source_read_object_stream(out, &dir->loose->base, oid))
+		if (!odb_source_read_object_stream(out, &dir->packed->base, oid))
+			return 0;
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next)
+		if (!odb_source_read_object_stream(out, &dir->loose->base, oid))
 			return 0;
 
 	return -1;

-- 
2.56.0.212.g129ede20d9.dirty

