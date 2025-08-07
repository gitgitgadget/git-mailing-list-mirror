Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203701DF258
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552918; cv=none; b=GDShgiSrB/tNzjxf9i0l160nAah8EFFPk2vwGUNnBrAxK0x2BHD2gmVQHnsah/iDbZ0NkjH734pkNHsIIu1a+DBKonBnd/YY8lABfdhRSDzLpDK+brJSTwwTCafj1FVAK/R3sopzh2McY3+fgC2AgmW5MDtY6q4FeByIEAp18vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552918; c=relaxed/simple;
	bh=bYk4Eb5RFQzh+cNCGVYCaFU1MLx3JpWSfmi+gE9csAw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeU3apMaqIG3E59aoKLF0a4L6GybeSjTyCfveRMCopiLZqbjXtMBXmLPBvV0UAfAmx35mkAxd0jXm4dnU6hewy/VvY8Lc8kNJuGjkufotXGmcYeTje1wkzhZ6MCZZm3sZy6x+G3rVBh7ILvcxUyGOpdC2fqa3yghBNcNQXH5g3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTAKOEmj; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTAKOEmj"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4fc009e3050so540753137.0
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 00:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754552916; x=1755157716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IPs/CwvTjC176HA6f5Zsjrfr/fVvIp2TjbntQ6X+j8Q=;
        b=YTAKOEmjlm4s1WYTUqez8NBYa/VHEpNS1+++F9aMgAlQmdEQQ4liRnOIlqGLkQ+6Og
         /HyKUPOzQMDHNJYXzpbvGs2ln8dBa9ljDhGJt2FxvtHD833huP5s2MqI6ER+rW4l1sH5
         GLZJgGm5hOrdkuJnWOLOE7VcrhGCsnkj4bMVpdb+PgMPyD/vLl4JGrRbTDPlq+AZZdrE
         hJRFZ2KjVkR45UOnLnaGeLpvGdFqfbTSW94XYKf1tQhSUnvI8to8sr4xrtAFhyeNf640
         0rfxeAUgzBAf02wjzQxXD769GsOudb2YblTR27wmQQthkevRdQt4e07CnQdafSSGwnZ7
         7qFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754552916; x=1755157716;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPs/CwvTjC176HA6f5Zsjrfr/fVvIp2TjbntQ6X+j8Q=;
        b=w56riTwf3/HXm1IMU5OQtFw19npUS7eCssPathJs7kSEOE9cEoaTe676tGvyhiRpfq
         ntWMa5DiQiAr3WMMGbJKklvtbpVjIDe92aWd69JVnHhtfrrHRe/CTs0kqTa0yhyEUnTs
         a3oSzYE9zRnFkncqBfDfVPS5gY/SJh/IlFWpXxle2ttpzJSBB1kOaebqENQ1gEaymxkH
         nKSt5D+OQE4KmuQhCxZeFPn3n3baEXW8BDkV5LDO/2lyyAebMDVBQuBXIFbMSkammJZi
         3zm06vvyolOLCW8vWsuDuDcDaGg840yn5Uj3k48c5pMS/3FbWY3sZ3AOpbHrXSkaeWSo
         atIg==
X-Forwarded-Encrypted: i=1; AJvYcCUU1EZIEFfUc0VCLTcXOa6jWmPVYRDRNiLWZJPOaV0cRhXE8/1OZ+abo4eUPyfQ88JrqpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YykW7r9192p3lgERGCvei4fOr8XcM5nM0bHh0iQGKp6C3UPofit
	lk+KNllH9lqf4L+/+RKgIwel32HI7HAmSBfHLE4hEBQ7gD/+zlpAtcmASYTRdTqkfLGwxZRCjeX
	O4gtRDaQjMExIIlspoHr3cKNwmc78hMs=
X-Gm-Gg: ASbGncsVrmVG5VtslCCCWDNjGYUYPxO/yAapRTyc8Y0Gkw/nvlEHY/B6g6i/koVddEW
	G/dKwHjzgLS4VGLeuO02Plvw2zS7MiuJKQ6phJTAOQpP6NZpnmWJ1q+OTGKMNrpijiadgzI+8DP
	pWKqZq7Dbu3bfzqvdY41dTKebdWIQMjRHxnifrQTWipnrYpkxkgAoKsB/KcVXXk/zx1OCq1AdR/
	jZsUg==
X-Google-Smtp-Source: AGHT+IHe0ddfsbUYAlhTaOlQiVj5eRaMPTS/SQ8jSR/xJgbVfyg8CNs9GOPf4+tbpoOlxYkB6XTEQgusM1yM3rqUFt0=
X-Received: by 2002:a05:6102:5128:b0:4e7:b893:fec7 with SMTP id
 ada2fe7eead31-5037873e5b0mr2731617137.5.1754552915945; Thu, 07 Aug 2025
 00:48:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Aug 2025 03:48:35 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Aug 2025 03:48:35 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250806195537.93302-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com> <20250806195537.93302-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 7 Aug 2025 03:48:35 -0400
X-Gm-Features: Ac12FXzwqTBVso3aNLN2RVa0GVspXv1Ydh9XTx_gDtFTAHkQbEQ5zaUZ_DIm5NM
Message-ID: <CAOLa=ZT9BvAp_TvD3MnUJxtpmT=U=hzi3NapokWbEyvyrv_y3A@mail.gmail.com>
Subject: Re: [GSoC PATCH v8 0/5] repo: add new command for retrieving
 repository info
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de, ps@pks.im, ben.knoble@gmail.com, 
	gitster@pobox.com, phillip.wood@dunelm.org.uk, jltobler@gmail.com, 
	jn.avila@free.fr, sunshine@sunshineco.com
Content-Type: multipart/mixed; boundary="0000000000004b91e5063bc1afe8"

--0000000000004b91e5063bc1afe8
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Hi again!
>
> This 8th version of `git-repo` basically address minor issues from the 7th
> version:
>
> - A test wasn't passing in the CI because it assumed that the ref
>   format was files by default. I fixed that.
>
> - t0450 wasn't passing because the documentation didn't match the
>   usage string. I fixed that.
>
> - A test generated the output and the expected value but wasn't
>   comparing them. I also fixed that.
>
> - strbuf management: now we have two strbufs for printing values:
>   one for unquoted values and other for quoted values
>
> - Test codestyle: now it's ending test case liness with \ instead of
>   open strings
>
> - Documentation: this version documents that we escape the value in
>   the `keyvalue` format.
>

Apart from a single nit on my side, I couldn't find any other changes
needed, this version looks good! :)

[snip]

--0000000000004b91e5063bc1afe8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9093546971de330b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pVVdsRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meHh6Qy85MjdoY2N5b1U2blc4ZUxNRlJEQkFMNTQwTApiSTMwblVTeXE1
b3puT1lsNVlxMWJhNWNZZFJSeUZia2g4enc5WmdSRWZkWE9ScWxEN2pzV2orNGxPakhRWnc5CkJw
YnBka0NCNmxRS3BDVGNLZVZCVjMvV2RzaENEVzJrTEMvQ09QSnVqdzlJUGdpbDZvYUVGQXVPblBI
Ky9EcGkKN01sN3ZnTE03WTJlTzJ2Mmp1bnJPd0JFZ2R6b2NQdWI3a05KUGpBQzRVd3hUTElzSTdF
eWRnL0lXdUg2QVlRVgp0NWFQeUFiamVCcjdaT0hKWWJoN0RpVDhYZ1pkcnRJNDdGaTU2a3J5MmlQ
c1pyQXNZK2twcGtKNWx0UEZxclRYCjRzS0ZyeW8waFIrRmZVeVV0R2ZQb3ZsYjQyd1kzZHBYaEsy
RVhIcEVUbWI3NXRYQUZ4UUUrNk5mc2JLTkxtSWgKVFV4TTVOTmE2azR4Q01WQUQ2ckp2YXo4M1E1
YW00Nkl5aWM3K2s5NzlJT3RTcE5NelRYNkllZmI4QXE0and2TAo5dGlDUXo5c0VqT1FiaG8vT0pS
ZnRiS1hJSm83d2hCcGJlSkdNVzFzN2h0NWx1eEpIL0JNajNoWTJuN2d3TlJ2Cjdld2hwNDRkRXUy
c3ZQUTF0V0xsRy9XUi91a01KaStrcnI5QXdjUT0KPVlFa2YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004b91e5063bc1afe8--
