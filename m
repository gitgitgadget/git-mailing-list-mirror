Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B068FC7619A
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 09:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjC0JRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 05:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjC0JRm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 05:17:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BA63C26
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 02:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679908654; i=johannes.schindelin@gmx.de;
        bh=S7NEhjTZ9rZU9JmyfP0LiTWH/5esVuR1aMz3/Vq6zNg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=re5+WXnJcvDJjldv9LxHpe+oxFiNiMd9wm0kG+HJ+k48Xji/JdoOkzdqTbKtAq1Kj
         2Q4ETeOLoU3jC62QJdnKfDcBwSP66QzTNzTURZHqWp8+TyPsTyrrM00mKxzUpiJOah
         r0aGYO98434M6hMGb04Yk7XDmG/dN9W6HY20qBrZBV1QHmI8GtzF7m49CudXKLnVkp
         cZkh+jt0hdOvfdgy+kTvzL77nK2wlKPww06gNFr9ayWt0FLOWPXyHiW9qosvEc0wlz
         oNw10RgL6iJpuJojTEMwVkx+CDzSpelRZ7I4/pcNsBuRvrAtmycN59EWQs4BN92lJM
         1ovzVTuAqosgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4axq-1piMsC2cMg-001ieD; Mon, 27
 Mar 2023 11:17:34 +0200
Date:   Mon, 27 Mar 2023 11:17:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Paul Mackerras <paulus@ozlabs.org>,
        Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH 0/2] gitk: handle long command-lines
In-Reply-To: <pull.1469.git.1674559397.gitgitgadget@gmail.com>
Message-ID: <af2111f8-2669-b952-6c4e-45ee0330ec14@gmx.de>
References: <pull.1469.git.1674559397.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:w/gARIg32RVUJxxZyWM/scs2eCYBGSAKZfFNSdowWCdbsiOlS1I
 JwCmWO2VP9RXHaMSsuo3Z3oDSRbNX3utZnrlLMtwJaPSu2W/ayLONiNdM3qLqe9s5n4Jvp4
 W75wh9fhrKTH9eSJZ5fk3AS+nAB0Yk82LTiz1ZgC0Fr1j4GU31ckKyM9DZkd7WFVVA0yDiC
 bZgMna+FaxTNgeBJsLstA==
UI-OutboundReport: notjunk:1;M01:P0:tdUSCFU3BEY=;gO9Sul8Aw0xd0MH8BMHJqRhUE6J
 K6ZCph1JouK+DJaZGYhwm6u4oWrjXYp6rDRMkzp6GibfNtp6auk6sZV93tTFWWYJRwfKMijMh
 0yqWAJSNUAF7YhsMtZtAiiuHeGfWtwnF0zEWPdRwNoc8+gXkyVZRVGSRybbgdJG1Ql4CNTdLi
 VeU0Y9TT5M5ro2m1lCrx5QFM8D+FvDrJ0TIKwnSkxN1Yolwv+6pjISbdbuaeipNImzKODxWn6
 /q22/oDpOfy6tQEO7q61pzbnVmEmFEh07KrzAGsGTKG32MXRWbdokbzZ9A+NqnYVhvNdtbYb1
 do8+K64I6WZHTywcbxr1wZhJ5ELZSdryKCJbTD5k5kuRWzT9n2jVOvre4093c1BbD7gqEsa8P
 vfceSbstIizP/+zArt6rDETjIKlwZlLJBp9uEW+k/HdsNoRM0X/00zh/x0EkbVGFebS8x2mkT
 0LqYsaybQ5kXeYQUs8k98uFoo7yH8RtIgFeURWiQCaiD8VIIy8ZxvVZG9N4M/shRR+pdmm+l8
 92PCx3kyztE46k1WgeQOZ0gWB9fBjokdAktEUrr5ysOSjfCrDEwNErX83qyLNgEvVfLAYoRmc
 U5TLib8iwKsKJSikYcvGquYeOJcwJNxVMdz2GyGdAPUYvK8Ufp17oy1aclM0r+B8NOR6digFK
 ktB8gBFICRkfNuMCCCp0WXoGSFlRRCD6EOb3hcArjDQlNbBOfwIWgiJZJ3FFdNHK8/9D+ZScz
 uhgB5dr6P2lg8b4l5Qnj9K3JpxJ+KKA2MRhfmEYXgIK935mo1cVNjAwMMYfCOuhFJ78k40xhC
 6JmMZAbZMd9h01e2+gq/5C6aJCLsWLCBeLR3DB32jk3M+C1bQQXFTRUvVAC/92uVcU81jmCf9
 CR8cvET1DRLWJkpDNrIdZV1D1p6Zpv6ShbJw5BxHpHHZ0YIsyH6l4hLg+XHOmfVpQzLrAGpuh
 GVB8YEcU+1SniD8R1/8vgrOE47Y=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pau & Junio,

this patch series saw a positive review from Junio (thank you! I know that
you try to stay away from Tcl code, so I appreciate the effort very much),
but apart from that it simply languished on the mailing list for more than
two months now.

Paul, is there anything I can do to help you integrate this into `gitk`?
Or is it time to pass over `gitk` maintenance to the Git project?

Ciao,
Johannes

On Tue, 24 Jan 2023, Johannes Schindelin via GitGitGadget wrote:

> These patches have been cooking for such a long time in Git for Windows =
that
> you might think they turned into broth. Yummy broth, to be sure. But bro=
th.
> 'Tis beyond time for the patches to make it upstream.
>
> Johannes Schindelin (1):
>   gitk: prevent overly long command lines
>
> Nico Rieck (1):
>   gitk: escape file paths before piping to git log
>
>  gitk | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
>
>
> base-commit: 465f03869ae11acd04abfa1b83c67879c867410c
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1469%2=
Fdscho%2Fgitk-long-cmdline-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1469/dsch=
o/gitk-long-cmdline-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1469
> --
> gitgitgadget
>
