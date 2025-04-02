Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D25C96
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743619697; cv=none; b=Gnpym5rA/dfXJODSH0QSLKL7KwxWV97OxHPzYwPyhvybAHHnqQYaxxN6GqBTnwxfJ/FCI4hcOv+JguTepUf3oh98iI2WbuPkVuu9bcw+kljEZIe52+0u1CV1uh1Kw3NmNj+zJODxeRb/89zbZzo/tNlTW5cla6Xtac7ZsmzwnUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743619697; c=relaxed/simple;
	bh=nAdaKBafFvihHQGxG2obFnSSC2hEOnE0toUUc7JSdVk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Q3TqElDaflOJ+JC0b58VezmnP6FkmsP3o68Eip00/ZmLzucjxRvM8F6Wufhb+G9QNeTl8zksYtjDaEG238mmSDBZQXh72rXop7QBdokDBNcjneXHgf+O43CHggato+I4IF8H7vBRR56Ng6lCV+LXUTMGRgaicQZ7AIxqKpx8vPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fieGHKIr; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fieGHKIr"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5cbd8b19bso14315a12.1
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 11:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743619693; x=1744224493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DrvVtTmzEyAYrjKhXLTaSqJria0RFsfc+l9b9j1p39I=;
        b=fieGHKIrL03P13zLMaULuSft63moetbGdmvheaq/uAFTrvfmd6qsAUCefuKN29jFLq
         nlwe0ZwJ/jc/LWFS78Im3FFCwd7lPajCTYhlr28VAistuq8lPph9XI5N6h1JdpWg0Qa5
         jZv9oBuZVT8rj4sGh9dR/TjjD1mMWa1diXFU5QZJeUpU6wWf10dDpd89LfghZHuhP554
         RWay3fU0Xug/rgiNrhEBK1kUfagO8fkFTwCsxy9ky0GFb2Dlk3me1YmnvHj/KcafilVi
         YbQb8ioFT24wa5gosZS23WimK8YKm/7pEdA3PVouik4IZBdAJgoKcOb7EG5RPvUhBnOM
         Y4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743619693; x=1744224493;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DrvVtTmzEyAYrjKhXLTaSqJria0RFsfc+l9b9j1p39I=;
        b=IRkQXV3AD18zAcstbZcBq/RLSWejitcSDhsmia1DNjWPFl/+QrM5PXJFrjri8YZRIu
         Ki/Dx/MyMCdSVw/C/+Biny5KXa7S3GMMkGM5Xrdo4oB5P2d0nKVvnV40+Xm3sMB0IU2m
         03K9MXxPHMr5xgseixKjJjKHO29QVXRRZKriM6YC3hAvCutZKa5VbN3g3YM39WHF8Nn1
         6crNhcex7B4cIheoowDZOPomASC3SqQOVTgzI8MkkKEqDOZYF8JK6nrJfKQzmqfiJPuN
         NnQKWbf+zX8U/q4+owKCz0WFujjHAQ4E4j4iTl+BVx0gizxRNh4/oLunr5u3dmaKhEVG
         QfBg==
X-Gm-Message-State: AOJu0Yx3Y3x5h5U1n5FmW1/Ne30iIGbjrSPg8UxXgi8mBU+LK/J4cQqP
	rGX1bnMrwy6wu2LwNlS3PiDM7W8np/iv0MZQ+azpguv2v7LAHVByIjV5FkDqp1W+PKEX8YDkWrz
	L62MPaoeX2vW3WKtiehclz/QD3lWuy/CYX1z9MCRCUPFiZMsyzF1F
X-Gm-Gg: ASbGnctTAmB0GGFV8g7aX2unXRM7LCv9z2G3pR6KRwfzngZEFDcDUB+n+ZmH7Ua8dgk
	t/1USGwEtmt32zXYYtvWb+gWwRJ+mW4XBrhJ3sb5k7BmweRKs4FgCbHAvhJLgVymwWDdFJb4cEI
	DCJajSHAHZouULIPwmQkmljjpdN9ONKsyZMUHMDNv9H+pJnETZCrTFDhzfKLGDMiSwreY=
X-Google-Smtp-Source: AGHT+IF/eDzSR59Etzbhihvw8iK2ElStPjveMQ8mmlNN6aKLqc3nHsnuBvg/4qaqEOxGz3JvC+TUIrC61UQb1T2yPsc=
X-Received: by 2002:a50:b412:0:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-5f0852e1cfamr3876a12.7.1743619692617; Wed, 02 Apr 2025 11:48:12
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Wed, 2 Apr 2025 11:48:01 -0700
X-Gm-Features: AQ5f1JpYX685QYI5SlV6kZmHpjUnrFG24QLBD6sG-XbxCCyFEQcO2UhlRZumEzQ
Message-ID: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
Subject: Gerrit, GitButler, and Jujutsu projects collaborating on change-id
 commit footer
To: Git Mailing List <git@vger.kernel.org>
Cc: Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"

Hi,

The Gerrit, GitButler, and Jujutsu projects all have a concept of
a "change id", and it behaves in a similar way between the three
tools. The change id is conceptually associated with a commit.
It follows a commit as its rewritten (e.g. by amending and
rebasing). The three projects currently store and format the
change id differently. We would like to unify that so we can
interoperate better. We hope the Git project is also interested
in preserving and using this header.

There are many benefits to having a change id even if it's just
local. I mentioned some in my email to this mailing list in [1].
For example, it enables
`git rebase main <change ID>; git switch <change ID>` without
requiring the user to look up the hash of the rewritten commit.
If the change id also transferred between repos and preserved by
a forge (such as Gerrit), it enables the change id to be used to
identify a code review.

Here's how the change ids are currently stored and formatted:

 * Gerrit currently stores change ids in a commit trailer called
   `Change-Id`. It always starts with the letter 'I' and is
   followed by 40 hex digits. For example:
   `Change-Id: Ib563e78c3fedcff262255fa025441daa3202311b`.

 * GitButler currently stores change ids in a commit footer
   called `gitbutler-change-id` (older versions used
   `change-id`). It's written as 32 hex digits separated by
   dashes as in the UUID  format. For example:
   `gitbutler-change-id  7d0fbc63-032d-413c-8ae8-610fbeb713c0`.

 * Jujutsu currently stores change ids in a local storage outside
   of the Git repo and is therefore not part of the Git commit
   id. It is stored as 16 bytes. It is rendered to the user as
  "reverse hex" using 'z' through 'k' as hex digits ('z' = 0,
  'k' = 15). This allows even short prefixes to be distinguished
   from commit  ids, which is a very useful property when used in
   the CLI.

As mentioned, the three projects would like to use the same
storage and format. I think we have a consensus to store it in a
Git commit header called `change-id` as a 32 reverse-hex digis.
For example: `change-id ywlktllmukprnxnmzzprukpuwyztylwt`.

There is a design doc [2] about the impact on Gerrit and how to
handle various cases where the client doesn't understand the
`change-id` header. That also includes some discussion about
whether cherry-picking should preserve the change id or create a
new one. I think there is a lot of value in having a
standardized header regardless of what we decide about
cherry-picks.

So, to be clear, this is mostly a heads up at this point; we don't
depend on any immediate changes from the Git project.

Thanks,
Martin


[1] https://lore.kernel.org/git/CANiSa6gwup5vXU235mG+Ybbc+P=SbwoNFEmuhg=iYu0yGvSXVA@mail.gmail.com/
[2] https://gerrit-review.googlesource.com/c/homepage/+/464287
