Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7597631E116
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781227; cv=none; b=QlSvpZ+uhFctS5tuLXJZ5Troebd7Kw/80bI5JJaOWuJu2DqUaO4PceVrO1Z9/QNyAe7REGgpFZBG31VNwWaSFEFqwO9EnwWgxvaCw9cE+ndQuhhtzLa0A3KYog8gqVYFMcT8ia2URsNzm+GflYpLZIxKB4vXvN+CozrgRe23Yik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781227; c=relaxed/simple;
	bh=VWUmluPhzdLiks9cGcFRXUfN/vo4x2ZCjlzjvOv07/U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nddq9iNqgpBL7EGf5IdZrRa+W+ETuUtgWiTV4vUCE0Gy1nr/wM234zPotyuNDOkSxeZwMVf+ATDH8KTYhXBMVH9JqCV3VkppF8v/DO85x2N1DJng6fWaX3zFun1sw3yUI8G3wSZwed1g6nm6MY+MNcvwHPbJagE/zDHf6wAPv90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3Y61rAh; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3Y61rAh"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea79219so1192583b3a.2
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 06:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755781225; x=1756386025; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWUmluPhzdLiks9cGcFRXUfN/vo4x2ZCjlzjvOv07/U=;
        b=S3Y61rAhcDwziMQMFGk7rdlOyKjKkLQ79uGnfmsGUes9AutnRk46JA0FkfyEX+Aesn
         OVIJLnDP3Ws+360z6euJ3u4KkkKLzax6BxJayJRTW9U1v2UZs6EQKswigkCJXlM532C1
         mZrPRPJc9SFXhVYbvqcHzc8+ahGsYb2MId0AXvy5umvzFHehzWMejZMGPn3y9T7EHUCq
         /auRQHQyuL/8d5yKtvMINBdaSwzqJlRIUxzj3kuom9U2lDXAp2W42LWLl5MEoWYxo10b
         +yfBCUCpaoJvwbbCd3gXrywt+1kAbGOvSVmv/G7xUhZJ0TujUfv1HvE3gIlO4e/BrQv2
         7zDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755781225; x=1756386025;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWUmluPhzdLiks9cGcFRXUfN/vo4x2ZCjlzjvOv07/U=;
        b=ECrI9i8bXnIUpJZXSOMB73PUTFajg9KJIM3H4vR/8TQtnoAxgHhhmfdqKe5Cdz8mh8
         PYtmQnnbIud8xFfKpwZ0hQjUs+C4vl8ZLbtRYaoZkzuBUcJ9WgezHpJDUr4xNQ4PTCcj
         D0sH7h2yG2vV2lTYBO76wFCGCGNL3TAUWCg9j8e7YLiuFLZrrl/RjW2XtflhPkiLZ0hJ
         O8YYKvNwJcIoHc4tLA//nKrK/dVT9lHxxBmb0NXCtYl4eWP9sT8Gfdz5+gWyb0LLkfKf
         HZVYtaqTpBSVdk5DQFh2yB6Pssj4ObtMPLly9H7GBvckDCpVe2ZkYDa+sC9zRduMlViZ
         EZdA==
X-Gm-Message-State: AOJu0YzuX5RMPBmPkcWrd35TtnoohKnJsy4otkPRQCXZJuYo7N1fcln+
	OBAfEGtV6P5jVBKJ9VfBp9PoHFS/jjZRqXgtC02ULVFjOQdChRN1+LHba1sUMA==
X-Gm-Gg: ASbGncuUJO6OKsSJg2VrKZixfehc2qc7ElwQM49bu11TPm0clY6vDzkLEFjsd/QPMiL
	DavqKoIey5NpVwNhCOvRug2JPiAv8k5LywL5cUDVWWxdbgv59JnB69ZzBxj2PCgvYq5whhF1WBv
	k1wKksHryK6Sfj0eQOMJTzkOQmRfkyM2pYDehdbz39Mxh5v9gDVCdRk2pH8oTH2I7uxEBBEMP9d
	19zCn3E1oWmp3wMJSEbA0T+1oL/BQDjatD3R8htB7BBxTEeJkuw482ymNZ3/VRsTezd7/ArtE1j
	VDSgu7x9CpzR8fr36FMmiLVN12nvgVCGI94GcTodbI93SKqXe7JIUD+0mUJK3giLion+eP2UrKM
	ZxC/UJhRQUa6KaH3KLwjwb9xpNaa6D2Z3aBM83RX5qtILSRPmF3I4q8YxCxhn+je8UGk=
X-Google-Smtp-Source: AGHT+IF8m5MGEyvXebT/Abk1SDRxOLbswr9eIzpR7Blj7vAAbTp12hoxzW5exgx0IeRPzvFA7FCNPA==
X-Received: by 2002:a05:6a00:3911:b0:736:5664:53f3 with SMTP id d2e1a72fcca58-76ea324704emr3013438b3a.15.1755781225002;
        Thu, 21 Aug 2025 06:00:25 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d5242dasm8247387b3a.77.2025.08.21.06.00.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 06:00:24 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [GSoC] Blog: Machine-Readable Repository Information Query Tool
 (week 11)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
Date: Thu, 21 Aug 2025 10:00:10 -0300
Cc: Karthik Nayak <karthik.188@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
Content-Transfer-Encoding: 7bit
Message-Id: <86AA99EA-12CA-4F14-9240-1FF4FBE8D426@gmail.com>
References: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
To: git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)

Hi!

Here's the 11th update on my GSoC blog:

https://lucasoshiro.github.io/gsoc-en/#week-11-ago-11th--ago-17th
