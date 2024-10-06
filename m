Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621AB163A9B
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728208659; cv=none; b=qdFqenxTM2NC0pI4JDe7D1GT+UpknGh3PFFMYHnWGdaxjuGzgZFc+RCRI5uS3qF1TrPqWGofG1BucEu7PniT3LMjTyWmfjwAtxjkUDy2bdFoNDzZyOypJZn9gPCCGa8Oc37JG7vHbJ5UuLoOJCYveKQdt86T91Mhtg02jCXnqok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728208659; c=relaxed/simple;
	bh=tNheyRq7XRAALEKi3kdkqbaHWrwJgg5NDUkOgCVEFWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjpIbocpA5XLU8GWxgsL6Dk5/JpgR1u7eBeR62USP/AQNPkihgggt/6oUYYgvJJEOP5Xx9IjZLk7wduseMWqRr8IFmo4s9MNvNLBtO2hNS8CJznk50BmRH6VnSpuaMU6fQ+OyHqBsCxLrdNRuqSVKstu3JWXlYrKhzIFeigXgjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKiR+jTb; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKiR+jTb"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-84e7f644ebcso105782241.0
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 02:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728208656; x=1728813456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1NiEQh+rN7TWvM3Le4aBVtrbNnlohLlCNGITSeXekM=;
        b=mKiR+jTbCJ8EYKN4mNtsLBcBpM3tDEiHPxAmOrhQ0WFeWulgsIe4O/l2sgWhkztxpb
         6/GiCXSwYET2su2LfT4M9RnPgyqR/ayrRGC755AjCZkJ0dYcvy+c9+Kshzlu2SMXfXQS
         oBjdmn2mTMSj2u75E8ySjtB90hB1/1yqi4i8yM1PTsaJUJMpLJRmFRki+shOgFF2KTxy
         D2ho4z4AywXU07HQh28nIzesP/bB52jE02+iwFiChfYI/LxNN9orgq6Ze6JofC242y7h
         fDn0WYOUXd/JAdk4gAfOfNiWtuP3lRpt5587PqzmH59d34JE1oG8fZpbt3RQ4GCQfqw7
         mE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728208656; x=1728813456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1NiEQh+rN7TWvM3Le4aBVtrbNnlohLlCNGITSeXekM=;
        b=qCJ6fcwdXpQ7Ih6f5RNkUipu4OirhPXEIFdalxp/H0dT6ZSUiV9upICahpj9KT7sEn
         Z3D60ZIP61IO7NEKKjX41nUB2jHqEv44/EG6Xu1gR5ga7fBXYbNTdS5Gzgm96uNrXF63
         tVgZ2L96NzWrHi+WdRBNR0sXJxsvtAzvLdA+SRgjqc5WG2xopa8wR7MzEvRlR18EZ2k8
         OEPNaxmbf7n9dKUIbmihPILU+DEZqf6RjyF1c3lDNMY1CUyM+HHzT+//ph9oS93AMcNF
         Kq0XG2SHF7KAttfRNP9kwb3HHwdLlddZLT7np8WXtxhg+0t9sm92Kyzroc+s5TN095AW
         vyGQ==
X-Gm-Message-State: AOJu0YwjvLhGRcs00p7nnIb9/G5P6B0oEoO8MrjJc3VPhxHWL2lTdqfL
	CBa0sxZI85c0UsTcbQ1NJ1MMA+5xisTG11bkT6egV9WGpYSxhrK0wBobuXkaA8c31l7NL35otwv
	20076kw/WMhKd1Im9RKmvsUu01r7FrdM0a4YHbA==
X-Google-Smtp-Source: AGHT+IH8auYwculx45dmp8P9TZYu+GZ67gR3QnpkkGBlEgJ1gg+epdiNrrQ1PevK8oa3WOBZR9G5DDqKT7H3YN+UBF4=
X-Received: by 2002:a05:6102:38ca:b0:493:b44f:5db4 with SMTP id
 ada2fe7eead31-4a4058d3633mr2093351137.3.1728208656168; Sun, 06 Oct 2024
 02:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO1n884e13_9FZDBtcFrwU8oCyv+0_WUT-c16qN0W9c+D6k2PQ@mail.gmail.com>
 <834250ef-46ec-4667-8e41-e427472fd623@gmail.com> <CAO1n887uu5qUcqLcdKfh8FBKJAQUCGqVOnAzX7WWiFEnuuMF3A@mail.gmail.com>
In-Reply-To: <CAO1n887uu5qUcqLcdKfh8FBKJAQUCGqVOnAzX7WWiFEnuuMF3A@mail.gmail.com>
From: Abraham Samuel <sammymore50@gmail.com>
Date: Sun, 6 Oct 2024 10:57:26 +0100
Message-ID: <CAO1n887hN81j5h12t-6xpNQAQ5uOx1wxLz48c+O4hZE-pWdY8A@mail.gmail.com>
Subject: Re: [Outreachy]
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philip,
I have read through [1], [2] and other articles relevant to completing
a micro project and contributing to git. After going through the
microproject ideas, I have come up with two possible projects I am
interested in working on.
1. changing the style for 'cd' in the test subshell.
In this following email,
https://lore.kernel.org/git/CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2SS_b7=
V8Hg@mail.gmail.com/
It explains how to modernise and clean up t7001, and example of which is

* style for `cd` in subshell is:

    (
        cd foo &&
        ...
    ) &&

  not:

    (cd foo &&
        ...

    ) &&.
However, a sample outdated style can be seen in the sample file
t/t5605-clone-local.sh which I would like to work on to change those
instances to the modern accepted code style
Some examples can be seen in the file as follows.
test_expect_success 'local clone without .git suffix' '
git clone -l -s a b &&
(cd b &&
echo false >expect &&
git config --bool core.bare >actual &&
test_cmp expect actual &&
git fetch)
'
test_expect_success 'local clone with .git suffix' '
git clone -l -s a.git c &&
(cd c && git fetch)
'
test_expect_success 'bundle clone with nonexistent HEAD (match default)' '
git clone b2.bundle b2 &&
(cd b2 &&
git fetch &&
git rev-parse --verify refs/heads/main)
'

2. Use test_path_is_* functions in test scripts.
I have found three potential test files in the t/ directory
t5601-clone.sh
test_expect_success 'clone --mirror' '

git clone --mirror src mirror &&
test -f mirror/HEAD &&
test ! -f mirror/file &&
FETCH=3D"$(cd mirror && git config remote.origin.fetch)" &&
test "+refs/*:refs/*" =3D "$FETCH" &&
MIRROR=3D"$(cd mirror && git config --bool remote.origin.mirror)" &&
test "$MIRROR" =3D true

'

t7300-clean.sh
test_expect_success 'git clean with skip-worktree .gitignore' '
git update-index --skip-worktree .gitignore &&
rm .gitignore &&
mkdir -p build docs &&
touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
git clean &&
test -f Makefile &&
test -f README &&
test -f src/part1.c &&
test -f src/part2.c &&
test ! -f a.out &&
test ! -f src/part3.c &&
test -f docs/manual.txt &&
test -f obj.o &&
test -f build/lib.so &&
git update-index --no-skip-worktree .gitignore &&
git checkout .gitignore
'
t7611-merge-abort.sh
test_expect_success 'fails without MERGE_HEAD (completed merge)' '
git merge clean_branch &&
test ! -f .git/MERGE_HEAD &&
# Merge successfully completed
post_merge_head=3D"$(git rev-parse HEAD)" &&
test_must_fail git merge --abort 2>output &&
test_grep MERGE_HEAD output
'

These tests can be refactored to use the test_path_is_file and
test_path_is_missing functions.

Please kindly let me know the possibility of doing these microprojects.
Thanks
Abraham.
On Thu, Oct 3, 2024 at 3:14=E2=80=AFAM Abraham Samuel <sammymore50@gmail.co=
m> wrote:
>
> Hello Philip, thanks for your prompt response. As regards your
> request, I want to work on the project description 'Convert unit tests
> to use the clar testing framework'.
>
> On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
> >
> > Hi Abraham
> >
> > On 02/10/2024 04:04, Abraham Samuel wrote:
> > > Hello, I'm Adekunle an Outreachy 2024 intern. I am most excited and
> > > eager to start making valuable contributions to this project. Thanks
> >
> > Happy to hear that you are interested in contributing to Git as part of
> > the Outreachy projet. To help us mentors, could you please clarify whic=
h
> > of the two approved projects you are interested in?
> >
> > Other than that I would strongly recommend reading through [1] and [2],
> > if you haven't already done so. They should give you some ideas for how
> > the Outreachy application process is designed to work in the Git projec=
t
> > and lays out the expectation of us mentors.
> >
> > Let me know in case you have any additional questions.
> >
> > Phillip
> >
> > [1]: https://git.github.io/Mentoring-Program-Guide/
> > [2]: https://git.github.io/General-Microproject-Information/
> >
