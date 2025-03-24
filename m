Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC1A1B3F3D
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742848542; cv=none; b=khyimBcIpm84r7WX5V4qxhjnkwNSn822FcPtVAN8mi31TilSdHNpmNiLwoflpkCC5rAPh1FXU4vm0nb13Pi7QOAAM+Mi4qZubOlesIdEFlm8xMOdqTSMdaIhwY+NlZ5+q4bJcVTjlsSrti6WWWIGZSrAeyqQ4p6+WMbeYEKQ51M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742848542; c=relaxed/simple;
	bh=KJQTzH2YjsG3quu9IqH4CfNGob/I89NU8XqhSluuqqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NABZQRijSXfGgreWeq9LpVX4rVGzQQK679+tK/rs99NSEAKzJB+SBpi3CdsxMUn986RuaScitZCpVnu7B/dZTT57/13RrY4dYuSSM5m9mREtIsHaU9BJZyXRp1A6Ruv3G4XdsVglEQJRecde34oNssfkpCZN+b7krBc87SET2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deHvFrxh; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deHvFrxh"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so7771234a12.3
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 13:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742848539; x=1743453339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJQTzH2YjsG3quu9IqH4CfNGob/I89NU8XqhSluuqqg=;
        b=deHvFrxh8nOZnynPIvEIilFaVyW+sYKHc2ERx9TNcSKom2YdbprNH3jE+9c3ySotbA
         vtV+z7eH+Ez2WvY27Om/N+F9RiWRAZSuRQl+3tWM8zjyrXcHGxlBH++I09RgWrzktY+2
         lA7xDsZBsMJTqI7tx6itcTHSS6UqaJkItmlphyyYiBxvkBNYLePjmzVe47/r7CIWmSYt
         bMpXWns8dskM83XYniDvI3WbdZA6vTW+DjrINkgdBLLa7fR3R+FwflirUwl5920MHv6N
         xzm3qYkgoiFWy36T1aPrdEkTTmNC2PeJ4GyRTMz+zyY1zMtKs1fVJdhXj1DwQTW8A9ey
         J/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742848539; x=1743453339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJQTzH2YjsG3quu9IqH4CfNGob/I89NU8XqhSluuqqg=;
        b=AY1sBcPrEoedP/sc+5GV45FolOJ3amJRQDczt6UHHpvi+8MP4n+U+tVnWw0FJg2SZQ
         2MfJumi62/8uoETWRt0XWJ+2fnGhgtMr2br39kcodpeLXjLlO7XwnhP2kAcaWCIoeyVS
         Try+8dkxwSefTKXmd9gvhxA7EEJknLEMvZm0UtFMowOgwNknXkAyEhItUdncvvm4hz01
         94PRd5Ic/eSosQWZlPMILEy64UE5hxTCu2p3gtMLw3SgY1oJSEmZG/Y7iTZW94uiYdE1
         JBHD3dCCwV7vmUD3pzRv9+zRlksAJu3Ky95p70AecU1uCzfUflUVOO69fdi5H8BaO7aS
         HDcw==
X-Gm-Message-State: AOJu0YxfrDppTeRCo/x8/2MtwRUNgZinaO/S4I2CQLzwNg2wfaCEfwWV
	A80rtacvQe++Q44sGA3CKSpDmelsGTFGouI/qM8GV/nr1wLsSXo9uBfxLbxqkec5WXFBkJKq6cQ
	4gcgWmSxsaOioXobvyyCwFvkDLMhOoLV+Qcc=
X-Gm-Gg: ASbGncsfG99iSoNMeIqxxkvlJ6eqeSz50Zy9h453Dyy2XTtY/Wc3NpD36RLU8M5SAOb
	tKkE5Tkz6ccUm+8DrGVTqledUvjL/JVEuYhS8alIKuqWr72ubXRJGHr5um3DJfuzVsNuntQ8kow
	Vg1pxuCJjRf6w2qD2KWif3H1FWR4ZiqQJSZoV3ZgIvHnotKqY1iFKrGb8pUfDL82OjRG/FJYI=
X-Google-Smtp-Source: AGHT+IHeeDfE+1eDjojW9PmokbLyJpWshqavfXpmbqNupwG/DCrv7AQW/Qh9PeIlW4RiFwviHoreM/fzeO4tFi0DwdA=
X-Received: by 2002:a05:6402:2551:b0:5e5:bde4:755f with SMTP id
 4fb4d7f45d1cf-5ebcd433fffmr13537541a12.14.1742848539264; Mon, 24 Mar 2025
 13:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC6paJg19ue7W0VxTnGH-1ra3Zkk+pRnj6McEC755RD54xDzCA@mail.gmail.com>
In-Reply-To: <CAC6paJg19ue7W0VxTnGH-1ra3Zkk+pRnj6McEC755RD54xDzCA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 24 Mar 2025 16:35:28 -0400
X-Gm-Features: AQ5f1JowBWIESARws8nSWJIv_YPDk3399MH-fItQUaeFX6p3HS61qnNUAEjHByM
Message-ID: <CALnO6CD=ghMyWm6s8u3=iH4neRMWnTTAQWUAokcgM1HOBqNC6A@mail.gmail.com>
Subject: Re: mergetool.vimdiff.layout behavior differs from documentation
To: kawarimidoll <kawarimidoll+git@gmail.com>
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>, 
	Fernando Ramos <greenfoo@u92.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 10:54=E2=80=AFAM kawarimidoll
<kawarimidoll+git@gmail.com> wrote:
>
> Hello,
>
> This is my first time reporting an issue with Git. I am not a native
> English speaker, so I apologize if there are any translation mistakes.
>
> Below is my response to `git bugreport`:
>
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> 1. I checked the `git mergetool --help` documentation and configured
> `$ git config --global mergetool.vimdiff.layout "@REMOTE"`.
> 2. In a repository with merge conflicts, I opened vimdiff using `git
> mergetool`, updated the REMOTE buffer, and saved the changes.
>
> > What did you expect to happen? (Expected behavior)
> I expected the changes made to the REMOTE buffer to be reflected in the f=
ile.
>
> > What happened instead? (Actual behavior)
> The changes made to the REMOTE buffer were **not** reflected in the file.
>
> > What=E2=80=99s different between what you expected and what actually ha=
ppened?
> The documentation states:
> =E2=80=9D@ is used to indicate the file containing the final version afte=
r
> solving the conflicts. If not present, MERGED will be used by
> default.=E2=80=9D
> So I thought that the changes made to the REMOTE buffer will be
> reflected in the file if I use @REMOTE.
> However, in my tests, @LOCAL and @MERGED worked as expected, but @BASE
> and @REMOTE did not behave correctly.

Interesting; I haven't tried to reproduce this, but the docs appear to
(vaguely) indicate that this is the case.
I've CC'd the author of most of that mergetool for some help, but the
issue is likely here (lines 298=E2=80=93310 of the script mergetools/vimdif=
f
on 683c54c999 (Git 2.49, 2025-03-14)):

# Search for a "@" in one of the files identifiers ("LOCAL", "BASE",
# "REMOTE", "MERGED"). If not found, use "MERGE" as the default file
# where changes will be saved.

if echo "$LAYOUT" | grep @LOCAL >/dev/null
then
FINAL_TARGET=3D"LOCAL"
elif echo "$LAYOUT" | grep @BASE >/dev/null
then
FINAL_TARGET=3D"BASE"
else
FINAL_TARGET=3D"MERGED"
fi

(Apologies that my mail client appears to strip leading indentation on
paste, ugh)

A GitHub link, for those who prefer it:
https://github.com/git/git/blob/683c54c999c301c2cd6f715c411407c413b1d84e/me=
rgetools/vimdiff#L298-L310

That code goes back to 0041797449 (vimdiff: new implementation with
layout support, 2022-03-30), whose author is also CC'd.

--=20
D. Ben Knoble
