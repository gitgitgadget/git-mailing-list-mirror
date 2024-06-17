Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD542F5B
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 05:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718603878; cv=none; b=T6QS0bq7hiWNgpSbKy+jD9ZsYlLRInMhycmW4Pq+aWitCvYYdWEYxPZRluGRZ9eHKl0O1sQSh0LOz9EmKJ0AeA1dEN4WCUTBUwkWb/T1cJQNfyuC8PwIZTiIFsFPTQYrZwNKT4YPoio1fgj0OmDk+/IDnWTmJuVd0alQwqjLtQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718603878; c=relaxed/simple;
	bh=3qMIIF/0GpudhbME623JKTGUri7Ke63A+Oc8+fGFlIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqdGglw2UOT3Xl5Tp/wOVZiNJszmfNuZ1XGOj6r0Q/r3gy9zNWW2Cteg17bhGWjjzv05sqqkA2iqkm+wKoU/gkGtOuMgmtB0RKFOj0lRbFNQ3zXB0eQz+dPieOxDdEsprYxPyRsQV4GxxugL8gCWnvRcFnhBMTu+u5HDbB2t3s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8iCZa+4; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8iCZa+4"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-656d8b346d2so2832375a12.2
        for <git@vger.kernel.org>; Sun, 16 Jun 2024 22:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718603875; x=1719208675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MQcqGJm49fToOUbnv34MLcSL/JYUC1GMZ4OGFaUB7I4=;
        b=c8iCZa+4Zxg/R30hyJGC/L3R7gJo6BLMPj5koidscCj00BeR9mZCCTnastnwut2oZt
         ypPL83+nmKpY3Hjt5h/it31T5KaLlqPGJ9g9vekxZnQL0GX/zT5MbZNZmMwH86l85mqF
         oe2KN2mUZ4M8fb7W2qHF21IRJ4iLL4PQSVJ1TN1r9a8oSohM+V9Jxw8o9TaKXh2ftLcS
         U+T0VsmchCEd3QRJ7vlU2mnS/QO2g0WF0wzkIaGYIFftEkPe1ZlIDcZBQsE6JWJik/7P
         W12GCwHx+T0cn575Hg9GjkVyaAfunVvrV563dAsZIcpj4dI7awBAnsej6VgV1SxmhJxc
         F0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718603875; x=1719208675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQcqGJm49fToOUbnv34MLcSL/JYUC1GMZ4OGFaUB7I4=;
        b=gW/TdFYqEUPul0pcELVYoCTwplAkdp5lN5bsL27ev2RpqydZ/xP7hFxLg02jAiROSn
         kLhu9nsCysVAzOK3zKdvgb50PU7Lk1hAG6g9+374+UMCKbE3nEisq6vq2TfOc6RLrRVZ
         P2tm0XPW7IdRIv3N0oayz1VKp8R5GhhrCQiw2eaENDt1qvKY+cIERRavRiF+RGD5ZThp
         kSqVMG059PIVGOCV3mpZDYkJlrjIX5UzcqV76WiHpGkM2TrgWrnreyQgaiYel8HzVWV6
         sAQc1Z/XBmGKUa36g3GdEcVRq5LOHXOloBsHU49og1chIQxaYhTK+xPLj2DCcDZS/uxa
         clfw==
X-Gm-Message-State: AOJu0YwhtFyG3VsmkS3WwJlMw53/5ziWIUxPoThPTKcWvNfKgZh0qkR6
	md3uDKHQ+VJ0rgzQ6PQbGdlA9B0cbwrQDbKMHTkYYDd9Vu2x01M2efrlTg==
X-Google-Smtp-Source: AGHT+IEaLx78OShz77F2O6keZuUnozz6V6oLScuK9+I8daOpZ2hFuIVyk7wO8Ifcwpft28GVBmhQ1w==
X-Received: by 2002:a05:6a20:7350:b0:1b4:4568:4c3e with SMTP id adf61e73a8af0-1bae7d9b7ccmr9197725637.9.1718603875573;
        Sun, 16 Jun 2024 22:57:55 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1cbe9sm72956695ad.247.2024.06.16.22.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 22:57:55 -0700 (PDT)
Date: Mon, 17 Jun 2024 13:57:54 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [GSoC]: Implement consistency check for refs blog
Message-ID: <Zm_QYoij0rEaG9Ii@ArchLinux>
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

This is my GSoC week 3 post:

  https://luolibrary.com/2024/06/17/GSoC-Week-3/

Thanks,
Jialuo
