Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1187CC433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 14:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921912071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 14:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=calebgray.com header.i=@calebgray.com header.b="ZR6fQN9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390831AbgEYOCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 10:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388862AbgEYOCi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 10:02:38 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C690CC061A0E
        for <git@vger.kernel.org>; Mon, 25 May 2020 07:02:33 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id j127so4263663vke.4
        for <git@vger.kernel.org>; Mon, 25 May 2020 07:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=calebgray.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nWZiZv3U2E98Cqq5qsKdrh+BoYpy/ueMq/vjc9eRcj8=;
        b=ZR6fQN9CRoykpfkKpBwtfdsmUixBXuEJZvvjiT3rHUP3ipw+ZQj12qMptftOa5IzZ7
         VB31c1GE840yXgqXFc/5IhdOBDFwRsFY1qfh+kUVoXXjXmAXnb53Bo57wDAiUc6SFgpq
         Dsi2DUNX459KqWWbD5svrtPFOGAJcHrXnUaIYwfpsIESoSzfR3MzVsnolQITVO+YQzEB
         9r2wWci/DZxXqG2IUM9GBBSF0OhtM0yHssgV22OsgacVSgy3FA872fjyzXmCDqPDJ4ft
         9cT3z930Gnic7fy+Z0X+Mn9GGxCLZFakMfrEUeEQh+5hF/31VSnHi4qc/7tUQ8NxkPjS
         Zx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nWZiZv3U2E98Cqq5qsKdrh+BoYpy/ueMq/vjc9eRcj8=;
        b=KuFpu8pH3LtayzymhZ36g6kn+WxgWU8HJ4HQ42QZ2h/iQ0v+mvQs59NC+Mgfs0+ZQH
         vL/IsPEo9YouZf0cD4VvIJu8hILAHCDrpRsbZsXpTFFbdGTIuGUZMQJ8XvxlDX7IPiMa
         3HHpfmZJqG2XkZx+HqHui/XMhYBFi/+EDcAscTZ4BS7C9CNIqExCnAbt1avRPtyqOLfB
         nHaK/t+wm9I7VLWqt81y73P4RVzejIsF8TIYiHrynaGIq8H4GE3U5WZn/yV2iu6U1j3X
         NGyPT7PYiJkTTPZyRCz/iERLWjq6ge7zpze178HYIngrkPGtVhJp4AyaXj/4iANBYvHx
         VNuw==
X-Gm-Message-State: AOAM5302BuEN//p7i74rqodM+e00rXTbSdnFwAWQ0Ma5PKUTAyIwhjxZ
        9SmGf9d1pCn+5yUdLHigdwYq0AlRjW7NRBWbvziCqQ==
X-Google-Smtp-Source: ABdhPJzTnhxzehNTpwaBRL6fTjvCWi58/qURWKwq2o4hpF4qgsS7zdhAck1tF8HRq0RGCtQx5tpH1OWHXfVhcQfjCQg=
X-Received: by 2002:a1f:ea06:: with SMTP id i6mr18097223vkh.36.1590415352756;
 Mon, 25 May 2020 07:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAGjfG9a-MSg7v6+wynR1gL0zoe+Kv8HZfR8oxe+a3r59cGhEeg@mail.gmail.com>
 <20200514203326.2aqxolq5u75jx64q@chatter.i7.local> <20200514210501.GY1596452@mit.edu>
 <20200514211040.a7hrirdzgkphx3la@chatter.i7.local> <xmqqr1vmp5wf.fsf@gitster.c.googlers.com>
 <20200514214404.bcbjskgi52bwedlh@chatter.i7.local> <20200515214257.GA21855@dcvr>
 <20200517221213.l3q2creiddpylbpm@chatter.i7.local> <1061511589863147@mail.yandex.ru>
In-Reply-To: <1061511589863147@mail.yandex.ru>
From:   Caleb Gray <hey@calebgray.com>
Date:   Mon, 25 May 2020 07:02:21 -0700
Message-ID: <CAGjfG9YXQ5fkwY6DS8iOymHHXm-r+Rs4yah1afngwkGxNOE9gA@mail.gmail.com>
Subject: Re: Add a "Flattened Cache" to `git --clone`?
To:     Konstantin Tokarev <annulen@yandex.ru>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@yhbt.net>, Junio C Hamano <gitster@pobox.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For a repo like git itself, the assertions regarding the way git
currently builds its data (in fact, including the `checkout` portion)
does compete directly with the "cached result" methodology! Holy shit
guys, I'm impressed as hell.

tl;dr: The way I read the raw numbers, `git` ends up being as-fast-as
(or faster) than a "cache" of the .git folder. Without doing further
research, I'm inclined to agree with the previously mentioned bitmap
method already being effectively as efficient as (more efficient
than!?) a cache.


Methodology/Reasoning:
virtualized: verified zero network chatter on eth0 before and after each te=
st.
tcpflow: to gather the bits for the entire transaction... from just
before the execution of `git clone` was started, and closing the
listener just after execution ended. (not worrying about
protocols/overhead)
tar: to compare the size of the repository on disk with the tcpflow
results. (not worrying about compensating for
headers/metadata/overhead)
gzip: to theoretically, I haven't checked anything, compensate for
seemingly arbitrary size differences when downloading over HTTPS.
time: (really) rough measure of execution time.


Commands used to generate files:
*.tcpflow: `sudo tcpflow -p -c -i eth0 > $filename.tcpflow`
*.tar: `tar cf $filename.tar .git`
*.gz: `gzip -9 $filename.tar`


Results:

75M kernelorg.tar
72M kernelorg.tar.gz
69M kernelorg_git.tcpflow
69M kernelorg_https.tcpflow

145M github.tar
143M github.tar.gz
143M github_git.tcpflow
142M github_https.tcpflow


Other Tests (sanity checks):

Cloned a gitea mirror of kernel.org's git:
69M gitea_git.tcpflow
69M gitea_https.tcpflow

Cloned a bitbucket mirror of kernel.org's git:
69M bitbucket_git.tcpflow
69M bitbucket_https.tcpflow

$ time git clone git://git.kernel.org/pub/scm/git/git.git
Cloning into 'git'...
remote: Enumerating objects: 15475, done.
remote: Counting objects: 100% (15475/15475), done.
remote: Compressing objects: 100% (861/861), done.
remote: Total 287977 (delta 14910), reused 14907 (delta 14610),
pack-reused 272502
Receiving objects: 100% (287977/287977), 66.09 MiB | 4.87 MiB/s, done.
Resolving deltas: 100% (217420/217420), done.

real    0m20.000s
user    0m15.414s
sys     0m1.606s

$ time wget https://calebgray.com/public/kernelorg.tar.gz
--2020-05-25 06:11:29--  https://calebgray.com/public/kernelorg.tar.gz
Resolving calebgray.com (calebgray.com)... 192.3.203.78
Connecting to calebgray.com (calebgray.com)|192.3.203.78|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 74593708 (71M) [application/octet-stream]
Saving to: =E2=80=98kernelorg.tar.gz=E2=80=99

kernelorg.tar.gz
100%[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>]
 71.14M  4.81MB/s    in 19s

2020-05-25 06:11:48 (3.79 MB/s) - =E2=80=98kernelorg.tar.gz=E2=80=99 saved =
[74593708/74593708]

real 0m19.420s
user 0m0.030s
sys 0m0.280s


Thanks everyone for your input and time! I love git, you guys do great work=
!

P.S. I ran a few other benchmarks outside of these, and the timing
always worked out to be more/less the same between the reported
transfer rate (as told by my router, as well) and the "real" time it
took to download (for both `git` and `wget`).

P.P.S. I haven't investigated the reason for the github repo being
nearly twice the size as the kernel.org hosted copy. That one stands
out as potentially part of the proxy discussion, or there's actually a
difference in the repo's data. Curiosity will likely get the best of
me eventually.




On Mon, May 18, 2020 at 9:40 PM Konstantin Tokarev <annulen@yandex.ru> wrot=
e:
>
>
>
> 18.05.2020, 01:12, "Konstantin Ryabitsev" <konstantin@linuxfoundation.org=
>:
> > On Fri, May 15, 2020 at 09:42:57PM +0000, Eric Wong wrote:
> >>  That said, I'm not sure if any client-side caching proxies can
> >>  MITM HTTPS and save bandwidth with HTTPS everywhere, nowadays.
> >>  I seem to recall polipo being abandoned because of HTTPS.
> >>  Maybe there's a caching HTTPS MITM proxy out there...
> >
> > Right, this can't operate as a transparent proxy.
>
> AFAIK, Squid can do MITM, caching and operate transparently.
> In the past it was done via ssl_bump directive, but seems like syntax cha=
nged a bit
> in modern versions.
