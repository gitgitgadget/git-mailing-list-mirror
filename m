Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567D43822B1
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 07:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914362; cv=none; b=LAfq7eVI6uAkZsravxUG9bU0nj1vg9bkFMBFjSRUBll74NrRtkFuBfpyxV9f1EymHgkGUxFkJ81vsx2rIl05qHfkCv2c7Jd+RAOsTJPW62x9yIBGf5QbJqcD6acIp3loS1ub9ZZ1CWbiOvzsGTn4bUY37Hw+vCfOWnE++IwOHw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914362; c=relaxed/simple;
	bh=+30AOsHOtF6Yl18I06IC4f8Ws6TkQ7KQ6J5s3DnVPKs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=bcV0f4MpEZh4gp70vRswR/Dx0UdIjeAyQ+jHJPq8XJAtWBNBsOYQEB0QACQnTJRLYsXP5yFr1UpgXTwS40xE82w57cy6SPmKmDlH0ypJ7986OJo+7wsV79o4tIk3gKiyKdQnRYJqN8rk/iS5FKTApF6pX4GlVYQXFMBUvUmzyZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=odoo.com; spf=pass smtp.mailfrom=odoo.com; dkim=pass (2048-bit key) header.d=odoo.com header.i=@odoo.com header.b=JR0ShAZd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=odoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=odoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=odoo.com header.i=@odoo.com header.b="JR0ShAZd"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-496b7622a83so4642815e9.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 00:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=odoo.com; s=google; t=1785914356; x=1786519156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from
         :content-language:to:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wXH5Q9YqejIX7w43TQkBKebhKnvF4PceAc59iEwLdKM=;
        b=JR0ShAZdcjVpbyweHy943VI5gz0Gr4yStQwR0nLS16OaoxuchZNQvxrKFoGjbGcFXV
         77KfR1I0rckNydr7u4FbEYBwXA5yYz+NyiQboxiBlAcJlyo70/76qamfOlLfYKvLLQ4f
         YHCRatKwapMCOc8vLhkwlwwwhNOKJWi8ukbsXt2RQyasEpkGaCTLqgLuM6+NDJNJsnNS
         Z6y2rXjjM+EKL0AgdOCpkJzEASsOMs5QtRgauCvR9TCpWZKHWkNKZUZTrPyeMiPWnlBi
         rW+z2lt6XT+p0sYhkDc7VSCWlBTR73fgTP8m6aOk8DIkWMG5tQEAPxLiDArWHNEoxvHM
         GVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785914356; x=1786519156;
        h=content-transfer-encoding:content-type:subject:from
         :content-language:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wXH5Q9YqejIX7w43TQkBKebhKnvF4PceAc59iEwLdKM=;
        b=bsbBB7Q0wS/1FQ2LGRXigKAgijMYV7iLKtuLb5LzmD3dPK3uTOIhZhJ73c87QtCJ6d
         6cb7b3tgC/lQenT229K0fPUQXsOi/0/XIuYMobYQ10zefAdIT6E31FjBtaoZCaIwVORa
         j+sDbRk0bxNXOXPxvGo0ggr0qdJir2g38DPnJEJraAkqxn2UNE2C8bFj1HyJ0KB9+EfM
         ZEj0gbrXb1Rx6r4OgW2IB2uPDOlgL/H7ZRFnXvAHWscU+te7hRDZxWzmPx46L67/1+WW
         JofDpLh1kH7KlM6LmHJ9GjbyAyYgTbgZXLu/s/yjAGDHyl3GnvUMXrRe7Lz9AcdkFr6C
         dkPQ==
X-Gm-Message-State: AOJu0YyIAIu4kNHHa8fpzUblOeu56inZJFvDfVcyDoHPLNtEeeexxK2b
	yJLRA8G8T869TBJgu+v81bwgL2KZ5grt8sZimH0x0dxU5Vt42/OWnQbbkaAOee7X0hkg24wun8a
	lFaov
X-Gm-Gg: AR+sD13RdCfuL5VHTb/nAdBfx47sVL6AgzjtcmcSrcmkY/7Pjld0Ed0D5pLgxlei2d6
	beGg7hSPdMvylHUVo9scOnKD9wtwDak+UzjdWT46uZRK72msaXI25rYf7tyUesyZqvxzL4q5yyB
	jxGvL3p22zfxqABN4uRTEzza8kA/WTYSovgtSgt3w+HbtUNcvpquFC0+EyocgLqObv+KrzVYu2o
	25GmZCV3AKTQh3jjVMxLB6KfzpILhhMCgS77ZC6h+TDRtB44Lrlhfs2RRnnX3TnuEAancVk75CM
	ctx951Ge8iQ4CZZ5h/QuY4SEyO5/Yrs8v9aM3fHVLufppbWOQucKvRKLZaPkvGhQ5Ox4Qq7H9Iz
	v0t0lyMVP2YAWRPUeELPjioB14FUlkfdCdXIZLcDtUEWDmC7zwZbLR8Q7gTYiXq717Iqt4MewP7
	tQHU0kjFVP99Q6qAIWaP7MzHN29M7oddQogFZPjpflFT5F1+2c6D4J9XqMma7tFQogAwVfYeHde
	qUsnB8evEcZgkLCrBk=
X-Received: by 2002:a05:600c:474a:b0:495:7888:281c with SMTP id 5b1f17b1804b1-4994e6d4a13mr45075015e9.0.1785914356390;
        Wed, 05 Aug 2026 00:19:16 -0700 (PDT)
Received: from [10.30.68.14] (host-212-68-194-130.dynamic.voo.be. [212.68.194.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949f68f95sm174885735e9.0.2026.08.05.00.19.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 00:19:15 -0700 (PDT)
Message-ID: <27d95520-409e-4d1b-b8b1-37a910bff604@odoo.com>
Date: Wed, 5 Aug 2026 09:19:13 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Xavier Morel <xmo@odoo.com>
Subject: `git push --porcelain` has no effect when deleting a ref which does
 not exist
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Using `push --delete --porcelain` with refs which are extant correctly 
outputs the relevant information in the documented format:

-	:refs/heads/<branch1>	[deleted]
-	:refs/heads/<branch2>	[deleted]

However doing the same with refs which don't exist on the remote (e.g. 
because of a concurrent deletion) has the error written out in 
human-targeted text:

error: unable to delete '<branch1>': remote ref does not exist
error: unable to delete '<branch2>': remote ref does not exist

I would have expected something along the lines of:

!	:refs/heads/<branch>	[remote failure]

which would be machine-readable as documented for the `--porcelain` 
flag. Was that intended or is it just something that fell through the 
cracks of code convolution?
