Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3853B2FD8
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 19:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389206; cv=pass; b=O8AnVJ778kvZ2CJMb2FrAVGgjyq2gNcQFRSM+hF1wI50zLOtl3KFG7Xa7BQ1oe+udWB8mA1vQeCqQlUJG6aeiF7mpDGHOrYeNkPLcKsC9mp5t98D5RNSUWdzhyh2QLKQcx7Azqt/YkMl49sKkwluNkwux1kWDc9uIkMsJbqHzgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389206; c=relaxed/simple;
	bh=RsR8FO6QuNcekmSDhj3+ZpjW8G7HhjWQANbYEG+9QKo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mAa/G3aKgU0LLyHqrJmFTq2bx8HBfAscAzD7jU4Do2eZ8zOcvJPmQOBLY2kqZBnM8SmCUubzgwAQuv12W7T/LzIAvdjbXxs5IFdu46oakjRA3Y80Eof01WapvheEZ+MyiDCfXe+g95oMzMypgw2G2DgtcVuAQWKJqAgQkiuaBJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sfhnt/52; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sfhnt/52"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8453427d3f4so2275467b3a.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 12:13:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786389205; cv=none;
        d=google.com; s=arc-20260327;
        b=HA1Zpjf53dRkTEin9Wrz/qimHnh6Vjyhob+ANbZRKmjn1Mc758w+6Tubqkrqfxivtf
         NiN538L1olu8/Qu9hxqRjqC44ambXNnDsNS0FShmGk7bDBQSNdrsnWmSxEfE8tqvf24k
         4Fare60wvfzj7NpDezzMAUAbOfuDJ9cseM2ysMMkfjFEuyDQY0hmIt6H0u8nX8IHvNY6
         tV/uUsladRaLjO2Np/VM7v267fbN1IT+rkZ8rrgkussQt/ZNbEqvWlj/vUMnHnvvIQfq
         itd1bW6hPe/sEukJ25DvQsc054i3qVbO3ufFp+jenoiIRRov5+SlVwXgOV4L1gL1bw0L
         cgDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=RsR8FO6QuNcekmSDhj3+ZpjW8G7HhjWQANbYEG+9QKo=;
        fh=mJp7zD/aNhugTOnrL8dQ02PHrLAVRLvBineKoPiKXAA=;
        b=MF3c0iPGAQDSYreu1P2bwmA7QT4NcQzltpzVX5R1qYaao/vP5bG3sF7MxLvL2lq+7N
         TKpSXxho0iTn9GpChHZuWKDgTKysCLABUOsA3Oh0DyZ8d3mv7oHdo/2FJh4OkYu0Egcj
         eGXC2NQ46PDKFQeodhb0HfWrDXlIrxAoIILE9FajF32vkjPy5Jc0y3qPUyCl+IxUaQXW
         EvC7+LDdCE7Y8T1jzWXq+ynTE3qAVag+tUKwg3UQ5fEMmYMkJDpgK9x3FL8KjiW2KKnv
         0sKdzmlpSOtUH0rPomMZVMpydExC0f9orbnLJG9/1otxeuAUduMQaYLeNuc2xLXXjnvR
         AaNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786389205; x=1786994005; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RsR8FO6QuNcekmSDhj3+ZpjW8G7HhjWQANbYEG+9QKo=;
        b=Sfhnt/52OuZ1S/1BfKHsV7s6FUD6KqHYyOBstPzhNerigr0NwYew7B6tjWdBpfMksx
         i3WbviT9tVkFdaqjrpTSyNzooNvdwC5ZBN/5VRjVM5CicWObFrM3pCFIDHv6Fxh8fU7m
         xoh5nYT4o5HjfRzo+2UgTJ1rSqO7WXlj5SJD9xnYWG6Og1GtwAw46nKP/hYUNWv+fIqH
         R5LVPXLjrFs2AVgpCiDtkCrsW0SveYCBIk5+4GxiBq0dzFsIQ3aHnrqcUVni0RolKSbf
         HFrxzWtdqF1Yj9cdSdjcqX3HmMTJhRrsG3saxwczsrSMcjTDunRtU84/tzHfkhFtUYEe
         9jXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786389205; x=1786994005;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RsR8FO6QuNcekmSDhj3+ZpjW8G7HhjWQANbYEG+9QKo=;
        b=sc3K2j1I3YA1QFi3cMTiRiKraCjspJ6eJCMLhm5o/yuXbOOTTD/qrb3t+KP9wngpsu
         SF1k9ZF8uFw8o5HDZI8F+u8Y1lGnZk2J9Q04dPlwk6hYGSfVOGc+tB4Tk+RKLZok93G7
         CZqR/RRdvq3tVB7RaT0zTIPqfxYaWm/YKsUMqEvIAzRrQz5VPCJhWvETxTght4Z+78GZ
         3D2kWyG66RCpU+ZPc/Wn+me74GdjbVrwJR6KW2mVrsm8fmuuczpuepDBc5Rck/0KR3iN
         M/5e50PtowsAo3THZxJ0fm/GMvAxzGNPBhwwWDv8rIEEIh7PWsJ+ttfLvFU1XWTyXSVI
         aBFQ==
X-Gm-Message-State: AOJu0YwkBrxkIEg2OI00jS4zvpzN9I5pZFnKI6tzz7Rc8Lr8R90Aji9I
	a/20aa0LpjdPYnFjnxOLejqQbShdiplrwN7NMIY8tp9ZFQiSMsK1NFldrLLLIBv+En7RjE9n19t
	FvsQGhLY8eJ+vd/s09/lKC5sBFqwFNPgVDMsk
X-Gm-Gg: AR+sD10ms+ijG0LHhY3HgjEHq8Ndx2bdrd8h3O39f4bJ7QCPMXqiC3yRROyJySoiP9k
	NcCFr+ZpA87OgzAf2qzNY4lYTjrDOpx4fjAPVfvn4cdA3ddDKEQITAxcrYH7CVdd3E9jRGLnNKu
	RT73ncpSxPHSSxWIEnclTHS1lloIklfh38TGshP4ZUFa5Ht9YuWW2bxtchwllJCQv5x28x9cx6j
	hqyHnD8SdzX/HmuhqDWIC/KnP3rsDcwt7+ud9HnesV6+vjawyiHQvrN9dMQEfu/Ts4Duw5JjGvp
	JSh5R9YXqEym09i0RbkVjbIHBL3pZLz2S6rXbWZvWXx25S4OZoAZPJl+TOGv8qpPqsRowHvMrDe
	vOG7u2Hj0qM5LpfW8ZDdgta/Iiuz4qC3CJxVx0jPui9lL/fu3vjzIrwV0GlTO0knW
X-Received: by 2002:a05:6a00:812:b0:84a:6540:3389 with SMTP id
 d2e1a72fcca58-84f9c8b95admr3742268b3a.10.1786389204557; Mon, 10 Aug 2026
 12:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Tue, 11 Aug 2026 00:42:47 +0530
X-Gm-Features: AUfX_mzZWqWcNq-R2ucjGZH3kQryjB1xWBf-hnebYrKc8vgrKtmsLqQ8laWQnYM
Message-ID: <CAGWgyh9OZWBz06BjWQoBNrwKZKd7VfAGk=ZbDZZ3RKSs0ks09Q@mail.gmail.com>
Subject: [GSoC Blog] Week 11 : Improve Disk Space Recovery for Partial Clones
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

My latest blog post, covering week 11, is now live:
https://siddharth.shrimali.info/#post/11

Please feel free to review my work and share your feedback.
Always open to discussions! :)

Regards,
Siddharth Shrimali
