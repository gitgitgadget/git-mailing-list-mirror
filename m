Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EDFB1F6BD
	for <e@80x24.org>; Wed,  1 Feb 2017 01:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750991AbdBABsI (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 20:48:08 -0500
Received: from smtpq2.tb.mail.iss.as9143.net ([212.54.42.165]:54189 "EHLO
        smtpq2.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750914AbdBABsH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 31 Jan 2017 20:48:07 -0500
Received: from [212.54.42.116] (helo=lsmtp2.tb.mail.iss.as9143.net)
        by smtpq2.tb.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <carlo@alinoe.com>)
        id 1cYk1X-0001vv-VC; Wed, 01 Feb 2017 02:47:52 +0100
Received: from h172167.upc-h.chello.nl ([62.194.172.167] helo=mail9.alinoe.com)
        by lsmtp2.tb.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <carlo@alinoe.com>)
        id 1cYk1X-0001q7-TG; Wed, 01 Feb 2017 02:47:51 +0100
Received: from carlo by mail9.alinoe.com with local (Exim 4.86_2)
        (envelope-from <carlo@alinoe.com>)
        id 1cYjRY-00017s-Jy; Wed, 01 Feb 2017 02:10:40 +0100
Date:   Wed, 1 Feb 2017 02:10:40 +0100
From:   Carlo Wood <carlo@alinoe.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git push failing when push.recurseSubmodules on-demand and git
 commit --amend was used in submodule.
Message-ID: <20170201021040.4f6cc827@hikaru>
In-Reply-To: <CAGZ79kbCfKVDq+9Pr5LmOtT=+uB+u+EMQg1=FUNS2umCvtvHhg@mail.gmail.com>
References: <20170129203348.1a8c0722@hikaru>
        <xmqqvasxwee1.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbCfKVDq+9Pr5LmOtT=+uB+u+EMQg1=FUNS2umCvtvHhg@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: carlo@alinoe.com
X-SA-Exim-Scanned: No (on mail9.alinoe.com); SAEximRunCond expanded to false
X-SourceIP: 62.194.172.167
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.2 cv=YdnN30Zf c=1 sm=1 tr=0 a=Sr+rG1RSRvb2GKWoPpN/Zg==:17 a=kj9zAlcOel0A:10 a=n2v9WMKugxEA:10 a=1XWaLZrsAAAA:8 a=ybZZDoGAAAAA:8 a=BjFOTwK7AAAA:8 a=Y6m7HPvqjSWfbygy7d4A:9 a=CjuIK1q_8ugA:10 a=nJcEw6yWrPvoIXZ49MH8:22 a=0RhZnL1DYvcuLYC8JZ5M:22 a=N3Up1mgHhB-0MyeZKEz1:22
 none
X-Ziggo-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 31 Jan 2017 14:08:41 -0800
Stefan Beller <sbeller@google.com> wrote:

> On Sun, Jan 29, 2017 at 5:00 PM, Junio C Hamano <gitster@pobox.com>
> wrote:
> >  2. If the amend is good and ready to go, "git add" to update the
> >     superproject to make that amended result the one that is needed
> >     in the submodule.  
> 
> yup.

But that is what I am doing. The amended commit IS already
added to the superproject (and pushed to the remote).

Please have a look at my script, this happens here:

# Correct that in the parent too:
pushd parent
git add subm
git commit -m 'Updated subm.'
popd

The commit from before the amend was added to the super
project (but never pushed) but has now been completely
replaced. I still think this is a flaw in git. It shouldn't
not complain and simply push.

-- 
Carlo Wood <carlo@alinoe.com>
