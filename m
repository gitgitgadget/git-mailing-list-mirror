Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162EFC11D00
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 01:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF02208CD
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 01:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="IQYTXxiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgBUBVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:21:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45413 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbgBUBVC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 20:21:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id g3so145676wrs.12
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 17:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=skuE2ydpBsC5NAMLJ8MYVboKPgeUc0K8dkthfSvar0M=;
        b=IQYTXxiWVGHa0y+DLjdf9EjuW/4/jHsLtanc8ypkGMDNnVRUwyxFivQlIJm5/2XXGE
         GunWmYeVcQs7yEdixfUmuAtteB1ea4+l6E1iFhsl2PonXJ4A2f71/t3vp6DJFxgwZAFi
         X8E7ZWyJeKyKZL7kxaWYGARWkEP3qx7W0uzMsTmK2OmnF5NQvd8u1CfVtBnpKm1iowjk
         us55V1nhW//xA2NTTQDLBkZwkUE9VXJp3S12H39VNxacZ0dB6Frysvn3BuA3b9dM8CoP
         4bBf7ZHlc6SLBscBIPH6gcCEOGRXMbIHxPYUCMe5QeYN08rqiHEn6B4n4GGnwueoDqXl
         eBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=skuE2ydpBsC5NAMLJ8MYVboKPgeUc0K8dkthfSvar0M=;
        b=rqKUAPcC/9jFaK349oxHlYixVzoDc6Y6zC33TvhfiHnKT5pDEsCshRQmVU03A4hJQl
         jFGVLyEl1q9BDDN2aITkRKX7+RhGh2mmZm7Quyrui7Pm/kws2FMsoIBt3Vpb8a2F3nmD
         aYlWL8M36BbHyAcIbXoWw40ZczrcBs8fqLG913LPd40ExuaQOdfnOqWj9q73tr9jGiW2
         /TLzQz6XUXOYLUD7Ldb5qkx+lmfVBjIUDrwc+p6haQKfRQdufigBJwDEaACB6CO0Dsuc
         QKVQounxSbecyLAXsSNUynlrxPpYX78P5slF3jOxGVSdJn20+ijgaQTMBeLjffKB0xlh
         bK0Q==
X-Gm-Message-State: APjAAAXpnZ2wWEd3bCAf+b9HLhgdZpKSnJRAr3JX/S9HYqZncJinLdcY
        MxxCTBrQ6RRuM+iIiCafAw7VGXyc+hIOpPyGnbbEayx8
X-Google-Smtp-Source: APXvYqxyjfHYUHxqQoCCpknL3judTkFKy2lfBGM2kAmKeCXonNiYlVxg/i4xlbujVxw8HeFXuNBs5rHWP3u9VcitNzI=
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr44339957wrw.126.1582248059980;
 Thu, 20 Feb 2020 17:20:59 -0800 (PST)
MIME-Version: 1.0
References: <CA+dzEB=jJEkuvcX5qDfeXS=mbJu_m=-yUsmHd_KrKAXC3YDe7w@mail.gmail.com>
 <20200221000141.GA6462@camp.crustytoothpaste.net> <CA+dzEBkP==U7iS=6vS4=g7LYwh_cKzqbPApDraiYv7tiwPOVHA@mail.gmail.com>
 <20200221011138.GB6462@camp.crustytoothpaste.net>
In-Reply-To: <20200221011138.GB6462@camp.crustytoothpaste.net>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Thu, 20 Feb 2020 17:20:51 -0800
Message-ID: <CA+dzEBk5D9x=sQnKDwAPHXOS_8gnA37X9sn+ccpfViEauiC5ww@mail.gmail.com>
Subject: Re: git does not wait on hook exes (^C)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 5:11 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-02-21 at 00:12:18, Anthony Sottile wrote:
> > On Thu, Feb 20, 2020 at 4:01 PM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > > I believe the way that SIGINT works on a terminal is that it sends the
> > > signal to all processes in the foreground process group.  So my guess of
> > > what's happening here is that Git and your script both get SIGINT, Git
> > > cleans up and exits quickly, leaving your script running.
> > >
> > > If so, I'm not sure that Git can do much here.  If Git waited for the
> > > hook to exit, then a broken or hung hook would cause Git to hang
> > > indefinitely, which is not what the user intended when they pressed
> > > Ctrl-C.  Usually what the user wants is an immediate return to the
> > > terminal in such a case, and I think most users would consider it a bug
> > > if Git were to wait for its children.
> >
> > Taking git out of the situation:
> >
> > Create a shell script:
> >
> > ```bash
> > #!/usr/bin/env bash
> > .git/hooks/pre-commit
> > ```
> >
> > ```console
> > $ ./t.sh
> > zzz part 1
> > ^Czzz part 2
> > exiting
> > $
> > ```
> >
> > that works fine (and is the expected case for `subprocess` calls for
> > example in python)
>
> Yeah, I think this is the case I was discussing up above, where the
> parent process waits for the subprocess to exit.  If I modify the foo
> function in your hook to also have a "sleep 10", then the parent process
> hangs until the child process exits, which again would mean that Git
> would hang indefinitely if the hook hung.
>
> Can you maybe tell us a little more about your use case?  What are you
> doing in your hook that makes this case come up?  Why is your hook
> trapping SIGINT?
> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204

My hook in question is a python process: https://pre-commit.com

It doesn't really do all that much on SIGINT but prints "(^C)
Interrupted" and offers a crash log when receiving ^C -- this races
with the git process terminating and causes terminal spew (sometimes
with pretty bad consequences with input breaking until `reset`
depending on which thing wins the tty reset race).

Anthony
