Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98404C4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 18:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA6F206C3
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 18:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvhcx8t8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgCVSdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 14:33:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42425 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgCVSdc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 14:33:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id b21so13762327edy.9
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ol5YyBSYiKMDeBLguvuYkhY6nKWKng2urwL1sH/mOBE=;
        b=Cvhcx8t87ayTbtaObmwTbpQ4Q6MlzoysyqM9NwNFc4fFw19y7VWTBVkhAFECJrqnBR
         kOxoUwysDuscrRvyD2H8DkxiLI0HaC89NJjXrdGkeM9d2S/2ObKjj9k9N2RwB5Vv1CRh
         HI0GwtMJk3uEhBlNh3RzKmp9SlhY7UJh9FLhCtsGBEQH/GE3VSdgmq2xYMjEFboBmxPO
         SbQFfooG8mCYQcgFE9w8XkFg25Tj2QSuQeEiHwY2/uCEmQavhUOj5LgH7SdYjkIwQlGY
         JuRlC8vbKbxii/hNxjE0/3cZBjiaqLQKuQj++fwg+l/EZJjWZqNBA/ocvjbSXKdueFhv
         ZLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ol5YyBSYiKMDeBLguvuYkhY6nKWKng2urwL1sH/mOBE=;
        b=ORCfNTUUxy2yx+RvjUiiVS61ACD9HidYgbSsQLMq87n8qXniy/7MmSM47qrFnVCy8e
         n3Nq+9qJ7nSPRRL7KJqpvb0N9emKD1aKn5BGUrRIvYOAhVB4BIHb0q+pDKQAvBnITbTx
         /n1a57NKZbD18i6LTBu4roF/1n7chWSMdIbEJmvCbuYJv45toqeSy7nJTTV7g5s+f6Qc
         LVC53Hhe6usXT6uT3ZoZNe5eY85p1Wut4zWwwilfw+cxp0JNC+9f2nWs0PIIfrsuY1El
         TW0J48+/Z5S+gLMjf4LdI1bXNV3mq24zK21VIaLzxlsBTZeFNaWduDX+zWCs2iy/4GST
         HyLQ==
X-Gm-Message-State: ANhLgQ1fI+zwSdNB46x+ntGxvRM7zhr4ru/5uEkfd/LGodNm/tfYfs82
        AOueVAPVelJE4GJMtRjGpyM9tSpBZEOWI9MQ+ns=
X-Google-Smtp-Source: ADFU+vt9SXFP6UIOa9NuZi0WZ1XQxc5ftNQnU1rZhVAGCuPHkQqWRsj6pEQlIguEIFApIlV9xLDS3pWCana40LS7+38=
X-Received: by 2002:a05:6402:2214:: with SMTP id cq20mr3657625edb.16.1584902011017;
 Sun, 22 Mar 2020 11:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <CANPdQv+tCnfy_csM8EwuqAYBtgkJ3RhRvo+ALbzO=BcZA7qJtg@mail.gmail.com>
 <20200322073105.zh2tqycu2fgydf3e@tb-raspi4> <CANPdQvK4LRZ2b_K0QuWErxNcc2wpW0W4zvmj3HzKDnOvgBNHfw@mail.gmail.com>
 <20200322165915.GA6499@camp.crustytoothpaste.net> <20200322180730.57pe4awhglmmlxpm@tb-raspi4>
In-Reply-To: <20200322180730.57pe4awhglmmlxpm@tb-raspi4>
From:   =?UTF-8?Q?Andr=C3=A1s_Kucsma?= <andras.kucsma@gmail.com>
Date:   Sun, 22 Mar 2020 19:33:19 +0100
Message-ID: <CANPdQvLQ4WFKmK+_Vys4EeBsRaFR+CcCJs_ARQX=JPzPLjxsWw@mail.gmail.com>
Subject: Re: GIT_ASKPASS absolute path detection bug on Windows
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 7:07 PM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
> On Sun, Mar 22, 2020 at 04:59:15PM +0000, brian m. carlson wrote:
> > This function (locate_in_PATH) specifically says it is not to be used o=
n
> > Windows because it doesn't work properly there due to file extensions.
>
> My reading is, that it dows work if you specify "foo.exe", "foo.bat".
> And when you specify "foo" it may use "foo.exe", but there may be
> a shell script called "foo".
> But I may be wrong.

Other than the extension appending, I believe the other difference is
that on native Windows the PATH separator is ';' (semi-colon). In
cygwin and mingw, PATH is translated to use ':' (colon).

>
> > I'm pretty sure a proper solution would involve touching that as well,
> > although your solution does indeed fix the issue you reported.  That
> > function also uses a colon-separated PATH, which I'm not sure will work
> > in all cases on Windows (although maybe it will).
> >
> > From looking at this earlier, I think the problem here is that we're
> > trying to use the Unix codepaths (on Cygwin) and then expecting those t=
o
> > handle Windows-style paths, which they aren't intended to do.  This is
> > likely one of many problems on Cygwin.
>
> Yes and no.
> C:/MyTool.BAT is a valid Windows file name even under Windows.
> Cygwin preferres /cygdrive/cMyTool.BAT
> Git under Cygwin should handle C:/MyTool.BAT correctly, and to my
> understanding it does.
>

Indeed, the Cygwin shell tools recognize C:/Users style and even
C:\\Users style paths as well.


Looking at the code a bit more, I feel like git is only supposed to
work within a Unix compatibility layer (like Cygwin or Mingw shell) on
Windows. Beside the PATH and directory separator characters, the code
makes other Unix like assumptions, for example that /bin/sh (a.k.a.
SHELL_PATH), or /dev/null exists. If native Windows support is a goal,
I'm happy to help a bit to improve the situation, but I wouldn't want
to swim against the current. Note that other than this GIT_ASKPASS
related edge case, cygwin built git has been working in this
environment for me.
