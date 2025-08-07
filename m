Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A423FC42
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 07:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552636; cv=none; b=qzl1XtZnOxzPuBobat7TjDIaQmL80FmSHa2X2P3pzSIkDfQk16Xv3pFzwULUpKT/r58ryUGpooNQPUEA08FUqb0XcyRYen61bv3CCKi27Sy7Y9UZRjoPgzOpNKE1+Ff1AOOvT0vmNTpuijEUxTcHxOGUgE9m5nB9GLpm5Ohsdjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552636; c=relaxed/simple;
	bh=0bvMuaT5TUSn8ENwErXKhHX02yXpWuAnyKzj9IGPOg0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9GPwYTJr/+zmIAX7kLiB+s8OldtqGnbAwBINBY4iLa+csbsUZQtpKqPMkeP9tTWRn6WAE8ADvlxlnonoYpWFjn2+FC8Ym3Z+/hqRvugH0sgr+MJ3buRcV5cLLahYlESeSkyRLQPnlNDbo9G00Uv8bli7nxINkiAoQqBkhSi4h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXfVSZW6; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXfVSZW6"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-88ddd1c6178so352324241.2
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 00:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754552634; x=1755157434; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aoJ819cKJyjvg3YrQ0vn4SG9e9dItOPjRgpcyIf4oUM=;
        b=eXfVSZW60AjGSv+gLKiFkap5LTH28AnRGdwyWuki4w4ldicGil1mQAgbwwehbQDLhJ
         0opWcfl+kyOHv2qB9wCbbfg0alFmcdCtSEjQS5GCCO0muZwck5jVtZXu/et/W7Gk4rp1
         lKYPWrYH8284trYinCQTEuz/op1vLsrTubNUpBe4+OJgFnFYV7Orbc4Uclzz5OiyujTs
         QJZRaFnkAYTEwEMvAZD9qUIV0+ivwMlJYPkj9h5vuczNpN6sLuOWiFHqIKmMs2d/yPw4
         rNzT6P89QyUFlJRUga0uTVrJwzuHHHWpeusz4zjId2LcS9XKrXwjm+Q2E4o/ZYiy52Nx
         KzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754552634; x=1755157434;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoJ819cKJyjvg3YrQ0vn4SG9e9dItOPjRgpcyIf4oUM=;
        b=ejm5ZqDNyvroLvXgMXbdPmQhzx4piUR/pphqb1FieAXzgMRUu28/Mn66aQURM95BOg
         HCEPc4tSlg35Cqo4MTwDxc+G9/8alJNRjqurK815jhu4xeWHmBt1CcgYVZ1dr8gKHZr8
         odm++HHdxUhtUgWBl9dY1F5LIviNJae8FrwIahwMppdKKUEJ3NpH07wjfCgGUEvPBjcU
         kTB0SOmbGGCFzdDHtN2ovFz3CTFEOOhqtfQmnqBhV4HskuQoa3YB54WNXqSKwF7fr/nZ
         uUO0DGVlmAcRijVnb6lf4wrZDtJ6rMtC39X/bsvbz0iHXV8TipxnXZ9SG/283p3EiTqZ
         je/w==
X-Forwarded-Encrypted: i=1; AJvYcCVLVcVzFUUcJnviLFk9dsnPYeUexHOzTd9OPWYXfGlYvVphDHrsT5vc3YF1J0aUOH7vrkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFPAxgb9Xnw7vkN5fgWDmbrxVpnM8zsl4vvmKUMPG0nmPOtzvR
	w/iTxNENbg6vP8mevPiFo+F8AfXikPp8mfYbB3dsankwnwRPXY4C6qyGAtGAFZ2dO6E+7ldoSVn
	6KrEpXbSQvinZKyKJ0+2BvSQxBFBSIAg=
X-Gm-Gg: ASbGncsJu0I2dBt34ksPa5/6nrFixTOJnCdDgUS3HbVvx26009bnfmhv5P0Lw1JfZyR
	GiiffnknN+x90cUwhqdpVXHEOnDrxYWZ3jRJl+pRUWgmbJHZwN8p2Zz9DbeKqc2936EWkqkl96R
	bXk5FqZ2JZZgwC0mDWsXwUQCTfgS/fzyO7UXnEwFH+CkH5lfD/BrdjybcbXpz2Oj42pI674LVTm
	A++oA==
X-Google-Smtp-Source: AGHT+IErImyrRDdQe820pXnlP294gFJ9FE+d8OPwO9fFY/eSUwvTWbSY2txMWFHWva1i/WHgwAhxVYUhgohCuHYgZjs=
X-Received: by 2002:a05:6102:3e27:b0:4e9:ba27:2c94 with SMTP id
 ada2fe7eead31-5037810e30cmr3095475137.6.1754552633800; Thu, 07 Aug 2025
 00:43:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Aug 2025 03:43:53 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Aug 2025 03:43:53 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250806195537.93302-3-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250806195537.93302-1-lucasseikioshiro@gmail.com> <20250806195537.93302-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 7 Aug 2025 03:43:53 -0400
X-Gm-Features: Ac12FXwJaI1VOrrV1vIb-bSZF9vm_JRKopJfJzoPR8q5TUwSuLq-5vYI8YjU7WY
Message-ID: <CAOLa=ZSX0hFt7PRdXssz2xGG17bmDchS=EheBSmQj9xr+r_baA@mail.gmail.com>
Subject: Re: [GSoC PATCH v8 2/5] repo: add the field references.format
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de, ps@pks.im, ben.knoble@gmail.com, 
	gitster@pobox.com, phillip.wood@dunelm.org.uk, jltobler@gmail.com, 
	jn.avila@free.fr, sunshine@sunshineco.com
Content-Type: multipart/mixed; boundary="0000000000007a60ec063bc19e24"

--0000000000007a60ec063bc19e24
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> new file mode 100755
> index 0000000000..ce02b394da
> --- /dev/null
> +++ b/t/t1900-repo.sh
> @@ -0,0 +1,57 @@
> +#!/bin/sh
> +
> +test_description='test git repo-info'
> +
> +. ./test-lib.sh
> +
> +# Test whether a key-value pair is correctly returned
> +#
> +# Usage: test_repo_info <label> <init command> <key> <expected value>
> +#
> +# Arguments:
> +#   label: the label of the test
> +#   init_command: a command which creates a repository
> +#   repo_name: the name of the repository that will be created in init_command
> +#   key: the key of the field that is being tested
> +#   expected_value: the value that the field should contain
> +test_repo_info () {
> +	label=$1
> +	init_command=$2
> +	repo_name=$3
> +	key=$4
> +	expected_value=$5
> +
> +	test_expect_success "$label" '
> +		eval "$init_command $repo_name" &&
> +		echo "$key=$expected_value" >expected &&
> +		git -C $repo_name repo info "$key" >actual &&
> +		test_cmp expected actual
> +	'
> +}
> +
> +test_repo_info 'ref format files is retrieved correctly' '
> +	git init --ref-format=files' 'format-files' 'references.format' 'files'
> +
> +test_repo_info 'ref format reftable is retrieved correctly' '
> +	git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'
> +
> +test_expect_success 'git-repo-info fails if an invalid key is requested' '
> +	echo "error: key '\'foo\'' not found" >expected_err &&

Nit: we generally use '${SQ}foo${SQ}' for single quoting in tests.

> +	test_must_fail git repo info foo 2>actual_err &&
> +	test_cmp expected_err actual_err
> +'
> +
> +test_expect_success 'git-repo-info outputs data even if there is an invalid field' '
> +	echo "references.format=$(test_detect_ref_format)" >expected &&
> +	test_must_fail git repo info foo references.format bar >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'only one value is returned if the same key is requested twice' '
> +	val=$(git rev-parse --show-ref-format) &&
> +	echo "references.format=$val" >expect &&
> +	git repo info references.format references.format >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done
> --
> 2.39.5 (Apple Git-154)

--0000000000007a60ec063bc19e24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 887c226d87b8d281_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pVVdUY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVNpQy80aXNsQld1enFzSEhvNDU1OTBHajdQUHQ0bwoxanhweWk4c1dk
ZG5Qb3lzTzU0ZGZoOW9KbFU2SVVPcTd2akttaUpqS1BoS3QxSWUxK2JNT0NLd0tsMVFKSW9GCi9B
ZGU0SXJSQnJ3ZlR6eS9JUWc4SmgyY3pLWG5TZURNM04zSWFnbHhXeUZ6NHVvaVhCOW5rclZ2QjJ5
b29JOFcKZ1BkTkozdjdkMFExbHVOL1RiSkRrOW1SckNPYVpMbWppYS8xYlhnUk1XNGkrdkdrektF
OUR6SmdWaWN2SWRubgpYdjdBL1N3MDZRTDFsZHRzSHVKVVJJeUkxYlFJeUVRZmhiUnAwMC9BbHIy
NFhvTHlsUGRYb1NVK3JGc1A1anA2CjdJOERiYzhReDZPa3B5RDlmL3BpNU91QmlaSExkKzRkU0J2
aVhQZm1LWlNIcjh4MlhvOGRnMDZmVFVPU2szL2UKVWZYaUhlZ0hScWhKQlltMEM1WWtSVWk0aVNN
bjZUTU15RnhZdEpud24ydmJJSFY2aFZxZElqMGNJb09TSTM3NwplTXJ4MTBQMWE3THNjZFZtSWYy
SmZ0L0xYaEZoMTEzNEFuaER6eFpPZm1Wd1dHVXZHb2ZMaGVyWFVhRko3aUhvCk1pVVVNSVIwbGRR
VlV0SkZPalh6MnF0cDNWMXRNdFByK2xGaGpWQT0KPUlJU3UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007a60ec063bc19e24--
