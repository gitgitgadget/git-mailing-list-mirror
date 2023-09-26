Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB310E7E637
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 14:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbjIZOCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 10:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjIZOCl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 10:02:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF82101
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 07:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695736949; x=1696341749; i=johannes.schindelin@gmx.de;
 bh=Yy34R0gX9qXhCp/AFo8hPFpeGZVSHfM+QBgWzJW6Q80=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=goX1C+BBS+dmJLUCyZ7pAY+DGx9jZSrZ967cArW3wrQSD5neGh/nhzP8MV5BKkNVhrJwwwD+mV/
 I7noXRqXUAe61Z4CzJjr76gPQJge77sGqQujP3MYkHqCJ3MWt96QlBaUcn/JjYJrvQCoSu2g/qdY1
 hVRwI2V/PTUvbrca8hDpfKu9wEC8Rvhykm176Y5KNHkQX80C4FR+jshNkDxx+ZDgd4N8yjanwtEYT
 2pKDZF53QSBSaCFAEWO6Bw1MOYSIcNBykFkJMJvoxUtKMNnkJSXODBefbFznCXjEDpVatQ69KsE64
 yyIbTcT4SnknYHxHpK0tpLgo7j40LriwIdWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.206]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KUT-1rib0f4BGD-016d0t; Tue, 26
 Sep 2023 16:02:29 +0200
Date:   Tue, 26 Sep 2023 16:02:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/6] coverity: allow overriding the Coverity project
In-Reply-To: <20230925121157.GB1623701@coredump.intra.peff.net>
Message-ID: <4e0f404e-0c49-b085-c35d-be53b0381402@gmx.de>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com> <6c1c82862814f40a408231cb249fb4b653276b52.1695379323.git.gitgitgadget@gmail.com> <20230923070019.GD1469941@coredump.intra.peff.net> <a839daf1-9e32-96f8-4eab-7c845e128488@gmx.de>
 <20230925121157.GB1623701@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:e3SJear7Y24zGEcn+5uAMItkahsBeJ/qTW7NWC+dM60r2qz26Fe
 7X2J/0F3tRY/PWHXjN3o6bppZ17EFoPudBQ3eR1aztfcnCKTNUo6TnFvCoXkKAzF2l/ify5
 PVzzZV3YkDilWFQKz6sdZNBf7/48iNbJZY6MY/4TsD8y7Ni/Er5t8GNLBH2adUcqFjdb3w4
 k0LOqabalSAQIx2qZw6og==
UI-OutboundReport: notjunk:1;M01:P0:aDvlViK1QrI=;KsWsAqCslcYP6XNhWPhKc0TN3EE
 w7J5R2esrL8C3bJwaZi0P4Gop3/bCajD3jfmOO1sZg+seVWYa8J+RJXpKQrGkLO+bb5YksIxJ
 fQAZG0aaAPj9+z7LIaK8N/qFtUmvoO5rYMIoDi12z7X3Vvm49CzkepyqxJFVIYdnuy+0j/y0g
 4udlk7jWwPYdDufv6opy24oOfBs87N5902JRkVCwE+ZdvIKm8ddVBT+sNJhDBbqvVm3XD/0yC
 BlLkxR77B6QH3mA+VvzQ57N7wGNj8RQ6b+Dvxz7gFi/MuhOBv5BI+e4GTCis+bwZTlXFwqrsq
 w29yxiGZ9BVUuHiJ/mhZK8aoBpaqhes5jSkTYMsUeqtWxmFeGAvY7dHd+b3pM2w9bSYVqISRD
 v6AcHKSoToFwj6kuNUMv/XH7HaY5JVknrIKqmFqncOG7gUrjMYvmRdlhbX9B5hZ3iH95qIViB
 9yYm5Zus5Ton+MEeDTc5A8I1AxvEDFCUosFXKECBIzrARL1wU9RhViWy/5v94Wx0XLKSwkJWP
 Tvs2VGcawLExo8+4+dNEKcUKpCTDIc4CCq22CQYwsm9ochQy7FOtOfx8+hPkx5gI1YHIvd7SL
 8l1BzgZf0WL6oZmGCtqxRN5VTHrQgGNNpDrERTmiAFNrupputVGGbYsgmdCf1IKu6qXbEkAMN
 l/ZN8F/VZLATnibX2N2JwX5974rYoxW4eCYYl8lZCpxGTBOzkQfQuomD0Trh7JRv/q6Bq1WQ9
 e9JqVXYaYqWvlc4NXAAROncRFWdfuQQaUcA+JOPW0Qx4rsOJBxZx4DaooIB0CBxMnIm6L5g3T
 JGK+jcttCulkK9x2FIHag0l2Vs2ukG+o6ESDYZOpOOALhu/Fpkw9O28yrdEtn2achP123UeEV
 7yfhndetAhk3H+/0D8ge38aVQlwyzY2NdXcZfPc8WFICMXzQh66cwcDze98ZSJdrQC8+XKNNx
 V4kQYHU3Qa3mJbyuXSfyrMmR3OQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Mon, 25 Sep 2023, Jeff King wrote:

> On Mon, Sep 25, 2023 at 01:52:47PM +0200, Johannes Schindelin wrote:
>
> > On Sat, 23 Sep 2023, Jeff King wrote:
> >
> > > On Fri, Sep 22, 2023 at 10:42:00AM +0000, Johannes Schindelin via Gi=
tGitGadget wrote:
> > >
> > > > +# By default, the builds are submitted to the Coverity project
> > > > +# `git`. To override this, set the repository variable
> > > > +# `COVERITY_PROJECT`.
> > >
> > > This may not matter all that much, because I don't expect most
> > > people to set this up for their forks
> >
> > Except, of course, Git for Windows. And that has been the entire
> > motivation for me to work on this here patch series in the first
> > place, so it would be rather pointless if I could not override this in
> > the git-for-windows/git fork.
>
> I didn't at all mean that it should not be possible to override it.

Aha! The "This" in "This may not matter all that much" was referring to
the `git` instead of the `COVERITY_PROJECT` part. That had not been clear
to me.

> I meant that the default should be $user/$fork from the Actions
> environment,

I'd much rather default to the value needed by the Git project than a
value that may be needed by any other user. I do aim to support the Git
project with this patch series, first and foremost.

Ciao,
Johannes
