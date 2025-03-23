Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EB73A8C1
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742763950; cv=none; b=llH7gU4B+MSa3lKwV4sDbjot9dVHPQCmi7k4qsiihf+BlradFLr+M/rf0/aCmmNGA4jsv9xv2ZhyvEE86ldcbH1I9XMD3fUxu/NjQZ4jmKuZmE6YXazvdn2a6jVfH2qZV8aJaOmaQe+QX52aO/QDflihyuEcbyGiriawkgTpsK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742763950; c=relaxed/simple;
	bh=zzC/0NtNXO/xJEdLNnUD7GrcFDmSQfH0mWHyPjCbryQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=RHcxogyI3vnLyjNxgCfCLWeswdXmVLT8eokDwRjlgr3zLsMzWhBrsybrnzJaZcaCV9UFQm/OTcTjOQxEti840pCe1CkLMgZagoTCCrQvqYxhoV/YHRI3sJrLyehwSzuWYGnaEqSOISAp9Cz1Im96fnU/BiB12B4V1ro1za0Z6dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=Bzraq4w0; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=D2SQRvAl; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="Bzraq4w0";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="D2SQRvAl"
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-6e8fb83e137so30214316d6.0
        for <git@vger.kernel.org>; Sun, 23 Mar 2025 14:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742763947; x=1743368747;
        h=content-transfer-encoding:message-id:references:in-reply-to:subject
         :cc:to:from:date:mime-version:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YF3p4JpKe0GgTVk6uxY4SFKTckJfEeugqPF2Cxo0Ccg=;
        b=REsb9nYmtMk8fjMcBZvUUwpPLfnnM1mzTEcHw4reB7TWYNJO4EVm7fz0u9WUM4LsbG
         WaJomLkx4ci0RkAHfPV4GH88nlL92TQuFzN1Qx5QYjpqUjWRCus+xLhXZBaaNV27+RWo
         mNP2xLV8vIxHs7AGIF1FjFmN9p44bVcvJWTchwouBqOXnv77xMV/03FIygRol+vTEKVr
         au8j6TOIyC77SLBl3GSBLDk69ybLzGxDqiuUbK7irKjhxTX9qXrP2L8aANXdbMScznNI
         +xbClqC0fi7S7O4qY9p1Zzt3Dux/zBwl0Py/hMM+RMAhZEW26JAzR37TpWfTDjSkeSHl
         R1Fw==
X-Gm-Message-State: AOJu0Yyfn8hz8q56e9aMFdKaq3LbGOfR2CVDhlZiTOWua2WXwy4Bnu8m
	gcc3HifQ3ZTeiOqfgyLLsQ7HhBMiXLmrLIGw7SuyKZuZQHKlr31260rPHOXx2PmtWw+o27848NQ
	oJGYSRgQPFV7Mdocs+aAYkU77fqZnQXEj
X-Gm-Gg: ASbGncuftq5WhqeS6pFkupsuQlpTbEE4dbx1J9iuFevwJI4zQzTAypBI7eHRgNIheN/
	F+2RMJTYhjcc6JT/YSKjcYbpTneZuvqrxwK1Xw2Kiz/62S6m11I5KAVMG9ZVT9/YwpsxepWrFeu
	ulGSZpeAx9EMC2zTi+ehBqMrxh1XfHjhXFVFyXhe2drM57P6yGO0CT7ei7a/1T5VGrTgAizzOse
	KcgY/MHDo1Bh6PsGjRJK3G5q5N1asFT5gpipWLFyiWrRHJ3t6FZrU0WTsQVnBGsFKraABVB0jl4
	wd2T19KAvStbywOY6urvurxNBaJjtZgbeTgQC3/t4JgkgDi0Caj71k3U6ZqflOMNwDXTQRqOmPm
	AaTCPDEeEyCUUdo2OD9bqyd9v+S55nQ==
X-Google-Smtp-Source: AGHT+IHHNc68hC641RGOtnDCBP23yrtnSt8VfjVHvDn4YmYnc54A8XN4e3AtetDWZpGd7Mrh/Y599B/FbltG
X-Received: by 2002:a05:6214:48e:b0:6e8:ee44:ce9f with SMTP id 6a1803df08f44-6eb3f2e47dbmr166278586d6.20.1742763947121;
        Sun, 23 Mar 2025 14:05:47 -0700 (PDT)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org (pool-108-49-41-183.bstnma.fios.verizon.net. [108.49.41.183])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6eb3efc16f2sm3447456d6.40.2025.03.23.14.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 14:05:47 -0700 (PDT)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1742763946; h=mime-version : date
 : from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding : from;
 bh=zzC/0NtNXO/xJEdLNnUD7GrcFDmSQfH0mWHyPjCbryQ=;
 b=Bzraq4w0C4EkKx98FHqrPievTWkGP7tsLr+b9pi8yEjKjuLi222SxVeMfXZLq9j2e47w5
 2FAc8/kLYIs3R7NBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1742763946; h=mime-version : date : from : to : cc : subject :
 in-reply-to : references : message-id : content-type :
 content-transfer-encoding : from;
 bh=zzC/0NtNXO/xJEdLNnUD7GrcFDmSQfH0mWHyPjCbryQ=;
 b=D2SQRvAlpzer6X9vhGBmZAQY+gWUkkkDOY/YTC2oT+iF2cVwSoSrmcaYSxSObHRfz3Jaf
 qYTFkUnq8kWONIWiYJu8FvsWgg8+RHCoNPHInsB/MOg8KwipMCRYT39bwmLYU5MG58uyhH+
 8Pn85U67OV9gIipHSQwu6cyudgyQNihVz0m2cdziKjfnTEFdrE8RSLBUQY9DWxaN3vZCOyf
 0bnhZ2NHD7Cxy6FCiF6khHPYDYrfWsl23UOL4ZQHO16RB35uI8P5cT/yQCdAXosiIc/4gyW
 QkthDx0SX+ofnGv43C6PkpMj1qA+ASul4nbEmSgyPp6ciepgrGyvP3iBJv8g==
Received: from webmail.mandelberg.org (mail-web-d031b246.virgo.mandelberg.org [10.0.6.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X448 server-signature ECDSA (secp384r1))
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4ZLTHG4KHsz10dZ;
	Sun, 23 Mar 2025 21:05:46 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 23 Mar 2025 17:05:46 -0400
From: David Mandelberg <david@mandelberg.org>
To: David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>, Junio C
 Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/2] completion: add helper to count path components
In-Reply-To: <17274df2746d304db876ebd82ad8d932@mandelberg.org>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <17274df2746d304db876ebd82ad8d932@mandelberg.org>
Message-ID: <dcfec0ed2ca2ce26f523e9531f5d3e76@mandelberg.org>
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
