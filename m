Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCCD313269
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094886; cv=none; b=BrFlh7FFxrMUlJVH47/e2y3wiBrUIxlm9aQHe+Eaw4UOT4jyOtc9XpcUo5bOqgFFmjaph10UzBTTf8Fc/0ZY+oFfPx7Nxxr9e9b8pYHOn7dbSFhDeJO8Y9j8A6yq4C5zIhcmwLiyAE+o0N4MDN4SnctCAvPwUFOtVpSjDPoaMhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094886; c=relaxed/simple;
	bh=fmR3uYsrtC+Y6FfrrADIv+vLuH8XOktOBA3//e11cGY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=uRH3YVDCgIQDcrR5tqV2+yhigkG/pbMdRQLKkvXiwzTLTxLTJGwrNpc36J/xXcQA7aZdlxY5bzy2EvgvbJmrr8oa2JKpps1CIi5GCLsnUvN3x0iWECotXMwWgvlV5Y3pmscQyNBa7W4dXKPc7TsCuejAWhpaWU1hzO9V5xOBucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=djamo.io; spf=pass smtp.mailfrom=djamo.io; dkim=pass (2048-bit key) header.d=djamo-io.20230601.gappssmtp.com header.i=@djamo-io.20230601.gappssmtp.com header.b=c6u3Lrew; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=djamo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=djamo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=djamo-io.20230601.gappssmtp.com header.i=@djamo-io.20230601.gappssmtp.com header.b="c6u3Lrew"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45ddcf50e95so2017435e9.0
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=djamo-io.20230601.gappssmtp.com; s=20230601; t=1757094883; x=1757699683; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJLrOgirP8fYZp6Mp68cpTt9BQuibdvgYB20gUxhA3s=;
        b=c6u3Lrewl5+ExZg3ii8mHv4yDBDOWHNvM6r8NlZ93zo3K8leUnQvBM7RVHuGlbfzR9
         x5PNAPO93SBhkKDj0HAoqLu/5UEF3UdjpznrljhzfUx8SqdblB1eChEOVKcP88FvyXbE
         nCWNs1INSAw/dHX6wJo6XLKO8M143eWrCZ2KxOmzWGX4T/10+82+ZGbkmZJeLK8Nd0zf
         GHR9GDwEXrVyfoECHuwGGQKfy3TwiW4Ug0YL4F/BwF3gEGXN3thqSr39kUUvi7HZ5Vmb
         MZ8PzafwnYhjqwolqvzH8KwCVRdUOVpEbUTxwroSPVEotOCETHQzDySAVVQmYi18U9m5
         Xrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757094883; x=1757699683;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QJLrOgirP8fYZp6Mp68cpTt9BQuibdvgYB20gUxhA3s=;
        b=CgCPY7WxaFCxvuPPJo/DgURtsP6Gl2fOybCQW+0JLJvqsb2IITFWUiaRi6E/ayyrQd
         aEFISkunstaBznJSkzuVM42vhjN+i8ISLGuSMmm+8EI+StMCeUfpiB31SjJ3b3xmbqrA
         Uq0KuUQOh7W2fXAFr1AEAfvkVyznQwW1+n0FJhHjxwg2JclteSsdNswXLTVTtfyPnabc
         s6lqpoxilFn092hV2PNen7yd6HiUjA+y7qLbYzvxBXiUH5JjtU5Wo/nRMe/KMGdogm+Y
         VERpturbriPnfWMwGvz93lEHxv/yXS4zvGgin+89m0+i9VcAOn9Db7lfxz1YLZ8tL+3j
         P7XA==
X-Gm-Message-State: AOJu0YwoPyHvMRGpQyLJ30CxzSo5ARn+BalnOeH1nyhYKDsvU2ePY5yz
	SBbz88ilXkyTrufQxsbvCl6EwVFktyuAQsE/6GgaHE0FlNYHireQgvKhEHoic/eh0Ie14Fio5es
	OV45ZUC0=
X-Gm-Gg: ASbGncvesUpaWsTZY64oFWLms2S4NG36SE2y5B5AoJMuBxhstVkZOPl7s/4TxDLGtm2
	Csf8xpZk+y84CaBELk6X2Ln3Igbr6VeMmzQ60Bm4hFJ+xfraO3A840xvxtZqtOQC8s/4Ep/bE+4
	Tgd4CqdBHSlmjcNP4akmD391e4nEl/kKpOop+T6N+cEg+gvlUMKqmQuj+otIaM27eHDL3BAUmFz
	5kV2o6qEcjXK8+cad9SYYoEHUcD3T7vV9MtEmweNLv589S4uRx8iirwjyAeoRirLYuD6jdrBIDr
	9fwvIiCuvkqG+a/ZnGhXDYLub37Jg4n7y2HmrSLgdfD5y364j7vidIgTaKokOMnZ+pLYzAkoUKF
	lHKdOXCqLNS1SsYoKc25m+OHD98CiSUTiB0if
X-Google-Smtp-Source: AGHT+IGfmsNfigjM+EmkDLKzaYi8uYvgyqRQMNu8ZcplBW7+D1dcC9Cng0DorKYktGtpDfzh+xItdw==
X-Received: by 2002:a05:600c:4452:b0:453:6ca:16b1 with SMTP id 5b1f17b1804b1-45b855ae8f3mr200158355e9.26.1757094882888;
        Fri, 05 Sep 2025 10:54:42 -0700 (PDT)
Received: from [192.168.178.32] ([213.219.130.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e50e30asm340432775e9.24.2025.09.05.10.54.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:54:42 -0700 (PDT)
Message-ID: <c0352082-f8f4-45a5-91cd-652a91887b53@djamo.io>
Date: Fri, 5 Sep 2025 19:54:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr
To: git@vger.kernel.org
From: Vianney <vianney@djamo.io>
Subject: Reporting usage of whatchanged
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I ran today `git whatchanged` and realized it's nominated for removal, 
but it is possible to report usage by sending an email. I'm sending this 
email to let you know that I still use the command.

Best,
Vianeny
