Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B6A3DBBC
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443846; cv=none; b=cFmt43VGh92ue5XLEmdo3j4TJWhMLkqWQnOm7P5IhxDAHWEthVpL769tKTVOXUwAXw6Pg+zMIexQ75e9kopDoV8brxnJjrpd8DSwViHR8eZERGsGbEdiA01HsPDIHVcQIh7fuhwkgtNUwGu0JBx7vubuVxb0vpvixp4whlH2FQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443846; c=relaxed/simple;
	bh=zsZ59BKQyN5UHYHlgIC1XbIPCjPqLo6VcIkgCrW4nzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhvPmKYEhrto612H8ruLVTjCxzQ0QBjb3V1hSlrHTCuw1uG2fNm0akyFCbrN5tLKptdejij95mBGpmJn4CLFdG7KWAoGDH8G/VE5GezR6pIMJew4YI0OQO6jowRDRGHjbya5NkvswlCXjqzj78MwOUH9sO5xFQqIxZAQaNfrJT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BL5qfC2y; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL5qfC2y"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d687da75c4so61038471fa.0
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 02:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711443843; x=1712048643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VLZM0dDYnbB73girtt9wqD1TKNZvLTCdtmdD+ca+8cg=;
        b=BL5qfC2yVKjok6+Mi+6myWKkMGnfdRff+yQ0K6LdLBZxtsUwYU0pPLiUA+XjOcI+QM
         bQ7/z5n2vsMaA8lxmJON5FiKqlVzy9QrNjgJS1sjMp7VKksQRkICufMuvDiyhXmLD9VO
         fDzU97SjUYHSEryCPQEmbiJTiYEs36EoxUiozD3aaugQU54/KsrclCzfNJhEW4z46Ch+
         rV9ZxX/ngykmOOeauU2WsNIlNIx4ztb1B6uPnukT+zGd5BLVpPcdvCv4MdBPDrJjqIJw
         5Bz9ucFoPGAmNFnWWVWQAJUJNzefp0Uo4WDEtZXRIAZHoLEm0Xg8cXc2+Tv5K2ZKQW6K
         BtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711443843; x=1712048643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLZM0dDYnbB73girtt9wqD1TKNZvLTCdtmdD+ca+8cg=;
        b=EwLN0UdFv55zHvZkoy2h6UN7G5jFnOWuocda7bOKhvY9JeceSYSHB+bRuxsy9xsV3z
         3L4TYanGqW1g3mMj9JYweiW4XRXgsaUJd7QWwOGi6FDWb8NcezThmnrGAY324LcQCDsJ
         +Dw581bAsK9dB4a60Fp929W5EtwQ9mHemlLs0Txi1uPYmzCZPyOzSyNLR3m0Q2bKilkz
         QU5J08zkdwtlEmnh2ooKt6jeogFyGpapivcR0r7BVvMffSGLAlDqH1M3IxGRjLgi73Tq
         xVjFjm7nU65cs2DBgOLuwmOqXQPIB759frqQ6uuh4wPitGxDONdJ0uN4wq4XCqCiFD0C
         77hg==
X-Gm-Message-State: AOJu0Yw+OfWmzWbSaJ8aLE6mD8IIhOKCveXeWGpMcbM7jml1CqNG/Lv/
	xb9d71BCv2COPh74IOehLQ5QDxHEyEmUXc7pPeCO+k2igjV8ZdAsaoPfOD0kfnpwP56EgHcal2i
	ExZvGCZrhHKTu3uskafkYSt4AotCIPicFNqYQKA==
X-Google-Smtp-Source: AGHT+IGW3sUyIWG2wXOAx9e46EzvxvAklMJw09jNUHr6g7R9BUrrFrCaCtZXJ+8TuxflYYTHnccfdxGobFm21RHaJAs=
X-Received: by 2002:a2e:a455:0:b0:2d6:8635:ca1c with SMTP id
 v21-20020a2ea455000000b002d68635ca1cmr451121ljn.47.1711443842235; Tue, 26 Mar
 2024 02:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHCXyj3U69qyhYewOLY9hN2rvi_5ZuSxQEBJbDxrKefm9MzVWg@mail.gmail.com>
 <CAOLa=ZRqkKhqUPjrYQWmLnLAf6Cmt17ZSMJja0rYLNWifUG+og@mail.gmail.com>
In-Reply-To: <CAOLa=ZRqkKhqUPjrYQWmLnLAf6Cmt17ZSMJja0rYLNWifUG+og@mail.gmail.com>
From: Aishwarya Narayanan <aishnana.03@gmail.com>
Date: Tue, 26 Mar 2024 14:33:59 +0530
Message-ID: <CAHCXyj2a5QFO+fDekR0sQuyFLocucMQeuABxG=6g1X92_cEkpA@mail.gmail.com>
Subject: Re: GSoC 2024
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Git Project Maintainers,

Assistance Needed: Locating Test Script for Addressing Git's Exit Code
Suppression. I hope this email finds you well. My name is Aishwarya,
and I am reaching out to seek assistance with a microproject I am
working on within the Git project.

As part of my efforts to contribute to the Git project, I am currently
focusing on addressing the suppression of Git's exit code in test
scripts, as outlined in the project's microproject ideas.
Specifically, I aim to identify a test script within the t directory
where Git's exit code may be inadvertently suppressed.

While I have attempted to locate such a test script independently, I
have encountered challenges in identifying a suitable candidate.
Therefore, I am reaching out to request guidance from the project
maintainers in locating a test script where this issue needs to be
addressed.
I tried commands that included:
grep -Er "git .* \|" t/, grep -R "git .* |" t/, findstr /s /i /p "git .* |" *.sh

Could you please provide any insights or guidance on identifying a
test script within the t directory that exhibits the suppression of
Git's exit code? Any pointers or suggestions would be greatly
appreciated.

Additionally, if there are specific criteria or patterns that I should
look for when identifying such test scripts, please let me know, and I
will ensure to align my search accordingly.

Thank you very much for your time and assistance. I am eager to
contribute to the Git project and look forward to your guidance in
this matter.


Best regards,
Aishwarya Narayanan


On Mon, 25 Mar 2024 at 23:15, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> Aishwarya Narayanan <aishnana.03@gmail.com> writes:
>
> Hello,
>
> > Dear Git Organization,
> >
> > I hope this email finds you well. I am reaching out regarding a
> > Request for Assistance with Microproject aimed at improving the
> > integration test scripts in the Git project by avoiding the
> > suppression of Git exit codes. As a beginner, I would greatly
> > appreciate your guidance on how to approach this task effectively.
> >
>
> Thanks for your interest and reaching out.
>
> > Here's a breakdown of the microproject and how I plan to tackle it as
> > a beginner:
> >
> > Understanding the Problem:
> >
> > The Git project utilizes Shell scripts for integration testing to
> > ensure software stability.
> > It's crucial to avoid suppressing the exit codes of Git commands in
> > these scripts, as it may lead to errors going unnoticed.
> >
>
> Correct.
>
> > Identifying Problematic Patterns:
> >
> > I will examine the integration test scripts located in the t directory
> > of the Git project.
> > Specifically, I will search for instances where Git commands are piped
> > into other commands, or where command substitution is used with Git
> > commands.
> >
>
> The goal of the microproject is to help you get started with
> contributing to the Git codebase. As such, it is recommended that you
> focus on finding and fixing a single instance only.
>
> > Learning from Examples:
> >
> > I will refer to the provided examples of bad and good practices to
> > understand what to look for and how to correct it.
> > Understanding why certain practices are bad and others are good will
> > help me grasp the underlying concepts better.
> >
> > Applying Correct Practices:
> >
> > When I identify instances of suppressed exit codes, I will modify the
> > scripts to adhere to the good practices outlined.
> > This may involve replacing problematic commands with alternatives that
> > properly handle Git exit codes.
> >
>
> I would also recommend reading the following documents:
> - Documentation/SubmittingPatches
> - Documentation/MyFirstContribution.txt
>
> > Validation and Documentation:
> >
> > After making modifications, I will ensure that the scripts still
> > function correctly by running the affected integration tests.
> > I will document the changes made and provide explanations for why
> > certain commands were modified. This documentation will aid in
> > understanding the improvements made to the test suite.
> >
> > Seeking Feedback:
> >
> > Once the changes are implemented, I will seek feedback from mentors or
> > collaborators to ensure that the modifications are in line with
> > project standards.
> >
> > I would greatly appreciate any insights or advice you can offer to
> > help me navigate through this microproject effectively. Additionally,
> > if you could provide guidance on where to find another test script
> > similar to the one referenced in commit c6f44e1da5, it would be
> > immensely helpful.
> >
>
> Well, you could use a regex search to find some of them. This one is for
> finding tests with pipes used, but do note that you could get false
> positives here too:
>
>     grep -Er "git .* \|" t/
>
> >
> > Thank you very much for your time and assistance. I look forward to
> > your guidance.
> >
> > Best regards,
> > Aishwarya Narayanan
>
> Wish you luck!
>
> - Karthik
