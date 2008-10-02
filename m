From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git commit: Repaint the output format bikeshed (again)
Date: Thu, 2 Oct 2008 17:13:09 -0400
Message-ID: <20081002211309.GB29480@coredump.intra.peff.net>
References: <20081001154425.GE21310@spearce.org> <48E3E66E.7020501@op5.se> <20081001220604.GB18058@coredump.intra.peff.net> <20081001223125.GA25267@coredump.intra.peff.net> <48E45ECC.8070104@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 02 23:14:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlVV9-0003qv-Cz
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 23:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142AbYJBVNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 17:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754121AbYJBVNN
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 17:13:13 -0400
Received: from peff.net ([208.65.91.99]:2003 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754104AbYJBVNM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 17:13:12 -0400
Received: (qmail 29880 invoked by uid 111); 2 Oct 2008 21:13:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 02 Oct 2008 17:13:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Oct 2008 17:13:09 -0400
Content-Disposition: inline
In-Reply-To: <48E45ECC.8070104@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97377>

On Thu, Oct 02, 2008 at 07:40:28AM +0200, Andreas Ericsson wrote:

> No sign-off.

Sorry, mistakenly omitted.

Signed-off-by: Jeff King <peff@peff.net>

>> +	printf("[%s%s]: created ",
>> +		!prefixcmp(head, "refs/heads/") ?
>> +			head + 11 :
>> +			!strcmp(head, "HEAD") ?
>> +				"detached HEAD" :
>> +				head,
>> +		initial_commit ? " (root-commit)" : "");
>>  
>
> Personally, I'm not overly fond of things like
>   something ? yay : nay_but_try ? worked_now : still_no_go
> since I find them hard to read without thinking a lot.

Hmm, I find them more readable. :) And often easier to visually see that
no matter what happens, the result has _some_ value (whereas with
if/else, you have to make sure that all branchs set the value).  But I
am happy to change it to:

  const char *branch;
  ...

  if (!prefixcmp(head, "refs/heads/"))
          branch = head + 11;
  else if (!strcmp(head, "HEAD"))
          branch = "detached HEAD";
  else
          branch = head;

However, I found your mail somewhat unexpected. Rather than comments on
the code, I expected rather "yes, I do like this better" or "no, I think
we should go with the other one." But maybe you are just sick of
weighing in. ;)

-Peff
