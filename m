Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028BB3A784F
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768429366; cv=none; b=OF4hSz07hJL1QCyEWHKGhr0ubpnR0DbtZQpfcNzvcr8/sYq6RgGXM9chcrJkTAlw6XuiUEbGEsC/WdYXIzHEE6meKiiIhVuhna54z1p56xN3vo2wA5Fe2X5x0lUQYcl7/hF/libqYpDCbjemlLQ7oVrJ/N7ECy4QNlfoLKwR7q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768429366; c=relaxed/simple;
	bh=2LcywjklOh8PyfqC0RyQTQu4ibTkcUYhInrhXLDLjtg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GcGhas6c0jRSymUWlrDpbbB81F29JUTUl2vqIT76ZkNV40m/p90XL82k2++E+bouZw5k5JETJHm7m3f31SmnsYcNWnDAJg+8m7KjzmygkybyCGTLDBc1PgeN6EZ/uJzjrGORXxT52t3WQbwMAGk5uYwQAk/Jk2UVEDCE9hdwuFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQwuY6RC; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQwuY6RC"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-652fec696c9so432458a12.3
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 14:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768429353; x=1769034153; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lg+Ao7BZMPB1HXpYwY22G07CZJy0FvdRvIOCNCI84eg=;
        b=JQwuY6RC7TL0kO4dK375+AbcicayJWzUGW1XePe9w4shJswTF1wKqa7s3rj08YAZWy
         Vl9iGdM5/PPq3qN4se6QTfVbiJw5dfCpjf77Dvht9c04In8E7tmtlsGErVLCPMFCejX3
         jNi16wdIo+CVb1axLTpdn0rmyJqejU5fgg7x1ABTOIFe+Oib21cMMChajdugfZ80ikm9
         S2DTBnSSWH5GVP8+NbK5ER5qn+pCiGEix3vMEdvEKaTVEK4lOYyIt5kbkETyPR44Xr2k
         YqHNMT0Qe2roeeWcjlbJkRan7sjOi2NvBsXJRWFui48/pwEPBYve4PZKxF9dXTuiFJOH
         0wFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768429353; x=1769034153;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lg+Ao7BZMPB1HXpYwY22G07CZJy0FvdRvIOCNCI84eg=;
        b=sDJQ0dIIXo3UGZ6FTCndx11LYbLslaXkg0KaD8ldttWrvf4r4tcpILwdHCZIYxWYzm
         VdbXa9S9NqxfwIx5sEVNGXwjeUEW2FIvFshNRjQIfbqEr7J+eU7LH32jTLEYE3zyKr+j
         FkKGGHv+j5PRFTIvjPH5hANDRCQ2U4l9w85oOml7zmjry3n9nXa5ReeyX7TehHNE/Pph
         75i3qHQmagCZLgzAnN9Fq/oETcSBBqdxQlp817k9+sSHcseMdgfSQbdTA548QbClL9TJ
         OgipUptoN2V6Ia2PixbYzJq/P/g38Z9rbgphPgk2Jfq9oRQGpgT7836flA/5I08sN8VA
         X+LA==
X-Gm-Message-State: AOJu0Yz48izqPe8PcWvJGjscwH2aRj7fo3WAYytfQU0awHjpwn1i09ZC
	xZMjIZolL4q29BPj+0DSyP1sB7MYjljn8GrVCTBFsovQak2NXDowKqYlFmKkUPSx
X-Gm-Gg: AY/fxX6FIumYxWCDyO6VxAtr1Z6XxpZLr2O56VJnVliBrTNuUZ9gjhRABaDhoIV9DeH
	np/0/fefcQr3Zo5AsL0iT3WVu7Y1CrgHxteLbESS1o1qdGw0OlkRbxHBINocZHwLWFo2gc6DxiM
	+Ziv9kdRZReiC+WeGMrnqvJ24tiSIwx7ocUcXmiwxDfpWBupASIceIezf8Eu3dOoulZ3ApGCt7o
	RcKbI3QFZLaFDI5WZHOxrpJlvcBDQ8uFr4zTpVh3Zr62NR0JlwLGh5rAMJxMvdxRlNfqyxtaUWw
	gjTLCO+bRT4S4Yn0Ye9yLFwwWJIKy0ZYPhx5qMfg0MaZ61E6r9qimCeptjR/x2dmuVkjpYNRjy7
	fsYlUSIwJ5DPfLOu/OIcHQ5jAlIRqeh/hRYLLj/O9XGyTUgsatPeZBvtTeEZVe3QFBqAZBC8LyI
	TTWr5DPTYInY2LER5fjdmP
X-Received: by 2002:a05:6402:90c:b0:64d:2920:ef17 with SMTP id 4fb4d7f45d1cf-653ee2ae8d8mr2964261a12.28.1768429352591;
        Wed, 14 Jan 2026 14:22:32 -0800 (PST)
Received: from lorenzo-VM ([84.33.162.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411f70f39sm703170a12.18.2026.01.14.14.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:22:32 -0800 (PST)
Date: Wed, 14 Jan 2026 23:22:30 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH 0/1] diff: improve scaling of filenames in diffstat to
 handle UTF-8 chars
Message-ID: <aWgXJjO4zvCTOZ7K@lorenzo-VM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The goal of this patch is to improve how UTF-8 characters are handled
when generating a diffstat. Details are provided in the commit message
of the patch itself.

In this cover letter I would like to ask if this patch (if it gets
accepted, obv) can be considered a valid GSoC "microproject".

Also, as this is my first contribution to Git, please let me know if I
made any mistakes!

LorenzoPegorari (1):
  diff: improve scaling of filenames in diffstat to handle UTF-8 chars

 diff.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

-- 
2.43.0

