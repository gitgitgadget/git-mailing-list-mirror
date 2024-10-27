Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2007D1E535
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730071058; cv=none; b=Hd/Wwey5OjSwCHAUADZzdlHsz++aNJHW0+vEQTh8+fUyjqJFxnlK+tvnq90mAhcvTPxrhY0aX7ZpUqTsXj0nAd6Lmm2u5cDoT9gUP2CM9vtO0CGV2ntleovt+PQNAvKQAtC3RlAeJzkivnNKt83neAGrM7o+Js6S4+UNW3nfjlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730071058; c=relaxed/simple;
	bh=hv9GT+adDqotM8WBfjLWzTr0U9V52634CzgkPI6QM8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2JXbLxqr3G7L6nMjEhJhPZsh8kFT0Ihpu/d8yFmFxKN9O2+Rj6fdTx8PFv70m0K/+GeuelBdrO106tWYeyvp2dcj3a9eV13pk2CjxWsMRjqIyJF1xhFfPpGGBKoV6Kj/HwV+kCL9pK+sjdMPdijIfh4yBeCf+6dzAho+cuUqM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msbGjJBx; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msbGjJBx"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e35bf59cf6so45061437b3.0
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 16:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730071054; x=1730675854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bq1t4payhubvqr/+hJfK/M3MYPD9IwC1WglCLQzI5HM=;
        b=msbGjJBxb1jwr8msf6LlW1ZAmt2yWH7w/rlzWsmUTSpArTQAEPewDR07cHD+40oenw
         C4XbPIHDTS+I17+P7iwWpgSO/E2szTSZvzK16v+Dau9f0BHKatiJN8cISTSNmi/nYqys
         6INd45jZQeA03nMMaIU8UKR4Tn6UWW4z/TWsKhhtJ7eHP3Y/dtSqes4rMPTOMUEeDzCg
         A4ZD5gq9OwJz1P1BX1cOecOvUCLEw+0B8Ri7o9dMSXFRwXp+miwRxQT1cpQPuhCgv36Q
         IYXgKMoFdPQHsWYE3PjaOTXppMmHTzN/iHRX1Yo8VLkyVeBXVodHvoD7NbWiXSek68Rv
         5qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730071054; x=1730675854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bq1t4payhubvqr/+hJfK/M3MYPD9IwC1WglCLQzI5HM=;
        b=atPoT5XEZpuvrvkRh+EuMqShm+NJRy2AWhtXiq5NoDw9JwYQ6HKoOEkdf+h8XU0GwK
         dEtoSersas/GDbYY49zJ/N/Kk1j3wZdAyqJHuRUfp8QbPTfPLL2SGBixoZqaO/vFzy+G
         TsMe2nn20MmmgWJF0JHUyVUzeYM1t63tHN+HCdH2LJGJhnsL7dFGYTZtHSEnE4qJCPSm
         PN2jKtA9TAS2qbP96RnRM6Vhsgu8ObBKsk5AChOWPwN702LMcQ9fUhYI1VeVIKXsHMFj
         Jm4KNkrJAfR6kO4otOf7ed4TpPmi4Gv5sJUloBA2qubbETQt7xFdnrNZqlOsJGLpWTjJ
         +Unw==
X-Gm-Message-State: AOJu0Yxe2qBJpPHCbs7ieWqBCVX1X7m/T93uBHY8QQxiQ9F1fOBWNHau
	lJ6RFBym8GPNyIeeHZV2I5GGfVDVIsKBKs5BScL0sgDu8tST8HObYUZS60r8eERAhOSdwaxnnAO
	3L/0rG9RCo/6ckXerjrgCkd6ePTTyvl+iZcaxqQ==
X-Google-Smtp-Source: AGHT+IHKN+bEHP22HxxiTFZ0LxH8FQWGv5ENOSy4HY8+rGDoyZIFcxUpEqzb/fd7CAW+lQICANWg+L7NTpRwJew2bik=
X-Received: by 2002:a05:690c:74c5:b0:6e2:1eaa:1c90 with SMTP id
 00721157ae682-6e857fe6e2cmr103004497b3.18.1730071053791; Sun, 27 Oct 2024
 16:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGedMteoVFfZy1jtHMPJvByzfq9unomcA7qkCNKx9R6_ZQ6=Cw@mail.gmail.com>
 <Zx4bEOGr8Hy-ZfX2@pks.im>
In-Reply-To: <Zx4bEOGr8Hy-ZfX2@pks.im>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Mon, 28 Oct 2024 00:17:21 +0100
Message-ID: <CAGedMtfrM1NZ6SY3SEy3+zSSvbB+D+Z_03jo9235fXoyuVXW5w@mail.gmail.com>
Subject: Re: [Outreachy] Final Application Timeline
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 27 Oct 2024 at 11:51, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Sat, Oct 26, 2024 at 03:50:11PM +0100, Seyi Chamber wrote:
> > Dear Mentors,
>
> Hi,
>
> > It's almost the deadline to create a final application for the Git
> > community, it's a little unclear how I should create a timeline for the
> > project *Convert unit tests to use the clar testing framework*.
>
> you may have a look at the recent thread in [1] to get some more input
> on that.
>
> > Does a timeline of the first 8 weeks spent working on converting the un=
it
> > test framework to use the clar framework and the remaining 4 weeks
> > spent on *implementing
> > additional asserting functions for Git-specific types *and using *clar
> > upstream to improve shortcomings discovered during the integration of G=
it
> > with the clar* tasks sound good?
>
> What I'd specifically like to see is how exactly you want to work on
> things. So it's not only "I will convert X", but a couple more items:
>
>   - Are there things you need to learn? When do you plan to get familiar
>     with the codebase and how do you tackle that problem?
>
>   - How do you plan to approach the topic? Do you want to convert
>     everything in one go and then send over a huge topic or rather want
>     to work on it incrementally? You can also take as inspiration the
>     last GSoC students that converted our unit tests from the test
>     helpers to our own unit testing framework.
>
>   - Do you plan to work with clar upstream in case you feel like there
>     are missing features? It might make sense to have a look at it early
>     in the cycle so that you know what to expect and what you may want
>     to implement there.
>
>   - Plan sufficient time for review cycles. The Git project is not
>     exactly the fastest-moving project, so you need to plan time
>     accordingly.
>
> Overall I don't expect a hugely detailed plan that knows ahead of time
> how long you'll work on each of these items. I just want to see whether
> you've got an idea for how to approach the project and how to work with
> the Git community.
>
> Let me know in case you've got further questions!
>
> Patrick
>
> [1]: https://lore.kernel.org/git/CAPSxiM-kf8U=3Dvzp5MoD3tUuOtnNjcCgPhLdri=
yeQo5CGf=3DEhyQ@mail.gmail.com/

Dear Community,

I hope you are doing well. My name is Seyi Kuforiji, and I=E2=80=99m thrill=
ed
to connect with you regarding my interest in contributing to the Git
project as part of the upcoming internship. With a background in
Software Engineering and hands-on experience in C Programming, Git,
Python, and other tools, I=E2=80=99m excited to use my skills to contribute
meaningfully to the Git community.


## A Bit About My Background

My journey into software development began with Python, which
introduced me to programming concepts in a beginner-friendly manner
(one of Python's biggest strengths :) ) and eventually led me to
explore version control with Git. A few years later, I pursued and
obtained a software engineering certification, building a solid
foundation in programming with C as my base language before
progressing to tools like Python and JavaScript.

Over the years, I=E2=80=99ve worked with various tools and on a variety of
projects, from a simple shell program that displays a prompt, accepts
single-word commands, and executes each one, handling errors and
exiting gracefully on EOF (Ctrl+D) [Simple
Shell](https://github.com/Seyi007/simple_shell), to full-fledged web
applications where I collaborated with people from diverse
backgrounds.

Along the way, I=E2=80=99ve gained experience writing unit tests in differe=
nt
languages, reinforcing my ability to learn quickly and solve complex
problems=E2=80=94a skill that has been invaluable in my development journey=
.

## Project objective and scope

The primary objective of this project is to transition Git's existing
unit tests from a homegrown testing framework (such as
t/unit-tests/test-lib.h) to the Clar testing framework. Using Clar
aims to improve the readability, consistency, and maintainability of
Git=E2=80=99s unit tests.

The existing structure of Git=E2=80=99s unit tests consists mainly of .c fi=
les
within t/unit-tests/, leveraging custom frameworks and assertions.
Clar, with its organized and efficient testing model, is well-suited
to replace these frameworks and streamline Git=E2=80=99s approach to unit
testing.

As displayed in this patch:
https://lore.kernel.org/git/604303e31aad3a9e74f7bdddc84f11d4d137c864.172545=
9142.git.ps@pks.im/

The following improvements can be observed

* Clar=E2=80=99s test structure provides more organized, descriptive test
functions, such as test_strvec__push or test_strvec__clear. Each
function isolates a specific test scenario, enhancing readability and
maintainability.

* Clar=E2=80=99s macros, such as cl_assert and cl_assert_equal_*, provide
uniform assertion syntax, making tests easier to understand and
maintain. The check_* functions from the previous framework were
custom, adding complexity, while Clar's built-in assertions improve
standardization.

* Using Clar aligns Git=E2=80=99s unit tests with a more structured framewo=
rk,
facilitating integration across the project. It potentially simplifies
contributions, as developers familiar with Clar can readily understand
and add tests.

* Clar includes built-in support for more complex test setups and
tear-down functions, making it easier to expand testing scenarios if
new strvec features are introduced.

* By adopting Clar, there=E2=80=99s an opportunity to identify and address =
any
framework limitations through upstream contributions, potentially
improving Clar itself and benefiting future Git projects.


## Contributions

I modernized a few test scripts during the contribution phase by
removing whitespaces after the redirect operator. Please find the
status of my contributions below:

- [PATCH v2 Outreachy] t7011: ensure no whitespace after redirect


    link: https://lore.kernel.org/git/20241019163439.274656-1-kuforiji98@gm=
ail.com/


    Status: Merged



    Description: This change updates the script to conform to the coding
    standards outlined in the Git project's documentation. According to the
    guidelines in Documentation/CodingGuidelines under "Redirection
    operators", there should be no whitespace after redirection operators.



- [PATCH Outreachy] t9101: ensure no whitespace after redirect

    link: https://lore.kernel.org/git/20241023121113.915310-1-kuforiji98@gm=
ail.com/


    Status: Queued


    Description: This change updates the script to conform to the coding
    standards outlined in the Git project's documentation. According to the
    guidelines in Documentation/CodingGuidelines under "Redirection
    operators", there should be no whitespace after redirection operators.



## Project steps

-  Initial Preparation and Codebase Familiarization
-  Develop a structured approach to incremental conversion of tests.
-  Initial Conversions and Incremental Submission
-  Feedback and Clar Collaboration
-  Continued Conversions and Feature Integration
-  Final Documentation and Wrap-Up

### Details

Week 1-2: Initial Preparation and Codebase Familiarization
- Objective: Get familiar with the Git codebase, particularly with
test structures, existing frameworks, and Clar.
- Tasks:
  - Review the Git project's code style and standards documentation.
  - Study the layout of unit tests, focusing on the t/unit-tests and
t/helper directories.
  - Analyze previous GSoC students=E2=80=99 work on test conversions for co=
ntext.
  - Review the Clar framework=E2=80=99s documentation and identify any
potential features to implement or adapt.
- Milestone: Build a foundational understanding of the Git codebase
and the test framework, and outline any necessary feature
implementations in Clar.

---

Week 3-4: Strategic Conversion Planning
- Objective: Develop a structured approach to incremental conversion of tes=
ts.
- Tasks:
  - Identify an initial set of unit tests for conversion to the Clar framew=
ork.
  - Create a conversion roadmap, prioritizing simpler tests for early
conversions.
  - Documenting conversions (notes, comments, dedicated documentation).
  - Confirm the feasibility of incremental patch submissions based on
the Git community=E2=80=99s preferences.
- Milestone: Establish a conversion plan that balances incremental
work with periodic review cycles.

---

Week 5-7: Initial Conversions and Incremental Submission
- Objective: Begin test conversions and submit initial patches for
community review.
- Tasks:
  - Convert the first batch of unit tests according to the planned roadmap.
  - Ensure compliance with Git=E2=80=99s coding standards and best practice=
s
for each conversion.
  - Submit the first set of patches for review, incorporating any
initial feedback.
  - Document any challenges encountered during the conversions.
- Milestone: Complete and submit the first set of converted unit
tests, gather feedback, and adjust the approach as needed.

---

Week 8-9: Feedback and Clar Collaboration
- Objective: Address reviewer feedback and explore collaboration with
Clar upstream.
- Tasks:
  - Apply reviewer feedback to improve both past and upcoming conversions.
  - Contact Clar upstream if any identified features or improvements
are feasible and valuable.
  - Begin implementing any features in Clar that could aid in Git=E2=80=99s
unit test migration, if needed.
- Milestone: Develop a collaborative approach with Clar upstream,
ensuring feedback-driven improvement in conversions.

---

Week 10-11: Continued Conversions and Feature Integration
- Objective: Maintain momentum in conversions and integrate Clar
features if implemented.
- Tasks:
  - Continue converting tests based on the roadmap, focusing on
higher-priority or more complex unit tests.
  - Apply any newly implemented features in Clar to simplify or
enhance conversions.
  - Share ongoing work with mentors or peers for mid-cycle feedback.
  - Begin planning final documentation for conversions and processes.
- Milestone: Have a significant portion of unit tests converted with
any Clar-based improvements integrated.

---

Week 12: Final Documentation and Wrap-Up
- Objective: Finalize the project, prepare for final reviews, and
summarize work.
- Tasks:
  - Complete final documentation detailing the conversion process, any
issues addressed, and feedback on Clar.
  - Prepare a presentation or report summarizing key takeaways,
including potential future work.
  - Submit final patches and documentation to the Git community.
- Milestone: Wrap up the project with comprehensive documentation and
prepare for potential post-internship contributions.


## Availabilility

I am available for the duration of my internship for a total of 30
hours per week. I do not have any school activities or work
commitments during this period, allowing me to fully dedicate my time
and effort to the internship.

## Final Remark

I would like to express my deepest gratitude to everyone who has
guided and supported me throughout my contribution phase. Your
encouragement, insights, and patience have made a significant impact
on my journey. Each interaction has not only enhanced my understanding
of the project but has also inspired me to push my boundaries and
strive for excellence.

Thank you for sharing your knowledge, offering constructive feedback,
and being a constant source of motivation. I am truly fortunate to
have had such remarkable mentors and colleagues by my side during this
phase. Your dedication to fostering a collaborative and supportive
environment has made all the difference, and I look forward to
continuing this journey together, and hopefully becoming a mentor to
future applicants


Thanks

Seyi
