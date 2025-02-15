Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C3942AA5
	for <git@vger.kernel.org>; Sat, 15 Feb 2025 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739633396; cv=none; b=I5Xeaa/90SjeSLETJFCfyAGC8AP6Mp6igz4iIFJGiz/j8ee9/H5XMJUIGfscQ21MWxXf3pj8zcgp9azgKVEX6L1fLJg5fInZDdVL/MS6A0/ZtON6gTvjGtlP5yFQMFh6uEaPdiH9mS8obHz97Nn+Pqce0VzIICf3PuUYLLSfimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739633396; c=relaxed/simple;
	bh=TQMEoURZDtaKjbodir0zUglkZJUs2V2CfcGSKr+OMsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTbc0F3HihP6ldDsbvoPQjpcEaVxjK9GyjYFtpWMIrQ28cf33p3aKf0jxPC/Oyifp8DdDndw7edj9Bkjc6lIyrdE5e3+ryQDkXM/xyB8a38gy/W8MaEsVemFMmCrh5csrv3ZmvypzkspvEH0Alf7ya4LXl74mCFkFcwpSuXASag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2ieiU7e; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2ieiU7e"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5205276bdb8so968794e0c.3
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 07:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739633393; x=1740238193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnMeTVTBJBPfoaTFeivUbJoeZ9/63yrQprGAVTKozaM=;
        b=F2ieiU7evlBlleTf76h4Wfqz9uyNBcHV5qhg2fbZ8qrLnW6KFOs44v+lrk1Ry586d4
         jNEB6sw4rxd0Wnu7SK7kgFO2dnjydkVZMgQG7TC4q/vfftnyvPVohODSQokVZUpPW5Db
         HP8BWOpe56tYj8/QzX5M32/eLXzxgcUAiVe5lY8lVkKPUnaZxdot1G+9CeykDopaGS8U
         06o5eztn5njs87r3xOwjfaYcM+xOW3JD3t1KVuZfrXvWkfk3wRvhZZZu+2upAZt7wPfx
         kPH81kny/Gg76dyG8TeLbPGvs5wrC3DoKfOMQWH03fZbXQWo0rWUSgZBprBGpQwxmjTU
         J2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739633393; x=1740238193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnMeTVTBJBPfoaTFeivUbJoeZ9/63yrQprGAVTKozaM=;
        b=pw+XG+5u7RWbGne1gBrDi4SEQP2zuYS7VypE1Z7qRPLmmYGg+rU13xwT/wHCknG2W8
         11Sx1KlTWrSTT9wYrjBu9TADzsiYTaWZjyKopuaNKPG5YP0SsagmcYKC0lLGbc99gyjJ
         rKP/YkwwgFW29vtSecgebniKxJoows1bMkNA8nqmTkNNfJFKo2fUOqtKMPrGFpsGsayk
         TYj6qjS5MyyuypYtogRu7XXTYtg2h4KgtLb931dj2de+VKBbex+5BHVFQrovUT1DFz/N
         ByNPXOAj3ArqZMPAS9ott7T/qMcDY9UTcp9JXB0KKJ46/5LADA+jamnWvXWQoMe1dIs+
         PSIg==
X-Forwarded-Encrypted: i=1; AJvYcCVs8pUgyhUHnit66ImGAhErB4Rgx/ufrU8ektKlOQKoDh5Stq8XhAW265qdc4ECoFHHyTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhQIN6j9lFLn1FBba/2mNEPzVdSElSt3Rx15Y+jJcowMRxKYVp
	E9s4FqH8iQ7V6hdF0HgHL3PfrKzaH+zjwGjcTJejGvwP4vfne3GidccL0gn9UBAUOCY8ZCftfET
	shed2RZ5skivIeVdK76CFyKti1bQ=
X-Gm-Gg: ASbGncsn5Sw2tzLK22mdPLI0oYjiQfYrkwVD/G4qtGGKQgECma7c2Jh2dSk8tdkIrKk
	1no0W2aV1ZdQyCco2MyDqG1mhovjlCUmnki9GArVuCipQvrp1MgAHcRf+9+scLg16VxlViy17
X-Google-Smtp-Source: AGHT+IHQqxkDS8vC3Xx5fY6zc6DNJEx5Kn2QpgKSs3uF7RlapuxSWAaqJvWbnlSL0VuOL34PkNv0B3kqj0GVXLuSeNo=
X-Received: by 2002:a05:6122:658b:b0:520:62ce:990f with SMTP id
 71dfb90a1353d-5209de5ea3amr1283236e0c.11.1739633393095; Sat, 15 Feb 2025
 07:29:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205185246.111447-1-usmanakinyemi202@gmail.com>
 <20250214123734.1403120-1-usmanakinyemi202@gmail.com> <20250214123734.1403120-7-usmanakinyemi202@gmail.com>
 <xmqq34ggkwnx.fsf@gitster.g>
In-Reply-To: <xmqq34ggkwnx.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 15 Feb 2025 20:59:41 +0530
X-Gm-Features: AWEUYZmZlRZOOKWB8o8lJbBFDgYER3cmLYH6KWBYt0CGs0tKxSQmht4_6QgMJyg
Message-ID: <CAPSxiM8t1TdvKwXuX1XZq_ms6WeJNBMMfhryY-x=835Z8zyHdQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] agent: advertise OS name via agent capability
To: Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, 
	Johannes.Schindelin@gmx.de, johncai86@gmail.com, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, ps@pks.im, rsbecker@nexbridge.com, 
	sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 3:37=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
Hi Junio,
>
> > As some issues that can happen with a Git client can be operating syste=
m
> > specific, it can be useful for a server to know which OS a client is
> > using. In the same way it can be useful for a client to know which OS
> > a server is using.
> >
> > Our current agent capability is in the form of "package/version" (e.g.,
> > "git/1.8.3.1"). Let's extend it to include the operating system name (o=
s)
> > i.e in the form "package/version os" (e.g., "git/1.8.3.1 Linux").
>
> Shouldn't this be "git/1.8.3.1-Linux" or something to avoid SP?  The
> capability list in protocol v1 is on a single line that is whitespace
> separated (cf. connect.c:parse_feature_value()) without any escape
> mechanism.
Yeah, I almost missed this function. Thanks for pointing it out.
>
>         Side note.  Does it pose a security hole, when we can set
>         agent to any value?  I do not think so, as it controls what
>         this end sends to the other.  If you are attacker in control
>         of your own agent string to be sent to the other end, and
>         use a string with a whitespace in it after "agent=3D" to claim
>         that you support a capability you actually don't, that is
>         not a new way to attack the other side available to you---you
>         can write your own Git client to talk to the other side to
>         send such a bogus capablity list anyway.
Thanks for this explanation.
>
> > diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotoc=
ol-v2.txt
> > index 1652fef3ae..f4831a8787 100644
> > --- a/Documentation/gitprotocol-v2.txt
> > +++ b/Documentation/gitprotocol-v2.txt
> > @@ -184,11 +184,14 @@ form `agent=3DX`) to notify the client that the s=
erver is running version
> >  the `agent` capability with a value `Y` (in the form `agent=3DY`) in i=
ts
> >  request to the server (but it MUST NOT do so if the server did not
> >  advertise the agent capability). The `X` and `Y` strings may contain a=
ny
> > -printable ASCII characters except space (i.e., the byte range 32 < x <
> > -127), and are typically of the form "package/version" (e.g.,
> > -"git/1.8.3.1"). The agent strings are purely informative for statistic=
s
> > -and debugging purposes, and MUST NOT be used to programmatically assum=
e
> > -the presence or absence of particular features.
> > +printable ASCII characters (i.e., the byte range 31 < x < 127), and ar=
e
>
> Patches 1 & 2 redacted non-printables and SP separately, because SP
> is considered printable.  With this change you are allowing SP to be
> passed without getting redacted?  I do not think it is a good idea
> (see above).
>
> While I'd prefer to keep the range the same as before, i.e. "any
> printable ASCII characters except space", "33 <=3D x <=3D 126" may be
> more readily recognisable that we are doing something unusual, as
> "32 <=3D x <=3D 126" is fairly easily recognisable as "ASCII printable".
>
> > +typically of the form "package/version os" (e.g., "git/1.8.3.1 Linux")
>
> So, I'd suggest using something other than " " between "version" and
> "os".  Dot (as if the byte there were redacted) or slash or dash or
> whatever, anything that is not whitespace.
Yeah, Noted. Thanks.
>
> > +where `os` is the operating system name (e.g., "Linux"). `X` and `Y` c=
an
> > +be configured using the GIT_USER_AGENT environment variable and it tak=
es
> > +priority. The `os` is retrieved using the 'sysname' field of the `unam=
e(2)`
> > +system call or its equivalent. The agent strings are purely informativ=
e for
> > +statistics and debugging purposes, and MUST NOT be used to programmati=
cally
> > +assume the presence or absence of particular features.
>
> Other than these nits, I find the above very well done.
>
> As to the additional implementation of git_user_agent_sanitized(),
> except for that same "do we really want SP there?" question, I see
> nothing questionable there, either.
>
> Overall very nicely done and presented.
Thank you.
>
> Thanks.
