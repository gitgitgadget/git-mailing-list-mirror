Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EE12F2E
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759071679; cv=none; b=FTWsQsDFe3lZ/xM4x/TGpR5I6L1Vyzn0Zjmd8MNlIk/0nBjO1A/YVvdL+CinhcXOghEOyS7jRKq38ZrLq4pTZn+vDhzMESwdYWpOnXyFvbz8r8PugWFNkiHbgy0F5JjHFIbH28KfhYrOJ2M1Fk2gFSm9OZAOjHf/o7U8oVsQ0QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759071679; c=relaxed/simple;
	bh=xAMVjrlR0i8Yoy7tpTPriv5PrtGW1k7wcW1n6CK6occ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePY2JgB1jQUeLzTYwuQv6votaq/pRzA4XFSucN6Cn8trkZkNITtJqQF41MLkvxt7G/TfAFOZPLH16DBk1y8noNQ3GTsQnLo0omL02SSS4c6mlw/VgEYN4Om1616p5ylGaUO7mRy3FpC9kWNyY5mgAtAR1KRQTdvgJcA9gVv7+BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgZFyQUy; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgZFyQUy"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-367874aeeacso15751411fa.1
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 08:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759071675; x=1759676475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3yHW2aa1i6Rn73jB55I1tgSYrJSw7UEfRH5li43cZ0=;
        b=jgZFyQUyhHAZ2XKgZmMMWjF+WelyySgGNmJ9MNS7VK0277l9aJAgtoDrfPu20cG3Uc
         33lewXUzD0nsgzRFpJOOrg/mCoISBNrWi2W4aijtE4G32Ij1NPne836E8lSQ0bf58fNc
         b2Ulj+HI1/d+7ctLDT2XVVbemXx1HfrV1mUTsNb2DjVtSrEuYx9BSNvM5/Pb26K1qBiJ
         Ol7b7fOiN8PQQD1RTAa+uxcDRXTN9ydV1mCIV7UP7tB3wryGB2fWhM/FIyWH64zSyIg4
         kHxArYeY9zfJJP6WhmrvsIsc874dengTBoMhlGNaGY2rcQCB8bKEQZNQT/1NHlH0PU12
         e8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759071675; x=1759676475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3yHW2aa1i6Rn73jB55I1tgSYrJSw7UEfRH5li43cZ0=;
        b=I7VOWgTG4n+0VQ10qAd5XciEBCD9B712AMV8ZK6VdIUKdVcd+npxTrEeFjINvYjh7I
         yFSv5LueGe6UlJZiOQ1yXjLL45RXFGmMsIviCopwkSVGB3j/Sc34VsyOtTf76f8K66f2
         iKJalXs4Y8Q+37s5FZad6gOziHLkkSo+OFjv48nON3ZrWs00Iw1oyZq5ghrlcVKRa7f+
         ayURJGBDfy9kMoq3FI+rjdXe1ZGGn/rFPFgX0h1ceVtuyAq4arua9nG+Wy7lJpHYxSFC
         ZD/vEmG8DyOAe2ZUqLYwwAuvQCAc85rMRABYScZ0YEIZDvA766lRROr5/Pv9mssmQW64
         STOg==
X-Gm-Message-State: AOJu0Yyf3D8i0eI4I2Zh9opVGpJ/IZVcj2XX5JiRvdyqYM+9aeCdEGbM
	hj1fj7DhWXJqDXCTE2bTgSZ7HCaJWlC83L+JwZyvgkRdUSMfS69mgIEsKiCp0tr+hT2TT/Y3U4Z
	GQgxSguHqZQTLv75SdECyO4HMKAz+zfY=
X-Gm-Gg: ASbGncuyaci0Nhja0hubWOJHZytBwWw/fytqswTdx8V1wXWwlx8QduyVMwWj/3JLdR2
	ZuQ4HHxbBdb7+BovSoWbmfCj6cUCQZRZRGW5qDkBCKIMPifazovS5sPirxwzgm8AsS29rN1+TYi
	+iqeSGellkyjcvkhnec0prz8Vz4uIv4Gqq/mLE9niZ9psTxqz/+r3S0lO53SVEI0vmUgKuJdAzb
	VXEsQg=
X-Google-Smtp-Source: AGHT+IGO7jNILWpF0guIgkEbfhbrvuHnudwow0de7fAk4Kv7dgdjCM80fu4AoFlIPeoBskvpy12fVSRadlWHh0iBYps=
X-Received: by 2002:a2e:a58b:0:b0:364:f830:230b with SMTP id
 38308e7fff4ca-36f7f248f86mr38700231fa.22.1759071674252; Sun, 28 Sep 2025
 08:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928135435.59623-1-rappazzo@gmail.com> <20250928135435.59623-2-rappazzo@gmail.com>
 <be1e6cba-c94d-4c2f-ab68-e368ffe9daa5@gmail.com>
In-Reply-To: <be1e6cba-c94d-4c2f-ab68-e368ffe9daa5@gmail.com>
From: Mike Rappazzo <rappazzo@gmail.com>
Date: Sun, 28 Sep 2025 11:01:02 -0400
X-Gm-Features: AS18NWAOPSTYo-iUFgBA3sGSkNyMErm9fCyDeWwi2eMufLNTjH3k56ljsG8-V7g
Message-ID: <CANoM8SWT4atDtFDgMvx5ivun9-sXZCsmT6gUG07byYOB0+2DFw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Revert "gitk: Only restore window size from
 ~/.gitk, not position"
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: git@vger.kernel.org, j6t@kdbg.org, 
	Johannes Sixt <johannes.sixt@telecom.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 10:17=E2=80=AFAM Mark Levedahl <mlevedahl@gmail.com=
> wrote:
>
> On 9/28/25 9:54 AM, Michael Rappazzo wrote:
> > From: Johannes Sixt <johannes.sixt@telecom.at>
> >
> > This reverts commit b9bee11526ec23541ddbbd75716bfd1acc241463.
> >
> > The commit catered to an unsupportable port of the Windows Tcl/Tk
> > stuck at 8.4.1 that was used by Cygwin. 8.4.1 has some bad bugs in its
> > layout engine, and forced changes in Gitk to be compatible. All this
> > became irrelevant around 2011 after Cygwin gained an X11 server and
> > switched to a supportable port of the Unix/X11 Tcl/Tk (it is now on the
> > current 8.6 code base).
> >
> > Helped-by: Mark Levedahl <mlevedahl@gmail.com>
> > Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> > ---
> >  gitk | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> >
> > diff --git a/gitk b/gitk
> > index 6e4d71d585..275f353811 100755
> > --- a/gitk
> > +++ b/gitk
> > @@ -2764,17 +2764,9 @@ proc makewindow {} {
> >      .pwbottom add .bright
> >      .ctop add .pwbottom
> >
> > -    # restore window width & height if known
> > +    # restore window position if known
> >      if {[info exists geometry(main)]} {
> > -        if {[scan $geometry(main) "%dx%d" w h] >=3D 2} {
> > -            if {$w > [winfo screenwidth .]} {
> > -                set w [winfo screenwidth .]
> > -            }
> > -            if {$h > [winfo screenheight .]} {
> > -                set h [winfo screenheight .]
> > -            }
> > -            wm geometry . "${w}x$h"
> > -        }
> > +        wm geometry . "$geometry(main)"
> >      }
> >
> >      if {[info exists geometry(state)] && $geometry(state) eq "zoomed"}=
 {
> I mis-interpreted an earlier inquiry about the patch being reverted here.=
 Patch e9937d2a03
> actually addressed the issues of Cygwin's 8.4.1 Tcl/Tk. Part of that was =
fixing the window
> geometry being restored, as sometimes the window manager would size the m=
ain window in a
> manner causing 8.4.1 to fail. But, this override of the main window manag=
er on all
> platforms raised complaints on the mailing list, and commit b9bee11526 wa=
s the response:
> it was only the SIZE of the Window that mattered on Cygwin, not its locat=
ion, so allowing
> window managers to set the location was ok.
>
> Personally, I'm fine with gitk remembering / restoring the full window ge=
ometry (I wrote
> it that way in e9937d2a03).

In my v2 version there is a slight difference:
+        after idle [list wm geometry . $geometry(main)]

This seems likely related to my second patch changes where I use `after
idle` due to the timing concerns which I reported on in my latest email
from that series[1].

[1] https://lore.kernel.org/git/CANoM8SXnxxF6UMSfQ06ANfEv7HFCEEMCVoGgod1-Du=
FeHp6tXg@mail.gmail.com/T/#e1fc2a76267e3077c0de40ad8902e2158c00164e1


>
> Mark
