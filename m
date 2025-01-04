Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE45CA932
	for <git@vger.kernel.org>; Sat,  4 Jan 2025 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736006141; cv=none; b=RSYC182EbW8Pozkux1IsZfjtiIoLYL5Nvsw9EUfo1tTTDnL9/OmPvLHV3Jz77JyUNQ//26/XH6HIOumtugl3RXQw5tJUdmNPRDWJEDu+EWjCpkMHRuJakIOLkp8cFrEwgpz9Nbq9iXXTfKxV6doHlghu9FxaeglxYZ08zg0Wcxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736006141; c=relaxed/simple;
	bh=8druj0QOYrybLKTIqOwusDRnDodnUJG6eGL0bgG/3LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvMXLntBwE72puHECg4tiQgxjdUP/GfEvxPP2SY5BQXWgnDu9GFfpgA8CnJ9Z7mm/akfPqaEECmLC/shlwkGkBEAcILZo5/8pHASelCQyU5s1YW7eNvSQRD08Cv3b1k6FwRLgZtZIh+pRaw3UoJrDVqyGMZKvu+Xr5+hC2u8be4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ad4oTpr4; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad4oTpr4"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8442ec2adc7so487817639f.2
        for <git@vger.kernel.org>; Sat, 04 Jan 2025 07:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736006139; x=1736610939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHhl/pNY5uBtQpPuo3Y86bAn0f49YfSH2Kn2oWKTIFM=;
        b=Ad4oTpr4n2xpnp5sx2jE10+Wb5oL7IBYWhXXuOy+PGveT7MjAovNtAYRgRYTglP+ST
         VNPsvW3zSQuLmxmDhS9Ry1S8LwvXN5zPS1sU3yEqZKC7xsFHexjx3eziqembD/iTItYA
         bzjXfmWpC3xjORspIdThTiWofWpyhY/M629iZ14nk+9Hv3BsNnXEN7V6MMst57N4fhns
         9PWbq13itcXhpv9Ly07gPYEcyFAqPClS+est5E/KVm9Fl6jQaY6PhopsGa3lKIfe0RBP
         kRcTQFs701W4m/dutVPuipltleZt38S8IutBBpRjb6wRkoggY6RwQ2usmbmvRhFWz+NX
         5mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736006139; x=1736610939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHhl/pNY5uBtQpPuo3Y86bAn0f49YfSH2Kn2oWKTIFM=;
        b=EIyk/AzBIN/b/dNrQS+iss+xcHpQOJEc4KzTJEYYHHTZXnnjk6vtZAeWJCvzfd1Z7q
         FbFzB+hbnBAiQzyiyCm+rCuZp89EQUQLjvw0XnYQlSJ9CD6/OsDqtjb2xNe9R5BYxWIJ
         HYYRR2nOj9vuZsShXGRngPI94vsTTshgdDMq5iP2qIWTMdDJLsl+vBEsbMKWZL+6jU0O
         c7P+iPLusCJn+D+CG11N/Y63NYG5gaE1iyswQWNF3w5YaZdxJI5CicwzwvGonUYbgOAK
         hPRl1+kYBI2n02w0gmI56RyFbMT5xcMGO5wlIoXKCEQXs2wiAy/F+M/6O0vUmwy8K35l
         xofw==
X-Forwarded-Encrypted: i=1; AJvYcCU82zrVuMmzIzya8A02VInyMibVqzSZkmFAYumg3MM6oI8GRLZXHfmQ5y7e7uZxj1kZTxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvUPQh+JzsioUsjiTIC4c48bufuZQTORuAKIPWuyGlRZ1JOnSd
	qL8yD8u2VTtTrXBKxDN2/9FCVlLCMPFjf51npVEdNOLe4vkynXyZgNf+AQi16LwneacH95RWstS
	dTxSYktnb0/e8e9tttdMkSxJDYqY=
X-Gm-Gg: ASbGncuszrdJ3hYWWWGAXwmvoeWKo3tLvJDxtUworBJG8E5R9VUZIti/8zR3gkOW1Aj
	d5cqY3VwMommJcKmjB5mImO1uxhT3Ot1T5OM5fSeCwSoRWQxB9byn
X-Google-Smtp-Source: AGHT+IHbmlo8jnncKJF2HFW5g8/5Srit85XVieoIiQec/QiY8JKmQbWzvxcRuO+8ssjBcy5O96mxgtkN0wt6gQQn01Q=
X-Received: by 2002:a05:6e02:1d02:b0:3a6:b445:dc92 with SMTP id
 e9e14a558f8ab-3c2d2568b0emr434191915ab.10.1736006138826; Sat, 04 Jan 2025
 07:55:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1844.git.1735699989371.gitgitgadget@gmail.com>
 <pull.1844.v2.git.1735949870.gitgitgadget@gmail.com> <xmqqed1i4pga.fsf@gitster.g>
In-Reply-To: <xmqqed1i4pga.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 4 Jan 2025 07:55:27 -0800
Message-ID: <CABPp-BEzKyXY7YZOzedwQzAFqLiE_9oWsD=GByiDhi7go2aXNw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] object-name: fix resolution of object names
 containing curly braces
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 4, 2025 at 6:35=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >  * Added a second patch for another bug discovered by the same reporter=
,
> >    where branch:path/to/file/named/major-gaffed is interpreted as a req=
uest
> >    for a commit (namely affed) rather than a blob. (At least, assuming
> >    commit affed exists)
> >
> > The second patch has some backward compatibility concerns. People used =
to be
> > able to do e.g. git show ${garbage}-g${hash}. I tightened it to
> > ${valid_refname}-${number}-g${hash}, but do we want to allow e.g.
> > ${valid_refname}-g${hash} (allowing the count to be omitted) or maybe e=
ven
> > allow a subset of invalid refnames?
>
> My take on it is that it is an absolute no-no if we require that
> ${valid_refname} exists locally, and it is still iffy if we checked
> ${valid_refname} with check_format() (because the definition of
> validity can change over time, and we would not know the rules that
> were valid back when the reference to the commit was written).

Fair enough.  However...

> Otherwise a tightened rule would make "${garbage}-g${hash}" less
> useful to copy-and-paste from a text file to command line.
>
> In general what would we do if a string can be interpreted in
> multiple ways in _different_ parts of the object-name codepaths.  We
> all know that "affed" would trigger the "ambiguous object name"
> error if there are more than one object whose object name begins
> with "affed", but if "${garbage}-gaffed" can be interpreted as the
> name of an object whose object name begins with "affed" and also can
> be interpreted as the name of another object that sits at a path
> that ends with "-gaffed" in some tree object, regardless of how the
> leading part "${garbage}" looks like, it would be desirable if we
> declared such a string as "ambiguous" the same way.

How would that be desirable?  There's no possible way to disambiguate.
While abbreviated revisions can just be modified to be less
abbreviated, paths cannot be spelled any other way.  How would you
spell
      master:path/to/who-gabbed
in a "less ambiguous" way to differentiate it from commit abbed?  As
far as I can tell, this proposal just leaves the user stuck with an
error with no way to get the path they want.

If you don't like check_format() being called on the leading part of
the string, can we at least enforce that there is no ':', so that we
can successfully request explicit paths of given revisions and know
that we'll get them?  (That'd disallow e.g. next^{/doc:}-12-gabbed,
but that clearly was never a valid describe output anyway.)
