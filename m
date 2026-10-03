Received: from mail-oi2-f1.google.com (mail-oi2-f1.google.com [74.125.231.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3B3932DC
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791017696; cv=pass; b=cY1+b7lWEPGSVsK1vrPigbrHG/FAXPfI+n7wZrXNFPTgoky7QZDSIK9w9X3PTQ6EeSHB8qDZJuOhpzk0LSDTnMQuTe2RERruz3YjF767tmPSzNF8SC17kweRt84EmJtUonc1JGixDNPMtWZ62T4LPjM8D2o5uVkjskXNEbaAN0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791017696; c=relaxed/simple;
	bh=DxNcD06TM1uXWQaKS3BbLUlb99IYPsB8269B7SxzF1g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jDlRW5766lr3ocSoyQ9rraDs2RJscScY1U78AajEKSN36tw39xy5qJr/G6ALUOlVP6+R5uNc+GzNSHaDpdT/YrbeHF8qw1HoyfIG5nmTA2S5bGMMUj8xGuVPv4Sy5G0yKIUwDJC39ArrT7r/DjNjdouAkibg4P42ol30Hl1Zpec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rpnuqiSa; arc=pass smtp.client-ip=74.125.231.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpnuqiSa"
Received: by mail-oi2-f1.google.com with SMTP id 5614622812f47-4b3780fb4f5so70432b6e.1
        for <git@vger.kernel.org>; Sat, 03 Oct 2026 01:54:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791017693; cv=none;
        d=google.com; s=arc-20260327;
        b=YPXSxylhUaovpm/KMBv2hFbpSrZGysy4FtKko8dJSURApqvssMLRWNtWaf07PS03R3
         lab/RKQSx8uD8xb0NvMMMJSJK4rOc187ffYDfsm74BzLgMRudVUkRPLJyQGvdilKXNqe
         qHw/SiEle0GiJflT9Ggo0AtO/3U/9XuCBZ3nGSplVKpSD50MSqRm6QvozSBUoGwOcHXj
         P8ITf1uafPEI7nFtJZtUClc2tbLKCy1c331dLffYtWhMirAQmsyzGVzejNsxTYKWYSn5
         YSw5bRRpjJ+q+a2BYGnErKsilEMav58qKC/JE4IEHkmydcHw4lFnsDPqFhLNbSD6d+EN
         nJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=DxNcD06TM1uXWQaKS3BbLUlb99IYPsB8269B7SxzF1g=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=C0XTJLKlPgFdHkBRZ+JSloU9NJdue5N/ZfCQeXfnjWlXaN9SfL8knw8JKin8hgO//q
         b+hKWmtGOLTmQ/CmtvmNBqvMvw+puIpr6hpr0Ugn1pLRnL0CIAGeyVtIijYvDw1Tr7vw
         TbNkJ10RBVC4Daa7/riqL4V+N5KOfElkmv9RPcz5QVO9lvjkAbVg6+KsqNQaHGQjhdoe
         mWe2rW06+N6iM7S5KyxbtGi2MCSFD2Cl25bh8fowv7k+ghvTzUSU4lLD+M+VioYTiCJQ
         9YcL5lF+RMlVPs8gVvnfriU7lTGC5NPf1BtSp9F/uhmRlNki3UKKcNXYMi+08Or95dOO
         4HQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791017693; x=1791622493; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DxNcD06TM1uXWQaKS3BbLUlb99IYPsB8269B7SxzF1g=;
        b=rpnuqiSaTDgAl4T3viaz0BNe72+6xwJIbU0Lf/hTv6M53Z8gzSMe4fzdKyr9mpYcXd
         6xNkRHiO0D08N3pqm7dvWA0OPwYQyxfdxCQD/70qPKxdC3gCqmF1QAYa1EWsw6KNbPdT
         Ke1KjCZfyiuGIVUmNZpv8b1eFOMs2I44iHzkb5X7Q3Ba7nnoX4P4Zy5Q29nxHHTvRXRs
         cGPyiC6CCDW0xQ1MgFCIna7UzMr6yv7ZqCAOxVbOYT7FcBxBvIMJ2QEoKbs6xqjBv7BH
         8wKAJMn8WcjLZtwrMLf8bs0eoQmCbhs/+hZmlvve60H1T5rC0i6u3YBKIfRKb1WOr2E0
         5x4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791017693; x=1791622493;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DxNcD06TM1uXWQaKS3BbLUlb99IYPsB8269B7SxzF1g=;
        b=r8Dqu05UaLFbyL9hWAASIIXmNBh3gJt9S2c/0JuUTVaRGOdOtYKBArx+/0wrOaNl6R
         NcPKxb2Gux2kCaZle2wfPrdF9IVjhXlJNIUM8no8f15LihuCq3xF+tcRhbvdjuQgcDtm
         kdtQgO33OAf+0CS4S9bSY2bu9npkZ3djhmb+IjF3ZKoQGIrZVKHKyNBjNrlJ+Y/apBJz
         Cswxrqf7wmCZymUDNIDMFCl6HmhdRiGj9g3GlI5FopMo99jos7mo/vEpcSJnSlplid+J
         ZlF6e1nRbWwKihQSdBFi3ItKWD4YmRn/91C0tFwQeB//xsPeqEkajHIhJTaptdyFKxVi
         P+TA==
X-Gm-Message-State: AFuF++mYhvwwgv1l2jGi/FA9Pjv205+lL/X6aPJZeIP8MWBwevRyH/7Y
	S+oa05Haf8c354kUGk6T//yGKKDe2JWHg0AevLyoYExwzWpgQmuvy0dsewBlOE0US79TYe54EvK
	wivQqbwL4thpoIKB6RzQuThqX73yNJpa7TnE/ZddXiPl0iI/hYg==
X-Gm-Gg: AYBFou1RtYZtsHiJ78uBMiHUF1xAF9S1j5FOwTBgCinP/CaSNOyy9DQucApXvqmLGTz
	m6mjeO3YWzgCaxSlkeEqED1CIcu5BjXurvO+rMKMQVl42cGAPFWJYO7/+zxcVHTF0scLvrN3fwE
	2i4gp6T5y45b43ghDVTNyKXhKugIutIvuyVSh0/W5ASvWcpZJF6m+/ju0ht5naU5AQcQCUFbKn2
	BBRzPpLqo+8GbaMvfSEJU+Q4zYoUEr4Vn/hcqSEIOY+yHOcQYK6mIedkpmw+ajc5xxVlWYBslRf
	rbeDExniHQynxBApSPdnc32I9HQ8PEn4YyXtEg97Ce7or7jZ6dDdoAifAz2KUq5/Qa/0i+0=
X-Received: by 2002:a05:6808:1997:b0:4b3:80c6:4bd4 with SMTP id
 5614622812f47-4f677447392mr2216132b6e.5.1791017693072; Sat, 03 Oct 2026
 01:54:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sphinx <sphinx9692@gmail.com>
Date: Sat, 3 Oct 2026 14:24:42 +0530
X-Gm-Features: AclHuK9vAyeMb_bmCx6_sTStno-4RvqNcH5u2cUKmwceo06j1DpHhg0a58k2rJQ
Message-ID: <CALfz8Qx63qNoSbXq7C7u+KwX4=HCL7=uOUahpXd6j7KvW_c_Eg@mail.gmail.com>
Subject: Question: behavior when reverting a commit from a shallow clone
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Git maintainers,

I have been investigating Git's behavior in a particular destructive
scenario and wanted to verify my understanding with the maintainers.

Consider the following repository history:

A -> B

where A contains the repository's files and B is the current HEAD.

The repository is then cloned with:

git clone --depth=3D1 <repository>

so only B is available locally and its parent A is not present in the
shallow clone.

If an operation is then performed to restore/revert B, I was looking
into the behavior when the resulting working tree/index becomes empty
=E2=80=94 effectively causing all tracked files to be removed.

I have gone through the Git documentation and experimented with the
relevant Git commands, including the behavior of shallow repositories,
branch deletion, working-tree changes, resets, restores, and other
destructive operations. Based on my investigation, I have not been
able to find evidence that Git provides a warning or confirmation
specifically when an operation results in all tracked files being
removed or produces an empty tree.

Before drawing any conclusions, I wanted to verify this with the Git develo=
pers.

Is the following understanding correct?

An empty tree is a valid Git state, so Git does not generally consider
transitioning from a non-empty tree to an empty tree inherently
erroneous.

Git does not have a general safeguard that warns when an operation
will delete all tracked files.

If there are existing safeguards, warnings, configuration options, or
historical discussions that I may have missed, I would appreciate any
pointers.

The reason I am asking is that I am trying to establish precisely
where Git's safety boundary is in this scenario specifically, whether
Git itself is expected to warn about the resulting empty tree, or
whether detecting an unexpectedly destructive tree change is
considered the responsibility of the tooling performing the operation.

Thanks,
A fellow git user
