Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF3AC433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 927E620663
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Qx6b9KIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391507AbgFWVEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:04:21 -0400
Received: from mout.gmx.net ([212.227.17.22]:52585 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393016AbgFWVEN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 17:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592946238;
        bh=bKPYR1+IwyqRq/PTsOSoOeWKOXG/2v/2R2Ar06i3aJg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Qx6b9KIny1XNIt836KCjS8gyh5WAzHSGOVVUUo4tFRX+pdl34nvJcYKB9e+FmuRW6
         D2+DQvWQAqS67IwPVk668gOihbBQI6cwyz6CSoBOO+0oZ2I9M76L+EOwwhth+SpC1C
         9UE52Lt/bT6C0vtI/ToMrOR0RCYqrw2AfEty2hOw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDIu-1j5wg13Jh2-00i8ha; Tue, 23
 Jun 2020 23:03:57 +0200
Date:   Tue, 23 Jun 2020 23:03:57 +0200 (CEST)
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
Subject: Re: [PATCH v2 11/12] submodule: use the correct default for the main
 branch name
In-Reply-To: <20200616134618.GI666057@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2006232259320.54@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <59d6267f099f30f830836a2422289bc83f5c35e5.1592225416.git.gitgitgadget@gmail.com> <20200616134618.GI666057@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cItDqRjtdKZiD0Oa+fw0mXSqOhs0P0WEasQxXjo+4Qh/6GWyp9j
 ywZDXSzmasje+dxeWvWXj4ncAAWKMUhsaR0tPRVIjjs1LvIxfzKkeBnIr9XBny4H6S9JrIw
 ivIW51dt5El/9NX/y2ZJCNWrHXo14xBMR0nUXoMRHJ/75SQlbSgBPomF8qdBtSbshkzGDmw
 qw5FEh4+V09/jb75NkZug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y90Uydz35Pg=:p1V+Q/6lq7eO+HGxILnfOk
 5dL7ytwMdZ84jxvKmoDRfZF/f3gbCjeL1Ud9ypD0QtluCVpqVBn1sDH5S/EYn/lWhz4f37XVF
 gnaalFnIQKp737+ZP+lKJa++NX3112Vjcw4IpTWi5SBVcKD8Xgnj30l4D+RrPVb59LRAwWbsG
 RVcb66vz7wlRdfh5LUglNn2+ytOo8s1Oc4HneixyecKNogIQwicAkXr3II+nIHG5cfmKUoV8f
 ldIif5bQx99fYCM/TvJ/XZv2dtqibyOTE37sm+ZuYnMTViBlSHGIGRtp27uDG8Mnth8dvVv4d
 o9V4+sonszmpt5mAeLiVefykygUQxcx6UoRZzZwAtUHocOSESJv+FYcqvpgnkc9mMcXRHkRfH
 VHYz8+lnszyEssjSLyjUoX624qcP8Hx9SKoa44iH7XeoqQJpLSHQGRvM+JXz9pJdFRvywrAD+
 36nQKvbJXjl429H0drtpZ6PohCQGpxi+7VanUNw2gffZQclgRTAcgq6Dti/bJKSGvlqlOzmRx
 DZ/A0OdNsuG56DDyAE5gKYrL7Rc7yp35UGnNsBQXGZ+e/5Xj9fL4GkTatjqzD41hUhQP3dmD8
 l9tL8wcUJisezPlwt7Xgy0Sk9Z3V8SVSw9XkYi5xioLtwta2b0+VvCUe74GfaR+87x9VoVdbS
 KikK4RHsioueSp3hc6+3Xs7e1m2GDaJXHWR1czz0v/GrmP/Zh91ngExUaidNKP0dW7imrgIKx
 SbU/rN9nGHwIH966p7LekN/1epP8Za3sE+nJtERdfcGi/9xoDXZ4mW2+Hxp9YyeyAqkLHb1nC
 8Y+kRFCnZmXQE31xmH9YwOq8dlJ+sjte8FDjJ3buV92w4R5pzUPgAfirX8Mhaa+TiseImHeS8
 16039Qa1pt2PzSgno7jf38+/1oSBIDetXoVH0FgHBjY/tpe4RoHW2MfunXEBSSWBMZfH+Hthd
 SpNyPssSx4fEi9ojFYeEK33jRJxhjWx0mvKSaeYnXLah0Rbgyb4m+8mr/TuWt8XAaziD7MKCd
 rLkJ4pQb6jTulCVc0LxEdNMPuVEMq4Yihg1bht3/WweyFyA1MW0cPWV4LPok8J1wprur6ieqK
 1OSwZWg24qCpUIyx1TpjmJt7aUbV8H8l5yfvCgDfsUa3JN4WrehzCYGWA0waGoPHmoZbVwBBg
 rtk1hCxw0zI06+wc7oPlXqXRAX9Zjwfbcw6rpY7AeI+jr77d7BB87B8Vsv9f6F+NVXPTcRwh8
 +iMxquCoPIzf89quI
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 16 Jun 2020, Jeff King wrote:

> On Mon, Jun 15, 2020 at 12:50:15PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > To allow for overriding the default branch name, we have introduced a
> > config setting. With this patch, the `git submodule` command learns
> > about this, too.
>
> This was the other reading case (besides guess_remote_head()) that I'm
> most concerned with causing regressions in a world where some repos are
> on "master" and some are on "main".
>
> This value ends up as the output of "submodule--helper remote-branch".
>
> I was initially worried that we used this branch name for the fallback
> when the server doesn't allow us to fetch the sha1 directly, but it
> doesn't look like it. That's good, because handling fallbacks there
> would be tricky.
>
> Instead, we seem to use this only after fetching all of the refs for a
> submodule:
>
>   $ git grep -h -B2 -A11 remote-branch git-submodule.sh
>   		if test -n "$remote"
>   		then
>   			branch=3D$(git submodule--helper remote-branch "$sm_path")
>   			if test -z "$nofetch"
>   			then
>   				# Fetch remote before determining tracking $sha1
>   				fetch_in_submodule "$sm_path" $depth ||
>   				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'=
")"
>   			fi
>   			remote_name=3D$(sanitize_submodule_env; cd "$sm_path" && get_defaul=
t_remote)
>   			sha1=3D$(sanitize_submodule_env; cd "$sm_path" &&
>   				git rev-parse --verify "${remote_name}/${branch}") ||
>   			die "$(eval_gettext "Unable to find current \${remote_name}/\${bran=
ch} revision in submodule path '\$sm_path'")"
>   		fi
>
> and then we just use that branch name to resolve a sha1. So this will
> break cases where you've set init.mainBranch, the submodule repo is
> still on "master", and you haven't configured a branch in .gitmodules.
>
> It seems like, independent of any change in the default branch names, we
> ought to be using $remote_name/HEAD for this case anyway. I suspect that
> would be a behavior improvement by itself, as it means more cases could
> avoid having to specify the branch name in .gitmodules manually.
> Probably nobody noticed so far because "HEAD" is almost always "master"
> in the current world. It technically breaks the case that you truly did
> want to use "master" in the submodule, but they set HEAD to something
> else, and you couldn't be bothered to put it into your .gitmodules file.
> That seems rather unlikely to me.
>
> And then everything would Just Work without having to worry about the
> local mainbranch value at all.

This is the route that I am taking.

Please note that t7519 contains a few test cases that rely on the current
confusing behavior where `git submodule update --remote` fetches the
remote `master` even if that is not the remote repository's current
branch!

I did adjust t7519 to stop verifying this confusing behavior, and to
verify the saner behavior instead.

This is of course a bit worrisome, as there might actually be users out
there relying on the confusing behavior.

However, I think it is okay to fix this:

- The `git submodule update --remote` command does not strike me as
  awfully common. In fact, I had never heard of it before I worked on this
  here patch.

- Current Git's behavior when running this command is outright confusing,
  unless the remote repository's current branch _is_ `master` (in which
  case the proposed behavior matches the old behavior).

- It is actually easily fixed by setting `submodule.<name>.branch` to
  `master` _iff_ users want to reinstate the old behavior.

> Alternatively, submodule--helper could pass back the empty string for
> "no, we don't have a configured branch name" and this shell code could
> actually try a sequence of reasonable guesses: init.mainbranch, then
> "master" (and between the two, "main" if that later becomes the
> default).

Quite honestly: I'd rather not.

Thank you,
Dscho
