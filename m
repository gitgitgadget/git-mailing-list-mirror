Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7D3152517
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676999; cv=none; b=h5CpLMJ/Um7JgsSj1oGT/Azgj/UEqQOJpIdP+wxdueDdaL32WZr70rzeJX0PSLGEx0896b9WWYxqbGUNa14nYMNhBtY/bbyR+4QLc4JB7SqM+QVfIj0uvnf1gLrqYlBBEt9B/FdjLjLNGVEljxLEK3I3sF+5X9o+hOzPJ0linds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676999; c=relaxed/simple;
	bh=Nt0qEA4H9XOM4EMLOafKy6wtKnvvlv199GhPyI9/Kmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1p8AyW0OX70OAuhHjM6jiovX0mKqLoL1Vp14ze+4mpMRP0brEZxUpvGqH6gskzTIskzH8fg5ynlysDOY0BWvwddo1GmH1oC4rBqeChbw91KgBrXz3n0EY6y6s2m5Fz/PfjacbPhmZlIGphjHLvAZnbflhWY8EKP1ArUZJTkD7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L14GZEh2; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L14GZEh2"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so889777566b.0
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 02:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729676996; x=1730281796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvN66syVfvxoQz4bzQrsE5HNzpXW7UFjL8XeMIQlVlc=;
        b=L14GZEh2COdFf6rB+ACxS2LsrJKkNusO0uYkUCpu6xVsM0zZabg8ugFQ17+/yCSMON
         gxRn2LPzGbP9f2M5gmboVRszqIniKEewKC3J1FQGdbJ0Bqq6iziNdy0qIG0eW3PwewFN
         LdPfGZfSX/hqb4LyAZ0ZJUsUumgnxv2GRLR5B7BgOFfIltQCTq6yTIBtsY2jgz8/1OHe
         Is1ZbUBgHa7YlsSjr1gXdZAd2p5Kbw8DiDpBjcuhbytYyYW79kCAOQeXi5+ATZBQa4yc
         Ae5ilD5a2otqgUjMylm7AVoZQ7YKrM6Jq9TvL53j3Bi4z2W2/UYW320PpbOjfSGN649C
         QQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729676996; x=1730281796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvN66syVfvxoQz4bzQrsE5HNzpXW7UFjL8XeMIQlVlc=;
        b=VOUq0Jlf1rsA3eHQnX++j2BE0OAcE5HE3ABu1RCGTJbfCYWDulGlcVxWlj5nOjw3JN
         uDJhYT2+20tBLLHYfJWCYXt75n3Y9Z5twxeMijX6ctMkoHGL9iviM46/GZyHkHrMmn3N
         f7E8K4D9jqLIWeN6dFOmvxalUgU8PtWn85V4Z7bwaKIw3Jy4g9LJa5eVNe1kWEHxzdoa
         mfDEGixO0pr4ss0sBt8O7XvhoLMHIFCgyDxkAm2ZnvoQ0w0iKM0LaYoBlAFtuvwCo/v1
         iTdCqGQt9vA/KgT51udDQA9i09wklzXlFXM8kYI5TYGmLhDqr6w0pR8n5yA6WGep04pC
         VUNw==
X-Gm-Message-State: AOJu0YxS83Bh3/jQ7KOMs2/iwW5zd1oFDlcOy1LXPy1nXC8o6zron/nN
	toNvKFd/yHBIiyp7b+h7x35H5QerarOUja86vviilr4YHP1TxcLpmgDUEkvZwTGitJm+WXhp2m/
	gzcg3i9VHO6V6rtCb0vfXs9x8znQBRA==
X-Google-Smtp-Source: AGHT+IGeVET06JtWjiI9cXUOvhO2P3vaSTjlWYoRpM8B9bl33iL1LgdBtJME3mwHlzc3OKCiupaZKo7GLHvzfv/ObBA=
X-Received: by 2002:a17:907:9452:b0:a9a:3d5b:dc1a with SMTP id
 a640c23a62f3a-a9abf869709mr193450866b.15.1729676996033; Wed, 23 Oct 2024
 02:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240926013856.35527-1-eric.peijian@gmail.com> <20240926013856.35527-7-eric.peijian@gmail.com>
In-Reply-To: <20240926013856.35527-7-eric.peijian@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 23 Oct 2024 11:49:44 +0200
Message-ID: <CAP8UFD24jDT1yFNTp-T==-avccd4QjrwRtfJ_-wPx78H31VSiw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] cat-file: add remote-object-info to batch-command
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 3:39=E2=80=AFAM Eric Ju <eric.peijian@gmail.com> wr=
ote:

> And finally for --buffer mode `remote-object-info`:
>  - Receive and parse input from user
>  - Store respective function attached to command in a queue
>  - After flush, loop through commands in queue:
>     If command is `remote-object-info`:
>         - Get object info from remote
>         - Loop through and print each object info
>     Else:
>         - Call respective function attached to command
>         - Get object info, print object info
>
> To summarize, `remote-object-info` gets object info from the remote and
> then loop through the object info passed in, print the info.

Maybe: s/print the info/printing the info/

> In order for remote-object-info to avoid remote communication overhead
> in the non-buffer mode, the objects are passed in as such:
>
> remote-object-info <remote> <oid> <oid> ... <oid>
>
> rather than
>
> remote-object-info <remote> <oid>
> remote-object-info <remote> <oid>
> ...
> remote-object-info <remote> <oid>

[...]

>  If no format is specified, the default format is `%(objectname)
> -%(objecttype) %(objectsize)`.
> +%(objecttype) %(objectsize)`, except for `remote-object-info` commands w=
hich use
> +`%(objectname) %(objectsize)` for now because "%(objecttype)" is not sup=
ported yet.
> +When "%(objecttype)" is supported, default format should be unified.

I think we should warn more clearly and strongly that users should
take into account that the default format will change. So they should
better not rely on the current format in their code.

Maybe something like:

`%(objectname) %(objectsize)` for now because "%(objecttype)" is not
supported yet.
WARNING: When "%(objecttype)" is supported, default format WILL be unified,=
 so
DO NOT RELY on the current default format to stay the same!!!

>  If `--batch` is specified, or if `--batch-command` is used with the `con=
tents`
>  command, the object information is followed by the object contents (cons=
isting

[...]

> diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-re=
mote-object-info.sh
> new file mode 100755
> index 0000000000..6826ff7a59
> --- /dev/null
> +++ b/t/t1017-cat-file-remote-object-info.sh
> @@ -0,0 +1,750 @@
> +#!/bin/sh
> +
> +test_description=3D'git cat-file --batch-command with remote-object-info=
 command'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +echo_without_newline () {
> +    printf '%s' "$*"
> +}
> +
> +echo_without_newline_nul () {
> +    echo_without_newline "$@" | tr '\n' '\0'
> +}
> +
> +strlen () {
> +    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
> +}

The above functions have been copied verbatim from t1006-cat-file.sh.
I think this is worth a comment or a TODO before these functions
saying that common code might want to be unified in the future.

Maybe something like:

# TODO: refactor these functions which were copied from
t1006-cat-file.sh into a new common file, maybe "lib-cat-file.sh"

Except the above nits and another one I found in patch 4/6, the rest
of this patch series looks good to me.

Thanks!
