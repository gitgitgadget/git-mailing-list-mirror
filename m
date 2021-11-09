Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF189C433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB04610CF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242526AbhKIXEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:04:34 -0500
Received: from mout.gmx.net ([212.227.17.20]:54297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240198AbhKIXE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 18:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636498887;
        bh=s9UqleHRiutT16niIx93TWC8BLzlfB1Xe/NmwcB66lY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OXFrA2SHDI96U6hZtmdYkqxaxuAUhNp81aI+c5SMFnPn9eotAu1IeyU3thizsFrGN
         uEM65a0YJqDg7LlYkhbINVEBIENvgzXzHBy2Oodoi0LSntJKdaRBqz8yDsf1HyvWP+
         3YtGvOIfImw3KEdIipny+zR41ac587MeehILWXhw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.22.201.164] ([89.1.212.10]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McYCb-1mAPHu0ZnZ-00d2ED; Wed, 10
 Nov 2021 00:01:27 +0100
Date:   Wed, 10 Nov 2021 00:01:24 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 7/7] t/helper/simple-ipc: convert test-simple-ipc to
 use start_bg_command
In-Reply-To: <dca03da9-5684-10c7-2315-2d10affd4f0a@ramsayjones.plus.com>
Message-ID: <nycvar.QRO.7.76.6.2111092358240.54@tvgsbejvaqbjf.bet>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com> <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com> <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com> <20211104194619.GA12886@dinwoodie.org>
 <nycvar.QRO.7.76.6.2111090051530.54@tvgsbejvaqbjf.bet> <dca03da9-5684-10c7-2315-2d10affd4f0a@ramsayjones.plus.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aFoo/douGOzceHabpdEBh9gHqc9+Iu3PFDxks4T5eA7oB59H9BR
 6T4ej6AVOzrrk/rSyCIKkaD0YgnYeL2HXT48BO09WCMGxYHINagKtt7dqIKk8LS9zKT0A5l
 RqRKU+SRCLuRHepjDtEwoHhQq4uPiieP7uto4fQjceFIFt1x3+kZapatA5aQoUKCyipZf2o
 ypQfRbk1nsjN6uwbxxDmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7iUrBf+MfEY=:APRxddvM6XVcABzfB74yFj
 NoU4zUceHMBfKIlNasp+AyBtc1p/G2P2z4VyRuQuXJfxnuU5utS/iz/rxh38dr2tGYSY9Z/hm
 u3+2w6ORda8NyHnj/MNdeLNHJ1sUbr35v6SKMAgw2gqD+mP0e66danA1gECtdgLSykhyZGKzO
 6rZvWLVOJN5Pcc0oMrE8XePbhfMtg7PIiQFN+M0kN/Lxo5UPeYm5JxSZpth6FrcmOENPtjyPs
 k/vNaz7BcCTvQskylAhTYH8SGIJSFVSptXOiAmGcrfkMcdr5QW/Vw8nqfsmlKZxwVO/YDS8ZP
 AHP8aSdcqtJh1zcMDc1uNN/0jn+rPUH7lkVe9Rb3K6ZFuMIngHX+oWX/ExlOMfYHlUj6nNa2W
 Fj0BwXUqP6OrH2/7IQVRFLwQ0xzaYXkl8YLUarQNb0/D/saujHAFYraKyJsVd2K6rX5sFBxSk
 qUg8dBezz6CaEw/jTs26n0oh2YbkzkthvOuVekXsd++JfvIZaWKmpbuXwUypqZ6feDhzY9uY6
 ST3T15sGPFuDZzqzpipDeswzOKvjzWwzpEfBeTLM5JgpexwkrWaSGekOYId13Eg/QNHzLYT0E
 ohUyfzKcqsMpW0AJqRR9n7fMR5v3XiifZH9RvYDzwIqiqcQz8rXb/Z6IDBomeaoAa24y+CSOM
 Uw3YixF1UMRONKL/USJBXVaa6/sxLejenNS4C/aBaDqqvByxDx9aJxg2VFklEP43LU4LLa+fJ
 7DaNFpMTZOK/B/54J+5w7Hi7qwsEDxCyniREElwtYj+b3ehNl00zuGwQIxBGfNCc0MaXCf1G4
 BMYZmvF8cRh5jFgfCL/Et42gtHF6DIb3wx+YOHi4/A2/kMPEgzhho3DvlvOo48uTydG0umUf5
 VyxYLZvRXjBQ/4s09+ObgVTwvKthkigUvOOFjMvQzvT4SzZHHRpsFICvr90M90V71PAJrtiYu
 /h4JRTooxhGbgGE+c53G2dLTHESoQDE0M8pM35uvVOEwPGwP7SFTXXq1h5YItSqpGHL4EV+kf
 DeDbl9Ccs8gy6bnD2wFHXk5wdJ/F/kU8PfzsootxmXl7IxpORFm4G1+d48vYoXlTuTo3y7Cu2
 yScKHBOuNVoMpU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Tue, 9 Nov 2021, Ramsay Jones wrote:

> On 08/11/2021 23:59, Johannes Schindelin wrote:
> [snip]
> > I had a look at this and could reproduce... partially. I only managed =
to
> > make it fail every once in a while.
> >
> > Digging deeper, it turns out that the `lstat()` call in
> > `ipc_get_active_state()` does not receive an `st_mode` indicating a
> > socket, but rather a file (in my tests, it was usually 0100644, but
> > sometimes even 0100755).
> >
> > The reason is, of course, that Cygwin _emulates_ Unix sockets. What is=
 in
> > the file system is just a special file, it is marked with the `system`=
 bit
> > (which only exists on Windows), and its contents start with the tell-t=
ale
> > `!<socket>`.
> >
> > And as you might have guessed, there is a race going on between Cygwin
> > writing that file _and_ flipping that `system` bit, and Git trying to
> > access the Unix socket and encountering an unexpected file.
> >
> > Now, why this only happens in your 32-bit setup, I have no idea.
> >
> > In my tests, the following patch works around the issue. Could I ask y=
ou
> > to test it in your environment?
>
> Just FYI, I just tried the patch below (on 64-bit cygwin) and this test
> now works fine for me. (well, run 5 times by hand - not with --stress).

Very good!

I fear that it is a bit late in the -rc cycle to try to get this into the
official v2.34.0. Adam, since you are the maintainer of the Cygwin git
package, would you mind incorporating this patch into Cygwin's version of
Git?

> This is on windows 10 21H1 and cygwin:
>
>   $ uname -a
>   CYGWIN_NT-10.0 satellite 3.3.2(0.341/5/3) 2021-11-08 16:55 x86_64 Cygw=
in
>   $
>
> [Yes, I updated last night!]

Good thing, too: v3.3.2 fixes a critical bug in the pipe code. One symptom
was that you could not use Git Credential Manager Core as credential
helper (because Git thought that the helper had hung up, well before the
helper sent any information).

Ciao,
Dscho

>
> ATB,
> Ramsay Jones
>
> > -- snip --
> > diff --git a/compat/simple-ipc/ipc-unix-socket.c
> > b/compat/simple-ipc/ipc-unix-socket.c
> > index 4e28857a0a..1c591b2adf 100644
> > --- a/compat/simple-ipc/ipc-unix-socket.c
> > +++ b/compat/simple-ipc/ipc-unix-socket.c
> > @@ -36,6 +36,23 @@ enum ipc_active_state ipc_get_active_state(const ch=
ar
> > *path)
> >  	}
> >
> >  	/* also complain if a plain file is in the way */
> > +#ifdef __CYGWIN__
> > +	{
> > +		static const int delay[] =3D { 1, 10, 20, 40, -1 };
> > +		int i;
> > +
> > +		for (i =3D 0; S_ISREG(st.st_mode) && delay[i] > 0; i++) {
> > +			/*
> > +			 * Cygwin might still be in the process of marking the
> > +			 * underlying file as a system file.
> > +			 */
> > +			sleep_millisec(delay[i]);
> > +			if (lstat(path, &st) =3D=3D -1)
> > +				return IPC_STATE__INVALID_PATH;
> > +		}
> > +	}
> > +#endif
> > +
> >  	if ((st.st_mode & S_IFMT) !=3D S_IFSOCK)
> >  		return IPC_STATE__INVALID_PATH;
> >
> > -- snap --
> >
> > FWIW it looks as if the loop might be a bit of an overkill, as I could=
 not
> > get the code to need more than a single one-millisecond sleep, but it'=
s
> > probably safer to just keep the delay loop in place as-is.
> >
> > Ciao,
> > Dscho
> >
>
>
