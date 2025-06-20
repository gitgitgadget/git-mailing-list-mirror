Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3D728C5BA
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750428529; cv=none; b=K4LXMdVqz1QUw0sWR5VMJhgipzBw4In0x2LWlw9ctOhyGu6rkOM/QqH8cbAFKdnCdTt6Wbm+KBmfKB5lCNeMhoY7DYnid+jKbw6E0AekCS6jUMXV9YD5XIMoM7dftqG9ijv457sFKggnkRIIvwuoJiX596ZbLMDPdZVoMHUvncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750428529; c=relaxed/simple;
	bh=cNkBTXycnQgkGMYtPpIvnSOhdHdDhlem3KLDQMn3psE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxaXPDiG+7SUyQJXqKnZ2GPp8KKS3l+lhJtCoTIHTJkSkddE1k2rwkxi24S5Hu+0FGofrAaDVZbzH9d8X9l3cCt/1uQHbe3CZkcM8yC+V+fzb2EjEF4OGBfyO8MFRNTaTQWqb7mcU1D4pO0aVP/ggrDMwDoDQHYRH5I/RS8FExU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfbLJ8+b; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfbLJ8+b"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-606fdbd20afso3516785a12.1
        for <git@vger.kernel.org>; Fri, 20 Jun 2025 07:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750428525; x=1751033325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRZm/90MEDAKk9WHeYsAGnz8mV8iuhV4ByBJRZLyPtI=;
        b=YfbLJ8+br47W5lICbisA1cm41hisKZANtInvAzjcYPYwpXPCyaFOoi1BxhcesyqAMA
         Anhf+lR6igzhHz11Npyjhs00HnRQNXo32yfJJyIheB1ewvtFFl36xT/j/oTzKXFEY3EV
         +6EEAqmNMTv9626J6pMcEf0rpHHGL8YqIy+0P3YDJJPKQ62hPaSvhkHJ0k8ys2GqNkyV
         HZoQx2W/jIYC+V7p8HbTdXZrzqwWKYN9xI0OF7zDk5tTXc/etQubwrj8IB+kAGI7v1RD
         l2hqLGj35MJBCEPxYYO2mlRplQZURwI0DbCA21b5MoYffPIJLnFSvzfBKN0OLyVkAxZk
         JsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750428525; x=1751033325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRZm/90MEDAKk9WHeYsAGnz8mV8iuhV4ByBJRZLyPtI=;
        b=X017R4cPukjsHO8pMAR6p7Hl805XjH4MPDBzGCjsH2GwKM+HHYVNFtxwiZd6MWpkrR
         WS80lwzCe4s/vyBmc5L94gknCY6U0uiTlnwqUx6hVVVGZZUcpZLiJIzH5BtDG/39hQ2D
         bliDhAFmGWWcfR0+lOy2C9tGnc/MAB9t77RdavPq21nFY3DQBZ+aBRWz21nXsi5DcBY7
         8L1ydEcxhmyS6XOKuyBlogbX294yjMZRhuNFLB+cDVyItXteSQEkD23wBkZM5HpgiugS
         Tz43jO0hXP9mD9grvUSiJkUoBaLge1XQEgnKFhYVbZoNXXMT7DAhLSWbIJeoIkY4gWfZ
         pf9Q==
X-Gm-Message-State: AOJu0YxevbMa0GUcX0Em6UaoBkQSJgDSMhRaNomyZhB1l5O8hoeiIVOu
	ATj7PtfKHUtiOOvJQb0hHN8yNDniwno2WJBXrazUCJHCSyfGxUAMyBcr/peeqNLkHvSTKiCuCF2
	iYuieiUktNOCoH+kWPKOh8/AwK4EfInY=
X-Gm-Gg: ASbGncvbNEMz6FFmDXx4rszMteWKcWR9xadvbeQFwKG5KRr3lrGXs8UCUOrWJFrEW8p
	3TBSRqi57uzJlBo8GcgPTam0+Y7ZEP58JQ07rpC88mf6zIH3ji1TaIaTopu6J1jq/SxlvHyv8F/
	u6eRZh6CYpZxNMhiWAYT6C+L9ei18Sicirv3gJRQuzD2ZpXA==
X-Google-Smtp-Source: AGHT+IFFJvNlq8kxVDgobHymlFdTPjnNfc/YhjoZOdaFewBArPha3tb6exelYkas+bnTtVHbwUKzHlBnFXrxh/0+fe4=
X-Received: by 2002:a17:907:f1d1:b0:ad2:2dc9:e3d3 with SMTP id
 a640c23a62f3a-ae057c2643emr290924566b.57.1750428524682; Fri, 20 Jun 2025
 07:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqmsa3adpw.fsf@gitster.g> <CAP8UFD0YEgh4Oy8MDpT0DfZJgo++NHf3mF6VsYxAG1CjhrKGLQ@mail.gmail.com>
 <xmqqfrfv8dr3.fsf@gitster.g>
In-Reply-To: <xmqqfrfv8dr3.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 20 Jun 2025 16:08:32 +0200
X-Gm-Features: Ac12FXwvTxOqb5_GTufDkWzUWwxltx1yeVa5cP_JVI36YVu2UsAuTks2GlHcDTE
Message-ID: <CAP8UFD27tQ3uhQW5zkPfFZSF=3FGEmi-rBYu3A_zZ8oNbUiNag@mail.gmail.com>
Subject: Re: .clang-format: how useful, how often used, and how well maintained?
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 2:20=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > Maybe a format-patch option (perhaps called '--format-check') could be
> > added to run such a command before format-patch actually outputs the
> > patches?
>
> A post-commit hook that does *not* prevent your changes that do not
> pass the "style-check" from getting committed, but does give you a
> feedback that let you consider before moving forward?

It's up to each one to decide if they prefer post-commit or pre-commit
hooks or other ways to trigger the style check. So yeah, we could both
suggest using hooks and add a format-patch option to make it easier
for those who don't want a hook.

>  It could be
> pre-commit hook that stops you, but then the people may bend their
> code to please the "style-check" and commit a sub-par code, which is
> not what we want.

I agree that we shouldn't recommend doing that.

> Or just write that command invocation into "MyFirstContribution" etc.?

Yeah, we could do that too.

> >> I do not mind the original but the updated one is not worse.  IOW, I
> >> would reject if a human sent this patch to fix the original that is
> >> already in-tree with "once the code is written in an acceptable way,
> >> it is not worth the patch noise to replace it with the updated one
> >> that is not significantly better".
> >>
> >> I'll call this kind "once the code is written" in the rest of the
> >> message.
> >
> > Yeah, I think those should be considered false positives. They are not
> > worth failing the "check-style" CI job or even having a human look at
> > them.
>
> We disagree here.  I notice that at least GitHub CI suite does not
> use clang-format task for "new 'seen' was pushed, so let's check"
> set of jobs.  The style checks are done for pull requests, and I
> think that is a more appropriate place.
>
> And I do not consider it false positive IF they are pointed out on
> the changes that are *not* in tree yet.  On the other hand, if the
> preimage and the postimage of the style checker's suggestions were
> iterations of the same series, neither of which has hit 'next', then
> I would consider a change like the above not "false positive".  It
> is still an improvement; it is not improvement enough to warrant a
> churn by piling new commits on top, once the preimage hits the
> public tree.

In your earlier message, you said "the updated one is not worse", now
you say it's still an improvement. My opinion is that it's not clear
that it's an improvement, especially because the updated one doesn't
group "(unsigned)strlen(signature)" and "signature" together on the
same line. So I would say it's more bikeshedding territory than a
clear improvement.

> What I called "once the code is written" is something I would refuse
> to accept as a "style fix" patch, but they are still improvements
> and it would be great if contributors followed these style checker's
> suggestion _before_ sending the patch to the list.

If we encourage a style checker to make suggestions that are often in
bikeshedding territory, then I think we take the risks of:

  - annoying some users who disagree with some suggestions,
  - having bikeshedding discussions on the list (like this one) about
things that are just not worth it,
  - the style checker being actually wrong (because of the context for exam=
ple).

In my opinion the possible small gains are not worth taking those
risks. In other words from a style checker I'd rather have fewer
suggestions that are more likely to be right, than more suggestions
that are more likely to be dubious.

> >> >  static void warn_on_extra_sig(const char **pos, struct commit *comm=
it, int is_sha1)
> >> >  {
> >> >       const char *header =3D is_sha1 ? "gpgsig" : "gpgsig-sha256";
> >> > -     const char *extra_sig =3D find_commit_multiline_header(*pos + =
1, header, pos);
> >> > +     const char *extra_sig =3D
> >> > +             find_commit_multiline_header(*pos + 1, header, pos);
> >>
> >> OK.
> >
> > I don't think those are OK. If the existing code already has longer
> > lines, like perhaps here the `static void warn_on_extra_sig(...)` line
> > above, then it's not worth suggesting wrapping lines like this. It
> > could result in a code with both long lines and wrapped short ones
> > which could be puzzling and harder to read than if the code had only
> > long lines.
>
> Existing mistakes are not excuses for piling new ones on top.
>
> I do not think the code with suggested change here is making the
> code so uneven to make it hard to read.  Quite the contrary, the
> body being easier to read is a good thing.  There is one
> contributing factor that clang-format may not be able to understand
> (or perhaps there is a way to do so that we are not taking advantage
> of).  There also is a reason to special case a line that has return
> type + function name + parameter list and allow it to go over the
> usual limit, which is grep-ability.

I agree that in the example above the suggested change might be good.
But if there is for example the following code:

my_foo_variable =3D my_function_with_a_very_long_name(foo1, foo2, foo3);
my_bar_variable =3D my_function_with_a_very_long_name(bar1, bar2, bar3);

and a patch wants to replace "bar" with "baz", I don't think you would
like the patch to look like:

 my_foo_variable =3D my_function_with_a_very_long_name(foo1, foo2, foo3);
-my_bar_variable =3D my_function_with_a_very_long_name(bar1, bar2, bar3);
+my_baz_variable =3D my_function_with_a_very_long_name(baz1,

                        baz2,

                        baz3);

So my opinion is that a style checker that doesn't take into account
the length of the lines around where it makes suggestions is likely to
make a number of wrong line wrapping suggestions.

> > Ideally our tools should be able to:
> >
> >   - provide full patch (including the commit message) which correctly
> > wraps all the long lines in a file, so that such a patch can easily be
> > created and added as a preparatory patch to a patch series,
>
> Ah, I wasn't talking about the proposed log message part.
> Especially in genAIs era, I would not want to go there, just not yet
> ;-)

I didn't mean that users should send the patch ouput as-is ;-) The
idea is about encouraging users to send preparatory patches to improve
formatting on whole files, and this way get source code files that are
more coherent. Then it would be less likely that suggestions from the
tool about a subsequent patch are dubious or wrong.
