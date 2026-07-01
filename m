Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97773446AD
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889485; cv=none; b=PMcb20SuPQvqt6QlfvqHPnOlKXJ8mwyt1KCmvQ71nfUgI6i18oz+czawKPACOSVOOXy5352AsSGc7K6D86utmt5yoDN0FzeeLj0t6Vpfozh8K2ykDoQx+XNyKaVZ0+PXt6SeAzF3oCcHOwF5thEmM27K8iJbDej56W5IhQambeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889485; c=relaxed/simple;
	bh=Bw+j1sRjQOGi38LtFdyYr4DOgzrm05WAdnNccMl2LOw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aaczKFSSOGr4blQJSp15EhMNKBaXNu2DQn2C29qz3C3WYfmHRO01/da9UpMGoDNKyjlLIdmgwaz7/84quQbKF15NYhMWzNiRUHkzrp5uEa3Tztn/rNzCmog7O7vQ0hgGuH9ndVRGJgnilWpZK5UbibEoHOLNLAHMJ8Z8HXPU2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmT2/g49; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmT2/g49"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8eabb1a9378so2813986d6.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 00:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782889484; x=1783494284; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaRw6AR0DhUSgZvhKZ4wS5CCV1AQoL0l4uBGIwlvIYk=;
        b=cmT2/g49CQPqVMLqqsHY5IqKRXjdRQV/y7YQN5thM0WAU38H1BW+3uaHZ4CTRTTeOW
         fTCyH3qpmNRttvot59ZhtFC+oNwotPdMub6Ocr7RXVA723AbaK+oREmJZDXg/lvSgjjH
         h2uWcdRxcDEbXc7VviQwHXq+lyzQnb8aQ/0dtnL7dK3z0L/KWUIsF5rXpc4eO4gaYuHo
         S/AFpQ9Zn//ms6+L6b+0GyzrZBhm/1aKGio5c/RazdsRGoNd3KnQ+yaNiXLLIl8Q5NDH
         4HAw3kaG95tqtel/H/yJPq400nwMKyVTUs+Jm+WfZ0kTAdt8olYp4gRZ2PnKFfBsdDfy
         VcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889484; x=1783494284;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UaRw6AR0DhUSgZvhKZ4wS5CCV1AQoL0l4uBGIwlvIYk=;
        b=kLt1QkWUa/2EFM7JGPlPEoXFIN0XwN4kNn0Sd4ibQRBC9eD4Xcpb1ieaGTWAqAuaBo
         9qlq3x5eXIjubjfk0tzJjzRASICibwhOxHJ8bNYAjRsnJDuXf4cIl0cMa97yH9zYcafY
         Oq+VdLYuVjrEDynVqGyKwLgwLaAUIuyJSCkD1sFYS+y4XyMQwJ9cVvhtZO51WLwQjCwb
         yNGSqZwkDPdk9AHnL3BaSVQxNIfcgbtAqx2fIpyCvEqVQ+4zybyWFsAnz8epYVZTvYc6
         vgUzptdBVMzJ+mnn6sKG1ZB6lHHT6Y74aX/i26aXLZZMR7enmPEj8q8JJ+AvtWDruY/s
         y/DA==
X-Gm-Message-State: AOJu0YxMHqwV+53C7BT3C8SPtPtrao2McBOn1qikdJEdjNaMwSBm8QIN
	Bvlo0KVa0UitEsfnTpXDa7u6J0UmgCMX1e+rsjBpNbLKnsUYS8OhleIpRWQC1w==
X-Gm-Gg: AfdE7cn/XFIu99nvbAsaMuWcoEY5/7rClO0FER+X9xlyTkOxHefhPmMRKcBan6b++So
	uGYbGno6F0mc96vGZuoHpGS5xjRXCC8jatXhZQRR6BCabzWiXivbOTTlADOrAMotTlhzfDYk32I
	f9+pa8jp4TFBiGOhREgB6KSi1WAYaMFvxxPnm5SITlUmQahUcm4pBL8zPgd2+5PBRij3kyjCpDW
	TbvI78dG0HjrlUExZy/4WrxkNgK/Xum7YuWsYwiVvKE3sBslA8elWgv8G5UxANq1cEsENTUTyXT
	eoJmeJ1TAUPc2zaDSPPXwhFMlddC+xgpZbDaUyshhT6rQofckchzT8/HrA1yDWx3s8RDLby/i5F
	oMJ9h08tx4SxddxgzgXSD9iwoRPJnlagxcSNSCprErZlFk5h7HQ+zynFSg1zULtTzTwdir/OAOH
	2CA8dhd3yT97f3CEKN
X-Received: by 2002:a05:6214:1c47:b0:8ed:1887:426e with SMTP id 6a1803df08f44-8f3c7d76b15mr5094916d6.24.1782889483733;
        Wed, 01 Jul 2026 00:04:43 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f362189372sm13809336d6.47.2026.07.01.00.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:04:43 -0700 (PDT)
Message-Id: <62ce03454aa1928edd8fa538e0600155629939cd.1782889472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 07:04:25 +0000
Subject: [PATCH 07/13] dir: free allocations on parse-error paths in
 read_one_dir()
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When read_one_dir() encounters a parse error while reading the
untracked cache from disk, it returns -1 immediately. Two
allocations made earlier in the function can leak on these
early-return paths: ud.untracked (allocated at line 3846 when
untracked_nr > 0) and ud.dirs (allocated at line 3851).

Free both before returning on the two error paths between these
allocations and the point where they are transferred into the
final xmalloc'd struct at line 3857.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 dir.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 32430090dc..23335b9f7a 100644
--- a/dir.c
+++ b/dir.c
@@ -3792,13 +3792,18 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 		ALLOC_ARRAY(ud.untracked, ud.untracked_nr);
 
 	ud.dirs_alloc = ud.dirs_nr = decode_varint(&data);
-	if (data > end)
+	if (data > end) {
+		free(ud.untracked);
 		return -1;
+	}
 	ALLOC_ARRAY(ud.dirs, ud.dirs_nr);
 
 	eos = memchr(data, '\0', end - data);
-	if (!eos || eos == end)
+	if (!eos || eos == end) {
+		free(ud.untracked);
+		free(ud.dirs);
 		return -1;
+	}
 
 	*untracked_ = untracked = xmalloc(st_add3(sizeof(*untracked), eos - data, 1));
 	memcpy(untracked, &ud, sizeof(ud));
-- 
gitgitgadget

