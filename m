Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721C5347B4
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756475314; cv=none; b=MLZFJe1ygyY0VDsnPrsYhemZSmJUR2j8upPidpD2EZhy3yv+x1yxx5PNDa8ezrdtMhz3xGVwIrjIL7YUww7TS6uiLKeA5BZ41w8cuKjHKpuEhNvVVfyuzY3lbNkeg5R+Pi6nXjPJIBV9Mk7Rv798WUIwdJF75RPtx68mPL5mvz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756475314; c=relaxed/simple;
	bh=3/aoo3cYYmhchLI/7aQWD88FtsA3Q+v/yMgmQI8wic8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8et1IF0w/24KKfZKGAUYqcnZUyt5KuDfhqatI0A0o/DykRNGpNCmbONFhPdC6W4U91ZQUC0aggF0uVyjutFFoiIHk7FCYR66DFGitcGrLkcRWtXJfIHXMt1pXdaVGGm8EEr05IZPctl/UL0INSDpHeWcYyAiKuqGYEoKAZJFd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wc852Xii; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wc852Xii"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6188b5ae1e8so2234279a12.0
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756475311; x=1757080111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/aoo3cYYmhchLI/7aQWD88FtsA3Q+v/yMgmQI8wic8=;
        b=Wc852XiiEcvFnM4fa1MVpn+AO9SFxhOGMaSpVAmpYXOyWF1JNz8DnVWGczbSMzmhkQ
         fMJXjuspDbIOoJfu6tTDPOAZWwn+sbTxaxtSC75zeMN2DzGiNohHaY3pjrNnDIWXFItS
         uU7frcOxAppeVeZMWkmxbF/VhjaaWZe71Rg82Nc3znJHxg3Ygxn5BUv5182FkGkvb34v
         sVlh9iT6ZRWJk8YoQd3u/olg9YOsDYxVLgDlsr519or1ALhV/gV57aLWGPtsl476/Vo7
         eojDL1vZPF6kzGMhpSXQYL5yv0d3qeD+67/Z7sf21OIAjBxcCz6b5W+KQOjHXSNvctIC
         H4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756475311; x=1757080111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/aoo3cYYmhchLI/7aQWD88FtsA3Q+v/yMgmQI8wic8=;
        b=XVQ/rd0F59t7B4k+6xpZHOO4xnB+srxHOGjEN6NASUttCIyB6S5J/Dne7Lu2D2X+6v
         Wtrc5wdmEjKpSI2u1RsAKzVdUSE0VyAQhYqiorQhGCC2uKzIyx4DSJDU9SKaMDmXOTrD
         lLhhMjcG6uoYljei1TqL6qEniSh1fwJwP7YpNwkU2iHX3hZvJ4eZkbIIwkOJBuay54YF
         E/n6qLbqtC1akTeFUHApGmrVClt/1Q/Itx1IqWafeaRIgmV9FbbtMgkKJg/gtm3sBOA6
         59HwYrKmwQH6+ERajsCdVlcYkez6yAhdEqwDQMDSMnk9thdyoOeTCPEMqp+f775dP7VB
         XKFA==
X-Forwarded-Encrypted: i=1; AJvYcCU2tExv9rELzOJjgY1Rs5YY31hcvqhotoaETRnxMhoagkkPEj3QNAa6/yx5KgbU+aXmsmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWx7aH75YvIr8YnyJvTM2HHVKmghsUPif1Cf/Jj7sXTDVyfY4m
	mBQGm8dsh23uD7NYIQqSIFSNK7D0FQECZAarFOTz3Gb2HZvdELIHD4h4IrJo3UyahtbGfCKBEim
	elwfFI6i9FJVhQAOaIT8NIUU7RraHG9k=
X-Gm-Gg: ASbGnctdQePIV2Q4OrhLtlDN4zsKtFEHFHKnMwcwYtG9LCqUf/ygSK5ORBVrXbzG8Sx
	1+8zS5CKuUJVFBSWkDr6EvMogmg4iaOtVCWIKKS1xD9tVDx5UwqN83xEoSkpsOlRezl0j3B4n2O
	j3Yh4gjvtTRC1Q+c7JsYkhplxzZWEqhMC4xDococ6WXAXydZSCBtNqeRibH+2vSX+4bLLWSPUe6
	6Q2/yPD1x2qEkGHY7YVGuhsPEwLaZyKPqrWHBWjhcAH9sPoAR0n
X-Google-Smtp-Source: AGHT+IGDbQjiX74M7u8WOHjGOdrh/n4HpiSOwDRfb+SmiDgCOHmq6GORLVpRQFkFPc9nU6LA5YybAlQbe01EKCJAAh8=
X-Received: by 2002:a05:6402:3591:b0:61c:cf9a:d479 with SMTP id
 4fb4d7f45d1cf-61ccf9ad68amr5946009a12.10.1756475310496; Fri, 29 Aug 2025
 06:48:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
 <b641874627b3898831c3965616e936bd4ee310df.1756148933.git.gitgitgadget@gmail.com>
 <CALnO6CDpsgTnC95CzjOL5MuhFNAnYYSQCR-jC_n5JYLEu0BTow@mail.gmail.com> <2efb789d-db2d-4dae-ae81-373bd231c3c6@app.fastmail.com>
In-Reply-To: <2efb789d-db2d-4dae-ae81-373bd231c3c6@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 29 Aug 2025 09:48:19 -0400
X-Gm-Features: Ac12FXwXx2n6gGoDKGbHADqaAhG2gRE55hdIYhj5PtppVXSrubbhyAtmr6xlP_I
Message-ID: <CALnO6CDJ72-vDYuf_9LzQ-U+Rc_em77WNO2nqNgQ-Cy=T=g3Kg@mail.gmail.com>
Subject: Re: [PATCH 5/5] doc: git-checkout: clarify restoring files section
To: Julia Evans <julia@jvns.ca>
Cc: Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 4:00=E2=80=AFPM Julia Evans <julia@jvns.ca> wrote:
>
> > Wishful thinking (see glossary comments): I wish we could teach them
> > about "tree-ish"s here rather than stop using useful shorthands
> > altogether. Of course, then we have to wonder where we can use the
> > shorthand and where we must do the "spell it out (give an
> > abbreviation)" dance. Hm.
>
> What I find hard about documenting cases like this is identifying
> the use case for providing so much flexibility
> ("you can pass any tree, not just a commit!), since personally
> I've never passed anything to `git checkout` other than a commit.

This makes sense, and: I think some of how I learned more Git was to
read the manuals, look up things I wasn't familiar with, and then play
with them :) So in a sense my wishful thinking is about sign-posting
"here's this other nook to explore if you're curious" (knowing that
~70% or or more simply won't be).

> I've been trying to think of examples of cases where it's useful
> to pass a tree instead of a commit. I can see that it's possible to run
> something like this
>
> $ git checkout HEAD:Documentation/ git-commit.adoc
>
> to restore `file.txt` into a different directory than it was originally.
> This seems cool in theory but it's hard for me to see why it's useful,
> which makes it hard for me to document. What I would tell a friend is
> "<tree-ish> 99% of the time just means "commit or something
> which resolves to a commit, but Git has made it more general for
> a reason I don't understand", but of course that's not the right
> thing to say in the Git documentation :)

I would say that it's more general in part because it can be: the data
model allows it without any extra effort (not a jab at the
programming, which was probably not easy!). But I'm in a tangent now
and the latest version is probably fine by me. I just don't want to
lose the signposts for explorers.

--=20
D. Ben Knoble
