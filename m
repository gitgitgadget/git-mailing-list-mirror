Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4F0823DD
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 00:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775435134; cv=none; b=ITOBvGdIb2VbMAZrqqqomiBO4X/pshbefYv4c5pAuq5xUP19yFmZgkYkS6VLwgrzaX4w2HFhIq+g/g7lmGy82ibjJHqeo91PoH9fWlOoHydmX9k7RUv66++1aX+Y4VzEynKEtyKBD58ELJa+FYF5kj/FZnaFSGYOZPP4ccxVtEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775435134; c=relaxed/simple;
	bh=sRF7GLfebicBePHPR1jD96WDS/MImaCOZYb4Ieabc6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIveuccMzUfIuoYOfBI2hxFMbH5uAZMZooSLWJNAUIxeGDdQ0R/JxZZF62kkr2o/hYfe673dqcoEu4loxh6N6sayPUo3lEkLhs0r/oTSHCLSQe5/RWDJnujGZngP3sMVEVZqWc2Dx+YCNT/wfAz0znRUQL9dN5GiAmFFxXy4enI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDiUq86x; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDiUq86x"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b87970468so2902897f8f.3
        for <git@vger.kernel.org>; Sun, 05 Apr 2026 17:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775435131; x=1776039931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sVNXlPJN0zoVaJUoba/icsxGoAbKWe2ess9+hUyRAM8=;
        b=gDiUq86xUhnfFGL4BmzJKojU8zEF5SJCW0TZL2OPlSGuzUnYglO75pDR4TBanqbGY6
         hdecFcE2TXd56NRrW/LJqy070JqPj0hYivWEztYOxhKtvXVYYAc3f7+IL31DaVvvUQUA
         DcHs2Oekin5HSijyQflFjx4X1veyJoI6TZCDCtSCQtejiefN+8YlYImzQRHCIP3oMbNc
         APWroqN7sYvsn9TNJxlUWnhsnbNmXr7JUIFzp9FeHoBiqsZ9F7O4YN91MpDxMveebt7C
         9L0YARFS9RBcYYQcmVSpM+67iw8dWCsoKK35tqpkLabh0GdYJZj7HIsHTTFJYMz9Oq3+
         B1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775435131; x=1776039931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVNXlPJN0zoVaJUoba/icsxGoAbKWe2ess9+hUyRAM8=;
        b=GmgiS806Ou3h7D0vWvhUh7bjGaolIk8Lw2Ua+WCYVebyJRBXCfqs+syuFD87/Kbo28
         AgejhGcOxuQH7DXcR85tbdwiS7vWyiPnvQu9dsREMLj5XGo6OW8az/YG3DhdYxv40VZF
         MZ0gbmiw+hrPmLhPpl9lkFiqc1cZgA2NoDuI+jQEpkeT3dFV4nb06FJEjqe8c4Z+t7Fu
         lV+DKrHVxQONrszzzvP0GBCdT5t0dX+R768I/6OJ4bZjxnOvOumAirKyOXPzYBfrnZhD
         C/YLmJUdQkX3B5uNgd65vn3xMmFAKT1IZKh7bRRNG7tlZ1xvkZPtTduQbdS1u8PoaZRP
         j8JQ==
X-Gm-Message-State: AOJu0YyBCAfwRtFhKdX6LrwugZF4u9LrwYBOvtX3s1vfZiMozBJk1u4H
	fFZifePuTrLKOyLFWfmyhvWP+024m1nOe5pl24/UyOgbqQx+nXptLwCF6BV8EwXjrSY=
X-Gm-Gg: AeBDievqhZvY+nKCtxbSehlPa2e8cULCkgYkPmieYzXT1aIu4noXLVOpX3PHGO4mGFx
	I0Wj0ZonTzae6ZNq68Zvm5R0pDAewGBqi0Kub4zkLM/BT1A3TCgK9fafc7QK+s05WjIHWg1c00W
	I2URj7gyCBRJJKecROLbwzZWDN9v5MvuH7lqpP3gwYmwOK5JUgaWiu3fcHjfEJIKLtZDugt08Ye
	rNo9w4puqentyz7gSNMmJHeJS6yG/Buzs+okGvkJo3zrIckuKZQWb0jUJnRKBynteQveYNgcIkh
	y5Yp/TuzVN4ROORnqmb91iBZ4S3BB0iRoMtjbAn1SuAZY15vhuH7DvgWHuXK7BIUwHtMzEhMMEh
	Tk5pULY0J32BE3tH67SOFUmIZxZ32ipkym15MfTJ2lVOfv1ktRghhUqmlIHsp00PH9AKp46ymJb
	R7BumFzxGeSFgMaKGzGtHNUgLWtkp6mFiv
X-Received: by 2002:a05:6000:4383:b0:439:c62a:6dc2 with SMTP id ffacd0b85a97d-43d292e188fmr16130492f8f.41.1775435131045;
        Sun, 05 Apr 2026 17:25:31 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f843dsm34074725f8f.37.2026.04.05.17.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 17:25:30 -0700 (PDT)
Date: Mon, 6 Apr 2026 02:25:28 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC PATCH v3 5/5] t7703: test for promisor file content after
 geometric repack
Message-ID: <1533fa96a8e2ed135504dee54535b2ed38fe5dab.1775431990.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>

Add test that checks if the content of ".promisor" files are correctly
copied inside the ".promisor" files created by a geometric repack.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 t/t7703-repack-geometric.sh | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 04d5d8fc33..231db98743 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -541,4 +541,46 @@ test_expect_success 'geometric repack works with promisor packs' '
 	)
 '
 
+test_expect_success 'check .promisor file content after geometric repack' '
+	test_when_finished rm -rf prom_test &&
+	git init prom_test &&
+	path=prom_test/.git/objects/pack &&
+
+	(
+		# Create 2 packs with 3 objs each, and manually create .promisor files
+		test_commit_bulk -C prom_test --start=1 1 &&  # 3 objects
+		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
+		oid=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid ref" >$prom &&
+		prom_before_repack1=$(cat $prom) &&
+		test_commit_bulk -C prom_test --start=2 1 &&  # 3 objects
+		prom=$(ls -t $path/*.pack | head -n 1 | sed "s/\.pack/.promisor/") &&
+		oid=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid ref" >$prom &&
+		prom_before_repack2=$(cat $prom) &&
+
+		# Create 2 packs with 12 and 24 objs, and manually create .promisor files
+		test_commit_bulk -C prom_test --start=3 4 &&  # 12 objects
+		prom=$(ls -t $path/*.pack | head -n 1 | sed "s/\.pack/.promisor/") &&
+		oid=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid ref" >$prom &&
+		prom_before_repack3=$(cat $prom) &&
+		test_commit_bulk -C prom_test --start=7 8 &&  # 24 objects
+		prom=$(ls -t $path/*.pack | head -n 1 | sed "s/\.pack/.promisor/") &&
+		oid=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid ref" >$prom &&
+		prom_before_repack4=$(cat $prom) &&
+
+		# Geometric repack, and check if correct compared to previous saved .promisor content
+		git -C prom_test repack --geometric 2 -d &&
+		prom=$(ls -t $path/*.pack | head -n 1 | sed "s/\.pack/.promisor/") &&
+		# $prom should have repacked only the first 2 small packs, so it should only contain
+		# the following: "$prom_before_repack1 <date>" & "$prom_before_repack2 <date>"
+		test_grep "$prom_before_repack1 " $prom &&
+		test_grep "$prom_before_repack2 " $prom &&
+		test_grep ! $prom_before_repack3 $prom &&
+		test_grep ! $prom_before_repack4 $prom
+	)
+'
+
 test_done
-- 
2.53.0.585.g1533fa96a8

