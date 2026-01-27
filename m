Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B093288C22
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528579; cv=none; b=LPdg49vfGDZ7aKQWswFeReY1PGXT66EPet0A42cmAv77wKjH5qrR45wEJqoicGP33Qv6yCfQ3GfTKTDZRHT23xbxQKshNFY+HYeZJ9Z2JyY9O5lwDCOgPhHDpbzGwpZMKHdl6rreA5+b6TCvo2Ki3EwiGABM6Ac52euwJUX3DL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528579; c=relaxed/simple;
	bh=M+nFNY2yLQeRkVAyH3nFdjir/9mpH5v2c6nbXC98glg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b3aELWWrTrw2ILKDtqIt7ytmmF+zlkj4pRRiJMHfboRAvp02jeXrKqaW0Qci7s2wwOBOSoKB/yrvOWuvQem7D2hOP76CHOXrsBiytTja7Wuftjt3dwN08SPKh1zLXmy23SQYSw7R6MX8tHI7Zsx1HjHdmPxVppeSFkLHQtIslFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+xF72up; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+xF72up"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-480142406b3so39933565e9.1
        for <git@vger.kernel.org>; Tue, 27 Jan 2026 07:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769528576; x=1770133376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1xi+FXZHRRppiQVbDVnv4rwAr0AhBQmdcauU75b/7s=;
        b=e+xF72upq3x7bMI4inST7KK9N0uAAl8shp+uitpwK5SOEdaGGhPkm1IbUwiOzMCalT
         iA/Iwlpkm0Gb//b6hINmvfi3LWBz8yJOY/vjPYo1yQOmAwLaZ7IxRVsFUmp2W6i4BPMl
         8HUDVD1+NSFNf23WxkpcPEUc8dSCGsBdxADfR/7IEoOvXJjmvi4WH/gRrrDz4XSa3DWM
         1U3pG39FqJYcKAojG6U5PpjkzTQcEW2gRwmrIW4Hxg+XxryTixuCBJXelr7eRFx0wrCe
         vf45VoRwWaHycZJu3+zvPBH3ZvFXcplyaeiqPwNRMJuYHWGPAk4J4iOhQB/MEgQyRZyP
         7XkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769528576; x=1770133376;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1xi+FXZHRRppiQVbDVnv4rwAr0AhBQmdcauU75b/7s=;
        b=LjFuCeUiE+3urJ7hWjbPJhxNFdrlxQwzJK99yRo4K3IZ+uJkSkDwWh+po72mtY0Sxj
         ZmieeMONvNJqFLw6+uTXxP+VA+WLuPKiFS6Jd7SEexIfe1Lrdukw7BfIUYCQkyTn+Y76
         GOKC6zHOafe4fqpqVOxd9iW1JVx9UVtG6arMk5MHe7XKbZx86MJ0s6358tT0U+BxtEzo
         kVrrwgO0HJqjjnNet070HDHz892sW6VdWva+DwyOse/hwn3IhY3S5wdonnQKSQwBEmGs
         K7EhaKQP1jA8G7jqPPeXIoBdQitQljtWy8TsjuEwnCesgE8rcQ/aPoWhJ3AGT2nzi+Io
         FJsA==
X-Gm-Message-State: AOJu0YxTZVJoCf0MpJuYEHsmx8GULJ7q0WAFKz+VZNKW24w680LxmVL7
	mlJCYGgzflOzB7RfAj+JZEHu6jXuHTrLvzdsZb3a20UTNSAdlhKJX0rBpN4L9zhc
X-Gm-Gg: AZuq6aLZQLzc51N9BAbhFL3TROnhs47v9nUO7fp8G9qxmqBNKXLO8xk3z9qZYd1v9RD
	Yrd2ETUWPCOCoXAkFD5DxMoY5YsrheozbY2MvGSNmKAaw2kGEf54SxEOEQZr2m3pb//y9OJkx8G
	JIS2BZfHKwAW7aA1QpML5lPats8LymeNmnrn3aCrjgD1+fFWLtsLftH4dqFiRNm7zS4bkIUXFSI
	8dq7t1aGNzprSmy3E2k+FNuRx1NGy6MaemlU7X1XWI5xoD/6+GC/UeeR+KN0pbd4NLpE0gM4zIO
	kYfRDAOdm671bQ70jS+0HLKLH2TDw0d6vuaRH3nbkXNeC4NRbWfnD6CFFh++EcXOvT6jlf/c/TW
	ZJNconmYzsDDiVA9OXh723JDpy9snbKm5lhaDOyZ2qnIeotg/snHAZ+L0Hzx9M1Nx2uTax+Rv6Y
	QuvxRp2m2CCszgTkB6Sj4QWcAjeb8=
X-Received: by 2002:a05:600c:1994:b0:47e:e2b0:15b8 with SMTP id 5b1f17b1804b1-48069bfa73bmr30443665e9.4.1769528575993;
        Tue, 27 Jan 2026 07:42:55 -0800 (PST)
Received: from localhost ([102.91.81.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cddffc0sm1190785e9.5.2026.01.27.07.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:42:55 -0800 (PST)
Date: Tue, 27 Jan 2026 16:43:06 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/1] Allow reworking with a file when making hunk decisions
Message-ID: <cover.1769522219.git.abrahamadekunle50@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769164663.git.abrahamadekunle50@gmail.com>

Hello,
After review and suggestions from Junio, I have been able to add the '<' and '>'
options for going to the previous file and next file respectively.
If there is only one file, neither of the options will be available, if we are in the
second of three or more file, both '<' and '>' will be available and if we are at the last file,
only '<' will be available.

This will enable simultaneous hunk decisions between between files.
After all decisions have been made in a file, a prompt shows which asks
"All hunks decided. What now?" that allows reworking with the file,
moving to the next or previous file as the case may be.

Since all hunks in the file have been decided, if the user navigates to a particular
hunk with 'K' or 'J' and redecides on an already decided hunk with options such as, 'y' or 'n',
the user is taken back to the first hunk with the "what now?" prompt shown.

The decision to use 'q' as a submit is because after some or all the decisions have been made
in a file, 'q' submits them as is even though in the `help_patch_text` it say `q` will
not stage the current hunk and all hunks after it. This is not true if hunks decisions
have been made and the user navigates with 'K' and 'J' or uses 'a' to select all hunks and
'q' after wards

I have not attempted to work on the t/3701-interactive.sh yet but this will be done
after concensus on the UI when all hunks have been decided.

Abraham Samuel Adekunle (1):
  Allow reworking with a file after deciding on all its hunks

 add-patch.c | 139 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 102 insertions(+), 37 deletions(-)

-- 
2.39.5 (Apple Git-154)

