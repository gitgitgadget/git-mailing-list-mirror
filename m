Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDBC3EB0E1
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932700; cv=none; b=qqBRB9XwkIvpdNticPk5gSlInMWIQOix29P/tw1Qvrl4JnpaCeA8rFQ+tPjtTuMMOnZpGAu01jt3FMXDQUtdhpquScOwQdX4/U2R2DDKNIPeed5CHoU6+/68u5K05cJBBJKPnysmvplCcs4bfoH6ioRGDKRCaPZeZAw+k2xx5NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932700; c=relaxed/simple;
	bh=vtonoNr+z4xp1FTtz0MMgvAYwH8wBbjoHZ1KFtZ3yDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=udA+yRz7lO3mQq1PV9Nh8a8Kr/bIQvtZ7ZGF7lE2ghr/NX4j4/QtgsWwxTg77NKKBmSHoDID1xKltVOtI+/1fwRuNmYkvg/rC1yzoaQoFidqVX6/of6Ol/C+Tbb5lJdlyeOCGtTljT6XYSnwp6unPu/xOJMLNuBViUBNBFBrY2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqiAeGKl; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqiAeGKl"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-664c6304683so879245d50.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 05:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785932698; x=1786537498; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ce6Cqn1tkZtnaVl8coU2yM6mw3a72udN19U8Clh1oMU=;
        b=gqiAeGKlKFlxlXHEt7zVuA7Rb01RyrAtL9XbIjw9c56xgFpAIpRiQH3EWzCjVYTmB1
         pJdG07Zc0bVbz9MiDGcU5p1lYLY3AoSFYsBtokovQuKMiX6XPdh+BQ5j3MXtjIXv4PTQ
         pyNr+BQKOthEPMs24IJaCKKDzQDNqJ+3s4zyAvro6HZ1zZTzRg8aDUZ93T4ScQ1DZCLb
         7Gw1Tr7WavAs0LKyIZuQsipcuW96fT1UXz2UWAiTmyMsogN9TbZVKl0HoLdG000odQCe
         ljAIwvymNl9Gq2oLUz37lg8QRor6ywvZMnpOv/CbUh198PdF+YPdUQJ+4YoMIS37Pimb
         82kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785932698; x=1786537498;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ce6Cqn1tkZtnaVl8coU2yM6mw3a72udN19U8Clh1oMU=;
        b=YGm0IyUSLuiYOTHnwISkMaiupwEivEvV9qoeEfGY4WUCB5AUnkK3M7VZxjj6rG2RqK
         xbR13sSuJMa10QK1vex4vV9IwbcUHabBFykHfPCcOvNFSJ3xgkdw/0Nsac4++LvQnhy3
         Tv144rOi/f0cD+Pynf8V0HrffXhLl59IHKmBpYRTu4PAAh3QIgRN1MBQKok//Fq2vzza
         TaR4nceXmduX0oHT/C39atqSDm5dxZJH/ZP/XmMsEYqmIVAssXPnE44DL2iJFSvfOuAg
         Le98ACMILAvNMnKHcEafrj8rX6JjmDCXcfdbiQnZ7RYHMLhGTrHkTLFTj3Yn9vPr1xeZ
         qCOw==
X-Gm-Message-State: AOJu0YzDabI0+ee/us5tApZucKA8b4gDG+oltEWfHEIYj/uOPAx7atbZ
	RcKXq6m/3G7rRcFfzSVRAFa0CUwQcBNnoq3E+hWwMRMvXtduzJC4sV5uxBWI0ut7JUE=
X-Gm-Gg: AR+sD11QvDMtYFiNFJitoSvgRdi+RrrFxWFTcy7bGW9itgTPAstup9IWWHCFPRXkO6b
	/JL5LUkWHxvwUvPchAy36UZTdimMX1+evA3KTFstkUyxTDAG8qmUNviMrWy+BRZt0LD0H0cywFS
	ZXljqYzGb3EdRhtJQDjIhyYgit4Lt7Ed1lVo5+TMRLL+/B4FMvWTWyLmIGX7X7mgCi1i9qrsR2k
	96BiOza4gfRINcv6gaGbONE1+x8994CPSNRZnbn4zGHtXhj7/kzUXg8dL5PN0LUlMth94GBBNhK
	Kect+gzjDoCFVfzSwKmZ01SfuWL4LX/5SDL/mEY+79FCwWXmqLOBb1QX60BDxAL5fDw6YTCKUU3
	Wgotf7UJeZZ3CuiZ9yPg0rKJPwSA7n8f5OBgTG+R88ytNZjsjvw/0Opo9UTaHmLSiytQh15iwM4
	fWvieX7R3fU6a0b0Nl1o0Og0CbxtO2z9Rq/FYUp5eP3jtQr3nCitKh3ubX8GIsmBbymHlpcPRS5
	574intmTyNkMVtcYR3dcsHBNLBbaoy2D3dHnLnet36TvVy6JDF+o5sseTveJm1bZBqKRO0IMCK8
	111SDPXZHQs=
X-Received: by 2002:a05:690c:f14:b0:80b:bc16:8a2a with SMTP id 00721157ae682-8202297a72fmr31870687b3.36.1785932698227;
        Wed, 05 Aug 2026 05:24:58 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8201326bb32sm19264127b3.21.2026.08.05.05.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:24:57 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] mailmap: change primary address for D. Ben Knoble
Date: Wed,  5 Aug 2026 08:19:32 -0400
Message-ID: <f7756811449494b378b5e82c84f46ef77672b8cf.1785932372.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.340.g8e2bf96aa5.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ben uses the +github GMail trick to identify emails sent to him by folks
that found his GitHub profile. At the time, that also meant he had to
commit under the same email for GitHub to recognize his commits. He has
since found out that GitHub can be configured with more than one email
for identification, and he would prefer his canonical email to omit
mention of GitHub (where it's not relevant) going forward.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index f8ede075ea..9277f4d5f7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -45,6 +45,7 @@ Christopher Díaz Riveros <chrisadr@gentoo.org> Christopher Diaz Riveros
 Clemens Buchacher <drizzd@gmx.net> <drizzd@aon.at>
 Clemens Buchacher <drizzd@gmx.net> <clemens.buchacher@intel.com>
 Csaba Henk <csaba@gluster.com> <csaba@lowlife.hu>
+D. Ben Knoble <ben.knoble@gmail.com> <ben.knoble+github@gmail.com>
 Dan Johnson <computerdruid@gmail.com>
 Dana L. How <danahow@gmail.com> <how@deathvalley.cswitch.com>
 Dana L. How <danahow@gmail.com> Dana How

base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
-- 
2.55.0.340.g8e2bf96aa5.dirty

