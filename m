Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8962115A843
	for <git@vger.kernel.org>; Sat, 15 Feb 2025 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739608978; cv=none; b=BaYZxezzdZwOeyanWx2a67zHo5G4TRpRKbfzEe6OjHFAuGWXx7xzA18gZMlo8fUPcFRT4HmhO2gzVLoHBJTBYPjXdg+e84RIjcTDuegSMr4tXcbguZvQkTAc/eJbIKaJv/2QcSXrhFyWqmaE98yutyHtfuqwjYuJQPR98gqaXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739608978; c=relaxed/simple;
	bh=QIR83M+8Hy/DSuvpzcEX0Yf9YLnjFh12u64cAcJJ+AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnkPJJtLYFVFnj0VeKpYOD1GpBrk+5gVk1Tvi/3jc4i6wdiU/u/TJi8EWQkZyj/zdKLvuG2ekf8EP1N6WksEdPz27g4taI0aBHJKjy3wo3Mv9jiiNKCJagEYLzi4BCpdonAtCupZHbjq8Jbr2EcgnLf9WA1QkudqdENurlqRSCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SR1erf9C; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SR1erf9C"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3076262bfc6so29889581fa.3
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 00:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739608974; x=1740213774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TJQriZyDPe6lx9q3n5slz55zyWn92eCseMJwt2BY2s=;
        b=SR1erf9CrLolKK8avgpc0TVY1GPCApCqFtAHgxon7ft1ae8R7yjqE+hnhoDYhEC7Fh
         0P3NZodtRgxLszL58qtENCOlZyLhKW7jMuo6hD6SfvjMgrJiobe9axKcg+Q+239ib88w
         E7OhLFIv8374Kym/cClWOSqbKnFVb9aV632xaGdmNd/uC5eYizhC8+wBos85d9FdsPGA
         PqFiooVIRhnPLFh7hNZ5TGtHINzgMMyRc9p2x8SzNL+f0/7rM0HD0TGnySbz+Yu0ZwX+
         ZMKkKu+Pz93F2bmOsloUtoN2s3mP3qrAAMPm7hwTF0UFkFm84bLjuTaIcx8WhYYddPv/
         VbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739608974; x=1740213774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TJQriZyDPe6lx9q3n5slz55zyWn92eCseMJwt2BY2s=;
        b=Eq/r9dmJ/IWVmJ4WRrz1H+SoxDUOEbfQfTdkI2Tfo2hwJb53y0uDVpBcFSF8OXELBH
         pIaUdbDzw7w24wdX1aDQdxj1u4sU9ZHN7K6bducJ8Hw3oE/0BL2A7t2h8IW1rRrUBCwE
         dDtrDJWNVydhG9JpwM/jRaAF/qqzMeMAgdT7rTez6nin+ZpqM9RYmKxxNLNUjEdOMPa0
         GgPyiHcaYngf5OSEgdSYNIdRVhxSuAFNKFv/fxhDx8bhz1X/X9570YVoqjxsbSQbG/qI
         ot4m3RP5l5r0/Oot9YUv0nP7H7r6cRcRVAkeBkAFZlCgopBf71wy7hRYyAp7odCxpRzV
         SfyA==
X-Gm-Message-State: AOJu0YztlhcPSFWqpc7utrwFF4EQhDwTQ5TnJHE1w1p8SRuqinvRULgz
	oh8HHX5LsVUctngTUON4HzzaHyM9zsO3GjSLNDaplc6QAZ8bXesz4LqyOAaTIsrxghLErRjrya6
	A6bd2yztRZ7qpaEzLajP6Ix9d87M=
X-Gm-Gg: ASbGncuH5gF+vkFRRdhioNgbqhrPpWFuF5iutN2elp3GrsWNwgff3c4y8vaJuY8G1LL
	apspgexG83Nt9uX4ZX9pFd4Im0ONr/WQynUDH/KsHm8qB9hSuTzJHnlqSTTfJDBsSDDVPubVJ0o
	Y=
X-Google-Smtp-Source: AGHT+IF9OgKw6XWmRGlska/C47qtBzpay21521aEXrElOZOhJOvA/BiDDYS7EZhdv4Gs8idq3ROX8wSOnBP7iiyaKfg=
X-Received: by 2002:a2e:93d0:0:b0:306:f7b:20b with SMTP id 38308e7fff4ca-30927afdd12mr7847651fa.24.1739608974264;
 Sat, 15 Feb 2025 00:42:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211194334.20710-1-meetsoni3017@gmail.com>
 <20250213090040.16133-1-meetsoni3017@gmail.com> <20250213090040.16133-3-meetsoni3017@gmail.com>
 <CABPp-BGqihkPq3o4jnqp2aGdqw12F8a8nOModuAB-5N7BQ1t0w@mail.gmail.com>
 <CAPhwyn0hz16mZ-UoVAczC4qDLx2i0LwfFhhDjdTahe0=4TO57g@mail.gmail.com>
 <CABPp-BGq-x9Z98scXRtEnqz7BCmPn9ONHd6wDnnm9jL4YeDHxQ@mail.gmail.com>
 <CAPhwyn1oXRy5BFQBvuFsmhfVhkW8+D6Xz6OYB8LpP0O+jH1TFQ@mail.gmail.com> <CABPp-BGOeAJ-e0P7kALLMnA7wCzbJx6WEYwmCmsq9qK46DYdVw@mail.gmail.com>
In-Reply-To: <CABPp-BGOeAJ-e0P7kALLMnA7wCzbJx6WEYwmCmsq9qK46DYdVw@mail.gmail.com>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Sat, 15 Feb 2025 14:12:42 +0530
X-Gm-Features: AWEUYZmJD2n48noUFqhJpXYIFKGS1kCrrJMMF80koKXnWQCNR4YkVpY1YtPYhos
Message-ID: <CAPhwyn0JGxqQcKjz58F9AQ5caPeXms_qPksxJ=JRrxPufUFZWg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] merge-recursive: optimize time complexity for get_unmerged
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 15 Feb 2025 at 00:30, Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Feb 14, 2025 at 12:24=E2=80=AFAM Meet Soni <meetsoni3017@gmail.co=
m> wrote:
> > That's the thing -- I did run make in the t/ directory, and it passed. =
I was
> > just wondering if there's any other way to test this in isolation, in c=
ase
> > I want to verify such changes more directly in the future.
>
> Really?  Did you rebuild the code, after making your changes?  You may
> have been running with a pre-changes version of the code.
>
> I just applied your changes and ran the tests.  I see it fail as soon
> as it gets to t1004.
>
> $ cd t && make test
> [... lots of output snipped ...]
> *** t1004-read-tree-m-u-wf.sh ***
> ok 1 - two-way setup
> ok 2 - two-way not clobbering
> ok 3 - two-way with incorrect --exclude-per-directory (1)
> ok 4 - two-way with incorrect --exclude-per-directory (2)
> ok 5 - two-way clobbering a ignored file
> ok 6 - three-way not complaining on an untracked path in both
> ok 7 - three-way not clobbering a working tree file
> ok 8 - three-way not complaining on an untracked file
> ok 9 - 3-way not overwriting local changes (setup)
> ok 10 - 3-way not overwriting local changes (our side)
> ok 11 - 3-way not overwriting local changes (their side)
> ok 12 - funny symlink in work tree
> ok 13 - funny symlink in work tree, un-unlink-able
> ok 14 - D/F setup
> ok 15 - D/F
> ok 16 - D/F resolve
> not ok 17 - D/F recursive
> #
> #
> #        git reset --hard &&
> #        git checkout side-b &&
> #        git merge-recursive branch-point -- side-b side-a
> #
> #
> # failed 1 among 17 test(s)
> 1..17
> make[1]: *** [Makefile:77: t1004-read-tree-m-u-wf.sh] Error 1
> make[1]: Leaving directory '/home/newren/floss/git/t'
> make: *** [Makefile:63: test] Error 2
>
>
> ...and if go to the toplevel directory and run under prove so I can
> see all the failures (and run the test suites in parallel), I see:
>
> $ cd .. && make DEFAULT_TEST_TARGET=3Dprove GIT_PROVE_OPTS=3D'--timer
> --state failed,slow,save --jobs 12' test
> [... lots of output snipped ...]
> Test Summary Report
> -------------------
> t3424-rebase-empty.sh                            (Wstat: 256 Tests: 20
> Failed: 18)
>   Failed tests:  3-20
>   Non-zero exit status: 1
> t3436-rebase-more-options.sh                     (Wstat: 256 Tests: 19
> Failed: 17)
>   Failed tests:  2-18
>   Non-zero exit status: 1
> t4151-am-abort.sh                                (Wstat: 256 Tests: 20
> Failed: 12)
>   Failed tests:  5-9, 12-16, 19-20
>   Non-zero exit status: 1
> t3407-rebase-abort.sh                            (Wstat: 256 Tests: 17
> Failed: 8)
>   Failed tests:  2-9
>   Non-zero exit status: 1
> t3428-rebase-signoff.sh                          (Wstat: 256 Tests: 7 Fai=
led: 5)
>   Failed tests:  2, 4-7
>   Non-zero exit status: 1
> t6409-merge-subtree.sh                           (Wstat: 256 Tests: 12
> Failed: 5)
>   Failed tests:  2-6
>   Non-zero exit status: 1
> t7102-reset.sh                                   (Wstat: 256 Tests: 38
> Failed: 7)
>   Failed tests:  14-20
>   Non-zero exit status: 1
> t6432-merge-recursive-space-options.sh           (Wstat: 256 Tests: 11
> Failed: 4)
>   Failed tests:  2, 7-8, 11
>   Non-zero exit status: 1
> t6430-merge-recursive.sh                         (Wstat: 256 Tests: 37
> Failed: 15)
>   Failed tests:  10-11, 13-20, 22-24, 28-29
>   Non-zero exit status: 1
> t3406-rebase-message.sh                          (Wstat: 256 Tests: 32
> Failed: 8)
>   Failed tests:  22, 24-27, 29-31
>   Non-zero exit status: 1
> t4200-rerere.sh                                  (Wstat: 256 Tests: 36
> Failed: 5)
>   Failed tests:  24-28
>   Non-zero exit status: 1
> t7201-co.sh                                      (Wstat: 256 Tests: 46
> Failed: 5)
>   Failed tests:  5-9
>   Non-zero exit status: 1
> t3418-rebase-continue.sh                         (Wstat: 256 Tests: 29
> Failed: 7)
>   Failed tests:  4, 6, 10-12, 26-27
>   Non-zero exit status: 1
> t3403-rebase-skip.sh                             (Wstat: 256 Tests: 20
> Failed: 3)
>   Failed tests:  2, 4, 9
>   Non-zero exit status: 1
> t4253-am-keep-cr-dos.sh                          (Wstat: 256 Tests: 7 Fai=
led: 2)
>   Failed tests:  6-7
>   Non-zero exit status: 1
> t9903-bash-prompt.sh                             (Wstat: 256 Tests: 67
> Failed: 39)
>   Failed tests:  16-31, 33-35, 37, 40-44, 46-52, 55-58, 60
>                 62, 67
>   Non-zero exit status: 1
> t3503-cherry-pick-root.sh                        (Wstat: 256 Tests: 6 Fai=
led: 2)
>   Failed tests:  5-6
>   Non-zero exit status: 1
> t3401-rebase-and-am-rename.sh                    (Wstat: 256 Tests: 10
> Failed: 2)
>   Failed tests:  4, 10
>   Non-zero exit status: 1
> t2407-worktree-heads.sh                          (Wstat: 256 Tests: 12
> Failed: 2)
>   Failed tests:  4-5
>   Non-zero exit status: 1
> t5407-post-rewrite-hook.sh                       (Wstat: 256 Tests: 17
> Failed: 3)
>   Failed tests:  4-6
>   Non-zero exit status: 1
> t2500-untracked-overwriting.sh                   (Wstat: 256 Tests: 10
> Failed: 2)
>   Failed tests:  9-10
>   Non-zero exit status: 1
> t4153-am-resume-override-opts.sh                 (Wstat: 256 Tests: 6 Fai=
led: 1)
>   Failed test:  3
>   Non-zero exit status: 1
> t1015-read-index-unmerged.sh                     (Wstat: 256 Tests: 6 Fai=
led: 1)
>   Failed test:  6
>   Non-zero exit status: 1
> t3509-cherry-pick-merge-df.sh                    (Wstat: 256 Tests: 9 Fai=
led: 1)
>   Failed test:  9
>   Non-zero exit status: 1
> t2023-checkout-m.sh                              (Wstat: 256 Tests: 5 Fai=
led: 1)
>   Failed test:  5
>   Non-zero exit status: 1
> t7615-diff-algo-with-mergy-operations.sh         (Wstat: 256 Tests: 7 Fai=
led: 1)
>   Failed test:  2
>   Non-zero exit status: 1
> t6427-diff3-conflict-markers.sh                  (Wstat: 256 Tests: 9 Fai=
led: 1)
>   Failed test:  8
>   Non-zero exit status: 1
> t1004-read-tree-m-u-wf.sh                        (Wstat: 256 Tests: 17
> Failed: 1)
>   Failed test:  17
>   Non-zero exit status: 1
> t3420-rebase-autostash.sh                        (Wstat: 256 Tests: 52
> Failed: 10)
>   Failed tests:  11-17, 21-23
>   Non-zero exit status: 1
> t4150-am.sh                                      (Wstat: 256 Tests: 87
> Failed: 33)
>   Failed tests:  34-40, 42-46, 48, 50-54, 57-62, 64-65, 67-71
>                 75, 87
>   Non-zero exit status: 1
> t7512-status-help.sh                             (Wstat: 256 Tests: 46
> Failed: 3)
>   Failed tests:  5-6, 29
>   Non-zero exit status: 1
> t3400-rebase.sh                                  (Wstat: 256 Tests: 39
> Failed: 1)
>   Failed test:  30
>   Non-zero exit status: 1
> t3404-rebase-interactive.sh                      (Wstat: 256 Tests:
> 131 Failed: 1)
>   Failed test:  80
>   Non-zero exit status: 1
> Files=3D1031, Tests=3D30662, 70 wallclock secs ( 8.33 usr  2.13 sys +
> 248.60 cusr 516.60 csys =3D 775.66 CPU)
> Result: FAIL
> make[1]: *** [Makefile:73: prove] Error 1
> make[1]: Leaving directory '/home/newren/floss/git/t'
> make: *** [Makefile:3237: test] Error 2
>
> I suspect this is a case where it was testing a version of git that
> you built before making the changes.

Thanks! You're right. I ran the tests before running make. After
running make and testing again, it failed.

Meet
