Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EA71FA856
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741981320; cv=none; b=J6HrwQx2G9q9tZBTOl5PR4VBVjIgwsa8pt/A8Sj9yg64p3GTEnXLoPklD6y+JNEB0ZlRj2LNEpacZoWMbybblx7W5DZOMxrxpdRv4ImS/zAhItdEE94/WUQ5dQGOwVSC9KxbPojpvGyqlx/L/JSmiCBQTqLJuuX65KBDrkrozEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741981320; c=relaxed/simple;
	bh=zzC/0NtNXO/xJEdLNnUD7GrcFDmSQfH0mWHyPjCbryQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rKVkQaUpHztXyMVotbdVh6xHmvti0Pz9DJiudEnfYITyzb7IF+7t38WqTeGdYMTXOe7A0eTWmzROaZq7zyjzSdsfB7SjdYI0Ekr07njfrJ1HCxmpHoyMmPfv9bfPW5dMal7ze48GAbPhYRmYLqID/6unr7HfN1SDrecajZdh2Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=uVsVOTwO; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=s+K5VuGN; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="uVsVOTwO";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="s+K5VuGN"
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-72b82c8230aso693577a34.2
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 12:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741981317; x=1742586117;
        h=content-transfer-encoding:message-id:references:in-reply-to:subject
         :cc:to:from:date:mime-version:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YF3p4JpKe0GgTVk6uxY4SFKTckJfEeugqPF2Cxo0Ccg=;
        b=Ymzm5t1wCrgmrk06bipAgiNXQ8yCwu9BCyI3CpNuau9/lqD79AnbZamOvF3OYgsBb7
         vz50rBzJDMhoJ4bS102bli76WR7R27+97kispa2zN39QL5xTz93+ZVI4X6wwbtEXh6sE
         ao6eVpgvCxg/gPxiXbeh+vSPSlNvL44QuA6OfEKR9MYCFyv2PciN1SIa88toLW2XCUU9
         slXZNQXo7vUxQYQd2cccj43gSPWl9e6vXQ1Fiw2snNxuh5fLWKhtPRGd9M3t1dYzt7UW
         ueTPvTR4z/YAY06m/DPN81hZbcd6ChYF19MuMBPnvKAd7bkS/tSgw9ul9N6TRwKHCHL6
         ZPtw==
X-Gm-Message-State: AOJu0Ywvcb3pUV8iHqWHPxtBlivDRr3NPBRhdrGmzV07gTJJfVJuhlmL
	NEe1QfUqIjZTD1G3nOpR7zOMdhcDjTlTsIhrlt+NxpBPDxdowAmXonRm5fpgK9caytBzB1l90Kt
	5NSDlOqJEqglqiQD860IzSckZYlFnCgm6
X-Gm-Gg: ASbGncvHg7ybxzZ4ig+m+x/LMQeBJjAz6UpCmxE7r9I/8NIeOxqZnyW7Gcwv3a/aIYC
	PmYGxxRu4TfqKcZnR5vstYRAy2cKcjQcUloS7gpY+tTElwwfeTH6MW39VF1Khcq/WGbjXalrrZU
	5twq+5ZCtPrZEtYQEoCpnttnxYRjDcUOX6atYmUm+iETlqAuqNtQ3xL9l/61ehvd2DR+3Hxwr/5
	YOadiJqIo8gwtZLJZW/o8UYNJuHB+ymhOkDaFNYojPyg9e8qMj6lE+PmxZdFBQ3WTP+YMYLbVH8
	RFJu/qZQMV+UlkFTxW/Vezr3/WHIt2J6I666fXuaJiGqYauDMRvXVTeQkoVcayMzY8aIRVGmfVm
	gzQ1wGgkXlfkFVmMuEJfZdfjA2FVgQw==
X-Google-Smtp-Source: AGHT+IGGH6o2T26cLQjqyuPawKBgWYfFrkvDedMO6dpGtbQ+nvq4Cd4mG4Sae9/SS/w8lOf+5dTYHi2W2ItY
X-Received: by 2002:a05:6870:224d:b0:2b8:3a1f:6351 with SMTP id 586e51a60fabf-2c69126994fmr2204689fac.34.1741981317474;
        Fri, 14 Mar 2025 12:41:57 -0700 (PDT)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org (pool-108-49-41-183.bstnma.fios.verizon.net. [108.49.41.183])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2c6712947dasm173749fac.32.2025.03.14.12.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 12:41:57 -0700 (PDT)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1741981316; h=mime-version : date
 : from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding : from;
 bh=zzC/0NtNXO/xJEdLNnUD7GrcFDmSQfH0mWHyPjCbryQ=;
 b=uVsVOTwONBcCVZrQHVIO2S4hCkfr/3MhRshhukS2vCgKZ5ewhWynj6oBywMsjrgqzKR3C
 dr8nJDrsf2TyumIBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1741981316; h=mime-version : date : from : to : cc : subject :
 in-reply-to : references : message-id : content-type :
 content-transfer-encoding : from;
 bh=zzC/0NtNXO/xJEdLNnUD7GrcFDmSQfH0mWHyPjCbryQ=;
 b=s+K5VuGN5DzrbiOuUmoHDMegydV32HvtVFWai7OCNLfn5giRB+IvP9ltZEvWY1vzQfEQo
 smlHKdW49EwTTBJkz5FEbLqPPS5Gd7SFSyxIbiiz2QBnqeHdhkZyKLmIO/6WRngl0APVkAO
 x5CuEg4rnh4CJm0BBSDBQV8G431V3SH8eiQdtyQHJaQp/mpMN1wOpLbAjE8zfNGY7/fwtF3
 dTsql6mnpZtXIbAtuDSVt5ESpPlyTJsGMu5tThU5nd+TWRY/hhYZlZSdz6ZHLWQxHXGvfTT
 rqjSFLLUuJ8PcSW3Kyk+1a5JMynizGFLY2WlpJ643CM2g7s4bMzm7j9vmxYA==
Received: from webmail.mandelberg.org (mail-web-d031b246.virgo.mandelberg.org [10.0.6.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X448 server-signature ECDSA (secp384r1))
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4ZDvrh4wj6zySJ;
	Fri, 14 Mar 2025 19:41:56 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Mar 2025 15:41:56 -0400
From: David Mandelberg <david@mandelberg.org>
To: David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>, Junio C
 Hamano <gitster@pobox.com>, david@mandelberg.org
Subject: [PATCH v3 1/2] completion: add helper to count path components
In-Reply-To: <1587533591c81d38977e62165784f8eb@mandelberg.org>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <1587533591c81d38977e62165784f8eb@mandelberg.org>
Message-ID: <769439687ea2fe89942a9e28822671ed@mandelberg.org>
X-Sender: david@mandelberg.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

A follow-up commit will use this with for-each-ref to strip the right
number of path components from refnames.

Signed-off-by: David Mandelberg <david@mandelberg.org>
---
 contrib/completion/git-completion.bash | 11 +++++++++++
 t/t9902-completion.sh                  | 26 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 413911be3b..5fdc71208e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -234,6 +234,17 @@ __git_dequote ()
 	done
 }
 
+# Prints the number of slash-separated components in a path.
+# 1: Path to count components of.
+__git_count_path_components ()
+{
+	local path="$1"
+	local relative="${path#/}"
+	relative="${relative%/}"
+	local slashes="/${relative//[^\/]}"
+	echo "${#slashes}"
+}
+
 # The following function is based on code from:
 #
 #   bash_completion - programmable completion functions for bash 3.2+
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 51bd750837..015289c776 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -455,6 +455,32 @@ test_expect_success '__git_dequote - open double quote' '
 '
 
 
+test_expect_success '__git_count_path_components - no slashes' '
+	echo 1 >expected &&
+	__git_count_path_components a >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_count_path_components - relative' '
+	echo 3 >expected &&
+	__git_count_path_components a/b/c >"$actual" &&
+	test_cmp expected "$actual"
+
+'
+
+test_expect_success '__git_count_path_components - absolute' '
+	echo 3 >expected &&
+	__git_count_path_components /a/b/c >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_count_path_components - trailing slash' '
+	echo 3 >expected &&
+	__git_count_path_components a/b/c/ >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+
 test_expect_success '__gitcomp_direct - puts everything into COMPREPLY as-is' '
 	sed -e "s/Z$//g" >expected <<-EOF &&
 	with-trailing-space Z
-- 
2.47.2
