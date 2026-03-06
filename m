Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD79256C6C
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 01:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772761503; cv=pass; b=Lvqb3sMcs1nQkpC0emJ2F+wh3Cp0bNrMry0cfvw81ZL7GGl4ZLvSp/xvSvgqDaJLvecrJMIcMb2dHrOmFwwQvdmpDk6kuoEM/NPrOb8Z+hGvs3I+bl9065vnPrOAGyi00BIGW/Nh38wW1HyWihlJpKC1DiMOeFN8SV7AjL2IcGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772761503; c=relaxed/simple;
	bh=4u9hJfbm8+tRhmsGacLFA8iOD1FhEUaGRBbrid+kSMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=VwoRqwl1u6FjLK0jfHwNst/m9N4uram74xMWXMUZcNiSMnp7edbpJBT8qkD+8Ustj3qMyEBjcXHc7t2CqW/af7G4oB6UCoX+125YI8oD5ZGthF/l5cUlUHmcVSvMHqdRa0dgcTGdcR8dOc0/aUvtcY+twTMlnWMiOLBaSZtR/vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9hW2Jaa; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9hW2Jaa"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-660bdba9390so5022027a12.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 17:45:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772761500; cv=none;
        d=google.com; s=arc-20240605;
        b=WoR/2/xSqLAIoGW/+Jd7bZSxDBdBmLio5xx4I3zNzhsFft4ioqfInZo05bTAIyaWIk
         jWBga7MKbOY4Cunw43Vfy+L0Rc9TWTOAPcJ2j188qUs+UkT0zVHGOALPI3VTvmNxhu26
         jz4THmS207nT+rnFxSuLLpDt8ONh262MuAqCwbHGudPn552Dr/cehLySfSc8aSIFjVvW
         SuaNAajgN+KBv1ONOmPLsxmaCo9vqPSjyKe6CtPAbfj7b3LjNracmef/lTb/px17dbik
         4orXhStGmlS6ZZj5CSdvi9NhBXhkiehd5AVHuhXrfj9V62gAKUODPwdcluDpb9hhgxCc
         GmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=Y1zkm39UVRNTrgW9xgD2ppcOoQViRvg0MDQfppZe0kc=;
        fh=PNVXveT8tss7yeC21DLmmEj3x+FdBfvjx3sb48AYYz8=;
        b=gA7M9ta+YA8PF8FGThf3n3Laht7J2tpSOTYWlp7Wb8USzP4Lz4DvtgZTMjgUm46W2o
         4cR2e9IvRbPBWO7Kj7Ed2xVqc24Pi6jD9FPHgtDZJ2FRV9GNoVatRz/4RswX9KRbRACE
         WFCnZLZ5NhPaP8LOG0RGExjFC4seOCgvGfstBe0VjhEQVHobadC5QKeRhf1FVIsLivvm
         mLL8587V8p3ktCNHVTyQRw8GbX8OWSHav8DLC4Ens1f0ZEOEq9eX6fESsw6uhtdXWeWE
         +K2iDGGacgoFPTj6hklUKJS07Mw1xRFeDJxxDRuGmqK1SkDPt5fnF/vpNG/DEHuI7xKu
         d4mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772761500; x=1773366300; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1zkm39UVRNTrgW9xgD2ppcOoQViRvg0MDQfppZe0kc=;
        b=j9hW2Jaa9IcOrWb4VFa/i4CQBzGvCQt0aFYX0hWv8ZXtE1JnON1Gr05ILPQwyWMr7T
         y0dF8W9cWFMvAb3A6zNTlQ577/qtSd0S/9Rm+8BlBeYlubIEODx25hyIFs9UJI/RUd83
         UMp5G7bCEmpmUrcPODRy3VoG2eFBcJh8fYsdoCEO/iajIT5QyqaB/S2PU4TRwcKidPNP
         ZdFxpc/DnlmY0Nr9ZcyrlahmefFsaywJC+Ot1lVNHmpg4cFQnfOKHAKTTa3ni7Cf7VWI
         NluqVJlN0TIrSAuaAbBy9uM1RVHdGaW0V9jSjUQYC5/7GO833al9cEk6t19ugr9K++MQ
         UVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772761500; x=1773366300;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1zkm39UVRNTrgW9xgD2ppcOoQViRvg0MDQfppZe0kc=;
        b=h3bnm+O3FxYq6KmS5tpgw9YD0NldBm/g9iqmtXKhFMvkbgXSJbKWngF3YRF7wS4y5W
         1HNXr9WakuLYzoOg4vxu+3fFeOVSmGJDdf3yvKEJuN3UWo/VvVuLizLX2xNidyApRcL5
         fIGWZA+9LZ9o42xbDIXN+sYJyiWEB9voOqqP76VkBvyxiwW9k9gSIYzeAnm53Nz0LsSE
         rfvnyEGvUAD1ySzUIfHRiUPSDIW4jGX01ECXe5GuHGyYXOe6lpSgRq3xKPotZ8TRBr7X
         vsXZ1HfYOLdy2Gj5hP/hZ6ctYXQx9RDCLv4PLb5FOI7xyeCytT7qKuGHKbHP/5nU637W
         fykw==
X-Forwarded-Encrypted: i=1; AJvYcCV4QBsH5t8vXYCfVetym7EmjjvPQ/eKeGvffTdis9YBFXD6O94PAo0p+l1eFnD8cuekZXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt0DOTWhRuj5txctI5qV2OJyRp/ed+wNN6iw/Mc4FeAE2KlTJ1
	sRR6OjBjlBWfMiwPVay0GBBW0GZRC3M81nZOLPwO81RRgLD6rjq2cYEDImIS/LDXEyKy5wCLUz0
	BEPDm63ggP0/0xQA4jw69dKMWqOUMz/g=
X-Gm-Gg: ATEYQzzzvmDloTyG+OqYGed6wjLJHAoPZqpILyC0jEeRcqX3byew/hnTuSAiauW75CM
	vjd5y+IqWfrzhBwtRqXquD2KvKWNii0CuaJEXkAJRj2r+6ZZSOg728+47DBY0IvyuMpv4X194xk
	/GIKIQyfQbcew9U/aD/C96bDT056jnN+tkPuGkXo8evDI5DGNtKtLtpdpQVJWtOC3o87D6yw66G
	xhSfC549c0bUiBMCE7RLW4QZf8EiYBdrVOOCwjuuOTyqmsMLaBaz151za5r+83S93/M/DJCPVqj
	/AESA5oVaIqTk+KFboNjv//zm36QZmHaDAxTCZQFH1tKsKcv5kQqdUPdMalv3E8HxIfw86x96ZQ
	NWVEtv+GAWOjBPJpjabBWi9fV
X-Received: by 2002:a05:6402:13d4:b0:661:85be:6082 with SMTP id
 4fb4d7f45d1cf-6619d45c764mr207309a12.5.1772761500230; Thu, 05 Mar 2026
 17:45:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAaskFBp+A9pOhd8O6owd6k0cDj66ipXrqH2Hj_c7j3d=HM10Q@mail.gmail.com>
 <CAAaskFANnrqTAjQOHhAgzES9=S+y7w9u-LMWbRbi8FayVdvzFw@mail.gmail.com> <aaosmo1Iluc5KeZw@fruit.crustytoothpaste.net>
In-Reply-To: <aaosmo1Iluc5KeZw@fruit.crustytoothpaste.net>
From: Ivan Ivanov <qmastery16@gmail.com>
Date: Fri, 6 Mar 2026 04:44:48 +0300
X-Gm-Features: AaiRm52uM506wL2bzMmjupqAuTfCtYwjNJu6qWpMk6EgUpgjwvdVapBMLMmvESE
Message-ID: <CAAaskFC=tpuS-saP9t5Kp0+i6qTHe29x-dGkanyAzz-xaq_HDA@mail.gmail.com>
Subject: Re: Test "t0300-credentials" is failing on Arch/Artix: asks to enter
 the Username/Password in an infinite loop
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Ivan Ivanov <qmastery16@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi there Brian! Here are my git version --build-options (taken from a
version packaged at Artix, however I assume it to have the same
options as on https://gitea.artixlinux.org/packages/git that I am
still building atm)

git version 2.53.0 cpu: x86_64 built from commit:
67ad42147a7acc2af6074753ebd03d904476118f sizeof-long: 8 sizeof-size_t:
8 shell-path: /bin/sh rust: enabled gettext: enabled libcurl: 8.18.0
OpenSSL: OpenSSL 3.6.1 27 Jan 2026 zlib-ng: 2.3.2 SHA-1: SHA1_DC
SHA-256: SHA256_BLK default-ref-format: files default-hash: sha1

As of my shell, it is a GNU bash --version 5.3.9(1)-release
(x86_64-pc-linux-gnu)

> any configuration options you're using to build?

At the moment - just "makepkg ./PKGBUILD --check --noextract
--noprepare -f" (these flags in order to get straight to the check()
stage). Btw right now I got a somewhat similar-by-appearance error at
test t5003, however if I press Enter two times then it gets further
instead of an infinite loop:

Username for 'http://127.0.0.1:5003':
Password for 'http://127.0.0.1:5003':

Here are the contents of a related .out file for this t5003 . Please
note that not so long ago I did chmod -R 755 on this
/dev/shm/git-test/ just in case, so I am not sure why this is failing

ok 81 - remote archive does not work with protocol v1
expecting success of 5003.82 'archive remote http repository':
    git archive --remote="$HTTPD_URL/auth/smart/bare.git" \
        --output=remote-http.zip HEAD &&
    test_cmp_bin d.zip remote-http.zip

fatal: cannot exec '/dev/shm/git-test/trash
directory.t5003-archive-zip/askpass': Permission denied

fatal: cannot exec '/dev/shm/git-test/trash
directory.t5003-archive-zip/askpass': Permission denied
fatal: cannot exec '/dev/shm/git-test/trash
directory.t5003-archive-zip/askpass': Permission denied
fatal: Authentication failed for 'http://127.0.0.1:5003/auth/smart/bare.git/'
not ok 82 - archive remote http repository
#
#        git archive --remote="$HTTPD_URL/auth/smart/bare.git" \
#            --output=remote-http.zip HEAD &&
#        test_cmp_bin d.zip remote-http.zip
#

# failed 1 among 82 test(s)
1..82
