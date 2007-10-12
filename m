From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: push fails with unexpected 'matches more than one'
Date: Fri, 12 Oct 2007 14:06:24 +0200
Message-ID: <91A04390-89B2-47B8-9B61-7C7E652670AE@zib.de>
References: <11921723791817-git-send-email-prohaska@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 12 14:06:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgJGL-0004FO-C1
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 14:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbXJLME4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 08:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753559AbXJLME4
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 08:04:56 -0400
Received: from mailer.zib.de ([130.73.108.11]:35636 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbXJLMEz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 08:04:55 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9CC4r2b009540
	for <git@vger.kernel.org>; Fri, 12 Oct 2007 14:04:53 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9CC4rYY027410
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 12 Oct 2007 14:04:53 +0200 (MEST)
In-Reply-To: <11921723791817-git-send-email-prohaska@zib.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60682>


On Oct 12, 2007, at 8:59 AM, Steffen Prohaska wrote:

> This adds a test case for unambigous local match but multiple remote
> matches. To me, it is unexpected that a ref that is perfectly defined
> on the local side fails with 'matches more than one'.
>
> The following rule could solve this:
> A ref shall first be unambigously resolved on the local side, and its
> full name should be used for matching on the remote side.
> For example 'frotz' resolves locally to 'heads/refs/frotz'.
> Therefore pretend the user had typed 'heads/refs/frotz'.
>
> But maybe there is some hidden secret about the current rules that
> I do not see.

Here is a related question:

I read carefully through the documentation of git-send-pack and
git-rev-parse. The current implementation of git-send-pack is in line
with the documented behaviour, as is the implementation of git-rev- 
parse.

So formally everything is correct.

But it is completely against my expectation that git-push <remote>  
<head>
can successfully resolve a <head> that git-rev-parse fails to parse. I
understand that refs are not revs ;). But nonetheless, I'd expect that a
local ref that cannot be parsed by git-rev-parse should also fail to be
pushed by git-send-pack. I didn't expect that git-send-pack would locate
<head> as someprefix/<head>.

Why is my expectation wrong?
Or is the current specification of git-send-pack's ref parsing wrong?

	Steffen
