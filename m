Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5043AD511
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833483; cv=none; b=dUJnPy5JQJJYx/NYSm67+bN0kA6aru8X2Ea02D414KhgBHdLrbRMP6QKyMSwYo9MgdmF01vnAz6DnpJUyhL/sf3I1zxuE3u2mIKC9aEx+i80ZHHAwpltpciwVb2I/XIFSBP21SUwsIlu3+tka2IRRjHsUbbAZHLFpVYS7SFuXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833483; c=relaxed/simple;
	bh=dbjYZa1Y5MTMHXRLZMl+EaeslbFYZvBoxS41hISj+1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FP9JnVBtiZEu9nvm4Mq8D8gv3gQdcutkXbajeNM8zPo7NpL7MiDitXdPMxImdUW2TUVq+qYoEb2aeZWYR34XLCnoGvTGQLp9q9Yj6M+FsjMngR835By/eYGPUtAGeb2c7iL6MXiIAXuV1+c+m+f3KKbE2+XoPlBsv0Km+dnMeV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxkObzIG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxkObzIG"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b983bb07eso1371624f8f.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 08:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775833480; x=1776438280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CrYUFOHuNbCtkGQ08HoSGWHf0RM9+OArmRtLYj4mT4w=;
        b=kxkObzIGf9pYpKUgeVwx1DsXCs+4j0RfhVU4NOu847BheqjjLom2V0FH6gA5GsRmKs
         YY0U6EAvIRYK6c/LN13DkwzK9se4Cbvo7SqE0M3Le80blK2EM5nc8iNYvsuzQ8tdKTfZ
         23aelGKe7SvXeZ9znQckyF+PoIBsNK6XWxaglwGVCHIKXlQd+ULflhg30KlcjIVKbweW
         edZ+ybaJiUgwpE+xngV4Q2TniWFczeo3XpZy5mNPj+oPJsGZAibWtULSbrTlG8xHVPNl
         xBXbnitxJy4xxRLu/Lug9jmGPEAzimsMQDQV/5rzlIR/duYB3ElJm3cYAiGDxvnemz/U
         Cs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775833480; x=1776438280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrYUFOHuNbCtkGQ08HoSGWHf0RM9+OArmRtLYj4mT4w=;
        b=q5O1bPed3ECZSiVJynSi3gs1LZZVUNbSZ2i20WVJS6j+UsKbGiGi0s2zdTij12lRYu
         P6TtFZo9mw2w0YvamgBgKszqZQeOHiYKCDVJ5JR19cvhBjPjJJWQktaWbTqbv+A3bPzX
         BTOksO57HnsbxKfqDkuZwqqIPQCX04xFNGxNRYvferR7iN69gEXJTerg214yeIrgOWvT
         l/oX5MwPVrYgDNsTh7hIYLvt28wMIQUZYr5t9WvcnWMh4ISfhFOXyef5XdEPkMTZMmeF
         555M5sjMVxWGOTbG8eQInqjqapTsNFMDTdTvuBbe24zyH40OaCrMssW6au36PIRRJuTy
         M1bw==
X-Gm-Message-State: AOJu0YxKpIR/H6gknDC4znYbKJHJAtlc+r6IekCqTWj4JCmBgyR62Xcr
	TQaBxjeqJZPQG1hqVfoB1z7Qgy0ZMI+GXjtOApEGVJyu5Hhg/JLwXrN3nfjsd6rm0QI=
X-Gm-Gg: AeBDieudoOpFXTeZAnWPeT9h+ykSBsGLVpr+TdpE7l3PHVk51L953JJnKlXBLb/KCdB
	lwPr8LGErkH6ufnwWL7qvJiSwZ/dBXB9e2H0wFDiwScG6rZpi+SE0Mo67dM8Ash93ol7ZWiCThc
	oRJwuWdE26he6WqSJAeNVSzY2Luuq7+zISQoF7qyTn+3SmwRWpee2shH05EZC2gTmutIrQE42+Y
	ieSEJQrmj9Uj7xjehCksLkLtM4uzeMzyXTokPD6SWrnv0/OmxOzrWJlQIlJLzTRf2HZxDbO80JT
	0jL5FbrmYIqc34U10WVsKS8R2g/+lo2so+ZvgUIm0twtYclL3qo4l/LyTZK83tyttOl9eZ4a+6a
	ZDt3HSkYyeRi8ONS3dzBlL19yfiL/o41rs1+zheIz3zTloeQAcBjWRCq7Ioz5+N0Woafe2XO16V
	OgW8E7LrlUJ6ehdxRfs15vNXQlL1eaa0K1CROt/DhJAmV3oQgZhEWlYG2motZgPlY/KI+Y0XLI/
	bxSrUNc
X-Received: by 2002:a05:6000:2906:b0:43d:604:56d8 with SMTP id ffacd0b85a97d-43d642c9610mr5241105f8f.49.1775833480278;
        Fri, 10 Apr 2026 08:04:40 -0700 (PDT)
Received: from lorenzo-VM (host-79-19-37-238.retail.telecomitalia.it. [79.19.37.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a48sm8565692f8f.7.2026.04.10.08.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:04:39 -0700 (PDT)
Date: Fri, 10 Apr 2026 17:04:37 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Tian Yuchen <cat@malon.dev>
Subject: [GSoC PATCH v4 5/5] t7703: test for promisor file content after
 geometric repack
Message-ID: <d9f63414818419031c61a54cc3550506405478d5.1775832056.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>

Add test that checks if the content of ".promisor" files are correctly
copied inside the ".promisor" files created by a geometric repack.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 t/t7703-repack-geometric.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 04d5d8fc33..a8e3e6ae3f 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -541,4 +541,37 @@ test_expect_success 'geometric repack works with promisor packs' '
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
+		prom1=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
+		oid1=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid1 ref1" >"$prom1" &&
+		test_commit_bulk -C prom_test --start=2 1 &&  # 3 objects
+		prom2=$(ls $path/*.pack | sed "s/\.pack/.promisor/; \|$prom1|d") &&
+		oid2=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid2 ref2" >"$prom2" &&
+
+		# Create 1 pack with 12 objs, and manually create .promisor file
+		test_commit_bulk -C prom_test --start=3 4 &&  # 12 objects
+		prom3=$(ls $path/*.pack | sed "s/\.pack/.promisor/; \|$prom1|d; \|$prom2|d") &&
+		oid3=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid3 ref3" >"$prom3" &&
+
+		# Geometric repack, and check if correct
+		git -C prom_test repack --geometric 2 -d &&
+		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/; \|$prom3|d") &&
+		# $prom should have repacked only the first 2 small packs, so it should only
+		# contain the following: "$oid1 ref1 <time>" & "$oid2 ref2 <time>"
+		test_grep "$oid1 ref1 " "$prom" &&
+		test_grep "$oid2 ref2 " "$prom" &&
+		test_grep ! "$oid3 ref3" "$prom"
+	)
+'
+
 test_done
-- 
2.53.0.585.ge25071d955

