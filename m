Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 869F61F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 01:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438932AbfJRBad (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 21:30:33 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:35093 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409455AbfJRBad (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 17 Oct 2019 21:30:33 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 5E6052FA;
        Thu, 17 Oct 2019 21:30:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 17 Oct 2019 21:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=pq7JnPVH1qpjTz0L7yOcPLAoIVZ
        Xm4EsT9Idpgnd1I4=; b=rXeFk8m6yRHaRUuZ7dH4yi8NKBxBdyuwUXLPzaKrlIF
        BYMuqS1ydTbYquvOZPff7j5NSpwqd/iKC7SuFsA7I7RlVXUCSgZoSeqP8AnTvOAM
        yC31tI/gPgHnSXNFe3uymosBYlV/8gU6lI2tJaLZy63FmgrR2af+FnMfYp2SuoJO
        WF30Y00Uqvyfpq5W7gdWjUlc9ZOcs/a4v0x128TQZHG5eY5tC/Vh0UsIc1IDkMhE
        3f42Q0ejexzHGdNurWSo/zsIlsvcTlpBec6AnAfsRJohVChbKGiPbZHDVfrlQZa2
        wZLLTG4AUZQONOhz/GagxUVp5a+xo4WjrXAUAGgb8Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=pq7JnP
        VH1qpjTz0L7yOcPLAoIVZXm4EsT9Idpgnd1I4=; b=tmq8jDKuKozJEIjsoPgsxW
        LKKy6Vs/EA+EokNQwlI4uG6UFQGg/V+ZG70GfBTKG/6itCyXoi2n4W2U9ompFd/V
        TI7/ZOell+jp9bomTGgazNNJ2HZbanPx/k+xTCckeo/H35t2RBWdnlY7RqkeTLen
        wvWFepzwmLnrO9zH9NZZDqWF+2QSPTA523EOku3C8RqXpr0Ucr52HaQyd/SXw0mT
        1FXqd+DOxZiBKgHUxPwDMybZIKDqGIauiZszERfgC2/pvvUCc0s5g79d5yFF5RQj
        zVxfjyPmjs73gJYolGIsiTUuu/155JfgJhjVzy5g4TepQ5dSecmNZRo4aemixMEA
        ==
X-ME-Sender: <xms:thWpXUV7Tgir_8Q3LCPydsDL_-0BqqLQz1S9OeCw0YqSOXt6-ToXMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrjeekgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepuddtgedrudefvddrtddrud
    dtleenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:thWpXSMtW2FEOhuejp4R1JVWN-qMtTcGHJeSi8uPB6JYMXcbLY_QhA>
    <xmx:thWpXYahdQaCOdVo3BgPMQNVOVQRUymotLl_Xb-2kGs3y_ANYPG_xg>
    <xmx:thWpXWoyOr9GjzqUkLmaZ3kU4fp6m8YX1AsdsgkVBxBNnvQP3gCvkw>
    <xmx:txWpXcYbXojnSSNJ1-senbnByNSglnvEcq0lXsA3mMDFt6uW-Y9h8Q>
Received: from localhost (unknown [104.132.0.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 37504D6005D;
        Thu, 17 Oct 2019 21:30:30 -0400 (EDT)
Date:   Thu, 17 Oct 2019 18:30:29 -0700
From:   Greg KH <greg@kroah.com>
To:     Santiago Torres Arias <santiago@nyu.edu>, Willy Tarreau <w@1wt.eu>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191018013029.GA1167832@kroah.com>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
 <20191017204343.GA1132188@kroah.com>
 <20191017204532.GA6446@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017204532.GA6446@chatter.i7.local>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 04:45:32PM -0400, Konstantin Ryabitsev wrote:
> On Thu, Oct 17, 2019 at 01:43:43PM -0700, Greg KH wrote:
> > > I wonder if it'd be also possible to then embed gpg signatures over
> > > send-mail payloads so as they can be transparently transferred to the
> > > commit.
> > 
> > That's a crazy idea.  It would be nice if we could do that, I like it :)
> 
> It could only possibly work if nobody ever adds their own "Signed-Off-By" or
> any other bylines. I expect this is a deal-breaker for most maintainers.

Yeah it is :(

But, if we could just have the signature on the code change, not the
changelog text, that would help with that issue.

thanks,

rgeg k-h
