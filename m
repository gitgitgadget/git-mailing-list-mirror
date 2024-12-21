Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70CA56B8C
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734768554; cv=none; b=DagZgPEevh/O2g0zFz5bm7xAToeWe3+j53R0NyRnKdsD2mmLuI9/ywJOypYPiZtaDI1tW3kxQMOh3JTRsquv7yYjKEN+17DrCbWExLfcp23LVolM5bwpBMus5kYcLYV7ZpeR/lsJ6Y11w9yk3ory0/+kKYyxKH+ZVZCosEM79kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734768554; c=relaxed/simple;
	bh=vtvnP0kLumOtimyuq+Vo3v6lhmzK03KGuW2hYVVL/ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFXXiIOraFqfZ6a89BTPGcsnhlg5JbBbRnhaYszKtOJgCCXQTGN4760L2DhAQNcGlJF5MTsABF9PpX/poo91mE4qmqwUSaDvtEIWWsM3armVHEEVcN0Izhipy5rNaj8gbWF3+oZ94lSHFBIQLaz92WcNDI4oW+AFJrF4JC4RdIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2Atik/G; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2Atik/G"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3da226a2aso382444a12.0
        for <git@vger.kernel.org>; Sat, 21 Dec 2024 00:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734768551; x=1735373351; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AS6zCxuFCvEfAYCmEMp5rnoy30eZPYl5Efl+U8yKqGg=;
        b=E2Atik/G7V7LwJGN4c/4m07i97W1nIvz4Cg4YEPc5i0+3znkc1FzDY6fC8DY0BvmC6
         PCmG5uEOwU8e7y+rxllZ5rZN12K8211V0NWI6UVecOokQJTUgt8hTSoi5Fc30aVqLyAa
         N6MfliCi6lEqcIgvYCqmAu2BzWB4Ug+PEA7xZ4E2fShlX4THG5wORkhSJFwuRHrCuARt
         f1PkXwED4VTX1iirJ7879ZXxLC8MMxuWas+Br6V+iP8ZEXiEY4Om7mIW3IyZ/J1+DOCB
         kapAeT5cqImjzTpn9YM3P71yyJJ5LRObEC8rSmo5BXYLXskk/7RtZZo8Kg/1LQBt5zSz
         thfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734768551; x=1735373351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AS6zCxuFCvEfAYCmEMp5rnoy30eZPYl5Efl+U8yKqGg=;
        b=j6m5ye6ejMU2J6wIV6YIWU65Rk8b4JnZol/t2tC6c7uIeW6TlJ3CQ1Nnbpa9Wu52Hl
         Xrw6BpkKiFUPqbXT35l9OB1SyzxaZKPT13SFP1alyU3VR3aAHL5JrVFUhDodldmc0ezd
         lfVUhPEyZRCEI/5lLSVP5vQaa3AB9ZOwnVHJLmFCuPXTajsyRXM2b+vMduy0Ygaglmtx
         4068JBNHpPRFcil1lA9XozYXpNM2a5KsIsYgrggmXHXgqnjruvNh6o2XZ8kHbJFeyU6J
         yvMdAv0lEuFkAdNFFdvh0vbyWGXkut904KOPpjq6gY55ZZpDc5sE8Xvj+xXQ+l24aBt/
         2Z/g==
X-Forwarded-Encrypted: i=1; AJvYcCU6j9HGbKUweEdVt1fhd2vKOxMTF1hv+CsUjWVNATIGDY0Z8Byf8My7s9XzVMAda6ERFNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOn8X7PFI43xk9WjQL3xPsH1XLcQFQqnZn2Wor/DynG6w7CyRv
	LnclIBi6VbWoUv3523h5CkI7C2bYu9gSQRDvNQG0hXfJ+UFom3/gmkQE3AHIhBWGGoCB9w3JZT1
	MMhBBNzoM/s61FmA7f6pW0ron1j3OV0sh
X-Gm-Gg: ASbGncv5F0gGj3HNpJRcg/q6lhTLPJF8BBh2Jj4mCvTsPCDnA2hUiM62heEd8EMGyWp
	L5HryMqrLWZMmVB6CaOrtwLZctP88FGneErVk
X-Google-Smtp-Source: AGHT+IFzgqGDPcrUYVtXYBw0z6DmpeZ4DxxUPbmxoAIXwSVMqQ+kgVLby8FamXwOPWWL7bJHlHgUKpIh1H1w/eA/Aig=
X-Received: by 2002:a05:6402:3550:b0:5d4:35c7:cd70 with SMTP id
 4fb4d7f45d1cf-5d81dd9cbebmr2024454a12.4.1734768550734; Sat, 21 Dec 2024
 00:09:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGJzqs=ksKqY2M8Px3uv6ut=MBwkmpPUqp3xVzVpNMJ0YBrBww@mail.gmail.com>
 <CAGJzqsnAO_vDSYOC7ZbYUQHJ3fT10JuQ2RrC2cvY4hcPMnZ=bg@mail.gmail.com>
 <Z2N-rV4fhF3ZkGlp@tapette.crustytoothpaste.net> <CAGJzqsmQY9p+nxHPB67N1P4i361adMbvT-BNR7UKfsSY=QGi2A@mail.gmail.com>
In-Reply-To: <CAGJzqsmQY9p+nxHPB67N1P4i361adMbvT-BNR7UKfsSY=QGi2A@mail.gmail.com>
From: M Hickford <mirth.hickford@gmail.com>
Date: Sat, 21 Dec 2024 08:08:29 +0000
Message-ID: <CAGJzqskPyjhLQKP7DmfE8kYF9NHTPqQ35eG9nbOPGg9AD+oLXQ@mail.gmail.com>
Subject: Re: Fwd: [Bug] `credential fill` prints incomplete bearer credential
To: M Hickford <mirth.hickford@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Dec 2024 at 19:15, M Hickford <mirth.hickford@gmail.com> wrote:
>
> On Thu, 19 Dec 2024 at 02:02, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > On 2024-12-18 at 20:42:31, M Hickford wrote:
> > > Hi. Is this a bug in git version 2.47.1? Or am I using it incorrectly?
> > >
> > > # erase existing example.com credentials
> > > printf "host=example.com\nprotocol=https\n" | git -c credential.helper= -c credential.helper=cache credential reject
> > > # store bearer token with expiry in far future in credential-cache
> > > printf "host=example.com\nprotocol=https\nauthtype=bearer\ncredential=letmein\npassword_expiry_utc=2147483640\n"
> > > | git credential-cache store
> > > # try to retrieve credential
> > > printf "host=example.com\nprotocol=https\n" | git -c credential.helper= -c credential.helper=cache credential fill
> > >
> > > Expected output (complete credential):
> > >
> > > protocol=https
> > > host=example.com
> > > authtype=bearer
> > > credential=letmein
> > > password_expiry_utc=2147483640
> > >
> > > Actual output (incomplete credential, no prompt for username or password):
> > >
> > > protocol=https
> > > host=example.com
> > > password_expiry_utc=2147483640
> >
> > This is expected.  Every request to a credential helper should include
> > all of the capabilities that the caller supports on input, and the
> > credential helper will always emit those on output.  `git credential`,
> > however, will only emit the capabilities that were actually supported,
> > so that general callers (including Git LFS) can determine the actual
> > set of supported capabilities.
> >
> > In this case, you asked the cache helper for a credential, but didn't
> > tell it that you supported `authtype` and `credential`.  Therefore, the
> > only safe thing it can assume is that you are incapable of parsing and
> > understanding those fields, so it doesn't emit them.  This is a benefit
> > for security, because some tooling logs all fields but the `password`
> > field, and we don't want to include new secret fields that the caller is
> > going to shovel into a file or syslog.
> >
> > In addition, the helper could actually store two different sets of
> > credentials, one which is a username and password, and one which is an
> > authtype and credential.  If you provided the capability, the latter
> > would be omitted, but otherwise the former would.  That can be helpful
> > if you have a stronger credential type but might occasionally need to
> > use older software (say, older versions of Git or Git LFS).
> >
> > However, if you provide the proper capability, this works as you expect:
> >
> > ----
> > % printf "host=example.com\nprotocol=https\n" | git -c credential.helper= -c credential.helper=cache credential reject
> > % printf "capability[]=authtype\nhost=example.com\nprotocol=https\nauthtype=bearer\ncredential=letmein\npassword_expiry_utc=2147483640\n" | git credential-cache store
> > % printf "capability[]=authtype\nhost=example.com\nprotocol=https\n" | git -c credential.helper= -c credential.helper=cache credential fill
> > capability[]=authtype
> > authtype=bearer
> > credential=letmein
> > protocol=https
> > host=example.com
> > password_expiry_utc=2147483640
> > ----
> >
> > Note that `capability[]` directives should always start the request to
> > allow one-pass parsing.
>
> I think a bug exists in credential-cache. Below it receives a query
> *without* capability authtype, upgrades it *with* capability authtype
> and prints a bearer credential.
>
> git credential-cache exit
> # store bearer credential
> printf "capability[]=authtype\nhost=example.com\nprotocol=https\nauthtype=bearer\ncredential=letmein\npassword_expiry_utc=2147483640\n"
> | git credential-cache store
> # query with capability authtype (prints bearer credential as expected)
> printf "capability[]=authtype\nhost=example.com\nprotocol=https\n" |
> git credential-cache get
> # query without capability authtype (expect nothing)
> printf "host=example.com\nprotocol=https\n" | git credential-cache get
>
> If you agree that this is a bug, we could add a test case to
> helper_test_authtype.

Here's a small fix and test for credential-cache
https://lore.kernel.org/git/pull.1842.git.1734729534213.gitgitgadget@gmail.com/

>
> Here's a second simpler example of credential-cache of upgrading a request:
>
> git credential-cache exit
> # store credential
> printf "host=example.com\nprotocol=https\nusername=tim\npassword=hunter2\n"
> | git credential-cache store
> # get credential (response is upgraded with capability authtype)
> printf "host=example.com\nprotocol=https" | git credential-cache get
>
>
>
> >
> > Hopefully this is helpful.
> > --
> > brian m. carlson (they/them or he/him)
> > Toronto, Ontario, CA
