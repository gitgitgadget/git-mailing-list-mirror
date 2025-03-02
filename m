Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4F2169397
	for <git@vger.kernel.org>; Sun,  2 Mar 2025 20:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740948888; cv=none; b=bU36EJUWeHstXWXAGCMUr9k6Fkafh4LKwmONFGTxmJck5Hnqd2mD8MFrV91yepZhJn4uBTuJM/GcCuH+/SJBaGFu+pTcULfZ3TdfKCWUPop8JhcNKVBkr5a980KANQCe22UmRlnLst5iorUvOJ94Y6uQQ2yaR5w2wNI3xvU8tdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740948888; c=relaxed/simple;
	bh=+XmBjPrbtr8Pu2EcVgjEJvVd9yL0POBmR5XGL0IJ1ME=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=HKZt2/Eqt6UIQ8JfjoVpi0W8TxZfE2t1gHIsqfhPGV19s3PuiSeGXBtfqRY5nzBuO8xxzQJPC3QdY8UgE+KBNVLbG/gAUc8/00r/R9lQ2+HrkUGOHsfneUzoFKxnitPr2WnWRLxlXKfs/UJUTSiCYfnUOU8F2g4KNEwGQvaKUvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=UeyKYU6E; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=Sr6mcuf1; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="UeyKYU6E";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="Sr6mcuf1"
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-6dd0d09215aso27951656d6.2
        for <git@vger.kernel.org>; Sun, 02 Mar 2025 12:54:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740948885; x=1741553685;
        h=content-transfer-encoding:message-id:subject:cc:to:from:date
         :mime-version:dkim-signature:dkim-signature:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6fGhLcDFLyX7GfCaLODhr+/yIUNX1ryEuGJys20Fh9I=;
        b=I7WTTgR5FLRwhHQVFhxHM1ifMNAV3YqpIdNH+6RkPkVEKC1b7mNBx/I6g8+AjMbEdC
         LXLaSP2v9gg4V3AZlH84HmmMP/K1WPUTdGkyIEV+7Mfqdy9yQDRVsseTUR8U4kcVCFE4
         ZnRJEThv/GzH7jGXu8nlEbq1BBmqzPD2LrQ0WIoXI87Xd17NSRXo4+WWFZpIt1KxGwOd
         4MVPG8rAHh6Pfbmho2/3VI5MlUWjrD6v1rhwZAdjCt1DB7gicOv1aOxyu22v4FxboPUJ
         QuZkASOf7S8EY0P5wYWKFRuFYMRrnp7oulFxm4FkVipeq5lHEmK+CTIH7IAo53vKA9Ju
         ytVw==
X-Gm-Message-State: AOJu0YxQJ6dHxIoCS3AvsH0MpfXbScEqpf0sK7WhffIWKIAjQbaidAhZ
	hqAabw+OiCTj3QVMbqxEgz0G/UXgsL0BvE/ljYSIe6qAykkAIUaa80yGgdUfmS4HXyPm2UJpN/b
	DaXthRcmgl0L/iCZI+o13NHWdW8bGBQfu8WKomJMxa/ixUcn8
X-Gm-Gg: ASbGncs99r2VeMXnJmx2X8lCseeXaLx0eLiJJtj7MgEvx1ijYMZLmAO+AgXmvDZWo+o
	dmyN6iGXs+p+3ifpQArXstc553WNUdKCRc+hjeGieGZjOgL5Tpg4Z/k9X8DeIO6AGHGXVQfp1wd
	83qBfHE89oIoljPdba4EoKpJziz6ZON1H8hnR0XP61wrBiXSbgIJhPl7/MVD/sYKw87rs2A75m6
	qBzj16fiP5aImHbAab28Cur7yCAkSxVPZjwxOQc9C1CS9PcE+u4zfgaH05XtEyJO/X51+zvGNhI
	9F71b5bHVDCRSIip4S94sA7GluD8y6HdhC1TGt4j
X-Google-Smtp-Source: AGHT+IGtPh1Hkn8wM1xQ1sKO0ZeM1IroJ2KteSKWCWZJ0VU86nhNuLJgdGcuVSTmM5ujCmZ7OxCvbodWJ9I1
X-Received: by 2002:a05:6214:f2a:b0:6e6:5f08:e77d with SMTP id 6a1803df08f44-6e8a0d0ebc8mr191734896d6.19.1740948885474;
        Sun, 02 Mar 2025 12:54:45 -0800 (PST)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org ([2600:4040:52f1:f606::8])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6e897604364sm3511916d6.27.2025.03.02.12.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 12:54:45 -0800 (PST)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1740948884; h=mime-version : date
 : from : to : cc : subject : message-id : content-type :
 content-transfer-encoding : from;
 bh=+XmBjPrbtr8Pu2EcVgjEJvVd9yL0POBmR5XGL0IJ1ME=;
 b=UeyKYU6Eskf0Fs8ndKrt8pbrZsahX0e5Mr7CWlvihpwiRCKWv/N7oG91HG/6cTGibczsl
 /+jvHj0mlZ+6eHIDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1740948884; h=mime-version : date : from : to : cc : subject :
 message-id : content-type : content-transfer-encoding : from;
 bh=+XmBjPrbtr8Pu2EcVgjEJvVd9yL0POBmR5XGL0IJ1ME=;
 b=Sr6mcuf1URzZ0jRGfUs8CSi29Z1P66z6oqxNxtbsBlODQnMrlwrSgPBeYpEvBqdKX8QR8
 EvhsBqwHTSOpHmnsOp7Q0L1qG6qa+MAT7xFcfg7xdQPfG0ZPOHi9MYtULTtGDqJBmbUxgvj
 JZDsl34rBHbCXkEo1vthXmFyXStL2wTD1J5yxVtvutCHawGaZ7hnR2igrKhAm3TwwK9EkjL
 +5VyZg3Q/eXATOb7foi4S+bH3F6C1tqE10naXetw+9rm4JF/vZktshmubsd0d/6Mja25BVB
 e0w3IWFYs+3o3a/npqfJTVG6fLSTjiu5tVfAxC6JpdTjy/Brm4+/W/6IVs1g==
Received: from webmail.mandelberg.org (mail-web-d031b246.virgo.mandelberg.org [10.0.6.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X448 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4Z5Z2D4V6cz10df;
	Sun,  2 Mar 2025 20:54:44 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 02 Mar 2025 15:54:44 -0500
From: David Mandelberg <david@mandelberg.org>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, "brian m. carlson"
 <sandals@crustytoothpaste.net>
Subject: [PATCH] editorconfig: add .bash extension
Message-ID: <15fa4f5d838745b5b05248b44aa16a57@mandelberg.org>
X-Sender: david@mandelberg.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Both files in the command below appear to be indented with tabs, and I'd
expect .bash files to have roughly the same style as .sh files.

$ find . -name \*.bash
./contrib/completion/git-completion.bash
./ci/check-directional-formatting.bash

Signed-off-by: David Mandelberg <david@mandelberg.org>
---
 .editorconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.editorconfig b/.editorconfig
index a3c578a43c..2d3929b591 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -4,7 +4,7 @@ insert_final_newline = true
 
 # The settings for C (*.c and *.h) files are mirrored in .clang-format.  Keep
 # them in sync.
-[{*.{c,h,sh,perl,pl,pm,txt,adoc},config.mak.*,Makefile}]
+[{*.{c,h,sh,bash,perl,pl,pm,txt,adoc},config.mak.*,Makefile}]
 indent_style = tab
 tab_width = 8
 
-- 
2.47.2
