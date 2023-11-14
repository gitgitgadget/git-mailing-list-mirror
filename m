Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656BC168A4
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l86uO7Fy"
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B188F5
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 01:14:35 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c742186a3bso67780031fa.1
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 01:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699953273; x=1700558073; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6232Jn7YiMdYbK4ysT29lu3IzB3afjLnQHhVtoeib98=;
        b=l86uO7Fyw+73Zje2H0PBNtdnwNHtpUBkm+ME7wSSft79o+wpFplItogubdVsp/iDVp
         45mw8hMHt+MMZS6eiknf7WmaVznn5uKRNqCVVKIBB30aJw5UqUP8WgwV17JMhxDElIBj
         D2J9rt06nDM1xPrbG0eY3V2brfmZzY0lG92wI1BevpdAkOCN64LhTX8i1R1H5dDIflMo
         n1nZqZYpU6H2lb3W3MSZuVs2yFQg0qzAKdJJ0ZXVCvCz+rEELLZFwOOf34cCpLby3yWF
         vB0u0bcO+yNT4bo5Ulk+m/GOeU1Z/V5qlrQxx1x1vWF4yzs5crE4ZeH9YmDqYP3Eou53
         iqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699953273; x=1700558073;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6232Jn7YiMdYbK4ysT29lu3IzB3afjLnQHhVtoeib98=;
        b=EvOrdE/FwRvOfwUpxJPC2xDbTJZmwAPNPNiSgtGipUr0bIRuANvmK0xyOtISVPDjqn
         wugKe0usLywmAVXoWdQh+7ugRMKqy/nZp8lQ5fAB1ewjS9qxD0l7at561hOSdSIt9Sy/
         Y071dIBzOaYUHWYakFmtZ1fT34AQPok5A+cTDUmVsmVzQLW4Yc+cF0NuHtvFYLmgraSs
         7i4pZ2U0X8M/ioS+SXVBPvu4yTIaUhRxRQpavmgJzYNpzXwyAthpSW6YPJQ54bbAaaNN
         TxCsyg8vlmPF0PYbpjgpdNyK/r/IOCguoD67wew3HFgYISnd1VbbQblNVwmbqr9rpzaS
         hcnw==
X-Gm-Message-State: AOJu0YwvMxu7c3l81RH9+3Wx7mZqCQdmqpQJCZU07QpRX3cSrfVpXe39
	RYWuYxzRPJedzwyRfEY+LxvEPNwJX4nK+BmE7qUC1pBYjbo=
X-Google-Smtp-Source: AGHT+IF7iHeDF5GsxGGNQFHA/7Rl8L0CcTtG20lp+fGpJhsqV59FBuEH21oGYZgAw95g2zs/nuLH1lRzd7FbIlnI53w=
X-Received: by 2002:a2e:a4cb:0:b0:2c5:5926:de52 with SMTP id
 p11-20020a2ea4cb000000b002c55926de52mr1039775ljm.53.1699953272923; Tue, 14
 Nov 2023 01:14:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondra Medek <xmedeko@gmail.com>
Date: Tue, 14 Nov 2023 10:14:21 +0100
Message-ID: <CAJsoDaFNxEEBuXK1o16NE-JzLeckpWbqxY_vhgqGF7MS-A85jg@mail.gmail.com>
Subject: Document git status -b --porcelain
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am using "git status -b --porcelain" and parsing output in a code.
However, the output is not documented for an empty repository or a
missing remote branch. (And maybe a detached head, too).

Doc for Porcelain Format Version 1

https://git-scm.com/docs/git-status#_porcelain_format_version_1

references doc for Short Format

https://git-scm.com/docs/git-status#_short_format

and it says:

> If -b is used the short-format status is preceded by a line
>   ## branchname tracking info

However, when I have a fresh clone or an empty repository, "git status
-b --porcelain" results in:

## No commits yet on master...origin/master [gone]

So, it seems to me the format is something like "# [info1
]branchname...tracking[ info2]" and it should be documented what infos
may appear and when. Otherwise it's hard to write robust parsing of
such output.

Thanks
Ondra Medek
