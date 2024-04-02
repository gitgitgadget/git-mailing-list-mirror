Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A63184037
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067765; cv=none; b=oZWXBHTHDp48s/i4fs+vD2/tLr9PLO+xWgNFVDXjDsOpqyMBPR1muhOblm13BLuS3490aA94zsn8ZDoSw0m3tZ1SELjvCnyp7TBz67q6MdO0TUGP6qzJ5euttCiIu7Snev88yjsssDRTFwe/keXQlbCBxQ1NNPTjLLF1MM4nPI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067765; c=relaxed/simple;
	bh=tsaFA7tQrgNzj4zp+8JwLPwsoX8ypMQ5zCiGV5AgV28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poImqL/mRmDStatgCsuTlhSQ/Fo7LbRo94RxFR1Em7LrUWqW7V8Zs51r8Kq6FKqHiMCANVuac8kZdz9PiTfq3MFsZY5jHvhc4kN2Cr023WYoo4h0dxMY1ILRUay76l1ZTcc+e2NAmzcYwUWuMCp6VOiheiG1kkq8QDH8ntGqyU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igSoQHMU; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igSoQHMU"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d475b6609eso56556731fa.2
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 07:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712067761; x=1712672561; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RavnMSiX85oqnYolv/HlU+JJ2cFDnEYrXSQ2TnQ8/No=;
        b=igSoQHMUrjkJteiTkcQT62DNaGq+m24jsEh23suxYJ/0Yo+2sG96lXBnLC/0+jC0/M
         +PhD89++CfV72D5BNpZAWqE1ZHT0E4uxTG8dR7yoIjr7xGBdI8fSNdRMkUq69zJslxg5
         rtneIxvO1RrZRqu1w25Bp3wemtnIRnvFl5Fca45NOSaF1qg/OaPHIoGxvSxfwTiD4hEH
         P48q5/0Z0DAsR4LANV/AkU+owatAv0eF+XcD/01oSUcUueeHiUnGoaeavw3uBqKo24gq
         lgemAA8hMw1vpblGZ8JB351Y6NV1abpU9BPsHNpO4y44TczP6MEjh/jPryA2ZX4naT8r
         sF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712067761; x=1712672561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RavnMSiX85oqnYolv/HlU+JJ2cFDnEYrXSQ2TnQ8/No=;
        b=PkQCC5+J+MblH2Zs/UFQWAb8mnFlJ6HFumYbZfkXT/j4RcVEXgApYzuuBWyUXF59bT
         2HtkAcMK6jACMDxWultWgFsAlhcB36xBBczMYW65Zks3vo2RL/XZPvgQWCpfWpCs4DYY
         7HrAJl4sQ7tlbe1351N9Nd8kvYBWStI5OAsx2sbtuqao8Ewz9a0JxhGmWx4ur7ess6Po
         HdAyKZ51pUlBrjasAevMhx4ekvOc7qi4YMayq6kGE0i6CE1BKVOM7Wphv5jW0aZX2Dz8
         qseat3jc0oqQdBLewUbiTLzfXNiMzlP/LgySBebmrj1my/sn2YxcNHqQ3nycpgCmG51e
         fQkg==
X-Gm-Message-State: AOJu0YxcKZzhu7l8xZvReqdAKWhaGzDi9TAgtkebZ2YE2r2XoT2tlYLc
	/9zk0g36Jd5ws7wDzCXaru/xJGo0rFt7u2YdAKhSQKTBk+OG+dOnVfhR3XdnimlpOrcUaBscNeE
	62B4r8Qs5Emi7G4u8Qx/RRCdQrBw=
X-Google-Smtp-Source: AGHT+IE1ryVQADFBo+U8/0sK3BQXJtjcaOXpKsw7KWyaMnkmFtjW2jLFLX7m27YS/WR6RIS7OFbToNbIhoyQNGnqChE=
X-Received: by 2002:a2e:a486:0:b0:2d6:c051:d29d with SMTP id
 h6-20020a2ea486000000b002d6c051d29dmr8226762lji.44.1712067760717; Tue, 02 Apr
 2024 07:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHCXyj2y131B6C+EA9fn2zPhx+LBsL9csHgJSy4GmK9xjdMQSg@mail.gmail.com>
 <CAOLa=ZS_pZEU+BHXoTpQyJy6Sn7j+ap5J+mZWOgnL39HKhK1Ww@mail.gmail.com>
In-Reply-To: <CAOLa=ZS_pZEU+BHXoTpQyJy6Sn7j+ap5J+mZWOgnL39HKhK1Ww@mail.gmail.com>
From: Aishwarya Narayanan <aishnana.03@gmail.com>
Date: Tue, 2 Apr 2024 19:52:34 +0530
Message-ID: <CAHCXyj0UjP5hxh4sk-bqMmh70SUM-FTg-Tv1FWp9+0c9aVGh2g@mail.gmail.com>
Subject: Re: [GSoC 2024][v2 Proposal]Move existing tests to a unit testing framework
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Git Maintainers,
>It's always better to send updates as responses to your previous emails.
>This allows for reviewers to contain context in a single thread.
Thanks for the feedback.

>This patch actually was reviewed by Junio [1] and there was no follow up
>from your side. I'm not sure how this was considered Declined, so it
>would be nice to have some reasoning about it.
I apologize for the confusion and inconvenience caused by creating a
new thread for this patch. I'm still under development in my Git
contribution workflow and should have replied to the original thread
reviewed by Junio [1]. Additionally, Junio mentioned that exiting from
the test_expect_success block is not recommended. I wasn't aware of
this best practice.

>It would also be nice if you mentioned what exactly is different in this
>version compared to the previous.
In essence, the changed version project summary provides a more
comprehensive overview of the legacy test migration project, while the
previous project summary offers a more targeted perspective on the
"reftable" test case as an example.
The project summary in the above version of the proposal addresses an
approach encompassing all legacy tests, including shell scripts
(t/.sh) and helper C files (t/helper/test-.c). "Reftable" tests might
not be part of this group; they're not explicitly mentioned. This
proposal solely focuses on the process of migrating all legacy tests
and the advantages of a unified testing approach. It highlights
codebase consistency and the potential for expanded testing
capabilities.

Thanks again for your time and patience.

Sincerely,
Aishwarya Narayanan

.

On Tue, 2 Apr 2024 at 16:09, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> Hello,
>
> Aishwarya Narayanan <aishnana.03@gmail.com> writes:
> > Dear Git Organization,
> > I'm writing to follow up on my Google Summer of Code proposal, "Move
> > Existing Tests to a Unit Testing Framework."
> > After careful consideration and based on our discussions, I've refined
> > the project summary and deliverables to focus specifically on Move
> > existing tests to a unit testing framework.This email aims to gather
> > feedback and initiate a discussion on the
> > feasibility and implementation of this idea.
>
> It's always better to send updates as responses to your previous emails.
> This allows for reviewers to contain context in a single thread.
>
> > Related Works
> >
> > https://lore.kernel.org/git/CAHCXyj3U69qyhYewOLY9hN2rvi_5ZuSxQEBJbDxrKefm9MzVWg@mail.gmail.com/
> > - Microproject Approach
> >
> > https://lore.kernel.org/git/ZgQffea0krKmZUEt@tanuki/ - [RFC PATCH]
> >              Description: While printf might be unlikely to fail
> > here,I felt the change aligns with the project's goal of ensuring Git
> > command exit codes are captured. This approach is more robust and
> > avoids potential issues in the future.
> >                Status: Declined
> >
>
> It would be nice if you could also add a summary on the approach and
> what went wrong and why.
>
> > https://public-inbox.org/git/xmqqttkqwfwe.fsf@gitster.g/ - [RFC PATCH]
> > Fix Git command exit code suppression in test script
> > t2104-update-index-skip-worktree.sh
> > Description: This patch increases the robustness of Git's testing
> > framework by guaranteeing that Git commands' exit codes are
> > appropriately examined during test execution. Previously, suppressed
> > exit codes allowed tests to pass despite Git command failures. This
> > fix stores the output of Git commands in variables and examines their
> > exit codes to detect errors.The discussion focuses on improvements to
> > the patch submission process, such as adhering to coding principles
> > and referencing appropriate documentation for proper formatting and
> > test script adjustments.
> > Status: Declined
> >
>
> This patch actually was reviewed by Junio [1] and there was no follow up
> from your side. I'm not sure how this was considered Declined, so it
> would be nice to have some reasoning about it.
>
> >
> >  https://public-inbox.org/git/CAHCXyj1hUVNNuCOgsNv4GJUi79_o9iWZDvV8Ocz3DodreYoL7g@mail.gmail.com/
> >   - GSoC 2024 [PATCH v2] Fix Git command exit code suppression in test
> > script t2104-update-index-skip-worktree.sh
> >                                  Description: This patch resolves an
> > issue in Git test scripts in which the exit code of git ls-files -t
> > may be disregarded, resulting in tests passing despite Git command
> > failures. The new version guarantees that Git commands used in
> > pipelines produce captured output and perform adequate exit code
> > checks. It also enhances code style by adhering to established rules.
> > This adds to more robust Git testing by ensuring the identification
> > and reporting of Git command errors within test scripts.
> > Status: Under Review
>
> This seems to be the same patch as the previous. A new thread was
> created here instead of replying to the previous thread.
>
> > Porting Unit Tests:
> >
> > [1]https://lore.kernel.org/git/cover.1692297001.git.steadmon@google.com/
> >
> > This patch series provides unit test functionality for the Git project.
> > The series includes the following patches:
> > A project plan document that outlines the goals for introducing unit
> > tests, as well as a review of potential frameworks and the features
> > used to assess them.
> > An implementation of the TAP unit test framework with a sample unit
> > test and Makefile integration.
> > Changes were made to the Git build system so that the unit tests could
> > be run in CI.
> > The TAP framework was selected because of the following advantages:
> > Simple to use and comprehend.
> > Widely used and integrates seamlessly with existing Git tools.
> >
> > The project plan document mentions a number of outstanding TODOs,
>
> Maybe I missed it, but where are the TODOs stated?
>
> > Next Steps:
> >
> > A following commit will port the relevant code from
> > t/helper/test-date.c to the new unit test file t/unit-tests/t-date.c,
> > using the newly introduced functions for pre-requisite checks.
> >
> > [5]Unit Testing in Git:
> >
> > https://github.com/git/git/blob/master/Documentation/technical/unit-tests.txt
> > discusses unit testing for the Git project. This gives an idea of the
> > background and importance of unit testing in the project applying to.
> >
> >
> >
> > During GSoc
> > The main goals of this project are:
> > 1. Understand the existing "reftable" unit tests: Examine the present
> > implementation of the "reftable" unit tests in
> > 't0032-reftable-unittest.sh' to ensure that you understand their
> > functionality and purpose.
> > 2. Learn the new unit testing framework: Get a thorough grasp of Git's
> > new unit testing framework, including setup, usage, and recommended
> > practices.
> > 3.Ensuring test coverage and reliability: Check that the converted
> > tests have sufficient code coverage and accurately simulate the
> > expected behaviour of the "reftable" capability. Test and validate the
> > new tests thoroughly to ensure their reliability.
> > 4. Documentation and code comments: Document the conversion process,
> > including any issues encountered and the reasoning behind design
> > decisions. Update the code comments and documentation to reflect the
> > changes to the tests.
> > Deliverables
>
> Kaartic's review in the previous version mentions [2]:
>
>     Your project summary and the deliverables below seem to mention that
>     you're going to work on migration of the reftable unit tests but the
>     project title seems to be "Move existing tests to a unit testing
>     framework'.
>
> It seems this version is the same...
>
> > Closing Remarks
> > Finally, I'd like to express my gratitude to the community and, in
> > particular, my mentors, Patrick Steinhardt,Christian Couder,Kaartic
> > Sivaraam,Karthik Nayak,Junio C Hamano. They did and continue to do an
> > exceptional task of maintaining and empowering the Git open-source
> > community, as well as offering much-needed and kind assistance to a
> > new contributor like me.
> > ---
> > Sincerely,
> > Aishwarya Narayanan
> >
>
> It would also be nice if you mentioned what exactly is different in this
> version compared to the previous.
>
> [1]: https://public-inbox.org/git/xmqqttkqwfwe.fsf@gitster.g/
> [2]: https://lore.kernel.org/git/CA+ARAtpqD0um9bVrjRKG0DmrxVR-46uSKfDKnO+H1rUp0i+4Ww@mail.gmail.com/#t
