Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F663A1E9C
	for <git@vger.kernel.org>; Mon, 29 Dec 2025 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767001406; cv=none; b=Mi7xBMqQB75DUsH7KtejpkRcz8AwgWyf5L8A+8Q4Tqxz1F55bEP58/2K7a4/LBz9Mszaf/DA6bTs6eVUjokpCMSJXA0yv8GEO6YsxKdpv9J9f/YLUaCmoBTPnDnm9icfo39M73vLMNOZdZb6gsAwzlgcoFbRQJZjppPxA2jXQhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767001406; c=relaxed/simple;
	bh=MEb+9PBU64tFfltTWd4wU9T7y1T2cEWOYozP+eDkIu0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=X+S43saW3b4vINf9S+Dgq34ZIhyTmB3myQ32JwFLtWi7nC0EuX1HVMSXBvWxGJiQFG4NSf7Z01oBOz/gGvOJHVYQkmgyG8Z9tI1rc636QiW51/N5l/HTKFKvxBoUVeXEY6YOE6Hso5Wx4AOImQceh/UF0x+cYaWdt9D4SIFv5Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+aSEP4E; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+aSEP4E"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-55b26332196so1914729e0c.3
        for <git@vger.kernel.org>; Mon, 29 Dec 2025 01:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767001403; x=1767606203; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MEb+9PBU64tFfltTWd4wU9T7y1T2cEWOYozP+eDkIu0=;
        b=c+aSEP4EMYXWEqITNA76IqmNtvMnCeURracB1xsC4iFSa8w+QsTJe3yQWDQg54/77l
         e22s0XgKVjcyByRVjjTnAr4Uw5W+Su+MVrKWq3VC+ex0mmjeWH4TbNOIbQpElcVv3cbR
         3cL5fYpODcc1LZDbvtIeppXk2xvbXExxCNd3ZBkXaepVoUAzGSjp8l/IfE07I1nSwU2z
         3RySK6vzhqV+Qsg/OA9cLHiUyRQkDFb4OhkngsIB7FlngMpoVQzPOz2144oVm2w5MqwQ
         6NVmtUXV6dIIeFQiZWkMdXTo3I/UGsSPZk7mfgz5lKw8u/qF6JvBFq35UljZTAw2vAKr
         5naQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767001403; x=1767606203;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEb+9PBU64tFfltTWd4wU9T7y1T2cEWOYozP+eDkIu0=;
        b=WWXm2zwLoz8VKCNvH4iQ0IIPWHGMd3iPudBuaP9Cxh8nhoDuspuZdy62UHMw4zyO+Y
         rSOYdu6D0WfYnZWKZP/MbKdE1Aupumo9KXvAo0RVh/GkBAyIRHdZ7dsX8jDrbrsvZjGk
         SJ7NhYii5uDStnxKZVe1l+jqit/rzDJLg1B23HPrp07hmz0tK3IzgL9kYeHG8tTF0rPF
         EC6Wy8H73dHww1ZaUl2KOzhZ4/dCrGbx+TZ9scyQ4lcJjhk+ue+rWP3toYPwjDlz9XOG
         BcFa68RkHFctk65NMvqGPQZnwZ0OlbLERBxD9XbgJ/fX3/dfPQXjY9YTtpsNumhw/tSG
         4bMQ==
X-Gm-Message-State: AOJu0YwQaYipmKUj0rU9HgfStiUYiPYY2bbit0bdLBebALtIK151TJDc
	l1yQQGyLH9T4rU36xVyW2byBr+BvV5QISTk4RKytXK2AlTrI9rCYFmvj0AVxXRfNINmKc0iYEkD
	6YbytoIdOYcbmMyfRZY8FClgQC8Z6vWOvjnWMbYU=
X-Gm-Gg: AY/fxX7I6mk6ccyuwuZaoHTRokOgayt5IRGYgaP4iHcn6+wBnwA6D5TLPl4APWKgNvp
	BYXZ4RQ4hTdwlf4XwrO1r133t1nRutsp596M965hA0PmKVntks/LUPxSQvk1YpoHQj3Ii/XO5z1
	4YV5pl6EzjzKf7/jXhda2gAT3OpWXuA9rwFPH8VSYZoxPKTpoLoCb2ZKQTuNn9xeQOrg++ZyJoV
	t4B/PTstAZeBr/XoYumFE90GXeJmiRqZ98nOc5dkZJU2vRdzjr9nCoG87DfMT1fv1hTnq4cfQ==
X-Google-Smtp-Source: AGHT+IGdBfKlDjfdzU4kHP+8qPtOVxBPSS7bTKi0KSORkKM7Mn93yEKgQJOtbyJt+jONnhVavJlGOl2osH/xRYUpv0U=
X-Received: by 2002:a05:6122:3d04:b0:55b:305b:4e46 with SMTP id
 71dfb90a1353d-5615bebc740mr7992933e0c.18.1767001403403; Mon, 29 Dec 2025
 01:43:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Mon, 29 Dec 2025 10:43:25 +0100
X-Gm-Features: AQt7F2pwoakexVprqLld57kDxtNP7XI9uqHr9LbKdJC4gX8xbrTjxQh9k2o9aJo
Message-ID: <CADYq+fa1BB2DzDFj4+GLqtDPg55JCi9VGCv0pgj2C8y_PaM5rA@mail.gmail.com>
Subject: [Gsoc] Early Introduction
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Git Community,

My name is Abraham Samuel Adekunle and I am excited to introduce myself to you.
I have a strong interest in low level systems development and I have previously
contributed minimally to a couple of open source organizations and I would
love to start contributing to Git for the upcoming GSOC 2026 program.

As suggested by Christian and Lucas in previous responses, I have read
[1] and [2].
I look forward to becoming a part of the Git Community.

1. https://git.github.io/Hacking-Git/
2. https://git.github.io/General-Microproject-Information/

Thanks
Abraham.
