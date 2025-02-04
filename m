Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F575684
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 00:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738628921; cv=none; b=ow5jkRRqqZWIzb4uPiRrki713s3dslrCXC04f8V3fvgxJ1WbQbZf60cDOWoddmAi1PljAY/m34xvRCfjH5/s/F+gw1V6LcQu+k/XjZPAVTlcMagpbVT4ElTT81Wx34X4Xyy1l9T1HD7Gr/R+/KpPWLPcMzuYkNnsbRm7FVgGmkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738628921; c=relaxed/simple;
	bh=sRq0YPRK0Aaj2fBY4iIuN31ZRbUDY2V74GJQYbtck6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLIQnToeOCN8QFsK03RYCRzyp5bs6QHh8cU60WDu5IRU6wQrrZfVE2acVCS3lAlndGIeVE4Ej8DZROWgC6GWpoS/SSw2KugIZDIRWmVBrg6NBm3/Sy++CMCpc+glZ1WPnpBmDf/fzaiFdaI2FNmEgsVpUq8oILiwL8J029luWx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQFtf6sE; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQFtf6sE"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2aa17010cbcso1929136fac.3
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 16:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738628918; x=1739233718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UgUYk80Jq0KxAavh1l0alwVmGB5qjP/A2AZEeNZSbyg=;
        b=ZQFtf6sEyslMo0sSal+w64N86+ZlLYBI9EVcQHaU1YDx6TF1SPKL1kd9Df54Bqn1PU
         S5U01ZXTK/oZms9e4Gk7fISR+HwweZgcYHy29MnJxAukKd4A7jD5lZO5g8cS1Y5wZgMB
         Hc4V0lTB/fCaDkr2nvtGO4IKDDf1peDmt0z5ce234AwfXXd/LGsHn1nTD/I/L1fS6bzK
         gf42CTDvXX8A2I8s30HFtEkKPHpVEbNirLis5cY68qwQGEqW1cBNbwcsAsoq69CGVQuA
         fDTMqLsqxSmLcC/SoMtI+qO5Xw4Z9js1vE4Ie6hc5PViJj+7cDwn53jQ8H6C92wmrNSy
         igkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738628918; x=1739233718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UgUYk80Jq0KxAavh1l0alwVmGB5qjP/A2AZEeNZSbyg=;
        b=LIJvXEIwzV+jTP7wIOspW1Ec5ZP6zq9/GHjgbCg26c3e3bSGmr7vtSbCvjP77ecbCi
         YrUn0A7Fn07P3Q5R/o2kJyAY0LVETleq8yvD482oORAfGUXecIK1K7Vzs2lVrb/vjllq
         14ZsmtU/Y7ux3C7+aseKYjclcWLCpjvadnqr9HNFpWhbZRlRsBpkjqJ5wlEp3hmZ3GlJ
         mxuHVMWFgg76Gx6tMgBNBowwR17xpipyl7hjvuyw91m4S67xe7yeQX/Y2mxDukzilLYB
         2o8MWz/Nysy2PQKRq8jfQ0Z6m41xzmsey2Gh/7Mun8d+ZxiSVhEt9uPRtGYyBlAofbmQ
         Uzlw==
X-Forwarded-Encrypted: i=1; AJvYcCX+IGT0BDb29EXNrzgOFA30kJN/SoZLyBHdw/9LHbvflqwAFJu8fxhMFXsydINqlwIdAoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7dM6WkFZSbhyc8+fXFxjMUb0PTDySMwvQ2UK+F0ke0R3QnP/Z
	3q9MrGon+LWHi9IGOW5T0GtH1Rw8mwUQQNrHJaCovU9tbs821hRfwsWHSQErd3P+HVkVidkuP5G
	xHBSjyNz1RJ34L34BCaKNgAOlAAc=
X-Gm-Gg: ASbGncv6GE5Vnytks3nVmpTYKV6mdNxaY8t1cQiBgPAP5IRO1D6XQ9l/DlLW+TfhewD
	AOqTRz+DZDeqS6AvleH2Fdag9wQ8x0sYpjU0z8D/u3ciTTq+AgBG6OvuD3rpYycYu6JQ7WKL4Ow
	==
X-Google-Smtp-Source: AGHT+IGwQrthu4d5rehry1tNxeEbjM0eNluffDst2rucKnSGY9u/v89RNCb2zpVSYY474rFY91u/daciHCIyXHEPakg=
X-Received: by 2002:a05:6871:a9cc:b0:29e:2d18:2718 with SMTP id
 586e51a60fabf-2b32f26194dmr14581942fac.28.1738628918629; Mon, 03 Feb 2025
 16:28:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPpV+OaMcViVKok5U0-4HaYyPMKEA7BBzw4t113uAaMndjs5Cg@mail.gmail.com>
 <xmqqh65b2ci3.fsf@gitster.g> <xmqq34guzi0f.fsf@gitster.g>
In-Reply-To: <xmqq34guzi0f.fsf@gitster.g>
Reply-To: bram@van-oosterhout.org
From: Bram van Oosterhout <adriaanbram0712@gmail.com>
Date: Tue, 4 Feb 2025 11:28:26 +1100
X-Gm-Features: AWEUYZlYcNwpyA37jkWifv84yP4uBvn6v4IuZ9K404gEREVP53tl4PPC8cxPtuA
Message-ID: <CAMoUM6+9SHybvWVp3SKDD4RWesruh=nmMacXn_oL893CPCn39g@mail.gmail.com>
Subject: Re: Usability issue: "Your branch is up to date"
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Manuel_Qui=C3=B1ones?= <manuel.por.aca@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ahhhh, this thread explains my confusion when, even though git locally
tells me my branch is "up to date", a fetch demonstrates the branch is
not up to date.

Which begs the question: Why does git say: "Your branch is up to date
..." if at best it can say: "Your
branch MIGHT BE up to date with ..."?

I have learned not to rely on the message and come to expect
(sometimes nasty) surprises when I return to a project after a few
months,

Bram

On Tue, Feb 4, 2025 at 11:11=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Manuel Qui=C3=B1ones <manuel.por.aca@gmail.com> writes:
> >
> >> that can be fetched from the remote. My proposal: Add the timestamp of
> >> the last fetch to the message. For example:
> >>
> >> ```
> >> $ git switch main
> >> Switched to branch 'main'
> >> Your branch is up to date with 'origin/main'. Last check was 2 hours a=
go.
> >> ```
> >>
> >> It looks like the timestamp of file `.git/FETCH_HEAD` would be enough
> >> to implement it.
> >
> > Not generally.  Your last fetch may not have been about origin/main
> > (e.g., "git fetch origin next"), or it may even have been about a
> > totally different remote (e.g., "git fetch elsewhere").
> >
> > The timestamp of the last entry of the reflog of origin/main may be
> > a lot better place to look for the information, if available.
>
> Unfortunately, this is not quite enough.
>
> I do not think a "git fetch" that noticed that the remote-tracking
> branch is up-to-date updates the reflog of the remote-tracking
> branch, so if you observed that their 'main' is at certain value 10
> hours ago, and if your more recent fetch done two hours ago found
> that they haven't made any progress, the reflog says "You observed
> that their 'main' is at this commit as of 10 hours ago" and not the
> number you want.
>
> However, as I said, the fetch that touched the FETCH_HEAD file may
> not have been about the ref in question, so while a two-hour old
> FETCH_HEAD can guarantee that update of any ref by fetching
> (including a fetch done as part of "git pull") did not happen in the
> last two hours, it does not really mean what you have in your
> remote-tracking branch is not stale from reality by more than two
> hours.
>
> You could inspect the contents of FETCH_HEAD to see if the source of
> the remote-tracking branch is listed there, and when it appears in
> the file, can use the timestamp of the file.  If you did this:
>
>     $ git fetch origin main
>
> and it left something like
>
>         f93ff170b... branch 'main' of https://www.kernel.org/...
>
> in the file, you can reverse map the URL and the branch using the
> remote.*.URL and the remote.*.fetch configuration variables to
> figure out that it must have been stored at our 'origin/main'.
> At that point, you know that the timestamp of FETCH_HEAD would be
> when we observed that value in the 'origin/main'.
>
> But even then, because the FETCH_HEAD file is not versioned, if you
> did
>
>     $ git fetch elsewhere main
>
> then the file gets overwritten, and you would no longer know when
> was the last time you observed the value of 'origin/main'.
>
> In short, there is not enough information kept anywhere to compute
> the number you want to show reliably.
>
