Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289582E62D9
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868641; cv=none; b=mPGcWsahFhNlsK+qJsY1lmDfbcEr2rj69toFKkaCl3/ZT4T/6NwsHGAUZvphEuOm4mCEesXqmqCTG9OZ50JYLuB/2m62TnmB0g67sngRTFBJjOPUbpvlDJtIVbs5UOehEuCl2Xwvb2B8XSll5LOKIRNtFPFkUR0jhAD+CfoHdHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868641; c=relaxed/simple;
	bh=x0kZKC4FxzEMXf2yCj5tqjJ4LUksizoL27a30s8pjOs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUGyXoaHxOXZOr3596WWtRozcq9S5f2N0lB00z7Izbnjc+ONpLYiGu9CSSo3bocUQOeDmC6AYTKXX1xol0aOF4hoPw63ej4MatTSGuJeANg7LE0tdu+KZLa89P09V8o+w7Y8+0uCjicKli5GSOStL3vVyhcoB1zggGJb9jY6X6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5hOTRQH; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5hOTRQH"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5db1e29edbcso1388711137.0
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 05:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762868639; x=1763473439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+iya5UCcAKiafrA2VoqQEGZ4Fl/+pzuxbAht8QT0IC0=;
        b=S5hOTRQHhx7eHxZGU1PrAvIF3fURkkG+/nWdyJzYHC8zeAbNorR2hFcElyUOdtogl3
         ihL3neHJdmvVA7j4tjUSxDXcdNjq9Po+guE1Fnz7wxKVMfHFlFCjBSh3OxPI83jFxWnz
         1ORY9RyDvbCRTcXWC5HhxrNeAJUpADRwcVy34e4LepnGNWbEAxD4bA3DmcMfdwiqvyyZ
         08kQtIkpZYse1AvqwJ6DQCiRLW28mQ1yrsix9jPJJAq/8HMoptd604YSwgTA5uOqH3zJ
         Nj4PzKYQizpZ0G0Cxo19UK78yU6kYXZ82hEA8S6ohxWMCpqu0RoNjTVzgonVia8K+rul
         zssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762868639; x=1763473439;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+iya5UCcAKiafrA2VoqQEGZ4Fl/+pzuxbAht8QT0IC0=;
        b=p8dDtL0lanLmbPlrfOLKcZ73dswNkf4NUbkT4J4zmTpBLTYLSVnwk093iLFtkLvr4F
         3z0zKycHNc8Csde1UfaLQ0uEnYXkmubLka2PlL7vlvwjob9BviDM13FQNmNrow1kUnEo
         4VUJuf2IlEi05wWbYt8FPekflnl5YxS5bAMndXjH9OD+NLC+d6BxpvbEkMgLykfuPgwp
         UBtrdSPCfbVQ3TKyzteghpg9cj+48aXizmiMfvqAtWmhmrrGhN+Xet2q9CYELn7h1fO1
         DgRXuQ0JqiGwMF+iylF4tiJEaeWalRnne+ylDXnWhRtx5eiK0BbZDR/athhr2exmejgo
         VJng==
X-Forwarded-Encrypted: i=1; AJvYcCUmTgsqk65ZKz/ykicDAW7Jg1xmhflrNnwWTV+uY43k7tBMJlqfiyBm9THMIiUm7QidcvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgO5esGBuJG2TfEwevfDzwHO8NLMK17Jzi9i1PPUAp4V35oKpO
	nZFXGWNQOZKzOqQhrekOTSqwWo1f43mNmApaM1gxfteGMNqeycEBAdh2cmCqNFiD4huPxFLLLww
	aOz5mjs/5N1WRFVTBJCr6ANI52AdOOds=
X-Gm-Gg: ASbGncu/fMkM4MdrMKKvk+gt9kKfnOh20pbO/t+DCmYxHf4nScSXHrqpjDW1JNEI8pr
	yr5FlbMGHtkV6hYPEYGNgChKDw6Q1/YOe4b3m7ThMXcTbRUrjS4+ROAhhpwRSu21QrSzpH/32Pn
	1bX8FaSzXnhucCWfYG1kp2XgcZ0uUOqaXNfWzuRNKhrATKbm/Nlwr7y0JBH0bH6scnQXn7we+h3
	vRwg+h//HQfNzvbZTdPj9IsiVlr5MrKJrVB/hvPODqKclclQaXJzTJN/YY=
X-Google-Smtp-Source: AGHT+IEVBsAkya3vqXnaa5ha3Bo8RnGxldcZcXgo8tFc8tRWTJUDxCxu+Rl1DMce2L1bIFJC4aa+rvNKLjw3S8Zmt6o=
X-Received: by 2002:a05:6102:c03:b0:5dc:51c5:e3c7 with SMTP id
 ada2fe7eead31-5ddc47e5d65mr3976195137.26.1762868638822; Tue, 11 Nov 2025
 05:43:58 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Nov 2025 08:43:57 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Nov 2025 08:43:57 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <d6b86ed23e28c875b48fdc77095ace3f8ff4ee5d.1762820704.git.ben.knoble+github@gmail.com>
References: <385992f6020703558f0ba75a1be6c4f9dae08b83.1762264709.git.ben.knoble+github@gmail.com>
 <d6b86ed23e28c875b48fdc77095ace3f8ff4ee5d.1762820704.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Nov 2025 08:43:57 -0500
X-Gm-Features: AWmQ_bm0BbN6qyaLw1qZ1dRyw29JxzXdNbzYqQfE28hO2dPuAoVG-ICI5wC8dMo
Message-ID: <CAOLa=ZTViq=OYoMQNdvi3rV+iUucGZ4RN0c7X_Q0PEugaEqqJQ@mail.gmail.com>
Subject: Re: [PATCH] meson: make GIT_HTML_PATH configurable
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000000d1b4064351d768"

--00000000000000d1b4064351d768
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

[snip]

> diff --git a/meson.build b/meson.build
> index 2b763f7c53..1f95a06edb 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -768,13 +768,18 @@ if test_output_directory =3D=3D ''
>    test_output_directory =3D meson.project_build_root() / 'test-output'
>  endif
>
> +htmldir =3D get_option('htmldir')
> +if htmldir =3D=3D ''
> +  htmldir =3D get_option('datadir') / 'doc/git-doc'
> +endif
> +
>  # These variables are used for building libgit.a.
>  libgit_c_args =3D [
>    '-DBINDIR=3D"' + get_option('bindir') + '"',
>    '-DDEFAULT_GIT_TEMPLATE_DIR=3D"' + get_option('datadir') / 'git-core/t=
emplates' + '"',
>    '-DFALLBACK_RUNTIME_PREFIX=3D"' + get_option('prefix') + '"',
>    '-DGIT_HOST_CPU=3D"' + host_machine.cpu_family() + '"',
> -  '-DGIT_HTML_PATH=3D"' + get_option('datadir') / 'doc/git-doc"',
> +  '-DGIT_HTML_PATH=3D"' + htmldir + '"',
>    '-DGIT_INFO_PATH=3D"' + get_option('infodir') + '"',
>    '-DGIT_LOCALE_PATH=3D"' + get_option('localedir') + '"',
>    '-DGIT_MAN_PATH=3D"' + get_option('mandir') + '"',
> diff --git a/meson_options.txt b/meson_options.txt
> index 143dee9237..e0be260ae1 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -1,4 +1,6 @@
>  # Configuration for Git installation
> +option('htmldir', type: 'string', value: '',
> +  description: 'Directory to install HTML docs to. Defaults to <datadir>=
/doc/git-doc')
>  option('perllibdir', type: 'string', value: '',
>    description: 'Directory to install perl lib to. Defaults to <datadir>/=
perl5')
>
>
> Diff-intervalle=C2=A0:
> 1:  385992f602 ! 1:  d6b86ed23e meson: make GIT_HTML_PATH configurable
>     @@ meson.build: if test_output_directory =3D=3D ''
>       ## meson_options.txt ##
>      @@
>       # Configuration for Git installation
>     - option('perllibdir', type: 'string', value: '',
>     -   description: 'Directory to install perl lib to. Defaults to <data=
dir>/perl5')
>      +option('htmldir', type: 'string', value: '',
>      +  description: 'Directory to install HTML docs to. Defaults to <dat=
adir>/doc/git-doc')
>     + option('perllibdir', type: 'string', value: '',
>     +   description: 'Directory to install perl lib to. Defaults to <data=
dir>/perl5')
>

I guess meson doesn't allow recursive dependency for build options? I
was hoping we could do `value: get_option('datadir') / 'doc/git-doc'`
and remove the custom block which checks for empty value above.

Anyways the patch looks good.

>     - # Configuration for how Git behaves at runtime.
>     - option('default_pager', type: 'string', value: 'less',
>
> base-commit: 7f278e958afbf9b7e0727631b4c26dcfa1c63d6e
> --
> 2.52.0.rc0.71.g03eda12af0.dirty

--00000000000000d1b4064351d768
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b0525f62fd95429d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rVFBac1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNGIyREFDYXNpenZFRWxXanVTK3lwWTN2Uzl3Mi9wUgp3Ujl1UTg3WHlm
S29zU2RZZ3lMbUlrNWFONXZWQU1UVDFSRm9VWTRkWndrWGV2bzlXRC9vTTdIQkNQVWhmeDl0Clg1
SG1ZZlZJT0oxUTVDSi9UVWlTZm4zTThPa2ViVHNlQW5OTlhvc2U4cCs2WHlpcDVsSWY3eitKdXdr
eFJrMm0KeWRMS042eFNOcnU4MWs2UGNNREtNVlR0SjJnOVFpYUpoY3lvM0RtaTFQN2pqTmJBcHpJ
Q05Bc2lpOHJlaGZEcQpsVEo5V3dOMXNsaW5WRXg0S3EwK3FQV2VOK2VkVm1xZjFsd3ZxdDNoOWo4
TTU5bUdrUkEwdU8wTmkveTFMWEVwClYwa1BCNy9ZcHZ6dUF4aVRiVWdrR21uTmp5a0FXWlEzaFRH
UFk3cGVNc3FLMFpRakZ0bWNVNmpDQ0s1N0ZBb3QKSnY5Tyt6Ris4aDE3aFppT28zeVdMMEpjcjA0
citqMkpNSjZmSTN6NmpzNW9uUjdYTVVKMXJFVVhTaGQ1UlpVego2OSt2OXJMWnhqcWgvakZPdXZx
aDZ1SGExRE1QbzZlWjZpV3ZuMUJWV3cyRnJFeXpQS29kYWJnamppNXlPQjFNCkN4RXh0OUI4VGR6
cGs2clNmRmIrSjFtaXpXRnB5UGRvcFh4dUxsWT0KPS9lYmIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000000d1b4064351d768--
