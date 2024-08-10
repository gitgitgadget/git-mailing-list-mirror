Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193313D512
	for <git@vger.kernel.org>; Sat, 10 Aug 2024 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723320703; cv=none; b=HL0VHAqa+U4GkiFGxqhZb4w7VhBPmD24RDeAKfroS28nfol1pJu4d4YiH97ZTZq5kRS2AtQ1+FJpTQrJg96TutZmM8XjaTUUqWbSMZE4Gk64IA6izkgSRVBj/Bc/jcqjFM+6itHyJm/IssXWKwcKnW2uljiKopi0pPSofxyB4gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723320703; c=relaxed/simple;
	bh=//8IR7fn+qz41r+K2fKtokwe8TV7RL2fztrqrpDX2JE=;
	h=Message-ID:Date:MIME-Version:From:Subject:Cc:To:Content-Type; b=qnutdswhnURCovjDa9LKU510eYmANcqt/K1xdY6G9fLGFmQ8cKUrJe/8ufG4d3AVSTze7CVa+u7xDiATJLSXPaLJNWYrlZhOf7pb/PslJqZHHX3xVK3kh9fGme0TPgBu9+v1QQewZF79JET1lO8oiBemgtH2yOgHJkTl4Mh/UA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9NEz+rw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9NEz+rw"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428e3129851so22539455e9.3
        for <git@vger.kernel.org>; Sat, 10 Aug 2024 13:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723320700; x=1723925500; darn=vger.kernel.org;
        h=content-transfer-encoding:to:cc:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUGzj5PS36CK4npKy8i/o4V8LONOdrNZtFADaRGJtl0=;
        b=Y9NEz+rwIGZvP42yVnexlpR2zJR3ncnP20a2YJ0ukrE3HjNly108r61fEjxLI2ZVqb
         3f1DcAG+BaXK8oR3OBBz51T0n8t9iTQFEK4e2ol2BDUJRfotsdt9Lj81/Hb/YvMi4f/w
         VZCLANTKF/dtiQjH+OjNkvsOoDkw/E0V+dzo9Mc3PClhunniy4eyRDwpis+xIG5oY38G
         mBZnilWYqJZY1qTVzhmyXKGYHg5HYPjXtAB8Xbdy2S0Nv4cT0J2SfFApO6KStoae7DJH
         cW+nKIOjFCfbZC5RSz2bgcOxVbQcu3RnyAgHywmgLWVWb7FUYgLk0L6LE6LA0V34ZlsG
         HGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723320700; x=1723925500;
        h=content-transfer-encoding:to:cc:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KUGzj5PS36CK4npKy8i/o4V8LONOdrNZtFADaRGJtl0=;
        b=Qg/X1G4zGbNG3TUEfvrYla6M8xWPtcR6qkjXtvePdlRWWg5HJcSd9wa3nPmtNceXU0
         sppRpc/rueInK+nMKIUN1tCyMjtUr+IByk+3o9ChAjhAx0Ftclu9WI09y+9Kh5iPWqff
         AKn3HqWm1aTdDvGswFjQ4FjbWCeeS7LBIn3mlqWJaEO+xhW2Uapm9270KcBYGgK3V6Kp
         vITIO8oa9msTJq9cIwTh/rCe/wVrBy/EbNmPPWXnrmdFBG7PuSdZZgvUiXYBuJ7qx2/o
         XRXvLMr4kmjS1Rat0djygq2dfBaGwsIjslCBVFp5ykGHNvyo1G23r7aMOl25Jq2qnOVu
         dXGQ==
X-Gm-Message-State: AOJu0Yy7ud69Pk4IQqWC1OTWHypUjaXtPsOKqWDdQX96VZQzYB7KEjtO
	VIqqc5GCGKBFz1BaE0GIEfK89Y9Xw433YuxeN+qGW63NGGJHuNxaYQK7OvhP0hM=
X-Google-Smtp-Source: AGHT+IHqqoeJRHxsE2UovqFpB8PLZLvo/ovWDjL7g6pcr3frck66bF4KgI6zWavCtltpr/9l4pdlnA==
X-Received: by 2002:a05:600c:c1b:b0:426:6822:861 with SMTP id 5b1f17b1804b1-429c3a5a0eemr33210315e9.36.1723320699701;
        Sat, 10 Aug 2024 13:11:39 -0700 (PDT)
Received: from [192.168.1.5] ([197.40.156.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfeef76sm3181276f8f.59.2024.08.10.13.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Aug 2024 13:11:39 -0700 (PDT)
Message-ID: <31efb040-57cd-46a7-80f1-62a9ce9efb52@gmail.com>
Date: Sat, 10 Aug 2024 23:11:30 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: =?UTF-8?Q?=5BNewcomer=5D_Introducing_myself_and_expressing_interest?=
 =?UTF-8?Q?_in_=60Implement_support_for_reftables_in_=E2=80=9Cdumb=E2=80=9D_?=
 =?UTF-8?Q?HTTP_transport=60_project?=
Cc: ps@pks.im, karthik.188@gmail.com
To: git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

My name is AbdAlRahman, I'm a senior computer science student.
I'm interested in working on the `Implement support for reftables in 
“dumb” HTTP transport` project with the help of a mentor, I'm aware that 
the project is not being worked on in GSOC but I was wondering if the 
project is still not taken in general, and whether I can work on it 
outside of GSOC?

If the project is not taken, what should I do next?

I'm also aware that the mentors are busy with GSOC and might not have 
time now.
I'm OK with starting whenever mentors are available, but hopefully, 
guide me on what to do until then.

Steps I've taken so far:

For git:

I worked on one of the micro-projects, modernizing a test script, The 
patch series is now merged in the `next` branch, there are still a few 
modernizations left in the file which I will work on after the first 
series is merged.

This taught me git contribution workflow and to expect to do multiple 
iterations of the patch.

For the project:

I've read the resources provided in the project description for GSOC [1] 
in addition to a video [2] and an article [3] by one of the possible 
mentors.

This gave me a high-level overview of the ref-table backend.

Thanks.

[1] https://git-scm.com/docs/reftable

[2] https://www.youtube.com/watch?v=9ky8tW778s0&ab_channel=GitLabUnfiltered

[3] 
https://about.gitlab.com/blog/2024/05/30/a-beginners-guide-to-the-git-reftable-format/
