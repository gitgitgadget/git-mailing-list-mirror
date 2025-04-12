Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D40E2A8D0
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744472756; cv=none; b=M8K7AxQRpgIXILCpvjaGRz+OOoeu0FZCZc5u1qPoNTV8ZAT/O4zneV0lASNi1Ridtu13kzHLD7u3/VLchiy/FbZ4sHk93fNKHmBYBLRvLa0y7a6CpokGfnuPAt7mlh+AeEeW8B6XzDKZz06nQWDcR6uKCErLmPnCM2pBZRr2w48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744472756; c=relaxed/simple;
	bh=jsLweSYJdzp2HzqTgMZ8MVgA2DqOeH6s8F4LV1zm+hs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TPYbAy130/knz42mmzuZIho16lkiG1cvPVwFGEA+Euy9xqCjUIgFgnliW2oFBMnwz40e3/fdvafU6CibTgpkfshWDVDUr1Fp2jEqmiE7F0D4QJZ6ukDmIVBM7lYzx2qG+3x2+HgQ6Nm20ELO1whMcgXXWXs16dp+Uixtg7hiksA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5yXC9+j; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5yXC9+j"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af6a315b491so2752672a12.1
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744472755; x=1745077555; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsLweSYJdzp2HzqTgMZ8MVgA2DqOeH6s8F4LV1zm+hs=;
        b=D5yXC9+j3UBhhUMfYTdj7kxaGTtGTyF7zkQDSy0UUzVuvibmxbzSHi5VcQx1s/YswG
         KJzGfynBMcdES5JuwEfjs4731qqbEZnIvzWHW21UB5eDYpFEfvfLVLf7eTs9T6GK+iyU
         kvf4sPrLV8f4+T6BHoXGb1O4EUX8u6J+W8cVAmVgmDH/kPpAqXtZvv7A4wBpAlTU9jc9
         emZE7FaVi4i1sAoWAuqhBf+eIvtdhpid1+GotHUiBaYFir0qyLCTrBhf+9kqRnJX+ZHc
         wvsFitYMHW1uvOvmahvMcT/VywNZLpy4UVTOPhgbTsr2HvK6JJpk97LL8T7xiqVGgs73
         vFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744472755; x=1745077555;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsLweSYJdzp2HzqTgMZ8MVgA2DqOeH6s8F4LV1zm+hs=;
        b=BvwUX5pkIfZ1l4lHw35bopJHqdLAcVzsM4KARYabH+Wwgd58nVWU307U7spM09vFUU
         fwTlLmz8d2n6HsT3DifydIRDllGiC2rO84m032QV5nBcHnA3kquR6jLd/7GO9hwKAaHJ
         Qj9urCSVttjil3F7j7HyBeT3SYEzLRwgVFAdmgw1WKlZikA4o1lS1ovaOPYIkdtq+8Cn
         kFQmWYk1a3E6/9aE0vx6VfwWGy+KcHAATNdS3okcZzyLv1JZfUbpC7LTb3utllwShf0y
         sc/hIJh+2DXahoaFD3c5d+l+zl1JE0qg8sNbVenXx9SGV1Qba96E8nDlsKbVdU1ahYX+
         BkQg==
X-Gm-Message-State: AOJu0Yx67sJaXnScuK2zd0tmczUTUMaJBZrx3A38CqtNloYFjCokWasw
	fT7dOz0c5ugm+QRrFOHlhRRcYSSrRhUQR7HoGIi4Xt7sBg3aeHbeAK+CJw==
X-Gm-Gg: ASbGncs77iipvy0Qo0o345Tasm3xO8B1okDjJ71VXmOoslKY6vTNuRh9JasHpvKbW0A
	XOWtzhfoDjFUvOEpp/pwtshoWC2Yg9kNvR9LwbefCr888xyD+gLaImrv0ghRIDxcTBHwDK1d2NX
	wpo5ZaP7WG36Eq97jeZYIeV03vUJ5Qm9XDL1m2XbUOM98v+m1MQP95+nkDs7dgyXK5Zhc0aEh33
	gAWch+FB04MYJdIJHjc5SYdXSkDA0qjNfolpnwE2Lamc5mFOBq1Dc17uwcF280+VQVHp+3GvHiQ
	ENmDlUQeeL+vusOAPf8sJt4dGCkU/BS7yzpctPiLHTJDkX47Gf+0kiuyEfdTkg3O8GioTVLg+Q=
	=
X-Google-Smtp-Source: AGHT+IE8Uo2ctp8pktIv7wljkwSBlUwuYdWOH8c4IvPz3UT9eodQxCvoW1/P8tJwIP+BJpeZ9icorA==
X-Received: by 2002:a17:90b:4e8b:b0:305:2d68:8d57 with SMTP id 98e67ed59e1d1-30823634625mr9677697a91.5.1744472754513;
        Sat, 12 Apr 2025 08:45:54 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8e7e:8555:58e0:926e:5ed4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccbd5esm69184875ad.248.2025.04.12.08.45.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2025 08:45:54 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH 0/1] add: fix pathspec handling when literal filenames
 match wildcard
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20250412094607.236382-1-jayatheerthkulkarni2005@gmail.com>
Date: Sat, 12 Apr 2025 12:45:40 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9EB38EEC-97EA-4F8D-BCC6-883771203755@gmail.com>
References: <20250412094607.236382-1-jayatheerthkulkarni2005@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi!

The original bug repot included some simple steps to reproduce
the bug. Since it is a corner case that wasn't covered by our
current test suite, it would be nice if you created a new
test case covering that.

PS: Since this is a single patch, you could sent this without
a cover letter, putting your comments after the scissors mark
(---).
