Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C80EC433EF
	for <git@archiver.kernel.org>; Mon,  2 May 2022 15:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383291AbiEBPGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 11:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbiEBPGe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 11:06:34 -0400
X-Greylist: delayed 1011 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 May 2022 08:03:05 PDT
Received: from dalaran.tastycake.net (dalaran.tastycake.net [IPv6:2001:ba8:0:1c0::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E681910FFC
        for <git@vger.kernel.org>; Mon,  2 May 2022 08:03:05 -0700 (PDT)
Received: from b.8.0.0.8.9.b.0.2.f.0.9.2.a.d.b.d.a.0.2.5.1.e.d.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:de15:20ad:bda2:90f2:b98:8b] helo=lucy.dinwoodie.org)
        by dalaran.tastycake.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <adam@dinwoodie.org>)
        id 1nlXJS-0006gm-WE; Mon, 02 May 2022 15:46:11 +0100
Received: from adam by lucy.dinwoodie.org with local (Exim 4.94.2)
        (envelope-from <adam@dinwoodie.org>)
        id 1nlXJS-002x9c-D1; Mon, 02 May 2022 15:46:10 +0100
Date:   Mon, 2 May 2022 15:46:10 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Lessley Dennington <lessleydennington@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] t9902: split test to run on appropriate systems
Message-ID: <20220502144610.fyxns33cfrpa5gsy@lucy.dinwoodie.org>
References: <20220408095353.11183-1-adam@dinwoodie.org>
 <220408.86v8vjbzen.gmgdl@evledraar.gmail.com>
 <20220409153626.qqn23c7vsw4ftges@lucy.dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220409153626.qqn23c7vsw4ftges@lucy.dinwoodie.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 09, 2022 at 04:36:26PM +0100, Adam Dinwoodie wrote:
> On Fri, Apr 08, 2022 at 12:56:30PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > 
> > <snip>
> > 
> > I converted all the straightforward cases, where these tests were either
> > a bit misleading, or we'd actually skip testing on some systems
> > needlessly e.g. if they supported \t in a name but not \n.
> > 
> > This leaves only 8 remaining cases of FUNNYNAMES, all of those similarly
> > seem like subtle potential issues. I.e. we're creating files with
> > characters like "?" or "*" in the name.
> > 
> > But the prerequisite never checks for that, we're just implicitly
> > assuming that a FS that can do [\t\n"] an also do [*?+] or whatever.
> > 
> > In the case of the "rm" test we'd unconditionally create a file with a
> > space in its name, but then conditional on FUNNYNAMES remove it.
> > 
> > <snip>
> 
> That's a significantly neater patch than I was expecting!  I can see
> Junio's added my quick fix for the v2.36.0 rc; what's the process from
> here in this circumstance?  Wait for v2.36.0 to be released properly,
> then submit the patches?
> 
> Fixing t9902 using the same scheme as above adds the diff below, after
> applying the patch above to the v2.36.0-rc1 tag; I've confirmed this
> works as expected on Cygwin, with the test gated by FS_NAME_TAB passing
> and the test gated by FS_NAME_BACKSLASH being skipped.
> 
> <snip>

Ævar, are you able to submit your patch here to provide the better
long-term fix?  Once you've submitted your signed-off version, I can
submit the t9902-specific changes on top, or I'm happy for you to just
integrate them into your commit if that's easier.
