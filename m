Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3CD1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 09:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750983AbeFCJpL (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 05:45:11 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41024 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeFCJpK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 05:45:10 -0400
X-Greylist: delayed 1039 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Jun 2018 05:45:10 EDT
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w539Rl7F003329
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 3 Jun 2018 11:27:47 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w539RlVi003328;
        Sun, 3 Jun 2018 11:27:47 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w539RaWY005661;
        Sun, 3 Jun 2018 11:27:36 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w539Rad1005660;
        Sun, 3 Jun 2018 11:27:36 +0200
Date:   Sun, 3 Jun 2018 11:27:36 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180603092736.GA5510@helen.PLASMA.Xg8.DE>
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE>
 <87y3hlecod.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3hlecod.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Unfortunatly this important topic of GDPR compliance has not seen much 
interest.

After asking github about how they would cope with the issue of erasing 
the author field, they changed their privacy policy, which now 
clarifies that this won't be done.

My guess is that this would ultimately rely on "overriding legitimate 
grounds for the processing" (Art. 17 (1) point (a) GDPR) which is one 
of the most fragile legitimizations avaiblable in the GDPR.

The GDPR emphasizes the importance of using state of the art 
technology, including anonymization, in as much as possible to ensure 
privacy.

At 
https://public-inbox.org/git/CA+dhYEViN4-boZLN+5QJyE7RtX+q6a92p0C2O6TA53==BZfTrQ@mail.gmail.com/T/ 
there is already some discussion about transitioning to a different 
hashing algorithm to get more in line with state of the art in hashing. 
(My clear favourite would be SHA-3.)

In course of this, anonymization could also be added. My idea would be 
as follows:

Do not hash anything directly to obtain the commit ID. Instead, hash a 
list of hashes of [$random_number, $information] pairs. $information 
could be an author id, a commit date, a comment, or anything else. Then 
store the commit id, the list of hashes, and the list of pairs to form 
the commit.

If someone requests erasure, simply empty the corresponding pair in the 
list. All that would be left would be the hash of the pair, which is 
completely anonymous (not more useful than a random number) and thus 
not covered by the GDPR. The history could still be completely 
verified, and when displaying the log, the erased entry could be 
displayed as "<<ERASED>>".

What do you think about this?

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
