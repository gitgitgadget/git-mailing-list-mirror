Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1910BA52
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705716619; cv=none; b=MydoO0/Uyqj9TGLkhIoDI06GecJhJTogFBBLv1P67rSGpTOjZhX7I195rQsz40AZYxH1gXRLODSY1wsHh/87sYZARrFWXQn1qGtW8Go3zhoFlbtM5bzQWFn1lkw7BDvJrqo9/9dXXYx4CdqS3+Q2djDkU/h5KKbH5gG6GhcCODE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705716619; c=relaxed/simple;
	bh=6BD9ULuaahpERNnQy/NU/Cis4f1CfLTsEiqeAObJn1Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=QHL6sL3PW+6JPXglDaBnDXn7paPrpvioFvdCtmhxTVV6GO1nMWDO7lOxGzQbk/x9zxXBaUD+P9h/gM270F9QKGQ3qehD7VTPrmRQ+tMbjF7lFHFm8ieYetpZtJywl5Fb3BRwNBzHYKhMy+/v2nZcA3TSfHvs1iBQDNvZhmakktA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gy55mj/8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gy55mj/8"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28e79182570so1175944a91.2
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 18:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705716617; x=1706321417; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3zQN747FQdcKRmZcO3/rUNPZo/Wa+/ClKPa9qQcpCs=;
        b=Gy55mj/8WXLYEZhjOhcW4KoyRmLKgg8ZjLT2+8pXgePPBMqfKBzWI62eRbkVT+eFRq
         cx4KkHlviql71qu+DuLVRBSa4ex2ifpHj6HtdQSTptVYsymu59MpPj2xTrVaAGazjPSZ
         Mpe0iyK5DCPvQrtfubtTNz/Sd2h2S4tR4ihUmz5lFVy4UM+bHp0Jw/wK4RZyeQCxSw+6
         oQaN0woSaxh+krV6DiLrW8Sz9xnBzwmVzI7oe6EWo5AXVIOKY1+Ax0qxzXZkBHBbzcYs
         PzSdHWxGGyHLfJU96buEl6+wdvwMtVlMuoV6EfWGMJMfs3kqCyGxJwgdDSrBFL9HFFx8
         ErHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705716617; x=1706321417;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i3zQN747FQdcKRmZcO3/rUNPZo/Wa+/ClKPa9qQcpCs=;
        b=GCYA3qBSUMJl6LaYTfvH4z6OpLBCj38WmkJ5Uw0lx+OV19bl2OaidSqvqCI/slJiXT
         OALet5TTesyE3GK8fO5Gp4+zgBWFlputyUeeKXYPUVnPmHQr4nPyUz388qZK6pOLU7nV
         M/FP8n91q53xaxw2b4eRiV6EX5hPV7K8LXrUsYopJ9kFGGkZ0VrD5G5GlKlL2e5lPMeB
         7gVa1L3N7WiUS7+aLnof1aQDpvdDAl/eQQOXhx5HQYG/oRFjS8KK75klJX44kRGQN59Y
         BlLU9QhXpf+j6HQnQBiW3XHrvouoo+MynKACA0Oy/auSzmqKpltQYGa/f2Wx78Xw4Eog
         2ffg==
X-Gm-Message-State: AOJu0Yz2+VZu2LiiadYB+5lHtYzv1SrlPZpv8AnJCIDjDnhd5287dkxf
	cOLPd1q1bWTI8rK0Hc/4tec6Pjur2A93zhIWzwOW3ibs+xEl5kud
X-Google-Smtp-Source: AGHT+IHBq+rRIObC1heBs35Yd41lA0ELYRcY4iMjkgLKJ9cvXndAdpUYOgjKNHz9iYDgc7i1vuVrdw==
X-Received: by 2002:a17:903:41c6:b0:1d7:2b84:c1e6 with SMTP id u6-20020a17090341c600b001d72b84c1e6mr892046ple.101.1705716617224;
        Fri, 19 Jan 2024 18:10:17 -0800 (PST)
Received: from localhost ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902f1cb00b001d710cb27b7sm2843279plc.206.2024.01.19.18.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 18:10:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 20 Jan 2024 07:40:13 +0530
Message-Id: <CYJ62QPHPHCA.2WLKYX1AIZ50T@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2024, #06; Fri, 19)
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <xmqqbk9ghio5.fsf@gitster.g>
In-Reply-To: <xmqqbk9ghio5.fsf@gitster.g>

On Sat Jan 20, 2024 at 7:26 AM IST, Junio C Hamano wrote:
> * gt/t0024-style-fixes (2024-01-18) 2 commits
>  - t0024: style fix
>  - t0024: avoid losing exit status to pipes
>
>  source: <20240118215407.8609-1-shyamthakkar001@gmail.com>

I have rerolled this series, cause it was breaking CI on alpine due to
a syntax issue which is described here:
https://lore.kernel.org/git/CYIDCZPQN2H1.1ET0CTP07NMYR@gmail.com/

Thanks.
