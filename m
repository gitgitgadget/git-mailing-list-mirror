Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC7E1CF96
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728207155; cv=none; b=MRKOCgxP/WrDgGQVP69nxHn4zQZCJXzfGlblmc2x1YK4PBVUvWcOuegnqHX36AtczdWJznfmi+UCIsJ1R6SxigMJuOg1sUCVlOMP24StXvm2IhjZ4hhu+EQsjBcS6aHMMMmCMf5qAEMTiReGsQiHb1cWFDVPcCR5FSIwyYhQsqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728207155; c=relaxed/simple;
	bh=Vg4PtqZs5iom5rEaTOGy6ACPIguY1R4SLV3zuTOce/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWy/pKFq25vwHrwB7E9uGxrNxAS1DtNEjggVekaUktA1Oxnz7CeFr413xCVzyMY4on1vO/iOGmog469MVKJs9cZ0FxdBpGaCC0L5XL8CK8DMajZJ2gGYP6f4KYssGNth6oQEYNMV61scMiPXaU015MWn2GNZDx9bEFKNkpxo6Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkGuH8Lk; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkGuH8Lk"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-84ea1e5e964so2589738241.0
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 02:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728207152; x=1728811952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mQpu5vBLGb5uwULVQHKFRSf/NkEq5FY/smfntlWTe4=;
        b=mkGuH8Lkva/+crxFUqIbl9NYVvlrbEtjU2TdcFaqVSmiVitbzoD2PRUXSh0vJl+5v5
         6HULSra0HMVXr/vXqUPDGkTFBaoWmn6ro3kERGDy5WDp1ghQxGjBIWJF2A825ehpyZgN
         IRqG9zYqdCIAnAX5bt9pWPMtZdpiBnw3Sb7UEUlTPqjZLrSKYI3TIp/h+7arEqDq3Uun
         wyh8RsrlPuNr3yfWtriaFLcygdoAyOuXRe98ZFJAiMTcE1bPuyr4UENnFJMGnNDxqKlg
         nCNrKvf2Y7G+Gw2ULBTJBUv8JpW4jXCMo7gRgrMS7DcXoWccaDT+7oQjdhdWJH0f/dyw
         49/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728207153; x=1728811953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mQpu5vBLGb5uwULVQHKFRSf/NkEq5FY/smfntlWTe4=;
        b=rN/LPNEkolXYNUsAqXT+EghiU46SsEZBuIaswk/sw6mwBricTCBjXzWaym7yxYSrMj
         tQ9x8Y6j7CCtqFi7LIxeVMW30mZBosXERH1CffjpOF2/u2byRqhwnrPlsAvJmdGoqRsl
         dXtlDDfYXN2xGls0njYRRCnzPR06ybYxi1poBQoKwxj5V8BzJhRW5frWJTVG64ShYMv7
         lpKDUJOfc0ans9kQloGdo3yqWmHGJVx3Mn58YLzqmK9WEFLaTZjW8ncdLL4ytM9MjtRZ
         0GoH/9vfHYb1H/iwQRllpvGabBlEukpnmv0iVtgwVP6TRhKyPf1i0+EK8sTOCS1suYti
         wduQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6hSQ9PFqIrBOmauDTwsusIsNtbsXAttEnWNEMJIdlBKM/9b9OHxRuFPzKewwd9M+sN4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYnwpshowr849X7G4d33zWQiO3Fk7Ye//P6D5Y2BuK2GM4h8ZC
	voQGP7HqnWRlAEy2ymyGwRQs9Kf4NZy2zuRzBIlrWI9Y7wxne1W0FjvtxZRZf2uAVuuSPwoDbFS
	yYbmz6afDsM5T6ZSbdwi4nO2UOJw=
X-Google-Smtp-Source: AGHT+IHp1zf6vInbB1M5MfhHTKM5J1vwoPNxicPpptQuzyQVD8xbHIJvhkvkxS6PiFkgV4HFIjKQGN2fmnJq1u7fFTc=
X-Received: by 2002:a05:6102:358f:b0:4a3:b344:b3aa with SMTP id
 ada2fe7eead31-4a405ce9511mr4675844137.5.1728207152632; Sun, 06 Oct 2024
 02:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
 <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com> <CAPig+cRePbX6OyE6WhFp1GEZenZyC7HFeA3188F_nErt7Gin6A@mail.gmail.com>
In-Reply-To: <CAPig+cRePbX6OyE6WhFp1GEZenZyC7HFeA3188F_nErt7Gin6A@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 6 Oct 2024 09:32:21 +0000
Message-ID: <CAPSxiM-=wtsd_XH3FY+C+1V_MwNkiMtRDwOKQH4r+6Cfj5Vydw@mail.gmail.com>
Subject: Re: [PATCH v2] [Outreachy][Patch v1] t3404: avoid losing exit status
 to pipes
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 9:19=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>
> On Sun, Oct 6, 2024 at 4:31=E2=80=AFAM Usman Akinyemi via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > The exit code of the preceding command in a pipe is disregarded. So
> > if that preceding command is a Git command that fails, the test would
> > not fail. Instead, by saving the output of that Git command to a file,
> > and removing the pipe, we make sure the test will fail if that Git
> > command fails.
> >
> > Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > ---
> >     After submitting the first patch, I noticed that the output of wc -=
l was
> >     failing due to trailing whitespace. I attempted to fix this by usin=
g tr
> >     -d to remove the whitespace. However, instead of squashing the two
> >     patches into one, I inadvertently created another commit.
> >
> >     Eric Sunshine sunshine@sunshineco.com provided valuable feedback du=
ring
> >     the review process. He explained the details of the patches to me a=
nd
> >     pointed out that using tr -d was unnecessary to resolve the whitesp=
ace
> >     issue.
>
> Thanks. This version of the patch looks fine.
>
> I notice that there are still quite a few instances of `git` upstream
> of a pipe remaining in t3404 even after this patch. But that's okay;
> fixing all of them would have made the patch far longer and more
> tiresome to review, so it is not a problem that you selectively
> converted only `git show` and `git cat-file` cases. It probably would
> have been helpful to reviewers if the patch's commit message mentioned
> that it only converts some of the instances, but it's not worth
> rerolling the patch just for that.
>
> So, I think it makes sense to stop here and consider this microproject
> successful (unless some other reviewer notices some problem or
> requests some other change).

Thanks Eric Sunshine, I appreciate your time and review. I am more
eager to continue working on it after review from the others. And also
would like to work on the test_line_count also if permitted. Thank you
very much.
