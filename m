Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B5F3FB1B
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748956565; cv=none; b=rsTOPQyHLEA5LCKyUontTmRGwkJXwb8+xFDVYip9F8N+4y0e88tIj8vUZtxkpuMdLoYMIjACRcG8u3jLymRGZL2AXBWiJ9DpBG0Nk/Rrt+Qexb+zZvQqh0r/iYp1lhYHTrcHo4OANAlegxfapbKqT+4LTj/4p0wTopwNM8eildE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748956565; c=relaxed/simple;
	bh=d2H/R+/B0tGCRv5zZzxWZc58JTB1QQtYJWXR0JZqeGs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XzFbuZikLvfgTPbZuydQaY6ctaDtXqa7ptayY9wyqEmJpNuftY3dK7VfZtObyD1JzaXXging6T+wd3+NOZZS4ObaCJvFF2Rsic0XTSo1epWBRbe/84VjYbz6VitKl2qsTcSZO47txQFp9trEVVfGsGB9X7oBj3Tcyp1H0D0cszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TFgxbC2L; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TFgxbC2L"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a43972dcd7so66366031cf.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748956562; x=1749561362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id
         :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geJVDvagmMktLYaqC8+ZSA0KTMdYnYWPIa4KQpiY9PQ=;
        b=TFgxbC2LHaPTicEPcPz80ZDnwuO4cmem8H871qPDiFdyRK0MhRo5lUs9frZd/IjS9X
         3bJO9zL7MIxPj1Ytu1aDAWilwD8JL/Cuq6DHgxzuI+Su7NgfzKUKDc3xIOB8sgxgRNw+
         72w+5ZEwpE/P1SG9LnrlA0qY8pLkQoCltVAB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748956562; x=1749561362;
        h=content-transfer-encoding:mime-version:references:message-id
         :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geJVDvagmMktLYaqC8+ZSA0KTMdYnYWPIa4KQpiY9PQ=;
        b=igfD2X1LxLXrZktCLFsAg3HSCs5A7TBsk4KlcKkuB93yRTC/bLRYX+woqID/tFB8kd
         DRciRFlL1fLs48Iel3rm/X02UTC3XjZcPPk8fl+sOEK/gSqkWtO1/tKjwhywLc+/JHxl
         ARAU3Hfb0/Wj+OcRESGIKKCz8bw6BGCjfcDpK85fR+urYZbdx5zXJ2nbZXVnewAYMyQ4
         CHdoh6N/RZQANNfksX3eT1LCzfFJuH2PbueRrct2xTO+MPv8DeXz4J1vLLZ+WPc+3WVf
         vNBafveomSs5052eqlscCAtlPENDimOFdR7oQoirVDB9MTNXzkiuh9LNEx+Vrau1mLP2
         V9sg==
X-Forwarded-Encrypted: i=1; AJvYcCXrT/f1+3kLMq0BPAyj3eCyIf/ML+XEguEpzAm9CX8ubHRtzPqHbb8qLmqAruN+c8hEZuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzVU+14lowkumOsZkpeSshhkyPFVws3fxEqE+GANiV3DuaR3S3
	2fb3/9nny4Jj7SK0DhDL3yYxEcAhGrIz5nXVkwtd6jviIPRqOfKcF1nYlX1LyQx3VQ==
X-Gm-Gg: ASbGncupE1vjG1kBY8Yo4ybmNdZDyYQITZuFZ3YDusivnZCka/7xJrZQjRL9iyAcFZl
	UgrEXFU/NnnIlDx9Tqg4V5oI7an0RHpsoAF/U75gbRDZHzAau0CDyqsXO1NHWeCCjuLZnrdgax0
	98lYGW58tdPqMwQtbvpCJsD10xCpckGMhzfiPsAwcBSEQevU3l/g7KnarqeLh6mnbx0qnwpNnC1
	iLb9g6xgBbdhmXeR+x3srUuvh/uVZ2mSEJ4UaspaO6IRfAdahrSE66De+WxsPz/dmAz5kado2ty
	lN5K0T/yOemo2IHt1Ovj/Jn18GwgE8rsWZGGImiBQ4r9aIHps/9NOOS+xwlwKJSnIkSzWFrIFpa
	0EaEGkL5WZlQxRi3LWp/O6ekmlYH9fgbnqvqodXY=
X-Google-Smtp-Source: AGHT+IGjXZny47fnOpQi34ZnH3baNRGaSD8R5tpaIcCSTnPMrg6wy1aI/MgAe9WXP2KpXvyneAoeRQ==
X-Received: by 2002:a0c:f096:0:10b0:6fa:d95d:d0b0 with SMTP id 6a1803df08f44-6fad95dd17amr117905516d6.29.1748956562125;
        Tue, 03 Jun 2025 06:16:02 -0700 (PDT)
Received: from [2600:4040:9ce0:6400:a8dd:c57f:7e21:e7b2] ([2600:4040:9ce0:6400:a8dd:c57f:7e21:e7b2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d5b04asm80055636d6.51.2025.06.03.06.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:16:01 -0700 (PDT)
Date: Tue, 3 Jun 2025 09:15:54 -0400 (EDT)
From: Mark Mentovai <mark@chromium.org>
To: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
cc: Junio C Hamano <gitster@pobox.com>, Git Development <git@vger.kernel.org>, 
    Eric Sunshine <sunshine@sunshineco.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] t: run tests from a normalized working directory
In-Reply-To: <20250603050256.GA9449@tb-raspi4>
Message-ID: <08b9b990-9ddc-740e-99ab-82d09fb30ef3@chromium.org>
References: <20250523193722.68344-1-mark@chromium.org> <20250528201737.55268-1-mark@chromium.org> <20250528230804.GA16856@tb-raspi4> <xmqqfrgmhep3.fsf@gitster.g> <20250531054618.GA30443@tb-raspi4> <xmqqcybnxvr2.fsf@gitster.g> <f0d4c85a-b833-c52d-b54f-77ab81f22451@chromium.org>
 <xmqqy0u9subw.fsf@gitster.g> <20250603050256.GA9449@tb-raspi4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT

Torsten Bögershausen wrote:
> On Mon, Jun 02, 2025 at 02:32:35PM -0700, Junio C Hamano wrote:
>> Mark Mentovai <mark@chromium.org> writes:
>>
>>> `realpath` is a library interface that transforms paths to those
>>> having the semantics at issue, but it's somewhat obscure, and easily
>>> confused with "real path" whose meaning would be entirely
>>> ambiguous. realpath(3) documentation from POSIX[4] explains the
>>> semantics fully; glibc[5], and Linux man-pages[6] provide full
>>> explanation while also using the term "canonicalize".
>>>
>>> "Canonicalize" alone is too generic, because there are several axes of
>>
>> Yes.  You need to specify what you are canonicalizing to, and once
>> you are going to do so, there is no need for that heavy verb, i.e.
>> you do not need to say "canonicalize it to realpath"---you say "turn
>> it into realpath" and you convey what you want to say just fine.
>>
>>> All of this illustrates the difficulty in choosing a single term to
>>> unambiguously convey the meaning. I chose to write a commit message
>>> that favored technical precision, even if it meant tending toward what
>>> Junio called "the more verbose and repetitive side". I believed that
>>> to be necessary to fully explain the background, the problem, and the
>>> solution.
>>
>> Yup, that is why I said I thought your original was clear enough.
>>
>> I am tempted to say that we take what we have from you and merge it
>> down.
>>
>
> Thanks for the long explanations.
> I still stumble across the headline:
> t: run tests from a normalized working directory
>
> Re-reading the help for realpath() and pwd, would this makes sense:
> t: run tests from an absolute pathname

No. As I wrote earlier:

> An "absolute" path is well-defined and commonly understood to have a
> singular meaning. These paths are relative to the root directory, and are 
> identified by a leading separator (/). POSIX specifies this at XBD.3.2[1] 
> and XBD.4.16[2].
>
> This change is not concerned with absolute paths. All of the paths in
> question are absolute, both before and after this change.
[...]
> [1] https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/V1_chap03.html#tag_03_02
> [2] https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/V1_chap04.html#tag_04_16

Making a path absolute is a different transformation than what is at issue 
here. You may have been misled by the fact that pwd -P and realpath both 
make paths absolute in addition to performing symbolic link resolution. 
The latter is what's operative here.

As I've explained, the paths in question are already absolute in git's 
test suite today, even without the proposed change. It's not correct to 
summarize the change as making paths absolute, when that's neither 
changing nor the crux of the problem.
