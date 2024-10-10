Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802941E7C35
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728545194; cv=none; b=AGHHyWjzXLMjZem3bqIDyW/8F5IjJVENQvbFge+BYK9xPWqcq8pQftCx6oJi1lBh6BXlzBFXi0Mw6RgT+HnYkyD3kvpW6kIOW/Sbtji+wXs77J6ofX6Db8j7AEhEPWVmKqy8pWoA5nTnC3mP56fSgIBxRu2BmdHFXyRha9iIR2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728545194; c=relaxed/simple;
	bh=aqFRUqVXYXX8D6GXL0mDp82aNUjU4/ZJeFTDIyyu+6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnSlYs8ytcg65Be/Yi58ePKRVOwsAaRP5oWkVCdF6dNKs93VZ5hONVnBsrQVuSZI6tZ/7Rl/pru4WoT2XZvoS3kiHPiPCT2fOed36kYZq1hh8I3NbV5/k6NXRIkyRuK4L+tULj0+9uCU+H3VTuBuvcY5mIyQPn169JrmDXJBk2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fikDKVqg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fikDKVqg"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c91a7141b8so685973a12.1
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 00:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728545191; x=1729149991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=stguNPXecmhl6HnFDPqntt/5QSyUQEjVJ+6z5u11Jzc=;
        b=fikDKVqgBe0kJwxKbSZri0/PRyqfi0HrcyptQHEnjwFXvShi9KQdMbfhaJkQvLVGww
         e9Lcy4JfPSEamXD9d/Gflyfr582LgMmoZKo0B2rsljH8TrEKI0LTKnPztuige9437bFU
         iZbrLUvtOlTJ7pD1y7eIlLb7uoU/X2mjpRfKEVRxhtE14QWIWRDBFrpgyz4dBxxvbutq
         rAG69yluqV9HdX6ce8RRMX9tCNwVUTHb3e6fs8+rNixwAasFDsK+o+stHXinDZJ8HVqb
         k29rakOOqCfnZ1QXlKs2mo/HqGhx8VX7WH48IpiwZagu06i4aiEhNzfp6Ist6wK+vTT5
         U50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728545191; x=1729149991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stguNPXecmhl6HnFDPqntt/5QSyUQEjVJ+6z5u11Jzc=;
        b=qVvqVKEg4WEVsxyQP6B/ZhRSs6sANjBXyw55TD5WW11yIqk614qRYwy/lTajaQ2AsC
         6CyZ8CKVklAl32gDxbNdgCBqlqFAgbg73oo17mDpDPGa3aWLl0biQFsBjXjdYWXxkwTZ
         7J4lDpZS3cD64baqqWWK9l6z6ZSct7nayDRrwZrPXvfpTA0SR1CP7Oijb2t0fTGZ1CU8
         gDfFQNRq+oM0IrUtrqbe/Wx4bvgE3LQk1bl/pQNEiIPXBa4kvBlJgk2HJVkUmbDsY3Db
         xvV6tnBiKKvhnJqg6x1GRwViewFzcyMXI5ZnPSjBg9pQlqMAhm5meAJC2GhIWyLPl3MH
         4uuQ==
X-Gm-Message-State: AOJu0YzxX3a0gsGLoPlCKgDX0v8fY+pmUPCij4OqVWkKlXKrY5GxjOTe
	0mcLqz+L/BFisUZeJGg4kRh5+uYJAc+cO89Z0ZQU2PG2nq+6kaJoXT10FnqzM8n4xnQyUKFVQn1
	JFSAvp7peTgtIYSmUymi1x7sQbeLRxDQuYEWflw==
X-Google-Smtp-Source: AGHT+IHLupPMsC6Y7zrNiu/yHlf9fUK8Z9N8u+Wmx06Zbp1bFJBiRu/ZLrKvXfRjFTc7jo6CFRm538v6cEIWEGEtiwY=
X-Received: by 2002:a05:6402:278f:b0:5c3:1089:ff23 with SMTP id
 4fb4d7f45d1cf-5c91d6a03femr3760386a12.35.1728545190123; Thu, 10 Oct 2024
 00:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008162117.6452-1-chizobajames21@gmail.com> <ZwYwm2-ixmyYVqo8@pks.im>
In-Reply-To: <ZwYwm2-ixmyYVqo8@pks.im>
From: Chizoba ODINAKA <chizobajames21@gmail.com>
Date: Thu, 10 Oct 2024 08:26:19 +0100
Message-ID: <CACwP9ar1MtZYK06RsRre5d7Zo-OtNdUvqFwpxjcHVvYuzWS4Dg@mail.gmail.com>
Subject: Re: [Outreachy][PATCH] t6050: avoid pipes in git related commands
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Oct 2024 at 08:28, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Tue, Oct 08, 2024 at 05:21:17PM +0100, chizobajames21@gmail.com wrote:
> > From: Chizoba ODINAKA <chizobajames21@gmail.com>
> >
> > In pipes, the exit code of a chain of commands is determined by
> > the downstream command. For more accurate info on exit code tests,
> > write output of upstreams into a file.
>
> Nit: it isn't really about accuracy, but rather about losing the return
> code entirely. I'd also mention as part of your observation that t6050
> still contains this pattern, which isn't currently obvious from just
> reading the commit message standalone.
>
Thanks Patrick for the review, and for pointing this out, I totally
agree with you.
> I'd also propose the following subject: "t6050: avoid pipes with
> downstream Git commands", which reflects the fact that Git commands can
> be at the end of the pipe without much of an issue.
>
And I will effect this proposal the next change.

> > Signed-off-by: Chizoba ODINAKA <chizobajames21@gmail.com>
> > ---
> >  t/t6050-replace.sh | 86 +++++++++++++++++++++++-----------------------
> >  1 file changed, 43 insertions(+), 43 deletions(-)
> >
> > diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> > index d7702fc756..6b9811ed67 100755
> > --- a/t/t6050-replace.sh
> > +++ b/t/t6050-replace.sh
> > @@ -98,30 +98,30 @@ test_expect_success 'set up buggy branch' '
> >  '
> >
> >  test_expect_success 'replace the author' '
> > -     git cat-file commit $HASH2 | grep "author A U Thor" &&
> > -     R=$(git cat-file commit $HASH2 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
> > -     git cat-file commit $R | grep "author O Thor" &&
> > +     git cat-file commit $HASH2 >actual && grep "author A U Thor" actual &&
> > +     R=$(git cat-file commit $HASH2 >actual && sed -e "s/A U/O/" actual | git hash-object -t commit --stdin -w) &&
> > +     git cat-file commit $R >actual && grep "author O Thor" actual &&
> >
> >       git update-ref refs/replace/$HASH2 $R &&
> > -     git show HEAD~5 | grep "O Thor" &&
> > -     git show $HASH2 | grep "O Thor"
> > +     git show HEAD~5 >actual && grep "O Thor" actual &&
> > +     git show $HASH2 >actual && grep "O Thor" actual
> >  '
>
> We don't typically chain multiple commands on the same line, as it
> becomes hard to read very fast. So these should all be split across
> multiple lines. The same is true for other tests you have converted.
>
> Furthermore, I'd recommend to replace "grep" with "test_grep", which is
> a convenience wrapper that provides more context in case the grep might
> have failed. It would for example output the contents of "actual", which
> helps quite a lot in the context of failing CI jobs.
>
I made these recommended changes.
> Thanks!
>
> Patrick

Thank you.
Chizoba
