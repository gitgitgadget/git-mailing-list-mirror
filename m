Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FE929E10D
	for <git@vger.kernel.org>; Sat,  9 Aug 2025 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754750689; cv=none; b=g9qrEo0ESTuqzv4DksBW8JSzp/cv9ucA+8ePgLtNejUfmyTLpWJtfFzWRTyhpQA+T+w5myWgUX7ovJO0r68RA1OycFdZOAbiT6MwWg/LEEf+lQKz7xHUCnlvyWwo6NtZYvTEpOMjwZdlrQqmO3gfYqyVd4e0RcB/SIou81PW74w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754750689; c=relaxed/simple;
	bh=gWMToMeY3yGW6t6ck8a3WVpYZfNcowQJvQ+yWk5xEYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/VTtZ0sE7GwS4/iUPUJzb75NJGnXmICQFIG5QXEBfoFewIBOY7f0eYsSj3UR2DiAWc4yFi9kRyJfKHnYd5dySLU5mTPaB2gO5HkucxJ6OQpCN2vbPTlmR7Fh0p23g5Z8raRmgFa+T82IjL0sjQtgWn/cGU/ZFea0Gp5xHclY7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHxdb11z; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHxdb11z"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so5024856a12.1
        for <git@vger.kernel.org>; Sat, 09 Aug 2025 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754750685; x=1755355485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sCJ6SUWNQPrfsUi5EevCoCT17tXjSIK7IT3hn1ypB0=;
        b=eHxdb11zAL1QlAZpftSku1V1WCPN6f+SI+GVEYNwHL2wBRS/qas8uoKqqZ7AMU0ASD
         gGPBVeW5C8WsXdzvIv5oWz+8aALUqIjBVvlaF68uEECyL/FjATHjZ61GDMq/VKskNjZ8
         n1zjc1VlTgrxqFiUsFWsaKkHPeNbhtkGmUT5Uai8Nt3zuaFWzdmLISUlsBM3zLhFumbr
         bUUtTrVAXOBKHnDyrXBWqld+3McJvuPtVADaOFiyuAzzRrbzyJbTvpPxSbHhKGp+f9jl
         6UN8R8qS9bVYA1tv57KoEzznsCyFfL+nPuimnlHHjTR5tuYki5StwPvYSsLqlWalYTXr
         VX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754750685; x=1755355485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sCJ6SUWNQPrfsUi5EevCoCT17tXjSIK7IT3hn1ypB0=;
        b=C+5jw3MxA3X8OP/rH1TRqezjdj8PpRSeAadSunw0CbteeeWXVwNO+fMjxczOZaig+o
         nOGmst272y42dLq9HqPUD+auirzmkccqOxPk7JunDA5+y2vzmpY+DiL3TBWuCmeuJGOW
         4Kzwc4E5jUxXXDc/gK5z6a1n2RxtrfwtZi3DL5EOtJd2IpPm0tyn6mmD3vDCsGJk1Vt5
         rrSMhjJGEVPblNxgUlGD4tTKwsvgXjpMZOAsYuE+pvM9bU5+dBeBTrbn1zTnodD528Vq
         jeXQ8Ibwm11+F2Brb5r0wwqCvd5z+VNTb6tMfyiu6QrbxlfiOUdQULvmrf+dUQda/1Yb
         7vlA==
X-Gm-Message-State: AOJu0YyZq/Aqv09L5+CC2K+PBP9q7tN7TkTc8XmRZ1qnlRCM8cE0V4mY
	XSn3lfMAYb6vW/3vBwOz3PmWpO5lv8HTYPZ7pVzpCWmwUwpvP6G1j9GwznP7q5ZsT19XN5vCm9C
	IFlc7i9Wzu9RPxdjNmdoBoYY/oJke+so=
X-Gm-Gg: ASbGncup5SVz2Pl4r2yZ2wcnOTvMxa5N8AFlIZsxeiXFvVogQ6dHmceEkvnNSdSeayJ
	UudV2f/fI43HCKXRsZ3TpZRedNVNx9m8FSRBJmpOsda9ukPZjJNTGHF0pL4laW2UoBFEbW5QB3k
	rDThbqdaI3Gz2Xp3b9+2+Q+ro0+iuEh21OcuqWo2inJjOLff3YuvvUwIqYuS4Cp1dyIuBozfBds
	sipe1Jit2FIBsvvJZdBVKCVReF7d8QLhn63T5nqKw==
X-Google-Smtp-Source: AGHT+IECHS1tYUkd5MtBwEg3SvC8pZ1cavJNwk/c7IuSjfzzbwelU9PkPU5BqoNNKSDNocnIWCweVBE5NrwrYZSzrYE=
X-Received: by 2002:a17:906:d54b:b0:af2:80c9:7220 with SMTP id
 a640c23a62f3a-af9c65186e9mr681199366b.36.1754750684390; Sat, 09 Aug 2025
 07:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1950.git.1754674979929.gitgitgadget@gmail.com>
In-Reply-To: <pull.1950.git.1754674979929.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 9 Aug 2025 10:44:33 -0400
X-Gm-Features: Ac12FXxoWISu97sv0lgKOYbA7cah8AhvsVbWeweHyrAjlVUgvuunreDV9vxlgKU
Message-ID: <CALnO6CDnSXpUVQEUJr=dc1ZY6errSv2M=4EmeaOmfDvcifHvnA@mail.gmail.com>
Subject: Re: [PATCH] git-jump: make `diff` work with filenames containing spaces
To: Greg Hurrell via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Greg Hurrell <greg.hurrell@datadoghq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 1:43=E2=80=AFPM Greg Hurrell via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Greg Hurrell <greg.hurrell@datadoghq.com>
>
> In diff.c, we output a trailing "\t" at the end of any filename that
> contains a space:
>
>     case DIFF_SYMBOL_FILEPAIR_PLUS:
>             meta =3D diff_get_color_opt(o, DIFF_METAINFO);
>             reset =3D diff_get_color_opt(o, DIFF_RESET);
>             fprintf(o->file, "%s%s+++ %s%s%s\n", diff_line_prefix(o), met=
a,
>                     line, reset,
>                     strchr(line, ' ') ? "\t" : "");
>             break;
>
> That is, for a file "foo.txt" we'll emit:
>
>     +++ a/foo.txt
>
> but for "foo bar.txt" we'll emit:
>
>     +++ a/foo bar.txt\t
>

A little spelunking dates this back to 1a9eb3b9d5 (git-diff/git-apply:
make diff output a bit friendlier to GNU patch (part 2), 2006-09-22),
so we may be stuck with it :/

> This in turn leads us to produce a quickfix format like this:
>
>     foo bar.txt\t:1:1:contents
>
> Because no "foo bar.txt\t" file actually exists on disk, opening it in
> Vim will just land the user in an empty buffer.

I can reproduce this with

    echo 1 >'a b' && git add --intent-to-add a?b && git jump diff

>
> This commit takes the simple approach of unconditionally stripping any
> trailing tab. Consider the following three examples:
>
> 1. For file "foo bar", Git will emit "foo bar\t".
> 2. For file "foo\t", Git will emit "foo\t".
> 3. For file "foo bar\t", Git will emit "foo bar\t\t".
>
> Before this commit, `git-jump` correctly handled only case "2".
>
> After this commit, `git-jump` correctly handles cases "1" and "3". In
> reality, "1" is the only case people are going to run into with any
> regularity, and the other two are extreme edge cases.

So we drop support for case 2? Hm. I personally try to avoid this
situation anyway, but it would be nice if we could just do the right
thing here.
Or maybe we should consider trying to parse --patch-with-raw output
for the filenames?

>
> The argument here is that stripping the "\t" unconditionally gives us a
> minimal change, and it addresses the common case without bringing in
> complexity for the uncommon ones. If anybody ever complains about case
> "2" no longer working for them, we can do the more complicated thing and
> only strip the "\t" if the filename contains a space.
>
> Signed-off-by: Greg Hurrell <greg.hurrell@datadoghq.com>
> ---
>     git-jump: make diff work with filenames containing spaces
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1950%2F=
wincent%2Fstrip-trailing-tab-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1950/wince=
nt/strip-trailing-tab-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1950
>
>  contrib/git-jump/git-jump | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> index 3f696759617..8d1d5d79a69 100755
> --- a/contrib/git-jump/git-jump
> +++ b/contrib/git-jump/git-jump
> @@ -44,7 +44,7 @@ open_editor() {
>  mode_diff() {
>         git diff --no-prefix --relative "$@" |
>         perl -ne '
> -       if (m{^\+\+\+ (.*)}) { $file =3D $1 eq "/dev/null" ? undef : $1; =
next }
> +       if (m{^\+\+\+ (.*?)\t?$}) { $file =3D $1 eq "/dev/null" ? undef :=
 $1; next }
>         defined($file) or next;
>         if (m/^@@ .*?\+(\d+)/) { $line =3D $1; next }
>         defined($line) or next;
>
> base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1
> --
> gitgitgadget
>

This fix works as claimed and drops case (2) above, as discussed, so
if we don't keep support for that then this looks right to me.


--=20
D. Ben Knoble
