Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632843ED3D4
	for <git@vger.kernel.org>; Mon, 25 May 2026 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719290; cv=none; b=ZALrorktW1jdF3Krcj8qFkKyIR/FFcsadhb3ZRJ3V/N4nAqDaFGPmxxRKMi39+orH9cXGWHLGxeLuGBoZNEAdT0v7bOG1gy+WUUSY46l5w+nOQBiHsED/X0grma6YmvaNTnWheE/jtpt6Z8ihahpUCSikZrUUOY8yiP4JTba9s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719290; c=relaxed/simple;
	bh=VKySGCveZKOcAi8Vhyic+aUuV3CHulpXpZ3/jVi1ZAw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GekPUb2Xd4delNw2M3I614YoA1M8kLPNivlg8UtePaIBG88ye4Xqhp/cWKrmibtcK5YSiv2k6+4n5THYrlxNMmSLsyJB7Czw6jmRoDBYcVYNph9rWBVYTRSplVjWkjZEWmuL+8FDsx28fhFtmN9oup9RKy593cyQwTOXHYkvo8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIdZuEkT; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIdZuEkT"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ca12973e15so133017956d6.1
        for <git@vger.kernel.org>; Mon, 25 May 2026 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779719288; x=1780324088; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eY4bzrtvBFgVxj/CYdLwEc/cPSxIHpFYjkBLaIQ5CdM=;
        b=bIdZuEkTVOUOSKD2VEINz3vSHrWWFwK1XGfqBFJCJmP6O+YrXoUOUWAHQGuWmo3qPX
         DY/2n1+qn86HvT5LuifEcsKEaP9Hh8dwkjBT3YFzmdvAwKjpqrPEXOce2qOY3sagOmJO
         Cch7Tn7ECT2oMy6v+Kr6x9qgA8MLA2/E4/zWt6XfmZqm16MjB76Sy//bs3dwOFADcwJo
         jgqov0mzPNgab2xxOtewwiRfYFP0/OaqWRATLRdWIO2DemaViXPeMOuZ7akm+enKO18w
         cDgXTOcoLDlDjuo97HszbeT1VWFbpVA2c2WYmGJBebW93Q+sVr647AXh7+UZZfwaC/Yz
         MrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779719288; x=1780324088;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eY4bzrtvBFgVxj/CYdLwEc/cPSxIHpFYjkBLaIQ5CdM=;
        b=lVJB2qxB/rWaha7X+NZB7iTHUn3/vRvCgrqHuxWweGR9UNnTBc6X73peRbgXIgXGPq
         fb1IpxW0FCMvGBG6Av69eeUtUXwL/2wL8jEtUThvbGFgoDUXeL5VNHWtmaUwiyDSaf7A
         KZeiFQDS0ivibQUOqIB7APFyNw0sf4SDxTLRZdXvXIPsTb+2zG7HpZ6B7kaKe1a27tWS
         0B9qZnyOC5ibjtwUI+5fM8XCEWxGsQkDlsK0mw/G4eBCpxugCkzCQ0weW5t1nrOr1914
         1TlzMX+HYQKtrQ90UVlH1vldxvQY9rE5ar+bhTuGgVoxUafiv0XADAa6iymFbN+ndC0w
         fr1w==
X-Gm-Message-State: AOJu0YzgZZ1vFB3GR5lMJddkdUxoVNP5V+/6o9kF1gTgv6EzlYbVLPzG
	3n2iaRr6CegKHPgKWSdqnTJFziGkC/PeQBQRvyEa7EH/hVxOf2YhHgkctfQ4Gg==
X-Gm-Gg: Acq92OGEqjYPrdgzVPScMrP8ruNdTcsOV2hkOY6W+cckFm9YP/kH/si+12eQQzjgmUG
	ClLBdYiQOZtu9PB0PUZU2TS8PFy3//fKyy8UhhlZHguQ/eQbLmC2hfayI611dcZNB6IeZhxKMbZ
	Jhj+on8J3ihR0wuSY8Nmpcp7Z5XkptcEzh70TK6yGd4Gl4gW58qCIZrRL/dFfaR+/Cp22tdKNtB
	irMFZ5Zcemn65ZWiEqdYPyJe/5bSA80oZKliIoy2i9SnROeTdVdZEfjBjt6qMv7Dq26FHXEH81C
	jiBBH0vMCzyPk6TNFOHUUIufTb9A/NGDffHyk43af/xKy3e4lhT/0TjmK+KCbjdRLEACvN6qeeo
	lnCclabxhTfRpJOimnpfEZFRjVMP3eWoospfPQhDzfehkijv9h/oRdIU5HyQWiu17OpFWvLPKXX
	zOrpfgsEPXtIpF/ayIi8L9x7o=
X-Received: by 2002:a05:6214:418d:b0:8ca:b44:ebea with SMTP id 6a1803df08f44-8cc7b6741cdmr226570786d6.27.1779719288228;
        Mon, 25 May 2026 07:28:08 -0700 (PDT)
Received: from [127.0.0.1] ([4.246.135.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc81316e4esm110667626d6.41.2026.05.25.07.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 07:28:07 -0700 (PDT)
Message-Id: <105f4646c2ded721c6f6ad69a5e72cf1201989d7.1779719286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2124.v2.git.1779719286.gitgitgadget@gmail.com>
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
	<pull.2124.v2.git.1779719286.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 14:28:03 +0000
Subject: [PATCH v2 1/3] object.h: fix stale entries in object flag allocation
 table
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
    Jeff King <peff@peff.net>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Update three stale entries found during an audit of the flag
allocation table:

 - sha1-name.c was renamed to object-name.c
 - builtin/show-branch.c uses bits 0 and 2-28, not 0-26
   (REV_SHIFT=2, MAX_REVS=FLAG_BITS-REV_SHIFT=27)
 - negotiator/skipping.c uses bits 2-5 like negotiator/default.c
   (ADVERTISED on bit 3 instead of COMMON_REF)

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 object.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/object.h b/object.h
index d814647ebe..2b26de3044 100644
--- a/object.h
+++ b/object.h
@@ -67,6 +67,7 @@ void object_array_init(struct object_array *array);
  * revision.h:               0---------10         15               23--------28
  * fetch-pack.c:             01    67
  * negotiator/default.c:       2--5
+ * negotiator/skipping.c:      2--5
  * walker.c:                 0-2
  * upload-pack.c:                4       11-----14  16-----19
  * builtin/blame.c:                        12-13
@@ -76,13 +77,13 @@ void object_array_init(struct object_array *array);
  * commit-graph.c:                                15
  * commit-reach.c:                                  16-----19
  * builtin/last-modified.c:                         1617
- * sha1-name.c:                                              20
+ * object-name.c:                                            20
  * list-objects-filter.c:                                      21
  * bloom.c:                                                    2122
  * builtin/fsck.c:           0--3
  * builtin/index-pack.c:                                     2021
  * reflog.c:                           10--12
- * builtin/show-branch.c:    0-------------------------------------------26
+ * builtin/show-branch.c:    0-----------------------------------------------28
  * builtin/unpack-objects.c:                                 2021
  * pack-bitmap.h:                                              2122
  */
-- 
gitgitgadget

