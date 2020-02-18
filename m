Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4048FC34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 11:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002502173E
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 11:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5JZyw33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgBRLZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 06:25:39 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:40494 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgBRLZi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 06:25:38 -0500
Received: by mail-ed1-f46.google.com with SMTP id p3so24400243edx.7
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 03:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n+WxOKHPr/YLIi5W84iIkoalP4Mj/LiktfxDeKLF8dM=;
        b=Y5JZyw33Ky8nRRdZaGxq6W3GKNMOIKl7vNthHbWMQgRLUQfGIZakIEIYisWElfWpCt
         2YTzjY4Ti0oH3ct/bKd9718rhEQvdvzGNMya6wgS0+IpLse39MbieT131w61N1DEr88i
         TyLY+zNZSSi7Q4KGIG22JGS5AiNsWbTOCQhkt09avzhhJ9/WTWDAxSQdg7mhe+eoPxvX
         GjjII4tKgWc5dvL8ftxkld0nRjSEsBMCujic8jmtq2VZGrIkwKRvuD6bhbxyj+VmFcSw
         m4Wim3tzmjSiAFp3GBKo4g23/gvcPT9jsB3cHiHZBeKBJL7j+TLE6XK5Fsyi5/ajeWYV
         WTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n+WxOKHPr/YLIi5W84iIkoalP4Mj/LiktfxDeKLF8dM=;
        b=d6ioIpZ1UrH+mpZqH/dWpd/Xz5Tfs/fR/pgKP9EbeVIOxloO/DL4y29ptfFcbPUMOQ
         VZxpzhAy2w9EogW0+XM7h1FOECnCFEt0/rv+FgMKpvKKqXKdJxDJNNCiOQqcpIaT71pK
         0FGNDYg93/erYdcqF22pssZ2JKz6hrba0xrHZvMvZ5uXjNVRcBSkA0fT3u6VHBgBJSVG
         MXFpyXCijnbuUxNNqxsti2+34AmHTP3lqEQk35h0tvDNbDK86NP7z4bQ84OKGnxHgv4v
         6uzDjpNp+xOvANuJ2DDFID0lUetfFAvREwLu8lrG+FK/+Cfg4vca25pgMpI9cGu5eckz
         wQNQ==
X-Gm-Message-State: APjAAAUQWb7kX6XD90/J7+Ly4ZphBKLRxjrBAlRDyWRFuJA4rCYj9IcM
        6kvCwAIV6plao28NeNuuRlnvqRYSI7wXVAsqrqrPEtpv
X-Google-Smtp-Source: APXvYqzGwdMtvwKCcZrD5+ps0LpBE4zaNggsata0d4/RhfmOcaoMaTYy4SIqWNY3Ef9f1hDCkzf3T7NRNqAkgLjQbN0=
X-Received: by 2002:a17:906:a444:: with SMTP id cb4mr19015862ejb.42.1582025136451;
 Tue, 18 Feb 2020 03:25:36 -0800 (PST)
MIME-Version: 1.0
References: <CABVXwf6q1xMFhw+xd5f8GKATwC9k8mrXUkykpGgvTj7hv9pwEw@mail.gmail.com>
 <4d17a541-3c5c-0cf3-6ea6-11c214aa4674@web.de>
In-Reply-To: <4d17a541-3c5c-0cf3-6ea6-11c214aa4674@web.de>
From:   Manish Devgan <manish.nsit8@gmail.com>
Date:   Tue, 18 Feb 2020 16:55:26 +0530
Message-ID: <CABVXwf404m9FdsoLxYxZriYT6uif_fsMs8B4dY4RmeQojqK9Wg@mail.gmail.com>
Subject: Re: Bug: Git: Clone: University Network: No Output on Terminal
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 1:08 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 17.02.20 um 09:02 schrieb Manish Devgan:
> > Hello,
> >
> > I am a university student from India and I was trying to clone the
> > xfwm4 git repository from the git-url :
> > https://git.xfce.org/xfce/xfwm4
> > I was trying to clone this repository over my university network and
> > it didn't work. I worked my way around by using my mobile
> > wireless-hotspot for the same and was able to do it just fine.
> > The next day I tried doing the exact same thing since I couldn't get
> > an answer from our university if any such firewall was blocking me
> > from cloning it. But this time instead of failing to reach the url the
> > command ran with the following output:
> >
> > gabru-md@bhaalu:~/Desktop$ git clone https://git.xfce.org/xfce/xfwm4
> > Cloning into 'xfwm4'...
> >
> > after waiting for a few minutes the command didn't fail but it didn't
> > show any output/stats like it does when I try to clone a repository
> > from Github which is definitely not blocked on the university network.
> > for eg.
>
> That doesn't sound ideal, but it also doesn't necessarily have to be a
> bug in the sense that git clone broke at some point.  It could be caused
> by the server side as well.
>
> What you see here is the default output of the so-called dumb HTTP
> transport.  AFAUI it doesn't show any progress (yet?).  You can get some
> kind of progress messages by dialing up the verbosity way up with
> repeated -v or --verbose options.  E.g.:

Thanks I will make sure to use the -vvv option next time.

>
>    $ git clone -vvv https://git.xfce.org/xfce/xfwm4
>    Cloning into 'xfwm4'...
>    got 9a2556cfeedcc1b73cea36e5045073ecdf9fd39a
>    walk 9a2556cfeedcc1b73cea36e5045073ecdf9fd39a
>    Getting alternates list for https://git.xfce.org/xfce/xfwm4
>    Getting pack list for https://git.xfce.org/xfce/xfwm4
>    got 72b002b0f028fe610ba22035453647001e886969
>    Getting index for pack 3a53ad6629b13fd830436a47c59b86e29b565d88
>    got 600cb96c7eed28529fc8d5d0383d58070cb30957
>    Getting index for pack 9ef7bd53f4441a79be936132e1c4cde62f6fd9a8
>    Getting index for pack cef42fa75f4badc8e7ece5fee5ff8068dc8ae51b
>    [...]

I tried it this way and it worked just like you've mentioned.

>
> > gabru-md@bhaalu:~/Desktop$ git clone https://github.com/gabru-md/stl-cp=
p
> > Cloning into 'stl-cpp'...
> > remote: Enumerating objects: 186, done.
> > remote: Counting objects: 100% (186/186), done.
> > remote: Compressing objects: 100% (128/128), done.
> > remote: Total 186 (delta 92), reused 146 (delta 56), pack-reused 0
> > Receiving objects: 100% (186/186), 105.58 KiB | 256.00 KiB/s, done.
> > Resolving deltas: 100% (92/92), done.
>
> This is the so-called smart HTTP transport at work, which does support
> progress output.
>
> You could use the git protocol to clone xfwm4:
>
>    $ git clone git://git.xfce.org/xfce/xfwm4
>    Cloning into 'xfwm4'...
>    remote: Counting objects: 66501, done.
>    remote: Compressing objects: 100% (16901/16901), done.
>    [...]

The problem is that my university has blocked git protocol and hence I
cannot access it to clone the repository.
Moreover cloning and pushing over ssh are also blocked which is really
bad. The only way to get work done is to use HTTP. :(

>
> > Furthermore the interesting thing is that I expected that my attempt
> > at cloning the xfwm4 repository might have failed but it surprisingly
> > did not. The command did clone the xfwm4 repository for me but it
> > didn't print out any stats/output during that time.
> >
> > After searching on DuckDuckGo I saw that adding flags `--verbose
> > --progress` will allow me to achieve the desired functionality. I
> > tried doing the same and the output is given below.
> >
> > gabru-md@bhaalu:~/Desktop/test$ git clone --progress --verbose
> > https://git.xfce.org/xfce/xfwm4
> > Cloning into 'xfwm4'...
> > gabru-md@bhaalu:~/Desktop/test$ ls
> > xfwm4
> > gabru-md@bhaalu:~/Desktop/test$ cd xfwm4/
> > gabru-md@bhaalu:~/Desktop/test/xfwm4$ cd icons/
> > gabru-md@bhaalu:~/Desktop/test/xfwm4/icons$ ls
> > 22x22  48x48  Makefile.am  scalable
> >
> > It is evident that the cloning worked perfectly fine but there didn't
> > seem to be any output on the terminal. At first I was convinced that
> > it was network error because it couldn't reach the target url but now
> > it doesn't seem to be a network problem.
> >
> > I am not quite sure if this unfamiliar behavior while cloning a
> > repository is a bug or not hence I thought of reporting it. Also,
> > Apologies if this is not a bug but something which is known already.
> >
> > I am currently running git version 2.17.1 on my Xubuntu.
>
> Git 2.25.1 shows the same behavior.
>
> I guess the reason the dumb HTTP transport doesn't show any progress is
> that there is no way to know how much data it needs to download, so it
> can't calculate a percentage of work done.  Perhaps showing a number
> that is incremented with each GET request or a spinning wheel or so
> could reassure users that git clone is still working?
>
> Ren=C3=A9
>

Yes. Having some sort of assurance that the clone command has not
failed would definitely be great.
The -vvv option puts out a great deal of stuff on my terminal which is
a sort of assurance that the command is working but it seems to print
huge loads of text which definitely does not make any sense to me at
least. I'd be more happy to see as you mentioned, a number or perhaps
a spinning wheel
which denotes that the command is working.

Thanks & Regards
Manish Devgan
