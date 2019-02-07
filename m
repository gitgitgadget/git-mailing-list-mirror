Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFD7D1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 16:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfBGQ6V convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 7 Feb 2019 11:58:21 -0500
Received: from elephants.elehost.com ([216.66.27.132]:61408 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBGQ6V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 11:58:21 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x17GwE39099492
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Feb 2019 11:58:14 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?iso-8859-1?Q?'Torsten_B=F6gershausen'?=" <tboegi@web.de>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
Cc:     "=?iso-8859-1?Q?'SZEDER_G=E1bor'?=" <szeder.dev@gmail.com>,
        "'Jeff King'" <peff@peff.net>, <git@vger.kernel.org>
References: <nycvar.QRO.7.76.6.1902061123410.41@tvgsbejvaqbjf.bet> <20190206104243.GJ10587@szeder.dev> <nycvar.QRO.7.76.6.1902061450280.41@tvgsbejvaqbjf.bet> <20190206171517.s5lskawpdodc74ui@tb-raspi4> 
In-Reply-To: 
Subject: RE: t0025 flakey?
Date:   Thu, 7 Feb 2019 11:58:08 -0500
Message-ID: <001501d4bf06$506b8640$f14292c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJs/IuaaCkX8/5Ult+TIwKZwFHx1AHYuM18APJkJqYCro2vgqR2wojwgAGC4SA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 6, 2019 13:01, I wrote:
> On February 6, 2019 12:15, Torsten Bögershausen wrote:
> > To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Cc: SZEDER Gábor <szeder.dev@gmail.com>; Jeff King <peff@peff.net>;
> > git@vger.kernel.org
> > Subject: Re: t0025 flakey?
> >
> > On Wed, Feb 06, 2019 at 02:52:53PM +0100, Johannes Schindelin wrote:
> > > Hi Gábor,
> > >
> > > On Wed, 6 Feb 2019, SZEDER Gábor wrote:
> > >
> > > > On Wed, Feb 06, 2019 at 11:25:38AM +0100, Johannes Schindelin
> wrote:
> > > >
> > > > > at first I thought that those intermittent test failures were
> > > > > limited to Windows, but they are not: I can see it now in a
> > > > > build on 32-bit Linux.
> > > > > Full logs here:
> > > > >
> > > > > https://dev.azure.com/gitgitgadget/git/_build/results?buildId=10
> > > > > 32 &_a=summary&view=ms.vss-test-web.build-test-results-tab
> > > > >
> > > > > Excerpt from the failing test case:
> > > > >
> > > > > -- snip --
> > > > > not ok 2 - renormalize CRLF in repo  expecting success:
> > > > > 	echo "*.txt text=auto" >.gitattributes &&
> > > > > 	git add --renormalize "*.txt" &&
> > > > > 	cat >expect <<-\EOF &&
> > > > > 	i/lf w/crlf attr/text=auto CRLF.txt
> > > > > 	i/lf w/lf attr/text=auto LF.txt
> > > > > 	i/lf w/mixed attr/text=auto CRLF_mix_LF.txt
> > > > > 	EOF
> > > > > 	git ls-files --eol |
> > > > > 	sed -e "s/	/ /g" -e "s/  */ /g" |
> > > > > 	sort >actual &&
> > > > > 	test_cmp expect actual
> > > > >
> > > > > + echo *.txt text=auto
> > > > > + git add --renormalize *.txt
> > > > > + cat
> > > > > + sort
> > > > > + sed -e s/	/ /g -e s/  */ /g
> > > > > + git ls-files --eol
> > > > > + test_cmp expect actual
> > > > > + diff -u expect actual
> > > > > --- expect	2019-02-06 09:39:42.080733629 +0000
> > > > > +++ actual	2019-02-06 09:39:42.088733629 +0000
> > > > > @@ -1,3 +1,3 @@
> > > > > -i/lf w/crlf attr/text=auto CRLF.txt
> > > > > +i/crlf w/crlf attr/text=auto CRLF.txt
> > > > >  i/lf w/lf attr/text=auto LF.txt -i/lf w/mixed attr/text=auto
> > > > > CRLF_mix_LF.txt
> > > > > +i/mixed w/mixed attr/text=auto CRLF_mix_LF.txt
> > > > > error: last command exited with $?=1
> > > > > -- snap --
> > > > >
> > > > > Any ideas?
> > > >
> > > > I reported this and Peff looked into it on the way to Git Merge,
> > > > but not working solution yet.
> > > >
> > > > https://public-inbox.org/git/20190129225121.GD1895@sigill.intra.pe
> > > > ff
> > > > .net/T/#u
> > >
> > > Thank you!
> > > Dscho
> >
> > I shortly looked into the pointers here - Is t0025 flaky after the fix
from
> Peff:
> >
> > [PATCH] add: use separate ADD_CACHE_RENORMALIZE flag
> >
> > Or has it always been shaky ?
> > Does anybody know ?
> 
> The NonStop port has traditionally had issues with t0025, which we tended
> to ignore because things did work. We wrote those off as bash issues in
> t0025 since they seemed to be corrected when we picked up a new bash
> version about a year ago. I will keep monitoring this, particularly when
2.21
> comes out.

FYI: t0020-t0027 all passed on the NonStop port for 2.21.0-rc0 - so no
issues for us on this one.

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



