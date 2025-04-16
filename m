Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35F71A2658
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 01:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744768601; cv=none; b=Z//iEfcQMS8VTcejRq2m9mHOLDkj6ermbkM9bBZscnoXa/lItUHc73xwj/GCqWUJPZuSwQRK28PjcGaL6aTpmmcxgzfyImaYfIS3S6DuCNyk8ZASckmRcVNTLVQ4iAPQ1GJ21VwX2/kPmEXuDhtlvpQvJwbS/cZZ815i65qgR8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744768601; c=relaxed/simple;
	bh=mJfiTT8WnaW65VIkYyHtXXQV4nzNFQFv/QJAdxc/uc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=NPzOimCLjW5ftzu01X0KUVOWgyEHgxVM1I6p4ool68C1yjzmQaySO4iXr+LYgIaOrCz8JSTRZu34WmKTpwvYR3t76b3EWN5vxRAb9+arHcqfQbGS4ngyGmxsm1iByzLcH2aGufmi9kM6b+GWAo95KDnIYwsngjZE2gtFTmEl4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJ9gbXiw; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJ9gbXiw"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47664364628so2778571cf.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 18:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744768598; x=1745373398; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOnDonezgtkCVOjAiWfTYabeQEWy4R4+T73+Z2aNAPQ=;
        b=bJ9gbXiwvVxzpVJd3gbeIUdo3eQ4capyXOPiEjSWvzNGfXNjseij/tmqPAmmLvjPPk
         NvdU8XL3Fr1nR4sZgE2Q29NPYq5Y6Cb7kau9scYZp/71W+9JRgy9sv5UvcT2Qtn1m8Tw
         MZnawpg1MeZG0sfJL2kcQGHJtLx38Fn1XnL8+jPJx0UIwGqw01mexP7KvLAD9SbBeCf+
         t+TXQxkYULNbQtspy6cJcltQZP/AZC+wFivcG5UB5jbDirASZSUHatYc2G2Iy8I3RaTt
         DKONsDICWXdK9tmAMcfJAbkpqwyTUXZ524qmZqqHR0VzbtLjrwpMBVOgREwvjunAJl0J
         /sLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744768598; x=1745373398;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOnDonezgtkCVOjAiWfTYabeQEWy4R4+T73+Z2aNAPQ=;
        b=CpnKEofGrEEhrXHKnydiXGaxzkdx7wHkgQqvbEhxg2Alw+o7HrPMU5UU0/tHj19JZ7
         VXXXUtbNkEapvrJYq3i+aPSmShM+NtBgp/9KdPBCA/eE7EF73o14Oe7hJJSvTHQBnx1J
         WibIY8m406dvsgyArl+PtDjhIFpGZqpW4q7NhWPHE0aLE9Op3DQY40BCGow3Hka63jYX
         6wd0B/AIxCCNuFQuKRuhjylPI2STRobhFKHLNLU3o0WSCC4gbBvJ52MrnxELxcAhmyFg
         e7X4shVO+Bd4TXKpadlANvilnGsko1GvuxDOSyXQZ5fuzX/ZJVE8FXrwOEpchUPALizj
         q5qg==
X-Forwarded-Encrypted: i=1; AJvYcCU5xWemYzFXpK4Yy0xf6Ll0UsqFc6RaipFEM16UOkQzwBRF5QWXhB9ya3B6iueGX/CXA5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmA5rBtwisc/DxUOdYFwLM4tYVDHqjDCfG5VISkfTBhfQ5RRdw
	xQrqWChCsx5Oe7PzSrOBNmWBfmOgWjePbDOGunbTqgKJ5RmAE7XbKEzOi8mvhH+85ZQFQ66oI3y
	cIPCFncFymhQiNTpxVeHSmjvStqo=
X-Gm-Gg: ASbGnctEBV/4Tq3vuLmgeY8FFedkoGOjorXKcrMUCgARbF52ezqcLM5bRZ5tj2ugEvD
	K0/ftqF84lNaBHatoOLSQL4M4+zi4vZ6gbQFfBgSEXLdGwrUTKEzW3caaefokgyWWEq+JM3VVGG
	K33fMBO4cdxcR+H+izep+MZoz634LWIUZ4773kpA7+VdzmTF3GTjhwCRs=
X-Google-Smtp-Source: AGHT+IESkgxQrretgy0LHv2pc4H4sluEJSm6m2YU8RfV+NgJRRQXAaSd0PBJqbj8vuC4Ia828+6TyApZlKynh8lVCJI=
X-Received: by 2002:a05:622a:11d5:b0:479:1a0:3448 with SMTP id
 d75a77b69052e-479ff1aa73amr81553761cf.10.1744768598618; Tue, 15 Apr 2025
 18:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412094607.236382-2-jayatheerthkulkarni2005@gmail.com>
 <20250412174051.780148-1-jayatheerthkulkarni2005@gmail.com> <Z_7ekhsBzXK6LKuV@tapette.crustytoothpaste.net>
In-Reply-To: <Z_7ekhsBzXK6LKuV@tapette.crustytoothpaste.net>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Wed, 16 Apr 2025 07:26:26 +0530
X-Gm-Features: ATxdqUHAbMetnOs3MCWwGYEiiKqxvhIyzELOLXhNVWmg2C3XfYvyve1DsxxDIdY
Message-ID: <CA+rGoLfAidyuomeNym5WX8Bo7-jPcfHx35wDeZ7W2aorAN-B7g@mail.gmail.com>
Subject: Re: [PATCH] t3706: Add test for wildcard vs literal pathspec
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, git@vger.kernel.org, peff@peff.net, 
	piotrsiupa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 4:02=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-04-12 at 17:40:51, K Jayatheerth wrote:
> > +test_expect_success 'recreate files to test add behavior' '
> > +    mkdir testdir &&
> > +    >testdir/f\* &&
> > +    >testdir/f\*\* &&
>
> I just want to point out that creating files with asterisks may not be
> possible on Windows due to limitations in the file system.  I'm not a
> Windows expert, so unfortunately I can't provide more details than that,
> but you may end up needing to add a prerequisite here to skip this on
> our Windows platforms if necessary.  Hopefully CI and a suitable search
> can help you figure it out.
>

Ok I will look into it, thank you for letting me know

> > +test_done
> > \ No newline at end of file
>
> We do want to keep newlines at the end of a file.  POSIX mandates one on
> text files and some systems are less tolerant of missing newlines than
> others.  Usually Linux and the BSDs handle this just fine, but some
> proprietary Unix systems, which unfortunately we don't have CI for, tend
> to be the ones that are less happy about this.
>

Ok I will make sure of that

> I haven't given this a full review, since others have done that instead,
> but just pointed out one or two things that got my attention.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA


While I was looking into the reviews I was creating various test cases
with these files
'*'  '**'  '?'  '\*'  '[abc]'   commit_files  'f*'  'f**'  'file[1-3]'
 'foo*bar'  'f?z'  'hello?world'

Everything went correct
But when I checked \* and which is used for getting * as specific
but there is also a literal \* in the above files

So it still adds both, I'm unsure if that is the intended behaviour.

but when I say git add "\*" it adds both the files * and \*
But rest of the other wildcards and literals work as intended which is why
I incorporated the \* literal

I also think I will still divide the test file because
git add isn't the only one that looks into wildcards and pathspec

I think something like git commit "*" -m "Test" also would be a great test

or even git rm command.

About the windows question, I think I will see if there is any common
ground I could find
But until then I think prereq is a great option.

For reference my test file looks something like this,

--- /dev/null
+++ b/t/t6137-pathspec-wildcard-literal.sh
@@ -0,0 +1,139 @@
+#!/bin/sh
+
+test_description=3D'test wildcards and literals with various git commands'
+
+. ./test-lib.sh
+
+reset_git_repo () {
+ rm -rf .git &&
+ git init
+}
+
+test_expect_success 'setup' '
+ mkdir testdir &&
+ cd testdir &&
+ touch "*" "?" "[abc]" "f*" "f?z" "a" &&
+ touch "**" "foo*bar" "hello?world" "f**" "hello_world" &&
+ git init
+'
+
+test_expect_success 'check * wildcard in git add' '
+ git init &&
+ git add "*" &&
+ cat >expected_files <<EOF &&
+*
+**
+?
+[abc]
+a
+f*
+f**
+f?z
+foo*bar
+hello?world
+hello_world
+EOF
+ git ls-files >actual_files &&
+ test_cmp expected_files actual_files
+'
+
+test_expect_success 'check \* literal in git add' '
+ reset_git_repo &&
+ git add "\*" &&
+ cat >expected_files <<EOF &&
+*
+EOF
+ git ls-files >actual_files &&
+ test_cmp expected_files actual_files
+'
+
+test_expect_success 'check f* wildcard in git add' '
+ reset_git_repo &&
+ git add "f*" &&
+ cat >expected_files <<EOF &&
+f*
+f**
+f?z
+foo*bar
+EOF
+ git ls-files >actual_files &&
+ test_cmp expected_files actual_files
+'
+
+test_expect_success 'check f\* literal in git add' '
+ reset_git_repo &&
+ git add "f\*" &&
+ cat >expected_files <<EOF &&
+f*
+EOF
+ git ls-files >actual_files &&
+ test_cmp expected_files actual_files
+'
+
+test_expect_success 'check f** wildcard in git add' '
+ reset_git_repo &&
+ git add "f**" &&
+ cat >expected_files <<EOF &&
+f*
+f**
+f?z
+foo*bar
+EOF
+ git ls-files >actual_files &&
+ test_cmp expected_files actual_files
+'
+
+test_expect_success 'check f\*\* literal in git add' '
+ reset_git_repo &&
+ git add "f\*\*" &&
+ cat >expected_files <<EOF &&
+f**
+EOF
+ git ls-files >actual_files &&
+ test_cmp expected_files actual_files
+'
+
+test_expect_success 'check ? wildcard in git add' '
+ reset_git_repo &&
+ git add "?" &&
+ cat >expected_files <<EOF &&
+*
+?
+a
+EOF
+ git ls-files >actual_files &&
+ test_cmp expected_files actual_files
+'
+
+test_expect_success 'check \? literal in git add' '
+ reset_git_repo &&
+ git add "\?" &&
+ cat >expected_files <<EOF &&
+?
+EOF
+ git ls-files >actual_files &&
+ test_cmp expected_files actual_files
+'
+
+test_expect_success 'check hello?world wildcard in git add' '
+ reset_git_repo &&
+ git add "hello?world" &&
+ cat >expected_files <<EOF &&
+hello?world
+hello_world
+EOF
+ git ls-files >actual_files &&
+ test_cmp expected_files actual_files
+'
+
+test_expect_success 'check hello\?world literal in git add' '
+ reset_git_repo &&
+ git add "hello\?world" &&
+ cat >expected_files <<EOF &&
+hello?world
+EOF
+ git ls-files >actual_files &&
+ test_cmp expected_files actual_files
+'
+
+test_done
--=20
2.49.GIT
