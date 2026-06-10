Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5312E2DFB
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130269; cv=none; b=ohD6zE5qzEJqCaey8Umu5+E7xbDgVUz1eVW4Z7fJCfaz2cuv/uvlv5IpmF6a+3hVuGjuGOD0A86vTPLTFxHvtPwDMh7al8re7qAo0uaSS8I1F+4wY14KXKOD8Px98iEiDVmM6efE587qYci/Xw1O4yZh6ihAEGYfuHDki2UDoGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130269; c=relaxed/simple;
	bh=6t5hHsR+dcFMdrmHJ6/QDg8H/VHdCw41vQY8ifUnnV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNrcHif0TpL5JIfsLGwHaTkyGWpmub55p2B3a+yfo1ZzT9dLrhoHH+Gq9bnzcqMLsK6ddaOyA2/1mU0X4tVHUEuntFjOuqHf0vZztpU8GQssueZfCspWA1ZOu4tAkBgMDPF4c/5LomRkofgynozmTivtWE54gNdqd/lIrA4Xw0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=YzDpHhc6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FV/Vm2CQ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="YzDpHhc6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FV/Vm2CQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 416931D00078;
	Wed, 10 Jun 2026 18:24:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 10 Jun 2026 18:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781130268;
	 x=1781216668; bh=ne1QFl8nT1hvYBxYdu5ObxXtw9PIuwLSbrlTO2wP6F4=; b=
	YzDpHhc6TulYKfh89CqVWecDb+okGlej0Spm3K33LKZZuvrY43AAJ/oSQ7YUBzbP
	WuLxyBiq7d4q17ezejWnN4eVEY6O/WabxLFVK26aOZCDZfdBYHSED7N0miq8QVAl
	Fc4jDWeQC2UssS2+0kmlUU2NB0wZoM8Ullal54c0v3PCj0VFSEXnBPgPfGEb8V/q
	04+5aWbclD9XTERe/xd9crkaJC6YveW1z960Ow/dyyMNZOaJx9kIlfUQ2A9iLJxb
	o/pg6ADRrk6X+5big8Hn+eiQxaoTBl/S2NLiI8DuyVxAvnOtiusfR7wjo861RKaZ
	6ml6IcLGp1z0rrgXePmKIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781130268; x=
	1781216668; bh=ne1QFl8nT1hvYBxYdu5ObxXtw9PIuwLSbrlTO2wP6F4=; b=F
	V/Vm2CQNRI260CHK1/c84h1GXN0JtcGCI7ksHRccLbygYzVPib0u9wDnko33P8wN
	pQfh0lP/M1eDMT0wT5DuxBebNhavFAUCInglVnmLpqAj9hrWoJs94/6d6Zk2ugA6
	iHhiERazVCKS1JU/GlvwBZnhrKOMjhwCgesWSjiWw4i3a3CdyzQAW/YoeDDU0tE5
	jaG8hBwiAgy03lN085oPwsxyXPF5apqYNpi0fXW14AY8wGE5xiV8PHlMZGGYLILb
	r4T3r1LnqnbQyyi4bflfWSOflrCrWySj9GqiYbdI0Y0VaCvGRqQ9LYzygoqUCicU
	AqcZjFnOkLDWrLEM0VpmA==
X-ME-Sender: <xms:HOQpagnxl3EetFv8EgsXO0o9vt1pa2rDh5_S4NUs-ufSxBqSNbk0JR8>
    <xme:HOQpal1WH7tX-Gh7xyVXLhXrVPZjqngqGnfFWue0LL0AymcpBde2oOW_ZdadjIhjt
    kDBIyIVBXfZyZNu6IzFl4N6zaREJPLpBWGIqJDrhVPvh8TZoX2VXg>
X-ME-Received: <xmr:HOQpasRJ9EviPbWqH8LGCZ0LD910A5qecANmHLcxqm8omtgkumkwaQfINk47rVqeX3hK6nOeKQzQjRHVO2CDPTUbA6QvTXtD35zbBgOAkZwZgHZyyAeso6eKkg>
X-ME-Proxy-Cause: dmFkZTGrSoxKMDviHz/3NXLyuxJgY3r0nCaXhrF+/SCsk+7E7K1d05Eg3FWgUDWheCGCcs
    SmbzL9uLRg7xf5+luXp4UKYxIubETIDCKenZt/rSaFsCKuykQ/nyeEqbHdsy7SNmqD76Dk
    cUC6r/Wc3LE2upfleP1fLWYRlSIrzDMSaUU/QWutbTUSJJEAFWs9opYZlVMVQklM2OmRxk
    eppMF/3DUDlBz6ou/7v9RHDJfP1QePc0IVV+XI1W6aGjl/TAFtwUhZE4t8NZ9BVkJsWr0E
    CEYr1dC11yG4TOMmKsN3h7V07zcuAv4fXfeJFrx6NNtxUXjJo7s2qE3Y+M/JY7EUdCybfo
    nzQ622GNXD5auGYwooCslmVuIxMpIU2/cG+i2jznbfnUdC4/OFQuBnnfHjvAaz+d5kDxEE
    +Xk/9bHD4mKGSOPFXOtXyxDgqVpleIH27zWL0Jwk3pyfiV/CUEiENz7Nidnnk8TnLOfvsa
    stIQbBudfk3dUw/kusxgrnyBLPe/fjxzEqA1PqKvKvC6gnSmbs1L29LMTDHSp0hxUqEzpT
    P8cj7k1ElcfrEijuVq04VCM867HOvimXhkS8bipcmgfdZTHvQQha4gL60UAqVy+47AnP6n
    R3I/qXiduREIAwVkGngWHwoJ7j6mgOFj2vMNL1HpptgT3PY6LxlnvCcaeTyw
X-ME-Proxy: <xmx:HOQpanvJ0_HEi3GoK1WJ1G2G2Q_tKesWDNv0_75V6gSA0eIGqPUnqA>
    <xmx:HOQpahbJW4-qGSSV0mTY6y0CGV4I_TnL0p71QQh-hM6524iEKHKcGg>
    <xmx:HOQpastNnpL6_WFLlmAMulT_bPHzG_9DQiabwQKh2Tm2B7AEmMYMlQ>
    <xmx:HOQpajE0BEQwH91rdkGMyqfNxWfUV3mXgqQmdNZLgxGEX4xhsRBz3w>
    <xmx:HOQpar83DwI1GMm98xyfdjvfRnkWoYFat_gPvbnKxmAoPY39NhPtoc2X>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 18:24:27 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 4/6] SubmittingPatches: document Based-on-patch-by trailer
Date: Thu, 11 Jun 2026 00:22:47 +0200
Message-ID: <Based-on-patch-by.8f7@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <CV_SubPatches_trailers.8f3@msgid.xyz>
References: <CV_SubPatches_trailers.8f3@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This trailer comes up often enough and the use case is not fully covered
by the other trailers here. For example, it is sometimes better to use
this trailer instead of `Co-authored-by:`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Note: “*can be* used”. Not “is”. Based on practical usage, I think
    it would be wrong to claim that someone sending a literal patch
    snippet via email means that this is the tag that you ought to
    use. I think e.g. `Helped-by` might be used instead.
    
    I also think that the “is” for `Helped-by` is too strongly worded
    for the same reasons.

 Documentation/SubmittingPatches | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 5dc32128883..c1d12e38b28 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -465,6 +465,10 @@ These are the common trailers in use:
   and found it to have the desired effect.
 . `Co-authored-by:` is used to indicate that people exchanged drafts
    of a patch before submitting it.
+. `Based-on-patch-by:` can be used when someone else authored parts of
+  the patch that you are submitting. This might be relevant if someone
+  sent a patch to the mailing list without a commit message or a
+  `Signed-off-by:` and you have picked it up.
 . `Helped-by:` is used to credit someone who suggested ideas for
   changes without providing the precise changes in patch form.
 . `Mentored-by:` is used to credit someone with helping develop a
-- 
2.54.0.22.g9e26862b904

