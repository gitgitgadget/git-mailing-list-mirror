Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AD0C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 20:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D99A12070E
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 20:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="U/K95vwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393022AbgFWU6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:58:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:40001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392358AbgFWU6s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 16:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592945917;
        bh=EakO1M+hoLPkXVPGxett1tS6MPWabNC0OT9be/Hft+E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=U/K95vwMtWxKuYcqov/36bvliMMlQdUwbQT14gGvvLePHR/eW16m3xJ/kwF/lsrYa
         7Un3hUD3eNl4XUTM+olIjHPOqSY6Uy3/oto61j9Ra+fyWTHRY8wIwVhVsck7CZEmlv
         xYdR5CjSDukRqq9eOETSW32ubTndT6UYT2NlwKjg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5VHG-1ilXHy3jQI-016z6V; Tue, 23
 Jun 2020 22:58:36 +0200
Date:   Tue, 23 Jun 2020 22:58:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 09/12] clone: handle overridden main branch names
In-Reply-To: <20200616132216.GH666057@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2006232233290.54@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <0e59b6181699abe17eb46fe3ca5a48ce71889780.1592225416.git.gitgitgadget@gmail.com> <20200616132216.GH666057@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ilV9m8Ug1fgeqQx3WK+sEPNHgnTrdpbnuYOiUSdPV/j/sUc1629
 ogvdbpqCEz5YyYrBGDSqCH44SucmZb83MG+3cye1X4Ht5A91krXX9o3We64T/ogUCsO34z5
 /b/z9+1Kcg422j4YWZIHq4Cvp+0ESKRWKhRACkGFQUaXS2UX+DID1mqI4EgPFr8jGkCEBDh
 nly03wwuXNWeh/Ap7j8NQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DTy/SON02dI=:LhINsEqwQ27ph3j2d6fEfl
 J15tZRzirAimo9EfDk+8p/qkOsPm7G46N06gAcmTHtqCBWFQY7XFUOf+uQImTvk7Dd/TC43UO
 VpdBRoAePuoCWUZfKWP3OO4TjCDxbulwrNUkSqEdQBLDaXKyzmHoeuP+6ze/TEJOuvLRkkJUs
 TESDCn1aPVxspgiNbWeGs+SkqMDiT2+Sn9YluMx/AZzGjSIywYfh0AvqB63PhbGyOQtBvAm4Y
 rLIEUFxORojQk4tRhjSJvUrLBzFHvFiLicOKqPDuCwP9f1tGQf2DSsL/eJLzcv7R0u7jsvBBE
 mrp6gYeg9v9YIjLCgsHt1LJpCmtDnqctoNycc0/Bw8wA9yUdHMUZg+yyF6Dwty/jiBGsG3oZT
 D4do42k5nJCz/jaZci1Vy7gBtRQczPJ/4Ekai755JJnFzllmp2wqE3fEblfh0iQDomzScAl7f
 IGBQMg9sS4PDki9joPxhO2oj1CjKn+97YXv7XrDQhaU7GLT0U39MHKopWwqWgSVlJwyXCwtp2
 NFJALGROiPKpNOpHuUvvn+gLw/bj8yXiVsxuL8uiTJAFNhRAfKZQrTrvD8Hga4w0p2Iu3Zpeq
 fld4DgJycviwCCXu5o0Jr7wsl/SXvcmeJ3vYnPxjSXF0R/b5Y681QrryTuDZMojZbmWwCZ0ho
 EiKXPo0gY7J6YCmDxzKRVIKFbQfI8Z22DhbRVnVQLqkbpLqSKvI5/JS6mKXNgRrFMS32IvakX
 /vxR09jQDZMcRquGdND/XtjDuyHCozQT6je2pwidyMUu+Q81Dw2X148ARuaE9Xjc85J36QJ2q
 fotiDC8mZyXKb+MrS5vDKW3wIG6whLtZty7BYNSQaL4w+qY5E3P2/2W64KGYri+Lj/us8LgbK
 ADaC9dMYUqR7dj9iEd3HMNiMsIl9nclGL1SjAiTddL52i+SLI/v1eerlBk97fNgGK7lOzHrgL
 oxjSY5pYDbjFmkzIQu2lLRmu//PX0HGFAWWEgG4y6Z+ZtIwglBxTu+Y5RTXDA3LUZiDcUeb1z
 7Z2QS35QE6zB04AyDO9HKLPtDDdEVM6Z2pQozEyuceFJVFFojCtj8AYyeR4XPrcZ8Wcv2b/Uf
 li7PcX8U+6GUgoJbVZ5oPy5tUHq7xVHiQITnXeYdrdp0aAs+SlV58E93EoERtpzJ60FdLWQ8q
 Xv27LWKvSvqABpU7d60DDMBXRT6YYzY7J5PBVib5hF/jsRaAw3ESaA2/DFyS+esk6xVrxX/Hl
 JbEz/DP8ZfD+Z/Z8R
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 16 Jun 2020, Jeff King wrote:

> On Mon, Jun 15, 2020 at 12:50:13PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 487b0a42d75..755fcaeb0ba 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -718,6 +718,7 @@ static void update_head(const struct ref *our, con=
st struct ref *remote,
> >  		/* Local default branch link */
> >  		if (create_symref("HEAD", our->name, NULL) < 0)
> >  			die(_("unable to update HEAD"));
> > +		git_config_set("core.mainbranch", head);
> >  		if (!option_bare) {
> >  			update_ref(msg, "HEAD", &our->old_oid, NULL, 0,
> >  				   UPDATE_REFS_DIE_ON_ERR);
>
> Just making sure I understand what's going on here...
>
> This covers the case that we've run "clone -b foo" or similar, but there
> are two other case arms when "foo" is a tag, or the remote HEAD is
> unreachable. And there we don't set core.mainbranch at all.

It was actually meant to catch the case where the remote repository has a
default branch other than `master`.

> But we would not want it to be missing, because that will likely need to
> stay a default for "master" indefinitely (to keep behavior for existing
> repositories). However, it won't be missing. We'll always have set it
> during the init_db() call, and this is just overriding that. So we'd end
> update_head() with either:
>
>   - core.mainbranch set to the same branch we point HEAD to, whether we
>     got it from the remote side or from "-b foo"
>
>   - if we write a detached HEAD, then core.mainbranch remains at
>     init.mainbranch (or defaulting to "master" now, and probably "main"
>     later). We have no better option.
>
> If so, then that makes sense to me.

In any case, this does not matter anymore, as I am dropping
`core.mainBranch` from v3, as you had suggested elsewhere in this thread.

Ciao,
Dscho
