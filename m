Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7E83203C1
	for <e@80x24.org>; Mon, 14 Nov 2016 22:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939765AbcKNWhj (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 17:37:39 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:37596 "EHLO
        homiemail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S941003AbcKNWhZ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 14 Nov 2016 17:37:25 -0500
Received: from homiemail-a9.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a9.g.dreamhost.com (Postfix) with ESMTP id 6BE875BE06F
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 14:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=ErPK3mfsoM5fH7JQyPPJEDd4WQo=; b=MOwzOQhn4Z
        NiOT9aAYL/INAexA67U9e1GjA+h+6QL+Y4FZYz5VzOO4iWgAJJb1pbMfcLaHHgn5
        n0oQzTBYxLB1HMsIVRQnnxv4Wil6LJ6Xu6hsJcKT5h5ZQck0sqQH+9eYrbBnnHrn
        K2Xdtd/+H68AxKhD5uYceLxYGoStPoJi0=
Received: from main (30-10-119.wireless.csail.mit.edu [128.30.10.119])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a9.g.dreamhost.com (Postfix) with ESMTPSA id 241805BE064
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 14:37:24 -0800 (PST)
Message-ID: <1479163040.2406.49.camel@mattmccutchen.net>
Subject: Re: "git subtree --squash" interacts poorly with revert, merge, and
 rebase
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     git@vger.kernel.org
Date:   Mon, 14 Nov 2016 17:37:20 -0500
In-Reply-To: <1478814800.2878.10.camel@mattmccutchen.net>
References: <1477523244.2764.114.camel@mattmccutchen.net>
         <1478814800.2878.10.camel@mattmccutchen.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2016-11-10 at 16:53 -0500, Matt McCutchen wrote:
> On Wed, 2016-10-26 at 19:07 -0400, Matt McCutchen wrote:
> >=20
> > Maybe we would never hit any of these problems in practice, but they
> > give me a bad enough feeling that I'm planning to write my own tool
> > that tracks the upstream commit ID in a file (like a submodule) and
> > doesn't generate any extra commits. =C2=A0Without generating extra co=
mmits,
> > the only place to store the upstream content in the superproject woul=
d
> > be in another subtree, which would take up disk space in every workin=
g
> > tree unless developers manually set skip-worktree. =C2=A0I think I pr=
efer to
> > not store the upstream content and just have the tool fetch it from a
> > local subproject repository each time it's needed.
> >=20
> > I'll of course post the tool on the web and would be happy to see it
> > integrated into "git subtree" if that makes sense, but I don't know h=
ow
> > much time I'd be willing to put into making that happen.
>=20
> I have named my tool "git subtree-lite" and posted it here:
>=20
> https://mattmccutchen.net/utils/git-subtree-lite.git/

As I was doing additional research in preparation for adding git-
subtree-lite to the tools page
(https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools),
by chance I found an existing tool, Braid
(http://cristibalan.github.io/braid/), whose design meets my
requirements. =C2=A0I have a few minor concerns, but assuming I'm able to
fix them without too much work and upstream accepts my patches, I plan
to switch to Braid.

I've made a properly marked section on the tools page for subproject
management tools:

https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#Su=
bprojects_or_sets_of_repositories

in the hope that the next person with the same requirements as me finds
Braid. =C2=A0(I unfortunately didn't check that page before starting, but=
 I
will the next time I need something.)

Matt
