Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC58625776
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754167111; cv=none; b=DVySKaUHF+JILIcccoBWo3ZcQ2jR6yo/PlnGM7ZYU1hziYIFDYvusHQ3CKPB1wubpgjtd9gkrDgKxOy/wT7iEz0hIbsmFgw+hNbiGOQn5yyZHGoSPmME1QoZq+PQHF1l46dy5S1R6RkVYj7U17JKwvkM7AI6uYktJISYCA5C34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754167111; c=relaxed/simple;
	bh=+NdCwvZzUsALPD5+O3X5xBKw6iLJxYUwKFnfxUwm1uo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nu3qKAw3rMhKFFOFLTWhnV7cbX1pUkY2VLCZR1UgzX0Sdw8gWvJwMFMfTd7OLSRSOVky1PfZA7KV3TyQij7JIVYKLfS5Ee3Y0pXTqiB89SAClCqOkGkqRhhkAM7RCAmrOKTRTy/9KjXOPJqV1IuRX8Ld//Fo5xQo1UmVzeftBO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDjEdxp7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDjEdxp7"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76bd2b11f80so2568039b3a.3
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 13:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754167109; x=1754771909; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NdCwvZzUsALPD5+O3X5xBKw6iLJxYUwKFnfxUwm1uo=;
        b=LDjEdxp7AtOR2a739QQH6m40EqKfdeJA64Sw/+4ETI99e+4nGCebDfx7P8prBhYS5H
         zs9l+tz75UdU6t+0t5evh+5/tfwhVloGchn6AQaA/f2XjE1/ljDOoa78w3jOoGPRzC+M
         l0k/m+BmaujDG7w5e+A2ccYnnkHu+QaspRY856f1U5Eq6EH1a9NziB9j9i0Hecx8a/RM
         oSNpVqVeKVpRgTptze2cj7LUxCI0dIMFBxfthPYJ5Y2wcgdoNwhKDFS7EG2fCfNY7qnU
         uGb9q7PjKfPRtsW2Y193ZtYB9ndJBEEgDIItQ0ESla/VdHjlHkiO/gie9Jzz4QO+He0V
         V2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754167109; x=1754771909;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NdCwvZzUsALPD5+O3X5xBKw6iLJxYUwKFnfxUwm1uo=;
        b=tft9EpUEZDZQy8rg0waeK+adD4WO2Ats374d3G22T4F5JS8T9ql+HCIB7ZlqcLJxRk
         x/mvUXcZMDI2IiL4PsGFGpBbQLriLWkwXR3lUxT3b0PhrXhKkkyhxHq2KukSFCLBD1w4
         J2on+AUfZ92CEe25GJCusaEo/wqQs/dwTOCGuAg2ccvhNPyADBJ/cv9nbTubazwZFCY0
         eEV1yMACHlneslzWCQmaYCJTg39IMe3DHxF6PxocKzLft39PCTJVGribK8Mox5cI0Kk8
         Wm6znKQNcDkl5Zc7XGX+JX8vcEqKQRaLIJYygDUbiT3xLSbgkiOtQMPZShCXgfeXJtmo
         wxGQ==
X-Gm-Message-State: AOJu0YymiQw8n22MNFdb/2ySWenPYwSr+aP6CB33PKa/SrFVduzfUBIe
	hUkNZZsgo+tsv3MDtAzAdIfjSc8H5yuihxPye+OPR4HWS0VDrjAWVUTt
X-Gm-Gg: ASbGncv4rDbm8t5mfMkxP3PqDDQ9Cda+bgpoCNXEf8YYL9aoGJcfCD2cdnJBr/muPy8
	D1+elD0ydHC3n7dtDz8+Rfgkyzc2BS51JJoLz2YeCl8ZR7BM3hd8G4cUnEERxsahWVn2QJUbmvb
	VZoptkNjjba4wRF5dv7VTgTrpY8HlCrXzI/Bbcb2N/0ptQhbakYD6TiRqghh1mSQxfX7Y09EVKk
	hpFBqvRksSsg1cMUbRdqyUsggnIOoHvMTC5JgYH/Z8T7BK8u6X4mlcQn92489yusNjD4FPbPtub
	cGYMeL0JV+dZkSVhvKyU5JP7cg/OPm7yGC8TJL98EhXHigkVNDRLD/58O7oljlMRb/cJf42zvRn
	1hvzWbpMHk2v45Ip2YdEE2JGB1f27g1BereFWzV8hwXqUHkZhjRKO4ISn
X-Google-Smtp-Source: AGHT+IFI2ik6bv3FM+KkERqn6P9s6t6w8lNcwJyuVIG0qIQE6IlSHnwqYI/qL48jJ0/hva98gtHZIA==
X-Received: by 2002:a05:6300:2189:b0:230:69f1:620a with SMTP id adf61e73a8af0-23df917ef24mr5855799637.42.1754167108914;
        Sat, 02 Aug 2025 13:38:28 -0700 (PDT)
Received: from smtpclient.apple ([2804:7f0:b77d:9c5:2c33:dec0:3280:5f67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b425731acc3sm53540a12.4.2025.08.02.13.38.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Aug 2025 13:38:28 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [ANNOUNCE] Git Rev News edition 125
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAP8UFD29T-BWhp7teeoUTmujoAWK_muj1JUqP9JaayiSaFCMsg@mail.gmail.com>
Date: Sat, 2 Aug 2025 17:38:15 -0300
Cc: git <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <0999D89F-AFFB-466F-B5CC-E220B19908A4@gmail.com>
References: <CAP8UFD29T-BWhp7teeoUTmujoAWK_muj1JUqP9JaayiSaFCMsg@mail.gmail.com>
To: Christian Couder <christian.couder@gmail.com>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)

I'm really happy that my GSoC project was mentioned by Usman!
Feel free to join the discussion about the discussion!

Thanks!
