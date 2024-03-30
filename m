Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7891A79D8
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711785725; cv=none; b=mRikzm86gW2sOecLZjfib627b4GvVRkeSPBq6afoWejvvwTiR9VfEG6+yVNkEu7AoSLq3Yjk0wYnASeFsnSkc1oi+nLWKRH8IUVj3DfsgV0idnVEctIv/PnNq5Q4byIAu5OsiJx+G1DOiUeq1d50+jYfUz4exleQL/1Ss7J8MgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711785725; c=relaxed/simple;
	bh=rWRC/GyRPToXYWAnNkVzh0Q6tdeEYVA2EV4BDFV6KcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVBGGj3nkOegetetPDiyq9oZt5Mvktsn/n5BFP50RvsEPRPMqiGQnVtGF7/ULXEap7Na8DjsaZRfQPima3eCxZEcNgGXIMZkYcnBCh1MLLVCtKPWUGLop7PSUUjHjOb51fvshYcaEZVBcHnEXl3CONQyYgQwqVAvnritGogUvnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gbkipui4; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gbkipui4"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4734ae95b3so336315066b.0
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 01:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711785722; x=1712390522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HpKqC1scH/aprsdI+BQzU1JdbVyOWg2IYRw4RW7f4dA=;
        b=Gbkipui4wof/sSOcBraLoGVOVLODNh/bZCBhBrEmvxuLl/nc2rmjUosvEW5rMqkVbn
         fk0JUAIher8MUXbjK8lHHvC4ROhYocC+QMYbDUztl+uFydAxkoFmVsr6uoLhdGEuwmnK
         dNNtZGWU2beVwovSM6vWfssD8b1YeOfnaYLUrNPheh+NLIbGkmqr/GPPunPkBG9c5Pr1
         aGwCIRGJ+4rbSXE/SMjajDHfL9mQ/6XIcKMy95FPq5GnFaGJV+y+d4G90vClVws+Av/N
         FlpNKYhiW75L98hYq3iqNswc1jJwinsrUr62FCb8M0k21zzKfONg1xQAGLIgmboU3E4h
         ZL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711785722; x=1712390522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpKqC1scH/aprsdI+BQzU1JdbVyOWg2IYRw4RW7f4dA=;
        b=HtUFzptMOGifQNtZVmsiZTaUD6U3rdDICeTf8GT6ggUwYVK+deAoITvry5TOnNsI5T
         th/oR50YFwVxn1j5UIHWaum/XoJHb1fajeetxvkYzfPSJAOVWEiOsjs8fLZuStcLjiaZ
         UYYwW0NtmXhsX9EMlYWt6yXR1w9nCU+frYqtw/ySUxlREik6gtlsR+uXl/nrny1j0HMH
         irCUDptLSFvtDfhdBUgfwDvHfwsfoWjS+Nm5F46FUdhKSp9Gpb0gUwsEkxXtKF2Ibjhb
         b16iERoeHehQwOh0r+UStQG/kj3SbCXga5oZxjIdCW3pTGJJGMMFlAhgeuh8lwDOLlso
         A75g==
X-Gm-Message-State: AOJu0YzV7ESfCYF1JXzHhJvISX1dLJQTg1yv7u7kswpnWsEQtFz4O+J7
	JlSjTLqkFTxKxK+nJnCnVv01ttTK0f+IhozHgTyL1vlEL2yaBzJo9BC23eBOmhZFUr1RhXLZqLM
	w+LAC8+ifF3r7Li1Fy/qN/4oTe/Q=
X-Google-Smtp-Source: AGHT+IEGelvSHOFAVqQofPw02QQms9rI6hES4k7gUBo/pF2FcsBJq2op2DKOvEfZB/wYumsNLpPlFYB6lGr6tj1QAJw=
X-Received: by 2002:a17:907:7e9a:b0:a47:4ae0:3bb9 with SMTP id
 qb26-20020a1709077e9a00b00a474ae03bb9mr3303795ejc.23.1711785721540; Sat, 30
 Mar 2024 01:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
In-Reply-To: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
From: M Hickford <mirth.hickford@gmail.com>
Date: Sat, 30 Mar 2024 08:00:00 +0000
Message-ID: <CAGJzqsnNmz1P1bqOztiC5=-SXDD=j_oaCuPLcPf_NV4c7VNjMA@mail.gmail.com>
Subject: Re: [PATCH 00/13] Support for arbitrary schemes in credentials
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Matthew John Cheetham <mjcheetham@outlook.com>, M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Mar 2024 at 01:13, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Right now, HTTP authentication in Git is mostly limited to approaches
> that require a username and password or are Kerberos (GSSAPI).  In
> addition, we effectively require that libcurl (or, for other software,
> such as Git LFS, using the credential helper, that HTTP library) knows
> how to implement the authentication scheme.
>
> However, this poses two sets of problems.  First, some sites, such as
> Azure DevOps, want to use Bearer authentication, which we don't support.

Git's lack of support for Bearer auth is also a frustration for OAuth
-- OAuth tokens are intended as Bearer tokens. As a workaround,
popular Git hosts support Basic auth with an OAuth token as password.
For certain hosts, this requires a magic username such as 'oauth2'
(GitLab) or 'x-token-auth' (Bitbucket). This is problematic if the
user has multiple accounts, or a different username stored in
credential.username or the remote URL.

> This is implemented using `http.extraHeader`, which is not a secure way
> to store credentials, since our credential helper protocol does not
> support this functionality.

Config key http.extraHeader is particularly unsuitable to hold
short-lived Bearer tokens. For example, GitLab's OAuth tokens expire
after 2 hours.

>
> In addition, other tools using the credential helper protocol do not
> support the variety of authentication mechanisms that Git does.
> Specifically, making NTLM function in a useful way on Windows is
> nontrivial and requires extensive integration and testing with C code,
> and because of this difficulty and the fact that NTLM uses cryptography
> known to be insecure since 1995, there is often little interest in
> implementing this support outside of libcurl. However, it would be
> helpful if people who want to use it can still use it.
>
> This series introduces new functionality to the credential helper
> protocol that allows helpers to produce credentials for arbitrary HTTP
> authentication schemes using the `authtype` and `credential`[0] fields.

Exciting! I drafted a patch to make git-credential-oauth generate
Bearer credentials
https://github.com/hickford/git-credential-oauth/pull/51 . Tested
together with your patch, it works for host bitbucket.org. Though of
course it isn't practical while storage helpers (such as
credential-cache, credential-wincred, credential-libsecret and
credential-osxkeychain) are unable to store the new attributes -- the
user has to complete the OAuth flow for every authentication.

> This allows a suitable credential helper to send Bearer credentials or
> any other standard or custom authentication scheme.  (It may be able to
> be extended to other functionality in the future, such as
> git-send-email, to implement custom SASL functionality, and due care has
> been taken to make the protocol adequately flexible for that purpose.)
>
> In addition, the protocol is also expanded to include per-helper state
> and multi-legged authentication (the former is effectively required for
> the latter).  The per-helper state can be useful to help credential
> helpers identify where the credential is stored, or any other
> information necessary.  Because NTLM and Negotiate (Kerberos/wrapped
> NTLM) require two rounds of authentication, the multi-legged
> authentication support along with per-helper state allows the helper to
> support these authentication methods without Git or other clients having
> to be aware of how they work.  (This would also be useful for SASL, as
> mentioned above.)
>
> This series introduces a capability mechanism to announce this
> functionality, which allows a helper to provide a username and password
> on older versions of Git while supporting more advanced functionality on
> newer versions.  (This is especially important on Azure DevOps, where
> NTLM uses a username and password but Basic or Bearer can use a personal
> access token.)  It is also designed such that extremely simple
> credential helpers, such as the shell one-liner in the Git FAQ that
> reads from the environment, don't accidentally claim to support
> functionality they don't offer.




>
> In addition, there is documentation for the expanded protocol, although
> none of the built-in helpers have been updated (that will be a future
> series for those for which it's possible).
>
> My personal interest here is getting credentials out of config files
> with `http.extraHeader` (which a future series will produce a warning
> for) and also allowing Git LFS to support Digest and NTLM with a
> suitable credential helper.  Git LFS used to support NTLM using custom
> code (because the Go standard library does not), but it was found to be
> broken in lots of ways on Windows, and nobody with a Windows system
> wanted to fix it or support it, so we removed it.  However, there are
> still some people who do want to use it, so allowing them to use a
> custom credential helper they maintain themselves seems like the best
> way forward.  Despite the advantages of this series for Azure DevOps, I
> have no personal or professional stake in their product; my only
> interest is the general one in whether their users can securely store
> credentials.  I believe the changes here are of general advantage to the
> Git userbase in a variety of ways such that the goal of this series
> should be uncontroversial.
>
> Feedback on any portion of this series is of course welcome.
>
> [0] A name different from `password` was explicitly chosen to avoid
> confusion from less capable protocol helpers so that they don't
> accidentally send invalid data.  This does have the downside that
> credential helpers must learn a new field to not log, but that should be
> generally easy to fix in most cases.
>
> brian m. carlson (13):
>   credential: add an authtype field
>   remote-curl: reset headers on new request
>   http: use new headers for each object request
>   credential: add a field for pre-encoded credentials
>   credential: gate new fields on capability
>   docs: indicate new credential protocol fields
>   http: add support for authtype and credential
>   credential: add an argument to keep state
>   credential: enable state capability
>   docs: set a limit on credential line length
>   t5563: refactor for multi-stage authentication
>   strvec: implement swapping two strvecs
>   credential: add support for multistage credential rounds
>
>  Documentation/git-credential.txt   |  59 +++++-
>  builtin/credential-cache--daemon.c |   2 +-
>  builtin/credential-store.c         |   2 +-
>  builtin/credential.c               |   7 +-
>  credential.c                       | 114 ++++++++++-
>  credential.h                       |  69 ++++++-
>  http.c                             | 128 +++++++-----
>  http.h                             |   5 +
>  imap-send.c                        |   2 +-
>  remote-curl.c                      |  14 +-
>  strvec.c                           |   7 +
>  strvec.h                           |   5 +
>  t/lib-httpd/nph-custom-auth.sh     |  17 +-
>  t/t0300-credentials.sh             | 136 ++++++++++++-
>  t/t5563-simple-http-auth.sh        | 308 +++++++++++++++++++++++++----
>  15 files changed, 760 insertions(+), 115 deletions(-)
>
