Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCB034B678
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144832; cv=none; b=eZ3GgwYidkgH1Gz08NsLmpb1TlX7pvddfdmCC/q/Vnb9DKC+JV4Mtuk7uXOrLBP1GxESpBgXK5qF5lMI/D1laeuM9f96KMp1vjE7I8KZLtNrDKTBVAwJAuOOD3hvGz1gxFsx1HcXPmUtx9sOONU+bNmPFz6cjhuVjyrsvSOrF3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144832; c=relaxed/simple;
	bh=5Ze4MKBYWSLa4sMiwIlAuXsvcjtNNfPEllLcHtzvjuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oF/H2cxaubspDOiWXTBTEonEvAUqEw6mn7ywmkQF2ZfpAVo0seBeMiZO9QmwY8Cqw1uXCf2G5Qfx/5gIabxapzJ5nzv0WuVi//WLv2C+Go5eYm/MDM9gm1cVbJmczbuzPI2bOK3UK5Xh+KQDzCaO0Hog+YnG+nJUrK5fFHjxi4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qc3Ji48V; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qc3Ji48V"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-892d1443e48so929418885a.0
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761144829; x=1761749629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xwd3v0lZxqrkDuXmK++4QktD0lvIQEakJJx1hRgxeeE=;
        b=Qc3Ji48VJgtzjvtWvox45J3seKXJ9BRx/2k05wRXMY9ctD6oAcu8oNk65VK8YaLBaH
         7M+ae00nFMrHst/PfwIshDaisATmOzIvMV9P3G44f6QzrGDOvblrMIO1+0wQ8orsdPv0
         eOakkc3x3APk2o5i32ShAHCR1c9SY9y8Dhial7sRD/4VhKrSyKXBSRUrt/w0do+wP6qB
         Lvg/ZgFFoBXvEE3d52lhYAjqEEGKj0J/eyWhtAKxr+t05WvcjWjO3Y5CMWD4HFlCW9DO
         MHeSVnm1tfy7MpIk6ZJTxoAnrwyqS1j0Ij3DfLTvbDBFNIzf+s2/u6b+msiLrgA4XdoP
         y8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761144829; x=1761749629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xwd3v0lZxqrkDuXmK++4QktD0lvIQEakJJx1hRgxeeE=;
        b=WS71qRrMcY5mMYUhEFxveWEQXyrnK5osrFLMEImASMk8jwQw8sohfsjJuLyJeczuoD
         xuN3w52coxdlj5xWxV5Y5sbCo8xPlspd3Sdfr4BMHu7FBzS0qV4pvTjSP0E0w/IYJNXC
         +RBRRs5bpLfuS24YoT30wF1GZxIFyTAS46oU+5TKJLnhKui+hG8J9Skb7MTUZyii7nqo
         9wl39Aj05SBb+r5Q/cl3u+wECco4Mvoa+gOLrdAVZRmMaGD/SzfcvC7KFkDDdaOtDOtU
         jRPs3aKezl3Ke4gz+um3cttCZrY3n6yELXYjYWMRgfzE6qhXpmTn+zjVrTEXH/6Kj9N3
         +0Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWCjU61DktItPKe/j1EE2qW6L1atCzzCYEAZ6qeXUmw2D5zvoq4TM89ZR5AVsPqSWnDWXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEvEGFDF46OuD76ZXByt47tOpYE6hxRvpWwZS59aTRM0tiajZ
	90bw3r+Sj+dvnDXtxVptagNwfGOE1RFQ5vNQwIxI3/MAY4j+qLJQNOZ7
X-Gm-Gg: ASbGncvBrJikZtrLgSo48sw6vP4Tt6Le3jXJBqspm6aaCr+wdcDEqTWpOszhhXLFFgv
	UBvOj+h6J2LQDt+O1b7LrWffsM8L6HMJwia4IcP2hXmdi3z/ajn/RJ3n28nZjh/bkAwIgXkk3Qx
	4BXuLnlTELj8Zfs0yWtj4Z/T4zavPsvndJQl2stTM4r2svjKe5kF1m8XdJVh54AvhJLGeagcfR/
	aNGYbA2EVcz8ammA8SKUvg70z9RW3d2Ibdre4eyk3hAqGlOQpT8VdURlyrO6x+s233kNuIy5tz5
	gVZ/u/ibJqlgtH/W7roeIKRdCBv0Wk8Q/+ekCtmNXdN/S0Tlx8M+fSUwTk/G6p88Hhe8KIr2sp/
	+cBhHQw4cYSLIvdkO0b/415KHcPuJ6aibqX8w2o0zunWz3nWjgpN9UAST8swJmcjCtWB+AzUJSn
	nblqV7t3kyCXrzW8Dy6Q5SoOCprWClh0n0Ren0RoaclcIwqg==
X-Google-Smtp-Source: AGHT+IFfcLoQ62YAT0RV2hqE5QxOq7LxJ7NvSZkwQn76MW+gdwZWCC30JpnwQ+2yM4VixPt4DVAqJg==
X-Received: by 2002:a05:620a:1984:b0:84f:f3bb:e464 with SMTP id af79cd13be357-8906fd1953cmr2792293885a.50.1761144828964;
        Wed, 22 Oct 2025 07:53:48 -0700 (PDT)
Received: from [192.168.1.109] ([136.56.76.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89a5a894503sm151691685a.24.2025.10.22.07.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 07:53:48 -0700 (PDT)
Message-ID: <dfb978ab-993f-49c3-ba55-d12d47dc659f@gmail.com>
Date: Wed, 22 Oct 2025 10:53:47 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] commit-graph: add new config for changed-paths &
 recommend it in scalar
To: Emily Yang via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, me@ttaylorr.com, ps@pks.im, newren@gmail.com,
 Emily Yang <emilyyang.git@gmail.com>
References: <pull.1983.git.1760043710502.gitgitgadget@gmail.com>
 <pull.1983.v2.git.1760734739642.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1983.v2.git.1760734739642.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/2025 4:58 PM, Emily Yang via GitGitGadget wrote:
> From: Emily Yang <emilyyang.git@gmail.com>

>     What's included in v2:
>     
>     I received feedback about the confusion around the config explanation,
>     so in v2 I added more clarification in the doc and commit message,
>     hopefully it helps!
>     
>     Thanks, Emily

Thanks for these updates. I'm happy with the new version.

Thanks,
-Stolee
