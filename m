Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279F2134CF7
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052954; cv=none; b=fKj8T/vKswxTnj7VF+K9owG34gKoEcbYbfidfLMLna7fP3zkcDyiIvNwQ+VJfRS6YHjADX2ZjSr0yC4cQu/Kn96sjudUbjEe9KHTw5t+XwWhbEcF7auTQY+adxVM6IjmsmO+CwptysngDiTO+2BWUGGwJ02PHRIGIkk5Iq+e5tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052954; c=relaxed/simple;
	bh=Z10LqrChNW+H6aKxCtmffQ7qa0EHnoBwL/PYP9recLU=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ITkIUMZV4/ya46N04oV5MIQiWcQbI6+ZeMUDQUdGGVyGPOykTMB7xix5hCosqM1JI4gXBNHBxilJTg7z88diZkWS+mnhFnTb+Va5VMzhH1qzC0hIrRF1a266h7z+huNLsjh34Ri/gS2zpv9aoNCOw6LzW8gR/Io9pM7zZk8wKyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foLSeTpA; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foLSeTpA"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33fd8a2a3e6so810296f8f.0
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711052951; x=1711657751; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlZn2lO50QkiHeWsvdqT8i5vxrXaV7D0JMwxesW+kiw=;
        b=foLSeTpA2k9SVEj+JmhEiGu9QroXG3hAYSj9YTYYT3UCAixaPvr3YfYF6DQIj5ph6Y
         /YwsdoBJMAftolUUUs/nHj8poxqteQ0BmC9MKSlPU7m7VCi3HCGGwK0Sl/ro6wGumPVM
         igC6Vwut4HcCUn05PM/aVW2hexT4Gy0uCJkFJyIQUig63a2+j8Tb7dNh+aNAVM5Z1L8w
         hdh7NcgmMaDDUsoffqsrG2KtsrGvLb9l0zSd19Y+4vWcTrxd7EX3uRA2B1jqxPX9p3mA
         9Pc9WSMzhH9r5MpHW23zsnYA4iZYSF4/48U/lN5A3iDN0NJ+FBVzsEIzpEpeaz61GfkJ
         Cfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711052951; x=1711657751;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlZn2lO50QkiHeWsvdqT8i5vxrXaV7D0JMwxesW+kiw=;
        b=AXPxGVYSl4dH3UdmBkuifAD6q8E+Hp/v6pc3Wt3h7Aksmc0t5hWH+0c0IsyPhpbmAP
         JpGdDtp/HR7ClQCFLi91M3GXtItSPthGuMUIlrNbdCkfKwkwbGQa4/2eLd03DxYNOIUW
         Vhl0CF3cpyX4CaU6hSx+6kIJUiz5HSvwQZssst98yRBPiKRWA/zZ0yVxNFj1XgTxL00A
         v+U27QRDj1o2yjVMf1+0M9GEMweMq6Ro6YXydsncWGR1s3kYUQfdPZat/C9HmlQNy7VT
         TUGoID0NkGXCDFhoF5f86wKuHb1c86PV/TKjSjJxCahA6fBRiURK4YETeF/mnLktZiRj
         Bccw==
X-Gm-Message-State: AOJu0Yw4M72XnicfCaMK7nw7J/XSfO/LYGnJXxWy9ky/XtNglB0i7Tr8
	lI13vj+HKACurm5vZYEUVOvuB+jjhDNNeM/OOcu28QET7x/UTZJjoCxfMA6a
X-Google-Smtp-Source: AGHT+IHW3WcMLgZY6ZklDCzHbp7sx/VudqMLFM/hiFLiKKitckZlYXM1EpVfWwSPrBavfY9dg+T6vw==
X-Received: by 2002:adf:a30c:0:b0:341:b4da:a33f with SMTP id c12-20020adfa30c000000b00341b4daa33fmr60662wrb.67.1711052950552;
        Thu, 21 Mar 2024 13:29:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h16-20020adfa4d0000000b0033e9f6997c7sm403149wrb.66.2024.03.21.13.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 13:29:09 -0700 (PDT)
Message-ID: <e25b5f928a9427de57ff1963d9fb4bca2b86e829.1711052946.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1691.v2.git.git.1711052946.gitgitgadget@gmail.com>
References: <pull.1691.git.git.1711049963.gitgitgadget@gmail.com>
	<pull.1691.v2.git.git.1711052946.gitgitgadget@gmail.com>
From: "Sanchit Jindal via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 Mar 2024 20:29:06 +0000
Subject: [PATCH v2 2/2] t9803: update commit messages and description
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Sanchit Jindal <sanchit1053@gmail.com>,
    Sanchit Jindal <sanchit1053@gmail.com>

From: Sanchit Jindal <sanchit1053@gmail.com>

Using the `test` function directly does not provide any
diagnostic information to the user, in case of a failure.

This patch replace the `test` function with the helper functions
defined that will call the corresponding test function and log an
error message if the assert fails

Making the replacements
- `test -e` -> test_path_exists,
- `test ! -e` -> test_path_is_missing
- `test -f` -> test_path_is_file

Signed-off-by: Sanchit Jindal <sanchit1053@gmail.com>
-- 
gitgitgadget
