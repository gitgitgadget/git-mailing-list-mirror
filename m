Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FF3303C86
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105889; cv=none; b=IvLZYhRk/w/He56IEbm2rWcVqBUIAN4tDwtFMXdolEOwpfdPKKcqM9shHc1MGmyaVYPNNJ5S7SASF/xYuYLUC+V56zYAwShv7bZ4pn1Ab/nCYYUzel8feuYCK9sDHgovZM10sIxulUEQTXKy2H2V+o8mQpJkY+vTVgsXNrKxlIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105889; c=relaxed/simple;
	bh=q9mYJthdKbJh7lqdd/+J//K9u0qlk3+0C8fTtcguEe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QS2PiTqYVkXUHbSP2r8RcVrclNQ7RXC4RsesIKS9YsXK9EuVueKJdj8yD0pXcAmQrztNxP1GHGTUGuc92oXNuAtXCHR2igmK/OxS+aKsezke+SEFaB4EA+tnAM9/6+ciZ2iwMeqM5lIhHIq8Aj17q74ntQJOiGfcQJ7xlVbHbdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNrkeeW1; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNrkeeW1"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb79db329so11127966b.2
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 10:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755105886; x=1755710686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exNAoVRXG7LQRuOHntq7wPwRrveHmsLK5KiEuGEhEjM=;
        b=iNrkeeW1Fvwf9bXBsdwbAJ+38fcvOWu+QhPQFZ/9h6FNgqwZZ2dNcIMot/Zxdd1HtX
         Jf02MyjjPT2VW7XISS62Lx1c5XWnV8mDEpgMW5/RsDAYpztmvF6ZYrJZnHY7d8JW4rbb
         MMgMt77ywDEVjDG1UCXGK3AWkhLrrQbtu+Og76ARRY/VdJeVtzUia4up1lLU7wRtLheh
         uI70KkHWcj3oFwcjv3BPP+CxPT47laKP6FuohyL5oydEqzpFwylg0qifT75sEFO39Ntl
         KyaJF/+zE9WXCFcJV2gTwnX7q3GBouM35rMCaygIUAfeVNDEmFUFfvfBEyxDyrSohKia
         K9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755105886; x=1755710686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exNAoVRXG7LQRuOHntq7wPwRrveHmsLK5KiEuGEhEjM=;
        b=Sy6K+P0cJddU7ggksyi0IKOb8tKpuzOuFhdfOHWEgB1VMOi+uVjk8q3KdtkZQyGdx3
         GURWucWZzYroGhfGZns+n9OshWsea4OsIQfZnHIvjqdPu/MBTLYZIBZ5e8oSVzgzqkRA
         +x0SQegS1d+oevu5VMX4RmL+9Ai4Dke3qjnNKMB1oYQ2WG291ASFdLuHdAIAnbPSt7Ja
         YI7fENpN51WmB9P5+O5SvIzsTNFCJo8YVYYKVI5xbjHfHCXcGw/MsLXvhFfjNiPsJLP2
         Ku6R+EfPUCoKlvL/5ktNpPhOGwnz+1KCLP3HxQUbk5/0OoZRZG1KIzw2f/dYjAnRk7s8
         ozoA==
X-Gm-Message-State: AOJu0YzUe4wK6n8ZZ5yREBruouiT3jT0z8RkgFYB2RstG8NxuuUA8QNR
	26i/f9nYJwyctwFUOynuFl/DGIfCLEQnWWTJMkBgh27iZSqE6os7FOZVnmccYsa4moPcd3R+3eZ
	t97HPE1s1hO9f0MDY3zn54pLCkjLGkRc=
X-Gm-Gg: ASbGnctzZqAbuWATyI4/DcdRkhtV9vDD4SNIsy1+hipC/uoK1ybqvZ9e6+WvfnmGNhR
	f35MDJIeZN4UCj0IXnQvaVIB8SVdEBGM2UbUBVv5jmtSCqX1jO7iojx2KlITlPHoG4vXaR53msH
	UNA1+5oqjfp85MUSDhmHHqR/QaCvQaXHf7g12QTiJBE1cRuM/Prr7lyRvIkHiIldpHdbzXYEne/
	9f28JwGJGegNbfHlEYIDnoY+6SgAtxdMPMajqMgYGUrGggCBaca
X-Google-Smtp-Source: AGHT+IHPX7L2DPHyfsE1w9Qd2y6/UhE0kocpuJqI+EhEhDSewuXLx+C1szizKoBUZWzcvQx7DskW3vwKDAv01tHDQ7Y=
X-Received: by 2002:a17:906:6a0b:b0:adf:f8f4:2001 with SMTP id
 a640c23a62f3a-afca4e5ef00mr375480666b.49.1755105885805; Wed, 13 Aug 2025
 10:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com> <3f4ab6150692418757c84db64cf6d3d79a654453.1755029249.git.gitgitgadget@gmail.com>
In-Reply-To: <3f4ab6150692418757c84db64cf6d3d79a654453.1755029249.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 13 Aug 2025 13:24:34 -0400
X-Gm-Features: Ac12FXw7gxymXZNBpCiIZxeY8juv249rbzqvmvLkDRe7pWEGAEFTO5VDh2M6sWw
Message-ID: <CALnO6CDpv_Mess+vmvrLFODZq2Ls-v92FEsoP02At+BP1tgXDQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] doc: git-add: simplify discussion of ignored files
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 4:10=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Julia Evans <julia@jvns.ca>
>
> - Mention the --force option earlier
> - Remove the explanation of shell globbing vs git's internal glob
>   system, it's a common gotcha but I don't think this is an appropriate
>   place to explain that concept. There's some discussion of the gotchas
>   around globbing and `git add` in the EXAMPLES section which I think
>   is clearer.
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-add.adoc | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> index 99ca2d0f7e21..0c4ca1794c91 100644
> --- a/Documentation/git-add.adoc
> +++ b/Documentation/git-add.adoc
> @@ -34,12 +34,11 @@ you must run `git add` again to add the new content t=
o the index.
>  The `git status` command can be used to obtain a summary of which
>  files have changes that are staged for the next commit.
>
> -The `git add` command will not add ignored files by default.  If any
> -ignored files were explicitly specified on the command line, `git add`
> -will fail with a list of ignored files.  Ignored files reached by
> -directory recursion or filename globbing performed by Git (quote your
> -globs before the shell) will be silently ignored.  The `git add` command=
 can
> -be used to add ignored files with the `-f` (force) option.
> +`git add` will not add ignored files by default. You can use the
> +`--force` option to add ignored files. If you explicitly specify the
> +exact filename of an ignored file (e.g. `git add ignored.txt`), `git
> +add` will fail with a list of ignored files. Otherwise it will silently
> +ignore the file.

This reads more clearly to me, although I think it's worth trying to
keep the style "The `git add` command" command to avoid strange
punctuation/capitalization at the start of a sentence.

Thanks for working on these :)

--=20
D. Ben Knoble
