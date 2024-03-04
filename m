Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF00BA33
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 06:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709532116; cv=none; b=IsHdfMBVtIm2iCTHW3dRqUzzBcZVxo07axU5A6ixCeZRXxNHO0rnxyEugA6xrErTNvfTXLNwqcfzCOo1q5vOcOF7yQ2spTu9hXCRgeQJ0dRqf1CkRX78v4tP6BhiT1IMFYZJN2NCYMGYerP/ieSoJ9NWGH3IQP2Yoa+/Gxd5BCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709532116; c=relaxed/simple;
	bh=Rs1tsW1G6TceBfJIqichcOmE5zb2nVDWWjCi12RzeVs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=r0TS80cUDvEyyAsYgZnaxnSVevJZquno8LvKsI1ZPgmL5yelYvaoIfb1nP7PvR4EbGUud+aWhnOMfa/33cDlxsiQUzvgrMjGos0M3wH0XMh8rZZx9acUlasFCm/hPILR2LZkSwgHHxlnJiid3NCk88P7rxmhEruxANO+ycsEwEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUIQtmnO; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUIQtmnO"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d24a727f78so49104671fa.0
        for <git@vger.kernel.org>; Sun, 03 Mar 2024 22:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709532113; x=1710136913; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rs1tsW1G6TceBfJIqichcOmE5zb2nVDWWjCi12RzeVs=;
        b=bUIQtmnOMFYuokXTV/QH1tGfVNtFhBhaLbNP155G5gebLDa0pLp3uX7YHbeVmlShXm
         DZWxewB9DGNp6csxspdAo8V9dJYqZnjZ52MLrFacVfAWn7qnxPrxdDAb6rgpAtQTZjDC
         kxjOjie6pVHYWVP/jaZkFxeUp8pnsjZVP0yJsMEAcF/WENcZqH6QaQPnchltISfOggfg
         FJtAzA/uhmXbgc+Wan5OwalqmP+PWYUWCIp5iUAStRWrnEg6i5fH4nGgYY3YQEkIIwTJ
         3J5NjtSemFZK5pIGlGow2H0NED6sZX2f5Xl+z8fCaGCtyIvDdphgkT16pqPkwKebeWZN
         u5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709532113; x=1710136913;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rs1tsW1G6TceBfJIqichcOmE5zb2nVDWWjCi12RzeVs=;
        b=rLqw8SfIFn6QapKUe26WhxK58e9pRa+5O1xVZg6WfnimvqUh5eft+yYpwNWVtBFkDe
         SGX3qw8iU0IWp0VYGol7ZlEPYdZHYCotrCz7mxnHqCY1CVfylB2KHadBCgVYnfIDbarU
         odPg6A4R7aEr25cbVqKV4FxwoYcFPREGtFeCwt8pabOH8RxIxc7qlK5zKUmD/Jc7lNFu
         T9ug4wDOUj1c9FZ+lXhw2xT8q0UnYOHPcTfpwqWzZcp2OX1tcGY9s4QSV7tl9wlIU36/
         KzboRXZSy6Gnq8cG65ORAPZLNGhArnPvm1T0Ql8dy+GjZS5UNaiD3yc2mJ9xifNHHV9x
         ISxA==
X-Gm-Message-State: AOJu0YxynGxUyrbYfYgLJHHc8zP0kfjer4BK2gYADT6JU0PaPPpGzK5y
	Pw+XZZfnrjfkL98PrbhRR4OU3akYmZHn/5OavTaph17y6myzmouXJML7kdbgNCOEguV7Z8f/v7b
	9cuDqB2GUo55ICemqzG9Ai/LqJ8/Hh/girSJVpw==
X-Google-Smtp-Source: AGHT+IGtjg55BPFP97/qj9DSpFXPDPcvzAXLhpZ6xOjt3YQVigzz6LzbmAJ2jkCUe1Rao6LyhGV4KmV8Z9C62KH2Zps=
X-Received: by 2002:a05:651c:c3:b0:2d3:4c3f:c12d with SMTP id
 3-20020a05651c00c300b002d34c3fc12dmr5535947ljr.26.1709532112977; Sun, 03 Mar
 2024 22:01:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aishwarya Narayanan <aishnana.03@gmail.com>
Date: Mon, 4 Mar 2024 11:31:43 +0530
Message-ID: <CAHCXyj3agZKxgseGwS-1WD3NR1nD7ni80Q5UEhf2EVpMiaSV4A@mail.gmail.com>
Subject: GSoC 2024
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Git Organization,

I am writing to express my strong interest in participating in Google
Summer of Code (GSoC) 2024 with the Git Organization. As a highly
motivated Final-year Electrical and Electronics Engineer, I am eager
to contribute to the open-source community and learn from experienced
developers like yourselves.

While this is my first foray into open-source development and GSoC, I
am excited by the prospect of contributing to the ongoing success of
Git. I have been actively learning and gaining a strong foundation in
Git commands, programming languages, and version control concepts. I
am particularly interested in the following project ideas:
1) Implement consistency checks for refs
2) Move existing tests to a unit testing framework

However, I understand the importance of starting with smaller
contributions before taking on a larger project like GSoC. I am eager
to begin by contributing to micro-projects and familiarizing myself
with the Git codebase and development workflow.

In this regard, I would greatly appreciate any guidance you can offer
on where to find existing micro-projects and how to get involved in
the Git community. Additionally, I would be grateful for any resources
or suggestions that can help me prepare for GSoC and submit a strong
proposal.

Thank you for your time and consideration. I am enthusiastic about the
opportunity to contribute to the Git project and look forward to
hearing from you soon.

Sincerely,
Aishwarya N
aishnana.03@gmail.com
https://github.com/Aishwarya-Narayanan03
