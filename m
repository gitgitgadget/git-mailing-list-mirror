Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E282A8C1
	for <git@vger.kernel.org>; Sat, 19 Apr 2025 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745084638; cv=none; b=rt1+RkvOpH0UsdvRrX22PVDwM8EpgnO1ezbjZ9RELTKh/JTjs0q6ouDnSVBISijRZLq/vt9VP5eAaMjST+iDXPhv1Ig5yW87RRaSH1Yo1lfwYwCIzha/TNagAng4+2aIvoPPaDx79twhj2i3IZT5IsNn3pVv3nb5i3qRRZKB6qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745084638; c=relaxed/simple;
	bh=5y/rRcfPfgyPaoiq5b4ljjNRajV9fQrZsRbT7bkom0g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uyiPFcp+o9DdK0SxASX2xqrUEXa5ie6E4gYTD3CWXSrugOCSpLivD+qlVgVtU1riYTSdK4LctMdyS4nTrFn87etalYJhyPQJPa6Nq0HRbI+g7F0vyqUktsRT5uAWL0LT8OTk7PgXXGSbLOracAILoiR9+nwhOdSvsaL/uYvKTm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hALKZ63x; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hALKZ63x"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so2550175b3a.2
        for <git@vger.kernel.org>; Sat, 19 Apr 2025 10:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745084635; x=1745689435; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfV+vgukt/1LlUdxpQII1C//r+D3hI51XImxmanaG8s=;
        b=hALKZ63xRPwxX7Tcu4CswDHXy18HXR/SSwfUOg7X7iy3yUdmJz508m2fLPXZ/MQhpG
         T00Un81EfiMY31ddIGfbmhc1JUTWYAjf3pUjUje4SaZl7it6VsrgLHNFgeNWGJqYryrh
         6fPOz7yYxRwJL6ToWi9xNXJMvO7sfYFsq5Zg6EFtF7utxE5JzDjh/v6XPjWIP3bfOK3W
         GluPbm0yX+bniR7USoH/Yu/MY9kGN93l6Jpo5jy+vbk1NBvJ7+qZLsJo+UEKoCjeMyd7
         c+h6bX2SnyTqdyW/06ANsyOcZZDF46o3n3poftKG21PSPuPm+oimNqs/A6kUcEO4HF9W
         21qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745084635; x=1745689435;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfV+vgukt/1LlUdxpQII1C//r+D3hI51XImxmanaG8s=;
        b=ALPl06MECnu45Ef5baBhGPRnva0pmhrr3mGQXN9c5UCAG5fyb8gpykS9i96/FirZVg
         EotvzQe3k8Jbp/J+lF+xNTCuQir+LNoxOyCdew67F3HVAaDibjOkAr0tN152d5IX26WX
         EczthyD542z9S9JG40cr6c76CHlxbOIoMbVM6okaApySnr0lBtmErfqZDjwXx0ELRRd7
         AFruDvb1uu9zsys1lm4kLOHfcjxO2WJ61C6xjUzmsxM2k/+D7gLw3xfkdHNl/EicR2V1
         pyhY7SJ/lwQsJOA/JOsEeqNrn0rDnceON/WSopkNXQbw2lZ1ormirrsseI6bPM/5QzOI
         CfJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNBW4tSKdN7VTPxIAK4zLfI0u1c12UquVXwbA802V5sIm+863cLcjgUGZKdOE0+PVAsh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtFKXvm8w26v25fpJq25gT48pnhsjS+ALMNCnaVzN6qLxpJL4h
	V7IlIjITkZrxmXBFgAj3Vfv94BF6rEl+pMJXIDyQJyLqJ4W8SQ0X
X-Gm-Gg: ASbGncsDrOVxHM5pRj072eOe3RRg6FYRsTgTNA583el8WEqEmh5WqPsjBFBaScRHezC
	U0DkHZkbul9PRpiRBzgq1pbMHtRgl2nGxQ2Vo/C1Zlh32i3gz+2cE4puZB1fxhzovbC+DFGD01j
	u2GHYKmGGLpYovVQSegB6CYAi1szZFuVZFz37/jiWaZaxnqkPXv8d7EePKQazTtXcNEHb4NxfOV
	rNIo5JGKLQBsEkuz+WhdBWzduKl/6okjZQhNEtVFvPtty4nXvOm/G8evb6XwynxQUM6XX4FHhjO
	SkIzhxJdDzr0y1vmxw9ccnaqo0ekx1plRe6nA3OffFSIOEqGlaeowk8CcltwWwrrcaIEOlqYJg=
	=
X-Google-Smtp-Source: AGHT+IG6JJTd3u0LCpTJf+5n0LHuDPltSgRBqkNMuyWHaE6/5yLtPc8DB8DQhyMwWkKErsZH7YeXPg==
X-Received: by 2002:a05:6a00:35ca:b0:736:ab21:6f37 with SMTP id d2e1a72fcca58-73dc119e7a8mr9181766b3a.0.1745084635551;
        Sat, 19 Apr 2025 10:43:55 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8e7e:f932:9969:fff8:e3ac])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfa574fasm3659249b3a.99.2025.04.19.10.43.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Apr 2025 10:43:55 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] t3706: Add test for wildcard vs literal pathspec
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CA+rGoLes1u3LZiStmDPmh4iiUNzNY43KyYNdLadQU+cy1TCc4A@mail.gmail.com>
Date: Sat, 19 Apr 2025 14:43:40 -0300
Cc: Junio C Hamano <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 git@vger.kernel.org,
 peff@peff.net,
 piotrsiupa@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <9200B571-071D-4BBF-B5E3-886B5CCFB89A@gmail.com>
References: <20250412094607.236382-2-jayatheerthkulkarni2005@gmail.com>
 <20250412174051.780148-1-jayatheerthkulkarni2005@gmail.com>
 <Z_7ekhsBzXK6LKuV@tapette.crustytoothpaste.net>
 <CA+rGoLfAidyuomeNym5WX8Bo7-jPcfHx35wDeZ7W2aorAN-B7g@mail.gmail.com>
 <xmqqa58gjlnk.fsf@gitster.g>
 <CA+rGoLesZ3nSjruJ8_XRWVsFpMu8mo_4cCOdB-GFHU_qXkXDCQ@mail.gmail.com>
 <717161C8-497D-42C7-8C10-AC112238EEFD@gmail.com> <xmqqcydchz9o.fsf@gitster.g>
 <CA+rGoLes1u3LZiStmDPmh4iiUNzNY43KyYNdLadQU+cy1TCc4A@mail.gmail.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi!

> reset_git_repo &&

I couldn't reproduce this as I don't have that function here. Is it a
command that you defined locally?

> I get issues with these test cases,
> Specially at git ls-tree -r --name-only HEAD > actual_files
> 
> For some reason the test_cmp doesn't get resolved

You can check the output of those commands by calling your test script
with the `-v` flag.

If `test_cmp a b` is false, you can check why by placing a temporary
`diff a b` for displaying what changed, of course running with a `-v`.

> Is it a bad way to do? or is there a better way?

I don't see any problem based on that code snippet (except for the
reset_git_repo that is not defined), but it looks like that there are
other changes compared to the code you sent in the patch, so I don't
have enough context.

