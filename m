Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E49A92E
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743588402; cv=none; b=omUscWJW1yszUagsSNvUdUbrkHi45ZY2KdT2A+e4oIKxhZGcIA1Tt/zaJIXyqyHEpTqf07uIp8Ofg4F/knWSucI35z5Xp7PRUx/8dmoyV+W+kyWxs2CWSfZOBEXuL9AiTV/BbEJEAgT4/mAzQcRtmoFtoxzziNiQCxRvAVAvE/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743588402; c=relaxed/simple;
	bh=Vowe6EzB36JAi22jJnyW7CMg7fRGLUk6TrEk+RO1+QY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=szgakbSyxCs/sGo47JdPthcqG/iw7zq3y47UXPGytYWchOG+jvr9I7orLZPkSBtDwc2FVqI6N/ToIpDHqow6lqwU2RlPH/4/FHK8Sum6/bTKAMlZhLQiWe/q9xG8NAjwaguegdRDrC/nurTkFhqnjYAhKjhR+q8CYI7Z9ERYM3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6dmuKCN; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6dmuKCN"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so62063861fa.2
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 03:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743588399; x=1744193199; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dQZ/pAW7jmqBViZw/z1xyTGYrnR9zSuEfKVG7xmxxAs=;
        b=P6dmuKCNy0ptiVAwvDe/k30SyhvjZz9h44GzfeIhK81/sO3LcBH5scNFEKI/CSA6qs
         wHLCbsoseTtmrusyTj18OZCde9gscmTX5h1du6n2J40GJz65+OMgCpq9XDIb76vLy/2D
         PM+ih6Oo2pqnPkfatxMii88mG+FrsibpKME3FMhIL6Csm9KCDHhTxgn0HdVf0TFV/A/h
         YFTxEXsSNgejPUjkz9Bw8GzAqWmlwiH6+IbAez6iGz3OvjnRQPmSwWOUAqJZRMMP1The
         6Cc2jWVjjtkwIJwfwNhpxVE4hHc+7SdxesbmexeqgEBFAkURXOB2x3X1xrUp7co39m6T
         1W8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743588399; x=1744193199;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQZ/pAW7jmqBViZw/z1xyTGYrnR9zSuEfKVG7xmxxAs=;
        b=BN1MnX8d/7RszPkgBvBNcsu+4IjEGFjUZ48EYbMvMyxVPFGq3K04kPNaA4p1MEXrvG
         0Y7XqETQLyEWbmD3xsOwXyUf14dC1MAmHytnug9nYqfxPB1jDFhpo2vn2uGWi6cVahzI
         +KDy+EfF2EZeaXWeWN0DZHE4ulA6iEhSSZ9OqebbXO0tfI2cEbfkETOWpXzc0vE/gxvy
         yI4xvotNcZ/5ubZN56RWQvDqLDcdFYCbWbSet3AwWL8S3dK/nSBkA9PQrMA+UGDmt70d
         OJOrW9/7Gx+XzAw2ny0Kyf+/bFsHcSoNUG36z1PZRrPu69EEJQ1Jj3wIdBC8Ivc73W81
         iNgw==
X-Forwarded-Encrypted: i=1; AJvYcCVyUsupomhMXKTMYeRxVEhiPp5zpov8pIqVoURHHK+Ej/l0YKtVq43F+ec5fV+hg8Nf4nM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRzZrMHKu880JvprdgFzMKlXkMaQoECk8+5yeAfmg2uSf9OYC+
	wfuNMa+DTv0AzRZEcULbZ5BVkY93XD/quBGCV2NDzBOkF64knYc60aRHoekOexD4kyCcnHlgPFd
	z/XDw+PH+8rWQia2+a2ZHXSFiZdAnQyabJ10=
X-Gm-Gg: ASbGncuTmnZzqcfo+QpY0tGqBFt7Zr0G0oesm5q2Ae0ocJ+Ktgg30TgtJMqHcr7ACkZ
	OmHEQPDKnXcZ3f3Duukv6M7io3PU4Zi9F+9p6C1O+i+efmx5HZQEfHKRV6AaocBvpoYhJbdQDRs
	1gFAzhzCYTj/EOF24nSpe1sz2qc0uOAYSWeg==
X-Google-Smtp-Source: AGHT+IFKcdIvSwQWwhcTioOO1SWLuiVIIaRLOss78yuifKqHgsjcTqCFbFxc7yDzO9xz+F9Y32tT9eEWXL4Gy/JP4xI=
X-Received: by 2002:a2e:9ad7:0:b0:30d:e104:b592 with SMTP id
 38308e7fff4ca-30de104b653mr41196581fa.38.1743588398158; Wed, 02 Apr 2025
 03:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANM0SV2huiGtWMcP+eEkNBHoieeoXmy_fM7vAOwyoW4=FXw1pg@mail.gmail.com>
 <Z-s2p-ak-KpU6uaX@tapette.crustytoothpaste.net> <CANM0SV0Np+52vjoopvAJ88U3Ue0EF35iarwBpOozrBH9KbH2Uw@mail.gmail.com>
 <Z-xvfqCsQnDIGaXx@tapette.crustytoothpaste.net>
In-Reply-To: <Z-xvfqCsQnDIGaXx@tapette.crustytoothpaste.net>
From: Devste Devste <devstemail@gmail.com>
Date: Wed, 2 Apr 2025 12:06:26 +0200
X-Gm-Features: AQ5f1JqoEEfeeVufnuE2DxRuyshdVb_DAyPlkvvaFpyR6qs615K71k96UupYnBU
Message-ID: <CANM0SV27g_37kLfgKu8GVg13mViQ78+DRwdjSf4mGrkNdndPLg@mail.gmail.com>
Subject: Re: --reset-author does not reset author date when used in
 post-commit hook
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Devste Devste <devstemail@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>My testing demonstrates that `commit-msg` is skipped with `--no-edit
--no-verify`, but not `prepare-commit-msg`.

Looks like a separate bug though?
https://git-scm.com/docs/git-commit#Documentation/git-commit.txt-code--no-editcode
says:
>Use the selected commit message without launching an editor. For example, git commit --amend --no-edit amends a commit without changing its commit message.

Why would the prepare-commit-msg hook be called then?

>What I could recommend instead is setting a shell script or PowerShell
file or such as the default Git binary (instead of git.exe) and setting
`TZ=UTC0` in that script (possibly only if the command is `commit` or
`commit-tree`).

The IDEs only work with git.exe. If it's not there, it won't run at
all. The only thing possible is setting TZ= as a user environment
variable however that will obviously be picked up by other
applications and cause the weirdest side-effects (e.g. Slack/Electron
suddenly start using that time zone for some things but the
in-built/setting timezone for others and lots of other inconsistency
issues in tons of applications)
There's various tickets for various IDEs for this use case, not just
for git, but also for npm and various other tools (e.g. people need to
change the JAVA version for a tool or whatever)

Some time ago I opened "Config timezone to prevent chaos when
DST/changing timezone" in the git mailing list and I saw you also
replied. But if git had a way to actually set the timezone, these
workarounds wouldn't be necessary; alas that's another issue

On Wed, 2 Apr 2025 at 00:58, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-04-01 at 03:44:17, Devste Devste wrote:
> > >your call to `git commit` will still invoke the
> > `prepare-commit-msg` (and possibly `commit-msg`) hook
> >
> > Since I used --no-edit --no-verify in the example/hook, that shouldn't
> > be the case though?
>
> My testing demonstrates that `commit-msg` is skipped with `--no-edit
> --no-verify`, but not `prepare-commit-msg`.
>
> > >such as by using an alias that sets `TZ=UTC0` to commit.
> >
> > Unfortunately, (at least on Windows) most tools and IDEs don't even
> > load a bashrc file (e.g. intellij) for their git UI, so that's not an
> > option (and setting the TZ as a global environment variable has
> > unwanted side effects, since it will set the timezone in various
> > applications randomly, e.g. Electron/Slack will use the TZ for some
> > but not for other things,...)
>
> What I could recommend instead is setting a shell script or PowerShell
> file or such as the default Git binary (instead of git.exe) and setting
> `TZ=UTC0` in that script (possibly only if the command is `commit` or
> `commit-tree`).  I use Neovim with the fugitive extension, and
> it provides functionality to override the Git executable, so I suspect
> other editors will as well.  This is something that will likely be
> robust and unlikely to break.
>
> The reason I make that recommendation is that I suspect you're going to
> find that there are other infelicities or weird edge cases in what
> you're doing and this would be a use case that I could see getting
> broken accidentally.  We've accidentally broken people doing `git add`
> in `pre-commit` hooks (which we also don't recommend) in the past, for
> instance.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA
