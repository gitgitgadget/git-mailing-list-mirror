Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EE544605C
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385494; cv=none; b=unTFhJUw++LyKlXNxdX/LPZrF7TILhr5Nuk1jm5HYjCpEFkGfiFEGBLTEDEA8kpS3EQmEnzqnCwnxo1HWRM9/xQq/PQZ2hmduD68gtYD6Nb7EThObbZ8KFTuxt1Vb9GRNsJL9dWcigwN3yksSBp6p+Z20HCIa9DKsh7+RhBmWD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385494; c=relaxed/simple;
	bh=pQYue02gxp0w/p5elZ/VFbmMNDUg6eqW4He5JXBhREs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PZCpTpmyO5prVCR08ph86BBuDo8/V39UH0Pf+hbARTkKd/HL/KBd7s6jpU0CTWtDsbCsXt84BHoH2lI77GLiIjk1bEdKWTBWN232cFOfWI3jkzh7S98g/i47BRA/q7qBiDXCKKLpIakA4Tpz+Aw5dvGkeIFce69j+d8qBZhxqg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSEOzUMq; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSEOzUMq"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334e72so18679745ad.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 04:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789385492; x=1789990292; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1O/dMpeoDRusKR1l2LPsc+N+UdB/XZJmDGkSj5BirLY=;
        b=NSEOzUMqB9UZmfn/SOA1AEHS/GH/MNtZ+2z9IbhUNieoTd57xK1hkqfSN8bZI9fT59
         V8duMcrv405QdPzBfAzcLmAgxiuRjVf0CZvY8F+AdaoXROR0VcfS6jZPW0Fo1l/85edB
         MqTryaVK2xXVMoEA9BdNU9iygkZZJlWhQKidu68T0i0EdyR6Cwm4WjsJcGIj8MEAeFxM
         y26JCgbmqN4L2faKotRenKh2ei7MXdollJXykgRFQtBMrERq7yXZSNCCqJ9j5jrmP49y
         r91umKcCh/TNkqRJ8RotplVMR0ugr0TseYEv+mWyVjAgZmcXjMbCZUXMNyqnNCRSPdyv
         Jkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789385492; x=1789990292;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1O/dMpeoDRusKR1l2LPsc+N+UdB/XZJmDGkSj5BirLY=;
        b=me5/A9O9/UN4MPVB/W2W+2ngdimh5rxbw+1vl2JG8ClicHt9e/ugm1GbLRmFjbEiLd
         Zn7gcKy6V5uFPTqsCuzkudUicc0+14lSPCPbWkCumdFPc9lvWl0LDIqi73tHQ1thVcOk
         7i0/X2NYtL+q/ThtUjeGeWu3LAFy2yNcHT9M95UxC5qI70SHyvr/zmnwAfYrhPXxy5Mn
         6GcCKUtlDjO0XSbLymt5gtkvWUYwzXJ7vE4bdg2yv8naSgUFPirhpXo9/px9of5rQkLR
         x67wYE6bSxvw/KFu3YbU8XFL5cU1ghn7eEmWmoqwbCOklXd760epNJ89dQ6DXj+eeSDo
         QBnw==
X-Gm-Message-State: AFuF++ktMLf0mvGyN3wL1iUIUvKuPKr2QnSju4FzgiAyuERwmYGRxGT6
	RgTdkLYcxS8GXrKRQ6vQmVOBIKCbc97AqIdYv/xX+cywV4E2CgcKf4X1kczkcA==
X-Gm-Gg: AYBFou0iOBGzKZi8kamS1VVHMbTu+Gv4U3nJAY/cRkZktiQVe6++D2RgaWXaSUJNgan
	F8N+um9Ejl/OgIAY7l2lRBicATYFlsI4iqClLs06pbfwBp1njWUBttgJFoAR2anSAzmvPjF6PTY
	sJlHWR9y8YuOjBReqm+C1FLetE8X/IBETU+6yYVTRFN7VFu+WzvS4xytAsPE7yBFDCXq+EKm7ot
	TUkNZ9SkuCE5FttnGmAOVSUQbAEzIRKqCAllIyNE0hpKWa76j5HN5eFj/IKovG9WfOYxrRBq/NR
	xcfi1RsRQL0z9nwF0r5EzP3zeiXzvupdredv3w1dRdtW7VhlCrCZoDRxIrtDfNobNaiXsnzGKc0
	vBIAu0QbCp6e17ToiFgYTBv/dCc9EqJSRXfShjneR6W+eDSoPIVl/UHBSLMRbcxVsGshTd0NBx4
	IPzka0cJ9qWX6JfKRKajweXA/O8aOfI+lKhm/Sl9eHksdvtlU2pAHGaRpT/uP+pXS9tlq3A7XOE
	AOm
X-Received: by 2002:a17:902:fc4c:b0:2d9:123c:8c49 with SMTP id d9443c01a7336-2dd6c6db8b7mr49001375ad.14.1789385491984;
        Mon, 14 Sep 2026 04:31:31 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2ce9c8besm45856175ad.18.2026.09.14.04.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:31:31 -0700 (PDT)
Message-Id: <38070935dc479099375b89f76a2f3c1db52e6577.1789385483.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
From: "Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 14 Sep 2026 11:31:21 +0000
Subject: [PATCH 4/6] pack-objects: sort --keep-pack list for lookup
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <ttaylorr@openai.com>,
    Junio C Hamano <gitster@pobox.com>,
    Justin Tobler <jltobler@gmail.com>,
    qeesung <qeesung@live.com>,
    Qin ShiCheng <qeesung@live.com>

From: Qin ShiCheng <qeesung@live.com>

add_extra_kept_packs() scans the whole "--keep-pack" list once per
pack in the repository. That is fine for the handful of names it gets
today, but the next commit lets a caller name every kept pack in the
repository, and with thousands of them the scan dominates: matching
20,000 kept packs against 20,000 names takes 11 seconds here, against
under a second with "--honor-pack-keep".

Sort the list once and look each pack up in it. The comparison stays
fspathcmp(), so what matches does not change.

Signed-off-by: Qin ShiCheng <qeesung@live.com>
---
 builtin/pack-objects.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8ca8255176..1fcb4ef8a5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5007,7 +5007,7 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 	oid_array_clear(&recent_objects);
 }
 
-static void add_extra_kept_packs(const struct string_list *names,
+static void add_extra_kept_packs(struct string_list *names,
 				 enum stdin_packs_mode stdin_packs)
 {
 	struct packed_git *p;
@@ -5015,18 +5015,13 @@ static void add_extra_kept_packs(const struct string_list *names,
 	if (!names->nr)
 		return;
 
-	repo_for_each_pack(the_repository, p) {
-		const char *name = basename(p->pack_name);
-		int i;
+	string_list_sort(names);
 
+	repo_for_each_pack(the_repository, p) {
 		if (!p->pack_local)
 			continue;
 
-		for (i = 0; i < names->nr; i++)
-			if (!fspathcmp(name, names->items[i].string))
-				break;
-
-		if (i < names->nr) {
+		if (string_list_has_string(names, basename(p->pack_name))) {
 			/*
 			 * When following, treat the pack like a "!" pack, not
 			 * a "^" one: nobody said it is closed under
@@ -5151,7 +5146,9 @@ int cmd_pack_objects(int argc,
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
 	int rev_list_index = 0;
 	enum stdin_packs_mode stdin_packs = STDIN_PACKS_MODE_NONE;
-	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
+	struct string_list keep_pack_list = {
+		.cmp = fspathcmp,
+	};
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
-- 
gitgitgadget

