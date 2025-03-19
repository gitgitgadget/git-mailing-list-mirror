Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F9421C17B
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423263; cv=none; b=TZRcSaulEhpmYDe2df0I2NPyxE18ElQFfQ4faonPsHTaUXZcPwNeQGfGozPykCVSabFYRnIuU5U4vojjrzRR9dqhOj7i3BMjARwMkq8WwRycp5bEDl0dNIgMqQ/LyTIfd/ArUAAgIalnNRPNzM5fNQqV+XltVh7yIKCQxwWF4ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423263; c=relaxed/simple;
	bh=toVf8+cqUC6on4joN7VZ0KT4tIveabzP9HektArszjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWFRBhulNOGH7NJEHfZoexC/VUBCWh/h33HO9tgVONn0BnBqm71V8g5ST/chnAidYqtUj3u089w55K1O8plyj7RyfKMxIbd6dO9TRwTfT7g+bFi4CoRJz2LjK5BJlqTp0ipqcE+l2pw8DYPbbpIm7ONH3ARhC9h5/Kq+oER9yNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=DJQ73DiP; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DJQ73DiP"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c546334bdeso15838185a.2
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742423260; x=1743028060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=toVf8+cqUC6on4joN7VZ0KT4tIveabzP9HektArszjg=;
        b=DJQ73DiPnOromI5tGZQRwLiXLS+0YnZ1hL94qTKN8ztfB9/rIqjHpEFyRIuNxLcrmo
         nO/PLPjLXDNLEubibarby/Up5Lg5XFF+MqrB5F/ZR9cBA+4qtHIMg972MUpDwbdNZWxW
         nIpT7geTSpl6+DAaPDeLzCtevSpIQQpyfEEX8HAAVWBTKKTwPqzejqLltZoxlNmfizF+
         3OmlU+mgCex6m561lJVnEibrUU2RcmB6zcLU9qHRKDACuRKG69cN/FEWUE5SASZAZ3mQ
         oeAZAK5Sd4A+0hkUjMxqNrkTUCrYaoduDKG7bgqiD0ryp4rOZ0ZOgsOv7YOx88L7Ys86
         KIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742423260; x=1743028060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toVf8+cqUC6on4joN7VZ0KT4tIveabzP9HektArszjg=;
        b=aKm/wiYT0OrMaG+DtaB+yfsaS9/OtMT1JM3X11k0pppbl6/8zRuAo6iKOHN42XmA2A
         pC5a5iLnMBPcmgrrSChi+QKsOATBlsIZ7/Y55s+KbhWbf9gPkFTodPKXxNipagBGByMK
         kzCF7TIl611GcX4MHPEJmSZn5hCmRBjai5fi44DBxsJbGqFvfG40CQ0ljbKm9Y6Sr0uy
         26QNp2IvIOL5D0xEjWhzyE5qxGCpNEzyx7iBseKKCc3/dHEduLJdrEeTOHiobTDf1+KF
         opOsu7pxD1mKkMx8pLuNjotHGHprtMsswOfEJ4jEg7OJPRKwGEUwBCRj09x6tiKqRE23
         7K8A==
X-Gm-Message-State: AOJu0YwOoiVHqqt0igUF760Jeq5Rji9QBvHF5PcpYPDq7V/qQ0JUN7qT
	T3Z1IaW6j1IzKJynIeXtU3mXgl5jFLkg8ATaqjnWnshNOMDcr3MCeH3VGtb+NGY=
X-Gm-Gg: ASbGncsO0l36f7wdiDHaxEKdGURZJ7JE3P9agMWHnUNkXxH7y3REG+KzXE+Er6xMCu7
	HPjZLU5tr8LDL51u2vKmkYI5OhDZpXkfqfwsFK9Wetxo9shy68OyRAkJR9MIm3cEL/0B9uyXNTA
	IOmJvuQ8Sn2zQ0HyUrPxa+ZLAWt3zy+qFFQcy9B7jY4jS6PImad1TMrNZhXHmHeVc/MHfoubc9+
	10Xeeii+NrmSlf/aeG8/nZp7yg2n676wJ6ko0xG+gV3pbaSI92kn9Weo1sRnyPDrh7NbIbEKSwi
	X/C75yal4Do3dl/ftq1jsS5jtP8SSCFMJvFlgpaXPvjFKgTJrazukmStyqik7ZkfCicyEAARECZ
	k/3sxPkFdCyD8zR7R
X-Google-Smtp-Source: AGHT+IF1M++8mF+cTonUJY7nFB2vJymfU74PEfZv8PouRWxHGJvRCRytJrZ5olf9NxI9ncf5U7EPNQ==
X-Received: by 2002:a05:620a:4246:b0:7c5:4949:23f3 with SMTP id af79cd13be357-7c5a83c9ab2mr509810485a.27.1742423260207;
        Wed, 19 Mar 2025 15:27:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d9256asm905918885a.106.2025.03.19.15.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:27:39 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:27:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 3/3] treewide: replace assert() with ASSERT() in
 special cases
Message-ID: <Z9tE2rQxT+qQP2mh@nand.local>
References: <pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
 <pull.1881.v3.git.1742401378.gitgitgadget@gmail.com>
 <82b7344e96683efdac5dfc559a023d81ea0084d0.1742401378.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82b7344e96683efdac5dfc559a023d81ea0084d0.1742401378.git.gitgitgadget@gmail.com>

On Wed, Mar 19, 2025 at 04:22:58PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> When the compiler/linker cannot verify that an assert() invocation is
> free of side effects for us (e.g. because the assertion includes some
> kind of function call), replace the use of assert() with ASSERT().

As a nice side-benefit, since our new ASSERT() macro naturally has the
same number of characters as a bog-standard assert(), we don't have to
realign any multi-line assertions below ;-).

Thanks,
Taylor
