Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A311F9F7A
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755209931; cv=none; b=TsJ0E0Qxuzgcp1QflwPskV4GMaerc/tD1dl6OdEAtxvF9gbAO8lzWI8ktx+1y9QbbKrw06VW+p5WSba8Q5imyOOvI5AZffXJ2wLPNe9UAO4CEWKhwaQ9RGICuUUJIW3bs8cZA10KvHnZJz3eT5DkghZFtKtvey1ju+CMNXZsnHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755209931; c=relaxed/simple;
	bh=MNPyApaotcGnmLXe0VSdsor++eYtzxM7+xXGzRIQU4g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LzN5EV44ygiGyAY0Nl9mNaCXRWYi2y4vkVfegsxS70z/UlxruIGhXjm7I/tpSnlp1tunYKl8wPOLyMa/PtX6DcyaU2MsMok3x5V9LeWUVy34Xp/Hoe2IAA1ms/3AWk3OMVfdy59MLddcgPg01QJmirFZNSYWcEnNy0sKy859mfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C98yB380; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C98yB380"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32326e5a623so1360374a91.3
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 15:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755209929; x=1755814729; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btHX0ihGkUaZag27UQKrvl8KR1f6W62KK4sOz1Sa29g=;
        b=C98yB3802isBi8+Tm1fTiULldUcIFf0F0g82wEtueCp7ZM7gGEnVgFdTvJDqTUUdRY
         hy21AqXBl4dQlHkyNMo1BJlrIeWN23jBhs0d5t2fWL8AB3roS+W44iEIdDF/JxYz7LBW
         mwmh/DgAcLqN9fPOB1J+198TY0YECylrKBPV8PzSU2ZjrrkT1LWFm5lUqMfe842X3Bjq
         t2CkXuxqFFxLNc3Noa/5vWwNe6UGA8tuEjgON+McXymL/QpuUPUZdACSkMMTJVVdI+Ew
         TXx8YyiH8O1Hlz9bgwJKUmqe8Y+b40Jd+CdvJUudEs3G/h6/lSR3+NPM5WlzP2dDTckA
         1Vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755209929; x=1755814729;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btHX0ihGkUaZag27UQKrvl8KR1f6W62KK4sOz1Sa29g=;
        b=PX+J6R/S1S6hLlk6F14CNXlbybFG+p4E/DyIq9+gfoExXSMA72aJY+bHIH/TPIsjFK
         NxPUqIEIBTDKgExMN++5p/I5eF8/wZo3vHrv+ZUpqsY4wQ0Y+Nr6UWn7LhJDpVB1SbqU
         SU+VwwtYzqMsWhEYJIO7AcUdjR4lWtBVfX0Ab7aMi6zuJMUOtfAte5V0VB2EpZOrKXT1
         BqhuPiexyZWrAP6IJPhId9oTBq7vaJjnyN4Yc/H30Hgf42cJBVdSg5Yo0XzBLnYQD3Qs
         jGDobjgnu7dz774BhLtcV2ZkT5+BP7u4PO419LVJ0f15uOPRJTBpWcDdOpB3EkIknR8o
         sP8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0O/9q+A0/AxAcYyMtUZqWqAFdeJe0uMe9Jsm5SgTNrNS5AMyVx91AeXdALjDXeZWxBSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwpwL1NYmIhAgJ9GpY1B8eFgmpmA/CQgbkkc2Tr3sUpHSUmGP8
	9aDOOWisiWWwi/DKQlx1TzUMKeXlToVmyMxM7/VSTLcxO+EHiwvGnO4H0FruGQ==
X-Gm-Gg: ASbGncsWPyomPuP2lgL5/pwqmMVlwlvxMX6zfKj2sgpvrgnzf7/J4RpoK8rEnKTUBUp
	JZ2Z9aQIZmpE7GbzdK3YfHEU2mqAhdAlEORH9xai9TzpCxqI2l3Ig8SUnqrPSjN0D37uDI2uUnP
	ncP/QNoakRKqiDpJ7L0nP3OrnCrYXjzWuMRtXeTD8UIrrzcVHtsu22N3fBddXuTCsp+dN0/f6ts
	ucJ3rkEPlpkEEWg+qOHXBk0J/v5SwFu6duNWXPk/qBOQdN/XFOgTMsfJG0RgAqFbtMEqPddDX5i
	o/DuchAhG3HAK8vN0MAqqqpKWxaGckca/RK8Jqw/Q8PNhPl4U7hF8p4z+av5v0Y9v5kjWRGe+kG
	uHLxjxx0h5c2CjKIV/TahE5I9JE5Y6d2ESfQfNXe1VluIJqG8EyCz18r9
X-Google-Smtp-Source: AGHT+IEj3ET9jeDJXs0hfj5A/zU0oux8euRau+KD4E+7FUOI/tmWaX5BFuP2GWRCLcxM+vrZl3ZNpA==
X-Received: by 2002:a17:90b:4e90:b0:31f:a4:8bfe with SMTP id 98e67ed59e1d1-32327a79925mr6893897a91.7.1755209929191;
        Thu, 14 Aug 2025 15:18:49 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330f835f7sm2925037a91.1.2025.08.14.15.18.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Aug 2025 15:18:48 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [GSoC PATCH v9 3/5] repo: add the field layout.bare
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqfrdt3feh.fsf@gitster.g>
Date: Thu, 14 Aug 2025 19:18:28 -0300
Cc: Eric Sunshine <sunshine@sunshineco.com>,
 git@vger.kernel.org,
 oswald.buddenhagen@gmx.de,
 ps@pks.im,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 phillip.wood@dunelm.org.uk,
 jltobler@gmail.com,
 jn.avila@free.fr
Content-Transfer-Encoding: 7bit
Message-Id: <1ABC1E05-BEE9-4E17-8C6C-8BB4127378BF@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-4-lucasseikioshiro@gmail.com>
 <CAPig+cSBg6oQC4Y81ieH25-A9cHRTfbqC5i+22RSBcbyVo_qtA@mail.gmail.com>
 <BCCE25CF-8546-4320-AB44-9B729C3D6DE6@gmail.com>
 <CAPig+cTQdEDZduG_UmdHn1JNfj7iTw0=jwdkX+VPJ11Jo0jUGA@mail.gmail.com>
 <xmqqfrdt3feh.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)


> I also care about future-proofing, though.  When Git is built with
> WITH_BREAKING_CHANGES=YesPlease, this test would break as the
> default reference backend will be reftable in that alternate world,
> wouldn't it?

To be honest, it wouldn't matter what are the keys selected for
testing this behavior. I'm only using references.format because it
was the first that I implemented. But given that, I can also change
their order to something like:

[1/5] repo: declare the repo command
[2/5] repo: add the field layout.bare
[3/5] repo: add the field layout.shallow
[2/5] repo: add the field references.format
[5/5] repo: add the --format flag

This way, this tests could be placed in 3/5 and using layout.bare and
layout.shallow as keys.

Thanks!
