Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFE44436A
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770893; cv=none; b=Jo6S7WuX8VstTJ0koNTgaTpL5Kp5HiBylOt5z6horSXAnPBjwm5O/x705H0W0ZGqmfHDQhnNvUJ2n0X56V8faeqOHisafbR61QbsKnBBSdSFlFML0eMsf1BY8y4NxEG/X/1YbfwokrixkAODproEp/osmk7Qgyhl28n+cWppuhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770893; c=relaxed/simple;
	bh=HJO+AvJVEcccQLbGyKrb/cqAxTbzBHlDOxx+62OYBWA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ROce6JJBBa35FlaW2FnY9b4k8pITV9CUgKGYSONrSQjZYaklqbC3crsudylgLLOPNVK6mtQwBuqqItR6eQZwsoayHE+5FxMulr0FMWbjMRCCx0rskgDtX+bwef3WD1ssLdQ0604d2mvR4Kk6r/h6IRwPxvX6SLVYM/0IIZDTKbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGiVF69C; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGiVF69C"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a843bef98so144265466b.2
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770889; x=1727375689; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acAZP4zO3m9b+1Or1ChWeADfULxxC/Rx53RiCCAa4p0=;
        b=dGiVF69CnfsLq77IEETm22SqbGhgNmEZmidAKMA/1q6v4BWu/cwYE/L0qlymgrAVDQ
         0PIdYmDJIYLfE8Fq+kpachXauC080zGtE3LcaOIh5ZZ1TuGIxGmJCXKID4+mGbmd8Iop
         iHBOEj7G+33hsylCh5EKy5CQX89wpHpdjgsE8H67wgEF22FWcvcFjEwoeTCXfwQX9Y0S
         4vJ2iooDoG2wMRVHxzvTeqJVJYA5/USYRWnII4tgJg+UXRhz9xeWS/yBHc85SmnSex4v
         Tn1DxdmsZefxvCaASFbVsngoo4F66VPMKX8LfhI0P14r/Uiv2LAfpfSvXfJY4p8cGeRm
         w/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770889; x=1727375689;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acAZP4zO3m9b+1Or1ChWeADfULxxC/Rx53RiCCAa4p0=;
        b=vdEgvOtmcpqmmpoL9qpLTfTwbDEN+JislneWcPdsOaa1bQa5/7Ndgq1co18me+LzGd
         DxK3AGX33FgZcfb6P79xI/IfgzXmeLYmNXfHIzZbzAig+F+1bRVDakxxf3UiDULCdC02
         dcUpf5Upvt/hAb7DC2cTO8e1Q/qG4YICbFLRcMwcPZFCkqcvwITQgG7xJt5gnw9NkWs0
         L7gn5yE/o7tkJfkyvIAGuMmbmpykQ8bye2U281x515r5bXxLnRpw+oT6Ler7sc0hEvMO
         gbq7Ahyd/Kda+6+Z2dAoLKrgoX4Ec2Z4eaVJuP1FsRebvsaVIElt4UZzP3vG46ckqN1p
         azTw==
X-Gm-Message-State: AOJu0YyLFB+1kVHw2s9RULgwrE5+UaK5w6D7myPGS6BCe3xJPFsJuy44
	lEP9YBOzSdbMu9zc5QcQUq06bN0HeGIYGxDMKGyNdy8QwuWxY8bDojtOPA==
X-Google-Smtp-Source: AGHT+IEQLw1Z6HcJLCCuDODzQTlxf78fUcEwHoFhnU6fT8DU3G8YSldmM0Cm6Lho/CxAu4/sSYw7Tw==
X-Received: by 2002:a17:907:c7db:b0:a86:7b71:7b77 with SMTP id a640c23a62f3a-a90d510be5fmr11141766b.44.1726770889066;
        Thu, 19 Sep 2024 11:34:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610962d1sm749542466b.32.2024.09.19.11.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:34:48 -0700 (PDT)
Message-Id: <3ecec180fc9233d06ee85153bedcecd710666557.1726770881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:26 +0000
Subject: [PATCH 06/20] gpg-interface: fix a typo
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
Cc: Andrew Kreimer <algonell@gmail.com>,
    Andrew Kreimer <algonell@gmail.com>

From: Andrew Kreimer <algonell@gmail.com>

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 gpg-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 6587085cd19..cf4a72692d9 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -400,7 +400,7 @@ static void parse_ssh_output(struct signature_check *sigc)
 	 * Note that "PRINCIPAL" can contain whitespace, "RSA" and
 	 * "SHA256" part could be a different token that names of
 	 * the algorithms used, and "FINGERPRINT" is a hexadecimal
-	 * string.  By finding the last occurence of " with ", we can
+	 * string.  By finding the last occurrence of " with ", we can
 	 * reliably parse out the PRINCIPAL.
 	 */
 	sigc->result = 'B';
-- 
gitgitgadget

