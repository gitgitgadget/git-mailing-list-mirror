Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F107261C
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770062470; cv=pass; b=NHYCGaaIJIEcEChHsbDxffElhlivuKkHQyAiSgg7wFI2gymmolXjMP1dM+2AmAtf2eAlrxFxm2X74krCaGNdcT/wErg6TCLsKM9MGtMFH5CRHoal8N82sDEVRVrRr+h7FY9GLHO5lxt4nyovwTB7jG4onz2Mh8I/wgy5zr7+ZGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770062470; c=relaxed/simple;
	bh=Zu/NLuH2tBj32MsUCSOdbg9qdPd15cvvL1Bbfm/gMew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMz7WYnTiL6OBYEkfuiMMP9KOKC8T9A4oUYlUVZWyojBHexacSZyMtmn3X2ZVWYxYz3+ndO0uB+bzomUO5dni1S78NVilw58an1jpLx+Xo00gWYBY/VFMp6WHEfO0NM0gas+FhzvQprg9dbaQqyGSaJ8kbJ6P5cYrfjlMJnr740=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRYOZlYm; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRYOZlYm"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c21417781so2507524a91.3
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 12:01:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770062469; cv=none;
        d=google.com; s=arc-20240605;
        b=FSoffnBLlkxUXkN/7uawU3ZV3wufk5LsM/diNHfcVsMd1fhEAn+ET8egUxKV7dNXgC
         jWr95gCO4c7QC23BRlZL2EZma07oELVaXILFhaVi95kWA8NVMcKNTMX0yDNiN8SARlxK
         pfUovwb32dXrECcJEMUlCmn5EsA+XAGzzwBsRNimKHB/6GX/Gp0TnD5t8Cv0ga5BAGN7
         BFPP9uROh0oypLkPE36R2ZXDJ911GNlSJ3C6h8UtiFIZ0PDlf2Xp2+AebklTWuHd9Jyn
         H+2EZ3pNlsi/OCYsG41n3Zjo8t5KZtCg9CtT8hZppzUpKCTC1z8MnUxFjCMWw9l3v4qt
         23MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EVc/5f9MnCLlC9pUzIyzSqoEJH/cNxtthyvArSPwMxY=;
        fh=kud2QCBUESDoweLTDYivbcmQeKnY5vck4e/wP7UKJcI=;
        b=Me3X/SCRnvJp0GVBKgCHLbvspr4ZVzbLJ9M7MT2WrNdx9KNMpOpuxtFD8RV1aY1emX
         hqwLCiswPzeMLy92zwhjhDmYNDSQCxSCJ2xPWB3OOeus+PnpXLQZDUhBjafUGypM6X3E
         BMAM2vf64iKtMMNuZJyJfZ3skfRhl3qOAqtJuqdfFav4Wz26482ONjWbgt+yPxotFEar
         zPT3K3y7AfSjNC1mm+QT3ObJUYiG8/jwOaWTr3f0NSD4/b3cQSUXabB1v+mMEPRJjXpI
         4dVDLbRvfpWdf+ye2wZse1viILjk9XxgFbZ+TbHNlUi/Ca19Y71ZAAQm7HuU0T5yq0pu
         iirA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770062469; x=1770667269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVc/5f9MnCLlC9pUzIyzSqoEJH/cNxtthyvArSPwMxY=;
        b=QRYOZlYm1G34NCSk4EvHjVZd/tGE4NOGl70+fXdG1e52SC5c4yyMZKJsL4NLujEBrY
         Sqmih57mqroxCnLy4zzYxM/H45JBa85fmx1Xneh2ytVzfpMZVx2JKb1FaTbY7v0SEVY4
         UwttcS+Fyp7Uc4ieg34GGcSRRyAkTK/r7EgvLE7pJYEJ2E8ZT+aTkLbJuvkjfuzteC6S
         aMnf3VFhFahKy535kmevvvjhOx5ePNFZxHKxh1kSwywcoQZZSgMMu2uUuwZnRCLrJ4mN
         7/zs8+LcRb7eYJ40gjIclO802dkpfGZiqJck0hTyl6huKgnPygJqSHQObx5HmvEqqIcx
         3bDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770062469; x=1770667269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EVc/5f9MnCLlC9pUzIyzSqoEJH/cNxtthyvArSPwMxY=;
        b=RkLytqZlnuwxBIqJTw2rLrKIlAgD0efEJ4QULp6FBvZcP+SUR/IvMCSSiQfikFMcB9
         7KKW2mbwcjvGMN5gwUYQURGAWBlsgw/hhRZJKJkIjw9GlISE6iayJG2cfSvFuBcK5gP5
         tMOn9sxevhzVoZoUgqXVQlY3YWYmN4vQjWn9IOZNaTP9wbvQBlE9FSv5p44aQC2WmXEz
         2yyQh0kNZl6gdskE921zz8K+G51pcfjciWoYlZEtdEQGL1dYW7ttG1Nwk0Tu+ZjjV+Sg
         wYKNTcflSzmaX79muOrevjU+emjyN2xnsog2GNmVwejgn6De3rNJaeFYEIouvBwT6Dqa
         Xrlw==
X-Gm-Message-State: AOJu0Yza292u3viLzdNccbATkf/aoJOlUL6iS4WYc8UV1teZh7bzL75h
	ClzPPiZtqsR6r02ERxhtNNUYp4KiahhY4Rrzk/xt0yS70Aii+tc/e8WpITnk+YQ6fOCI9LoGCMT
	y9Fz8rpkaV99RedknPmARFCVhh6bMURc=
X-Gm-Gg: AZuq6aIryN8p/GJcPT/iteGZYGc4oiMKVTVrFDFiMuo0s9MtMTZ0M/2R3jR66skM5eg
	0Osr05Q1aae6fNXvbb5XbetecrjEvfPyg/1hnMfq24TTs/FUkouhqTu50OHps3dCIkv8zHNmOcf
	1xII/y5qMDF6FTP1J+tURU0zZj/BegkGOL5zzCJH3RLXXuVPy7JiPEzPhatuUc2O5+tAQ+NtHb3
	T5lOqOFSBN6pxASmVAR13o+bopjPJiAGM9RaQ+yUdX08DiEWDWelKi0LQwp1vc/ptEyxk+tl4Wz
	/tTw4AmFUdjbJ7SMY13wz00cnQCqGiKJ67Qc6uF7jJRMWCzOQbNxt8RTHWUlLK0VHOJ2
X-Received: by 2002:a17:90a:d40d:b0:354:5ac4:2d5c with SMTP id
 98e67ed59e1d1-3545ac43a26mr6029838a91.26.1770062468529; Mon, 02 Feb 2026
 12:01:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202131921.15175-2-pushkarkumarsingh1970@gmail.com> <20260202162225.35206-3-pushkarkumarsingh1970@gmail.com>
In-Reply-To: <20260202162225.35206-3-pushkarkumarsingh1970@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 2 Feb 2026 15:00:57 -0500
X-Gm-Features: AZwV_Qh9xkGmNC_CWhQwuoZ2YGesMK3ClKCDYhrRWsRGafD7YgPReD4x6v0j8Rk
Message-ID: <CALnO6CDQiSo7QYnjUmwxgRJJ1=A15JZ5TTWaHKUMgfiMoJHsww@mail.gmail.com>
Subject: Re: [PATCH v2] stash: honor --no-overwrite-ignore with --all
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net, 
	karthiknayak@gmail.com, ps@pks.im, kh@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 11:37=E2=80=AFAM Pushkar Singh
<pushkarkumarsingh1970@gmail.com> wrote:
>
> Teach stash push/save to avoid -a cleanup when --no-overwrite-ignore
> is given by downgrading INCLUDE_ALL_FILES to include-untracked.
>
> This fixes ignored files being incorrectly removed despite
> --no-overwrite-ignore, and removes the stash FIXME by plumbing
> overwrite_ignore into unpack_trees().
>
> Add regression tests covering both overwrite and no-overwrite cases.
>
> Changes since v1:
> - Use OPT_BOOL correctly for overwrite-ignore.
> - Fix stash -a cleanup when --no-overwrite-ignore is given by downgrading
>   INCLUDE_ALL_FILES to include-untracked.
> - Add regression test for --overwrite-ignore.
> - Adjust no-overwrite-ignore test to explicitly use -a.
> - Add Signed-off-by.
>
> Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
> ---
>  builtin/stash.c                    | 14 ++++++++------
>  t/t3905-stash-include-untracked.sh | 16 ++++++++++++++--
>  2 files changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 82d10520fe..c3ee33cce1 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1858,9 +1858,7 @@ static int push_stash(int argc, const char **argv, =
const char *prefix,
>                 OPT_SET_INT('a', "all", &include_untracked,
>                             N_("include ignore files"), 2),
>                 OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore,
> -                       N_("update ignored files (default)")),
> -               OPT_BOOL(0, "no-overwrite-ignore", &overwrite_ignore,
> -                       N_("do not update ignored files")),
> +                        N_("update ignored files")),
>                 OPT_STRING('m', "message", &stash_msg, N_("message"),
>                            N_("stash message")),
>                 OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),

This doesn't apply on top of, say, the master branch; it looks like
you generated this patch on top of the previous version?

> diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-u=
ntracked.sh
> index 9c5421cd76..a979831a64 100755
> --- a/t/t3905-stash-include-untracked.sh
> +++ b/t/t3905-stash-include-untracked.sh
> @@ -427,17 +427,29 @@ test_expect_success 'stash -u ignores sub-repositor=
y' '
>         git stash -u
>  '
>
> -test_expect_success 'stash push --no-overwrite-ignore preserves ignored =
files' '
> +test_expect_success 'stash push -a --no-overwrite-ignore preserves ignor=
ed files' '
>         echo ignored.txt >>.gitignore &&
>         echo before >ignored.txt &&
>         git add .gitignore &&
>         git commit -m "add ignore" &&
>
>         echo after >ignored.txt &&
> -       git stash push --no-overwrite-ignore &&
> +       git stash push -a --no-overwrite-ignore &&
>
>         test_path_is_file ignored.txt &&
>         grep after ignored.txt
>  '
>
> +test_expect_success 'stash push -a --overwrite-ignore overwrites ignored=
 files' '
> +       echo ignored.txt >>.gitignore &&
> +       echo before >ignored.txt &&
> +       git add .gitignore &&
> +       git commit -m "add ignore" &&
> +
> +       echo after >ignored.txt &&
> +       git stash push -a --overwrite-ignore &&
> +
> +       ! grep after ignored.txt
> +'

After removing --overwrite-ignore from these 2 tests to run them on
unmodified Git, the first one fails (good: exercising new feature and
showing improvement) and the 2nd one succeeds (probably good:
exercising existing behavior, but strange: see below).

Use test_grep instead of plain grep. For example, it reveals that in
the first test, ignored.txt doesn't exist in current Git! (Which is
expected with -a, although should be changed by this series).

For the second test, I think we're hitting a similar issue (test_grep
complains ignored.txt doesn't exist, so while inverted grep would
succeed, we actually want to see that the file doesn't exist, right?).
Anyway, the current "! grep =E2=80=A6" passes on current Git because it's n=
ot
really the right test, plus "--overwrite-ignore" is the current
behavior of "-a", so a modified version of this test _should_ pass on
current Git. I think we want "test_path_is_missing" here?

--=20
D. Ben Knoble
