Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A137A14A4DB
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895076; cv=none; b=PGMyVcsR8OvkG8wJ2pM9I2dmYEGOe7hzuctqwqMGbjZsO83JUDSzFT7mJoi+JCxgEsi+UxI9hiSYZfNVQaGMCwPy7cNvmw2cPDd75azcPVTbbyQNYbeEbEss1afzJQJCzET2m7tk54PiVDiUZE31XbyMUoqhJYFUQLUq6ZN7fOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895076; c=relaxed/simple;
	bh=aupmtBbJnC+wCjIYnL5A+pxWSPrtFIrJI+RIf0vTFCY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=D32UvWrXniwEXqt1Fd+Lx2nc0Y0VmIg13QG9Mfi0o0bxDEokq3Bddp+p+cycXXqNRthun0gxwJfA9qeL2HIIq6ZQ+81H2L8puvbi3RSSwLRZ9JiLSu2NqAPmHZs1OcC39SAFyGb0q/vxuPqsBxO+YVT1MZkd9vgub2W67Ccaxgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiTRIcoA; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiTRIcoA"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-296043e44caso1955063a91.0
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 09:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706895074; x=1707499874; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aupmtBbJnC+wCjIYnL5A+pxWSPrtFIrJI+RIf0vTFCY=;
        b=JiTRIcoAYZPRjsKdQM96QJ9CInMFJ//vjLv0ZfTDkWCOsXtHCO+9a5rqy5zi7wcy33
         BsCrfQpWq2EmK5lLgqNzE+eJ0kgxmB5MIU9U3qFfQ3NBJq5fMiPWL8RfvZIUeFz6jAZj
         Bab3Z/z93M5uy/3fHTvMuddTbZ7pCdviPci1opHrYsZJmnyWXcmoMl/VSym1CnUbch2c
         +N/VjEmMmNXTKVoB6dnz8uk7mVvmtrEl9ghVcGC2hCqGP8SrPjLrfgjCM016QrP/It3z
         AY8Gi7oJmubvZ5rSMT0sKj7YqHw/AJDDrG7ivngRkKdUvp+nprzByEcx97wUDoDBFT0s
         sEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895074; x=1707499874;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aupmtBbJnC+wCjIYnL5A+pxWSPrtFIrJI+RIf0vTFCY=;
        b=cpa50S5ay9M+TraJYThjsAbnO7Il5bmaSnX9w6ZJYxjk0qOBgCx+WUenXYYpnxvm12
         Jzf2PblgaRUJtYIiwebWFIHZ0mFRrk4ob3+H+/Wniv1U1GlioF6a75j9AF0Qvn1VBi+/
         ugPosReI1Q4VMXm9v6Xzo2xBn02f093ikSntPyo5pE5JQayll3RCQCND51PUWSlC0TnQ
         ys5si3yOa7GKxYSuI5eU2Pvlv5VOIIVyO+tWl1EwUfhsMkTGn0eDU46efbzu3j73zAX5
         CVuiHCldd95uH4FHsQOGzOEZxsLBW0s0iZM5/B6A+deTwv9R084gDqpWmdA3u2xztVHL
         D2Kg==
X-Gm-Message-State: AOJu0YxQv055bsb6Cb7x/QpSUVAtomGpDd3U2TBXafDayZwA6YuMGxhn
	nl/eZqwZUduaEzweCu/z68JRrT6vMn5+JjQI7l37wO3gTzKohYT7
X-Google-Smtp-Source: AGHT+IHMDCJPsU2Ck9VbnhbP2jxGTZH0nE/MJMczZyyhlwdQQpN4A/5QIlWYP0PxdqcR1j9I0/+LnA==
X-Received: by 2002:a17:90a:d787:b0:296:33de:1173 with SMTP id z7-20020a17090ad78700b0029633de1173mr2708171pju.18.1706895073874;
        Fri, 02 Feb 2024 09:31:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWYHYQ2HYC/lsoR8lcRhHKqFd7O4tj7qR6syiA1MnGxTfqN98JAeU65QAWXBvVX349Gnx3srcJyxOtRUdy2xDdiZMDKrkHRv8f1ryIjtfI=
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090adb8e00b0029647e89771sm276780pjv.19.2024.02.02.09.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 09:31:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Feb 2024 23:01:09 +0530
Message-Id: <CYURSXQPY5QA.34WZH01SLKI55@gmail.com>
Cc: <gitster@pobox.com>, <ps@pks.im>
Subject: Re: [PATCH v2 0/2] add-patch: Support '@' as a synonym for 'HEAD'
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240128181202.986753-2-shyamthakkar001@gmail.com>
 <20240202150434.11256-1-shyamthakkar001@gmail.com>
In-Reply-To: <20240202150434.11256-1-shyamthakkar001@gmail.com>

On Fri Feb 2, 2024 at 8:33 PM IST, Ghanshyam Thakkar wrote:
> This patch series removes a non-relevant NEEDSWORK comment and addresses
> disparity between '@' and 'HEAD' in patch mode for (checkout, restore,
> reset) commands.
>
> The removal of the NEEDSWORK comment and the '@' support are split into
> different patches because the former is still up for discussion. And if
s/former/latter/

> it is decided against, the NEEDSWORK comment can still go as it would not
> be the desired solution anyway (described in the commit message).
