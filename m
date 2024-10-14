Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F01586CF
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922400; cv=none; b=jf5MJIcRSzuDz8YuQ51KDKCflzI7JBnyaZw2vTEdk6mdUkW2q9HbR0lmOXVA1itb91JSyqQSe7dLUnvKjHNn108WahghoACjPZTcEQpmpQX2v0tcp5CtkOrI6owr5YohvAiqY3Aj1P9D+Bi1BC8sDMi93wkhXJu0M5aoD9rwoNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922400; c=relaxed/simple;
	bh=7Caspx7i6VsrNH8Gb2FfyWfMkAIhXQp8LHwcLjioXmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IlUmGbZPYseHDtB01HtmQDgIoJPyDNSUyyqtMmtpwezBFGw0ojFIriF4+4f8cSo0ZObAZMKjkK1wvEVfT4q39hawZ+886oNukYgWQKOQ29s0nsJfUo5W9/SNWRyBbcCV4dwt7+WetZ81BE22vqdONscVX6xlqJuyCOhcfinTzYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brpQn4rM; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brpQn4rM"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-84fc7b58d4dso1191364241.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728922397; x=1729527197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYIO9uVAkjg87BXAyw3LNgxjcx7+1z9W2jih9BkQKeE=;
        b=brpQn4rMsVm+Chs25Lk0e8/iHUo5iwVkHb6kOIRCLvaJFngKvh7G2gYHjUz/Z1tE9B
         0eSjBuNCJ4xWzR4hp7KWqvC0vO74DbJEbMB05ZLyuLxF7a1aIiB+GaQjOKsv825jhU0u
         sjhEkXMTNBw4fScxYAFDIS+5NJZG1S5hy/6yoWcnYqesfGbuQsUDKL1INaMp0LkFGHOY
         +2prPewxHpCpSb0EXiLBGGTtIixMlvbl/S9dCvtpOiiY6IoK/lj1ezAL30lFFBBVAnjW
         tqjq1jUXcMS/3+v/kNAlfNBrMgvBJbszQI5xfOLo/10Ix+cmFwyRlENVrsrsjHxeDBkG
         rzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728922397; x=1729527197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYIO9uVAkjg87BXAyw3LNgxjcx7+1z9W2jih9BkQKeE=;
        b=dxHWExit78Zz88/Wbjrop5RTTzZaIXOuMU8p9Cgt13aUWfnPodQVqPxZLQyOsn0lkV
         gRWxRxOVc8rAbxAdxHW5U4FC7kYCfg9KMWqXQmjO317NrHSY9fykxRV9xkUCdAB7rEw8
         90NRUoiW5xRG0dng9xiw0w5ZzrcTocJZB7lhyX0lm03YvpF3BDb7DaTxbJqXQETJiPN5
         URDzlxmNJs+7KnZj/ooTHpnDPG0BFeUto9z25rJiB7N8fsfDzefFAY3r5+UH+VfmGfl0
         /9//ryHdbbFPgknASq0OpgI4zOGyrRe2fnb5S4kjo4LGSQvoaOWT6k7VYy0lk9XyeClP
         SGOg==
X-Forwarded-Encrypted: i=1; AJvYcCW3ydpywNMYM4djS+P7ZWr5joSJWsRFRiBpmEFL4zL8aaVfiwMWJhyLiT66N6dWwa4CNv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFpw4GmkXO30WnD2N2PSoLNZtFpVbOeAIv2nFnMuaxE3/Bo0rm
	PYA6q2nFJzj5/afRjTDgOy3MDac7pUZ0w96hlGVwSvjK4gsevfWR73nFR608IXR86qcIeVxrhpD
	rOEbQq9Diir8VK7VV5nw+tNu5+k8=
X-Google-Smtp-Source: AGHT+IF6pGfTXLz3GfDHlLpBXSFFe4jNAvlV9OkNnhFruylCQ2gNf/A6OQIV8sHvdsquf+Bbinft6dvKgZBgZu03XXM=
X-Received: by 2002:a05:6122:923:b0:50d:4b8d:673c with SMTP id
 71dfb90a1353d-50d4b8d6cd3mr3194834e0c.0.1728922397302; Mon, 14 Oct 2024
 09:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com>
 <Zwz4B4osJnYJw6pd@pks.im> <2a937b6f-a3fb-4f2a-997b-5508f0e20e65@gmail.com>
 <Zw0kGLZ-mcYjb6Je@pks.im> <2160f8ea-5f00-49d9-8e02-d71d4d827d39@gmail.com>
In-Reply-To: <2160f8ea-5f00-49d9-8e02-d71d4d827d39@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 14 Oct 2024 16:13:06 +0000
Message-ID: <CAPSxiM9ncwaZ3HF72wsRwmen7joWk3mjipsu78WxKEzLX607sw@mail.gmail.com>
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and strtol_i()
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 2:55=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 14/10/2024 15:00, Patrick Steinhardt wrote:
> > On Mon, Oct 14, 2024 at 02:57:13PM +0100, Phillip Wood wrote:
> >> On 14/10/2024 11:53, Patrick Steinhardt wrote:
> >>> On Sun, Oct 13, 2024 at 09:42:41AM +0000, Usman Akinyemi wrote:
> >>>> On Sat, Oct 12, 2024 at 11:09=E2=80=AFPM Usman Akinyemi via GitGitGa=
dget
> >>>> <gitgitgadget@gmail.com> wrote:
> >>>>>
> >>>>> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> >>>>>
> >>>>> Replace unsafe uses of atoi() with strtoul_ui() for unsigned intege=
rs
> >>>>> and strtol_i() for signed integers across multiple files. This chan=
ge
> >>>>> improves error handling and prevents potential integer overflow iss=
ues.
> >>>>>
> >>>>> The following files were updated:
> >>>>> - daemon.c: Update parsing of --timeout, --init-timeout, and
> >>>>>     --max-connections
> >>>>> - imap-send.c: Improve parsing of UIDVALIDITY, UIDNEXT, APPENDUID, =
and
> >>>>>     tags
> >>>>> - merge-ll.c: Enhance parsing of marker size in ll_merge and
> >>>>>     ll_merge_marker_size
> >>>
> >>> To me it's always an indicator that something should be split up acro=
ss
> >>> multiple commits once you have a bulleted list of changes in your com=
mit
> >>> message.
> >>
> >> Agreed, but I think in this case there is a common theme (converting a=
toi()
> >> to a safer alternative) and the problem is with the commit message lis=
ting
> >> which files have changed rather than unrelated code changes being grou=
ped
> >> together. This patch could be split up and if there were many more ato=
i()
> >> conversions it would need to be split to prevent it being too long but=
 I
> >> don't think its essential to do so.
> >
> > In theory I agree. In practice I think we should have better
> > explanations why the respective conversions are fine and whether this i=
s
> > fixing a bug or not. And if it is fixing bugs I'd also like to see test=
s
> > added to the tree.
>
> I'm not sure if I would describe any of the changes as fixing bugs. The
> option and config parsing code becomes stricter so I guess you could say
> it was a bug to accept any old rubbish and treat it as zero before. The
> imap code that's changed all rejected zero anyway apart from the tag
> parsing so maybe accepting the changes to the tag parsing are fixing a bu=
g.
>
> > And by the time we got there it makes sense to split up commits.
>
> Yes if we start adding tests then it is worth splitting them up, I'm not
> sure we have anyway of testing the imap changes but it would be worth
> testing the other changes though.
>
> Phillip
>
> > Patrick
> >
>
I got this from a leftoverbit which the main issue was reported as
bug. https://public-inbox.org/git/CAC4O8c-nuOTS=3Da0sVp1603KaM2bZjs+yNZzdAa=
a5CGTNGFE7hQ@mail.gmail.com/

For the test, I should have the test as another patch right ?
Thanks.
