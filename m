Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CAC29B0
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 04:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728965111; cv=none; b=tTELGbeRzmt/JnJ8FlnJl0VhYWcderve2AUHvAQQDGKLXAqEM0XzIGGlSaMkQWSicC2p540nRCK34koCHGE2guUSdWtpOUqRaOEO3imsi0NxoTrM7WeJP7sjMy/M4z+go+ucmPUugmozYwVtf2ULMgHbI9pJ8IiPhO/JzKsN73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728965111; c=relaxed/simple;
	bh=n21J14IZ10NHIQjnwwlvIr4yP2rsfAYgnpqCoRTfVG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3FNjUVoDPZq7+pKkVKthqUf8bQhvtNTwjb39qbOWrls4O3WEq7C6OwxeA2Gp+Hkw5JHTHiFgY+RqEpeevCltJ/912AEJ0CQOJvTs8p531Ve8DQ/XtZsAP9L4olaS2hy0zaeVQF9s1SSmnpikpaNF6yEM8DEL/Rnur6bG/mhItU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHxmrApz; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHxmrApz"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4a47dc2ef46so689283137.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 21:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728965109; x=1729569909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9/TEbO9MJbhew2zKwdgbRij1p0FY7VuPgt3/uIhiKI=;
        b=bHxmrApzst7DloC4iG6/hEBG5+f3XhHhl5MokKN0jTIqwZxneyBDvvwuJp9OLD6Yjj
         qIHyZ/ZuUDo8e6wfLGF16hSUYNONNPH74wdrr9hPai/+Z1i7LOnDeGi1HrrB14Z7IKvQ
         DJgBYebPNWpS5rezdpfC9vnLMIwg8dxSjtDptdxmqlEskS2R6c3MCGIC9lHV2DIuvl0L
         PofyANXr9xLJwui+QNexLrBXvhiz+3J0kkHT85a2lmje3KXpwDz/Gw+Gy4I7pl9qosR4
         1NbY4JbqADJlsxL1L3HKnlhMwg+ix7e3SKKlsO2ncL1FK2X75nx/7TJmHjzSxDmP+24E
         Ut3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728965109; x=1729569909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9/TEbO9MJbhew2zKwdgbRij1p0FY7VuPgt3/uIhiKI=;
        b=HJR3WwVzmfy+9GKWw67JOFbL46bcqIkqSV1QxJiQ0oG9JVWPUSd/TttmizBopFcp5e
         +prNmu87WpgzNYahw6CUNNYgg1Pxvnres7n7twkWkje36pWlTcL1t2hqLAd7wsUOXlfO
         ZCTgNQVXVruIEURmhE9ZDfFwh6oH2WhVp2MCB6GWNvEDE6cRMEWQ04Ep/kEk6FBzIhpO
         ZNlDjTQD/oB4sZIfKAnvQX3TkOs63Yn2U2mpSUEyFTIRiBxx04qhTNt9unCFGfVhuibJ
         T/jOvolxu7nQzdILiMt43NTtP9rOWEkOG2aJ34/60cl0QYusGXvphssCXBCBCLitIwaZ
         ldkQ==
X-Gm-Message-State: AOJu0Yw3qyWW7CZiIIyELVuZCCcVw1WXKeYb5k2hF6d3HVSxgNPMSsfE
	4MLM3Nw+bEYKT/DvMdL2rKZ8uNvhftLJmGJRIv6mLVvRTAiLvJ1aTO3F4zNxcMKZFEVRACT31ol
	DCPoblGk8Il/RpIxrrIykrD8OBZU=
X-Google-Smtp-Source: AGHT+IG0rjWrp8zg4OjDDsf9j3l/9MckWZowlB2IjbnxgYvbQJK2OVkfFaOPXg6qAdA3Fc/k5CJHRmV0SMJROD3uHOY=
X-Received: by 2002:a05:6102:b15:b0:493:de37:b3ef with SMTP id
 ada2fe7eead31-4a475f6504fmr6464545137.13.1728965109119; Mon, 14 Oct 2024
 21:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM9FoGBhsnBE4E0Fvq-x_HvyFGGkkhaLNoRdVkvE6CpaZw@mail.gmail.com>
 <ZwqcHDzaR2U2JNu0@nand.local> <CAPSxiM_U5ffBCsTrbBqsJK0jUZtAuWSLook8CLKat46CX0QC7g@mail.gmail.com>
 <Zw26bU17+2SRfv8L@nand.local> <CAPSxiM9jHn-RQ3FXJRQNKAE9xPr_4yJbWB--oWgQeKhEMLmE4Q@mail.gmail.com>
 <CAPSxiM_qw0akVoG5cJRgwk6oP1q519zBp2m6GmFYGmrrc3jXfg@mail.gmail.com>
In-Reply-To: <CAPSxiM_qw0akVoG5cJRgwk6oP1q519zBp2m6GmFYGmrrc3jXfg@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 15 Oct 2024 04:04:58 +0000
Message-ID: <CAPSxiM-voyrHf0M2ELD6OmJr_ECQMd=+si0wd6_boy7VJCQzyw@mail.gmail.com>
Subject: Re: [RFC Outreachy] Leftoverbits, which involve replacing atoi with
 strtol or strtol_i or equivalent.
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>, 
	phillip.wood123@gmail.com, Christian Couder <christian.couder@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 3:54=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> On Tue, Oct 15, 2024 at 3:49=E2=80=AFAM Usman Akinyemi
> <usmanakinyemi202@gmail.com> wrote:
> >
> > On Tue, Oct 15, 2024 at 12:42=E2=80=AFAM Taylor Blau <me@ttaylorr.com> =
wrote:
> > >
> > > On Sun, Oct 13, 2024 at 03:46:05AM +0000, Usman Akinyemi wrote:
> > > > On Sat, Oct 12, 2024 at 3:56=E2=80=AFPM Taylor Blau <me@ttaylorr.co=
m> wrote:
> > > > >
> > > > > Hi Usman,
> > > > >
> > > > > On Sat, Oct 12, 2024 at 11:21:13AM +0000, Usman Akinyemi wrote:
> > > > > > Hello,
> > > > > >
> > > > > > I was looking at some #leftoverbits which I can work on and I c=
ame
> > > > > > across this conversation.
> > > > > > https://public-inbox.org/git/CAC4O8c-nuOTS=3Da0sVp1603KaM2bZjs+=
yNZzdAaa5CGTNGFE7hQ@mail.gmail.com/
> > > > > >
> > > > > > I followed the conversation and came accross
> > > > > > three instances where I think atoi can be
> > > > > > converted to strtol or strtol_i or parse_timestamp().
> > > > > > These are the three files which I think the atoi can be
> > > > > > replaced with.
> > > > >
> > > > > This seems like a good #leftoverbits to use as an Outreachy
> > > > > contribution. From a brief skim, it looks like this is going in t=
he
> > > > > right direction.
> > > > >
> > > > > But to get help from the rest of the list, please submit this cha=
nge as
> > > > > a patch or patch series, following the instructions in:
> > > > >
> > > > >   - Documentation/MyFirstContribution.txt, and
> > > > >   - Documentation/SubmittingPatches
> > > > >
> > > > Thanks Taylor, I already went through these as I already sent my fi=
rst
> > > > patch before.  Also, I already sent a patch as you suggested. Thank
> > > > you very much.
> > > > Usman Akinyemi.
> > >
> > > I must be missing something... I don't see any patches from you that
> > > touch e.g., merge-ll.c, which is the first file you mention in this
> > > thread.
> > >
> > > Try searching the list archive for:
> > >
> > >   f:'Usman Akinyemi' dfn:merge-ll.c
> > >
> > > Is this different from the other patches you have sent to the list? M=
y
> > > apologies if I am missing something here.
> > >
> > > Thanks,
> > > Taylor
> > Hi, Taylor
> >
> > Thanks for the reply. There is a little confusion going on.
> >
> > This is what happened. I had two patches which are entirely different
> > from this leftoverbit. Both has been reviewed by other maintainer and
> > integrated into seen by Junio through
> > https://github.com/git/git/commit/4dae47e02757333b7d6a6508e36ccb5463b6a=
d92
> >  and https://github.com/git/git/commit/dfdc6a71e76c7a1dab22fc9d9e437c85=
8cfea6dc.
> > I submitted this leftoverbit patch but I made the mistake of basing it
> > on top of the previous branch which I use for the two above commits.
> > This is the commit which has the leftoverbit and the previous two
> > commits which have already been integrated into seen.
> > https://public-inbox.org/git/pull.1810.git.git.1728774574.gitgitgadget@=
gmail.com/T/#t
> > That is the reason why you saw it again. Also, I noticed you also
> > integrated the two patches again into seen and gave some comments. I
> > think that might not be needed again. Thank you.
> I meant for those particular two patches, since it is integrated into
> seen already,
> I can probably wait for it to be merged then work on the review which
> you gave or what do you think should be done ?
> Thank you.
Hi Taylor,

I went through your comment for the two previous patches, some of them
have already been addressed in the original thread
https://public-inbox.org/git/CAPSxiM8cpX9NYB02fAPA7WbLsLrvmFfsE2=3DVN=3DNcg=
uif7mQN9Q@mail.gmail.com/.
I am really sorry for confusing you.
Thank you.
