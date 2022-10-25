Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7E0FA3742
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 09:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiJYJsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 05:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiJYJsG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 05:48:06 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172B5111B99
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 02:48:05 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9so488832pll.7
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 02:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1WI5LjDWB48bwOthOo6jWx6cGlJ9LsH0e1DqeHKdLtM=;
        b=W2Vl2aIo7MqOmF64e6DfO/pIk3Edd3Bq7jkEHgmGu817oMdkcNXQcIX3gngfI/FIkY
         gnY9jOYDOe9ilaONMpZsiVmlwnZ4gjzlINI4Ancr7RocXjsYS+GmsmpHLXFh0/L11Y9H
         FW9hwVFlW+wJdOcJXw2iXITuhR2dxI+ec5bzjq3r9v23qgknGAQLJ1mmIVsqAtYCs6ew
         zGPvVCZmub9MOffRShtMUyC0scvk60LVQfydBY7LrJHfPaj65R3as5f0lg38VTljAJcI
         lCPZSzT2Z/CySAkVP0r2ebFWlg+ClUSxY5XDz24vDXdGJW3iWtDXLfWEnJMqgNXARDw1
         h34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WI5LjDWB48bwOthOo6jWx6cGlJ9LsH0e1DqeHKdLtM=;
        b=1oGmtufBeyqFLTki3+L84Vw//ggv3nO4q7ZUUvTT0nBDumapLOw8rk3tP6O/W5fz8Y
         i2jCZHvS9a/8nqikNeXRG1bqEXO/K0sx3rcyseBkKLEwCkGtQqMcG9w2lPuGePtl4EuD
         o8DOtsS1oGtRt+EcnGamfsQpIFeKDIiN0aaYsH1w14JPa7dDwzIUXoYiYHgq74151jxk
         aGpz9voF22DY2jDlflgN0Ajp6dX3tFaX90L0xLXNjptwM/oCaMLduq43HBRlggNklqrN
         Jo8p+yib8N9ONjEXVYGZJohuKzcr4yErNvdqO0Bk2FFjrrI8A0GT1ACWL6kG5X+Br+qq
         z0bw==
X-Gm-Message-State: ACrzQf3ckq5KS12OlRpEJ4x4PtSQ3BBfoYgEP1AMQkCwXdcEn2ldGxf5
        V+/g1NuWlKQfSGW3l2v2wDbY4uNNTqj9k61TS44=
X-Google-Smtp-Source: AMsMyM4GJzCQmUZ2NNPkB4GPl+3aph01z9AbDBjdbxNU2FTe23tHLl8oHT5CXBKWkkK6aq9hzbDA6aGLVntXg8dG9jc=
X-Received: by 2002:a17:90b:3d8b:b0:20d:3e7f:32d3 with SMTP id
 pq11-20020a17090b3d8b00b0020d3e7f32d3mr42529175pjb.22.1666691284449; Tue, 25
 Oct 2022 02:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <CADUYy5vwfOJOFBQ+zUmkrsxGO=E9N5vUbsVRgjBn_MMY2X6H=A@mail.gmail.com>
 <Y1XcQctK/SkDZCbt@tapette.crustytoothpaste.net>
In-Reply-To: <Y1XcQctK/SkDZCbt@tapette.crustytoothpaste.net>
From:   shubham sharma <shubhamsharma4060@gmail.com>
Date:   Tue, 25 Oct 2022 15:17:28 +0530
Message-ID: <CADUYy5sv-rc-hRB9xV2uK05k+S2G7AADiA9w6iD8pzoYMPQqGw@mail.gmail.com>
Subject: Re: waitpid errors with shell aliases
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        shubham sharma <shubhamsharma4060@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

/bin/sh -> GNU bash, version 5.1.4(1)-release (x86_64-pc-linux-gnu)
OS -> Arch Linux
Kernel: Linux 5.4.86-1-lts
Architecture: x86-64
git -> git version 2.30.0

Thanks,
Shubham

On Mon, Oct 24, 2022 at 5:58 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2022-10-21 at 09:26:11, shubham sharma wrote:
> > Hi,
> >
> > I am using git shell aliases in config and was facing some weird
> > error. The error is not reproducible in all runs and occurs randomly
> > between runs...consider the minimal config(alias section) below for
> > usage idea:
> >
> > [alias]
> >     A = "!f(){ \
> >         ( \
> >               // implementation
> >               git \"$1\"; \
> >         ) 250<dir/tmp; \
> >     }; f"
> >     B = "!f(){ \
> >         ssh <server> <command>; \
> >     }; f"
> >     C= "!f(){ \
> >         git A B; \
> >     }; f"
> >
> > when firing "git C" from shell,in some cases(not deterministically reproducible)
> > i observed weird waitpid errors of the type :
> >
> > error: waitpid for f(){         ssh <server> <command>;    }; f
> > failed: No child processes
> > fatal: while expanding alias 'B': 'f(){       ssh <server> <command>;
> >      }; f': No child processes
> > error: waitpid for f(){     (//implementation; git "$1"; )250<dir/tmp;
> >    }; f failed: No child processes
> > fatal: while expanding alias 'A': 'f(){        (//implementation; git
> > "$1"; )250<dir/tmp;      }; f': No child processes
> > error: waitpid for f(){    git A B;    }; f failed: No child processes
> > fatal: while expanding alias 'C': 'f(){       git A B;      }; f': No
> > child processes
> >
> > can anyone please help as to what could possibly be the reason for this?
>
> Could you tell us what OS and version of Git you're running, and what
> shell /bin/sh is?  I could imagine that there might be some weirdness on
> Windows with the shell, but I would find an ECHILD to be surprising on
> Unix.
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
