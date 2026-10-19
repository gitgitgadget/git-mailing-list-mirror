Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF5348382F
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 10:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792406119; cv=none; b=NU7KjuGUJLLEMNiC/Meqw++rHuvTuGXHE8McU5vbdaY/IflSgj5L2hSOlNs60chvqsE+MVg+vzxNy+Yot21jG+pqjf3PmVOW5BDV3QZUXtFem8khe8YN165fuhFqYzfyTpKRo9SKr6OgdGSVJVKuEhqnma5ZWzMcZKXNJ6fnEKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792406119; c=relaxed/simple;
	bh=rHrEfCPxZOjbosHVes6X5BNaxVAFCDU0m6MubZtq244=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dGe0s94kC++6DxIW7cN8sGzWucApAhI0tVAW/CFo3/Ab2BlgRGhGPmvqapwesExhtiI/3Ed67YUDL9/IhqeKBkRwZh+7+u9lH9ZN8SnfAy4EaEHHEqTJKA+ZYNdeWRbh8XnxybbXEx73YQFt8k5iGHZHxFsvbyw/0vP5YLrH5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSxLTigM; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSxLTigM"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be41a7aba4so117093e87.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 03:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792406116; x=1793010916; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fk3t5vbOe1v6yDCFQFQ1Kv4vdHOYcy3lx5FErMc9SBs=;
        b=NSxLTigMqB8tFMbI3srQH3MPo3RRtSFAi/biHrKBpc7aamx9OIWOveZKSlOhINCPqS
         EQt87SPF0U0GeliM+hzH4JejaqVOMQk4jEt5FIjsmjuL+MG40uSx2rRxwZta8j6B51cy
         2AT0W9OjdtFc16ADPgEDktkLa95EV+2x0M1h24IZGvJ0pG1k+V2tC3T4FecuwUBkFBP6
         T2q4qfdhYAM2SGsZcLEy/uuZWLWqh1Q70UyJIwdIsity/n8lhpUIpDB8IP9n3y/79ive
         1vQQaoA9KuJ5riSzBpB++6wq0W664SveD7ySTjVPJzGuKkVzHQ8sBkNY/ClHJU48jKrz
         IhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792406116; x=1793010916;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fk3t5vbOe1v6yDCFQFQ1Kv4vdHOYcy3lx5FErMc9SBs=;
        b=fg8/fzQSqudrJJe3D0nUfEhDveP1Oz4YPPPn/BUNKpayi/mCR3SjhlOyVRCGKEDa7n
         W5txNKfQIsdoDDTKikM5bVb30w2SjelAe2W6y3yvRHQ6+nKBcPWRjaLZERvIe073JJhg
         HVgAFV2pAVqVOjNcuId0Jy4PG31PZtVKbMyQdDtx2dgkVBZplhQXbOP+71VIuE13exgC
         m+AX1/EGVEAH2ZJHGGWIbqnQbPiyn1XN6uRGQDpQUJvLLam+N1xzjk8AzZn89Ldr7zjv
         JtonixuBa6SQU2r0PTZbK1adaGWmFsZo+uPrPWgQYRaP1cBeyZok8mjPcyO6oIg1bdNr
         QSeQ==
X-Gm-Message-State: AFq9FYKULsFQqVORk9XPSxwWn+WYmfjeb4NC/FSrXuE8U7A9fOBac8aL
	gdhz/1nH5nuqp5MwNK1b4nCP4Ej6h2zgFgc0cNCaZtlicDlQzOtLkgDv
X-Gm-Gg: AYBFou3NWHYgoeo/iEq14h7mZMj00GR3nDG4yNbJtCZt+WC1LoOUwB63dt5NKBAoWnn
	qTd2Mo/a9dDnFJV1A69tnJBQ5+A6yXqWRNeAlHTkRuALhQsm/GfLtkoxv4Y1Xp7VC24XTI59f2d
	S24gZLkvFIQYZ15deKr7Ah8FxdGGr42TlEFywbQyq2rFc7R67hMRJEpXgXYhsMKIdV0+suKk25E
	VSn7i33JyNuqOSvbBQrpeGdxAG4B8NWZxAySpHXEdXrGmo5whjSA0VxpU5gMHHLTYDZLkHzRYik
	mTTerbw7yRVdfpGU4IpVesoMXhgHiUlCbxGoSfkc9EFVoEfht8n5Xjnsi4F8otBjgc/opPTRQVk
	NYWqZ0oRG32ypOs8gcC1gAE20JoEwnnDkp7tyFxivHFABDOIaFQwMoMb4fVnRvLt7+itTuxD8c0
	3Esch1z42wNSRV+SGFMxGqMQAVbJ85VnImB9992iakIQR2ajKT08/tAkhQn00jniQ9/H1RdWRrG
	z81R1mXowV/dbsks6k/Ml94PW+fV9DBO++EQ/5ebnyhgyc1jQmqaA==
X-Received: by 2002:ac2:46d9:0:b0:5be:50c0:9ce6 with SMTP id 2adb3069b0e04-5be50c09ebcmr1573190e87.1.1792406115790;
        Mon, 19 Oct 2026 03:35:15 -0700 (PDT)
Received: from Iris-HRQ6HW3 (78-71-217-218-no600.tbcn.telia.com. [78.71.217.218])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a533900sm1956292e87.50.2026.10.19.03.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:35:15 -0700 (PDT)
Date: Mon, 19 Oct 2026 12:35:14 +0200 (CEST)
From: Olof Fairbrook <olof.fairbrook@gmail.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
cc: git@vger.kernel.org
Subject: Re: [PATCH] bundle: do not free uninitialized memory on bad
 arguments
In-Reply-To: <CAHwyqnWxr3ZhPpM0WPCnJh-SHdGDZNE0ZJwA1jHhd+6-f0aEcw@mail.gmail.com>
Message-ID: <947bafea-8f2b-9865-0dcf-c5de1c7853f9@gmail.com>
References: <20261018142130.2701449-1-olof.fairbrook@gmail.com> <CAHwyqnWxr3ZhPpM0WPCnJh-SHdGDZNE0ZJwA1jHhd+6-f0aEcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Mon, 19 Oct 2026, Harald Nordgren wrote:

>> -       struct rev_info revs, revs_copy;
>> +       struct rev_info revs, revs_copy = { 0 };
>
> I'm not familiar with this code, but the fix seems simple enough and
> has a test. Looks good.
>
>
> Harald
>

Thanks for the review!
Olof
