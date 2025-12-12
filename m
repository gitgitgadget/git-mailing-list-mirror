Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B951F584C
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 21:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765575976; cv=none; b=DkjcpeJZw5H++bjcUE83YGuQjxOthrhE7o1+JVT80emnkZNCyYPoJC6ox0KxzvX3Ur0ljf0MCwo1UpF3ODvjih9BrBgTd+yLQ8QDsTJY/GF128bXDhHf2nfKfI+F9qdmeFG0d76C8eeAPx6AVyvtRFrhWFQ1eXXAyBqMe+ZvUqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765575976; c=relaxed/simple;
	bh=KjA8y3Nx//pL3CqxAGKgtDJqMQGjDl2aXCSspodz/rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjUwGKwLy04VihHG1zj31VrumGrTsMNu57R+47qgDEixvs7lUz38fRUjmRahoSeqNAg1c1V+9+46laWWjNtKM3hU8AxTmTCsgrt6O6jY6Q3ajYrt+qStywrQiysEeQrqRBdJr+Yj0CXgcfRdYdkMj9sF/SpGrOTx16c4XCl0p+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLmJx4PW; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLmJx4PW"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-343ea89896eso1692707a91.2
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 13:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765575973; x=1766180773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r53hknNTo3mjQ5+P+vEivzfiftLhEFiHwmMicKdXa64=;
        b=lLmJx4PWYHiwI9pvDQ1AyfCNNcpX3CgKw49DuutQnATeyVR5Gin40BHe15LyRSpkN5
         +BUNAsvEYP9KRH4/juWPjpcpUs5xXJDij6SrBcbc219Z/sp109Zgbg4TR7CjMk5h8YTS
         rps5ngD8qdP/lJES/qEAjsQl6M3pmfbTa02KMLrth5ZRg4BSoZyQkQ+U62pIthF4Fior
         VDZ5d5f1N5aWvkKU2KsdO0ejrWO3PDAAfYpOp7uEdYMtj/nhzwuWGnfsTm5tLakLH8sb
         yvFLW8iKJCuDj+rcNBVDmtISEdjv+qHHIddCGpTqxA5nUgGULVWpSl0+XfaJyEPrJFG9
         YL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765575973; x=1766180773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r53hknNTo3mjQ5+P+vEivzfiftLhEFiHwmMicKdXa64=;
        b=HZi0zriA9ybXKfbXeMISatmCYCjTY5tWWu/WkkS2PlQvxR9lOxlvQ82mlAGutkXTFF
         5l1982bfG/IOTluADtpEFIMhVWFJqQq9H/IEgsqi70qOGwoLbrdilxiYvLM6Duwd6Thb
         7gGxjNwufKBHl8bFDUblFNo8zbl3PgRGV8pUHXiECIsvwc66JH98ccJn2tr+bmm+soz9
         ToMyMZSbC/deyAqxDjel03X40+Z09fopwbGbYfq+xI7HLkteiw7gkNCmyILM/QA+dop6
         IvWpfKIJmYyvlQyPJbQDyh1OgA6w0oKeasQijT03yEhGvqtjBD1tpQ0bVsk0NM0pZFs0
         Vp1w==
X-Gm-Message-State: AOJu0Yw8E0QAUFiYVAwLdph1FS3dBLyRwWXQ+gYqGuMKipmpK+TgBjQI
	l6bhpGD/qFFZv/rmBHAikeE4vXdij4LtX1nv3kauS7VRnjrmDIIMXEWhFD00zHZyAvjWh1ftO6h
	N/uKqnlRyXpYHEixzx1MImyMkyzzELi9KVr2V
X-Gm-Gg: AY/fxX7r9NwqnL2Cl+/7l7X7qIRQLkyGlPP9GYAPw7O3oMn1XHE3rXkAXAHv13L0LJe
	0U1aWjkXVEO7toIrNYdFvAUGvnSMsPddHmyl8DeK7uMsfWUiHmyODwUFkyxTKVXuUJj4iBQwMgV
	kIzhmAyJ4CFnE6fT0wAmAQK5kH1pEIKnovx2sW3OHFThylnHIjz/oyyr79h+R5fz8JaCnM9lnJi
	Qqxnpu8/xktLeStDq7S9uW7zX3Lx5Y/7SApTuDqKAAinPt1cl4IWXhwAxYYbhyjDwdLTfbisWia
	A8c1Y5s=
X-Google-Smtp-Source: AGHT+IEFckvsd3S30l/dQyEHU8AA+SsBjp+wbZsuP0riW5hn3JYjTsvwHa9uKGOaFLcjyRlnGqk4lIa5H6VQCZdJFPE=
X-Received: by 2002:a17:90b:4f41:b0:340:9d52:44c1 with SMTP id
 98e67ed59e1d1-34abd78fabbmr3063525a91.35.1765575973325; Fri, 12 Dec 2025
 13:46:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DS0PR03MB729012244C8A65D318FDC205A3A3A@DS0PR03MB7290.namprd03.prod.outlook.com>
In-Reply-To: <DS0PR03MB729012244C8A65D318FDC205A3A3A@DS0PR03MB7290.namprd03.prod.outlook.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 12 Dec 2025 16:46:02 -0500
X-Gm-Features: AQt7F2p6K20AgUXwaFiubKUVO45ACHZj4UsoLtPyfQD8mSW3kCIlkTSvmOOgPGg
Message-ID: <CALnO6CDB8aHZ96emgX43GOVAzZxz_7-ZkOqhasob=zf+Hot0fw@mail.gmail.com>
Subject: Re: UX failure: SSH authentication failure diagnostics
To: Ryan Johnson <ryan.johnson.code@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 12:08=E2=80=AFAM Ryan Johnson
<ryan.johnson.code@gmail.com> wrote:
>
> When Git fails SSH authentication, the error message provides no indicati=
on
> that Git may be using a different SSH client than the user expects.
>
> PROBLEM
>
> Multiple SSH implementations commonly coexist on a single system:
>
>   Windows:
>     - Windows OpenSSH: C:\Windows\System32\OpenSSH\ssh.exe
>     - Git's bundled SSH: C:\Program Files\Git\usr\bin\ssh.exe
>
>   macOS:
>     - System SSH: /usr/bin/ssh
>     - Homebrew SSH: /opt/homebrew/bin/ssh
>
>   Linux:
>     - System SSH: /usr/bin/ssh
>     - Snap/Flatpak-packaged Git may bundle its own SSH
>     - Alternative installations: /usr/local/bin/ssh
>
> These may use separate key stores and agents. On Windows, the system
> ssh-agent service is inaccessible to Git's bundled MSYS2 SSH.
>
> A user who runs:
>
>   ssh -T git@github.com    # Works - uses one SSH binary
>   git push                 # Fails - uses different SSH binary
>
> receives only:
>
>   git@github.com: Permission denied (publickey).
>   fatal: Could not read from remote repository.
>
> This error gives no indication that Git is using a different SSH binary t=
han
> the one the user just tested. The user has no reason to suspect this is t=
he
> cause. Debugging this issue typically costs hours of research.

I'm a bit confused on how this could be the case, but my knowledge
here is admittedly murky: Git looks for SSH in the following places

- the value of GIT_SSH_COMMAND in the environment
- the value configured for core.sshcommand
- the value of GIT_SSH in the environment (historical compatibility,
according to source comments)
- finally, it uses the command "ssh" (which I assume is looked up in PATH)

Granted, Git does a little bit of PATH manipulation to find its own
binaries, so is this the culprit? That might explain why the issue
appears on Windows (bundled MSYS2 SSH)?

>
> SOLUTION
>
> When SSH authentication fails, Git should:
>
> 1. Print which SSH command it invoked:
>
>      Using SSH: /opt/homebrew/bin/ssh
>
> 2. Detect if multiple ssh binaries exist in PATH or common locations. If =
so:
>
>      Note: Multiple SSH clients detected on this system.
>      Git is using: C:\Program Files\Git\usr\bin\ssh.exe
>      Also found:   C:\Windows\System32\OpenSSH\ssh.exe
>
>      To use a different SSH client:
>        git config --global core.sshCommand "/path/to/preferred/ssh"
>
> This diagnostic should only appear on authentication failure, not on succ=
ess.

I think a simpler thing to do might be to make GIT_TRACE2* output
lookup the pah for the command that's being run and log it, since I
can see (using either GIT_TRACE2 or GIT_TRACE2_EVENT) the invocations
of ssh for e.g. git-fetch. They just appear as "ssh" for me, although
at the time of the trace events we don't know (at least on *nix)
whether we're going to exec the program directly or fall back to
executing it through the shell.

While poking at the exec calls, I saw we also have locate_in_PATH
(non-Windows!), so perhaps we could also use that here. And we could
add advice of the kind you mentioned (although I'm not sure it makes
sense to search the system for other ssh implementations?), though it
might not be the case that the solution to a failed SSH attempt is the
client (it could be something else).

Stepping back a moment: I realized you wrote "When SSH authentication
fails"---I'm not sure if Git sees that. I suspect it only sees that
SSH failed ("could not read from remote"). And authentication could
fail for any number of reasons. Hm. What to do?

> RATIONALE
>
> Git for Windows bundles MSYS2 tools for cross-platform consistency. Homeb=
rew
> and Snap/Flatpak may install SSH binaries that shadow or conflict with sy=
stem
> SSH. These are reasonable packaging decisions, but the resulting SSH clie=
nt
> mismatch is a known, common failure mode that produces no actionable
> diagnostic information.
>
> The fix is a one-line config change. The problem is that users have no wa=
y
> to discover this without external research. Surfacing this information at
> the point of failure would eliminate significant friction for beginners
> as well as veterans. Seasoned programmers and beginners alike complain ab=
out
> UX failures like this one all the time. Considering your tool has become =
de-facto
> standard, you should take care of these problems. Dealing with this probl=
em
>  is the responsibility of the tooling creators, not the users. Do not shu=
nt
> responsibility onto every user to sit and spend an entire day of research=
 and
> headache unraveling your poorly-communicated configuration nuances.
>
> --
> Ryan

I can't speak for anyone else, but I find the statements at the end
unhelpful to a fruitful collaboration for improvement. "Your tool",
"you should", (paraphrasing) it's your problem, not mine=E2=80=A6 how are w=
e
to collaborate in such an atmosphere? (This kind of thing is where
that trite "we don't owe you anything" comes from [1].) In a
charitable reading, I'd just skip the last few sentences. It sounds
like you've found a problem in documentation, or maybe in the way
certain errors are presented. Great! Help us improve that for the next
person, or maybe write down what you found and share it widely so
others won't spend as much time researching the problem as you did.

[1]: https://mikemcquaid.com/open-source-maintainers-owe-you-nothing/

--=20
D. Ben Knoble
