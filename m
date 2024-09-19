Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4568319AD8D
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726750598; cv=none; b=VpWR1sZODROqvp5rEV0L3lIH8whmYpS8AfvG7GhEYYRqU6AVK6C9VzdUKH1RwrlEsRJVsDeMX1VJYUFu3IImnL/pbih9uuDZqeRLZNR5l44IL7uesj1UJ0Foz85j5R9O8No1odISD4vyYRR621JIQo2I20tVf0y1qASIuQvsNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726750598; c=relaxed/simple;
	bh=7vhhK0JW8Ssi6h3QV5RG6XX4ssPyP7r0gy1h7ifnk/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R2CEhSYxlzEkjj0P3zkAeyEYPhqoI/D+UwApZYmkFTsdBl7ez306VuTXTLNnlHYHBHYX97ZZx4x1LU0IC5qCydNcdP+73yeUNXkpwF0LgC7cqUQAtJbAPoz8IyAHR0g1EVRhgqRr12GAwvfulUyPjR63hi50pL2LO19Nh97uprc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b79+l1em; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b79+l1em"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6d74ff7216eso6108297b3.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 05:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726750596; x=1727355396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JYgcoIbFZ4Eq71UeJ4vjJiepg2MNPY+LdTU/PklBb5I=;
        b=b79+l1emJaf1HfEsDXRiPQktr8Nf17LiCJHf+mGQ08V6gUEEoIVncM3g+AfkfQw1Ay
         q9okMM+zNFs9TMTxC9d7/cXvtOXE1n6OL46NilRFWd6JXAG17XAtfN3jBcIIIcMNPfb7
         T0qfFuUknUp0i4VzhOKK3Lo9g98bDxHvkseAUIS0Z0h6hSlbFn0sImEFv4jVGgFzXqI8
         YmBV/MvkclA8HbtSIkKQxYEZWVxBNVesMWNDncWzPlnuc91kx0aFaLOdYIDBJ9fLwIAl
         i66eCqxRrkQk4gr11YKMGJ8Gn1xKkKcw4NhNv+8wu/VU+2jGbMkS3o3zvhSZDxw1DNat
         ZaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726750596; x=1727355396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYgcoIbFZ4Eq71UeJ4vjJiepg2MNPY+LdTU/PklBb5I=;
        b=BZmAoR+82eWTPi9AsIudgjpzavmtzye9CppHRCESRm5HQ14CKGZrowfbrOTnTNSsoz
         H4eGYv7pqmgUysVaZ86hD6/AO+r7hrU0ZK3SVsvjsoGOSbbv5oWjHHoHuvGMrIOcy2US
         /66JR2vOTAKOxPbjpBweVGbjfPOB3v4fLZyVuOQMpSf/nPYYOCClwsUzIL72OLsGHZOj
         38/sbXD27BoTSyeB+Wk2qCCpsWAFhxZiJiPAAzc+LPkUQTw/8yxeP+3QpwORwJwpK2X1
         uW/1cojmnVGi1dXO9SklW68hrzGngMm92OQRRBUhsKQUh+y0WH5enXei21psFdes9eAI
         Ywuw==
X-Forwarded-Encrypted: i=1; AJvYcCUbFaabC394cw846DM/7vDRtlXaUvY44d1ckcQn312R+dLy16iKOWKs4V4Cg41z2iZdOJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw19ofbrXZHjwhwiGn2EEZxtBni9l+MXxF4bzo5cv8q1bxliCjf
	SSt0cstS8bFkbwhLT6g5lNIcsEqIydjySdMfo4oWmaNtjt/nuzVklqOgVg==
X-Google-Smtp-Source: AGHT+IGToiP1gPlPOW398QegQl5RA3ob6mKQhPYhZfQpZTeMiY/xqXDfCpXBjzj12U1VTPiasNL53w==
X-Received: by 2002:a05:690c:4609:b0:6dd:fb47:2184 with SMTP id 00721157ae682-6ddfb472546mr39904627b3.13.1726750596158;
        Thu, 19 Sep 2024 05:56:36 -0700 (PDT)
Received: from [10.138.36.87] (syn-076-182-087-058.res.spectrum.com. [76.182.87.58])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6dbe2ecfae7sm21503427b3.99.2024.09.19.05.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 05:56:35 -0700 (PDT)
Message-ID: <cce1d054-911e-407e-bc26-1c0bac4dd8e4@gmail.com>
Date: Thu, 19 Sep 2024 08:56:33 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: The maintenance tasks will never run if maintenance.lock is
 accidentally not deleted
To: =?UTF-8?B?5YiY6ZKf5Y2a?= <liuzhongbo.gg@gmail.com>, git@vger.kernel.org
References: <CAN477tHJnVnOKfUsG5G9QAVdzYvmUuC8A8Vxt8mtHB23fd=hAQ@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAN477tHJnVnOKfUsG5G9QAVdzYvmUuC8A8Vxt8mtHB23fd=hAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/19/24 8:40 AM, 刘钟博 wrote:
> In my work, I found that the prefetch task of maintenance often
> failed, causing the fetch command to take a long time to execute in
> monorepo.
> 
> After investigation, it was found that the maintenance.lock file was
> not deleted correctly for various reasons, resulting in the inability
> to trigger subsequent maintenance tasks.

This is unfortunately a common occurrence. It seems to be related to
the Git background processes being killed in such a way that does not
allow the standard lock cleanup mechanism to kick in.

At least, I haven't been able to find a reason why Git would be
failing with something like a segfault which would also cause leftover
.lock files.

> So is it recommended to add some mechanism to ensure that
> maintenance.lock can be correctly restored when it is not deleted? For
> example, add pid information to maintenance.lock, or add a lock
> timeout mechanism.

I can speak from experience of previously having a lock timeout
that this could cause problems where maintenance processes start
running on the same repo concurrently. The reason for this in the
past was due to being blocked on credential manager prompts.

I was vaguely remembering fixing that issue with credential prompts,
but then realized the change was only made to microsoft/git [1]. That
same change reverted the removal of "stale" .lock files.

I should put this together for an upstream patch series, finally.

[1] https://github.com/microsoft/git/pull/598

> I'm not sure if I missed any information, but if this is feasible, I
> would be happy to contribute such a patch.
I will CC you on my submission for the credential changes, as a way
to help introduce you to the code in this area.

Thanks,
-Stolee

