Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B56E1FC96
	for <e@80x24.org>; Thu,  8 Dec 2016 11:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbcLHLyo (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 06:54:44 -0500
Received: from mout.gmx.net ([212.227.15.18]:62414 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbcLHLyn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 06:54:43 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQRWm-1c516P2Dwy-00Tp0c; Thu, 08
 Dec 2016 12:53:41 +0100
Date:   Thu, 8 Dec 2016 12:53:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Robbie Iannucci <iannucci@google.com>
Subject: Re: [PATCH 3/3] lockfile: LOCK_REPORT_ON_ERROR
In-Reply-To: <20161207194105.25780-4-gitster@pobox.com>
Message-ID: <alpine.DEB.2.20.1612081252490.23160@virtualbox>
References: <xmqqd1h3y506.fsf@gitster.mtv.corp.google.com> <20161207194105.25780-1-gitster@pobox.com> <20161207194105.25780-4-gitster@pobox.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:stvl/Wb7fsPtflZHLDCw8zPJzZNqZTxsUZ7GxnnJ9vaEtEk9M6c
 iC3gI0jdaG/t+yMV68SEHOIqd8O17IMtY59I2bmsqY3jcMZaTe5VQ8XxKxVtNvLmm/lLmYX
 WP3ABLUc5yRK9gkJr/5zjAa6j3CXwLnLZVAC2nDe7sS9H3S1J/YIOqSXTcUuqL7VOR6QBeT
 iUsxapeIWnkUC32D3Ik8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jFdoPSTfECo=:K7k5+1wskwJdak89DtkWjB
 6Khe/PSCAxtsB47l5TI9POmF/5kdQuBsl1Gkr6tYViVLFN3qOlL9FkJxNuAl/5U4Bo9akJ8hx
 QM8qUAAM2NqPkZnMymCvZ8JlyMdBhb2V0cbK9106QlDr/051Mi3j3IK8dBeKjaQ5dUh0pAEXZ
 WKIFxMZ9Nusq+mB6gceG/fm4hYX6waM2jWcxnfFeI7TpXIeqoiI3dhfpdJq1CepKj2+04I1fO
 Y/YnpswFD1Twyk8psBkbAE1axr8WOOLkWOBWQBBFS7f69MDwdE7HgXrrquyyU9C1NR6xv3uiI
 0USIiNCy6ieSHIgEyALH2bpRTsX3seebyU3pT91gGlnqgiT2C/9okCPCiYgJw0CqZKD73XV6j
 FNx0pYVmKXJxipLwaRMJgyS/jdXajDbho8cJYB8IK0monFS1MjACftqlart57OcSQP1Dfbdva
 d37FCXJVxACdLkiEoCfFOnAGC9sIVijLiIW0tTGcW4vTXFeQKw/6VBfm+AcnCwOMtXFJ9e3qM
 zueTct+mRu1L3NRxL9c0zxflIa84g8zrPCiCC1pmPy8Rp3GR7X4s1uQ5BYMQANkCzAFx4mxB1
 +GHJhuDyD4drV1vcHLpikTy65HKIw5NfqccG9jxNDi25U/RWzjAYIYty0AVPuO3Ork6w6V9WD
 t/KTYaFFbFYi1Sa4BPQWdDY/87wSOyOY1rqxMLoz0p4iwI3fSGCyL3yS+Rt6+dL9+BhXy5HC0
 qUC9loorGeArps8HZ9I9/OPSvrNfmhH9EkG1w6B/ercpudEcwZUDt4uoDwx6yibYf4RU0eS1l
 nMwLNKo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 7 Dec 2016, Junio C Hamano wrote:

> The "libify sequencer" topic stopped passing the die_on_error option
> to hold_locked_index(), and this lost an error message from "git
> merge --ff-only $commit" when there are competing updates in
> progress.

Sorry for the breakage.

When libifying the code, I tried to be careful to retain the error
messages when not dying, and mistakenly assumed that hold_locked_index()
would do the same.

Ciao,
Dscho
