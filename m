Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FCCC28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 18:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B2F1206CD
	for <git@archiver.kernel.org>; Sun,  3 May 2020 18:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sudoforge.com header.i=@sudoforge.com header.b="wNi0bbpf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iWPUyxC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgECS1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 14:27:34 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:48561 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728358AbgECS1c (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 May 2020 14:27:32 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id F410E3AC;
        Sun,  3 May 2020 14:27:31 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute2.internal (MEProxy); Sun, 03 May 2020 14:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sudoforge.com;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type:content-transfer-encoding; s=fm1; bh=it
        8c3sqZm6yiQ1nPstVISm5HTuJg0Qv3sR8CRQZClYE=; b=wNi0bbpfQ71L8R7xjO
        2pC/nqDUG1BDMgZiqSXuEjgu16tGDEFbIXSJHJXvUyZAvta6xw1cnLEqTsNZFQpk
        NEjt0+lPOtrjHWrkvhdcgiXZwcKqBm8QJv7K+vcIQDuczMdmxVm/pk87iHPpNf2T
        Nl4MDeNwlQLtmJckMuRfkOgEPZxNn+KMuhXMfkaCBuFGTcWzSyiepKAy4/SntmvM
        7odln+tcIeyQlRebThtRuAUrECu7sVPW4zpGgeWvP3g6nuv2jzvpZaWzISmuXweH
        xisaLN7QTk6YLkxeDlZvUHplIYMwN5YCVSAZwJfPK+3/qiV+1i8hok/DP7syp2dF
        x9XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=it8c3sqZm6yiQ1nPstVISm5HTuJg0Qv3sR8CRQZCl
        YE=; b=iWPUyxC51qcLy9TALU72MVpvj+M50x5UM8zLUZ/joVUr+xlqi+EggU2y1
        KEbL7I8cKIV0w0m/bkBIbzOLRx0++LEbpeibnwn8yubjGUTsz+WsEiYEzY2XWWiV
        repuHqRWODsHaXvpym9wMtBqx0N3FtS3/9sXOI1NUnqprFCrE//IcuY6pASMkVO9
        c4OsAfiWt20HeWCBC2VUpePpkFrkEMKRuUIV6jkIYDi5eUZIteBplmkUN7kHVx4Z
        pyUiYeBuNDTgYlYO+QPD7cCiYizY1HPtkhu2k3y+jGiBmFHed70FQz1cxf21O9dj
        lsc+z2ohm6gbJmJ6UQ1PIgqWnDy4w==
X-ME-Sender: <xms:Ew2vXse49E3D9s-uG7qmGV8MsKkO1OBjV7TkaxD-Rvbdi_eDzbYeUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjedvgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtgfesth
    hqredtreerjeenucfhrhhomhepfdeuvghnucffvghnhhgrrhhtohhgfdcuoegsvghnsehs
    uhguohhfohhrghgvrdgtohhmqeenucggtffrrghtthgvrhhnpeffiedvuefhtdetvdeuud
    fhhefhvdehtdeigfevheegtdekudfghfeigeevffegueenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghnsehsuhguohhfohhrghgvrdgtoh
    hm
X-ME-Proxy: <xmx:Ew2vXpINqShuCQj1ZicEprgXlKe5NxCKNR147fiOlusAw-PddnMnfg>
    <xmx:Ew2vXgLZ2qmvTVD6TDUI5u_R2TTrUnCDp9rF-mNtCRNh-a-LdvAsRg>
    <xmx:Ew2vXgvmrs1NxlunB0tI2BOqF-HX3hqsPP_TAR200L9ZU4y76bElVA>
    <xmx:Ew2vXtfVibjixYuREt0TwVWQhrJtLw1HLB7Y-AQxM7eq4ALVV7vr7w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3E4D8E00A9; Sun,  3 May 2020 14:27:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-351-g9981f4f-fmstable-20200421v1
Mime-Version: 1.0
Message-Id: <7ecc6a46-001a-45b5-8b63-7e07f88acfb9@www.fastmail.com>
In-Reply-To: <20200503065446.GA1829906@coredump.intra.peff.net>
References: <7480e635-97cc-4acd-875e-54bc71a88068@www.fastmail.com>
 <20200503065446.GA1829906@coredump.intra.peff.net>
Date:   Sun, 03 May 2020 11:27:10 -0700
From:   "Ben Denhartog" <ben@sudoforge.com>
To:     "Jeff King" <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: --no-tags doesn't appear to be working as intended
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gah, sorry for the erroneous bug report, this was user error.

This was caused by having `fetch.prunetags =3D true` in my user-scoped c=
onffile. As per the documentation from `git-fetch`:

```
The --prune-tags option is equivalent to having refs/tags/*:refs/tags/* =
declared in the refspecs of the remote. This can lead to some seemingly =
strange interactions:

           # These both fetch tags
           $ git fetch --no-tags origin 'refs/tags/*:refs/tags/*'
           $ git fetch --no-tags --prune-tags origin

       The reason it doesn=E2=80=99t error out when provided without --p=
rune or its config versions is for flexibility of the configured version=
s, and to maintain a 1=3D1 mapping between what the command line flags
       do, and what the configuration versions do.
```

--=20
  Ben Denhartog
  ben@sudoforge.com

On Sat, May 2, 2020, at 23:54, Jeff King wrote:
> On Sat, May 02, 2020 at 02:01:35PM -0700, Ben Denhartog wrote:
>=20
> > # set up the fork
> > git -C /tmp/b init
> > git -C /tmp/b remote add -f --no-tags upstream file:///tmp/a
> > ```
> >=20
> > You'll see the 0.0.1 tag being fetched. You can delete it all you
> > want, set the `remote.upstream.tagopt =3D --no-tags`, etc -- it will=

> > always be pulled. This is the opposite behavior I would expect based=

> > on the available documentation and discussion around the tag in the
> > mailing list.
>=20
> I don't see that behavior. I get:
>=20
>   $ git -C /tmp/b remote add -f --no-tags upstream file:///tmp/a
>   Updating upstream
>   remote: Enumerating objects: 3, done.
>   remote: Counting objects: 100% (3/3), done.
>   remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
>   Unpacking objects: 100% (3/3), 197 bytes | 197.00 KiB/s, done.
>   From file:///tmp/a
>    * [new branch]      master     -> upstream/master
>=20
> Is it possible you have some other config that might be conflicting
> (e.g., extra refspecs that ask to transfer tags)? What does "git confi=
g
> --list --show-origin" say?
>=20
> -Peff
>
