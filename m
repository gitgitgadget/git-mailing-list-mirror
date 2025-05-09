Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE5F231841
	for <git@vger.kernel.org>; Fri,  9 May 2025 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746808922; cv=none; b=LIs2VHqeg5A8lbFm6Jyi7AphiYlrDYK4ao+4hqxhvomwjl6aU+YaotWF3CSR8dZu8NZbPkM5yJrHGw4ACVb4wfSKJnadquhwF9kjD2qrVy3OqNGQ7c+EOGO6ZiiOcg+j6dd7Cl7pZzQ1pKzHZT9p+e/wBpUpSTWylTWg2BLXUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746808922; c=relaxed/simple;
	bh=qfBTzxuHGs787k+o1mZ8/96SVyOufkdn43UEKdMXyKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMMctUDDlH+KyxkSJ4TXwd/1PeklXOuBtdYlfB8k7Avl5hHb1mpGw9lHiyKClisFrl9Z/SE7VxQfz3NvJiODmSwj7yr9dE0PKjBBTct6OkiSk16QVxJoujqDOwBaYVSR0DXyS2MTpe76vfjbVp/JPilCB+jjoh85LotdiSzL83o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZTeTUYy; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZTeTUYy"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac345bd8e13so343595966b.0
        for <git@vger.kernel.org>; Fri, 09 May 2025 09:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746808919; x=1747413719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiX0YVnr+Yy6DW7oI8l4Fy3HbBzp0pw72xGq3WS6AF4=;
        b=RZTeTUYyNX/AaVciXCDZQVDILv7KVPu/8lXUJj/e1VeziWN+Ogs+cXf0PyV9NjqByZ
         NA8Pd1FAmWjztII+IC31in4tx90uDjyDzEyDiayYgwYxFCYQij/88R4vigw1g1AgAHFr
         VNHVcADmb516k5V6o1Nf3ZQHIFVQAjgUszFd5TuAST/kh0eUXvuQzb09sNWH/pZ6cZeJ
         NO7KOVU23upur5B1H0/dFX/Mfk5vJr2ghK8bjdAtjEyVZk3RtAth76iUpnBFLmyIOtI+
         uy2o/+ePDBZ9rNKrSSCo79iuFegFlHqwjRvsLIsS4GHvlKz0gKm/9VFlyjvRGxaTgTIK
         o3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746808919; x=1747413719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiX0YVnr+Yy6DW7oI8l4Fy3HbBzp0pw72xGq3WS6AF4=;
        b=QdYIlv6kHrXTLX+HakUoVasdgp/HUCed2b8/KOqwzNLzhKXoNi5a8jB3ay87HinytK
         Y22WAbCyqqiOK17hvCAmkyK0w8yGt0hp7vX82NePA/AAir3rg3gxuYMRNqW31hhyTuAY
         KuotN4SEj9Dp/9duzU1CeVm80VXWW+iTzb2wS/BguET8N/yFnuQEAyRv42PerrsriaMv
         ooXYqHg50MMja0nAGUCX8eZpzC/1Q1GUJ6ImXe0FdrOL6z4Te1Gm+rZA2mOzbmztbNJy
         Y4Sk50tKcvtaSPa2g16Ji2MCwEImIkaFfMxEhp6VTVyuMBA7Z1Ujsv3x6oWzVQj93FXM
         uicA==
X-Gm-Message-State: AOJu0YxJ7zXwROlMM1PD65niE1ISBi+NnGITnCVihMFBh9k/FqIeHR7I
	gX3cV6GFndQVKqoorznJ2HA0dbsq9D6sMQ8HHs2s4QwZ2Nmj09E4F7jte2sCKUYGIBpJlkL7faD
	FgRUy/YDcr//7uXz0ACLWiQPkcM4KfuxE
X-Gm-Gg: ASbGnct2XQYx0Gh9E7Ut/drEOz+STdNiK0K1d42gz28NlegI+NX0NC6E3NknJ07LQ4u
	AmajBE5GA0onNH2G+EBQS03dNQALpgIhbPn51lE1ZUpeSMKUZHvV6knGaOhh+LJnRBXZSVcdcuq
	uVbi5+Qf+GV2kGTW9mb3LG5zUXPiNyXZ0KCO0zgdXj775neBw+uK4sikA=
X-Google-Smtp-Source: AGHT+IFUTGldtcuVNPk5Y8+DRak/wLxl2gQN88Q4t8MJxZ6QVTzKE6fT58P4YHkmcbWQHJCrRviwZmYn6xoxH6QcD1o=
X-Received: by 2002:a17:907:9453:b0:ace:f53b:ff4a with SMTP id
 a640c23a62f3a-ad21917f5d3mr426724466b.50.1746808918384; Fri, 09 May 2025
 09:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8c075e6e-c28c-4146-66bc-9bd7bc705611@gmail.com>
In-Reply-To: <8c075e6e-c28c-4146-66bc-9bd7bc705611@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 9 May 2025 12:41:47 -0400
X-Gm-Features: AX0GCFupmqKXqlTsmrfPHemtzdVadoYEfHlH_oNvaq2AdrMDiEvxdk3iaiFLpx0
Message-ID: <CALnO6CB6aH5DEDP3QL43RCFfaZJ3uzrAY1LdGyTNi8F3XVoEhw@mail.gmail.com>
Subject: Re: Bug report for pull --rebase
To: Mr Bill <billc56196@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 5:44=E2=80=AFPM Mr Bill <billc56196@gmail.com> wrote=
:
>
>
> Hi, I ran across this doing a pull --rebase using the current master
> version of git
>
> This happens on Slackware linux, using git HEAD, version 2.35.8, and 2.46=
.2
>
> I have a clone of the ffmpeg video package, with a few custom commits on
> top of it,
> I periodically fetch and "pull --rebase" to update the underlying ffmpeg
> code.
> I tried this recently, and my custom commits disappeared.
>
>
> I looked further with a small test, and it looks like this is happening:
>
> The setup:
>     "base" repo with a few commits (A, B, C)
>     "clone_1" cloned from "base", with a few extra commits (F, G)
>     "clone_2" cloned from "clone_1"
>
> Add a few more commits for base (D, E)
>
> Then use "git remote set-url origin" to point "clone_2" to "base"
>
> Then, in "clone_2" do "pull --rebase"; the F and G commits disappear.
>
> Then, in "clone_1" do "pull --rebase"; the F and G commits are retained.

Thanks for including a script! I modified it (uploaded to
https://gist.github.com/benknoble/7a5eecd522b48669c2a5207e2ed9b7ee to
avoid problems with my mailer) to be suitable for use with bisect.

I put the script at /tmp/bugreport/doit next to a clone of the Git
source code, then (in the Git source repo) started a --first-parent
bisect between 2.49 and 2.0 with the ../doit script as the runner;
here's the log:

# bad: [683c54c999c301c2cd6f715c411407c413b1d84e] Git 2.49
# good: [e156455ea49124c140a67623f22a393db62d5d98] Git 2.0
git bisect start '--first-parent' '@' 'v2.0.0'
# bad: [4336fdb2efaf77b720f152c06b5ce2aa2e347fb6] Merge branch
'rs/nedalloc-fixlets'
git bisect bad 4336fdb2efaf77b720f152c06b5ce2aa2e347fb6
# bad: [130b664e442767587638b3e807a6f543168239d7] Merge branch
'js/travis-32bit-linux'
git bisect bad 130b664e442767587638b3e807a6f543168239d7
# bad: [922239e7da03f8e0a8c6ba809c1ee0cf3776f94a] Merge branch
'dk/p4-import-ctypes'
git bisect bad 922239e7da03f8e0a8c6ba809c1ee0cf3776f94a
# bad: [afa3ccbf44cb47cf988c6f40ce3ddb10829a9e7b] Merge branch
'jc/pretty-format-doc'
git bisect bad afa3ccbf44cb47cf988c6f40ce3ddb10829a9e7b
# bad: [7669461459aaee1587bac77c4a446e9365b582c7] Merge branch
'rs/merge-tree-simplify'
git bisect bad 7669461459aaee1587bac77c4a446e9365b582c7
# bad: [3d77f72efe79eb90f67aec9ecf6d4bd11fc9a78c] Merge branch
'jc/fix-clone-single-starting-at-a-tag'
git bisect bad 3d77f72efe79eb90f67aec9ecf6d4bd11fc9a78c
# bad: [5b3a58d459171f49ee8d486e4ac399eb2678605d] Merge branch
'jk/argv-array-for-child-process'
git bisect bad 5b3a58d459171f49ee8d486e4ac399eb2678605d
# bad: [d83c9c75e1edebd4ece3ad5223103f46fc38a4d3] Merge branch
'jk/grep-tell-run-command-to-cd-when-running-pager'
git bisect bad d83c9c75e1edebd4ece3ad5223103f46fc38a4d3
# bad: [e3798318b12502ae13a8e35e4a385665e810047f] Merge branch
'mm/mediawiki-encoding-fix'
git bisect bad e3798318b12502ae13a8e35e4a385665e810047f
# bad: [2e4b5dee97cb1524a88f0ee90450b139bfaff07b] Merge branch
'rs/ref-update-check-errors-early'
git bisect bad 2e4b5dee97cb1524a88f0ee90450b139bfaff07b
# bad: [f008cef4abb2a4db766b4a152b304aca91a0101a] Merge branch
'jc/apply-ignore-whitespace'
git bisect bad f008cef4abb2a4db766b4a152b304aca91a0101a
# bad: [bce14aa132e0064d9a9b1c7ad98e71e22c6e0272] Sync with 1.9.4
git bisect bad bce14aa132e0064d9a9b1c7ad98e71e22c6e0272
# bad: [d7172825321369cb951dd7bbfc0c12dc4ecbe518] t5537: re-drop http tests
git bisect bad d7172825321369cb951dd7bbfc0c12dc4ecbe518
# first bad commit: [d7172825321369cb951dd7bbfc0c12dc4ecbe518] t5537:
re-drop http tests

I think this just means the bug has been present since at least 2.0 (I
never checked if 2.0 was actually "good"; that was just as far back as
I was willing to go).

I didn't try to track down where it came from, though.

P.S. I was having trouble building master (something in the linker
with _false_but_the_compiler_does_not_know_it)? Revision 1ee85f0e21
(The twelfth batch, 2025-05-08). Log at
https://gist.github.com/benknoble/a8bdc272f44673e115f8b3e57d62e4f6.
P.P.S. I was flummoxed for a long time before I realized that "git
bisect run" sets GIT_DIR in the environment (checked by comparing the
script's environment in and out of "git bisect run"); is that
documented? Intended? Made it harder to drive Git in this script (see
"unset GIT_DIR").

--=20
D. Ben Knoble
