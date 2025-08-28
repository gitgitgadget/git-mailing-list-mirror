Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D242EBB87
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756371539; cv=none; b=AFQgaDfCxTZ7RwBevfPc1DjeHXe6eNc/s+9CZOe2Fubizdzd9Z5fm++wlrb9mhurNM/EiyJCLZdgWWBGY31duRp9kRTwuPRDxjPORT9tpTzRcEK7Lm9JIET98Dyud+npjaTf8YsfrVfagcv4wNwyeHGIJUnCSheVUHM+xAEg0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756371539; c=relaxed/simple;
	bh=ZE6uhN8L2nACR9gPcKQRD5yGf9LA+qcf+Ip0iM5c4bM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WEdT9qwUrb3Mf4VujTpxAZr9H+Ho4R1YsC2GSyNcopVFvn6XIhO0B98Q5I0N6suBJL0d+9UpOgpWVp2bKxwlAzRDuh5GzrGxvhnP8EhJb4phs+hLTazRzEFGxajPRT7tu6JGqHlyaaF//84QB5dSXsAawvG1FTOqJQAs3xn1lTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ln6ApaT7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln6ApaT7"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b5c12dd87so4312705e9.2
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 01:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756371535; x=1756976335; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNpHPM7+f2AtKgTETZtbq7nvyh4vz/P6zLoRHRlYfic=;
        b=ln6ApaT7PPvXoycz+nBxqI51Di5ORc+84IOWLKE3ljrX1Er7/FlrIykkJg3kWC6sCw
         yXv2wCIMUT2CneD3iQwZstyc1ihkkMWF25ewPkPC1jrbeRa6Pb9vmjZXk6kQhMCfMnNR
         fSrBjXSbn8dTss5JR0C7FAR77iVFJKywJMQ3AjcYXTLmVAKtTBCe8Y3cry9xUj/jlLeA
         nafuQ59rDiamHYQ4FY4zRuryRg0YRVmqLdy6OdPj0U+tBDFvxtQZaTzU+vy+ojqwKgjY
         Ad68XmqsDXY339Xnsx+q/rxTSNBxGkQFGXKS03kX9c+qMUYVnJv33Fqfa+x6AGJPnhMg
         1t9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756371535; x=1756976335;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNpHPM7+f2AtKgTETZtbq7nvyh4vz/P6zLoRHRlYfic=;
        b=MBVdylXaNgT0wZquu8zW3nbDQVYJnQCyIYfCc/KlL+9NJgTThim0pXKVskAQvHwtkB
         LqXWDxVJKZCrhv5BRr8HdqosiMCNn3fK0QO3UUlUEQ6yVrg7mQEXo1foFJ/eJv5wZ91t
         4EgXKsOpwyQCNqkSAN8Hh11oE5vkXtJ6SR10H9ob5CUrPN9ZgehiQQP50u2xSepK/yEN
         06ReJeMEPrbdE/NJ95wjrhMs4Sd77Gbr09VKwXu7Gq410zRPUYvbqgvAhaNGkTEL60e7
         x5NVTf44rtsm488E6sJRqjz+O/s9oa4pyuKclJYW1O9ckjhsdJIRb1swl3L+b6s9nyeY
         0PgA==
X-Gm-Message-State: AOJu0Yw6d9OIw3GLk/ZC/H5S2jOeuhkTVkWvLCH0HKFpuUwXc8Ln6teb
	nKzGTSK3ouJ1hoiFewoXfrSVtZ+un96P3HzLD+GrY78z9rk0nMHliXU/9bRtfA==
X-Gm-Gg: ASbGncuXehXxg0SW+rRf070p7eaDwpoVx846svjWsImRFUizJcp02mTYt84ZXgzCBru
	y62cfRAY2yhvzLH8HAn/JsdMYnFrie0FOH11eKR/Oo/1/RXwyZofCGU2TP494sqcP3+x32zAhLk
	5xl55NsRmGalu1mdMspRW/D9VxurlECrH674Y7lapkJ1fT1bA9Q4yDbGnKglf7iko+SnDby1xdD
	lVBUw4DNnOcS3iWRXpMVUbGSo5TSBedhGmTeHxseRRtaWgRnL6LFGHIUSvFTdcklfgKlKXu35Zk
	LBigg38qUBvPh4nfzrpAmQEQ7s534CNm95hwknSub8EE4Ylfc2kYkigQoNAfRsxbTZ1c0Us1e1/
	QU5v/+yUv2OslXdKNHZ/CsVUJ/Hw=
X-Google-Smtp-Source: AGHT+IGm0TGi93RKrIwpI+3n9o/AckuvGGhyNfj704Ep4wcJB/pVU4nwhWulGRPK6r/mHdvQpdMoSg==
X-Received: by 2002:a05:600c:350f:b0:456:a1b:e906 with SMTP id 5b1f17b1804b1-45b517df310mr203415075e9.33.1756371535465;
        Thu, 28 Aug 2025 01:58:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9f8dsm25933286f8f.9.2025.08.28.01.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:58:55 -0700 (PDT)
Message-Id: <4b04832c0b8119b784806f54a2354d910965a523.1756371530.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.358.v2.git.1756371530.gitgitgadget@gmail.com>
References: <pull.358.git.gitgitgadget@gmail.com>
	<pull.358.v2.git.1756371530.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 08:58:50 +0000
Subject: [PATCH v2 4/4] git-gui--askyesno (mingw): use Git for Windows' icon,
 if available
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Pratyush Yadav <me@yadavpratyush.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This provides a unified look-and-feel in Git for Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-gui--askyesno | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/git-gui--askyesno b/git-gui--askyesno
index d0c801c42c7c..142d1bc3de22 100755
--- a/git-gui--askyesno
+++ b/git-gui--askyesno
@@ -47,5 +47,17 @@ pack .b -side bottom -fill x -ipadx 20 -ipady 15
 bind . <Key-Return> {exit 0}
 bind . <Key-Escape> {exit 1}
 
+if {$::tcl_platform(platform) eq {windows}} {
+	set icopath [file dirname [file normalize $argv0]]
+	if {[file tail $icopath] eq {git-core}} {
+		set icopath [file dirname $icopath]
+	}
+	set icopath [file dirname $icopath]
+	set icopath [file join $icopath share git git-for-windows.ico]
+	if {[file exists $icopath]} {
+		wm iconbitmap . -default $icopath
+	}
+}
+
 wm title . $title
 tk::PlaceWindow .
-- 
gitgitgadget
