Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE1FC3F2C0
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 21:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9B1246A3
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 21:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fp3Pj0VV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgB0VYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:24:10 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:43125 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgB0VYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 16:24:09 -0500
Received: by mail-oi1-f181.google.com with SMTP id p125so702773oif.10
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 13:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=O0mOyAR4VXhxUG2ap6yJLSXBrnMa+U56fezGlkTdGGw=;
        b=fp3Pj0VVXSHS58VC8WQSvKUfNL+XbwK3lbEcHD0poTe7ep5rffJOpOhTdiRtKuELcR
         JJATzt9QRYavbzPnhGxsMZDIxal4mAKE7wLsqGKOxQGp7JrFcylSVq0b2sfrHwZj0zd0
         TPdbqgYe+tLMezOyIAfsVwAo3ais4L6VQXJa7ytNA6lgPa22yAjsxXSodD/nJ4gVeOK9
         +IjQePiWviVTDHDAIIMAgU4cvH+Pa5R7DVx6FTO7Bzw9VZKIXsLVm9GYfiYGDbOT4+Um
         30HjhFt1W3ZcUVbEPk+/qcJ6kAEnlLIABgWTSW20fd86pX074NLTkaoPR0DuujtWaz8o
         0/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=O0mOyAR4VXhxUG2ap6yJLSXBrnMa+U56fezGlkTdGGw=;
        b=KE4GjaDSLzinuNxts+o5AbzwQMwv26wasmPlkle/6LI79isA10UDUYed34xwY674bW
         J6i0LD8/CuFt+a/GMUGZyFS+NpaDEy2QbuC0bqwxGncm3n+VGqouZR5OFNm6IuF2zCsY
         jdCnA5PPWJC5HE27zDOZCIrMw6lFWMpeTrbut5EYAuukRgpXqOrYxbHp6hZoCEq8DyIR
         TmFycytgA4QDi1qZLk1m21/8g11uY+UTVFT/Rv9u/AzK7DpKazLQ6r4W43j3o1NivQ0L
         rz5dr2xKrbJvk1Forkuo2m+PNVMWfxcwIQQJmC2+V81YeqBPBFV6CgzcJWgYdsYvhvcz
         8LZQ==
X-Gm-Message-State: APjAAAX2PfRaBQx8ep4pLTJHAsIw6uPHe1llspBpTIgrET32JfbPniFK
        2Kd95jC4RvqcL2kn6WXW8k97NZiC
X-Google-Smtp-Source: APXvYqwyOSPnH7TSBV9B0T3oSgOdjnX6qs/VktYRhbP/+xya9KxKYN1AfPV4OXDRc1iF5seVcBKlcg==
X-Received: by 2002:a54:4091:: with SMTP id i17mr794512oii.99.1582838648373;
        Thu, 27 Feb 2020 13:24:08 -0800 (PST)
Received: from LJZDELLPC (108-251-140-47.lightspeed.frokca.sbcglobal.net. [108.251.140.47])
        by smtp.gmail.com with ESMTPSA id x15sm2342882otq.30.2020.02.27.13.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 13:24:07 -0800 (PST)
From:   <lyle.ziegelmiller@gmail.com>
To:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Jeff King'" <peff@peff.net>
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
References: <000001d5e4e3$91ffb0a0$b5ff11e0$@gmail.com> <20200216211604.GE6134@camp.crustytoothpaste.net> <20200218051956.GA1641086@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2002272204150.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2002272204150.46@tvgsbejvaqbjf.bet>
Subject: RE: ! [remote rejected] master -> master (unpacker error)
Date:   Thu, 27 Feb 2020 13:24:04 -0800
Message-ID: <004201d5edb4$3dc34040$b949c0c0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMhw4Eo4Ohz4QZPcWFj6oDqlRz55AI5bVuwAeDSbLQCirKjlaViuU3Q
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

" But I vividly remember that there used to be a problem even with
`git.exe`, probably still is a problem on older Windows versions. That might
be the problem here?"

I'm using the latest version of Windows 10 and Cygwin's version of git -
version 2.21.0. This is being executed in a Cygwin window, not a DOS
terminal.

All of this stuff used to work.

Regards

Lyle

-----Original Message-----
From: Johannes Schindelin <Johannes.Schindelin@gmx.de> 
Sent: Thursday, February 27, 2020 1:05 PM
To: Jeff King <peff@peff.net>
Cc: brian m. carlson <sandals@crustytoothpaste.net>;
lyle.ziegelmiller@gmail.com; git@vger.kernel.org
Subject: Re: ! [remote rejected] master -> master (unpacker error)

Hi Peff,

On Tue, 18 Feb 2020, Jeff King wrote:

> On Sun, Feb 16, 2020 at 09:16:04PM +0000, brian m. carlson wrote:
>
> > On 2020-02-16 at 16:10:12, lyle.ziegelmiller@gmail.com wrote:
> > >
> > > Any updates on this error I emailed a while back?
> > >
> > > lylez@LJZ-DELLPC ~/python
> > > $ git push
> > > Enumerating objects: 5, done.
> > > Counting objects: 100% (5/5), done.
> > > Delta compression using up to 4 threads Compressing objects: 100% 
> > > (2/2), done.
> > > Writing objects: 100% (3/3), 279 bytes | 23.00 KiB/s, done.
> > > Total 3 (delta 1), reused 0 (delta 0)
> > > remote: fatal: not a git repository: '.'
> >
> > This error is telling you that Git doesn't think the remote location 
> > is a Git repository.  It could be because it really isn't one, or it 
> > could be that the permissions are wrong.
> >
> > It could also be that the repository is mostly there but very 
> > slightly corrupt and therefore can't be detected as one.  For 
> > example, it could be missing its HEAD reference.
>
> I think it's more subtle than that, though. If it wasn't a git 
> repository at all, then receive-pack would fail to start, and you'd 
> get something like this:
>
>   $ git push /foo/bar
>   fatal: '/foo/bar' does not appear to be a git repository
>   fatal: Could not read from remote repository.
>
>   Please make sure you have the correct access rights
>   and the repository exists.
>
> The output above, plus the:
>
>   error: remote unpack failed: unpack-objects abnormal exit
>
> makes it looks like receive-pack started just fine, but something 
> about the way it set up the environment made the child unpack-objects 
> unhappy when it tried to initialize its internal repo variables.
>
> I have no clue what that "something" is, though. Windows and UNC paths 
> were mentioned elsewhere, which seem plausible. It mentions ".", so 
> presumably we've chdir()'d into the receiving repository and set 
> $GIT_DIR. Which I'd think rules out any weird interpretations of UNC 
> paths in $GIT_DIR.

I thought that I remembered that it is not possible to `chdir()` into a UNC
path. And it would seem that `cmd.exe` still cannot have a UNC path as a
current directory.

But PowerShell can, and so does `git.exe`, apparently (I tested this using
`wsl bash -lc "cd ~ && git.exe -C . version"`).

But I vividly remember that there used to be a problem even with `git.exe`,
probably still is a problem on older Windows versions. That might be the
problem here?

Ciao,
Dscho

> I'd expect that error if we did a chdir() internally to some other 
> path after setting up $GIT_DIR, but I don't know why we'd do that (I 
> thought at first that the quarantine code in receive-pack might be 
> related, but we don't ever chdir() into the quarantine dir; we just 
> set up GIT_OBJECT_DIRECTORY).
>
> -Peff
>

