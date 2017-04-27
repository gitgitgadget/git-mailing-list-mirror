Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3556A207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 22:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937845AbdD0W5Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 18:57:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:55726 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751277AbdD0W5P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 18:57:15 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1WHV-1dxDvI29NZ-00tSrp; Fri, 28
 Apr 2017 00:57:09 +0200
Date:   Fri, 28 Apr 2017 00:57:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/26] setup_bare_git_dir(): fix memory leak
In-Reply-To: <51f2bd16-7c55-7ba0-c963-6f725b2f79e5@kdbg.org>
Message-ID: <alpine.DEB.2.20.1704280056070.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <042b3e98e9e5b8850c35103cc56cf651b2fb3f6e.1493237937.git.johannes.schindelin@gmx.de> <51f2bd16-7c55-7ba0-c963-6f725b2f79e5@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ltHLcT5FjST0F3gMzBdAigARlMH4lBx1PL3q9LB9Yilv0UGEWW6
 j5WOgKa61l1H2ySJ+SzsMX69oWyjYKshwSmcwaM8sR9Qdnsvk3zdYhRx62WtI3XF+VnrVPd
 kMLouFccWNib63PBMG3FSSEsJw4HSZMvd5K/NfWntABqITsagiXo7BkL5XiTRhRqbPql/5l
 z/kn3u60Fb1o7+Zd9Ukag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kOaoMIIcW7Y=:12TqISJc3RBgdQBOtp7CBD
 8OrWp6yTuAmCvDvACxP8Dd4HrIR7hdSeH89TIJYPAFamfBiNuRJgZhNoIM0NIzhhuewJC0gAl
 7PSUOOa31oSnN/5sWjiFh5ruR792+boGmW13r3hi/if3zoz+TWG+EVcTwyT630mnLqbEWsgGc
 4Z/+bZFWuKz0SxtfvAuTXHn1Crlvy4/6TbfA441v8SPxhbt4EHXUKFO1F8Koq9b6lmQcWrJaj
 sAWG353cSVuNZbyts4wenbIy1dhgKVcJpEXQn24+XMPqzZ73pfnIni259IkxihWxn3MYlI8md
 /3dH/vHQptsXrT/oKOd67ipp4MSEMEWuMUMY2CHcQOoR8THi38yimHz10276UoAqKMsC8OV0z
 CfCrS2jpEu6tXtcWmh8lRcofkvVSGaG+oKoeK+7ZXtx1My/e7Lu6ichmRncgAqsbLEVLsEehy
 hrQkVktbzPxyi8fdACHKbH3ZZWmSf5kaTbi9esw+ujOU3CZi9xOZw7B2eTh5w2cqlvWEOa3Ap
 kz1B3IEPgct2Zu0dTq5a+GT90QEN6ePOsSFiqol9ver8Z9dfM9gxT+XRxvEQSIXH17toghBFb
 Ymt5wjYoDhA4e5Juvef3l8Jr9HeFYa2E4KMd3AFJ1liFVnN3dnR6NZ/EGF8B7e3xPIZvEE9h9
 m/hvaeLKKx8/AJID+Bca549GJT5TB8y716LR6LhLTnK60Swh8It10oueYsvy45ZnyfqxENbSL
 YBJrgpVVkUOcTz2p0bLpm/G1k/H5OKOZd7vd9RYbZ+W9IPEXkGHYyf9xwPhpoZsZRkJuVgEIz
 Rm09Ypo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Thu, 27 Apr 2017, Johannes Sixt wrote:

> Am 26.04.2017 um 22:20 schrieb Johannes Schindelin:
> > Reported by Coverity.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  setup.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/setup.c b/setup.c
> > index 0309c278218..0320a9ad14c 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -748,7 +748,7 @@ static const char *setup_bare_git_dir(struct strbuf
> > *cwd, int offset,
> >
> >   /* --work-tree is set without --git-dir; use discovered one */
> >   if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
> > -		const char *gitdir;
> > +		static const char *gitdir;
> >
> >    gitdir = offset == cwd->len ? "." : xmemdupz(cwd->buf, offset);
> >    if (chdir(cwd->buf))
> >
> 
> Whoa! Look what values are assigned to the variable: Either a static string or
> allocated memory. I suspect that this does not fix a memory leak at all, but
> only shuts up Coverity.
> 
> -- Hannes
> 
> PS: stopping here as I'm running out of time.

Sorry, I meant to amend the commit message and forgot before sending the
first time: setup_git_directory() (and consequently, setup_bare_git_dir())
can only be called once.

Yes, this patch is here to shut up Coverity, as it cannot know that we are
talking about a singleton here.

Ciao,
Dscho
