Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F9638F9C
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 23:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763680078; cv=none; b=hQZi3/FyP8Nr4aYIYyOWiw7IdcR8hinBMciw7rcQOPSAXKCCnxouEAr/IIQ/nx0laiMHmvwBxdwK5DzFHDF1dGOCOh78SpCeH+kkVgl7ZWsDlybVLo4RojJNtuc6x/4BtjQbsjommtgIlqyiJzdiATsJB8jLcIDlhx1zZY9SUmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763680078; c=relaxed/simple;
	bh=BqUt0if8ptYSASKk3ue1PVQ+hiO/zw0L+mF8aLqjzxM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CQNCZ/eXuOKpbF130xoQjVw/AhC+61QViKKEa+K5H4dp99CoxbP6t7KUdGjL9kZCRqRF25NAabUCl8CwkGb5biOtn40GK6LhXPh6mtCzYks3YUp67q1II6NQAJunmCpfs+5EGx9mPT8IXwnydq/IcKIW0GHNvr9YuiuAGC7oT9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnIuDHCK; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnIuDHCK"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so1760244b3a.0
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 15:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763680077; x=1764284877; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VPROBvHaUgkyqvx0J33fHAv1DP7Gb63LC4EYpW2F50=;
        b=bnIuDHCKW/0jgocqW0tMDOP/S9Z5X1+QgaPMu4hTyx+wn1LxIG7tFUk1fBltUgqlkA
         ZPha3A13svOLXBZlY46AsgUOjbtMRLGovZfDG08vA3rH2xsmtqiuDfeHOzdYiPEhqVU3
         0hxWJBSyyUncXN+GA06595BUFpe1ZhiZOMx2O472pcIub6iTl554Q3Q/8LAPvIaAKW/h
         fS9alS3iUR+NZxLUmaDYCKtz+Cg9pGAV+wA4fKA6C0k2AUUJsWv/q7z8f6V2SkPxNVFC
         x9mHZY2Ar+eYLY3gbN32/WbkQj6HZJoPSGVnkPWHs2ldx2J+z3ts6KjhqY1CHcHowTgI
         b6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763680077; x=1764284877;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6VPROBvHaUgkyqvx0J33fHAv1DP7Gb63LC4EYpW2F50=;
        b=eE/VINWCj/4/liimcp4SG10kA7lJcE6UdWq+RHnw76NFdf6txCo+bxvEL4Z9AFv7cJ
         0Axq6OORSsBMKubgmMD7+G8jBctkYNcjnRxTbEyPw9gNJQjlI0tTfr9Ak2NFpoVPup9N
         JtTHLLwKS4vikiy/g8DQ/HT3xmUMuzXOwLmrCdvCeBlrCy4k2EF8RXehwsmz9hZ1e4+H
         dbCQ6FUZYRggv/yQMi8mMYiIxF6MM68UR+LGm1sMBW2NYiRKpA95p1f8QEcXF9PNfNOt
         wXNo7Ct3ua0zwlMofBGhMUzmZiZd3hNdS3/Db0ojgcfed4xWbTiDY5xK3C+QXJ4leEs5
         XN/g==
X-Gm-Message-State: AOJu0YzINiuSb1TtjUy3aRYqqvu0wzKNqJxVYmLZbl1e0u7UgFFFuwBB
	H7RQNBOoEvq9UHZmVIlUskk3osr0BhhjuWdH9ps7fAz417CPY3pYkuyg/YvwSw==
X-Gm-Gg: ASbGncvmQm/+ky9bRspF7zP3bRsv8vbYJyi/rZ/IXOk/MB/VFWCusfK5gTZJrXV3234
	BnNSeeFd+ZGT/h8vKJ2wHTlUiZqjfeKHXI7jwp/B72JEELhfyIxgoEOXdZTy3uaf7NBsEYAyV/f
	wYgqfBfPEHd5vIoCaFQngrBrvsDY4fU1upSMI+PtwcxKSB7aY8AV+vK0YBhNTpCfhLowux/lKca
	nJT+g3RNbx0gwjKZ7WimSG3o2DdDCD9m5vxhCDNXb/Th7gU7FOUARZ+v64IOOKdNmJOZbgXNT3e
	1rBEc0JTEYLOLyQB47SUBRIWyalcfq5grOd748bfb6Jzqtc9vz2h2TMQTF0/jUk6XyAfsrL/s/x
	ms1fFytPuB5GBKY2JsJIFinvR5E3VtP7tJSGRTwqwNL6qJGzVddsT5HkAWqg/H0XGx/p9fi83Cz
	fExaUieFWqQWkZEON7wE8zpgDJyrwzfED8qCJCkZPg
X-Google-Smtp-Source: AGHT+IHLQlTDbh4iG3xHHRZG9N1IOkcmBbudy1cjw3iDCrmbwFd7tkGm9puBNpnHf7PRsgqj9ScPCw==
X-Received: by 2002:a05:7022:6285:b0:11a:fe6f:806a with SMTP id a92af1059eb24-11c9d850598mr68593c88.31.1763680076446;
        Thu, 20 Nov 2025 15:07:56 -0800 (PST)
Received: from smtpclient.apple ([177.103.85.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93de6d5csm10012844c88.4.2025.11.20.15.07.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Nov 2025 15:07:56 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: Feature request: git cp
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAL4-wQrgD3nnW2BfNf6e9d7tDANE60dYBRRP_0FW3Z-LvQrZmg@mail.gmail.com>
Date: Thu, 20 Nov 2025 20:07:43 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <6F4B3935-7F2F-43C9-8E5E-12E2FB3331BD@gmail.com>
References: <CAL4-wQrgD3nnW2BfNf6e9d7tDANE60dYBRRP_0FW3Z-LvQrZmg@mail.gmail.com>
To: Martin Guy <martinwguy@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: Apple Mail (2.3864.200.81.1.6)

Hi, Martin!

> and would like the history to track the relevant lines in each file,
> like "git mv" does,

As a consequence of Git being based on snapshots instead of
deltas (see [1]), `git mv` actually doesn't keep track of
renames. You can think of `git mv` as `git rm`ing the file
with the old name + `git add`ing the same file with the the
new name.

As Kristoffer said, the renames are detected by tools like 
`git log`, `git diff` or `git status` based on similarity 
between files, which are considered a rename if they are
similar enough. That similarity can even be tuned by using
the flag --find-renames, available in those three commands.


[1] https://git-scm.com/book/en/v2/Getting-Started-What-is-Git%3F
