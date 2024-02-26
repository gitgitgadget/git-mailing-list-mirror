Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84091129A60
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961539; cv=none; b=WdO9y9OLAyKLpVPZ0JG6FQk9IeiLFakB/aBxTd01oLEt3j+Tk+GNR0DXBTnHjvMVscP0z+2ONzzvBRJPFygzv8h7uYJSoUHoO4e9LaMLeWvBZzqGD/qOtkFAg0FDRs8DdaWnIXyvX09i5t4vlImXeRt61l31i/QhN35pe06SQj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961539; c=relaxed/simple;
	bh=LqVuJfUWpyJOZ8KRfprJJGw0KeNjUHNkWV0HfiI8OH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SclPYdYwqCx6ww589tlQFK8/JF08uojAp8/ml/55WaFZLbhR5nY5xsxwJO8XrmCYg6brNYEXkZVDlHrq5Ral8R9aPp2Qql0IEM5MxGLYoVT399kTfyuSvlWbe/Y4kDriFN7Crozs68LklFW4Ti8L+oO0bxHyVf2hpPIiQcjsvw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQtgPdRK; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQtgPdRK"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d21a68dd3bso43199611fa.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 07:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708961536; x=1709566336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zB6k6dTukt4jGZFM16ebW88Pa9Ls3M7KkQ/l9Ox3Mbk=;
        b=nQtgPdRK5gYXqoPNySnUkeZ5+s0XQ1/XuQcz1g1VUj+JTjPfcUwfqmgUX+c1jnvJHh
         xbhdsW/P+eyR2uX9RxC3LbPepZ1GArQ1gKMhOhdfJBWSeme9ojluLxwKQf9UXoLk1Z3e
         l3/Wy02lQvhYqPzDk/MoZgF/RC4tiZ4y4gTt6xhKVk3NnHJA3vK9KN0X2CUi8Qw9vgUd
         1aVzbNBlLksUZLGgJQHJU7j0r9SMDA9pxK8AGDwzoOaWKOT9Tsf9p8s3Vg/qKOBkYwqL
         7p1PU65cF1jzbu5hXcvqs/Hhz//8GFDmxr0xAnUsKZM/o5/ArnXFnk87/d7f0ObsB2Xd
         DO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961536; x=1709566336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zB6k6dTukt4jGZFM16ebW88Pa9Ls3M7KkQ/l9Ox3Mbk=;
        b=EyGdhjwCMlghRrmdmkwl7vdOBnFwka3hna6mXLBYpoUpFFN6DFZJU4+eC5OQ5totGP
         I6KR/VBVgtkIYJspg3YSGC81lI9QWa6dog/p31rGOYcfBX15SxL/uYlrfX8nB6eOYSPS
         yOZS8XxFhJvAGnmelAEDlTUnCIZbHIM1XraNNedMIt5z0BO+RG/43s86yUADKrGG+mvc
         UHE3YmpSClF4jmks8FsF5peBz3/zcFvbEucby2S/4D2VR3zJvqL0dvhLhGyj3G60SXjN
         4nN2NZXf9fNHUv3gzlKq10pR6GG8KQ/LDOsmOlEojHB/ZpE9N3baquuR+60eWY9dq8CY
         o3Lg==
X-Gm-Message-State: AOJu0YwqA4aHecNeHzzyyrPApVO13GNhVV8L5P+K5kY4XgFwuvVLeKZy
	FWVypPN42iI3pdwR22N+UzTmAuMeB3E2YVa8xTjMVSr0DgTP70vI
X-Google-Smtp-Source: AGHT+IHdVLjSrrTLuO4wol/HC0I+Hri4rX/jcF9LW+bA8XJNMeitlO/lrFj791C8i0jZ10C2jFeaLg==
X-Received: by 2002:a05:651c:221a:b0:2d2:86d3:b8dd with SMTP id y26-20020a05651c221a00b002d286d3b8ddmr3748636ljq.34.1708961535262;
        Mon, 26 Feb 2024 07:32:15 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:4b27:339f:196f:f7f9? ([2a0a:ef40:69d:3501:4b27:339f:196f:f7f9])
        by smtp.gmail.com with ESMTPSA id h19-20020adfa4d3000000b0033cf2063052sm8674397wrb.111.2024.02.26.07.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 07:32:15 -0800 (PST)
Message-ID: <5e807c1c-20a0-407b-9fc2-acd38521ba45@gmail.com>
Date: Mon, 26 Feb 2024 15:32:14 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] 2.44.0 t7704.9 Fails on NonStop ia64
Content-Language: en-US
To: rsbecker@nexbridge.com, =?UTF-8?Q?=27Torsten_B=C3=B6gershausen=27?=
 <tboegi@web.de>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <01bd01da681a$b8d70a70$2a851f50$@nexbridge.com>
 <01be01da681e$0c349090$249db1b0$@nexbridge.com>
 <20240225191954.GA28646@tb-raspi4>
 <01ca01da682a$5f6a7b60$1e3f7220$@nexbridge.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <01ca01da682a$5f6a7b60$1e3f7220$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Randal

[cc'ing Patrick for the reftable writer]

On 25/02/2024 20:36, rsbecker@nexbridge.com wrote:
> On Sunday, February 25, 2024 2:20 PM, Torsten Bögershausen wrote:
>> On Sun, Feb 25, 2024 at 02:08:35PM -0500, rsbecker@nexbridge.com wrote:
>>> On Sunday, February 25, 2024 1:45 PM, I wrote:
>>>> To: git@vger.kernel.org
>> But I think that this should be used:
>> write_in_full()
> 
> My mailer autocorrected, yes, xwrite. write_in_full() would be safe,
> although a bit redundant since xwrite() does similar things and is used by
> write_in_full().

Note that unlike write_in_full(), xwrite() does not guarantee to write 
the whole buffer passed to it. In general unless a caller is writing a 
single byte or writing less than PIPE_BUF bytes to a pipe it should use 
write_in_full().

> The question is which call is bad? The cruft stuff is
> relatively new and I don't know the code.
> 
>>> reftable/writer.c:              int n = w->write(w->write_arg, zeroed,
>>> w->pending_padding);
>>> reftable/writer.c:      n = w->write(w->write_arg, data, len);

Neither of these appear to check for short writes and 
reftable_fd_write() is a thin wrapper around write(). Maybe 
reftable_fd_write() should be using write_in_full()?

>>> run-command.c:                  len = write(io->fd, io->u.out.buf,

This call to write() looks correct as it is in the io pump loop.

>>> t/helper/test-path-utils.c:                     if (write(1, buffer,
> count)
>>> < 0) >>> t/helper/test-windows-named-pipe.c:             write(1, buf, nbr);
>>> t/helper/test-windows-named-pipe.c:             write(1, buf, nbr);

In principle these all look like they are prone to short writes.

>>> trace2/tr2_dst.c:       bytes = write(fd, buf_line->buf, buf_line->len);

This caller explicitly says it prefers short writes over retrying

Best Wishes

Phillip
