Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699733EBF22
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 03:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771817751; cv=none; b=ExSqhYEmIoHOZtMjhrJ2xdRSgcY5u1aY18H2DLVpzfQlnqlCx18MNNQfJGKpuDREEmLersz0WOexfc2dgmN3xhoLv+TS3RFMkgAK0sNCCPpmekaMQVQqEA4Z2+sXCosgVQmP+/CjO0VsK/leOgTpVg0PPIQqnvhRUaa+q13d17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771817751; c=relaxed/simple;
	bh=Sl/FOEfvwL+bx4LF3I7xf6X43aRsNc0maP2v4oSUccA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVPRz8aelefGwIICHBYMhKzXxuDugzK/HBTTCqZO8y4tpOZ2QbzM7l+TOYsWfsvme2leQ3sz/7KDhHh9ld42pACn9jHvp8MEbr3S16OGdAL7a9zj0yrEUCj/+CLY03LsJ7u8v4wYSDQgWPrL+AvLajAhKmhrymvg0NYfz/SyXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8FMiIfj; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8FMiIfj"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c632ca0c317so365463a12.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 19:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771817750; x=1772422550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JuDoFuw3eSg/epatlR7+L+CDLWmTIbLS0Y4njvVPrL4=;
        b=Q8FMiIfjduumnTaNzWu79JKCELgmucW0JaJWpt0Y11EltnoYXVS5Byt7MpZwYBVFbT
         9gPA0hE/rP55Q6nh5h5DMMR7owEIqK3ntmKulEjBCtarY+acgklyjQtnsnZ0u/TwJi4B
         s3bhW+jilfcWJQXUz+LlbYMgn0ZiACxdP2RMaDg01QBWnyGbZ7Mloz70vLDD6cjlaHGO
         YUZ65pU6wUvpeLD3TDCgZ6QLbviqUbQVd0E3ygLMWRxBX0dbD0mPFc/+JVWgPLFv8kK9
         RBDNojNb84PSm9Yc9wTHbd+YSWZw93F+PvG0ZByOEWVW74Nfn9vixyhq80gkufpSpy16
         2IzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771817750; x=1772422550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuDoFuw3eSg/epatlR7+L+CDLWmTIbLS0Y4njvVPrL4=;
        b=v3wNRfTWjirPc4UXJoYNLoQAPUPuMvnJUHdMXExrsmlkc8RhHaiKMPDOBeyGOmcPKl
         FQ5f1UT+fTmej8f5WDLbCahFdhT2Hfsg33jk/f4wHLAGBQfgSWMs2104MR+V0A7utZjy
         Co6Ms6+bA69EIF36CzgaFPb6N9mohJT7b00Cz7Jl1KZAQzhmN0ax2dpta4u2GKV3OkWG
         uJqwl6S1rR0X0VbSIfOj1Mj+XhSwU9r8RFpPbGX2cr6pKUyscSLBEtmD2ZGGhAihIpon
         184xuuI3P2FJSPhdNIM+1vZSQPx7GR7/X+xfYBGzAoiqy53/ON2E5eWbMazjQW406R3c
         eWSQ==
X-Gm-Message-State: AOJu0YwIMdT6nO2YOSP7Mu++wYt0JT6zQM0pAMvAeoDL+aef6dlvM0tg
	jgzwGa+9xjsJZw97RNMHqj0W1HkbSjtL852OJGIl4i9NfZFL2qiQWAgihiLz1Q==
X-Gm-Gg: AZuq6aLNUbZ8UJMI6qZSapGxfjjmJk9vu+qbAcYamlN9E26SaYJMO0ZODbfWrOCUc3Q
	cApLTHxEFOmmR5d+YNiLGORK+kGo9fi5/Rpo3Hn7xcdzb/nlBeYB6ogd7Ign8Ho6ju/iwQDiYAT
	kr3odJmjNKu76SpKCllwBaEmy0uy2ZmVP/GoMt4UhCDY4C8e3Wz73AxHhVIiEoJkQSju1VPIYf7
	6oeFPP89qqZeCJceE+zXrWbJJiO1C0LJ8Bi4vhrtRvf2qDUaPp4SMX0VgL3CC29Gpk6kgse7ivN
	jc7cxNNwefTXsLPDvNANnDYQFDZXe7rfjyVPX3JQ8QIOD1LChW45wJB2Zjd7+E79uJqtl9Guu/K
	eOevwuwvGKXdwmyknSRWZpBPTlm5sXi4OqTk/SXFv4rSz6MjAzNsMAogNMT8OgBc1/EhoW7mbEr
	gDwANwUAzAeEGx6+XzkWH+IuQOfUehSqTTpk9aTfMB
X-Received: by 2002:a05:6a20:939e:b0:38e:9479:8a4e with SMTP id adf61e73a8af0-39545f47ef7mr4368836637.4.1771817749768;
        Sun, 22 Feb 2026 19:35:49 -0800 (PST)
Received: from [10.226.142.119] ([119.56.65.112])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8cbb02sm6015827b3a.57.2026.02.22.19.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 19:35:49 -0800 (PST)
Message-ID: <5263825f-163c-43af-bac7-152d670919d9@gmail.com>
Date: Mon, 23 Feb 2026 11:35:46 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] setup: improve error diagnosis for invalid .git files
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
References: <20260221083001.220061-1-a3205153416@gmail.com>
 <20260222102928.377519-1-a3205153416@gmail.com> <xmqq4in8quxn.fsf@gitster.g>
 <xmqqqzqcpatz.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqqzqcpatz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio,

 >> We'd probably need to treat ENOTDIR the same way as ENOENT to deal
 >> with cases where we expect a directory "sm1" to be the root of a
 >> submodule working tree, and we have a modification that removes the
 >> submodule directory and replace it with a regular file "sm1".  In
 >> the code path touched by this patch in submodule.c, we would ask "is
 >> sm1/.git a git directory?" and the stat(2) call on that path in
 >> read_gitfile_gently() used to say "Ah, a failure, that means we
 >> cannot positively say that 'sm1/.git' is a git directory or a gitdir
 >> file."  Now we inspect the error code in an attempt to tell if it is
 >> a system failure (e.g., a corrupt filesystem), but catching only
 >> ENOENT is probably a bit too tight.  In the above scenario, asking
 >> about 'sm1/.git' when 'sm1' is a regular file will not result in
 >> ENOENT but in ENOTDIR (i.e., "the leading 'sm1' is not a directory so
 >> it makes no sense to ask about 'sm1/.git'").

I must admit I hadn't considered this edge case at all. Thank you for 
pointing it out :]

>> Is it always sensible to treat ENOTDIR and ENOENT as two equivalent
>> errors for the purpose of read_gitfile_gently()?  I have no clear
>> answer offhand myself.  This is part of what we need to think about
>> and resolve while addressing the original "NEEDSWORK:" comment.

Hummm, I believe it is safe. From the perspective of 
'read_gitfile_gently()', the sole purpose is to locate and read a 
repository file. Whether 'stat()' returns 'ENOENT' (the file physically 
does not exist) or 'ENOTDIR' (a component of the path is not a 
directory, making it impossible for the file to exist there), the 
functional result is exactly the same: the '.git' file is missing.

But I must say I can't 100% guarantee its safety. Anyway, lemme just do 
what I can for now.

I will:
  - squash your diff into my patch
  - rename the error code to `READ_GITFILE_ERR_STAT_MISSING`
  - combine this with the commit message refinements and test cleanups 
suggested by Karthik in the previous thread.

Thank you for the patch and for walking me through this edge case. I'll 
send out v11 soon! (2~3 hours later)

Regards,

Yuchen
