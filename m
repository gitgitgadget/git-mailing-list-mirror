Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B0F303C8A
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105770; cv=none; b=tlLRiqpFokKQ+s70VbW80YB+0tq6hITEunBXxa/x68XEUgLx+YDFIpt19LUoqZp55HxdWr2CIJF26Wt3uYG8AMf9smvpL0Ri+AoR7ChG6OQnkiQgf7u1HTUyo+RWqO4eiZsQ6G/a12ZZQZ8/UOXfjNW9j2DzL8v1Vqr9QOtATD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105770; c=relaxed/simple;
	bh=9FXm2+kMROzx+N868IFjI3co44f/61F0fm6UJAyG0Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJSEfv+aLY5Y9h/WonNyH3RPL7ePVMhye92iDFPlRlJxhajGSGO0kZ/D2p5a0UJcr8rb3zSnqu6GPO8iUFx1PjRNXZYHIH4C/c5gCNCXaujuXiIcf6IZGo4Jc6R4HWfpX++lLtdKJK4HuzDJgj7rnk+5AA31NudaFeyJoLLqVP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mjhvn/aP; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mjhvn/aP"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7a3a085so12322966b.2
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 10:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755105767; x=1755710567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkRHStzuIbDMKyr7wZxWphNJ+JIhls64eoscP5WdUlg=;
        b=Mjhvn/aP9O5zxfWuWW1dyye1E2y2mqOFdvGl6xfJHG6gDoBbh5zagIva4S3z9/exUg
         FwzqO7uDuH54vGonlkTH/G4d53O3f6TwjThlpmm+UbtHFTTCGzKJe1zC/zFba0QoDfJt
         3iukI5tRN69Q/EEdqb32tx9n2SwKg2z/+YiCndYqdcSjSxa6koWI4gjmOnNBKVkUetAN
         u7gASl4tHxorDVy6+9k7GHQ3VDKy+6weD/0LMeYS93gJlq8accnT6qfKH6r1Fzbf17F7
         Mjow9GsJK9FCdtsjKJD982IAWSrYWj8PlY6yN9b2JhrYkfNFaU+VXsssJfk+ZPBmBvu4
         D5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755105767; x=1755710567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkRHStzuIbDMKyr7wZxWphNJ+JIhls64eoscP5WdUlg=;
        b=HROL5XYekMgDQ0HkmF2bmrQwH0LWcWWTL01PSTzTx1rFmfMma4RZrCvcH7SXSf9ypq
         QqIqn08iAO6ZgxdbA83gT7EMOjLxrz/V939EuK+T0jA5CAr7vcKScizUrtdR+BhDoDA6
         N3saU5wJynVaCjJC/eFZgbVa6Joq8omBb3L361A9uUy2YxA+B5bjuzMCg9liynr7ypte
         oIN47sZB3i8hOv1eSsxe3hQp0qP48ZQUaDanm6bYSPDgtA/xgsp3Gzo4a4KakFVrt6rg
         0GSpCnVht4Utm5wXojHvdQn+9yOxZY7V3O1Gw6/rPZR6ZFkaAvJ2oRekBSgvCDaTyVsU
         /arg==
X-Forwarded-Encrypted: i=1; AJvYcCWgQ58en859eZ+jfSzimCj9sdXZtgND8wjW+w004P1OeGeZ3BjnWzszgJ8pjDNFRB/fCZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVkNyJyxr9FWZLdHVoYu+jfVQFKz1l9oMfVwez3gKdeF+mv20K
	mDMAuiETYriStxDGvQYPGpYs+co1CfZIzwe0jAOuAWmlFBHumslYqEquCarEwM+ZxQhP7+aP2bx
	lfvlzNXp96nMDyJXZr7CkwGRy2vSRHrGMsjOHUy8=
X-Gm-Gg: ASbGncvm8sfTLUoHNhc3tB3xilNikykK4pnZiiuSqUproC+LxJXisfsc8oBfF/FPflO
	3I4EYW1kqrEjCFqHBmjIgJHD76I19yy/Aw0BkaM5IswgHHzOKXjlhJSRj49YeMOA84jc1FKqQvs
	ochhVAr3aiqKUjdjK98L0w9OMoy2oDEUWpUbD+3h+kRaXXiYA768JGzKDBX2IXi05fhgxKotmEk
	zOshqqkaM95uC1OZ02t+5Q3sOTrPy39fAFbb3BiFQ==
X-Google-Smtp-Source: AGHT+IGkgunGjPedNJxeqhgeaRWF71SqAtzTrTwFEXraosbrpJ9HZ46oX8WCVP6LhoPRYVAfua7cy8hkMVBhF1y0u3g=
X-Received: by 2002:a17:907:940c:b0:ae3:7058:7b48 with SMTP id
 a640c23a62f3a-afcb97d430fmr1273166b.25.1755105766303; Wed, 13 Aug 2025
 10:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
 <310d2c1d8f7f68ae52ddd29f0ccb0a0364aba1a2.1755029249.git.gitgitgadget@gmail.com>
 <xmqqbjoks19f.fsf@gitster.g> <152d47a3-7744-476a-8ab8-43b7b52b67ea@app.fastmail.com>
In-Reply-To: <152d47a3-7744-476a-8ab8-43b7b52b67ea@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 13 Aug 2025 13:22:34 -0400
X-Gm-Features: Ac12FXwUcwZzYM7OSDRe2UgTO-SpiXHAJehcflybjoDG--35vIb9NdmT4nw98oQ
Message-ID: <CALnO6CCjW=W4A7d4se8fCe7gzuDLc-SyGv7JbVqbtSSkSM1bNg@mail.gmail.com>
Subject: Re: [PATCH 2/5] doc: git-add: start man page with an example
To: Julia Evans <julia@jvns.ca>
Cc: Junio C Hamano <gitster@pobox.com>, Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 5:40=E2=80=AFPM Julia Evans <julia@jvns.ca> wrote:
>
> > But isn't it the source of the most end-user confusion that they
> > cannot wean themselves off of the diff/patch worldview?
>
> To me it feels very contextual! My impression is that what's important fo=
r Git
> users is to be able to think about commits as diffs in some contexts, and=
 as
> snapshots in other contexts. For example with `git rebase` I'm usually th=
inking
> of my commits as diffs, but it's very helpful to me to think of a merge c=
ommit
> as a snapshot, because the merge commit does not have to be a "combinatio=
n" of
> the two sides of the merge, it can have arbitrary extra content.
>
[snip]
>
> >> +By default, `git commit` only commits changes that you've added to th=
e
> >> +index. For example, if you've edited `file.c` and want to commit your
> >> +changes, you can run:
> >> +
> >> +   git add file.c
> >> +   git commit
> >
> > What happens when you did "edit && add && edit && add"?  It commits
> > the two changes you added to the index?  I do not think it is
> > productive to hide the fact that you are preparing a snapshot of the
> > "next commit" in the index (or "staging the contents for the next
> > commit in the staging area") with various forms "git add", including
> > "git add -p".
>
> It could! It's easy for me to imagine a world where the index
> stores an ordered list of diffs, which are applied as patches in
> series when I commit. I guess you'd need some sort of
> patch + patch + patch + diff workflow to generate the final diff,
> but to me that doesn't feel so different from what Git is actually doing =
in
> practice.
>
> In any case, I'll think more about whether I think this is really
> an accurate description. I'm always especially interested in the practica=
l
> consequences of having misconceptions about Git: for example (and maybe I=
'm
> convincing myself to change my position here!) with `git mv` I think it c=
an
> become relevant pretty quickly that commits are snapshots, because if
> you move a file and edit it then Git can't always accurately guess that y=
ou
> intended to "move" the file rather than delete the file and create a new =
one.
>
> I'd like to be able to have a similarly practical example of why it's imp=
ortant
> to think of commits as snapshots in the context of `git add` but I haven'=
t quite
> found the right one yet. I've noticed that people will often sort of "rej=
ect"
> information that does not fit their mental models, and I think "commits a=
re
> snapshots, this is important in this context because of
> <specific practical consequence>" is much more convincing than just
> "commits are snapshots".

Less a comment on this patch or diff ;) and more a meta-note: I happen
to have several links saved on the idea of "Snapshot vs. Patch" aka
"commit duality", so I figured I'd share. They reinforce to me, at
least, that the contextual mode of thinking is useful in practice,
even if the snapshot model is the (semantic) storage model [*].
Knowing about snapshots does make it far easier to interact with
objects directly, which also frequently helps me better understand how
to use particular commands.

- https://www.thirtythreeforty.net/posts/2020/01/the-wave-particle-duality-=
of-git-commits/
- https://roadrunnertwice.dreamwidth.org/596185.html (which references
Julia's work)
- of course, https://jvns.ca/blog/2024/01/05/do-we-think-of-git-commits-as-=
diffs--snapshots--or-histories/
;)
- https://stackoverflow.com/q/40617288/4400820,
https://stackoverflow.com/q/73646342/4400820,
https://stackoverflow.com/a/27760319/4400820
- https://github.blog/open-source/git/commits-are-snapshots-not-diffs/
- https://lore.kernel.org/git/alpine.LFD.0.98.0705090856220.4062@woody.linu=
x-foundation.org/

What I find is that, while we keep trying to reinforce the snapshot
mentality, there are situations where thinking in diffs is a
reasonable approximation. In the particular case of git-add, most
interactions I observe with the index are diff-based (git diff, git
diff --cached, etc.), but I'm not sure how to usefully clarify the
relationship between those things and the underlying trees involved
(working tree, HEAD, index :0:) in a manual section targeted primarily
at newcomers.

[*]: "Semantic" because deltas in packfiles muddy the _actual_ storage
model somewhat :)

--=20
D. Ben Knoble
