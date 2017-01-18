Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3E451F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 16:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753952AbdARQXG (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 11:23:06 -0500
Received: from mout.gmx.net ([212.227.17.22]:58736 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753943AbdARQXE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 11:23:04 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mbfyr-1cAygB3Pb3-00J2M2; Wed, 18
 Jan 2017 17:22:43 +0100
Date:   Wed, 18 Jan 2017 17:22:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>
Subject: Re: [PATCH 2/2] Be more careful when determining whether a remote
 was configured
In-Reply-To: <20170118125422.gi3ppqiqhyykk7iy@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1701181700020.3469@virtualbox>
References: <cover.1484687919.git.johannes.schindelin@gmx.de> <41c347f22c80e96c54db34baa739b6e37e268b61.1484687919.git.johannes.schindelin@gmx.de> <20170117214723.p5rni6wwggei366j@sigill.intra.peff.net> <alpine.DEB.2.20.1701181334040.3469@virtualbox>
 <20170118125422.gi3ppqiqhyykk7iy@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XjQqF5YWwYtP6idxbexDJGAi9MLKi4ZCzON+mBQMLFB92uH4rG9
 hp/PkecjRYA7sKQ1oEqtnwiPcK4R0SZOmLbbLBEpFfyHUo66u7GEs3MSO1psXFCtcDJdm/T
 P/TU2M1CSZ+L5BchlhZLNlctHXzS/geKNgdz9k/XxpRHnEkgepbV7U8zZQFfB3C2UgoD83e
 hpfg+3nqqgrzlb5vHUDiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p4dvIzg/RTo=:5YnX6fxu4spUDlAVgGbvxu
 xFWgLmCx7fXGRmG2rrKk2HrLcT7hKXT1COOqmxNLtfoUdpAyekmu9jXMFHaUkCmnVQv6+V2nu
 EONoVFSyn1YlVq6c8Sx5PGHphMZnLY93CVAGhA85xVGppzh7PM0w59xmk6AxPgzAJUU4TTRcr
 mlOi0HKsdzklOwhOBUW6Ed0n2esGlgab+PUPvTKErlvx38vd/gKUP8B/A3sjnJdUe2xqd1fuQ
 tWy3/gZW/ZVhWGPaQ4aU8kyC2YuaI5zoEi5frGSt9MjvJjUD1JfSxCz7TFI0Kf9wAMDhnrmP7
 VeDFab5tafLagFqUzbFeegSX5E31dphIf/hCRfQPNp2yN4y2qxCyUs+1lO5zoLXeornhcjMcF
 l16ouW7p7SlJt6Y1K14zMQ3+x+onBj3IRHWHxIq5xQds5uJq1Cs4NZiG9IxG8vaDa9kiC9X1n
 AA6gjplFGeKRvzIfXL3JjL+9V6nCxNRV72qp8Pcb/A5/u2xEVi64ZIIdvdfESmALdnvrEQ5/9
 0NqJBvq3i5pPRV440/IP9WNRi2fcQZ86wkEVH3uULx3YLu0cz+EQxMSVkJyDjw1jaaS1I/jUR
 /mSgQVRu9274LjFxGpoX66j+m+V77FuTPEWZLe/5Y1OoMegdLrApIunOFdV6oekXRfKAU07wF
 E6tsIjlOFp6BiCylgAGCeMv4r6NN/wBfAVPy2vtVL/U4y7PWW+p3PHi0VxlkPMG/uGHgvAyIV
 e11ZVL4KDNOTPp8z4Zoh1K3VTEFso8eAMfgtcfHER7iARuVIM8Z6yrqyCe4qOoJ9jkVUW79uk
 amMX13KuT5pm/77wGRKfVVuY4zdQ5FTaE2B3fwD89P/xsszaHcdFUDMr8kR+nMRzLhiUyNth/
 R72ZdVkrERsvJm5prxYCj9Hvj/nLw72xa0BkyKb0bP0zvha7GYWwCt/v07CC5CLWotsOzYfn7
 nwavdhPGgNPyBgeORiiE0dVgVOwmRh9URUrGaptaZvdwW7dlLzoUtpj+HjwBGDzEFKtNcIxOA
 pa8QlJH86VbaGbgD+jlBv+E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 18 Jan 2017, Jeff King wrote:

> On Wed, Jan 18, 2017 at 01:34:28PM +0100, Johannes Schindelin wrote:
> 
> > > > Let's fix this by telling Git that a remote is not configured
> > > > unless any fetch/push URL or refspect is configured explicitly.
> > > 
> > > Hmm. Old versions of GitHub for Windows used to set fetch refspecs
> > > in the system gitconfig, for a similar purpose to what you want to
> > > do with remote.origin.prune.
> > > 
> > > I notice here that setting a refspec _does_ define a remote. Is
> > > there a reason you drew the line there, and not at, say, whether it
> > > has a URL?
> > 
> > I want to err on the side of caution. That's why.
> 
> I guess I just don't see why changing the behavior with respect to
> "prune" or "proxy" is any less conservative than changing the one for
> "refspec".

Let's take a step back and consider the problem I try to solve, okay?

The problem is that `git remote rename <old> <new>` refuses to do its job
if it detects a configured `<new>`. And it detects a configured `<new>`
even in cases where there is not *really* any remote configured.

The example use case is to configure `remote.origin.prune = true` in
~/.gitconfig, i.e. changing Git's default for all "origin" remotes in all
of the user's repositories.

Now, the *real* fix would be to detect whether the remote was "configured"
in the current repository, or in ~/.gitconfig. But that may not even be
desirable, as we would want a more general fix for the question: can `git
remote` rename a given remote to a new name, i.e. is that new name already
taken?

And if you try to answer that last question, you will probably pick the
same set of keys for which you assume that remote.<name>.<key> really
configures a remote or not.

Originally, I would even have put the "vcs" into that set, as I could see
a legitimate use case for users to configure "remote.svn.vcs = vcs" in
~/.gitconfig. But the regression test suite specifically tests for that
case, and I trust that there was a good reason, even if Thomas did not
describe that good reason in the commit message nor in any reply to this
patch pair.

So how can things go wrong?

Let's take your example that the user may have specified refspecs (or
prune, or proxy) for a URL via "remote.<url>.fetch", and that `git rename`
incorrectly allows that as a new remote name. You know what? Let's do a
real code review here, not just a patch glance-over. Let's test this and
*know* whether it can be a problem:

	git remote rename origin https://github.com/git/git
	fatal: 'https://github.com/git/git' is not a valid remote name

A ha! It is *not* possible to hit that case because `git remote rename`
already complains much earlier about the new name not being a valid name.

So let's see what could go wrong with another example you mentioned, that
the proxy may not be used because we changed the logic of
remote_is_configured(). But the only user of the remote proxy settings is
in http_init() and reads:

        if (remote && remote->http_proxy)
                curl_http_proxy = xstrdup(remote->http_proxy);

        if (remote)
                var_override(&http_proxy_authmethod, remote->http_proxy_authmethod);

It does not even test whether the remote is configured! So maybe the
caller does? Nope, the only caller of http_init() that passes a remote is
remote-curl's cmd_main() function, and the relevant part reads:

        remote = remote_get(argv[1]);

        if (argc > 2) {
                end_url_with_slash(&url, argv[2]);
        } else {
                end_url_with_slash(&url, remote->url[0]);
        }

        http_init(remote, url.buf, 0);

This code also does not care whether the remote "is configured" or not.

So maybe there are any other downsides with callers of
remote_is_configured()?

There is one caller in builtin/fetch.c's add_remote_or_group() which
clearly is covered (we need a URL, unless the vcs is configured).

All other callers are in builtin/remote.c:

- in add(), to test whether we can add a new remote,
- in mv(), to test whether the remote to rename is configured,
- in mv(), to test whether the new name is already taken,
- in rm(), to test whether the remote exists,
- in set_remote_branches(), to test whether the remote to be changed
  exists,
- in get_url(), to test whether the remote exists, and
- in set_url(), to test whether the remote exists.

It appears pretty obvious that in all of these cases, the suggested patch
still makes sense and does not introduce any nasty surprise.

> I can think of one alternative approach that might be easier for users
> to understand, and that we already use elsewhere (e.g., with "http.*"
> config): have a set of "default" remote keys (e.g., just "remote.key")
> that git falls back to when the remote.*.key isn't set. Then your use
> case becomes something like:
> 
>   [remote]
>   prune = true
> 
> That's not _exactly_ the same, as it applies to all remotes, not just
> "origin" (other remotes can override it, but would need to do so
> explicitly). But I have a suspicion that may actually be what users
> want.

Sure. That'll be another patch series, though. And another contributor.

Ciao,
Johannes
