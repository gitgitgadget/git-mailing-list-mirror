Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D7F80C07
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449033; cv=none; b=Ju3xGq47G8yeJntXT4UOJz3rCw1mvxRkytZB1PQgzy0IHpDIBypx4+b/ChVVCyrQCfeT5yhk0446CcfNK8m6RPI+93af+77DVvF+popenOv0KD7SXPbfv33Pg3DiY6wCgPYIbXBOP072vTEFl+/cuMxD4zF1SdmBR0nH1CVuPVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449033; c=relaxed/simple;
	bh=wB7aFd0l7XxIQjK2YQgbgAN/peOqElVwFpXsElghiVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q19/+kdfsepCMyqvsqet6RlKB2EbM8jDr7HLak8Hq1Ff/oSbYC5QyaYKMX7SsGr2EAlcuuW/3yjlhepin8OCQj6VSk9ZpZS7f+IaJqfiXlYc9PODuX1fDUUH9UvjF5zEajxAolqqo243Ng4jNgt7Com4lSLyl9tkeZri0MP6VzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqexWxgZ; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqexWxgZ"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-703607df7f3so1063671a34.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 07:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720449029; x=1721053829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=411n49TYT//mE32oBDeJQwOxvzlontQ2vDlI3zP8JTs=;
        b=hqexWxgZfN5bKoueyWkK4mAnp6W3CACP+tBBgUs9X8UYMbJOxDYzLyz+XodJougvHO
         zpdvoCLmAn8EIRyMlC5O94yuMlxzYzt9FEOXwq86vAGvcCI4WDI/8g2KDTjAdkc8gIcN
         ewJHg4CsAR/qp4IlfmkFdNWOyNqBJ1GCF7MU6RbEMWvWX+xn4mTmARkc4CkSN4eSKqrg
         wnkTTtfAJWAAG1Lfex55X0IrQn5ytMCsaJYZnDeHexHoe8cBziSUPDIDzAgqIO8YFEbr
         e0Z+wrwYsX4AQyHURykNMxI2MT4Rz2iaSxy8qsKORTcsCHjITXUnxomrWzG1d2a1aRhe
         HPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720449029; x=1721053829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=411n49TYT//mE32oBDeJQwOxvzlontQ2vDlI3zP8JTs=;
        b=DM8PIzXkJ4QlBqBWSvzuHShiFvlG7tGct6ZLrLNTa+F+SKLiiXWcWA3h0MpqB/VAEw
         unEaAmvoQ/zBz5BRj7/Qz+8Eui5VjRGlbL+D7nnPnKobw7oHRFpAmcuvJoTi3/w8QC4y
         SyKwlIuKOAX77a5YCngyMJesYgvJLgLlsj2HNkH4FVzFY3ndebLAQCzOyjKyLK/B6ZPJ
         tejTV9eBMW+nTccqKVkBiaCYJPyFXZEYJtlF+HkQsaxlxMPG27aR+Wbf6lPIjY2NLVAG
         dfqfj6YeVvkO6Wg27CidqIfcHtuK7u1bDAq3mSsz7TU5W0HeLPa4HtfM9Ri3u5sg5c1J
         7yaQ==
X-Gm-Message-State: AOJu0YwBVB/IZ8R6s19UXOVxkjV/S8d8Fwk/mmfyS8jc3iOjRA1hLm21
	E2V1xtouGBsaOMhF0FLLpdJyGXcVyj9RRK/dvtjEjS3xSQy/z9WvQDhxOOQL
X-Google-Smtp-Source: AGHT+IFul0kUjBLC4PXE5XBkQwutTflLiseNBhnxKhfJ0v4HGkAWPEWeZhR6OBb4XEzIetsjIPcnAg==
X-Received: by 2002:a05:6871:b2a:b0:254:ac99:1152 with SMTP id 586e51a60fabf-25e2bf1eabemr10273695fac.58.1720449029355;
        Mon, 08 Jul 2024 07:30:29 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70afb8c3299sm8506697b3a.156.2024.07.08.07.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 07:30:28 -0700 (PDT)
Date: Mon, 8 Jul 2024 22:30:28 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [GSoC]: Implement consistency check for refs blog
Message-ID: <Zov4BHi0z8HmvfYr@ArchLinux>
References: <ZlQ7j9HYVOpP2Xga@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlQ7j9HYVOpP2Xga@ArchLinux>

Hi All:

This is my week 6 blog:

  https://luolibrary.com/2024/07/08/GSoC-Week-6/

Thanks,
Jialuo
