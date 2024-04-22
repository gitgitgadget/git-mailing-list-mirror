Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1627C1514E2
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800484; cv=none; b=PnyzpS6kYAnacwX3FuGNBLEoedkgKYF/qRJC82dRJ9SNZlyVUPIOugPsIKEow/EuMhQUR3EVeAZBbyCZFi/mW3ZK2LiNqL1MUFhleAx6YYUcPLt6wm9nOZln2RbfmeBRANjJDneNHPMSVkWTDWNnul8fM6mWgTmUuk7L7Ytx17k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800484; c=relaxed/simple;
	bh=Tk/QjJjKEvrPbJVawRWPTuADBMwzSpXPHEwYVCoBaMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gYl629N2P5A3LiOVsN5PRX1dxtGItOc/cfuvjYMOd48cz3Ux6EcKLa3cLy+MbdV06Fv92jPrQDtF1UMNBz7c/AzGtROzep2Forw8ODRTSU3WkUh87DLfxV8O7odgTijp67u/1wQJ9tTrg5iVHaxL40mqaD61ZjCS9ZL2eyXfW6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECwXhbJE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECwXhbJE"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-417e327773cso30923875e9.1
        for <git@vger.kernel.org>; Mon, 22 Apr 2024 08:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713800481; x=1714405281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dgupXmaE8T7Q8y3d5lEsFBXg/KHZrEhKBYQ/v0lVNwE=;
        b=ECwXhbJENk5eYx/1+kP5Al5fJD6G7Ha+yvzisYhC7uZZG12gH1Ek6pWLbkQpmHa57c
         WhHY461jkREu/6bLwH/+t8Wn/24UGcGqTOUGZu6vlsX/Bl2JUN9fIZ2eolIotTabsCqo
         HQ+0NddqHWEyTL8XKwqK1v4K5lml53cfUyS7q/zEFjO7MibTi8bih6p9JCS1itdDG5Hi
         yeIW3xpmlrdxPghc1F1RyOZPJDLFhERdYlQSukJnI9GWdfxNKxCLJHq1rJqfa7xTR8iN
         xsz8HKMuEQ0IvKfbsx1CcDGdv3REFgrEKKfFBjET5iOCBd0cZa3y96QSMGL7Blr8Zo7V
         1ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713800481; x=1714405281;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgupXmaE8T7Q8y3d5lEsFBXg/KHZrEhKBYQ/v0lVNwE=;
        b=d0pTuzfdBUqkwEPF9WGve3IDGVuSxSd+QhE2tVX/ROdfxddYHF5kS8mbfTqrPrl0jo
         RbIDKQHBjO6gwEU5Mnd1YOE5GyMaA8s8afuyiSXcpXuEYLzLYYhY3O6REIqPVFy0Y96n
         JSLDdYotLNqVtwjhIwNLGimK2T8H1g+V7P0ClXqXnw8WxMIxjlt9amvJUqlw4/PdkEaQ
         k3yWKfo6kzoa+sUfIxOrw4rAUOBE+jVL/CCf8yv6royBG2WvrbXX8t+5uvl129rcfZrI
         DfmvkkrOqXDFk79HuTzo3Gtl55xphP0C1aasAA0LIcKCS2OHa6o92tGfuBROWtQchaE3
         AUSg==
X-Forwarded-Encrypted: i=1; AJvYcCVTZ0tDgxedv4pBC7YLmdNMjrVm1b0kg+1FH/m016A9QfQ9mwW9U3+wH5l4DIy5tVQB8OT7QwrixJoBjuj22YLhEf/K
X-Gm-Message-State: AOJu0YxZbnJsV2F5UsNHsC0yB68aZ5QP6XJVkqYBG9zoFAD6RSmgVm2v
	gsV0nGLzXI8bIukFUiLdxiBsabjWNOcSgTsBjOD2HNHmUEb9ZfQW
X-Google-Smtp-Source: AGHT+IEELV5zea/uTY88SXsJU5qVp/EwYuhv7FoJO7Os+qecV0+EYy9XYZaC63zYijlBrNiy6zqj8g==
X-Received: by 2002:a05:6000:241:b0:34a:5d48:a708 with SMTP id m1-20020a056000024100b0034a5d48a708mr48208wrz.0.1713800481298;
        Mon, 22 Apr 2024 08:41:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:701:9864:4109:be00:6ff6? ([2a0a:ef40:62a:701:9864:4109:be00:6ff6])
        by smtp.gmail.com with ESMTPSA id g18-20020adfa492000000b0033e9d9f891csm12499007wrb.58.2024.04.22.08.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 08:41:21 -0700 (PDT)
Message-ID: <74a6465c-01b6-4a65-8491-751244d37c82@gmail.com>
Date: Mon, 22 Apr 2024 16:41:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] apply: plug a leak in apply_data
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>
References: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
 <8e6ab088-2026-43e7-a869-b1c7185ee765@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <8e6ab088-2026-43e7-a869-b1c7185ee765@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 21/04/2024 11:28, Rubén Justo wrote:
> Plug a leak we have since cfb6f9acc3 (apply: accept -3/--3way command
> line option, 2012-05-08).

Looking at that commit I see

-        if (apply_fragments(&image, patch) < 0)
-                return -1; /* note with --reject this succeeds. */
+        if (apply_fragments(&image, patch) < 0) {
+                /* Note: with --reject, apply_fragments() returns 0 */
+                if (!threeway || try_threeway(&image, patch, st, ce) < 0)
+                        return -1;
+        }

So the leak existed before that commit. Indeed it looks
like the leak predates the introduction of struct image in b94f2eda99
(builtin-apply.c: make it more line oriented, 2008-01-26) and when
the patch does not apply we have been leaking the buffer passed to
apply_fragments() since the beginning of the builtin apply added in
ac6245e31a3 (Builtin git-apply., 2006-05-23)

The fix itself looks good to me

Best Wishes

Phillip


> This leak can be triggered with:
> 
>      $ echo foo >file
>      $ git add file && git commit -m file
>      $ echo bar >file
>      $ git diff file >diff
>      $ sed s/foo/frotz/ <diff >baddiff
>      $ git apply --cached <baddiffén
> 
> Fixing this leak allows us to mark as leak-free the following tests:
> 
>      + t2016-checkout-patch.sh
>      + t4103-apply-binary.sh
>      + t4104-apply-boundary.sh
>      + t4113-apply-ending.sh
>      + t4117-apply-reject.sh
>      + t4123-apply-shrink.sh
>      + t4252-am-options.sh
>      + t4258-am-quoted-cr.sh
> 
> Mark them with "TEST_PASSES_SANITIZE_LEAK=true" to notice and fix
> promply any new leak that may be introduced and triggered by them in the
> future.
> 
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
>   apply.c                   | 4 +++-
>   t/t2016-checkout-patch.sh | 1 +
>   t/t4103-apply-binary.sh   | 1 +
>   t/t4104-apply-boundary.sh | 1 +
>   t/t4113-apply-ending.sh   | 1 +
>   t/t4117-apply-reject.sh   | 1 +
>   t/t4123-apply-shrink.sh   | 1 +
>   t/t4252-am-options.sh     | 2 ++
>   t/t4258-am-quoted-cr.sh   | 1 +
>   9 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/apply.c b/apply.c
> index 34f20326a7..2f752d71a8 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3712,8 +3712,10 @@ static int apply_data(struct apply_state *state, struct patch *patch,
>   			fprintf(stderr, _("Falling back to direct application...\n"));
>   
>   		/* Note: with --reject, apply_fragments() returns 0 */
> -		if (patch->direct_to_threeway || apply_fragments(state, &image, patch) < 0)
> +		if (patch->direct_to_threeway || apply_fragments(state, &image, patch) < 0) {
> +			clear_image(&image);
>   			return -1;
> +		}
>   	}
>   	patch->result = image.buf;
>   	patch->resultsize = image.len;
> diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
> index c4f9bf09aa..c40b661ac1 100755
> --- a/t/t2016-checkout-patch.sh
> +++ b/t/t2016-checkout-patch.sh
> @@ -2,6 +2,7 @@
>   
>   test_description='git checkout --patch'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./lib-patch-mode.sh
>   
>   test_expect_success 'setup' '
> diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
> index d370ecfe0d..144619ab87 100755
> --- a/t/t4103-apply-binary.sh
> +++ b/t/t4103-apply-binary.sh
> @@ -9,6 +9,7 @@ test_description='git apply handling binary patches
>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_expect_success 'setup' '
> diff --git a/t/t4104-apply-boundary.sh b/t/t4104-apply-boundary.sh
> index 71ef4132d1..dc501aac38 100755
> --- a/t/t4104-apply-boundary.sh
> +++ b/t/t4104-apply-boundary.sh
> @@ -5,6 +5,7 @@
>   
>   test_description='git apply boundary tests'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   L="c d e f g h i j k l m n o p q r s t u v w x"
> diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
> index 66fa51591e..2c65c6a169 100755
> --- a/t/t4113-apply-ending.sh
> +++ b/t/t4113-apply-ending.sh
> @@ -6,6 +6,7 @@
>   test_description='git apply trying to add an ending line.
>   
>   '
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   # setup
> diff --git a/t/t4117-apply-reject.sh b/t/t4117-apply-reject.sh
> index c86d05a96f..4d15ccd28e 100755
> --- a/t/t4117-apply-reject.sh
> +++ b/t/t4117-apply-reject.sh
> @@ -7,6 +7,7 @@ test_description='git apply with rejects
>   
>   '
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_expect_success setup '
> diff --git a/t/t4123-apply-shrink.sh b/t/t4123-apply-shrink.sh
> index 3ef84619f5..3601c0c5dc 100755
> --- a/t/t4123-apply-shrink.sh
> +++ b/t/t4123-apply-shrink.sh
> @@ -2,6 +2,7 @@
>   
>   test_description='apply a patch that is larger than the preimage'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   cat >F  <<\EOF
> diff --git a/t/t4252-am-options.sh b/t/t4252-am-options.sh
> index e758e634a3..5b680dc755 100755
> --- a/t/t4252-am-options.sh
> +++ b/t/t4252-am-options.sh
> @@ -1,6 +1,8 @@
>   #!/bin/sh
>   
>   test_description='git am with options and not losing them'
> +
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   tm="$TEST_DIRECTORY/t4252"
> diff --git a/t/t4258-am-quoted-cr.sh b/t/t4258-am-quoted-cr.sh
> index 201915b45a..3573c9147f 100755
> --- a/t/t4258-am-quoted-cr.sh
> +++ b/t/t4258-am-quoted-cr.sh
> @@ -2,6 +2,7 @@
>   
>   test_description='test am --quoted-cr=<action>'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   DATA="$TEST_DIRECTORY/t4258"
