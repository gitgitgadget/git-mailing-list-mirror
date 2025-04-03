Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B8F24EAAD
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689448; cv=none; b=oJctmNtBtbFg/2gggB1MG0OXuuCJm5w/S7b1kBt8JyE322o9qtBct07DylxvV7t4wNvCUrfdZMcwi3sglKlGI/veyV1CECnTiN05se2CV363bKTBWhfGYK7bSbrdDSlW8MU7v46lPXbKiFAXvOqQ1K9VNyEpZfpcPElKO0G73h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689448; c=relaxed/simple;
	bh=tQVKoqHrUh4IYNljglfUjgQJxjUPHggn7ArknPfsWH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AaqjjwJ8RFu7T0fUKYXtfXk2/6d01tmeamOWCLRx3sdIlbZzRJ9AlcMjKMg6g/Z7TEQKQRPv2Vyd0G5gupqiUACUOmoQUT3GY83G9Wktzih9dOWI6eB3DnHA1FmqqAGbif2GjctYbIAdG1hIOqjUvXhfQBTnIQyEfe/s9R1J/mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QX6Xl9aB; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX6Xl9aB"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47663aeff1bso8381251cf.0
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 07:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743689445; x=1744294245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQVKoqHrUh4IYNljglfUjgQJxjUPHggn7ArknPfsWH4=;
        b=QX6Xl9aBkJVZ0YW+fncKXXYSor4KK66WaJ2VBQbKXATn2rj5ThvUo4f/cXKOI9EA2K
         ja2tHpW6up6uYx6r+oojkqs4aufaq1qaw5J5w/AREugq6ep+1yC7KVVa8+goNLyeoRYg
         kdHUNjG/5ayJdTPi4PSqMGFiDtg7awfx88HoZO9/xRcRXz9Ji/w6JjWTgenxMtm5c9VQ
         1zKAucG85/zW9K6mR9JAbx7tsWVDaCQ9LHSlp/8iy5tHg+m02OCrCsombbWwXh8C28CW
         GCGh7TfgfaLwrz6qiW8hTT0R/dypU+0kgsLwO2/9aSALwLXEKe1IiX49I7b5T4XHOeix
         6gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743689445; x=1744294245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQVKoqHrUh4IYNljglfUjgQJxjUPHggn7ArknPfsWH4=;
        b=v4akohamM7OA98v2G+kGEZBLtKW/+uPTSryE6AoOhIFT3u/4akSv7L1vSvq/Fkjv6m
         Hj6aABLqOOW4FVozKRRPYOU4K1s8nH/jEObpWhSXQIPCQHqg+OH2tH2rEMr4fYhA4E8K
         Ui7mNwghNbPVSQQe4wXuSXU/ITT1mAMa+MPnd9lNxXulkopTthItQA+fvLhNvVnxBBW5
         j1cnrhCIsOe2p9XrPIhkNo3zxX23b+vXGjiTXCoabEof9GkooNooa9WXx6G0ArkiRO9L
         /Y1QgJ1gITty453ux8uTXMDREEIYsmQ+3xIhgJWHgJoCBmrxmhK0Jk1onhsRx/u8u9dJ
         0KLQ==
X-Gm-Message-State: AOJu0Yyj1bkEHu3g4Gcr3mxHIwtzpjAwcb+nosK+aYMNlsRbdzsYCbhI
	IoIz5fBfmjfJFpwCCOSJXVT5+Z0MdeSIfQQhLx/PqQ0oBBEpLBVdNPsiA9JpO65r5H9xC+fedTj
	qWihNw+IF086gV6ZW92fgkxTf/Hg=
X-Gm-Gg: ASbGncvNTfI1p42qv1p0lg69jPCnjoEkUodkQ/TOB8PJs4thpk6GXDqoyM2PMaPQ4j2
	s7FxU6ubANt5FFINo4ZsJwvFmUMI8efa49tpoX4axtKQ5tWwddZ+7H8n2byk+72q1nZR+b70886
	P5NqrRtJJyq9qQ1cYM57PtowNpBIpY2fDEcjkCQf9l0LrFLNlEETd2kWVOdTk=
X-Google-Smtp-Source: AGHT+IGGUOWFBXN66xbMSHtMkXYgKJ37Qw4UEutQ+zTBWq3+AkbVbYiuO2PSLaRpX/FL7CrIgJMqSfAmR3WrBRkepuk=
X-Received: by 2002:a05:622a:1441:b0:476:838c:b0ce with SMTP id
 d75a77b69052e-47909f76e1fmr128365261cf.13.1743689445246; Thu, 03 Apr 2025
 07:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLfxZHdns=7FwQuYS=JANrR9zDP-dOpV2AxM1hC1Lc9wiw@mail.gmail.com>
 <Z-5hlL1Gk0oi4fX2@pks.im>
In-Reply-To: <Z-5hlL1Gk0oi4fX2@pks.im>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Thu, 3 Apr 2025 19:40:33 +0530
X-Gm-Features: AQ5f1Jp7sIx3NJ2-GJ506lk4aJ6nZa3ZQ_Om8W0LsnNJ5Mxum-cpk2j4SW3fsNc
Message-ID: <CA+rGoLfCTzNTcGXG5py6oHQazeE8Vj0fLsR4KUTJ6rSRFnT_Vw@mail.gmail.com>
Subject: Re: [GSOC] [Proposal v1] Machine-Readable Repository Information
 Query Tool
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 3:53=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Mon, Mar 31, 2025 at 08:21:27PM +0530, JAYATHEERTH K wrote:
> > ## **Synopsis**
> > This project aims to develop a dedicated Git command that interfaces
> > with Git=E2=80=99s internal APIs to produce structured JSON output,
> > particularly for repository metadata. By offering a clean,
> > machine-readable format, this tool will improve automation, scripting,
> > and integration with other developer tools.
> >
> > ## **Benefits to the Community**
> > ### **1. Simplifies Automation and Scripting**
> > - Many Git commands output **human-readable text**, making automation
> > **error-prone** and **dependent on fragile parsing**.
> > - This project introduces **structured JSON output**, allowing scripts
> > and tools to consume repository metadata **directly and reliably**.
> > - No more **awkward text parsing**, `grep` hacks, or brittle `awk/sed`
> > pipelines=E2=80=94just **clean, structured data**.
> >
> > ### **2. Eliminates the Overuse of `git rev-parse`**
> > - `git rev-parse` is widely misused for extracting metadata, despite
> > being intended primarily for **parsing revisions**.
> > - Developers often **repurpose** it because there=E2=80=99s **no dedica=
ted
> > alternative** for metadata queries.
> > - This project **corrects that gap** by introducing a **purpose-built
> > command** that is **cleaner, more intuitive, and extensible**.
> >
> > ### **3. Optimizes CI/CD Pipelines**
> > - CI/CD systems currently need **multiple Git commands** and
> > associated parsing logic to fetch basic metadata:
> >
> > ```bash
> > # Example: Gathering just a few common pieces of info
> > BRANCH=3D$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "DETACHE=
D")
> > COMMIT=3D$(git rev-parse HEAD)
> > REMOTE_URL=3D$(git remote get-url origin 2>/dev/null || echo "no-origin=
")
> > # ... often requiring more commands and error handling logic.
> > ```
> > - The proposed command aims to **replace these multiple calls** with a
> > **single, efficient query** returning comprehensive, structured JSON
> > data.
> > - This **simplifies pipeline scripts**, reduces process overhead, and
> > makes CI/CD configurations **cleaner and more robust**.
>
> I already saw this in another proposal, which indicates that the project
> idea might be a bit underspecced. In any case, the goal of the project

Hey Patrick, thank you for letting me know
I actually have been working on this proposal for a while now.
I also sent an e-mail regarding this specific project right before
GSOC proposals started. As far as I can see this project was not
previously discussed therefore I picked this.

https://lore.kernel.org/git/CA+rGoLdvY+JdgdzgE04EJoF9KGUpd39+2S_AgpFyucP38m=
dFgA@mail.gmail.com/

I'm not sure how to proceed in this situation. I think I need some
advice from your side on this.

> isn't to write a single tool that is able to surface _all_ information
> for a Git repository. It's rather that we want to surface low-level
> information around the repository itself.
>
> The basic intent is to give the options listed in git-rev-list(1) under
> the section "Options for Files" a better home. We have a bunch of
> command line options there that allow us to parse environment variables,
> paths, repository formats and other low-level stuff. But these aren't
> really a good fit for git-rev-parse(1) itself because that tool was
> intended to be about parsing revisions. So this is one of those
> organically grown commands that has started to accumulate all kinds of
> unrelated options that didn't have a better home elswhere.
>

Ok that clears a lot of things.

> So the scope of the project is somewhat more limited compared to what
> you propose here. As that impacts a lot of the implementation details as
> well as the project timeline I'm not going to comment on these now.
>

I think some parts of this proposal still hold scope like the CJSON
discussion part, repository details etc, into this revised plan, but I
think I will send a revised proposal covering the changes in detail.

> > ## Detailed Project Timeline
> >
> >
> > **Phase 0: Pre-Acceptance Preparation (April 9 - May 7, 2025)**
> >
> > * **Focus:** Demonstrate continued interest and deepen understanding
> > while awaiting results.
> > * **Official GSoC Milestone:** April 8, 2025 - Proposal Deadline.
> > * **Activities:**
> > * **(April 9 - April 21):** Deep dive into Git's source code
> > structure, focusing specifically on areas identified in the proposal's
> > Technical Details:
> > * `builtin/` directory structure and command handling.
> > * `repository.h`, `refs.h`, `remote.h`, `config.c`, `strbuf.h`.
> > * How existing commands like `git status`, `git branch`, `git
> > rev-parse`, `git remote -v` access underlying data.
> > * **(April 22 - May 7):**
> > * Monitor the Git mailing list for discussions related to repository
> > information, command output formats, or JSON usage.
> > * Refine understanding of Git's testing framework as I've not done a
> > deep dive into tests(`t/test-lib.sh`). Try running and understanding
> > existing tests relevant to refs, remotes, or configuration.
> > * Review Git's contribution guidelines (`SubmittingPatches`, coding
> > style) again since most of my microproject time was related to
> > documentation.
> > * Try to start some more microprojects or actively converse in other pa=
tches.
>
> Note that microprojects are supposed to be finished before submitting
> your proposal. They are used for us mentors to figure out whether
> candidates would be a good fit or not. So ideally, you would prominently
> link to one or more of your finished microprojects in the proposal
> itself already.
>

I see you've noticed below that I've been active in a microproject. I
will move it up and make it more noticable thank you for pointing it
out!!

> > **Phase 4: Documentation, Polish & Stretch Goals (Coding Weeks 9-12:
> > July 22 - Aug 18, 2025 Approx.)**
> >
> > * **Focus:** Finalize documentation, implement error handling, address
> > feedback, attempt stretch goals if feasible.
> > * **Activities:**
> > * **(Week 9: July 22 - July 28):** Complete the first draft of the man
> > page, detailing usage, JSON schema, and options. Implement the
> > `--json-errors` functionality for structured error reporting. Add
> > tests for error cases.
> > * **(Week 10: July 29 - Aug 4):** *Begin Stretch Goals (Conditional):*
> > If core work is stable and time permits, start implementing
> > `--head-only` / `--remotes-only` flags or the basic `is_dirty` check.
> > Add tests for any implemented stretch goals.
> > * **(Week 11: Aug 5 - Aug 11):** Thorough code cleanup, address all
> > outstanding review comments on submitted patches. Ensure documentation
> > is comprehensive and accurate. Final pass on test suite coverage.
> > * **(Week 12: Aug 12 - Aug 18):** Prepare and submit final patches
> > incorporating documentation, error handling, and any completed stretch
> > goals. Final code freeze for GSoC evaluation purposes. Write blog post
> > update summarizing final phase.
>
> One thing that I also mentioned to others: instead of planning for one
> big batch of load, I would strongly recommend to plan your work in
> smaller batches. You should ideally have multiple self-contained batches
> of work that you can submit as early as possible while still bringing
> some value to the project. This ensures that you can get feedback from
> the bigger community early on.
>

Ok, so I will reshape my timeline in a way where I specify my patches
while converging them to a bigger project at the end.

> > ## Past Communication and Microproject
> > * **Blog**: [Blog](https://jayatheerthkulkarni.github.io/gsoc_blog/inde=
x.html)
> > This blog contains a detailed communication description and blog of my
> > microproject experience.
> > * First Introduction to the Git Mailing list: [first
> > Mail](https://lore.kernel.org/git/CA+rGoLc69R8qgbkYQiKoc2uweDwD10mxZXYF=
SY8xFs5eKSRVkA@mail.gmail.com/t/#u)
> > * First patch to the git mailing list: [First
> > Patch](https://lore.kernel.org/git/20250312081534.75536-1-jayatheerthku=
lkarni2005@gmail.com/t/#u)
> > * Most recent series of patches and back and forth with feedbacks:
> > [Main mail thread](https://lore.kernel.org/git/xmqqa59evffd.fsf@gitster=
.g/T/#t)
> >
> > I've been maintaing the blog and will maintain the blogs of all the
> > communication of mine to the git mailing list.
>
> ah, you do have a microproject. As this is part of the prerequisites I
> would like to propose to have this more prominently visible.
>
> Thanks!
>

Thanks again this helps a lot.

> Patrick

Thank you,
Jay
