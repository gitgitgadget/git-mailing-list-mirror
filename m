Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE8615D5C1
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727419805; cv=none; b=bbFaXZk47D9obiVD+Q3zkPUHuopVfl2nMvY1rdxGllqfu/PM093ceporYFuj3jO8TlNeZQS82gznmZq/MhGYpWNFksiS94fT10aZrYVdAjkaVJ3I8SQD0ejEYTLCCcrFhTGhonHEjxCanPU+7Os3wHO+MegeeehBa3j86509zcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727419805; c=relaxed/simple;
	bh=ROSY+H059TWsKl73We/WNURMMYQf3BLMOjZ3yuRa40U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LbmEeihXZdTr6qFzSkuVJaD1V01Z2RTWo990CAGmjWQHCdlGefLkB+C8EayARgkQr8YJ8uB81Y33IXZLlCSY9id/uPM0vYOAEQgIVviCR3zeSkT9XTFTppzuM4+UsFEFLYjMxVZlp1ji3flKOSrryJnY+yCiJkZ9lwa7Btbukz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQVoOE2F; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQVoOE2F"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6c34dd6c21aso11419046d6.2
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 23:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727419802; x=1728024602; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yL9dPMgc3r5glD+27NLFtoi6sCiWGNmuw3BL30uj26M=;
        b=dQVoOE2Fj0e50JNLVy86/EAx3CehSj/ue0Ibql9eQw4PXp2kWXPyrQqDTHwcAsREuj
         VjTnzfY+uVUSoGjbxw40t9iF01Watk26FBye1Z8g1XbR8MPfjBTJZKSiB6Lp1KMtXTR9
         LAfrF1IcjDM/p3aAGl1uOz2shP7t6/8LFUozC0xCDYbTzzIvd03vdOzoh1QgvTg00Lh3
         HMe6j+NacMJZI9io145IzVFoh7pbRxkqQ3x30I81cqEgIODMMvVWRjuju2kgODg15YbP
         6tsWPIriwzXgePYY8i57qPHRgRTyA/Q9wvCBWH+xVRo8aJu2BGDYLg+CK3EUFHwrvqJL
         LXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727419802; x=1728024602;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yL9dPMgc3r5glD+27NLFtoi6sCiWGNmuw3BL30uj26M=;
        b=LBSKjSV8gcYmdzIjBzlI972q63S85FC2/p5fx3IjP1SwlvNhYj4j3Kws05MHoyDfjf
         u0LOgEDch0DLqABAY6xaHvTKptvdotxiIlA3arPN+qbX4NCDwj8kqocnwjAd4AauMiaX
         Rmz0Bd2ltGhMYV5lryYH2RAFJGdOza6GJVPCOa4IaHrVjRp5OCZGpro/hCGMk6DL0Mh6
         eahXUqgiGyde6W4oVoidxn54GJ7VW7SnX47zLPtqNTGFU6FUV5xozeRzITxiCur8QGmK
         wwUU7Ron1EM9kytZ3pVFtTSvUWaDoDxWrBApKpFTXDdlAhWrkemVVf1mgcLT64wCqBPL
         vx6A==
X-Forwarded-Encrypted: i=1; AJvYcCVLZPd0zSlRI/LSvk2XXjDDWlSnadZ6I8d0ZZU7jgN1We/l/LsuB6YUiDcVLVSEMSJV8ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZsTvtipISm1AFFpkN0VHBFCZCEaAgN7JFi5iQSCj78c65eCkR
	rAthr2q6lJhdUJzq9mZ6ha5UF1yRrEqWSIu/9rXubm+1m+xbYVGZssKqDscy7HE7aVUUIW09+KK
	dNRngjDOPJmh5rWU1XvFZwn5GMh1wvNtN
X-Google-Smtp-Source: AGHT+IEDVNU2jFDzBQdPujD0iJqQOb2IRN4pOwgtNO0B0Zrf5oY05SvNLAQ1hNdyk4nDKEBDQNyYeCFHmYqyHkccVTc=
X-Received: by 2002:a05:6214:4284:b0:6c5:50bb:d59d with SMTP id
 6a1803df08f44-6cb3b645145mr31071916d6.37.1727419802331; Thu, 26 Sep 2024
 23:50:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGW8g7=21pPAgCixjpayEvmw_ns-hcB4e59NP476TKtCRXHPXQ@mail.gmail.com>
 <ZvM39VNFptcfwMGk@tapette.crustytoothpaste.net> <m0r097mv19.fsf@epic96565.epic.com>
 <ZvXMSKaUWWA-MG9J@tapette.crustytoothpaste.net>
In-Reply-To: <ZvXMSKaUWWA-MG9J@tapette.crustytoothpaste.net>
From: Ron Ziroby Romero <ziroby@gmail.com>
Date: Fri, 27 Sep 2024 07:49:51 +0100
Message-ID: <CAGW8g7mmbGRWfieVK5HL=LNF7tSAU7WOUqe83HqQk-wStqQ+Bw@mail.gmail.com>
Subject: Re: Pretty output in JSON format
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Sean Allred <allred.sean@gmail.com>, 
	Ron Ziroby Romero <ziroby@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 22:04, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2024-09-25 at 18:45:54, Sean Allred wrote:
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >
> > > On 2024-09-24 at 21:52:35, Ron Ziroby Romero wrote:
> > >> What do y'all think?
> > >
> > > I think this is ultimately a bad idea.  JSON requires that the output be
> > > UTF-8, but Git processes a large amount of data, including file names,
> > > ref names, commit messages, author and committer identities, diff
> > > output, and other file contents, that are not restricted to UTF-8.
> >
> > This strikes me with a little bit of 'perfect as the enemy of good'
> > here. I'm sure there are ways to signal an encoding failure. I would,
> > however, caution against trying to provide diff output in JSON. That
> > just seems... odd. Maybe base64 it first? (I don't know -- I just
> > struggle to see the use-case here.)
>
> I understand JSON output would be useful, but it's also not useful to
> randomly fail to do git for-each-ref (for example) because someone has a
> non-UTF-8 ref, or to fail to do a git log because of encoding problems
> (which absolutely is a problem in the Linux kernel tree).  "It works
> most of the time, but seemingly randomly fails" is not a good user
> experience, and I'm opposed to adding serialization formats that do
> that.  (For that reason, just-send-bytes that produces invalid JSON on
> occasion is also unacceptable.)
>
> If we always base64-encoded or percent-encoded the things that aren't
> guaranteed to be UTF-8, then we could well create JSON.  However, that
> makes working with the data structure in most scripting languages a pain
> since there's no automatic decoding of this data.  In strongly typed
> languages like Rust, it's possible to do this decoding with no problem,
> but I expect that's not most users who'd want this feature.

I do plan on percent-encoding all non-UTF-8 data.  It sounds like a
good way to check this feature would be to call "git log
--pretty:json" on the Linux kernel and ensure we get a valid, though
massive, UTF-8 JSON file. (Not as an automated test, but as a way to
check that we've covered everything. Any stumbling blocks should be
put into an automated test.) The use case I'm thinking of is piping
data to jq to process it.

CBOR output seems useful, but I see it as a follow-up project. JSON
output would be more beneficial to more people, so I feel we should
tackle it first.

> >> What do y'all think?
> As with all things, I'd suggest you draw up a more formal proposal of
> exactly how this would work, and then that proposal can be discussed.
> How would you use this option? What would its behavior be? What's in
> scope? What's _not_ in scope? :-)

OK, I'll start working on a more formal proposal.

--
Ron Ziroby Romero
