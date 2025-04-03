Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8092E252906
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743703388; cv=none; b=D3GUZgT7yT2hVgzCPZo70DQ7NCvDPnoO6P0i4Nw+OvEnHfP3XZzbxfE8nHMCmum0WH76sfXCzVh2ubWDbBbwbIFXWm8cC3LalbfJlU8amRNioukfdDS5vgp6Jxc4SS3EKbbBeiUduZqZJl+I+N6TfFXyGzMyQ4LEuDXaqVcXZuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743703388; c=relaxed/simple;
	bh=mMONNn38MZpb+YPP1hDgbZhQMIcNZNBt9xYvvv0Kt+U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MIXoh4sbE+zdRnVpcqtIQ1TxBtfiMGTCdTWVxyRz6wPlRUe/NLVbiaGDzZ1uLjyryPZCe3NSjNscn/bOnuliuNWTjaRWxUQS/2+yciMlJeeyNr3Odina1IYTNuaOxy3IsjULfVfp1nvBvtt/QA1PkP+FTlwEKybGsKQIMLa6wW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8HeKWoZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8HeKWoZ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223f4c06e9fso11859755ad.1
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 11:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743703385; x=1744308185; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMONNn38MZpb+YPP1hDgbZhQMIcNZNBt9xYvvv0Kt+U=;
        b=K8HeKWoZ2i+j/sz5zMIoPh6cMBJwDiGbPdf9R/s9XWpMpBX8PoUkb5bM6PR5EDH9am
         6IC7r5B/Sr1RV7WYFJD3QEBpXlCkJyFqTU3tkCggAQy5PSu69iDSCIcNL/cBu7IBQLuZ
         5V/TRgmrN2dBr92oQZntHXThwAb1MQWNJrW6FHDDwvhKkjCZfv86j4BaiePu1pZ4q7tS
         YMK/OJKHiEXD29bZxoJgYq70K4+XoB6G8GK02vn5SF9D0BIP9iga61GDnrdlYVXg/bpC
         j2Rkx4xRC784wnqHAhMZAs+lonTXH/Wpq+8rSBYXXS8IS0wEOZx/sYB6oJysqFbiAhAQ
         MGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743703385; x=1744308185;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMONNn38MZpb+YPP1hDgbZhQMIcNZNBt9xYvvv0Kt+U=;
        b=X3+N2ajT5r89sWt7Avz/NOlXLeXDkfAe5Ej78Nb3eFY0hQzuF2Om3H+ACmMW+kdTOl
         1mlrURm6XpFc+D+pOui7ne7rzlbM0vDmNDJWXIXtwldk5IO2lGtZJ4JB2sr3nb7NmEI8
         jJ8W+5E3U6sbXa9IXZiZ+sIHKh18SZ9zEn7TKI71YcCLMcjBWpJ7CtF3RUFUrcwmD8sg
         jiGT3KUE10A9j1C/bMAGtdJNPvlgZzUwTxNsg7sjM/IhNo97LlrZNrxQe5HPF00a5PRV
         GBKFOyFktlwS/e0iNek/taa1F+wa+0Jox23i7ICZ/jpS0BtwkRHsD+2EC+4Ry4r+JfA9
         gy/Q==
X-Gm-Message-State: AOJu0YyNuV1vCW7DaRMv5KrrsDb7t8kiBnfo2r3ISN/JWV4joWLu/IuI
	JZI8RMf6TruXhdjX6c3c3zD48VQzuXJT6pqmvTVi85ZFuGKnWDyo
X-Gm-Gg: ASbGncswrBW8ew/s64B1nYugFLaa6YeFCtH0bHgwkPwzNJkgJotb7VKj0NnDpI3q6yR
	JjzHK11OkqGIVt6g++40nGymtli/7qEyssmtvui8mfMWf9b6jvaF4De6qVq3NveFV9iUDhMnyO+
	DHGIcvu0LK4cTejtMZEXliN+CBBZrbV7hxzKv8xLXQ+SZkli9NyfoXWFty/uIBBVaAECPbojNLf
	NnUicKCcEdE1pgZ8U5QAOC/1bGB/4ingAm2/cPiDkwFc0bgWNKJzISWPoe6+TvwGyTAe7KqMc3N
	X0ut1u40TswFgYUpa7UQ75L4jpiJYce8cL4ugzvgKwFWcr7dARGAiJOp4OmMm9SD7nYG
X-Google-Smtp-Source: AGHT+IGwFVZhRMbY8QwzFsn5ba8Y922cdhlkumJH9u4dCvrO6bV4iadBR0nEL2DSOrh1zhv6St64gw==
X-Received: by 2002:a17:902:ce8f:b0:224:3610:bef4 with SMTP id d9443c01a7336-22976733d1dmr60403645ad.25.1743703385379;
        Thu, 03 Apr 2025 11:03:05 -0700 (PDT)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e902sm17548205ad.203.2025.04.03.11.03.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Apr 2025 11:03:04 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [GSoC] Project Proposal: Machine-Readable Repository Information
 Query Tool
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <Z-5famP3CgaSfDc2@pks.im>
Date: Thu, 3 Apr 2025 15:02:51 -0300
Cc: git@vger.kernel.org,
 karthik.188@gmail.com,
 shyamthakkar001@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <BC393559-6A33-447D-9AE8-BB2D9D0BC0D6@gmail.com>
References: <7EB151DA-0BDB-4D54-BBB8-CEE69F51F13A@gmail.com>
 <Z-5famP3CgaSfDc2@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.500.181.1.5)


> Could you please also amend the status (merged to master, merged to
> next, under discussion) for each of these items?

Ok! This may change until the GSoC submission deadline, but by now:

- Microproject: merged to master
- Merge Documentation: merged to master
- Extra prefix flag: closed
- Fix on git.github.io <http://git.github.io/>: merged to master
- Driver for INI files: under discussion

> This kind of information is exposed via git-rev-parse(1) already, see
> the section "Options for Files".

Thanks for your clarification! But still, I was discussing with people
here at my university who deals directly with research on FLOSS
repositories, is it worth to find other uses cases for this new command?

> I generally recommend students to take on smaller batches of work that
> can be submitted individually. The way it is structured now means that
> you will end up with a single deliverable at the end of your project.
> But structuring the project like that introduces a high risk that you
> won't be able to land anything until the end of your project in case
> there is a bigger discussion around parts of these patches.

I see... After sending this first version I was thinking about it and
it would be hard to test the functionalities without having the JSON
serializer minimally working. I'll send another version, proposing
smaller batches of work and writing a minimal serializer at the
beginning of the project, improving with the new features.

> Patrick

Thanks for your time!

