Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BD11885B3
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734035038; cv=none; b=E1rAh7Rtcx/CCMpbVM4/WhG4ycIqjnoCL+o/AWWSW6ADor08I1iHvlCSMBpvdFWQSdc4+/MCD4uSZGGU/WTh41HuReZ6x31RmmNIEC/rWo0M52OPf6rn2pNnZoCrq1AHwyTQVL/+syUEXDpPYbLvfMHY9HSzA+jrJ3fiuFjwerU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734035038; c=relaxed/simple;
	bh=pYWezhCPe290YWPut3ayraILcK9UJjxRnND3+XS+kGw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KxoMg0/LJ867GnGt0Eq1yfEajkj1WlAiD3q6830/IT35lU10AClj06WsueQXz5ljrVZW7GjXnIYyQg1tYp5wITjbIZxaCdYfyHgMAZoDTvOiUW24gMNNYn/lMti3cvG6/jBb8AVuQtHYpHknjF/bpHsadTznAS8DfIYuvJ8EhWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ak8vuCzI; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak8vuCzI"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725b4f6332bso90622b3a.0
        for <git@vger.kernel.org>; Thu, 12 Dec 2024 12:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734035035; x=1734639835; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TIR1bVcQdhZXhTBmowUNWfVgU7h4f/kO4RAm1MjOD1o=;
        b=Ak8vuCzI9ZyHFVMVXWJDVSsAmGDWGDgyLhxTnpmzGnE5XCzFpKq7tbcc+h4C6rr3yT
         9VWX+w3joX6drDQIVtJkONIw6b+ohgEw8Otb0HfbrXpgWRroW8y8C9UwPwHwMyc+ePe6
         7oLlgmzTqncMc/oBHizpvKl8JMzR6KeZKq5AtsQC9of20DaKzdhWkOBCM0BWAYxUJZAE
         DiLqaW5Nxle5sT0h9RlHhl8Z8gxyWEZmpR9477oCb54wrE4dY9VXj98U5KeI42kyOe9K
         tNAPpH0cnIjXnvC1a1/qhzvwEostpCPBzv/bJJgFK0hvwgZkDMwYptpV7TFcWhqOxZJH
         Mhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734035035; x=1734639835;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIR1bVcQdhZXhTBmowUNWfVgU7h4f/kO4RAm1MjOD1o=;
        b=oz5cNn/jZdeNqJTlHZpIvwMQombV34j8Gc5PaelTB/YfF+9L9aaF+7Nrd7kNEsZzbj
         xQokHaOLkYszRZ3zJSfoHHwZpSTWrQYbecpzi+z0FJNj52ft27U17wCY0XY6yIT1HgCl
         UfkC82+4XimUif2MYOqCce+IY1abGmeXNz3Xg9mayrB+iJCznyPTTC2iYke1+RI7twyP
         X9K90QTszYow/Qcbh+MWt0ZB2lZu+/aetF9SU6FG0rIO+ABk2OJ5mNzYJXcF1z/BngK6
         lQ0Y245vSkekM+FFI5vLgbEQ1SV0OQPJcQGa77BnTParvzbkZH973Ew/DE60fn0XSNDS
         ie9g==
X-Gm-Message-State: AOJu0YzOOe4kLnFlGfLXJ1Za1tFgajfO6XeT/BM9+q25Cy1OYrlj3x5O
	ATMc+/Y81SBaQEx3A+sGmq8sigoa3JwCA6RzmZGpRlzjbL1NLm+TZM2dhQjhUO84vQzgTFj9J69
	QFALvhdUdgUMPDKgUkG3Dwx4kTH/W3K0U
X-Gm-Gg: ASbGncuvXpV/h1UQysQKasc4N1Zz2UxA0g+bYXcMTYCZ/QfQGAYpd5FQlTs+NsHBN3+
	BkIAeMeV5GE6D1W/eJNgfrJ292PfneZ1M62qYsT6nNRQXfFKDqkacC+X7v0bXQqiCIl0=
X-Google-Smtp-Source: AGHT+IEqfoOXT62zswGGYBC1dnMlIZ9XvpQl/ibpv67PnQgas5Wz76sALj9A6rLO27OyPRDj6y28lMTuMBKOapStChI=
X-Received: by 2002:a05:6a21:7890:b0:1d9:9de1:b2e7 with SMTP id
 adf61e73a8af0-1e1dabd136bmr1005814637.7.1734035035525; Thu, 12 Dec 2024
 12:23:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Brendan Jackman <bhenryj0117@gmail.com>
Date: Thu, 12 Dec 2024 21:23:44 +0100
Message-ID: <CAJUwWUMQF_tN_hyBMh+F4NtAHVAx1z+g0HYY=PD9-jd5RdcR9g@mail.gmail.com>
Subject: failed to read .git/worktrees/test-worktree-xdrphX/commondir: Success
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am developing a tool that uses Git via its CLI. The tool creates a
bunch of worktrees on startup and tears them down on shutdown.

When running its tests, it does this a lot. Sometimes, the git
worktree add command fails with exit code 128. The output just looks
like:

failed to read .git/worktrees/test-worktree-xdrphX/commondir: Success

Naturally, whenever I try to strace anything, the bug stops
reproducing. But, I have tried manually adding logging to my
application to see the Git commands it's running.

The test harness sets up a fresh repo and puts some commits in it,
then runs multiple instances of the application (on the same repo).
The one that fails seems to only be running these two commands:

["-c", "color.ui=false", "log", "-n1", "--format=%H %T", "HEAD"]
["-c", "color.ui=false", "worktree", "add",
"/tmp/limmat-child3qE96Q/worktrees/test-worktree-sGVqA8", "HEAD"]

And that second command fails with the error above.

Any idea what's going wrong here? Is what I'm doing (i.e. creating
worktrees in parallel) actually legit? Anything I can do to help
narrow down the issue?

.:: Details

I've built git from next on Ubuntu 24.04.1 LTS, here's the git
bugreport output:
https://gist.github.com/bjackman/3377add9e8d7b747d9f74b52518e9101/edit

But, I also experienced this issue with the Ubuntu packaged version of Git.

The application with the hacks to add logging of Git commands is here:
https://github.com/bjackman/limmat/tree/git-bug

Here's an example of the test failing in CI:
https://github.com/bjackman/limmat/actions/runs/12303338582/job/34338222752#step:5:337

If you're willing to try and reproduce locally, in theory it should be
enough to put your Git build in $PATH, clone my repo, install Cargo
(https://doc.rust-lang.org/cargo/getting-started/installation.html),
and then from the base of my repo run  `cargo test race` in a loop, in
my case it usually fails relatively quickly.

Many thanks,
Brendan
