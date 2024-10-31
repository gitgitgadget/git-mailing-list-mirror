Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE019CC1D
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377290; cv=none; b=so6lL2Ut5Iga5GlTuCbFWq9ksUleHct+J8+fhhqqFGBIlHf+Mo7ImC8C9ZLbl0YhRHBR8XbW2XDdxrzvdKwdvkQEiVU3Zfbj+u2mPTxzZx6xo4NxDrOFElt0hCL4lvOP1JFY/ldLzO+yeI7HBPc/w6cUW/8PonVZVya1RnXWjy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377290; c=relaxed/simple;
	bh=n7XNRJTlPnLJtMcGmXXFEKwk9jeHhfoSBDlI0MHaCcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcyiEA6pEgwCzXBF/cIpg6H25h0+08IKWxAlFgl6uRnJiw0mf1wl54RH7bpsc4rxw4Tr6XTiU98rIK8AE3f4PYD5F9qdtpKIOKCm4dU6wpSA7wRftQP71MUyPEuMJ/ILZc/EfE0ctGfvkACtwbKtR9cXleJWOPTu6GZohGZP0pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gooeyh4N; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gooeyh4N"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4a5c4d8ee99so261901137.1
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 05:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730377287; x=1730982087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9+dp+H+mB3EFi9rOF/7s/pY01AxJ8xrR22ZsHjTOjw=;
        b=Gooeyh4NLDAL8Lo+M9urxRDGtVIcjqyN9wI9ou2GENXlib4DoPeE3aRB95WFS5x5Be
         10QxiR5iBzkLbRBWsUcl00zwztEPn1eF0Kt90k47IbMFJ+CGmUbgZNFzptzEc54T3CBr
         bfsSrSPY400PTI4OlI464G+8pFN/Jo1gjB11wd3Z3X5kxYshYP3W6yp2TpbGjA5DSGg6
         JDtqKISlv13VQMhvJxtqnUUXuk3FGTRj1S7gsLiQLc+/qDzD8AKf5hQ036IkEyvhmOE/
         KJC0SQKZdCP/qzOU/Qowd4j0Z67V6tTY93vnFYn62ZtV4HMUjxwQz0N5uIucb4Bw0PRn
         0gAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730377287; x=1730982087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9+dp+H+mB3EFi9rOF/7s/pY01AxJ8xrR22ZsHjTOjw=;
        b=vGfoAejMjr25AfIFp53L8x/1CgINNjwV35RRsm6Tm76He9W/YJDvM18+S4Zkp6OzY2
         hqAgdM62aNrLM7+Q5nh2AOQMtPQLf2ty41lsKJjcqroDYScwzbFDy1nRYk7A49KYC6+w
         6O557hF6IuYFCnyieXywVsFeeFRyvXDfrvEZfuldKSocDWAqyY0qS2GhNsITCh6GdeOt
         xIBGK2cEM+rilu/4R9M2+LCB5vLCzcD8su9DLKJVzekrondUrZ1Ek4P3M2Q4tzDqeAxM
         Ge8e88BGCtFbHO9eqPzvAGF8nfjGDpH3eF4EGvDAU64wJOgvZvw+kSJG6chx1/0C272z
         NPGg==
X-Forwarded-Encrypted: i=1; AJvYcCWFKHeMkVoV0KgTOOIvrmuDxLWajJTqLufmp0xyXHEcwD2eDUMlbV4CwBLRNfKTaCLhcwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYYEa+GlYu1pJNVIIxjprbRbH3bmMl27TUVaCeCNvfEN0G6uBI
	7xDWLFlCKqseRlH/bCTPnXo4pgJo7ewG7ejAxmttjaGvpBHafl5MGZmKzk48v7/0Sw7FwC6Ar90
	C3cPDwHu2kzNDwhAd1Yc5JYZg1LE=
X-Google-Smtp-Source: AGHT+IG2hzov1S1JIQjfE7jPiZSIj0q7Gzbh1TY6UdwVeH2u9Z8Sdz40nurAWibPy31Gg/VSCdDQSdKVqE8d3rP2awo=
X-Received: by 2002:a05:6102:3584:b0:4a5:b5db:ec5e with SMTP id
 ada2fe7eead31-4a90108f45cmr8932985137.27.1730377287271; Thu, 31 Oct 2024
 05:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com> <5d58c150efbed1a10e90dba10e18f8641d11a70f.1729259580.git.gitgitgadget@gmail.com>
 <ZxZHH-oHE7g09xIR@pks.im> <e4a70501-af2d-450a-a232-4c7952196a74@gmail.com>
 <CAPSxiM-X3gk4tsVSJ_dFP2EGWX_dvFnqRp0rTYvhPxqYsUeijg@mail.gmail.com> <3c081d3c-3f6f-45ff-b254-09f1cd6b7de5@gmail.com>
In-Reply-To: <3c081d3c-3f6f-45ff-b254-09f1cd6b7de5@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 31 Oct 2024 12:21:15 +0000
Message-ID: <CAPSxiM8u8CdeipatHRJ8Fq_8hKHDqyTm8OCh7sR49_Bh6Ps8uQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] merge: replace atoi() with strtol_i() for marker
 size validation
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 9:58=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Usman
>
> On 30/10/2024 16:19, Usman Akinyemi wrote:
> > On Wed, Oct 30, 2024 at 3:20=E2=80=AFPM Phillip Wood <phillip.wood123@g=
mail.com> wrote:
> >> On 21/10/2024 13:20, Patrick Steinhardt wrote:
> >>> On Fri, Oct 18, 2024 at 01:52:59PM +0000, Usman Akinyemi via GitGitGa=
dget wrote:
> >>>> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> >>> These are a bit curious. As your test demonstrates, we retrieve the
> >>> values from the "gitattributes" file. And given that the file tends t=
o be
> >>> checked into the repository, you can now basically break somebody els=
es
> >>> commands by having an invalid value in there.
> >>>
> >>> That makes me think that we likely shouldn't die here. We may print a
> >>> warning, but other than that we should likely continue and use the
> >>> DEFAULT_CONFLICT_MARKER_SIZE.
> >>
> >> I think using a warning here is a good idea, we should probably fix th=
e
> >> whitespace attributes to do the same. If you have
> >>
> >>       * whitespace=3Dindent-with-non-tab,tab-in-indent
> >>
> >> in .gitattributes then "git diff" dies with
> >>
> >>       fatal: cannot enforce both tab-in-indent and indent-with-non-tab
> >>
> >> Anyway that's not really related to this series but I thought I'd add =
it
> >> as #leftoverbits for future reference.
> >>
> >> Thanks for working on this Usman, what is queued in next looks good to=
 me.
> >
> > I just checked it. I will be glad to work on it.
>
> If you want to work on this that's great, but please don't feel any
> obligation to do so.
>
> > I also noticed that the test used for testing used a different
> > approach(test_must_fail) compared to the one I wrote which used
> > test_grep. Should I change the test also ?
>
> I'm not sure which test you are looking at but I assume it is using
> test_must_fail because the command being tested is expected to die. If
> we change the code to print a warning instead then we'd need to capture
> stderr and use test_grep or test_cmp. Note that we only want to print a
> warning when parsing .gitattributes, the other callers of
> parse_whitespace_rule() still want to die. Also we should decide what
> value to use when the user provides both - neither indent-with-non-tab
> or tab-in-indent are on by default so it's not clear exactly what we
> should do.
Hi Philip,

I understand, we will have to pick one if we are to use a warning in this c=
ase,
indent-with-non-tab seems to be a good candidate as it is not excluded
by default.

We can have something like this

    if (rule & WS_TAB_IN_INDENT && rule & WS_INDENT_WITH_NON_TAB) {
        warning(_("cannot enforce both tab-in-indent and
indent-with-non-tab, removing tab-in-indent"));
        rule &=3D ~WS_TAB_IN_INDENT;
    }
and this for default
#define WS_DEFAULT_RULE (WS_TRAILING_SPACE | WS_SPACE_BEFORE_TAB |
WS_INDENT_WITH_NON_TAB | 8)

or just leave the WS_DEFAULT_RULE as it is and remove WS_TAB_IN_INDENT
in case both are set.

what do you think ?

Thank you.
Usman


>
> > Also, when should someone redirect a warning/failure into a file then
> > use test_grep or just used test_must_fail ?
>
> You must use test_must_fail if you expect a git command to fail, if you
> expect the command to print a warning but exit successfully you should
> not use test_must_fail. So if you expect a command to fail and print an
> error or warning then you'd do
>
>      test_must_fail git my failing command 2>err &&
>      test_grep "error message" err
>
> test_must_fail checks that the command fails, but reports an error if
> the command is killed by a signal such as SIGSEV.
Thanks for the explanation. I understand it well now.
>
> Best Wishes
>
> Phillip
>
> > Thank you
> > Usman Akinyemi
> >>
> >> Best Wishes
> >>
> >> Phillip
> >>
> >>
> >>> Patrick
> >>>
> >>
> >
>
