Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2448139D0B
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921853; cv=none; b=sxHYkgpJeI0JhQZSHP0iglBkUOYX44tMyZDtdt3/iDyeT0JLoEtZCAM9evRjywcXIbv2Bhm5htIEXei3hfRZ5h/Xo8qEN7KBB/A0cpsVMJajDG2bIWmuDDOFjhih1ceix98Imvah6PCCtst4TpVM2q1xx+7C8GURqvmXyK7FzEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921853; c=relaxed/simple;
	bh=OAmjzYCb8JA1+KI1rgrugIKGq6LWKu8oJm7/GbPgOb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lbqgq5QR3bcI56ZxXmc3Z+5IR3BUMngL3WwaNfFN5Ybi34lycuqcj/Oj3FdIPKpKn9qyBNPVcmgQNvWPXGUhgoimnd6QRGJCqYtkrYeWLuCLr36RWkEGGKyuNEgGHwlrJBGtg4heqPhfcvDq1i9ze/iC/skZ1mf/XBjHFid6lq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUsyDMDL; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUsyDMDL"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-716a7fabf31so1384069a34.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 09:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728921851; x=1729526651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7wrgdgznow+WEszYXUYMNpkRkv3FpyuoNCBMO9E1LQ=;
        b=TUsyDMDLPosYRcRlsz4L0sgtomwr2DIPHJetjYlM3skJD90T4f1as4bHO5Q/X0dPiG
         2kRwXCu8PEg/94lUuHYH+aq/dmCFX46PdWBM5OnhAv0punDC3LkAnf8G7YqWbhHQcwoO
         G0EnabWqUTzHKRt1aRR1hY4Z28Z37iQ7qam1ADtmoyuB6nFfeqtrntnhnXvgse9DD2M8
         UhDOeqSOyek2AlFTwcUFFjO4O5v6BtjvHeaOXejphNMyhUqy5C6lej6MUKfGEt2UN6kT
         SA1UxpQ30QeB0fh/hJTUOSk55XJiZcekbkdjIMLaXNiKLEHC2TFcJijbDJoqGxXTuX1R
         gvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728921851; x=1729526651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7wrgdgznow+WEszYXUYMNpkRkv3FpyuoNCBMO9E1LQ=;
        b=Q2CYpW7PK/yE0kgMEJjB8r2TPDZNivJ3aJQis7679VJuDxaekHMJpqJp/b54cyhoq9
         WLyXjULEZaueKoC4epTvHrY82NgEfm1jlHXLuGenqMP+EXVrlqYW8Q37wP+r40RdcDvc
         DYjH2N1F15ejRXFK7UVeTIWMYX/88eSriD3j3BVZe9rX++elG4HsBMP8oJGUVOuLEi21
         /mX6cCd/WA4NPDrwGDzq4wKLK8i2XOIRs8N8uvWx1tT0yRbhtbd9B5I7r+9P0VI84Ysh
         YhEx86Ig+LgwzEcK/gIhVEMgk5CsD70M/bnXhDzrhUkgivhW1vvPL7a6PFdqdNWuDgRR
         f8HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpS4w2JgRGtUta/36qRuLTNUAYyF+BG/ApEodAIOSSjSSg7Da9cpf223PP3k8cHByjmf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJWKfFufOAKKOiVsSQMVMOqdiormtAW+C6PWa/j8npeEFBi7rd
	eXRbxph//Z3U1EUkMyyD0uQX5LNzSdy8wKU3Mh/apv2dU/dmdnM8ZeRT1wDzWGgoo7412kZIU4j
	YH5d+wO5RMZxBVQb6PD24Ik27rK0=
X-Google-Smtp-Source: AGHT+IEkNeVC3nsCAs24MCXUCTClbKnd6t40MhJL+Y7MCPdB3VtoRABFlod4AteCnBCQZpF0DgQbSvi6ef625UBdkqA=
X-Received: by 2002:a05:6358:988d:b0:1bc:583b:a173 with SMTP id
 e5c5f4694b2df-1c340cc6bdamr111143655d.10.1728921850469; Mon, 14 Oct 2024
 09:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com> <Zwz4B4osJnYJw6pd@pks.im>
In-Reply-To: <Zwz4B4osJnYJw6pd@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 14 Oct 2024 16:03:59 +0000
Message-ID: <CAPSxiM9t63E3OJm6SrLEOf_0bcLX_Eo9uS+u6TqeovVUrb-2rA@mail.gmail.com>
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and strtol_i()
To: Patrick Steinhardt <ps@pks.im>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:53=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Sun, Oct 13, 2024 at 09:42:41AM +0000, Usman Akinyemi wrote:
> > On Sat, Oct 12, 2024 at 11:09=E2=80=AFPM Usman Akinyemi via GitGitGadge=
t
> > <gitgitgadget@gmail.com> wrote:
> > >
> > > From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > >
> > > Replace unsafe uses of atoi() with strtoul_ui() for unsigned integers
> > > and strtol_i() for signed integers across multiple files. This change
> > > improves error handling and prevents potential integer overflow issue=
s.
> > >
> > > The following files were updated:
> > > - daemon.c: Update parsing of --timeout, --init-timeout, and
> > >   --max-connections
> > > - imap-send.c: Improve parsing of UIDVALIDITY, UIDNEXT, APPENDUID, an=
d
> > >   tags
> > > - merge-ll.c: Enhance parsing of marker size in ll_merge and
> > >   ll_merge_marker_size
>
> To me it's always an indicator that something should be split up across
> multiple commits once you have a bulleted list of changes in your commit
> message.
>
> > > This change allows for better error detection when parsing integer
> > > values from command-line arguments and IMAP responses, making the cod=
e
> > > more robust and secure.
> > >
> > > This is a #leftoverbit discussed here:
> > >  https://public-inbox.org/git/CAC4O8c-nuOTS=3Da0sVp1603KaM2bZjs+yNZzd=
Aaa5CGTNGFE7hQ@mail.gmail.com/
> > >
> > > Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > >
> > > Cc: gitster@pobox.com
> > > Cc: Patrick Steinhardt <ps@pks.im>
> > > Cc: phillip.wood123@gmail.com
> > > Cc: Christian Couder <christian.couder@gmail.com>
> > > Cc: Eric Sunshine <sunshine@sunshineco.com>
> > > Cc: Taylor Blau <me@ttaylorr.com>
>
> The Cc annotations shouldn't be part of the commit message. If you want
> to Cc specific folks you should rather do it e.g. on the command line or
> whatever you use to send out the patches. Otherwise, these will all end
> up in our history.
Thanks for this, I thought the gitgitgadget automatically use the Cc
from the commit message.
>
> > > ---
> > >  daemon.c    | 14 +++++++++-----
> > >  imap-send.c | 13 ++++++++-----
> > >  merge-ll.c  |  6 ++----
> > >  3 files changed, 19 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/daemon.c b/daemon.c
> > > index cb946e3c95f..3fdb6e83c40 100644
> > > --- a/daemon.c
> > > +++ b/daemon.c
> > > @@ -1308,17 +1308,21 @@ int cmd_main(int argc, const char **argv)
> > >                         continue;
> > >                 }
> > >                 if (skip_prefix(arg, "--timeout=3D", &v)) {
> > > -                       timeout =3D atoi(v);
> > > +                       if (strtoul_ui(v, 10, &timeout) < 0) {
> > > +                               die("'%s': not a valid integer for --=
timeout", v);
> > > +                       }
> > >                         continue;
> > >                 }
>
> We don't use braces around single-line statements. It would also help to
> explain whether this is fixing a bug and, if it does, then it would be
> nice to have a testcase that demonstrates the behaviour. The same is
> true for the other sites that you convert.
>
I was going to add testcase, I sent this patch to ensure I am going in
the right direction.
> [snip]
> > I also want to ask if this is the right way to send another patch as I
> > noticed that it is showing my previous patch which is not related to
> > this. Thank you.
>
> You shouldn't ever include patches from another patch series. I guess
> tha problem here is that you created all of your work on the same
> branch. I'd recommend to use separate feature branches for every series
> you are working on. In general, these branches should start from the
> current "main" branch.
>
> Patrick
Thanks Patrick. I actually created a new branch for this branch, my
mistake was not basing it on the master branch. I was a little bit
confused. But, now I understand better. Thanks.
