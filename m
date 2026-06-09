Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7FD31E82A
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 06:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986562; cv=pass; b=jiReh+CKE0+x9zET0pAh8zxVjDT4MAxS5WWV5uQYv54zZyNFz2JlwRpPbTy9/OCElPLODZ1aCVm2IN5K15ryeXTlnL3Z815aibI8ZUd/bf2Den+KHiC5LKzwMMr0hqGU3u60G1rspPsYgkObucpERFR5NFJH/RkvB4DONNh9lA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986562; c=relaxed/simple;
	bh=gcmrCLx/IfewgT937RirmjSnhaX3jBMIuQ7Mp9XT1Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Snp2g/5XxoqlOc9Xt37jRHXB56n5F+ibxiiRND/QKRpl+/OVoF/GJ7xrmt82iprxO4ebqT3mYWCtSSBZ5NRbKh1VJbVBJu1WLxesjI/1Qc8Sr83Pp3H3yLnFbOoEDy4+6yMfxOuQXFfgbbZX3Z1cdtCmwhM3I0mmqSbT50pWRMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZ+/JZwo; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ+/JZwo"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-68cc6c7df99so7350200a12.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 23:29:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780986559; cv=none;
        d=google.com; s=arc-20240605;
        b=GSCzS8eeo/S4waVj2S4LxyqGIUkFcoklXyD7MmSmV7QOFWwjYtafEjfZAKwuHMNqen
         RgV7eMj+4Bo2NwIh30x3hMSKiPZQoNBP9Qd9uwoFrgUAzc8fIPXqf8dE4nlJV4KSK5+2
         3rWZUv5D3y3F0trN1KGD8UXN8yBN6d5DTny/WbqIaq2WvtM55RS2AxZgo4ubhoeFeRT1
         REC+zpnUj4NPYwJuf3e+7WxwWseKNIdiYUNliThjwmDV+Y4iSaokRd/ub5CRA42zSxB8
         Yfm41r3wX4neimz4/3/zov+ZEvceu0bywunwqXGarbaerfdF3cUNQBKCoqdMS/MHdr8j
         7Blg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xF9jj58oZ+94VKnaDdZJbbWJQ5EZq7/6eSbtUJnPThs=;
        fh=uRdAhoxHxJmXOlW80cbu0Ri0cKjE+m0eeU1API3EEhg=;
        b=CPjTq7d1Gbq6X//9PaLhtjhSOZ+afgnNus59LZ0LDxOb/8UVkhYQ4HnXNzpaHhvK02
         gBHLiEHf1u3b6Ol7XFFuha3UuCIgukKL+6rPscKPdP/nBbGCwiqvQE9cUMt9awu/4HPM
         5UfWUDrCxaXZRAO09RD/Lpc6BqYebA2epHOnNXCeWOG1Dabvn96oYlc2CByAIBnDiNQM
         c/Opd5LAUvLKfXXGUm7BFdTB1ssfeegt5iUsSigMGWbPaiKQtj8BMPQKjh7evFmz8xk/
         lYVK/hC9sP17/QI3dG/MdYl+95RysxuYn4OWpzz3XasT/XTA6XHWsNh0uII0h791kp0a
         MTqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780986559; x=1781591359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xF9jj58oZ+94VKnaDdZJbbWJQ5EZq7/6eSbtUJnPThs=;
        b=bZ+/JZwo/7IR0izZd7tkZgPRWasZfoat+DZcfhJSd33nIS62vGJqbAB8W1WctRqp49
         RlVs1FVAgmSPF4ABLsE17duT3pKBuCB/U/qKZ5RMLUOaumi1t6ck5NFdJUbxpIaHDyFF
         N7ddNfzIgJI4ljVhiWNWcVJHqukERv3j4Fer0nXbxagHbwt5Kdow17b8nIceA9EWOqaA
         bGtFA/i9HexUmjcBDHCnaM3aD220Dz4epcZeIH7CjK+p5q1vGlXdXB6r8G5Sb3auXlZQ
         KRhu6ad0DesE73r5jx+QfxG8t+pkzZkvOVh2+eHdUum5XockqEm2OEiGpx8NKwtp5e12
         Y8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780986559; x=1781591359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xF9jj58oZ+94VKnaDdZJbbWJQ5EZq7/6eSbtUJnPThs=;
        b=hj41uP8tZCJJU9aLaisn0qI+bcKIE9ERtrIWPRaPselO3kX/lo4YuJeUl6KTq3cfRH
         HQV3dn2AJ+/E51W3aaCDRQbm5zV8lGQMtVO/SBKCmdO6QfL9L2iHdTT7F6GsfUt55fHX
         /EOGDxgXLlW1HXfHCaXbHJ3taeMCdz/FEnorg2zLuBbalNdx7uIYs4vlAirGshMInkQR
         F7dkCaTOom1dU3hc8PvZTey1ytWsM1uhQ80DZpxbVqrrGAAQ/tQD4kPPntmRITlAa96D
         aw6AXO+Yrp3N2JOCqJwYUBrTBMKFbQttjYbkd0u+0CHax3EcmsyhepR55oMBsLI4JGY1
         XiRA==
X-Forwarded-Encrypted: i=1; AFNElJ8lnLv9QthA8kbXZ9p2WBnc0DkKyNfn/eOI6z9Xmlhn4f3xuzjAyilzY4xpnAEghim+Ji4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlyDANV+uUFXfdEyeAtYvED1PPVQF4hKTemzF44cUKoGTWVdyb
	OTcVTAQu8f8MEHeogv9XhqhkgdeTBJ46cSuRH9yJj6sTa9SZ8vFeJxgBTfbRyJ2+a7g21ubS3Q9
	mXR48EAiaK1H7NgXBj4gW5QsYgz7c2fA=
X-Gm-Gg: Acq92OHB0KSUzQ/xhcNUwYbUJsvuRLAFYd2avi44Rdz5ik9Bu6+ixDUHmPKK46mPO+Q
	Yq7cfO/tK8yGurlY1TVFZnOOvjHFNps202M+tYKH7rP37iIzR38v3NxfIr202899xbKb84EAMt+
	FUYs25vGCFCzZiFt4UwjipDMnkm7zBoM1ihoTEUTMx4bKp95rCBHjAVmJe9s/nBFvmCataBkCWw
	BT5vx+ApCaki/gL3iLHPn961WcoA5JW0P766etUvBDUMNtWC8BsKpfHq5DxYvrj2/bJnKoBV1Zr
	IkNaQbNtpbwNqGmLZll8iBDTDjzBoOWsu2UDiXJfV44pjRgLDXaOBa7clTIj9twAvqpjvezy3tz
	VVc7SrA+AXVGus6OLF3ulRxL2KL8=
X-Received: by 2002:a05:6402:5305:b0:66e:cf8d:6970 with SMTP id
 4fb4d7f45d1cf-68fa514fbf6mr8804712a12.20.1780986558873; Mon, 08 Jun 2026
 23:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221190451.12536-1-eric.peijian@gmail.com>
 <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com> <20260608-ps-eric-work-rebase-v12-4-5338b766e658@gmail.com>
In-Reply-To: <20260608-ps-eric-work-rebase-v12-4-5338b766e658@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Tue, 9 Jun 2026 11:58:51 +0530
X-Gm-Features: AVVi8CcbKa4_DhxFqrmpg3k9F_NEwduNNKyz671Tw7yffHmFq6FAT_buVnisKqE
Message-ID: <CA+J6zkQe=K80QUOH8LwXCRw9nxv3tHBg+FtfDsYedY5xdHW79A@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v12 04/12] t1006: split test utility functions
 into new "lib-cat-file.sh"
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: eric.peijian@gmail.com, calvinwan@google.com, chriscool@tuxfamily.org, 
	git@vger.kernel.org, jltobler@gmail.com, jonathantanmy@google.com, 
	karthik.188@gmail.com, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jun 2026 at 15:44, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
>
> From: Eric Ju <eric.peijian@gmail.com>
>
> This refactor extracts utility functions from the cat-file's test
> script "t1006-cat-file.sh" into a new "lib-cat-file.sh" dedicated
> library file. The goal is to improve code reuse and readability,
> enabling future tests to leverage these utilities without duplicating
> code.

Hmm, seems like a premature change to me. Do any of the subsequent
commits require this refactor? Maybe the follow-up series that enables
%objecttype support needs it? Did someone request this change in v11's
feedback?

If any of those are true, I think it's worthwhile mentioning it here. That will
make it easier to determine whether this change is truly necessary.

> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  t/lib-cat-file.sh   | 16 ++++++++++++++++
>  t/t1006-cat-file.sh | 13 +------------
>  2 files changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/t/lib-cat-file.sh b/t/lib-cat-file.sh
> new file mode 100644
> index 0000000000..44af232d74
> --- /dev/null
> +++ b/t/lib-cat-file.sh
> @@ -0,0 +1,16 @@
> +# Library of git-cat-file related test functions.
> +
> +# Print a string without a trailing newline.
> +echo_without_newline () {
> +       printf '%s' "$*"
> +}
> +
> +# Print a string without newlines and replace them with a NULL character (\0).
> +echo_without_newline_nul () {
> +       echo_without_newline "$@" | tr '\n' '\0'
> +}
> +
> +# Calculate the length of a string.
> +strlen () {
> +       echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
> +}
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 8e2c52652c..8360f3bbd9 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -4,6 +4,7 @@ test_description='git cat-file'
>
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY/lib-loose.sh"
> +. "$TEST_DIRECTORY"/lib-cat-file.sh
>
>  test_cmdmode_usage () {
>         test_expect_code 129 "$@" 2>err &&
> @@ -99,18 +100,6 @@ do
>         '
>  done
>
> -echo_without_newline () {
> -    printf '%s' "$*"
> -}
> -
> -echo_without_newline_nul () {
> -       echo_without_newline "$@" | tr '\n' '\0'
> -}
> -
> -strlen () {
> -    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
> -}
> -
>  run_tests () {
>      type=$1
>      object_name="$2"
>
> --
> 2.54.0
