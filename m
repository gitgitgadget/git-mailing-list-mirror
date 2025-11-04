Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD55A230BD5
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264001; cv=none; b=EoQU+uXHWx2oHMMI4XgE9v+lu4eKsZyg/Z6xlqODJVv8eLU+rfsu8y0PVflPVaB7pxt6GAOzbtwuU59aB8o6XLyqWDFyQaZrtPqIC9REyicz6uieOCFQpUPYWgysLIrEJzJwH4BkM1e9w/slmVaxRIrCxJqQxjte4zEpVCnaSF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264001; c=relaxed/simple;
	bh=491pS95JfOQ7bzhnlaFK19r9ITxlpsFqgufYc5NS718=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FT7r9lv3b4uOLNbtAQeSOVc0UgbL7JQEHMLdwsCLycy6YRxm7KM52m+3QUsAtXR4DBppSHLf5q6DTXGkOxNfrSWfcCpoFOvwD74HQSvxU15YEasHNJK+RUxdD9IdhYu0AmWNHmyt+3NIZaobEKRqa3v4r/a8857ODFEs3zU72Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwhR6vjH; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwhR6vjH"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63f74b43db8so5693245d50.3
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 05:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762263999; x=1762868799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=491pS95JfOQ7bzhnlaFK19r9ITxlpsFqgufYc5NS718=;
        b=bwhR6vjH/fyLhikH5wIlWNeMvB4+8kShDqaFooWSqXwbbZAqmw0Ow9S+MLk17esWwp
         cPDRDByhCfZqOfM+bVUI4ldKkG/8BnZVRe4TgZHJakA2yi8I1tUXDF7Bn9x5uAjpSfwJ
         72/SFHu0dSDo3N9Suybl9CdH5ovKiV8e11BTKNq+LmOKa0nXGrDtHeD5CuKNWg+HZZd5
         +v4RB6klknR2aaNaawZ+uKopT6lByOwOz25yHszHGJB7hl7WZMw3QZV6kC2Wtq8CYiB3
         ssHGd5jmFbnOEJDIuC27NMw6TK5X8HiD0K8zXs/2ruSrMDnOlpbaKqfaCPRE6TALjd1z
         2O2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263999; x=1762868799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=491pS95JfOQ7bzhnlaFK19r9ITxlpsFqgufYc5NS718=;
        b=qRpjDdAah67DLlOC2g3dJ+D7tfSn57zjDkrgAWC+9fuHGp6cP31osIwnszsApvzrxy
         mC0ZqMiSTUeW1SisBgHBUA3YMxejKbZOmc89rw+jMyCBhjvgvJGs71xmVzC4aDXuQ2W0
         7BSLaiq4QF70RsAhPJEwZ/wNkPs6Jj3A6nSZTOEf++BIjMV7PQwz+BzHPxJ87NX7y19V
         61KsiUGALHLOdkMLrMwcCpvHe+PhBnZXPNcr4Et9ZSmKnOzg94uk/qt0DXum5sHVRg4P
         Lt7z7TSBYQxGC6rV6a5qcb6OLs+00n3iYeh49NM4RRyzP/+daNFyWnbmbyodvBXT7jUu
         mhEQ==
X-Gm-Message-State: AOJu0YyDtcASDTNwEBZKhyUQ4+6RZTrJw9tcaMHrdSWckKs8zw3pmzSp
	VYfi6sgvc5+ve/ibiY8/MxsMNVSPxzl7/2f8NfMijAldjDVzWSOo4iHxUqXy0DZsr8nZJblqLJZ
	J1uQiYZF2u9LmcQeQCs4KqC3CtEoNchheXRuzhbA=
X-Gm-Gg: ASbGncvqk2Sh70goNKREXlmKb59XvYAcQ3onS6d6wHI/mykf+MoP6MIueuAgHxZDKr1
	iiZ8lHmFzJ7gA+rmmB3pedA8iqbjM2hbqbuTyjoN1pxvRgWT2pgQkU1aFO+GHII/91p2lIBfHvv
	oWlku9BRTlSvMw0Qw+jaMgXcdqc7xkm58go8N/CylcDItfir00opnwpiAyk6M3PpBDAX9+fzRWA
	o0TU647rDi1yjS62qozwkC/Rhz6AmDl52DDQ6lbHrk30BnTGadZa8vOBNTHUj/6Fg==
X-Google-Smtp-Source: AGHT+IFWve6jk4mafMJsnFw67enw/vIk6U52S+jX5MLVN6MEKnvAQtlVXKfLj/5iCV50YgNwYWYrI9B0yju5XfS2IJM=
X-Received: by 2002:a53:ac8b:0:b0:63f:ad02:8d8 with SMTP id
 956f58d0204a3-63fad0209e1mr7125515d50.31.1762263998639; Tue, 04 Nov 2025
 05:46:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Queen Ediri Jessa <qjessa662@gmail.com>
Date: Tue, 4 Nov 2025 14:46:26 +0100
X-Gm-Features: AWmQ_bl_IrbrMbzLRYky1meFEgKCzIX-JjUYUEYIXVVxqvRp9mzONz5W0vGsXjw
Message-ID: <CA+JX8FoKKB8LrCbPgXgiqSLvtpk=HBsxCcZAW2M_Y1-Of48Y+Q@mail.gmail.com>
Subject: Outreachy Proposal: Refactor Git to reduce global state
To: git@vger.kernel.org
Cc: christian.couder@gmail.com, usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello mentors,

I=E2=80=99m submitting my Outreachy internship proposal for the project
=E2=80=9CRefactor Git to reduce global state.=E2=80=9D This proposal outlin=
es my plan
for the 12-week internship, including my understanding of the project
goals, proposed approach, and weekly milestones. I=E2=80=99d appreciate you=
r
feedback and approval so I can begin preparations accordingly.


Project Title:
Refactor Git to Reduce Global State

Overview
The goal of this project is to identify and refactor areas of Git=E2=80=99s
codebase that rely heavily on global variables, converting them to
localized or function-specific scopes where possible. Reducing Git=E2=80=99=
s
global state improves code modularity, enhances testability, and
reduces side effects across different modules.


Objectives
- Study the current usage of global variables within Git=E2=80=99s codebase=
.
- Identify opportunities to move global variables to local or function scop=
es.
- Implement refactoring strategies in small, reviewable patches.
- Submit, discuss, and iterate on patches through the Git mailing list.
- Improve maintainability and test coverage of affected modules.


12-Weeks Work Plan

Week 1 =E2=80=93 2:
=E2=80=A2 Study the codebase and related documentation.
=E2=80=A2 Review previous contributions related to global variable refactor=
ing.
=E2=80=A2 Understand how recent global-to-local transitions were implemente=
d.

Week 3 =E2=80=93 4:
=E2=80=A2 Identify specific global variables that can be localized.
=E2=80=A2 Map their dependencies and understand potential side effects.
=E2=80=A2 Draft a clear plan for refactoring each variable.

Week 5 =E2=80=93 6:
=E2=80=A2 Begin implementing small refactors, moving selected global variab=
les
to local scope.
=E2=80=A2 Test and verify correctness through existing Git test suites.
=E2=80=A2 Prepare initial patches for submission.

Week 7 =E2=80=93 8:
=E2=80=A2 Submit patches to the mailing list for review.
=E2=80=A2 Gather mentor and community feedback.
=E2=80=A2 Address review comments and refine changes.

Week 9 =E2=80=93 10:
=E2=80=A2 Continue refactoring additional variables or modules as agreed wi=
th mentors.
=E2=80=A2 Update documentation if necessary to reflect internal changes.
=E2=80=A2 Maintain consistent communication on progress.

Week 11 =E2=80=93 12:
=E2=80=A2 Finalize pending patches and ensure smooth integration.
=E2=80=A2 Conduct a review of refactored modules to confirm expected behavi=
or.
=E2=80=A2 Document key learnings and results.
=E2=80=A2 Prepare a final summary report and presentation

Expected Outcomes
By the end of this internship, Git will have reduced dependency on
global variables, resulting in cleaner, more modular, and maintainable
code. The project will also provide a clearer path for future
contributors to continue reducing global state across the codebase.


Thank you for reviewing my proposal. I'm looking forward to hearing
your feedback and guidance.

Best regards,
Queen Ediri Jessa
Email: qjessa662@gmail.com
GitHub: [https://github.com/QueenJcloud](https://github.com/QueenJcloud)
