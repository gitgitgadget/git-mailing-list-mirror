Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EAE1755B
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720127013; cv=none; b=SLVXfZVT/kp2BJ+Dj8mDJOzlUNmo31J+MPIEIPYOMJhidWX2UDMp33FscYNUpb8tkQhQt59dKfj9xduPN/VRIFc68XIcQo+POlE3lRVes8LJ9fIaT2Ajj7klSRkTxVYK8xxktU/guvlWn+jT/MgfWyP7qlHXG4an6ykOHrvdYcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720127013; c=relaxed/simple;
	bh=Ubz0g0aNvLpSnYHTg4yCUbNPQUKem5yfuSFLPuyWCTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJq7xY2WQ/luSU/o6k7mN3Ag06gkc4SIqhzc/58fDRIXiqE3yXagG7qrfX+/RNG30Cpa+58mkPpn45IodN6IgNlK3tdEU65HQ+kPTEPS1X3nXhnALr0lg1lmEpsgHuVQrir/XvY8XGlp5/U/T1vdVOhHqU6xNKQs1ioeSflczdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzJ8Ifxz; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzJ8Ifxz"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7f5f7ecacc0so37675439f.0
        for <git@vger.kernel.org>; Thu, 04 Jul 2024 14:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720127010; x=1720731810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zexVT3WRkhWeQndIC2ma19W821ByPqfzU353x/Ab8U=;
        b=UzJ8IfxzNCgiikhpBbTc2vHHX+AKF1r7/mPx2T/Tj89btCQyzaRx7tkBkOCOpfTLCY
         MVw3pI7Ito1D3muwyvx20+U8FTHo4Uwf+V78fY+bCQHiJyMSkVFdyI6sKvT5XY3Y8Cj/
         zgtVOQH2NlMu5eOmM/D+2c7RKw9yzhUslvyK8d7So1VrRzNhDrLsf0aGMUIvkUPH+oUQ
         j/eeqZsbSROXK9hnBOuOtCfkPBSM5lmGVgylau7I3uNah90bCeRn+azGwyUOKP3yxHTK
         XtxpcGHevUx5rnfPXI/llWdTyyKLFSUADy+KIEPN5Xkx3N/HrNBJQMhS2j5HPwqXgacp
         MX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720127010; x=1720731810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zexVT3WRkhWeQndIC2ma19W821ByPqfzU353x/Ab8U=;
        b=iJuk2BYCuokEEuefEfYXIlPSoyyYsQMUIZ0yM6ojT2PNM4mxdJhk1RPwIZhUfjbZU0
         zi1MLH8a2Y7iesRQvKkoefk0doQocKmEpJIK7X40zukMw0je1HrthJ+3QZsBZe7N8+CJ
         8Yn1z7WJ+zqS3ANJRfxfa8Ys22g4CodHMlaTjWUvOHu/R4whbuGeLsAQksDjZCxsP21M
         owMY+Xl+cDqnGVqkheGI8CfgD/quTZNorLSF61Ox5lvCFrQaYWVoVUkTI87dmgLn0/c/
         QHlXALUZa/LunKiJDKisV+84ext3yC2V48bWQmZNcPYOpJgZZ9y3OiD2S0jKxRRBr89V
         1gAQ==
X-Gm-Message-State: AOJu0YwST9H0rYoekZcpQbB29Zcn5UK0JrTy32+Ryf4sNc26Qxha+4I3
	tPNQNb7DJc/NL/bb3hRWI+x2FUWj+U+7T77fWo5BKAXcNfMpQrZbZgy13rA30jao0Ea51VleQz1
	iP2kzJxbNVDOWS6vtWRYI2jPjvZBpew==
X-Google-Smtp-Source: AGHT+IErxciGm11JaU7gJbw4Rac6PKmmcOyJAkSON5HbJ561Or4B/TtOhX7NBe1md/dkIfY/bdaU5nk+uSuzvM6w+yI=
X-Received: by 2002:a6b:e206:0:b0:7f6:28ed:efe1 with SMTP id
 ca18e2360f4ac-7f66df1a6c9mr309131039f.16.1720127010145; Thu, 04 Jul 2024
 14:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SA3PR14MB6519B74CA58C9AE49DC28513E7DE2@SA3PR14MB6519.namprd14.prod.outlook.com>
In-Reply-To: <SA3PR14MB6519B74CA58C9AE49DC28513E7DE2@SA3PR14MB6519.namprd14.prod.outlook.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 4 Jul 2024 14:03:18 -0700
Message-ID: <CABPp-BGE1aDb5Nch8kQx+uZkCvbTz6sN0m2Yad=1D4=z0C9JNA@mail.gmail.com>
Subject: Re: Losing the file during rebase
To: Dmytro Ovdiienko <Dmytro.Ovdiienko@iongroup.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 7:29=E2=80=AFAM Dmytro Ovdiienko
<Dmytro.Ovdiienko@iongroup.com> wrote:
>
> Hello,
>
> I'd like to report an issue. I'm not sure if it is a bug. Git just behave=
s not in the way as I expected.
>
> $ git --version
> git version 2.34.1
>
>
> The problem is that Git  is losing the file when I do rebase. Following a=
re the steps to reproduce the issue:
>
> 1. mkdir test
> 2. cd test
> 3. git init
> 4. touch 1.cpp
> 5. git add 1.cpp
> 6. git commit -m "Added 1.cpp"
> 7. touch 2.cpp
> 8. touch 3.cpp
> 9. git add 2.cpp 3.cpp
> 10. git commit -m "Added 2.cpp and 3.cpp"
> 11. git restore --source @~1 2.cpp
> 12. git add -u
> 13. git commit -m "Delete committed 2.cpp"
> 14. git revert @
> 15. git rebase -i @~3
> 16. Now in the opened editor
>     a. move the last commit (revert commit) to the top of the commits lis=
t
>     b. squash/embed  (by typing 'f') the "Delete comitted 2.cpp" commit i=
nto the commit "Added 2.cpp and 3.cpp"
> 17. Save and exit
> 18. ls
>
> The output is : 1.cpp 3.cpp
> Expected: 1.cpp 2.cpp 3.cpp
>
>
> In case if at the step #16 you first do 16b, then close the editor, then =
start rebase again and do 16a, then all the files are on their places.

Not a bug; I think you are expecting patches & commits to commute,
when they do not.

One way to look at this, which I think you are viewing it from, is:
   * If you start with 2.cpp, then remove 2.cpp in a commit, then
restore it in another commit, then you end up with 2.cpp; it _appears_
the last two commits are just inverses and together do nothing.
And similarly,
   * If you start with no file, then add 2.cpp in a commit, then
remove it in another commit, then you end up with no file; it
_appears_ the last two commits are just inverses and do nothing.

However, if we take the last two commits above for each scenario but
give it a different starting point:
  * If you start with no file, and try to play a change to remove
2.cpp (which already doesn't exist), and then add 2.cpp, then the
first commit is a no-op that does nothing while the second adds 2.cpp.
The last two commits are clearly not inverses.
  * If you start with 2.cpp, then add a change which also tries to
create the same 2.cpp, and then remove 2.cpp, then the first commit is
a no-op that does nothing while the second removes 2.cpp.  The last
two commits are clearly not inverses.

When you tried to rebase and swap the order of commits, you took
things from one of the first scenarios to one of the last two
scenarios.
