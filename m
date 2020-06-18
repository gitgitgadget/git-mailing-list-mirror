Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5645CC433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 10:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B1B21548
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 10:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FYnsLkUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgFRKJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:09:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:39647 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728798AbgFRKJO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 06:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592474931;
        bh=yTCoZYiZ0ao2ZWnDjyKButXcxXWLtx6mlDefk1Fg4U0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FYnsLkUC/0+DTipf2ipZnrn3kYD4v90pqAU4/tplL1XkT5ygrl5z/1vQJuFpnCjAb
         ngOz5jW+ZksMxyp/x4UU5LnBBESfjWey0cPKXHvnZQqsWS9MSCpeSdhZm3r/nbz0hU
         VknTPGbz5i4uJ2xjpnXNGVaZAW6b0vsOqop3csN0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.215.12]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhlKs-1jHBUB3BhI-00dqpZ; Thu, 18
 Jun 2020 12:08:51 +0200
Date:   Thu, 18 Jun 2020 12:08:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 05/12] fast-export: handle overridden main branch
 names correctly
In-Reply-To: <20200616131039.GG666057@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2006181208180.54@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <a3be4f39aa240e614a2e12756e1ea864c35137a2.1592225416.git.gitgitgadget@gmail.com> <a0982afb-8c44-aeff-1839-6e0aa897fcf2@gmail.com>
 <20200616131039.GG666057@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1ht7XlHv/CMbXsXw182Rzyujd9oYHev8F/AnujdDTxsPrR0LfsM
 xbHH5y8LapD8hg5a5FQbI8dnfWNjA/WBSMJW9yIX0/eYtvyHUEEC3oSDSPPYErykY7pyTUh
 M2AOX6sEQ9ZhARVn2i6ny4pFobXXUytLpIIX/Op0b48VaRgeyQzChhA+SBj2qe3O7fRPuaf
 fuyHIfUiiTYPRBCt0nF+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ixQbl1c/3Hg=:kIB5V7RCk1h18bXpWjDb2G
 PdBTkmBM4JKNmD1dY7DTTiQ+XN379x2Vz+WFszomtuQPhsM+9jsPz/W6gP/6LPxWenyIrVaiS
 7Ak+nzMXqTJMbVn6IQ12qUAOhz/CqUe7YMEii4GUxtjcei7et1zVDwjO19zafUgIGLUMY11oo
 0WUeIZEtjrWfrUaxMThLlCX7VajRWCgjOrMqomSiLcYTU0mfM6HIHroewF8MPI89QJAO2RsdB
 59gEJfYm4li74BH7sbEZW91TVYpr+NTWVYWmYOEPa5oEtLfmx7zIjTiPTbVordLIeShTOlUUN
 3+9+92QIIMxm8Au8zEdKlTJjRNcYlqMGWzXc6v2Ubx63qGnRK7pZAmErcgO4ilUAdoOD6m/DJ
 mMf78d565Fz4BHZV8PQamsOTLJJF1IFJLvW69SeTCecTzwGL0FRqlF/oBKNJ+6Xl/QO8D3VYE
 eKpyjRECcxpImgIbeDuZifTqsrHLlZyYaV0rTRKsSNQqxtnPLgA1irTC83mKb6eYmt89WtTF8
 lA3Ko5vAOEYXM3PwxVRR58XgahAmruNq8t266/99Wkl8c0dO5WYL0G5QflPxpzU533cgJ26aM
 2tFKMAlt9+WbdnWkSiU2135CwRRfBYCCo2DfCI14uakmciqQTKnXuaV7mbPE+gozTmjoRWQ6E
 S3TiRIIzLcqBQZwUyU7+mF6NqCxAw7sxlTFexAqvlcaZimrKmvY9Mt1959LFhXTzpaeiv4/CL
 Qe2t6pzdWUr5MGblBeDtInKYSUM502eVaHcTev85GOaUTYuCTW5mjbgRVymYkegBfOFxaAzvH
 nHkitVgA2vhuvZTLYcaIC4NeU5p2pTrogY1ex17hv+yAJZb4+ENA9qMvxRpMMZv42Yq8+kxRH
 uPa6TSW4nM5NwaUwLyKkW8g6o//C7/D2qZPvLRcdcKIxr316vVOtojjhlZm7fB3lxxmmJjz84
 tx/y12mbl0TbC4b4jUD9hemezF66JIIhfLFt+wcqS3Xpb6FqKlrD6qI57CgWr4s+v9RjmB13n
 ep/T9MYwCbxUIC49TZAjyceOyLWiXeKDyKSdI+FfOPsICbrjeIyDf+zjV4NafJTh2GQAVAdWb
 SFuaMr3cUgAnGnTMJrhnyqDhWS8RdjWjp4+RyVZKuSab6KnoqvkMq04WlusTM+VaNc9stVVNL
 ++0spnwCL7RPO4D76IScF2WTIKq3m2DA6M+z+VcdOKF/YzV1ura29E6b7ve+tXPp1kDCzzpXY
 YZje6ro7nizoDzKrm
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 16 Jun 2020, Jeff King wrote:

> On Mon, Jun 15, 2020 at 04:05:52PM +0100, Phillip Wood wrote:
>
> > > @@ -515,14 +515,23 @@ static const char *anonymize_refname(const cha=
r *refname)
> > >   	};
> > >   	static struct hashmap refs;
> > >   	static struct strbuf anon =3D STRBUF_INIT;
> > > +	static char *main_branch;
> > [...]
> > > -	if (!strcmp(refname, "refs/heads/master"))
> > > +	if (!main_branch)
> > > +		main_branch =3D git_main_branch_name(MAIN_BRANCH_FULL_NAME);
> > > +
> > > +	if (!strcmp(refname, main_branch))
> > >   		return "refs/heads/ref0";
> >
> > This leaks main_branch if it came from git_main_branch_name()
>
> It's a static that's used over and over, so I think it's intentional to
> essentially memoize it for the life of the program (at which point we
> could free it, but don't bother to do so, letting the process exit take
> care of it, and trusting in leak detectors to be aware that it's still
> reachable, as we do for lots of other process-lifetime allocations).

That is indeed the intention, and I will edit the commit message
accordingly.

Thanks,
Dscho
