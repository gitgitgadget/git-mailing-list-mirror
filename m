Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF73E1F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 07:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757445AbcIHHaq (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 03:30:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:53791 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752815AbcIHHan (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 03:30:43 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LnxVE-1b6d9M37yC-00g1J6; Thu, 08 Sep 2016 09:30:00
 +0200
Date:   Thu, 8 Sep 2016 09:29:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix a segfault caused by regexec() being called on
 mmap()ed data
In-Reply-To: <20160906182942.s2mlge2vg65f5sy4@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609080921030.129229@virtualbox>
References: <cover.1473090278.git.johannes.schindelin@gmx.de> <xmqqwpiqp3ho.fsf@gitster.mtv.corp.google.com> <20160906071255.ggsoj2lh2f3kubhj@sigill.intra.peff.net> <alpine.DEB.2.20.1609061521410.129229@virtualbox>
 <20160906182942.s2mlge2vg65f5sy4@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Vr3vCVMAgLBjcTw6pm0unRssPvXtvV5TWtqsRvYnFGlxiNxivX7
 ph6NqsZ87sFbSH/6kG+eLXLhFDliEtVVZHXUrCuDenQm2pO2vpyFAhT/tFwwPubDVs7Esy+
 yEXfIZH6PMR/m4zxKx+y29/plNv0U/A9c3rlJyaglYOU7zdTelFdMUN5J5QAHxZjSUDyqy1
 R/WUVNEbCGZMocdkXKtBw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ymYcghty8fc=:h/n+jdGlhsAfiRfxy8GbZZ
 2EoQKpyuhu7Kj+TsDaDYkYkgmjfkLsZvWS1gqDpisDtvOVpKUiEq+EIhSBe7IvNZ2pCsvRON5
 IT5V/eOpdYAmBfdLQjvPVFWJFfgb5zGG1YWoirLehWQyWGD2b57wi8aCJdNibSVKt9T8KWlmk
 AsjkRgW6cGOfBYzlDCtTG9jNNvI4sr7d+nPayCfTl6ZDomE/zq41I3vmSyQ2dET79G897PZus
 V/z5wbAqdYfGDOjeJPQxcGahF78WzPo4ErSaoIW601gDNEePS1xSwXEjh+Ela/+1jtW5DKcZs
 D5qWRoDAayQtFheRel21Esg3Nezaj4pg8kK7xge6i79iduVjPD62DPTv/huaZfycF8ES5kz1z
 5PC+xjZ1eTlGuR91Qne1AXeAJGmYNfLHo/f/LmdNcS4wjLkQR90jK14z6d4egodRbnvPE3LL/
 ljJPuGrrY22MGqhJiqVj45j/k8kzlv+qm7Fg4O/nO/tkuBvg/32tWpCffAtAsj6zJMS9PjdSM
 TsFKzB65wv0FWjnA8r9cImXIvr2ZRR1EoLGPnS50OxBAg0eSJZlT2l8q+RGEMerwfz4/pw7ip
 6jT9W3rlLcK9E56KwcUlGNqDV2ZzouLI3cjftvKPPjpisF5e/ukXdcXXIushtPSoernBQqun8
 MfVoLiFrh9YI/27sQ5gw0fGjXP/wVl/nuA2xGlk8swxoPMjVbUKOA93OCsfV1iagQuL7GcFX3
 nH2tjFqvGFJPgax2Fl7yguNdQjt5aaap8ZdP8jGp9EnpyDzqz/Tkk45FF50afIOS95Tuq0f+u
 Hj55l7z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

sorry for the late answer, I was really busy trying to come up with a new
and improved version of the patch series, and while hunting a bug I
introduced got bogged down with other tasks.

The good news is that I made up my mind about releasing a Git for Windows
v2.10.0(2): originally, I had planned to do that today, to have time for
any hot fixes until Sunday, if necessary, before going semi-dark.

FWIW I am now trying to track my plans for v2.10.0(2) (or v2.10.1, if
upstream Git v2.10.1 is released before) on GitHub:

	https://github.com/git-for-windows/git/milestone/3

On Tue, 6 Sep 2016, Jeff King wrote:

> On Tue, Sep 06, 2016 at 04:06:32PM +0200, Johannes Schindelin wrote:
> 
> > > I think re_search() the correct replacement function but it's been a
> > > while since I've looked into it.
> > 
> > The segfault I investigated happened in a call to strlen(). I see many
> > calls to strlen() in compat/regex/... The one that triggers the segfault
> > is in regexec(), compat/regex/regexec.c:241.
> 
> Yes, that is the important one, I think. The others are for patterns,
> error msgs, etc. Of course strlen() is not the only function that cares
> about NUL delimiters (and there might even be a "while (*p)" somewhere
> in the code).
> 
> I always assumed the _point_ of re_search taking a ptr/len pair was
> exactly to handle this case. The documentation[1] says:
> 
>    `string` is the string you want to match; it can contain newline and
>    null characters. `size` is the length of that string.
> 
> Which seems pretty definitive to me (that's for re_match(), but
> re_search() is defined in the docs in terms of re_match()).

Right. The problem is: I *really* want to avoid using GNU-isms.

> > The bigger problem is that re_search() is defined in the __USE_GNU section
> > of regex.h, and I do not think it is appropriate to universally #define
> > said constant before #include'ing regex.h. So it would appear that major
> > surgery would be required if we wanted to use regular expressions on
> > strings that are not NUL-terminated.
> 
> We can contain this to the existing compat/regexec/regexec.c, and just
> provide a wrapper that is similar to regexec but takes a ptr/len pair.

But we can do even better than that: we can provide a wrapper that uses
REG_STARTEND where available (which is really the majority of platforms we
care about: Linux, MacOSX, Windows, and even the *BSDs). Where it is not
available, we simply malloc(), memcpy() and append a NUL.

Which is what my v2 does (will send it out in a moment).

Ciao,
Dscho
