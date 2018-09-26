Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A1621F453
	for <e@80x24.org>; Wed, 26 Sep 2018 11:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeIZRyL (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 13:54:11 -0400
Received: from mail.pdinc.us ([67.90.184.27]:51768 "EHLO mail1.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbeIZRyL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 13:54:11 -0400
X-Greylist: delayed 2728 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Sep 2018 13:54:10 EDT
Received: from blackfat (five-58.pdinc.us [192.168.5.58])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id w8QAuHBs028758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Sep 2018 06:56:18 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail1.pdinc.us w8QAuHBs028758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1537959378; bh=NUMnIhSQrMDzf7dZWIP6AL/nM/2Q8LbyzeBhF1fWQ8g=;
        h=Reply-To:From:To:References:In-Reply-To:Subject:Date:From;
        b=bz3vr9dleAAR2W8S+7yED1bl3S+lOipQ9Q5ZjIC5mbKuXcBaYdDEK94/H9cpMTCmY
         XbN3evWWfW8KIHIMbFZktZDyj0ZV9PEfKJSiW0ZVDg8pUVW24R3oihSzaMvKl/Z498
         TAFeMjbIrnNI9LdHj8KvoBP+teYnWhL8U2V6NbR4LJ0UNvaxFbfqGVOYHiycaVdugZ
         /c2ExWRoT04qpkak6tEUtGHO786BXpC4K7rjkB7V906+1clSEIi5wW5yJ69o76pT18
         vmNItBkZgi0u3weajyDZOEjOa4GS1DxPvlRW0j+FYO+wPuyzQJNH5z35zppTm7ZlWr
         Vv4MLnCEUKeag==
Reply-To: "Derrick Stolee" <stolee@gmail.com>,
          "Ben Peart" <peartben@gmail.com>,
          "Git List" <git@vger.kernel.org>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     "'Derrick Stolee'" <stolee@gmail.com>,
        "'Ben Peart'" <peartben@gmail.com>,
        "'Git List'" <git@vger.kernel.org>
References: <4bcd63bf-648d-f3f6-dac8-aabe7ea1e480@gmail.com> <d92f18e2-0bbc-e36b-123a-3ed3f44cf418@gmail.com> <b46d6363-1709-968e-105a-3f4e8a77155e@gmail.com>
In-Reply-To: <b46d6363-1709-968e-105a-3f4e8a77155e@gmail.com>
Subject: RE: Git Test Coverage Report (Tuesday, Sept 25)
Date:   Wed, 26 Sep 2018 06:56:23 -0400
Organization: PD Inc
Message-ID: <551b01d45587$90b27f30$b2177d90$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIssIFrSCQa+B4/pdhMqhjD6J2bewGcScT+AoE2l7KkML+nUA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Derrick Stolee
> Sent: Wednesday, September 26, 2018 6:43 AM
>=20
> On 9/25/2018 5:12 PM, Ben Peart wrote:
> >
> >
> > On 9/25/2018 2:42 PM, Derrick Stolee wrote:
> >> In an effort to ensure new code is reasonably covered by the test
> >> suite, we now have contrib/coverage-diff.sh to combine the gcov
> >> output from 'make coverage-test ; make coverage-report' with the
> >> output from 'git diff A B' to discover _new_ lines of code that are
> >> not covered.
> >>
<snip/>
> >
> > I looked at the lines that came from my patches and most if not all =
of
> > them are only going to be executed by the test suite if the correct
> > "special setup" option is enabled.  In my particular case, that is =
the
> > option "GIT_TEST_INDEX_THREADS=3D<n>" as documented in t/README.
> >
> > I suspect this will be the case for other code as well so I wonder =
if
> > the tests should be run with each the GIT_TEST_* options that exist =
to
> > exercise uncommon code paths with the test suite.  This should =
prevent
> > false positives on code paths that are actually covered by the test
> > suite as long as it is run with the appropriate option set.
> This is a bit tricky to do, but I will investigate. For some things, =
the
> values can conflict with each other (GIT_TEST_SPLIT_INDEX doesn't play
> nicely with other index options, I think). For others, we don't have =
the
> environment variables in all versions yet, as they are still merging =
down.

Remember that the code coverage is cumulative, on one of my projects =
where I have similar special cases the automated build will run through =
a sequence of different build options (including architectures) and =
executions - then generate the final report.

Another thought would be to weight the report for "new lines of code" - =
which is the same we do for our Fortify scans. We take the git blame for =
the change range and de-prioritize the findings for lines outside of the =
changed lines. This could give a tighter focus on the newly change =
code's test coverage.

> >
> > I realize it would take a long time to run the entire test suite =
with
> > all GIT_TEST_* variables so perhaps they can only be tested "as
> > needed" (ie when patches add new variables in the "special setups"
> > section of t/README).  This should reduce the number of combinations
> > that need to be run while still eliminating many of the false =
positive
> > hits.
>=20
> This is something to think about. For my own thoughts, I was thinking =
of
> trying to run it when we see large blocks of code that are uncovered =
and
> obviously because of environment variables. This is what I was =
thinking
> when I saw your and Duy's commits in the output. I'll see if I can
> re-run the suite using GIT_TEST_INDEX_THREADS=3D2 and
> GIT_TEST_INDEX_VERSION=3D4.
>=20
> Thanks,
> -Stolee

