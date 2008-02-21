From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix amending of a commit with an empty message
Date: Thu, 21 Feb 2008 12:56:52 -0800
Message-ID: <7vmyput4dn.fsf@gitster.siamese.dyndns.org>
References: <20080221195438.GA6973@steel.home>
 <7vwsoyt5xt.fsf@gitster.siamese.dyndns.org>
 <20080221203506.GA20143@steel.home> <20080221203802.GB20143@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 21:58:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSIUs-0000Jy-NN
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 21:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbYBUU5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 15:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934243AbYBUU5R
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 15:57:17 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932379AbYBUU5P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 15:57:15 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 12AF22677;
	Thu, 21 Feb 2008 15:57:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2F0D72675; Thu, 21 Feb 2008 15:57:05 -0500 (EST)
In-Reply-To: <20080221203802.GB20143@steel.home> (Alex Riesen's message of
 "Thu, 21 Feb 2008 21:38:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74656>

Alex Riesen <raa.lkml@gmail.com> writes:

> In this one. I am a bit unsure regarding the change (it looks a little
> too strong), even though it passes the test suite.

I think that is because your new test is faulty.

Instead of ':' I complained about, try having "echo foo" there.
I think it will still fail.

So your test failure is not about "a commit with an empty message"
at all.

Look at the previous test and how we allow an empty commit (not
"with empty message", but "with the same tree as its sole
parent") to be made and amended.

Having said that, here is a quiz.  When the user says "git
commit --amend", what are the valid reasons not to allow it,
other than:

 - the index is unmerged.
 - the branch is yet to be born.
