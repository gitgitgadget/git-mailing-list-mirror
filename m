Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEA461F667
	for <e@80x24.org>; Tue, 22 Aug 2017 15:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbdHVPu2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 11:50:28 -0400
Received: from smtprelay09.ispgateway.de ([134.119.228.117]:64614 "EHLO
        smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbdHVPu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 11:50:27 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay09.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1dkBRf-0000tf-LU; Tue, 22 Aug 2017 17:50:23 +0200
Date:   Tue, 22 Aug 2017 17:50:22 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Submodule regression in 2.14?
Message-ID: <20170822155022.GB5697@book.hvoigt.net>
References: <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com>
 <FCB6097F-9F8D-4FDD-A8CE-D936C9CE62E7@gmail.com>
 <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
 <xmqqd17tei7m.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZdnJ+bATTxKBhsJnKaJWGqcBu3MOQ9eK7m4j3dJPNbTw@mail.gmail.com>
 <xmqq7ey0ddlk.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kap-4k7n48dvBAv2pJjNy2s_LPHS-NdfQD0A-BbWqh4aQ@mail.gmail.com>
 <xmqqpobs9hjy.fsf@gitster.mtv.corp.google.com>
 <20170821160514.GA1618@book.hvoigt.net>
 <xmqqr2w46f4c.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr2w46f4c.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2017 at 09:48:51AM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > So I think it is important that there are commits in the submodule so
> > its history makes sense independently for others.
> 
> I was trying to push the "just like trees" to the logical conclusion
> in order to see see if it leads to an absurd conclusions, or some
> useful scenario.  I do not necessarily subscribed to Jonathan's
> "vision" (I do not object to it as one possible mode of operation,
> either).
> 
> > Or how would you push out the history in the submodule in your idea?
> > Maybe I am missing something? What would be your use case with gitlinks
> > pointing to trees?
> 
> Not my idea.  But Stefan's message I was responding to said that
> object database for the superproject is the same as and mixed with
> object databases for the submodules, so it is plausible that push
> always happens at the superproject, and a mechanism to be invented
> (I mentioned the need for it in the message you are responding to)
> to enumerate all the commits bound from submodules to a range of
> superproject's commits would identify these trees to be pushed out.
> 
> In essense, "just like trees" folks want to use the gitlinks in the
> superproject to only specify the tree from the submodule project
> that should sit there.  And my point is that such a world view would
> lead to no need for branches in the submodule repository, no need
> for commits in the submodule repository, and no need for history in
> the submodule repository.  Which may or may not be a bad thing.

The problem I see here is: How do we seperate the submodule from the
superproject? Without the history (commits and trees) of the
superproject the submodule trees do not make sense anymore. The reason
users have submodules is because the projects are seperate somehow. With
just trees in the submodule it becomes tied quite tightly to the
superproject, IMO.

One step further: Why use gitlinks to point to trees? Let's just use
normal tree links instead, we already have that implemented :)

Cheers Heiko
