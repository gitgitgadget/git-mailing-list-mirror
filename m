Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5052777F3
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053075; cv=none; b=ZLCysmpjij4+uwxXy3QIOn8Vp2mhBfl9th/L/ZtZDMUY4ie8LjUD6ugr+A2MenQMeZW14vkJsOi6ceFsexh/VvEu2jghGzpA0AGdk2VqRKFbYf63W8nOrReAhFmr/GS/YKnIxdFnSgkGsyBd1tLXNNKJfbNYPg0K5UxcVshVXVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053075; c=relaxed/simple;
	bh=ErhiO5gEmP62SM90BP/mit8t+0NApW4QgE1BJ8wY7Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRxZpMBKsCSc4X726fpkaeyQ3PvOvz2aW4WRU6zOrDQjSSMZn/qBOAM8VBgFw7FzsuuDhBgop9zqCL38C+d4ECUuWBjZz1ykIkY4ICBvTQne5/GEAmU+wPDJgafAz2Av8kbqptoly4qEtSXQLDRle9gH36ca8DIKQovP98R9Hbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Fd82N0Sy; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Fd82N0Sy"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63f9beb2730so2700511d50.0
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 12:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765053072; x=1765657872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aIzFrlBdfwv62cj0VGp3kt3nL23QneuqEoC6l5xFO/8=;
        b=Fd82N0Syl2e+cAYR+FRy3d/tciY1+SqfPDCdUAEROq217WxC7DjbCr2LbM6SBLn9AV
         UIxum+Cq6uN3rxr0a8qXHJzN5+4pHTtPf5XNP5+5xfRZ9vLzpBLcNG7D0921UvKTrezL
         ZosgH2RZNB0oz8LsRG8/f8MiZum8CWaQ/3WaEACbf6knGF78/Esn0zeFqd4Y7dhfzPI6
         ubMQ2m2HKjz35gQ8HiwbnZmzkVe03tQ99zsOcTMYTM7OrGetDkl/ykZeCDfh4FVxcyuj
         fS/SE51zRNtniuv8Zd5F9ude8j1mOggip5V3gWtKcuY8w67kfP6MTYqddbuxLoGd9drw
         AoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765053072; x=1765657872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIzFrlBdfwv62cj0VGp3kt3nL23QneuqEoC6l5xFO/8=;
        b=wL4EFS35VVCkxZU1PBORMb4EhEKk+pyNrR6J5cZxX+33qBsDfDulDBrNg0FWsM03b+
         yCUt4f7+jaKy8uuAupaWUud+wONv1uo61RiZHkzzAhhzuulf8Br1rPw7ewLnNPsYQxy8
         W/LdET4aTKwUF5HCCP/xHfvYI9bvbtNtj3HF0tcve0anzR21IEC1Mnv7LdB+84HI6SRk
         UK1+uJcjY582hiCDQvmD1sGUpN+bH4m3sjVqK6baAletr5gV9JEN3s3rR4IeEb7jMcHy
         Dmlea4rDKHaXl0WcSWeKf4iv3Mlz3EAX7cRhGxfFDqHyVFhBkzS6Cejn00RSSca8OGfb
         u/Hw==
X-Gm-Message-State: AOJu0YyiYPi21SALPhhvYtV3Tx2jDC2mvIuwjSH3k9f4DM5wQGDmta6p
	D27qNlq9fCGkHKb28732irxp21FYtR3IBH02fltAh0LYgCpFL/enEutP7gcSa8ZpqVFr2GFxu/f
	x/megs/g=
X-Gm-Gg: ASbGncuet/EJAIlYm2A40B+WfcyNgUDXM+R6TmtgmcJO2ndWgEt1G3YWbKa5Ojv6hR5
	56tH4p021iqEiTP+b78QsAPnocwAw3I2fK2VGvRLxk5rcKkk9/bUqmTp2jU5tuJACzWxPAKPPhL
	OXt+5wmEfqMA0G8gTHoh8E8ErNwEXdWVrvLg+tT6NI6ltRXPk8r8P2aZI7ku2wJagHz27o4k42F
	ha6UDn+JhIBWcSYrNdfOkVHUQuUr6N5WSBjqjzTCSEn4Ma7hLJU4rZTgoVFQ+dhMvTE6U2MN1TP
	Hyn7rFZCMtAywo4kdcOd5d34GK8Yjn4zwtu1Q3Kg13D2E7p8U4CliJn7RmwTD2wK2nuRAk4Un84
	U6FN5Nb3SUsy/QA3swT/h86tf9vyncraHRP/QwN/IrzhQcnq77J7MwRtUdvXdYrxw4p1QoXSDKl
	Yl4W2rYpwvYmDew5tdlSfRr8rI1uSQZIhHuIJx3v+0w+T5sej10PJ+PfCs4pDWIvrhymGaAjigH
	ZUOkv+JcFGTKmx07g==
X-Google-Smtp-Source: AGHT+IGqHL6jVmLlhIyX+r3nSjGsyRjiMJVc6zhCYiUrChUjNrIGa4/oU3vLR6D812aIPhTJATqcUg==
X-Received: by 2002:a05:690c:f96:b0:786:aa47:7567 with SMTP id 00721157ae682-78c33b4b5c5mr33117027b3.26.1765053071876;
        Sat, 06 Dec 2025 12:31:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c1b4ae534sm30911427b3.3.2025.12.06.12.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 12:31:11 -0800 (PST)
Date: Sat, 6 Dec 2025 15:31:10 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 04/17] git-multi-pack-index(1): remove non-existent
 incompatibility
Message-ID: <66411e25bb49546500f10a3d3734a2277ddbd633.1765053054.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1765053054.git.me@ttaylorr.com>

Since fcb2205b774 (midx: implement support for writing incremental MIDX
chains, 2024-08-06), the command-line options '--incremental' and
'--bitmap' were declared to be incompatible with one another when
running 'git multi-pack-index write'.

However, since 27afc272c49 (midx: implement writing incremental MIDX
bitmaps, 2025-03-20), that incompatibility no longer exists, despite the
documentation saying so. Correct this by removing the stale reference to
their incompatibility.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index a4550e28bed..a502819fc38 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -75,7 +75,7 @@ marker).
 		Write an incremental MIDX file containing only objects
 		and packs not present in an existing MIDX layer.
 		Migrates non-incremental MIDXs to incremental ones when
-		necessary. Incompatible with `--bitmap`.
+		necessary.
 --
 
 verify::
-- 
2.52.0.171.gd6a4e6b6955

