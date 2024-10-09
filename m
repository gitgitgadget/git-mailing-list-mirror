Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B44F291E
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728479631; cv=none; b=fitEbhLh7DhjYHosiC+nxfx1V5+LoW8o2tLaClgrS+42RyaSzIZD6QokZFDkIzBTggCxehdDiyNkSgxD8eHaBYKkGhGp1vZQGdLHZgntlyVP7EO/Z9hCvvDOuCP+gfI4SjO02ldeYtyC0cMU6YwgCd/vK+LSoQ4vqL4Eok0qwus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728479631; c=relaxed/simple;
	bh=4MO6cEbwEc9/dObfqWue7buVf4VnjZ9Ox0oSp956OpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDnXildUamIVIp/nyZ3zVKnnCViIQrr7zsk85Rxa7AwZc+p0O+KHILDmwo2LnsT3G+iWCa9nUVMu+MyUd/UxBdIUzdjwt54bIUO9UQ7nnMuzkuTk/X7NrElOo5+jVvPqVfAEPll2tHDQ3OTbT/ZjeeAH+CaEZP4vGj5d3KFO65M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuHzoeoR; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuHzoeoR"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e30ee6788dso19837827b3.2
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 06:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728479628; x=1729084428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4MO6cEbwEc9/dObfqWue7buVf4VnjZ9Ox0oSp956OpI=;
        b=VuHzoeoRUJJ/7LAmaIGhj7qUr3a3RTqvXRXxUY0V0kOEQ0gRCnZME3PgqHevEnrgID
         PfExvnNrUHZYQzBS69nFSUZnagNk+J9GoC0OdZFEoSqMcDdDsgUwgx/93jVrYn2Jzm2U
         5/6nRn+Y8y+DEi36qvnWdYLSFJoIin9zOvUn/LboORlnugyofzfaPJpMt5qurDchpvwO
         AHYlS8f8KEi8JPdy8z8y4hAyDQe0gGgU24NzakOIzDSLoRLjE0KwGfi/IQ96RvMY44JJ
         pbpyIOFMNGTYZ68Lv0/kzbAD+olhmK+0L/OIgB2Gs991RfM35JRp/3L9JIwOM0u91Nz5
         FoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728479628; x=1729084428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4MO6cEbwEc9/dObfqWue7buVf4VnjZ9Ox0oSp956OpI=;
        b=ML2tteWFY6Oq5Aei8xMZxtF0/MOM1yR1sokxPoJazOlR/ZxjFzAfuxWw9HpAfnHnw7
         OyNTpYGmm8JhOljia7/Av1qvpSIKz15cxtdrmpPEMYaTxTCWhs19jSkGnFQBsoHFatt3
         oOq5C6+pTHArj/+iS37ePz1MxUi6LX6d3zSlDFluMwsfOVYIIN46s2b+gX1DSymgSjHJ
         h7j+Ja2e4yHTGcCNa9m9ks728RTqKqJKhf+GAGZex+on5+tf79aW46JlvetycUN1etWe
         +4QNiXlGx5i22FJ7Hf3FL+lOWW/QTO219yU2HkFDClo0WGuYHVfENju551y1B2accwCt
         VNMA==
X-Forwarded-Encrypted: i=1; AJvYcCVASqS2zvVzZul3wOytVdGa6XpelqLjmWZuV4wRrAvmVfZE5egmiTQJ+4DCOv8PGbowoSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ8IMaltJw51P/Z5+skymJJuK17bj7rNN4e3lFMd68WBbaq6ZC
	TnAEkQfjJru9VnYeLQlAObVPFnMwQz4nnCkmRmIO35/AKdYurO4t
X-Google-Smtp-Source: AGHT+IHEKygATb09S3H7cJALbg5RI3MxnG7eQKtzPRUlyCyoda7zBIw7SgnGCTCQ5H79+0GgjcNDGw==
X-Received: by 2002:a05:690c:300b:b0:6e2:aceb:fb47 with SMTP id 00721157ae682-6e32217e3eamr17701217b3.2.1728479628459;
        Wed, 09 Oct 2024 06:13:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:799f:a786:d66d:649f? ([2600:1700:60ba:9810:799f:a786:d66d:649f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d926d62csm18332647b3.18.2024.10.09.06.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 06:13:47 -0700 (PDT)
Message-ID: <26e589c7-7625-409c-9913-9ed4b8ef9808@gmail.com>
Date: Wed, 9 Oct 2024 09:13:47 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] builtin/gc: fix crash when running `git maintenance
 start`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Shubham Kanodia <shubham.kanodia10@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>
 <5798c31e1ef9346e7faf73f8c80b32c436937a8a.1728455715.git.ps@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <5798c31e1ef9346e7faf73f8c80b32c436937a8a.1728455715.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/24 3:08 AM, Patrick Steinhardt wrote:

> There's a single fix compared to v1, where Stolee mentioned that the
> added test fails on both Windows and macOS because the "crontab"
> scheduler isn't available there. I've adapted the test to instead use
> the "systemd" scheduler, which _is_ available on all platforms when the
> systemctl(1) binary can be found.

I do appreciate that you are making the test work on all platforms
instead of my workaround to avoid the test on mac and Windows.

I was initially confused by your description saying that systemctl is
available on these platforms, because it isn't for my machines. But
a way to rephrase what you mean is "Git has compile-time expectations
that crontab doesn't exist for macOS and Windows, but Git checks for
'systemctl' on the PATH regardless of compiled platform."

Thus, placing a systemctl script works for these platforms even when
they don't have systemctl available normally.

I'm happy with this version.

Thanks,
-Stolee

