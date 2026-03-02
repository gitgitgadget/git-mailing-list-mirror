Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5571E413237
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467884; cv=none; b=DDC1NU9Hr/CZwZvGoA7nTiS/l8eHSLuDJ0DLhxFmONTfqrvFydQVqIiNljFgbBg2AxguAmr26ppRzANMMwlNi5eV6nmh98d03N10KXq6cFrihf4f85mtRPl1L0fRZ7GLJpBHarVPM1jBrvURwOg/ATiB2/kNJADUyYAPkUYkeDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467884; c=relaxed/simple;
	bh=hwCHnNKp3pRddvqpce0ZPB+YCE+nKANT6ST8K34SaOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7093KIpXtBcZckcq7QBWvZVNE4mvtq2CopF5eOBZbRilQue33YQi9Jh1LehREOP1W15vAdD8lwhuPGzrOSNpvZ0Uw/63/x5ZIOPrq/F4Sb2onkfCH8plLe+/a2MOHwIKFJieo4y+7zsgff7Lhx490o42crpuX3zzgoVV+uHvBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IemNr8Ad; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IemNr8Ad"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso41919295e9.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 08:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772467881; x=1773072681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5SDnsTSlCUs+s5S6n/u+2apSoFTbpHcXKP0AzMm/fjs=;
        b=IemNr8Adn4F5tH6XJsaB+trSmSvuB7mzlXoK0qEzFuBBOhjiY63TMrDDeBmOlUEsOl
         8CQMiSh9tNcr7kyNkQ4JeNnus18bMPCBh82ouA3sMcJ/eTR73cDpuFk3utQvVCCYOsSC
         BUD+7S/BrjDKUqeTgR06YR6BNug2bzgNfPdBKKUH7ZPnA1Ik1HH8XtYULeySkETWaYVo
         B9tw7sgRt1ZXiPzpnj66trqSKkP5clHpGnfBb4du7GJ6y1AoZAeOby+xZUgmkwhVFneI
         Vv9zFt8yviOlAY0aTmLFvUinHoANoCZ0r3/zFlKtdw71Ja3dLEjupjvOVtQXgKE2+jMg
         d1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772467881; x=1773072681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SDnsTSlCUs+s5S6n/u+2apSoFTbpHcXKP0AzMm/fjs=;
        b=xBWL7+dPPcNTuFPyxXk6eljsUkHKDV2y+jRbuu7tR97X30JSRjCxYftW3cA/zcDd+U
         5Mg6slXZn5gbnXi0biabYPqeBeFOHlSrg+ASluiLOwuX8kXB5HNI6EJ0JSRBVXGfE8aQ
         LtzH62fsCPfE5rtTqWbhCyBvoK+aGbby3+jGANLVBddVO+aa2g5uhG8xd/o0TNByU++5
         r020ZFf9EELBBRasxsno9Vd11YVrqUHZYz2PcwTeqM6thnuUHfH3snKoOvEibcZjwZAK
         FCWYJGWpNp+SGoNeSndu7mLLRG+Qxvrx/+swJy9H9A7dwooODpmrBwHCW9kSkoPcAh5A
         XjoQ==
X-Gm-Message-State: AOJu0YxceN+z5UuPv7WcodtuH6PKKjBgnFWFz1SDXDGgGkZ0lI57OCg+
	72uU/9Own+PgGbSk0AQIlXdQecWME5WCa1qh1ZVmnk63aaF8ygGS/oSbc/q1Ag==
X-Gm-Gg: ATEYQzylDIinfuCNTZFQmmOGDtSVhQs8Y1LwZbSE/hCYj5Szk4VnJIvo8AN2W8IO8gz
	4az8XwOlEmQMEsrOFdGIm8fMkpBk/LA1oP4eMOtmWlKZn4+fvcg2wBMoXKLsggQ2bG9wHhz3tUd
	D+fEdOBOHaIa1KGpHV4b1lzQH7ZfZMbAd63WVD1l2a5Mm4J82Pmc/mL57xJNUm4sGX2AvOKE2ct
	Z4uUeISTCfXFnLCPuqfQUGmSh2QJk+WE+g6gEANLDgbwEha/rWMgBm0RFRjVK90xmEpIbtAPyEt
	wgPRlKf4ZkhMNEVmNfzfZH7CsS7edhn2e2HTi53n5XbVci4lcUGTBODnzIp9+0CMGFtiNqS3DlB
	ScbRKQ1Pg42fpMNP+ayMtKvmwYKDPYKTmvs2FJV5ZTGnCzjUGPGe4lpHrRJRBYW3fnqYNsm1fxz
	1qHnbxGkBE/zYGwRwdJTxLiq0AiLah0uRBXLg=
X-Received: by 2002:a05:600c:4592:b0:480:52fd:d2e4 with SMTP id 5b1f17b1804b1-483c9b78c20mr242944295e9.0.1772467860186;
        Mon, 02 Mar 2026 08:11:00 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd750701sm439917015e9.11.2026.03.02.08.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 08:10:59 -0800 (PST)
Date: Mon, 2 Mar 2026 17:10:58 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH 3/3] doc: gitprotocol-pack: normalize inline code
 formatting
Message-ID: <e0e4ea3d22d11d8d6b6e721228f1420cb8dfa612.1772467050.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1772467050.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772467050.git.lorenzo.pegorari2002@gmail.com>

Uniform inline code usage for command and process names.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 Documentation/gitprotocol-pack.adoc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitprotocol-pack.adoc b/Documentation/gitprotocol-pack.adoc
index f4c9e024b0..63d3971037 100644
--- a/Documentation/gitprotocol-pack.adoc
+++ b/Documentation/gitprotocol-pack.adoc
@@ -117,7 +117,7 @@ process on the server side over the Git protocol is this:
 SSH Transport
 -------------
 
-Initiating the upload-pack or receive-pack processes over SSH is
+Initiating the 'upload-pack' or 'receive-pack' processes over SSH is
 executing the binary on the server via SSH remote execution.
 It is basically equivalent to running this:
 
@@ -131,7 +131,7 @@ two commands, or even just one of them.
 
 In an ssh:// format URI, it's absolute in the URI, so the '/' after
 the host name (or port number) is sent as an argument, which is then
-read by the remote git-upload-pack exactly as is, so it's effectively
+read by the remote `git-upload-pack` exactly as is, so it's effectively
 an absolute path in the remote filesystem.
 
        git clone ssh://user@example.com/project.git
@@ -163,7 +163,7 @@ supports passing environment variables as an argument.
 
 A few things to remember here:
 
-- The "command name" is spelled with dash (e.g. git-upload-pack), but
+- The "command name" is spelled with dash (e.g. `git-upload-pack`), but
   this can be overridden by the client;
 
 - The repository path is always quoted with single quotes.
@@ -377,10 +377,10 @@ In multi_ack_detailed mode:
 
 Without either multi_ack or multi_ack_detailed:
 
- * upload-pack sends "ACK obj-id" on the first common object it finds.
+ * `upload-pack` sends "ACK obj-id" on the first common object it finds.
    After that it says nothing until the client gives it a "done".
 
- * upload-pack sends "NAK" on a flush-pkt if no common object
+ * `upload-pack` sends "NAK" on a flush-pkt if no common object
    has been found yet.  If one has been found, and thus an ACK
    was already sent, it's silent on the flush-pkt.
 
-- 
2.43.0

