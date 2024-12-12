Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2A945027
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733998594; cv=none; b=QUid37wxuRDQJJkNEj2YDb5WyvSm3vmaOhCjFO8qTfvNP+FHdFIZQIQjvRzP7zr1/Ksj8ouPZGgzHXABaUyehhEPCUJkgSlLUxUbBreJXgfMflNfAazDyt5fsTgjsTrsYPUrfJTv45p2Yxb3XsTlLdC/dsin7FA8DRsidHz+HAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733998594; c=relaxed/simple;
	bh=3IgaIusAUQRb2Kh8yA9dsM/zyKpQGbuf8cCrt0pRr0I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Y+2RWxlUXUN/8K0fgkgRA8dSs6CwkYrw7OeZUVA+FLXPx1mAA2jFMs3fs/FjEx/r5+L9QK8jKbnfht/Z1Axa3CAvwZKk0NVxiWtLuJ8Zt5r/RGSSJk8aYn76h27QeGXwK2PQd0p3FeWey3DMHnu3G+qrUNydE/bwpsIA9j4mzKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7ZYgIIx; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7ZYgIIx"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-51873bc7377so104966e0c.1
        for <git@vger.kernel.org>; Thu, 12 Dec 2024 02:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733998591; x=1734603391; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IT9EN5zJjvG5FePIm3nK8aUwinEZ5kW+thvWby2fJUo=;
        b=j7ZYgIIxANEraSNv1zgQlfnUESyR6sOFZJLpVg4nZzrnPjULxPKDfKcROhccM6j/aF
         wsuvKc627wtrt0zb4S0ny2NmRjzS3Bwl8NXS/YCT5EuPRv5u3pKDuLp1TIHMEx4iwsle
         JGKosI0ouHnvFiiqg2cqIrLf6TRVbOkKPpBo5P3Gzsn0xMrkCkeu478yu6xR5GuJ0zdO
         EaAwGaoVy9HG1TlP8rkJPJTdpqUHUp8xYFzv6uLQGsdf9hiqihWx6AT0hEvBFGEdHiaK
         oGuZ53DfZmnpFTH7dx7n+br6OgnhIml4Z4sirTBMT7U8qjNuMtdqWaKpPi4m2XGN73kP
         0ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998591; x=1734603391;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IT9EN5zJjvG5FePIm3nK8aUwinEZ5kW+thvWby2fJUo=;
        b=O7j+gKf7ckICnJjO3H6ROf8v98K8BzVamjDdElz6GH1m30CcrggH8clRn7ONzEJmLw
         swaEwPvsp+XuoMX0CjOu9dRwesU6ipgIBkdOvVdxhRy6Z41hPcteHvrqkCUdMcHvAayl
         iIEkLD0ohEAm1YQgWgqtNWwG4pkublWCLfCkbbPRw1ywSp0DxAcTbxcrx68yOGQCkT/I
         lgalOar4vbebP2F7WWyWZEqhCqz+xnQC2qGiDdkpeolR2HZbsazX5IfAhqo0+CI6Pmfg
         rUGjlB338/Ho6pSJSA14x2lkbNMTPHYoyK5QrJGfaHjduEXq3sAwEyztQoUTBbQvAmkr
         KJEg==
X-Forwarded-Encrypted: i=1; AJvYcCXgmQUFLX6jE05JZHPXk4Jl1BbqRaHD4noeCDXhUYrEDg62vB3bs3Ot09+beo7MO4ZyLVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7kvA/flp7WRV1aJQDT6dHiSYq4JoP7FHoQBAD4uXlD3RjMz7
	bGolMIswBzGfaDQPMB6kY4QYOcJh9RrR/lCuO7UxijZ04py8/prLriIaAIBfc0GSMx2EuFF2Kbg
	kArs8kjOx8xPSvV4shY1Y5WqBipYP9WKr
X-Gm-Gg: ASbGncsyz3oLskZ6BwJ9qhuSfMET9CBz9/3j25F6aN11D/0Pkzm3vZDnOdA4uCwDBpa
	KQxO4k0Ot3HAdglCcIYfaC0fcgHTT/EHJxcFR
X-Google-Smtp-Source: AGHT+IElNYoaGPZLb+4FbzXzdm68dKZZRJVEI1gOEdixHXaBXa4I7yidPPgex0m6SYVxfxazLXEIytlRjzm2XZzgDTM=
X-Received: by 2002:a05:6122:c82:b0:516:c0b:8bfe with SMTP id
 71dfb90a1353d-518b5ccbc70mr2185739e0c.1.1733998591195; Thu, 12 Dec 2024
 02:16:31 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Dec 2024 02:16:30 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241211-pks-meson-ci-v1-1-28d18b494374@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im> <20241211-pks-meson-ci-v1-1-28d18b494374@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Dec 2024 02:16:30 -0800
Message-ID: <CAOLa=ZTtkM_unYCjgQf0FZCo=4KOmOiRosC8jPOcs_Np+tCd-g@mail.gmail.com>
Subject: Re: [PATCH 1/8] ci/lib: support custom output directories when
 creating test artifacts
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000011de0106291002c6"

--00000000000011de0106291002c6
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Update `create_failed_test_artifacts ()` so that it can handle arbitrary
> test output directories. This fixes creation of these artifacts for
> macOS on GitLab CI, which uses a separate output directory already. This
> will also be used by our out-of-tree builds with Meson.
>

So currently in the config: `TEST_OUTPUT_DIRECTORY: "/Volumes/RAMDisk"`.
So this is broken as is?

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  ci/lib.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 930f98d7228166c37c236beb062b14675fb68ef3..2e7a5f0540b66f24bd0f5744311c2c48b472d63d 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -180,9 +180,9 @@ handle_failed_tests () {
>  }
>
>  create_failed_test_artifacts () {
> -	mkdir -p t/failed-test-artifacts
> +	mkdir -p "${TEST_OUTPUT_DIRECTORY:-t}"/failed-test-artifacts
>
> -	for test_exit in t/test-results/*.exit
> +	for test_exit in "${TEST_OUTPUT_DIRECTORY:-t}"/test-results/*.exit
>  	do
>  		test 0 != "$(cat "$test_exit")" || continue
>
> @@ -191,11 +191,11 @@ create_failed_test_artifacts () {
>  		printf "\\e[33m\\e[1m=== Failed test: ${test_name} ===\\e[m\\n"
>  		echo "The full logs are in the 'print test failures' step below."
>  		echo "See also the 'failed-tests-*' artifacts attached to this run."
> -		cat "t/test-results/$test_name.markup"
> +		cat "${TEST_OUTPUT_DIRECTORY:-t}/test-results/$test_name.markup"
>
> -		trash_dir="t/trash directory.$test_name"
> -		cp "t/test-results/$test_name.out" t/failed-test-artifacts/
> -		tar czf t/failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
> +		trash_dir="${TEST_OUTPUT_DIRECTORY:-t}/trash directory.$test_name"
> +		cp "${TEST_OUTPUT_DIRECTORY:-t}/test-results/$test_name.out" "${TEST_OUTPUT_DIRECTORY:-t}"/failed-test-artifacts/
> +		tar czf "${TEST_OUTPUT_DIRECTORY:-t}/failed-test-artifacts/$test_name.trash.tar.gz" "$trash_dir"
>  	done
>  }

The changes look good, if the TEST_OUTPUT_DIRECTORY isn't set we default
to `t` which was the previous directory.

--00000000000011de0106291002c6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 921388c9ef933a0e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kYXQvMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mODdEQy85eUcyTWZqQ2tjdjdvZjNiVGVEQnhXQjJITQpocDFBOW1aQ2lH
SE5qZnlLbW9vdmtrRitQVktKRTBnNE5aU2lybWVBQ1M3RzFPYm16WUxLOVBPOGZRYSttaTZjCkwx
MTFlRUtwRnExZ1ZwZm9DTHVRWEZiSkIvdm5EY0FybHBpdmNNTUhkOVpOVjQ2ZVZhSmxjalZhNmhi
ZXNQYSsKOXZPdFU1VytSc3k0Mk02MGdVdWhnSE5PSHAzWnBzMXFRdyt4d29sNStTYjBla211K1F6
andoNGp2MHZUcUZtSQppRHNCUDJtKzNDUndZek9rWENCdVZHWFg2am0wcndJTkhoTlpmaHA4cU12
eXhwcVBqaU0zMjNhYTRLN0RlQ2J4CmtlbU5Kc2ZZNW9xUzVQcDJ3VVJmUUZXRjc1c1JXbk9CQ3JD
eC9YSjMvTjc3alFxb3hXeXNQd1hUeVlIcDAxcSsKVUhDMXdYN2Y5Q2YyeUdicUtFb3U5aURnZy9M
UlViTlhPMXVnMUkreldkNkVHcGtTbUIrRzZ5UXdnSlZDMXFrdQpVRnJlMTlkU2NZQ0h3cXVNVGVw
NVdkSEFPeWMvdU1yNDNRc1JmRFAvSGJxWVpOS251bHJoVUY4OGZialdsSHdhCkhHNDNNV3duQS91
SjFYSDNyYkFlM2ZGTnlrZnpUQnBLdFVDcWRHOD0KPUNmeEUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000011de0106291002c6--
