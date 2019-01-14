Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 015CC211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 18:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfANS1H (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 13:27:07 -0500
Received: from elephants.elehost.com ([216.66.27.132]:25670 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANS1H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 13:27:07 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x0EIR2nF023946
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 14 Jan 2019 13:27:03 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Barret Rhoden'" <brho@google.com>
Cc:     <git@vger.kernel.org>, "'Stefan Beller'" <stefanbeller@gmail.com>,
        "'Jeff Smith'" <whydoubt@gmail.com>, "'Jeff King'" <peff@peff.net>
References: <20190107213013.231514-1-brho@google.com>        <xmqqbm4s6ozl.fsf@gitster-ct.c.googlers.com>        <20190108112742.7878d4cb@gnomeregan.cam.corp.google.com>        <xmqqimyz57l9.fsf@gitster-ct.c.googlers.com>        <20190109154828.1b19dbb4@gnomeregan.cam.corp.google.com>        <xmqq1s5k16zj.fsf@gitster-ct.c.googlers.com>        <20190114101956.2b899d0e@brho.roam.corp.google.com> <xmqqfttvw2sv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqfttvw2sv.fsf@gitster-ct.c.googlers.com>
Subject: RE: [PATCH] blame: add the ability to ignore commits
Date:   Mon, 14 Jan 2019 13:26:56 -0500
Message-ID: <003c01d4ac36$bdf29470$39d7bd50$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJdJn21rWW0oLRiGldTBLKyYBC34gHyd15RAa7xDpABvDy68wHHH7MpAn7VxN8DZKZpVAIzKL+XpCQ+yyA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 14, 2019 12:46, Junio C Hamano wrote:
> Barret Rhoden <brho@google.com> writes:
> 
> > On 2019-01-10 at 14:29 Junio C Hamano <gitster@pobox.com> wrote:
> >> > For instance, commit X does this:
> >> >
> >> > -foo(x,y);
> >> > +foo(x,y,z);
> >> >
> >> > Then commit Y comes along to reformat it:
> >> >
> >> > -foo(x,y,z);
> >> > +foo(x, y, z);
> >> >
> >> > And the history / rev-list for the file looks like:
> >> >
> >> > ---O---A---X---B---C---D---Y---E---F
> >> >
> >> > I want to ignore/skip Y and see X in the blame output.
> >>
> >> If you skip Y, the altered history would have "foo(x, y, z)" in E,
> >> "foo(x,y,z)" in X, and "foo(x,y)" in A.  If you start blaming from F,
> >> you'd get E as the commit that explains the latest state.  If you do
> >> not skip Y, you'd get Y.  I am not sure how you'd get X in either
> >> case.
> >
> > The way to do it is ...
> 
> Sorry, I made a too-fuzzy statement.  What I meant was, that unless you
are
> ignoring E, I do not know why you "would want to" attribute a line "foo(x,
y,
> z)" that appears in F to X.  Starting from X up to D (and to Y in real
history, but
> you are ignoring Y), the line was "foo(x,y,z)", after E, it is "foo(x, y,
z)".  I
> didn't mean to ask how you "would show" such a result---as I do not yet
> understand why you would want such a result to begin with.

From my own community, this came up also. The intent was to show everyone
who touched a particular line, throughout history, not just the current one.
Perhaps that is what Barret is going for.

Regards,
Randall

