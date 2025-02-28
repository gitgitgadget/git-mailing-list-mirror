Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5B61B6CFF
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 05:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740718935; cv=none; b=M5dp7QKJvnf/50XKpnV+UlVpC4wdeT4HPPYj08JUb7OPRW+BljKIhHD63QcVSlJUrnbsdUmUHGAK9+yNhAXrgtQHzjrmlBiMB4fOh/El7UvYJLV154NiD26WZrO8icX3uQFMspO9PDfviA8Y4g21XX110idNCyvNtHzDH9BhEhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740718935; c=relaxed/simple;
	bh=SHmfYwZBb9C4WVFLT6mV9ZRQCBP/UFpABhYSJEVQBqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sf2CXxgwtCwL9OC0IFzpGoYUujZXlF8BVQKHIJhti4pGqKFKyLOtPK5BvsffS6Y4aUfyoqM8EJLPq69I36k9PMgYqsdN6xpcyb1WWy1LGuaGutm0I0lOJEkxAdSqT/jJgm+DfIaa/xisKZmB1kjiKjyjtwX+nAcoZWtXAEJ2pSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiGFU9KS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiGFU9KS"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22114b800f7so34301305ad.2
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 21:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740718933; x=1741323733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qnLcUGj0cy7MjiKS4CE+ESanRVR2a/Ir2JEh0viQV7M=;
        b=hiGFU9KSG8DORgm2tksOgV8R4jKJkQEW9eFFB6HSG0P166U1OCY/MsLgYjHi7aVRK2
         Aot3m5JEzi4DmZauMe4CiVmxhXZYhgpzMMvo6VVFcbZVksj3uPZOIbpIbrhncDY6N79k
         6GYqvy2FT6jpg8j4vEF5vxeKgNkMuyp2k5s1kqNXVPChps0zN/tSlN6ZkT8UrulAV7wl
         0vEoNnNwWgpsHqngQ3rQElQ6sbeudVT//C0JhsqiacjQ1e0qYw1HW34I2XxWi8zgOuqM
         DTJVRda+mz97a8mKhfLn5JFJ59dT3D7JIp3riKiriZe5SQNrHgHqChgXNbOU2BUGTux4
         mCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740718933; x=1741323733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnLcUGj0cy7MjiKS4CE+ESanRVR2a/Ir2JEh0viQV7M=;
        b=BhoJHr1quZW/r5W8ynVGBL1NFICtJybAa7seJHasbQ99CDqvjgmM4vXxi2L/A2RWsg
         MrV7LXQATmCWLhFndiYZtF9DEfhSK3QPaCt65owTfI8KHyqWvsnoO/bjzzD71y5XtyBo
         MBX0dhGRtSHr8n7qcBfVwbAY1JGvJq0yKjp9c1eKgZm1IBb0NvN3TYqfhFhwtD+Dsj0x
         D/lrWOhzUzsakFND4xTaia2BtELOht47sX5Yev7cQsuiJ8aFt8SZrV56gZJLmabNJiUm
         FdyBivyFsKAtBQO5otdLXPYStg3V9jZ7isbRCR5n7K8yryZ7/3telna1v7OJAzhgDuJa
         HlMg==
X-Gm-Message-State: AOJu0Yxh9uVlYy+u/S/MwJmkc5deTVJqU+2nJ8FfjX/iWG3ON4ckdcw/
	2VNtrVmMvQHU9RiD1pLxewKUEQ4U69NzXmYAPvPjb56a7sL53kSY
X-Gm-Gg: ASbGncuqllD5EP8HObLNxQuiV9/vjyRfXXkpHUjfy9mql/OU5YUV++YmCZ5xTP84ZYC
	62OR2nCFfp2dmjuYCTHm+iAtZdILphhc+nT7garoAoT5D321NmgHe3YArsWX8nQsbozg5R42shb
	eQ795Dloi5cg/a/jL05xIWve+ocOtxFgJQZDM4KGLtG5GpopQxtc7iiGH2Bi7amtzC0xUAzKGT0
	+pDgR9CxNbwlBmEgnastOle/Kp/XVymRbUrxt1pb41/nvZOTowaygT2RwZSWu89ZyHnQeNf4YfT
	7A7yRm/OBBpQILt8rj+qvg==
X-Google-Smtp-Source: AGHT+IG9UCY0QPPp42hB3va0eEUDMd7vpnS9pZs4tuYMM360iTEDYYkPGxrCf2+E/C8wf+Y8zEAsMw==
X-Received: by 2002:a17:902:ebc6:b0:220:e63c:5aff with SMTP id d9443c01a7336-2236925e517mr28043275ad.47.1740718933368;
        Thu, 27 Feb 2025 21:02:13 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fe6ded6ebfsm6905692a91.1.2025.02.27.21.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 21:02:12 -0800 (PST)
Date: Fri, 28 Feb 2025 13:02:23 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 3/9] packed-backend: check whether the "packed-refs"
 is regular file
Message-ID: <Z8FDX9-BbAt4H1RV@ArchLinux>
References: <Z78bmBSrDR20GY6g@ArchLinux>
 <Z78cAU69IUSDgpuD@ArchLinux>
 <xmqq5xkwd042.fsf@gitster.g>
 <Z7-4XRCVvLjFCFR8@ArchLinux>
 <xmqqeczj9vh4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeczj9vh4.fsf@gitster.g>

On Thu, Feb 27, 2025 at 08:57:11AM -0800, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > You are right. Actually, I just want to avoid assigning the `fd` to -1.
> 
> Why not?
> 
> Between leaving it uninitialized and explicitly initializing it to
> signal that it is invalid, the only difference is that you can
> programmatically check if fd is invalid and refrain from calling
> close(fd), for example, with the latter, while with the former you
> cannot.
> 

Yes, that's correct.

> > However, I didn't realize that I would initialize the strbuf later.
> > After waking up, I have suddenly realized this problem.
> 
> Given that initialized-but-never-used strbuf does not hold any
> acquired resources, the current code at the end of the series is
> still OK.  So there is technically nothing to fix.  I'll take a
> reroll if you later send one, but as I said, I do not think it is
> necessary to reroll only to add fd=-1 initialization.

Yes, as you have said, there is nothing wrong at now. And as Patrick has
nothing comment. I have sent out a reroll to make code better.

Thanks,
Jialuo
