Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1E833D4E8
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773003430; cv=none; b=eJBn2wUQFJhAqqJLCQvAbR107f6kxFBqG0jY3YwXq9nnJwpCa0mO6/iux81oEDnN0P2XTWYsLH+LTvvS+8lZk20K0+c3vMGQThicWbp+DrI8fyyJZ37Kug1QsuyIMp2HCX/0vt4aWPkpGcwXtdxn377MDdsOQnoR1xSoXAj48Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773003430; c=relaxed/simple;
	bh=QvhFbDKX5iKohscekjFpw0GJu20NKP1nyDN4IFJqyjk=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=E1lUhLSeXoIEMsLfDH+Pf6QiAuuBgEwLmkAJU++rr8sT5lavPdTda0kN4JnkCdPvcdNiG06D0Un0xJhB8rGGU7/UL89svtefQZtcME8G4jNvpCp9nP/UFncPo6kjWGIl+Uuxzg+iVXWThfDRFObxTlpjU4pYn4ONbbw9UzTo7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqYKqINS; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqYKqINS"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-798527f822cso108037387b3.3
        for <git@vger.kernel.org>; Sun, 08 Mar 2026 13:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773003428; x=1773608228; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2lxrK78kRu7vmhzVkTkKbEw4Rk/DDi42XY1/gY//fgY=;
        b=hqYKqINSohXZRUURRAdIiQ1sC4oORnyTqHMLJpxN7mwafuREqwn5dCF1cNaOomwqs2
         VqLoZrnusGB9EtZOI27N6rDk8gOZn+l9Rl/AXdCktQNkF9RK9l9p6/UYTHfOyMJl9hez
         qZe6c+db/UDhy6mXpXG5/tjDPiytLaPF/Sk4xrojecCVDd/o/yle/MrG3tdV6ecHVbwa
         8CURwftUBo3lXhIzf/csUbOwUcNIAjUxsKcIdrkm7UT/xoCkiA5RvFK1M3vWMkQrKmYl
         /+Vo/yvZZzwmywDESpccyIvL2LV3imZ6my9/tA624OyKyV5meYrMR2Jz6A5Dr9WB1TW0
         2POg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773003428; x=1773608228;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2lxrK78kRu7vmhzVkTkKbEw4Rk/DDi42XY1/gY//fgY=;
        b=JgPs43dlgjUHpVR+NKKBJ9EcsP1vOPalbGg13u1118b/m9c5+mx7omEHARIoQaM5sO
         p8YXRijabUve1I51Bo+2eP0QgcaB6ChFfD9vA4u8athy22cIBs/kYF3+p4zp5dhPjMnX
         1GIhk4ZWiL8HjY3Sx7JMal+1ey2Y1emyfut0uVRwA8pL9hI1fIccgsI8LuL23TwMHymK
         VfYBUNpjGeKKjCREBU64OEyuzquNPYgrkQH/V7uUer8WyH0HNcpfuReFpB3MtCNWvbsg
         BwjOLIIA578/8NWfH2dsF3Zsxl3GhWJUgJoeyTeyEqMLdBFh5wzzZr9nw8r9aig8k9Zz
         0SmA==
X-Gm-Message-State: AOJu0YxDh46dkQNkaMonVtGfXI5XCg4nCLgV/g7sdT2IxbFaD+Gdw56n
	/kwtum7Ax+oHsUVwF/UV2wwVvVes5Ma0rR0HBGrRaCMGxzro0pa391lahXuP0w==
X-Gm-Gg: ATEYQzwy6BgMDUpZhuhVtyMEWRnRowWIUexIR8XwcMJE3JOX39Q/+z8W4L8K+c8HDwk
	MTagZezCm0KlFKCSJo2coMFKz8hQN1ALtnQ5fot940dwimBFBr90pPcBPiRMelp8fdF7zJwvz4n
	mo0FKjOPNJO+RiQGwBnXTSl26a7vvncSQAAgWxYfGhNK0MLnVo13CMsM9d5KiWxNt33tDtP8nXM
	eA05BaH0ay10UGlEb+FaKnV3cjYvgwsd4jN87+KiSPraMP5+MrJXE6sojpASKM+fw06ox3xeaDU
	SZkwJsh5OCSHyERLVEryVKvxiyBC1HK2pbpjiOSowysu/2X4k4fLc9l+38rmAIYkrz/GJ+3ogvI
	ABNFeV5MkMkveDxBe/zksR54oWHFOKrPs1APYJkGTvSX0jlxiNOdZpwPG0AZmV2n/q8HUgrAzMA
	NacV8S0KEW+klPLIm2kamAOaBnTcBf0nRoolJx8dlgAMQIhIPUZ8L0VlAssXnmZRuBzCWSSByDg
	MfxrOaPxpfFwAHuhxKJ22oFySJHc8O5BD0qr9TY
X-Received: by 2002:a05:690c:102:b0:798:3a6:3f4 with SMTP id 00721157ae682-798dd741b73mr85730867b3.43.1773003428196;
        Sun, 08 Mar 2026 13:57:08 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90eb:5600:1c70:d059:42e3:6010])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798dec8f455sm37019897b3.8.2026.03.08.13.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2026 13:57:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] quiltimport: fix backslash expansion in patch subjects
Date: Sun, 8 Mar 2026 16:56:57 -0400
Message-Id: <92EC21F4-52E1-4FE8-A1B8-5878D6CC654C@gmail.com>
References: <20260308165531.40655-1-sashal@kernel.org>
Cc: git@vger.kernel.org
In-Reply-To: <20260308165531.40655-1-sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
X-Mailer: iPhone Mail (21F90)


> Le 8 mars 2026 =C3=A0 13:01, Sasha Levin <sashal@kernel.org> a =C3=A9crit :=

>=20
> =EF=BB=BFecho interprets backslash sequences, so a patch with "\0" in its
> subject has that expanded into a NUL byte, which git commit-tree
> rejects.

Echo _shouldn=E2=80=99t_ do that without flags like -e depending on your imp=
lementation, but I wouldn=E2=80=99t put it past echo ;) hence my preference f=
or printf in scripts.

More interestingly, though: do the patch-names or subjects being adjusted be=
low contain such a sequence? They look like user input, so possibly (and we c=
an=E2=80=99t be sure they don=E2=80=99t).

It might be nice to say more about what =E2=80=9Crejects=E2=80=9D means (err=
ors confusingly? Truncates user input?), but otherwise I expect this is reas=
onable.

> Use printf '%s\n' instead, which doesn't interpret the string.
>=20
> Also quote $tmp_dir to handle paths with spaces.
>=20
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> git-quiltimport.sh | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/git-quiltimport.sh b/git-quiltimport.sh
> index eb34cda409..38302d28c9 100755
> --- a/git-quiltimport.sh
> +++ b/git-quiltimport.sh
> @@ -79,7 +79,7 @@ tmp_info=3D"$tmp_dir/info"
> # Find the initial commit
> commit=3D$(git rev-parse HEAD)
>=20
> -mkdir $tmp_dir || exit 2
> +mkdir "$tmp_dir" || exit 2

We prefer to leave such =E2=80=9Cwhile at it=E2=80=9D changes in separate pa=
tches, so perhaps a preliminary cleanup =E2=80=9Cquote variable expansions t=
o handle whitespace=E2=80=9D or some such step would help?

(I didn=E2=80=99t look past the context to see if tmp_dir may have whitespac=
e or shell meta characters.)

> while read patch_name level garbage <&3
> do
>    case "$patch_name" in ''|'#'*) continue;; esac
> @@ -101,7 +101,7 @@ do
>        echo "$patch_name doesn't exist. Skipping."
>        continue
>    fi
> -    echo $patch_name
> +    printf '%s\n' "$patch_name"

Does this go to commit-tree? Or just protecting the output for the user=E2=80=
=99s terminal?

>    git mailinfo $MAILINFO_OPT "$tmp_msg" "$tmp_patch" \
>        <"$QUILT_PATCHES/$patch_name" >"$tmp_info" || exit 3
>    test -s "$tmp_patch" || {
> @@ -142,14 +142,14 @@ do
>    SUBJECT=3D$(sed -ne 's/Subject: //p' "$tmp_info")
>    export GIT_AUTHOR_DATE SUBJECT
>    if [ -z "$SUBJECT" ] ; then
> -        SUBJECT=3D$(echo $patch_name | sed -e 's/.patch$//')
> +        SUBJECT=3D$(printf '%s' "$patch_name" | sed -e 's/.patch$//')

Interesting. I think POSIX sh  supports the ${x#suffix} expansion, which cou=
ld avoid sed. I think it unlikely the =E2=80=9C.=E2=80=9D in the RE is inten=
ded to match any character rather than a literal dot. But should be done a s=
eparate patch and could be left for another series if you wanted (assuming m=
y memory of supported expansions is correct).

Importantly, this does get fed to commit-tree below=E2=80=A6

>    fi
>=20
>    if [ -z "$dry_run" ] ; then
>        git apply --index -C1 ${level:+"$level"} "$tmp_patch" &&
>        tree=3D$(git write-tree) &&
> -        commit=3D$( { echo "$SUBJECT"; echo; cat "$tmp_msg"; } | git comm=
it-tree $tree -p $commit) &&
> +        commit=3D$( { printf '%s\n' "$SUBJECT"; echo; cat "$tmp_msg"; } |=
 git commit-tree $tree -p $commit) &&
>        git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4=

>    fi

=E2=80=A6 so may need protected as described. Neat.=20

> done 3<"$QUILT_SERIES"
> -rm -rf $tmp_dir || exit 5
> +rm -rf "$tmp_dir" || exit 5

Ditto for cleanup.=20

> base-commit: 795c338de725e13bd361214c6b768019fc45a2c1
> --
> 2.51.0

Thanks=
