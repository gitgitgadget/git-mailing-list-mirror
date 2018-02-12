Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4B101F404
	for <e@80x24.org>; Mon, 12 Feb 2018 21:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932424AbeBLVk0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 16:40:26 -0500
Received: from mout.web.de ([212.227.17.12]:37001 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932204AbeBLVkY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 16:40:24 -0500
Received: from [192.168.178.36] ([79.237.252.254]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ljamy-1eETvQ38Z6-00bZHA; Mon, 12
 Feb 2018 22:40:20 +0100
Subject: Re: [PATCH 003/194] object-store: move packed_git and packed_git_mru
 to object store
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235508.216277-4-sbeller@google.com>
 <xmqqsha9vmqt.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kacD5Bevw==v3fbyWmz0FiDDM5ypkYuxHxbXJM62FX40w@mail.gmail.com>
 <xmqqsha5sywh.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <212094a6-f1bd-c4cd-01f9-e819a701cfac@web.de>
Date:   Mon, 12 Feb 2018 22:40:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqsha5sywh.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:3E0PfjHIydrJa1jIBpEc9nT5LjEcGPnMdy76nNUW8cwmmO28kE/
 IWBSTS5hKRn+I+w7eqk4BiVmglDCPnOADAY1Jmr3+VI1ssv0KT3+dbFTb6dr209RFc/+u21
 HKgjUA6/92SdVJThYxVwG8nP61RNsrltpGNuanetD5FK9+oxTQHrqAhv29iESXrDZDLZmA7
 KOrUYUdTx+FRnAp8P1lUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gDNFb9M7g7c=:jqxanNcgQKnTNk7bxhyKxs
 lX+QsjrwFt7rsm0ZAL+nyDugmlH8Kk1k4x7L8vQoaE052B/Luyr0txDl/+ByRC1PoWJRV5VBY
 DrpArC5W0Ru+ME/PYFVcBq91RgQNi0t55LIcaa3fcR+xzyiLGvyq832uPQq/qgLtHQAjxhpSe
 IiNQxIAyK3M5uPsysjGJ5a4NHXKscBGFXTpiIjNVLsiywulnKN4NLi1jlXh3Fhn+FNMgw+V8L
 MlFmEszYTtbt01qDLHeQjk/czTFbOli7VfHdqwwmswLkBluN9MVdwxNbXiiVa4TTR1f+h37wT
 IAknIWJNcPCudHliTnd/oIY7wsQdbuHJ61gIm8zhwks/G/QlJc2VMYb2ba+7/RFGZBIZIAK2X
 w9M1QYp7s0jE42ihpkEhWIOtZQlXewwuF8nYuCW8sgNiQBrX7X6mM9p6XT2jKu7mcIqiPoM8V
 lBvmEH5U6iHz/5+HZxCbvBvGsxxVhoBndjHxNNNwRUxr0Q7TCLRxCp3MCptd65338JLZWatMo
 OMCGdekNTTZZkWtfUc0AefGMusP4p6H2hWbY+G6SEa3F+B0J3/yHsvXiRPaj+hEPgxg8Igxzl
 zAa+MFiogvHKbS3d/7wCCqzUurruv1dihRptsjfH9G2y4uOfsfaYz0dgcEDf0raYmULuMYSVa
 9A+Qil3qQAx5JXeDca/7GkUqkHh2/6LHRMjZuWhYgehcz9u+iXyec3s16VUP+i9MipxlgRLxO
 LrwzKXN2a2yi5mzqzo+rwYbAlBNS8u5VArUoF+lGQekUBGSKbC/ajuiXuCaINd+fzZoYqr9uB
 hiS7KGAdoahxTDV7jAElmOGtMj3l+6wVTxf/NBThLRq7AqUZXk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.02.2018 um 22:04 schrieb Junio C Hamano:
> Stefan Beller <sbeller@google.com> writes:
> 
>> I thought it may be a helpful
>> for merging this series with the rest of the evolved code base which
>> may make use of one of the converted functions. So instead of fixing
>> that new instance manually, cocinelle could do that instead.
> 
> Having the .cocci used for the conversion *somewhere* would indeed
> be helpful, as it allows me to (1) try reproducing this patch by
> somebody else using the file and following the steps in order to
> audit this patch and (2) catch new places that need to be migrated
> in in-flight topics.
> 
> But placing it in contrib/coccinelle/ has other side effects.

Running "make coccicheck" takes longer.  What other downsides are
there?

> I can think of two precedents in this project, namely:
> 
>   - fixup-builtins in 36e5e70e ("Start deprecating "git-command" in
>     favor of "git command"", 2007-06-30)
> 
>   - convert-cache in d98b46f8 ("Do SHA1 hash _before_ compression.",
>     2005-04-20)
> 
> that are about tools that is useful during a transition period but
> can and should be removed after transition is over.  These two were
> done as one-off and added at the top-level, but perhaps we want a
> new directory at the top (e.g. devtools/) to add things like this
> and hold them while they are relevant?

Semantic patches for completed transformations can be removed as
well (or archived, e.g. by renaming to .cocci.done or so).

René
