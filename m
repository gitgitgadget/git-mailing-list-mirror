Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8381532694F
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958442; cv=none; b=DjFlyMMXgL0pnkcgPm8h89CsgqslEhjbQ3jXohboE0iDxAWVxSHEzT7A3Ih1yo7xB1nzsuXumuwQKdaxD3Gz0TrYUMZ1lagthwqlbf9w6oLNadw57MJtBVvsxFiuldWSnPa114JHhgk0PCfoJ3HOvt7nF+69U5rbrwty23VY2C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958442; c=relaxed/simple;
	bh=YeA2Q25J8VAhRyvK0+sFrjZSZvo1f3cxX4nPOKRqLA0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gzYMvXe7GWzCPK5Aux0k0syRe+BGLWNTRZ4pYbJQf0TB8JNT86PddVVBgdy72qv/gyVt6I3FxcTVKziREGv+69yRMDaxPxAKLPPyj7ffk1n95ns0vw9oGwDD1UjKhOVa1F8yN2pMCoaIGjawmRFdW3xpgediXd1AJKgWeIeVzQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ozv+lrbn; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozv+lrbn"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-6cfdce656bfso1681535137.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 15:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780958440; x=1781563240; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2vkYa0cbOPQNXt4HxwjnWoE08GQ6Z0+ktJ7PFLa8fM=;
        b=ozv+lrbnE4ogOR1occzEtd1d6SPZl2uPtakUb8dUyYGoB7mZCuKzQtsbS22+zEkXrO
         lKzK6oP4olYCSrfJVF74vEKn0mYSWZLkoXeLwlQcuHLsksHXCT+I17Op8sgsThxHSDEC
         g7+x3OkAWrHqQk5S/R7uOua57TFFwG3nrUKkpqDqdI8sbFQXLip25PtXEFyYMsLRpMCI
         V0N0UbgYkxgSSCnlTKpj+rgMf8fIVmn+35luwPqQoZaadOu0PaEpANAkY2gBJmUW7dt4
         CMzbhJhG5J1bKJxmA8qyd0+1I9mFJPE0FG5dCAjWASqqsENwmNswzceoeUbNNIMwjg3Z
         yxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780958440; x=1781563240;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2vkYa0cbOPQNXt4HxwjnWoE08GQ6Z0+ktJ7PFLa8fM=;
        b=b8ji1OoH713EOb+xZXjOddLbTG+tIEugPRl6bTySLCOUogkWDCtZPRGf5+cqfm3PKW
         pSQFfQ5e59F/CAADZnmJJcFUm2HSvqGzOuQBpPJzMa8+3tHKTK+Od+oBdDDgGsz7bCuq
         y7/hRE62MYfztlRne7sNmEYqTh1AIRcbx9NlY4TH5b/CR3ifPZsR7znmU4y5f9WYo4O7
         I+YUgnOq5xp76XFfGXn/P3zRElZEGTEYJSfE5R1TayJN8bxH0jwxngxrHN4amOqi4/2g
         6doyoWZaHFzwQpKYRsssaN3IEQkDVoJeVvAc+O7TXdfmMAXAUMxmQhD3417k4wvPTwcl
         ahNw==
X-Gm-Message-State: AOJu0YyqZvrWZodr4YSQv3wXsiQMjLk0SbRabpVLOuxgboEwXOlBTX8k
	iSoZeyrnSg8j2n264hW6cqkwLxU+U+dcAXRrWHyFEpPp81Kyfs38YRKx
X-Gm-Gg: Acq92OGo1pqBj5FHrsQiClWVhM3wTHWsny9wKvYYx7W81Jh0h1C3itOw9P61VzWKxlg
	XmB0yhc1PMF/5Alg5nw/LaufcuzVoQ/Nx4BpUCUbCIr+0VgMjsUrSvmXHA1Xn0eg+Pnhf8AveGW
	FN7jJXEdj+s5zD+EINl4qq+ziZR1qN2GSFh7uGQ7nsSVNufoM/zvDjWdcfI/hDE+2lM/ylsE6ko
	8xvARL08fi5+cSVSdjuyAhv0SRJ2ksuw69h5T+Qzh7cLSz4OdEIuiguumJ9tyVFNv/j9jW2pik4
	yeYlptqPLh25KgmC6s7lVxk/G7x3VIthVTMIhWbHnePrTSnkjXD9pcZb9H3cGCSytUEk+oaQ54F
	L4uKks9rXITMppAEqxvn3vUZQFM5CMY3C5hII/yt9TuRr8HIPCb/T8YyUoDcdhKZQ7WZCTp+pYo
	7RamoIAlKcocsQUGuzbW2eMgZs367eAx64H2ZCNpNHeeP3ionNTUypArzAvHQR3igk8jGDgbfd7
	A==
X-Received: by 2002:a05:6102:800c:b0:607:798d:8083 with SMTP id ada2fe7eead31-719361e5d88mr63515137.15.1780958440538;
        Mon, 08 Jun 2026 15:40:40 -0700 (PDT)
Received: from smtpclient.apple ([189.62.148.96])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6eb5764dda8sm15603725137.5.2026.06.08.15.40.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2026 15:40:40 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [GSoC PATCH v2 4/4] repo: add path.commondir with absolute and
 relative suffix formatting
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260605163012.181089-5-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 8 Jun 2026 19:40:25 -0300
Cc: git@vger.kernel.org,
 a3205153416@gmail.com,
 gitster@pobox.com,
 jltobler@gmail.com,
 kumarayushjha123@gmail.com,
 phillip.wood@dunelm.org.uk,
 sandals@crustytoothpaste.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <D0CF1CC0-DF1A-482A-AD1D-D41680A1672D@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-5-jayatheerthkulkarni2005@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

This patch looks really straightforward after the previous one.
I hope the rest of the path.* series will be just like that.

> +test_repo_info_path 'commondir' 'echo "$(cd .. && pwd)/.git"' =
'../.git'
> +test_repo_info_path 'commondir' 'echo "$(cd .. && =
pwd)/custom-common"' '../custom-common' 'GIT_COMMON_DIR=3D"$(cd .. && =
pwd)/custom-common" GIT_DIR=3D../.git'
> +test_repo_info_path 'commondir' 'echo "$(cd .. && pwd)/.git"' =
'../.git' 'GIT_DIR=3D../.git'

If you use the test_repo_info_path that I suggested in the
other answer, this would be:

test_repo_info_path 'commondir without env vars' 'commondir' =
'common-no-env' \
                    '.git' '../.git'

test_repo_info_path 'commondir with GIT_COMMON_DIR and GIT_DIR' =
'commondir' \
                    'commondir-envs' 'custom-common' '../custom-common'\
		    'export GIT_COMMON_DIR=3D"$ROOT/custom-common" &&
		     export GIT_DIR=3D"../.git" &&
		     git init --bare "$ROOT/custom-common"
		    '

test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
                    'commondir-only-gitdir' '.git' '../.git' =
'GIT_DIR=3D../.git'

