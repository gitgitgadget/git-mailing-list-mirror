Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915D1C77B7C
	for <git@archiver.kernel.org>; Fri, 26 May 2023 11:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242666AbjEZLN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 May 2023 07:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbjEZLNz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2023 07:13:55 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73910101
        for <git@vger.kernel.org>; Fri, 26 May 2023 04:13:51 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E14235C00C6;
        Fri, 26 May 2023 07:13:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 26 May 2023 07:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sebyte.me; h=cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685099630; x=1685186030; bh=xL
        PPqoEooNHw7T7s2MR7Culw6XGm4Qs1s6g4Dz+ahmc=; b=ELBUmOHDxJ0NPagZmm
        gXC2c9VfyR2vZdyTxd/PGoVys+wUj6EeLLAy5Bv9jdbT84lnCgM+s8WgI6gcVVQ7
        FJ+VYp1a0MiO2lEsvViSUI1MbabAbZcQXGf9/OeizvIP8bGAtui7a/iSdrgIMDkR
        mD8TnosVfZXF5vVdw5sWHcoQoUSRYpNmXXIQHiu2ZhbSh/ps4MXhcdnfYuP/O8fE
        6YSBJpSt2DhATVDSEXeGU3ZtNcnuYZe06x/v1dJ3q9Cosd4W16cIQNIZp3E7DtGT
        76GBqQCLrWc1CO6HDA6sxsZRTxUuJWwWA6cf90/oG/YA9GBqpIeuHIYkAJ+DfTPp
        KnoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685099630; x=1685186030; bh=xLPPqoEooNHw7
        T7s2MR7Culw6XGm4Qs1s6g4Dz+ahmc=; b=hhiK2pQrhaRmMd+OzxQhJZ9Mn7VCh
        GN+P36mccMy9NSalAHt8646Rp2HtOYmMfn+jC9uGnd4hAei1tVWkVw4dhU1c6NY+
        g4XpdA4upjxS3Pnlrl1SdqdgkMtwMQdik/CpibAMMx/lGS7L4djGrs0BUqhAUVsk
        DuRrFAlLH0iBgwHNIXnPbZnsCPEVI5+y94TJV7IJnC9WV9Hjdl2ua4ne5ifsinFE
        rhjvyT9EcCIdTSQME49bZC2AjOKOxY0dWvBN/MgvsN+JDfy0OLy2MRG4zClURozR
        JfWNs9oaJdHA1o3814D6jihTmUTv2pv/IOkJJyqNEh9TgjBrobD9cM7Ag==
X-ME-Sender: <xms:bpRwZOy8IZTqiTWOdYwKJrHvSjb6ebVcSqZlQLQfiOtbrh1vrI4Evw>
    <xme:bpRwZKSUn3uEytCPhjhR0X7D1wepmc75FXVjkXsOHgGlHhTexF_v0ErtwkLYr7hXN
    CxM6EvAbybUeoj-4Q>
X-ME-Received: <xmr:bpRwZAX6DTmn5I8HmgpblOgfwy6x81G1OOlLpSQLoVDyz4XPS8C388W9RU9EZvdF-ghEO-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejledgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgfgsehtqhertd
    dtreejnecuhfhrohhmpefuvggsrghsthhirghnucfvvghnnhgrnhhtuceoshguthesshgv
    sgihthgvrdhmvgeqnecuggftrfgrthhtvghrnhephefgffelteefueffvdeffeffheejve
    eigfdvtdeufeefveelleeivddttdegtdefnecuffhomhgrihhnpegvgigrmhhplhgvrdgt
    ohhmpdhfohhrkhdrhhhoshhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepshgvsgihthgvodhrvghtuhhrnhdqphgrthhhsehfrghsthhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:bpRwZEheE_HkLo6MbcMpMq6tzXs85PM62ZaBJStSkDdUzb979F15OQ>
    <xmx:bpRwZACZl6Luxt0Ej8RCYL2T0jKReZU0UVSOMFtplXq1hhLQ64xXgQ>
    <xmx:bpRwZFLB6PpWZ8bPzqvZix6CXB0FtXmeOx7huRteum08MPyVTXPsvA>
    <xmx:bpRwZP83XNSjytkg0MzJH4WAvYjTuN-1Pg6qV8iluRaHgeZmcU4bTA>
Feedback-ID: i9e78401f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 May 2023 07:13:50 -0400 (EDT)
Received: from sebyte by balor with local (Exim 4.94.2)
        (envelope-from <sebyte@balor.gnukahvesi.net>)
        id 1q2VOH-000JER-8T
        for git@vger.kernel.org; Fri, 26 May 2023 11:13:49 +0000
From:   Sebastian Tennant <sdt@sebyte.me>
To:     git@vger.kernel.org
Subject: How to publish a fork
Date:   Fri, 26 May 2023 11:13:49 +0000
Message-ID: <87pm6ne45u.fsf@sebyte.me>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello list,

I wish to publish a fork of an upstream git repository (as a means of
distributing modifications to upstream across multiple machines).

Let's call the publishing repo fork.git, the machine which hosts
fork.git the fork host, and the machines which clone fork.git clients
of the fork host.

fork.git includes unmodified upstream branches and additional branches
not found upstream.  The additional branches all share a common
namespace; mod-*.  For example, mod-master is an additional branch
based on upstream branch master.  A cron job running on the fork host
automatically fetches from upstream every 30 minutes using a mirror
refspec, e.g. +refs/heads/master:refs/heads/master.  Clients of the
fork host also use a mirror refspec for upstream branches and an
ordinary fetch refspec for the additional branches,
e.g. +refs/heads/mod-master:refs/remotes/forkhost/mod-master.

To summarise, the resulting configs look something like this:

Fork host config (extract):
--8<---------------cut here---------------start------------->8---
[remote "upstream"]
	url =3D https://example.com/upstream.git
	fetch =3D +refs/heads/master:refs/heads/master
--8<---------------cut here---------------end--------------->8---

Fork host client config (extract):
--8<---------------cut here---------------start------------->8---
[remote "forkhost"]
	url =3D https://fork.host/fork.git
	fetch =3D +refs/heads/master:refs/heads/master
	fetch =3D +refs/heads/mod-master:refs/remotes/forkhost/mod-master
[branch "mod-master"]
	remote =3D forkhost
	merge =3D refs/heads/mod-master
--8<---------------cut here---------------end--------------->8---

In order to keep an additional branch up to date with upstream, a
client need only fetch from the fork host, rebase on the upstream
branch, and then push (back to the fork host).  For example:

 $ cd mod-master

 $ git fetch --verbose forkhost
 [=E2=80=A6]
 4b3de748b0..f35648ba0c  master     -> master
 =3D [up to date]          mod-master -> forkhost/mod-master

 $ git status --short --branch
 ## mod-master...forkhost/mod-master

 $ git log --oneline ..master | wc -l
 1

 $ git rebase master
 Successfully rebased and updated refs/heads/mod-master.

 $ git status --short --branch
 ## mod-master...forkhost/mod-master [ahead 3, behind 2]

Note that, although there was only one =E2=80=98incoming=E2=80=99 commit, m=
od-master
and forkhost/mod-master have diverged (by 3 and 2 commits
respectively).  This is because there were (and are) two commits on
mod-master not found on master.

After fetching, C is the =E2=80=98incoming=E2=80=99 commit:

               master:  ---A---B---C

           mod-master:  ---A---B---X---Y

  forkhost/mod-master:  ---A---B---X---Y

After reabsing:

               master:  ---A---B---C

           mod-master:  ---A---B---C---X'---Y'

  forkhost/mod-master:  ---A---B---X---Y

As you can see, mod-master and forkhost/mod-master now diverge after B
(by 3 and 2 commits respectively).

This means that when the client tries to push, the updates are
rejected:

 $ git push
 To [forkhost]
  ! [rejected]              mod-master -> mod-master (non-fast-forward)
 error: failed to push some refs to [forkhost]
 hint: Updates were rejected because the tip of your current branch is behi=
nd
 hint: its remote counterpart. Integrate the remote changes (e.g.
 hint: 'git pull ...') before pushing again.
 hint: See the 'Note about fast-forwards' in 'git push --help' for details.

unless force is used:

 $ git push --force
 [=E2=80=A6]
  + cbb90030a9...5299b8bf0d mod-master -> mod-master (forced update)

It is obviously dangerous and wrong for a client to use force every
time it pushes to fork.git.  What if the client failed to notice
incoming commits on mod-master (as well as on master)?  Those missed,
incoming commits might be irretrievably lost.

So, how should one _safely_ publish a fork?

Sebastian
