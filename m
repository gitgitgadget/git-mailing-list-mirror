Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8F319E98C
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734635762; cv=none; b=gceGQGC3d8gKYoyF1DyvNLiHKx3wgtew7vR9uqEBXz6crhoMrcgzOwcaBJQ8VL1d0PVo68z+Xfzu1021KoyClRbE/Ny2K5A8H50cXlmOZBzjjItUX4+Hr6985e1XvpqalSEcaO1uQXgLkzQFLXJ1ZVynVRLvBawiuBuklYaDSkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734635762; c=relaxed/simple;
	bh=6ZCzFueYLrgQi4LjDFskJzxvHX35g7dCksJUnW+0uWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=EmYwzdUDKquCfas4sLj565F1gWw0OPiDTmqmmWb+7FKD1BOSLaz90XBichqhX5clFjDXek5FULAXEKIMocpLuIfLXPKsHCGnubBPmyIOaZq78dq9ZujUdo7fwEDy6G+slK2rdfjk0s3NsNci/D7uuTSHO6qymxNQ4VrgBigKjtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=To4EO8gc; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To4EO8gc"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa680fafb3eso15833366b.3
        for <git@vger.kernel.org>; Thu, 19 Dec 2024 11:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734635759; x=1735240559; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNOBmwqwRj3yzOYPTCEEI8dhzc3mbBHJ18/WLJV+8LY=;
        b=To4EO8gc8XaYU9GLWSWl/bi6IYqa3awv7XZYa7xAydlvcKbH7flq7WVlZ+X8Lnfd93
         Uw6ddyFQ0kuUNzudew8uvdZDDDMwV5HHkTAYs2JQeHF2FYm39+R9gg7lpyWA4nJYSNXe
         oKuh0LCX/6oCXfK043mrQRq9W28wUc7y/zz5vwVi42O3aOMDUTrjHmnug0a7NkdR1xvk
         I8sRiZEwxBaNtohoXXhhTOeXrhVcxDuXIvlrNGuqL4Vn0DcybXQWTH3/ZWfK8LOKoXsB
         LdQ/xqD3E6ixgz67xptymGw4hSDYeD0J+09jsOwOvEtjB9gM1WsgHFz2PbIM2Y0IGnQj
         4c8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734635759; x=1735240559;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNOBmwqwRj3yzOYPTCEEI8dhzc3mbBHJ18/WLJV+8LY=;
        b=q16XGLwACMybWe862O4lYk+QlsYysZXNdfD2Cw7wBgECjHR3wDchvPOS0TLByrk9EJ
         NfxI3VSz8Ut3OUBKxcgkcNp+qqs2VPFfQw297eWMf2jqLaubBtM3Chp/sbumV/TZxsXn
         W1G62K+LpPCKwQ7fjRK7QD5BYUD6SkzoCT7OZqVE68zRu8Jryw6skSqshYz02DFdCSjB
         Dzo6dHGaHE1cE6oPLUg6F3JCl/Ut4aIg8SmZCoyKTAeToy0rei7FGKQd7OS2fYrxlIkW
         DAxiG0StAEzVSkTRNyW53c/y23z4plGdcTjf9wH1qKBKPVRdLguwhduRyYAw3wHxdQDg
         6CWw==
X-Forwarded-Encrypted: i=1; AJvYcCU6gs727Yk9uWdhd8eLYiwza7qcPNNz2hmK1cVPVQPOYy2bHvIQDuKFeTEbfUpafpIz79A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTmvY9oUdLKzlmHhXsd4k3giFLTRhx3zVCl4sCdDoaiNbI9XbZ
	+5CIKSuclsMvSKpilfhqQUAWroGj8vHnMa9aXmTTEFJPgZ8QKtk6rePi78fbZNE86OtqME3gYpz
	VP+UujOb9BQf9+3049+jEj3CEpOk=
X-Gm-Gg: ASbGnct5lgoCvy7KJd/26qLFIiC8DcsQ3V3kskPbCkxx0e1gOY818TbpjfSR9MQPRfb
	be/ZunxL++Wv+sRUO+XQr6pyximFSHDOF0dH9nR3w
X-Google-Smtp-Source: AGHT+IFRjZ5gE1tVcLron6RpJpWDZy7hsTa8k0I5UHyiz6zDLDaE+5075nYzRjieKEMtuLyaXQGoXw7MWQk2vaAwbiw=
X-Received: by 2002:a05:6402:4403:b0:5d0:b7c5:c40b with SMTP id
 4fb4d7f45d1cf-5d81dd66e01mr25011a12.1.1734635758947; Thu, 19 Dec 2024
 11:15:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGJzqs=ksKqY2M8Px3uv6ut=MBwkmpPUqp3xVzVpNMJ0YBrBww@mail.gmail.com>
 <CAGJzqsnAO_vDSYOC7ZbYUQHJ3fT10JuQ2RrC2cvY4hcPMnZ=bg@mail.gmail.com> <Z2N-rV4fhF3ZkGlp@tapette.crustytoothpaste.net>
In-Reply-To: <Z2N-rV4fhF3ZkGlp@tapette.crustytoothpaste.net>
From: M Hickford <mirth.hickford@gmail.com>
Date: Thu, 19 Dec 2024 19:15:00 +0000
Message-ID: <CAGJzqsmQY9p+nxHPB67N1P4i361adMbvT-BNR7UKfsSY=QGi2A@mail.gmail.com>
Subject: Re: Fwd: [Bug] `credential fill` prints incomplete bearer credential
To: "brian m. carlson" <sandals@crustytoothpaste.net>, M Hickford <mirth.hickford@gmail.com>, 
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Dec 2024 at 02:02, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2024-12-18 at 20:42:31, M Hickford wrote:
> > Hi. Is this a bug in git version 2.47.1? Or am I using it incorrectly?
> >
> > # erase existing example.com credentials
> > printf "host=example.com\nprotocol=https\n" | git -c credential.helper= -c credential.helper=cache credential reject
> > # store bearer token with expiry in far future in credential-cache
> > printf "host=example.com\nprotocol=https\nauthtype=bearer\ncredential=letmein\npassword_expiry_utc=2147483640\n"
> > | git credential-cache store
> > # try to retrieve credential
> > printf "host=example.com\nprotocol=https\n" | git -c credential.helper= -c credential.helper=cache credential fill
> >
> > Expected output (complete credential):
> >
> > protocol=https
> > host=example.com
> > authtype=bearer
> > credential=letmein
> > password_expiry_utc=2147483640
> >
> > Actual output (incomplete credential, no prompt for username or password):
> >
> > protocol=https
> > host=example.com
> > password_expiry_utc=2147483640
>
> This is expected.  Every request to a credential helper should include
> all of the capabilities that the caller supports on input, and the
> credential helper will always emit those on output.  `git credential`,
> however, will only emit the capabilities that were actually supported,
> so that general callers (including Git LFS) can determine the actual
> set of supported capabilities.
>
> In this case, you asked the cache helper for a credential, but didn't
> tell it that you supported `authtype` and `credential`.  Therefore, the
> only safe thing it can assume is that you are incapable of parsing and
> understanding those fields, so it doesn't emit them.  This is a benefit
> for security, because some tooling logs all fields but the `password`
> field, and we don't want to include new secret fields that the caller is
> going to shovel into a file or syslog.
>
> In addition, the helper could actually store two different sets of
> credentials, one which is a username and password, and one which is an
> authtype and credential.  If you provided the capability, the latter
> would be omitted, but otherwise the former would.  That can be helpful
> if you have a stronger credential type but might occasionally need to
> use older software (say, older versions of Git or Git LFS).
>
> However, if you provide the proper capability, this works as you expect:
>
> ----
> % printf "host=example.com\nprotocol=https\n" | git -c credential.helper= -c credential.helper=cache credential reject
> % printf "capability[]=authtype\nhost=example.com\nprotocol=https\nauthtype=bearer\ncredential=letmein\npassword_expiry_utc=2147483640\n" | git credential-cache store
> % printf "capability[]=authtype\nhost=example.com\nprotocol=https\n" | git -c credential.helper= -c credential.helper=cache credential fill
> capability[]=authtype
> authtype=bearer
> credential=letmein
> protocol=https
> host=example.com
> password_expiry_utc=2147483640
> ----
>
> Note that `capability[]` directives should always start the request to
> allow one-pass parsing.

I think a bug exists in credential-cache. Below it receives a query
*without* capability authtype, upgrades it *with* capability authtype
and prints a bearer credential.

git credential-cache exit
# store bearer credential
printf "capability[]=authtype\nhost=example.com\nprotocol=https\nauthtype=bearer\ncredential=letmein\npassword_expiry_utc=2147483640\n"
| git credential-cache store
# query with capability authtype (prints bearer credential as expected)
printf "capability[]=authtype\nhost=example.com\nprotocol=https\n" |
git credential-cache get
# query without capability authtype (expect nothing)
printf "host=example.com\nprotocol=https\n" | git credential-cache get

If you agree that this is a bug, we could add a test case to
helper_test_authtype.

Here's a second simpler example of credential-cache of upgrading a request:

git credential-cache exit
# store credential
printf "host=example.com\nprotocol=https\nusername=tim\npassword=hunter2\n"
| git credential-cache store
# get credential (response is upgraded with capability authtype)
printf "host=example.com\nprotocol=https" | git credential-cache get



>
> Hopefully this is helpful.
> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA
