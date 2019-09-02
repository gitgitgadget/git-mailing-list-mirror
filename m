Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEBA51F461
	for <e@80x24.org>; Mon,  2 Sep 2019 14:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbfIBOp4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 10:45:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:54049 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfIBOp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 10:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567435537;
        bh=UMWXLegQ9R50pjeI1sqhpKmzSxbsfTECqkhVULBO934=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZVrN7SjRxlzje2lH1+GE22GU75Ffod4IOiK3CSDhbrCb2djZ5c5SPuTfvjrtIwDft
         Dxsbf46DwInGq385tLsZdgf0TawRBo0VQnGu27COixvx9iHZU2KIGwRmYDQ4OMbIxb
         KykbmOjJWfo6YdcocPkIvcCBj56OCwSFDrer7XM4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbyUS-1iUCmr1Roa-00jJAM; Mon, 02
 Sep 2019 16:45:37 +0200
Date:   Mon, 2 Sep 2019 16:45:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 2/4] t3427: accelerate this test by using fast-export
 and fast-import
In-Reply-To: <20190830055707.7785-3-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909021641490.46@tvgsbejvaqbjf.bet>
References: <20190829000657.26415-1-newren@gmail.com> <20190830055707.7785-1-newren@gmail.com> <20190830055707.7785-3-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kXRbOqlEPwhuRh0TtFsHiOFhD2SPn19YlfLo9o40Kc56jUs+eRz
 8uQOB+q6NAljt6McmAGFLLyOJ+MThajBj/umvhv5ZYcrFCosVja61NY+Ym1WnnGfczta6s4
 m3OzkAe0f44b8QwtqSDgBQj+vsEgLHFfkkJoZRzB+vFy3gnPu0INk0TMaDuCcOSDh39tW5S
 EXdOo1DzKxm6yq+hz/epg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hBrzxbav2jc=:xuoiflgfgH3vM0qa8NYoja
 ne89KhtJw/tITwhWw/PoEWGEYZUljuV9C+WHFoUKeNKxdj6OF1qD9myIhb4kXp7LbX0ciCaMc
 ZBErnz+ebP7fJ4flYqghOgoCrgA0vQVwtKEc1jitnFgKUOEdwACCg168AkKlvc5Tn3y09Ur45
 F/rKVbs5ZhPMT2caAAkHKVvE94lSgI7w1NOTzSppN0Swj8zOMiukq1WEBluj1l6pPEzxs1dxa
 blPo7XEXWufGeDeBEY2DsIzdadhwTaqvDrJWMRDgIenfaLm7o8Xv+upJWZ8r4N1HapU2MMXfg
 tJsfPK93iJKFRWoALcvea+Thxp7iKw3ZipApLB/fWxLsPypD2fWbvuu/g8dShxmFzKoLlHvGI
 26j7wLGyWYajEzKEvy28xD/c7iWb5K3UnuGRcPtdPs1+5SBFGB9LUUwbul7g5X7mWoRfZjjU1
 JFjEeJ/xRuyQ/o/f76ClVkYjSsjX9hl7MJrIo1UtYQEPnWR82KUhZVW0+oFMuhRR/EVBrlbLy
 meieFZuxR1jFtRouJMRNUZH/6OMKWCsMVxgcbHVjKWz1AgoPt0vKZA071LPM0tSrtqdjeUPs2
 J9mY4kiL4WF6DLPzC7EqQqV192k/fmCp2MuDO+e2MApfFJG7vmQjFV6j8q9GNKPahsWTfb3km
 ZAJ6+YhZuQIf+/y+t7//f/YlRkSSttIG3kmeTml/HfDlM66SK7QtujdpcSNnxulNiEsGQKOrd
 Hxqy5jS4NjWtYHHIK2xzTNlVo5oJqRxE+CWq8eLZj4zKmIGVXf5FyadW0Iq5fUMNu3aFU7+wt
 YQSFaZlWCwogphYrNc8SCFhYZlVQ51jvl/RlG9EgtZo9HVDC2efSzf0CeFN5kHcK6yl3JuM91
 T0/iaLp4KQdaK51Q3ohRDHibtppgO9MNE9NMGyVsiKsPOmHy0otHxfMdm+3uWQxG0zTofpUPa
 3lWChmsaCvubcTAlOksGzMQoI0vrvAwqRP+s5PbnoY5BnsJNklcioREXOLVcLbvhEJbBYKt6K
 wJy9KMmeTaKXwzD+LRYBdsEURV/hYr+DkVNaDNoDcrNGDZ3lo8o9HLa7VgAEQnzciJ+b9u+RG
 Gh+SaJgsbAcHMkPPwu7ykTZBRVlGvvq67G0rJzIGGW3cnp2o5U+c6B6WFC+k/G8F7f6WO9LS2
 vGL72506pOmkTqDbS1bonn5h273i5rPtPaQS0qjP0S/X3C9sCt9G7sTdppYuySshGDn70=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 29 Aug 2019, Elijah Newren wrote:

> fast-export and fast-import can easily handle the simple rewrite that
> was being done by filter-branch, and should be significantly faster on
> systems with a slow fork.  Timings from before and after on two laptops
> that I have access to (measured via `time ./t3427-rebase-subtree.sh`,
> i.e. including everything in this test -- not just the filter-branch or
> fast-export/fast-import pair):
>
>    Linux:  4.305s -> 3.684s (~17% speedup)
>    Mac:   10.128s -> 7.038s (~30% speedup)

This patch seems to accelerate t3427 on my Windows laptop, too, from
~1m37s to ~1m17s, i.e. ~20%.

Ciao,
Dscho
