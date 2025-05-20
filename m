Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D11213E76
	for <git@vger.kernel.org>; Tue, 20 May 2025 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732298; cv=none; b=TzcQ6zE2OElSvGE0HL5LK3+2YpxpYiqK58ilS8l+cFEP9/2UY3yzaJhOBDziRs/BxCMNAtAQ8Wnp5EhIjA/Zss1C0QCoJZAohtICim7cFSxNAXsjlc1cVy8lnq20uYDjGgWchcRv+mo4KS38/GwcwR21YaN+bMiKeLqi8qQACBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732298; c=relaxed/simple;
	bh=COXYuyZbhtgzWUqPUIO7jZocB3CS2hmWjHuYd9+/z9I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlxuvRN4H/QTXwNm8mEjr8R2FEkmC+Nkaxjf9hm6UZd70I0cfUMDBAx/KKJlKFq2MFbxzi+6KlDfF3CfWMECE8e5jBtDAlCUpbjXhX+qLaYdHkjwUelL/6AknFSYrgfqAedeuqcahTO41irTVgHFg4ms0EW2LMFhOewfvm+thD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewVkGHU2; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewVkGHU2"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-525b44b7720so1568612e0c.0
        for <git@vger.kernel.org>; Tue, 20 May 2025 02:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747732295; x=1748337095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wlXm4k2EGwO9Jh67scAAD98SZ/lNp3loW5Ih2Xg1PBc=;
        b=ewVkGHU2G1YGnrXWvJDr+PrD/SJQD18NcpLCbQq2mE6FZgZBkduHnmL7UgvpYaDBYf
         mEFRDSNYWSLAvq4iAMnxs3QILxlJdqtz3I5H6KC+mNVOC3u4mqWAFeEoXbDP+A0/rDwL
         +Ut6uTEIhthzRaBJk7rh5LjxVcfJIXI0Z9MAkckeVdGpnsCYpOK1rZ6ScqEYaqO1asCP
         yLfGiJx5htxrYCJN9UXpoIteHsaFOFv+hQ4rI3r4UKOgRGRmNV/d4JWMzs3bcgAKguTB
         GLiiY9tbSLKQht6Z74Z2xIXi8qA0XrjG7s1XdH+mRNJVsKeDJGVXxLj4oXwwW8KzfQxI
         yP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747732295; x=1748337095;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlXm4k2EGwO9Jh67scAAD98SZ/lNp3loW5Ih2Xg1PBc=;
        b=YgQMh+oZX8hr6Sjbh5qHdvgMmtcR4ih+TGpU+nMmxxIhffnWy2p64lwFoLA+bd33PB
         GdVclKBhz71c6L8mMlpRCMqih6ZSkj3zk7yYXMi150TFe/2RbQBvpPkvlz0tBZ6pq09X
         rKrAinS8J/+diJ8Gw3c9Ky8V9L/J5rivAroY/AjNAI1FYb9i6Eeb2QPAJ1IjVIDmbJDC
         CDTVWqpcg0sZ/DeNtAy0D+AqN15cPhB82BFV6szNLPr/d/DjMjLrMxCW7+wbNDjYioI+
         fU2RzQExRk790uZrq7S4TxUcBstX1G1lv995syF0R5/UN5juXLULJBm1Q0/hP0m//cSX
         jQMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXru6g+XE59ff9cWTQeMwkRHvGN0M+UNq9EGQQuchsfZJh20ywzSUfkSVxU95MrbH8fcaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwG4g6Ub5qxMQHwgEeC4hr2pr9Z4q/97GIU2Tt2QIK83Snqix6
	XIxjpCn64jwLyed7n6biJ0aGLVXcyhrD3yDQTRjDZ5vRsmYKwhOPH+9uzX80awmoWbG8EhBNOpQ
	f04q9uFNw5Pg0tPLjhuI7U+8jNcVX8ktLXOKs
X-Gm-Gg: ASbGncs356lVlaAct7MihSS0isC/O6gI5l5HXl+mo4lUzqOOZe5IfX3P/7gnBNLATjN
	Msmap/IKKF4fahnjOKaZwzvrWNkmj0nG6w3EapkNRx7ufnt8F5JeMwY6gfaMwOwSNiaj19jve5h
	vF8nIakKLB9BxsqyeXYNSNktNP6ai+oiM=
X-Google-Smtp-Source: AGHT+IEDcjSe+Dq3ZCqIiaTV5Ri/06dlhlDCZVC/yPbzPYDczTTe/c/z81CAMPER8mPoDNQQlppWqaA7fWLbeX6sNJ8=
X-Received: by 2002:a05:6122:428a:b0:520:60c2:3fd with SMTP id
 71dfb90a1353d-52dbcc8547emr12263972e0c.3.1747732295075; Tue, 20 May 2025
 02:11:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 May 2025 04:11:33 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 May 2025 04:11:33 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250520014920.201736-2-jltobler@gmail.com>
References: <20250507030249.4802-1-jltobler@gmail.com> <20250520014920.201736-1-jltobler@gmail.com>
 <20250520014920.201736-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 20 May 2025 04:11:33 -0500
X-Gm-Features: AX0GCFuRldMOG16ZzfPQL-XGOxlM-J5iu0SbVVqEJRboI8VLO1KyKphQe35Otr8
Message-ID: <CAOLa=ZRz8iAF8DhtMnt_usaWSTxjiHQNprGXES6mRAWK4QTG5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] t5410: test receive-pack connectivity check
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000009c6aa906358da26a"

--0000000000009c6aa906358da26a
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> As part of git-recieve-pack(1), the connectivity of objects is checked.
> Add a test validating that git-receive-pack(1) fails due to an incoming
> packfile that would leave the repository with missing objects. Instead
> of creating a new test file, "t5410" is generalized for receive-pack
> testing.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  t/meson.build                                 |  2 +-
>  ...ck-alternates.sh => t5410-receive-pack.sh} | 23 ++++++++++++++++++-
>  2 files changed, 23 insertions(+), 2 deletions(-)
>  rename t/{t5410-receive-pack-alternates.sh => t5410-receive-pack.sh} (57%)
>
> diff --git a/t/meson.build b/t/meson.build
> index 43c9750b88..6b7c0b167b 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -628,7 +628,7 @@ integration_tests = [
>    't5407-post-rewrite-hook.sh',
>    't5408-send-pack-stdin.sh',
>    't5409-colorize-remote-messages.sh',
> -  't5410-receive-pack-alternates.sh',
> +  't5410-receive-pack.sh',

I think this is much better that creating a new test file, since
currently the file houses only 2 tests. When we do start adding a lot
more tests we can branch out as necessary.

>    't5411-proc-receive-hook.sh',
>    't5500-fetch-pack.sh',
>    't5501-fetch-push-alternates.sh',
> diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack.sh
> similarity index 57%
> rename from t/t5410-receive-pack-alternates.sh
> rename to t/t5410-receive-pack.sh
> index 4e82fd102e..9afea54a26 100755
> --- a/t/t5410-receive-pack-alternates.sh
> +++ b/t/t5410-receive-pack.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>
> -test_description='git receive-pack with alternate ref filtering'
> +test_description='git receive-pack'
>
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> @@ -41,4 +41,25 @@ test_expect_success 'with core.alternateRefsPrefixes' '
>  	test_cmp expect actual.haves
>  '
>
> +test_expect_success 'receive-pack missing objects fails connectivity check' '
> +	test_when_finished rm -rf repo remote.git setup.git &&
> +
> +	git init repo &&
> +	git -C repo commit --allow-empty -m 1 &&
> +	git clone --bare repo setup.git &&
> +	git -C repo commit --allow-empty -m 2 &&
> +
> +	# Capture git-send-pack(1) output sent to git-receive-pack(1).
> +	git -C repo send-pack ../setup.git --all \
> +		--receive-pack="tee ${SQ}$(pwd)/out${SQ} | git-receive-pack" &&
> +

We don't remove 'out' with 'test_when_finished' but that's okay since
'tee' overrides the file by default. Makes sense.

> +	# Replay captured git-send-pack(1) output on new empty repository.
> +	git init --bare remote.git &&
> +	git receive-pack remote.git <out >actual 2>err &&
> +
> +	test_grep "missing necessary objects" actual &&
> +	test_grep "fatal: Failed to traverse parents" err &&
> +	test_must_fail git -C remote.git cat-file -e $(git -C repo rev-parse HEAD)
> +'
> +
>  test_done
> --
> 2.49.0.111.g5b97a56fa0

--0000000000009c6aa906358da26a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 33e115492880e464_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nc1IwUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meVVZREFDaXUxZ1I4RTlrMGFTakNYWnFvczFleHZVVgpsWEVVZzhGRCs1
alpoeExUb0d1UjFkMUhZZEZKdnc5cGNGWHZiRDZQUGpDa3FtOEFaTTZqT0lQNGUvcThXcCtrClll
NkdjN3Z1TVUxdW4wRmVYbVRPY1lpT2J3bmI2WmtIbnNrS0l4QzJCRkJ2RlhFcUdDTG16K094aDRm
NUhwenUKd09CK1VxT2JoYU5UMS84SktQNCs3ZG81eXVkZWQvSW5zMWdMalR0L3FkWkxSVWdlckZW
c3RyaHhmdU9WRkFxMgp0bys4ZUtHdFZJRzRnWDgzNm9jM2NZSE52VlB4dlpGOGJuWFJUV2FMVE1q
TTN2d2NQM2lHMWJiZXgvcGZqL25CCkFiVEJLaVc4OFlLK3cxbEptcHVsTUYwbHN2Z21TTDAyemVx
czhvRkcxbmZHd2h5TDlRem1VZU0xRW0vRFRNV0IKSUxjWXViVVpld1JFaDNUNDhxSWNXLzJ2ZlFn
T01GMDhYNjkwRkNDcFJ5Rm03eFB3NGF5Z0JON1NzRi9CblB5SgpwdnVqbUdvUmswcUxHOUM4TFBq
RTRMKzJmQTdpeXJNNStDRld3dkc4WEpnMmRHSVBGRnZOa2NSbDQ2NHo1aDRDCmViSmhBZ25pQWxV
ZHV0ajIwOUREc1V3Q0hGWk5oZTg3Z3dTcWNoUT0KPXJkdE0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009c6aa906358da26a--
