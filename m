Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D0158553
	for <git@vger.kernel.org>; Sat,  5 Oct 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728146504; cv=none; b=itYCG8QI58yzYr9Y5h96tEovxOzf9BvYUF9SdIvlAdT7aWEfGlnnnoJkUGYvulLKxjgGpvQh/fcHS7K9FRxsLSJJ0WQgpnfN7InrX6qFyKUYnyUlLLPmTFKMKmnL79S8ymnU/Uz8WSM718+QWwEDxZpyFvQpK8TQ4o3QyqJcY08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728146504; c=relaxed/simple;
	bh=/xt9+VekCXvGhF2bvqD2Lpar66ylsyfBDaGnyxwXhxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNReTJbwEvj7Uo5a2UpWOYaaQ3EJIkQvYdChCsy1Gf99Clz16m2Rwqk223quqJ+0TVFbUUImHcG2+r2wc0NhnaRP8f6kLOdx1xa8OFVnczvJapz/uHyq6/JJ+XCXyKzfo+N0mOc4HlSMcQ831BAVNHfyhaHCVOOVUnmLYIFJQL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0qBjBJz; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0qBjBJz"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5090e09438aso997041e0c.0
        for <git@vger.kernel.org>; Sat, 05 Oct 2024 09:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728146502; x=1728751302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xt9+VekCXvGhF2bvqD2Lpar66ylsyfBDaGnyxwXhxk=;
        b=C0qBjBJz7c0gQoyHgnrJljdYuGS1acgc4mNSoe5vvR4BXzHQw/YQ1ZmbLUE4lRd/Kr
         42ePQlCfS8OaHXn1oRQ+2Nyhmq/FgYrDysqvKhoePxzuXRfXh158LTgjwI6Y/fyh3gW/
         wZ0LivskNx40da1MTTEexOzd4nlaHHb1V+FPwfw/7uJNhHWgT6h1HDswyKJA2UVgckZ+
         880R2UcD1HOu+wNrat8UYp/Ph68WdsK4sLUZGdJq5vYwImBybD+OL/AzUiLt7bdZ6iI9
         AhpImRkxGfwxmnGJKv5Qkq5h6bM2PB7zJLgPDoOTUWZPSRu5I3g28h7YRbhZ5pKjq3LO
         GYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728146502; x=1728751302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xt9+VekCXvGhF2bvqD2Lpar66ylsyfBDaGnyxwXhxk=;
        b=KwtVpuI2U0TV0hjaR/H9H0c+EOKgUAu1rjB2x7wc32MYMhNeFbBvpFuF5qMu4gxO9N
         mG7UcYJAcdjl6gSKw9ySHqZxuy7WTpRgxgDJfb1EQ/5yX+cAPRKca90fHHuysTJkprYp
         8cr34TYUUvIoxeQZD/k50WhNzWStLPfpWP1eFftRzUY77VtThYS69HbUI/h2nkiTQCAk
         8wisbELkla4/W+EyBAqjrThPjhg9tFxdFTTiYVSDSKyXQBQwepB/fYNG4JOwMJToqjdZ
         OmxAnuGiA8m1yCrml6+E3hKG8RoF2pnqdQtWZAhQu9SA8NPvtWJ73l0lwGi+jgfKUPx+
         9SLw==
X-Gm-Message-State: AOJu0YxeJOHNd+9Uw5NWWSQ9ph19c8MIbJ0y1MeLAJCDps6B7K4c1+T3
	AHvnwD2M/yp/XYH6OaR9BULAgzrkOQiDQFeLJIxhq5muZi1+nzmALn7XgBDvO2ZvZn3VjQhNmQt
	wqC80Qg9YP8oudns07XVzt0MEQ/CzJQdXtvE=
X-Google-Smtp-Source: AGHT+IFk8uEgi7YUvoJcOo1spd8/xZ3AGUQfJCO6Oe1nDezkgjqSsDRGbIc8aV/VgzLIqmCY7GT8x555lzE9i5DqbXk=
X-Received: by 2002:a05:6122:16a2:b0:4fc:da8f:c8a8 with SMTP id
 71dfb90a1353d-50c8543953amr4475983e0c.1.1728146501913; Sat, 05 Oct 2024
 09:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM-+4VFsHkBW8Y3ncY-kjxvAXSOdSom=zBQzTNd-JK+HxA@mail.gmail.com>
 <Zv0-Wv03hSea_Tje@pks.im>
In-Reply-To: <Zv0-Wv03hSea_Tje@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 5 Oct 2024 16:41:30 +0000
Message-ID: <CAPSxiM_fTMCzXg3OrcbJrn=UskyCaR3D=xgR4d6PrnnAdoYcCQ@mail.gmail.com>
Subject: Re: [Outreachy] Potential intern.
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

Following this, I have gone through [1], [2] and some other resources.

I was able to get potential three interesting MiniProject which I can
work on. I have also checked through the mailing list to ensure no one
is working on any of the particular file. As advised, I am sending
this just to be sure if it=E2=80=99s worth doing and if it=E2=80=99s approp=
riate for a
miniproject. I am sending three MiniProjects so I can have one to work
with in case any of them is not appropriate.

1. Use test_path_is_* functions in test scripts
An approved sample -
https://lore.kernel.org/git/20240304095436.56399-2-shejialuo@gmail.com/

Two email threads of discussion and feedback from maintainers.

https://lore.kernel.org/git/CAPig+cR2-6qONkosu7=3DqEQSJa_fvYuVQ0to47D5qx904=
zW08Eg@mail.gmail.com/
https://public-inbox.org/git/CAPig+cRfO8t1tdCL6MB4b9XopF3HkZ=3D=3DhU83AFZ38=
b-2zsXDjQ@mail.gmail.com/

Two potential test files which I saw that I can work one.

t/t7003-filter-branch.sh


test_expect_success 'test that the file was renamed' '
test D =3D "$(git show HEAD:doh --)" &&
! test -f D.t &&
test -f doh &&
test D =3D "$(cat doh)"
'

t/t2003-checkout-cache-mkdir.sh

test_expect_success 'use --prefix=3Dpath2/' '
rm -fr path0 path1 path2 &&
mkdir path2 &&
git checkout-index --prefix=3Dpath2/ -f -a &&
test -f path2/path0 &&
test -f path2/path1/file1 &&
test ! -f path0 &&
test ! -f path1/file1
'
These two are asserting that if a file exists, it can be changed to
test_file_exist

2. Avoid suppressing git=E2=80=99s exit code in test scripts

Sample email thread about the same issue.
https://public-inbox.org/git/pull.885.v2.git.git.1603032125151.gitgitgadget=
@gmail.com/

First file - t/t6050-replace.sh
code sample
test_expect_success 'replace the author' '
git cat-file commit $HASH2 | grep "author A U Thor" &&
R=3D$(git cat-file commit $HASH2 | sed -e "s/A U/O/" | git hash-object
-t commit --stdin -w) &&
git cat-file commit $R | grep "author O Thor" &&
git update-ref refs/replace/$HASH2 $R &&
git show HEAD~5 | grep "O Thor" &&
git show $HASH2 | grep "O Thor"
'
Second File - t/t3404-rebase-interactive.sh
code sample that needs improvement

test_expect_success 'retain authorship' '
echo A > file7 &&
git add file7 &&
test_tick &&
GIT_AUTHOR_NAME=3D"Twerp Snog" git commit -m "different author" &&
git tag twerp &&
git rebase -i --onto primary HEAD^ &&
git show HEAD | grep "^Author: Twerp Snog"
'

3. Modernise test.
Description
https://lore.kernel.org/git/CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2SS_b7=
V8Hg@mail.gmail.com/
Sample code t/t7611-merge-abort.sh test_expect_success 'Reset index
(but preserve worktree changes)' '
git reset "$pre_merge_head" &&
git diff > actual &&
test_cmp expect actual
'
Thank you as I await your feedback.

On Wed, Oct 2, 2024 at 12:36=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Hi again :)
>
> I've already replied to this email when it reached Phillip and me in
> private and redirected it to the mailing list. So I'll repeat what I've
> said in my reply mail just so that others are aware that I've responded
> to it.
>
> On Wed, Oct 02, 2024 at 07:12:37AM +0000, Usman Akinyemi wrote:
> > Hello, I am Usman Akinyemi from the Outreachy program, I just got
> > selected for the second round contribution stage, I got interested in
> > the git project as it is one of the most important OpenSource
> > projects.
>
> Great, thanks for reaching out to us and thank you for your interest in
> the Git community!
>
> > Also, my skills are aligned with the required skill for the
> > projects and it is related with what I did at systemd where I created
> > a new unit test framework which is now the primary framework used
> > across the project. This development has significantly enhanced
> > testing efficiency by improving error reporting and debugging,
> > streamlining development processes, and increasing the reliability of
> > the software.
> >
> > I hope to learn and contribute meaningful contributions to git.
> >
> > Also, if there is anything I need to learn about, kindly let me know.
> > I really appreciate it.
>
> I would strongly recommend reading through [1] and [2]. They should give
> you some ideas for how the Outreachy application process is designed to
> work in the Git project and lays out the expectation of us mentors.
>
> Let me know in case you have any additional questions!
>
> Patrick
>
> [1]: https://git.github.io/Mentoring-Program-Guide/
> [2]: https://git.github.io/General-Microproject-Information/
