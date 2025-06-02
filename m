Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741CC2C327C
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 04:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748839540; cv=none; b=Xp8qXIU6U7/1pSDTbLiEvKCuRvDunVzWG/2dmaUUADpvMZsCzxoNbA+GtM+Jy2VWzlCt1+7ciWx5GfP1N1IsVEESdMy3Y6F9Hr15cDlW570A9qblg8ZCdwgtoPUzfLzSuwqYqpy+NHj3NLqHsplwbVrKwOWlOgG/rMgw4I/e+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748839540; c=relaxed/simple;
	bh=nMWr+KnhRoYpV31C0D0rPoAdX5G5tge+dQlg0mziBnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYwwtzRTHGQ+FTpNA61z00g9ejdsx/14CfxwbSB/ICmJkygBssA0jzefQ08WkOL5bfhnmqnYx/o3iHPuYFt2HfcTGC0lRoYFu/6svyqMWV6/zg7dwA0qTlbDOlktiFW+D7TkevGU80aG0gb9FxvPL6r92ceqIJuDqKUBo9C+oL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMd6VLe3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMd6VLe3"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742c27df0daso3007650b3a.1
        for <git@vger.kernel.org>; Sun, 01 Jun 2025 21:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748839539; x=1749444339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1wtRFbo0BV63YP8la8Wos1/JHz0hwn/67dHFG/bzxA=;
        b=bMd6VLe3Nw1VF6x9zDCpFbYgEwflK6JkKSU8oefTDSq6hxHRgbCrgoBQrh46DIhT/8
         599foffaHnIUEFfvf36wYQTB07egRLdqAYJDWdrXhwoE0LTc/jCstsABmr17NcFGet4T
         wsa1UzS2kUVwzTumtX3TVC4zdEdN1LTjDlpdQ+uboz1kVsV7H/0kY+Wf2SBEJBOZBKRE
         8ZbH2Yjo6bGcMhZYaWapS9PVQjw+DNkN80hYVsf2r9n1vhxq6Y3W/pqn+4nO44fuFnhf
         IgG2pJ5soCGrW0kVRu1Sb/vTUuI44iLMSDZcc6Ts5gZzOcx6Vld/MyzvdLqKExNIve0m
         zmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748839539; x=1749444339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1wtRFbo0BV63YP8la8Wos1/JHz0hwn/67dHFG/bzxA=;
        b=KMu5iRA9yrzKjMzQu0H6cMbtMNj6FnBw4KbI32nnXpt4MV2qFVgitROy8EOMxraFF/
         s2YWwf/c6QBfZ9b0su81PmR7LanhJn2z7av4Dahb6h7uJ1KwI4aY1XPc+1xKOCTmirNS
         k2KqGLhIbyXx5+31OqTv4oo4H+AvmHDjCfpSULEjMVShbWYXLYex4JsGQps3nvz6fEcZ
         N04QDjpk1sKgtcThQKTcZa8s2OQOgH/SdqWvMqMuM90CD6m/n29C/eI9oaIokHI6Phdh
         d0VZDVjisAzGvfw4/YU0J0AnflBCm8lfsFNVyxcVyAchokOkWbjNVWXIHFT1xj2qgqFR
         QtAg==
X-Gm-Message-State: AOJu0YwHBGK/LQOvIBUZWhFfQLNMLWa6YAd/5Ze/lqwTb3uyKwyA5ELF
	Kfohn1i49us88e4srY/C2MWUPzGSuslCQ8/yZuFcYZ7mJmj1/KDTc9QEsuF2Sw==
X-Gm-Gg: ASbGncsnI9ozy3+M6M10Nt/qvcW3FldmMAgc0AOKtQ7ynWnBydMyMNGJYXCjeylxjUu
	6r/maFlCRi/fKn5WBsL7Mao6YBvrbchbEAQJ4xaqyKE0xVJoVjuxlRvtBDIVmUbnwQKt00CtVM0
	d+guOBHqgyC9vkLboZxOWjz42OfjUHuBuK52u70pFoAJ4UwkYfp50WUys4nT/6yRqdKxqP+Dvqy
	m2Rk9+JGeDSxNFVBExCly8uyWyUI2QfLhsumyWkEQG69gErCDLZ5detCAfJcK868S3Ce6Ev3TKo
	544MdS+sn+BpFB4DmPkCHMTjoKgWmS9BtFjq1FDLT1F+XnhQIq/ONISoC5AQur2Kfcf9MGAak8c
	XaHp5j8uXxtAqWU9YfpaEbi0=
X-Google-Smtp-Source: AGHT+IGpOW4yAssTdmfyf1JC1u6QDzpn+jrC3uA+R9PD+8uplQKxbb+CjQvUheFI3N2PCOf8yO5C5A==
X-Received: by 2002:a05:6a21:3a85:b0:1f5:7b6f:f8e8 with SMTP id adf61e73a8af0-21ad95262b2mr17505857637.6.1748839538594;
        Sun, 01 Jun 2025 21:45:38 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:3d58:686e:64d7:5163])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeaad78sm6666115b3a.46.2025.06.01.21.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 21:45:38 -0700 (PDT)
Date: Sun, 1 Jun 2025 21:45:37 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Brad Smith <brad@comstyle.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] config.mak.uname: update settings for OpenBSD
Message-ID: <o43c7pn37zdhpw6awst7itumf2ogshie5hykrcpz4sdxbhx42x@zgqoztab3vvi>
References: <aD0XIxPRQjA5t8oi@humpty.home.comstyle.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD0XIxPRQjA5t8oi@humpty.home.comstyle.com>

On Sun, Jun 01, 2025 at 11:14:43PM -0800, Brad Smith wrote:
> 
> OpenBSD has never had the BSD sysctl KERN_PROC_PATHNAME nor
> does it support or use the /proc filesystem.

... since 5.7 [1]

Carlo

[1] https://man.openbsd.org/OpenBSD-5.6/mount_procfs.8
