Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD14E26296
	for <git@vger.kernel.org>; Thu, 15 May 2025 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747315376; cv=none; b=DaP6429wrNFwgol0TtknlxFbSI4ZHZoRW6/H7fD5hqoqnFb7WG3pUby5BfG+Hc8J4E4cNjkjQh9KfxzDq6G0rME2sPb7Y8IJE9ercRK9ezxi+0sxDwgP0wMC5T3iNr7HnPLkT+92cuHuS1fxWiO6VS/07NoDfcHRADJHSAhzYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747315376; c=relaxed/simple;
	bh=Ub+j/Uh3ZjHJl+eet8sRBSYsRY5saDswIo72kDIKSrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnoUnEu5laknbqeJgSDgNZNywEbLK16d5YAoHC4/s5rFH7sN2OajJCyhGMzpF7sZjpHOfjA6ai0jI7zvD1STNxlIY0lKsw3D8EdDV7PCvssB9A15DVhimjnUL+Js6DJPn9Kb5Loxtqpz84hJ8YB/++S4xWgvrXfUg+mZ6S4uOhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=B/CiISyJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="B/CiISyJ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-442ec3ce724so7506975e9.0
        for <git@vger.kernel.org>; Thu, 15 May 2025 06:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1747315373; x=1747920173; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZdZx3srqPrIYro7PfaQmu8Ou1AE5Y3LCzRd8ldgos8=;
        b=B/CiISyJksUfiXonNpPH1vr0t5Fw7ruYqwZ++IYlVxLa9CE6iZjz0fkFUvQGs6A1EF
         1xwRmz+zPkDd8ir7PXKwDELwnoM0oS49YLFejv4zLRMoXrjiPop/KmigGeVfX23Mn2m4
         n4B1+8uh/0UxBq3r4XqR+TkDhKuMKOBZ04uzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747315373; x=1747920173;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZdZx3srqPrIYro7PfaQmu8Ou1AE5Y3LCzRd8ldgos8=;
        b=b3Eiu5jjGR67SXlO+nCuyhLypre4nEGn2CJIu1O2kZzmh5mQ2O5kAFoQgrO3z6/u6y
         5MT0qxEDhIRizT25YSvesr426KrK42prBXBc5dVt37BhDEBgKIvWABhkQDt+MQcWTj8h
         viCykcMt3EsRVXZZ7n1X5cdvZ6bBT5+KlRb9631XKlQ7d1rQRwCcSMANZrsgWEW8JD+8
         VX5NLcdG3vXOcYoD5gqCvOFp1b+GXOi9teYkUVwVNf8dmCZePDKetwqRNzM593CdoXeO
         7hzg4UO8TLWT//6M/1oK6vEGLwEXnojvY/wEnKPUywt5D1ItJjIPfj6hCc0ZHC+7Fg+1
         TOTA==
X-Forwarded-Encrypted: i=1; AJvYcCW8G9vatuY63dTkxSKwdkUL7WKy1f5YPdXYpCI/I0zKtVZ+gKptmEOofdXRKsF9X0XZGGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj2TTbvhGAMheDnz79IQpn+2Bhm8p1EbCN3Gi0uN6Fonas4EpO
	IJ9d0abvwN1rocYzC+HQu1j+a6YG2RVy6kFu1w4nFA8js4LnOybtExH44jF7cEc=
X-Gm-Gg: ASbGncuJbrHyRREKlJhDSE8fnljE38HeV1kxOsFewtyiRn9tTzG38M1YO0yO0eEsMsl
	/C0pS/Tq5oDM43ccru9GN9176+Hk+rx4OSQMzPpTp6iPzEeXF+EnQKvjvvlpVNUlMN2G8Zh0IJc
	BX49yHIX6Dh2YysFurr4+3PTpx1IwV9SfmKND5bXDsyf6VCfbhiSwAoOdhh1L0TXwU5Y2u5+vtw
	6qJT1yUe5aOgyTJdoDeSWQVc/UEId56QFoGQ1CIBSMjIBdzE7+RHrjNjz81DUs1DH3w0S9QhIFd
	wldLIgbaLVAcXi9zd2mbdUeNJZ+sX5krNhYJl6Nr7kjTuvMO
X-Google-Smtp-Source: AGHT+IHkd+JXUq4IPiEbiGmzoMKSUPna4GdH2AHdtptjmAFE/7mmG05zcH0PSgiOYSFYzhJgcG2oog==
X-Received: by 2002:a05:600c:828a:b0:43c:f050:fee8 with SMTP id 5b1f17b1804b1-442f21691fcmr66544315e9.20.1747315372781;
        Thu, 15 May 2025 06:22:52 -0700 (PDT)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3368fc5sm72582915e9.5.2025.05.15.06.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:22:52 -0700 (PDT)
Date: Thu, 15 May 2025 14:22:50 +0100
From: Chris Down <chris@chrisdown.name>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] commit: Add commit.signoff configuration option
Message-ID: <aCXqqj6gKc7-fjoF@chrisdown.name>
References: <aCM5JY25NVPgyYRP@chrisdown.name>
 <CALnO6CBdhYFsDN=HPo9HbKeoZH7bb=xVVXUCK7nUdadLg-U_Pw@mail.gmail.com>
 <aCTI7VjK5QMht3ws@chrisdown.name>
 <xmqqy0uy4thk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqy0uy4thk.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)

Junio C Hamano writes:
>But an old mistake is never an excuse that we can pile more mistakes
>of the same kind on top.  Otherwise we wouldn't have learned anything.

I'm curious about what specific issues format.signoff has caused that make you 
consider it a mistake. Has there been evidence over the past 16 years of it 
undermining the significance of signoffs or creating other problems?
