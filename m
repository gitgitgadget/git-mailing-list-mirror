Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C97A1F859
	for <e@80x24.org>; Sun, 14 Aug 2016 11:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933028AbcHNK75 (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 06:59:57 -0400
Received: from mout.web.de ([212.227.15.3]:59435 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932645AbcHNK7z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 06:59:55 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MTgqe-1bhaIi0T7w-00QQ3y; Sat, 13 Aug 2016 23:18:08
 +0200
Date:	Sat, 13 Aug 2016 21:18:05 +0000
From:	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	git@vger.kernel.org, peff@peff.net, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v1 1/2] t0027: Correct raciness in NNO test
Message-ID: <20160813211805.GA10624@tb-raspi>
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
 <1471020662-20746-1-git-send-email-tboegi@web.de>
 <57AF4FCB.7090409@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57AF4FCB.7090409@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:cGHzTcU6NEdLDOWvPL3n62qDIo+YwiDg39bu56fFOxXLD8J7aHg
 rf86vTsrl8AWg18+mh+2Sq58uJrPHoOZ7cVCOa7zpc3dmgPURiwSW8DwO0odZzmQneGtmWy
 8JKxGyl2QlANNaWW4diTTz3C+T+vQt36UrrjBvn3WMWnFERmj2mr9/JhyH26cOuBEPFZwLG
 vuaTjE9wS7Sye5vEhGICg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:L2RPzGyVFfc=:CX5Q2AR5GMN0hpByfu58KP
 oPueNSb8y/y17P7GbxTsdGVWafsbivs9qcfz1CzF6WqbB6PtUbQfXUdKUYJc7m6sZfdR5mHMS
 D/FucoWQi565TyFx6n1aDTP1GqZrL2NaX7GzYNLAEPlkK+fbTDc44VnH8LwFuSGvldX/cUUjn
 R3y8umYSCpENpgJqYfaUozTXR/DfE4s9J3CbJnxlYdEYPuR9cb8ZGrAJoNMVnwLHzmDMViOHj
 frkitjbLeAlZLFAhK5teou8O7Azlzg7WSBRPBgLWtSbaylCkjexa6Ocydx0nMZmyvYHX0Npib
 Np51bF4iWrXDcYieIIblVzUFZoAQ1irINl1LgafFDJuv0554arCqiKOSQTHvpsaA23FYrXwE1
 FeTi+PNB5QvPaOmjTePI43yIIGorU+Bh9LDLy+pY9XHNWmTxBpMsf7snsRrNcql0XL0Ahv+Kq
 +pob7LAeQZZGF8mn8uT+pblCYzDmr1ZNqJnlDF444BIc+jZgouVqkvtMmgFkoiSzPikcbWR2q
 XsMWJlP2RtTwemoSXMPxCsBmVLDzssBDjKrXtbbtZohh/xf7TBkv+KPexvxe0aiSS7zuJzuh2
 46wlxD9pewTc9SJ7bzIFX8BRGpe8dJiOdSr/tm9EfU2ZIh1Wji/PwciHzqK3ZbQAOq/0HT3Wg
 Z2r9HhPPNrZmk+RatSpXTv28qR9gvBWu/PtHLYTzHedMRWKLoNhk7Zi/tK8OSgpQOOotTvn+s
 +FWKVukbJtRTbs0ZpA1BU945lD2VmQwWZepELo8N5eYU2ZmSz118mPbGRvg=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Aug 13, 2016 at 06:50:19PM +0200, Johannes Sixt wrote:
> Am 12.08.2016 um 18:51 schrieb tboegi@web.de:
> >From: Torsten Bögershausen <tboegi@web.de>
> >
> >When a non-reversible CRLF conversion is done in "git add",
> >a warning is printed on stderr (or Git dies, depending on checksafe)
> >
> >The function commit_chk_wrnNNO() in t0027 was written to test this,
> >but did the wrong thing: Instead of looking at the warning
> >from "git add", it looked at the warning from "git commit".
> >
> >This is racy because "git commit" may not have to do CRLF conversion
> >at all if it can use the sha1 value from the index (which depends on
> >whether "add" and "commit" run in a single second).
> >
> >Correct this and replace the commit for each and every file with a commit
> >of all files in one go.
> 
> The new test code does not only fix the race condition, but also
> tests different things, or prepares test cases in a different
> manner. I would have appreciated an explanation why this is
> necessary. Is it "on my machine, the race condition was triggered
> consistently for a bunch of tests, and so I recorded the wrong
> expected output in the test cases"?
> 
Good point. The origanal intention was to let t0027 pass, and fix
the bug in convert.c in a later commit.
(and rename NNO in a 3rd commit, that is postponed until we figured this out).

Looking at t0027, it turns out that the changes in the test matrix done in 1/2
are reverted in 2/2.
This is not a good thing.
Either (a) they should be marked as test_expect_failure in 1/2 and
corrected in 2/2,
or (b) 1/2 and 2/2 are squashed together and the noise in t0027 is minimal.
I'll send a patch for (b) in a second.
