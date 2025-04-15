Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF791F4C82
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744726435; cv=none; b=PtZNBXnQVn2Y0w/ZyqmPENpKc8+hg05/kfb8rsWLrvvq3lguFDM2NJvrNU6TktK4zUzxeIF7zuJKnzK3BdLL97GaQ49FaSAXm4DtM7tsOhZIfE9X0pmLqSBx+MM8yeY9q7Mlix8Hgkrsb/T3FmB7qtMTOsToYTg8ebdSKSre7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744726435; c=relaxed/simple;
	bh=P/ychzYQol2GWYk8otSFujvg/NTNjBfIqXtkAjqLl8Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sFHbEA8gi9sqbvngDzUK1vPg7HH72A0rce0tOHoFSGswz9ex9iJssDL7t8pMnSvxD8H4WzGUvQToazcnXpwDYnxvGxHmO6sBkSgIdfaC3FPgrvmixAROjlHOvvJOA8+o16EXmGpIRMyG00AQxUXOAKyQV7yvZCIjOmUo7m05NW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvyxlTvh; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvyxlTvh"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3081f72c271so4749367a91.0
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 07:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744726432; x=1745331232; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/ychzYQol2GWYk8otSFujvg/NTNjBfIqXtkAjqLl8Q=;
        b=cvyxlTvh9wpc+0HdaplQPkBEoEHiZq2JGBU9S92qTQQSjjBugmqIPET2WgfbAZtsvr
         27J6GS/EXzA6V0gLjEXg/Q1KVUfNqYxZ6SMoFuMLdcM/KODHgELJ63ZJNrzIYBQSxCus
         D3CnfLMwdGrDPbtSd6YOudi6oqqO6T3WSxyz/WH2sWYPyX+UXJG7A+brLdJ1Y9M3/Rf9
         o/8mojxb0gT6vD3Te/hqREWNBDT3ih/TFLVMAmesd/XlN0b5gqt2VHr4EKW1k3bTWBNo
         fGGJHhHsZhSCqP+BQz+DD3dUanYCUwza9KSjNBAz1Tpa3uKv6WXqfT0WK8O1Gw+fIrsv
         of0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744726432; x=1745331232;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/ychzYQol2GWYk8otSFujvg/NTNjBfIqXtkAjqLl8Q=;
        b=HMYHZptkTywuHMxtwBpJ6+92CSYFOqQxMhnug/KZMqgvK3UepiM/YX/fdwA3qRuu9e
         wNAEFA8jzXtsF1u+Cof73o1CNH6RkNYJsoh5uD47GfWLpubiLumcFU+1Y5s5K9vhcxQ+
         XNbgjYngLVKIbpcKK/Ie29CAJzrYCd4A14sCO2zF2bhqRgqxqewrWXWHo1GI0KdJOlpX
         CmkD4J/dAYkeyrVR1Da0lghU+19g3YyZjqlSRJX7DVrBkVXwL6rymaUx0R8FgIou8dFg
         G/Sg1WY/JOC1jVVkLbVn9nbNTguXicZ2J7dvTw5K8S6U9+ZBgk2fA0KiUDmwANjH+927
         69XA==
X-Gm-Message-State: AOJu0YyKj/J6o/DcZDS1e/k852MxSKDkYpoIbJM9yG/9cwU2zhAhV6td
	hgZ1rfmSIQzIxL8ikY6HVoLMTSyLCc2UqYk24CMb+a+ZNObwb+d+gnpQp9vu
X-Gm-Gg: ASbGnctrsRs2sCY9qupqmXMv7hQ/a73QVzGYu7ifxay2hkO2c0em023J4//Eqw16CdC
	lXMPcAFxhz4Jz63HA6qETeVvfKJTbOwdEdF7AMRNCuWxCf3X2PQvG+vjhgWAgdUSkALre3+N9da
	EWzl0KUbHYAmX2pNr9r6Z9rhNcipmakvgFj4jG+CwBpVF648bVXV1Y9PDpJ/p1KHR0RKWmYXLAY
	xgVRNuqKoPbu+glBBUfi4xzsLcC7AvjWslQXCT64H2V7pju2XazNDIbxOIiZ7Cm/y+AVowVNX/t
	Y334u8fr8L82AVP8YYiloAWrsa9TIHPw+4iExmXVqGnJEf9+BFL/ZW0x7dMFTL3WLJItbz6RfYC
	Y1oZRR5Br
X-Google-Smtp-Source: AGHT+IF2K8/KR9I+KJxLGQMzThJn4c0ohrN3wbj9C/7bZDryXfQiwAgnFF36qKVCaPQeh9bxjsxoqQ==
X-Received: by 2002:a17:90b:582d:b0:2f4:4500:bb4d with SMTP id 98e67ed59e1d1-3082367494fmr23006326a91.20.1744726432225;
        Tue, 15 Apr 2025 07:13:52 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8e7e:b9e6:5ec0:4667:bfe1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd1717cesm13393395a91.31.2025.04.15.07.13.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Apr 2025 07:13:51 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: git merge bug report
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAE8aReXOwM8ByyObxrb8NhRMYfK1OB_6B9eOO07mYXMkp_E8EA@mail.gmail.com>
Date: Tue, 15 Apr 2025 11:13:35 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <39551FA4-855C-4E55-BC2B-F77D9BBCCF6A@gmail.com>
References: <CAE8aReXOwM8ByyObxrb8NhRMYfK1OB_6B9eOO07mYXMkp_E8EA@mail.gmail.com>
To: mu gsh <yue937@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi!

> I would like to report a bug I encountered in Git during a merge
> operation. The method from one branch was merged into the wrong class,
> despite there being no reported conflict.

Thanks for your script! I could reproduce this here!

When two branches changes the same plaintext file, Git tries to merge
them based on their contents without taking into account the syntax.
It is done using diff algorithms, which you can change using
`-X diff-algorithm=<algorithm>`.

I tried the four algorithms available (minimal, histogram, myers and
patience) and all of them produced the same result.

Sadly, they are not infallible and those mistakes may happen. There
are other cases where it can happen. For example, imagine a Python
class with only two methods and each branch deletes one of them.
After merging, it will leave an empty class definition, which is not
allowed in Python (unless you use `pass`). These algorithms are not
aware of that, and they'll leave an invalid Python file.

Also note that they are not exactly wrong. They only do their work
naively based on the information they have.

This way, it's always a good idea to check if the merge went well.
