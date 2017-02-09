Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 489FA1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 21:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbdBIVhP (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 16:37:15 -0500
Received: from mout.gmx.net ([212.227.17.21]:53005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752300AbdBIVhO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 16:37:14 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MV30j-1cuqls2pRt-00YQTl; Thu, 09
 Feb 2017 22:05:25 +0100
Date:   Thu, 9 Feb 2017 22:05:24 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: Re: [PATCH] rev-parse --git-path: fix output when running in a
 subdirectory
In-Reply-To: <xmqqh944wmcs.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702092201080.3496@virtualbox>
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de> <xmqqh944wmcs.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WbpOK1imyW26D799qF/fjBmPAI18VwLYDVzDeVooYb5ymmRIBQ7
 d2JX+Q7wVAHcZQNMZHUsMqumufclwnKHC4GhzqhDPzwxEOaN2VlLChSWL0tsgwdcsZubSk8
 NgpYZaeu6BiDPMnCsSGcMEAyoMw3zlAdUlCf21s1sggQUIG7Y+/Rv5XegWxckGpluWlpGHc
 CBllaU9x7vfh+UvdD0uGw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cdXVo66gvUM=:WSn2YIz4C4nbdXl/tAnYuz
 KdepZBwaN5fWgAPN3AZAbxVoI06blhoSv6NaLmInav1ljAUZA73nAZk4gMQ2VDD+fcBZTfdl5
 g1+zegH5aHKl5I2zSs3C07oqoOYbxz5QJPnV+QHXyIPvo7Lm8A3OEhWfjNRszF5H2ZYfmg39Z
 kVBdOU7jAntDbgCCqgB6FwoSpqOfhuBTYk/ZcZ+Jou9mNlYjx8AN9c3CWL9owCJlavNU/c+07
 9d6c3O10uMzRRwXp7tNnIQuAN9/gKIxMB3OohFc1mC61Z9QO6evJQM3b68NQ4R0xwGY5X+2SH
 9lu5YUNPRB+BnvAP2AxJe6PGWF2/g+ApJ9nxNehew6gBxYS6G1c37p+EPh+ERKeRw67vgz2Av
 uRxYK72sv7oIuaCV8ZSEXMlG8bHlyUNAvKHK35b5122CcNlrP6ctoFCahtnFRtI7sMU5dIfCz
 k9jkEVtqwMggf/gxC6EPHeyE1A1o9EAqT4EFbtwc3jXt/S8/9qhpupRZ55Ge7Lg0gZbat2uuo
 HyJYYT9p1R2kk41RVV8iPyv6EY4tsBv2jdMksiNYOXXdP7BHXHNyr/wDBFJxDIp3235ewdF+m
 30Ypp0ZiqH31E2kb414l0Qs/wJTXsrYcltfu9Ka0h9WPV+3DR9XKIU9TqCmbnOtBlJXNi5SWQ
 C92svMKn7UM98k3+TxNlMTBq/agJEEaoEVF5553C9TrtzHGAHyeSvmMFZDlZ8cbktx2qQ+zuT
 27Rb3Kjf+RpmXh41gUr24VTxUqOm525LaVscF/COKWDHguRI0d2RE6PfU6GYrga1nF2+wRuVs
 GYPjyQz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 8 Feb 2017, Junio C Hamano wrote:

> How long has "rev-parse --git-path" been around?  Had scripts in the
> wild chance to learn to live with the "output is relative to the top of
> the working tree" reality?  I think the answers are "since 2.5" and
> "yes".

Correct. And the third question is: How did the scripts work around this
feature?

The answer is obvious: by switching back to `$(git rev-parse
--git-dir)/filename`.

This is literally on what I spent the better part of Wednesday.

There is just no way you can "fix" this otherwise. As an occasional shell
scripter, you may be tempted to use `$(git rev-parse --show-cdup)$(git
rev-parse --git-path filename)`, but of course that breaks in worktrees
and if you do not use worktrees you would not even know that your
workaround introduced another bug.

The current handling of --git-path is just plain wrong. The fact that I am
the first person to report this here merely shows how much it is used in
the wild.

Ciao,
Johannes
