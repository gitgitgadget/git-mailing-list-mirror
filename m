From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Mon, 8 Sep 2008 15:42:22 +0200
Message-ID: <20080908134222.GA20998@cuci.nl>
References: <20080907103415.GA3139@cuci.nl> <7vhc8rjyxj.fsf@gitster.siamese.dyndns.org> <20080908115129.GA19031@cuci.nl> <48C522F6.7090308@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Sep 08 15:43:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kch1i-00076l-5E
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 15:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbYIHNmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 09:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754126AbYIHNmY
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 09:42:24 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:43738 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbYIHNmY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 09:42:24 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id D1B065465; Mon,  8 Sep 2008 15:42:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48C522F6.7090308@gnu.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95248>

Paolo Bonzini wrote:
>> commit 7df437e56b5a2c5ec7140dd097b517563db4972c
>> tree a006f20b481d811ccb4846534ef6394be5bc78a8
>> parent ff1e8bfcd69e5e0ee1a3167e80ef75b611f72123
>> parent bbb896d8e10f736bfda8f587c0009c358c9a8599
>> cousin 6ffaecc7d8b2c3c188a2efa5977a6e6605d878d9
>> cousin a1184d85e8752658f02746982822f43f32316803
>> author Junio C Hamano <gitster@pobox.com> 1220153499 -0700
>> committer Junio C Hamano <gitster@pobox.com> 1220153499 -0700

>What about "origin", and making it propagated through cherry-picks?  In

"origin" gives a better sense of direction, so maybe that's better, yes.

>other words, if I "cherry-pick -x" A generating B, and do the same on B
>generating C, C should have A as origin.  Also, "git cherry-pick -n -x"
>should add the commit to a list of origins somewhere so that "git
>commit" can reuse it.

That is debatable, and should be configurable with a switch.
It depends on the way of operation, I guess.
If one picks A -> B, and then B -> C, then usually for C you want B
to be the origin to indicate that the patch has been tested and shaved
to fit from A -> B, and further polished to fit from B -> C.
Usually backporting involves shaving the patch slightly to fit the older
branch, and in that case it is truly more honest to point back to B
instead of A from C.  And besides, you can follow the chain to C -> B -> A
if you like, no information is lost.

>Furthermore, "git cherry" should use origins if available.

That is one of the places in git that needs to accomodate the new field,
luckily the impact on the rest of git-core is rather minimal, I think.
-- 
Sincerely,
           Stephen R. van den Berg.
The Horkheimer Effect: "The odds of it being cloudy are directly proportional
to the importance of an astronomical event."
