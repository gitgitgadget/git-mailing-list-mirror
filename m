Received: from mail-vs2-f36.google.com (mail-vs2-f36.google.com [74.125.227.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EAD3B19C6
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790771181; cv=pass; b=tGVBfulcjOlfd63S80cX3fFb5aDug2OXz05iQlDJ7SEddJ3YkFlcUFF0WTvIOCYdWXyf8oFbhwMuq54eldaez8yP0+z2o6cvfcLV1Te2soiew2KmQidFTjIrnoDa0mRdk1P18TQD749wPCALmCCabjQyJ/cQ8sm6wff6kliSQl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790771181; c=relaxed/simple;
	bh=BOr/FhiMQMeuiHrWYkUN0ADHCCSbfKD0/93tFVyvCSw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKJeft8EqvoeZjy6q6840+99OrvQlMvrVIlkQlJWw8PZlrsBq0DwCMSyhwSwxR5h0OxH67TXiu80lrFIOfzUtV5ZT2DOfQo/Wqdqydu5fQWXqpZKDKUbN7wDPLuVlSeUgtelOpz1+rbVr9XYL7mooL4ksGuy0hFWH4aB+xmfQ3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoUzgjqi; arc=pass smtp.client-ip=74.125.227.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoUzgjqi"
Received: by mail-vs2-f36.google.com with SMTP id ada2fe7eead31-7ba8b67f74eso315389137.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 05:26:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790771178; cv=none;
        d=google.com; s=arc-20260327;
        b=i+j6oiNZEyn7SE1qoGNdLsViy/Eb1LbjF52tXv/Le+glgXZY3O0LLLrH0Dff6Neja4
         GVLOaPrVl/OIU9cYRy7du/ZWNVxwyVSdFMTwoDQl4iV0OTiQ3p2EhxK2NSVRWxhc8Xm2
         Gt8lZkpVYzP5LD/f2dgUifb1EWK9WsyGrpwyzIkzlZfkn27+pBkjyV2ragPyy+5L7ytO
         hsRej3yzssFhrcuXp6Ss1/KnhN/KVRTmfKsKtEly/Mfcok5SubteGo0BvycVEFQv0/Hq
         VphopAmm1SLx0H7I2kIYAv8Q662Jgtg8k+mOSc0+Amt10aW43mFa5yy8ZeXoS4SCf+mg
         T5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=44/vmJ9rUM1I9m4pvLp/0A/MBfS23LDonLhFvMBIkj8=;
        fh=Q5Z87g2awXg4dYbbuZF/TeVSx+8jBpAb0Rp59QuDm+o=;
        b=TbH8Hp3XHNlR81kGdyh3v3gG2RxhyaDq65LIgT4iCvOsE9oSHkX9jAyED3z+AkEmiu
         AKdfMgXiJtH/+OXLq2OT6/agYSpCTTeHvo5TnUdNXMadXoFEzADvgrmky+WKumta8wSE
         TvlogLG6dczoBNsbikvWTGZfd2QBugr+mUX+tiMtkN8FoP8R6dc8gayG3iAEI/AM5Jpp
         FmYHBA5JhTm6MDpZxLEBJKl8O4FDUldUZ+iplWY/muM6icV52s/XRF5zQeU1wgbISuyr
         wiQIiAIwCNPv7aZZVtndlXSzn1rl8wPwTEDP6DYEnC+ZyP48XLswtygjAGw9znczYB4y
         wCVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790771178; x=1791375978; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=44/vmJ9rUM1I9m4pvLp/0A/MBfS23LDonLhFvMBIkj8=;
        b=HoUzgjqiUvMxThHzJvfOjtF1IaXUQaMJolmqIuperfhdSyq81u96D62LxaSkXutNjz
         LOGXNo7oapiXwd5gSjSf+Bn8wD7wOUugjJ6D8Lp6DzT8yyWhhzPh6Fbs7SVSKtYDtvH6
         zz5L0r2B784lDY5yKo4Zqjn99CI4EANJsisJbF/ulSjNQXCj+3OQS2+TzHN0xyJudm4x
         mYCRagGIJU0NTCrZHUMACCutITuPsbHG3/q4BDfVEqxwxuWKqw+c+PhbY70uhezD2lsv
         ky4r1Db+RKiWXE3pElkWt0RLc2U1NUQd0P7of+1PIWXpirzIaBy8A+J8EAmkjqgLOQKp
         xmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790771178; x=1791375978;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=44/vmJ9rUM1I9m4pvLp/0A/MBfS23LDonLhFvMBIkj8=;
        b=gDDT4wMKiRvvQjA8m/YylNuj6WmDY8ovHZmfFWn3YJOIbtY2DjIq0EZtrTKQuJOpJQ
         ZZKEpmobn6pMsrWUrlcZh+AVUKKfsondFoSDYfEbC/23DS8oLIRZYZKFIo6tXINsKXli
         qXq/lKjSKx1dd9xsjZPVahnxDVRRfyXiLg109CTUN4TxSa8AzbTigtmLuQAXJPWZ21F/
         KdKIbt/aiE5XZNx+C8rNafJhPvwTH8BDy1z1/98LOmxXzIuhjKeB1IXMoEIZ6t5INKct
         xpmFLtLiJnsxG+MmNMEULSuRALKGV5wZst12WAK4uSCYanFlaGrUsVaMb8ZkS8+jH397
         MDHQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8t+bib1QAIJpmg8sXUWH5cRmxzI88sIwlAOT4nTt1bU+gs373PaGoZneAAHagX0vJb6g=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCRntJBkMlC0bQVkw/qt76638H7EZi82+8nanapCnjaSqr5CIX
	+gED6bD0dDbKmXwt/PkSWHoOrhE3TRsVldo0YOqkPzKNP9Fc2pNDzMK20dMjTj9Q8ctJFSWk6bv
	Qh//qNVhoevK7l252i8bgMZinGOna98I=
X-Gm-Gg: AYBFou1pqNey93DVv5ekH4tJdwrwzwwgxlB29MVcW7y7+D4zVE/wYWYvM2gKLDecZ9z
	CFtpmH502GrAaCuoBHurNK47s+7Tm2KLRTaEyQ0zO5l5nVPbdZcHAKMvBd3VJ52rZ7ZZkdZ3kwt
	3a1Q9Xk8IJ2T+EBDlxY90YvhOMig3JJvHempjbub99kewFL4wwxxcY/aNPosG3AwVtdGsOZTpPM
	VTUHB94Bv59m2M0mDRZMLpeKHcfdGYHYFNz7hB3+71nu31sCy/LJTzrgzZnlnZrkKDhXKGpV3Wb
	qYlqavnsEAYuXq+zkQootjw2vm8A2hi8c/8aDr9hHQ+JUMmAwNwlS74uI619l/eQA/qVrBDZYjG
	JNHTFdhTlATY51glbZ/ai98Dr7wivwM9GWLbhHNjNV1Gx5Q==
X-Received: by 2002:a05:6102:c4e:b0:7a5:673f:9a37 with SMTP id
 ada2fe7eead31-7be91326073mr196882137.15.1790771178629; Wed, 30 Sep 2026
 05:26:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Sep 2026 05:26:17 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Sep 2026 05:26:17 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260924-pks-meson-improvements-v1-7-90b7f79f1c4e@pks.im>
References: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im> <20260924-pks-meson-improvements-v1-7-90b7f79f1c4e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 30 Sep 2026 05:26:17 -0700
X-Gm-Features: AclHuK8vPVExrRcwP0V6T1nB_YjYqaa1m9ogg6uqTHCowwo_2sMV_8byp3WtkrU
Message-ID: <CAOLa=ZShU_FhuudX6JSPO7q6w9xBR-QRyEd1UbCZ15o-S3xtqQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] gitlab-ci: fix hanging MSVC jobs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: multipart/mixed; boundary="000000000000fa1e79065cb26721"

--000000000000fa1e79065cb26721
Content-Type: text/plain; charset="UTF-8"

FPatrick Steinhardt <ps@pks.im> writes:

> Starting with GitLab Runner 19.x, the runner executes `git credential
> reject` in its cleanup stage. This has bad interactions with our build
> environment because we install our own version of PortableGit, and the
> runner picks up that version of Git. The consequence is that we invoke
> PortableGit's default credential manager, which is Git Credential
> Manager for Windows. GCM then tries to use Windows Credential Manager,
> but it cannot and thus the job hangs in its cleanup phase forever.
>
> Fix this hang by unsetting the credential helper after installing
> PortableGit. This means that `git credential reject` becomes a no-op,
> and thus the cleanup succeeds again.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  ci/install-dependencies.ps1 | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/ci/install-dependencies.ps1 b/ci/install-dependencies.ps1
> index e3b367fa54..2ceb5dd99a 100755
> --- a/ci/install-dependencies.ps1
> +++ b/ci/install-dependencies.ps1
> @@ -53,3 +53,11 @@ Invoke-Installer msiexec.exe @('/i', $mesonMsi, 'INSTALLDIR=C:\Meson', '/quiet',
>  $rustMsi = Get-Installer "rust.msi" `
>      "https://static.rust-lang.org/dist/rust-$RustVersion-x86_64-pc-windows-msvc.msi"
>  Invoke-Installer msiexec.exe @('/i', $rustMsi, 'INSTALLDIR=C:\Rust', 'ADDLOCAL=Rustc,Cargo,Std', '/quiet', '/norestart')
> +
> +# Disable Git Credential Manager, which is auto-configured by PortableGit.
> +# GitLab's runner picks up this Git in its cleanup stage and runs `git
> +# credential reject`, which hangs in GCM and makes the job time out.
> +& "C:\Program Files\Git\bin\git.exe" config unset --all --system credential.helper
> +if ($LASTEXITCODE -ne 0 -and $LASTEXITCODE -ne 5) {
> +    throw "Failed to unset credential.helper with exit code $LASTEXITCODE"
> +}
>

Nice, for reference the runner team also has a fix on their end to
disable credential.helper on their side too [1].

[1]: gitlab.com/gitlab-org/gitlab-runner/-/merge_requests/7470
> --
> 2.56.0.rc2.329.gd58861e689.dirty

--000000000000fa1e79065cb26721
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4d2d0244d82cd28e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xOC8rZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEJHQy8wYm0zNGsrSVUxSDl5NnM4T3liVEhLTDJqVQpGbFhGWHNoSkJL
ejdNWXZFN2NrMzJTRmlLKzZUekZOa3NoR3V2UC85K3pyL2VrTjJmcnNaTnRYSVp0b1BCSXgvCll2
emkvbytGRUFiMFIzekRLMWRzckVKU05GMWpzcWgvL2VSU2QxMGNUaUhCYWZNUTdWQlFRa1Q2dGxB
dGVlUHgKdEZEeVdBc0pGYStYdGpUbWdRU1d3MGR6bU5TOHJZR3F0UHJKNUl6UCtoekw0U01lYjY3
NWxwTnNVU3dOaCtOOQoxVnFMbng1ZmxSRGhaN2xvREluYXVXQzl2TXJGWVFhVWNoK0kwSm1KYjJh
cU1xbDhVWlJIWjBmRWpSVjRjZE5zCjNSbEhaSXVkZndMQnVQVVdac0ZDWExZekxtYUJadVBzck1k
QmZnbkVaYW8yd1RDZWc3TFBhQ0JBVGszOFpzalIKSVNlTkx1UjNNcFJ6aW9DL3UzUmIyOWFRVGhU
TTVSNU5LYU9PMTY0d3BmdE5OczR2REtUQ1BGUVdTbW1TZjh5Lwo2c201WGo1ajh6cnh2L3dWM245
NE9KaWVvRW5kdExCRUtnRXpVS2htN3RwMjFtZVg4cE1qT1dVMkVWQ2M3TndVCklqQ091QktzR0JV
eDNQRmJmbjFibHY3TDlYSmNLZTBmbkNZSS9rND0KPVhnNzIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fa1e79065cb26721--
