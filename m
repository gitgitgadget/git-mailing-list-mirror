Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2183201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 18:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbdKLSnA (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 13:43:00 -0500
Received: from imap.thunk.org ([74.207.234.97]:37366 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751092AbdKLSnA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 13:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZKc6V8P8uBzO77cH+d++xBpy8+CSWCJWPYRLV9PKp8E=; b=Zbr+K2XtVGyhBndN39t9/NfuDB
        U1O88sPTkkG9lqgCoo2nbURm1UByadO+JjTM9lcZ77gm71maJzZJ9ZM9dLNKtCy4Ihbea4iy+HFxM
        lFKSsWs8w34SgZ90KJaYGtIUmlWYgMtUMIGyQSaawH7WubK4yz13kyBtLf77D3VuluHY=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1eDxDZ-0006uT-HT; Sun, 12 Nov 2017 18:42:53 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 84A80C00640; Sun, 12 Nov 2017 13:42:52 -0500 (EST)
Date:   Sun, 12 Nov 2017 13:42:52 -0500
From:   Theodore Ts'o <tytso@mit.edu>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>,
        Stephan Beyer <s-beyer@gmx.net>
Subject: Re: should "git bisect" support "git bisect next?"
Message-ID: <20171112184252.vpasjhfkt63izrun@thunk.org>
References: <alpine.LFD.2.21.1711110639120.5632@localhost.localdomain>
 <CAP8UFD3az17BpB0nA+35p3BP95sBuOY0Yvce3cgbh0L3YH7+rQ@mail.gmail.com>
 <xmqq4lq0ev8g.fsf@gitster.mtv.corp.google.com>
 <20171111194616.a2hl4dwz5cycuzdh@thunk.org>
 <xmqqvaigclv0.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD3DzdTf6-yZVwMvc1=nP+ejrinjvE8wAPhdaHoOQOmpGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD3DzdTf6-yZVwMvc1=nP+ejrinjvE8wAPhdaHoOQOmpGw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 12, 2017 at 03:21:57PM +0100, Christian Couder wrote:
> 
> Yeah I agree that it might be something interesting for the user to do.
> But in this case the sequence in which you give the good and the bad
> commits is not important.
> Only the last bad commit and the set of good commits that were given
> are important.

Is it really true that of the bad commits, only the last one is significant?

Suppose we have a git tree that looks like this:

          *---*---*---*---*---*---M2---*---B1
          |                        |
  G1--*--D1---*---*---*---B2-\     |
          |                   \    /
          *---*---*---B3--*---M1--/

If we know that commits B2 and B3 are bad, if we assume that all
commits before the "bad" commit are good, all commits after the "bad"
commit are bad, can we not deduce that commit D1 should also be "bad"?

       	   	       	   	       	      - Ted
