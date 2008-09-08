From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Mon, 8 Sep 2008 13:51:29 +0200
Message-ID: <20080908115129.GA19031@cuci.nl>
References: <20080907103415.GA3139@cuci.nl> <7vhc8rjyxj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 13:52:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcfIL-00014Q-LP
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 13:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbYIHLvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 07:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbYIHLvb
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 07:51:31 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:42442 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbYIHLvb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 07:51:31 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id A551C5465; Mon,  8 Sep 2008 13:51:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vhc8rjyxj.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95240>

Junio C Hamano wrote:
>"Stephen R. van den Berg" <srb@cuci.nl> writes:
>I think the commit object name -x records in the commit message of the
>cherry-picked one is noticed by gitweb to give you an easy access.  You
>could teach gitk a similar trick, and that would not just help cherry
>picking but also reverts, and a fix-up commit that says "This fixes the
>regression introduced by commit 90ff09a5".

Checking the on-disk format I see that it has been defined in a rather
extensible way.

If we were to put the SHA1-ref somewhere in the commit message, 
finding references to a certain commit through cherry-picks becomes
rather disk/CPU-intensive.

Would there be any objections against extending the on-disk format to
accomodate something like the following:

commit 7df437e56b5a2c5ec7140dd097b517563db4972c
tree a006f20b481d811ccb4846534ef6394be5bc78a8
parent ff1e8bfcd69e5e0ee1a3167e80ef75b611f72123
parent bbb896d8e10f736bfda8f587c0009c358c9a8599
cousin 6ffaecc7d8b2c3c188a2efa5977a6e6605d878d9
cousin a1184d85e8752658f02746982822f43f32316803
author Junio C Hamano <gitster@pobox.com> 1220153499 -0700
committer Junio C Hamano <gitster@pobox.com> 1220153499 -0700

Whereas cherry-pick would (optionally) generate a cousin reference for every
commit it picks.

I'm willing to do the work to fix up git-core to support the new field.
-- 
Sincerely,
           Stephen R. van den Berg.
The Horkheimer Effect: "The odds of it being cloudy are directly proportional
to the importance of an astronomical event."
