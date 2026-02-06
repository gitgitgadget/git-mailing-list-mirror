Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16815285041
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770357724; cv=none; b=i0ixkrjZlZ9dg+j8kosU7K82kAr79PcsOjCyX5BDylxQfRQMyh480ygOTSdCyG4D/s3VWS6ZeL8qmhEYwnbOUUgU04EVTomAvalEA+Hsa8DIpZHRFtsSLKwxfLAsw0dHpvmh0+Wwn+IqgrdT9nKN9GmovBBxj7Ij2/8foul8ey8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770357724; c=relaxed/simple;
	bh=OWd1PVH0+yQf75/RMMGjbqUc4EegivpCOKlx3r5Boz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHfBnVquHwHdrrPbg9w9uYMD9x5oqhnOZN1ZTcY33bpHVhPlwL6VEF1X8J92GFlbedNZ237n0wT4HHrECPvCHqeEyxJRYNn7iBTgPXvvPSm0L6V2BVeIsKouqVSCbAbvbr6p9hW45CbAHfxHkB0u57oDPbx76cjibfxT6E6t2v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLomcUTU; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLomcUTU"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a79ded11a2so12436345ad.3
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 22:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770357723; x=1770962523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zr4byqaaTVhIa0i+H9vnWXvPXvA4XJo1ve6Zd3rPMBY=;
        b=OLomcUTUQSo/f0ZuDxy/9oG02moHg5/3eGnaK6VDAq8oUmGIuoYT37gWNqqIWtNIA7
         JLqZSAwcH7mDOQmDu4X4HeeMZiUbTj6OQcjryyIDTloDHCsu+7HEgu4d8otlvkZUKs5V
         3N45qZGL7O6np5br3u36rCCGwU5dc6fn27iLRc2NgVbOpjyGhjX7E099eGUNK//1APaT
         Sbx6FpxBSyxydyM31W4g3QPHCZ40kdolpHlKvQwWrHTTMX2pFFn0UlF4i4J3zC5ncOAQ
         N7ijnIPXFa3xueF2qJ6+/UaS5h++of5gWMhaBU4p2d+2Fc29lQ+lMg7NvELVjFfHhiqV
         2lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770357723; x=1770962523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zr4byqaaTVhIa0i+H9vnWXvPXvA4XJo1ve6Zd3rPMBY=;
        b=JjrYQl3loszQfF2lcgN0+JgGfnjnjGI5hIoedCoOfmMqx6QwX/aCctb3XyC55jBUwX
         8i/G5RjSpIkrko8XtVSBUOyI8dODvBGoQFXVY4uilHrwIxA3ZHaXyRfyABVd7vG/uAFK
         LGD8SlGVMn1IYX2UgIDcGQUGOkoclKMvEBLBNyZ1xOB/wONfnIHTFZo5SBZvXvN8AEAl
         /mu2bG1FpCBYvWkRJ7AUXGRoHHZFxu7TKOEy4BCePjlAcqjLRM0XIEq785HUHegY3/Gd
         KP+D39niJSoR0U3W3LvNDkfBhuw2f3O7+S/uvaj+eKB2+vTrLCoEaOoKflqbpLiPsxVu
         IV3w==
X-Gm-Message-State: AOJu0YwxzWi4l+XfBZOcl7hLdPtikuqM/ADDYHzYJHTI10UF6glrGvlS
	bS/VhUffFv2auoJoji+52Gn5seUXZlzaIfyvBvnGGzji0BYT3FMizM9/
X-Gm-Gg: AZuq6aKy3KmxmfOWvfU1+YZVN9Kv3ktSP+HTSUpuxaSXkpSUGOjvvNTrcpOgrgE/FWE
	oHlIEJHvuoy/HU4lkWtHsP8bCa7/tB1v5kmVFWOAEO3LwWvy5RTmfKq3neCavNyljEpfyuz/sg7
	yOz1Tusrk62SlT7k26/CHXFkcnjmCE7+vvYdssALZyXTfwxfaAvUC3I1cvdbzo/wBjPWOWOKJiR
	nF7wYE5ri7T+X9cSEyNkJPOtXmAgONDg8aAIeVyQSpU53+m3UnFVvaoz2d4gwdfqL/+YrwU7CxN
	9XhZkvI3EgjLhdN99UURysHJn7n6I/8INnjrex/L8M0MsU8b/y7bwrViATEmizZEJShssNtg+zp
	ji0GTi8+QQsJV1lal3CtNm13mvKWIfNUCfArJ/5T/pO8EecSZrnBi0abbPSmjlOWLNHk76/2bL+
	HuYgB9ZeVZMX8oRD5FyWzvAEq8px/0SUOqOkd/UW7+6EnnAOGPW4JLxv9dVBUZ93Q2Sm7XkMnII
	0PaUpcu51WatESeHmZH/ntKnGLDpws/Ihte9InQe8mXNt70Ffig4E4YLliheHU=
X-Received: by 2002:a17:902:cf03:b0:2a8:d469:9b2c with SMTP id d9443c01a7336-2a95170bd94mr17727515ad.44.1770357723246;
        Thu, 05 Feb 2026 22:02:03 -0800 (PST)
Received: from localhost.localdomain ([14.139.195.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c8096dsm12243885ad.29.2026.02.05.22.02.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Feb 2026 22:02:02 -0800 (PST)
From: SoutrikDas <valusoutrik@gmail.com>
To: shreyanshpaliwalcmsmn@gmail.com
Cc: git@vger.kernel.org,
	valusoutrik@gmail.com
Subject: Re: [PATCH] doc: fix repo_config documentation reference
Date: Fri,  6 Feb 2026 11:31:56 +0530
Message-ID: <20260206060156.73753-1-valusoutrik@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205131132.44282-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260205131132.44282-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Documenation spelling corrected

> First describe the current problem statement which describes the 
> current state in the present tense like 
> "In MyFirstContribution.adoc, the link to the repo_config() 
> documentation is invalid because the documentation related was 
> moved to a different file."

Let this be A 

> Then you instruct somebody to make changes to the code to make it 
> better like 
> Replace the path for the repo_config() documentation from 
> 'Documentation/technical/api-config' to 'config.h'.

Let this be B

So the Commit will be 
> <short tile> 
> 
> <B> 

And the cover mail for that patch will be 
> <short tile same as commit message ? > 
> 
> <A>
>
> <B> 

I configured my git send-email because I couldnt reply to your email
with gitgitgadget ... maybe it was my mistake. Anyway I wanted to ask
Now that I have changed the commit message , what should I do ? 
Should I send a [PATCH v2] as a seperate thread or send it here ?

