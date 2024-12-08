Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F489461
	for <git@vger.kernel.org>; Sun,  8 Dec 2024 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733648555; cv=none; b=DE4uvmPwsp1lrRaOWuFlv0QiQxjDClqQWx8+qVIMYF4mqMk31QRo0CDniXNK4gNDpzMaEnJxyalbKoVxJjjvsqJiOiXPtNdaDTLx5fZY+Ry6Iks0Jif4PBl9gttpPEoSNk7kgbWzXsKZhLbYGVgoza+f2Xn95TpSQfvvEcV3b40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733648555; c=relaxed/simple;
	bh=GBNtDE5xyhH/3VBxJ0al/a7AFsldHKWW8pruRKShkjM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=g+99zIzyofbCImln2j4GMsSb9qPkY5JCeniQKttsBHA07te4RKqrtZIW/2wCna7Ftrk4fEN4eaBHpVG/4VPIik5zwm1nlCD8guVBUZXRzTNObPqJl40tRr5DOhbelbC/OTZfGtooOs9lzxiuv5g+pvmc7o6YFRByWZKpdy6DbEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CC3rZ3cM; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CC3rZ3cM"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a77131adebso1156805ab.1
        for <git@vger.kernel.org>; Sun, 08 Dec 2024 01:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733648552; x=1734253352; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EvvmJKmeZSNWAhgmif/UmzticaICoFYyWhlj7NH3+II=;
        b=CC3rZ3cMVVXCiJd9t5BN3+4ugDTZxb9COLL91n+EfS0rLyPaaMYgk9HjhEeFBRQC3v
         elTgcESiHtzvXArxbpvBqSf+Yk6/iHKL6Ez52JWLNPKjPxkGOVL0iuriC7g5uySucyiz
         qniqLg3dwwr6A0PGW1bRwh6bNYJVvU6PVzH3poF5oLvhT5UEOuDi8ADjxvTsqGt+GNl6
         YmYpW9aQ/9wHy2z7PA9h0YxouekC9FWsnnpuEii2uaxmldgQ5tLWyQhvA4xMw7O9O1kQ
         VyQGvga7xc0UByYEw44PR0lblgTfoH2rjC+X7OAlRfWRLZsHpvn5bwP6kB/CzYTpYekZ
         64bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733648552; x=1734253352;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EvvmJKmeZSNWAhgmif/UmzticaICoFYyWhlj7NH3+II=;
        b=xE7pI9Le2uIJvAi44nEOY5JtjMmteJoIRqpHLpJvvTDoRNoiY+M8KEkrE3vT10Lkon
         sDGTEmtPJVkXmEawsbq9ih7fCQHkF8ZIfyAJi9Cml3j2HEq/dRh78AZl5rZbtWB8pPZx
         uTvIY2xDRkL4M1JYxNkmH2x4eeybdKXlqVyzwgfPzy1JV1/kYVWwQatD22lFb0U90WqV
         PoSHR0nSzatVnXAAQDRTYNeFkD3KG6OthWI+Y0WacQ8iAxIseM07D2mPsBlUuCyI22Nj
         77Vqo6U0zQfaLLltHwbV5AVqmj+gtL9bM6WqQG2m5PcoJ/8T/klP68yK881zWQsFpb4b
         /8YQ==
X-Gm-Message-State: AOJu0Yy5Wou76LJVZBG1zcmtTcEyLHSZ0ZeZWQ3kLhRi+G+N3vyjoJWT
	72qOJ2YiRQIXdayux0wNNNz9X+WXn9KgDiQBFiAHK2Hr3TeIZvBnYx3q5Q==
X-Gm-Gg: ASbGncsig1FgQ1KFgmXnTVior1iaUEhVBaYhSEZeVdilFoQNnzaAxIa2U6+WCStNGiK
	28kWRt549LpFseOtxFOmAtE8Ek+pfdI3qyEZjOk04H0MpqZMRVUJf/xHTdtt/t/P/QjlR2gIoDo
	ybNpQ4A1QO+sODUFIep7ssR0jlRV+Euz1TKz0lvPIGWd5lKiuzzaa1p5+mDZylKxD821kJQ9mpq
	HNbvs+OJlD30nG+xXEQgnMYwuGtqvItCLLeQA7dz7TZUJNQ
X-Google-Smtp-Source: AGHT+IGsO3hRJHuVZXVdk0pUntyzj9oYUaIeEj4ImKXEC9tJdf2hpPugdlPIj6FsFXOFgJ8kOq+o+w==
X-Received: by 2002:a92:cd8f:0:b0:3a7:bceb:d572 with SMTP id e9e14a558f8ab-3a811df24dbmr27768865ab.4.1733648551948;
        Sun, 08 Dec 2024 01:02:31 -0800 (PST)
Received: from kf-ir16 ([2607:fb90:bf0b:c24f:90dd:1923:e54e:b3c0])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9caa29ed3sm6794325ab.79.2024.12.08.01.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 01:02:31 -0800 (PST)
Date: Sun, 8 Dec 2024 03:02:22 -0600
From: Aaron Rainbolt <arraybolt3@gmail.com>
To: git@vger.kernel.org
Cc: adrelanos@kicksecure.com
Subject: [Bug] git difftool "--submodule=diff" argument does nothing
Message-ID: <20241208030222.60e7ac70@kf-ir16>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LYDgjnHh00dDXPAFdLruCyv";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/LYDgjnHh00dDXPAFdLruCyv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I'm working with a project that has a lot of submodules. Like, a
shockingly large number of submodules. Each submodule is a miniature
project in its own right, with its own version history, version
numbers, etc. The "master project" is then used to build all of them
and integrate them into an installable Linux image. This works great,
except for when we want to look at all of the changes from one version
of the project to the next.

As one might expect, using something like `git difftool --tool=3Dmeld
--dir-diff prior-version-tag` doesn't work right. Rather than showing
the changes within the submodules, git simply shows the submodules
themselves, with contents such as 'Subproject commit
idontactuallywanttotypeasha256hashhere'. I don't really want to see
that, I want to see the contents of the submodules.

According to `man git-difftool`, the `git difftool` command supports
all of the same options as `git diff`:

    git difftool is a frontend to git diff and accepts the same options
    and arguments.

`git diff` supports a `--submodule=3Ddiff` argument, which will show me
exactly the info I want to see, but in a massive long diff file that
is painful to read and easy to miss stuff in. So, I tried running `git
difftool --submodule=3Ddiff --tool=3Dmeld --dir-diff prior-version-tag`
and... it did exactly the same thing as what it does without
`--submodule=3Ddiff`. It didn't crash, it didn't complain that I gave it
a bad argument, it just... pretended like the option wasn't there.

After experimenting and a bit of research, I don't think git has a way
of doing this yet. I found someone else on the mailing list mentioning
this same problem, and it was suggested that they use something along
the lines of `git submodule foreach git diff`. The problem with that is
it assumes that all of the submodules are going to have the exact same
version tags as the "master repo", which they don't, by design. Trying
this on my repo results in an error `fatal: ambiguous reference
'prior-version-tag': unknown revision or path not in the working tree`.
So that won't work.

Due to my unwillingness to be subjected to reading massive git diff
output, I went ahead and wrote a script that basically emulates the
behavior I want out of `git difftool`. This works, but it's non-ideal
for a number of reasons (it's hardcoded to use meld, it's written in
bash, it's not integrated into git, it does nothing about the fact that
the git manpage is incorrect when it comes to difftool's feature set,
etc.). If it was just me and the devs I work with using this, I
probably wouldn't mind it so much, but the problem is we expect people
who use our code to also audit our code, and it's decidedly non-ideal
that people would have to install a special script on their system just
to be able to run a user-friendly diff against our code for audit
purposes.

So... are there any particular roadblocks to making this work? Anything
I should be aware of aside from standard contribution guidelines before
sending a patch?

Thanks,
Aaron

P.S.: The script I wrote for emulating `git difftool --submodule=3Ddiff
--tool=3Dmeld --dir-diff`:

#!/bin/bash

## Copyright (C) 2024 - 2024 ENCRYPTED SUPPORT LP <adrelanos@whonix.org>
## See the file COPYING for copying conditions. (AGPLv3+ licensed.)

set -x
set -e
set -o pipefail
set -o errtrace
set -o nounset
set -o pipefail

cleanup() {
   rm "${git_diff_file}"
   rm -rf "${git_difftool_current_dir}"
   rm -rf "${git_difftool_selected_rev_dir}"
}

trap cleanup EXIT

pushd "$(git rev-parse --show-toplevel)"

git_ref=3D"${1:-}"
[ -z "${git_ref}" ] && exit 1

git_diff_file=3D"$(mktemp)"
git_difftool_current_dir=3D"$(mktemp -d)"
git_difftool_selected_rev_dir=3D"$(mktemp -d)"
git diff --submodule=3Ddiff "${git_ref}" > "${git_diff_file}" || exit 1;
git_diff_file_line_seek=3D'n'
git_diff_target_file=3D''
while read -r git_diff_line; do
   if [[ "${git_diff_line}" =3D~ ^diff\ --git\ a/ ]]; then
      git_diff_file_line_seek=3D'y'
      continue
   elif [ "${git_diff_file_line_seek}" =3D 'y' ]; then
      if [[ "${git_diff_line}" =3D~ ^'+++ b/' ]]; then
         # trim off the +++ b/ at the start
         git_diff_target_file=3D"${git_diff_line:6}"
         git_diff_target_dirname=3D"$(dirname "${git_diff_target_file}")"
         mkdir -p "${git_difftool_selected_rev_dir}/${git_diff_target_dirna=
me}"
         mkdir -p "${git_difftool_current_dir}/${git_diff_target_dirname}"
         if [ -f "${git_diff_target_file}" ]; then
            cp "${git_diff_target_file}" "${git_difftool_selected_rev_dir}/=
${git_diff_target_file}"
            cp "${git_diff_target_file}" "${git_difftool_current_dir}/${git=
_diff_target_file}"
         fi
         git_diff_file_line_seek=3D'n'
      fi
   fi
done < "${git_diff_file}"

pushd "${git_difftool_selected_rev_dir}"
patch -R -p1 < "${git_diff_file}"

popd # git_difftool_selected_rev_dir
popd # git rev-parse --show-toplevel

meld "${git_difftool_current_dir}" "${git_difftool_selected_rev_dir}"

--Sig_/LYDgjnHh00dDXPAFdLruCyv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCgAdFiEEudh48PFXwyPDa0wGpwkWDXPHkQkFAmdVYJ4ACgkQpwkWDXPH
kQkr5w/4s/QH0wV2mlKphT0uF9PuNDIpeVkgbD+B0W+Su4uE835FQyu0Dahv8GZ6
G4nL7vo2BanfeL4i2pwm0gDd5EssyII8TX2la8xHCq4O1kJI3n3hlhn3aNeNqNUI
/kuddNDoDcC1FJHe2Lu8YL+9QSc/uln87O8RtRrSg9OzylqYYYYawvNTDNn8yZef
1xYeEmiQDMAHpQ7+jrL9arSK3J8cbv+93wzECtw2FRY3pKGT9Zwlm8wByf2gIgNw
37+dDR4VGuBBwOo4e+QdbtiiP+vCM4eJTwQdEksiIxgprS2Sbr26T7VxsG0RFZR0
eg4SoMsQGn5xwEVpj4M9GeXSbl5wkMhAf5KqeI+23XnrOQ/7jvLqahMLfVqp59ai
czOoD0gYX/s5Y3tSLLfMDbiB2RMR7ldKADdMoFej+3ybnm2spxmzeEpsHtQMPREC
u7UR0gQWes1f7FJbqz7qq9rV9tDeKPddT7PMa6IxJLnumN0JVLYpZZ4QQkJYzOXr
7O7TsQf37MjkSrWur9eFJVUeOAaSFymLqIzoRN5uygb6UMx/Q1QBFdBmwOW/+y64
iICO8DDEpzAMSqm07YxOk0OcDtVk831yUWH8UBYXsHCdHLXdPDQZ3THJ8oxuKubD
VkVnzArLI1M0DdgMYNvdsFht7XiLpRgGbZzdz6vpa+AYctKGew==
=+UNd
-----END PGP SIGNATURE-----

--Sig_/LYDgjnHh00dDXPAFdLruCyv--
