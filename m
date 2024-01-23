Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960D839848
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 21:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045916; cv=none; b=FWNOvU5W83dGvUxoS+0VyWG8d8AFgAYsonBecb73dgpIg5RsDyhTq12P6fpg1wrlqTPQrDj8NpfQGZ//j713YycrR4GESg58bR4WGgU1yvq4/MYnaQ8/Klvo4XjE+XefcmIEpoTH9y/2/p+V/WU2xRMo5ln1TZG7kVNL/+oM+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045916; c=relaxed/simple;
	bh=o3Dgg6QD2TT0DJDw+yD68TaQhWoJ1S8265mQd69fB9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uiJ7cZ2SsvXki9dy2f9B12xC+7ZbaQelu2oADIP/g9eP48KCLpyfbPrfK0YdiYwFb8t9NWkVc7mTfvRGDcwUXvPszPcQrSVgBf1awHaaXzi4mGfKz/cepQyDmzLJOyKVneSvN6M3J8PDM5Htl7+KSRTJrq0Vkbg4tAaWAyOI1t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h85zukjV; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h85zukjV"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7838d1176b4so104342085a.0
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 13:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706045913; x=1706650713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWm9SjrdKzVGLHpyky0002tF/zNE37eSWbLxPbf+6vk=;
        b=h85zukjVx0G9XEvBzuVVdxQ4maxXdrsF6sRTZA9lAcxHZEPW6w3X2JqgdRif7a1DgP
         blE+ZyqEjM/K4d59jsC+PWVMhjgeoyiGfWwyOl9MYXbIZKNh+ve2yOrL2ub8D2T9uLfC
         G6ris+Vbr8XUfarwfm0NupTrv54I68URTRQufBNJQYSPy8Z+5O2KpekzCWjVpR6L3QF9
         r0C8sVfZdPQObkZN6R9BvKNFPxqtDM0ElpmV9dCDhAY1x7VF+0J7vDqx3VzI1mKiv4Og
         FLxfLNVLQzByh/+fDQk98yKJ9het6jmqFb3ERbeAjOerWuIATx2VBqK5ZClPa9iN/uo6
         VXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706045913; x=1706650713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWm9SjrdKzVGLHpyky0002tF/zNE37eSWbLxPbf+6vk=;
        b=VfftSX/1aam8jo0yHazxLKYxGP16e2VxhvWGlMbzx5dVpyrKf9EEw3QNC9ma+lagqw
         8WMqoA2bYJSK3DkaCgGXr/Pdni1p04SYfn/31QHcUACSZwd1m0aWeQVCE5QOqfAy37IH
         2AzWJhoeGp3qMZhZNnEt5nlPMN+9MVICdjsYkgkSFej366rbxvf+rGw0b8sTaiayrhwE
         feGwhMIlCMUrkNm2ocFBd+FFndb7nqOq85xgMydhbjZopxGlCL4l4LEChmsodJVAxQSv
         KBxNlXO5Pf+DGKB0fHDgPRyVLAzO00y3VaD1Gwo/m702ZL0VDW669VFN3IA2OFN2buZ5
         ejYA==
X-Gm-Message-State: AOJu0YxmUecIN8bMc5ZKDhb+/vJj760xO/CYfwyGDmRkCoMH9ZIBUd7r
	b1+K5QDkl2JKcHuaLZYdQWxjrg7F3KLO3pS+gmtFaDvrIAadz22AQmYxLgbB
X-Google-Smtp-Source: AGHT+IEUSgKrjbQhale/iNdWWC15IGzqQoVflMuyPMtQQ9OgaYhPNTpQF0JFjaaUo0EBTe10pIuEPA==
X-Received: by 2002:a05:620a:4453:b0:783:9aee:d891 with SMTP id w19-20020a05620a445300b007839aeed891mr540259qkp.7.1706045913242;
        Tue, 23 Jan 2024 13:38:33 -0800 (PST)
Received: from [192.168.1.160] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id i18-20020ae9ee12000000b007830d515973sm3441338qkg.56.2024.01.23.13.38.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 13:38:32 -0800 (PST)
From: John Cai <johncai86@gmail.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] reftable: honor core.fsync
Date: Tue, 23 Jan 2024 16:38:32 -0500
X-Mailer: MailMate (1.14r5937)
Message-ID: <51A9851B-418E-47AC-A6FE-A411F39D4D92@gmail.com>
In-Reply-To: <200cff64-cf53-4f91-bdf4-5afae2d2a127@app.fastmail.com>
References: <pull.1654.git.git.1706035870956.gitgitgadget@gmail.com>
 <200cff64-cf53-4f91-bdf4-5afae2d2a127@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kristoffer,

On 23 Jan 2024, at 16:06, Kristoffer Haugsbakk wrote:

> On Tue, Jan 23, 2024, at 19:51, John Cai via GitGitGadget wrote:
>> This commits adds a flush function pointer as a new member of
>
> I guess you meant singular “This commit”?
>
>> This commits adds a flush function pointer as a new member of
>> […]
>> This patch does not contain tests as they will need to wait for another
>
> Out of these two “This commit” is more true for the future `git log`.

yes this was a typo, thanks for catching that!

>
> -- 
> Kristoffer Haugsbakk

thanks
John
