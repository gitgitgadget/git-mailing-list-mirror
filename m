Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F58345741
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534019; cv=none; b=kNPlb2uVjD6PVY5dMOiPw/7cN+F41VYXAsskIvygZA6WSwXir7A5KV1PW8KhiqH5kv53S4b00Mv9uad20vbnLszYthBAjZf0WfoIdOupUGFf+SO2gU0faeYlNvhSnS9GXjuO2eynDKOC9U6DRyrOfpy5P6+aYOexSRPbNJQFWRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534019; c=relaxed/simple;
	bh=/FbH6SXkv2I/oynQ1lNL+N21dkhij2UoJJNnlBEyy8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C0LlObim2Nzh6om4EHhNMeW2ySoKgdmdWMUkErRuFEcq6gaF0zQVSjCPRmwoOk0LRSAKDUXRjDeqimnNKoP8AdD0zuTePtYFaT2XsmB0RC+wIGZFJdYSMATgKo2xbkizjFPlE+NPXN/BAUKnmFIeHn9tZc01WBNw5rtE0VhSSao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBw+aXar; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBw+aXar"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso496132a12.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774534018; x=1775138818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4u471OOZSfOYIJ1vCT3hokYxwMz/AtbbjVXPiybKchk=;
        b=LBw+aXarslWVhv5cTWbR13hP1CXlegrupPkeDwLRrkrVF5HrcSJ3o1P1vTzGZ3n5zu
         BvbLUVBf5HE87WoqtctDjM+S+4/IeJiG5yMcnlV9HgQsA+szyUoEQ8Z/DmKANtN5y7rk
         tsOR+m8kOcz+jdVbZLAd+n1dtDFy33H/NtJCnPavjUdp9if8CSvD7+N1Eeg6kP9IGvyB
         +7qPYLDHGK/OJPbWDh8LPWMFlmZW5BygYqGcln3xPQdU5GgWNxNkl5uR4nG4XYY3t7dg
         R9qGQW9MU4Q7iVLbnmRKPuOU6kgq/Zp72zJTjOnhQIgQ823eoypacL15cPdaSaWCpghY
         BfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774534018; x=1775138818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4u471OOZSfOYIJ1vCT3hokYxwMz/AtbbjVXPiybKchk=;
        b=tOv3ZDa1w8JTY1EfxcV6vR7U+Jj3mT3W73cN+ksPJSdHq1zDAE+GHarUlIpy907HGj
         7/Qy6TMwriaU+aYn06GqfIl61nkUtBEGfLZbqGNA3+HZSG+bOKAEAEkrLB7asOrgDJXo
         cC51VWdAN/NocTzJCQpjj5xmFaepYhFlS6k7rYpB78z0FN+zPCrUJ/rPZGG32BDxXkee
         hhyix2A/CkMTKiFOGto0BcLUz+j79Olj+b2wHMg8C5Dals6aXotVfnbNZRwjL4VO8hVg
         A6x4v1CM+is2HvB40A55/bPmbRn7Bprnoo7rZZI/cn0xIARIx3OXs4mOzBlVY2cc8+J+
         QELQ==
X-Gm-Message-State: AOJu0Yy1wtqYehmaeHAkqU8bkoBhuxY+l0iqv2gduKWqjY3arUQzOKNe
	SqNGYDvFehQAp+F2/qhL7NaGxfOQxogavLq6f6SkQZR802/avjVYu9GHQsOafl7G
X-Gm-Gg: ATEYQzyouc9si32xNtEQoVQAWuAKM/bDjhBblnr+jeUgyyZE8rXgCzeXg+QAmKn7zDf
	cjQVVMBU1OD0WniRnrfHf1AYJXTD8bGdDnHeMSGOBRwt6iM7fNdKbChN583VwLULzmOMpv3bFir
	fPzT2LwHlLVz/SAhTQWmKXS2NHnYVoAU3aPW0YlRJceFj5LG8rSIWAdW4lgaRPtrnx8+1txQMFN
	PzkcQTnjjVLI3XZeqAJFE+hzdxyRoptDkSkmpgYiYQnBvEM+pA7rDnRGgLy3/ApiKGg+T+31Jn1
	9W837oTRq3DhKEXgog0XROBuCyXC4L7e1yloOq8eeo/ckXeoekkjJOAM5OGNL7GxbD5N4cPoA56
	bnzoknH6XUt27Y71Rry1dfmAlA3Zs8VZuwG7P9kHB28omKgLgvKe8TJCaEd6P7r4xcsJn/xOyxo
	Px3Tnm5G5ePWunYLRJdbU9XoVKu22LmPAu/uNTPFqYxiGk4zQ5CVHrBeBePg/44YO55MmbsjaWE
	6lnL09gUw==
X-Received: by 2002:a17:903:3884:b0:2ae:5655:b16 with SMTP id d9443c01a7336-2b0b0a140d0mr84712515ad.21.1774534017751;
        Thu, 26 Mar 2026 07:06:57 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc9176acsm32140725ad.82.2026.03.26.07.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 07:06:57 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC] Introduction - Trieu Huynh
Date: Thu, 26 Mar 2026 23:06:34 +0900
Message-ID: <20260326140651.145384-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.53.0.719.g41688c1a23
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

I'm Trieu (full name: Nhat-Trieu Huynh-Pham) from Vietnam. I hold a 
BS and MS in Electronics Engineering from HCMUT, and I'm currently 
working as a Software Engineer at LG Electronics Vietnam.

I have hands-on experience with C/C++ and am comfortable with SCM 
tools like Git, Gerrit, and Repo through my work on open-source 
projects, including AOSP. I confirm that I meet all GSoC 
eligibility requirements and am interested in contributing to the 
Git project.

As per the guidelines, I have chosen the microproject: "Avoid 
suppressing git’s exit code in test scripts" as my starting point 
for the GSoC proposal. I will be submitting the patch shortly.

I'm excited to learn more about Git's internals and contribute 
meaningfully this summer. Please let me know if you have any 
questions or concerns.

Best regards,
Trieu Huynh
