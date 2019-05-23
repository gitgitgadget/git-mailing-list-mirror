Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DAEB1F462
	for <e@80x24.org>; Thu, 23 May 2019 20:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387902AbfEWUTJ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 23 May 2019 16:19:09 -0400
Received: from elephants.elehost.com ([216.66.27.132]:12537 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfEWUTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 16:19:09 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x4NKIsFd019816
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 16:18:55 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Git Mailing List'" <git@vger.kernel.org>
References: <001501d5101e$db98dfb0$92ca9f10$@nexbridge.com> <20190522004825.GC8616@genre.crustytoothpaste.net> <004301d510a4$bbe362e0$33aa28a0$@nexbridge.com> <nycvar.QRO.7.76.6.1905232203130.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1905232203130.46@tvgsbejvaqbjf.bet>
Subject: RE: Issues with t7519.19, was RE: [Breakage] 2.22.0-rc1 t5401-update-hooks.sh
Date:   Thu, 23 May 2019 16:18:47 -0400
Message-ID: <006401d511a4$bdffbbe0$39ff33a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHMXCdBtn7xefigKEQDPm4zJf8pugKY8znQAUMMeCUB5HYAnKZci+dQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 23, 2019 16:06, Johannes Schindelin wrote:
> On Wed, 22 May 2019, Randall S. Becker wrote:
> 
> > On May 21, 2019 20:48, brian m. carlson wrote:
> > > To: Randall S. Becker <rsbecker@nexbridge.com>
> > > Cc: 'Git Mailing List' <git@vger.kernel.org>
> > > Subject: Re: [Breakage] 2.22.0-rc1 t5401-update-hooks.sh
> > >
> > > On 2019-05-21 at 21:47:54, Randall S. Becker wrote:
> > > > When running the test in isolation, it passes without incident
> > > > whether or not --verbose is used. So far, this only occurs on the
> > > > first run through. I wanted to report it, based on the
> > > > inconsistency of results. This is not the first time tests have
> > > > acted in this fashion, and I realize it is difficult to do
> > > > anything about it without being able to recreate
> > > the situation.
> > >
> > > Does running git clean -dxf cause it to be reproducible?
> >
> > I will give it a go. Having exactly the same behaviour in t7519
> > subtest 19. I wonder whether there are breadcrumbs not being cleaned
> > up. Will report back when I am able - may take a day or so.
> 
> I fear that t7519's problems are *completely* unrelated to the t5401 issue
> you reported earlier. I hunted the t7519 problems down today, and I could
> imagine that these patches fix your t7519, too:
> 
> 	https://github.com/gitgitgadget/git/pull/223

From the description, I believe it. Timestamp resolution on NonStop is in microseconds and those are not even slightly simulated. Coupled with this being an MPP not SMP, things can occur within the same microsecond, or in weird situations slightly before or after when comparing the clock on different CPUs. Yes, time-travel is possible at the single microsecond level 😉. Cores are synchronized, but our machine has 4 CPUs and synchronizing the file system across all of them does lead to slightly strange situations.

